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

#define IRQ_UPPERLINE 5
#define IRQ_SPLITLINE 150
#define SYSTEM_IRQ_HANDLER 0xea81
#define SYSTEM_IRQ_VECTOR  0x313

#if defined(WIN32)
int irqon=0;
#endif

void do_bitmapmode()
{
 #if defined(OSCAR64)
 __asm{
 // bitmap mode ON
  lda $d011
  and #$1f 
  ora #$20 
  sta $d011
  // multicolor ON
  lda $d016
  ora #$10 
  sta $d016
  // bitmap bank 1
  lda $d018  
  and #$f0   
  ora #$08 
  sta $d018  
  // video bank 3
  lda $dd02  
  ora #3     
  sta $dd02  
  lda $dd00  
  and #$fc   
  ora #0     
  sta $dd00  
  // screen bank 12
  lda $d018  
  and #$0f   
  ora #$c0   
  sta $d018  
}
#else
 // bitmap mode ON
  __asm__("lda $d011");
  __asm__("and #$1f ; clear bits 5,6,7 of vic control register 1.");
  __asm__("ora #$20 ; set bit 5.");
  __asm__("sta $d011");
  // multicolor ON
  __asm__("lda $d016");
  __asm__("ora #$10 ; set bit 4 of vic control register 2.");
  __asm__("sta $d016");
  // bitmap bank 1
  __asm__("lda $d018  ; read the VIC-II pointer register. ");
  __asm__("and #$f0   ; preserve the upper nybble, clear the lower nybble.");
  __asm__("ora #$08 ; add in the adjusted 1-bit parameter value.");
  __asm__("sta $d018  ; write the VIC-II pointer register.");
  // video bank 3
  __asm__("lda $dd02  ; read Port-A Data Direction register (CIA #2).");
  __asm__("ora #3     ; set the lowest two bits (outputs).");
  __asm__("sta $dd02  ; write Port-A Data Direction register (CIA #2).");
  __asm__("lda $dd00  ; read Port-A data register (CIA#2).");
  __asm__("and #$fc   ; preserve the upper 6 bits, clear the lower 2.");
  __asm__("ora #0     ; add in the adjusted 2-bit parameter value.");
  __asm__("sta $dd00  ; write Port-A data register (CIA#2).");
  // screen bank 12
  __asm__("lda $d018  ; read the VIC-II pointer register.");
  __asm__("and #$0f   ; preserve the low nybble, clear the high nybble.");
  __asm__("ora #$c0   ; add in the adjusted 4-bit parameter value.");
  __asm__("sta $d018  ; write the VIC-II pointer register.");
#endif
}

void IRQ_textmode();
void IRQ_bitmapmode()
{
 #if defined(NOBITMAP)
#else
#if defined(OSCAR64)
 __asm{
  lda #$ff
  sta $d019 

  // --- __asm__("lda #%b",COLOR_BLACK);
  // --- __asm__("sta $d020");
  // --- __asm__("sta $d021");
 }
 do_bitmapmode();
 __asm{
  lda #IRQ_SPLITLINE
  sta $d012
  ldx #<IRQ_textmode
	 ldy #>IRQ_textmode
	 stx $0314
	 sty $0315
  // +leaveIRQ    
  jmp $ea81
 }
#else
  //  +enterIRQ
  __asm__("lda #$ff");//   ;this is the orthodox and safe way of clearing the interrupt condition of the VICII.
  __asm__("sta $d019 ");

  // --- __asm__("lda #%b",COLOR_BLACK);
  // --- __asm__("sta $d020");
  // --- __asm__("sta $d021");

  do_bitmapmode();

  __asm__("lda #%w",IRQ_SPLITLINE);
  __asm__("sta $d012");//                                                     ; this is the raster line register");
  __asm__("ldx #<%v",IRQ_textmode);//	;lo-byte
	 __asm__("ldy #>%v",IRQ_textmode);//	;hi-byte
	 __asm__("stx $0314");//
	 __asm__("sty $0315");//
  // +leaveIRQ    
  __asm__("jmp $ea81");
#endif
#endif
}

