#define MASK_FWDDEF (0<<6)
#define MASK_FWD    (1<<6)
#define MASK_BCK    (2<<6)
#define MASK_PLAIN  (3<<6)

//#define USE_PACKEDFWD

//#define HUPACK_USETOPFREQ 
//#define HUPACK_USEBIGRAMS

#define headmask_topfreq 128
#define headmask_bigrams 64

int hpack_usedef=0;
u8  master[4]={0,0,0,0},hpack_defval=0;

#if defined(IMPLEMENT_C_HBUNPACK)

#if !defined(WIN32)

extern u8* asm_src;
extern u8* asm_dst;
void fastcall asm_hunpack(void);

void hunpack(const u8*pbuf,u8*buf)
{
 asm_src=(u8*)pbuf;
 asm_dst=buf;
 asm_hunpack();
}
#else

u8 hb_what,hb_len;
u16 hunpack(u8*buf,u8*pbuf)
{
 u16 i=0,j=0;
 u8*tbuf,best=0; 
 if(hpack_usedef>1)
  best=buf[i++];
 #if defined(HUPACK_USETOPFREQ)||defined(HUPACK_USEBIGRAMS)
 u8  head=buf[i++];
 u16 bigr[4];
 if(head&headmask_topfreq)
  {best=buf[i++];}
 if(head&headmask_bigrams)
  {
   head&=0x3;
   memcpy(&bigr[0],&buf[i],head*sizeof(bigr[0]));
   i+=head*sizeof(bigr[0]);
  }
 #endif

 while(buf[i])
  {
   hb_what=buf[i++];
#if defined(USE_PACKEDFWD)
   if((hb_what&(MASK_FWD|32))==(MASK_FWD|32))
    {
     hb_len=((hb_what>>2)&0x7)+2;
     hb_what=pbuf[j-((hb_what&3)+1)];       
     while(hb_len--)
      pbuf[j++]=hb_what;
     continue;
    }
   else
    {
     hb_len=hb_what&0x1F;
     if(hb_len==31)
      hb_len=buf[i++];
    }
#else
   {
    hb_len=hb_what&0x3F;
    if(hb_len==63)
     hb_len=buf[i++];
   }
#endif
   hb_what=hb_what&MASK_PLAIN;
      
   if(hb_what==MASK_PLAIN)
    {     
     while(hb_len--)
      pbuf[j++]=buf[i++];
    }
   else 
   if(hb_what==MASK_BCK)
    {
     hb_what=buf[i++];
     tbuf=pbuf+j-hb_what;
     while(hb_len--)
      pbuf[j++]=*tbuf++;
    }
   else 
   if(hb_what==MASK_FWD)
    {
     hb_what=buf[i++];
     while(hb_len--)
      pbuf[j++]=hb_what;
    }
   else 
   if(hb_what==MASK_FWDDEF)
    {
     #if defined(HUPACK_USEBIGRAMS)
     memcpy(&pbuf[j],&bigr[hb_what],sizeof(bigr[0]));
     j+=sizeof(bigr[0]);
     #else
     hb_what=best;
     while(hb_len--)
      pbuf[j++]=hb_what;
     #endif
    }
  }
 return j; 
}
#endif

#else
u16 hunpack(u8*buf,u8*pbuf);
#endif

#if defined(IMPLEMENT_C_HBPACK)

#define maxscan    256
#define maxscanfwd 63
#define plainrun   255

u8 scanfwd(u8*buf,u16 i,u16 hm,u8*w)
{
 u8 ll=1;
 while((ll<maxscanfwd)&&(i+ll<hm)&&(buf[i]==buf[i+ll]))
  ll++;
 if(w) *w=buf[i];
 if(ll>2)
  return ll;  
 else
  if(hpack_usedef&&(ll>1)&&(buf[i]==master[0]))
   return ll;  
  else
  if((hpack_usedef>2)&&(ll>1)&&(buf[i]==master[1]))
   return ll;  
  else
  if((hpack_usedef>3)&&(ll>1)&&(buf[i]==master[2]))
   return ll;  
  else
  if((hpack_usedef>4)&&(ll>1)&&(buf[i]==master[3]))
   return ll;  
  else
   return 0; 
}

