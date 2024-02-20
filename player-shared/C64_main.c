// ---------------------------------------------------------------
// StoryTllr64 - player - v 1.0.1
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

#include "C64_main.h"

#define BYTENUM_ONLY

void mini_itoa(int n, char * s)
{
#if defined(BYTENUM_ONLY)
#if defined(TARGET_GENERIC)||defined(EMUL)
 char neg = n < 0;
 char	i = 0, j = 0;
 if (neg)
  n = -n;
 do
 {
  int	d = n % 10;
  d += '0';
  s[i++] = d;
 } while ((n /= 10) > 0);
 if (neg)
  s[i++] = '-';
 s[i] = 0;
 while (j + 1 < i)
 {
  char c = s[j];
  s[j++] = s[--i];
  s[i] = c;
 }
#else
 u8 i=0;
 if(n>=100)
  {
   s[i]='0';
   while(n>=100)
    {s[i]++;n-=100;}
   i++;
  }
 if(n>=10)
  {
   s[i]='0';
   while(n>=10)
    {s[i]++;n-=10;}
   i++;
  }
 else
  if(i)
   s[i++]='0';
 s[i]='0'+n;
 i++;
 s[i]=0;
#endif
#else
	char neg=n<0;
 char	i=0,j=0;
	if(neg)
		n = - n;
 do
 {
		int	d = n % 10;
		d += '0';
		s[i++] = d;
  }
 while ((n /= 10) > 0);
	if (neg)
	s[i++] = '-';
	s[i] = 0;
	while (j + 1 < i)
	{
		char c = s[j];
		s[j++] = s[--i];
		s[i] = c;
	}
#endif
}

//#define NOBITMAP

// ---------------------------------------------------------------
// MEMORY DEFINITIONS
// ---------------------------------------------------------------

//#define TEMPAREA   ADDR(0xC800)

#define GAMETEMPAREA  ADDR(0x0400)
#define GAMEORIGAREA  ADDR(0x0500)

#define TOPBITMAP  ADDR(0xE000)
#define VIDEOMEM   ADDR(0xF000)

#if defined(USE_FONT)
#define TTVIDEOMEM 0xF400
#define TVIDEOMEM  ADDR(TTVIDEOMEM)
#else
#define TVIDEOMEM  ADDR(0x0400)
#endif
#define FONTMEM    ADDR(0xF800)

#if defined(NOBITMAP)
u8*video_ram=ADDR(0x0400);
#else
u8*video_ram=TVIDEOMEM;
#endif
u8*video_colorram=ADDR(0xD800);
u8*bitmap_image=TOPBITMAP;

//u8*basecachemem,*cachemem;
u16 csize;

u8 slowmode=0;

#define MAX_CMD   80
#define MAX_TMP   40
#define MAX_TMP2 120
#define VRBLEN    10

u8*strcmd=ADDR(0x02A7);//TEMPAREA+MAX_TMP+VRBLEN;

u8*tmp;//=TEMPAREA;
u8*vrb;//=TEMPAREA+MAX_TMP;
u8*tmp2;//=TEMPAREA+MAX_TMP+VRBLEN; // MAX_CMD+
//u8*loadram=TEMPAREA+MAX_TMP+MAX_TMP2+VRBLEN; // MAX_CMD+
u8 icmd=0;

u16 ww;

u8* m_bitmap;
u16 m_bitmap_w,m_bitmap_ox;
u8  m_bitmap_h,m_bitmap_oy;
u8  load;


#if defined(USE_DISK)
#if defined(WIN32)||defined(APP_SDL)||defined( APP_WASM )
const char*FILENAME(char*nm)
{
 static char nn[256];
#if defined(TARGET_GENERIC)
 sprintf(nn,"%s%s",basepath,nm);
#else
 sprintf(nn,"%simg/%s",basepath,nm);
#endif
 return nn;
}
#else
#define FILENAME(nm) nm
#endif
#endif

