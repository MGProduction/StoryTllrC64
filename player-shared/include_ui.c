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

// -----------------------------
// UI CODE
// -----------------------------

#define ALIGN_LEFT   0
#define ALIGN_RIGHT  1
#define ALIGN_CENTER 2

#define code_reftoshortdict 93
#define shortdict_fixedlen   0
#define start_packedcouples 95

u16 ll,spl,align=0;
u8 x,y;
u8 blink;
u8 _pch,b_bch,_ech,_cplw,_cplx,b_cplw,b_cplx;
#if defined(TARGET_GENERIC)
u8 _buffer[SCREENCH_W+2],_cbuffer[SCREENCH_W+2];
#else
u8 _buffer[SCREEN_W+2],_cbuffer[SCREEN_W+2];
#endif
u8*_cpl;
u8*b_cpl;
u8*btxt;
u8 v,u;

void _savechpos()
{
 btxt=txt;
 b_cpl=_cpl;
 b_cplx=_cplx;b_cplw=_cplw;
 //b_bch=_bch;
}
void _restorechpos()
{
 txt=btxt;
 _cpl=b_cpl;
 _cplx=b_cplx;_cplw=b_cplw;
 //_bch=b_bch;
}

#if defined(MULTIPLATFORMPLAYER)
#else

void scrollup()
{
 REFRESH 
 #if defined(WIN32)
 memmove(video_ram+text_ty*40,video_ram+(text_ty+1)*40,(SCREEN_H-(text_ty+1))*40); 
 memset(video_ram+(SCREEN_H-1)*40,' ',40);
 #else
 #if defined(OSCAR64)
  if(*ADDR(0x02A6)==0) // NTSC
   vic_waitLine(IRQ_SPLITLINE);
  else
   vic_waitFrame();
  __asm{
   lda $1
   sta ch
   sei
   and $fc
   sta $1
 
   ldx #40

scrollloop:
   dex

#assign mem1 TTVIDEOMEM+(text_ty+0+1)*40
#assign mem2 TTVIDEOMEM+(text_ty+0)*40
#assign ry   0
#repeat		
	lda mem1,x
 sta mem2,x 
#assign mem1 mem1 + 40
#assign mem2 mem2 + 40
#assign ry ry + 1
#until ry == 10
#undef ry
#undef mem1
#undef mem2
  lda #32
  sta TTVIDEOMEM+24*40,x
 
 //inx");
  cpx #0
  bne scrollloop

  lda ch
  sta $1
  cli
 
  


 }
 #else
 __asm__("lda $1");
 __asm__("sta %v",ch);
 __asm__("sei"); 
 __asm__("and $fc");
 __asm__("sta $1");
 
 __asm__("ldx #40"); 
 __asm__("scrollloop:"); 
 __asm__("dex");
 
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+0+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+0)*40);
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+1+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+1)*40);
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+2+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+2)*40);
 
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+3+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+3)*40); 
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+4+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+4)*40);
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+5+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+5)*40);
 
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+6+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+6)*40);
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+7+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+7)*40); 
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+8+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+8)*40); 
 __asm__("lda %w,x",TTVIDEOMEM+(text_ty+9+1)*40);
 __asm__("sta %w,x",TTVIDEOMEM+(text_ty+9)*40); 
 
 //__asm__("inx");
 __asm__("cpx #0");
 __asm__("bne scrollloop");  

 __asm__("lda %v",ch);
 __asm__("sta $1");
 __asm__("cli");
 
 __asm__("lda #32");
 __asm__("ldx #39"); 
 __asm__("scrollloop2:"); 
 __asm__("dex"); 
 __asm__("sta %w,x",TTVIDEOMEM+24*40);
 __asm__("cpx #0");
 __asm__("bne scrollloop2");  
#endif
 
 #endif
 memmove(video_colorram+text_ty*40,video_colorram+(text_ty+1)*40,(SCREEN_H-(text_ty+1))*40); 
}