u8 scanbck(u8*buf,u16 i,u16 hm,u8*w)
{
 int ii,jj,blen=0,bpos=-1;
 u8 ch=buf[i];
 for(ii=max(0,i-maxscan);ii<i;ii++)
  if(buf[ii]==ch)
   for(jj=3;jj<maxscanfwd;jj++)
    if((i-ii<maxscan)&&(ii+jj<i)&&(i+jj<hm))        
     if(memcmp(buf+ii+1,buf+i+1,jj-1)==0)
      if(jj>=blen)
       {
        bpos=ii;
        blen=jj;
       }
 if(w) *w=(u8)(i-bpos);     
 return (u8)blen;  
}

int emitplain(u8*out,u8*in,u16 len)
{
 int l=0,i;
 while(len)
  {
   int llen=min(len,255);
#if defined(USE_PACKEDFWD)
   if(llen<31)
    out[l++]=MASK_PLAIN|llen;
   else
    {
     out[l++]=MASK_PLAIN|31;
     out[l++]=llen;
    }
#else
   if(llen<63)
    out[l++]=MASK_PLAIN|llen;
   else
    {
     out[l++]=MASK_PLAIN|63;
     out[l++]=llen;
    }
#endif
   for(i=0;i<llen;i++)
    out[l++]=in[i];
   len-=llen;in+=llen; 
  }  
 return l;
}

int emitcodedef(u8*out,u8 mask,u8 fwd,u8 code)
{
 int l=0;
#if defined(USE_PACKEDFWD)
 if(fwd<31)
  out[l++]=mask|fwd;
 else
  {
   out[l++]=mask|31;
   out[l++]=fwd;
  }  
#else
 if(hpack_usedef<=2)
  {
   if(fwd<63)
    out[l++]=mask|fwd;
   else
    {
     out[l++]=mask|63;
     out[l++]=fwd;
    }
  }
 else
  {
   if(fwd<16)
    out[l++]=mask|(code<<4)|fwd;
   else
    {
     out[l++]=mask|(code<<4)|15;
     out[l++]=fwd;
    }  
  }
#endif
 return l;
}

int shorter=0;
int emitcode(u8*out,u8 mask,u8 fwd,u8 code)
{
 int l=0;
 /*if(mask==MASK_FWDDEF)
  {
   out[l++]=mask|(code<<2)|fwd;
  }
 else*/
 if((fwd<8)&&(code<4))
  shorter++;
#if defined(USE_PACKEDFWD)
 if(mask&MASK_FWD)
  {
  if(mask&32)
   // 2 = FWD | 1 = FWDPCK | 3 | 2
   out[l++]=mask|((fwd-2)<<2)|(code-1);
  else
  if(fwd<31)
   {
    out[l++]=mask|fwd;
    out[l++]=code;
   }
  else
   {
    out[l++]=mask|31;
    out[l++]=fwd;
    out[l++]=code;
   }  
  }
 else
  if(fwd<31)
  {
   out[l++]=mask|fwd;
   out[l++]=code;
  }
 else
  {
   out[l++]=mask|31;
   out[l++]=fwd;
   out[l++]=code;
  }  
#else
 if(fwd<63)
  {
   out[l++]=mask|fwd;
   out[l++]=code;
  }
 else
  {
   out[l++]=mask|63;
   out[l++]=fwd;
   out[l++]=code;
  }  
#endif
 return l;
}

typedef struct{
 u8  seq[2];
 u16 cnt;
}bigram;
typedef struct{
 short  seq;
 u16 cnt;
 u16 codelen;
 short left,right;
}mono;

int bigram_compare(const void*a,const void*b)
{
 bigram*A=(bigram*)a;
 bigram*B=(bigram*)b;
 return B->cnt-A->cnt;
}

int mono_compare(const void*a,const void*b)
{
 mono*A=(mono*)a;
 mono*B=(mono*)b;
 return B->cnt-A->cnt;
}

int mono_compareseq(const void*a,const void*b)
{
 mono*A=(mono*)a;
 mono*B=(mono*)b;
 return A->seq-A->seq;
}

int pmono_compare(const void*a,const void*b)
{
 mono**A=(mono**)a;
 mono**B=(mono**)b;
 return (*B)->cnt-(*A)->cnt;
}

u16 emitnibble(u8*buf,u16 j,u8 nib)
{
 if(j&1)
  buf[j>>1]|=(nib<<4);
 else
  buf[j>>1]=nib;
 j++;
 return j;
}

