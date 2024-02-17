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
// game data, built by the script compiler
// -----------------------------
#if defined(USE_BUILTINCARTRIDGE)
#else
#include "storytllr64_data.h"
#endif

// -----------------------------
// ui coordinates
// -----------------------------

#if defined(TARGET_ZXSPECTRUM)
#define split_y 64
#define status_y 8
#else
#define split_y screen_splity
#if defined(TARGET_GENERIC)
#define status_y ((split_y/8))
#else
#define status_y ((split_y/8)+1)
#endif
#endif
#define text_ty  (status_y+1)
#define text_stoprange (SCREEN_H-text_ty)

#define TVIDEORAM_OFFSET (text_ty*40)
#define TVIDEORAM_SIZE   (1000-TVIDEORAM_OFFSET)

#define CHANGES

// -----------------------------
// special characters
// -----------------------------

#define FAKE_CARRIAGECR 31
#define ESCAPE_CHAR     92

// -----------------------------
// GLOBALS
// -----------------------------
// most of variables are here
// I don't use parameters or locala
// if I can avoid them to optimize
// CC65 work
// -----------------------------
u8*txt,*etxt;
u8 txt_x,txt_y,txt_col,txt_rev,txt_wrap;
u8 text_y=0,text_x=0;
u8 _ch,_bch,al;
// -----------------------------
u8 room=meta_nowhere,nextroom=meta_nowhere,newroom,quit_request=0,text_attach,text_continue;
u8 rightactorimg=meta_none,leftactorimg=meta_none;
// -----------------------------
#define kind_none 0
#define kind_obj  1
#define kind_room 2
u8 cmd,obj1,obj2,obj1k,obj2k;
u8 clearfull;
u8*str,*ostr,*strcmds;
u16*strdir;
u8 strid,_strid;
u8 ch,imageid,curimageid=255;
u8*imagemem;
u16 i,j,ii,freemem;
u8 cmdid,fail,opcode,thisopcode,var,varobj,varroom,varmode,varattr,saved,a,b;
// -----------------------------
u8  key,len,in,istack=0,thisobj,thatobj,used;
u8 *pcode;
u16 pcodelen;
u8  executed;
u8  ormask[8]={1,2,4,8,16,32,64,128},
    xormask[8]={255-1,255-2,255-4,255-8,255-16,255-32,255-64,255-128};
// -----------------------------

 
// -----------------------------
// PROTOTYPES
// -----------------------------
void room_load();
void adv_run();
void os_roomimage_load();
void os_core_roomimage_load();
void core_drawtext();
void core_drawscore();
void cr();
void ui_text_write(u8*text);
void ui_waitkey();
void ui_getkey();
void ui_clear();
void ui_cr();
void ui_room_update();
u8   adv_save();

#define ch_sep 124

/*void _gettmp()
{
 i=0;
 while(*ostr&&(*ostr!=' '))
  if(i<32)
   tmp[i++]=*ostr++;
  else
   ostr++;
 tmp[i]=0;
}*/

void _getstring()
{
 _strid=0;
 ostr=str;
 while(_strid<strid)
 {
  len=*str++;  
  if(len==255)
   {
    len=*str++;
    str+=255;
   } 
  str+=len; 
  _strid++;
  ostr=str;
 } 
len=*ostr++; 
etxt=ostr+len;
if(len==255)
 {
  len=*ostr++; 
  etxt+=1+len;
 }
_bch=0;
}

