#ifndef __MGLIB_H__
#define __MGLIB_H__

typedef unsigned char  u8;
typedef signed   char  s8;
typedef unsigned short u16;
typedef signed   short s16;
#if defined(TARGET_GENERIC)||defined(EMUL)
typedef unsigned int u32;
typedef signed   int s32;
#endif

#if defined(WIN32)||defined(APP_SDL)
extern u8 bMEM[];
#define fastcall
#define ADDR(a) &bMEM[a]
u8*remapmem(u8*mem,u16 size);
#define REMAPMEM(a,sizeofa) remapmem(a,sizeofa)
#else
#define ADDR(a) (u8*)a
#define REMAPMEM(a,sizeofa) ((u8*)a)
#endif

//#include "upk.h"
#if defined(OSCAR64)||defined(TARGET_GENERIC)
#else
#include "vid.h"
#endif

#endif