#define IMAGEFORMAT_ASE
#define ASE_POLYSUPPORT
#define ATLAS_DUMP

#if !defined(IMAGEFORMAT_ASE)

#else

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include "asefile.h"

#define STBI_SUPPORT_ZLIB
#if defined(TARGET_HTML5)
#include "../stb/stb_image.h"
#else
#include "../stb/stb_image.h"
#endif

#define STB_RECT_PACK_IMPLEMENTATION
#if defined(TARGET_HTML5)
#include "../stb/stb_rect_pack.h"
#else
#include "../stb/stb_rect_pack.h"
#endif

// ---
// -------------------------------------



// -------------------------------------
// ---

int bOptimize=0; // 1 - x | 2 -y
int g_atlas_cnt=0;
//
//#define ATLAS_DUMP
#if defined(ATLAS_DUMP)
#include "../stb/stb_image_write.h"
#endif



typedef struct tagI32{
 unsigned int* p;
 int           sx,sy;
 int           ox,oy,lx,ly;
 int           duration;
 char          used,attr;
 short         frame,layer;
 char          name[256];
}I32;

typedef struct tagIMGTAG{
 char  name[32];
 short from,to;
 short time;
 short attr; 
}IMGTAG;

carray_define(tagAGMEMI,AGMEMI,int)
carray_define(tagAGI32,AGI32,I32)
carray_define(tagAGIMGTAG,AGIMGTAG,IMGTAG)

#include "aseformat.h"

void I32_new(I32*i,int w,int h)
{
 memset(i,0,sizeof(I32));
 i->lx=i->sx=w;
 i->ly=i->sy=h;
 i->p=(unsigned int*)ALLOC(i->sx*i->sy*sizeof(i->p[0]));
}

void I32_delete(I32*img)
{
 FREE(img->p);
}

void I32_copyex(I32*dest,int x,int y,I32*source,int sx,int sy,int sw,int sh)
{
 int xx,yy; 
 for(yy=0;yy<sh;yy++)
  for(xx=0;xx<sw;xx++)
   {                         
    unsigned char*s=(unsigned char*)(&source->p[(sx+xx)+(sy+yy)*source->sx]);
    if(isbetween((xx+x),0,dest->sx-1)&&isbetween((yy+y),0,dest->sy-1))
     {
      unsigned char*d=(unsigned char*)(&dest->p[(xx+x)+(yy+y)*dest->sx]);
      if(s[3])
       {
        if(d[3]==0)
         memcpy(d,s,4);
        else
         memcpy(d,s,4); 
       }  
     }  
   }
}

void I32_copy(I32*dest,int x,int y,I32*source)
{
 I32_copyex(dest,x,y,source,0,0,source->sx,source->sy); 
}
 
DWORD I32_get(I32*i,int x,int y,int mask)
{
 DWORD w=0;
 if(isbetween(x,0,i->sx-1)&&isbetween(y,0,i->sy-1))
  w=i->p[x+y*i->sx];
 if(mask&8)
  return (w&0xFF000000)>>24;
 else
  return w; 
}

void I32_opacity(I32*i,int opacity)
{
 int x,y,n=4,w=i->sx,h=i->sy;
 unsigned char*data=(unsigned char*)i->p;
 for(x=0;x<w;x++)     
  for(y=0;y<h;y++)
   {
    unsigned char*pix=&data[x*n+y*n*w];
    pix[3]=(pix[3]*opacity/255);    
		  }
}

int I32_optimize(I32*img,int border,int way)
{
 int x,y,mx=img->sx,my=img->sy,MX=0,MY=0;
 for(y=0;y<img->sy;y++)
  for(x=0;x<img->sx;x++)
   if(I32_get(img,x,y,8))
    {
    if(x<mx) mx=x;
    if(y<my) my=y;
    if(x>MX) MX=x;
    if(y>MY) MY=y;
    }
 if(way&1)
  {   
   int lmx=(img->sx-1-MX);
   if(mx>lmx)
    mx=lmx;
   if(mx>border)
    {
     mx-=border;
     img->ox=mx;   
     img->lx-=mx*2;
     //img->lx=MX-mx+1;
    }
  }
 if(way&4)
 {
  if(my>border)
  {
   img->oy=my; 
   img->ly-=my;
  }
 }
 else
 if(way&2)
  {  
   int lmy=(img->sy-1-MY);
   if(my>lmy)
    my=lmy;
   if(my>border)
    {
    img->oy=my; 
    img->ly-=my*2;
    }
  } 
 if((img->lx!=img->sx)||(img->ly!=img->sy))
  return 1;
 else
  return 0; 
}
 
void I32_blend(I32*i,int x,int y,DWORD col)
{
 if(isbetween(x,0,i->sx-1)&&isbetween(y,0,i->sy-1))
  {
   DWORD w=i->p[x+y*i->sx];
   BYTE  r,g,b,a,r1,g1,b1,a1;
   a=(w&0xFF000000)>>24;
   b=(BYTE)((w&0xFF0000)>>16);
   g=(BYTE)((w&0xFF00)>>8);
   r=(w&0xFF);
   a1=(col&0xFF000000)>>24;
   b1=(BYTE)((col&0xFF0000)>>16);
   g1=(col&0xFF00)>>8;
   r1=(col&0xFF);
   r=((r*(255-a1))+(r1*a1))>>8;
   g=((g*(255-a1))+(g1*a1))>>8;
   b=((b*(255-a1))+(b1*a1))>>8;
   i->p[x+y*i->sx]=(a<<24)+(b<<16)+(g<<8)+r;
  } 
}

void outline(I32*img)
{
 int  x,y;
 BYTE*b=(BYTE*)ALLOC(img->sx*img->sy);
 y=img->sy;   
 while(y--)
  {
   x=img->sx;
   while(x--)
    if(I32_get(img,x,y,8)==0)
     {
      int l=0,d=0;
      if((I32_get(img,x-1,y,8))||(I32_get(img,x,y-1,8))||(I32_get(img,x+1,y,8))||(I32_get(img,x,y+1,8)))
       b[x+y*img->sx]=1;
      else
      if((I32_get(img,x-1,y-1,8))||(I32_get(img,x+1,y-1,8))||(I32_get(img,x+1,y+1,8))||(I32_get(img,x-1,y+1,8))) 
       b[x+y*img->sx]=1;
     }    
 }
 y=img->sy;   
 while(y--)
  {
   x=img->sx;
   while(x--) 
    if(b[x+y*img->sx])
     img->p[x+y*img->sx]=0xA0000000;
  } 
 FREE(b);
}
 
void efx(I32*img,int kind)
{
 int x,y;
 switch(kind)
  {
   case 2:
    {
     y=img->sy;   
     while(y--)
      {
       x=img->sx;
       while(x--)
        if(I32_get(img,x,y,8)==0)
         {
          int l=0,d=0;
          if((I32_get(img,x-1,y,8))||(I32_get(img,x,y-1,8)))
           img->p[x+y*img->sx]=0xFF0000FF;
         }    
     }
    }
   break;
   default:
    {      
     for(y=0;y<img->sy;y++)
      for(x=0;x<img->sx;x++)
       if(I32_get(img,x,y,8)==0)
        {
         int l=0,d=0;
         if((I32_get(img,x+1,y,8))||(I32_get(img,x,y+1,8)))
          img->p[x+y*img->sx]=0x80FFFFFF;
        }
     y=img->sy;   
     while(y--)
      {
       x=img->sx;
       while(x--)
        if(I32_get(img,x,y,8)==0)
         {
          int l=0,d=0;
          if((I32_get(img,x-1,y,8))||(I32_get(img,x,y-1,8)))
           img->p[x+y*img->sx]=0x80FFFFFF;
         }    
     }
   }  
  }     
/*    
   if(I32_get(img,x,y,8))
    {
     int l=0,d=0;
     if((I32_get(img,x-1,y,8)==0)||(I32_get(img,x,y-1,8)==0))
      l=1;
     if((I32_get(img,x+1,y,8)==0)||(I32_get(img,x,y+1,8)==0))
      d=1;     
     if(l!=d)
      if(l)
       I32_blend(img,x,y,0x20FFFFFF);
      else 
       I32_blend(img,x,y,0x20000000);
    }
*/   
}

