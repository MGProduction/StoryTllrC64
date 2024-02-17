// ---------------------------------------------------------------
// StoryTllr64 - PC player - v 1.0.1
// ---------------------------------------------------------------
// Copyright (c) 2021/2024 Marco Giorgini
// ---------------------------------------------------------------
// MIT License
// ---------------------------------------------------------------
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// ---------------------------------------------------------------
#define _CRT_NONSTDC_NO_DEPRECATE 

#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MULTIPLATFORMPLAYER
#define IMPLEMENT_C_HBPACK
extern "C"
{
#include "storytllr.h"
}

#define BORDER_W        20
#define BORDER_H        10
#define SCREENCH_W      40
#define SCREENCH_H      25

#define GAME_WIDTH      SCREENCH_W*8
#define GAME_HEIGHT     SCREENCH_H*8

#define GAME_TITLE      "StoryTllr: Player"


int     fullscreen;

#define APP_IMPLEMENTATION
#ifdef _WIN32 
    #define APP_WINDOWS
#elif __wasm__
    #define APP_WASM
#else 
    #define APP_SDL    
    #define TARGET_GENERIC
    #define USE_BUILTINCARTRIDGE
#endif
#define APP_LOG( ctx, level, message ) 
#include "gustavsson/app.h"
#if defined(_DEBUG)
#define STB_IMAGE_IMPLEMENTATION
#endif
#include "stb/stb_image.h"

#define canvas_w (GAME_WIDTH+BORDER_W*2)
#define canvas_h (GAME_HEIGHT+BORDER_H*2)
#define screen_w GAME_WIDTH
#define screen_h GAME_HEIGHT
#define canvas_ox (canvas_w-screen_w)/2
#define canvas_oy (canvas_h-screen_h)/2

APP_U32 canvas[canvas_w*canvas_h];
APP_U32  c64col[16]={
0x000000,
0xFFFFFF,
0x68372B,
0x70A4B2,
0x6F3D86,
0x588D43,
0x352879,
0xB8C76F,
0x6F4F25,
0x433900,
0x9A6759,
0x444444,
0x6C6C6C,
0x9AD284,
0x6C5EB5,
0x959595};

APP_U32 colorBKG=c64col[COLOR_BLUE];
APP_U32 colorBRD=c64col[COLOR_WHITE];

#define screen_sx canvas_w*4
#define screen_sy canvas_h*4

app_t*  theapp;