void ui_clear()
{
 text_y=0,text_x=0;al=0;
 if(clearfull)
  {
   memset(TVIDEOMEM+status_y*40,' ',SCREEN_W);
   memset(video_colorram+status_y*40,0,SCREEN_W);
   clearfull=0;
  }
 memset(TVIDEOMEM+TVIDEORAM_OFFSET,' ',TVIDEORAM_SIZE);
 memset(video_colorram+TVIDEORAM_OFFSET,0,TVIDEORAM_SIZE);
}

void _getnextch()
{
 _pch=_ch;
 #if defined(packed_strings)
  if(_ech)
   {
    _ch=_ech;
    _ech=0;
   }
  else  
  if(_cplx<_cplw)
   _ch=_cpl[_cplx++];
  else  
  /*if(_bch)
   {
    _ch=_bch;
    _bch=0;
   }  
  else*/
   if(txt==etxt)
    _ch=0;
   else     
    {
     _ch=*txt++;
     if((_ch==code_reftoshortdict)||(_ch==code_reftoshortdict+1))
     {
      if(_ch==code_reftoshortdict+1)
       _ch=*txt++;
      else
       _ch=1;

      _ch++;
      
      _cpl=shortdict+(1+shortdict[0])+shortdict[_ch];
      if (_ch >= shortdict[1])
       _cpl += 256;
      //memcpy(_cpl,packdata+(_ch<<1)+(_ch<<2),shortdict_fixedlen);
      _cplw=shortdict[_ch+1]-shortdict[_ch];_cplx=0;
      _ch=_cpl[_cplx++];
     }
     else
     if(_ch>=start_packedcouples)
      {
       _ch=_ch-start_packedcouples;
       _cpl=packdata+(_ch<<1);
       //memcpy(_cpl,packdata+(_ch<<1),2);
       _cplw=2;_cplx=0;
       _ch=_cpl[_cplx++];
       /*_ch=_cpl[0];
       _bch=_cpl[1];*/
      }
    }  
 #else
 if(txt==etxt)
  _ch=0;
 else  
  _ch=*txt++;
 #endif
}

void cr()
{
 REFRESH
#if defined(WIN32)
 cmdlog_addstream("\n", 1);
#endif
 text_x=0;
 text_y++;
 if(text_ty+text_y>=SCREEN_H)
  {  
   scrollup();
   text_y--;
  }
}

void core_cr()
{
 REFRESH
 txt_x=0;
 txt_y++;
 if((_ch==' ')||(_ch==FAKE_CARRIAGECR)) 
  _getnextch(); 
#if defined(WIN32)
 else
  cmdlog_addstream(" ", 1);
#endif
 if(txt_y>=SCREEN_H)
 {
  scrollup();
  txt_y--;
 }
 al++;
}

void core_drawscore()
{
 u8 i=0;
 u8*ptr;
 mini_itoa(vars[0],tmp);
 while(tmp[i]) i++;
 tmp[i++]='/';
 mini_itoa(vars[1],tmp+i);
 while(tmp[i]) i++;
 ptr=video_ram+status_y*40+40;
 ptr-=i;i=0;
 while(tmp[i])
 {
  ptr[i]=tmp[i]|128;
  i++;
 }
}