#if defined(OSCAR64)
#define FREAD(A,B) krnio_read(lfn_command,(char*)A,B)    
#define FWRITE(A,B) krnio_write(lfn_command,(char*)A,B)    
#else
#if defined(EMUL)
#define FREAD(A,B) emuFREAD(A,1,B,fp)
#define FWRITE(A,B) emuFWRITE(A,1,B,fp)
#else
#define FREAD(A,B) fread(A,1,B,fp)
#define FWRITE(A,B) fwrite(A,1,B,fp)
#endif
#endif


#if defined(USE_DISKSAVE)
#if defined(OSCAR64)
u8 diskmemlow,diskmemhi,ediskmemlow,ediskmemhi;
char disknm[]="@0:SAVE";
#define disknmlen 7
u8 disk_load(const char*nm,u8*mem,u16 len)
{ 
 diskmemlow=((u16)mem)&0xFF;
 diskmemhi=((u16)mem)>>8;
 __asm{
        lda #disknmlen
		      ldx #<disknm
		      ldy #>disknm
		      jsr SETNAM

        lda #$01
		      ldx $BA 
        bne skip
		      ldx #$08
skip:
		      ldy #$00
		      jsr SETLFS

		      lda #$00
        LDX diskmemlow
        LDY diskmemhi
		      jsr LOAD
        BCS  error 
        lda #1
        sta accu
        rts
error:
        lda #0
        sta accu
        rts
  } 
}
u8 disk_save(const char*nm,u8*mem,u16 len)
{
 diskmemlow=((u16)mem)&0xFF;
 diskmemhi=((u16)mem)>>8;
 mem+=len;
 ediskmemlow=((u16)mem)&0xFF;
 ediskmemhi=((u16)mem)>>8;
 __asm{
        lda #disknmlen
		      ldx #<disknm
		      ldy #>disknm
		      jsr SETNAM		      

        lda #$01
		      ldx $BA 
        bne skip
		      ldx #$08
skip:
		      ldy #$00
		      jsr SETLFS

        LDA diskmemlow
        STA $C1
        LDA diskmemhi
        STA $C2
        LDX ediskmemlow
        LDY ediskmemhi
        lda #$C1
		      jsr SAVE
        BCS  error 
        lda #1
        sta accu
        rts
error:
        lda #0
        sta accu
        rts
  } 
}
#else
u8 disk_load(const char*nm,u8*mem,u16 len)
{
 u8 retval=1;
#if defined(OSCAR64)
 u8 disk=*ADDR(0xBA);
 if(disk==0) disk=8;
 krnio_setnam("SAVE,S,R");	
 if (krnio_open(lfn_command, disk, 2))
#else
 FILE*fp=fopen(nm,"rb");
 if(fp)
#endif
 {
  u16 read=FREAD(mem,len);
  if(read!=len)
   retval=0;
  #if defined(OSCAR64)
  krnio_close(lfn_command);
  #else
  fclose(fp);
  #endif
  return retval;
 }
 else
  return 0;
}
u8 disk_save(const char*nm,u8*mem,u16 len)
{
 u8 retval=1;
 #if defined(OSCAR64)
 u8 disk=*ADDR(0xBA);
 if(disk==0) disk=8;
 krnio_setnam("SAVE,S,W");	
 if (krnio_open(lfn_command, disk, 2))
 #else
 FILE*fp=fopen(nm,"wb");
 if(fp)
 #endif
  {
   u16 written=FWRITE(mem,len);
   if(written!=len)
    retval=0;
   #if defined(OSCAR64)
   krnio_close(2);
   #else
   fclose(fp);
   #endif
   return retval;
  }
 else
  return 0;
}
#endif
#endif