void do_textmode()
{
 #if defined(NOBITMAP)
#else
#if defined(OSCAR64)
 __asm{
  lda $d011
  and #$1f 
  sta $d011
  // multicolor OFF
  lda $d016
  and #$ef 
  sta $d016
  // charset bank ROM mixedcase
  lda $d018
  and #$f0 
  ora #$06 
  sta $d018
  // video bank 3
  lda $dd02 
  ora #3    
  sta $dd02 
  lda $dd00 
  and #$fc  
#if defined(USE_FONT)    
  ora #0 
#else
  ora #3 
#endif
  sta $dd00 
  // screen bank 1
  lda $d018 
#if defined(USE_FONT)  
  and #$01  
  ora #$d0  
  ora #$0e  
#else
  and #$0f  
  ora #$10  
#endif  
  sta $d018 
 }

#else
//__asm__("lda #%b",COLOR_GRAY2);
  // --- __asm__("lda #%b",COLOR_BLACK);
  // --- __asm__("sta $d020");
  // --- __asm__("sta $d021");

  // bitmap mode OFF
  __asm__("lda $d011");
  __asm__("and #$1f ; clear bits 5,6,7 of vic control register 1.");
  __asm__("sta $d011");
  // multicolor OFF
  __asm__("lda $d016");
  __asm__("and #$ef ; clear bit 4 of vic control register 2.");
  __asm__("sta $d016");
  // charset bank ROM mixedcase
  __asm__("lda $d018  ; read the VIC-II pointer register. ");
  __asm__("and #$f0   ; preserve the upper nybble, clear the lower nybble.");
  __asm__("ora #$06   ; add in the adjusted 1-bit parameter value.");
  __asm__("sta $d018  ; write the VIC-II pointer register.");
  // video bank 3
  __asm__("lda $dd02  ; read Port-A Data Direction register (CIA #2).");
  __asm__("ora #3     ; set the lowest two bits (outputs).");
  __asm__("sta $dd02  ; write Port-A Data Direction register (CIA #2).");
  __asm__("lda $dd00  ; read Port-A data register (CIA#2).");
  __asm__("and #$fc   ; preserve the upper 6 bits, clear the lower 2.");
#if defined(USE_FONT)    
  __asm__("ora #0 ; add in the adjusted 2-bit parameter value."); // 3 
#else
  __asm__("ora #3 ; add in the adjusted 2-bit parameter value."); // 3 
#endif
  __asm__("sta $dd00  ; write Port-A data register (CIA#2).");
  // screen bank 1
  __asm__("lda $d018  ; read the VIC-II pointer register.");  
#if defined(USE_FONT)  
  __asm__("and #$01   ; preserve the low nybble, clear the high nybble.");
  __asm__("ora #$d0    ; add in the adjusted 4-bit parameter value."); // 1
  __asm__("ora #$0e    ; charset ");
#else
  __asm__("and #$0f   ; preserve the low nybble, clear the high nybble.");
  __asm__("ora #$10    ; add in the adjusted 4-bit parameter value."); // 1
#endif  
  __asm__("sta $d018  ; write the VIC-II pointer register.");
#endif
#endif
}

void IRQ_textmode()
{
 #if defined(NOBITMAP)
#else
#if defined(OSCAR64)
 __asm{
  lda #$ff
   sta $d019
 }

  do_textmode();

  __asm{
   lda #IRQ_UPPERLINE
  sta $d012
  ldx #<IRQ_bitmapmode
	 ldy #>IRQ_bitmapmode
	 stx $0314
	 sty $0315
  // +leaveIRQ    
  jmp $ea81
  }
#else

  __asm__("lda #$ff");//   ;this is the orthodox and safe way of clearing the interrupt condition of the VICII.
  __asm__("sta $d019 ");

  do_textmode();

  //  lda active_screenbank
  //  jsr vic_select_vmatrix

//    lda screencolor
    //sta VIC_backgroundcolor0        
    
  //  +set_raster_interrupt BEGIN_PREGUIAREA, irq_begin_preguiarea
  __asm__("lda #%b",IRQ_UPPERLINE);
  __asm__("sta $d012");//                                                     ; this is the raster line register");
  __asm__("ldx #<%v",IRQ_bitmapmode);//	;lo-byte
	 __asm__("ldy #>%v",IRQ_bitmapmode);//	;hi-byte
	 __asm__("stx $0314");//
	 __asm__("sty $0315");//
  // +leaveIRQ    
  __asm__("jmp $ea81");
#endif
#endif
}

