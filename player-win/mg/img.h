//
// Copyright (c) 2023, Marco Giorgini [ @marcogiorgini ]
// Distributed under the MIT License
//
// (very) basic img handling
//

#ifndef mg_img_h
#define mg_img_h

#ifdef __cplusplus
extern "C" {
#endif

typedef struct{
 byte    attr,depth;
 word    w,h;
 union{
  dword*  rgba;
  byte*   a;
 };
}_img;

/*
 word nanims;
 word nframes;
*/

void  img_new(_img*i,int w,int h);
void  img_delete(_img*i);

int   img_load(_img*img,const char*name);

dword img_get(_img*i,int x,int y);
void  img_set(_img*i,int x,int y,dword col);

void  img_box(_img*idst,int x,int y,int w,int h,dword col);
void  img_line(_img*idst,int x0,int y0,int x1,int y1,dword col);
void  img_blit(_img*idst,int px,int py,_img*i,int x,int y,int w,int h,int flip);

void efx_fade(_img*idst,int pos,int top,int efx);

#ifdef __cplusplus
}
#endif

#endif

#ifdef MGIMG_IMPLEMENTATION

#ifndef MGIMG_IMPLEMENTATION_ONCE
#define MGIMG_IMPLEMENTATION_ONCE

#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

void img_new(_img*i,int w,int h)
{
 memset(i,0,sizeof(_img));
 i->rgba=(dword*)calloc(w*h,sizeof(dword));
 i->w=w;i->h=h;
 i->attr=1;
}

int  img_load(_img*img,const char*name)
{ 
 dword  size;
 byte  *mem=res_get(name,&size);
 if(mem)
  {
   int       width, height;
   dword*    image;
   qoi_desc  desc;
   memset(img,0,sizeof(*img));         
   image = (dword*) qoi_decode(mem,size, &desc, 4 );
   width=desc.width;height=desc.height;
   if(image)
    {
     img->rgba=image;
     img->w=width;img->h=height;
     img->attr=0;
     return 1;
    }
  }
 return 0;
}
void img_delete(_img*i)
{
 if(i->attr&1)
  free(i->rgba); 
 i->rgba=NULL;i->w=i->h=0;
}

void img_line(_img*idst,int x0,int y0,int x1,int y1,dword col)
{
    int dx = abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
    int dy = abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
    int err = (dx > dy ? dx : -dy) / 2;

    while (img_set(idst,x0, y0,col), x0 != x1 || y0 != y1)
    {
        int e2 = err;
        if (e2 > -dx) { err -= dy; x0 += sx; }
        if (e2 <  dy) { err += dx; y0 += sy; }
    }
}

dword img_mix(dword col,dword col2,byte alpha)
{
 byte  r=((col&0xFF)*alpha+(col2&0xFF)*(255-alpha))/255;
 byte  g=((((col&0xFF00)>>8)*alpha+((col2&0xFF00)>>8)*(255-alpha))/255);
 byte  b=((((col&0xFF0000)>>16)*alpha+((col2&0xFF0000)>>16)*(255-alpha))/255);
 return r|(g<<8)|(b<<16)|0xFF000000;        
}

dword img_get(_img*i,int x,int y)
{
 if((x>=0)&&(x<i->w)&&(y>=0)&&(y<i->h))
  return i->rgba[x+y*i->w];
 else
  return 0;
}

dword img_rgba(byte r,byte g,byte b,byte a)
{
 return r|(g<<8)|(b<<16)|(a<<24);
}

void img_set(_img*i,int x,int y,dword col)
{
 if((x>=0)&&(x<i->w)&&(y>=0)&&(y<i->h))
  {
   byte alpha=(col&0xFF000000)>>24;
   if(alpha)
    if(alpha==255)
     i->rgba[x+y*i->w]=col;
    else
     {
      dword val2=i->rgba[x+y*i->w];
      byte  r=((col&0xFF)*alpha+(val2&0xFF)*(255-alpha))/255;
      byte  g=((((col&0xFF00)>>8)*alpha+((val2&0xFF00)>>8)*(255-alpha))/255);
      byte  b=((((col&0xFF0000)>>16)*alpha+((val2&0xFF0000)>>16)*(255-alpha))/255);
      i->rgba[x+y*i->w]=r|(g<<8)|(b<<16)|0xFF000000;        
     }
  }
}

void img_box(_img*idst,int x,int y,int w,int h,dword col)
{
 int   xx,yy,hh=idst->h,ww=idst->w;
 dword*canvas=idst->rgba;
 for(yy=0;yy<h;yy++)
  if(isbetween(y+yy,0,hh-1))
   for(xx=0;xx<w;xx++)
    if(isbetween(x+xx,0,ww-1))
    {
     byte alpha=(col&0xFF000000)>>24;
     if(alpha)
      if(alpha==255)
       canvas[(x+xx)+(y+yy)*ww]=col;
      else
       {
        dword val2=canvas[(x+xx)+(y+yy)*ww];
        byte  r=((col&0xFF)*alpha+(val2&0xFF)*(255-alpha))/255;
        byte  g=((((col&0xFF00)>>8)*alpha+((val2&0xFF00)>>8)*(255-alpha))/255);
        byte  b=((((col&0xFF0000)>>16)*alpha+((val2&0xFF0000)>>16)*(255-alpha))/255);
        canvas[(x+xx)+(y+yy)*ww]=r|(g<<8)|(b<<16)|0xFF000000;        
       }
    }
}

void efx_fade(_img*idst,int pos,int top,int efx)
{
 byte alpha=0;
 switch(efx)
 {
 case 1:
  alpha=(top-pos)*255/top;
  img_box(idst,0,0,idst->w,idst->h,0x000000|(alpha<<24));
  break;
 case -1:
  alpha=(pos)*255/top;
  img_box(idst,0,0,idst->w,idst->h,0x000000|(alpha<<24));
  break;
 }
}

void img_blit(_img*idst,int px,int py,_img*i,int x,int y,int w,int h,int flip)
{
 int   xx,yy,ww=idst->w,hh=idst->h;
 dword*canvas=idst->rgba;
 for(yy=0;yy<h;yy++)
  if(isbetween((py+yy),0,hh-1)&&isbetween((y+yy),0,i->h-1))
  for(xx=0;xx<w;xx++)
   if(isbetween((px+xx),0,ww-1)&&isbetween((x+xx),0,i->w-1))
    {     
     byte  alpha;
     dword val;
     if(flip&1)
      val=i->rgba[x+(w-xx-1)+(y+yy)*i->w];
     else
      val=i->rgba[x+xx+(y+yy)*i->w];
     alpha=(val&0xFF000000)>>24;
     if(alpha)
      if(alpha==255)
       canvas[(px+xx)+(py+yy)*ww]=val;
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

#endif
#ifdef __cplusplus
}
#endif
#endif