void core_drawtext()
{  
  _getnextch();
  while(_ch)
   {        
    if(al+1>=text_stoprange) 
     {
      _ech=_ch;     
      return;
     }
    if(_ch==FAKE_CARRIAGECR)
     {
      core_cr();
      _getnextch();
     }
    else
     {
      align=ALIGN_LEFT;spl=ll=0;
      while(_ch&&(ll+txt_x<SCREEN_W)&&(_ch!=FAKE_CARRIAGECR))
      {
       if(_ch==ESCAPE_CHAR)
        {
         _getnextch();
         switch(_ch)
         {
         case 'c'-'a'+1:
          align=ALIGN_CENTER;
         break; 
         case 'r'-'a'+1:
          align=ALIGN_RIGHT;
         break; 
         case 'l'-'a'+1:
          align=ALIGN_LEFT;
         break; 
         case 'g'-'a'+1:
          txt_col=COLOR_GRAY2;
          break;
          case 'y'-'a'+1:
          txt_col=COLOR_YELLOW;
          break;
         case 'w'-'a'+1:
          txt_col=COLOR_WHITE;
          break;
          case 'V'-'A'+65:
           u=1;
          case 'v'-'a'+1:
           v=0;
           while(vrb[v])
            {
             _buffer[ll]=vrb[v]+txt_rev;
             if(u)
              {_buffer[ll]+=64;u=0;}
             _cbuffer[ll]=txt_col; 
             ll++;v++;
            }
          break;
         }
         _getnextch();
        }
       else
        {
        if(_ch==' ')
         {
          spl=ll;
          _savechpos();
         }
        _buffer[ll]=_ch+txt_rev;_cbuffer[ll]=txt_col; 
        ll++;
        _getnextch();
        }
      }
      if((ll+txt_x==SCREEN_W)&&((_ch==0)||(_ch==' ')))
       ;
      else
      if(ll+txt_x>=SCREEN_W)
       {
        _restorechpos();
        ll=spl;
        _getnextch(); 
       }
      switch(align)
       {
       case ALIGN_CENTER:
         txt_x+=(SCREEN_W-ll)>>1;
        break;
        case ALIGN_RIGHT:
         txt_x+=(SCREEN_W-ll);
        break;
       }
#if defined(WIN32)
      cmdlog_addstream(_buffer, ll);
#endif
      memcpy(video_ram+txt_y*40+txt_x,_buffer,ll);
      memcpy(video_colorram+txt_y*40+txt_x,_cbuffer,ll);
      txt_x+=ll;      
      if(_ch==0)
       break;
      else
       core_cr();           
    }
  }
}

void status_update()
{
 strid=roomnameid[room];

#if defined(WIN32)
 if(strid!=255)
  {
   char title[256];
   int  i=0;
   str=advnames;_getstring();txt=ostr;
   _getnextch();
   while(_ch)
    {
     title[i++]=_ch;
     _getnextch();
    }
   title[i]=0;
   cmdlog_addtitle(title);
   }
#endif

 if(strid!=255)
  {
   str=advnames;_getstring();txt=ostr;
   memset(video_colorram+status_y*40,COLOR_YELLOW,40);
   memset(video_ram+status_y*40,160,40);
   al=0;txt_col=COLOR_YELLOW;txt_rev=128;txt_x=0;txt_y=status_y;
#if defined(WIN32)
   cmdlog_enable(0);
#endif
   core_drawtext();  
   if(vars[1])
    core_drawscore();
#if defined(WIN32)
   cmdlog_enable(1);
#endif
  }
 else
  {
   txt=(u8*)"";
   memset(video_colorram+status_y*40,COLOR_BLACK,40);
  }

 //ui_clear();
}

void hide_blink()
{
 video_colorram[txt_y * 40 + (txt_x)]=COLOR_BLACK;
}

void do_blink()
{
 blink++;
 if (blink > 90)
 {
   u8 ch;
   u16 blinkpos = txt_y * 40 + (txt_x);
   ch = video_colorram[blinkpos];
   if(ch==COLOR_BLACK)
    ch=COLOR_GRAY2;
   else
    ch=COLOR_BLACK;
   video_colorram[blinkpos]=ch;
   video_ram[blinkpos]=108;
   blink=0;
  }
}

char charmap(char c)
{
 if((c>='0')&&(c<='9'))
   c=c-'0'+48;
  else
  if((c>='A')&&(c<='Z'))
   c=c-'A'+1;
  else
   if((c>='a')&&(c<='z'))
    c=c-'a'+1;
   else
    if(c==' ')
     c=32;
    else
     if(c=='.')
      c=46;
     else
      if(c==',')
       c=44;
      else      
       c=0;
 return c;
}

