#ifndef mg_font_h
#define mg_font_h

#define MGFONT_IMPLEMENTATION

#ifdef __cplusplus
extern "C" {
#endif

#include "img.h"

#define font_outline 32

 typedef struct{
  word x,y;
  word w,h;
  word ch;
 }_fontchar;

typedef struct{
 _strhash      name;
 byte          flags;
 word          count;

 _img          t;
 float         fnt_size;
 short         fnt_ascent,fnt_descent;
 word          w,h;
 unsigned char map[256];
 _fontchar*    chars;
 word          charscount;
}_font,*_font_ptr;

int font_new(_font*f,const char*name,float fontsize,const char*sequence,int mode);
int font_delete(_font*f);
int font_calcwh(_font*f,const char*text,int w,int flags);
int font_draw(_font*f,_img*canvas,int x,int y,int w,int h,const char*text,dword color,int flags);

#ifdef MGFONT_IMPLEMENTATION

#ifndef MGFONT_IMPLEMENTATION_ONCE
#define MGFONT_IMPLEMENTATION_ONCE

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include "minilib.h"
#include "asefile.h"

#define TTF_SUPPORT

#if defined(TTF_SUPPORT)
#define STB_TRUETYPE_IMPLEMENTATION
#include "../stb/stb_truetype.h"
#endif

byte*res_get(const char*nm,dword*size);

#define default_textsequence "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,:;?!-_'\"()/"

typedef struct {
 unsigned char ch;
 unsigned char*buffer;
 int           buffersize;
 int           advance,xo,yo;
 int           gmCellIncX;
 int           gmBlackBoxX,gmBlackBoxY;
}_gly;

void ttf_addchar(void*atlas,stbtt_fontinfo*s_font,float scale,int font_ascent,int font_descent,unsigned char c,_gly*gly)
{
 int           w,h,lsb,advance,x0,y0,x1,y1;
 unsigned char*bitmap = stbtt_GetCodepointBitmap(s_font, scale, scale, c, &w, &h, &gly->xo,&gly->yo);
 int g = stbtt_FindGlyphIndex(s_font, c); 
 stbtt_GetGlyphHMetrics(s_font, g, &advance, &lsb);
 stbtt_GetGlyphBitmapBox(s_font, g, scale,scale, &x0,&y0,&x1,&y1);
 
 gly->gmCellIncX=gly->gmBlackBoxX=w;
 gly->gmBlackBoxY=h;
 stbtt_GetCodepointHMetrics(s_font,c,&gly->advance,&lsb); 
 //mg_addtoATLAS(atlas,"",bitmap,w,h,1); 
 mg_addtoATLASex(atlas,"",bitmap,w,font_ascent-font_descent,gly->xo,gly->yo+font_ascent,w,h,1);//gly->xo,gly->yo+font_ascent,w,h,1); 
}

int font_new(_font*f,const char*name,float fontsize,const char*sequence,int mode)
{
 dword          size;
 unsigned char *ttf=res_get(name,&size);
 if(ttf)
  {   
#if defined(TTF_SUPPORT)
   stbtt_fontinfo s_font;   
   if(sequence==NULL) sequence=default_textsequence;
   if(stbtt_InitFont(&s_font,ttf,stbtt_GetFontOffsetForIndex(ttf,0)))
    {
     int   i,idx=0,x0,x1,y0,y1;
     float scale;
     int   fntOTM_ascent,fntOTM_descent;
     void *atlas=mg_createATLAS();
     _font*font=f;
     font->name=strhash(name);
     //cache_clean(t);
     font->fnt_size=fontsize;
     scale=stbtt_ScaleForPixelHeight(&s_font,font->fnt_size);//*1.25f;
     stbtt_GetFontBoundingBox(&s_font,&x0,&y0,&x1,&y1);
     stbtt_GetFontVMetrics(&s_font,&fntOTM_ascent,&fntOTM_descent,NULL);
     font->fnt_ascent=(int)(fntOTM_ascent*scale);
     font->fnt_descent=(int)(fntOTM_descent*scale);          
     
     mg_addtoATLASex_starttag(atlas,name);
     
     idx=i=0;
     while(sequence[i])
      {
       unsigned char ch=sequence[i];
       if((ch=='[')&&sequence[1]&&(sequence[2]=='-')&&sequence[3]&&(sequence[4]==']'))
        {
         unsigned char chA=sequence[1],chB=sequence[3];
         while(chA<=chB)
          idx++;             
         i+=5;
        }
       else 
        {  
         idx++;
         i++;
        }
      }
     font->charscount=idx;
     font->chars=(_fontchar*)ALLOC(font->charscount*sizeof(font->chars[0]));
     idx=i=0;
     while(sequence[i])
      {
       unsigned char ch=sequence[i];
       _gly          gly;
       if((ch=='[')&&sequence[1]&&(sequence[2]=='-')&&sequence[3]&&(sequence[4]==']'))
        {
         unsigned char chA=sequence[1],chB=sequence[3];
         while(chA<=chB)
          {
           ttf_addchar(atlas,&s_font,scale,font->fnt_ascent,font->fnt_descent,chA,&gly);
           font->chars[idx].ch=chA;
           font->map[chA++]=idx++;
          } 
         i+=5;
        }
       else 
        {  
         ttf_addchar(atlas,&s_font,scale,font->fnt_ascent,font->fnt_descent,ch,&gly);
         font->chars[idx].ch=ch;
         font->map[ch]=idx++;
         i++;
        }
      } 
     mg_addtoATLASex_endtag(atlas); 
     if(idx)
      { 
       _animation   *anim;
       int           i,w,h,mw=0,mh=0;
       unsigned char*img=mg_buildATLAS(atlas,&w,&h,NULL,&anim,NULL,atlas_dontswapy); 
       font->t.a=img;
       font->t.w=w;font->t.h=h;

       for(i=0;i<anim->nframes;i++)
       {
        font->chars[i].x=anim->frames[i].uv.x;
        font->chars[i].y=anim->frames[i].uv.y;
        font->chars[i].w=anim->frames[i].uv.w;
        font->chars[i].h=anim->frames[i].uv.h;
        if(font->chars[i].w>mw)
         mw=font->chars[i].w;
        if(font->chars[i].h>mh)
         mh=font->chars[i].h;
       }
       font->w=mw;
       font->h=mh;
       /*font->t=tex_readMemory(gs,img,w,h,32,name,0,anim);
       FREE(img);*/
       mg_deleteATLAS(atlas); 
      } 
     
     FREE(ttf);        
     return 1;
    }
   else 
    FREE(ttf);         
#endif
  }
 return 0;
}

int font_delete(_font*f)
{
 img_delete(&f->t);
 return 1;
}

void font_img_blit(_img*idst,int px,int py,_img*i,int x,int y,int w,int h,dword color,dword outline,int flip)
{
 int   xx,yy,ww=idst->w,hh=idst->h,xxx,prev=-1,next=1;
 dword*canvas=idst->rgba;
 for(yy=0;yy<h;yy++)
  if(isbetween((py+yy),0,hh-1)&&isbetween((y+yy),0,i->h-1))
  for(xx=0;xx<w;xx++)
   if(isbetween((px+xx),0,ww-1)&&isbetween((x+xx),0,i->w-1))
    {     
     byte  alpha;
     dword val;
     if(flip&1)
      {val=i->rgba[x+(w-xx-1)+(y+yy)*i->w];xxx=(w-xx-1);next=-1;prev=1;}
     else
      {val=i->rgba[x+xx+(y+yy)*i->w];xxx=xx,next=1,prev=-1;}
     alpha=(val&0xFF000000)>>24;
     if(alpha)
      if(alpha==255)
       {
        canvas[(px+xx)+(py+yy)*ww]=val;
        if(flip&font_outline)
         {
          if(img_get(i,xxx+x+prev,yy+y)==0)
           img_set(idst,px+xx-1,py+yy,outline);
          if(img_get(i,xxx+x+next,yy+y)==0)
           img_set(idst,px+xx+1,py+yy,outline);
          if(img_get(i,xxx+x,yy+y-1)==0)
           img_set(idst,px+xx,py+yy-1,outline);
          if(img_get(i,xxx+x,yy+y+1)==0)
           img_set(idst,px+xx,py+yy+1,outline);
         }
       }
      else
       {
        dword val2=canvas[(px+xx)+(py+yy)*ww];
        byte  r=((val&0xFF)*alpha+(val2&0xFF)*(255-alpha))/255;
        byte  g=((((val&0xFF00)>>8)*alpha+((val2&0xFF00)>>8)*(255-alpha))/255);
        byte  b=((((val&0xFF0000)>>16)*alpha+((val2&0xFF0000)>>16)*(255-alpha))/255);
        canvas[(px+xx)+(py+yy)*ww]=r|(g<<8)|(b<<16)|0xFF000000;        
       }
    }
}

int font_calcwh(_font*f,const char*text,int w,int flags)
{
 int i=0,px=0,py=0,mw=0,mh=0;
 while(text[i])
  {
   int tch=text[i];
   if(tch=='\n')
    {
     px=0;
     py+=f->h;
    }
   else
   if(tch==' ')
    px+=f->w/2;
   else
   {
    int ch=f->map[tch];
    if(ch)
     px+=f->chars[ch].w+(1*((flags&font_outline)==font_outline));
    else
     px+=f->w/2;
   }
   if(px>mw)
    mw=px;
   if(py>mh)
    mh=py;
   i++;
  }
 return px;
}

int font_draw(_font*f,_img*canvas,int x,int y,int w,int h,const char*text,dword color,int flags)
{
 int i=0,px=x,py=y;
 while(text[i])
  {
   int tch=text[i];
   if(tch=='\n')
   {
    px=x;
    py+=f->h;
   }
   else
   if(tch==' ')
    px+=f->w/2;
   else
    {
     int ch=f->map[tch];
     if(ch)
      {
       font_img_blit(canvas,px,py,&f->t,f->chars[ch].x,f->chars[ch].y,f->chars[ch].w,f->chars[ch].h,color,0xFF000000,flags);
       px+=f->chars[ch].w+(1*((flags&font_outline)==font_outline));
      }
     else
      px+=f->w/2;
    }
   i++;
  }
 return 1;
}

#endif
#endif

#ifdef __cplusplus
}
#endif


#endif