int I32_isempty(I32*i)
{
 const unsigned char*data=(const unsigned char*)i->p;
 int                 w=i->sx,h=i->sy;
 int                 x,y,n=4;
 for(x=0;x<w;x++)     
  for(y=0;y<h;y++)
   {
    const unsigned char*pix=&data[x*n+y*n*w];
    if(pix[3]!=0)
     return 0;       
   }
 return 1;
}

const char*S_gettokenex(const char*s,char*line,int max,char sep)
{
 int j=0;
 const char*bs=s;
 while(*s&&(*s!=sep))
  if(s-bs<max)
   line[j++]=*s++;
  else
   s++;
 line[j]=0;
 if(*s==sep) s++;
 return s;
}

int namecnt(AGI32*ii,const char*nm)
{
 int i,cnt=0;
 for(i=0;i<ii->cnt;i++)
  if(strcmp(ii->items[i].name,nm)==0)
   cnt++;
 return cnt;
}

#if defined(ASE_POLYSUPPORT)

typedef struct{
 int x,y;
}PT;
carray_define(tagAGPT,AGPT,PT)

typedef enum {
	RIGHT=1, BOTTOM=2, LEFT=3, TOP=4
} Direction;

typedef struct tagASEPOINT
{
    long  x;
    long  y;
} ASEPOINT;

ASEPOINT Pavlidis_start_point(unsigned char* srcbin, int wid, int hei, int widstep)
{
	int x=0, y=0;
	ASEPOINT startpoint = {-1, -1};

	for (y=1;y<hei-1;y++)
	{
		for (x=1;x<wid-1;x++)
		{
			if( ! srcbin[y*widstep+x] )
				continue;

			if( ! srcbin[y*widstep+x-1] ) 
			{
				startpoint.x = x;
				startpoint.y = y;
				return startpoint;
			}
		}
	}

	return startpoint;
}


int
Pavlidis_TurnLeft(int d)
{
	int dnew = d - 1;
	if(dnew == 0)
		dnew = 4;
	return dnew;
}

int 
Pavlidis_TurnRight(int d)
{
	int dnew = d + 1;
	if(dnew == 5)
		dnew = 1;
	return dnew;
}

void Pavlidis_contour_tracing(unsigned char* srcbin, 
						 int wid, int hei, int widstep, 
						 unsigned char* dstbin, 
						 int dst_wid, int dst_hei, int dst_widstep,AGPT*pt)
{
	ASEPOINT		startpoint;
	Direction	dir = TOP;
	Direction	startdir = dir;
	ASEPOINT		cpix;
	int			rightturn_step = 0;
	int			tracetime = 4;
	int			maxloop = 1E5;

	startpoint = Pavlidis_start_point(srcbin, wid, hei, widstep);

	if(startpoint.x < 0)
		return;

	memset(dstbin, 0, dst_widstep*dst_hei);

	cpix = startpoint;
	dir = TOP;
	while( maxloop-- )
	{
		ASEPOINT P1,P2,P3;
		int p1, p2, p3;

		// cpix : Current position
		if( cpix.x == startpoint.x
			&& 
			cpix.y == startpoint.y)
		{
			tracetime--;

			if(tracetime == 0)
				break;
		}

		switch (dir)
		{
		case TOP:
			// * * *
			//   o
			P1.x=cpix.x-1; P1.y=cpix.y-1;
			P2.x=cpix.x; P2.y=cpix.y-1;
			P3.x=cpix.x+1; P3.y=cpix.y-1;
			break;
		case LEFT:
			// *
			// * o
			// *
			P1.x=cpix.x-1; P1.y=cpix.y+1;
			P2.x=cpix.x-1; P2.y=cpix.y;
			P3.x=cpix.x-1; P3.y=cpix.y-1;
			break;
		case RIGHT:
			//   * 
			// o *
			//   *
			P1.x=cpix.x+1; P1.y=cpix.y-1;
			P2.x=cpix.x+1; P2.y=cpix.y;
			P3.x=cpix.x+1; P3.y=cpix.y+1;
			break;
		case BOTTOM:
			//   o
			// * * *
			P1.x=cpix.x+1; P1.y=cpix.y+1;
			P2.x=cpix.x; P2.y=cpix.y+1;
			P3.x=cpix.x-1; P3.y=cpix.y+1;
			break;
		};


		p1= srcbin[P1.y*widstep+P1.x];
		p2= srcbin[P2.y*widstep+P2.x];
		p3= srcbin[P3.y*widstep+P3.x];

		if(p1)
		{
   PT p;
   p.x=cpix.x;p.y=cpix.y;
   carray_safeadd((*pt),PT,p)

			dstbin[cpix.y*dst_widstep+cpix.x] = 255;

			cpix = P1;
			dir = (Direction) Pavlidis_TurnLeft(dir);
			rightturn_step = 0;
		}
		else if(p2)
		{
   PT p;
   p.x=cpix.x;p.y=cpix.y;
   carray_safeadd((*pt),PT,p)

			dstbin[cpix.y*dst_widstep+cpix.x] = 255;

			cpix = P2;
			rightturn_step = 0;
		}
		else if(p3)
		{
   PT p;
   p.x=cpix.x;p.y=cpix.y;
   carray_safeadd((*pt),PT,p)

			dstbin[cpix.y*dst_widstep+cpix.x] = 255;

			cpix = P3;
			rightturn_step = 0;
		}
		else 
		{
			dir = (Direction) Pavlidis_TurnRight(dir);
			rightturn_step++;

			if(rightturn_step == 3)
				break;
		}
	}
}

int collinear(int x1, int y1, int x2,
               int y2, int x3, int y3)
{
    // Calculation the area of
    // triangle. We have skipped
    // multiplication with 0.5
    // to avoid floating point
    // computations
    /*float ab = sqrt(pow((float)x2-x1,2)+pow((float)y2-y1,2));
    float bc = sqrt(pow((float)x3-x2,2)+pow((float)y3-y2,2));
    float ac = sqrt(pow((float)x3-x1,2)+pow((float)y3-y1,2));
    float abc;
    abc = ab+bc;
    if(fabs(abc-ac)<0.18f)
     return 1;
    else
     return 0;*/
    int a = x1 * (y2 - y3) +
            x2 * (y3 - y1) +
            x3 * (y1 - y2);
 
    if (isbetween(a,-3,3))
        return 1;
    else
        return 0;
}

int I32_getpoly(I32*img,AGPT*pt)
{
 BYTE*src,*dst;
 int  w=img->sx+2,h=img->sy+2,f=0; 
 int  x=0,y=0; 
 
 for(y=0;y<img->sy;y++)
  for(x=0;x<img->sx;x++)
   if(I32_get(img,x,y,8))
    f++;
 if(img->sx*img->sy-f<6)
  return 0;
  
 src=(BYTE*)ALLOC(w*h);       
 for(y=0;y<img->sy;y++)
  {
   for(x=0;x<img->sx;x++)
    if(I32_get(img,x,y,8))
     src[(x+1)+(y+1)*w]=255;
  }
 dst=(BYTE*)ALLOC(w*h); 
 Pavlidis_contour_tracing(src,w,h,w,dst,w,h,w,pt); 
 FREE(src);
 //stbi_write_png("c:/tmp/prova.png",w,h,1,dst,0);   
 memset(dst,0,w*h); 
 if(pt->cnt)
  {
   int i=0;
   while(i+2<pt->cnt)
   {
    if(collinear(pt->items[i].x,pt->items[i].y,pt->items[i+1].x,pt->items[i+1].y,pt->items[i+2].x,pt->items[i+2].y))
     carray_delete((*pt),PT,i+1)
    else
    i++;
   }
   for(i=0;i<pt->cnt;i++)
    {
     int x=pt->items[i].x;
     int y=pt->items[i].y;
     dst[(x+1)+(y+1)*w]=255;
    }
  }
 //stbi_write_png("c:/tmp/prova2.png",w,h,1,dst,0); 
 FREE(dst);
 if(pt->cnt)
  {
   return pt->cnt;
  }
 else  
  return 0; 
}
#endif

