// ---------------------------------------------------------------
// StoryTllr64 - compiler - v 1.0.1
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

#include <windows.h>
// ---------------------------------------------
#include <stdlib.h>
#include <stdio.h>
// ---------------------------------------------
typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
// ---------------------------------------------
#include "minilib.h"
// ---------------------------------------------
#define IMPLEMENT_C_HBUNPACK
#define IMPLEMENT_C_HBPACK
#define USE_DICTREF 1
#define HANDLE_IMAGES
// ---------------------------------------------
#define pack_bigramsanddict 4
#define pack_huffman        16
#define storytllr_imageformat_strippacked 16
#define storytllr_imageformat_huffman     17
#define storytllr_imageformat_raw         18
#define storytllr_imageformat storytllr_imageformat_strippacked
// ---------------------------------------------
#include "lib/huff.c"
// ---------------------------------------------
int bUSEPACK = pack_bigramsanddict;
int bSPACEADD = 0;
int FIXED_NGRAM = 2;
int MAX_FIXED_NGRAM = 2;
int FIXED_NGRAM2 = 0;
// ---------------------------------------------
#include "hupack.c"
// ---------------------------------------------
enum{
 C64=1,
 VIC20=2,
 ZXSpectrum,
 VGA
};
u8 model=C64;
// ---------------------------------------------
#include "lib/lev.c"
// ---------------------------------------------
#define DESC_MAXSIZE 8192
// ---------------------------------------------
dict sVRBCLS,sOBJCLS,sCLS;
dict sDEF;
dict sCMD, sCMDALIAS;
dict sVAR, sBITVAR;
dict sVRB, sROOM, sOBJ;
dict sMSG, sMSG2, sMETA, sATTR, sNAMES, sDESC, sATTRS, sKEYS, sCKEYS, sCMP, sIMG, sTNAMES;
dict sSCENERY;
dict sARTS, sADJS, sOBJSYNS, sVRBSYNS, sGENS;
dict sDICT;
int sDICT_fixedlen = 5, sDICT_usefixedlen = 0;
int sDICT_addspace = 1;
dict sADDSCORE;
BUF  opcodes, vopcodes;
BUF  roomattrs, objattrs;
BUF  mem;
BUFW memidx;
int baseverbs, baseattrs;
u8 vrbcls[1024];
u16 ivrbcls;
#if !defined(HANDLE_IMAGES)
HANDLE hfIMAGEBAT;
#endif
// ---------------------------------------------
HANDLE hfIMAGEBAT2;
// ---------------------------------------------
int   smallimages;
// ---------------------------------------------
#define bit_OBJ   2 
#define bit_ROOM  4
#define bit_MSG   8
#define bit_ATTR  16
#define bit_VAR   32

#define bit_NUM   64
#define bit_CHAR  64
#define bit_IMAGE 64

#define bit_CMP    128
#define bit_BITVAR 256
// ---------------------------------------------
int wholes=0;
int meta_base;
int meta_everywhere,meta_inventory;
int theerrors=0,thewarnings=0;
// ---------------------------------------------
void ERR(const char*line,const char*element)
{
 printf("ERR: %s :: %s\n",line,element);
 theerrors++;
}
void WARN(const char*line,const char*element)
{
 printf("WARN: %s :: %s\n",line,element);
 thewarnings++;
}
// ---------------------------------------------
int findMSG(const char*szD, int*two)
{
 int id = dict_find(&sMSG, szD);
 if (id != -1)
 {
  if (two) *two = 0;
  return id;
 }
 else
 {
  int id = dict_find(&sMSG2, szD);
  if (id != -1)
  {
   if (two) *two = 1;
   return id;
  }
  return -1;
 }
}
int addMSG(const char*szD)
{
 if (sMSG.nstrings < 254)
  return dict_add(&sMSG, szD);
 else
  return dict_add(&sMSG2, szD);
}
int addOBJ(const char*mmeta, const char*desc)
{
 if (desc&&*desc)
 {
  int odd = 0, id = dict_find(&sOBJ, mmeta);
  if (id != -1)
   odd++;
  return dict_addEx(&sOBJ, mmeta, -1, (u8*)desc, strlen(desc) + 1);
 }
 else
  return dict_addEx(&sOBJ, mmeta, -1, NULL, 0);
}
// ---------------------------------------------
void addconfig(const char*sz)
{
 char key[256],line[512];
 const char*val;
 string_getline(sz,line);
 string_trim(line,line);
 val=string_gettoken(line,key,':');
 if(val)
  dict_addEx(&sDEF,key,-1,(u8*)val,strlen(val)+1);
}
int configcheck(const char*key,const char*val)
{
 int id=dict_find(&sDEF,key);
 if(id!=-1)
  {
   char what[256];
   dict_getEx(&sDEF,id,NULL,NULL,(u8*)what,NULL);
   return (strcmp(what,val)==0);
  }
 return 0; 
}
int configvalue(const char*key,int def)
{
 int id=dict_find(&sDEF,key);
 if(id!=-1)
  {
   char what[256];
   dict_getEx(&sDEF,id,NULL,NULL,(u8*)what,NULL);
   return atoi(what);
  }
 return def; 
}
int configstring(const char*key,char*pwhat)
{
 int id=dict_find(&sDEF,key);
 if(id!=-1)
  {
   char what[256];
   dict_getEx(&sDEF,id,NULL,NULL,(u8*)what,NULL);
   if(pwhat) strcpy(pwhat,what);
   return 1;
  }
 return 0; 
}
// ---------------------------------------------
void tabwrite(HANDLE hf,int tb)
{
 tb--;
 while(tb--)
  file_writes(hf,"\t");
}
int empty(const char*l)
{
 if(memcmp(l,"//",2)==0)
  return 1;
 while((*l==' ')||(*l=='\t'))
  l++;
 return *l==0; 
}
char*treepad2txt(char*p,const char*fn)
{
 char*startp=p;
 char line[8192]; 
 char tied[32][64],prefix[32][64];
 u8   usedtied[32];
 char outf[256],nm[256];
 int  err=0,tlv=0; 
 HANDLE hf;

 sprintf(outf,"tmp/%s.txt",string_getfilename(fn,nm));
 hf=file_create(outf);
 if(hf==(HANDLE)-1)
  {
   CreateDirectoryA("tmp",NULL);
   hf=file_create(outf);
  }
 memset(tied,0,sizeof(tied));
 memset(prefix,0,sizeof(prefix));
 memset(usedtied,0,sizeof(usedtied));
 while(p&&*p)
  {
   p=string_getline(p,line);
   if(memcmp(line,"<node>",6)==0)
    {
     char title[2048],level[32];
     int  lv=0,emit,n;
     p=string_getline(p,title);
     p=string_getline(p,level);
     lv=atoi(level);

     if(lv&&cIsIn(tied[lv-1],"|objclass|verbclass|"))
      dict_add(&sCLS,title);

     if(cIsIn(title,"|objclass|verbclass|"))     
      {
       int n;
       strcpy(prefix[lv],"");
       strcpy(tied[lv],title);usedtied[lv]=2;
       for(n=lv+1;n<sizeof(usedtied);n++)
        usedtied[n]=0;
       if(*p!='<')
        err++;
      } 
     else
     if((usedtied[lv-1]!=2)&&(cIsIn(title,"|include|verb|obj|room|")||cIsIn(title,"|scenery|sceneryobj|sceneryactor|actor|genericverb|movementverb|normalobj|smallobj|topics|")||(dict_find(&sCLS,title)!=-1)))     //scenery|sceneryobj|actor|genericverb|movementverb|normalobj|
      {
       int n;
       strcpy(prefix[lv],"");
       strcpy(tied[lv],title);usedtied[lv]=1;
       for(n=lv+1;n<sizeof(usedtied);n++)
        usedtied[n]=0;
       if(*p!='<')
        err++;
      } 
     else
     if((usedtied[lv-1]!=2)&&(memcmp(title,"room:",5)==0))
      {
       int n;
       strcpy(prefix[lv],title+5);
       strcpy(tied[lv],"room");       
       usedtied[lv]=1;
       for(n=lv+1;n<sizeof(usedtied);n++)
        usedtied[n]=0;
       if(*p!='<')
        err++;
      } 
     else
      { 
       int rl=0;
       for(n=0;n<lv;n++)
        if(usedtied[n])
         rl++;
       if(lv)
        {
         if(usedtied[lv-1])
          {
           const char*t=title;
           //lv=lv-1;
           while(t)
            {
             char nm[256];
             t=string_gettoken(t,nm,'+');
             tabwrite(hf,lv-rl);
             file_writes(hf,tied[lv-1]);
             file_writes(hf,":");
             if(*prefix[lv-1])
              {
               file_writes(hf,prefix[lv-1]);
               file_writes(hf,"_");
              } 
             file_writes(hf,nm);
             file_writes(hf,"\r\n");
            } 
           emit=1;
          }
         else
          { 
           tabwrite(hf,lv-rl);
           file_writes(hf,title);
           if(cIsIn(title,"|imagedesc|desc|it.desc|en.desc|")||((memcmp(title,"attr.",5)==0)&&strstr(title,":")==NULL))
            {
             file_writes(hf,":");
             emit=0;
            } 
           else 
            {
             file_writes(hf,"\r\n");
             emit=1;
            } 
          }          
        }
       while(p&&*p)
        {
         p=string_getline(p,line);
         if(memcmp(line,"<end node>",10)==0)
          break;
         if(empty(line))
          continue; 
         if(lv) 
          {
           if(emit)
            tabwrite(hf,lv+1-rl);
           file_writes(hf,line);
           file_writes(hf,"\r\n");
           emit=1;
          }
        }
      }  
    }  
  } 
 file_close(hf); 
 FREE(p)
 if(file_readfile(outf,&p)) 
  {
   //F_remove("tmp/dump.txt");
   return p;
  } 
 else
  return NULL; 
}

char*clean(char*p,const char*fn)
{ 
 if(memcmp(p,"<Tree",5)==0) 
  return treepad2txt(p,fn);
 else
  {    
   char*bp=p;
   char*pp; 
   char line[8192]; 
   pp=strstr(p,"//");
   while(pp)
    {
     int l=0;
     while(pp[l]&&(pp[l]!='\r')&&(pp[l]!='\n'))
      l++;
     string_delete(pp,0,l); 
     pp=strstr(p,"//");
    }
   while(p&&*p)
    {
     char*pb=p;
     int  len;
     p=string_getline(p,line);
     len=strlen(line);
     string_trim(line,line);
     if(*line==0)
      {     
       if(pb[len]=='\r') len++;
       if(pb[len]=='\n') len++;
       if(len)
        string_delete(pb,0,len);
       p=pb;
      }  
    }
   return bp;       
  }   
}
// ---------------------------------------------
#if defined(HANDLE_IMAGES)

#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#define STB_IMAGE_RESIZE_IMPLEMENTATION
#include "stb/stb_image.h"
#include "stb/stb_image_write.h"
#include "stb/stb_image_resize.h"

#define v20palettesize 16
u8 v20palette[16*3]={
0x00,0x00,0x00,
0xff,0xff,0xff,
0xa8,0x3,0x4a,
0xe9,0xb2,0x87,
0x77,0x2d,0x26,
0xb6,0x68,0x62,
0x85,0xd4,0xdc,
0xc5,0xff,0xff,
0xa8,0x5f,0xb4,
0xe9,0x9d,0xf5,
0x55,0x9e,0x4a,
0x92,0xdf,0x87,
0x42,0x34,0x8b,
0x7e,0x70,0xca,
0xbd,0xcc,0x71,
0xff,0xff,0xb0};

#define vgapalettesize 56 
u8 vgapalette[vgapalettesize*3]={
45,11,56,
86,22,73,
148,57,94,
193,90,102,
227,132,120,
250,184,149,
255,228,192,
26,11,56,
18,26,71,
30,59,100,
53,100,136,
63,145,167,
85,186,197,
122,239,236,
13,30,39,
19,58,45,
38,93,61,
56,124,71,
95,175,98,
133,205,116,
200,242,152,
47,19,32,
82,33,49,
129,52,66,
170,69,69,
196,104,92,
216,142,110,
241,197,147,
36,20,53,
69,30,82,
122,51,121,
173,74,156,
203,96,169,
231,123,180,
251,174,197,
59,31,27,
96,55,40,
125,85,57,
139,104,66,
160,132,83,
194,179,104,
218,217,129,
28,23,35,
44,40,56,
64,61,81,
86,86,102,
113,115,128,
134,135,143,
161,162,167,
32,21,22,
59,45,45,
76,63,60,
104,93,88,
126,120,113,
143,139,129,
167,166,158};

#define c64palettesize 16
u8 c64palette[16*3]={0, 0, 0,
                       255, 255, 255,
                       104, 55, 43,
                       112, 164, 178, 
                       111, 61, 134,
                       88, 141, 67,
                       53, 40, 121,
                       184, 199, 111, 
                       111, 79, 37,
                       67, 57, 0,
                       154, 103, 89,
                       68, 68, 68,
                       108, 108, 108, 
                       154, 210, 132,
                       108, 94, 181,
                       149, 149, 149};

#define zxpalettesize 8
u8 zxpalette[16*3]={
 0x00,0x00,0x00,
	0x00,0x00,0xd7,
	0x00,0xd7,0x00,
	0x00,0xd7,0xd7,
	0xd7,0x00,0x00,
	0xd7,0x00,0xd7,
	0xd7,0xd7,0x00,
	0xd7,0xd7,0xd7,
	0x00,0x00,0x00,
	0x00,0x00,0xff,
	0x00,0xff,0x00,
	0x00,0xff,0xff,
	0xff,0x00,0x00,
	0xff,0x00,0xff,
	0xff,0xff,0x00,
	0xff,0xff,0xff,

/*0x00,0x00,0x00,
0x00,0x00,0x00,
0x00,0x00,0xd8,
0x00,0x00,0xff,
0xd8,0x00,0x00,
0xff,0x00,0x00,
0xd8,0x00,0xd8,
0xff,0x00,0xff,
0x00,0xd8,0x00,
0x00,0xff,0x00,
0x00,0xd8,0xd8,
0x00,0xff,0xff,
0xd8,0xd8,0x00,
0xff,0xff,0x00,
0xd8,0xd8,0xd8,
0xff,0xff,0xff*/
};

u8 palettesize=zxpalettesize;
u8*palette=zxpalette;

u8 findpalette(u8*rgb,u8*palette,u8 palsize,u8 mode);       

typedef struct{
 u8* mem;
 u16 pos;
}memfile;

u16 emit_window(u8*mem,u16 rx,u16 bufsize,FILE*fbin,memfile*head,memfile*data)
{
 u16 x=0,used=0; 
 u8  pbuf[4096];
 if(head)
  {memcpy(head->mem+head->pos,&rx,sizeof(rx));head->pos+=sizeof(rx);}
 else
  fwrite(&rx,sizeof(rx),1,fbin);used+=sizeof(rx);
 while(x<rx)
  {
   u16 what=min(rx-x,bufsize);
   u16 phm=hpack(mem,x,what,pbuf);
   //u16 phm2=hhpack(mem+x,what,pbuf);
   if(phm>=what)
    {
     phm=what;
     if(head)
      {memcpy(head->mem+head->pos,&phm,sizeof(phm));head->pos+=sizeof(phm);}
     else
      fwrite(&phm,sizeof(phm),1,fbin);used+=sizeof(phm);
     if(data)
      {memcpy(data->mem+data->pos,mem+x,what);data->pos+=what;}
     else
      fwrite(mem+x,what,1,fbin);used+=what;
    }
   else
    {
     if(head)
      {memcpy(head->mem+head->pos,&phm,sizeof(phm));head->pos+=sizeof(phm);}
      else
      fwrite(&phm,sizeof(phm),1,fbin);used+=sizeof(phm);
     if(data)
      {memcpy(data->mem+data->pos,pbuf,phm);data->pos+=phm;}
     else
      fwrite(pbuf,phm,1,fbin);used+=phm;
    }
   x+=what;
  }  
 return used;
}

typedef struct{
 char name[256];
 u8*  bitmap;
 u8*  color;
 u8*  screen;
 u16  pos, bpos;
}RIMG;
BUF_define(_DEFRIMG,DEFRIMG,RIMG)

DEFRIMG imgrooms;

u8 IMG_recover(const char*packed,const char*dest)
{
 FILE*f=fopen(packed,"rb");
 if(f)
 {
  u16 head[5],x,y,bsize,size;
  u8  cache[4096];
  u8  videomem[25*40],video_colorram[25*40];
  u8  bitmap_image[8*1024];

  fread(head,sizeof(head),1,f);
  fread(cache,head[2]+head[4],1,f);   
  if(head[1]==head[2])
   memcpy(videomem,cache,head[1]);
  else
   hunpack(cache,videomem);    

  y=0;
  x=0;
  while(x<head[3])
   {
    u8 c=cache[head[2]+x++];
    video_colorram[y++]=c&0x0F;
    video_colorram[y++]=(c&0xF0)>>4;
   }    

  fread(&bsize,sizeof(size),1,f);
  x=0;
  while(x<bsize)
  {
   fread(&size,sizeof(size),1,f);
   fread(cache,size,1,f);   
   
   if((size==bsize-x)||(size==head[0]))
    memcpy(bitmap_image+x,cache,size);
   else
    hunpack(cache,bitmap_image+x);

   x+=head[0];
  }
  fclose(f);
  
  {
   int rout_w=320,out_w=160,out_h=96,n=4,pos=0,bpos=0,i,j,bkcol=0;
   u8* bmp=(u8*)malloc(rout_w*out_h*4);
   for(y=0;y<out_h;y+=8)
    for(x=0;x<out_w;x+=4)
     {
      u8 c0=videomem[pos];
      u8 c3=video_colorram[pos];
      u8 c1=c0>>4;
      u8 c2=c0&0x0f;
      for(i=0;i<8;i++)
       {
        u8 val=0;
        u8 col=bitmap_image[bpos++];                   
        for(j=0;j<4;j++)
         {
          int shift=2*(3-j);
          int c=0x03<<shift;
          int tc=col&c,rc;
          u8*rgb=bmp+((x+j)*2+(y+i)*rout_w)*n;
          switch(tc>>shift)
           {
            case 0:
             rc=bkcol;
            break;
            case 1:
             rc=c1;
            break;
            case 2:
             rc=c2;
            break;
            case 3:
             rc=c3;
            break;
           }
          memcpy(rgb,c64palette+rc*3,3);
          memcpy(rgb+n,c64palette+rc*3,3); 
          if(n==4)
           rgb[3]=rgb[7]=255;                     
         }
        } 
      pos++;
     }
   stbi_write_png(dest, rout_w, out_h, n, bmp, 0);
   free(bmp);
  }
  return 1;
 }
 else
  return 0;
}

u8 IMG_write(const char*outputbin,u16 ofx,u16 ofy,u16 w,u16 h,u8 bkcol,u8*screen,u8*color,u8*bitmap,u8 up)
{
 FILE*fbin;
 if(imgrooms.mem)
  {
   RIMG r;
   u16 bpos=w*h/8;
   u16 pos=bpos/8;
   strcpy(r.name,outputbin);
   r.bitmap=(u8*)M_alloc(bpos);
   r.color=(u8*)M_alloc(pos);
   r.screen=(u8*)M_alloc(pos);
   memcpy(r.bitmap,bitmap,bpos);
   memcpy(r.color,color,pos);
   memcpy(r.screen,screen,pos);
   r.bpos = bpos; r.pos = pos;
   BUF_safeadd(imgrooms,RIMG,r)
   return 1;
  }
 else
  {
  
  fbin=fopen(outputbin,"wb");
  if(fbin)
   {
    u16 uu,phm;           
    u8  u;
    u8  pbuf[64*1024];
    u16 bpos=w*h/8;
    u16 pos=bpos/8;
    
    u8 head[32],ih=0;
       
    //fwrite(&u,sizeof(u),1,fbin);
    
    uu=w;
    memcpy(&head[ih],&uu,sizeof(uu));ih+=sizeof(uu);
    //fwrite(&uu,sizeof(uu),1,fbin);
    u=(u8)h;
    memcpy(&head[ih],&u,sizeof(u));ih+=sizeof(u);
    //fwrite(&u,sizeof(u),1,fbin);
    
    uu=ofx;
    memcpy(&head[ih],&uu,sizeof(uu));ih+=sizeof(uu);
    //fwrite(&uu,sizeof(uu),1,fbin);
    u=(u8)ofy;
    memcpy(&head[ih],&u,sizeof(u));ih+=sizeof(u);
    //fwrite(&u,sizeof(u),1,fbin);
    
    u=bkcol;
    memcpy(&head[ih],&u,sizeof(u));ih+=sizeof(u);
    u=2|128*up;
    memcpy(&head[ih],&u,sizeof(u));ih+=sizeof(u);
   
    if( (up == storytllr_imageformat_raw) || (up == storytllr_imageformat_huffman) )
    {
     fwrite(screen, 1, pos, fbin);
     fwrite(color, 1, pos, fbin);
     fwrite(bitmap, 1, bpos, fbin);
    }
    else
#if storytllr_imageformat==storytllr_imageformat_huffman
    if (up == storytllr_imageformat_huffman)
    {
     u16 x = 0, w;
     u8  buf[8 * 1024];
     huffpack_start();
     huffpack_add(screen, pos);
     huffpack_add(color, pos);
     huffpack_add(bitmap, bpos);
     huffpack_calc();
     w=huffpack_pack(screen, pos,buf+x);
     x += w;
     w = huffpack_pack(color, pos, buf + x);
     x += w;
     w = huffpack_pack(bitmap, bpos, buf + x);
     fwrite(buf, 1, 256*3, fbin);
     fwrite(buf, 1, w, fbin);
     huffpack_end();
    }
    else
#endif
    if(up==storytllr_imageformat_strippacked)
     {
      u16 used=0,needed=0,n;
      u16 bufsize=320*2;
      u8  tmp[4096],tmp0[256];
      memfile head,data;
      head.mem=tmp0;head.pos=0;
      data.mem=tmp;data.pos=0;
      if(w*h/64<1000)
       bufsize=w*3;
      else
       bufsize=w*4;
           
      if(1)
       {memcpy(head.mem+head.pos,&bufsize,sizeof(bufsize));head.pos+=sizeof(bufsize);}
      else
       fwrite(&bufsize,sizeof(bufsize),1,fbin);
      
      for(n=1;n<pos;n++)
       if(screen[0]==screen[n])
        ;
       else
        break;
      if(n==pos)
       {
        u16 rx=pos;
        if(1)
         {memcpy(head.mem+head.pos,&rx,sizeof(rx));head.pos+=sizeof(rx);}
        else
         fwrite(&rx,sizeof(rx),1,fbin);used+=sizeof(rx);
        rx=1;
        if(1)
         {memcpy(head.mem+head.pos,&rx,sizeof(rx));head.pos+=sizeof(rx);}
        else
         fwrite(&rx,sizeof(rx),1,fbin);used+=sizeof(rx);
        if(1)
         {memcpy(data.mem+data.pos,screen,1);data.pos+=1;}
        else
         fwrite(screen,1,1,fbin);
       }
      else
       used+=emit_window(screen,pos,bufsize,fbin,&head,&data);needed+=pos;
           
      for(n=1;n<pos;n++)
       if(color[0]==color[n])
        ;
       else
        break;
      if(n==pos)
       {
        u16 rx=pos;
        if(1)
         {memcpy(head.mem+head.pos,&rx,sizeof(rx));head.pos+=sizeof(rx);}
        else
         fwrite(&rx,sizeof(rx),1,fbin);used+=sizeof(rx);
        rx=1;
        if(1)
         {memcpy(head.mem+head.pos,&rx,sizeof(rx));head.pos+=sizeof(rx);}
        else
         fwrite(&rx,sizeof(rx),1,fbin);used+=sizeof(rx);
        if(1)
         {memcpy(data.mem+data.pos,color,1);data.pos+=1;}
        else
         fwrite(color,1,1,fbin);
       }
      else
       {
        u8  tmp[4096];
        u16 rx,n,m;
       for(m=n=0;n<pos;n+=2,m++)
        if((color[n]&0xF0)||(color[n+1]&0xF0))
         n=0;
        else
         tmp[m]=color[n]|(color[n+1]<<4);
        needed+=pos;     
        used+=m;
        rx=m;
        if(1)
         {memcpy(head.mem+head.pos,&rx,sizeof(rx));head.pos+=sizeof(rx);}
        else
         fwrite(&rx,sizeof(rx),1,fbin);used+=sizeof(rx);
        if(1)
         {memcpy(head.mem+head.pos,&rx,sizeof(rx));head.pos+=sizeof(rx);}
        else
         fwrite(&rx,sizeof(rx),1,fbin);used+=sizeof(rx);
        if(1)
         {memcpy(data.mem+data.pos,tmp,rx);data.pos+=rx;}
        else
         fwrite(tmp,rx,1,fbin);
       }

      fwrite(head.mem,head.pos,1,fbin);
      fwrite(data.mem,data.pos,1,fbin);

      used+=emit_window(bitmap,bpos,bufsize,fbin,NULL,NULL);needed+=bpos;
       
      used=0;
     }
    else
    if(up==1) 
     {            
      uu=bpos;
      fwrite(&uu,sizeof(uu),1,fbin);
      uu=pos;
      fwrite(&uu,sizeof(uu),1,fbin);
      
      fwrite(bitmap,bpos,1,fbin);     
      fwrite(screen,pos,1,fbin);
      fwrite(color,pos,1,fbin);
      
     }
    else
    if(up==3)
     {
      int y=0,s=0;
      for(y=0;y<h;y+=8)
       {
        s+=hpack(screen,y*w/8/8,w/8,pbuf+s);
        s+=hpack(color,y*w/8/8,w/8,pbuf+s);
        s+=hpack(bitmap,y*w/8,w/8*8,pbuf+s);
        /*p=bitmap+y*w/8;       
        for(i=yy=0;yy<8;yy++)
         for(xx=0;xx<w/8;xx++)
          fline[i++]=p[yy+xx*8];
        s+=hpack(fline,w/8*8,pbuf+s);*/
       } 
      uu=(u16)s;
      fwrite(&uu,sizeof(uu),1,fbin);
      fwrite(pbuf,uu,1,fbin);
     }
     else 
     { 
      int s=0;
      u8  pcol[40*25],usehalf=0;
      
      if(screen)
       uu=hpack(screen,0,pos,pbuf);
      else
       uu=0;

      memcpy(&head[ih],&uu,sizeof(uu));ih+=sizeof(uu);     

      if(usehalf)
       {
        int i;
        for(i=0;i<pos;i+=2)
         pcol[i/2]=(color[i]&0x0F)|((color[i+1]&0x0F)<<8);
        uu=hpack(pcol,0,pos/2,pbuf);
        memcpy(&head[ih],&uu,sizeof(uu));ih+=sizeof(uu);
       }
      else
       {
       uu=hpack(color,0,pos,pbuf);
       memcpy(&head[ih],&uu,sizeof(uu));ih+=sizeof(uu);
       }
      
      //uu=gpack(bitmap,bpos,pbuf);
      uu=hpack(bitmap,0,bpos,pbuf);
      memcpy(&head[ih],&uu,sizeof(uu));ih+=sizeof(uu);
      
      
      fwrite(head,ih,1,fbin);     
      
      if(screen)
       {
        phm=hpack(screen,0,pos,pbuf);
        uu=phm;s+=uu;
        //fwrite(&uu,sizeof(uu),1,fbin);
        fwrite(pbuf,phm,1,fbin);     
       }
      
      if(usehalf)
       phm=hpack(pcol,0,pos/2,pbuf);
      else
       phm=hpack(color,0,pos,pbuf);
      uu=phm;s+=uu;
      //fwrite(&uu,sizeof(uu),1,fbin);
      fwrite(pbuf,phm,1,fbin);
      
      
      phm=hpack(bitmap,0,bpos,pbuf);     
      uu=phm;s+=uu;
      //fwrite(&uu,sizeof(uu),1,fbin);
      fwrite(pbuf,phm,1,fbin);
      
      wholes+=s+6;     
      
     }
    
    fclose(fbin);
    return 1;
   } 
   }
 return 0; 
}
       