void _findstring()
{
 cmdid=0;i=0;
 if(strdir)
  if(ostr[0]<26)
   i=strdir[ostr[0]];
  /*else
   i=0xFFFF;*/
 if(i==0xFFFF)
  ;
 else
  while(str[i])
   {
    len=str[i++];   
    if(str[i]==ostr[0])
     {
      if((ostr[len]==0)||(ostr[len]==' '))
       if(memcmp(ostr,str+i,len)==0)
        {
         memcpy(tmp,str+i,len);tmp[len]=0;
         i+=len;ostr+=len;
         cmdid=str[i];
         if(cmdid==255)
          {
           i++;
           len=str[i++];         
           while(len--)
            {
             if(str[i++]==room)
              {cmdid=str[i];break;}
             cmdid=str[i++];
            }
          }       
         return;
        } 
     }
    else
     if(strdir)
      break;
    i+=len; 
    if(str[i]==255)
     {
      i++;
      i+=(str[i]<<1);
      i++;
     }
    else
     i++;
   }
 i=0;
 while(*ostr&&(*ostr!=' '))
  if(i<32)
   tmp[i++]=*ostr++;
  else
   ostr++;
 cmdid=255;
}

void draw_roomobj()
{
 u8 i,k,c; 
 al=0;txt=tmp2;
 for(k=c=i=0;i<obj_count;i++)
  if(objloc[i]==varroom)
   if((objattr[i]&varattr)==varattr)
    {     
     strid=objnameid[i];
     if(strid==255)
      ;
     else
      { 
       str=advnames;     
       _getstring();
       k=0;
       if(c)
        {
         txt[k++]=',';
         txt[k++]=' ';
        }
       while(ostr<etxt)
        txt[k++]=*ostr++;
       txt[k]=0;
       txt_col=COLOR_WHITE;
       core_drawtext();
       // tmp2[k++]=ESCAPE_CHAR;     
       // tmp2[k++]='w'-'a'+1;
       c++;
      }
    }
 if(c==0)
 {
 }
 else
  {
   k=0;
   txt[k++]='.';
   txt[k++]=0;
   txt_col=COLOR_WHITE;
   core_drawtext();
   text_y=txt_y-text_ty;
   text_attach=0;
   cr();
  } 
}

void _alignattr()
{
varroom=room;varobj=thisobj;
}
void _getattrstrid()
{
 var = pcode[i++]; strid = 255;
 switch(var&0x3f)
  {
   case metaattr_name:
    str=advnames;text_continue=1;
    if(var&metaattr_obj)
     strid=objnameid[varobj];
    else
     strid=roomnameid[varroom];
   break;
   case metaattr_desc:
    str=advdesc;
    if(var&metaattr_obj)
     strid=objdescid[varobj];
    else
     strid=roomdescid[varroom];
   break;
   default:
    if(var&metaattr_obj)
     {
      txt=objattrex;
      varmode=varobj;
     }
    else
     {
      txt=roomattrex;    
      varmode=varroom;
     }
    if(txt==NULL)
     strid=255;
    else
     {
      varattr=var&0x3f;
      while(1)
       {
        a=*txt++;
        if(a==255)
         break;
        if(varattr==(a&0x7f))
         if(a&0x80)
          {
           txt++;
           strid=txt[varmode];
           break;
          }
         else
          {
           txt++;
           while (a--)
            {
             a = *txt++;
             b = *txt++;
             if (varmode == a)
             {
              strid = b;
              break;
             }
            }
           break;
          }
        else
         {
          b=*txt++;
          if(a&0x80)
           txt+=b;
          else
           {
            txt+=b;
            txt+=b;
           }
         }
       }
      varmode=0;
      if(a!=255)
       {str=advdesc;text_continue=1;}
     }
  }
}

void _getobj()
{
 var=pcode[i++];       
 switch(var)
 {
  case meta_this:
   var=obj1;
   break;
  case meta_that:
   var=obj2;
  break;
  case meta_here:
   var=room;
  break;
  case meta_oneofroom:
  case meta_oneofobj:
   {
    ch=pcode[i++];
    myrand();
    var=pcode[i+(rnd_a%ch)];
    i+=ch;
   }
  break;
  case meta_any:
  case meta_available:
  break;
  default:
   if(varmode)
    {
     var=vars[var];
     varmode=0;
    }
 }
}

// -----------------------------
// OPCODES PLAYER
// -----------------------------

