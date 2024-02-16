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

#include <math.h>
#include <string.h>
#include <stdio.h>

#include "image_en.h"

#define BYTE_IMAGE

#ifdef BYTE_IMAGE
typedef unsigned char kz_pixel_t;	 /* for 8 bit-per-pixel images */
#define uiNR_OF_GREY (256)
#else
typedef unsigned short kz_pixel_t;	 /* for 12 bit-per-pixel images (default) */
# define uiNR_OF_GREY (4096)
#endif

// ---------------------------------------------------------------

// *****************************************************************************
/*
 * ANSI C code from the article
 * "Contrast Limited Adaptive Histogram Equalization"
 * by Karel Zuiderveld, karel@cv.ruu.nl
 * in "Graphics Gems IV", Academic Press, 1994
 *
 *
 *  These functions implement Contrast Limited Adaptive Histogram Equalization.
 *  The main routine (CLAHE) expects an input image that is stored contiguously in
 *  memory;  the CLAHE output image overwrites the original input image and has the
 *  same minimum and maximum values (which must be provided by the user).
 *  This implementation assumes that the X- and Y image resolutions are an integer
 *  multiple of the X- and Y sizes of the contextual regions. A check on various other
 *  error conditions is performed.
 *
 *  #define the symbol BYTE_IMAGE to make this implementation suitable for
 *  8-bit images. The maximum number of contextual regions can be redefined
 *  by changing uiMAX_REG_X and/or uiMAX_REG_Y; the use of more than 256
 *  contextual regions is not recommended.
 *
 *  The code is ANSI-C and is also C++ compliant.
 *
 *  Author: Karel Zuiderveld, Computer Vision Research Group,
 *           Utrecht, The Netherlands (karel@cv.ruu.nl)
 */

 /*

 EULA: The Graphics Gems code is copyright-protected. In other words, you cannot
 claim the text of the code as your own and resell it. Using the code is permitted
 in any program, product, or library, non-commercial or commercial. Giving credit
 is not required, though is a nice gesture. The code comes as-is, and if there are
 any flaws or problems with any Gems code, nobody involved with Gems - authors,
 editors, publishers, or webmasters - are to be held responsible. Basically,
 don't be a jerk, and remember that anything free comes with no guarantee.

 - http://tog.acm.org/resources/GraphicsGems/ (August 2009)

 */

/******** Prototype of CLAHE function. Put this in a separate include file. *****/
int CLAHE(kz_pixel_t* pImage, unsigned int uiXRes, unsigned int uiYRes, kz_pixel_t Min,
	  kz_pixel_t Max, unsigned int uiNrX, unsigned int uiNrY,
	  unsigned int uiNrBins, float fCliplimit);

/*********************** Local prototypes ************************/
static void ClipHistogram (unsigned long*, unsigned int, unsigned long);
static void MakeHistogram (kz_pixel_t*, unsigned int, unsigned int, unsigned int,
		unsigned long*, unsigned int, kz_pixel_t*);
static void MapHistogram (unsigned long*, kz_pixel_t, kz_pixel_t,
	       unsigned int, unsigned long);
static void MakeLut (kz_pixel_t*, kz_pixel_t, kz_pixel_t, unsigned int);
static void Interpolate (kz_pixel_t*, int, unsigned long*, unsigned long*,
	unsigned long*, unsigned long*, unsigned int, unsigned int, kz_pixel_t*);

/**************	 Start of actual code **************/
#include <stdlib.h>			 /* To get prototypes of malloc() and free() */

const unsigned int uiMAX_REG_X = 16;	  /* max. # contextual regions in x-direction */
const unsigned int uiMAX_REG_Y = 16;	  /* max. # contextual regions in y-direction */



/************************** main function CLAHE ******************/
int CLAHE (kz_pixel_t* pImage, unsigned int uiXRes, unsigned int uiYRes,
	 kz_pixel_t Min, kz_pixel_t Max, unsigned int uiNrX, unsigned int uiNrY,
	      unsigned int uiNrBins, float fCliplimit)