int I32_trim(AGI32*aimg,const char*name,int*x,int*y)
{
 int i,xmargin=0;   
 int left=aimg->items[0].sx,oright=left,right=0,top=aimg->items[0].sy,bottom=0,obottom=top;
 for(i=0;i<aimg->cnt;i++)
  if(strcmp(aimg->items[i].name,name)==0)
  {
   I32*img=&aimg->items[i];
   unsigned char*data=(unsigned char*)img->p;
   int      x,y,w=img->sx,h=img->sy,n=4;     
   for(x=0;x<w;x++)     
    {
     int c=0,cc=0;
     for(y=0;y<h;y++)
      {
       unsigned char*pix=&data[x*n+y*n*w];
       if(pix[3]==0)
        c++; 
       else
        cc++;            
      }
     if(c!=h)
      {
       if(x<left)
        left=x;
       break;  
      }
    }
   x=w; 
   while(x--)
    {
     int c=0;
     for(y=0;y<h;y++)
      {
       unsigned char*pix=&data[x*n+y*n*w];
       if(pix[3]==0)
        c++;            
      }
     if(c!=h)
      {
       if(x>right)
        right=x;
       break;  
      }        
    }   
   for(y=0;y<h;y++)
    {
     int c=0;
     for(x=0;x<w;x++)     
      {
       unsigned char*pix=&data[x*n+y*n*w];
       if(pix[3]==0)
        c++;            
      }
     if(c!=w)
      {
       if(y<top)
        top=y;
       break;  
      }
    }
   y=h; 
   while(y--)
    {
     int c=0;
     for(x=0;x<w;x++) 
      {
       unsigned char*pix=&data[x*n+y*n*w];
       if(pix[3]==0)
        c++;            
      }
     if(c!=w)
      {
       if(y>bottom)
        bottom=y;
       break;  
      }        
    }        
  }
 if((left!=0)||(right!=oright)||(top!=0)||(bottom!=obottom)) 
  {
   int ww=right-left+1,hh=bottom-top+1,rrr=0,bbb=0;
   int bb=aimg->items[i].sy-(top+1);
   for(i=0;i<aimg->cnt;i++)
    if(strcmp(aimg->items[i].name,name)==0)
    {
     I32*img=&aimg->items[i];
     unsigned char*ndata=(unsigned char*)ALLOC(4*ww*hh);
     unsigned char*data=(unsigned char*)aimg->items[i].p;
     int      x,y,w=aimg->items[i].sx,h=aimg->items[i].sy,n=4;
     rrr=w-(right+1);
     bbb=h-(bottom+1);
     for(y=0;y<hh;y++)
      for(x=0;x<ww;x++)     
       {
        unsigned char*pix=&data[(x+left)*n+(y+top)*n*w];
        unsigned char*npix=&ndata[x*n+y*n*ww];
        memcpy(npix,pix,4);
       }
     FREE(aimg->items[i].p);
     aimg->items[i].p=(unsigned int*)ndata;
     aimg->items[i].lx=aimg->items[i].sx=ww;
     aimg->items[i].ly=aimg->items[i].sy=hh;
    }   
   if(x) *x=(left+rrr)/2;
   if(y) *y=(top+bbb)/2; 
   return 1;
  }
 else
  {
   if(x) *x=0;
   if(y) *y=0; 
   return 0;
  }  
}

int choosebestsize(int sx,int sy,int hm,int*nw,int*nh)
{
 int sq=(int)sqrt((float)hm),wx,wy;
 int lnw=1,lnh=1; 
 if(sq<2) sq=2; 
 wx=sx*sq;wy=sy*sq;
 while(lnw<wx) lnw*=2;
 while(lnh<wy) lnh*=2;
 if(nw) *nw=lnw;
 if(nh) *nh=lnh;
 return 1;
}

#if defined(ADX_ENGINE)

extern int g_advASEload;

#define kind_obj      1
#define kind_hotspot  2
#define kind_actor    3
#define kind_walkarea 4
#define kind_mask     5
#define kind_alert    6
#define kind_btn      7
#define kind_undef   -1

int ADXENGINE_addkeyvalue(const char*kind,const char*key,const char*value);

int kindfromname(const char*name,int*pstep,char*extra)
{
 int kind=kind_undef,step=0;
 *extra=0;
 if(memcmp(name,"obj.",4)==0)
  {kind=kind_obj;step=4;}
 else
  if(memcmp(name,"btn.",4)==0)
  {kind=kind_btn;step=4;}
 else
 if(memcmp(name,"hot.",4)==0)
  {kind=kind_hotspot;step=4;}
 else
 if(memcmp(name,"alert.",6)==0)
  {
   kind=kind_alert;step=6;
   sprintf(extra,"alert:%s;",name+6);
  }
 else
 if((memcmp(name,"exitW.",5)==0)||(memcmp(name,"exitE.",5)==0)||(memcmp(name,"exitN.",5)==0)||(memcmp(name,"exitS.",5)==0))
  {
   kind=kind_hotspot;step=6;
   if(1)
    sprintf(extra,"movedir:%c;moveto:%s;",name[4],name+6);
   else
    sprintf(extra,"movedir:%c;",name[4]);
  }
 else
 if(memcmp(name,"act.",4)==0)
  {kind=kind_actor;step=4;}
 else
 if(memcmp(name,"mask.",5)==0)
  {kind=kind_mask;step=5;}
 else
 if(strcmp(name,"walkarea")==0)
  {kind=kind_walkarea;} 
 if(pstep) *pstep=step; 
 return kind;
}

int createinfo(char*info,I32*img,int x,int y,int*pkind,char*key)
{
 int  ret=1;
 char extra[256];
 int step,kind=kindfromname(img->name,&step,extra);
 *info=0;
 if((kind==kind_obj)||(kind==kind_mask)||(kind==kind_btn))
  {
  sprintf(info+strlen(info),"name:%s;",img->name+step);
  sprintf(info+strlen(info),"overlay:%s;",img->name);
  strcpy(key,img->name+step);
  }
 else
 if((kind==kind_hotspot)||(kind==kind_actor)||(kind==kind_walkarea)||(kind==kind_alert))
  {
  sprintf(info+strlen(info),"name:%s;",img->name+step);
  strcpy(key,img->name+step);
  ret=0;
  }
 else
  {
  sprintf(info+strlen(info),"name:%s;",img->name);
  sprintf(info+strlen(info),"overlay:%s;",img->name);
  strcpy(key,img->name);
  }
 if(0&&(kind==kind_actor))
  sprintf(info+strlen(info),"pos:%d,%d;",x+img->sx/2,y+img->sy/2); 
 else
  sprintf(info+strlen(info),"pos:%d,%d;size:%d,%d;",x,y,img->sx,img->sy); 
 if(kind==kind_mask) 
  sprintf(info+strlen(info),"decalc:true;"); 
 if((ret||(kind==kind_actor))&&((img->attr&1)==0))  
  sprintf(info+strlen(info),"show:false;"); 
 if(*extra)
  strcat(info,extra);
 if(pkind) *pkind=kind;
 return ret;
}
#endif

typedef struct{
 AGI32    imgarray;
 AGIMGTAG tagarray;
 AGMEMI   start;
}_aseatlas;

void*mg_createATLAS()
{
 _aseatlas*a=(_aseatlas*)ALLOC(sizeof(_aseatlas));
 carray_set(a->imgarray,I32,16)
 carray_set(a->tagarray,IMGTAG,16)      
 carray_set(a->start,int,16)
 return a;
}

void mg_deleteATLAS(void*aa)
{
 _aseatlas*a=(_aseatlas*)aa;
 carray_free(a->start)
 carray_free(a->imgarray)
 carray_free(a->tagarray)
 FREE(a);
}

