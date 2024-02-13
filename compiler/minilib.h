#define   S_alllowercase     0
#define   S_alluppercase     2

#define M_free(a) free(a)
#define M_alloc(a) calloc(a,1)
#define M_realloc(a,b) realloc(a,b)

#ifndef isbetween
#define isbetween(a,b,c)           (((a)>=(b))&&((a)<=(c)))
#endif

HANDLE file_create(const char* lpszFilename)
{
 return (HANDLE)CreateFileA(lpszFilename,GENERIC_READ|GENERIC_WRITE,FILE_SHARE_READ,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL/*|FILE_FLAG_RANDOM_ACCESS*/,NULL);
}
HANDLE file_openR(const char* lpszFilename)
{
 HANDLE hf;
 hf = (HANDLE)CreateFileA(lpszFilename, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL/*|FILE_FLAG_RANDOM_ACCESS*/, NULL);
 return hf;
}
int file_close(HANDLE hf)
{
 return CloseHandle((HANDLE)hf);
}
long file_write(HANDLE hf, const LPVOID lpBuffer, long lBytes)
{
 DWORD dw;
 WriteFile((HANDLE)hf, lpBuffer, (DWORD)lBytes, &dw, NULL);
 return (long)dw;
}
long file_writes(HANDLE hf,const LPVOID lpBuffer)
{
 return file_write(hf,lpBuffer,strlen((char*)lpBuffer));
}
DWORD F_filesize(HANDLE hf)
{ 
 DWORD d;
 return GetFileSize((HANDLE)hf,&d);     
}
long file_read(HANDLE hf,LPVOID lpBuffer,long lBytes)
{
 DWORD dw;
 ReadFile((HANDLE)hf,lpBuffer,(DWORD)lBytes,&dw,NULL);
 return (long)dw;
}
long file_readfile(const char* name,u8**p)
{
 HANDLE  h;
 long   l;
 h=file_openR(name);
 if(h==((HANDLE)-1))
  return -1;
 l=F_filesize(h); 
 if(l>=0)
 {
   *p=M_alloc(l+1);
   if (*p)
	 {
		if (l>0)
		 file_read(h,*p,l);
	 }
   else
    l=-1;
  }
 file_close(h);
 return l;
}
int file_updateneeded(const char*nmxW,const char*nmxQ)
{
 HANDLE hf=file_openR(nmxW);
 int   needed=1;
 if(hf!=(HANDLE)-1)
  {
   FILETIME lWTW,lWTQ;
   GetFileTime((HANDLE)hf,NULL,NULL,&lWTW);
   file_close(hf);
   hf=file_openR(nmxQ);
   if(hf!=(HANDLE)-1)
    {
     GetFileTime((HANDLE)hf,NULL,NULL,&lWTQ);
     file_close(hf);
     if(CompareFileTime(&lWTW,&lWTQ)<=0)
      needed=0;               
    } 
   else
    needed=1;              
  }           
 else
  needed=-1; 
 return needed; 
} 
int file_exists(const char* lpszFilename)
{
 HANDLE hf = file_openR(lpszFilename);
	if (hf!=(HANDLE)INVALID_HANDLE_VALUE)
	{
		file_close(hf);
  return 1;
	}
 return 0;
}
int utf8_getchar(const char* s, int* adv)
{
 const unsigned char* p=(const unsigned char*)s;
	int u = 0;
	if(adv) *adv = 1;
	if (*p<192)
	{
		u = (int)*p;
	}
	else if (*p<224)
	{
		u = ((int)(*p&(unsigned char)0x1f)<<6)|((int)(p[1]&(unsigned char)0x3f));
		if(adv) *adv = 2;
	}
	else if (*p<240)
	{
		if (p[1]!=0)
		{
			u = ((int)(*p&(unsigned char)0x0f)<<12)|((int)(p[1]&(unsigned char)0x3f)<<6)|((int)(p[2]&(unsigned char)0x3f));
			if(adv) *adv = 3;
		}
	}
	else
	{
		if ((p[1]!=0)&&(p[2]!=0))
		{
			u = ((int)(*p&(unsigned char)0x07)<<18)|((int)(p[1]&(unsigned char)0x3f)<<6)|((int)(p[2]&(unsigned char)0x3f));
			if(adv) *adv = 4;
		}
	}
	return u;
}