/*u16 stack_i;
u8  stack_used,stack_istack,stack_fail,stack_thisopcode;

void adv_gosub()
{
 stack_thisopcode=thisopcode;stack_i=i;stack_used=used;stack_istack=istack;stack_fail=fail;

 adv_run();

 thisopcode=stack_thisopcode;
 pcode=opcode_data+opcode_pos[thisopcode];
 pcodelen=opcode_len[thisopcode];
 i=stack_i;
 used=stack_used;
 istack=stack_istack;
 fail=stack_fail;
}*/

void adv_exec()
{ 
 used=istack=fail=in=0;thisopcode=opcode;
 thisobj=obj1;
 i=0;
 while(i<pcodelen) 
  {     
   opcode=pcode[i++];
   if(opcode==op_endwith)
    break;
   if(opcodeattr[opcode-128]&128)
    {
     used++; 
     switch(opcode)
      {
     case op_msgattr:
     case op_msgvarattr:
      if(opcode==op_msgattr)
       _alignattr();
      else
       {     
        varmode=1;_getobj();
        varroom=var;varobj=varroom;
       }
      _getattrstrid();
      if(strid==255)
       {
         /*if(var==meta_roomdesc)
         {
          cmd=vrb_ondesc;
          adv_gosub();
         }
         else*/
        fail=1;
       }
      else
       {
         _getstring();
         ui_text_write(ostr);       
       }
      break;

     case op_msgroom:
     case op_msgobj:
      {
       strid=pcode[i++];
       strid=vars[strid];      
       str=advnames;
       if(opcode==op_msgobj)
        strid=objnameid[strid];
       else
        strid=roomnameid[strid];
       _getstring();
       ui_text_write(ostr);
      }
      break;
     case op_msgvar:
      {
       strid=pcode[i++];
       strid=vars[strid];
       ch=0;
       if(strid>99)
        {tmp[ch++]='0'+strid/100;strid%=100;}
       if(strid>9)
        {tmp[ch++]='0'+strid/10;strid%=10;}
       tmp[ch++]='0'+strid;
       tmp[ch]=0;
       ostr=tmp;etxt=ostr+ch;
       ui_text_write(ostr);
      }
      break;
     case op_msg:
     case op_msg2:
      {
       var=pcode[i++];
       if(opcode==op_msg2)
        str=msgs2;
       else
        str=msgs;
       strid=var;
       if(strid==255)
        fail=1;
       else
        {
        _getstring();
        ui_text_write(ostr);       
        }
      }
     break;

     case op_quit:
       quit_request=1;
     break;
     case op_start:
      quit_request=2;
     break;
     case op_load:
      #if !defined(USE_DISKSAVE)
      if(saved) 
      #endif
       quit_request=3;
     break;
     case op_save:
      *roomstart=room;
      adv_save();
      saved++;
     break;
     case op_gfxmode:
      {       
       var=pcode[i++];  
       slowmode=var;
      }
     break;
     case op_dbg:
      {       
       mini_itoa(freemem,(char*)tmp);       
       ostr=tmp;
       ui_text_write(ostr);       
      }
     break;
     case op_clear:
      ui_clear();
     break;
     case op_getkey:
      ui_getkey();
      key=ch;     
     break;
     case op_waitkey:
      ui_waitkey();
     break;
     case op_showobj:
      rightactorimg=pcode[i++];
      ui_room_update();
     break;
     case op_goto:
      nextroom=pcode[i++];       
     break;
     case op_setattr:
     case op_unsetattr:
      {
       _getobj();varobj=var;
       var=pcode[i++];    
       switch(opcode)
        {
         case op_unsetattr:
          objattr[varobj]&=(0xFF-var); CHANGES
         break;
         case op_setattr:
          objattr[varobj]|=var; CHANGES
         break;
        }
      }
     break;
     case op_setroomoverlayimage:
      _getobj();varroom=var;
      var=pcode[i++];
      //roomimg[varroom]=var;
      roomovrimg[varroom]=var; CHANGES
      os_roomimage_load();
     break;
     case op_setroomimage:
      _getobj();varroom=var;
      var=pcode[i++];
      roomimg[varroom]=var; CHANGES
      os_roomimage_load();
     break;
     case op_setcount:
      _getobj();varobj=var;
      _getobj();varroom=var;
      varattr=pcode[i++];
      var=ch=0;
      while(ch<obj_count)
       {
        if((objloc[ch]==varroom)&&((objattr[ch]&varattr)==varattr))
         var++;
        ch++;
       }
      vars[varobj]=var;
     break;
     case op_list:
      _getobj();varroom=var;
      varattr=pcode[i++];
      draw_roomobj();              
     break;
     case op_put:
      {
       _getobj();varobj=var;
       _getobj();varroom=var;
       objloc[varobj]=varroom; CHANGES
      }
     break;
     case op_set:
     case op_unset: 
      varobj=pcode[i++];       
      var=varobj>>3;
       if(opcode==op_set)
        bitvars[var]|=ormask[varobj&0x7]; CHANGES
       else
        bitvars[var]&=xormask[varobj&0x7]; CHANGES
     break;
     case op_addscore:
       varobj=pcode[i++];       
       var=varobj>>3;
       varattr=bitvars[var]&ormask[varobj&0x7];
       if(varattr==0)
        {
         bitvars[var]|=ormask[varobj&0x7]; CHANGES
         vars[0]++; CHANGES
         core_drawscore();
        }
      break;
     case op_addvar:
     case op_decvar:
     case op_setvar:
      varobj=pcode[i++];     
      _getobj();
      switch(opcode)
       {
        case op_addvar:
         vars[varobj]+=var; CHANGES         
        break;
        case op_decvar:
         vars[varobj]-=var; CHANGES         
        break;
        case op_setvar:
         vars[varobj]=var; CHANGES
        break;
       }
      break;
      default:
       fail=1;
     }
    }
   else  
    {
     switch(opcode)
     {
      case op_else:
        var=0;
        while(i<pcodelen)
        {
         if((pcode[i]>=op_if)&&(pcode[i]<=op_ifvar))
          var++;
         else
         if(pcode[i]==op_endif)
          if(var)
           var--;
          else
           break;
         else
          if(pcode[i]==op_endwith)
           break;
         ch=pcode[i];
         i+=opcodeattr[ch-128]&0x7f;
        }
      break;
      case op_endif:
      break;
      case op_ifkey:
       var=pcode[i++];            
       if(var!=key)
        fail=3;
      break;
      // attr
      case op_ifis:
       _getobj();varobj=var;
       var=pcode[i++];    
       if(varobj==meta_none)
        fail=3;
       else
       if((objattr[varobj]&var)!=var)
        fail=3;
      break;
      case op_ifisin:
      case op_needin:
      case op_ifobjinattr:
       {
        _getobj();varobj=var;
        _getobj();varroom=var;
        switch(opcode)
         {
          case op_ifobjinattr:
           varattr=pcode[i++];
          if(varobj==meta_any)
           {
            ch=0;
            while(ch<obj_count)
             if(objnameid[ch]==255)
              ch++;
             else
              if((objloc[ch]==varroom)&&((objattr[ch]&varattr)==varattr))
               break;
              else              
               ch++;
            if(ch==obj_count)
             fail=3;
           }
          else
          if((objloc[varobj]!=varroom)||((objattr[varobj]&varattr)!=varattr))
           fail=3;
          break;
         case op_needin:
         case op_ifisin:
          if(varobj==meta_any)
           {
            ch=0;
            while(ch<obj_count)
             if(objloc[ch]==varroom)
              break;
             else
              ch++;
            if(ch==obj_count)
             fail=3;
           }
          else
          if(varroom==meta_available)
           {
            if(objloc[varobj]==meta_inventory)
             ;
            else
             if((objloc[varobj]==room)&&(objattr[varobj]&attr_visible))
              ;
             else
              fail=3;
           }
          else
          if(objloc[varobj]!=varroom)
           fail=3;          
          break;
         }
        if((opcode==op_needin)&&fail)
         i=pcodelen;
       }
      break;           
      case op_ifisaroom:
       var=pcode[i++];
       if((var==meta_this)&&(obj1k==kind_room))
        ;
       else
       if((var==meta_that)&&(obj2k==kind_room))
        ;
       else
        fail=3;
      break;
      case op_ifundef:
       _alignattr();
       _getattrstrid();
       text_continue=0;
       if(strid!=255)
        fail=3;
      break;
      case op_ifisroom:
       var=pcode[i++];
       if(var!=room)
        fail=3;
      break;
      case op_withobj:
       in++;
       if(in>1)
        {
         thatobj=var=pcode[i++];
         if(var!=obj2)
          if(obj2==meta_none)
           if(var==meta_unknown)        
            ;
           else 
            fail=2;
          else
           if(var==meta_every)
            thisobj=obj2;
           else
            fail=2;
        }
       else
       {
        thisobj=var=pcode[i++];
        if(var!=obj1)
         if(obj1==meta_none)
          if(var==meta_unknown)        
           ;
          else 
           fail=2;
         else
          if(var==meta_every)
           thisobj=obj1;
          else
           fail=2;
        }
      break;          
      case op_if:
      case op_ifnot:
       varobj=pcode[i++];     
       var=varobj>>3;
       var=bitvars[var]&ormask[varobj&0x7];
       if(opcode==op_if)
        {
         if(var==0)
          fail=3;
        }  
       else
        if(var)
         fail=3;
      break; 
      case op_ifvar:
       varattr=pcode[i++];
       varmode=varattr&0x40;_getobj();varobj=var;
       varmode=varattr&0x80;_getobj();varroom=var;       
       switch(varattr&0x3f)
        {
         case varcmp_equal:
          if(varobj!=varroom)
           fail=3;
         break;
         case varcmp_different:
          if(varobj==varroom)
           fail=3;
         break;
         case varcmp_greater:
          if(varobj<=varroom)
           fail=3;
         break;
         case varcmp_less:
          if(varobj>=varroom)
           fail=3;
          break;
        }
      break;
      default:
       fail=1;
     }     
    if(fail)
     {
      if(fail==2)
       {
        u8 m=0;
        while(i<pcodelen) 
         {
          ch=pcode[i];
          if(ch==op_endwith)
           if(m)
            m--;
           else
            break;
          else
          if(ch==op_withobj)
           m++;
          if(ch>=128)
           i+=opcodeattr[ch-128]&0x7f;
          else
           break;
         }
        i++;
        if(pcode[i-1]==op_endwith)
         {fail=0;in--;}
        if(fail)
         break;
       }
      else
      if(fail>2)
       {        
        istack++;
        while((i<pcodelen)&&(pcode[i]!=op_endwith)) 
         {
          ch=pcode[i];
          if((ch>=op_ifstart)&&(ch<=op_ifend))
           istack++;
          else
           if(ch==op_else)
            {
             if(istack==1)
              {
               fail=istack=0;
               break;
              }
            }
           else
           if(ch==op_endif)
            if(istack==1)
              {
               if((i+1==pcodelen)&&(used==0))
                ;
               else
                fail=istack=0;
               break;
              }
            else
            if(istack==0)
             break;
            else
             istack--;
          if(ch>=128)
           i+=opcodeattr[ch-128]&0x7f;
          else
           break;
         }
        i++;
        if(pcode[i-1]==op_endwith)
         {fail=0;in--;}
        if(fail)
         break;
       }
      else
       break;
     }
    }
  }
 if((fail==0)&&used)
  executed=1;
 else
  executed=0;
}