u8 FONT_bitmap(const char*png,const char*outputbin,const char*szHPath)                       
{
 int w,h,n;
 u8*data=stbi_load(png, &w, &h, &n, 0);
 if(data)
  {
   u8*charset=(u8*)calloc(128,8);
   u8 buf[64*1024];
   u8 mask[]={128,64,32,16,8,4,2,1};
   u16 phm,c=0,lc=0,x,y,xx,yy;
   u8 zero[4];
   memcpy(zero,data,n);
   
   for(y=0;y<h;y+=8)
    for(x=0;x<w;x+=8)
     {
      int cnt=0;
      for(yy=0;yy<8;yy++)
       {
        u8 bu8=0;
        for(xx=0;xx<8;xx++)
         {
          u8*rgb=data+((x+xx)+(y+yy)*w)*n;
          if(memcmp(rgb,zero,3))
           bu8|=mask[xx];
         }
        charset[c++]= bu8;
        if(bu8==0)
         cnt++;
       } 
      if(cnt!=8)
       lc=c; 
     }
   
   phm=hpack(charset,0,lc,&buf[0]);
   if(phm)
    {
     FILE*f=fopen(outputbin,"wb");
     if(f)
      {
       fwrite(buf,phm,1,f);
       fclose(f);
      } 
     if(1)
      {
      HANDLE hf=file_create(string_getINInamepath("font.h",szHPath));
       char out[256];
       int i;
       sprintf(out,"u8 %s[%d]={","font",phm);
       file_writes(hf,out);
       for(i=0;i<phm;i++)
       {
        if(i)
          file_writes(hf,",");
        if((i%32)==31) file_writes(hf,"\r\n");  
        sprintf(out,"0x%02x",buf[i]);
        file_writes(hf,out);
       }
       sprintf(out,"};\r\n");
       file_writes(hf,out);
       file_close(hf);
      }  
    }
   free(charset);
   stbi_image_free(data);
   return 1;
  }
 else
  {
  ERR("image not found",png);
  return 0; 
  }
}

int fw=3,fh=3,cx=1,cy=1;
int*mulmat;
int tdiv=8,bias,extmul=1;

int applyfilter(u8*data,u8*bit,int x,int y,int w,int h,int n)
{
 int rr=0,gg=0,bb=0,cnt=0,m=0,i,j;
 int whiteadded=0;
 for(j=0;j<fh;j++)
  for(i=0;i<fw;i++)
  {
   if((((x+i-cx)>=0)&&((x+i-cx)<w))&&(((y+j-cy)>=0)&&((y+j-cy)<h)))
    {
    u8*p=data+((x+i-cx)+(y+j-cy)*w)*n;
    rr+=p[0]*mulmat[m]*extmul;
    gg+=p[1]*mulmat[m]*extmul;
    bb+=p[2]*mulmat[m]*extmul;
    cnt++;
    }
   else
   {
    u8*p=data+((x)+(y)*w)*n;
    rr+=p[0]*mulmat[m]*extmul;
    gg+=p[1]*mulmat[m]*extmul;
    bb+=p[2]*mulmat[m]*extmul;
    cnt++;
   }
   m++;
  }
 if(tdiv)
  cnt=tdiv*extmul;
 if(cnt)
 {
 u8*d=bit+(x+y*w)*n;
 u8*p=data+(x+y*w)*n;
 d[0]=max(0,min(255,rr/cnt+bias));
 d[1]=max(0,min(255,gg/cnt+bias));
 d[2]=max(0,min(255,bb/cnt+bias));
 
 if(((d[0]==255)&&(d[1]==255)&&(d[2]==255))&&(!((rr==255)&&(gg==255)&&(bb==255))))
  whiteadded++;
 else
  if(((d[0]==0)&&(d[1]==0)&&(d[2]==0))&&(!((rr==0)&&(gg==0)&&(bb==0))))
  whiteadded++;
 
 if(n==4)
  d[3]=p[3];
 }
 return whiteadded;
}

void image_filter(u8*data,int w,int h,int n,int efx,int modifier)
{
 int x,y,newwhite=0;
 u8*bit=(u8*)calloc(w*h,n);
 switch(efx)
 {
 case 4:
  {
  static int unsharpenmulmat[]=
   {1,4,6,4,1,
   4,16,24,16,4,
   6,24,-476,24,6,
   4,16,24,16,4,
   1,4,6,4,1};    
  mulmat=unsharpenmulmat;
  fw=5;fh=5;
  tdiv=-256-(modifier-1);

  }
  break;
 case 0:
  {
  static int sharpen2[] = { 0,-1, 0, 
                           -1, 5,-1, 
                            0,-1, 0};
  static int sharpenmulmat[]=
   {-1, -1, -1,
    -1, 16, -1,
    -1, -1, -1};
  fw=3;fh=3;cx=1;cy=1;
  sharpenmulmat[4]=16-(modifier-1);
  bias=0;tdiv=0;
  mulmat=sharpenmulmat;
  

  //mulmat=sharpen;
  //tdiv=0+ -1 + 0 + -1 + 5 + -1 + 0 + -1 + 0;
  }
  break;
 case 1:
  {static int contrastmulmat[]={1};
  fw=fh=1;cx=cy=0;  
  mulmat=contrastmulmat;
  tdiv=1;
  bias=-8;
  }
  break;
  case 2:
  {static int contrastmulmat[]={1};
  fw=fh=1;cx=cy=0;  
  mulmat=contrastmulmat;
  tdiv=1;
  bias=8;
  }
  break;
  case 3:
  {
   static int blurtmulmat[]={1, 2, 1,
                             2, 4, 2,
                             1, 2, 1 };
  fw=fh=3;cx=cy=1;  
  mulmat=blurtmulmat;
  tdiv=16;
  bias=0;
  }
  break;
 }

 for(y=0;y<h;y++)
  for(x=0;x<w;x++)
   newwhite+=applyfilter(data,bit,x,y,w,h,n);

 if(0&&((newwhite>20)&&(efx==0)))
  ;
 else
  memcpy(data,bit,w*h*n);
 free(bit);
}

#include "image_en.h"

u8       bLive=0;
imageefx efx;

int colorcmp(u8 c1,u8 c2,u8 c3,int sccnt,u8 oc1,u8 oc2,u8 oc3,int osccnt)
{
 if(sccnt<=osccnt)
  {
   u8  s1[4],s2[4];
   int i,j,fnd;
   s1[0]=c1;s1[1]=c2;s1[2]=c3;
   s2[0]=oc1;s2[1]=oc2;s2[2]=oc3;
   for(fnd=i=0;i<sccnt;i++)
    for(j=0;j<osccnt;j++)
     if(s1[i]==s2[j])
      {fnd++;break;}
   if(fnd==sccnt)
    return 1;
  }
 return 0;
}

int usedcol_compare(const void*a,const void*b)
{
 char*A=(char*)a;
 char*B=(char*)b;
 return B[1]-A[1];
}

int byte_compare(const void*a,const void*b)
{
 u8*A=(u8*)a;
 u8*B=(u8*)b;
 return *A-*B;
}

u8 PNG_converter(const char*png,const char*outputbin,int optimized,const char*roomname,u8 modelwanted)
{
 int  w,h,n;
 u8   forcedbkcol=0,bScaleToFit=0,bHBorder=0,bRBorder=0,bOrderedDither=0,bCRT=0,bCompactColors=1;
 u8   bColorReduce=1,palmode=0,gray=0,reducegrain=0,sharpen=0,unsharpen=0,contrast=0,dither=0,morecontrast=0,dithermethod=dither_floyd,ypos=0;
 u8   bTest=0,ret=0,colorbalance=0;
 int  cl1=-1,cl2=-1,cl3=-1;
 u8   oc1,oc2,oc3;
 char imgbordername[256];
 int  monitor_w=320,monitor_h=200;
 int  osccnt=-1;
 float saturation=0,brightness=0;
 char png1[256],ini[256];
 char filehead[64];
 const char*png2;
 u8*data;
 u8*imgborder=NULL;
 int imgborderw,imgborderh,imgbordern;
 int fileformat=configvalue("image.fileformat",storytllr_imageformat);
 png2=string_gettoken(png,png1,'-');
 if(png2)
  if(strstr(png1,".png")&&strstr(png2,".png"))
   ;
  else
   strcpy(png1,png);

 strcpy(ini,png1);
 if(model==ZXSpectrum)
  strcpy(ini+strlen(ini)-3,"zx.ini");
 else
  strcpy(ini+strlen(ini)-3,"ini");

 model=modelwanted;

 if(model==VGA)
  {palettesize=vgapalettesize;palette=vgapalette;monitor_w=320,monitor_h=200;strcpy(filehead,"_VGA.png");}
 else
 if(model==C64)
  {palettesize=c64palettesize;palette=c64palette;monitor_w=320,monitor_h=200;strcpy(filehead,"_C64.png");}
 else
  if(model==ZXSpectrum)
   {palettesize=zxpalettesize;palette=zxpalette;monitor_w=256,monitor_h=192;strcpy(filehead,"_ZXSpectrum.png");}
  else
   {palettesize=zxpalettesize;palette=zxpalette;monitor_w=22*8,monitor_h=23*8;strcpy(filehead,"_VIC20.png");}

 palmode=(strstr(png,filehead)==NULL)*(1);

 if(optimized&1)
  {
   char output_filename[256];
   strcpy(output_filename,png1);
   strcpy(output_filename+strlen(output_filename)-4,filehead);
   if(file_updateneeded(png1,output_filename))
    ;
   else
    if(file_exists(ini)&&file_updateneeded(ini,output_filename))
     ;
    else
     if(file_updateneeded(png1,outputbin))
      ;
     else
      return 1;
  }

 do
  {
   if(model==VGA)
    ;
   else
   if(palmode)
    {
     dither=configvalue("image.dither",5);
     unsharpen=configvalue("image.unsharpen",2);
     sharpen=configvalue("image.sharpen",1);
     contrast=configvalue("image.contrast",255);
     morecontrast=configvalue("image.morecontrast",1);
     bHBorder=configvalue("image.hborder",16);
     bRBorder=configvalue("image.rborder",0);
     bCRT=configvalue("image.crt",0);
    }

  if(bLive||imageefx_read(&efx,ini))
   {
    sharpen=efx.val[efx_sharpen];
    unsharpen=efx.val[efx_unsharpen];
    contrast=efx.val[efx_contrast];
    morecontrast=efx.val[efx_morecontrast];   
    dither=efx.val[efx_dither];dithermethod=efx.val[efx_dithermethod];   
    saturation=(float)efx.val[efx_saturation]/10.0f;
    brightness=(float)efx.val[efx_brightness]/10.0f;
    ypos=efx.val[efx_ypos];
    cl1=efx.val[efx_cl1];
    cl2=efx.val[efx_cl2];
    cl3=efx.val[efx_cl3];
    colorbalance=efx.val[efx_colorbalance];
   }

  gray=0;reducegrain=0;
  
  if(optimized&2)
   ;
  else
  if(configstring("image.imgborder",imgbordername))
   imgborder=stbi_load(imgbordername, &imgborderw, &imgborderh, &imgbordern, 0);

  data=stbi_load(png1, &w, &h, &n, 0);
  if(data)
   {
    u8* bitmap,*color,*screen,c,*outbitmap;
    u16 palcnt[256],toppalcnt=0,pos=0,bpos=0;
    u8  bkcol;   
    
    //char output_filename[256];
    int rout_w=w,out_w=w/2,out_h=h,x,y,topy=configvalue("image.splity",96);
    int slice_x=0,real_slice_x=0,slice_y=0,slice_w=0,slice_h=0;
    unsigned char* output_data;     

    memset(palcnt,0,sizeof(palcnt));

    if(optimized&2)
     topy=h;
    
    if(png2&&*png2)
     {
      int w2,h2,n2;
      u8*data2=NULL;
      char nm[256];
      strcpy(nm,png1);
      x=strlen(nm);
      while(x--)
       if((nm[x]=='\\')||(nm[x]=='/'))
        {
         strcpy(nm+x+1,png2);        
         break;       
        }      
      if(x==-1)
       strcpy(nm,png2);
      data2=stbi_load(nm, &w2, &h2, &n2, 0);
      if(data2)
       {
        int del=0,fx=-1,fy=-1,lx=0,ly=0;
        if((w==w2)&&(h==h2))
         {
          int diff=0;
          for(x=0;x<w;x+=8)
           {
            int sequ=0,aequ=0;
            for(y=0;y<h;y+=8)          
             {
              int equ=0,xx,yy;
              for(yy=0;yy<8;yy++)
               for(xx=0;xx<8;xx++)
                {
                 u8*rgb1=data+((x+xx)+(y+yy)*w)*n;
                 u8*rgb2=data2+((x+xx)+(y+yy)*w)*n2;
                 if(memcmp(rgb1,rgb2,n)==0)
                  equ++;
                }  
              aequ++;  
              if(equ==8*8)
               sequ++;              
             }
           if(sequ==aequ)
            {
             if(lx==0) lx=x;
             if(diff==0) fx=x;
            }   
           else
            {diff++;lx=0;}
           }  
          diff=0; 
          for(y=0;y<h;y+=8)                      
           {
            int sequ=0,aequ=0;
            for(x=0;x<w;x+=8)          
             {
              int equ=0,xx,yy;
              for(yy=0;yy<8;yy++)
               for(xx=0;xx<8;xx++)
                {
                 u8*rgb1=data+((x+xx)+(y+yy)*w)*n;
                 u8*rgb2=data2+((x+xx)+(y+yy)*w)*n;
                 if(memcmp(rgb1,rgb2,n)==0)
                  equ++;
                }  
              aequ++;  
              if(equ==8*8)
               sequ++;              
             }
           if(sequ==aequ)
            {
             if(ly==0) ly=y;
             if(diff==0)  fy=y;
            }   
           else
            {diff++;ly=0;}
           }  
         }
        stbi_image_free(data2);
        real_slice_x=slice_x=fx;slice_y=fy;
        slice_w=lx-fx;slice_h=ly-fy;
        //stbi_write_png("c:\\tmp\\prova.png", w, h, n, data, 0);
       }
     }
     
    if((w>monitor_w)||(h>monitor_h)||(h>topy))
     {
      int nw=w,nh=h;
      u8*output_data;
      
      if(bScaleToFit)
       {
        if(nw>monitor_w)
         {
          nw=monitor_w;
          nh=h*nw/w;
         }
        if(h>topy)
         {
          nh=topy;
          nw=w*nh/h;
         }
       }
      else
       if(nw>monitor_w)
        {
         nw=monitor_w;
         nh=h*nw/w;

        }
       else     
        if(h>topy)
         {
          nh=topy;
          nw=w*nh/h;
         }

      output_data=(u8*)malloc(nw*nh*n); 
     
      stbir_resize(data, w, h, 0, output_data, nw, nh, 0, STBIR_TYPE_UINT8, n, STBIR_ALPHA_CHANNEL_NONE, 0, STBIR_EDGE_CLAMP, STBIR_EDGE_CLAMP, STBIR_FILTER_DEFAULT, STBIR_FILTER_DEFAULT, STBIR_COLORSPACE_LINEAR, NULL);     

      if(nw%16) 
       {
        int nrm=((nw/16)+1)*16;
        int ox=nrm-nw;
        memset(data,0,nrm*nh*n);
        for(y=0;y<nh;y++)
         memcpy(data+(ox+y*nrm)*n,output_data+y*nw*n,nw*n);
        nw=nrm;
       }
      else 
       memcpy(data,output_data,nw*nh*n);
      free(output_data);

      if(nh>topy)
       {
        int oy=(nh-topy)-ypos;
        output_data=(u8*)calloc(nw*(topy+1),n); 
        if(oy<0) oy=0;
        if(oy>(nh-topy)) oy=(nh-topy);
        memcpy(output_data,data+(oy*nw)*n,nw*topy*n);
        free(data);
        data=output_data;
        nh=topy;
       }

      w=nw;h=nh;
      if(w<monitor_w)
       {
        int ox=(monitor_w-w)/2;
        nw=monitor_w;
        output_data=(u8*)calloc(nw*h,n); 
        for(y=0;y<nh;y++)
         memcpy(output_data+(ox+y*nw)*n,data+y*w*n,w*n);
        free(data);
        data=output_data;
        w=monitor_w;
       }
     }
    
    if(w==monitor_w)
     {
      x=0;
      while(x<monitor_w/2)
       {
        for(y=0;y<h;y++)
         {
          u8*rgbL=data+(x+y*w)*n;
          u8*rgbR=data+((w-x-1)+y*w)*n;
          if((rgbL[0]==0)&&(rgbL[1]==0)&&(rgbL[2]==0)&&(rgbR[0]==0)&&(rgbR[1]==0)&&(rgbR[2]==0))
           ;
          else
           break;
         }
        if(y==h)
         x++; 
        else
         break; 
       } 
     }  
    else
     if(w<monitor_w)
      {
       int ox=(monitor_w-w)/2;
       int nw=monitor_w;
       output_data=(u8*)calloc(nw*h,n); 
       for(y=0;y<h;y++)
        memcpy(output_data+(ox+y*nw)*n,data+y*w*n,w*n);
       free(data);
       data=output_data;
       w=monitor_w;
      }

    if(colorbalance)
     image_COLORBALANCE(data,w,h,n,colorbalance-1,colorbalance-1,1);

    if(contrast)
     {
      int c;      
      if(contrast==255)
       image_CLAHE(data,w,h,n,cl1,cl2,cl3);
      else
       {
       c=contrast;
       while(c--)
        image_filter(data,w,h,n,1,contrast);
       }
     }

    if(morecontrast>0)
     image_MORECONTRAST(data,w,h,n,morecontrast);      
    if(unsharpen>0)
     image_filter(data,w,h,n,4,unsharpen);
    if(sharpen>0)
     image_filter(data,w,h,n,0,sharpen);
    if(brightness!=0.0f)
     image_BRIGHTNESS(data,w,h,n,brightness);
    if(saturation!=0.0f)
     image_SATURATION(data,w,h,n,saturation);
  
   if(1)
    {
     if(imgborder)
      {
       for(x=0;x<w;x++)
        for(y=0;y<h;y++)
         {
          u8*rgb1=data+(x+y*w)*n;
          if((x<imgborderw)&&(y<imgborderh))
           {
            u8*rgb2=imgborder+(x+y*imgborderw)*imgbordern;
            if(rgb2[3])
             memcpy(rgb1,rgb2,n);
           }
         }
       stbi_image_free(imgborder);
      }
     else
      {
      if(bHBorder)
      {
       for(y=0;y<h;y++)
        {
         memset(data+y*w*n,0,bHBorder*n);
         memset(data+(w-bHBorder+y*w)*n,0,bHBorder*n);
        }
      }
     if(bRBorder)
      {
       double dbrd=12,sl=dbrd/(h/3.0);
       for(y=0;y<h;y++)
        {
         int brd=0;
         if(y<h/2)
          dbrd-=sl;
         else
          dbrd+=sl;
         if(dbrd>=1)
          brd=(int)dbrd;
         if(brd)
          {
          memset(data+(bHBorder+y*w)*n,0,brd*n);
          memset(data+(w-bHBorder-brd+y*w)*n,0,brd*n);
          }
        }    
      }
      }
    if(bCRT)
     if(bCRT==2)
      {
       for(y=0;y<h;y+=2)
        memcpy(data+((y+1)*w)*n,data+((y)*w)*n,w*n);
      }
     else
      {
       for(y=0;y<h;y+=2)
        memset(data+(y*w)*n,0,w*n);
      }
    }
     
    if(model==C64)
     {rout_w=w;out_w=w/2;out_h=h;}
    else
     {rout_w=w;out_w=w;out_h=h;}
    
    if(model==ZXSpectrum)
     if(abs(out_h-64)<abs(out_h-128))
      out_h=64;
     else
      out_h=128;

    output_data = (unsigned char*)malloc(out_w * out_h * n);     
    
    if(gray)
     image_GRAY(data,w,h,n);       

    if(reducegrain)
     {
      int x,y;
      for(y=0;y<h;y++)
       for(x=0;x<w;x+=4)
        {
         u8*rgb=data+(x+y*w)*n;
         rgb[0]=rgb[n]=rgb[n*2]=rgb[n*3];
         rgb[0+1]=rgb[n+1]=rgb[n*2+1]=rgb[n*3+1];
         rgb[0+2]=rgb[n+2]=rgb[n*2+2]=rgb[n*3+2];
        }      
      for(y=0;y<h;y+=2)
       {
        memcpy(data+(y+1)*w*n,data+y*w*n,w*n);
        memcpy(data+(y+2)*w*n,data+y*w*n,w*n);
        memcpy(data+(y+3)*w*n,data+y*w*n,w*n);
       }
     }

    if(png2&&*png2)
     {
      int w2,h2,n2;
      u8*data2=NULL;
      char nm[256];
      strcpy(nm,png1);
      x=strlen(nm);
      while(x--)
       if((nm[x]=='\\')||(nm[x]=='/'))
        {
         strcpy(nm+x+1,png2);        
         break;       
        }      
      if(x==-1)
       strcpy(nm,png2);
      data2=stbi_load(nm, &w2, &h2, &n2, 0);
      if(data2)
       {
        int del=0,fx=-1,fy=-1,lx=0,ly=0;
        if((w==w2)&&(h==h2))
         {
          int diff=0;
          for(x=0;x<w;x+=8)
           {
            int sequ=0,aequ=0;
            for(y=0;y<h;y+=8)          
             {
              int equ=0,xx,yy;
              for(yy=0;yy<8;yy++)
               for(xx=0;xx<8;xx++)
                {
                 u8*rgb1=data+((x+xx)+(y+yy)*w)*n;
                 u8*rgb2=data2+((x+xx)+(y+yy)*w)*n2;
                 if(rgb2[3])
                  memcpy(rgb1,rgb2,n);
                }  
             }
           }             
         }
        stbi_image_free(data2);
       }
     }

    if(bLive)
     stbi_write_png("tmp/full.png", w, h, n, data, 0);
       
    memset(palcnt,0,sizeof(palcnt));

    if(palmode==0)    
     {
      for(y=0;y<out_h;y++)
       for(x=0;x<out_w;x++)
       {
        u8*rgbS=data+((x*2)+y*w)*n;
        u8*rgbD=output_data+(x+y*out_w)*n,r;      
        for(r=0;r<n;r++)
         //rgbD[r]=min(rgbS[r],rgbS[r+n]);
         //rgbD[r]=(rgbS[r]+rgbS[r+n])/2;
         rgbD[r]=rgbS[r];
       }
     }
    else
     stbir_resize(data, w, h, 0, output_data, out_w, out_h, 0, STBIR_TYPE_UINT8, n, STBIR_ALPHA_CHANNEL_NONE, 0, STBIR_EDGE_CLAMP, STBIR_EDGE_CLAMP, STBIR_FILTER_DEFAULT, STBIR_FILTER_DEFAULT, STBIR_COLORSPACE_LINEAR, NULL);     

    //stbir_resize(data, w, h, 0, output_data, out_w, out_h, 0, STBIR_TYPE_UINT8, n, STBIR_ALPHA_CHANNEL_NONE, 0, STBIR_EDGE_CLAMP, STBIR_EDGE_CLAMP, STBIR_FILTER_DEFAULT, STBIR_FILTER_DEFAULT, STBIR_COLORSPACE_LINEAR, NULL);
    stbi_image_free(data);
    bitmap=calloc(rout_w*out_h,1);
    if(model==C64)
     {
      outbitmap=calloc(rout_w*out_h,1);
      screen=calloc((out_w/4)*(out_h/8),1);
      color=calloc((out_w/4)*(out_h/8),1);   
     }
    else
     if(model==VGA)
     {
      outbitmap=calloc(rout_w*out_h,1);
      screen=NULL;
      color=NULL;   
     }
     else
     {
      outbitmap=calloc((rout_w/8)*out_h,1);
      screen=NULL;
      color=calloc((rout_w/8)*(out_h/8),1);   
     }

    if(dither)
     image_DITHER(output_data,out_w,out_h,n,palette,palettesize,dithermethod,dither);

    if(bColorReduce)
     {
      int dith_err[3]={0,0,0};
      for(y=0;y<out_h;y++)
      {     
       for(x=0;x<out_w;x++)
       {
        u8*rgb=output_data+(x+y*out_w)*n;
        u8 idx=findpalette(rgb,palette,palettesize,palmode);        
        bitmap[x+y*out_w]=idx;
        palcnt[idx]++;
        memcpy(rgb,palette+idx*3,3);
       }
      }
     }
    if(forcedbkcol!=255)
     bkcol=forcedbkcol;
    else
    for(c=0;c<palettesize;c++)
     if(palcnt[c]>toppalcnt)
      {
       toppalcnt=palcnt[c];
       bkcol=c;
      }
    oc1=oc2=oc3=0;osccnt=-1;
    if(model==VGA)
     {
     }
    else
    if(model==ZXSpectrum)
     {
      int p[8]={128,64,32,16,8,4,2,1},cpos=0,bpos=0,fnd=0;
      for(y=0;y<out_h;y+=8)
       {
        for(x=0;x<out_w;x+=8)
         {
          int i,j,sccnt=0,err=0;
          u8  lcolcnt[48]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
          u8  usedcol[16*2+2],c1,c2;
          for(i=0;i<8;i++)
           for(j=0;j<8;j++)
            {
             u8 col=bitmap[(x+j)+(y+i)*out_w];
             if(col>=16)
              err++;
             lcolcnt[col]++;
            }
          for(i=0;i<16;i++)
           if(lcolcnt[i])
            {
             usedcol[sccnt*2+0]=i;
             usedcol[sccnt*2+1]=lcolcnt[i];
             sccnt++;
            }
          if(sccnt>=16)
           err++;
          usedcol[sccnt*2+0]=0;
          usedcol[sccnt*2+1]=0;
          if(sccnt>1)
           qsort(usedcol,sccnt,sizeof(usedcol[0])*2,usedcol_compare);

          c1=usedcol[0];
          c2=usedcol[2];

          color[cpos++]=c2|(c1<<3);
          for(i=0;i<8;i++)
           {
            u8 mask=0,odd=0;
            for(j=0;j<8;j++)
             {
              u8 col=bitmap[(x+j)+(y+i)*out_w];
              if((col!=c1)&&(col!=c2))
               {
                u8 shortpalette[3*2],cols[4]={c1,c2};
                memcpy(shortpalette+0*3,palette+c1*3,3);
                memcpy(shortpalette+1*3,palette+c2*3,3);
                col=findpalette(palette+col*3,shortpalette,sizeof(shortpalette)/3,palmode);
                col=cols[col];
               }
              if(col==c1)
               ;
              else
              if(col==c2)
               {mask|=p[j];fnd++;}         
              else
               odd++;
             }
            outbitmap[bpos++]=mask;
           }
         }
       }
      y=0;
      y=0;
     }
    else
    if(model==C64)
     {
     for(y=0;y<out_h;y+=8)
      {
       for(x=0;x<out_w;x+=4)
        {
         int i,j,sccnt=0;
         u8 lcolcnt[48]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
         u8 usedcol[16];
         u8 c1=255,c2=255,c3=255,vc1=0,vc2=0,vc3=0,err=0,cloneprev=0,a[3];
         memset(lcolcnt,0,sizeof(lcolcnt));
         for(i=0;i<8;i++)
          for(j=0;j<4;j++)
          {
           u8 col=bitmap[(x+j)+(y+i)*out_w];
           if(col>=16)
             err++;
           lcolcnt[col]++;
          }
         for(i=0;i<16;i++)
          if(i!=bkcol)
           if(lcolcnt[i])
            usedcol[sccnt++]=i;
         if(sccnt>3)
          {
           int k;
           k=0;
          }
         else
          if(bCompactColors)
          if(pos&&sccnt)
           if(colorcmp(usedcol[0],usedcol[1],usedcol[3],sccnt,oc1,oc2,oc3,osccnt))
            cloneprev=1;
         if(gray)
         {
          c1=11;;c2=12;c3=15;
          screen[pos]=(c1<<4)|c2;
          color[pos]=c3;
         }
         else
         if(cloneprev)
         {
          c1=oc1;c2=oc2;c3=oc3;
          screen[pos]=screen[pos-1];
          color[pos]=color[pos-1];
         }
         else
          {
          for(i=0;i<16;i++)
           if(i!=bkcol)
            if(lcolcnt[i])
             {
              if(lcolcnt[i]>=vc1)
              {
               vc3=vc2;c3=c2;
               vc2=vc1;c2=c1;
               vc1=lcolcnt[i];c1=i;
              }
              else
               if(lcolcnt[i]>=vc2)
                {
                 vc3=vc2;c3=c2;
                 vc2=lcolcnt[i];c2=i;
                }
               else
                if(lcolcnt[i]>=vc3)
                {
                 vc3=lcolcnt[i];c3=i;
                }
             }
          if(c1>15) 
           c1=oc1;
          if(c2>15) 
           c2=oc2;
          if(c3>15) 
           c3=oc3;
          
          a[0]=c1;a[1]=c2;a[2]=c3;
          qsort(a,3,sizeof(a[0]),byte_compare);
          c1=a[0];c2=a[1];c3=a[2];

          oc1=c1;oc2=c2;oc3=c3;osccnt=min(3,sccnt);
          screen[pos]=(c1<<4)|c2;
          color[pos]=c3;
          }
         pos++;

         for(i=0;i<8;i++)
          for(j=0;j<4;j++)
           {
            u8 col=bitmap[(x+j)+(y+i)*out_w];
            if(col==bkcol)
             ;
            else
             if((col==c1)||(col==c2)||(col==c3))
              ;
             else
              {
               u8 shortpalette[3*4],cols[4]={bkcol,c1,c2,c3};
               memcpy(shortpalette+0*3,palette+bkcol*3,3);
               memcpy(shortpalette+1*3,palette+c1*3,3);
               memcpy(shortpalette+2*3,palette+c2*3,3);
               memcpy(shortpalette+3*3,palette+c3*3,3);

               col=findpalette(palette+col*3,shortpalette,sizeof(shortpalette)/3,palmode);
               bitmap[(x+j)+(y+i)*out_w]=cols[col];

               {
                u8*rgb=output_data+((x+j)+(y+i)*out_w)*n;
                memcpy(rgb,palette+cols[col]*3,3);
               }
              }
           }

         for(i=0;i<8;i++)
         {
          u8 val=0,shift;
          for(j=0;j<4;j++)
           {
            u8 col=bitmap[(x+j)+(y+i)*out_w],mask;
            if(col==bkcol)
             mask=0;
            else
             if(col==c1)
              mask=1;
             else
             if(col==c2)
              mask=2;
             else
             if(col==c3)
              mask=3;
             else
              mask=0;
            shift=2*(3-j);
            val|=mask<<shift;
           }
          outbitmap[bpos]=val;
          bpos++;
         }
        }
      }
      }

    if(1)
     {
      u8*bmp=(u8*)calloc(rout_w*out_h,n);
      char output_filename[256];
      int i,j,fnd=0;
      u16 bpos=0,pos=0;
      if(model==VGA)
       memcpy(bmp,output_data,rout_w*out_h*n);
      else
      if(model==ZXSpectrum)
       {        
        int p[8]={128,64,32,16,8,4,2,1};
        for(y=0;y<out_h;y+=8)
         for(x=0;x<out_w;x+=8)
          {
           u8 col=color[pos++];           
           u8 c2=col&0x7;
           u8 c1=(col>>3)&0x7;
           for(i=0;i<8;i++)
           {
            u8 mask=outbitmap[bpos++];              
            if(mask)
             fnd++;
            for(j=0;j<8;j++)
             {
              u8*rgb=bmp+((x+j)+(y+i)*rout_w)*n;
              if((mask&p[j])==0)
               memcpy(rgb,palette+c1*3,3);
              else
               memcpy(rgb,palette+c2*3,3);
              rgb[3]=255;
             }
           }
          }
       }
      else
      if(model==C64)
       {
        for(y=0;y<out_h;y+=8)
         for(x=0;x<out_w;x+=4)
          {
           u8 c0=screen[pos];
           u8 c3=color[pos];
           u8 c1=c0>>4;
           u8 c2=c0&0x0f;
           for(i=0;i<8;i++)
            {
             u8 val=0;
             u8 col=outbitmap[bpos++];                   
             for(j=0;j<4;j++)
              {
               int shift=2*(3-j);
               int c=0x03<<shift;
               int tc=col&c,rc;
               u8*rgb=bmp+((x+j)*2+(y+i)*rout_w)*n;
               switch(tc>>shift)
                {
                 case 0:
                  rc=bkcol;
                 break;
                 case 1:
                  rc=c1;
                 break;
                 case 2:
                  rc=c2;
                 break;
                 case 3:
                  rc=c3;
                 break;
                }
               memcpy(rgb,palette+rc*3,3);
               memcpy(rgb+n,palette+rc*3,3); 
               if(n==4)
                rgb[3]=rgb[7]=255;                     
              }
             } 
           pos++;
          }
       }
      if(bLive)
       if(model==ZXSpectrum)
        stbi_write_png("tmp/ZXSpectrum.png", rout_w, out_h, n, bmp, 0);
       else
        stbi_write_png("tmp/c64.png", rout_w, out_h, n, bmp, 0);
      else
       if(palmode==0)
        ;
       else
        {
         char fn[256];        
         strcpy(output_filename,png);
         strcpy(output_filename+strlen(output_filename)-4,filehead);

         if(model==VGA)
          ;
         else
          stbi_write_png(output_filename, rout_w, out_h, n, bmp, 0);

         if(roomname&&*roomname)
          {
           if(model==VGA)
            strcpy(fn,"png\\VGA\\");
           else
           if(model==ZXSpectrum)
            strcpy(fn,"png\\ZXSpectrum\\");
           else
            if(model==C64)
             strcpy(fn,"png\\C64\\");
            else
             strcpy(fn,"png\\VIC20\\");
           strcat(fn,roomname+(*roomname=='$'));strcat(fn,".png");          
           stbi_write_png(fn, rout_w, out_h, n, bmp, 0);
           if(model==VGA)
            {
             //u8* out=(u8*)malloc(rout_w*out_h*3);
             //int size=hpack(bitmap,0,rout_w*out_h,out);
             strcpy(fn,"vga_");
             strcat(fn,outputbin);strcat(fn,".png");          
             stbi_write_png(fn, rout_w, out_h, n, bmp, 0);
            }
          }
        }
      free(bmp);
     }
     
    free(output_data);

    if(model==ZXSpectrum)
     {
      u8*outbitmap2=calloc((rout_w/8)*out_h,1);
      int y,x,n=0;

      for(y=0;y<out_h;y++)
       for(x=0;x<out_w/8;x++)       
        outbitmap2[n++]=outbitmap[x*8+(y&7)*256+(y>>3)];

      memcpy(outbitmap,outbitmap2,(rout_w/8)*out_h);

      free(outbitmap2);
     }
    
    if(model==VGA)
     ;
    else
    if(slice_w&&slice_h)
     {
      int ps=0,bps=0;
      for(y=0;y<slice_h/8;y++)
       {
        int obps=real_slice_x+((slice_y+y*8)*rout_w)/8,ops=obps/8;
        for(x=0;x<slice_w/8;x++,ps++,ops++,bps+=8,obps+=8)
         {
          screen[ps]=screen[ops];
          color[ps]=color[ops];
          memcpy(&outbitmap[bps],&outbitmap[obps],8);
         }
       } 
      IMG_write(outputbin,slice_x,slice_y,slice_w,slice_h,bkcol,screen,color,outbitmap,fileformat);  
     }
    else       
     IMG_write(outputbin,slice_x,slice_y,rout_w,out_h,bkcol,screen,color,outbitmap,fileformat);

    
    free(screen); 
    free(color);
    free(bitmap);       
    ret=1;
   }  
  else 
   {
   ERR("image not found",png);
   ret=0; 
   }
  }
 while(bTest);
 return ret;
}                       
#endif