// ---------------------------------------------------------------
#if defined(USE_FONT)
#if defined(USE_DISK)&&defined(USE_FONTONDISK)
void font_load()
{
 u8 *mem=ADDR(0x4000); 
 u16 len=634;
 #if defined(OSCAR64)
 u8 disk=*ADDR(0xBA);
 if(disk==0) disk=8;
 krnio_setnam("FONT");	
 if (krnio_open(lfn_command, disk, 2))
#else
 FILE*fp=fopen(FILENAME("font"),"rb");
 if(fp)
#endif
 {
  u16 read=FREAD(mem,len);
  #if defined(OSCAR64)
  krnio_close(lfn_command);
  #else
  fclose(fp);
  #endif
  {
   u8 *tmp=ADDR(0xC000); 
   u16 i;
   hunpack(mem,tmp);
   memcpy(FONTMEM,tmp,128*8);
   for(i=0;i<128*8;i++)
    tmp[i]=255-tmp[i];
   memcpy(FONTMEM+128*8,tmp,128*8);
  }
 }
}
#else
#include "font.h"
void font_load()
{
 u8 *tmp; 
 u16 i;
 tmp=ADDR(0xC000);
 hunpack(font,tmp); 
#if defined(TARGET_GENERIC)
 memcpy(bCHARACTERS,tmp,128*8);
 for(i=0;i<128*8;i++)
  tmp[i]=255-tmp[i];
 memcpy(bCHARACTERS+128*8,tmp,128*8); 
#else
 memcpy(FONTMEM,tmp,128*8);
 for(i=0;i<128*8;i++)
  tmp[i]=255-tmp[i];
 memcpy(FONTMEM+128*8,tmp,128*8);
#endif
}
#endif
#endif
// ---------------------------------------------------------------
#include "include_storytllr64.c"
// ---------------------------------------------------------------
#if defined(APP_SDL)||defined( APP_WASM )
void do_bitmapmode(){}
void do_textmode(){}
void IRQ_textmode(){}
void IRQ_bitmapmode(){}
void IRQ_reset(){}
void IRQ_gfx_init(){}
#else
#include "include_irq.c"
#endif
// ---------------------------------------------------------------
#if !defined(advcartridgeondisk)
#define USE_HIMAGE
#if defined(TARGET_GENERIC)
#else
#if defined(easyflask_images)
#if defined(OSCAR64)
#include "storytllr64_crtimages.c"
#else
#include "storytllr64_crtimages.c"
#endif
#else
#include "images.h"
#endif
#endif
#endif
// ---------------------------------------------------------------
#include "include_ui.c"
// ---------------------------------------------------------------

// ---------------------------------------------------------------
// GLOBALS
// ---------------------------------------------------------------

#if defined(WIN32)
u8 video_scroll_x,video_scroll_y;
#endif



// ---------------------------------------------------------------

//u8 cached_room[2]={255,255};
u8*cached_mem[2];

void irq_detach(u8 mode)
{
 REFRESH
 IRQ_reset();
 if((mode==0)|| (mode == 4))
  do_textmode();
 else
  {
   do_bitmapmode();
   memset(VIDEOMEM+((split_y / 8)*40),0,(25- (split_y / 8 ))*40);
   memset(video_colorram+((split_y / 8) *40),COLOR_BLACK,(25- (split_y / 8 ))*40);
  }
 //REFRESH
}

void irq_attach()
{
 REFRESH
 IRQ_gfx_init();
}

#if !defined(USE_HIMAGE)
void os_core_roomimage_load()
{ 
#if img_fileformat==16
#else
 FILE*fp;  
 char nm[]="room01";
 u8 r=imageid+1;
 nm[4]='0'+(r/10); 
 nm[5]='0'+(r%10); 
    
 //vid_setcolorBRD(COLOR_WHITE);
 fp = fopen(FILENAME(nm), "rb");  
 if(fp)
  {
   u16 psize,lsize;
   u8* cache;
   u8  lcachemem[14];
   csize=0;         
   fread(lcachemem,14,1,fp);
   csize+=14;
   lsize=0;
   
   psize=*(u16*)(lcachemem+8);*(u16*)(lcachemem+8)=lsize;lsize+=psize;
   
   psize=*(u16*)(lcachemem+10);*(u16*)(lcachemem+10)=lsize;lsize+=psize;
   
   psize=*(u16*)(lcachemem+12);*(u16*)(lcachemem+12)=lsize;lsize+=psize;

#if defined(FILEFORMAT2DIRECT)
   cache=ADDR(0xCFFF)-(lsize+14);
#else
   cache=cachemem;
#endif
   cached_mem[0]=cache;
   memcpy(cache,lcachemem,14);
   
   psize=fread(cache+14,lsize,1,fp);
   //cachemem+=lsize;
   fclose(fp);
  }  
#endif
}
#endif