void parser_update()
{  
 //txt=(u8*)">";
 al=0;txt_col=COLOR_GRAY2;txt_rev=0;txt_x=0;txt_y=text_ty+text_y;
 video_colorram[txt_y*40+txt_x]=COLOR_GRAY2;                         
 video_ram[txt_y*40+txt_x]='>';
 txt_x=1;
 //core_drawtext();
 txt=strcmd;
 txt_col=COLOR_GRAY2;
 core_drawtext(); 
 video_colorram[txt_y*40+txt_x]=COLOR_BLACK;                         
 video_ram[txt_y*40+txt_x]=' ';
 al=0;
 REFRESH
}

void ui_getkey()
{
 while(1)
  {
#if defined(WIN32)
 cmdlog_ui(1);
 ch=cgetc();
 cmdlog_ui(0);
#else
#if defined(OSCAR64)
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
#endif
 if(ch)
  break;
 REFRESH
  }
 #if defined(WIN32)
 if((ch>='a')&&(ch<='z'))
  ch=ch-'a'+'A';
 #endif
}

void ui_waitkey()
{
 ll=18;
 while(ll<21)
  {
  video_colorram[24*40+ll]=COLOR_GRAY1;
  video_ram[24*40+ll]=46;
  ll++;
  }
 ui_getkey();
 ll=18;
 while(ll<21)
  {
  video_colorram[24*40+ll]=COLOR_GRAY1;
  video_ram[24*40+ll]=' ';
  ll++;
  }
 al=0; 
}

void ui_text_write(u8*text)
{ 
 txt=text;
 txt_col=COLOR_WHITE; 
 if(text_attach)
  text_attach=0;
 else
  {
   txt_rev=0;txt_x=0;txt_y=text_ty+text_y;
  }
 while(1)
  {  
  core_drawtext();
  if(_ch==0)
   {
    if(txt[-1]=='+')
     {text_attach=1;if(txt_x) txt_x--;}
    else
    if(text_continue)
     text_attach=1;
    else
     {
     text_y=txt_y-text_ty;
      cr();
     }
   break;
   }
  else
   ui_waitkey();
  }  
 text_continue=0;
 al++; 
}

void IMAGE_clear()
{
 memset(TOPBITMAP,0,(split_y*320)/8); 
 memset(video_colorram,0,status_y*40-1);
 memset(VIDEOMEM,0,status_y*40-1);
 ui_clear();
}

u8*tt1,*t2,*t3,*ot1,*ot2,*ot3;
u16 wC,wwC,oxC,oxB;

void bytemem()
{
#if defined(FILEFORMAT2DIRECT)
 if(wC==wwC)
  hunpack(tt1,ot1);
 else
#endif
  {
   hunpack(tt1,ADDR(0xC000));
   tt1=ADDR(0xC000);
   if(oxC)
    ot1+=oxC;
   for(y=0;y<m_bitmap_h;y+=8) 
    {memcpy(ot1,tt1,wC);tt1+=wC;ot1+=wwC;}
  }
}

/*void ui_image_draw()
{ 
 if(m_bitmap_ox||m_bitmap_oy)
  oxB=m_bitmap_ox+(m_bitmap_oy>>3)*320;
 else
  oxB=(320-m_bitmap_w)>>1;
 
 oxC=oxB>>3;
 wC=m_bitmap_w>>3;wwC=SCREEN_W;
 tt1=m_bitmapcol;
 ot1=video_colorram;
 bytemem();
 tt1=m_bitmapscrcol;
 ot1=VIDEOMEM;
 bytemem();
 
 oxC=oxB;
 wC=m_bitmap_w;wwC=320;
 tt1=m_bitmap;
 ot1=bitmap_image;
 bytemem();
  
 
 t2=m_bitmapscrcol;
 t3=m_bitmap;
  
 ot1=video_colorram;
 ot2=VIDEOMEM;
 ot3=bitmap_image;
 
}*/

