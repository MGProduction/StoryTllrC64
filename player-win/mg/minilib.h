//
// Copyright (c) 2023, Marco Giorgini [ @marcogiorgini ]
// Distributed under the MIT License
//
// minimal memory/string library
//

#ifndef mg_minlib_h
#define mg_minlib_h

#ifdef __cplusplus
extern "C" {
#endif

// -------------------------------------------------------------------------

#if defined(WANT_STANDARD)
typedef unsigned int uint32_t;
typedef signed long int32_t;
typedef unsigned short uint16_t;
typedef short int16_t;
typedef unsigned char uint8_t;
typedef signed char int8_t;
#endif

typedef unsigned int   dword;
typedef unsigned short word;
typedef unsigned char  byte;

typedef unsigned long DWORD;
typedef unsigned short WORD;
typedef unsigned char BYTE;

#define TRUE  1
#define FALSE 0

// -------------------------------------------------------------------------

typedef struct{
 float x,y,w,h;
}_aabb;

typedef struct{
 float x,y;
}_fpos;

// -------------------------------------------------------------------------

#if defined(LEAKCHECK)
void*_ALLOC(size_t size,const char*file,int linenumber);
#define ALLOC(a) _ALLOC(a,__FILE__,__LINE__)
#else
void*ALLOC(size_t size);
#endif
const char*STRDUP(const char*str);
void STRFREE(const char*str);
void*REALLOC(void*mem,size_t size);
void FREE(void*mem);

// -------------------------------------------------------------------------

#define              strhash_null -1
typedef unsigned int _strhash;

// -------------------------------------------------------------------------

#define isbetween(a,b,c)           (((a)>=(b))&&((a)<=(c)))

// -------------------------------------------------------------------------

#define carray_usage
#if defined(carray_usage)
#define carray_define(tagtipo,tipo,pointer) \
typedef struct tagtipo{\
                       pointer*       items;\
                       int            total;\
                       int            cnt;\
                       unsigned int   granularity;\
                      } tipo;
                      
#define carray_set(mem,pointer,mitems)             {mem.cnt=0;\
                                                   mem.total=mitems;\
                                                   mem.granularity=mitems;\
                                                   mem.items=(pointer*)ALLOC(mitems*sizeof(pointer));}

#define carray_addspace(mem,pointer,hm) while(mem.cnt+hm>=mem.total)\
                                        {\
                                         while(mem.cnt+hm>=mem.total)\
                                          if(mem.total*sizeof(pointer)<16*1024*1024) mem.total*=2; else mem.total+=(mem.total/16);\
                                         mem.items=(pointer*)REALLOC(mem.items,mem.total*sizeof(pointer));\
                                        }

#define carray_safeadd(mem,pointer,what) {carray_addspace((mem),pointer,1)\
                                         (mem).items[(mem).cnt++]=what;}
                      
                      
#define carray_free(mem) {if(mem.items)\
                          {\
                           FREE(mem.items);\
                           mem.items=NULL;\
                          }\
                         mem.cnt=mem.total=0;}
                         
#define carray_delete(mem,pointer,i) \
 {if(mem.cnt-((i)+1)>0)\
   memmove(&mem.items[i],&mem.items[i+1],(mem.cnt-((i)+1))*sizeof(pointer));\
  mem.cnt--;}

#define carray_deleterange(mem,pointer,i,l) \
 {if(mem.cnt-((i)+(l))>0)\
   memmove(&mem.items[i],&mem.items[i+(l)],(mem.cnt-((i)+(l)))*sizeof(pointer));\
  mem.cnt-=(l);}     
#endif

// -------------------------------------------------------------------------

int          string_hasextension(const char*file,const char*ext);
int          string_addtoseq(char*bag,const char*add,int bagsize);
void         string_changeextension(char*file,const char*ext);
int          string_getname(char*name,const char*file);
int          string_getpath(const char*file,char*path);
const char*  string_getline(const char*s,char*line,int linesize);
const char*  string_gettoken(const char*s,char*tok,char sep);
int          string_trim(const char*source,char*dest,int flags);
int          string_isin(const char*sz,const char*seq);
int          string_charcount(const char*sz,char ch);
int          string_replace(char*sz,int pos,int len,const char*what);

byte*        file_read(const char*nm,dword*size);

// -------------------------------------------------------------------------

_strhash     strhash(const char*str);

// -------------------------------------------------------------------------

#ifdef __cplusplus
}
#endif

#endif

// -------------------------------------------------------------------------

#ifdef MINILIB_IMPLEMENTATION

#ifndef MINILIB_IMPLEMENTATION_ONCE
#define MINILIB_IMPLEMENTATION_ONCE

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#if defined(LEAKCHECK)

typedef struct{
 void      *mem;
 const char*file;
 int        linenumber;
 size_t     size;
}ptr;

ptr p[8192];
int ip;

#endif