int total;

void writeh(HANDLE hf,BUF*sz,const char*name)
{
 char out[256];
 int  i;
 total+=sz->c;
 sprintf(out,"u8 %s[%d]={",name,sz->c);
 file_writes(hf,out);

 for(i=0;i<sz->c;i++)
 {
  if(i) file_writes(hf,",");
  if((i%32)==31) file_writes(hf,"\r\n");
  sprintf(out,"0x%02x",sz->mem[i]);
  file_writes(hf,out);  
 }

 file_writes(hf,"};\r\n\r\n");
}

void writeh16(HANDLE hf,BUFW*sz,const char*name)
{
 char out[256];
 int  i;
 total+=sz->c;
 sprintf(out,"u16 %s[%d]={",name,sz->c);
 file_writes(hf,out);

 for(i=0;i<sz->c;i++)
 {
  if(i) file_writes(hf,",");
  if((i%32)==31) file_writes(hf,"\r\n");
  sprintf(out,"0x%04x",sz->mem[i]);
  file_writes(hf,out);  
 }

 file_writes(hf,"};\r\n\r\n");
}

void writeh32(HANDLE hf, BUFDW*sz, const char*name)
{
 char out[256];
 int  i;
 total += sz->c;
 sprintf(out, "u32 %s[%d]={", name, sz->c);
 file_writes(hf, out);

 for (i = 0; i < sz->c; i++)
 {
  if (i) file_writes(hf, ",");
  if ((i % 32) == 31) file_writes(hf, "\r\n");
  sprintf(out, "0x%04x", sz->mem[i]);
  file_writes(hf, out);
 }

 file_writes(hf, "};\r\n\r\n");
}


void bwriteh(HANDLE hf,BUF*sz,const char*name)
{
 char out[256];
 int  i;
 total+=sz->c;
 sprintf(out,"u8 %s[%d]={",name,sz->c);
 file_writes(hf,out);

 for(i=0;i<sz->c;i++)
 {
  if(i) file_writes(hf,",");
  if((i%32)==31) file_writes(hf,"\r\n");
  sprintf(out,"0x%02x",sz->mem[i]);
  file_writes(hf,out);  
 }

 file_writes(hf,"};\r\n\r\n");
}

void BUFC_add(BUFC*sz,const char*what)
{
 int l=(int)strlen(what);
 BUF_addspace((*sz),char,(l+1))
 strcpy(sz->mem+sz->c,what);
 sz->c+=l; 
}



void zeromap(BUFC*sz)
{
 int i;
 for(i=0;i<sz->c;i++)
  if(sz->mem[i]=='~')
   sz->mem[i]=0;
}

u8 maxc=0,minc=0;

char pettrans(char c)
{
 if((c==13)||(c==10))
   c=31;
  else
  if((c>='0')&&(c<='9'))
   c=c-'0'+48;
  else
  if((c>='A')&&(c<='Z'))
   c=c-'A'+65;
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
       if(c==';')
      c=59;
     else
      if(c==':')
       c=58;
      else
       if(c=='(')
      c=40;
     else
      if(c==')')
       c=41;
      else
       if(c=='"')
       c=34;
      else
       if(c=='-')
       c=45;
      else
      if(c=='?')
      c=63;
     else
      if(c=='!')
       c=33;
      else
      if(c=='>')
      c=62;
     else
     if(c=='[')
      c=27;
     else
     if(c==']')
      c=29;
     else
      if(c=='_')
       c=108;
      else
       c=c;
 if(c>maxc)
  maxc=c;
 if(c<minc)
  minc=c;
 return c;
}

void petmapbuf(char*sz,int size)
{
 int i;
 for(i=0;i<size;i++)
  sz[i]=pettrans(sz[i]);
}

u16 petmapstring(char*sz)
{
 u16 i=0;
 while (sz[i])
 {
  sz[i] = pettrans(sz[i]);
  i++;
 }
 return i;
}

void petmap(BUFC*sz)
{
 petmapbuf(sz->mem,sz->c);
}

u8 bADDSPACE=0;

int pretokenize(const char*sz,dict*sKEYS,u16*seq,int way)
{
 int iseq=0;
 while(*sz)
 {
  char tkn[256];
  int  i=0,id;
  if(*sz=='\\')
   {
    tkn[i++]=*sz++;
    tkn[i++]=*sz++;
   }
  else
  if(cIsCharIn(*sz," ()-.,:;!?\"'\n"))
   tkn[i++]=*sz++;
  else
  while(*sz&&(!cIsCharIn(*sz," ()-.,:;!?\\\"\n")))
   tkn[i++]=*sz++;
  
  if(bADDSPACE||((way==17)&&sDICT_addspace)) if(*sz==' ') tkn[i++]=*sz++;
  
  tkn[i]=0;
  if(way==17)
   {
    if(i>=sDICT_fixedlen)
     id= dict_add(sKEYS,tkn);
   }
  else
   {
    id= dict_add(sKEYS,tkn);
   //if(*sz==' ')
   // sz++;
    seq[iseq++]=(u16)id;
   }
 }
 return iseq;
}

int tokenize(const char*sz,dict*sKEYS,u8*seq)
{
 int iseq=0;
 while(*sz)
 {
  char tkn[256];
  int  i=0,id;
  if(*sz=='\\')
   {
    tkn[i++]=*sz++;
    tkn[i++]=*sz++;
   }
  else
  if(cIsCharIn(*sz," ()-.,:;!?\"'\n"))
   tkn[i++]=*sz++;
  else
  while(*sz&&(!cIsCharIn(*sz," ()-.,:;!?\\\"\n")))
   tkn[i++]=*sz++;
  
  if(bADDSPACE) if(*sz==' ') tkn[i++]=*sz++; 
   
  tkn[i]=0;
  id=1+dict_find(sKEYS,tkn);
  //if(*sz==' ')
  // sz++;
  if(id<128)
   seq[iseq++]=(u8)id;
  else
   {    
    seq[iseq++]=(u8)128|(id>>8); 
    seq[iseq++]=id&0xFF;
   }
 }
 seq[iseq++]=0;
 return iseq;
}

int idict=0,idictidx=0;
unsigned short dictidx[2048],dictpos[2048],dictlen[2048];
unsigned char  dicttext[8192];

int writedictionary(dict*sKEYS)
{
 int i=0,bSORT=1;
 if(bSORT)
  {  
   dict_Sort(sKEYS,_dict_sortbystring_); 
   while(i<sKEYS->nstrings)
    {
     int j=1;
     if((i+j<sKEYS->nstrings)&&(memcmp(sKEYS->str+sKEYS->idx[i+j-1],sKEYS->str +sKEYS->idx[i+j],strlen(sKEYS->str +sKEYS->idx[i+j-1]))==0))
      j++;
     memcpy(dicttext+idict,sKEYS->str +sKEYS->idx[i+j-1],strlen(sKEYS->str +sKEYS->idx[i+j-1]));
     idict+=strlen(sKEYS->str +sKEYS->idx[i+j-1]);
     i+=j;
    }
  }  
 dict_Sort(sKEYS,_dict_sortbycounterreverse_);  
 for(i=0;i<sKEYS->nstrings;i++)
 {
  const char*s=sKEYS->str +sKEYS->idx[i];
  int l=strlen(s);
  if(bSORT)
   {
   u16 j=0,err=1;
   for(j=0;j<idict-l;j++)
    if(memcmp(dicttext+j,s,l)==0)
     {
      dictidx[idictidx]=j;
      dictlen[idictidx]=(u8)l;
      idictidx++;    
      err=0;
      break;
     } 
   if(err)
    err++;  
   }
  else
   {
    dictidx[idictidx]=idict;
    dictlen[idictidx]=(u8)l;
    memcpy(dicttext+idict,s,l);
    petmapbuf(dicttext+idict,l);
    idict+=l;
    idictidx++;    
   } 
 }
 if(bSORT)
  {
   petmapbuf(dicttext,idict);
   return idict+idictidx*3;
  } 
 else
  return idict+idictidx*3;
}

int getDICTREF(const char*szTXT, int*len);
int prepack(dict*sMSG,dict*sKEYS,dict*sCKEYS,int way)
{
 int    i,wlen=0,slen=0,sync=0;
 u16   seq[8192];
 for(i=0;i<sMSG->nstrings;i++)
 {
  const char*s=sMSG->str +sMSG->idx[i];
  slen+=strlen(s);
  if(way==17)
   wlen+=pretokenize(s,sKEYS,&seq[0],way);
  else
  if((way==1)||((bSPACEADD!=0)&&((way==4)||(way==5))))
   wlen+=pretokenize(s,sKEYS,&seq[0],way)*2;
  else
   if(FIXED_NGRAM==MAX_FIXED_NGRAM)
    {
     int n=0,l=strlen(s),nl;   
     while(n<l-MAX_FIXED_NGRAM)
      if(getDICTREF(s+n,&nl)!=-1)
       n+=nl;
      else
       {
        char ss[32];
        memcpy(ss,s+n,MAX_FIXED_NGRAM);ss[MAX_FIXED_NGRAM]=0;
        if(dict_find(sCKEYS,ss)!=-1)
         n+=MAX_FIXED_NGRAM;
        else
         {
         dict_add(sKEYS,ss);
          if(sync)
           n+=MAX_FIXED_NGRAM;
          else
           n++;
         }
       }
    }
   else
    {  
    int n,l=strlen(s);   
    for(n=0;n<l-MAX_FIXED_NGRAM;n++)
     {
      int j,minimal=0;
      if(sCKEYS)
       for(j=FIXED_NGRAM;j<=MAX_FIXED_NGRAM;j++)
       if(n<l-j)
        {
         char ss[32];
         memcpy(ss,s+n,j);ss[j]=0;
         if((ss[0]==10)&&(ss[1]=='F')&&(ss[2]==0))
          *ss=10;
         if(dict_find(sCKEYS,ss)!=-1)
          minimal=j;        
        }
      if(minimal>0)
       n+=minimal-1;
      else
       for(j=FIXED_NGRAM;j<=MAX_FIXED_NGRAM;j++)
        if(n<l-j)
         {
          char ss[32];
          memcpy(ss,s+n,j);ss[j]=0;
          if((ss[0]==10)&&(ss[1]=='F')&&(ss[2]==0))
           *ss=10;
          dict_add(sKEYS,ss);
         }
     }
     }
  //slen+=strlen(s);
  //wlen+=tokenize(s,sKEYS,&seq[0])*2;
 }
 return wlen;
}

int ngram=3;

int two_compare(const void*a,const void*b)
{
 return memcmp(a,b,ngram);
}

int twopack(char*szTXT,u8*seq)
{
 int i=0,j=0;
 //petmapbuf(szTXT,strlen(szTXT));
 while(szTXT[i])
  {
   u8*fnd=(u8*)bsearch(szTXT+i, dicttext,idict/ngram,ngram,two_compare);
   if(fnd)
    {
     seq[j++]=128+(fnd- dicttext)/ngram;
     i+=2;
    } 
   else 
    seq[j++]=szTXT[i++];
  }
 seq[j++]=0;
 return j; 
}

#define code_dictreference  93
#define start_packedcouples (code_dictreference+2)

void minimalunpack(char*szTXT,char*szUTXT)
{
 int i=0,k=0,mask=0;
 if(bSPACEADD==0)
  mask=0x7f;
 else
  mask=0x3f; 
 while(szTXT[i])
  {
   u8 p=szTXT[i],len;
   if((p==code_dictreference)||(p==code_dictreference+1))
    {          
     const char*s;
     int        ln;

     i++;

     if(p==code_dictreference+1)
      p=szTXT[i++]-1;      
     else
      p=0;

     s=sDICT.str +sDICT.idx[p];
     ln=strlen(s);

     memcpy(szUTXT+k,s,ln);
     k+=ln;

    }
   else
   if(p>=start_packedcouples)
    {
     p-=start_packedcouples;
     if(FIXED_NGRAM2&&(p==126))
      {
       memcpy(szUTXT+k," the",4);
       k+=4;
      }
     else
     if(FIXED_NGRAM2&&(p==127))
      {
       memcpy(szUTXT+k," you",4);
       k+=4;
      }
     else
      { 
       if(bUSEPACK==pack_bigramsanddict)
        len=dictlen[p+1]-dictlen[p];
       else 
        len=dictpos[p+1]-dictpos[p];
       if(bSPACEADD&1)
        if(szTXT[i]&0x40)
         szUTXT[k++]=' ';
       if(bUSEPACK==pack_bigramsanddict)
        memcpy(szUTXT+k, dicttext +dictlen[p],len);
       else 
        memcpy(szUTXT+k, dicttext +dictpos[p],len);
       k+=len;
       if(bSPACEADD&2)
        if(szTXT[i]&0x40)
         szUTXT[k++]=' ';
      }
     i++; 
    }
   else
    {szUTXT[k++]=p;i++;}
  }
 szUTXT[k]=0;   
}
int char_packed=0,char_missed=0,char_needed=0,char_used=0,char_topyj=0,char_extra=0;
int char_packed_used[256];
int dict_used[256];
int getDICTREF(const char*szTXT,int*len)
{
 int i,hm=sDICT.nstrings;
 for(i=0;i<hm;i++)
 {
  const char*what=sDICT.str +sDICT.idx[i];
  int        lwhat=strlen(what);
  if(memcmp(szTXT,what,lwhat)==0)
   {
    dict_used[i]++;
    if(len) *len=lwhat;
    return i;
   }
 }
 return -1;
}

int minimalpack(const char*orig,char*szTXT)
{
 char szSTR[DESC_MAXSIZE],szOTXT[DESC_MAXSIZE];
 int i=0,k=0,err=0;
 while(szTXT[i])
 {
  int j=0,dictid=-1,len;  
  if(USE_DICTREF&&((dictid=getDICTREF(szTXT+i,&len))!=-1))
   {
    if(dictid==0)
     szSTR[k++]=code_dictreference;
    else
     {
      szSTR[k++]=code_dictreference+1;
      szSTR[k++]=dictid+1;
     }
    i+=len;
   }
  else
  if(USE_DICTREF&&((dictid=getDICTREF(szTXT+i+1,&len))!=-1))
   {
    szSTR[k++]=szTXT[i++];
    char_missed++;
   }
  else
  if(FIXED_NGRAM2&&(memcmp(szTXT+i," the",4)==0))
   {
    szSTR[k]=128|126;
    i+=4;
    k++;
   }
  else
  if(FIXED_NGRAM2&&(memcmp(szTXT+i," you",4)==0))
   {
    szSTR[k]=128|127;
    i+=4;
    k++;
   }
  else   
   {
   for(j=0;j<idictidx;j++)
    {
     u16 pos;
     u8  len;    
     if(bUSEPACK==pack_bigramsanddict)
      {
       pos=dictlen[j];
       len=dictlen[j+1]-dictlen[j];
      } 
     else     
      {
       pos=dictpos[j];
       len=dictpos[j+1]-dictpos[j];
      } 
     if(len&&(memcmp(szTXT+i, dicttext +pos,len)==0))
      {   
       char_packed_used[j]++;
       if(j>char_topyj)
        char_topyj=j;
       if(j>=127)
        j+=0;
       szSTR[k]=start_packedcouples+j;
       char_packed++;
       i+=len;
       if((bSPACEADD&3)==2)
        {
         if(szTXT[i]==' ')
          {
           szSTR[k]|=64;        
           i++;
          }
        }
       else 
       if((bSPACEADD&3)==3)
        if((szTXT[i]==' ')&&k&&(szSTR[k-1]==' '))
         { 
          szSTR[k]|=64;        
          k--;
          szSTR[k]=szSTR[k+1];
          i++;
         }
       k++;
       break;
      }  
    } 
   if(j==idictidx) 
    {
     int n;
     for(n=2;n<16;n++)
      if(i-n>=0)
       if(memcmp(szTXT+i,szTXT+i-n,2)==0)
        {
         char_extra++;
         break;
        }
     szSTR[k++]=szTXT[i++];
     char_missed++;
    }
   }
 }
 char_needed+=i;
 char_used+=k;
 szSTR[k]=0; 
 minimalunpack(szSTR,szOTXT);
 if(strcmp(szOTXT,szTXT))
  {
   ERR(orig,"packed error!"); 
   err++;
  }
 else 
  strcpy(szTXT,szSTR);
 if(k>255)
  ERR(orig,"(warning) text is long"); 
 return k; 
}

void strpack(char*szTXT)
{
 char szSTR[DESC_MAXSIZE];
 int i=0,k=0;
 while(szTXT[i])
 {
  int j=0,bj=-1,bln=-1;
  while(j<i)
  {
   int ln=2;
   if((j+ln<i)&&(memcmp(szTXT+j,szTXT+i,ln)==0))
    {
     while(ln<32)
      if((j+ln+1<i)&&(memcmp(szTXT+j,szTXT+i,ln+1)==0))
       ln++;
      else
       break;
     if(ln>bln)
      {
       bj=j;bln=ln;
      }
     else
      if(ln==bln)
       bj=j;
    }
   j++;
  }
  if(bln<0)
   szSTR[k++]=szTXT[i++];
  else
   {
    szSTR[k++]=128|(i-bj);
    szSTR[k++]=bln;
    i+=bln;
   }
 }
 szSTR[k]=0;
 strcpy(szTXT,szSTR);
}

void addtrie(const char*sz,int pos,int id)
{
 int next,err=0;
 if(pos==idict)
  {
  dicttext[idict++]=*sz;
  dicttext[idict++]=0xFF;
  dicttext[idict++]=0xFF;
  dicttext[idict++]=0xFF;
  }
 while(pos<idict) 
  {
   if(idict/4>250)
    err++;
   if(*sz== dicttext[pos])
    {
     if(sz[1]==0)
      {
       if(dicttext[pos+3]!=0xFF)
        err++;
       else
        dicttext[pos+3]=id;
       return;
      }
     else
      {
       sz++;
       next= dicttext[pos+2];
       if(next==0xFF)
        {
         next= dicttext[pos+2]=idict/4;
         dicttext[idict++]=*sz;
         dicttext[idict++]=0xFF;
         dicttext[idict++]=0xFF;
         dicttext[idict++]=0xFF;
        }
       pos=next*4;
      }
    }
   else
    {
     next= dicttext[pos+1];
     if(next==0xFF)
      {
       next= dicttext[pos+1]=idict/4;
       dicttext[idict++]=*sz;
       dicttext[idict++]=0xFF;
       dicttext[idict++]=0xFF;
       dicttext[idict++]=0xFF;
      }
     pos=next*4;
    }
  } 
}

void trie(dict*sMSG,const char*name)
{
 int i,len=0;
 for(i=0;i<sMSG->nstrings;i++)
  {
  u16 w;
  char szSTR[DESC_MAXSIZE]="",szSTRF[DESC_MAXSIZE]="",tkn[256];
  const char*p;
  dict_getEx(sMSG,i,szSTR,NULL,(u8*)szSTRF,&w);  
  if(w==0)
   p=szSTR;
  else
   p=szSTRF;
  while(p)
   {
    len+=strlen(tkn);
    p=string_gettoken(p,tkn,'|');
    addtrie(tkn,0,i);
   } 
  }
}

int ppack(BUF*mem,u8*szSTR,int ll)
{
 int i,j,n,fnd=0;
 for(i=0;i<ll;i++)
  for(n=0;n<32;n++)
   {
    j=8+4;
    while(j--)
     if(j<4)
      break;
     else
      if(mem->c-(n+1)>=0)
       if(mem->c-(n+1)+j<mem->c)
        if(memcmp(mem->mem+mem->c-(n+1),szSTR,j)==0)
        {
         char cod[3];
         cod[0]=93;cod[1]=(n<<3)|(j-4);cod[2]=0;
         string_replace(szSTR,i,j,cod);
         break;
        }
   }
 ll=strlen(szSTR);
 return ll;
}