void os_roomimage_load()
{  
 u8 img=roomimg[room];
 if(slowmode==2)
  img=0;
 if(img!=curimageid)
  {
  if (slowmode == 4)
   ui_image_clear();
  else
   {
    imageid = img;
    ui_room_update();
    curimageid = imageid;
   }
  }
 ui_status_update();
 
 REFRESH
 
}


#define _DBG(a)
#define DBG(iln) _DBG(iln);

#if defined(advcartridgeondisk)
#if defined(OSCAR64)
#define REG_INTSERVICE_LOW  $0314
#define REG_INTSERVICE_HIGH $0315
#define REG_STOP_LOW   $0328
#define REG_STOP_HIGH  $0329
#define OSCAR64DIRECT
char advnm[]="ADVCARTRIDGE";
void irq_border_on()
{
 __asm{
  jmp skip

irq:
    stx $d020
    jmp $f6fe

skip:
  sei    

  lda #<irq
  ldx #>irq
  sta REG_STOP_LOW
  stx REG_STOP_HIGH    
  cli 
 }
}
void irq_border_off()
{
 __asm{
        sei        
        
        lda #$ed
        ldx #$f6
        sta REG_STOP_LOW
        stx REG_STOP_HIGH
        cli        
}
}
#endif
void checksum(u16 ln)
{
 u16 i=0;
 u8  sum=0;
 while(i<ln)
  sum+=advcartridge[i++];
 if(sum!=0)
  vid_setcolorBRD(COLOR_WHITE);
 else
  vid_setcolorBRD(COLOR_RED);  
}
void setupcartridge(u16 iln)
{
 u16 ln=0;

 freemem=ADDR(0xCB80)-(advcartridge+iln);
 
 iln=*(u16*)tmp2;tmp2+=sizeof(iln);   
 DBG(iln)
 
 //fread(&ln,sizeof(ln),1,f);
 ln=*(u16*)tmp2;tmp2+=sizeof(ln);      
 opcode_vrbidx_count=(u8)ln;
 DBG(ln)
 
 //fread(&ln,sizeof(ln),1,f);
 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 obj_count=(u8)ln;
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 room_count=(u8)ln;
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 var_count=(u8)ln;
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 shortdict=advcartridge+ln;    
 DBG(ln)
 
 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 advnames=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 advdesc=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 msgs=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 msgs2=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 verbs=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 objs=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 objs_dir=(u16*)(advcartridge+ln);    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 rooms=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 packdata=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 opcode_vrbidx_dir=(u16*)(advcartridge+ln);    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 opcode_vrbidx_data=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 opcode_pos=(u16*)(advcartridge+ln);    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 opcode_len=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 opcode_data=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 roomnameid=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 roomdescid=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 roomimg=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 roomovrimg=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 objnameid=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 objdescid=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 objimg=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);    
 objattr=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 objloc=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 objattrex=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 roomstart=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 roomattr=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 roomattrex=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 bitvars=advcartridge+ln;    
 DBG(ln)

 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 vars=advcartridge+ln;    
 DBG(ln)

#if defined(USE_ORIGRAM)
 ln=*(u16*)tmp2;tmp2+=sizeof(ln);   
 origram=advcartridge+ln;    
 DBG(ln)
#endif

 //checksum(ln);

 ln = *(u16*)tmp2; tmp2 += sizeof(ln);
 imagesidx = (u16*)(advcartridge + ln);
 ln = *(u16*)tmp2; tmp2 += sizeof(ln);
 imagesdata = advcartridge + ln;
 if(imagesdata == (u8*)imagesidx)
  {
   imagesidx = NULL; imagesdata = NULL;
  }

 ln = *(u16*)tmp2; tmp2 += sizeof(ln);
 origram_len = ln;
 DBG(ln)


