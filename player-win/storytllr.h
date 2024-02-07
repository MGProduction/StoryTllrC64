#if !defined(_STORYTLLR_H_)
#define _STORYTLLR_H_

typedef unsigned char  u8;
typedef signed   char  s8;
typedef unsigned short u16;
typedef signed   short s16;
typedef unsigned int   u32;
typedef signed   int   s32;

#define isbetween(a,b,c) (((a)>=(b))&&((a)<=(c)))

#define COLOR_BLACK             0x00
#define COLOR_WHITE             0x01
#define COLOR_RED               0x02
#define COLOR_CYAN              0x03
#define COLOR_VIOLET            0x04
#define COLOR_PURPLE            COLOR_VIOLET
#define COLOR_GREEN             0x05
#define COLOR_BLUE              0x06
#define COLOR_YELLOW            0x07
#define COLOR_ORANGE            0x08
#define COLOR_BROWN             0x09
#define COLOR_LIGHTRED          0x0A
#define COLOR_GRAY1             0x0B
#define COLOR_GRAY2             0x0C
#define COLOR_LIGHTGREEN        0x0D
#define COLOR_LIGHTBLUE         0x0E
#define COLOR_GRAY3             0x0F

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

void clrscr();
unsigned char bordercolor(unsigned char);
unsigned char bgcolor(unsigned char);
unsigned char textcolor(unsigned char);

void screen_update();

void cmdlog_start();
void cmdlog_addcmd(const u8*cmd);
void cmdlog_addtitle(const u8*cmd);

void vid_setcolorBRD(u8 col);
void vid_setcolorBKG(u8 col);
void vic_wait_offscreen();
u8   charmap(u8 ch);

// ---------------------------
void status_update();
void clean();
void do_blink();
void hide_blink();
void parser_update();
void ui_room_update();
void cr();
extern u8 bCHARACTERS[256*8];
// ---------------------------

#endif