void stpwriteh(HANDLE hf,dict*sMSG,int first,int top,const char*name,int pack,u8*redirect,int tredirectcnt)
{ 
 int    i,n,psize=0,lsize=0;
 u8     buf[8192]; 
 if(top==-1)
  top=sMSG->nstrings;
 if(pack==16)
  {
   u16 w=mem.c;
   u16  offset[256],lC,tC;   
   dict sTMP;
   dict_add(&sTNAMES,name);
   BUF_safeadd(memidx,u16,w)
   dict_new(&sTMP,0,_dict_sorted|_dict_counter);
   for(i=first;i<top;i++)
    {
     char szSTR[DESC_MAXSIZE]="",szSTRF[DESC_MAXSIZE]="";
     const char*s;
     u16 w;
     u8   n;
     dict_getEx(sMSG,i,szSTR,NULL,(u8*)szSTRF,&w);       
     if(strstr(szSTR,"berries"))
      n=0;
     if(w)
      {
       for(n=0;szSTRF[n];n++)
        if(szSTRF[n]=='_')
         szSTRF[n]=' ';      
       strcpy(szSTR,szSTRF);  
      }
     s=szSTR; 
     while(s) 
     {
      char sC[256];
      s=string_gettoken(s,sC,'|'); 
      dict_addEx(&sTMP,sC,i,NULL,0);
     } 
    }
   memset(offset,0xFF,sizeof(offset));
   lC=255;tC=0;
   for(i=0;i<sTMP.nstrings;i++)
    {
     char sC[256];
     int  id;
     u8   l,n;
     dict_getEx(&sTMP,i,sC,&id,NULL,NULL);
     if(cIsIn(sC,"|fountain|"))
      n=0;
     l=strlen(sC);
     petmapbuf(sC,l);
     if(offset[sC[0]]==0xFFFF)
      {
       if(sC[0]<lC) lC=sC[0];
       if(sC[0]>tC) tC=sC[0];
       offset[sC[0]]=mem.c-w;
      }
     BUF_safeadd(mem,u8,l)     
     for(n=0;n<l;n++)
      BUF_safeadd(mem,u8,sC[n])
     if(redirect)
      if(tredirectcnt==0)
       {
        n=redirect[id];
        BUF_safeadd(mem,u8,n) 
       }
      else
       {
        int r,rr,hm=0;;
        for(r=0;r<tredirectcnt;r++)
         if(redirect[r*3]==id)
          {
           while(r+hm<tredirectcnt) 
            if(redirect[(r+hm)*3]==id)
             hm++;
            else
             break;
           break;
          }
        if(hm==1)
         {
          n=redirect[r*3+2];
          BUF_safeadd(mem,u8,n) 
         }
        else
         {
          BUF_safeadd(mem,u8,255) 
          BUF_safeadd(mem,u8,hm) 
          for(rr=0;rr<hm;rr++)
           {
            BUF_safeadd(mem,u8,redirect[(r+rr)*3+1]) 
            BUF_safeadd(mem,u8,redirect[(r+rr)*3+2]) 
           }
         }
       }
     else
      {
       n=id;
       BUF_safeadd(mem,u8,n) 
      }
    }
   BUF_safeadd(mem,u8,0)      
   dict_delete(&sTMP);

   if(strcmp(name,"objs")==0)
   {
    u16 w=mem.c;
    dict_add(&sTNAMES,"objs_dir");
    BUF_safeadd(memidx,u16,w)
    for(i=0;i<=tC;i++)
     {
      u8 b=offset[i]&0xFF;
      BUF_safeadd(mem,u8,b) 
      b=(offset[i]>>8);
      BUF_safeadd(mem,u8,b) 
     }
   }
  }
 else
 if(pack==4)
  {
   u16 w=mem.c;
   int  rl=0,prl=0;
   dict_add(&sTNAMES,name);
   BUF_safeadd(memidx,u16,w)
   for(i=first;i<top;i++)
    {
    const char*orig = sMSG->str + sMSG->idx[i];
     char szSTR[DESC_MAXSIZE]="",szSTRF[DESC_MAXSIZE]="";
     u16 w;
     u8   l;
     u16  ll,n;
     dict_getEx(sMSG,i,szSTR,NULL,(u8*)szSTRF,&w);  
     if(w)
      {
       for(n=0;szSTRF[n];n++)
        if(szSTRF[n]=='_')
         szSTRF[n]=' ';      
       strcpy(szSTR,szSTRF);  
      }
     ll=strlen(szSTR);
     rl+=ll;
     petmapbuf(szSTR,ll);
     ll=minimalpack(orig,szSTR);

     prl+=ll;
     //petmapbuf(szSTR,ll);
     if(ll<255)
      {
       l=(u8)ll;
       BUF_safeadd(mem,u8,l)
      }
     else
     if(ll<511)
      {
       l=255;
       BUF_safeadd(mem,u8,l)
       l=(u8)ll-255;
       BUF_safeadd(mem,u8,l)
      }  
     else
      ERR("*","len problem while packing");
     for(n=0;n<ll;n++)
      BUF_safeadd(mem,u8,szSTR[n])
    }
   BUF_safeadd(mem,u8,0)      
  }
 else
  { 
   BUFC a;
   BUF_set(a,char,256)
   for(i=first;i<top;i++)
   {
    const char*orig = sMSG->str + sMSG->idx[i];
    char szSTR[DESC_MAXSIZE]="",szSTRF[DESC_MAXSIZE]="";
    u16 w;
    dict_getEx(sMSG,i,szSTR,NULL,(u8*)szSTRF,&w);  
    if(w)
     {
      for(n=0;szSTRF[n];n++)
       if(szSTRF[n]=='_')
        szSTRF[n]=' ';
      if(pack==1) 
       psize+=tokenize(szSTRF,&sKEYS,&buf[psize]);
      else
      if(pack==2)
       psize+=twopack(szSTRF,&buf[psize]);
      else
      if(pack==3)
       strpack(szSTRF);
      else
       minimalpack(orig,szSTR);
      lsize+=strlen(szSTRF);
      BUFC_add(&a,szSTRF);
     }
    else
    {
     int ln=strlen(szSTR)+1;
     if(pack==1) 
      psize+=tokenize(szSTR,&sKEYS,&buf[psize]);
     else
     if(pack==2)
      psize+=twopack(szSTR,&buf[psize]);
     else
      if(pack==3)
       strpack(szSTR);
      else
       minimalpack(orig,szSTR);
     lsize+=ln;
     BUFC_add(&a,szSTR);
    }
    BUFC_add(&a,"~");
   }
   if((pack==1)||(pack==2))
    {
     if(mem.mem)
     {
      u16 w=mem.c;
      dict_add(&sTNAMES,name);
      BUF_safeadd(memidx,u16,w)
      for(i=0;i<psize;i++)
       BUF_safeadd(mem,u8,buf[i])   
     }
    }
   else
    {
    BUFC_add(&a,"~");
    zeromap(&a);
    petmap(&a);
    if(mem.mem)
     {
      u16 w=mem.c;
      dict_add(&sTNAMES,name);
      BUF_safeadd(memidx,u16,w)
      for(i=0;i<a.c;i++)
       BUF_safeadd(mem,u8,a.mem[i])
     }
    else
     writeh(hf,&a,name);
     }
   BUF_free(a) 
  }     
}


int binstart;

#define MAX_IFAT 1024
#define MAX_FILE 16*1024
#define MAX_IC 512
#define FAT_SIZE 4

#define fat_verb    0
#define fat_room    1
#define fat_pointer 2
#define fat_withobj 3

u16 ifat;
u8  gfat[MAX_IFAT*FAT_SIZE];
u8  file[MAX_FILE];
u16 cpos[MAX_IC];
u8  clen[MAX_IC];
u16 ic,ifile=0;

int fat_compare(const void*a,const void*b)
{
 u8*A=(u8*)a;
 u8*B=(u8*)b;
 int dif=A[fat_verb]-B[fat_verb];
 if(dif) return dif;
 dif=A[fat_room]-B[fat_room];
 if(dif) return dif;
 dif=A[fat_withobj]-B[fat_withobj];
 if(dif) return dif;
 dif=clen[B[fat_pointer]]-clen[A[fat_pointer]];
 return dif;
}

void writepcode(HANDLE hf)
{
 char out[256];
 int  i;
 
 total+=ifat*FAT_SIZE;

 qsort(gfat,ifat,FAT_SIZE,fat_compare);

 sprintf(out,"// pcode size: %d\r\n",ifat*FAT_SIZE+ic*(sizeof(cpos[0])+sizeof(clen[0]))+ifile);
 file_writes(hf,out);

 sprintf(out,"u8 pcode_vrbidx[%d]={",ifat*FAT_SIZE);
 file_writes(hf,out);
 for(i=0;i<ifat*FAT_SIZE;i+=FAT_SIZE)
 {
  if(i) file_writes(hf,",\r\n");
  if(isbetween(gfat[i],0,sVRB.nstrings-1))
   sprintf(out,"vrb_%s, ",sVRB.str+sVRB.idx[gfat[i]]);
  else
   sprintf(out,"0x%02x, ",gfat[i]);
  file_writes(hf,out);  
  if(isbetween(gfat[i+1],0,sROOM.nstrings-1))
  {
   const char*s=sROOM.str +sROOM.idx[gfat[i+1]];
   sprintf(out,"room_%s, ",s+(*s=='$'));
  }
  else
   sprintf(out,"0x%02x, ",255);
  file_writes(hf,out);  
  sprintf(out,"0x%02x",gfat[i+2]);
  file_writes(hf,out);  
 }
 file_writes(hf,"};\r\n");
 
 if(ifile<256)
  {
   total+=ic;
   sprintf(out,"u8 pcode_pos[%d]={",ic);
  }
 else
  {
   total+=ic*2;
   sprintf(out,"u16 pcode_pos[%d]={",ic);
  }
 file_writes(hf,out);
 for(i=0;i<ic;i++)
 {
  if(i) file_writes(hf,",");
  if((i%32)==31) file_writes(hf,"\r\n");
  sprintf(out,"0x%02x",cpos[i]);
  file_writes(hf,out);  
 }
 file_writes(hf,"};\r\n");

 total+=ic;
 sprintf(out,"u8 pcode_len[%d]={",ic);
 file_writes(hf,out);
 for(i=0;i<ic;i++)
 {
  if(i) file_writes(hf,",");
  if((i%32)==31) file_writes(hf,"\r\n");
  sprintf(out,"0x%02x",clen[i]);
  file_writes(hf,out);  
 }
 file_writes(hf,"};\r\n");

 total+=ifile;
 sprintf(out,"u8 pcode_data[%d]={",ifile);
 file_writes(hf,out);
 for(i=0;i<ifile;i++)
 {
  if(i) file_writes(hf,",");
  if((i%32)==31) file_writes(hf,"\r\n");
  sprintf(out,"0x%02x",file[i]);
  file_writes(hf,out);  
 }
 file_writes(hf,"};\r\n");

 file_writes(hf,"\r\n");
}

#define verbobj_score        250
#define verbeverywhere_score 253
#define verbclass_score      254

int getCMD(const char*meta);

int emitstream(int verbid,int roomid,BUF*bin,int start)
{
 int i,len=bin->c-start;
 int op_withobj=getCMD("withobj")+128;
 
 if((verbid==5)&&(roomid==10))
  i=0;

 if(len==0)
  return -1;

 if(len>255)
  {
   ERR("emitstream","len>255");
   return -1;
  }

 if(ifat>=MAX_IFAT)
  {
   ERR("emitstream","ifat>=MAX_IFAT");
   return -1;
  }

 memset(&gfat[ifat*FAT_SIZE],0,FAT_SIZE);

 gfat[ifat*FAT_SIZE+fat_verb]=(u8)verbid;
 if(gfat[ifat*FAT_SIZE+fat_verb]>=240)
  i=0;
 if(roomid==-2)
  gfat[ifat*FAT_SIZE+fat_room]=(u8)verbeverywhere_score;
 else
 if(roomid==-1)
  gfat[ifat*FAT_SIZE+fat_room]=(u8)verbobj_score;
 else
  gfat[ifat*FAT_SIZE+fat_room]=(u8)roomid;

 if(bin->mem[start]==op_withobj)
  gfat[ifat*FAT_SIZE+3]=bin->mem[start+1];
 else
  gfat[ifat*FAT_SIZE+3]=255;

 for(i=0;i<ic;i++)
  if(clen[i]==len)
   {
    if(memcmp(file+cpos[i],bin->mem+start,clen[i])==0)
     break;
   }

 if(i==ic)
  {
   int found=0,j;
   if(ic>=MAX_IC)
    {
     ERR("emitstream","ic>=MAX_IC");
     return -1;
    }
   if(ifile+len>=MAX_FILE)
    {
     ERR("emitstream","ifile+len>=MAX_FILE");
     return -1;
    }
   
   cpos[ic]=ifile;
   clen[ic]=len;
   
   for(j=0;j<ifile-len;j++)
    if(memcmp(file+j,bin->mem+start,len)==0)
    {
     found=1;
     cpos[ic]=j;
     break;
    }
   
   if(found==0)
    {
     memcpy(file+ifile,bin->mem+start,len);
     ifile+=len;
   }
   ic++;
  }

 if(i>255)
  ERR("emitstream", "fat_pointer>255");
 else
  gfat[ifat*FAT_SIZE+fat_pointer]=(u8)i;

 ifat++;

 return ifat;
}

void addOPCODE(BUF*op,int opc)
{
 int err=0;
 if((opc<0)||(opc>=255))
  err++;
 BUF_safeadd((*op),u8,opc)
}

void addOPCODES(BUF*op,BUF*op2)
{
 int i;
 for(i=0;i<op2->c;i++)
  BUF_safeadd((*op),u8,op2->mem[i])
}

int oncebit,flagbit;
int mask[16]={1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768};

u8 roomnameId[256],roomdescId[256],roomattr[256],roomimg[256],roomovrimg[256],
   
   objnameId[256],objdescId[256],objloc[256],objattr[256],objimg[256], 
   objartId[256],objadjId[256],objsynId[256],objgenId[256],objcapacity[256],objsize[256],

   cobjnameId[256],cobjdescId[256],cobjloc[256],cobjattr[256],cobjimg[256],

   objsynids[256],
   roomobjsynids[1024*3],iroomobjsynids,needroomobjs,
   vrbsynids[256],

   vars[256],bitvars[32];

static const char* local_S_getline(const char* stringa,char* line)
{
 if(stringa)
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
 else
 {
  if(line) *line=0;
  return stringa;
 }
}

void adjustname(char*nm)
{
 int i=0,j=0;
 while(nm[i])
  if(isalnum((u8)nm[i]))
   nm[j++]=nm[i++];
  else
   i++;
 nm[j]=0;  
 string_normalize(nm,S_alllowercase);
}

int addroomimage(const char*roomname,int roomid,const char*p)
{        
 int imageid=dict_find(&sIMG,p);
 if(imageid==-1)
  {
  char cmd[256];
  char img[256],png[256],imgfolder[256],png1[256];
  imageid= dict_add(&sIMG,p);

  sprintf(png,"%s",p);
  configstring("imgfolder",imgfolder);
  sprintf(img,"%sroom%02d",imgfolder,imageid+1);
  string_gettoken(png,png1,'-');
  if(file_exists(png1))//file_updateneeded(png,img))
   {
    char nm[256];
#if defined(HANDLE_IMAGES)
    PNG_converter(png,img,1,roomname,model);    
    //PNG_converter(png,img,1,roomname,VGA);
#else
   sprintf(cmd,"..\\..\\..\\bin\\bin2h.exe -i %s -o null -dither 8 -bkcol 0 -contrast 2 -sharpen 1 -ob img\\room%02d\n",p,imageid+1,imageid+1,imageid+1);
   file_writes(hfIMAGEBAT,cmd);           
#endif   
    if(configstring("name",nm))
     {
      adjustname(nm);      
      sprintf(cmd,"c1541.exe bin/%s.d64 -write img/room%02d room%02d\r\n",nm,imageid+1,imageid+1);
      file_writes(hfIMAGEBAT2,cmd);      
     } 
   }
  else
   ERR("image not found",png);
  }
 if((roomid!=-1)&&(imageid!=-1))
  roomimg[roomid]=imageid;
 return imageid;
}

void format_disk()
{
 char nm[256];
 if (configstring("name", nm))
 {
  char out[256];
  adjustname(nm);
  sprintf(out, "c1541.exe -format %s,666 d64 bin/%s.d64 -attach bin/%s.d64 -write %%1 %s\r\n", nm, nm, nm, nm);
  file_writes(hfIMAGEBAT2, out);
 }
}


int S_tabcount(const char*s,int wanted)
{
 while(wanted--)
  if(*s=='\t')
   s++;
  else
   return 0;
 return 1;
}

void deaccent(char*szDESC)
{
 int k,i=0;
 u8  bUTF8=0;
 u8  rmp[]="ָאטילעש";
 u8  rmpx[]="Eaeeiou"; 
 while(szDESC[i])
  {
   if(szDESC[i]=='\t')
    szDESC[i]=' ';
   i++; 
  }
 i=0; 
 while(szDESC[i])
  {
   if((szDESC[i]==' ')&&(szDESC[i+1]==' '))
    string_delete(szDESC,i,1);
   else
    i++; 
  } 
 i=0; 
 while(szDESC[i])
  {
   if((szDESC[i]=='#')&&(szDESC[i+1]=='#'))
    {
     int n=2,j=0,id;
     char var[256];
     while(szDESC[i+n]!='#')
      var[j++]=szDESC[i+n++];
     var[j]=0; 
     string_normalize(var,S_alllowercase);
     id=dict_find(&sDEF,var);
     if(id==-1)
      string_delete(szDESC,i,2+j+2);
     else
      {
       dict_getEx(&sDEF,id,NULL,NULL,var,NULL);
       string_replace(szDESC,i,2+j+2,var);
      } 
    } 
   else
    i++; 
  }  
 i=0; 
 while(szDESC[i])
  {
   if(((szDESC[i]=='#')||(szDESC[i]=='@'))&&isalpha(szDESC[i+1]))
    {
     int n=1;
     while(isalpha(szDESC[i+n])||(szDESC[i+n]=='-'))
      n++;
     string_insert(szDESC,i+n,"\\w"); 
     string_replace(szDESC,i,1,"\\y");
    } 
   else
    i++; 
  }  
 i=0; 
 while(szDESC[i])
  {
   int len,code;
   if(bUTF8)
    code= utf8_getchar(szDESC+i,&len);
   else
    {code=(u8)szDESC[i];len=1;}
   if(code>127)
    {
     for(k=0;rmp[k];k++)
      if(rmp[k]==code)
       {
        char r[3];
        r[0]=rmpx[k];r[1]='\'';r[2]=0;
        string_replace(szDESC,i,len,r);
        break;
       }
     if(rmp[k]==0)
      i+=len;
    }
   else
    i+=len; 
  }
}

int getLIST(dict*sSYNS,const char*sz,const char*sep,int way,int*ids)
{
 int cnt=0,err=0;
 while(sz)
 {
  char tkn[256];  
  int  id;
  sz=string_gettoken2(sz,tkn,sep);
  string_trim(tkn,tkn);
  if((*tkn=='"')&&(tkn[strlen(tkn)-1]=='"'))
   {
    tkn[strlen(tkn)-1]=0;
    string_delete(tkn,0,1);
   }
  if(way&1)
   id= dict_add(sSYNS,tkn);
  else
   id=dict_find(sSYNS,tkn);
  if(id!=-1)
   ids[cnt++]=id;
  else
   err++;
 }
 return cnt;
}

const char*getDESC(const char*p,const char*sz,char*szDESC,int tab,char*szDESC2,char*szDESC3,char*szDESC4)
{
 int len=strlen(p),i=0;
 if(szDESC2) *szDESC2=0;
 if(szDESC3) *szDESC3=0;
 if(szDESC4) *szDESC4=0;
 strcpy(szDESC,p);
 while(szDESC[i]==' ') i++;
 if(i)
  string_delete(szDESC,0,i);
 while(sz&&S_tabcount(sz,tab))
  {
   char line[8192];
   sz=local_S_getline(sz,line);
   string_trim(line,line);
   if(*line==0)
    continue;   
   if(len>60)
    strcat(szDESC," ");
   else
    strcat(szDESC,"\n");
   strcat(szDESC,line);
   len=strlen(line);
  }  
 deaccent(szDESC);
 len=strlen(szDESC);
 
 if(len>=DESC_MAXSIZE)
  ERR(szDESC,"len");
 return sz;
}

int getCMD(const char*meta)
{ 
 int id=dict_find(&sCMD,meta);
 if(id==-1)
  { 
   id=dict_find(&sCMDALIAS,meta);
   if(id!=-1)
    {
     char cmd[256];
     dict_getEx(&sCMDALIAS,id,NULL,NULL,(u8*)cmd,NULL);
     id=dict_find(&sCMD,cmd);
    }
  }
 return id;
}

int stringcheck(const char*string,char*match)
{
 if(strcmp(string,match)==0)
  return 1;
 if(isalpha(string[0])&&isalpha(string[1])&&(string[2]=='.')&&(strcmp(string+3,match)==0))
 {
  char lang[32];
  if(configstring("language",lang))
   if(memcmp(lang,string,2)==0)
    return 1;
   else
    return -1;
  return 0;
 }
 return 0;
}

const char*tknget(const char*what,char*tkn)
{
 int t=0;
 while(*what==' ') what++;
 if(cIsCharIn(*what,"=<>"))
  {
   while(cIsCharIn(*what,"=<>"))
    tkn[t++]=*what++;
   tkn[t]=0;
  }
 else
 if(*what=='"')
  {
   tkn[t++]=*what++;
   while(*what)
    if(*what=='"')
     {tkn[t++]=*what++;break;}
    else
     tkn[t++]=*what++;
   tkn[t]=0;
  }
 else
  {
   while(*what&&(!cIsCharIn(*what,"=<>,")))
    tkn[t++]=*what++;
   tkn[t]=0;
  } 
 while(*what==' ') what++;
 if(*what==',') 
  {
   what++;
   while(*what==' ') what++;
  }
 if(*what==0)
  return NULL;
 else
  return what;
}

const char*ifget(const char*what,char*tkn)
{
 int t=0;
 while(*what==' ') what++;
 if(cIsCharIn(*what,"=<>"))
  {
   while(cIsCharIn(*what,"=<>"))
    tkn[t++]=*what++;
   tkn[t]=0;
  }
 else
  if(isdigit(*what))
  {
   while(isdigit(*what))
    tkn[t++]=*what++;
   tkn[t]=0;
  }
  else
  if(*what=='"')
   {
    tkn[t++]=*what++;
    while(*what)
     if(*what=='"')
      {tkn[t++]=*what++;break;}
     else
      tkn[t++]=*what++;
    tkn[t]=0;
   }
  else
   {
    if(*what=='$')
     tkn[t++]=*what++;
    while(isalpha(*what))
     tkn[t++]=*what++;
    tkn[t]=0;
   } 
 while(*what==' ') what++;
 if(*what==',') 
  {
   what++;
   while(*what==' ') what++;
  }
 if(*what==0)
  return NULL;
 else
  return what;
}

const char*handleaction(const char*sz,BUF*vopcodes,int vrbid,char*synonyms,const char*roomname)
{
 int opcodeid=-1,attr=0,varid=-1,varid2=-1,varid3=-1,fnd=0;
 char line[8192],meta[256]; 
 int  tab=0,loc;
 int  op_msg=getCMD("msg")+128,op_msg2=getCMD("msg2")+128;
 sz=local_S_getline(sz,line);
 while(line[tab]=='\t') tab++;
 string_trim(line,line);

 if(strstr(line,"berries"))
  fnd++;

 if(*line==0)
  ;
 else
  {
  const char*p=string_gettoken(line,meta,':');   
  opcodeid=getCMD(meta);
  if(opcodeid!=-1)
  {   
   if(strcmp(meta,"addscore")==0)
    dict_add(&sADDSCORE,line);

   dict_getEx(&sCMD,opcodeid,NULL,&attr,NULL,NULL);   
   if(strcmp(meta,"if")==0)
    {
     char tkn[256];
     if(*p=='!')
      {
       p++;
       strcpy(meta,"ifnot");
       opcodeid=getCMD(meta);
      }
     p=ifget(p,tkn);
     if(p==NULL)
      {       
       addOPCODE(vopcodes,opcodeid+128);
       varid= dict_add(&sBITVAR,tkn);
       if(varid==-1)
        ERR(line,tkn);
       else
        {       
         addOPCODE(vopcodes,varid);
        }
      }
     else
      {
       int tvarid=dict_find(&sMETA,tkn),varmask=0;
       if(tvarid!=-1)
        {
         int mode;
         dict_getEx(&sMETA,tvarid,NULL,&mode,NULL,NULL);
         varid=tvarid+meta_base;
        }       
       else
        {varid= dict_add(&sVAR,tkn);varmask|=0x40;}
       if(varid==-1)
        ERR(line,tkn);
       else
        {
         int varid1=varid,cmpid=-1,varid2=-1;
         p=ifget(p,tkn);
         cmpid=dict_find(&sCMP,tkn);
         if(cmpid==-1)
          ERR(line,tkn);
         else
          {
           p=ifget(p,tkn);
           if(isdigit(*tkn))
            varid2=atoi(tkn);
           else
            {
             int tvarid=dict_find(&sMETA,tkn);
             if(tvarid!=-1)
              {
               int mode;
               dict_getEx(&sMETA,tvarid,NULL,&mode,NULL,NULL);
               varid2=tvarid+meta_base;
              }
             else
              if(*tkn=='"')
               {
                tkn[strlen(tkn)-1]=0; 
                if(sOBJSYNS.nstrings)
                {
                 varid2=dict_find(&sOBJSYNS,tkn+1);
                 if(varid2!=-1)
                  varid2=objsynids[varid2];                  
                }
                else
                 varid2=dict_find(&sOBJ,tkn+1);
               }
              else
               {varid2=dict_find(&sVAR,tkn);varmask|=0x80;}
            }
           if(varid2==-1)
            ERR(line,tkn);
           else
            {
            opcodeid=getCMD("ifvar");
            addOPCODE(vopcodes,opcodeid+128);
            addOPCODE(vopcodes,cmpid|varmask);

            addOPCODE(vopcodes,varid1);            
            addOPCODE(vopcodes,varid2);
            }
          }
        }
      }
    }
   else
    {
     addOPCODE(vopcodes,opcodeid+128);
     while(p)
      {
       int  lattr=attr&0x3FF;
       int  two=0,two2=0,two3=0;
       char tkn[DESC_MAXSIZE],tkn2[DESC_MAXSIZE],tkn3[DESC_MAXSIZE],tkn4[DESC_MAXSIZE];
       varid=-1;
       if(lattr&bit_MSG)
        {
         if(*p=='$')
          p=string_gettoken(p,tkn,',');
         else
          {
          sz=getDESC(p,sz,tkn,tab+1,tkn2,tkn3,tkn4);          
          p=NULL;
          }
        }
       else
       {
        p=tknget(p,tkn);
        //p=string_gettoken(p,tkn,',');
        if(cIsIn(meta,"|withobj|"))
        {
         char tkn1[256];
         string_gettoken(tkn,tkn1,'|');
         strcpy(tkn,tkn1);
         p=NULL;
        }
       }

       if(cIsIn(meta,"|ifundef|"))
       {
        int k;
        k=0;
       }
       
       if(lattr&bit_ATTR)
        {
         const char*pp=tkn;
         char szattr[256];
         int lvarid=0;
         varid=0;
         while(pp)
          {
          pp=string_gettoken(pp,szattr,'+');
          if(strcmp(szattr,"$none")==0)
           varid=0;
          else
           {
            lvarid=dict_find(&sATTR,szattr);
            if(lvarid==-1)
            {
             dict_add(&sATTR,szattr);
             lvarid=dict_find(&sATTR,szattr);
            }
            varid|=mask[lvarid];
           }
          }
        }
       else
       if(lattr&bit_CMP)
        varid=dict_find(&sCMP,tkn);
       else
       if(lattr&bit_VAR)
        if((lattr&bit_NUM)&&isdigit(*tkn))
         varid=atoi(tkn);
        else
        {
         int tvarid=dict_find(&sMETA,tkn);
         if(tvarid!=-1)
          {
           int mode;
           dict_getEx(&sMETA,tvarid,NULL,&mode,NULL,NULL);
           if(mode&lattr)
            varid=tvarid+meta_base;
           else
            varid= dict_add(&sVAR,tkn);
          }       
         else
          if(*tkn!='$')
           {
            varid= dict_add(&sVAR,tkn);
            if(varid==-1)
             varid=dict_find(&sOBJ,tkn);
           }
        }
       else
       if(lattr&bit_OBJ)
        {
         varid=dict_find(&sOBJ,tkn);
         if((varid==-1)&&(*tkn!='$')&&roomname&&*roomname)
          {
           char localobj[256]={0};
           strcpy(localobj,roomname);strcat(localobj,".");
           strcat(localobj,tkn);
           varid=dict_find(&sOBJ,localobj);
          }
        }
       else
       if(lattr&bit_ROOM)
        varid=dict_find(&sROOM,tkn);
       else
       if(lattr&bit_MSG)
        {
        varid=findMSG(tkn,&two);
        if(*tkn2)
         varid2=findMSG(tkn2,&two2);
        else
         varid2=-1; 
         if(*tkn3)
         varid3=findMSG(tkn3,&two3);
        else
         varid3=-1; 
        }
       else
        if(lattr&bit_BITVAR)
         varid= dict_add(&sBITVAR,tkn);
       if(lattr&&(varid==-1))
        {
         int tvarid=dict_find(&sMETA,tkn);
         if(tvarid!=-1)
          {
           int mode;
           dict_getEx(&sMETA,tvarid,NULL,&mode,NULL,NULL);
           if(mode&lattr)
            varid=tvarid+meta_base;         
          }
         else
         if(lattr&bit_NUM)
          if(isdigit(*tkn))
           varid=atoi(tkn);
          else
           if(isalpha(*tkn)&&(tkn[1]==0))
            varid=pettrans(*tkn);
           else
            if(strstr(tkn,".png")||strstr(tkn,".jpg"))
             varid=addroomimage(NULL,-1,tkn);
            else
            if(strcmp(tkn,"$null")==0)
             varid=255; 
        }
       if(lattr&&(varid==-1))
        if(*tkn=='$')
         if(lattr&bit_MSG)
          {
           int id=-1,knd=0;
           if(memcmp(tkn,"$room.",6)==0)
            {knd=1;id=dict_find(&sATTRS,tkn+6);}
           else
            if(memcmp(tkn,"$obj.",5)==0)
             {knd=2;id=dict_find(&sATTRS,tkn+5);}
            else
             if(memcmp(tkn,"$this.",6)==0)
              {knd=2;id=dict_find(&sATTRS,tkn+6);}
             else
             if(memcmp(tkn,"$room",5)==0)
              {knd=1;id=dict_find(&sATTRS,tkn+5);}
             else
              if(memcmp(tkn,"$obj",4)==0)
               {knd=2;id=dict_find(&sATTRS,tkn+4);}
           if(id!=-1)            
            {
             if(strcmp(meta,"msg")==0)
              {
               opcodeid=dict_find(&sCMD,"msgattr");
               vopcodes->mem[vopcodes->c-1]=opcodeid|128;
              }
             varid=(knd-1)*64+id;
            }
          }
       if(lattr&&(varid==-1))
        ERR(line,tkn);
       else
        {       
         if((lattr&bit_MSG)&&(*tkn!='$'))
          if(two)
           if(vopcodes->c&&vopcodes->mem[vopcodes->c-1]==op_msg)
            vopcodes->mem[vopcodes->c-1]=op_msg2;
         if(varid!=-1)
          addOPCODE(vopcodes,varid);
         if(cIsIn(tkn,"|$oneofroom|$oneofobj|"))
          {
           unsigned char what[256],cnt=0,l;
           int           m=tkn[6];
           while(p)
            {
             p=string_gettoken(p,tkn,'+');
             if(m=='r')
              l=dict_find(&sROOM,tkn);
             else
              l=dict_find(&sOBJ,tkn);
             if(l==-1)
              ERR(line,tkn);
             else
              what[cnt++]=l;
            }
           addOPCODE(vopcodes,cnt);
           l=0;
           while(l<cnt)
            addOPCODE(vopcodes,what[l++]);
          }
         // add a second msg request
         if(varid2!=-1)
          {
           if(two2&&((opcodeid+128)==op_msg))
            addOPCODE(vopcodes,op_msg2);
           else
            addOPCODE(vopcodes,opcodeid+128);
           addOPCODE(vopcodes,varid2);
           varid2=-1;
          }         
         if(varid3!=-1)
          {
           if(two3&&((opcodeid+128)==op_msg))
            addOPCODE(vopcodes,op_msg2);
           else
            addOPCODE(vopcodes,opcodeid+128);
           addOPCODE(vopcodes,varid3);
           varid3=-1;
          }          
        }
       attr=attr>>10;
      }
     }
   if(cIsIn(meta,"|withobj|"))
    {
     while(sz&&S_tabcount(sz,tab+1))
      sz=handleaction(sz,vopcodes,vrbid,NULL,roomname);      
     if(sz)
     {
      local_S_getline(sz,line);string_trim(line,line);
     }
     else
      *line=0;
     p=string_gettoken(line,meta,':');   
     if(*meta==0)
      ;
     else
     if(cIsIn(meta,"|endwith|"))
      ;
     else
      addOPCODE(vopcodes,getCMD("endwith")+128);
    }
   else
    if((memcmp(meta,"if",2)==0)||(memcmp(meta,"else",4)==0))
     {
      int endif=0;
      while(sz&&S_tabcount(sz,tab+1))
       sz=handleaction(sz,vopcodes,vrbid,NULL,roomname);      
      if(sz&&S_tabcount(sz,tab))
       {
       local_S_getline(sz,line);
       string_trim(line,line);
       p=string_gettoken(line,meta,':');   
       if(cIsIn(meta,"|endif|else|"))
        endif=1;
       }
      else
       {
        local_S_getline(sz,line);
        string_trim(line,line);
       }
      if((*meta==0)||endif)
       ;
      else
       addOPCODE(vopcodes,getCMD("endif")+128);
     }
  }
  else
   if((loc=stringcheck(meta,"syn"))||(loc=stringcheck(meta,"synonym")))
    {
     char szDESC[DESC_MAXSIZE]="";
     int  id,err=0,synids[64];
     if(loc>0)
      {
      int nsyns;
      if(synonyms)
       strcpy(synonyms,p);
      nsyns=getLIST(&sVRBSYNS,p,",+|",1,&synids[0]);
      while(nsyns--)
       vrbsynids[synids[nsyns]]=vrbid;
      id=0;
      id=0;
      }
    }
   else
   if(isalpha(meta[0])&&isalpha(meta[1])&&(meta[2]=='.')&&cIsIn(meta+3,"|msg|"))
    ;
   else
    ERR(line,meta);  
  }
 return sz;
}

