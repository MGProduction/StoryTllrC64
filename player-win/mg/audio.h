#define MAX_SOUNDS        32
#define MAX_CONTEXTSOUNDS 8

#define CALLBACK_FREQUENCY 44100

typedef struct __sound {
    short* sample_pairs;
    int    sample_pairs_count;
    word   sample_rate,sample_ratio;
    byte   channels;
} _sound;

typedef struct __sound_channel {
    int    age,id;
    int    current_position;
    float  volume;
    _sound*sound;
} _sound_channel;

typedef struct __sound_context {
    #ifndef __wasm__
    thread_mutex_t mutex;
    #endif
    _sound_channel music;
    _sound_channel sounds[ MAX_CONTEXTSOUNDS ];
    int            streamed;
} _sound_context;

void channel_play(_sound_channel* sound,int*left,int*right)
{
 if(sound->sound&&(sound->sound->sample_pairs_count))
  if( sound->current_position < sound->sound->sample_pairs_count )
   {
    if( sound->current_position >= 0 )
     {
      int    sl,sr;
      int    position=sound->current_position;
      _sound*snd=sound->sound;
      if(sound->sound->sample_ratio>1)
       position/=sound->sound->sample_ratio;
      if(snd->channels==2)
       {
        sl = snd->sample_pairs[ position * 2 + 0 ];
        sr = snd->sample_pairs[ position * 2 + 1 ];                                       
       }
      else
       sr = sl = snd->sample_pairs[ position ];

      *left = *left + (int)( sl * sound->volume );
      *right = *right +(int)( sr * sound->volume );
      sound->current_position++;
            
     }
    else
     {
         sound->current_position++;
     }
   }
  else
   sound->sound=NULL;
}

void sound_callback( APP_S16* sample_pairs, int sample_pairs_count, void* user_data )
{
    _sound_context* context = (_sound_context*) user_data;
    int             i,j;

    #ifndef __wasm__
        thread_mutex_lock( &context->mutex );
    #endif

    for(i = 0; i < sample_pairs_count; ++i )
    {
        int left=0,right=0;
        if(context->music.sound)
         {
          context->streamed++;
          channel_play(&context->music,&left,&right);            
          if( context->music.current_position >= context->music.sound->sample_pairs_count )
           context->music.current_position = 0;          
         }
        for(j = 0; j < sizeof( context->sounds ) / sizeof( *context->sounds ); j++ )
         if(context->sounds[ j ].sound)
           channel_play(&context->sounds[ j ],&left,&right);            
        
        left = left > 32767 ? 32767 : left < -32767 ? -32767 : left;
        right = right > 32767 ? 32767 : right < -32767 ? -32767 : right;
        sample_pairs[ i * 2 + 0 ] = (short)left;
        sample_pairs[ i * 2 + 1 ] = (short)right;
    }

    #ifndef __wasm__
        thread_mutex_unlock( &context->mutex );
    #endif
}

typedef struct{
    char    name[32];
    _sound  snd;
} sound_file_t;

sound_file_t sounds[MAX_SOUNDS];
byte         sounds_cnt;

_sound*audio_get(int id)
{
 if((id>=0)&&(id<MAX_SOUNDS))
  return &sounds[id].snd;
 else
  return NULL;
}

int audio_load(const char*name)
{
 dword    size;
 int      i;
 byte    *mem;
 for(i=0;i<MAX_SOUNDS;i++)
  if(strcmp(sounds[i].name,name)==0)
   return i; 
 mem=res_get(name,&size);
 if(mem)
  {
   int    channels = 0,sample_rate = 0,samples=0;
   short* output = NULL;   
#if defined(USE_QOA)
   if(samples==0)
    {
     qoa_desc qoa;
     output=(short*)qoi_decode(mem,size,&desc,0);
     if(output)
      {       
       channels=qoa.channels;
       sample_rate=qoa.samplerate;
       samples=qoa.samples;
      }         
    }
#endif
#if defined(USE_MP3)
   if(samples==0)
    {
     mp3dec_t mp3d;
     mp3dec_file_info_t info;
     int      read=mp3dec_load_buf(&mp3d, mem,size, &info, NULL, NULL);
     if((read>=0)&&info.samples)
      {       
       channels=info.channels;
       sample_rate=info.hz;
       output=info.buffer;
       samples=info.samples;
      }         
    }
#endif
#if defined(USE_OGG)
   if(samples==0)
    {
     samples = stb_vorbis_decode_memory( mem, size, &channels, &sample_rate, &output );
     if(samples<0)
      if(samples==-1)
       {
        int        error;
        stb_vorbis*vorbos=stb_vorbis_open_memory(mem,size,&error,NULL);
        return -10-error;
       }
       else
        if(samples==-2)
         return -4;
        else
         return -5;
    }
#endif
   if((samples > 0)&& output)
    {    
     for(i=0;i<MAX_SOUNDS;i++)
      if(*sounds[i].name==0)
       {
         strcpy(sounds[i].name,name);
         sounds[i].snd.channels=channels;
         sounds[i].snd.sample_rate=sample_rate;
         sounds[i].snd.sample_pairs = output;
         sounds[i].snd.sample_pairs_count = samples;
         sounds[i].snd.sample_ratio=CALLBACK_FREQUENCY/sample_rate;
#if defined(USE_QOA)
         if(0){
          qoa_desc     qoa;
          unsigned int size;
          void*        encoded;
          memset(&qoa,0,sizeof(qoa));
          qoa.channels=sounds[i].snd.channels;
          qoa.samplerate=sounds[i].snd.sample_rate;
          qoa.samples=sounds[i].snd.sample_pairs_count;
          encoded = qoa_encode(sounds[i].snd.sample_pairs, &qoa, &size);
          free(encoded);
         }
#endif         
         return i;
       }
     return -2;
    }   
  }
 return -1;
}