// -----------------------------
// USER INPUT HANDLING
// -----------------------------

void adv_run()
{   
 u8  theroom;
 u16 i,ei;
 theroom=room;executed=0;
 if(cmd>opcode_vrbidx_count)
  cmd=opcode_vrbidx_count;
 i=opcode_vrbidx_dir[cmd];
 ei=opcode_vrbidx_dir[cmd+1];
 while(i<ei)
  { 
   varroom=opcode_vrbidx_data[i++];    
   if((varroom==theroom)||(varroom==meta_everywhere))
    {
     opcode=opcode_vrbidx_data[i++];
     pcode=opcode_data+opcode_pos[opcode];
     pcodelen=opcode_len[opcode];
     adv_exec();
     if(executed)
      break;
    }
   else
    i++;
  }
}

void adv_onturn()
{
 cmd = vrb_onturn; obj1 = 255; adv_run();
}

void adv_parse()
{
 ostr=str;
 cmd=meta_unknown;obj1=obj2=meta_none,obj1k=obj2k=kind_none;
 while(*ostr&&(*ostr==' ')) ostr++;
 if(*ostr)
  {
   u8*bostr;
   while(*ostr)
   {
    strdir=NULL;
    if(cmd==meta_unknown)
     str=verbs;
    else
     {str=objs;strdir=objs_dir;}
    bostr = ostr;
    _findstring();
    if(cmdid!=255)
     {
      if(cmd==meta_unknown)
       {
        cmd=cmdid;
        strncpy((char*)vrb,(char*)tmp,VRBLEN-1);
       } 
      else
       if(obj1k==kind_none)
        {obj1=cmdid;obj1k=kind_obj;}
       else
        if(obj2k==kind_none)
         {obj2=cmdid;obj2k=kind_obj;}
     }
    else
     if(cmd!=meta_unknown)
      {
       ostr=bostr;
       str=rooms;strdir=NULL;
       _findstring();
       if(obj1k==kind_none)
        {
         if(cmdid!=255)
          {obj1=cmdid;obj1k=kind_room;}
         else
         if(obj1==meta_none)
          obj1=meta_unknown;
        }
       else
        if(obj2k==kind_none)
         if(cmdid!=255)
          {obj2=cmdid;obj2k=kind_room;}
      }
    while(*ostr&&(*ostr==' ')) ostr++;
   }
   adv_run();

   adv_onturn();

   if(nextroom!=meta_nowhere)
    {
     newroom=nextroom;nextroom=meta_nowhere;
     room_load();
    }

  }
}