int extractSCENERY(char*szDESC,dict*sSCENERY)
{
 char*p=strstr(szDESC,"{");
 if(p)
  {
   if(sSCENERY)
    {
     const char*s=p;
     dict_softreset(sSCENERY);
     while(s&&(*s=='{'))
     {
      char line[8192];
      int  n=0;
      s++;
      while(*s&&(*s!='}'))
       line[n++]=*s++;
      line[n]=0;
      if(*s=='}') s++;
      while((*s=='\r')||(*s=='\n')||(*s==' ')) s++;
      string_trim(line,line);
      if(cIsCharIn(*line,"{}[]<>"))
       ;
      else
      if(isalpha(*line))
       {
        int j=0,i=0;
        char obj[8192];
        while(line[i]&&(line[i]!=':'))
         obj[j++]=line[i++];
        obj[j]=0;
        string_trim(obj,obj);
        if(line[i]==':') 
         {
          i++;
          while(line[i]==' ')
           i++;
         }
        dict_addEx(sSCENERY,obj,-1,(u8*)line+i,strlen(line+i)+1);
       }
     }
    }
   *p=0;
   string_trim(szDESC,szDESC);
   return 1;
  }
 else
  return 0;
}

void handleSETS(char*szDESC)
{
 if(*szDESC=='[')
 {
  int i=1;
  dict stp;
  dict_new(&stp,0,_dict_sorted);
  while(szDESC[i]&&(szDESC[i]!=']'))
   {
    int j=0;
    char tkn[256];
    while(szDESC[i]&&(szDESC[i]!=']')&&(szDESC[i]!=','))
     tkn[j++]=szDESC[i++];
    tkn[j]=0;
    string_trim(tkn,tkn);
    dict_add(&stp,tkn);
    if(szDESC[i]==',') i++;
   }
  *szDESC=0;
  for(i=0;i<stp.nstrings;i++)
  {
   if(i)
    if(i+1==stp.nstrings)
     strcat(szDESC," and ");
    else
     strcat(szDESC,", ");
   else
    strcat(szDESC,"");
   strcat(szDESC,stp.str +stp.idx[i]);
  }
  dict_delete(&stp);
 }
}

void model_update()
{
 if(configcheck("model","ZX")) 
  model=ZXSpectrum;
 else
  if(configcheck("model","VIC20")) 
   model=VIC20;
  else
  if(configcheck("model","C64")) 
   model=C64;
  else
  if(configcheck("model","VGA")) 
   model=VGA;
}



void adv_preparse(const char*szPath,const char*szPath2,const char*sz,int way)
{
 int kind=0,objid=-1,vrbid=-1;
 char room[256]={0};
 while(sz&&*sz)
  {
   char line[8192],meta[256];
   const char*p;
   int tab=0,loc;
   sz=local_S_getline(sz,line);
   while(line[tab]=='\t') tab++;
   string_trim(line,line);
   if(*line==0)
    continue;
   p=string_gettoken(line,meta,':');

   if(strlen(meta)>sizeof(meta))
    tab=0;

   if(cIsIn(meta,"|include|"))
    {
     u8*p2;
     char szFN[256];
     string_gettoken(p,meta,',');
     sprintf(szFN,"%s%s",szPath,meta);
     if(file_readfile(szFN,&p2)>0)
     {
      p2=(u8*)clean((char*)p2,szFN);
      adv_preparse(szPath,szPath2,(char*)p2,way);
      FREE(p2)
     }
     else
      ERR(line,meta);
    }
   else
   if(cIsIn(meta,"|config|"))
    {
     while(sz&&S_tabcount(sz,tab+1))
      {
       char key[256];
       const char*val;
       sz=string_getline(sz,line);
       string_trim(line,line);
       val=string_gettoken(line,key,':');
       if(val)
        dict_addEx(&sDEF,key,-1,(u8*)val,strlen(val)+1);
       else
        {
         while(sz&&S_tabcount(sz,tab+1+1))
          {
           char key2[256];
           const char*val;
           sz=string_getline(sz,line);
           string_trim(line,line);
           val=string_gettoken(line,key2,':');
           if(val)
            {
             char kkey[256];
             sprintf(kkey,"%s.%s",key,key2);
             dict_addEx(&sDEF,kkey,-1,(u8*)val,strlen(val)+1);
            }
           else
            ;
          }
        }
      } 
     model_update();
    }
   else       
   if(cIsIn(meta,"|setvar|addvar|decvar|ifvar|"))
   {
    tknget(p,meta);
    //string_gettoken(p,meta,',');
    dict_add(&sVAR,meta);
   }
   else
   if((loc=stringcheck(meta,"syn"))||(loc=stringcheck(meta,"synonym")))
   {
    char szDESC[DESC_MAXSIZE]="";
    int  synids[64],nsyns;
    if(loc>0)
     if(kind==2)
      {
       nsyns=getLIST(&sOBJSYNS,p,",+|",1,&synids[0]);
       /*while(nsyns--)
        objsynids[synids[nsyns]]=objid;*/
      }
     else
      if(kind==1)
       {
        nsyns=getLIST(&sVRBSYNS,p,",+|",1,&synids[0]);
        /*while(nsyns--)
         vrbsynids[synids[nsyns]]=vrbid;*/
       }
      else
       nsyns=0;
    /*sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);          
    id=dict_find(&sSYNS,szDESC);
    if(id!=-1)
     pobjsynId[objid]=id;
    else
     err++;*/
   }
   else
   if(loc=stringcheck(meta,"name"))
    {
     char szDESC[DESC_MAXSIZE]="";
     sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);     
     if(loc>0)
      dict_add(&sNAMES,szDESC);
    }
   else
   if(loc=stringcheck(meta,"desc"))
    {
     char szDESC[DESC_MAXSIZE]="";
     if(p==NULL)
      ;
     else
      sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);          
     if(loc>0)
     {        
      if(extractSCENERY(szDESC,&sSCENERY))
       {
        int i;
        for(i=0;i<sSCENERY.nstrings;i++)
         {
          char obj[256],desc[4096];
          char mmeta[256]={0};
          dict_getEx(&sSCENERY,i,obj,NULL,(u8*)desc,NULL);         
          if(strstr(obj,".")||strstr(desc,"*"))
           {
            const char*d=desc;            
            char*p;
            while(d)
             {
              char szD[512];
              d=string_gettoken(d,szD,'*');
              string_trim(szD,szD);
              if((*szD=='$')||(*szD=='?'))
               ;
              else
               addMSG(szD);
             }
            if(*room) {strcpy(mmeta,room);strcat(mmeta,".");}
            
            p=strstr(obj,".");
            if(p)
             *p++=0;

            strcat(mmeta,obj);

            objid=addOBJ(mmeta,NULL);//dict_addEx(&sOBJ,mmeta,-1,NULL,0);
           }
          else
           {
            strcpy(desc,"\t\tdesc:");
            dict_getEx(&sSCENERY,i,obj,NULL,(u8*)desc+5+2,NULL);         
            if(*room) {strcpy(mmeta,room);strcat(mmeta,".");}
            strcat(mmeta,obj);
            objid=addOBJ(mmeta,desc);//dict_addEx(&sOBJ,mmeta,-1,(u8*)desc,strlen(desc)+1);
            dict_add(&sDESC,desc+5+2);
           }
         }
        dict_softreset(&sSCENERY);
       }      
      dict_add(&sDESC,szDESC);
     }
    }
   else
   if(cIsIn(meta,"|verb|")||(dict_find(&sVRBCLS,meta)!=-1))
    {
     char*pp;
     kind=1;
     string_gettoken(p,meta,'|');
     pp=strstr(meta,"+");
     if(pp) *pp=0;
     if(*meta=='$')
      ;
     else
     if(dict_find(&sVRB,meta)==-1)
      vrbid=dict_addEx(&sVRB,meta,-1,(u8*)p,strlen(p)+1);
    }
   else
   if(cIsIn(meta,"|verbclass|"))
    {
     char*pp;
     string_gettoken(p,meta,'|');
     pp=strstr(meta,"+");
     if(pp) *pp=0;
     if(*meta=='$')
      ;
     else
     if(dict_find(&sVRBCLS,meta)==-1)
      dict_addEx(&sVRBCLS,meta,-1,(u8*)p,strlen(p)+1);
    }
   else
   if(cIsIn(meta,"|objclass|"))
    {
     char*pp;
     string_gettoken(p,meta,'|');
     pp=strstr(meta,"+");
     if(pp) *pp=0;
     if(*meta=='$')
      ;
     else
     if(dict_find(&sOBJCLS,meta)==-1)
      dict_addEx(&sOBJCLS,meta,-1,(u8*)p,strlen(p)+1);
    }    
   else
   if(memcmp(meta,"attr.",5)==0)
    {
     if(p&&isdigit(*p))
      {
       int val=atoi(p);
       int attrid= dict_add(&sATTRS,meta+5);
      }
     else
      {
       int  attrid= dict_add(&sATTRS,meta+5);
       char szDESC[DESC_MAXSIZE]="";
       sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);          
       handleSETS(szDESC);
       dict_add(&sDESC,szDESC);
      }
    }
   else
   if(cIsIn(meta,"|room|location|"))
    {
     strcpy(room,p);
     dict_add(&sROOM,p);kind=3;
    }
   else
   if(cIsIn(meta,"|obj|withobj|")||(dict_find(&sOBJCLS,meta)!=-1))
    {
     int already=0;
     if(p&&strstr(p,"berries"))
      already=0;
     if(strcmp(meta,"withobj")==0)
      already=1;
     if (cIsIn(meta, "|withobj|"))
      ;
     else
      kind=2;
     if(p)
      {
      string_gettoken(p,meta,'|');
      if((*meta=='"')&&(meta[strlen(meta)-1]=='"'))
       {
        meta[strlen(meta)-1]=0;
        string_delete(meta,0,1);
       }
      if(*meta=='$')
       ;
      else
      if(dict_find(&sOBJ,meta)==-1)
       {
        char mmeta[256]={0};
        if(*room) {strcpy(mmeta,room);strcat(mmeta,".");}
        strcat(mmeta,meta);
        objid=addOBJ(mmeta,p);//dict_addEx(&sOBJ,mmeta,-1,(u8*)p,strlen(p)+1);
       }
      }     
    }
   else   
   if((cIsIn(meta,"|msgobj|msgroom|msgattr|")&&(loc=1))||(loc=stringcheck(meta,"msg")))
    if(*p=='$')
     ;
    else
    {
     char szDESC[DESC_MAXSIZE]="",szDESC2[DESC_MAXSIZE],szDESC3[DESC_MAXSIZE],szDESC4[DESC_MAXSIZE];
     sz=getDESC(p,sz,szDESC,tab+1,szDESC2,szDESC3,szDESC4);          
     if(loc>0)
      {
      addMSG(szDESC);
      if(*szDESC2)
       addMSG(szDESC2);
      if(*szDESC3)
       addMSG(szDESC3);
      if(*szDESC4)
       addMSG(szDESC4);
      }
    }
  }
}

void addobjsyns(int syn,int refid,int roomid)
{
 int fnd=0;
 if((syn==19)||(refid==19))
  fnd++;
 roomobjsynids[iroomobjsynids*3+0]=syn;
 roomobjsynids[iroomobjsynids*3+1]=roomid;
 roomobjsynids[iroomobjsynids*3+2]=refid;
 iroomobjsynids++;

 if((objsynids[syn]==255)||(objsynids[syn]==refid))
  objsynids[syn]=refid;
 else
  needroomobjs++;
}

int getDESCID(const char*szDESC)
{
 int id=dict_find(&sDESC,szDESC);
 if(id>=240)
  ERR("getDESCID too hight",szDESC);
 return id;
}

const char*handleobj(const char*sz,const char*objs,int tab,const char*roomname,int roomid,int classid)
{
 int objid,loc,already=0;
 char line[8192],meta[256],obj[256];
 char synonyms[512]={0},thename[256]={0},isclass=0,localobj=0,skipped=0;
 u8*pobjartId=objartId;
 u8*pobjadjId=objadjId;
 u8*pobjgenId=objgenId;
 u8*pobjsynId=objsynId;
 u8*pobjcapacity=objcapacity;
 u8*pobjsize=objsize;

 u8*pobjnameId=objnameId;
 u8*pobjdescId=objdescId;
 u8*pobjloc=objloc;
 u8*pobjattr=objattr;
 u8*pobjimg=objimg;
 u8*psynids=objsynids;
 const char*p; 
  
 string_gettoken(objs,obj,'|');
 if((*obj=='"')&&(obj[strlen(obj)-1]=='"'))
  {
   obj[strlen(obj)-1]=0;
   string_delete(obj,0,1);
  }
 
 objid=dict_find(&sOBJ,obj);
 if(roomname&&*roomname)
  {
   char robj[256];
   sprintf(robj,"%s.%s",roomname,obj);
   objid=dict_find(&sOBJ,robj);
   if(objid!=-1)
    {strcpy(obj,robj);localobj=1;}
   else
    objid=dict_find(&sOBJ,obj);
  }
 else
  objid=dict_find(&sOBJ,obj);
 if(objid==-1)
  {
   objid=dict_find(&sOBJCLS,obj);
   if(objid!=-1)
    {
     isclass=1;
     pobjnameId=cobjnameId;
     pobjdescId=cobjdescId;
     pobjloc=cobjloc;
     pobjattr=cobjattr;
     pobjimg=cobjimg;
    }
  }
 else 
  if(classid!=-1)
   if(objattr[objid]==0)
    objattr[objid]=cobjattr[classid];
   else
    if(localobj)
     objattr[objid]=cobjattr[classid];
    else
     skipped++;

 // vanno gestite le istanze LOCALI
 if((objid!=-1)&&(roomid!=-1))
  if(pobjloc[objid]==255)
   pobjloc[objid]=roomid;
  else
   if(localobj)
    pobjloc[objid]=roomid;
   else
    skipped++;
 
 if(objid==-1)
  ERR(line,obj);

 while(sz&&S_tabcount(sz,tab+1))
 {
  int fnd=0,tab=0;
  sz=local_S_getline(sz,line);
  while(line[tab]=='\t') tab++;
  string_trim(line,line);
  if(*line==0)
   continue;
  if(strstr(line,"berries"))
   fnd++;
  p=string_gettoken(line,meta,':');      
  if(cIsIn(meta,"|note|notes|drawnotes|imagedesc|")||(*meta=='_'))
   {
    if(strstr(line,":"))
     ;
    else
     {
      char szDESC[DESC_MAXSIZE];
      if(p==NULL) p="";
      sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);
     }
   }
  else
  if(cIsIn(meta,"|startin|startat|"))
  {
   while(p)
   {
    char szattr[256];
    int  lvarid;
    p=string_gettoken(p,szattr,'+');
    lvarid=dict_find(&sROOM,szattr);
    if(lvarid!=-1)
     pobjloc[objid]=lvarid;
    else
     if(strcmp(szattr,"$inventory")==0)
      pobjloc[objid]=meta_inventory;
     else
      {
       lvarid=dict_find(&sMETA,szattr);
       if(lvarid!=-1)
        pobjloc[objid]=lvarid+meta_base;
       else
        {
         lvarid=dict_find(&sOBJ,szattr);
         if(lvarid!=-1)
          pobjloc[objid]=lvarid;
        }
      }
   }
  }
  else
  if(cIsIn(meta,"|capacity|size|"))
  {
   while(p)
   {
    char szattr[256];
    p=string_gettoken(p,szattr,'+');
    if(*meta=='c')
     pobjcapacity[objid]=atoi(szattr);
    else
     pobjsize[objid]=atoi(szattr);
   }
  }
  else
  if(cIsIn(meta,"|attr|"))
  {
   while(p)
   {
    char szattr[256];
    int  lvarid;
    p=string_gettoken(p,szattr,'+');
    if(strcmp(szattr,"$none")==0)
     pobjattr[objid]=0;
    else
     {
      lvarid=dict_find(&sATTR,szattr);
      if(lvarid==-1)
      {
       dict_add(&sATTR,szattr);
       lvarid=dict_find(&sATTR,szattr);
      }
      pobjattr[objid]|=mask[lvarid];
     }
   }
  }
  else
  if(cIsIn(meta,"|verb|")||(dict_find(&sVRBCLS,meta)!=-1))
   {
    char tkn[256];
    int  vrbid;
    const char*vsyn=string_gettoken(p,tkn,'|');    
    if(strstr(tkn,","))
     ERR(line,tkn);
    if(*tkn=='$')
     {
      vrbid=dict_find(&sMETA,tkn);
      if(vrbid!=-1)
       vrbid+=meta_base;
     }
    else
     vrbid=dict_find(&sVRB,tkn);
    if(vrbid!=-1)
    {
     if(sz&&(S_tabcount(sz,tab+1)==0)&&(memcmp(sz+tab,"verb:",5)==0))
      {
       const char*psz=sz;
       while(psz)
       {
        char       vrb[256];
        const char*npsz=string_getline(psz,line);
        string_trim(line,line);
        if(*line==0)
         continue;
        string_gettoken(line,vrb,':');
        if(cIsIn(vrb,"verb"))
         {
          psz=npsz;
          continue;
         }
        else
         break;
       }
       binstart=opcodes.c;
       
       addOPCODE(&opcodes,getCMD("withobj")+128);
       addOPCODE(&opcodes,objid);

       while(psz&&S_tabcount(psz,tab+1))
        psz=handleaction(psz,&opcodes,vrbid,NULL,roomname);
       
       emitstream(vrbid,roomid,&opcodes,binstart);
       while(vsyn)
        {
         vsyn=string_gettoken(vsyn,tkn,'|');    
         if(*tkn=='$')
          {
           vrbid=dict_find(&sMETA,tkn);
           if(vrbid!=-1)
            vrbid+=meta_base;
          }
         else
          vrbid=dict_find(&sVRB,tkn);
         if(vrbid==-1)
          ERR(line,tkn);
         else
          emitstream(vrbid,roomid,&opcodes,binstart);
        }
      }
     else
      {
       binstart=opcodes.c;

       addOPCODE(&opcodes,getCMD("withobj")+128);
       addOPCODE(&opcodes,objid);
       
       while(sz&&S_tabcount(sz,tab+1))
        sz=handleaction(sz,&opcodes,vrbid,NULL,roomname);      
       
       emitstream(vrbid,roomid,&opcodes,binstart);
       while(vsyn)
        {
         vsyn=string_gettoken(vsyn,tkn,'|');    
         if(*tkn=='$')
          {
           vrbid=dict_find(&sMETA,tkn);
           if(vrbid!=-1)
            vrbid+=meta_base;
          }
         else
          vrbid=dict_find(&sVRB,tkn);
         if(vrbid==-1)
          ERR(line,tkn);
         else
          emitstream(vrbid,roomid,&opcodes,binstart);
        }
     }

    }     
   }
  else
  if(cIsIn(meta,"|art|article|art_it|"))
   {
    char szDESC[DESC_MAXSIZE]="";
    int  id,err=0;
    sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);          
    id=dict_find(&sARTS,szDESC);
    if(id!=-1)
     pobjartId[objid]=id;
    else
     err++;
   }
  else
  if(cIsIn(meta,"|adj|adjective|adj_it|"))
   {
    char szDESC[DESC_MAXSIZE]="";
    int  id,err=0;
    sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);          
    id=dict_find(&sADJS,szDESC);
    if(id!=-1)
     pobjadjId[objid]=id;
    else
     err++;
   }
  else
  if((loc=stringcheck(meta,"syn"))||(loc=stringcheck(meta,"synonym")))
   {
    char szDESC[DESC_MAXSIZE]="";
    int  id,err=0;
    if(loc>0)
     {
      int nsyns,synids[64];
      strcpy(synonyms,p);
      nsyns=getLIST(&sOBJSYNS,p,",+|",1,&synids[0]);
      while(nsyns--)
       addobjsyns(synids[nsyns],objid,roomid);
       //psynids[synids[nsyns]]=objid;
      id=0;
      id=0;
     }
    /*sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);          
    id=dict_find(&sSYNS,szDESC);
    if(id!=-1)
     pobjsynId[objid]=id;
    else
     err++;*/
   }
  else
  if(loc=stringcheck(meta,"name"))
   {
    char szDESC[DESC_MAXSIZE]="";
    int  id,err=0;
    sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);          
    if(loc>0)
     {
      strcpy(thename,szDESC);
      id=dict_find(&sNAMES,szDESC);
      if(id!=-1)
       pobjnameId[objid]=id;
      else
       err++;
     }
   }
  else
  if(loc=stringcheck(meta,"desc"))
   {
    char szDESC[DESC_MAXSIZE],szDESC2[DESC_MAXSIZE],szDESC3[DESC_MAXSIZE],szDESC4[DESC_MAXSIZE];
    int  id;
    if(p==NULL)
     ;
    else
     sz=getDESC(p,sz,szDESC,tab+1,szDESC2,szDESC3,szDESC4);
    if(loc>0)
     {
      extractSCENERY(szDESC,NULL);
      id=getDESCID(szDESC);
      if(id!=-1)
       pobjdescId[objid]=id;
     }
   }
  else
  if(cIsIn(meta,"|image|"))
   {        
    char cmd[256];
#if !defined(HANDLE_IMAGES)    
    sprintf(cmd,"..\\..\\..\\bin\\bin2h.exe -i %s -o itembitmap%02d.h -n itembitmap%02d -dither 8 -bkcol 0 -contrast 1 -sharpen 1 -ob img\\item%02d\n",p,smallimages+1,smallimages+1,smallimages+1);
    file_writes(hfIMAGEBAT,cmd);        
#endif    
    sprintf(cmd,"c1541.exe %%1 -write res/img/item%02d item%02d\r\n",smallimages+1,smallimages+1);
    file_writes(hfIMAGEBAT2,cmd);    
    pobjimg[objid]=smallimages++;
   }
 }

 if(isclass==0)
  {
   if(*synonyms==0)
   {
    int nsyns,synids[64];
    strcpy(synonyms,objs);
    nsyns=getLIST(&sOBJSYNS,synonyms,",+|",1,&synids[0]);
    while(nsyns--)
     addobjsyns(synids[nsyns],objid,roomid);
     //psynids[synids[nsyns]]=objid;
   }
   if(*thename==0)
   {
    int err=0,id=dict_find(&sNAMES,obj);
    if(id!=-1)
     pobjnameId[objid]=id;
    else
     err++;
   }
  }
 if(pobjnameId[objid]==-1)
 {
 }
 if(objsynId[objid]==-1)
 {
 }

 if(objattr[9]==1)
 {
  int k;
  k=0;
 }

 return sz;
}

const char*sztabs(int tabs)
{
 static char tab[64];
 int         t=0;
 while(tabs--)
  tab[t++]='\t';
 tab[t]=0;
 return tab;
}