int mg_core_readASE(const char*mainname,void*mem,int pp,int*w,int*h,void*tatlas,int flags)
{
 _aseatlas   *atlas=(_aseatlas*)tatlas;
 AGI32   *imgarray=&atlas->imgarray;
 AGIMGTAG*tagarray=&atlas->tagarray;
 int      basef=imgarray->cnt,rbasef=basef;
 #if defined(ADX_ENGINE)
 int      bANIM=(g_advASEload==0);
 #else
 int      bANIM=0;
 #endif
 carray_safeadd(atlas->start,int,tagarray->cnt) 
 if(mem) 
  {   
   unsigned char    *b=(unsigned char*)mem;
   struct AsepriteHeader*header=(struct AsepriteHeader*)b;
   int               i=0,j,f;     
   if(header->magic==ASE_FILE_MAGIC)
    {
     int            odd=0;     
     unsigned short layersattr[128];
     int            layertilesetId[128];
     char           layername[128][80];
     unsigned char opac[80];
     int            nlayers=0;
     I32            img;     
     if(w) *w=header->width;
     if(h) *h=header->height;
     i+=128;
     for(f=0;f<header->frames;f++)
      {
       int                    pix=0;
       struct AsepriteFrameHeader*fheader=(struct AsepriteFrameHeader*)&b[i];
       if(fheader->magic!=ASE_FILE_FRAME_MAGIC)
        {
         FREE(mem);
         return 0;
        }       
       i+=sizeof(struct AsepriteFrameHeader);
       
       if(bANIM)
        I32_new(&img,header->width,header->height);
        
       for(j=0;j<fheader->chunks;j++)
        {
         struct   AsepriteChunk*chunk=(struct AsepriteChunk*)&b[i];
         int      k=sizeof(struct AsepriteChunk);
         switch(chunk->type)
          {
           case ASE_FILE_CHUNK_FLI_COLOR2: // Old palette chunk
            odd++;
           break;
           case ASE_FILE_CHUNK_FLI_COLOR: // Old palette chunk
            odd++;
           break;
           case ASE_FILE_CHUNK_LAYER: // Layer Chunk 
            {
             unsigned short flags,layer_type,child_level,blendmode,namelen,w,h;
             unsigned char  opacity;
             char           name[256];
             layersattr[nlayers]=flags=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             layer_type=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             child_level=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             w=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             h=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             blendmode=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             opacity=*(unsigned char*)&b[i+k];
             k+=sizeof(unsigned char);
             k+=3;
             namelen=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             memcpy(name,&b[i+k],namelen);name[namelen]=0;             
             strcpy(layername[nlayers],name);
             opac[nlayers]=opacity;
             img.frame=f;
             img.layer=nlayers;
             k+=namelen;
             layertilesetId[nlayers]=-1;
             if(layer_type==2)
              layertilesetId[nlayers]=*(unsigned int*)&b[i+k];
             nlayers++;
            }
           break;
           case ASE_FILE_CHUNK_CEL: // Cel Chunk
            {
             unsigned short layerindex,celtype;
             unsigned char  opacity;
             short          x,y;
             layerindex=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             x=*(short*)&b[i+k];
             k+=sizeof(unsigned short);
             y=*(short*)&b[i+k];
             k+=sizeof(unsigned short);
             opacity=*(unsigned char*)&b[i+k];
             k+=sizeof(unsigned char);
             celtype=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             k+=sizeof(unsigned char)*7;
             switch(celtype)
              {
               case ASE_FILE_RAW_CEL: // uncompressed
                {
                 odd++;
                }
               break;
               case ASE_FILE_LINK_CEL: // linked
                {
                 odd++;
                }
               break;
               case ASE_FILE_COMPRESSED_TILEMAP:
                {
                 uint16_t mapw,maph,bitspertile;
                 uint32_t bitmasks[4];
                 uint8_t* packedtilemap;
                 int      outlen=0,len,initial_size;
                 int      parse_header=1;
                 uint32_t*tilemap;

                 mapw=*(unsigned short*)&b[i+k];
                 k+=sizeof(unsigned short);
                 maph=*(unsigned short*)&b[i+k];
                 k+=sizeof(unsigned short);
                 bitspertile=*(unsigned short*)&b[i+k];
                 k+=sizeof(unsigned short);

                 bitmasks[0]=*(uint32_t*)&b[i+k];
                 k+=sizeof(bitmasks[0]);
                 bitmasks[1]=*(uint32_t*)&b[i+k];
                 k+=sizeof(bitmasks[1]);
                 bitmasks[2]=*(uint32_t*)&b[i+k];
                 k+=sizeof(bitmasks[2]);
                 bitmasks[3]=*(uint32_t*)&b[i+k];
                 k+=sizeof(bitmasks[3]);

                 k+=10; // reserved

                 packedtilemap=&b[i+k];
                 len=chunk->size-k;
                 initial_size=mapw*maph*bitspertile/8;                  
                 tilemap=(uint32_t*)stbi_zlib_decode_malloc_guesssize_headerflag((char*)packedtilemap,len,initial_size,&outlen,parse_header);                                                      
                 if(tilemap)
                  {
                   I32 img;
                   int skip=0;
                   memset(&img,0,sizeof(img));
                   img.layer=layertilesetId[layerindex];
                   img.attr=64;
                   img.p=tilemap;
                   img.sx=mapw;
                   img.sy=maph;
                   strcpy(img.name,layername[layerindex]+skip);                       
                   img.frame=f;  
                   carray_safeadd((*imgarray),I32,img)
                  }
                }
               break;
               case ASE_FILE_COMPRESSED_CEL: // compressed (inflated)
                {
                 int            celsize;
                 unsigned short w,h;                 
                 unsigned int*  cel=NULL;
                  
                 w=*(unsigned short*)&b[i+k];
                 k+=sizeof(unsigned short);
                 h=*(unsigned short*)&b[i+k];
                 k+=sizeof(unsigned short);
                  
                 if((w!=header->width)||(h!=header->height))
                  odd++;
                  
                 celsize=w*h*4;
                 
                 {
                  const char *buffer=(char*)&b[i+k];
                  int         len=chunk->size-k;
                  int         initial_size=celsize;
                  int         outlen=0;
                  int         parse_header=1;
                  cel=(unsigned int*)stbi_zlib_decode_malloc_guesssize_headerflag(buffer,len,initial_size,&outlen,parse_header);                                     
                  if(outlen==celsize)
                   {
                    int xx,yy,skip;
                                          
                    if(bANIM)
                     {
                      if(layersattr[layerindex]&ASE_LAYER_FLAG_VISIBLE)
                      {
                       int xx,yy;
                       
                       img.frame=f;
                       img.layer=nlayers;
                       img.attr|=(layersattr[layerindex]&ASE_LAYER_FLAG_VISIBLE);
                       skip=layername[layerindex][0]=='=';
                       strcpy(img.name,layername[layerindex]+skip);                       
                      
                       for(yy=0;yy<h;yy++)
                        for(xx=0;xx<w;xx++)
                         {                         
                          unsigned char*s=(unsigned char*)(&cel[xx+yy*w]);
                          if(isbetween((xx+x),0,header->width-1)&&isbetween((yy+y),0,header->height-1))
                           {
                            unsigned char*d=(unsigned char*)(&img.p[(xx+x)+(yy+y)*img.sx]);
                            if(s[3])
                             {
                              pix++;
                              if(d[3]==0)
                               memcpy(d,s,4);
                              else
                               memcpy(d,s,4); 
                             }  
                           }  
                         }
                      }
                     }
                    else 
                     {
                      if(flags&1)
                       {
                        if((y>=0)&&(y+h>header->height))
                         h-=header->height-(y+h);

                       if((y<0)||(y+h>header->height)||(x<0)||(x+w>header->width))
                        {
                         int rw=w,rh=h,bx=x,by=y;
                         if(y<0)
                          {
                           rh-=y;
                           if(rh>header->height)
                            rh=header->height;
                          }
                         else
                         {
                          by=0;
                          if(y+rh>header->height)
                           rh=header->height-y;
                         }
                         if(x<0)
                          {
                           rw-=x;
                           if(rw>header->width)
                            rw=header->width;
                          }
                         else
                          {
                           bx=0;
                           if(x+rw>header->width)
                            rw=header->width-x;
                          }
                         
                         I32_new(&img,rw,rh);
                         for(yy=0;yy<h;yy++)
                          for(xx=0;xx<w;xx++)
                           { 
                            unsigned char*s=(unsigned char*)(&cel[(xx)+(yy)*w]);
                            if(isbetween(xx+x,0,header->width-1)&&isbetween(yy+y,0,header->height-1))
                            {                                                                                   
                             unsigned char*d=(unsigned char*)(&img.p[(xx+bx)+(yy+by)*img.sx]);
                             if(s[3])
                              {
                               pix++;
                               if(d[3]==0)
                                memcpy(d,s,4);
                               else
                                memcpy(d,s,4); 
                              }                              
                            } 
                           }
                         if(x<0) x=0;
                         if(y<0) y=0;
                        } 
                       else
                        { 
                         I32_new(&img,w,h);
                         memcpy(img.p,cel,w*h*4);                            
                        }
                       img.ox=(x+img.sx/2)-header->width/2;img.oy=header->height/2-(y+img.sy/2); 
                       }
                      else
                       {                      
                       I32_new(&img,header->width,header->height);
                       //img.ox=x;img.ox=y;
                       for(yy=0;yy<h;yy++)
                        for(xx=0;xx<w;xx++)
                         {                         
                          unsigned char*s=(unsigned char*)(&cel[xx+yy*w]);
                          if(isbetween((xx+x),0,header->width-1)&&isbetween((yy+y),0,header->height-1))
                           {
                            unsigned char*d=(unsigned char*)(&img.p[(xx+x)+(yy+y)*img.sx]);
                            if(s[3])
                             {
                              pix++;
                              if(d[3]==0)
                               memcpy(d,s,4);
                              else
                               memcpy(d,s,4); 
                             }  
                           }  
                         }
                       }
                      /*if(img.ox<0) 
                       img.ox=0;
                      if(img.oy<0) 
                       img.oy=0;*/
                      skip=layername[layerindex][0]=='=';
                      strcpy(img.name,layername[layerindex]+skip);                       
                      img.frame=f;  
                      img.layer=layerindex;
                      img.duration=fheader->duration;
                      img.attr|=(layersattr[layerindex]&ASE_LAYER_FLAG_VISIBLE);
                      #if defined(ADX_ENGINE)
                      if((!g_advASEload)&&((img.attr&1)==0))
                       I32_delete(&img);
                      else
                      if(I32_isempty(&img))
                       I32_delete(&img);
                      else
                      #else
                      if((flags&1)&&((img.attr&1)==0))
                       I32_delete(&img);
                      else
                      if(I32_isempty(&img))
                       I32_delete(&img);
                      else
                      #endif
                       {
                        if(opac[layerindex]!=255)
                         I32_opacity(&img,opac[layerindex]);
                        if(bOptimize) I32_optimize(&img,1,bOptimize);
                        carray_safeadd((*imgarray),I32,img)
                       } 
                     }  
                    }
                   else
                    odd++; 
                 }
                 free(cel);
                }
               break;
              }
            }           
           break;
           case ASE_FILE_CHUNK_FRAME_TAGS: // Frame Tags Chunk
            {
             unsigned short ntags=*(unsigned short*)&b[i+k];
             int            t;
             k+=sizeof(unsigned short);
             k+=sizeof(unsigned char)*8;
             for(t=0;t<ntags;t++)
              {
               IMGTAG         tag;
               unsigned short from,to,namelen;
               unsigned char  loop;
               char           name[256];
               memset(&tag,0,sizeof(tag));
               from=*(unsigned short*)&b[i+k];
               k+=sizeof(unsigned short);
               to=*(unsigned short*)&b[i+k];
               k+=sizeof(unsigned short);
               loop=*(unsigned char*)&b[i+k];
               k+=sizeof(unsigned char);
               k+=sizeof(unsigned char)*8;
               k+=sizeof(unsigned char)*3;
               k+=sizeof(unsigned char)*1;
               namelen=*(unsigned short*)&b[i+k];
               k+=sizeof(unsigned short);
               memcpy(name,&b[i+k],namelen);name[namelen]=0;
               k+=namelen;
               if(bANIM&&(*name==0))
                ;
               else
                { 
                 if(0)
                  sprintf(tag.name,"%s.%s",mainname,name);
                 else 
                  strcpy(tag.name,name);
                 //strlwr(tag.name);
                 tag.attr=0;
                 if(tag.name[namelen-1]=='*')
                  {
                   tag.name[namelen-1]=0;
                   tag.attr=1;
                  }
                 tag.from=basef+from;
                 tag.to=basef+to;
                 tag.time=fheader->duration;
                 carray_safeadd((*tagarray),IMGTAG,tag)
                } 
              }
             k=0;
            }           
           break;
           case ASE_FILE_CHUNK_PALETTE: // Palette Chunk
            {
             /*
             DWORD         New palette size (total number of entries)
             DWORD         First color index to change
             DWORD         Last color index to change
             BYTE[8]       For future (set to zero)
             + For each palette entry in [from,to] range (to-from+1 entries)
               WORD        Entry flags:
                             1 = Has name
               BYTE        Red (0-255)
               BYTE        Green (0-255)
               BYTE        Blue (0-255)
               BYTE        Alpha (0-255)
               + If has name bit in entry flags
                 STRING    Color name
             */   
            }           
           break;
           case ASE_FILE_CHUNK_USER_DATA: // User Data Chunk
            {
             uint32_t flags;
             uint16_t namelen;
             char     name[256];
             flags=*(uint32_t*)&b[i+k];k+=sizeof(flags);
             if(flags&1)
             {
              namelen=*(unsigned short*)&b[i+k];
              k+=sizeof(unsigned short);
              memcpy(name,&b[i+k],namelen);name[namelen]=0;             
              k+=namelen;
             }
             if(flags&2)
             {
             }
             if(flags&4)
             {
              uint32_t propsize,propnum;
              propsize=*(uint32_t*)&b[i+k];k+=sizeof(propsize);
              propnum=*(uint32_t*)&b[i+k];k+=sizeof(propnum);
             }
            }
           break;
           case ASE_FILE_CHUNK_COLOR_PROFILE:
           case ASE_FILE_CHUNK_SLICE: // User Data Chunk
            {
             int k;
             k=0;
            }           
           break;
           case ASE_FILE_CHUNK_TILESET: // User Data Chunk
            {
             uint32_t tilesetID,tilesetflag,tilesnumber,packedmapsize;
             uint16_t tilesW,tilesH;
             int16_t  baseidx;
             uint8_t* packedmap;
             uint16_t namelen;
             char     name[256];
             uint32_t*tiles;
             int      outlen=0;

             tilesetID=*(uint32_t*)&b[i+k];k+=sizeof(tilesetID);
             tilesetflag=*(uint32_t*)&b[i+k];k+=sizeof(tilesetflag);
             tilesnumber=*(uint32_t*)&b[i+k];k+=sizeof(tilesnumber);
             tilesW=*(uint16_t*)&b[i+k];k+=sizeof(tilesW);
             tilesH=*(uint16_t*)&b[i+k];k+=sizeof(tilesH);
             baseidx=*(int16_t*)&b[i+k];k+=sizeof(baseidx);
             k+=14; // reserved
             namelen=*(unsigned short*)&b[i+k];
             k+=sizeof(unsigned short);
             memcpy(name,&b[i+k],namelen);name[namelen]=0;k+=namelen;
             packedmapsize=*(uint32_t*)&b[i+k];k+=sizeof(packedmapsize);
             if(packedmapsize==0)
              packedmapsize=chunk->size-k;
             packedmap=&b[i+k];
             tiles=(uint32_t*)stbi_zlib_decode_malloc_guesssize_headerflag((char*)packedmap,packedmapsize,tilesW*tilesH*tilesnumber*sizeof(uint32_t),&outlen,1);                                     
             if(tiles)
              {
               I32 img;
               memset(&img,0,sizeof(img));
               img.layer=tilesetID;
               img.attr=128;
               img.p=tiles;
               img.sx=tilesW;
               img.sy=tilesH*tilesnumber;
               img.duration=tilesnumber;
               carray_safeadd((*imgarray),I32,img)
               #if defined(ATLAS_DUMP)
               if(1)
               {
                char n[256];
                sprintf(n,"tileset.%d.png",++g_atlas_cnt);
                stbi_write_png(n,img.sx,img.sy,4,img.p,0);
               }
               #endif
              }
             /*
             const char *buffer=(char*)&b[i+k];
             int         len=chunk->size-k;
             int         initial_size=celsize;
             int         outlen=0;
             int         parse_header=1;
             cel=(unsigned int*)stbi_zlib_decode_malloc_guesssize_headerflag(packedmap,packedmapsize,tilesW*tilesH*,&outlen,1);                                     
             */
            }           
           break;
           default:
            odd++;
          }
         i+=chunk->size;
        }
       if(tagarray->cnt)
        {
         int j;
         for(j=0;j<tagarray->cnt;j++)
          if(isbetween(basef+f,tagarray->items[j].from,tagarray->items[j].to))
           {
            tagarray->items[j].time=fheader->duration;
            break;
           } 
        } 
        
       if(bANIM)
        { 
         img.duration=fheader->duration;
         carray_safeadd((*imgarray),I32,img)             
        } 
        
       //efx(&img,0);
       
       //FREE(img.p)        
      }          
     basef+=f;            
    }
   else
    {     
     return 0; 
    } 
  }
 else
  return 0;
 #if defined(ADX_ENGINE)
 if(g_advASEload==1)
  ;
 else
 #endif
 if(atlas->start.items[atlas->start.cnt-1]==tagarray->cnt)
  {
   IMGTAG tag;
   tag.attr=0;
   strcpy(tag.name,"default");
   tag.from=rbasef;
   tag.to=imgarray->cnt;
   tag.time=1000;
   carray_safeadd((*tagarray),IMGTAG,tag)
  } 
 return 1; 
}