/*   pImage - Pointer to the input/output image
 *   uiXRes - Image resolution in the X direction
 *   uiYRes - Image resolution in the Y direction
 *   Min - Minimum greyvalue of input image (also becomes minimum of output image)
 *   Max - Maximum greyvalue of input image (also becomes maximum of output image)
 *   uiNrX - Number of contextial regions in the X direction (min 2, max uiMAX_REG_X)
 *   uiNrY - Number of contextial regions in the Y direction (min 2, max uiMAX_REG_Y)
 *   uiNrBins - Number of greybins for histogram ("dynamic range")
 *   float fCliplimit - Normalized cliplimit (higher values give more contrast)
 * The number of "effective" greylevels in the output image is set by uiNrBins; selecting
 * a small value (eg. 128) speeds up processing and still produce an output image of
 * good quality. The output image will have the same minimum and maximum value as the input
 * image. A clip limit smaller than 1 results in standard (non-contrast limited) AHE.
 */
{
    unsigned int uiX, uiY;		  /* counters */
    unsigned int uiXSize, uiYSize, uiSubX, uiSubY; /* size of context. reg. and subimages */
    unsigned int uiXL, uiXR, uiYU, uiYB;  /* auxiliary variables interpolation routine */
    unsigned long ulClipLimit, ulNrPixels;/* clip limit and region pixel count */
    kz_pixel_t* pImPointer;		   /* pointer to image */
    kz_pixel_t aLUT[uiNR_OF_GREY];	    /* lookup table used for scaling of input image */
    unsigned long* pulHist, *pulMapArray; /* pointer to histogram and mappings*/
    unsigned long* pulLU, *pulLB, *pulRU, *pulRB; /* auxiliary pointers interpolation */

    if (uiNrX > uiMAX_REG_X) return -1;	   /* # of regions x-direction too large */
    if (uiNrY > uiMAX_REG_Y) return -2;	   /* # of regions y-direction too large */
    if (uiXRes % uiNrX) return -3;	  /* x-resolution no multiple of uiNrX */
    if (uiYRes % uiNrY) return -4;	  /* y-resolution no multiple of uiNrY */
    if (Max >= uiNR_OF_GREY) return -5;	   /* maximum too large */
    if (Min >= Max) return -6;		  /* minimum equal or larger than maximum */
    if (uiNrX < 2 || uiNrY < 2) return -7;/* at least 4 contextual regions required */
    if (fCliplimit == 1.0) return 0;	  /* is OK, immediately returns original image. */
    if (uiNrBins == 0) uiNrBins = 128;	  /* default value when not specified */

    pulMapArray=(unsigned long *)malloc(sizeof(unsigned long)*uiNrX*uiNrY*uiNrBins);
    if (pulMapArray == 0) return -8;	  /* Not enough memory! (try reducing uiNrBins) */

    uiXSize = uiXRes/uiNrX; uiYSize = uiYRes/uiNrY;  /* Actual size of contextual regions */
    ulNrPixels = (unsigned long)uiXSize * (unsigned long)uiYSize;

    if(fCliplimit > 0.0) {		  /* Calculate actual cliplimit	 */
       ulClipLimit = (unsigned long) (fCliplimit * (uiXSize * uiYSize) / uiNrBins);
       ulClipLimit = (ulClipLimit < 1UL) ? 1UL : ulClipLimit;
    }
    else ulClipLimit = 1UL<<14;		  /* Large value, do not clip (AHE) */
    MakeLut(aLUT, Min, Max, uiNrBins);	  /* Make lookup table for mapping of greyvalues */
    /* Calculate greylevel mappings for each contextual region */
    for (uiY = 0, pImPointer = pImage; uiY < uiNrY; uiY++) {
	for (uiX = 0; uiX < uiNrX; uiX++, pImPointer += uiXSize) {
	    pulHist = &pulMapArray[uiNrBins * (uiY * uiNrX + uiX)];
	    MakeHistogram(pImPointer,uiXRes,uiXSize,uiYSize,pulHist,uiNrBins,aLUT);
	    ClipHistogram(pulHist, uiNrBins, ulClipLimit);
	    MapHistogram(pulHist, Min, Max, uiNrBins, ulNrPixels);
	}
	pImPointer += (uiYSize - 1) * uiXRes;		  /* skip lines, set pointer */
    }

    /* Interpolate greylevel mappings to get CLAHE image */
    for (pImPointer = pImage, uiY = 0; uiY <= uiNrY; uiY++) {
	if (uiY == 0) {					  /* special case: top row */
	    uiSubY = uiYSize >> 1;  uiYU = 0; uiYB = 0;
	}
	else {
	    if (uiY == uiNrY) {				  /* special case: bottom row */
            uiSubY = (uiYSize+1) >> 1;	uiYU = uiNrY-1;	 uiYB = uiYU;
	    }
	    else {					  /* default values */
		uiSubY = uiYSize; uiYU = uiY - 1; uiYB = uiYU + 1;
	    }
	}
	for (uiX = 0; uiX <= uiNrX; uiX++) {
	    if (uiX == 0) {				  /* special case: left column */
		uiSubX = uiXSize >> 1; uiXL = 0; uiXR = 0;
	    }
	    else {
		if (uiX == uiNrX) {			  /* special case: right column */
            uiSubX = (uiXSize+1) >> 1;  uiXL = uiNrX - 1; uiXR = uiXL;
		}
		else {					  /* default values */
		    uiSubX = uiXSize; uiXL = uiX - 1; uiXR = uiXL + 1;
		}
	    }

	    pulLU = &pulMapArray[uiNrBins * (uiYU * uiNrX + uiXL)];
	    pulRU = &pulMapArray[uiNrBins * (uiYU * uiNrX + uiXR)];
	    pulLB = &pulMapArray[uiNrBins * (uiYB * uiNrX + uiXL)];
	    pulRB = &pulMapArray[uiNrBins * (uiYB * uiNrX + uiXR)];
	    Interpolate(pImPointer,uiXRes,pulLU,pulRU,pulLB,pulRB,uiSubX,uiSubY,aLUT);
	    pImPointer += uiSubX;			  /* set pointer on next matrix */
	}
	pImPointer += (uiSubY - 1) * uiXRes;
    }
    free(pulMapArray);					  /* free space for histograms */
    return 0;						  /* return status OK */
}
void ClipHistogram (unsigned long* pulHistogram, unsigned int
		     uiNrGreylevels, unsigned long ulClipLimit)
