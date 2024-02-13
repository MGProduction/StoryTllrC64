#if !defined(IMAGE_EN_H)
#define IMAGE_EN_H

#ifdef __cplusplus
extern "C" {
#endif


#if !defined(u8)
typedef unsigned char u8;
#endif

#define dither_floyd       0
#define dither_atkinson    1
#define dither_burkes      2
#define dither_sierralite  3
#define dither_count       3 

// char valnames[][24]={"sharpen","contrast","unsharpen","dither","cl1","cl2","cl3","morecontrast","saturation","brightness","ypos",""};
#define efx_sharpen      0
#define efx_unsharpen    1  
#define efx_contrast     2
#define efx_morecontrast 3
#define efx_dither       4
#define efx_dithermethod 5
#define efx_brightness   6
#define efx_saturation   7
#define efx_cl1          8
#define efx_cl2          9
#define efx_cl3         10
#define efx_gray        11
#define efx_xpos        12
#define efx_ypos        13  
#define efx_colorbalance 14

#define efx_count       15


typedef struct{
 short val[efx_count];
}imageefx;

void imageefx_reset(imageefx*efx);
int  imageefx_read(imageefx*efx,const char*name);
int  imageefx_write(imageefx*efx,const char*name);

void image_CLAHE(u8*data,int w,int h,int n,int cl1,int cl2,int cl3);
void image_COLORBALANCE(u8*data,int w,int h,int n,int minsat,int maxsat,int tied);
void image_SATURATION(u8*data,int w,int h,int n,float s);
void image_GRAY(u8*data,int w,int h,int n);
void image_MORECONTRAST(u8*data,int w,int h,int n,int morecontrast);
void image_BRIGHTNESS(u8*data,int w,int h,int n,float s);
void image_DITHER(u8*data,int w,int h,int n,u8*palette,u8 palettesize,int dithermethod,int ditherstrenght);

#ifdef __cplusplus
}
#endif


#endif