void ui_image_fade()
{
#if defined(FADEH)
 u8 x; 
 for(x=0;x<SCREEN_W/2;x++)
 {
  u16 yy;
  u8* v=VIDEOMEM;
  u8  y;
  REFRESH
  yy=y=0;
  while(y<(split_y/8))
   {
    video_colorram[x+yy]=0;
    video_colorram[(SCREEN_W-x-1)+yy]=0;
    v[x+yy]=0;
    v[(SCREEN_W-x-1)+yy]=0;
    yy+=40;y++;}
 } 
#else
 u8*v=VIDEOMEM+(96/8+1)*40;
 u8*c=video_colorram+(96/8+1)*40;
 u8 y=(96/8+1);
 while(y--)
 {
  memset(v,0,40);v-=40;
  memset(c,0,40);c-=40;
  REFRESH
  WAIT
 }
#endif
 memset(bitmap_image,0,(split_y*320)/8);
}

void ui_image_clean()
{
 memset(VIDEOMEM,0,(split_y/8)*40);   
 memset(video_colorram,0,(split_y/8)*40); 
 memset(bitmap_image,0,(split_y*320)/8);
 
}

void ui_room_gfx_update();

void ui_room_update()
{
 REFRESH
 
 #if defined(WIN32)  
 if(slowmode==0)
  ui_image_clean();
 #endif
 ui_room_gfx_update();
 status_update(); 
 
}

void clean()
{
 u8 backup=*ADDR(0x0001);
 *ADDR(0x0001)=0x37-3;
 memset(ADDR(0xF200),0,8);
 *ADDR(0x0001)=backup;
}