int stC_isalpha[256]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
                      0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,1,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,
                      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0
                      };                     

int stC_tolower[256]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,
                      ' ','!','"','#','$','%','&','\'','(',')','*','+',',','-','.','/','0','1','2','3','4','5','6','7','8','9',':',';','<','=','>','?',
                      '@','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','[','\\',']','^','_',
                      '`','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','{','|','}','~','',
                      'Ä','Å','Ç','É','Ñ','Ö','Ü','á','à','â','ö','ã','ú','ç','û','è','ê','ë','í','ì','î','ï','ñ','ó','ò','ô','ö','õ','ú','ù','û','ˇ',
                      '†','°','¢','£','§','•','¶','ß','®','©','™','´','¨','≠','Æ','Ø','∞','±','≤','≥','¥','µ','∂','∑','∏','π','∫','ª','º','Ω','æ','ø',
                      '‡','·','‚','„','‰','Â','Ê','Á','Ë','È','Í','Î','Ï','Ì','Ó','Ô','','Ò','Ú','Û','Ù','ı','ˆ','◊','¯','˘','˙','˚','¸','˝','ﬁ','ﬂ',
                      '‡','·','‚','„','‰','Â','Ê','Á','Ë','È','Í','Î','Ï','Ì','Ó','Ô','','Ò','Ú','Û','Ù','ı','ˆ','◊','¯','˘','˙','˚','¸','˝','˛','ˇ'
                      };

int stC_toupper[256]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,
                      ' ','!','"','#','$','%','&','\'','(',')','*','+',',','-','.','/','0','1','2','3','4','5','6','7','8','9',':',';','<','=','>','?',
                      '@','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','[','\\',']','^','_',
                      '`','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','{','|','}','~','',
                      'Ä','Å','Ç','É','Ñ','Ö','Ü','á','à','â','ä','ã','å','ç','é','è','ê','ë','í','ì','î','ï','ñ','ó','ò','ô','ö','õ','ú','ù','û','ü',
                      '†','°','¢','£','§','•','¶','ß','®','©','™','´','¨','≠','Æ','Ø','∞','±','≤','≥','¥','µ','∂','∑','∏','π','∫','ª','º','Ω','æ','ø',
                      '¿','¡','¬','√','ƒ','≈','∆','«','»','…',' ','À','Ã','Õ','Œ','œ','–','—','“','”','‘','’','÷','◊','ÿ','Ÿ','⁄','€','‹','›','ﬁ','ﬂ',
                      '¿','¡','¬','√','ƒ','≈','∆','«','»','…',' ','À','Ã','Õ','Œ','œ','–','—','“','”','‘','’','÷','◊','ÿ','Ÿ','⁄','€','‹','›','˛','ˇ'
                      };

#define   C_isalpha(c) stC_isalpha[((u8)c)]

const char* string_gettoken(const char* stringa,char* token,char sep)
{
 int i=0;
 while(*stringa&&(*stringa!=sep))
  if(token)
   token[i++]=*stringa++;
  else 
   stringa++;
 if(token)  
  token[i]=0;
 if(*stringa)
  stringa++;
 if(*stringa==0)
  return NULL;
 else
  return stringa;
}

int cIsCharIn(const char ch,const char*seq)
{
 while(*seq)
  if(ch==*seq)
   return 1;
  else
   seq++;
 return 0;   
}

const char* string_gettoken2(const char* stringa,char* token,const char*sep)
{
 int i=0;
 while(*stringa&&(!cIsCharIn(*stringa,sep)))
  if(token)
   token[i++]=*stringa++;
  else 
   stringa++;
 if(token)  
  token[i]=0;
 if(*stringa)
  stringa++;
 if(*stringa==0)
  return NULL;
 else
  return stringa;
}

