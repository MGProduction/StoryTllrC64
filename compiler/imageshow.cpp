#define  APP_IMPLEMENTATION
#define  APP_WINDOWS

#include <stdio.h>
#include <stdlib.h> // for rand and __argc/__argv
#include <string.h> // for memset

#include "gustavsson/app.h"
#include "stb/stb_image.h"
#include "image_en.h"

enum{
 C64=1,
 VIC20=2,
 ZXSpectrum
};


APP_U32 _c64col[16]={0x000000,0xFFFFFF,0x880000,0xAAFFEE,0xCC44CC,0x00CC55,0x0000AA,0xEEEE77,0xDD8855,0x664400,0xFF7777,0x333333,0x777777,0xAAFF66,0x0088FF,0xBBBBBB};
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

#define canvas_w 380
#define canvas_h 260
#define screen_w 320
#define screen_h 200
#define canvas_ox (canvas_w-screen_w)/2
#define canvas_oy (canvas_h-screen_h)/2

#define screen_sx canvas_w*3
#define screen_sy canvas_h*3

APP_U32 canvas[ canvas_w * canvas_h ]; // a place for us to draw stuff
APP_U32 colcanvas[ canvas_w * canvas_h ]; // a place for us to draw stuff

app_t* theapp;
DWORD last=-1;

typedef unsigned char u8;

extern "C"
{
 extern unsigned char bLive;
 extern imageefx efx;
 unsigned char PNG_converter(const char*png,const char*outputbin,int optimized,const char*roomname,u8 model);
}

const char*pngname;
char       ininame[256];

void image_write(int ox,int oy,unsigned char*data,int w,int h,int n)
{
 int x,y;
 for(y=0;y<h;y++)
  for(x=0;x<w;x++)
   {
    APP_U32       color=0;
    unsigned char*p=&data[(x+y*w)*n];
    color=p[0]|(p[1]<<8)|(p[2]<<16)|(255<<24);
    if((ox+x>=0)&&(ox+x<canvas_w)&&(oy+y>=0)&&(oy+y<canvas_h))
     canvas[ox+x+(oy+y)*canvas_w]=color;
   }
}

int selector=0;
int limitA=0,limitB=255;
u8 wmodel=C64;

void imageshow_update()
{
 int w,h,n;
 u8 *data;
 PNG_converter(pngname,"tmp",0,NULL,wmodel);
 
 data=stbi_load("tmp/full.png", &w, &h, &n, 0);
 image_write(canvas_ox,canvas_oy,data,w,h,n);
 stbi_image_free(data);

 if(wmodel==C64)
  data=stbi_load("tmp/c64.png", &w, &h, &n, 0);
 else
  data=stbi_load("tmp/ZXSpectrum.png", &w, &h, &n, 0);
 image_write(canvas_ox,canvas_oy+100,data,w,h,n);
 stbi_image_free(data);

 imageefx_write(&efx,ininame);
}


int imageshow_loop()
{
 bLive=1;
 imageefx_reset(&efx);
 imageefx_read(&efx,ininame);
 imageshow_update();
 while(1)
 {
  int  kchar=0;
  DWORD here=GetTickCount();
  if(last==-1)
   last=here;
  else
   while(1)
    {
     here=GetTickCount();
     if(here-last<1000/50)
      continue;
     else
      break;
    }

  app_present( theapp, canvas, canvas_w, canvas_h, 0xffffff, 0x000000 );
  app_yield( theapp );

  app_input_t events=app_input(theapp);
  if(events.count)
   {
    int k=events.count;
    while(k--)
     if(events.events[k].type==APP_INPUT_CHAR)
     {
      kchar=events.events[k].data.char_code;
      break;
     }
   }
  if(kchar)
  {
   switch(kchar)
   {
   case 'y':
    selector=efx_ypos;
    limitA=0;limitB=200;
    break;
    
   case 'r':
    imageefx_reset(&efx);
    break;
   case 'c':
    selector=efx_contrast;
    limitA=0;limitB=255;
    break;
    case 'm':
    selector=efx_morecontrast;
    limitA=0;limitB=255;
    break;
    case 's':
    selector=efx_sharpen;
    limitA=0;limitB=255;
    break;
    case 'u':
    selector=efx_unsharpen;
    limitA=0;limitB=255;
    break;
    case 'd':
    selector=efx_dither;
    limitA=0;limitB=255;
    break;
    case 'D':
    selector=efx_dithermethod;
    limitA=dither_floyd;limitB=dither_count;
    break;
    case '1':
    selector=efx_cl1;
    limitA=1;limitB=4;
    break;
    case '2':
    selector=efx_cl2;
    limitA=0;limitB=255/8;
    break;
    case '3':
    selector=efx_cl3;
    limitA=0;limitB=255;
    break;
    case 't':
     selector=efx_saturation;
     limitA=0;limitB=10;
     break;
     case 'b':
     selector=efx_brightness;
     limitA=-10;limitB=10;
     break;
     case 'B':
     selector=efx_colorbalance;
     limitA=0;limitB=20;
     break;
    case '+':
     efx.val[selector]=min(limitB,efx.val[selector]+1);
    break;
    case '-':
     efx.val[selector]=max(limitA,efx.val[selector]-1);
    break;
    case '0':
     efx.val[selector]=0;
    break;
    case 'a':
     efx.val[selector]=limitB;
    break;
    case 'q':
    return 1;
   }

   imageshow_update();
  }
 }
 return 0;
}

int app_proc( app_t* app, void* )
{
 theapp=app;
	memset( canvas, 0x00, sizeof( canvas ) ); // clear to grey
	app_window_size(app,screen_sx,screen_sy);
	app_screenmode( app, APP_SCREENMODE_WINDOW );
	app_title( app, "C64" );

 
	
	// keep running until the user close the window
	while( app_yield( app ) != APP_STATE_EXIT_REQUESTED )
		{
		// plot a random pixel on the canvas

		// display the canvas
		app_present( app, canvas, 320, 200, 0xffffff, 0x000000 );

		if(imageshow_loop())
   break;
		}
	return 0;
	}

extern "C" void imageshow(const char*name,int argc,const char*argv[])
{
 pngname=name;
 

 if(argv[2])
  if(strcmp(argv[2],"-zx")==0)
   wmodel=ZXSpectrum;
 strcpy(ininame,pngname);
 if(wmodel==ZXSpectrum)
  strcpy(ininame+strlen(ininame)-3,"zx.ini");
 else
  strcpy(ininame+strlen(ininame)-3,"ini");
 app_run( app_proc, NULL, NULL, NULL, NULL );
}