u16 getnibble(u8*buf,u16 j,u8*nib)
{
 if(j&1)
  *nib=buf[j>>1]>>4;
 else
  *nib=buf[j>>1]&0xF;
 j++;
 return j;
}

int code(mono*queue,int root,int depth)
{
 int err=0;
 queue[root].codelen=depth;
 if((queue[root].left<0)||(queue[root].left>511))
  err++;
 else
  code(queue,queue[root].left,depth+1);
 if((queue[root].right<0)||(queue[root].right>511))
  err++;
 else
  code(queue,queue[root].right,depth+1);
 return 1;
}
int hhpack(u8*buf,u16 hm,u8*pbuf)
{
 u8     check[8192];
 mono   mo[256+255];
 mono  *pmo[256];
 u16    freq[256],ret=0,root=0,bit=0;
 u16     iim=0,im=0;
 u16    i,j=0,n,packed=0,err=0;
 memset(freq,0,sizeof(freq));
 for(i=0;i<hm;i++)
  freq[buf[i]]++;
 for(i=0;i<256;i++)
  if(freq[i])
   {
    mo[im].left=mo[im].right=-1;
    mo[im].seq=i;mo[im].cnt=freq[i];im++;
   } 
 for(i=0;i<im;i++)
  pmo[i]=&mo[i];
 qsort(pmo,im,sizeof(pmo[0]),pmono_compare);    
 iim=im;
 while(iim>1)
  {
   im++;
   mo[im].cnt=pmo[iim-1]->cnt+pmo[iim-2]->cnt;
   mo[im].seq=32727;
   mo[im].left=pmo[iim-1]-mo;
   mo[im].right=pmo[iim-2]-mo;
   iim-=2;
   pmo[iim++]=&mo[im];
   qsort(pmo,iim,sizeof(pmo[0]),pmono_compare);    
  }
 root=pmo[0]-mo;
 code(&mo[0],root,1);
 qsort(mo,im,sizeof(mo[0]),mono_compareseq);    
 for(i=0;i<hm;i++)
 {
  for(n=0;n<im;n++)
   if(mo[n].seq==buf[i])
   {
    bit+=mo[n].codelen;
    break;
   }
 }
 qsort(mo,im,sizeof(mo[0]),mono_compare);    
 for(i=0;i<12;i++)
  {
   packed+=mo[i].cnt;
   j=emitnibble(pbuf,j,mo[i].seq&0xF);
   j=emitnibble(pbuf,j,(mo[i].seq&0xF0)>>4);
  }
 i=0;
 while(i<hm)
  {
   u8 fwd=0,bck=0,bckln=0,bbck=0,bbckln=0;
   while((i+fwd+1<hm)&&(fwd<15))
    if(buf[i]==buf[i+fwd+1])
     fwd++;
    else
     break;
   while((i-bck-1>=0)&&(bck<15))
    if(buf[i]==buf[i-bck-1])
     {
      bckln=0;
      while(i-bck-1+(bckln+1)<i)
       if(buf[i+bckln+1]==buf[i-bck-1+(bckln+1)])
        bckln++;
       else
        break;
      if(bckln>bbckln)
       {
        bbck=bck;
        bbckln=bckln;
       }
      bck++;
     }
    else
     break;
   if((fwd>2)&&(fwd>bbckln))
    {
     for(n=0;n<12;n++)
      if(buf[i]==mo[n].seq)
       break;
     if(n==12)
      {
       j=emitnibble(pbuf,j,13);
       j=emitnibble(pbuf,j,fwd);
       j=emitnibble(pbuf,j,buf[i]&0xF);
       j=emitnibble(pbuf,j,(buf[i]&0xF0)>>4);
       i+=fwd;
      }
     else
      {
       j=emitnibble(pbuf,j,12);
       j=emitnibble(pbuf,j,fwd);
       j=emitnibble(pbuf,j,n);
       i+=fwd;
      }
    }
   else
   if(bbck>2)
    {
     j=emitnibble(pbuf,j,11);
     j=emitnibble(pbuf,j,bbck);
     j=emitnibble(pbuf,j,bbckln);
     i+=bbckln;
    }
   else
    {
     for(n=0;n<12;n++)
      if(buf[i]==mo[n].seq)
      {
       j=emitnibble(pbuf,j,n);
       break;
      }
     if(n==12)
      {
       j=emitnibble(pbuf,j,14);
       j=emitnibble(pbuf,j,buf[i]&0xF);
       j=emitnibble(pbuf,j,(buf[i]&0xF0)>>4);
      }
     i++;
    }
  }
 j=emitnibble(pbuf,j,15);
 if((j&1)==0)
  j++;
 ret=j/2;
 j=12*2;i=0;
 while(1)
 {
  u8 n,nn;
  j=getnibble(pbuf,j,&n);
  if(n==15)
   break;
  else
   switch(n)
   {
   case 12:
    {
     j=getnibble(pbuf,j,&nn);
     j=getnibble(pbuf,j,&n);
     while(nn--)
      check[i++]=pbuf[n&7];
    }
    break;
    case 13:
     {
      u8 b=0;
      j=getnibble(pbuf,j,&nn);
      j=getnibble(pbuf,j,&n);
      b|=n;
      j=getnibble(pbuf,j,&n);
      b|=n<<4;
      while(nn--)
       check[i++]=b; 
     }
    break;
    case 14:
     {
      u8 b=0;
      j=getnibble(pbuf,j,&n);
      b|=n;
      j=getnibble(pbuf,j,&n);
      b|=n<<4;
      check[i++]=b; 
     }
    break;
    default:
     check[i++]=pbuf[n&7];
   }
 }
 for(i=0;i<hm;i++)
  if(check[i]!=buf[i])
   err++;
 if(err)
  err=0;
 return ret;
}