#if !defined(USE_ORIGRAM)
  memcpy(GAMEORIGAREA,objattr,origram_len);
#endif
 DBG(*roomdescid)
 
 //basecachemem=origram+ln;

 if(roomovrimg==roomattr)  roomovrimg=NULL;
 if(objimg==objattr)       objimg=NULL;
 if(roomattrex==objattrex) roomattrex=NULL;
 if(objattrex==bitvars)    objattrex=NULL;   
 
//   vid_setcolorBRD(ch++);
//   vid_setcolorBRD(ch++);
 
 tmp=GAMETEMPAREA;
 vrb=tmp+MAX_TMP;
 tmp2=vrb+VRBLEN; // MAX_CMD+

}
u8 loadcartridge()
{
 u16 iln=0;      
 #if defined(WIN32)||defined(APP_SDL)||defined( APP_WASM )
 advcartridge=ADDR(0x4000);
 #else
 advcartridge=ADDR(0x4000);
 #endif
 #if defined(OSCAR64DIRECT)
 {
#define load_address 0x4000
  irq_border_on();
  __asm{
        lda #$01
        ldx $BA 
        bne skip
		      ldx #$08
skip:
		      ldy #$00
		      jsr SETLFS

		      lda #12
		      ldx #<advnm
		      ldy #>advnm
		      jsr SETNAM

		      lda #$00
        LDX #<load_address
        LDY #>load_address
		      jsr LOAD
  
        BCS  error 
        jmp good
error:
        jsr irq_border_off

        lda #0
        sta accu        
        rts
good:
        jsr irq_border_off

  }
  //IRQ_reset();
  iln=*(u16*)advcartridge;
  DBG(iln)
  advcartridge+=sizeof(u16);
  tmp2=advcartridge+iln;
 }
#else
 #if defined(OSCAR64)
 {
  u8 disk=*ADDR(0xBA);
  if(disk==0) disk=8;
  krnio_setnam(advnm);	
  if (krnio_open(lfn_command, disk, sa_command))
 #else
 {
  FILE*fp;
// vid_setcolorBRD(COLOR_YELLOW);
#if defined(WIN32)||defined(APP_SDL)||defined( APP_WASM )
  char card[256];
  sprintf(card,"%sadvcartridge",basepath);
  fp=fopen(card,"rb");
#else
  fp=fopen("advcartridge","rb");
#endif  
  if(fp)
#endif
  {
#if defined(WIN32)||defined(APP_SDL)||defined( APP_WASM )
   u16 read=FREAD(advcartridge,65536);  
   advcartridge+=sizeof(iln);
   iln=*(u16*)advcartridge;advcartridge+=sizeof(u16);
   tmp2=advcartridge+iln;
#else
   FREAD(&iln,sizeof(iln)); // size of cartridge
   FREAD(&iln,sizeof(iln)); // size of cartridge
   DBG(iln)      
   FREAD(advcartridge,iln);          
   FREAD(tmp2,advcartridge_dirsize);
#endif
   #if defined(OSCAR64)
   krnio_close(lfn_command);
   #else
   fclose(fp);
   #endif
  }
 }
#endif

 if(iln)
 {
  setupcartridge(iln);
  return 1;
 }
 else
  return 0;
// vid_setcolorBRD(COLOR_BLACK); 
}
#endif 

void os_init()
{
 #if defined(WIN32)||defined(APP_SDL)||defined( APP_WASM )
 
 #else
 #if defined(OSCAR64)
 mysrand();
 #else
 _randomize();
 #endif
 #endif

 vid_setcolorBKG(COLOR_BLACK);
 vid_setcolorBRD(COLOR_BLACK);

#if defined(NOBITMAP)
#else
#if defined(USE_FONT) 
 font_load();
#endif 
#endif

 // key autorepeat OFF
#if defined(OSCAR64)
 __asm{
  lda $028A
  and #$3f
  ora #$40
  sta $028A
 }
#else
#if defined(APP_SDL)||defined( APP_WASM )
#else
 __asm__("lda $028A");
 __asm__("and #$3f");
 __asm__("ora #$40");
 __asm__("sta $028A");
#endif
#endif

 memset(video_ram,' ',1000);
 memset(video_colorram,COLOR_BLACK,1000);

 REFRESH
 
#if defined(NOBITMAP)
 *ADDR(0x01)=(37-3);
#else
#if defined(OSCAR64)
  mmap_set(MMAP_NO_BASIC);
#endif
#endif
 
}

void os_reset()
{
#if defined(OSCAR64)
 __asm{
  JSR $FCE2
 }
#else
 #if defined(APP_SDL)||defined( APP_WASM )
 #else
 __asm__("JSR $FCE2");
#endif
#endif
}

void dos_msg(const char*label,u8 pos)
{
 u8 i=0;
 u8*scr=video_ram+12*40+pos;
 u8*col=video_colorram+12*40+pos;
 while(label[i])
  {
   u8 ch=label[i++];
   if((ch>='A')&&(ch<='Z'))
    ch=(ch-'A')+1;
   *scr++=ch;*col++=COLOR_YELLOW;
  }
}

#if defined(WIN32)||defined(APP_SDL)||defined( APP_WASM )
int c64_main()
#else
int main()
#endif
{
 //loadcartridge();
 //return 0;
 os_init();  

 #if defined(advcartridgeondisk)  
 do_textmode();
 dos_msg("LOADING...",(40-10)/2);
 if(loadcartridge()==0)
  {
   dos_msg("DISK ERROR",(40-10)/2);
   puts("\nPLEASE TURN VIRTUAL DEVICE OR TRUE EMULATION ON");
   return 0; 
  }
 else
  {
   memset(video_ram+12*40,0,80);
   memset(video_colorram+12*40,0,80);
  }
#else 
#if defined(WIN32)||defined(APP_SDL)||defined( APP_WASM )
 tmp=GAMETEMPAREA;
 vrb=tmp+MAX_TMP;
 tmp2=vrb+VRBLEN; // MAX_CMD+
   //basecachemem=ADDR(0x8000);
#else
   //basecachemem=origram+origram_len;   
#endif   
#endif 
 REFRESH
 IRQ_gfx_init();
 vid_setcolorBRD(COLOR_BLACK);
 *strcmd=0;

#if defined(WIN32)||defined(APP_SDL)||defined( APP_WASM )
 cmdlog_start();
#endif

 //IMAGE_clear();
 //slowmode=1;
 clean();
 adv_start();
 //slowmode=0;

 while(1)
 {
   
   parser_update();
   
   quit_request=ch=0;
   while(quit_request==0)
   {  
  #if defined(WIN32)||defined(APP_SDL)||defined( APP_WASM )
    ch=cgetc();
  #elif defined(OSCAR64)
    __asm{
     JSR SCNKEY
     JSR GETIN
     STA ch
   }
  #else
    __asm__("JSR %w",SCNKEY);
    __asm__("JSR %w",GETIN);
    __asm__("STA %v",ch);
  #endif
    if(ch)
     {
      hide_blink();
      if(ch==CHAR_RETURN)
       execute();
      else
       if(ch==CHAR_UP)
        ;
       else
       {
        if(ch==CHAR_BACKSPACE)
        {
         if(icmd)
          strcmd[--icmd]=0;
        }
        else
        {
         if(icmd<MAX_CMD)
          {
           ch=charmap(ch);
           if(ch)
            {
             strcmd[icmd++]=ch;
             strcmd[icmd]=0;
            } 
          }    
        }
        parser_update();
       }
     }
    else
     do_blink();
     
    REFRESH
   }
   
  if(quit_request>=2)
   {    
    u8 skipreload=0;
    if(quit_request==2)
     adv_reset();
    else
     {      
      if(adv_load()==0)
       skipreload=1;          
     }
    if(skipreload)
     ;
    else
     {
      newroom=*roomstart;
      room_load();      
     }
    quit_request=0;
   }
  else
   break;
 }
 
 os_reset();
 
 return 0;
}