const char* string_getline(const char* stringa,char* line)
{
 int i;
 for(i=0;(stringa[i]!=0)&&(stringa[i]!='\r')&&(stringa[i]!='\n')&&(stringa[i]!=11);i++)
  if(line)
   line[i]=stringa[i];
 if(line)
  line[i]=0;
 if((stringa[i]=='\n')||(stringa[i]==11))
  i++;
 else
  if(stringa[i]=='\r')
   {
    i++;
    if(stringa[i]=='\n')
     i++;
   }
 if(stringa[i]==0)
  return NULL;
 else
  return stringa+i;
}

char* string_getfilename(const char* sz,char* s)
{
 int i;
 i=(int)strlen(sz)-1;
 for(;i&&((sz[i]!='\\')&&(sz[i]!='/'));i--);
 if(i)
  strcpy(s,sz+i+1);
 else
  strcpy(s,sz);
 return s;
}

char* string_getpath(const char* sz,char* s)
{
 int i;
 i=(int)strlen(sz);
 if(i) i--;

 for(;i&&((sz[i]!='\\')&&(sz[i]!='/'));i--);

 if(i)
  {
   memcpy(s,sz,i+1);
   s[i+1]=0;
  }
 else
  strcpy(s,"");
 return s;
}

char* string_getINInamepath(char* sz,const char* path)
{
 static char s[4][MAX_PATH+32];
 static int  is=0;  
 char*  ps;
 
 memset(s[is],0,sizeof(s[is]));
 if(((*sz=='\\')&&(sz[1]=='\\'))||(C_isalpha(*sz)&&(sz[1]==':')))
  ; 
 else
  { 
   int lp;   
   strcpy(s[is],path);
   lp= strlen(path);
   if(lp&&(path[lp-1]!='/')&&(path[lp-1]!='\\'))
    strcat(s[is],"/");
   } 
 strcat(s[is],sz);
 ps=s[is];
 is++;
 if(is==4) is=0;
 return ps;
}

int string_trim(char* source,char* dest)
{
 int i,j,len;
 for(i=0;(source[i])&&(((u8)source[i])<=' ');i++);
 len=(int)strlen(source);
 for(j=len-1;(j>0)&&(source[j])&&(((u8)source[j])<=' ');j--);
 if(dest!=source)
  strcpy(dest,source);
 dest[j+1]=0;
 if(i!=0)
  {
   int l= strlen(dest+i)+1;
   memmove(dest,dest+i,l);
  } 
 return (int)strlen(dest);
}

char* string_normalize(char* wword,int kind)
{
 u8* word=(u8*)wword;
 int i;
 switch(kind)
  {
   case S_alllowercase:
    for(i=0;word[i];i++)
     word[i]=stC_tolower[(u8)word[i]];
   break;
   case S_alluppercase:
    for(i=0;word[i];i++)
     word[i]=stC_toupper[(u8)word[i]];
  }
 return (char*)word;
}

char* string_replace(char* sz,int where,int len,const char* what)
{
 int szlen;
 int whlen; 
 szlen=(int)strlen(sz);
 if(what)
  whlen=(int)strlen(what);
 else
  whlen=0;
 if((szlen-(where+len)+1>0)&&(whlen!=len))
  memmove(sz+where+whlen,sz+where+len,szlen-(where+len)+1);
 if(whlen)
  memcpy(sz+where,what,whlen);
 return sz;
}
#define   string_insert(sz,where,what) string_replace(sz,where,0,what)
#define   string_delete(sz,where,len) string_replace(sz,where,len,"")

int cIsIn(const char*sz,const char*seq)
{
 if(sz&&seq&&*sz) 
  {
   const char*psz=strstr(seq,sz);
   if(psz)
    {
     int  len= strlen(sz);
     while(psz)
      {
       if(((psz==seq)||(psz[-1]=='|'))&&((psz[len]=='|')||(psz[len]==0)))
        return 1;
       else
        psz++;
       psz=strstr(psz,sz);
      }
    }
  }
 return 0;
}