#ifdef BIG
#define OUT_SIZE 2000000
#else
#define OUT_SIZE 65536
#endif /* BIG */
static unsigned char outBuffer[OUT_SIZE];
static int outPointer = 0;
static int bitMask = 0x80;
static int maxGamma = 7;


static void FlushBits(void)
{
 if (bitMask != 0x80)
  outPointer++;
}

static void PutBit(int bit)
{
 if (bit && outPointer < OUT_SIZE)
 	outBuffer[outPointer] |= bitMask;
 bitMask >>= 1;
 if (!bitMask)
  {
	  bitMask = 0x80;
	  outPointer++;
  }
}


void PutValue(int value)
{
 int bits = 0, count = 0;
 while (value>1)
  {
	  bits = (bits<<1) | (value & 1);	/* is reversed compared to value */
	  value >>= 1;
	  count++;
	  PutBit(1);
  }
 if (count<maxGamma)
	 PutBit(0);
 while (count--)
  {
  	PutBit((bits & 1));	/* output is reversed again -> same as value */
	  bits >>= 1;
  }
}

void PutNBits(int byte, int bits)
{
 while (bits--)
 	PutBit((byte & (1<<bits)));
}

int RealLenValue(int value)
{
 int count = 0;

 if (value<2)	/* 1 */
 	count = 0;
 else if (value<4)	/* 2-3 */
	 count = 1;
 else if (value<8)	/* 4-7 */
	 count = 2;
 else if (value<16)	/* 8-15 */
	 count = 3;
 else if (value<32)	/* 16-31 */
	 count = 4;
 else if (value<64)	/* 32-63 */
	 count = 5;
 else if (value<128)	/* 64-127 */
	 count = 6;
 else if (value<256)	/* 128-255 */
	 count = 7; 
 else
  count = 8;
 return count+1;
}

