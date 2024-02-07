#ifndef mg_ase_h
#define mg_ase_h

#ifdef __cplusplus
extern "C" {
#endif

#define carray_usage
#include "minilib.h"
#include "aseformat.h"

typedef struct{
 short x,y,w,h;
}_svquad;

typedef struct
{
 _svquad       uv;
 float         alpha;
 char         *name;
 unsigned char attr;
}_aseimg;

typedef struct
{
 _aseimg  *images;
 int       nimages;
}_aseimgblock;

typedef struct
{
 _strhash name;
 uint32_t*tiles;
 uint16_t tilew,tileh,tilecount;
 uint32_t*map;
 uint16_t mapw,maph;
}_asetilemap;

typedef struct
{
 _asetilemap *tilemap;
 int          ntilemap;
}_asetilemaps;

typedef struct
{
 _svquad       uv,ruv;
 short         ms;
}_frame;

typedef struct
{
 _strhash name;
 short*   ids;
 int      nids;
 char     flags; 
}_animframe;

typedef struct
{
 _frame     *frames;
 int         nframes;
 _animframe *aframes;
 int         naframes;
}_animation;

#define       atlas_twopow         0
#define       atlas_freesize       1
#define       atlas_mergelayers  256
#define       atlas_framehcrop   512 
#define       atlas_framevtop   1024
#define       atlas_dontswapy   2048

void*         mg_createATLAS();
void          mg_deleteATLAS();
void          mg_addtoATLAS(void*atlas,const char*name,void*mem,int w,int h,int mode);
void          mg_addtoATLASex(void*atlas,const char*name,void*mem,int w,int h,int bx,int by,int bw,int bh,int mode);
unsigned char*mg_buildATLAS(void*atlas,int*w,int*h,int*framestart,_animation**anim,_aseimgblock*imgblock,int flags);
unsigned char*mg_readASE(const char*mainname,void*mem,int pp,int*w,int*h,_animation**anim,_aseimgblock*imgblock,_asetilemaps*tilemap,int flags);
int           mg_core_readASE(const char*mainname,void*mem,int pp,int*w,int*h,void*tatlas,int flags);

#ifdef __cplusplus
}
#endif

#endif