#ifndef BUF_USAGE

#define BUF_USAGE
#define BUF_define(tagtipo,tipo,pointer) \
typedef struct tagtipo{\
                       pointer*  mem;\
                       int       m;\
                       int       c;\
                       u16       gran;\
                      } tipo;

BUF_define(tagBUF,BUF,u8)
BUF_define(tagBUFC,BUFC,char)
BUF_define(tagBUFW,BUFW,u16)

//#pragma pack()


#define BUF_addspace(buf,pointer,hm) while(buf.c+hm>=buf.m)\
                                        {\
                                         while(buf.c+hm>=buf.m)\
                                          if(buf.m*sizeof(pointer)<16*1024*1024) buf.m*=2; else buf.m+=(buf.m/16);\
                                         buf.mem=(pointer*)M_realloc(buf.mem,buf.m*sizeof(pointer));\
                                        }



#define BUF_set(buf,pointer,mitems)             {buf.c=0;\
                                                   buf.m=mitems;\
                                                   buf.gran=mitems;\
                                                   buf.mem=(pointer*)M_alloc(buf.m*sizeof(pointer));}



#define BUF_insert(mem,pointer,i,what) \
 {if(mem.c-(i)>0)\
   memmove(&mem.mem[i+1],&mem.mem[i],(mem.c-(i))*sizeof(pointer));\
  mem.mem[i]=what;\
  mem.c++;}

#define BUF_insertarray(mem,pointer,i,size,what) \
 {int j;\
  if((mem.c-(i))>0)\
   memmove(&mem.mem[i+size],&mem.mem[i],(mem.c-(i))*sizeof(pointer));\
  for(j=0;j<size;j++)\
   mem.mem[i+j]=what[j];\
  mem.c+=size;}

#define BUF_delete(mem,pointer,i) \
 {if(mem.c-((i)+1)>0)\
   memmove(&mem.mem[i],&mem.mem[i+1],(mem.c-((i)+1))*sizeof(pointer));\
  mem.c--;}

#define BUF_deleterange(mem,pointer,i,l) \
 {if(mem.c-((i)+(l))>0)\
   memmove(&mem.mem[i],&mem.mem[i+(l)],(mem.c-((i)+(l)))*sizeof(pointer));\
  mem.c-=(l);}

#define BUF_write(mem,pointer,hf) \
 {file_write(hf,&mem.c,sizeof(int));\
  file_write(hf,&mem.m,sizeof(int));\
  file_write(hf,&mem.gran,sizeof(int));\
  if(mem.c) file_write(hf,mem.mem,mem.c*sizeof(pointer));}

#define BUF_read(mem,pointer,hf) \
 {int temp[3];file_read(hf,&temp[0],sizeof(int)*3);\
  __adjustlong(temp[0]);\
  __adjustlong(temp[1]);\
  __adjustlong(temp[2]);\
  mem.c=temp[0];\
  mem.m=temp[1];\
  mem.gran=temp[2];\
  FREE(mem.mem);if(mem.m) mem.mem=(pointer*)M_alloc(mem.m*sizeof(pointer));\
  if(mem.c) file_read(hf,mem.mem,mem.c*sizeof(pointer));}

#define BUF_readstruct(mem,pointer,hf) \
 {int temp;file_read(hf,&mem.c,sizeof(int));\
  __adjustlong(mem.c);\
  file_read(hf,&mem.m,sizeof(int));\
  __adjustlong(mem.m);\
  file_read(hf,&temp,sizeof(int));\
  __adjustlong(temp)\
  mem.gran=temp;\
  FREE(mem.mem);}

#define BUF_safeinsert(mem,pointer,i,what) {BUF_addspace((mem),pointer,1)\
                                              BUF_insert((mem),pointer,i,what)}


#define BUF_safeadd(buf,pointer,what) {BUF_addspace((buf),pointer,1)\
                                         (buf).mem[(buf).c++]=what;}