void handlewptext(const char*d,char*desc,int tabs)
{
 while(d)
  {
   char szD[512];
   d=string_gettoken(d,szD,'*');
   string_trim(szD,szD);
   if(*szD=='?')
   {
    if(szD[1]=='<')
    {
     tabs--;
     strcat(desc,"\r\n");strcat(desc,sztabs(tabs));strcat(desc,"endif");
    }
    else
    if(szD[1]=='>')
    {
     tabs--;
     strcat(desc,"\r\n");strcat(desc,sztabs(tabs));strcat(desc,"else");
     tabs++;
    }
    else
    if(szD[1]=='!')
    {
     strcat(desc,"\r\n");strcat(desc,sztabs(tabs));
     if(szD[2]=='$')
      {strcat(desc,"ifobjin:");strcat(desc,szD+3);strcat(desc,",$nowhere");}
     else
      {strcat(desc,"ifnot:");strcat(desc,szD+2);}
     tabs++;
    }
    else
    {
     strcat(desc,"\r\n");strcat(desc,sztabs(tabs));
     if(szD[1]=='$')
      {strcat(desc,"ifobjin:");strcat(desc,szD+2);strcat(desc,",$inventory");}
     else
      {strcat(desc,"if:");strcat(desc,szD+1);}
     tabs++;
    }
   }
   else
   if(*szD=='$')
    {
     strcat(desc,"\r\n");strcat(desc,sztabs(tabs));
     if(szD[1]=='+')
      {strcat(desc,"set:");strcat(desc,szD+2);}
     else
      if(szD[1]=='+')
       {strcat(desc,"unset:");strcat(desc,szD+2);}
      else
       if(szD[1]=='$')
        if(szD[2]=='+')
         {strcat(desc,"putobj:");strcat(desc,szD+3);strcat(desc,",$inventory");}
        else
         if(szD[2]=='+')
          {strcat(desc,"putobj:");strcat(desc,szD+3);strcat(desc,",$here");}
    }
   else
    {
     strcat(desc,"\r\n");strcat(desc,sztabs(tabs));
     strcat(desc,"msg:");strcat(desc,szD);
    }
  }
}

const char*handleroom(const char*sz,const char*p,int tab)
{
 char line[8192],meta[256],roomname[256]; 
 int roomid=dict_find(&sROOM,p),fnd=0,loc;
 strcpy(roomname,p);
 //printf("room: %s        \r",roomname);
 if(cIsIn(p,"|forsakenpath|"))
  fnd=1;
 while(sz&&S_tabcount(sz,tab+1))
 {      
  const char*obj=NULL;
  char vrb[32];
  int tab=0,classid=-1;
  sz=local_S_getline(sz,line);
  while(line[tab]=='\t') tab++;
  string_trim(line,line);
  if(*line==0)
   continue;
  p=string_gettoken(line,meta,':');      
 if(cIsIn(meta,"|note|notes|drawnotes|imagedesc|")||(*meta=='_'))
  {
   if(strstr(line,":"))
    ;
   else
    {
     char szDESC[DESC_MAXSIZE];
     if(p==NULL) p="";
     sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);
    }
  }
 else
 if(cIsIn(meta,"|shared|"))
  {
  }
 else
 if(cIsIn(meta,"|onfirst|onenter|onleave|onturn|ondesc|"))
  {
   int vrbid;
   vrbid=dict_find(&sVRB,meta);
   if(vrbid!=-1)
    {
     
     binstart=opcodes.c;

     while(sz&&S_tabcount(sz,tab+1))
      sz=handleaction(sz,&opcodes,vrbid,NULL,roomname);      

     emitstream(vrbid,roomid,&opcodes,binstart);

    }
  }
  else
  if(cIsIn(meta,"|obj|")||((classid=dict_find(&sOBJCLS,meta))!=-1))
   sz=handleobj(sz,p,tab,roomname,roomid,classid);
  else
  if(cIsIn(meta,"|verb|")||(dict_find(&sVRBCLS,meta)!=-1))
  {
   int  vrbid,multi=0;
   char synonyms[512]={0};
   const char*vsyn=string_gettoken(p,vrb,'|');
   if(strstr(vrb,","))
    ERR(line,vrb);
   if(*vrb=='$')
    {
     vrbid=dict_find(&sMETA,vrb);
     if(vrbid!=-1)
      vrbid+=meta_base;
    }
   else
    vrbid=dict_find(&sVRB,vrb);
   if(vrbid==-1)
    ERR(line,vrb);
   else
    {
     if(sz&&(S_tabcount(sz,tab+1)==0)&&(memcmp(sz+tab,"verb:",5)==0))
      {
       const char*psz=sz;
       while(psz)
       {
        char       vrb[256];
        const char*npsz=string_getline(psz,line);
        string_trim(line,line);
        if(*line==0)
         continue;
        string_gettoken(line,vrb,':');
        if(cIsIn(vrb,"verb"))
         {
          psz=npsz;
          continue;
         }
        else
         break;
       }
       binstart=opcodes.c;
       if(obj)
       {
        int objid=dict_find(&sOBJ,obj);
        if(objid!=-1)
         {
          addOPCODE(&opcodes,getCMD("withobj")+128);
          addOPCODE(&opcodes,objid);
         }
        else
         ERR(line,obj);
       }
       while(psz&&S_tabcount(psz,tab+1))
        psz=handleaction(psz,&opcodes,vrbid,synonyms,roomname);

       emitstream(vrbid,roomid,&opcodes,binstart);
       while(vsyn)
        {
         char tkn[256];
         vsyn=string_gettoken(vsyn,tkn,'|');    
         if(*tkn=='$')
          {
           vrbid=dict_find(&sMETA,tkn);
           if(vrbid!=-1)
            vrbid+=meta_base;
          }
         else
          vrbid=dict_find(&sVRB,tkn);
         if(vrbid==-1)
          ERR(line,tkn);
         else
          emitstream(vrbid,roomid,&opcodes,binstart);
        }
      }
     else
      {
       binstart=opcodes.c;

       if(obj)
       {
        int objid=dict_find(&sOBJ,obj);
        if(objid!=-1)
         {
          addOPCODE(&opcodes,getCMD("withobj")+128);
          addOPCODE(&opcodes,objid);
         }
        else
         ERR(line,obj);
       }

       while(sz&&S_tabcount(sz,tab+1))
        sz=handleaction(sz,&opcodes,vrbid,synonyms,roomname);

       emitstream(vrbid,roomid,&opcodes,binstart);
       while(vsyn)
        {
         char tkn[256];
         multi=1;
         vsyn=string_gettoken(vsyn,tkn,'|');    
         if(*tkn=='$')
          {
           vrbid=dict_find(&sMETA,tkn);
           if(vrbid!=-1)
            vrbid+=meta_base;
          }
         else
          vrbid=dict_find(&sVRB,tkn);
         if(vrbid==-1)
          ERR(line,tkn);
         else
          emitstream(vrbid,roomid,&opcodes,binstart);
        }
     }
     if(multi)
      ;
     else
     if(*synonyms==0)
      {
       int nsyns,synids[32];
       nsyns=getLIST(&sVRBSYNS,vrb,",+|",1,&synids[0]);
       while(nsyns--)
        vrbsynids[synids[nsyns]]=vrbid;
      }
    }
  }
  else
  if(loc=stringcheck(meta,"name"))
  {
   int id=dict_find(&sNAMES,p);
   if(loc>0)
    if(id!=-1)
     roomnameId[roomid]=id;
  }
  else
  if(loc=stringcheck(meta,"desc"))
   {
    char szDESC[DESC_MAXSIZE];
    int  id;
    sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);
    if(loc>0)
     {
      extractSCENERY(szDESC,&sSCENERY);
      id=getDESCID(szDESC);
      if(id!=-1)
       roomdescId[roomid]=id;
      if(sSCENERY.nstrings)
       {
        int i;
        for(i=0;i<sSCENERY.nstrings;i++)
        {
         char desc[8192];
         char msg[4096],objvrb[256];
         int  classid=dict_find(&sOBJCLS,"scenery");
         u16 w;
         dict_getEx(&sSCENERY,i,objvrb,NULL,(u8*)msg,&w);
         if(strstr(objvrb,".")||strstr(msg,"*"))
          {           
           char*p,*pp=NULL;           
           p=strstr(objvrb,".");
           if(p)
            {
            *p++=0;
            pp=strstr(p,".");
            if(pp)
             *pp++=0;
            }
           else
            {
             p="x";pp=NULL;
            }
           if(pp)
            {             
             const char*o=pp;
             while(o)
              {
               char obj2[256];
               int  tabs=4;
               const char*d=msg;
               o=string_gettoken(o,obj2,'+');
               strcpy(desc,"\t\tverb:");strcat(desc,p);
               strcat(desc,"\r\n\t\t\twithobj:");strcat(desc,obj2);
               
               handlewptext(d,desc,tabs);

               handleobj(desc,objvrb,1,roomname,roomid,classid);
              }
            }
           else
            {
             const char*d=msg;
             int        tabs=3;
             strcpy(desc,"\t\tverb:");strcat(desc,p);
             handlewptext(d,desc,tabs);                                       
             handleobj(desc,objvrb,1,roomname,roomid,classid);
            }            
          }
         else
          {
           const char*d=msg;
           while(d)
            {
             char szD[512];
             d=string_gettoken(d,szD,'*');
             string_trim(szD,szD);
             strcpy(desc,"\t\tdesc:");strcat(desc,szD);
             handleobj(desc,objvrb,1,roomname,roomid,classid);
            }
          }
        }
        dict_softreset(&sSCENERY);
       }
     }
   }
  else
  if(memcmp(meta,"attr.",5)==0)
   {
    char*pdot=strstr(meta,":");
    if(pdot)
     {
      *pdot++=0;
      if(isdigit(*pdot))
       {
        int val=atoi(pdot);
        int attrid=dict_add(&sATTRS,meta+5);
        BUF_safeadd(roomattrs,u8,attrid);
        BUF_safeadd(roomattrs,u8,roomid);        
        BUF_safeadd(roomattrs,u8,val);
       }
     }
    else
     {
     char szDESC[DESC_MAXSIZE];
     int  id;
     sz=getDESC(p,sz,szDESC,tab+1,NULL,NULL,NULL);
     handleSETS(szDESC);
     //if(loc>0)
      {
       int attrid=dict_add(&sATTRS,meta+5);
       id=getDESCID(szDESC);
       if(id>255)
        ERR("roomattr out of range",szDESC);
       if(id!=-1)
        {
         BUF_safeadd(roomattrs,u8,attrid);
         BUF_safeadd(roomattrs,u8,roomid);        
         BUF_safeadd(roomattrs,u8,id);
        }
      }
     }
   }
  else
  if(cIsIn(meta,"|image|"))
   addroomimage(roomname,roomid,p);
  else
  if(cIsIn(meta,"|end|"))
   break;
  else
   if(isalpha(meta[0])&&isalpha(meta[1])&&(meta[2]=='.')&&cIsIn(meta+3,"|name|desc|synonym|syn|msg|"))
    ;
   else
    ERR(line,meta);
 } 
 return sz;
}
   

void adv_parse(const char*szPath,const char*szPath2,const char*sz,int way)
{
 while(sz&&*sz)
 {
    char line[8192],meta[256];
    const char*p;
    int        tab=0,classid=-1,check=0;
    sz=local_S_getline(sz,line);
    while(line[tab]=='\t') tab++;
    string_trim(line,line);
    if(*line==0)
     continue;
    p=string_gettoken(line,meta,':');

    if(gfat[20*FAT_SIZE+fat_verb])
     check++;

    if(strcmp(line,"room:gasroom")==0)
     check++;

    if(cIsIn(meta,"|include|"))
     {
      u8*p2;
      char szFN[256];
      string_gettoken(p,meta,',');
      sprintf(szFN,"%s%s",szPath,meta);
      if(file_readfile(szFN,&p2)>0)
      {
       p2=(u8*)clean((char*)p2,szFN);
       adv_parse(szPath,szPath2,(char*)p2,way);
       FREE(p2)
      }
      else
       ERR(line,meta);
     }
    else        
    if(cIsIn(meta,"|verb|verbclass|")||(dict_find(&sVRBCLS,meta)!=-1))
    {
     char tkn[256];
     int  vrbid,classid=-1;           
     string_gettoken(p,tkn,'|');
     if(*tkn=='$')
      {
       vrbid=dict_find(&sMETA,tkn);
       if(vrbid!=-1)
        vrbid+=meta_base;
      }
     else
     if(cIsIn(meta,"|verbclass|"))
      {
       vrbid=dict_find(&sVRBCLS,tkn);
       if(vrbid!=-1)
        vrbid+=(meta_base-sVRBCLS.nstrings);
      }     
     else
      {
       vrbid=dict_find(&sVRB,tkn);
       classid=dict_find(&sVRBCLS,meta);
       
       vrbcls[ivrbcls++]=vrbid;
       vrbcls[ivrbcls++]=classid+(meta_base-sVRBCLS.nstrings);
       
       if(classid!=-1)
        {
         int k;
         k=0;
        }
      }
     if(vrbid!=-1)
      {
       char synonyms[512]={0};
       if(sz&&(S_tabcount(sz,tab+1)==0)&&(memcmp(sz+tab,"verb:",5)==0))
        {
         const char*psz=sz;
         while(psz)
         {
          char       vrb[256];
          const char*npsz=string_getline(psz,line);
          string_trim(line,line);
          if(*line==0)
           continue;
          string_gettoken(line,vrb,':');
          if(cIsIn(vrb,"verb"))
           {
            psz=npsz;
            continue;
           }
          else
           break;
         }
         binstart=vopcodes.c;
         while(psz&&S_tabcount(psz,tab+1))
          psz=handleaction(psz,&vopcodes,vrbid,synonyms,NULL);      
         emitstream(vrbid,-2,&vopcodes,binstart);
        }
       else
        {
         binstart=vopcodes.c;
         while(sz&&S_tabcount(sz,tab+1))
          sz=handleaction(sz,&vopcodes,vrbid,synonyms,NULL);      
         emitstream(vrbid,-2,&vopcodes,binstart);
        }
       if(cIsIn(meta,"|verbclass|"))
        ;
       else
       if(*tkn=='$')
        ;
       else
       if(cIsIn(tkn,"|onfirst|onenter|onleave|onturn|ondesc|"))
        ;
       else
       if(*synonyms==0)
        {
         int nsyns,synids[32];
         nsyns=getLIST(&sVRBSYNS,tkn,",+|",1,&synids[0]);
         while(nsyns--)
          vrbsynids[synids[nsyns]]=vrbid;
        }
      }     
    }
    else
    if(cIsIn(meta,"|obj|objclass|")||((classid=dict_find(&sOBJCLS,meta))!=-1))
     {
      if(p)
       sz=handleobj(sz,p,tab,"",-1,classid);
     }
    else
    if(cIsIn(meta,"|room|"))
     {
      if(p)
       sz=handleroom(sz,p,tab);
     }
    
    if(gfat[20*FAT_SIZE+fat_verb])
     check++;
   }
}

void emitattrBYTE(HANDLE hf,const char*prefix,const u8*objnameId,int nstrings)
{
 if(mem.mem)
  {
   u16 w=mem.c;
   int  i;
   BUF_safeadd(memidx,u16,w)
   dict_add(&sTNAMES,prefix);
   if(nstrings==0)
    BUF_safeadd(mem,u8,255)
   else
    for(i=0;i<nstrings;i++)
    {
     u8 b=(u8)objnameId[i];
     BUF_safeadd(mem,u8,b)
    }
  }
}

void emitattrWORD(HANDLE hf,const char*prefix,const u16*objnameId,int nstrings)
{
 if(mem.mem)
  {
   u16 w=mem.c;
   int  i;
   BUF_safeadd(memidx,u16,w)
   dict_add(&sTNAMES,prefix);
   if(nstrings==0)
    BUF_safeadd(mem,u8,255)
   else
    for(i=0;i<nstrings;i++)
    {
     u8 b=(objnameId[i]&0xFF);
     BUF_safeadd(mem,u8,b)
     b=((objnameId[i]>>8)&0xFF);
     BUF_safeadd(mem,u8,b)
    }
  }
}

void emitattrex(HANDLE hf,const char*prefix,int nstrings,const unsigned char*objnameId,int size)
{
  if(mem.mem)
  {
   int  i;
   u16 w=mem.c;   
   BUF_safeadd(memidx,u16,w)
   dict_add(&sTNAMES,prefix);
   if(nstrings==0)
    if(objnameId)
     BUF_safeadd(mem,u8,255)
    else
     ;
   else
    for(i=0;i<nstrings;i++)
     BUF_safeadd(mem,u8,objnameId[i])
  }
  else
   {
   char out[256];
   u16*objnameId16 = NULL;
   if (size == 1)
    ;
   else
    objnameId16 = (u16*)objnameId;
   if(nstrings==0)
   {
    if(size==1)
     sprintf(out,"u8 %s[1]={255};\r\n",prefix);
    else
     sprintf(out, "u16 %s[1]={255};\r\n", prefix);
    file_writes(hf,out);
   }
   else
    {   
    int  i;
    if (size == 1)
     sprintf(out,"u8 %s[%d]={",prefix,nstrings);
    else
     sprintf(out, "u16 %s[%d]={", prefix, nstrings);
    file_writes(hf,out);
    for(i=0;i<nstrings;i++)
    {
     if(i)
       file_writes(hf,",");
     if (size == 1)
      sprintf(out,"%d",objnameId[i]);
     else
      sprintf(out, "%d", objnameId16[i]);
     file_writes(hf,out);
    }
    sprintf(out,"};\r\n");
    file_writes(hf,out);
    }
   }
}

void emitattr(HANDLE hf, const char*prefix, int nstrings, const unsigned char*objnameId)
{
 emitattrex(hf, prefix, nstrings, objnameId, 1);
}

int twoint_compare(const void*a,const void*b)
{
 int*A=(int*)a;
 int*B=(int*)b;
 return B[1]-A[1];
}

const char*SHORTMSG(const char*s)
{
 static char what[256];
 int         i=0;
 while(s[i]&&(i<64))
  if((s[i]=='\r')||(s[i]=='\n'))
   {strcpy(what+i,"...");break;}
  else
   {what[i]=s[i];i++;}
 if(s[i])
  strcpy(what+i,"...");
 else
  what[i]=0;
 return what;
}

u16 jump_table[256+2];

void opcodeDUMP(const char*fn)
{
 HANDLE hf=file_create(fn);
 int vv;
 for(vv=0;vv<ifat;vv++)
  {
   int v=vv*FAT_SIZE;
   int vrb=gfat[v+fat_verb];
   int room=gfat[v+fat_room];
   int codeidx=gfat[v+fat_pointer],ln,j,t;
   char out[512],sroom[128];
   u8*p;
   
   if(isbetween(room,0,sROOM.nstrings-1))
    strcpy(sroom,sROOM.str +sROOM.idx[room]);
   else 
    strcpy(sroom,"$everywhere");

   if(cIsIn(sVRB.str +sVRB.idx[vrb],"kill"))
    ln=0;
    
   if(vrb<sVRB.nstrings)
    sprintf(out,"%s[%d]::%s[%d] = $%02x/%d\r\n",sVRB.str +sVRB.idx[vrb],vrb,sroom,room,codeidx,codeidx);
   else
    if(vrb==255)
     sprintf(out,"%s[%d]::%s[%d] = $%02x/%d\r\n","$unknown",vrb,sroom,room,codeidx,codeidx);
    else
     sprintf(out,"%s[%d]::%s[%d] = $%02x/%d\r\n",sVRB.str +sVRB.idx[vrb],vrb,sroom,room,codeidx,codeidx);

   file_writes(hf,out);
   ln=clen[codeidx];
   p=file+cpos[codeidx];
   j=0;t=1;
   while(j<ln)
    {
     int op=p[j];
     int cnt;
     char szCMD[256];
     int jlen,n;
     u16 w;
     dict_getEx(&sCMD,op-128,szCMD,&cnt,(u8*)&jlen,&w);
     if((memcmp(szCMD,"end",3)==0)||(memcmp(szCMD,"else",4)==0))
      t--;
     if((t<0)||(t>8))
      t=0;
     for(n=0;n<t;n++)
      out[n]='\t';
     if((jlen&127)==2)
      {
       int param=p[j+1];
       if((cnt&bit_OBJ)&&isbetween(param,0,sOBJ.nstrings-1))
        sprintf(out+t,"%s::[%d]%s\r\n",szCMD,param,sOBJ.str +sOBJ.idx[param]);
       else
        if((cnt&bit_OBJ)&&isbetween(param,meta_base,255))
         sprintf(out+t,"%s::[%d]%s\r\n",szCMD,param,sMETA.str +sMETA.idx[param-meta_base]);
        else
        if((cnt&bit_ROOM)&&isbetween(param,0,sROOM.nstrings-1))
         sprintf(out+t,"%s::[%d]%s\r\n",szCMD,param,sROOM.str +sROOM.idx[param]);
        else
         if((cnt&bit_MSG)&&isbetween(param,0,sMSG.nstrings-1))
          if(strcmp(szCMD,"msg2")==0)
           sprintf(out+t,"%s::[%d]%s\r\n",szCMD,param,SHORTMSG(sMSG2.str +sMSG2.idx[param+255]));
          else
           sprintf(out+t,"%s::[%d]%s\r\n",szCMD,param,SHORTMSG(sMSG.str +sMSG.idx[param]));
         else
          if((cnt&bit_BITVAR)&&isbetween(param,0,sBITVAR.nstrings-1))
           sprintf(out+t,"%s::[%d]%s\r\n",szCMD,param,sBITVAR.str +sBITVAR.idx[param]);
          else
           if((cnt&bit_VAR)&&isbetween(param,0,sVAR.nstrings-1))
           sprintf(out+t,"%s::[%d]%s\r\n",szCMD,param,sVAR.str +sVAR.idx[param]);
           else
            sprintf(out+t,"%s[%d]::%d\r\n",szCMD,op,param);
      }
     else
      sprintf(out+t,"%s[%d]\r\n",szCMD,op);
     file_writes(hf,out);
     j+=(jlen&127);
     if((memcmp(szCMD,"if",2)==0)||(memcmp(szCMD,"withobj",7)==0)||(memcmp(szCMD,"else",4)==0))
      t++;
    }
  }
 file_close(hf);
}

const char*getdesc(const char*s,char*desc)
{
 int d=0;
 while(*s&&(*s!='"')) s++;
 if(*s=='"')
  {
   int d=0;
   s++;
   while(*s&&(*s!='"')) 
    if((*s=='\r')||(*s=='\n'))
     {
      if(d&&(desc[d-1]!=' '))
       desc[d++]=' ';
      s++;
     }
    else
     if(*s=='\\')
      {
       s++;
       desc[d++]=*s++;
      }
     else
      desc[d++]=*s++;
   if(*s=='"')
    s++;
   desc[d]=0;
   if(d>512)
    d=512;
   if(*s==')')
    {     
     return s+1;
    }
   else
    return "";
 }
 else
  return "";
}


void imageshow(const char*name,int argc,const char*argv[]);
int  roomobjsyns_compare_simple(const void*a,const void*b)
{
 u8*A=(u8*)a;
 u8*B=(u8*)b;
 int dif=A[0]-B[0];
 return dif;
}
int  roomobjsyns_compare(const void*a,const void*b)
{
 u8*A=(u8*)a;
 u8*B=(u8*)b;
 int dif=A[0]-B[0];
 if(dif) return dif;
 dif=A[1]-B[1];
 if(dif) return dif;
 dif=A[2]-B[2];
 return dif;
}

#define skip_objimg     1
#define skip_roomovrimg 2

int attrs_compare(const void*a,const void*b)
{
 u8*A=(u8*)a;
 u8*B=(u8*)b;
 int dif=A[0]-B[0];
 if(dif) return dif;
 dif=A[1]-B[1];
 if(dif) return dif;
 dif=A[2]-B[2];
 return dif;
}

u8 getemitflags()
{
 int i;
 u8  emit=0;
 for(i=0;i<sOBJ.nstrings;i++)
  if(objimg[i]!=255)
   break;
 if(i==sOBJ.nstrings)
  emit|=skip_objimg;
 for(i=0;i<sROOM.nstrings;i++)
  if(roomovrimg[i]!=255)
   break;
 if(i==sROOM.nstrings)
  emit|=skip_roomovrimg;
 return emit;
}

const char*dotfix(const char*s)
{
 static char ss[256];
 int i=0,j=0;
 while(s[i])
  if(s[i]=='.')
   {ss[j++]='_';i++;}
  else
   ss[j++]=s[i++];
 ss[j]=0;
 return ss;
}

void checksimilarity(dict*sNAMES,const char*kind)
{
 int i,j;
 for(i=0;i<sNAMES->nstrings-1;i++)        
 {  
  const char*s=sNAMES->str +sNAMES->idx[i];
  int ls=strlen(s);
  if(ls<128)
   for(j=i+1;j<sNAMES->nstrings;j++)
    {
     const char*t=sNAMES->str +sNAMES->idx[j];
     int lt=strlen(t);
     if(lt<128)
      if(abs(lt-ls)<4)
       {
        int val=levenshtein(s,t);
        if(val<4)
         {
          char out[512];
          sprintf(out,"%s: %s <> %s",kind,s,t);
          WARN("similar strings",out);
         }
       }
    }
 }
}

void bufferedimgs_start()
{
 BUF_set(imgrooms,RIMG,8)
}

int cpl_compare(const void*a, const void*b)
{
 u16*A = (u16*)a;
 u16*B = (u16*)b;
 return B[1] - A[1];
}

u8 cplfnd(u16 val, u16*cpl, u8 cplcnt)
{
 u8 i;
 for (i = 0; i < cplcnt; i++)
  if (cpl[i * 2] == val)
   return i;
 return 255;
}

u16 cplpack(u8*mem, u16 size,u8*outmem, u16*cpl, u8 cplcnt)
{
 u16 lastemitj=0,i=0,j=0,lost=0,lost2=0;
 while(i < size)
 {
  u8 code = 255;
  if (i + 1 < size)
   code = cplfnd(mem[i] + mem[i + 1] * 256,cpl, cplcnt);
  if (code == 255)
  {
   if ((lastemitj == j - 2) && (outmem[lastemitj] == 255))
    {
     outmem[lastemitj] = 254;
     outmem[j++] = mem[i];
     lost2++;
    }
   else
    {
     lastemitj = j;
     outmem[j++] = 255;
     outmem[j++] = mem[i];
     lost++;
    }
   i++;
  }
  else
  {
   outmem[j++] = code; i += 2;
  }
 }
 return j;
}

void packcolor(u8*col, u16 colsize, u8*halfcol)
{
 u16 i,j;
 for (j=i = 0; i < colsize; i += 2)
  halfcol[j++] = col[i] | (col[i + 1] << 4);
}

u16 huffpack_adddict(dict*d)
{
 u16 i,sum=0;
 for (i = 0; i<d->nstrings; i++)
 {
  char str[1024];
  u16  len;
  strcpy(str,d->str + d->idx[i]);
  len = petmapstring(str);
  huffpack_add(str, len);
  sum += len;
 }
 return sum;
}

u16 huffpack_packdict(dict*d,u8*buf)
{
 u16 i, sum = 0;
 for (i = 0;i< d->nstrings; i++)
 {
  char str[1024];
  u16  len;
  strcpy(str, d->str + d->idx[i]);
  len = petmapstring(str);  
  len = huffpack_pack(str, len, buf + sum+1);
  buf[sum] = len; sum++;
  sum += len;
 }
 return sum;
}

int CompressLZO(u8* dst, const u8* source, int size)
{
 int		csize = 0;

 int	pos = 0;
 while (pos < size)
 {
  int	pi = 0;
  while (pi < 127 && pos < size)
  {
   int	bi = pi, bj = 0;
   for (int i = 1; i < (pos < 255 ? pos : 255); i++)
   {
    int j = 0;
    while (j < 127 && pos + j < size && source[pos - i + j] == source[pos + j])
     j++;

    if (j > bj)
    {
     bi = i;
     bj = j;
    }
   }

   if (bj >= 4)
   {
    if (pi > 0)
    {
     int i;
     dst[csize++] = pi;
     for (i = 0; i < pi; i++)
      dst[csize++] = source[pos - pi + i];
     pi = 0;
    }

    dst[csize++] = 128 + bj;
    dst[csize++] = bi;
    pos += bj;
   }
   else
   {
    pos++;
    pi++;
   }
  }

  if (pi > 0)
  {
   int i;
   dst[csize++] = pi;
   for (i = 0; i < pi; i++)
    dst[csize++] = source[pos - pi + i];
  }
 }

 dst[csize++] = 0;

 return csize;
}