int I32_draw_pointrow(I32*img,int x,int y,unsigned int col,unsigned char*alpha64,int sx,int flags)
{
 //y=(img->sy-y-1);
 if(isbetween(y,0,img->sy-1)&&(x<img->sx)&&(x+sx>0))
  {
   if(x<0)
    {
     alpha64+=(0-x);
     x+=(0-x);
    }
   if(x+sx>img->sx-1)
    sx=(img->sx-1)-x;
   if(sx)
    {
     unsigned char*p=(unsigned char*)&img->p[x+y*img->sx];
     unsigned char*pcol=(unsigned char*)&col;   
     while(sx--)
      {
       unsigned char a=*alpha64++;
       if(a==0)
        p+=4;
       else
       if(a==255)
        {
         *p++=pcol[0];
         *p++=pcol[1];
         *p++=pcol[2];
         *p++=255;
         //p++;
        }
       else
        {       
         if((flags&1)&&(a>128))
          {
           *p++=255;
           *p++=255;
           *p++=255;
           *p++=255;
          }
         else         
         if((flags&1)&&(a<96))
          p+=4;
         else         
         if(1)
          {
           float alpha=((float)a/(float)255.0),nalpha=1-alpha;
           *p++=(unsigned char)(float)(((float)*p*nalpha)+((float)pcol[0]*alpha));         
           *p++=(unsigned char)(float)(((float)*p*nalpha)+((float)pcol[1]*alpha));         
           *p++=(unsigned char)(float)(((float)*p*nalpha)+((float)pcol[2]*alpha));
           *p++=255;
          }
         else
          {
           *p++=pcol[0];
           *p++=pcol[1];
           *p++=pcol[2];
           *p++=(BYTE)((float)a*4.0f);
          }
        }
      }
    }
   return 1;
  }
 else
  return 0;
}