/* This function performs clipping of the histogram and redistribution of bins.
 * The histogram is clipped and the number of excess pixels is counted. Afterwards
 * the excess pixels are equally redistributed across the whole histogram (providing
 * the bin count is smaller than the cliplimit).
 */
{
    unsigned long* pulBinPointer, *pulEndPointer, *pulHisto;
    unsigned long ulNrExcess, ulUpper, ulBinIncr, ulStepSize, i;
    long lBinExcess;

    ulNrExcess = 0;  pulBinPointer = pulHistogram;
    for (i = 0; i < uiNrGreylevels; i++) { /* calculate total number of excess pixels */
	lBinExcess = (long) pulBinPointer[i] - (long) ulClipLimit;
	if (lBinExcess > 0) ulNrExcess += lBinExcess;	  /* excess in current bin */
    };

    /* Second part: clip histogram and redistribute excess pixels in each bin */
    ulBinIncr = ulNrExcess / uiNrGreylevels;		  /* average binincrement */
    ulUpper =  ulClipLimit - ulBinIncr;	 /* Bins larger than ulUpper set to cliplimit */

    for (i = 0; i < uiNrGreylevels; i++) {
      if (pulHistogram[i] > ulClipLimit) pulHistogram[i] = ulClipLimit; /* clip bin */
      else {
	  if (pulHistogram[i] > ulUpper) {		/* high bin count */
	      ulNrExcess -= pulHistogram[i] - ulUpper; pulHistogram[i]=ulClipLimit;
	  }
	  else {					/* low bin count */
	      ulNrExcess -= ulBinIncr; pulHistogram[i] += ulBinIncr;
	  }
       }
    }

    while (ulNrExcess) {   /* Redistribute remaining excess  */
	pulEndPointer = &pulHistogram[uiNrGreylevels]; pulHisto = pulHistogram;

	while (ulNrExcess && pulHisto < pulEndPointer) {
	    ulStepSize = uiNrGreylevels / ulNrExcess;
	    if (ulStepSize < 1) ulStepSize = 1;		  /* stepsize at least 1 */
	    for (pulBinPointer=pulHisto; pulBinPointer < pulEndPointer && ulNrExcess;
		 pulBinPointer += ulStepSize) {
		if (*pulBinPointer < ulClipLimit) {
		    (*pulBinPointer)++;	 ulNrExcess--;	  /* reduce excess */
		}
	    }
	    pulHisto++;		  /* restart redistributing on other bin location */
	}
    }
}
void MakeHistogram (kz_pixel_t* pImage, unsigned int uiXRes,
		unsigned int uiSizeX, unsigned int uiSizeY,
		unsigned long* pulHistogram,
		unsigned int uiNrGreylevels, kz_pixel_t* pLookupTable)