void bufferedimgs_end()
{
 if (1)
 {
  int i, w = 0, r = 0,ww=0;
  u8  buf[8 * 1024],obuf[8192];
  for (i = 0; i < imgrooms.c; i++)
  {
   int j, k = 0, z, b = 0,osz;
   if (1)
   {
    for (j = 0; j < imgrooms.mem[i].pos; j++)
     buf[k++] = imgrooms.mem[i].screen[j];
    for (j = 0; j < imgrooms.mem[i].pos; j++)
     buf[k++] = imgrooms.mem[i].color[j];
    for (j = 0; j < imgrooms.mem[i].pos; j++)
     for (z = 0; z < 8; z++)
      buf[k++] = imgrooms.mem[i].bitmap[b++];
   }
   else
    for (j = 0; j < imgrooms.mem[i].pos; j++)
    {
     buf[k++] = imgrooms.mem[i].screen[j];
     buf[k++] = imgrooms.mem[i].color[j];
     for (z = 0; z < 8; z++)
      buf[k++] = imgrooms.mem[i].bitmap[b++];
    }
   //w = CompressLZO(obuf, buf, k);
   if (k)
   {
    FILE*f = fopen("C:\\Users\\marco\\Downloads\\dark-0.51-win\\img.raw", "wb");
    fwrite(buf, 1, k, f);
    fclose(f);
   }
   r += k;
   osz=hpack(buf, 0, k, &obuf[0]);
   w += osz;
   huffpack_start();
   huffpack_add(obuf,osz);
   huffpack_calc();
   ww+= huffpack_pack(obuf, osz,buf);
   huffpack_end();
  }
  i = 0;
 }
 else
 if (1)
 {
  int i,sum=0,rsum=0;
  u8  buf[8 * 1024],col[1*1024];
  
  huffpack_start();

  for (i = 0; i < imgrooms.c; i++)
  {
   huffpack_add(imgrooms.mem[i].screen, imgrooms.mem[i].pos);
   packcolor(imgrooms.mem[i].screen, imgrooms.mem[i].pos, col);
   huffpack_add(col, imgrooms.mem[i].pos/2);
   huffpack_add(imgrooms.mem[i].bitmap, imgrooms.mem[i].bpos);
  }

  huffpack_calc();
  
  for (i = 0; i < imgrooms.c; i++)
  {
   u16 w,x;
   x = 0;

   w = huffpack_pack(imgrooms.mem[i].screen, imgrooms.mem[i].pos, buf + x);
   x += w; rsum += imgrooms.mem[i].pos;

   packcolor(imgrooms.mem[i].screen, imgrooms.mem[i].pos, col);
   w = huffpack_pack(col, imgrooms.mem[i].pos/2, buf + x);
   x += w; rsum += imgrooms.mem[i].pos;

   w = huffpack_pack(imgrooms.mem[i].bitmap, imgrooms.mem[i].bpos, buf + x);
   x += w; rsum += imgrooms.mem[i].bpos;

   sum += x;
  }
  huffpack_end();
 }
 else
 {
  int i, j, k, sum = 0, psum = 0, wsum = 0;
  int cnt[256 * 256];
  u16 cpl[256 * 256 * 2];
  u8  buf[8 * 1024], cplcnt;
  u16 x;
  memset(cnt, 0, sizeof(cnt));
  for (i = 0; i < imgrooms.c; i++)
  {
   u8*tmp = imgrooms.mem[i].screen;
   /*for (j = 0; j < imgrooms.mem[i].pos - 1; j++)
    cnt[tmp[j] + tmp[j + 1] * 256]++;
   tmp = imgrooms.mem[i].color;
   for (j = 0; j < imgrooms.mem[i].pos - 1; j++)
    cnt[tmp[j] + tmp[j + 1] * 256]++;*/
   tmp = imgrooms.mem[i].bitmap;
   for (j = 0; j < imgrooms.mem[i].bpos - 1; j++)
    cnt[tmp[j] + tmp[j + 1] * 256]++;
  }
  for (j = k = i = 0; i < 256 * 256; i++)
  {
   sum += cnt[i];
   if (cnt[i] > 1)
   {
    cpl[j * 2] = i; cpl[j * 2 + 1] = cnt[i];
    j++;
   }
  }
  qsort(cpl, j, sizeof(u16) * 2, cpl_compare);
  cplcnt = min(j, 254);
  for (i = 0; i < cplcnt; i++)
   psum += cpl[i * 2 + 1];


  for (i = 0; i < imgrooms.c; i++)
  {
   u16 ps;
   x = 0;
   /*ps = cplpack(imgrooms.mem[i].screen, imgrooms.mem[i].pos, buf + x, cpl, cplcnt);
   wsum += ps; x += ps;
   ps = cplpack(imgrooms.mem[i].color, imgrooms.mem[i].pos, buf + x, cpl, cplcnt);
   wsum += ps; x += ps;*/
   ps = cplpack(imgrooms.mem[i].bitmap, imgrooms.mem[i].bpos, buf + x, cpl, cplcnt);
   wsum += ps; x += ps;
  }

  i = 0;
  j = 0;
 }
}