void mg_addtoATLAS(void*atlas,const char*name,void*mem,int w,int h,int mode)
{
 _aseatlas* tatlas=(_aseatlas*)atlas;
 I32    img;
 IMGTAG tag;
 int    basef=tatlas->imgarray.cnt;
 
 carray_safeadd(tatlas->start,int,tatlas->tagarray.cnt) 
 
 tag.attr=0;
 strcpy(tag.name,"default");
 tag.from=basef+0;
 tag.to=basef+0;
 tag.time=1000;
 carray_safeadd(tatlas->tagarray,IMGTAG,tag)
 
 I32_new(&img,w,h);
 strcpy(img.name,name);
 switch(mode)
  {
   case 4:
    memcpy(img.p,mem,img.sx*img.sy*4);
   break;
   case 1:
    {
     int           y;
     unsigned char*bpix=(unsigned char*)mem;
     for(y=0;y<h;y++,bpix+=w)
      I32_draw_pointrow(&img,0,y,0xFFFFFFFF,bpix,w,0);
    }
  }  
 if(bOptimize) I32_optimize(&img,1,bOptimize);
 carray_safeadd(tatlas->imgarray,I32,img)
}

void mg_addtoATLASex_starttag(void*atlas,const char*name)
{
 _aseatlas *tatlas=(_aseatlas*)atlas; 
 IMGTAG tag;
 int    basef=tatlas->imgarray.cnt;
 carray_safeadd(tatlas->start,int,tatlas->tagarray.cnt) 
 tag.attr=0;
 strcpy(tag.name,"default");
 tag.from=basef+0; 
 tag.time=1000; 
 tag.to=basef+0;
 carray_safeadd(tatlas->tagarray,IMGTAG,tag)
}

void mg_addtoATLASex_endtag(void*atlas)
{
 _aseatlas *tatlas=(_aseatlas*)atlas;  
 int    basef=tatlas->imgarray.cnt;
 tatlas->tagarray.items[tatlas->tagarray.cnt-1].to=basef;
}

void mg_addtoATLASex(void*atlas,const char*name,void*mem,int w,int h,int bx,int by,int bw,int bh,int mode)
{
 _aseatlas *tatlas=(_aseatlas*)atlas; 
 I32    img;
 int    err=0;
 
 if(mode==2)
  I32_new(&img,w+2,h+2);
 else
  I32_new(&img,w+1,h);
 if(bx+bw>w)
  err++;
 if(by+bh>h)
  err++;
 switch(mode)
  {
   case 4:
    memcpy(img.p,mem,img.sx*img.sy*4);
   break;
   case 1:
    {
     int           y;
     unsigned char*bpix=(unsigned char*)mem;
     for(y=0;y<bh;y++,bpix+=bw)
      I32_draw_pointrow(&img,bx,by+y,0xFFFFFFFF,bpix,bw,1);
     //efx(&img,2);
    }
   break;
   case 2:
    {
     int           y;
     unsigned char*bpix=(unsigned char*)mem;
     for(y=0;y<bh;y++,bpix+=bw)
      I32_draw_pointrow(&img,bx+1,by+1+y,0xFFFFFFFF,bpix,bw,1);
     outline(&img); 
     //efx(&img,2);
    } 
  }  
 if(bOptimize) I32_optimize(&img,1,bOptimize);
 carray_safeadd(tatlas->imgarray,I32,img)
}

#if defined(ADX_ENGINE)

typedef struct {
 char*string;
 int *pos;
} STP;

int STP_AddStringEx(STP*stp,const char* string,int counter,const unsigned char* data,WORD datasize)
{
 return 1;
}

void S_stripext(char*fn)
{
 int l=strlen(fn);
 while(l--)
  if(fn[l]=='.')
   {fn[l]=0;break;}
}

int IMGARRAY_compare(const void*a,const void*b)
{
 I32*A=(I32*)a;
 I32*B=(I32*)b;
 int dif=A->layer-B->layer;//strcmp(A->name,B->name);
 if(dif==0)
  return A->frame-B->frame;
 else
  return dif; 
}