int i_alloc=0;
int i_walloc=0;
size_t i_maxalloc=0;
size_t i_sumalloc=0;
#if defined(LEAKCHECK)
void*_ALLOC(size_t size,const char*file,int linenumber)
{
 void*mem=calloc(size,1);
 i_alloc++;i_walloc++;i_sumalloc+=size;
 if(size>i_maxalloc)
  i_maxalloc=size; 
 p[ip].mem=mem;
 p[ip].file=file;
 p[ip].linenumber=linenumber;
 p[ip].size=size;
 ip++;
#if defined(SMALLER_TRACE_MEMORY)
 printf("ALLOC:%d [%s:%d]\n",(int)size,file,linenumber);
#endif   
 return mem;
}
#define ALLOC(a) _ALLOC(a,__FILE__,__LINE__)
#else
void*ALLOC(size_t size)
{
 void*mem=calloc(size,1);
 i_alloc++;i_walloc++;i_sumalloc+=size;
 if(size>i_maxalloc)
  i_maxalloc=size;
#if defined(SMALLER_TRACE_MEMORY)
 printf("ALLOC:%d\n",size);
#endif  
 return mem;
}
#endif
void*REALLOC(void*mem,size_t size)
{
 void*nmem=realloc(mem,size);
#if defined(LEAKCHECK)
 int ii=ip,err=0;
 while(ii--)
  if(p[ii].mem==mem)
   {
    i_sumalloc-=p[ii].size;i_sumalloc+=size;
    p[ii].size=size;
    p[ii].mem=nmem;
    break;
   }
 if(ii==-1)
  err++;
#endif  
#if defined(SMALLER_TRACE_MEMORY)
 printf("REALLOC:%d\n",(int)size);
#endif   
#if defined(LEAKCHECK)
#endif
 return nmem;
}
void FREE(void*mem)
{
#if defined(LEAKCHECK)
 int ii=ip,err=0;
 while(ii--)
  if(p[ii].mem==mem)
   {
    i_sumalloc-=p[ii].size;
    memmove(&p[ii],&p[ii+1],(ip-(ii+1)+1)*sizeof(ptr));
    ip--;
    break;
   }
 if(ii==-1)
  err++;
#endif   
 if(mem)
  {
   i_alloc--;
   free(mem);
  } 
}

int istrhash=0;
typedef struct{
 _strhash hash;
 size_t   pos;
 short    idx,cnt;
}strhashpool;

typedef struct{
strhashpool*hpl;
int         cnt,top,topidx;
char*       sz[64];
size_t      szcur;  
size_t      pos,posgl;
}strhashpooler;

strhashpooler hpl;

void strings_init()
{
 hpl.szcur=0;
 hpl.top=16*1024;
 hpl.sz[hpl.szcur]=(char*)ALLOC(hpl.top);
 hpl.topidx=8192;
 hpl.hpl=(strhashpool*)ALLOC(hpl.topidx*sizeof(strhashpool));
}

void strings_reset()
{
 int i,saved=0;
 for(i=0;i<hpl.cnt;i++)
  saved+=hpl.hpl[i].cnt-1;
 for(i=0;i<=hpl.szcur;i++)
  FREE(hpl.sz[i]);
 FREE(hpl.hpl);
}

const char*strings_revstrhash(_strhash hash)
{
 int i=hpl.cnt;
 while(i--)
  if(hpl.hpl[i].hash==hash)
   return hpl.sz[hpl.hpl[i].idx]+hpl.hpl[i].pos;
 return "";  
}

const char*strings_add(const char*ostr,_strhash hash)
{
 int i=hpl.cnt;
 int len=strlen(ostr);
 while(i--)
  if(hpl.hpl[i].hash==hash)
   if(strcmp(ostr,hpl.sz[hpl.hpl[i].idx]+hpl.hpl[i].pos)==0)
    {
     hpl.hpl[i].cnt++;
     return hpl.sz[hpl.hpl[i].idx]+hpl.hpl[i].pos;       
    } 
 if(hpl.pos+len+1>=hpl.top)
  {
   hpl.szcur++;
   hpl.sz[hpl.szcur]=(char*)ALLOC(16*1024);
   hpl.pos=0;
  }   
 if(hpl.cnt+1>=hpl.topidx)
  {
   hpl.topidx+=4096;
   hpl.hpl=(strhashpool*)REALLOC(hpl.hpl,hpl.topidx*sizeof(strhashpool));
  }
 strcpy(hpl.sz[hpl.szcur]+hpl.pos,ostr);
 hpl.hpl[hpl.cnt].idx=hpl.szcur;
 hpl.hpl[hpl.cnt].hash=hash;
 hpl.hpl[hpl.cnt].pos=hpl.pos;
 hpl.hpl[hpl.cnt].cnt=1;
 hpl.pos+=len+1;
 hpl.posgl+=len+1;
 hpl.cnt++;
 return hpl.sz[hpl.cnt-1]+hpl.hpl[hpl.cnt-1].pos;
}