extern "C"
{

#if defined(APP_SDL)
#else
void __asm__(const char*cmd,...)
{
}
#endif
	
#if defined(USE_BUILTINCARTRIDGE)
#include "gameres/storytllr64_data.h"
#endif

#include "../player-shared/C64_main.c"

void cmdlog_start()
{
}
void cmdlog_addcmd(const u8*cmd)
{
}
void cmdlog_addtitle(const u8*cmd)
{
}

void vid_setcolorBRD(u8 col)
{
 colorBRD=c64col[col];
}
void vid_setcolorBKG(u8 col)
{
 colorBKG=c64col[col];
}

char kchar;
char cgetc()
{
 char c=kchar;
 kchar=0;
 return c;
}

u8 bMEM[64*1024];
u8 bCHARMEM[SCREENCH_W*SCREENCH_H];
u8 bCOLCHARMEM[SCREENCH_W*SCREENCH_H];
u8 bCHARACTERS[256*8];

void draw_border()
{
 APP_U32 col=colorBRD;
 int     a,b;
 for(b=0;b<canvas_h;b++)
  for(a=0;a<canvas_w;a++)
   if(isbetween(a,canvas_ox,canvas_ox+screen_w-1)&&isbetween(b,canvas_oy,canvas_oy+screen_h-1))
    ;
   else 
    canvas[(a)+(b)*canvas_w]=(col>>16)|((col&0xFF)<<16)|(col&0xFF00);
}

void draw_crt()
{
 int     a,b;
 for(b=0;b<canvas_h;b+=2)
  for(a=0;a<canvas_w;a++)
   {
    u8*r=(u8*)&canvas[(a)+(b)*canvas_w];
    *r=*r-*r/16;
    r++;
    *r=*r-*r/16;
    r++;
    *r=*r-*r/16;
   }
}

void core_draw_char(u8*charmem,int x,int y,APP_U32 chcol,APP_U32 bgcol)
{
 u16       a,b;
 static u8 mask[8]={128,64,32,16,8,4,2,1};
 static u8 cmask[4]={128|64,32|16,8|4,2|1};
 static u8 cmaskshift[4]={6,4,2,0};
 for(b=0;b<8;b++)
  /*if((canvas_oy+y+b<blittop)||(canvas_oy+y+b>blitbottom))
   ;
  else*/
   {
    u8 colseq=charmem[b];
    for(a=0;a<8;a++)
     if(colseq&mask[a])
      canvas[(canvas_ox+x+a)+(canvas_oy+y+b)*canvas_w]=(chcol>>16)|((chcol&0xFF)<<16)|(chcol&0xFF00);
     else
      canvas[(canvas_ox+x+a)+(canvas_oy+y+b)*canvas_w]=(bgcol>>16)|((bgcol&0xFF)<<16)|(bgcol&0xFF00);
   }
}

u8     *img;
u32     img_w,img_h,img_n;
void draw_image()
{
 int x,y;
 for(y=0;y<img_h;y++)
  for(x=0;x<img_w;x++)
   {
    u8*col=img+(x+y*img_w)*img_n;
    canvas[(canvas_ox+x)+(canvas_oy+y)*canvas_w]=0xFF000000|(col[2]<<16)|(col[1]<<8)|col[0];
   }
}

void draw_char(int x,int y,u8 ch,u8 col)
{
 u8*charmem=bCHARACTERS+ch*8;
 core_draw_char(charmem,x,y,c64col[col],colorBKG);
}

void draw_charscreen()
{
 u8*video_ram=bCHARMEM;
 u8*video_colorram=bCOLCHARMEM;
 int x,y,c=0,cc=0;
 for(y=0;y<SCREENCH_H;y++)
  for(x=0;x<SCREENCH_W;x++)
   {
	   u8 ch=video_ram[x+y*SCREENCH_W];
    u8 col=video_colorram[x+y*SCREENCH_W];
    if(ch)
     cc++;
    if(col)
     c++;
    draw_char(x*8,y*8,ch,col);
   }
}

int last=-1;

#if defined(APP_SDL)
#include <time.h>
#include <errno.h>    

/*
 * Emulates the Win32 GetTickCount API call
 *
 * https://learn.microsoft.com/en-us/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount
 */
u32 GetTickCount()
{
        struct timespec ts;

        clock_gettime(CLOCK_MONOTONIC_COARSE, &ts);
        return (1000 * ts.tv_sec + ts.tv_nsec / 1000000);
}

/* msleep(): Sleep for the requested number of milliseconds. */
int Sleep(long msec)
{
    struct timespec ts;
    int res;

    if (msec < 0)
    {
        errno = EINVAL;
        return -1;
    }

    ts.tv_sec = msec / 1000;
    ts.tv_nsec = (msec % 1000) * 1000000;

    do {
        res = nanosleep(&ts, &ts);
    } while (res && errno == EINTR);

    return res;
}
#endif

void screen_update()
{
 u32   here=GetTickCount();
 int   fullscreenchange=0;
 if(last==-1)
  ;
 else
  {
   here=GetTickCount();   
   if(here-last<1000/50)
    Sleep(1000/50-(here-last));
  }
 /*bMEM[0xD012]++;
 if(bMEM[0xD012]==0)  
  if(bMEM[0xD011]&0x80)
   bMEM[0xD011]-=0x80;
  else
  bMEM[0xD011]|=0x80;

 int irq=0;
 blittop=0;blitbottom=canvas_h;
 while(getirqsettings(irq++,&blittop,&blitbottom))
  {
  if(bMEM[0xD011]&32)
   draw_bitmapscreen();
  else
   draw_charscreen();
  draw_sprites();  
  } */ 
 draw_charscreen();
 draw_image();
 draw_border();
 draw_crt();

 app_present( theapp, canvas, canvas_w, canvas_h, 0xffffff, 0x000000 );
 if(app_yield( theapp )==APP_STATE_EXIT_REQUESTED)
  exit(0);

 app_input_t events=app_input(theapp);
 if(events.count)
 {
  int k=events.count;
  while(k--)
   if(events.events[k].type==APP_INPUT_CHAR)
   {
    kchar=events.events[k].data.key;
    break;
   }
   else
    if(events.events[k].type==APP_INPUT_KEY_UP)
     {
      if(events.events[k].data.key==APP_KEY_ESCAPE)
       fullscreenchange=1;
      else
      if(events.events[k].data.key==APP_KEY_UP)
       kchar=APP_KEY_UP;
#if defined(APP_SDL)
      else
      if(events.events[k].data.key==APP_KEY_RETURN)
       kchar=APP_KEY_RETURN;
      else
      if(events.events[k].data.key==APP_KEY_BACK)
       kchar=APP_KEY_BACK;
#endif
      break;
     }
 }
 if(fullscreenchange)
  {
   fullscreen=!fullscreen;
   app_screenmode( theapp, fullscreen ? APP_SCREENMODE_FULLSCREEN : APP_SCREENMODE_WINDOW );
  }
 last=here;
}

void vic_wait_offscreen()
{
 screen_update();
}

void _getnextch()
{
 _pch = _ch;
#if defined(packed_strings)
 if (_ech)
 {
  _ch = _ech;
  _ech = 0;
 }
 else
  if (_cplx < _cplw)
   _ch = _cpl[_cplx++];
  else
   /*if(_bch)
    {
     _ch=_bch;
     _bch=0;
    }
   else*/
   if (txt == etxt)
    _ch = 0;
   else
   {
    _ch = *txt++;
    if ((_ch == code_reftoshortdict) || (_ch == code_reftoshortdict + 1))
    {
     if (_ch == code_reftoshortdict + 1)
      _ch = *txt++;
     else
      _ch = 1;

     _ch++;

     _cpl = shortdict + (1 + shortdict[0]) + shortdict[_ch];
     if (_ch > shortdict[1])
      _cpl += 256;
     //memcpy(_cpl,packdata+(_ch<<1)+(_ch<<2),shortdict_fixedlen);
     _cplw = shortdict[_ch + 1] - shortdict[_ch]; _cplx = 0;
     _ch = _cpl[_cplx++];
    }
    else
     if (_ch >= start_packedcouples)
     {
      _ch = _ch - start_packedcouples;
      _cpl = packdata + (_ch << 1);
      //memcpy(_cpl,packdata+(_ch<<1),2);
      _cplw = 2; _cplx = 0;
      _ch = _cpl[_cplx++];
      /*_ch=_cpl[0];
      _bch=_cpl[1];*/
     }
   }
#else
 if (txt == etxt)
  _ch = 0;
 else
  _ch = *txt++;
#endif
}

void scrollup()
{
 memmove(bCHARMEM+text_ty*SCREENCH_W,bCHARMEM+(text_ty+1)*SCREENCH_W,(SCREEN_H-(text_ty+1))*SCREENCH_W); 
 memset(bCHARMEM+(SCREEN_H-1)*SCREENCH_W,' ',SCREENCH_W);
 memmove(bCOLCHARMEM+text_ty*SCREENCH_W,bCOLCHARMEM+(text_ty+1)*SCREENCH_W,(SCREEN_H-(text_ty+1))*SCREENCH_W); 
 memset(bCOLCHARMEM+(SCREEN_H-1)*SCREENCH_W,COLOR_BLACK,SCREENCH_W);
}

void cr()
{
 REFRESH
 text_x=0;
 text_y++;
 if(text_ty+text_y>=SCREENCH_H)
  {  
   scrollup();
   text_y--;
  }
}

void core_cr()
{
 REFRESH
 txt_x=0;
 txt_y++;
 if((_ch==' ')||(_ch==FAKE_CARRIAGECR)) 
  _getnextch();
 if(txt_y>=SCREENCH_H)
 {
  scrollup();
  txt_y--;
 }
 al++;
}

void core_drawscore()
{
 u8 i=0;
 u8*ptr;
 mini_itoa(vars[0],(char*)tmp);
 while(tmp[i]) i++;
 tmp[i++]='/';
 mini_itoa(vars[1],(char*)tmp+i);
 while(tmp[i]) i++;
 ptr=bCHARMEM+status_y*SCREEN_W+SCREEN_W;
 ptr-=i;i=0;
 while(tmp[i])
 {
  ptr[i]=tmp[i]|128;
  i++;
 }
}

void core_drawtext()
{  
  _getnextch();
  while(_ch)
   {        
    if(al+1>=text_stoprange) 
     {
      _ech=_ch;     
      return;
     }
    if(_ch==FAKE_CARRIAGECR)
     {
      core_cr();
      _getnextch();
     }
    else
     {
      align=ALIGN_LEFT;spl=ll=0;
      while(_ch&&(ll+txt_x<SCREENCH_W)&&(_ch!=FAKE_CARRIAGECR))
      {
       if(_ch==ESCAPE_CHAR)
        {
         _getnextch();
         switch(_ch)
         {
         case 'c'-'a'+1:
          align=ALIGN_CENTER;
         break; 
         case 'r'-'a'+1:
          align=ALIGN_RIGHT;
         break; 
         case 'l'-'a'+1:
          align=ALIGN_LEFT;
         break; 
         case 'g'-'a'+1:
          txt_col=COLOR_GRAY2;
          break;
          case 'y'-'a'+1:
          txt_col=COLOR_YELLOW;
          break;
         case 'w'-'a'+1:
          txt_col=COLOR_WHITE;
          break;
          case 'V'-'A'+65:
           u=1;
          case 'v'-'a'+1:
           v=0;
           while(vrb[v])
            {
             _buffer[ll]=vrb[v]+txt_rev;
             if(u)
              {_buffer[ll]+=64;u=0;}
             _cbuffer[ll]=txt_col; 
             ll++;v++;
            }
          break;
         }
         _getnextch();
        }
       else
        {
        if(_ch==' ')
         {
          spl=ll;
          _savechpos();
         }
        _buffer[ll]=_ch+txt_rev;_cbuffer[ll]=txt_col; 
        ll++;
        _getnextch();
        }
      }
      if((ll+txt_x==SCREENCH_W)&&((_ch==0)||(_ch==' ')))
       ;
      else
      if(ll+txt_x>=SCREENCH_W)
       {
        _restorechpos();
        ll=spl;
        _getnextch(); 
       }
      switch(align)
       {
       case ALIGN_CENTER:
         txt_x+=(SCREENCH_W-ll)>>1;
        break;
        case ALIGN_RIGHT:
         txt_x+=(SCREENCH_W-ll);
        break;
       }
      memcpy(bCHARMEM+txt_y*SCREENCH_W+txt_x,_buffer,ll);
      memcpy(bCOLCHARMEM+txt_y*SCREENCH_W+txt_x,_cbuffer,ll);
      txt_x+=ll;      
      if(_ch==0)
       break;
      else
       core_cr();           
    }
  }
}

void status_update()
{
 strid=roomnameid[room];

#if defined(WIN32)||defined(APP_SDL)
 if(strid!=255)
  {
   char title[256];
   int  i=0;
   str=advnames;_getstring();txt=ostr;
   _getnextch();
   while(_ch)
    {
     title[i++]=_ch;
     _getnextch();
    }
   title[i]=0;
   cmdlog_addtitle((u8*)title);
   }
#endif

 if(strid!=255)
  {
   str=advnames;_getstring();txt=ostr;
   memset(bCOLCHARMEM+status_y*SCREENCH_W,COLOR_YELLOW,SCREENCH_W);
   memset(bCHARMEM+status_y*SCREENCH_W,32|128,SCREENCH_W);
   al=0;txt_col=COLOR_YELLOW;txt_rev=128;txt_x=0;txt_y=status_y;
   core_drawtext();  
   if(vars[1])
    core_drawscore();
  }
 else
  {
   txt=(u8*)"";
   memset(bCOLCHARMEM+status_y*SCREENCH_W,COLOR_BLACK,SCREENCH_W);
  }

 //ui_clear();
}

void hide_blink()
{
 bCOLCHARMEM[txt_y*SCREENCH_W+(txt_x)]=COLOR_BLACK;
}

void do_blink()
{
 blink++;
 if(blink>90)
  {
   u8 ch=bCOLCHARMEM[txt_y*SCREENCH_W+(txt_x)];
   if(ch==COLOR_BLACK)
    ch=COLOR_GRAY2;
   else
    ch=COLOR_BLACK;
   bCOLCHARMEM[txt_y*SCREENCH_W+(txt_x)]=ch;
   bCHARMEM[txt_y*SCREENCH_W+(txt_x)]=108;
   blink=0;
  }
}

u8 charmap(u8 c)
{
 if((c>='0')&&(c<='9'))
   c=c-'0'+48;
  else
  if((c>='A')&&(c<='Z'))
   c=c-'A'+1;
  else
   if((c>='a')&&(c<='z'))
    c=c-'a'+1;
   else
    if(c==' ')
     c=32;
    else
     if(c=='.')
      c=46;
     else
      if(c==',')
       c=44;
      else      
       c=0;
 return c;
}

void ui_image_fade()
{
/*
#if defined(WINDOW)
 u8 x; 
 for(x=0;x<SCREEN_W/2;x++)
 {
  u16 yy;
  u8* v=VIDEOMEM;
  u8  y;
  REFRESH
  yy=y=0;
  while(y<(split_y/8))
   {
    video_colorram[x+yy]=0;
    video_colorram[(SCREEN_W-x-1)+yy]=0;
    v[x+yy]=0;
    v[(SCREEN_W-x-1)+yy]=0;
    yy+=40;y++;}
 } 
#else
 u8*v=VIDEOMEM+(96/8+1)*40;
 u8*c=video_colorram+(96/8+1)*40;
 u8 y=(96/8+1);
 while(y--)
 {
  REFRESH
  memset(v,0,40);v-=40;
  memset(c,0,40);c-=40;
 }
#endif
 memset(bitmap_image,0,(split_y*320)/8);*/
}
const char*IMGFILENAME(char*nm)
{
 static char nn[256];
 sprintf(nn,"%svga_img/%s",basepath,nm);
 return nn;
}
u8 getpalette(u8*col,u8*palette,u8*cnt)
{
 u8 i;
 for(i=0;i<*cnt;i++)
  if(memcmp(col,palette+i*3,3)==0)
   return i;
 memcpy(palette+i*3,col,3);
 *cnt=*cnt+1;
 if(*cnt>128)
  i=0;
 return i;
}
#if defined(_DEBUG)
void images_build()
{
 int i=0,pos=0;
 u8* imagedata=(u8*)malloc(16*1024*1024);
 u32*imagesidx=(u32*)malloc(256*sizeof(u32));
 u8* palette=(u8*)malloc(256*3);
 u8  palcnt=0;
 imagesidx[i++]=0;
 while(1)
 {
  char fn[256];
  FILE*f;
  sprintf(fn,"vga_img/room%02d.png",i);
  f=fopen(fn,"rb");
  if(f)
   {
    u8*    buf=(u8*)malloc(128*1024);
    size_t read=fread(buf,1,128*1024,f);
    fclose(f);
    if(read>64*1024)
     read=read;
    if(read)
     {
      int w,h,n;
      u8*sdata;
      u8*data=stbi_load_from_memory(buf,read, &w, &h, &n, 0);
      sdata=(u8*)malloc(w*h);
      for(j=0;j<w*h;j++)
       {
        u8*col=data+j*n;
        sdata[j]=getpalette(col,palette,&palcnt);
       }
      stbi_image_free(img);
      *(u16*)(buf+0)=w;
      *(u16*)(buf+2)=h;
      n=hpack(sdata,j,buf+4);      
      free(sdata);
      memcpy(imagedata+pos,buf,j);pos+=n+4;
      free(buf);
     }
    imagesidx[i++]=pos;
   }
  else
  {
   FILE*f=fopen("images.h","wb");
   if(f)
   {
    int  j;
    fprintf(f,"u32 imagesidx[%d]={",i);
    for(j=0;j<i;j++)
    {
     if(j) fprintf(f,",");
     fprintf(f,"0x%04x",imagesidx[j]);
    }
    fprintf(f,"};\r\n");
    fprintf(f,"u8  imagesdata[%d]={",pos);
    for(j=0;j<pos;j++)
    {     
     if(j) fprintf(f,",");
     if((j%32)==31) fprintf(f,"\r\n");
     fprintf(f,"0x%02x",imagedata[j]);
    }
    fprintf(f,"};\r\n");
    fprintf(f,"u8  imagespal[%d]={",palcnt*3);
    for(j=0;j<palcnt*3;j++)
    {     
     if(j) fprintf(f,",");
     if((j%32)==31) fprintf(f,"\r\n");
     fprintf(f,"0x%02x",palette[j]);
    }
    fprintf(f,"};\r\n");
    fclose(f);
   }
   break;
  }
 }
}
#endif
#if defined(_DEBUG)
void ui_room_gfx_update()
{
 u8  memval=0x37-3;
 int w,h,n;
 char nm[]="room01.png";
 u8*data;
 u8 r=imageid+1;
 nm[4]='0'+(r/10); 
 nm[5]='0'+(r%10);
 if(img) {stbi_image_free(img);img=NULL;img_w=img_h=0;}
 data=stbi_load(IMGFILENAME(nm), &w, &h, &n, 0);
 if(data)
 {
  img=data;
  img_w=w;img_h=h;img_n=n;  
 } 
}
#else
#include "gameres/images.h"
void ui_room_gfx_update()
{
 int w,h;
 u8 *data=imagesdata+imagesidx[imageid]; 
 u8 *out;
 img_w=w=*(u16*)(data+0);
 img_h=h=*(u16*)(data+2);
 img_n=3;
 data+=4;
 out=(u8*)malloc(w*h);
 free(img);
 img=(u8*)malloc(img_w*img_h*img_h);
 hunpack(data,out);
 for(i=0;i<w*h;i++)
  memcpy(img+i*img_n,imagespal+out[i]*3,3);
 free(out);
}
#endif

void ui_room_update()
{
 REFRESH
 
 ui_room_gfx_update();
 status_update();  
}

void clean()
{
 /*u8 backup=*ADDR(0x0001);
 *ADDR(0x0001)=0x37-3;
 memset(ADDR(0xF200),0,8);
 *ADDR(0x0001)=backup;*/
}

void parser_update()
{  
 txt=(u8*)">";
 al=0;txt_col=COLOR_GRAY2;txt_rev=0;txt_x=0;txt_y=text_ty+text_y;
 bCOLCHARMEM[txt_y*SCREENCH_W+txt_x]=COLOR_GRAY2;                         
 bCHARMEM[txt_y*SCREENCH_W+txt_x]='>';
 txt_x=1;
 //core_drawtext();
 txt=strcmd;
 txt_col=COLOR_GRAY2;
 core_drawtext(); 
 bCOLCHARMEM[txt_y*SCREENCH_W+txt_x]=COLOR_BLACK;                         
 bCHARMEM[txt_y*SCREENCH_W+txt_x]=' ';
 al=0;
 REFRESH
}

void ui_getkey()
{
 while(1)
  {
#if defined(WIN32)||defined(APP_SDL)
 ch=cgetc();
#else
#if defined(OSCAR64)
 __asm{
     JSR SCNKEY
     JSR GETIN
     STA ch
   }
#else
 __asm__("JSR %w",SCNKEY);
 __asm__("JSR %w",GETIN);
 __asm__("STA %v",ch);
#endif
#endif
 if(ch)
  break;
 REFRESH
  }
 #if defined(WIN32)||defined(APP_SDL)
 if((ch>='a')&&(ch<='z'))
  ch=ch-'a'+'A';
 #endif
}

void ui_waitkey()
{
 ll=SCREENCH_W/2-2;
 while(ll<SCREENCH_H/2+2)
  {
  bCOLCHARMEM[(SCREENCH_H-1)*SCREENCH_W+ll]=COLOR_GRAY1;
  bCHARMEM[(SCREENCH_H-1)*SCREENCH_W+ll]=46;
  ll++;
  }
 ui_getkey();
 ll=SCREENCH_H/2-2;
 while(ll<SCREENCH_H/2+2)
  {
  bCOLCHARMEM[24*SCREENCH_W+ll]=COLOR_GRAY1;
  bCHARMEM[24*SCREENCH_W+ll]=' ';
  ll++;
  }
 al=0;
}

void ui_text_write(u8*text)
{ 
 txt=text;
 txt_col=COLOR_WHITE; 
 if(text_attach)
  text_attach=0;
 else
  {
   txt_rev=0;txt_x=0;txt_y=text_ty+text_y;
  }
 while(1)
  {  
  core_drawtext();
  if(_ch==0)
   {
    if(txt[-1]=='+')
     {text_attach=1;if(txt_x) txt_x--;}
    else
    if(text_continue)
     text_attach=1;
    else
     {
     text_y=txt_y-text_ty;
      cr();
     }
   break;
   }
  else
   ui_waitkey();
  }  
 text_continue=0;
 al++;
}

void ui_clear()
{
 text_y=0,text_x=0;al=0;
 if(clearfull)
  {
   memset(bCHARMEM+status_y*SCREENCH_W,' ',SCREEN_W);
   memset(bCOLCHARMEM+status_y*SCREENCH_W,COLOR_BLACK,SCREEN_W);
   clearfull=0;
  }
 memset(bCHARMEM+(text_ty*SCREENCH_W),' ',(SCREENCH_H-text_ty-1)*SCREENCH_W);
 memset(bCOLCHARMEM+(text_ty*SCREENCH_W),COLOR_BLACK,(SCREENCH_H-text_ty-1)*SCREENCH_W);
}

}