void ADXENGINE_handle(void*atlas,int rbasef,const char*name,const char*rootname,const char*dst,char*bkg,int*bx,int*by,char*movearea,STP*actors,STP*objs)
{
  _aseatlas*tatlas=(_aseatlas*)atlas;
  if(tatlas->imgarray.cnt)    
   {
    int i=0;   
    int tbx=*bx,tby=*by;
    qsort(tatlas->imgarray.items,tatlas->imgarray.cnt,sizeof(tatlas->imgarray.items[0]),IMGARRAY_compare);
    while(i<tatlas->imgarray.cnt)
     {
      char info[8192];
      int  write=1;
      *info=0;
      if((tatlas->imgarray.items[i].frame==0)&&(namecnt(&tatlas->imgarray,tatlas->imgarray.items[i].name)==1))
       {
        if(memcmp(tatlas->imgarray.items[i].name,"bkg.",4)==0)
         {
          if(bx) *bx=tatlas->imgarray.items[i].sx;
          if(by) *by=tatlas->imgarray.items[i].sy;
          tatlas->imgarray.items[i].name[3]=0;
         }
        else
         {
         int px,py,kind;
         char key[256];
         if(0)
          {
          I32_trim(&tatlas->imgarray,tatlas->imgarray.items[i].name,&px,&py);
          tatlas->imgarray.items[i].ox+=px/2;
          tatlas->imgarray.items[i].oy+=py/2;
          }
         write=createinfo(info,&tatlas->imgarray.items[i],tatlas->imgarray.items[i].ox+tbx/2-tatlas->imgarray.items[i].sx/2,tatlas->imgarray.items[i].oy+tby/2-tatlas->imgarray.items[i].sy/2,&kind,key);
         switch(kind)
          {
           case kind_walkarea:
            {
             strcpy(movearea,info);
             ADXENGINE_addkeyvalue("",key,info);
             {
               AGPT points;
               carray_set(points,PT,24)
               if(I32_getpoly(&tatlas->imgarray.items[i],&points))
                {      
                 if((points.cnt==4)&&(points.items[0].x==points.items[3].x)&&(points.items[1].x==points.items[2].x)&&(points.items[0].y==points.items[1].y)&&(points.items[2].y==points.items[3].y))
                  ;
                 else
                  {
                   int i;
                   strcpy(info,"polyline:"); 
                   for(i=0;i<points.cnt;i++)
                    {
                     char n[32];
                     if(i)
                      strcat(info,",");
                     sprintf(n,"%d-%d",points.items[i].x,points.items[i].y);
                     strcat(info,n);
                    }
                   strcat(info,";"); 
                   ADXENGINE_addkeyvalue("",key,info);
                  } 
                }    
               carray_free(points) 
             }             
            }
           break;
           case kind_actor:
            ADXENGINE_addkeyvalue("actors",key,info);
           break;
           default:
            if(kind==kind_mask)
             ;
            else
            if((kind!=-1)||(string_charcount(key,'.')==0))
            {
             ADXENGINE_addkeyvalue("objects",key,info);
             strcpy(tatlas->imgarray.items[i].name,key);
            }
            else
            {
             int k;
             k=0;
            }
            //STP_AddStringEx(objs,onmx,-1,(BYTE*)info,strlen(info)+1);
          }
         }        
       } 
      else
       {
       int px=0,py=0,kind;
       char key[256];
       I32_trim(&tatlas->imgarray,tatlas->imgarray.items[i].name,&px,&py);
       //write=createinfo(info,&tatlas->imgarray.items[i],px,py,&kind,key);       
       tatlas->imgarray.items[i].ox+=px;
       tatlas->imgarray.items[i].oy+=py;
       write=createinfo(info,&tatlas->imgarray.items[i],tatlas->imgarray.items[i].ox+tbx/2-tatlas->imgarray.items[i].sx/2,tatlas->imgarray.items[i].oy+tby/2-tatlas->imgarray.items[i].sy/2,&kind,key);
       switch(kind)
        {
         case kind_walkarea:
          strcpy(movearea,info);
          ADXENGINE_addkeyvalue("",key,info);
         break;
         case kind_actor:
          ADXENGINE_addkeyvalue("actors",key,info);
         break;
         default:
          if((kind!=-1)||(string_charcount(key,'.')==0))
           ADXENGINE_addkeyvalue("objects",key,info);
          //STP_AddStringEx(objs,onmx,-1,(BYTE*)info,strlen(info)+1);
        }
        while((i+write<tatlas->imgarray.cnt)&&(strcmp(tatlas->imgarray.items[i].name,tatlas->imgarray.items[i+write].name)==0))
         write++;
       }
      if(write) 
       {
        IMGTAG tag;
        tag.attr=0;
        strcpy(tag.name,"default");
        tag.from=rbasef+i;
        tag.to=rbasef+i+write-1;
        tag.time=1000;
        carray_safeadd(tatlas->tagarray,IMGTAG,tag)
        //stbi_write_png(onm,imgarray.items[i].sx,imgarray.items[i].sy,4,imgarray.items[i].p,0);
        i+=write;
       }
      else  
       {
        FREE(tatlas->imgarray.items[i].p);
        carray_delete(tatlas->imgarray,I32,i)
       } 
     } 
   }  
}   

#endif