int hbpack(u8*buf,u16 hm,u8*pbuf)
{
 int i=0,j=0,le=0,safecheck=1,cnt=0,ibigr=0;
 u16 used[5]={0,0,0,0,0}; 
 u16 tlen[5]={0,0,0,0,0};
 u16 bigr[4]={0,0,0,0};
 #if defined(HUPACK_USETOPFREQ)
 hpack_usedef=0;
 #else
 hpack_usedef=1;
 #endif
 i=0;
 while(i<hm)
  {
   u8  wf,wb;
   u8  fwd=scanfwd(buf,i,hm,&wf);
   u8  bck=scanbck(buf,i,hm,&wb);
   if(safecheck&&(i-le==1)&&(((fwd>bck)&&(fwd==2))||((bck>fwd)&&(bck==2))))
    {
     #if defined(HUPACK_USEBIGRAMS)
     if((i+1<hm)&&ibigr)
      {
       int n;
       for(n=0;n<ibigr;n++)
        if(memcmp(&buf[i],&bigr[n],sizeof(bigr[n]))==0)
         {
          j+=emitcodedef(pbuf+j,MASK_FWDDEF,n,wf);
          used[1]++;
          if(fwd>tlen[1]) 
           tlen[1]=fwd;
          i+=2;
          break;
         }
       if(n==ibigr)
        i++;
      }
     else
     #endif
      i++;
    }
   else
   if(fwd+bck)
    {
     if(i>le)
      {j+=emitplain(pbuf+j,buf+le,i-le);used[0]++;if(i-le>tlen[0]) tlen[0]=i-le;}
     if(fwd>bck)
      {        
       int bj=j,n;
       if(hpack_usedef&&(wf==hpack_defval))
        {j+=emitcodedef(pbuf+j,MASK_FWDDEF,fwd,wf);used[1]++;if(fwd>tlen[1]) tlen[1]=fwd;}
       else
        {
         int ref=0;
         if(i&&(buf[i-1]==wf))
          ref=1;
         else
          if((i>1)&&(buf[i-2]==wf))
           ref=2;
          else
           if((i>2)&&(buf[i-3]==wf))
            ref=3;
           else
            if((i>3)&&(buf[i-4]==wf))
             ref=4;
         if(ref&&(fwd<8))
          j+=emitcode(pbuf+j,MASK_FWD|32,fwd,wf);
         else
          j+=emitcode(pbuf+j,MASK_FWD,fwd,wf);
         for(n=0;n<63;n++)
          {
           int pj=bj-n-(j-bj);
           if(pj>=0)
            if(memcmp(pbuf+pj,pbuf+bj,j-bj)==0)
            {
             cnt++;
             break;
            }
          }
         used[2]++;
         if(fwd>tlen[2]) 
          tlen[2]=fwd;
        }
       i+=fwd;
      } 
     else
      {
       int bj=j,n;
       /*if((bck<4)&&(j-wb<7))
        {j+=emitcode(pbuf+j,MASK_FWDDEF,bck,j-wb);used[1]++;if(bck>tlen[1]) tlen[1]=bck;}
       else*/
       j+=emitcode(pbuf+j,MASK_BCK,bck,wb);
       for(n=0;n<63;n++)
        {
         int pj=bj-n-(j-bj);
         if(pj>=0)
          if(memcmp(pbuf+pj,pbuf+bj,j-bj)==0)
          {
           cnt++;
           break;
          }
        }

       used[3]++;
       if(bck>tlen[3]) 
        tlen[3]=bck;

       i+=bck;
      } 
     le=i; 
    }    
   else
    i++;   
  }
 if(i>le)
  {j+=emitplain(pbuf+j,buf+le,i-le);used[0]++;if(i-le>tlen[0]) tlen[0]=i-le;}
 pbuf[j++]=0; 
 return j;
}

int monocnt_compare(const void*a,const void*b)
{
 u16*A=(u16*)a;
 u16*B=(u16*)b;
 return B[1]-A[1];
}