#if defined(OSCAR64)
#else
FILE*fp;
#endif
u8*fileptr;
u8 ui_openimage()
{ 
 if (imageid == 255)
  return 0;
 if (imagesidx)
 {
  fileptr = imagesdata + imagesidx[imageid];
  return 1;
 }
 else
 {
#if defined(OSCAR64)
  char nm[] = "ROOM01,P,R";
  u8 disk = *ADDR(0xBA);
  if (disk == 0) disk = 8;
  u8 r = imageid + 1;
  nm[4] = '0' + (r / 10);
  nm[5] = '0' + (r % 10);
  krnio_setnam(nm);
  if (krnio_open(lfn_command, disk, sa_command))
#else
  char nm[] = "room01";
  u8 r = imageid + 1;
  nm[4] = '0' + (r / 10);
  nm[5] = '0' + (r % 10);
  fp = fopen(FILENAME(nm), "rb");
  if (fp)
#endif
   return 1;
  else
   return 0;
 }
}
void ui_read(void*what, u16 size)
{
 if (fileptr)
 {
  memcpy(what, fileptr, size);
  fileptr += size;
 }
 else
 {
#if defined(OSCAR64)
  krnio_read(lfn_command, what, size);
#else
  FREAD(what, size);
#endif
 }
}
void ui_room_gfx_update()
{
 u8 memval=0x37-3;
 REFRESH
#if img_fileformat==16
 {
  if (ui_openimage())
   {
     u16 size,bsize,x,y;
     u16 head[5];
     u8* cache;
     u8  backup;

     ui_read(&head,sizeof(head));
     cache = ADDR(0xCFFF) - head[0];

     //FREAD(&bsize,sizeof(bsize));    
     //FREAD(&size,sizeof(size));
     ui_read(cache,head[2] + head[4]);

     if (slowmode)
      {
       ui_clear();
       memset(video_ram + status_y * 40,160,40);
       ui_image_fade();
      }

     backup = *ADDR(0x0001);
     *ADDR(0x0001) = memval;
     if (head[1] == head[2])
      memcpy(VIDEOMEM,cache,head[1]);
     else
      hunpack(cache,VIDEOMEM);
     *ADDR(0x0001) = backup;

     //FREAD(&bsize,sizeof(size));    
     //FREAD(&size,sizeof(size));
     //FREAD(cache,size);   

     // ---backup=*ADDR(0x0001);
     // --- *ADDR(0x0001)=memval;
     y = 0;
     x = 0;
     while (x < head[3])
     {
      u8 c = cache[head[2] + x++];
      video_colorram[y++] = c & 0x0F;
      video_colorram[y++] = (c & 0xF0) >> 4;
     }
     // ---*ADDR(0x0001)=backup;

     ui_read(&bsize,sizeof(size));
     x = 0;
     while (x < bsize)
     {
      ui_read(&size,sizeof(size));
      ui_read(cache,size);

      backup = *ADDR(0x0001);
      *ADDR(0x0001) = memval;
      if ((size == bsize - x) || (size == head[0]))
       memcpy(bitmap_image + x,cache,size);
      else
       hunpack(cache,bitmap_image + x);
      *ADDR(0x0001) = backup;
#if defined(EMUL)
      if(slowmode==1)
       REFRESH
#endif
      x += head[0];
     }

     //clean(memval);
     if (fileptr)
      fileptr = NULL;
     else
     {
#if defined(OSCAR64)
      krnio_close(lfn_command);
#else
      fclose(fp);
#endif
     }
   }
  else
   ui_image_clean();
 }
#else
 if(imagemem)
  {
   m_bitmap_w=*(u16*)(imagemem+0);   
   m_bitmap_h=*(u8*)(imagemem+2);
   m_bitmap_oy=*(u8*)(imagemem+5);
   m_bitmap_ox=*(u16*)(imagemem+3);
      
   m_bitmapscrcol=imagemem+14+*(u16*)(imagemem+8);
   m_bitmapcol=imagemem+14+*(u16*)(imagemem+10);
   m_bitmap=imagemem+14+*(u16*)(imagemem+12);
   
   ui_image_draw();
  }
 
 if(rightactorimg!=meta_none)
  {
   /*m_bitmapscrcol=itembitmap02_screencol;
   m_bitmapcol=itembitmap02_col;
   m_bitmap=itembitmap02_bitmap;
   m_bitmap_h=itembitmap02_h;
   m_bitmap_w=itembitmap02_w;  
   m_bitmap_ox=8;
   m_bitmap_oy=8;*/

   ui_image_draw();
  }
 if(leftactorimg!=meta_none)
  {
   /*m_bitmapscrcol=itembitmap01_screencol;
   m_bitmapcol=itembitmap01_col;
   m_bitmap=itembitmap01_bitmap;
   m_bitmap_h=itembitmap01_h;
   m_bitmap_w=itembitmap01_w;  
   m_bitmap_ox=320-itembitmap01_w-8;
   m_bitmap_oy=8;*/

   ui_image_draw();
  }
#endif   
}
#endif

void execute()
{
#if defined(WIN32)
 cmdlog_addcmd(strcmd);
#endif
 cr();
 
 str=strcmd;
 adv_parse();
 
 icmd=0;strcmd[icmd]=0;
 parser_update();
}

void room_load()
{
 while(1)
 {
 cmd=vrb_onleave;obj1=255;adv_run();

 room=newroom;
 os_roomimage_load(); 

 executed=0;
 if((roomattr[room]&1)==0)
  {
   roomattr[room]|=1;
   cmd=vrb_onfirst;
   obj1=255;adv_run();
  }
 if(executed==0)
  {
   cmd=vrb_onenter;
   obj1=255;
   adv_run();
  }
  adv_onturn();
  if(nextroom!=meta_nowhere)
  {
   newroom=nextroom;
   nextroom=meta_nowhere;
  }
  else
   break;
 }
}