#define BUF_free(buf) {if(buf.mem)\
                          {\
                           M_free(buf.mem);\
                           buf.mem=NULL;\
                          }\
                         buf.c=buf.m=0;}

#endif

#define FREE(a) {if((a)) { M_free((a));(a)=NULL;}}

#define _dict_ordered       1
#define _dict_sorted        1
#define _dict_counter       2
#define _dict_extradata     4
#define _dict_sureadd       8
#define _dict_noreallocpos 16
#define _dict_largerpos    32
#define _dict_counterasint 64

#define _dict_sortbystring_                  1
#define _dict_sortbycounter_                 3
#define _dict_sortbycounterreverse_          4

#define dict_increasecounter                -1
#define dict_dontupdatecounter              -2

typedef struct{
         int          size;
         int          usedsize;
         int          gran;
         int          nstrings;
         int          kind;
         char*        string;
         int*         pos;
        } dict; 

int INT_GRANULARITY=1024;
int LARGER_INT_GRANULARITY=64*1024;

int dict_new(dict*stp,int gran,int kind)
{
 stp->gran =max(gran,1024);
 stp->size=stp->gran;
 stp->nstrings=0;              
 stp->usedsize=0;
 stp->kind=kind;
 stp->string=(char*)M_alloc(stp->gran);
 if(kind&_dict_largerpos)
  stp->pos=(int*)M_alloc(LARGER_INT_GRANULARITY*sizeof(int));
 else
  stp->pos=(int*)M_alloc(INT_GRANULARITY*sizeof(int));
 return 1;
}

int dict_reset(dict*stp)
{
 FREE(stp->string);
 FREE(stp->pos);
 stp->nstrings=0;
 stp->size=0;
 stp->usedsize=0;
 return dict_new(stp,stp->gran,stp->kind);
}

int dict_softreset(dict*stp)
{
 stp->nstrings=0;
 stp->usedsize=0;
 return 1;
}

int dict_delete(dict*stp)
{
 FREE(stp->string);
 FREE(stp->pos);
 stp->nstrings=0;
 stp->size=0;
 stp->usedsize=0;
 stp->gran =0;
 return 1;
}

int dict_getEx(const dict*stp,int where,char* string,int* counter,u8* data,u16* sz)
{
 u8*   p=(u8*)stp->string;
 int*  pos=stp->pos;
 int         len;
 if(!isbetween(where,0,stp->nstrings-1))
  {
   if(string)
    *string=0;
   if(counter)
    *counter=0;
   if(sz)
    *sz=0;
   return 0;
  }
 p+=pos[where];
 if(string)
  strcpy(string,p);
 len= strlen(p)*sizeof(char)+1;
 p+=len;
 if(counter)
  {
   if(stp->kind&_dict_counter)
    *counter=*(int*)p;
   else
    *counter=1;
  }
 
 if(stp->kind&_dict_counter)
  p+=sizeof(int);
 if(stp->kind&_dict_extradata)
  {
   int size=p[0]+p[1]*256;
   if(sz)
    *sz=size;
   p+=sizeof(u16);
   if(data)
    memcpy(data,p,size);
  }
 else
  {
   if(sz)
    *sz=0;
  }
 return 1;
}

int bSureAdd=0;

int dict_get(const dict*stp,int pos,char* string)
{
 return dict_getEx(stp,pos,string,NULL,NULL,NULL);
}