void IRQ_gfx_init()
{
#if defined(NOBITMAP)
#else
#if defined(OSCAR64)
 __asm{
  sei
    
 ldy #$7f 
 sty $dc0d
    
 lda $d01a
 ora #$01
 sta $d01a
    
 lda $d011
 and #$7f
 sta $d011

#if defined(USE_MUSIC)
 jsr sidinit
#endif
 
 lda #IRQ_UPPERLINE
 sta $d012
 ldx #<IRQ_bitmapmode
	ldy #>IRQ_bitmapmode
	stx $0314
	sty $0315
//+load16word SYSTEM_IRQ_VECTOR, handler                        ; set system IRQ vector to our handler");
    
 cli 
 rts
 }
#else

 #if defined(WIN32)
 irqon=1;
 #endif
 __asm__("sei                                          ; disable interrupts");
    
 __asm__("ldy #$7f                                     ; 01111111 ");
 __asm__("sty $dc0d                                    ; turn off CIA timer interrupt");
    
 __asm__("lda $d01a                                    ; Enable raster interrupts");
 __asm__("ora #$01");
 __asm__("sta $d01a");
    
 __asm__("lda $d011");//                                    ; bit 7 of $d011 is the 9th bit of the raster line counter.");
 __asm__("and #$7f                                     ; make sure it is set to 0");
 __asm__("sta $d011");

#if defined(USE_MUSIC)
 __asm__("jsr sidinit");
#endif
 
 __asm__("lda #%b",IRQ_UPPERLINE);
 __asm__("sta $d012");//                                                     ; this is the raster line register");
 __asm__("ldx #<%v",IRQ_bitmapmode);//	;lo-byte
	__asm__("ldy #>%v",IRQ_bitmapmode);//	;hi-byte
	__asm__("stx $0314");//
	__asm__("sty $0315");//
//__asm__("+load16word SYSTEM_IRQ_VECTOR, handler                        ; set system IRQ vector to our handler");
    
 __asm__("cli                                          ; enable interupts");
 __asm__("rts");
#endif
#endif
}

void IRQ_reset()
{
 #if defined(NOBITMAP)
#else
#if defined(OSCAR64)
 __asm{
  sei
    
 lda $d01a
 and #$fe
 sta $d01a

 ldx #$81
	ldy #$ea
	stx $0314
	sty $0315
//+load16word SYSTEM_IRQ_VECTOR, handler                        ; set system IRQ vector to our handler");
    
 cli
 rts
 }
#else

 #if defined(WIN32)
 irqon=0;
#else
  __asm__("sei                                          ; disable interrupts");
    
 __asm__("lda $d01a");
 __asm__("and #$fe");
 __asm__("sta $d01a");

 __asm__("ldx #$81");//	;lo-byte
	__asm__("ldy #$ea");//	;hi-byte
	__asm__("stx $0314");//
	__asm__("sty $0315");//
//__asm__("+load16word SYSTEM_IRQ_VECTOR, handler                        ; set system IRQ vector to our handler");
    
 __asm__("cli                                          ; enable interupts");
 __asm__("rts");

#endif
#endif
#endif
}

#if defined(WIN32)
int getirqsettings(int irq,int*top,int*bottom)
{
 if(irqon)
  switch(irq)
   {
  case 0:
     IRQ_bitmapmode();
     if(top) *top=0;
     if(bottom) *bottom=IRQ_SPLITLINE-21;
     return 1;
  case 1:    
   {
     IRQ_textmode();
     if(top) *top=IRQ_SPLITLINE-21;
     if(bottom) *bottom=bordery+200;
     return 1;
   }
   default:
    return 0;
   }
 else
  if(irq==0)
   return 1;
  else
   return 0;
}
#endif