/* This function classifies the greylevels present in the array image into
 * a greylevel histogram. The pLookupTable specifies the relationship
 * between the greyvalue of the pixel (typically between 0 and 4095) and
 * the corresponding bin in the histogram (usually containing only 128 bins).
 */
{
    kz_pixel_t* pImagePointer;
    unsigned int i;

    for (i = 0; i < uiNrGreylevels; i++) pulHistogram[i] = 0L; /* clear histogram */

    for (i = 0; i < uiSizeY; i++) {
		pImagePointer = &pImage[uiSizeX];
		while (pImage < pImagePointer) pulHistogram[pLookupTable[*pImage++]]++;
		pImagePointer += uiXRes;
		pImage = &pImagePointer[-(int)uiSizeX];	/* go to bdeginning of next row */
    }
}

void MapHistogram (unsigned long* pulHistogram, kz_pixel_t Min, kz_pixel_t Max,
	       unsigned int uiNrGreylevels, unsigned long ulNrOfPixels)
/* This function calculates the equalized lookup table (mapping) by
 * cumulating the input histogram. Note: lookup table is rescaled in range [Min..Max].
 */
{
    unsigned int i;  unsigned long ulSum = 0;
    const float fScale = ((float)(Max - Min)) / ulNrOfPixels;
    const unsigned long ulMin = (unsigned long) Min;

    for (i = 0; i < uiNrGreylevels; i++) {
		ulSum += pulHistogram[i]; pulHistogram[i]=(unsigned long)(ulMin+ulSum*fScale);
		if (pulHistogram[i] > Max) pulHistogram[i] = Max;
    }
}

void MakeLut (kz_pixel_t * pLUT, kz_pixel_t Min, kz_pixel_t Max, unsigned int uiNrBins)
/* To speed up histogram clipping, the input image [Min,Max] is scaled down to
 * [0,uiNrBins-1]. This function calculates the LUT.
 */
{
    int i;
    const kz_pixel_t BinSize = (kz_pixel_t) (1 + (Max - Min) / uiNrBins);

    for (i = Min; i <= Max; i++)  pLUT[i] = (i - Min) / BinSize;
}

void Interpolate (kz_pixel_t * pImage, int uiXRes, unsigned long * pulMapLU,
     unsigned long * pulMapRU, unsigned long * pulMapLB,  unsigned long * pulMapRB,
     unsigned int uiXSize, unsigned int uiYSize, kz_pixel_t * pLUT)