// ---------------------------------------------------------------

int app_proc( app_t* app, void* user_data )
{    
    APP_U32 dummy = 0;
    app_displays_t displays;
    
    theapp=app;
    //memset( canvas, 0xC0, sizeof( canvas ) );
    app_screenmode( app, APP_SCREENMODE_FULLSCREEN );

    displays = app_displays( app );
    
     if( displays.count > 0 ) {
        // find main display
        int i,disp = 0;
        for( i = 0; i < displays.count; ++i )
        {
            if( displays.displays[ i ].x == 0 && displays.displays[ i ].y == 0 ) {
                disp = i;
                break;
            }
        }
        {// calculate aspect locked width/height
        int scrwidth = displays.displays[ disp ].width;
        int scrheight = displays.displays[ disp ].height;
        int aspect_width = (int)( ( scrheight * screen_sx ) / screen_sy );
        int aspect_height = (int)( ( scrwidth * screen_sy ) / screen_sx );
        int target_width, target_height;
        if( aspect_height <= scrheight ) {
            target_width = scrwidth;
            target_height = aspect_height;
        } else {
            target_width = aspect_width;
            target_height = scrheight;
        }
        // set window size and position
        {int x = displays.displays[ disp ].x + ( displays.displays[ disp ].width - target_width ) / 2;
        int y = displays.displays[ disp ].y + ( displays.displays[ disp ].height - target_height ) / 2;
        int w = target_width;
        int h = target_height;
        app_window_pos( app, x, y );
        app_window_size( app, w, h );
        }
        }
    }

    #ifndef __wasm__
     app_window_size( app, screen_sx, screen_sy );
#if defined(_DEBUG)
        fullscreen = 0;        
#else
        fullscreen = 1;
#endif
    #else
        game.fullscreen = 0;
    #endif
    app_interpolation( app, APP_INTERPOLATION_NONE );
    app_screenmode( app, fullscreen ? APP_SCREENMODE_FULLSCREEN : APP_SCREENMODE_WINDOW );
    app_title( app, GAME_TITLE );

     // No mouse cursor    
    app_pointer( app, 1, 1, &dummy, 0, 0 );

    //frametimer_t* frametimer = frametimer_create( NULL );
    //frametimer_lock_rate( frametimer, GAME_FRAMERATE );
#if defined(AUDIO_SUPPORT)
    audio_new(&game);
#if defined(USE_MINIAUDIO)
    ma_result result;
    ma_engine engine;
    result = ma_engine_init(NULL, &engine);
    if (result != MA_SUCCESS) {
        return -1;
    }
#endif
#endif

    app_present( app, canvas, canvas_w, canvas_h, 0xffffff, 0x000000 );

#if defined(_DEBUG)
    if(0)
     images_build();
#endif
    
    c64_main();

    /*while( app_yield( app ) != APP_STATE_EXIT_REQUESTED )
    {
        app_present( app, canvas, GAME_WIDTH, GAME_HEIGHT, 0xffffff, 0x000000 );
    }*/

   

    //frametimer_destroy( frametimer );
#if defined(AUDIO_SUPPORT)
#if defined(USE_MINIAUDIO)
    ma_engine_uninit(&engine);
#endif
    audio_delete(&game);
#endif

    //game_reset();

    return 0;
}

extern "C" int main( int argc, char** argv ) {
    (void) argc, (void ) argv;
    
    return app_run( app_proc, NULL, NULL, NULL, NULL );
}


// pass-through so the program will build with either /SUBSYSTEM:WINDOWS or /SUBSYSTEM:CONSOLE
#if defined( _WIN32 ) && !defined( __TINYC__ )
    #ifdef __cplusplus 
        extern "C" int __stdcall WinMain( struct HINSTANCE__*, struct HINSTANCE__*, char*, int ) { 
            return main( __argc, __argv ); 
        }
    #else
        struct HINSTANCE__;
        int __stdcall WinMain( struct HINSTANCE__* a, struct HINSTANCE__* b, char* c, int d ) { 
            (void) a, b, c, d; return main( __argc, __argv ); 
        }
    #endif
#endif