_inline int dict_findCore(const dict*stp,const char* string,int*lastwhere)
{
 int         i=0;
 u8*   p=(u8*)stp->string;
 int*  pos=stp->pos;

 if((stp->nstrings)&&string&&(*string))
  {
   if((stp->kind&_dict_ordered)==_dict_ordered)
    {     
     int low=0,hi=stp->nstrings,cur;
     int cmp;
     do
      {   
       cur=low+(hi-low)/2;
       cmp=strcmp(string,p+pos[cur]);
       if(cmp==0)
        return cur;
       else
        if(cmp<0)
         hi=cur;
        else
         low=cur;
      }
     while(hi-low>5);
     for(i=low;i<hi;i++)
      {
       cmp= strcmp(string,p+pos[i]);
       if(cmp==0)
        return i;
       else
        if(cmp<0)
         {
          if(lastwhere)
           *lastwhere=i;
          return -1;
         }
      }
    }
   else
    {     
     u16    ch=((u8)string[0])+((u8)string[1]*256);
     int     i,ii;
     string++;
     i=stp->nstrings/4;
     ii=stp->nstrings%4;
     while(i--)
      {
       if(ch==*(u16*)&p[*pos++])
        if(strcmp(string,p+*(pos-1)+1)==0)
         return (pos-stp->pos)-1;       
       if(ch==*(u16*)&p[*pos++])
        if(strcmp(string,p+*(pos-1)+1)==0)
         return (pos-stp->pos)-1;       
       if(ch==*(u16*)&p[*pos++])
        if(strcmp(string,p+*(pos-1)+1)==0)
         return (pos-stp->pos)-1;       
       if(ch==*(u16*)&p[*pos++])
        if(strcmp(string,p+*(pos-1)+1)==0)
         return (pos-stp->pos)-1;       
      }
     while(ii--)
      if(ch==*(u16*)&p[*pos++])
       if(strcmp(string,p+*(pos-1)+1)==0)
        return (pos-stp->pos)-1;       
    }
  }
 if(lastwhere)
  *lastwhere=i;
 return -1;
}

char* dict_allocspace(dict*stp,int add)
{
 while(stp->usedsize+add>=stp->size)
  {
   if(stp->size<256*1024)
    while(stp->usedsize+add>=stp->size)
     stp->size+=stp->gran;
   else           
    while(stp->usedsize+add>=stp->size)
     if(stp->size*2<=0)
      stp->size+=stp->size/4;
     else
      stp->size*=2;
   stp->string=(char*)M_realloc(stp->string,stp->size);
  }
 return stp->string;
}

void dict_makespace(dict*stp,int where,int add)
{
 int        i;
 u8*  p=(u8*)stp->string;
 int* pos=stp->pos;
 int        pw=pos[where];
 memmove(p+pw+add,p+pw,stp->usedsize-pw);
 for(i=where;i<stp->nstrings;i++)
  pos[i]=pos[i]+add; 
}

void dict_insertspace(dict*stp,int where,int add)
{
 int        i;
 u8*  p=(u8*)stp->string;
 int* pos=stp->pos;
 int        pw=pos[where];
 memmove(p+pw+add,p+pw,stp->usedsize-pw);
 memset(p+pw,0,add);
 for(i=stp->nstrings;i>where;i--)
  pos[i]=pos[i-1]+add; 
}