/*
 #if defined(HUPACK_USETOPFREQ)||defined(HUPACK_USEBIGRAMS)   
 if(1)
 #else
 if(0)
 #endif
  {
   bigram cnt[12*1024];
   mono   mo[256];
   int    hi=0,n,icnt=0,freq[256],tfreq=0,best=0,headmask=0,lost=0,used=0,im=0,bit=0;
   memset(cnt,0,sizeof(cnt));
   memset(freq,0,sizeof(freq));
   for(i=0;i<hm-1;i++)
    {
     bigram b;
     freq[buf[i]]++;
     if(freq[buf[i]]>tfreq)
      {tfreq=freq[buf[i]];best=buf[i];}
     b.seq[0]=buf[i];b.seq[1]=buf[i+1];b.cnt=1;
     for(n=0;n<icnt;n++)
      if(memcmp(b.seq,cnt[n].seq,sizeof(b.seq))==0)
       {
        cnt[n].cnt++;
        if(cnt[n].cnt>hi)
         hi=cnt[n].cnt;
        break;
       }
     if(n==icnt)
      if(icnt<12*1024)
       {memcpy(&cnt[icnt],&b,sizeof(b));icnt++;}     
      else
       lost++;
    }
   for(i=0;i<256;i++)
    if(freq[i])
    {
     mo[im].seq=i;mo[im].cnt=freq[i];im++;
     used++;
    }
   qsort(mo,im,sizeof(mo[0]),mono_compare);    
   bit=0;
   for(i=0;i<hm;i++)
    {
     for(j=0;j<15;j++)
      if(buf[i]==mo[j].seq)
      {
       bit+=4;
       break;
      }
     if(j==3)
      bit+=12;
    }
   if(tfreq>100)
   {
    hpack_usedef=1;
    hpack_defval=best;
    headmask|=headmask_topfreq;
   }

   if(hi>=100)
    {
     hi=0;
     qsort(cnt,icnt,sizeof(cnt[0]),bigram_compare);    
     while((hi<icnt)&&(cnt[hi].cnt>=100))
      hi++;
     if(hi)
     {
      headmask|=headmask_bigrams;
      if(hi>4)
       hi=4;
     }
    }
   
   #if defined(HUPACK_USETOPFREQ)
   pbuf[j++]=headmask;
   if(headmask&headmask_topfreq)
    pbuf[j++]=best;
   #elif defined(HUPACK_USEBIGRAMS)   
   pbuf[j++]=headmask|hi;
   if(headmask&headmask_bigrams)
    {
     u8 n;
     for(n=0;n<hi;n++)
      {
       pbuf[j++]=cnt[n].seq[0];pbuf[j++]=cnt[n].seq[1];
       memcpy(&bigr[n],&cnt[n].seq[0],sizeof(cnt[0].seq));       
      }
     ibigr=hi;
    }
   #endif

   hi=0;
  }
 else
 {
  #if defined(HUPACK_USETOPFREQ) || defined(HUPACK_USEBIGRAMS)
  pbuf[j++]=0; // head
  #endif
 }
*/