int main(int argc,const char*argv[])
{
 if(argc>1)
 {
  u8*p;
  int  debug=1;
  char*argv2="storytllr64_data.h";
  char*argv3="advcartdrige";
  if(argv[2]) argv2=argv[2];
  if(argv[3]) argv3=argv[3];

  /*if(strstr(argv[1],"room"))
   IMG_recover(argv[1],argv[2]);
  else*/
  if(strstr(argv[1],".png")||strstr(argv[1],".jpg"))
   imageshow(argv[1],argc,argv);
  else
  if(file_readfile(argv[1],&p)>0)
  {
   const char*sz=(char*)p;
   char   szPath[256],szPath2[256];
   int    len;
   int    maxcardsize = 32 * 1024;
   
   dict_new(&sCLS,256,_dict_sorted);   
   p=(u8*)clean((char*)p,argv[1]);   

   sz=(char*)p;
   

   string_getpath(argv[1],szPath);
   string_getpath(argv2,szPath2);

   dict_new(&sDEF,0,_dict_sorted|_dict_extradata);
   // defaults
   addconfig("engine:StoryTllrC64");
   addconfig("name:undefined");
   addconfig("author:undefined");
   addconfig("splity:96");
   addconfig("binary:yes");
   addconfig("model:C64");
   addconfig("imgfolder:img\\");
   

   dict_new(&sVRB,0,/*_dict_sorted|*/_dict_extradata);
   
   dict_new(&sVRBCLS,0,_dict_sorted|_dict_extradata);
   dict_new(&sOBJCLS,0,_dict_sorted|_dict_extradata);
   
   dict_new(&sROOM,0,0);
   dict_new(&sOBJ,0,/*_dict_sorted|*/_dict_extradata);

   dict_new(&sARTS,0,_dict_sorted);
   dict_new(&sADJS,0,_dict_sorted);
   dict_new(&sOBJSYNS,0,0);
   dict_new(&sVRBSYNS,0,0);
   dict_new(&sGENS,0,_dict_sorted);

   dict_new(&sMSG,0,_dict_sorted);
   dict_new(&sMSG2,0,_dict_sorted);
   dict_new(&sNAMES,0,_dict_sorted);
   dict_new(&sDESC,0,_dict_sorted);
   
   dict_new(&sATTRS,0,0);
   dict_add(&sATTRS,"name");
   dict_add(&sATTRS,"desc");   

   dict_new(&sSCENERY,0,_dict_sorted|_dict_extradata);
   BUF_set(roomattrs,u8,256)
   BUF_set(objattrs,u8,256)

   dict_new(&sMETA,0,_dict_sorted|_dict_counter);
   dict_new(&sATTR,0,0);      
   
   dict_new(&sVAR,0,0);
   
   dict_new(&sADDSCORE,0,0);
   dict_add(&sVAR,"score");
   dict_add(&sVAR,"topscore");

   dict_new(&sBITVAR,0,0);
   
   dict_new(&sIMG,0,0);
   dict_new(&sCMP,0,0);

   //dict_addEx(&sVAR,"$status",0,NULL,0);
   //dict_addEx(&sVAR,"$score",0,NULL,0);
   //dict_addEx(&sVAR,"$topscore",0,NULL,0);

   dict_addEx(&sCMP,"=",0,NULL,0);
   dict_addEx(&sCMP,"<>",0,NULL,0);
   dict_addEx(&sCMP,">",0,NULL,0);
   dict_addEx(&sCMP,"<",0,NULL,0);
   dict_addEx(&sCMP,">=",0,NULL,0);
   dict_addEx(&sCMP,"<=",0,NULL,0);

   dict_addEx(&sVRB,"onfirst",0,NULL,0);
   dict_addEx(&sVRB,"onenter",0,NULL,0);
   dict_addEx(&sVRB,"onleave",0,NULL,0);
   dict_addEx(&sVRB,"onturn",0,NULL,0);
   dict_addEx(&sVRB,"ondesc",0,NULL,0);
   baseverbs=sVRB.nstrings;

   dict_add(&sATTR,"visible");
   baseattrs=sATTR.nstrings;

   dict_addEx(&sMETA,"$nowhere",bit_ROOM,NULL,0);
   dict_addEx(&sMETA,"$everywhere",bit_ROOM,NULL,0);
   dict_addEx(&sMETA,"$unknown",bit_OBJ,NULL,0);
   dict_addEx(&sMETA,"$every",bit_OBJ|bit_ROOM,NULL,0);
   dict_addEx(&sMETA,"$any",bit_OBJ,NULL,0);
   dict_addEx(&sMETA,"$this",bit_OBJ|bit_ROOM|bit_VAR,NULL,0);
   dict_addEx(&sMETA,"$that",bit_OBJ|bit_ROOM|bit_VAR,NULL,0);
   dict_addEx(&sMETA,"$here",bit_ROOM|bit_VAR,NULL,0);
   dict_addEx(&sMETA,"$available",bit_ROOM,NULL,0);   
   dict_addEx(&sMETA,"$none",bit_OBJ|bit_ATTR,NULL,0);
   dict_addEx(&sMETA,"$inventory",bit_ROOM|bit_MSG,NULL,0);
   //dict_addEx(&sMETA,"$score",bit_MSG,NULL,0);
   /*dict_addEx(&sMETA,"$roomdesc",bit_MSG,NULL,0);
   dict_addEx(&sMETA,"$roomname",bit_MSG,NULL,0);
   dict_addEx(&sMETA,"$objdesc",bit_MSG,NULL,0);   
   dict_addEx(&sMETA,"$objname",bit_MSG,NULL,0);*/
   
   dict_addEx(&sMETA,"$oneofobj",bit_OBJ,NULL,0);
   dict_addEx(&sMETA,"$oneofroom",bit_ROOM,NULL,0);

   meta_base=(256-sMETA.nstrings);
   meta_everywhere=meta_base+dict_find(&sMETA,"$everywhere");
   meta_inventory=meta_base+dict_find(&sMETA,"$inventory");


   dict_new(&sCMD,0,_dict_counter|_dict_sorted|_dict_extradata);   
   dict_new(&sCMDALIAS,0,_dict_counter|_dict_sorted|_dict_extradata);
   
   len=2;
   dict_addEx(&sCMD,"withobj",bit_OBJ,(u8*)&len,sizeof(len));      
   
   len=1;
   dict_addEx(&sCMD,"endwith",0,(u8*)&len,sizeof(len));   

   len=4;   
   dict_addEx(&sCMD,"ifvar",bit_VAR|(bit_CMP<<10)|((bit_NUM<<20)|(bit_VAR<<20)),(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"ifobjinattr",bit_OBJ|(bit_ROOM<<10)|(bit_ATTR<<20),(u8*)&len,sizeof(len));   

   len=2;
   dict_addEx(&sCMD,"ifisaroom",bit_ROOM,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"ifisroom",bit_ROOM,(u8*)&len,sizeof(len));   
   dict_addEx(&sCMD,"ifkey",bit_CHAR,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"ifundef",bit_VAR|bit_MSG,(u8*)&len,sizeof(len));
   
   dict_addEx(&sCMD,"if",bit_BITVAR,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"ifnot",bit_BITVAR,(u8*)&len,sizeof(len));
   
   len=2|128;
   dict_addEx(&sCMD,"set",bit_BITVAR,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"unset",bit_BITVAR,(u8*)&len,sizeof(len));
   
   len=3;
   dict_addEx(&sCMD,"needin",bit_OBJ|(bit_ROOM<<10),(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"ifisin",bit_OBJ|(bit_ROOM<<10),(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"ifis",bit_OBJ|(bit_ATTR<<10),(u8*)&len,sizeof(len));  
   
   len=3|128;
   dict_addEx(&sCMD,"list",bit_ROOM|(bit_ATTR<<10),(u8*)&len,sizeof(len));
   
   dict_addEx(&sCMDALIAS,"ifobjin",-1,(u8*)"ifisin",strlen("ifisin")+1);
   dict_addEx(&sCMDALIAS,"ifobj",-1,(u8*)"ifis",strlen("ifis")+1);
   dict_addEx(&sCMDALIAS,"listobjin",-1,(u8*)"list",strlen("list")+1);
   
   len=1;
   dict_addEx(&sCMD,"else",0,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"endif",0,(u8*)&len,sizeof(len));

   len=3|128;
   dict_addEx(&sCMD,"put",bit_OBJ|(bit_ROOM<<10),(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"setattr",bit_OBJ|(bit_ATTR<<10),(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"unsetattr",bit_OBJ|(bit_ATTR<<10),(u8*)&len,sizeof(len));
   
   dict_addEx(&sCMDALIAS,"putobj",-1,(u8*)"put",strlen("put")+1);
   dict_addEx(&sCMDALIAS,"setobj",-1,(u8*)"setattr",strlen("setattr")+1);
   dict_addEx(&sCMDALIAS,"unsetobj",-1,(u8*)"unsetattr",strlen("unsetattr")+1);
      
   len=3|128;
   dict_addEx(&sCMD,"setvar",bit_VAR|((bit_NUM<<10)|(bit_ROOM<<10)|(bit_OBJ<<10)),(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"addvar",bit_VAR|(bit_NUM<<10),(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"decvar",bit_VAR|(bit_NUM<<10),(u8*)&len,sizeof(len));

   len=4|128;
   dict_addEx(&sCMD,"setcount",bit_VAR|(bit_ROOM<<10)|(bit_ATTR<<20),(u8*)&len,sizeof(len));

   len=2|128;
   dict_addEx(&sCMD,"gfxmode",bit_NUM,(u8*)&len,sizeof(len));   
   dict_addEx(&sCMD,"hintmode",bit_NUM,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"addscore",bit_BITVAR,(u8*)&len,sizeof(len)); 

   len=1|128;   
   dict_addEx(&sCMD,"dbg",0,(u8*)&len,sizeof(len));   
   dict_addEx(&sCMD,"start",0,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"quit",0,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"load",0,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"save",0,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"clear",0,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"getkey",0,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"waitkey",0,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD, "loadimg", 0, (u8*)&len, sizeof(len));

   len=2|128;   
   dict_addEx(&sCMD,"msg",bit_MSG,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"msg2",bit_MSG,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"msgattr",bit_VAR,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"msgvar",bit_VAR,(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"msgobj", bit_VAR, (u8*)&len, sizeof(len));
   dict_addEx(&sCMD,"msgroom", bit_VAR, (u8*)&len, sizeof(len));
   len=3|128;
   dict_addEx(&sCMD,"msgvarattr",bit_VAR|(bit_MSG<<10),(u8*)&len,sizeof(len));
   

   len=2|128;
   dict_addEx(&sCMD,"showobj",bit_OBJ,(u8*)&len,sizeof(len));

   len=3|128;
   dict_addEx(&sCMD,"setroomimage",bit_ROOM|(bit_IMAGE<<10),(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"setroomoverlayimage",bit_ROOM|(bit_IMAGE<<10),(u8*)&len,sizeof(len));
   dict_addEx(&sCMD,"setroomname",bit_ROOM|(bit_MSG<<10),(u8*)&len,sizeof(len));
   
   dict_addEx(&sCMD,"setobjname",bit_OBJ|(bit_MSG<<10),(u8*)&len,sizeof(len));

   len=2|128;
   dict_addEx(&sCMD,"goto",bit_ROOM,(u8*)&len,sizeof(len));

   len=1;
   dict_addEx(&sCMD,"end",0,(u8*)&len,sizeof(len));

   memset(roomnameId,0xFF,sizeof(roomnameId));
   memset(objnameId,0xFF,sizeof(objnameId));

   memset(objsynids,0xFF,sizeof(objsynids));
   memset(vrbsynids,0xFF,sizeof(vrbsynids));

   memset(roomdescId,0xFF,sizeof(roomdescId));
   memset(objdescId,0xFF,sizeof(objdescId));

   memset(objattr,0x0,sizeof(objattr));
   memset(roomattr,0x0,sizeof(roomattr));

   memset(roomimg,0xFF,sizeof(objimg));
   memset(roomovrimg,0xFF,sizeof(roomovrimg));
   memset(objimg,0xFF,sizeof(objimg));

   memset(objloc,dict_find(&sMETA,"$nowhere")+meta_base,sizeof(objnameId));
   
   //BUF_set(verbs,char,2048)
   //BUF_set(objs,char,2048)

   BUF_set(opcodes,u8,2048)
   BUF_set(vopcodes,u8,2048)

#if !defined(HANDLE_IMAGES)
   hfIMAGEBAT=file_create(string_getINInamepath("image.bat",szPath2));
#endif

   model_update();
   
   hfIMAGEBAT2=file_create("make.bat");   

   bufferedimgs_start();

   adv_preparse(szPath,szPath2,sz,0);   

   format_disk();

   if(1)
   {
    char nm[256];    
    if(configstring("language",nm))
     {
      strcat(nm,".");strcat(nm,"msg");
      dict_addEx(&sCMDALIAS,nm,-1,(u8*)"msg",strlen("msg")+1);
     }
   }   

   if(1)
   {
    char nm[256];    
    if(configstring("splash",nm))
     {
      char cmd[256];
      char img[256],png[256],imgfolder[256],png1[256];
      sprintf(png,"%s",nm);
      configstring("imgfolder",imgfolder);
      sprintf(img,"%sroom00",imgfolder);
      string_gettoken(png,png1,'-');
      if(file_exists(png1))//file_updateneeded(png,img))
       {
        char nm[256];
        PNG_converter(png,img,1|2,"splash",model);    
        if(configstring("name",nm))
         {
          adjustname(nm);      
          sprintf(cmd,"c1541.exe bin/%s.d64 -write img/room00 room00\r\n",nm);
          file_writes(hfIMAGEBAT2,cmd);      
         } 
       }
     }
   }

   debug=configvalue("build.emit_texts",0);

   adv_parse(szPath,szPath2,sz,0);   

   //bufferedimgs_end();

   //printf("\n");

   dict_delete(&sCLS);

   //BUFC_add(&verbs,"|");
   //BUFC_add(&objs,"|");
   

   //zeromap(&verbs);
   //zeromap(&objs);

   {
    HANDLE hf=file_create(argv2);
    if(hf!=(HANDLE)-1)
     {
      int useramsize=0,ramsize=0,i,first=-1,last=-1,saved=0,filled=0,used=0,wlen=0; // 1 dictionary 2 ngram 3 inner pack
      u8  attremitflag=0;
      char out[256];
      u16 ln[256],iln=0;
      
      for(i=0;i<sMSG.nstrings;i++)
       {
        int l=strlen(sMSG.str +sMSG.idx[i])+1;
        if(l>wlen)
         wlen=l;
       }
      for(i=0;i<sDESC.nstrings;i++)
       {
        int l=strlen(sDESC.str +sDESC.idx[i])+1;
        if(l>wlen)
         wlen=l;
       } 
      
      if(bUSEPACK)
       { 
        sprintf(out,"#define packed_strings %d\r\n\r\n",bUSEPACK);
        file_writes(hf,out);
       } 

      sprintf(out,"#define img_fileformat %d\r\n\r\n",configvalue("image.fileformat",storytllr_imageformat));
      file_writes(hf,out);

      sprintf(out,"#define screen_splity %d\r\n\r\n",configvalue("image.splity",96));
      file_writes(hf,out);
       
      sprintf(out,"#define string_max_len %d\r\n\r\n",wlen);
      file_writes(hf,out);       

      sprintf(out,"u8 opcodeattr[%d]={",sCMD.nstrings);
      file_writes(hf,out);
      
      for(i=0;i<sCMD.nstrings;i++)
      {
       int  len;
       dict_getEx(&sCMD,i,NULL,NULL,(u8*)&len,NULL);
       if(i)
        file_writes(hf,",");
       sprintf(out,"%d",len);
       file_writes(hf,out);
      }
      file_writes(hf,"};\r\n\r\n");

      file_writes(hf,"#define varcmp_equal       0\r\n");
      file_writes(hf,"#define varcmp_different   1\r\n");
      file_writes(hf,"#define varcmp_greater     2\r\n");
      file_writes(hf,"#define varcmp_less        3\r\n\r\n");

      for(i=0;i<sCMD.nstrings;i++)
      {
       char sz[256];
       dict_getEx(&sCMD,i,sz,NULL,NULL,NULL);
       sprintf(out,"#define op_%s %d\r\n",sz,128+i);
       file_writes(hf,out);
       if(memcmp(sz,"if",2)==0)
       {
        if(first==-1) first=i;
        last=i;
       }
      }    
      sprintf(out,"#define op_ifstart %d\r\n",128+first);
      file_writes(hf,out);
      sprintf(out,"#define op_ifend %d\r\n",128+last);
      file_writes(hf,out);

      file_writes(hf,"\r\n");

      for(i=0;i<sMETA.nstrings;i++)
      {
       sprintf(out,"#define meta_%s %d\r\n",sMETA.str +sMETA.idx[i]+1,meta_base+i);
       file_writes(hf,out);
      }
      file_writes(hf,"#define metaattr_name 0\r\n");
      file_writes(hf,"#define metaattr_desc 1\r\n");
      file_writes(hf,"#define metaattr_obj  64\r\n");
      //file_writes(hf,"#define meta_everywhere 255\r\n");

      file_writes(hf,"\r\n");
      
      //opcode: add classes
      if(ivrbcls)
       {
        for(i=0;i<ivrbcls;i+=2)
         {
          int j,lj=ifat*FAT_SIZE;
          for(j=0;j<lj;j+=FAT_SIZE)
           if(gfat[j]==vrbcls[i+1])
            {          
             gfat[ifat*FAT_SIZE+fat_verb]=vrbcls[i];
             gfat[ifat*FAT_SIZE+fat_room]=verbclass_score;
             gfat[ifat*FAT_SIZE+fat_pointer]=gfat[j+2];
             ifat++;
            } 
         }
       }      

      attremitflag=getemitflags();

      if(configcheck("binary","yes")) 
       {
        ln[iln++]=sVRB.nstrings;
        ln[iln++]=sOBJ.nstrings;
        ln[iln++]=sROOM.nstrings;
        ln[iln++]=sVAR.nstrings;
        //ln[iln++]=attremitflag;
        file_writes(hf,"u8 opcode_vrbidx_count;\r\n");
        file_writes(hf,"u8 obj_count;\r\n");
        file_writes(hf,"u8 room_count;\r\n");
        file_writes(hf,"u8 var_count;\r\n");
        //file_writes(hf,"u8 attremit_flags;\r\n");
       }
      else
       { 
        sprintf(out,"#define opcode_vrbidx_count %d\r\n",sVRB.nstrings);
        file_writes(hf,out);
        sprintf(out,"#define obj_count %d\r\n",sOBJ.nstrings);
        file_writes(hf,out);
        sprintf(out,"#define room_count %d\r\n",sROOM.nstrings);
        file_writes(hf,out);
        sprintf(out,"#define var_count %d\r\n",sVAR.nstrings);
        file_writes(hf,out);
        //sprintf(out,"#define attremit_flags %d\r\n",attremitflag);
        //file_writes(hf,out);
       }
       
      file_writes(hf,"\r\n");
      
      BUF_set(mem,u8,256)
      BUF_set(memidx,u16,256)

      dict_new(&sTNAMES,0,0);      

      if(configvalue("build.string_checksimilarity",0))
       {
        checksimilarity(&sNAMES,"NAMES");
        checksimilarity(&sDESC,"DESC");
        checksimilarity(&sMSG,"MSG");
        checksimilarity(&sMSG2,"MSG");
       }

      if (bUSEPACK == pack_huffman)
      {
       u16 real = 0, packed = 0;
       u8  buf[64 * 1024];

       huffpack_start();

       real+=huffpack_adddict(&sNAMES);
       real += huffpack_adddict(&sDESC);
       real += huffpack_adddict(&sMSG);
       real += huffpack_adddict(&sMSG2);

       huffpack_calc();

       packed+=huffpack_packdict(&sNAMES,buf);
       packed += huffpack_packdict(&sDESC, buf);
       packed += huffpack_packdict(&sMSG, buf);
       packed += huffpack_packdict(&sMSG2, buf);

       huffpack_end();

      }
      else
      if((bUSEPACK==1)||(bUSEPACK==2)||(bUSEPACK==pack_bigramsanddict)||(bUSEPACK==5))
       {

        dict_new(&sKEYS,0,_dict_counter);
        dict_new(&sCKEYS,0,_dict_counter);

        {
         int dictsaved=0,ml=0,j=0,wl=0;
         dict sDICTX;
         dict_new(&sDICTX,0,_dict_counter);
         dict_new(&sDICT,0,_dict_counter);

         prepack(&sNAMES,&sDICTX, NULL, 17);
         prepack(&sDESC,&sDICTX,NULL,17);
         prepack(&sMSG,&sDICTX,NULL,17);      
         prepack(&sMSG2,&sDICTX,NULL,17);    

         dict_Sort(&sDICTX,_dict_sortbycounterreverse_);
         
         for(i=0;i<sDICTX.nstrings;i++)
          {
           int  cnt,l;
           char sz[256];
           dict_getEx(&sDICTX,i,sz,&cnt,NULL,NULL);       
           if(cnt>4)
            {
            l=strlen(sz);
            if(l>ml)
             ml=l;
            if((sDICT_usefixedlen==0)||(l==sDICT_fixedlen))
             {     
              wl+=l;
              dict_add(&sDICT,sz);
              if(wl>=512)
               break;
             }
            }
           else            
            break;
          }
          dict_delete(&sDICTX);

          i=0;
          //sDICT.nstrings=0;
         }

        while(sCKEYS.nstrings<768)
         {
          dict_softreset(&sKEYS);
          
          memset(dict_used,0,sizeof(dict_used));

          saved+=prepack(&sNAMES,&sKEYS,&sCKEYS,bUSEPACK);
          saved+=prepack(&sDESC,&sKEYS,&sCKEYS,bUSEPACK);
          saved+=prepack(&sMSG,&sKEYS,&sCKEYS,bUSEPACK);      
          saved+=prepack(&sMSG2,&sKEYS,&sCKEYS,bUSEPACK);    
          dict_Sort(&sKEYS,_dict_sortbycounterreverse_);
          for(i=0;(i<sKEYS.nstrings)&&(i<1);i++)
           {
            char sz[256];
            int  cnt,x=0;
            dict_getEx(&sKEYS,i,sz,&cnt,NULL,NULL);       
            if(cnt>1)
             dict_addEx(&sCKEYS,sz,cnt,NULL,0);
            else
             break;
           }
          if(i==0)
           break;
         }
                
        if((bUSEPACK==2)||(bUSEPACK==pack_bigramsanddict)||(bUSEPACK==5))
         {
          int lsaved=0;
          int seq[768],iseq=0;;
          dict_Sort(&sCKEYS,_dict_sortbycounterreverse_);
          for(i=0;(i<sCKEYS.nstrings)&&(iseq<768-2);i++)
           {
            char sz[256];
            int  cnt,x=0;
            dict_getEx(&sCKEYS,i,sz,&cnt,NULL,NULL);       
            if(cnt>1)
             if(sz[1])
              {
               int len=strlen(sz);
               int value=(len-1)*cnt;
               seq[iseq++]=i;
               seq[iseq++]=value;
              }
           }          
          
          if(MAX_FIXED_NGRAM!=FIXED_NGRAM) 
           qsort(seq,iseq/2,sizeof(int)*2,twoint_compare); 
          
          for(i=0;i<iseq;i+=2)
           {
            char sz[256];
            int  cnt,len,score=seq[i+1];
            dict_getEx(&sCKEYS,seq[i],sz,&cnt,NULL,NULL);       
                        
            len=strlen(sz);
            
            if(bSPACEADD==0)
             ;
            else
             if(bUSEPACK==pack_bigramsanddict)
              if(idict+len+1>255)
               continue;
            
            if(bUSEPACK==pack_bigramsanddict)
             dictlen[idictidx++]=idict;
            else 
             dictpos[idictidx++]=idict;
             
            memcpy(dicttext +idict,sz,len);idict+=len;
            
            used++;
            if(bSPACEADD==0)
             {
              if(used>(255-start_packedcouples)-1)
               break;
             }
            else 
             if(used>63)
              break;
           }
          
          if(bUSEPACK==pack_bigramsanddict)
           dictlen[idictidx+1]=(u8)idict;
          else 
           dictpos[idictidx+1]=idict;
          lsaved-=(idict+idictidx);                     
         }
        else
         {         
          saved+=writedictionary(&sKEYS);
                
          emitattrWORD(hf,"dict_idx",dictidx,idictidx);
          emitattrBYTE(hf,"dict_len",dictlen,idictidx);
          emitattrBYTE(hf,"dict_data", dicttext,idict);
         } 
       }

      petmapbuf(dicttext,idict);

      if(sDICT.nstrings)
      {
       u8   shortdict[128*8],lens[32];
       int  i,j;
       u16  pj=0,bpj=0;
       
       shortdict[pj++]=2+sDICT.nstrings;
       shortdict[pj++]=0; // add 256

       pj+=sDICT.nstrings+1;
       bpj=pj;

       memset(lens, 0, sizeof(lens));
       for (j = i = 0; i < sDICT.nstrings; i++)
       {
        char*s = sDICT.str + sDICT.idx[i];
        int  ln = strlen(s);
        lens[ln]++;
       }
       for(j=i=0;i<sDICT.nstrings;i++)
        {
         char*s=sDICT.str +sDICT.idx[i];
         int  ln=strlen(s);
         petmapbuf(s,ln);
         shortdict[2+i]=(pj-bpj);
         memcpy(shortdict+pj,s,ln);         
         if (shortdict[1] == 0)
          if ((pj - bpj) > 255)
           shortdict[1] = 2+i;
         pj += ln;
        } 
       shortdict[2+i]=(pj-bpj);
       emitattrBYTE(hf,"shortdict",shortdict,pj); 
      }
      else
       emitattrBYTE(hf,"shortdict","",0); 

      memset(dict_used,0,sizeof(dict_used));
          
      stpwriteh(hf,&sNAMES,0,-1,"advnames",bUSEPACK,NULL,0);
      if(debug)
       dict_export(&sNAMES,"debug_names.txt");
      stpwriteh(hf,&sDESC,0,-1,"advdesc",bUSEPACK,NULL,0);
      if(debug)
       dict_export(&sDESC,"debug_desc.txt");
      stpwriteh(hf,&sMSG,0,-1,"msgs",bUSEPACK,NULL,0);
      if(debug)
       dict_export(&sMSG,"debug_msg.txt");
      stpwriteh(hf,&sMSG2,0,-1,"msgs2",bUSEPACK,NULL,0);      
      if(debug)
       dict_export(&sMSG2,"debug_msg2.txt");

      // --- trie(&sVRB,"verbs");
      // --- trie(&sOBJ,"objs");
      if(sVRBSYNS.nstrings)
       stpwriteh(hf,&sVRBSYNS,0,-1,"verbs",16,vrbsynids,0);
      else
       stpwriteh(hf,&sVRB,0,-1,"verbs",16,NULL,0);

      if(sOBJSYNS.nstrings)
       {
        int f;
        for(f=0;f<sOBJ.nstrings;f++)
         {
          const char*p=sOBJ.str +sOBJ.idx[f];
          const char*pd=strstr(p,".");
          if(pd==NULL)
           {
            if(dict_find(&sOBJSYNS,p)==-1)
             {
              int ff,nsyns,synids[64];
              int roomid=meta_everywhere;
              for(ff=0;ff<iroomobjsynids;ff++)
               if(roomobjsynids[ff*3+2]==f)
                break;
              if(ff==iroomobjsynids)
               {
                nsyns=getLIST(&sOBJSYNS,p,",+|",1,&synids[0]);
                while(nsyns--)
                 addobjsyns(synids[nsyns],f,roomid);
               }
             }
           }
          else
           {
            if(dict_find(&sOBJSYNS,pd+1)==-1)
             {
              int  roomid;
              char room[256];
              if(strcmp(pd+1,"berries")==0)
               roomid=-1;
              memcpy(room,p,pd-p);room[pd-p]=0;
              roomid=dict_find(&sROOM,room);
              if(roomid!=-1)
               {
                int ff,nsyns,synids[64];
                for(ff=0;ff<iroomobjsynids;ff++)
                 if((roomobjsynids[ff*3+2]==f)&&(roomobjsynids[ff*3+1]==roomid))
                  break;
                if(ff==iroomobjsynids)
                 {
                  nsyns=getLIST(&sOBJSYNS,pd+1,",+|",1,&synids[0]);
                  while(nsyns--)
                   addobjsyns(synids[nsyns],f,roomid);
                 }
               }
             }
           }
         }
        if(debug)
         {
         dict_export(&sOBJSYNS,"debug_objsyns.txt");
         dict_export(&sOBJ,"debug_obj.txt");
         }
        if(needroomobjs)
         {
          qsort(roomobjsynids,iroomobjsynids,sizeof(roomobjsynids[0])*3,roomobjsyns_compare);
          stpwriteh(hf,&sOBJSYNS,0,-1,"objs",16,roomobjsynids,iroomobjsynids);      
         }
        else
         stpwriteh(hf,&sOBJSYNS,0,-1,"objs",16,objsynids,0);      
       }
      else
       stpwriteh(hf,&sOBJ,0,-1,"objs",16,NULL,0);      

      stpwriteh(hf,&sROOM,0,-1,"rooms",16,NULL,0);
            
      emitattrBYTE(hf,"packdata", dicttext,idict);
      if(bSPACEADD==0)
       ;
      else
      if(bUSEPACK==pack_bigramsanddict)
       emitattrBYTE(hf,"packpos",dictlen,idictidx+1);
      else
       emitattrWORD(hf,"packpos",dictpos,idictidx+1);

      //opcode
      qsort(gfat,ifat,FAT_SIZE,fat_compare);
      for(i=0;i<ifat;i++)
       {
        if(gfat[i*FAT_SIZE+1]==verbclass_score)
         gfat[i*FAT_SIZE+1]=meta_everywhere;
        else
        if(gfat[i*FAT_SIZE+1]==verbeverywhere_score)
         gfat[i*FAT_SIZE+1]=meta_everywhere;
        else 
        if(gfat[i*FAT_SIZE+1]==verbobj_score)
         gfat[i*FAT_SIZE+1]=meta_everywhere;
       }
      {
       u8  file2[MAX_FILE];
       int remap[MAX_IC],ic2=0,f2=0;
       u16 cpos2[MAX_IC];
       u8  clen2[MAX_IC];
       memset(remap,0xFF,sizeof(remap));
       for(i=0;i<ifat*FAT_SIZE;i+=FAT_SIZE)
        {
         int v=gfat[i+2];
         if(remap[v]!=-1)
          gfat[i+2]=(u8)remap[v];
         else
          {
           cpos2[ic2]=f2;           
           memcpy(&file2[f2],&file[cpos[v]],clen[v]);
           clen2[ic2]=clen[v];
           f2+=clen[v];
           remap[v]=ic2++;
           gfat[i+2]=(u8)remap[v];           
          }
        }
       memcpy(&cpos[0],&cpos2[0],ic2*sizeof(cpos[0]));
       memcpy(&clen[0],&clen2[0],ic2*sizeof(clen[0]));
       memcpy(&file[0],&file2[0],f2*sizeof(file[0]));
       ic=ic2;ifile=f2;
      }
      i=0;
      
      if(1)
       {
        int i,last=0,nsize;
        u16 pos=0,next;
        u8  nfat[(256+2)*FAT_SIZE];
        memset(jump_table,0xFF,sizeof(jump_table));
        for(i=0;i<ifat;i++)
         {         
          const char*vrb=sVRB.str +sVRB.idx[gfat[i*FAT_SIZE+fat_verb]];
          if(gfat[i*FAT_SIZE]>sVRB.nstrings)
            break;
          if(cIsIn(vrb,"kill"))
           vrb="kill";
          last=gfat[i*FAT_SIZE+fat_verb];
          if(jump_table[last]==0xFFFF)
           jump_table[last]=pos;
          nfat[pos++]=gfat[i*FAT_SIZE+fat_room];
          nfat[pos++]=gfat[i*FAT_SIZE+fat_pointer];
         }
        last++;
        next=jump_table[last]=pos;
        
        for(;i<ifat;i++)
         {         
          if(gfat[i*FAT_SIZE]==255)
           {
            nfat[pos++]=gfat[i*FAT_SIZE+1];
            nfat[pos++]=gfat[i*FAT_SIZE+2];
           }
         }
        last++;
        next=jump_table[last]=pos;

        last++;
        i=last;
        while(i--)
         if(jump_table[i]==0xFFFF)
          jump_table[i]=next;
         else
          next=jump_table[i];
        nsize=last*2+pos;        
        emitattrWORD(hf,"opcode_vrbidx_dir",jump_table,last);
        emitattrBYTE(hf,"opcode_vrbidx_data",nfat,pos);
       }
      else
       emitattr(hf,"opcode_vrbidx",ifat*FAT_SIZE,gfat);
      emitattrWORD(hf,"opcode_pos",cpos,ic);
      emitattrBYTE(hf,"opcode_len",clen,ic);
      emitattrBYTE(hf,"opcode_data",file,ifile);

      // rooms
      
      emitattr(hf,"roomnameid",sROOM.nstrings,roomnameId);
      emitattr(hf,"roomdescid",sROOM.nstrings,roomdescId);    
      emitattr(hf,"roomimg",sROOM.nstrings,roomimg);       
      if(attremitflag&skip_roomovrimg)
       emitattr(hf,"roomovrimg",0,NULL);    
      else
       emitattr(hf,"roomovrimg",sROOM.nstrings,roomovrimg);               

      // objects
      emitattr(hf,"objnameid",sOBJ.nstrings,objnameId);
      emitattr(hf,"objdescid",sOBJ.nstrings,objdescId);
      if(attremitflag&skip_objimg)
       emitattr(hf,"objimg",0,NULL);
      else
       emitattr(hf,"objimg",sOBJ.nstrings,objimg);

      i=mem.c;

      emitattr(hf,"objattr",sOBJ.nstrings,objattr);
      emitattr(hf,"objloc",sOBJ.nstrings,objloc);
      
      if(objattrs.c) 
       {
        BUF_safeadd(objattrs,u8,255)
        emitattr(hf,"objattrex",objattrs.c,objattrs.mem);
       }
      else
       emitattr(hf,"objattrex",0,NULL);

      {
       u8 roomstart=dict_find(&sROOM,"$start");
       u16 w=mem.c;   
       BUF_safeadd(memidx,u16,w)
       dict_add(&sTNAMES,"roomstart");
       BUF_safeadd(mem,u8,roomstart);
      }

      emitattr(hf,"roomattr",sROOM.nstrings,roomattr);  

      if(roomattrs.c) 
       {
        int   i=0,hm=roomattrs.c/3;
        BUF out;
        BUF_set(out,u8,256)
        qsort(roomattrs.mem,hm,sizeof(u8)*3,attrs_compare);
        while(i<hm)
         {
          int k,j=0;
          while((i+j<hm)&&(roomattrs.mem[i*3]==roomattrs.mem[(i+j)*3]))
           j++;          
          if(j<sROOM.nstrings/2)
           {
            BUF_safeadd(out,u8,roomattrs.mem[i*3])            
            BUF_safeadd(out,u8,j)
            for(k=0;k<j;k++)
             {
              BUF_safeadd(out,u8,roomattrs.mem[(i+k)*3+1])
              BUF_safeadd(out,u8,roomattrs.mem[(i+k)*3+2])
             }            
           }
          else
           {
            u8 map[256];
            memset(map,255,sizeof(map));
            BUF_safeadd(out,u8,(roomattrs.mem[i*3]|128))
            BUF_safeadd(out,u8,sROOM.nstrings)
            for(k=0;k<j;k++)
             map[roomattrs.mem[(i+k)*3+1]]=roomattrs.mem[(i+k)*3+2];
            for(k=0;k<sROOM.nstrings;k++)
             BUF_safeadd(out,u8,map[k])
           }
          i+=j;
         }
        BUF_safeadd(out,u8,255)
        emitattr(hf,"roomattrex",out.c,out.mem);
        BUF_free(out)
       }
      else
       emitattr(hf,"roomattrex",0,NULL);

      // ram
      emitattr(hf,"bitvars",1+(sBITVAR.nstrings/8),bitvars);
      if(sADDSCORE.nstrings)
       {vars[0]=0;vars[1]=sADDSCORE.nstrings;}
      emitattr(hf,"vars",sVAR.nstrings,vars);    
      
      ramsize=mem.c-i;       

      if(useramsize)
       {        
        if(ramsize)
         {
         u8 buf[2048];
         int len=hpack(mem.mem+i,0,ramsize,&buf[0]);
         emitattr(hf,"origram",len,buf);
         len=0;
         }
       }


      {
       int idx=0,pos=0;
       char fnt[256],nm[256];
       const char*name;
       
       //psize=brutepack(mem.mem,mem.c,buf);
       
       if (configcheck("binary", "yes")&&(mem.c + sIMG.nstrings * 3000 < maxcardsize))
        {
         int i, size;
         BUFW offset;
         BUF  imem;
         BUF_set(imem, u8, 256)
          BUF_set(offset, u16, 256)
          for (i = 0; i < sIMG.nstrings; i++)
          {
           char imgfolder[256], img[256];
           u8*p;
           configstring("imgfolder", imgfolder);
           sprintf(img, "%sroom%02d", imgfolder, i + 1);
           if ((size = file_readfile(img, &p)) > 0)
           {
            int j;
            u16 uu = imem.c, lsize = 0;
            BUF_safeadd(offset, u16, uu)

            /*psize = *(u16*)(p + 8); *(u16*)(p + 8) = lsize; lsize += psize;

            psize = *(u16*)(p + 10); *(u16*)(p + 10) = lsize; lsize += psize;

            psize = *(u16*)(p + 12); *(u16*)(p + 12) = lsize; lsize += psize;*/

            for (j = 0; j < size; j++)
             BUF_safeadd(imem, u8, p[j])
            FREE(p)
           }
          }
         if (mem.c + (offset.c * sizeof(offset.mem[0])) + (imem.c * sizeof(imem.mem[0])) < maxcardsize)
          {
           emitattrex(hf, "imagesidx", offset.c * sizeof(offset.mem[0]), (u8*)offset.mem,2);
           emitattr(hf, "imagesdata", imem.c * sizeof(imem.mem[0]), imem.mem);
           file_close(hfIMAGEBAT2);
           hfIMAGEBAT2 = file_create("make.bat");
           format_disk();
          }
         else
         {
          emitattrex(hf, "imagesidx", 0, NULL,2);
          emitattr(hf, "imagesdata", 0, NULL);
         }
         //writeh(hf, &imem, "imagesdata");
         //writeh16(hf, &offset, "imagesidx");
         BUF_free(offset)
         BUF_free(imem)          
        }
       else
       {
        emitattrex(hf, "imagesidx", 0, NULL,2);
        emitattr(hf, "imagesdata", 0, NULL);
       }

       if (configstring("font", fnt))
        {
         FONT_bitmap(fnt, "img/font", szPath2);
         if (configcheck("binary", "yes"))
         {
          if (configstring("name", nm))
          {
           char out[256];
           adjustname(nm);
           sprintf(out, "c1541.exe bin/%s.d64 -write img/font font\r\n", nm);
           file_writes(hfIMAGEBAT2, out);
          }
         }
        }
       
       if(configcheck("binary","yes"))
        { 
        HANDLE hfx;
         char path[256],card[256];
         u16 uu;           
         file_writes(hf,"#define advcartridgeondisk\r\n\r\n");     
         file_writes(hf,"u16 origram_len;\r\n");
         file_writes(hf,"u8*advcartridge;\r\n");         
         while(idx<sTNAMES.nstrings)
          {
           name=sTNAMES.str +sTNAMES.idx[idx];pos=memidx.mem[idx++];
           ln[iln++]=pos;
           if(cIsIn(name,"|opcode_pos|opcode_vrbidx_dir|objs_dir|imagesidx|"))
            sprintf(out,"u16*%s;\r\n",name); 
           else
            sprintf(out,"u8*%s;\r\n",name);       
           file_writes(hf,out);         
           // break;
          }
         ln[iln++]=ramsize; 
         sprintf(out,"#define advcartridge_dirsize %d\r\n",(iln+1)*2);       
         file_writes(hf,out); 
         if(argc==4)
          strcpy(card,argv3);
         else
          {
           string_getpath(argv2,path);         
           strcpy(card,string_getINInamepath("advcartridge",path));
          } 
          
         hfx=file_create(card); 
          
         if(configstring("name",nm))
          {
           char out[256];    
           adjustname(nm);      
           sprintf(out,"c1541.exe bin/%s.d64 -write %s advcartridge\r\n",nm,card);
           file_writes(hfIMAGEBAT2,out);
          }  
         
         uu=0x4000;
         file_write(hfx,&uu,sizeof(uu));

         uu=mem.c;
         file_write(hfx,&uu,sizeof(uu));
        
         file_write(hfx,mem.mem,mem.c); 
         
         file_write(hfx,&iln,sizeof(iln));
         file_write(hfx,&ln[0],iln*sizeof(ln[0]));
         
         file_close(hfx);
        } 
       else
        {
         writeh(hf,&mem,"advcartridge");
         while(idx<sTNAMES.nstrings)
          {
           name=sTNAMES.str +sTNAMES.idx[idx];pos=memidx.mem[idx++];
           if((strcmp(name,"opcode_pos")==0)||(strcmp(name,"opcode_vrbidx_dir")==0)||(strcmp(name,"objs_dir")==0))
            sprintf(out,"u16*%s=(u16*)(advcartridge+%d);\r\n",name,pos); 
           else
            sprintf(out,"u8*%s=advcartridge+%d;\r\n",name,pos);       
           file_writes(hf,out);         
           // break;
          }
         sprintf(out,"#define origram_len %d\r\n",ramsize);       
         file_writes(hf,out); 

         sprintf(out,"#define advcartridge_dirsize %d\r\n",(sTNAMES.nstrings+6)*2);       
         file_writes(hf,out); 

        }  
       file_writes(hf,"\r\n");
      }
      
      opcodeDUMP("tmp/opcodes.txt");

      if(configcheck("binary","yes"))
      {
       for(i=0;i<baseverbs;i++)
        {
         sprintf(out,"#define vrb_%s %d\r\n",sVRB.str +sVRB.idx[i],i);
         file_writes(hf,out);
        }    
       file_writes(hf,"\r\n");
       for(i=0;i<baseattrs;i++)
        {
         const char*s=sATTR.str +sATTR.idx[i];
         sprintf(out,"#define attr_%s %d\r\n",s+(*s=='$')+(*s=='#'),mask[i]);
         file_writes(hf,out);
        }    
       file_writes(hf,"\r\n");

       file_writes(hf,"#define skip_objimg     1\r\n");
       file_writes(hf,"#define skip_roomovrimg 2\r\n");
       file_writes(hf,"\r\n");

       file_close(hf);
       
       hf=file_create("temp.h");

       for(i=0;i<sTNAMES.nstrings;i++)
        {
         const char*name=sTNAMES.str +sTNAMES.idx[i];
         char       out[256];
         int        pos=memidx.mem[i];     
         sprintf(out,"// %s = %.2f%% [%d - %d bytes]\r\n",name,(memidx.mem[i+1]-pos)*100.0f/mem.c,pos,memidx.mem[i+1]-pos);
         file_writes(hf,out);         
         // break;
        }
      }

     BUF_free(memidx)
     BUF_free(mem)

     if(1)
      {

      for(i=0;i<sROOM.nstrings;i++)
      {
       const char*s=sROOM.str +sROOM.idx[i];
       sprintf(out,"#define room_%s %d\r\n",s+(*s=='$')+(*s=='#'),i);
       file_writes(hf,out);
      }    
      file_writes(hf,"\r\n");
      for(i=0;i<sOBJ.nstrings;i++)
      {
       const char*s=sOBJ.str +sOBJ.idx[i];
       sprintf(out,"#define obj_%s %d\r\n",dotfix(s+(*s=='$')+(*s=='#')),i);
       file_writes(hf,out);
      }    
      file_writes(hf,"\r\n");
      for(i=0;i<sVRB.nstrings;i++)
      {
       sprintf(out,"#define vrb_%s %d\r\n",sVRB.str +sVRB.idx[i],i);
       file_writes(hf,out);
      }    
      file_writes(hf,"\r\n");
      for(i=0;i<sVAR.nstrings;i++)
      {
       const char*s=sVAR.str +sVAR.idx[i];
       sprintf(out,"#define var_%s %d\r\n",s+(*s=='$')+(*s=='#'),i);
       file_writes(hf,out);
      }    
      file_writes(hf,"\r\n");      
      for(i=0;i<sBITVAR.nstrings;i++)
      {
       const char*s=sBITVAR.str +sBITVAR.idx[i];
       sprintf(out,"#define bitvar_%s %d\r\n",s+(*s=='$')+(*s=='#'),i);
       file_writes(hf,out);
      }    
      file_writes(hf,"\r\n");
      for(i=0;i<sATTR.nstrings;i++)
      {
       const char*s=sATTR.str +sATTR.idx[i];
       sprintf(out,"#define attr_%s %d\r\n",s+(*s=='$')+(*s=='#'),mask[i]);
       file_writes(hf,out);
      }    
      file_writes(hf,"\r\n");
      }

      //writepcode(hf);

    file_close(hf);

    printf("ROOMS: %d\nOBJECTS: %d\nBITVAR: %d\nVAR: %d\nNAMES: %d\nDESC: %d\nMSG: %d+%d\n",sROOM.nstrings,sOBJ.nstrings,sBITVAR.nstrings,sVAR.nstrings,sNAMES.nstrings,sDESC.nstrings,sMSG.nstrings,sMSG2.nstrings);
        
    if(configcheck("binary","no")||configcheck("binary", "crt"))
     {
      int i,size;
      BUFW offset;
      BUFDW offset32;
      BUF_set(mem, u8, 256)
      BUF_set(offset, u16, 256)
      BUF_set(offset32, u32, 256)
       if (configcheck("binary", "crt"))
       {
        char out[256];
        hf = file_create(string_getINInamepath("storytllr64_crtimages.h", szPath2));
        file_writes(hf, "#if defined(TARGET_GENERIC)||defined(EMUL)\r\n");
        
        for (i = 0; i < sIMG.nstrings; i++)
        {
         char imgfolder[256], img[256];
         u8*p;
         configstring("imgfolder", imgfolder);
         sprintf(img, "%sroom%02d", imgfolder, i + 1);
         if ((size = file_readfile(img, &p)) > 0)
         {
          int j;
          u16 psize, lsize = 0;
          BUF_safeadd(offset32, u32, mem.c)

          psize = *(u16*)(p + 8); *(u16*)(p + 8) = lsize; lsize += psize;

          psize = *(u16*)(p + 10); *(u16*)(p + 10) = lsize; lsize += psize;

          psize = *(u16*)(p + 12); *(u16*)(p + 12) = lsize; lsize += psize;

          for (j = 0; j < size; j++)
           BUF_safeadd(mem, u8, p[j])
          FREE(p)
         }
        }
        writeh(hf, &mem, "crt_image");
        writeh32(hf, &offset32, "crt_imageidx");
        BUF_free(offset32)

        file_writes(hf, "#else\r\n");

        for (i = 0; i < (sIMG.nstrings / 4) + 1; i++)
        {         
         sprintf(out,"#pragma section( bcode%d, 0 )\r\n", i + 1);
         file_writes(hf, out);
         sprintf(out,"#pragma section( bdata%d, 0 )\r\n", i + 1);
         file_writes(hf, out);
         sprintf(out, "#pragma region(bank%d, 0x8000, 0xc000, , 1, { bcode%d, bdata%d } )\r\n\r\n", i + 1, i + 1, i + 1);
         file_writes(hf, out);

        }
        for (i = 0; i < sIMG.nstrings; i+=4)
        {
         char imgfolder[256], img[256];
         int  ii;
         u8*p;
         sprintf(out, "#pragma code ( bcode%d )\r\n", (i / 4) + 1);
         file_writes(hf, out);
         sprintf(out, "#pragma data ( bdata%d )\r\n\r\n", (i / 4) + 1);
         file_writes(hf, out);

         mem.c = 0; offset.c = 0;
         for (ii = 0; ii < 4; ii++)
          {
           configstring("imgfolder", imgfolder);
           sprintf(img, "%sroom%02d", imgfolder, i+ii + 1);
           if ((size = file_readfile(img, &p)) > 0)
           {
            int j;
            u16 uu = mem.c, psize, lsize = 0;
            BUF_safeadd(offset, u16, uu)

             psize = *(u16*)(p + 8); *(u16*)(p + 8) = lsize; lsize += psize;

            psize = *(u16*)(p + 10); *(u16*)(p + 10) = lsize; lsize += psize;

            psize = *(u16*)(p + 12); *(u16*)(p + 12) = lsize; lsize += psize;

            for (j = 0; j < size; j++)
             BUF_safeadd(mem, u8, p[j])
             FREE(p)
           }
          }
         writeh(hf, &mem, "crt_image");
         writeh16(hf, &offset, "crt_imageidx");
         file_writes(hf, "\r\n");
        }
        file_writes(hf, "#pragma code ( code )\r\n");
        file_writes(hf, "#pragma data ( data )\r\n");
        
        file_writes(hf, "#endif\r\n");
       }
      else
      {
       hf = file_create(string_getINInamepath("images.h", szPath2));
       for (i = 0; i < sIMG.nstrings; i++)
        {
         char imgfolder[256], img[256];
         u8*p;
         configstring("imgfolder", imgfolder);
         sprintf(img, "%sroom%02d", imgfolder, i + 1);
         if ((size = file_readfile(img, &p)) > 0)
         {
          int j;
          u16 uu = mem.c, psize, lsize = 0;
          BUF_safeadd(offset, u16, uu)

           psize = *(u16*)(p + 8); *(u16*)(p + 8) = lsize; lsize += psize;

          psize = *(u16*)(p + 10); *(u16*)(p + 10) = lsize; lsize += psize;

          psize = *(u16*)(p + 12); *(u16*)(p + 12) = lsize; lsize += psize;

          for (j = 0; j < size; j++)
           BUF_safeadd(mem, u8, p[j])
           FREE(p)
         }
        }
       writeh(hf, &mem, "imagesdata");
       writeh16(hf, &offset, "imagesidx");
      }
      BUF_free(offset)
      BUF_free(mem)
      file_close(hf); 
     }
     }
   }

#if !defined(HANDLE_IMAGES)
   file_close(hfIMAGEBAT);
   if(sIMG.nstrings)
    ShellExecuteA(NULL,"open",string_getINInamepath("image.bat",szPath2),NULL,NULL,SW_SHOW);   
#endif
   file_close(hfIMAGEBAT2);  
  
   dict_delete(&sIMG);
   dict_delete(&sVAR);
   dict_delete(&sKEYS);
   dict_delete(&sCKEYS);
   dict_delete(&sVRB);
   dict_delete(&sROOM);
   dict_delete(&sOBJ);
   dict_delete(&sCMD);
   dict_delete(&sNAMES);
   dict_delete(&sDESC);
   dict_delete(&sMSG);
   dict_delete(&sMSG2);
   dict_delete(&sMETA);
   dict_delete(&sATTR);

   dict_delete(&sATTRS);
   dict_delete(&sSCENERY);

   dict_delete(&sARTS);
   dict_delete(&sADJS);
   dict_delete(&sOBJSYNS);
   dict_delete(&sVRBSYNS);
   dict_delete(&sGENS);

   dict_delete(&sADDSCORE);

   FREE(p)
   printf("Done.\n");
   if(theerrors)
    return 0;
   else
    return 1;
  }
 else
  printf("Can't read %s\n",argv[1]); 
 }
 else
 {
  printf("Usage: script_compiler <mainscript.hjt/.txt> [<header path> <cartdrige name>]\n");
  printf("i.e.:  script_compiler accuse.hjt storytllr64_data.h advcartdrige\n");
  }
 return 0;
}