/* pImage      - pointer to input/output image
 * uiXRes      - resolution of image in x-direction
 * pulMap*     - mappings of greylevels from histograms
 * uiXSize     - uiXSize of image submatrix
 * uiYSize     - uiYSize of image submatrix
 * pLUT	       - lookup table containing mapping greyvalues to bins
 * This function calculates the new greylevel assignments of pixels within a submatrix
 * of the image with size uiXSize and uiYSize. This is done by a bilinear interpolation
 * between four different mappings in order to eliminate boundary artifacts.
 * It uses a division; since division is often an expensive operation, I added code to
 * perform a logical shift instead when feasible.
 */
{
    const unsigned int uiIncr = uiXRes-uiXSize; /* Pointer increment after processing row */
    kz_pixel_t GreyValue; unsigned int uiNum = uiXSize*uiYSize; /* Normalization factor */

    unsigned int uiXCoef, uiYCoef, uiXInvCoef, uiYInvCoef, uiShift = 0;

    if (uiNum & (uiNum - 1))   /* If uiNum is not a power of two, use division */
    for (uiYCoef = 0, uiYInvCoef = uiYSize; uiYCoef < uiYSize;
	 uiYCoef++, uiYInvCoef--,pImage+=uiIncr) {
	for (uiXCoef = 0, uiXInvCoef = uiXSize; uiXCoef < uiXSize;
	     uiXCoef++, uiXInvCoef--) {
	    GreyValue = pLUT[*pImage];		   /* get histogram bin value */
	    *pImage++ = (kz_pixel_t ) ((uiYInvCoef * (uiXInvCoef*pulMapLU[GreyValue]
				      + uiXCoef * pulMapRU[GreyValue])
				+ uiYCoef * (uiXInvCoef * pulMapLB[GreyValue]
				      + uiXCoef * pulMapRB[GreyValue])) / uiNum);
	}
    }
    else {			   /* avoid the division and use a right shift instead */
	while (uiNum >>= 1) uiShift++;		   /* Calculate 2log of uiNum */
	for (uiYCoef = 0, uiYInvCoef = uiYSize; uiYCoef < uiYSize;
	     uiYCoef++, uiYInvCoef--,pImage+=uiIncr) {
	     for (uiXCoef = 0, uiXInvCoef = uiXSize; uiXCoef < uiXSize;
	       uiXCoef++, uiXInvCoef--) {
	       GreyValue = pLUT[*pImage];	  /* get histogram bin value */
	       *pImage++ = (kz_pixel_t)((uiYInvCoef* (uiXInvCoef * pulMapLU[GreyValue]
				      + uiXCoef * pulMapRU[GreyValue])
				+ uiYCoef * (uiXInvCoef * pulMapLB[GreyValue]
				      + uiXCoef * pulMapRB[GreyValue])) >> uiShift);
	    }
	}
    }
}

// ---------------------------------------------------------------

typedef struct{
 double L,A,B;
}LAB;                       
                       
void RGB2LAB(u8 rgbR,u8 rgbG,u8 rgbB,LAB*lab)
{
  double r = rgbR / 255.0,
      g = rgbG / 255.0,
      b = rgbB / 255.0,
      x, y, z;

  r = (r > 0.04045) ? pow((r + 0.055) / 1.055, 2.4) : r / 12.92;
  g = (g > 0.04045) ? pow((g + 0.055) / 1.055, 2.4) : g / 12.92;
  b = (b > 0.04045) ? pow((b + 0.055) / 1.055, 2.4) : b / 12.92;

  x = (r * 0.4124 + g * 0.3576 + b * 0.1805) / 0.95047;
  y = (r * 0.2126 + g * 0.7152 + b * 0.0722) / 1.00000;
  z = (r * 0.0193 + g * 0.1192 + b * 0.9505) / 1.08883;

  x = (x > 0.008856) ? pow(x, 1.0/3.0) : (7.787 * x) + 16.0/116.0;
  y = (y > 0.008856) ? pow(y, 1.0/3.0) : (7.787 * y) + 16.0/116.0;
  z = (z > 0.008856) ? pow(z, 1.0/3.0) : (7.787 * z) + 16.0/116.0;

  lab->L=(116.0 * y) - 16.0;
  lab->A=500.0 * (x - y);
  lab->B=200.0 * (y - z);
  //return [(116 * y) - 16, 500 * (x - y), 200 * (y - z)]
}         