int dict_addEx(dict*stp,const char* string,int counter,const u8* data,u16 datasize)
{ 
 int         wherex,lastwhere=stp->nstrings;
 int         len= strlen(string)*sizeof(char)+1;
 u8*   p=(u8*)stp->string;
 int*  pos=stp->pos;
 if((stp->kind&_dict_sureadd)||(bSureAdd)) 
  wherex=-1;
 else
  wherex=dict_findCore(stp,string,&lastwhere);
 if(len>1)
  if(wherex==-1)
   {
    int add=len;
    if(stp->kind&_dict_counter)            add+=sizeof(int);
    if(stp->kind&_dict_extradata)          add+=sizeof(u16)+datasize;   
    if(stp->usedsize+add+16>stp->size)
     p=dict_allocspace(stp,add);
    if(stp->kind&_dict_noreallocpos)
      ; 
    else  
     if(stp->kind&_dict_largerpos)
      {
       if((stp->nstrings%LARGER_INT_GRANULARITY)==(LARGER_INT_GRANULARITY-1))
        pos=stp->pos=(int*)M_realloc((u8*)stp->pos,(((stp->nstrings+1)/LARGER_INT_GRANULARITY)+1)*LARGER_INT_GRANULARITY*sizeof(int));
      }
     else
      {    
       if((stp->nstrings%INT_GRANULARITY)==(INT_GRANULARITY-1))
        pos=stp->pos=(int*)M_realloc((u8*)stp->pos,(((stp->nstrings+1)/INT_GRANULARITY)+1)*INT_GRANULARITY*sizeof(int));
      }  

    wherex=stp->nstrings;

    if((stp->kind&_dict_ordered)==_dict_ordered)
     {
      int i=lastwhere;
      if(i!=stp->nstrings)
       {
        dict_insertspace(stp,i,add);
        wherex=i;
       }
      else
       pos[wherex]=stp->usedsize;
     }
    else
     pos[wherex]=stp->usedsize;
    p+=pos[wherex];
    strcpy(p,string);
    p+=len;
    stp->usedsize+=len;
    if(stp->kind&_dict_counter)
     {
      if(counter!=dict_dontupdatecounter)
       if((counter!=-1)||(stp->kind&_dict_counterasint))
        {
         *(int*)p=counter;
        }
       else
        {
         *(int*)p=1;
        }        
      else
       p[0]=p[1]=p[2]=p[3]=0;
      p+=sizeof(int);
      stp->usedsize+=sizeof(int);
     }
    if(stp->kind&_dict_extradata)
     {
      p[0]=LOBYTE(datasize);
      p[1]=HIBYTE(datasize);
      p+=sizeof(u16);
      memcpy(p,data,datasize);
      stp->usedsize+=sizeof(u16);
      stp->usedsize+=datasize;
     }
    stp->nstrings++;
    return wherex;
   }
  else
   {
    p+=pos[wherex];
    p+=len;
    if(stp->kind&_dict_counter)
     {
      if(counter!=dict_dontupdatecounter)
       if((counter!=-1)||(stp->kind&_dict_counterasint))
        {
         *(int*)p=counter;
        }
       else
        {
         *(int*)p+=1;
        }
      p+=sizeof(int);
     }
    if(stp->kind&_dict_extradata)
     {
      u16 oldsize=p[0]+p[1]*256;
      if(oldsize!=datasize)
       {
        int diff=(char*)p-stp->string;
        p=dict_allocspace(stp,datasize-oldsize);
        if(wherex+1!=stp->nstrings)
         dict_makespace(stp,wherex+1,datasize-oldsize);         
        stp->usedsize+=datasize-oldsize;
        p=(u8*)stp->string+diff;
        p[0]=LOBYTE(datasize);
        p[1]=HIBYTE(datasize);
       }
      p+=sizeof(u16);
      memcpy(p,data,datasize);
     }
    return wherex;
   }
 else
  return -1;
}

int  dict_add(dict*stp,const char* string)
{
 return dict_addEx(stp,string,-1,NULL,0);
}

int dict_find(const dict*stp,const char* string)
{ 
 return dict_findCore(stp,string,NULL);
}

int dict_export(const dict*stp,const char*name)
{
 HANDLE hf=file_create(name);
 if(hf!=(HANDLE)-1)
  {
   int i;
   for(i=0;i<stp->nstrings;i++)
    {
     file_writes(hf,stp->string+stp->pos[i]);file_writes(hf,"\r\n");
    }
   file_close(hf);
   return 1;
  }
 else
  return 0;
}

typedef struct tagXTRIS{
                       int iData;
                       int iCount;
                       const char*szString;
                      } XTRIS;

BUF_define(tagAGXTRIS,BUFXTRIS,XTRIS)

static int kcomparecr( const void *arg1, const void *arg2 )
{
 XTRIS*xb1=(XTRIS*)arg1;
 XTRIS*xb2=(XTRIS*)arg2;
 if(xb2->iCount-xb1->iCount)
  return xb2->iCount-xb1->iCount;
 else
  return strcmp(xb1->szString,xb2->szString);
}

static int kcomparec( const void *arg1, const void *arg2 )
{
 XTRIS*xb1=(XTRIS*)arg1;
 XTRIS*xb2=(XTRIS*)arg2;
 if(xb1->iCount-xb2->iCount)
  return xb1->iCount-xb2->iCount;
 else
  return strcmp(xb1->szString,xb2->szString);
}