int hpack(u8*buf,u16 start,u16 hm,u8*pbuf)
{
 int i=start,j=0,le=0,safecheck=1,cnt=0,ibigr=0,low=0;  
 u16 used[5]={0,0,0,0,0}; 
 u16 tlen[5]={0,0,0,0,0};
 u16 bigr[4]={0,0,0,0};
 #if defined(HUPACK_USETOPFREQ)
 hpack_usedef=0;
 #else
 hpack_usedef=1;
 #endif
 master[0]=0;
 if(hpack_usedef>1)
  {
   u16 monocnt[256*2];
   for(i=0;i<256;i++)
    {
     monocnt[i*2]=i;
     monocnt[i*2+1]=0;
    }
   if(1)
    {
     i=0;
     while(i<hm-1)
      {
       int j=1;
       while(i+j<hm)
        if(buf[i]==buf[i+j])
         {monocnt[buf[i]*2+1]++;j++;}
        else
         break;
       i+=j;
      }
    }
   else
    {
     for(i=0;i<hm;i++)
      monocnt[buf[i]*2+1]++;
    }
   qsort(monocnt,256,sizeof(monocnt[0])*2,monocnt_compare);
   for(i=0;i<256;i++)
    if(monocnt[i*2+1]==0)
     break;
   if(i<15)
    low=1;
   else
    if(i<31)
     low=2;
    else
     if(i<63)
      low=3;
   for(i=0;i<4;i++)
    if(monocnt[i*2+1]>8)
     master[i]=monocnt[i*2];
    else
     {
      if(i)
       master[i]=master[i-1];
      else
       master[0]=master[1]=0;
      break;
     }
   hpack_defval=master[0];
  }

 le=i=start;
 if(hpack_usedef>1)
  {
   pbuf[j++]=master[0];
   if(hpack_usedef>2)
    pbuf[j++]=master[1];
   if(hpack_usedef>3)
    pbuf[j++]=master[2];
   if(hpack_usedef>4)
    pbuf[j++]=master[3];
  }
 while(i<start+hm)
  {
   u8  wf,wb;
   u8  fwd=scanfwd(buf,i,start+hm,&wf);
   u8  bck=scanbck(buf,i,start+hm,&wb);
   if(safecheck&&(i-le==1)&&(((fwd>bck)&&(fwd==2))||((bck>fwd)&&(bck==2))))
    {
     #if defined(HUPACK_USEBIGRAMS)
     if((i+1<hm)&&ibigr)
      {
       int n;
       for(n=0;n<ibigr;n++)
        if(memcmp(&buf[i],&bigr[n],sizeof(bigr[n]))==0)
         {
          j+=emitcodedef(pbuf+j,MASK_FWDDEF,n,wf);
          used[1]++;
          if(fwd>tlen[1]) 
           tlen[1]=fwd;
          i+=2;
          break;
         }
       if(n==ibigr)
        i++;
      }
     else
     #endif
      i++;
    }
   else
   if(fwd+bck)
    {
     if(i>le)
      {j+=emitplain(pbuf+j,buf+le,i-le);used[0]++;if(i-le>tlen[0]) tlen[0]=i-le;}
     if(fwd>=bck)
      {        
       int bj=j,n;
       if(hpack_usedef&&(wf==master[0])&&((hpack_usedef<=2)||((hpack_usedef>2)&&(fwd<16))))
        {j+=emitcodedef(pbuf+j,MASK_FWDDEF,fwd,0);used[1]++;if(fwd>tlen[1]) tlen[1]=fwd;}
       else
       if((hpack_usedef>2)&&(wf==master[1])&&(fwd<16))
        {j+=emitcodedef(pbuf+j,MASK_FWDDEF,fwd,1);used[1]++;if(fwd>tlen[1]) tlen[1]=fwd;}
       else
       if((hpack_usedef>3)&&(wf==master[2])&&(fwd<16))
        {j+=emitcodedef(pbuf+j,MASK_FWDDEF,fwd,2);used[1]++;if(fwd>tlen[1]) tlen[1]=fwd;}
       else
       if((hpack_usedef>4)&&(wf==master[3])&&(fwd<16))
        {j+=emitcodedef(pbuf+j,MASK_FWDDEF,fwd,3);used[1]++;if(fwd>tlen[1]) tlen[1]=fwd;}
       else
        {
#if defined(USE_PACKEDFWD)
         int ref=0;
         if(i&&(buf[i-1]==wf))
          ref=1;
         else
          if((i>1)&&(buf[i-2]==wf))
           ref=2;
          else
           if((i>2)&&(buf[i-3]==wf))
            ref=3;
           else
            if((i>3)&&(buf[i-4]==wf))
             ref=4;
         if(ref&&(fwd<8))
          j+=emitcode(pbuf+j,MASK_FWD|32,fwd,ref);
         else
#endif
          j+=emitcode(pbuf+j,MASK_FWD,fwd,wf);
         for(n=0;n<63;n++)
          {
           int pj=bj-n-(j-bj);
           if(pj>=0)
            if(memcmp(pbuf+pj,pbuf+bj,j-bj)==0)
            {
             cnt++;
             break;
            }
          }
         used[2]++;
         if(fwd>tlen[2]) 
          tlen[2]=fwd;
        }
       i+=fwd;
      } 
     else
      {
       int bj=j,n;
       /*if((bck<4)&&(j-wb<7))
        {j+=emitcode(pbuf+j,MASK_FWDDEF,bck,j-wb);used[1]++;if(bck>tlen[1]) tlen[1]=bck;}
       else*/
       j+=emitcode(pbuf+j,MASK_BCK,bck,wb);
       for(n=0;n<63;n++)
        {
         int pj=bj-n-(j-bj);
         if(pj>=0)
          if(memcmp(pbuf+pj,pbuf+bj,j-bj)==0)
          {
           cnt++;
           break;
          }
        }

       used[3]++;
       if(bck>tlen[3]) 
        tlen[3]=bck;

       i+=bck;
      } 
     le=i; 
    }    
   else
    i++;   
  }
 if(i>le)
  {j+=emitplain(pbuf+j,buf+le,i-le);used[0]++;if(i-le>tlen[0]) tlen[0]=i-le;}
 pbuf[j++]=0; 
 
 {
 int good=0;
 u8  out[64*1024];
 if(start)
  memcpy(out,buf,start);
 if(hunpack(pbuf,out+start))
  if(memcmp(out+start,buf,hm)==0)
   good=1;
  else
  {
   int i,err=0;
   for(i=0;i<hm;i++)
    if(buf[start+i]!=out[start+i])
     err++;
   good=0;
  } 
 } 
 return j;
}
#else
int hahpack(u8*buf,u16 hm,u8*pbuf);
#endif