// -----------------------------
// GAME RESET/LOAD/START
// -----------------------------

void irq_attach();
void irq_detach(u8 mode);

void adv_reset()
{
#if defined(USE_ORIGRAM)
 hunpack(origram,objattr);
#else
 memcpy(objattr,GAMEORIGAREA,origram_len);
#endif
}

u8 adv_save()
{
#if defined(USE_DISKSAVE)
 u8 ret;
 #if !defined(USE_HIMAGE) 
 irq_detach(0); 
 #endif
 if(disk_save(FILENAME("save"),objattr,origram_len)==0)
  {
   vid_setcolorBRD(COLOR_RED);
   REFRESH
   vid_setcolorBRD(COLOR_BLACK);
   ret=0;
  }
 else
  ret=1;
 #if !defined(USE_HIMAGE) 
 irq_attach(); 
 #endif
 return ret;
#else
  memcpy(loadram,objattr,origram_len);
  return 1;
#endif
}

u8 adv_load()
{
 #if defined(USE_DISKSAVE) 
 u8 ret;
 #if !defined(USE_HIMAGE) 
 irq_detach(0);
 #endif
 if(disk_load(FILENAME("save"),objattr,origram_len)==0)
  {
   vid_setcolorBRD(COLOR_RED);
   REFRESH
   vid_setcolorBRD(COLOR_BLACK);
   ret=0;
  }
 else
  ret=1;
 #if !defined(USE_HIMAGE) 
 irq_attach();
 #endif
 return ret;
 #else
 memcpy(objattr,loadram,origram_len);
 return 1;
 #endif
}

void adv_start()
{
 clearfull=1;ui_clear();
 newroom=*roomstart;
 room_load();
}