static int kcompare( const void *arg1, const void *arg2 )
{
 XTRIS*xb1=(XTRIS*)arg1;
 XTRIS*xb2=(XTRIS*)arg2;
 return strcmp(xb1->szString,xb2->szString);
}

static int kcomparei( const void *arg1, const void *arg2 )
{
 XTRIS*xb1=(XTRIS*)arg1;
 XTRIS*xb2=(XTRIS*)arg2;
 return strcmpi(xb1->szString,xb2->szString);
}

int dict_getAndCounter(dict*stp,int pos,char* string,int* counter)
{
 return dict_getEx(stp,pos,string,counter,NULL,NULL);
}

int dict_Sort(dict*stp,int iSortKind)
{
 dict     ordinato;
 int      i,count;
 int      quanti=stp->nstrings;
 XTRIS    elemento;
 BUFXTRIS xbin;
 BUF_set(xbin,XTRIS,quanti)
 for(i=0;i<quanti;i++)
  {                                                       
   dict_getAndCounter(stp,i,NULL,&count);
   elemento.iData=i;
   elemento.iCount=count;
   elemento.szString=stp->string+stp->pos[i];
   BUF_safeadd(xbin,XTRIS,elemento)
  }
if(iSortKind==_dict_sortbycounter_)
  qsort(&xbin.mem[0],xbin.c,sizeof(XTRIS),kcomparec);
 else
 if(iSortKind==_dict_sortbycounterreverse_)
  qsort(&xbin.mem[0],xbin.c,sizeof(XTRIS),kcomparecr);
 else
 if(iSortKind==_dict_sortbystring_)
   qsort(&xbin.mem[0],xbin.c,sizeof(XTRIS),kcompare);
 memset(&ordinato,0,sizeof(ordinato));
 ordinato.kind=stp->kind; 
 if(ordinato.kind&_dict_sorted) ordinato.kind-=_dict_sorted;
 ordinato.gran =stp->gran;
 ordinato.size=((stp->usedsize/1024)+1)*1024;
 ordinato.usedsize=0;
 if(ordinato.kind&_dict_largerpos)
  ordinato.pos=(int*)M_alloc(LARGER_INT_GRANULARITY*sizeof(int));
 else
  ordinato.pos=(int*)M_alloc(INT_GRANULARITY*sizeof(int));
 ordinato.string=(char*)M_alloc(ordinato.size);
 if(ordinato.string&&ordinato.pos)
  {
   u8*buf=(u8*)M_alloc(65536);
   FREE(ordinato.pos)
   if(ordinato.kind&_dict_largerpos)
    ordinato.pos=(int*)M_alloc((((xbin.c/LARGER_INT_GRANULARITY)+1)*LARGER_INT_GRANULARITY)*sizeof(int));
   else
    ordinato.pos=(int*)M_alloc((((xbin.c/INT_GRANULARITY)+1)*INT_GRANULARITY)*sizeof(int));
   ordinato.kind|=_dict_sureadd;
   ordinato.kind|=_dict_noreallocpos;
   for(i=0;i<xbin.c;i++)
    {
     char* sz;
     int       cnt2;
     u16      w;     
     count = xbin.mem[i].iCount;
     sz=stp->string+stp->pos[xbin.mem[i].iData];
     dict_getEx(stp, xbin.mem[i].iData,/*sz2*/NULL,&cnt2,(u8*)buf,&w);
     dict_addEx(&ordinato,sz,cnt2,buf,w);
    }
   ordinato.kind-=_dict_sureadd;
   ordinato.kind-=_dict_noreallocpos;
   if(iSortKind==_dict_sortbystring_)
    ordinato.kind|=_dict_sorted;
   FREE(buf);
   dict_delete(stp); 
   memcpy(stp,&ordinato,sizeof(dict));
   BUF_free(xbin);
   return 1;
  }
 else
  {
   BUF_free(xbin);
   return 0;
  }
}