_strhash strhash(const char*str)
{
   unsigned int hash = 0;
   const char*  ostr=str;
   while (*str)
      hash = (hash << 7) + (hash >> 25) + *str++;
   hash+=(hash >> 16);
   strings_add(ostr,hash);
   return hash;
}

int string_charcount(const char*sz,char ch)
{
 int cnt=0;
 while(*sz)
  {
   if(*sz==ch)
    cnt++;
   sz++;
  }
 return cnt; 
}

int string_replace(char*sz,int pos,int len,const char*what)
{
 int l=strlen(what);
 if(l!=len)
  memmove(sz+pos+l,sz+pos+len,strlen(sz+pos+len)+1);
 memcpy(sz+pos,what,l);
 return l-len;
}

int string_isin(const char*sz,const char*seq)
{
 if(sz&&seq&&*sz) 
  {
   const char*psz=strstr(seq,sz);
   if(psz)
    {
     int  len=strlen(sz);
     while(psz)
      {
       int p=psz-seq;
       if(((p==0)||(psz[-1]=='|'))&&((psz[len]=='|')||(psz[len]==0)))
        return TRUE;
       else
        psz++;
       psz=strstr(psz,sz);
      }
    }
  }
 return FALSE;
}

int string_addtoseq(char*bag,const char*add,int bagsize)
{
 if(string_isin(add,bag))
  return 0;
 else
  {
   int len=strlen(bag),llen=strlen(add);
   if((len+llen+1<bagsize)||(bagsize==-1))
    {
     if(*bag) strcat(bag,"|");
     strcat(bag,add);
     return 1;
    }
   else
    return -1;  
  } 
}

int string_trim(const char*source,char*dest,int flags)
{
 int i=0,j,len=(int)strlen(source);
 if(flags&1)
  for(i=0;(source[i])&&(((unsigned char)source[i])<=' ');i++);
 if(flags&2)
  {    
   for(j=len-1;(j>0)&&(source[j])&&(((unsigned char)source[j])<=' ');j--);
   if(dest!=source)
    strcpy(dest,source);
   dest[j+1]=0;
  }
 if(i!=0)
  {
   int l=strlen(dest+i)+1;
   memmove(dest,dest+i,l);
  } 
 return (int)strlen(dest);
}

const char*string_getline(const char*s,char*line,int linesize)
{
 int i=0,j=0;
 while((s[i]!=0)&&(s[i]!='\r')&&(s[i]!='\n')&&(s[i]!=11))
  if(line)
   if(j<linesize-1)
    line[j++]=s[i++];
 if(line)
  line[j]=0;
 if((s[i]=='\n')||(s[i]==11))
  i++;
 else
  if(s[i]=='\r')
   {
    i++;
    if(s[i]=='\n')
     i++;
   }
 if(s[i]==0)
  return NULL;
 else
  return s+i;

}

const char*string_gettoken(const char*s,char*tok,char sep)
{ 
 while(*s&&(*s!=sep))
  *tok++=*s++;
 *tok++=0;
 if(*s==sep)
  s++;
 if(*s==0)
  return NULL;
 else  
  return s;
}

void string_changeextension(char*file,const char*ext)
{
 size_t l=strlen(file);
 while(l--)
  if(file[l]=='.')
   { 
				if((ext==NULL)||(*ext==0))
					file[l]=0;
				else
     strcpy(file+l+1,ext);
    break;
   } 
}

int string_getpath(const char*file,char*path)
{
 int i=0,li=0;
 while(file[i])
  if((file[i]=='\\')||(file[i]=='/'))
   {
    li=1+i++;
   }
  else
   i++;
 memcpy(path,file,li);path[li]=0; 
 return 1;  
}

int string_getname(char*name,const char*file)
{
 size_t l=strlen(file);
 while(l--)
  if(file[l]=='.')
   { 
    int n=l--;
    while(l--)
     if((file[l]=='\\')||(file[l]=='/'))
      break;     
    memcpy(name,file+l+1,n-(l+1));name[n-(l+1)]=0;
    return 1;
   } 
 return 0;  
}

int string_hasextension(const char*file,const char*ext)
{
 size_t len=strlen(file),l=2;
 if(len>1)
  {
   while(len-l)
    if(file[len-l]=='.')
     return string_isin(file+len-l+1,ext);
    else
     l++;
  }
 return 0;
}

const char*STRDUP(const char*str)
{
 return strings_add(str,strhash(str)); 
}

void STRFREE(const char*str)
{
}

#include <sys/stat.h>
byte*        file_read(const char*name,dword*size)
{
 struct stat filestat;
 if(stat(name, &filestat) == 0)
  {  
   FILE*f=fopen(name,"rb");
   if(f)
    {
     dword st_size=filestat.st_size;
     byte *mem=(byte*)malloc(st_size);
     fread(mem,1,st_size,f);  
     fclose(f); 
     if(size) *size=st_size;
     return mem;
   }
  }
 if(size) *size=0;
 return NULL;
}

#endif

#endif

// -------------------------------------------------------------------------