double LABDISTCIE76(LAB*plabA,LAB*plabB)
{
 double labA[3],labB[3];
  labA[0]=plabA->L;labA[1]=plabA->A;labA[2]=plabA->B;
  labB[0]=plabB->L;labB[1]=plabB->A;labB[2]=plabB->B;
  {
  double deltaL = labA[0] - labB[0];
  double deltaA = labA[1] - labB[1];
  double deltaB = labA[2] - labB[2];
  return sqrt(deltaL*deltaL+deltaA*deltaA+deltaB*deltaB);
  }
}              
                       
u8 findpalette(u8*rgb,u8*palette,u8 palsize,u8 mode)
{
 u8 i,besti=0;
 double best=0x7FFFFFFF;
 LAB l1,l2;

 for(i=0;i<palsize;i++)
  if(memcmp(palette+i*3,rgb,3)==0)
   return i;
   
 if(mode&1)
  RGB2LAB(rgb[0],rgb[1],rgb[2],&l1);  

 for(i=0;i<palsize;i++)
 {
  int j;
  double dist=0;
  
  if(mode&1)
   {    
    RGB2LAB(palette[i*3+0],palette[i*3+1],palette[i*3+2],&l2);
    dist+=LABDISTCIE76(&l1,&l2);
   } 
  else
   for(j=0;j<3;j++)
    {
     double a=rgb[j]/255.0,b=palette[i*3+j]/255.0;
     dist+=(a-b)*(a-b);
    }    
  if(dist<best)
  {
   best=dist;
   besti=i;
  }
 }
 return besti;
}     

void image_MORECONTRAST(u8*data,int w,int h,int n,int morecontrast)
{
 int x,y,c;
 for(y=0;y<h;y++)
  for(x=0;x<w;x++)
   {
    u8*rgb=data+(x+y*w)*n;
    for(c=0;c<3;c++)
    {
     int red = rgb[c];                
     double pixel = red/255.0;
     pixel -= 0.5;
     pixel *= (double)(1+(double)morecontrast/10.0);
     pixel += 0.5;
     pixel *= 255;
     if (pixel < 0) pixel = 0;
     if (pixel > 255) pixel = 255;
     rgb[c] = (u8) pixel;
    }
   }
}

void image_GRAY(u8*data,int w,int h,int n)
{
 int x,y;
 for(y=0;y<h;y++)
  for(x=0;x<w;x++)
   {
    u8*rgb=data+(x+y*w)*n;
    double Y = 0.2126 * rgb[0] + 0.7152 * rgb[1] + 0.0722 * rgb[2];       
    u8 gray=(u8)Y;
    rgb[0]=gray;
    rgb[1]=gray;
    rgb[2]=gray;
   }      
}

void image_BRIGHTNESS(u8*data,int w,int h,int n,float s)
{
 int x,y;
 for(y=0;y<h;y++)
  for(x=0;x<w;x++)
   {
    u8*rgb=data+(x+y*w)*n;
    int c;
    for(c=0;c<3;c++)
    {
     int red;
     if(s>0)
      red = min(255,(int)(rgb[c]+rgb[c]*s));
     else
      red = max(0,(int)(rgb[c]+rgb[c]*s)); 
     rgb[c] = (u8) red;
    }
   }        
}