unsigned char*mg_buildATLAS(void*atlas,int*w,int*h,int*framestart,_animation**anim,_aseimgblock*imgblock,int flags)
{
 _aseatlas*tatlas=(_aseatlas*)atlas;
 #if defined(ADX_ENGINE)
 if(g_advASEload)
  {
   char movearea[256],bkg[256];   
   STP  actors,obj;
   ADXENGINE_handle(atlas,0,"","","",bkg,w,h,movearea,&actors,&obj);
  } 
 #endif
 if(tatlas->imgarray.cnt)  
  {
   I32 atlas;   
   int nw=0,nh=0,x=0,y=0,i,sx=tatlas->imgarray.items[0].sx,sy=tatlas->imgarray.items[0].sy;
   {
    int           f,hm,lx=0,ly=0,err=0,odd=0,aw=64,ah=64;
    stbrp_context cont;
    stbrp_node   *nodes;
    stbrp_rect   *rects;//
    nodes=(stbrp_node*)ALLOC(sizeof(stbrp_node)*256);
    rects=(stbrp_rect*)ALLOC(sizeof(stbrp_rect)*tatlas->imgarray.cnt);
         
    for(f=0;f<tatlas->imgarray.cnt;f++)
     if(I32_isempty(&tatlas->imgarray.items[f])) 
      tatlas->imgarray.items[f].lx=tatlas->imgarray.items[f].ly=0;

    if(flags&atlas_freesize)
     aw=ah=0;
        
    for(f=0;f<tatlas->imgarray.cnt;f++)
     {
      I32*i=&tatlas->imgarray.items[f];
      rects[f].id=f;
      rects[f].w=i->lx;
      rects[f].h=i->ly;
      if((rects[f].w<0)||(rects[f].w>1024)||(rects[f].h<0)||(rects[f].h>1024))
       odd++;
      if(flags&atlas_freesize)
       {
        aw+=rects[f].w;
        if(ah<rects[f].h)
         ah=rects[f].h;
        //ah=max(ah,rects[f].h);
       }
      else
       {
        while(rects[f].w>aw) 
         aw*=2; 
        while(rects[f].h>aw) 
         aw*=2;
       }
     } 
    if(imgblock)
     {
      imgblock->nimages=tatlas->tagarray.cnt;
      imgblock->images=(_aseimg*)ALLOC(imgblock->nimages*sizeof(_aseimg));
      for(f=0;f<tatlas->tagarray.cnt;f++)
       {
        int  id=tatlas->tagarray.items[f].from;
        I32 *i=&tatlas->imgarray.items[id];
        _aseimg*ii=&imgblock->images[f];
        ii->uv.x=i->ox;
        ii->uv.y=i->oy;
        ii->uv.w=i->lx;
        ii->uv.h=i->ly;
        ii->name=(char*)STRDUP(i->name);
        ii->attr=i->attr;
       }
     } 
    if(flags&atlas_freesize)
     ;
    else
     ah=aw;
    while(1)
     { 
      stbrp_init_target (&cont, aw,ah, nodes,256);
      stbrp_setup_heuristic(&cont,STBRP_HEURISTIC_Skyline_BF_sortHeight);
      hm=stbrp_pack_rects (&cont,rects,tatlas->imgarray.cnt);
      if(hm==0)
       {aw*=2;ah*=2;}
      else
       break; 
     } 
    for(f=0;f<tatlas->imgarray.cnt;f++)
     {
      if(rects[f].was_packed==0)
       err++;
      if(rects[f].x+rects[f].w>lx)
       lx=rects[f].x+rects[f].w;
      if(rects[f].y+rects[f].h>ly)
       ly=rects[f].y+rects[f].h;
     }  
    if(flags&atlas_freesize)
     {nw=lx;nh=ly;}
    else
     {
      nw=nh=2; 
      while(nw<lx) nw*=2;
      while(nh<ly) nh*=2;
     }
    if(anim)
     {
      *anim=(_animation*)ALLOC(sizeof(_animation));
      (*anim)->nframes=tatlas->imgarray.cnt;
      (*anim)->frames=(_frame*)ALLOC(sizeof(_frame)* ((*anim)->nframes) );      
      
      I32_new(&atlas,nw,nh); 
      
      for(f=0;f<tatlas->imgarray.cnt;f++)
       {
        int    i=rects[f].id;
        int    x=rects[f].x,y=rects[f].y;
        int    sx=rects[f].w,sy=rects[f].h;
        _frame*ff=&(*anim)->frames[i];
        I32   *src=&tatlas->imgarray.items[i];
        
        ff->uv.x=x;
        if(flags&atlas_dontswapy)
         ff->uv.y=y;
        else
         ff->uv.y=nh-(y+sy);
        ff->uv.w=src->sx;
        ff->uv.h=src->sy;
        ff->ruv.x=src->ox;
        ff->ruv.y=src->oy;
        ff->ruv.w=src->lx;
        ff->ruv.h=src->ly;
        ff->ms=src->duration;      
        
        if((bOptimize)||(flags&atlas_framehcrop)||(flags&atlas_framevtop))
         I32_copyex(&atlas,x,y,src,src->ox,src->oy,src->lx,src->ly);
        else 
         I32_copy(&atlas,x,y,src);
        I32_delete(src);       
       }
       
      (*anim)->naframes=tatlas->tagarray.cnt;
      if((*anim)->naframes)
       {
        (*anim)->aframes=(_animframe*)ALLOC(sizeof(_animframe)* ((*anim)->naframes) );
        for(i=0;i<tatlas->tagarray.cnt;i++)
         {
          int j,odd=0;
          (*anim)->aframes[i].name=strhash(tatlas->tagarray.items[i].name);        
          (*anim)->aframes[i].nids=tatlas->tagarray.items[i].to-tatlas->tagarray.items[i].from+1;
          (*anim)->aframes[i].flags=tatlas->tagarray.items[i].attr;
          if((*anim)->aframes[i].nids>0)
           {
            (*anim)->aframes[i].ids=(short*)ALLOC((*anim)->aframes[i].nids*sizeof(short));
            for(j=0;j<(*anim)->aframes[i].nids;j++)
            {
             for(f=0;f<tatlas->imgarray.cnt;f++)
              if(tatlas->imgarray.items[f].frame==tatlas->tagarray.items[i].from+j)
               {(*anim)->aframes[i].ids[j]=f;break;}
             if(f==tatlas->imgarray.cnt)
              (*anim)->aframes[i].ids[j]=tatlas->tagarray.items[i].from+j;
            }
           }  
          else
           odd++; 
         }
       }  
      
      if(w) *w=atlas.sx;
      if(h) *h=atlas.sy; 
       
      FREE(rects);
      FREE(nodes);
      
      if(framestart)
       memcpy(framestart,tatlas->start.items,sizeof(int)*tatlas->start.cnt);
       
      //mg_deleteATLAS(tatlas); 
     
      #if defined(ATLAS_DUMP)
      {
       char n[256];
       sprintf(n,"atlas.%d.png",++g_atlas_cnt);
       stbi_write_png(n,atlas.sx,atlas.sy,4,atlas.p,0);
      }
      #endif
      return (unsigned char*)atlas.p;
    }
    else
     return NULL;    
   }
   
  }
 else
  {
   mg_deleteATLAS(&tatlas);
   return NULL;
  } 
}

unsigned char*mg_readASE(const char*mainname,void*mem,int pp,int*w,int*h,_animation**anim,_aseimgblock*imgblock,_asetilemaps*tilemap,int flags)
{ 
 _aseatlas        *tatlas=(_aseatlas*)mg_createATLAS();
 unsigned char*retmem;
 mg_core_readASE(mainname,mem,pp,w,h,tatlas,1*(imgblock!=NULL));
 if(flags&atlas_mergelayers)
 {
  int i,j;
  for(i=0;i<tatlas->imgarray.cnt;i++)
   for(j=i+1;j<tatlas->imgarray.cnt;j++)
   if(tatlas->imgarray.items[i].frame==tatlas->imgarray.items[j].frame)
    {
     I32_copyex(&tatlas->imgarray.items[i],0,0,&tatlas->imgarray.items[j],0,0,tatlas->imgarray.items[i].sx,tatlas->imgarray.items[i].sy);
     tatlas->imgarray.items[j].frame=-1;
    }
  j=tatlas->imgarray.cnt;
  while(j--)
   if(tatlas->imgarray.items[j].frame==-1)
    {
     I32_delete(&tatlas->imgarray.items[j]);
     carray_delete(tatlas->imgarray,I32,j)
    }
 }
 if(flags&atlas_framehcrop)
 {
  int i;
  for(i=0;i<tatlas->imgarray.cnt;i++)
   I32_optimize(&tatlas->imgarray.items[i],1,1);
 }
 if(flags&atlas_framevtop)
 {
  int i;
  for(i=0;i<tatlas->imgarray.cnt;i++)
   I32_optimize(&tatlas->imgarray.items[i],1,4);
 }
 if(tilemap)
  {
   int i,j,c=0;
   memset(tilemap,0,sizeof(_asetilemaps));
   for(j=i=0;i<tatlas->imgarray.cnt;i++)
    if(tatlas->imgarray.items[i].attr&64)
     tilemap->ntilemap++;
   tilemap->tilemap=(_asetilemap*)malloc(tilemap->ntilemap*sizeof(tilemap->tilemap[0]));
   for(i=0;i<tatlas->imgarray.cnt;i++)
    if(tatlas->imgarray.items[i].attr&64)
     {
      _asetilemap tm;
      for(j=0;j<tatlas->imgarray.cnt;j++)
       if(tatlas->imgarray.items[j].attr&128)
        if(tatlas->imgarray.items[j].layer==tatlas->imgarray.items[i].layer)
         {
          tm.name=strhash(tatlas->imgarray.items[i].name);

          tm.mapw=tatlas->imgarray.items[i].sx;
          tm.maph=tatlas->imgarray.items[i].sy;
          tm.map=(uint32_t*)malloc(tm.mapw*tm.maph*sizeof(tm.map[0]));
          memcpy(tm.map,tatlas->imgarray.items[i].p,tm.mapw*tm.maph*sizeof(tm.map[0]));

          tm.tilecount=tatlas->imgarray.items[j].duration;
          tm.tilew=tatlas->imgarray.items[j].sx;
          tm.tileh=tatlas->imgarray.items[j].sy/tm.tilecount;
          tm.tiles=(uint32_t*)malloc(tm.tilew*tm.tileh*tm.tilecount*sizeof(tm.tiles[0]));
          memcpy(tm.tiles,tatlas->imgarray.items[j].p,tm.tilew*tm.tileh*tm.tilecount*sizeof(tm.tiles[0]));

          memcpy(&tilemap->tilemap[c],&tm,sizeof(tm));c++;
          break;
         }
     }
  }
 retmem=mg_buildATLAS(tatlas,w,h,NULL,anim,imgblock,flags);
 mg_deleteATLAS(tatlas);
 return retmem;
}
#endif