void image_DITHER(u8*data,int w,int h,int n,u8*palette,u8 palettesize,int dithermethod,int ditherstrenght)
{
 int x,y,c,dither=ditherstrenght;
 int floyd[]={16, 1,0,7, 0,1,5, 1,1,1, -1,1,3, 0,0,0};
 int atkinson[]={8, 1,0,1, 0,1,1, 1,1,1, -1,1,1, 2,0,1, 0,2,1, 0,0,0 };
 int burkes[]={32, 1,0,8,  0,1,8, 1,1,4, -1,1,4, 2,0,4, 3,0,2, -2,1,2, 0,0,0 };
 int sierralite[]={4, 1,0,2, 0,1,1, -1,1,3, 0,0,0};
 int*diffusion=&atkinson[0];//floyd[0];
 switch(dithermethod)
  {
  case dither_floyd:
   diffusion=&floyd[0];
   break;
  case dither_atkinson:
   diffusion=&atkinson[0];
   break;
   case dither_burkes:
   diffusion=&burkes[0];
   break;
   case dither_sierralite:
    diffusion=&sierralite[0];
    break;
  }
 for(y=0;y<h;y++)
  for(x=0;x<w;x++)
   {
    u8 *rgb=data+(x+y*w)*n;
    u8  idx=findpalette(rgb,palette,palettesize,1);
    u8 *actual = palette+idx*3;
    int dith_err[3];
    for(c=0;c<3;c++)
     dith_err[c]= (rgb[c] - actual[c]);
    if(dith_err[0]||dith_err[1]||dith_err[2])
     {
      int    n=0;
      double div=(diffusion[n++]+dither*8);
      while(1)
       {
        int nx=diffusion[n++],ny=diffusion[n++],strength=diffusion[n++];
        if(strength==0)
         break;
        if((x+nx<w)&&(y+ny<h))
         for(c=0;c<3;c++)
          {
           double add=(double)dith_err[c]*(double)strength/div;
           int    nrgb = (int)(rgb[nx*3+ny*w+c] + add);
           rgb[nx*3+ny*w+c] = max(0,min(nrgb,255));
          }        
       }
     }
    memcpy(rgb,palette+idx*3,3);
   }
}

void image_SATURATION(u8*data,int w,int h,int n,float s)
{
 int x,y; 
 for(x=0;x<w;x++)     
  for(y=0;y<h;y++)
   {
    unsigned char*pix=&data[x*n+y*n*w];
    unsigned char r=pix[0];
    unsigned char g=pix[1];
    unsigned char b=pix[2];
    float         L = 0.3f*r + 0.6f*g + 0.1f*b;
    pix[0]=(unsigned char)(r+s*(L-r));
    pix[1]=(unsigned char)(g+s*(L-g));
    pix[2]=(unsigned char)(b+s*(L-b));
   }
}

void image_COLORBALANCE(u8*data,int w,int h,int n,int minsat,int maxsat,int tied)
{
 u8     m[4],M[4],MM=0,mm=255;
 int    r,x,y;
 double gray[3]={0.2126,0.7152,0.0722};
 for(r=0;r<n;r++)
  {
   m[r]=255;M[r]=0;
   for(x=0;x<w;x++)
    for(y=0;y<h;y++)
    {
     u8 c=data[(x+y*w)*n+r];
     if(c>M[r]) M[r]=c;
     if(c<m[r]) m[r]=c;
     if(c>MM) MM=c;
     if(c<mm) mm=c;
    }
  }

 if((minsat!=0)||(maxsat!=0))
 {
  size_t nb_min=(w*h)*minsat/100;
  size_t nb_max=(w*h)*maxsat/100;
  MM=0;mm=255;
  for(r=0;r<n;r++)
   {
    size_t h_size = UCHAR_MAX + 1;
    size_t histo[UCHAR_MAX + 1];
    size_t i;
    /* make a cumulative histogram */
    memset(histo, 0x00, h_size * sizeof(size_t));
    for(x=0;x<w;x++)
     for(y=0;y<h;y++)
      {
       u8 c=data[(x+y*w)*n+r];
       histo[c] += 1;
      }
    for (i = 1; i < h_size; i++)
     histo[i] += histo[i - 1];

    i = 0;
    while (i < h_size && histo[i] <= nb_min)
     i++;
    /* the corresponding histogram value is the current cell position */
    m[r]=(u8)i;
    i = h_size - 1;
     /* i is unsigned, we check i<h_size instead of i>=0 */
    while (i < h_size && histo[i] > (w*h - nb_max))
      i--;
    /*
     * if we are not at the end of the histogram,
     * get to the next cell,
     * the last (backward) value > size - nb_max
     */
    if (i < h_size - 1)
        i++;
    M[r]=(u8)i;
    if(M[r]>MM) MM=M[r];
    if(m[r]<mm) mm=m[r];
   }
 }

 for(r=0;r<n;r++)
  {
   u8  norm[UCHAR_MAX + 1];
   int i,min=m[r],max=M[r];
   if(tied)
    {
     min=mm;
     max=MM;   
    }
   //min=max(m[2],max(m[0],m[1]));
   //max=min(M[2],min(M[0],M[1]));   
   for(i = 0; i < min; i++)
     norm[i] = 0;
   for (i = min; i < max; i++)
       /*
        * we can't store and reuse UCHAR_MAX / (max - min) because
        *     105 * 255 / 126.            -> 212.5, rounded to 213
        *     105 * (double) (255 / 126.) -> 212.4999, rounded to 212
        */
       norm[i] = (unsigned char) ((i - min) * UCHAR_MAX
                                  / (double) (max - min) + .5);
   for (i = max; i < UCHAR_MAX + 1; i++)
       norm[i] = UCHAR_MAX;
   /* use the normalization table to transform the data */
    for(x=0;x<w;x++)
     for(y=0;y<h;y++)
     {
      u8 c=data[(x+y*w)*n+r];
      data[(x+y*w)*n+r]=norm[c];
     }
  }
}

void image_CLAHE(u8*data,int w,int h,int n,int cl1,int cl2,int cl3)
{
 u8*rgba[4];
 u8 m[4],M[4],MM=0,mm=255;
 int r,x,y;

 if(cl1==-1) 
  cl1=4;
 else
  {
   int cl[]={1,2,4,8,16};
   if((cl1>0)&&(cl1<5))
    cl1=cl[cl1];
   else
    cl1=4;
  }
 if(cl2==-1) cl2=192/8;
 if(cl3==-1) cl3=35;

 for(r=0;r<n;r++)
 {
  rgba[r]=(u8*)calloc(w,h);
  m[r]=255;M[r]=0;
  for(x=0;x<w;x++)
   for(y=0;y<h;y++)
   {
    u8 c=data[(x+y*w)*n+r];
    if(c>M[r]) M[r]=c;
    if(c<m[r]) m[r]=c;
    if(c>MM) MM=c;
    if(c<mm) mm=c;
    rgba[r][x+y*w]=c;
   }
 }

 for(r=0;r<n;r++)
 {
  CLAHE(rgba[r],w,h,m[r],M[r],cl1,cl1,cl2*8,(float)(cl3/10.0f));
  for(x=0;x<w;x++)
   for(y=0;y<h;y++)
    data[(x+y*w)*n+r]=rgba[r][x+y*w];
  free(rgba[r]);
 }
}

void imageefx_reset(imageefx*efx)
{
 memset(efx,0,sizeof(imageefx));
 efx->val[efx_contrast]=255;
 /*efx->val[efx_cl1]=2;
 efx->val[efx_cl2]=224/8;
 efx->val[efx_cl3]=60;*/
}

char efxnames[][24]={
                     "sharpen","unsharpen",
                     "contrast","morecontrast",                     
                     "dither","dithermethod",
                     "brightness","saturation",
                     "cl1","cl2","cl3",                     
                     "gray",
                     "xpos","ypos",
                     "colorbalance",
                     ""};


int imageefx_read(imageefx*efx,const char*ini)
{
 FILE*f=fopen(ini,"rb");
 if(f)
 {
  while(!feof(f))
  {  
   char line[256];
   fgets(line,sizeof(line),f);
   if(*line=='[')
    continue;
   else
   {
    char name[256];
    char*num;
    int  x=0;
    while(line[x]&&(line[x]!='='))
     {name[x]=line[x];x++;}
    name[x]=0;
    num=line+x+(line[x]=='=');
    for(x=0;x<efx_count;x++)
     if(strcmp(name,efxnames[x])==0)
      {
       efx->val[x]=atoi(num);
       break;
      }
   }
  }
  fclose(f);
  return 1;
 }
 else
  return 0;
}

int imageefx_write(imageefx*efx,const char*ini)
{
 FILE*f=fopen(ini,"wb");
 if(f)
 {
  int i;
  fprintf(f,"[efx]\n");
  for(i=0;i<efx_count;i++)
   fprintf(f,"%s=%d\n",efxnames[i],efx->val[i]);
  fclose(f);
  return 1;
 }
else
 return 0;
}