--------------------------------------------------------------------
startup: ; startup
0801 : 0b __ __ INV
0802 : 08 __ __ PHP
0803 : 0a __ __ ASL
0804 : 00 __ __ BRK
0805 : 9e __ __ INV
0806 : 32 __ __ INV
0807 : 30 36 __ BMI $083f ; (startup + 62)
0809 : 31 00 __ AND ($00),y 
080b : 00 __ __ BRK
080c : 00 __ __ BRK
080d : ba __ __ TSX
080e : 8e 70 3c STX $3c70 ; (spentry + 0)
0811 : a9 64 __ LDA #$64
0813 : 85 19 __ STA IP + 0 
0815 : a9 3f __ LDA #$3f
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 40 __ LDA #$40
081c : e9 3f __ SBC #$3f
081e : f0 0f __ BEQ $082f ; (startup + 46)
0820 : aa __ __ TAX
0821 : a9 00 __ LDA #$00
0823 : a0 00 __ LDY #$00
0825 : 91 19 __ STA (IP + 0),y 
0827 : c8 __ __ INY
0828 : d0 fb __ BNE $0825 ; (startup + 36)
082a : e6 1a __ INC IP + 1 
082c : ca __ __ DEX
082d : d0 f6 __ BNE $0825 ; (startup + 36)
082f : 38 __ __ SEC
0830 : a9 64 __ LDA #$64
0832 : e9 64 __ SBC #$64
0834 : f0 08 __ BEQ $083e ; (startup + 61)
0836 : a8 __ __ TAY
0837 : a9 00 __ LDA #$00
0839 : 88 __ __ DEY
083a : 91 19 __ STA (IP + 0),y 
083c : d0 fb __ BNE $0839 ; (startup + 56)
083e : a2 f7 __ LDX #$f7
0840 : e0 f7 __ CPX #$f7
0842 : f0 07 __ BEQ $084b ; (startup + 74)
0844 : 95 00 __ STA $00,x 
0846 : e8 __ __ INX
0847 : e0 f7 __ CPX #$f7
0849 : d0 f9 __ BNE $0844 ; (startup + 67)
084b : a9 cc __ LDA #$cc
084d : 85 23 __ STA SP + 0 
084f : a9 cb __ LDA #$cb
0851 : 85 24 __ STA SP + 1 
0853 : 20 80 08 JSR $0880 ; (main.s1000 + 0)
0856 : a9 4c __ LDA #$4c
0858 : 85 54 __ STA $54 
085a : a9 00 __ LDA #$00
085c : 85 13 __ STA P6 
085e : a9 19 __ LDA #$19
0860 : 85 16 __ STA P9 
0862 : 60 __ __ RTS
--------------------------------------------------------------------
main: ; main()->i16
.s1000:
0880 : a5 53 __ LDA T1 + 0 
0882 : 8d ce cb STA $cbce ; (main@stack + 0)
0885 : a5 54 __ LDA T2 + 0 
0887 : 8d cf cb STA $cbcf ; (main@stack + 1)
.s0:
088a : 20 00 0a JSR $0a00 ; (os_init.s0 + 0)
088d : 20 b3 0c JSR $0cb3 ; (do_textmode.s0 + 0)
0890 : a9 0f __ LDA #$0f
0892 : 85 0f __ STA P2 
0894 : a9 52 __ LDA #$52
0896 : 85 0d __ STA P0 
0898 : a9 0d __ LDA #$0d
089a : 85 0e __ STA P1 
089c : 20 ec 0c JSR $0cec ; (dos_msg.s0 + 0)
089f : 20 5d 0d JSR $0d5d ; (loadcartridge.s0 + 0)
08a2 : a5 1b __ LDA ACCU + 0 
08a4 : d0 03 __ BNE $08a9 ; (main.s3 + 0)
08a6 : 4c e3 09 JMP $09e3 ; (main.s2 + 0)
.s3:
08a9 : a9 00 __ LDA #$00
08ab : 85 0f __ STA P2 
08ad : 85 10 __ STA P3 
08af : 85 12 __ STA P5 
08b1 : a9 50 __ LDA #$50
08b3 : 85 11 __ STA P4 
08b5 : ad ef 3e LDA $3eef ; (video_ram + 0)
08b8 : 18 __ __ CLC
08b9 : 69 e0 __ ADC #$e0
08bb : 85 0d __ STA P0 
08bd : ad f0 3e LDA $3ef0 ; (video_ram + 1)
08c0 : 69 01 __ ADC #$01
08c2 : 85 0e __ STA P1 
08c4 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
08c7 : a9 00 __ LDA #$00
08c9 : 85 0f __ STA P2 
08cb : 85 10 __ STA P3 
08cd : 85 12 __ STA P5 
08cf : a9 50 __ LDA #$50
08d1 : 85 11 __ STA P4 
08d3 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
08d6 : 18 __ __ CLC
08d7 : 69 e0 __ ADC #$e0
08d9 : 85 0d __ STA P0 
08db : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
08de : 69 01 __ ADC #$01
08e0 : 85 0e __ STA P1 
08e2 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
.l124:
08e5 : 2c 11 d0 BIT $d011 
08e8 : 10 fb __ BPL $08e5 ; (main.l124 + 0)
.s6:
08ea : 20 7b 11 JSR $117b ; (IRQ_gfx_init.s0 + 0)
08ed : ad 01 3f LDA $3f01 ; (strcmd + 0)
08f0 : 85 43 __ STA T0 + 0 
08f2 : ad 02 3f LDA $3f02 ; (strcmd + 1)
08f5 : 85 44 __ STA T0 + 1 
08f7 : a9 00 __ LDA #$00
08f9 : 8d 20 d0 STA $d020 
08fc : a8 __ __ TAY
08fd : 91 43 __ STA (T0 + 0),y 
08ff : 20 11 12 JSR $1211 ; (clean.s0 + 0)
0902 : 20 33 12 JSR $1233 ; (adv_start.s0 + 0)
.l11:
0905 : 20 4b 34 JSR $344b ; (parser_update.s1000 + 0)
0908 : a9 00 __ LDA #$00
090a : 8d c7 3f STA $3fc7 ; (ch + 0)
090d : 8d 3a 3f STA $3f3a ; (quit_request + 0)
.l14:
0910 : 20 9f ff JSR $ff9f 
0913 : 20 e4 ff JSR $ffe4 
0916 : 8d c7 3f STA $3fc7 ; (ch + 0)
0919 : ad c7 3f LDA $3fc7 ; (ch + 0)
091c : d0 06 __ BNE $0924 ; (main.s16 + 0)
.s17:
091e : 20 de 3a JSR $3ade ; (do_blink.s0 + 0)
0921 : 4c 79 09 JMP $0979 ; (main.l127 + 0)
.s16:
0924 : 85 53 __ STA T1 + 0 
0926 : 20 23 35 JSR $3523 ; (hide_blink.s0 + 0)
0929 : a5 53 __ LDA T1 + 0 
092b : c9 0d __ CMP #$0d
092d : d0 06 __ BNE $0935 ; (main.s20 + 0)
.s19:
092f : 20 5f 35 JSR $355f ; (execute.s1000 + 0)
0932 : 4c 79 09 JMP $0979 ; (main.l127 + 0)
.s20:
0935 : c9 91 __ CMP #$91
0937 : f0 40 __ BEQ $0979 ; (main.l127 + 0)
.s23:
0939 : c9 14 __ CMP #$14
093b : d0 03 __ BNE $0940 ; (main.s26 + 0)
093d : 4c c9 09 JMP $09c9 ; (main.s25 + 0)
.s26:
0940 : ad 63 3f LDA $3f63 ; (icmd + 0)
0943 : c9 50 __ CMP #$50
0945 : b0 2f __ BCS $0976 ; (main.s136 + 0)
.s31:
0947 : 85 54 __ STA T2 + 0 
0949 : a5 53 __ LDA T1 + 0 
094b : 20 b1 3a JSR $3ab1 ; (charmap.s0 + 0)
094e : 8d c7 3f STA $3fc7 ; (ch + 0)
0951 : 09 00 __ ORA #$00
0953 : f0 21 __ BEQ $0976 ; (main.s136 + 0)
.s34:
0955 : 18 __ __ CLC
0956 : a5 54 __ LDA T2 + 0 
0958 : 69 01 __ ADC #$01
095a : 85 43 __ STA T0 + 0 
095c : 8d 63 3f STA $3f63 ; (icmd + 0)
095f : ad 01 3f LDA $3f01 ; (strcmd + 0)
0962 : 85 45 __ STA T3 + 0 
0964 : ad 02 3f LDA $3f02 ; (strcmd + 1)
0967 : 85 46 __ STA T3 + 1 
0969 : ad c7 3f LDA $3fc7 ; (ch + 0)
096c : a4 54 __ LDY T2 + 0 
096e : 91 45 __ STA (T3 + 0),y 
.s137:
0970 : a9 00 __ LDA #$00
0972 : a4 43 __ LDY T0 + 0 
0974 : 91 45 __ STA (T3 + 0),y 
.s136:
0976 : 20 4b 34 JSR $344b ; (parser_update.s1000 + 0)
.l127:
0979 : 2c 11 d0 BIT $d011 
097c : 10 fb __ BPL $0979 ; (main.l127 + 0)
.s13:
097e : ad 3a 3f LDA $3f3a ; (quit_request + 0)
0981 : f0 8d __ BEQ $0910 ; (main.l14 + 0)
.s15:
0983 : c9 02 __ CMP #$02
0985 : b0 06 __ BCS $098d ; (main.s41 + 0)
.s12:
0987 : 20 e7 3b JSR $3be7 ; (os_reset.s0 + 0)
098a : 4c b8 09 JMP $09b8 ; (main.s1001 + 0)
.s41:
098d : d0 06 __ BNE $0995 ; (main.s45 + 0)
.s44:
098f : 20 47 3b JSR $3b47 ; (adv_reset.s0 + 0)
0992 : 4c 9c 09 JMP $099c ; (main.s51 + 0)
.s45:
0995 : 20 66 3b JSR $3b66 ; (adv_load.s0 + 0)
0998 : a5 1b __ LDA ACCU + 0 
099a : f0 14 __ BEQ $09b0 ; (main.s135 + 0)
.s51:
099c : ad 9d 3f LDA $3f9d ; (roomstart + 0)
099f : 85 43 __ STA T0 + 0 
09a1 : ad 9e 3f LDA $3f9e ; (roomstart + 1)
09a4 : 85 44 __ STA T0 + 1 
09a6 : a0 00 __ LDY #$00
09a8 : b1 43 __ LDA (T0 + 0),y 
09aa : 8d b3 3f STA $3fb3 ; (newroom + 0)
09ad : 20 d3 12 JSR $12d3 ; (room_load.s1000 + 0)
.s135:
09b0 : a9 00 __ LDA #$00
09b2 : 8d 3a 3f STA $3f3a ; (quit_request + 0)
09b5 : 4c 05 09 JMP $0905 ; (main.l11 + 0)
.s1001:
09b8 : a9 00 __ LDA #$00
09ba : 85 1b __ STA ACCU + 0 
09bc : 85 1c __ STA ACCU + 1 
09be : ad ce cb LDA $cbce ; (main@stack + 0)
09c1 : 85 53 __ STA T1 + 0 
09c3 : ad cf cb LDA $cbcf ; (main@stack + 1)
09c6 : 85 54 __ STA T2 + 0 
09c8 : 60 __ __ RTS
.s25:
09c9 : ad 63 3f LDA $3f63 ; (icmd + 0)
09cc : f0 a8 __ BEQ $0976 ; (main.s136 + 0)
.s28:
09ce : 38 __ __ SEC
09cf : e9 01 __ SBC #$01
09d1 : 8d 63 3f STA $3f63 ; (icmd + 0)
09d4 : 85 43 __ STA T0 + 0 
09d6 : ad 01 3f LDA $3f01 ; (strcmd + 0)
09d9 : 85 45 __ STA T3 + 0 
09db : ad 02 3f LDA $3f02 ; (strcmd + 1)
09de : 85 46 __ STA T3 + 1 
09e0 : 4c 70 09 JMP $0970 ; (main.s137 + 0)
.s2:
09e3 : a9 0f __ LDA #$0f
09e5 : 85 0f __ STA P2 
09e7 : a9 ea __ LDA #$ea
09e9 : 85 0d __ STA P0 
09eb : a9 10 __ LDA #$10
09ed : 85 0e __ STA P1 
09ef : 20 ec 0c JSR $0cec ; (dos_msg.s0 + 0)
09f2 : a9 4a __ LDA #$4a
09f4 : 85 0d __ STA P0 
09f6 : a9 11 __ LDA #$11
09f8 : 85 0e __ STA P1 
09fa : 20 f5 10 JSR $10f5 ; (puts.s0 + 0)
09fd : 4c b8 09 JMP $09b8 ; (main.s1001 + 0)
--------------------------------------------------------------------
os_init: ; os_init()->void
.s0:
0a00 : 20 5a 0a JSR $0a5a ; (mysrand.s0 + 0)
0a03 : a9 00 __ LDA #$00
0a05 : 8d 21 d0 STA $d021 
0a08 : 8d 20 d0 STA $d020 
0a0b : 20 62 0a JSR $0a62 ; (font_load.s0 + 0)
0a0e : ad 8a 02 LDA $028a 
0a11 : 29 3f __ AND #$3f
0a13 : 09 40 __ ORA #$40
0a15 : 8d 8a 02 STA $028a 
0a18 : a9 20 __ LDA #$20
0a1a : 85 0f __ STA P2 
0a1c : a9 00 __ LDA #$00
0a1e : 85 10 __ STA P3 
0a20 : a9 e8 __ LDA #$e8
0a22 : 85 11 __ STA P4 
0a24 : a9 03 __ LDA #$03
0a26 : 85 12 __ STA P5 
0a28 : ad ef 3e LDA $3eef ; (video_ram + 0)
0a2b : 85 0d __ STA P0 
0a2d : ad f0 3e LDA $3ef0 ; (video_ram + 1)
0a30 : 85 0e __ STA P1 
0a32 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
0a35 : a9 00 __ LDA #$00
0a37 : 85 0f __ STA P2 
0a39 : 85 10 __ STA P3 
0a3b : a9 e8 __ LDA #$e8
0a3d : 85 11 __ STA P4 
0a3f : a9 03 __ LDA #$03
0a41 : 85 12 __ STA P5 
0a43 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
0a46 : 85 0d __ STA P0 
0a48 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
0a4b : 85 0e __ STA P1 
0a4d : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
.l29:
0a50 : 2c 11 d0 BIT $d011 
0a53 : 10 fb __ BPL $0a50 ; (os_init.l29 + 0)
.s1:
0a55 : a9 36 __ LDA #$36
0a57 : 85 01 __ STA $01 
.s1001:
0a59 : 60 __ __ RTS
--------------------------------------------------------------------
mysrand: ; mysrand()->void
.s0:
0a5a : a5 a2 __ LDA $a2 
0a5c : f0 fc __ BEQ $0a5a ; (mysrand.s0 + 0)
0a5e : 8d 71 3c STA $3c71 ; (rnd_a + 0)
.s1001:
0a61 : 60 __ __ RTS
--------------------------------------------------------------------
font_load: ; font_load()->void
.s0:
0a62 : a9 72 __ LDA #$72
0a64 : 85 0d __ STA P0 
0a66 : a9 3c __ LDA #$3c
0a68 : 85 0e __ STA P1 
0a6a : a9 00 __ LDA #$00
0a6c : 85 0f __ STA P2 
0a6e : a9 c0 __ LDA #$c0
0a70 : 85 10 __ STA P3 
0a72 : 20 c2 0a JSR $0ac2 ; (hunpack.s0 + 0)
0a75 : a9 00 __ LDA #$00
0a77 : 85 11 __ STA P4 
0a79 : 85 43 __ STA T1 + 0 
0a7b : 85 0d __ STA P0 
0a7d : a9 04 __ LDA #$04
0a7f : 85 12 __ STA P5 
0a81 : a9 f8 __ LDA #$f8
0a83 : 85 0e __ STA P1 
0a85 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
0a88 : a9 c0 __ LDA #$c0
0a8a : 85 44 __ STA T1 + 1 
0a8c : a0 00 __ LDY #$00
0a8e : 84 45 __ STY T2 + 0 
0a90 : a2 04 __ LDX #$04
.l1002:
0a92 : a9 ff __ LDA #$ff
0a94 : 38 __ __ SEC
0a95 : f1 43 __ SBC (T1 + 0),y 
0a97 : 91 43 __ STA (T1 + 0),y 
0a99 : c8 __ __ INY
0a9a : d0 02 __ BNE $0a9e ; (font_load.s1005 + 0)
.s1004:
0a9c : e6 44 __ INC T1 + 1 
.s1005:
0a9e : 38 __ __ SEC
0a9f : a5 45 __ LDA T2 + 0 
0aa1 : e9 01 __ SBC #$01
0aa3 : 85 45 __ STA T2 + 0 
0aa5 : b0 01 __ BCS $0aa8 ; (font_load.s1007 + 0)
.s1006:
0aa7 : ca __ __ DEX
.s1007:
0aa8 : 8a __ __ TXA
0aa9 : 05 45 __ ORA T2 + 0 
0aab : d0 e5 __ BNE $0a92 ; (font_load.l1002 + 0)
.s4:
0aad : 85 0f __ STA P2 
0aaf : 85 11 __ STA P4 
0ab1 : 85 0d __ STA P0 
0ab3 : a9 c0 __ LDA #$c0
0ab5 : 85 10 __ STA P3 
0ab7 : a9 04 __ LDA #$04
0ab9 : 85 12 __ STA P5 
0abb : a9 fc __ LDA #$fc
0abd : 85 0e __ STA P1 
0abf : 4c 60 0c JMP $0c60 ; (memcpy.s0 + 0)
--------------------------------------------------------------------
hunpack: ; hunpack(u8*,u8*)->u16
.s0:
0ac2 : a9 00 __ LDA #$00
0ac4 : 85 1b __ STA ACCU + 0 
0ac6 : 85 1c __ STA ACCU + 1 
0ac8 : a8 __ __ TAY
0ac9 : b1 0d __ LDA (P0),y ; (buf + 0)
0acb : d0 01 __ BNE $0ace ; (hunpack.s36 + 0)
0acd : 60 __ __ RTS
.s36:
0ace : 84 43 __ STY T3 + 0 
0ad0 : 84 44 __ STY T3 + 1 
.l2:
0ad2 : 18 __ __ CLC
0ad3 : a5 0d __ LDA P0 ; (buf + 0)
0ad5 : 65 43 __ ADC T3 + 0 
0ad7 : 85 47 __ STA T5 + 0 
0ad9 : a5 0e __ LDA P1 ; (buf + 1)
0adb : 65 44 __ ADC T3 + 1 
0add : 85 48 __ STA T5 + 1 
0adf : a0 00 __ LDY #$00
0ae1 : b1 47 __ LDA (T5 + 0),y 
0ae3 : aa __ __ TAX
0ae4 : 29 3f __ AND #$3f
0ae6 : 8d 64 3f STA $3f64 ; (hb_len + 0)
0ae9 : 8a __ __ TXA
0aea : 29 c0 __ AND #$c0
0aec : aa __ __ TAX
0aed : a5 43 __ LDA T3 + 0 
0aef : 85 45 __ STA T4 + 0 
0af1 : 18 __ __ CLC
0af2 : 69 01 __ ADC #$01
0af4 : 85 43 __ STA T3 + 0 
0af6 : a5 44 __ LDA T3 + 1 
0af8 : 85 46 __ STA T4 + 1 
0afa : 69 00 __ ADC #$00
0afc : 85 44 __ STA T3 + 1 
0afe : ad 64 3f LDA $3f64 ; (hb_len + 0)
0b01 : c9 3f __ CMP #$3f
0b03 : d0 13 __ BNE $0b18 ; (hunpack.s6 + 0)
.s4:
0b05 : c8 __ __ INY
0b06 : b1 47 __ LDA (T5 + 0),y 
0b08 : 8d 64 3f STA $3f64 ; (hb_len + 0)
0b0b : 18 __ __ CLC
0b0c : a5 45 __ LDA T4 + 0 
0b0e : 69 02 __ ADC #$02
0b10 : 85 43 __ STA T3 + 0 
0b12 : a5 46 __ LDA T4 + 1 
0b14 : 69 00 __ ADC #$00
0b16 : 85 44 __ STA T3 + 1 
.s6:
0b18 : 8a __ __ TXA
0b19 : e0 c0 __ CPX #$c0
0b1b : d0 03 __ BNE $0b20 ; (hunpack.s8 + 0)
0b1d : 4c 19 0c JMP $0c19 ; (hunpack.s10 + 0)
.s8:
0b20 : c9 80 __ CMP #$80
0b22 : d0 03 __ BNE $0b27 ; (hunpack.s14 + 0)
0b24 : 4c b5 0b JMP $0bb5 ; (hunpack.s13 + 0)
.s14:
0b27 : c9 40 __ CMP #$40
0b29 : f0 47 __ BEQ $0b72 ; (hunpack.s19 + 0)
.s20:
0b2b : 09 00 __ ORA #$00
0b2d : d0 2e __ BNE $0b5d ; (hunpack.s1 + 0)
.s25:
0b2f : ad 64 3f LDA $3f64 ; (hb_len + 0)
0b32 : ce 64 3f DEC $3f64 ; (hb_len + 0)
0b35 : 09 00 __ ORA #$00
0b37 : f0 24 __ BEQ $0b5d ; (hunpack.s1 + 0)
.s35:
0b39 : a5 0f __ LDA P2 ; (pbuf + 0)
0b3b : 85 47 __ STA T5 + 0 
0b3d : a4 1b __ LDY ACCU + 0 
0b3f : ae 64 3f LDX $3f64 ; (hb_len + 0)
.l1022:
0b42 : 18 __ __ CLC
0b43 : a5 10 __ LDA P3 ; (pbuf + 1)
0b45 : 65 1c __ ADC ACCU + 1 
0b47 : 85 48 __ STA T5 + 1 
0b49 : a9 00 __ LDA #$00
0b4b : 91 47 __ STA (T5 + 0),y 
0b4d : c8 __ __ INY
0b4e : d0 02 __ BNE $0b52 ; (hunpack.s1039 + 0)
.s1038:
0b50 : e6 1c __ INC ACCU + 1 
.s1039:
0b52 : 8a __ __ TXA
0b53 : ca __ __ DEX
0b54 : 09 00 __ ORA #$00
0b56 : d0 ea __ BNE $0b42 ; (hunpack.l1022 + 0)
.s1015:
0b58 : 84 1b __ STY ACCU + 0 
.s275:
0b5a : 8e 64 3f STX $3f64 ; (hb_len + 0)
.s1:
0b5d : a5 43 __ LDA T3 + 0 
0b5f : 85 45 __ STA T4 + 0 
0b61 : 18 __ __ CLC
0b62 : a5 0e __ LDA P1 ; (buf + 1)
0b64 : 65 44 __ ADC T3 + 1 
0b66 : 85 46 __ STA T4 + 1 
0b68 : a4 0d __ LDY P0 ; (buf + 0)
0b6a : b1 45 __ LDA (T4 + 0),y 
0b6c : f0 03 __ BEQ $0b71 ; (hunpack.s1001 + 0)
0b6e : 4c d2 0a JMP $0ad2 ; (hunpack.l2 + 0)
.s1001:
0b71 : 60 __ __ RTS
.s19:
0b72 : a5 43 __ LDA T3 + 0 
0b74 : 85 45 __ STA T4 + 0 
0b76 : 18 __ __ CLC
0b77 : a5 0e __ LDA P1 ; (buf + 1)
0b79 : 65 44 __ ADC T3 + 1 
0b7b : 85 46 __ STA T4 + 1 
0b7d : a4 0d __ LDY P0 ; (buf + 0)
0b7f : b1 45 __ LDA (T4 + 0),y 
0b81 : 85 1d __ STA ACCU + 2 
0b83 : ae 64 3f LDX $3f64 ; (hb_len + 0)
0b86 : ce 64 3f DEC $3f64 ; (hb_len + 0)
0b89 : e6 43 __ INC T3 + 0 
0b8b : d0 02 __ BNE $0b8f ; (hunpack.s1035 + 0)
.s1034:
0b8d : e6 44 __ INC T3 + 1 
.s1035:
0b8f : 8a __ __ TXA
0b90 : f0 cb __ BEQ $0b5d ; (hunpack.s1 + 0)
.s34:
0b92 : a5 0f __ LDA P2 ; (pbuf + 0)
0b94 : 85 47 __ STA T5 + 0 
0b96 : a4 1b __ LDY ACCU + 0 
0b98 : ae 64 3f LDX $3f64 ; (hb_len + 0)
.l1014:
0b9b : 86 1b __ STX ACCU + 0 
0b9d : 18 __ __ CLC
0b9e : a5 10 __ LDA P3 ; (pbuf + 1)
0ba0 : 65 1c __ ADC ACCU + 1 
0ba2 : 85 48 __ STA T5 + 1 
0ba4 : a5 1d __ LDA ACCU + 2 
0ba6 : 91 47 __ STA (T5 + 0),y 
0ba8 : c8 __ __ INY
0ba9 : d0 02 __ BNE $0bad ; (hunpack.s1037 + 0)
.s1036:
0bab : e6 1c __ INC ACCU + 1 
.s1037:
0bad : ca __ __ DEX
0bae : a5 1b __ LDA ACCU + 0 
0bb0 : d0 e9 __ BNE $0b9b ; (hunpack.l1014 + 0)
0bb2 : 4c 58 0b JMP $0b58 ; (hunpack.s1015 + 0)
.s13:
0bb5 : a5 43 __ LDA T3 + 0 
0bb7 : 85 45 __ STA T4 + 0 
0bb9 : 18 __ __ CLC
0bba : a5 0e __ LDA P1 ; (buf + 1)
0bbc : 65 44 __ ADC T3 + 1 
0bbe : 85 46 __ STA T4 + 1 
0bc0 : a4 0d __ LDY P0 ; (buf + 0)
0bc2 : b1 45 __ LDA (T4 + 0),y 
0bc4 : 85 1d __ STA ACCU + 2 
0bc6 : ae 64 3f LDX $3f64 ; (hb_len + 0)
0bc9 : ce 64 3f DEC $3f64 ; (hb_len + 0)
0bcc : e6 43 __ INC T3 + 0 
0bce : d0 02 __ BNE $0bd2 ; (hunpack.s1029 + 0)
.s1028:
0bd0 : e6 44 __ INC T3 + 1 
.s1029:
0bd2 : 8a __ __ TXA
0bd3 : f0 88 __ BEQ $0b5d ; (hunpack.s1 + 0)
.s33:
0bd5 : a5 0f __ LDA P2 ; (pbuf + 0)
0bd7 : 85 49 __ STA T6 + 0 
0bd9 : 18 __ __ CLC
0bda : 65 1b __ ADC ACCU + 0 
0bdc : a8 __ __ TAY
0bdd : a5 10 __ LDA P3 ; (pbuf + 1)
0bdf : 65 1c __ ADC ACCU + 1 
0be1 : aa __ __ TAX
0be2 : 98 __ __ TYA
0be3 : 38 __ __ SEC
0be4 : e5 1d __ SBC ACCU + 2 
0be6 : 85 47 __ STA T5 + 0 
0be8 : 8a __ __ TXA
0be9 : e9 00 __ SBC #$00
0beb : 85 48 __ STA T5 + 1 
0bed : ae 64 3f LDX $3f64 ; (hb_len + 0)
.l1012:
0bf0 : 86 1d __ STX ACCU + 2 
0bf2 : 18 __ __ CLC
0bf3 : a5 10 __ LDA P3 ; (pbuf + 1)
0bf5 : 65 1c __ ADC ACCU + 1 
0bf7 : 85 4a __ STA T6 + 1 
0bf9 : a0 00 __ LDY #$00
0bfb : b1 47 __ LDA (T5 + 0),y 
0bfd : a4 1b __ LDY ACCU + 0 
0bff : 91 49 __ STA (T6 + 0),y 
0c01 : 98 __ __ TYA
0c02 : 18 __ __ CLC
0c03 : 69 01 __ ADC #$01
0c05 : 85 1b __ STA ACCU + 0 
0c07 : 90 02 __ BCC $0c0b ; (hunpack.s1031 + 0)
.s1030:
0c09 : e6 1c __ INC ACCU + 1 
.s1031:
0c0b : e6 47 __ INC T5 + 0 
0c0d : d0 02 __ BNE $0c11 ; (hunpack.s1033 + 0)
.s1032:
0c0f : e6 48 __ INC T5 + 1 
.s1033:
0c11 : ca __ __ DEX
0c12 : a5 1d __ LDA ACCU + 2 
0c14 : d0 da __ BNE $0bf0 ; (hunpack.l1012 + 0)
0c16 : 4c 5a 0b JMP $0b5a ; (hunpack.s275 + 0)
.s10:
0c19 : ad 64 3f LDA $3f64 ; (hb_len + 0)
0c1c : ce 64 3f DEC $3f64 ; (hb_len + 0)
0c1f : 09 00 __ ORA #$00
0c21 : d0 03 __ BNE $0c26 ; (hunpack.s32 + 0)
0c23 : 4c 5d 0b JMP $0b5d ; (hunpack.s1 + 0)
.s32:
0c26 : a5 0f __ LDA P2 ; (pbuf + 0)
0c28 : 85 47 __ STA T5 + 0 
0c2a : a5 0d __ LDA P0 ; (buf + 0)
0c2c : 85 49 __ STA T6 + 0 
0c2e : ae 64 3f LDX $3f64 ; (hb_len + 0)
.l1020:
0c31 : 18 __ __ CLC
0c32 : a5 10 __ LDA P3 ; (pbuf + 1)
0c34 : 65 1c __ ADC ACCU + 1 
0c36 : 85 48 __ STA T5 + 1 
0c38 : 18 __ __ CLC
0c39 : a5 0e __ LDA P1 ; (buf + 1)
0c3b : 65 44 __ ADC T3 + 1 
0c3d : 85 4a __ STA T6 + 1 
0c3f : a4 43 __ LDY T3 + 0 
0c41 : b1 49 __ LDA (T6 + 0),y 
0c43 : a4 1b __ LDY ACCU + 0 
0c45 : 91 47 __ STA (T5 + 0),y 
0c47 : e6 43 __ INC T3 + 0 
0c49 : d0 02 __ BNE $0c4d ; (hunpack.s1025 + 0)
.s1024:
0c4b : e6 44 __ INC T3 + 1 
.s1025:
0c4d : 98 __ __ TYA
0c4e : 18 __ __ CLC
0c4f : 69 01 __ ADC #$01
0c51 : 85 1b __ STA ACCU + 0 
0c53 : 90 02 __ BCC $0c57 ; (hunpack.s1027 + 0)
.s1026:
0c55 : e6 1c __ INC ACCU + 1 
.s1027:
0c57 : 8a __ __ TXA
0c58 : ca __ __ DEX
0c59 : 09 00 __ ORA #$00
0c5b : d0 d4 __ BNE $0c31 ; (hunpack.l1020 + 0)
0c5d : 4c 5a 0b JMP $0b5a ; (hunpack.s275 + 0)
--------------------------------------------------------------------
memcpy: ; memcpy(void*,const void*,i16)->void*
.s0:
0c60 : a6 12 __ LDX P5 
0c62 : f0 10 __ BEQ $0c74 ; (memcpy.s0 + 20)
0c64 : a0 00 __ LDY #$00
0c66 : b1 0f __ LDA (P2),y 
0c68 : 91 0d __ STA (P0),y ; (dst + 0)
0c6a : c8 __ __ INY
0c6b : d0 f9 __ BNE $0c66 ; (memcpy.s0 + 6)
0c6d : e6 10 __ INC P3 
0c6f : e6 0e __ INC P1 ; (dst + 1)
0c71 : ca __ __ DEX
0c72 : d0 f2 __ BNE $0c66 ; (memcpy.s0 + 6)
0c74 : a4 11 __ LDY P4 
0c76 : f0 0e __ BEQ $0c86 ; (memcpy.s0 + 38)
0c78 : 88 __ __ DEY
0c79 : f0 07 __ BEQ $0c82 ; (memcpy.s0 + 34)
0c7b : b1 0f __ LDA (P2),y 
0c7d : 91 0d __ STA (P0),y ; (dst + 0)
0c7f : 88 __ __ DEY
0c80 : d0 f9 __ BNE $0c7b ; (memcpy.s0 + 27)
0c82 : b1 0f __ LDA (P2),y 
0c84 : 91 0d __ STA (P0),y ; (dst + 0)
0c86 : a5 0d __ LDA P0 ; (dst + 0)
0c88 : 85 1b __ STA ACCU + 0 
0c8a : a5 0e __ LDA P1 ; (dst + 1)
0c8c : 85 1c __ STA ACCU + 1 
.s1001:
0c8e : 60 __ __ RTS
--------------------------------------------------------------------
memset: ; memset(void*,i16,i16)->void*
.s0:
0c8f : a5 0f __ LDA P2 
0c91 : a6 12 __ LDX P5 
0c93 : f0 0c __ BEQ $0ca1 ; (memset.s0 + 18)
0c95 : a0 00 __ LDY #$00
0c97 : 91 0d __ STA (P0),y ; (dst + 0)
0c99 : c8 __ __ INY
0c9a : d0 fb __ BNE $0c97 ; (memset.s0 + 8)
0c9c : e6 0e __ INC P1 ; (dst + 1)
0c9e : ca __ __ DEX
0c9f : d0 f6 __ BNE $0c97 ; (memset.s0 + 8)
0ca1 : a4 11 __ LDY P4 
0ca3 : f0 05 __ BEQ $0caa ; (memset.s0 + 27)
0ca5 : 88 __ __ DEY
0ca6 : 91 0d __ STA (P0),y ; (dst + 0)
0ca8 : d0 fb __ BNE $0ca5 ; (memset.s0 + 22)
0caa : a5 0d __ LDA P0 ; (dst + 0)
0cac : 85 1b __ STA ACCU + 0 
0cae : a5 0e __ LDA P1 ; (dst + 1)
0cb0 : 85 1c __ STA ACCU + 1 
.s1001:
0cb2 : 60 __ __ RTS
--------------------------------------------------------------------
do_textmode: ; do_textmode()->void
.s0:
0cb3 : ad 11 d0 LDA $d011 
0cb6 : 29 1f __ AND #$1f
0cb8 : 8d 11 d0 STA $d011 
0cbb : ad 16 d0 LDA $d016 
0cbe : 29 ef __ AND #$ef
0cc0 : 8d 16 d0 STA $d016 
0cc3 : ad 18 d0 LDA $d018 
0cc6 : 29 f0 __ AND #$f0
0cc8 : 09 06 __ ORA #$06
0cca : 8d 18 d0 STA $d018 
0ccd : ad 02 dd LDA $dd02 
0cd0 : 09 03 __ ORA #$03
0cd2 : 8d 02 dd STA $dd02 
0cd5 : ad 00 dd LDA $dd00 
0cd8 : 29 fc __ AND #$fc
0cda : 09 00 __ ORA #$00
0cdc : 8d 00 dd STA $dd00 
0cdf : ad 18 d0 LDA $d018 
0ce2 : 29 01 __ AND #$01
0ce4 : 09 d0 __ ORA #$d0
0ce6 : 09 0e __ ORA #$0e
0ce8 : 8d 18 d0 STA $d018 
.s1001:
0ceb : 60 __ __ RTS
--------------------------------------------------------------------
dos_msg: ; dos_msg(const u8*,u8)->void
.s0:
0cec : ad ef 3e LDA $3eef ; (video_ram + 0)
0cef : 18 __ __ CLC
0cf0 : 69 e0 __ ADC #$e0
0cf2 : aa __ __ TAX
0cf3 : ad f0 3e LDA $3ef0 ; (video_ram + 1)
0cf6 : 69 01 __ ADC #$01
0cf8 : a8 __ __ TAY
0cf9 : 8a __ __ TXA
0cfa : 18 __ __ CLC
0cfb : 65 0f __ ADC P2 ; (pos + 0)
0cfd : 85 45 __ STA T2 + 0 
0cff : 90 01 __ BCC $0d02 ; (dos_msg.s1008 + 0)
.s1007:
0d01 : c8 __ __ INY
.s1008:
0d02 : 84 46 __ STY T2 + 1 
0d04 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
0d07 : 18 __ __ CLC
0d08 : 69 e0 __ ADC #$e0
0d0a : aa __ __ TAX
0d0b : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
0d0e : 69 01 __ ADC #$01
0d10 : a8 __ __ TAY
0d11 : 8a __ __ TXA
0d12 : 18 __ __ CLC
0d13 : 65 0f __ ADC P2 ; (pos + 0)
0d15 : 85 43 __ STA T1 + 0 
0d17 : 90 01 __ BCC $0d1a ; (dos_msg.s1010 + 0)
.s1009:
0d19 : c8 __ __ INY
.s1010:
0d1a : 84 44 __ STY T1 + 1 
0d1c : a9 00 __ LDA #$00
0d1e : 85 1b __ STA ACCU + 0 
.l1:
0d20 : a4 1b __ LDY ACCU + 0 
0d22 : b1 0d __ LDA (P0),y ; (label + 0)
0d24 : d0 01 __ BNE $0d27 ; (dos_msg.s2 + 0)
.s1001:
0d26 : 60 __ __ RTS
.s2:
0d27 : aa __ __ TAX
0d28 : e6 1b __ INC ACCU + 0 
0d2a : e0 41 __ CPX #$41
0d2c : 90 06 __ BCC $0d34 ; (dos_msg.s6 + 0)
.s7:
0d2e : a9 5a __ LDA #$5a
0d30 : d1 0d __ CMP (P0),y ; (label + 0)
0d32 : b0 03 __ BCS $0d37 ; (dos_msg.s4 + 0)
.s6:
0d34 : 8a __ __ TXA
0d35 : 90 04 __ BCC $0d3b ; (dos_msg.s1006 + 0)
.s4:
0d37 : 8a __ __ TXA
0d38 : 18 __ __ CLC
0d39 : 69 c0 __ ADC #$c0
.s1006:
0d3b : a0 00 __ LDY #$00
0d3d : 91 45 __ STA (T2 + 0),y 
0d3f : a9 07 __ LDA #$07
0d41 : 91 43 __ STA (T1 + 0),y 
0d43 : e6 45 __ INC T2 + 0 
0d45 : d0 02 __ BNE $0d49 ; (dos_msg.s1012 + 0)
.s1011:
0d47 : e6 46 __ INC T2 + 1 
.s1012:
0d49 : e6 43 __ INC T1 + 0 
0d4b : d0 d3 __ BNE $0d20 ; (dos_msg.l1 + 0)
.s1013:
0d4d : e6 44 __ INC T1 + 1 
0d4f : 4c 20 0d JMP $0d20 ; (dos_msg.l1 + 0)
--------------------------------------------------------------------
0d52 : __ __ __ BYT 4c 4f 41 44 49 4e 47 2e 2e 2e 00                : LOADING....
--------------------------------------------------------------------
loadcartridge: ; loadcartridge()->u8
.s0:
0d5d : a9 80 __ LDA #$80
0d5f : 8d 65 3f STA $3f65 ; (advcartridge + 0)
0d62 : a9 40 __ LDA #$40
0d64 : 8d 66 3f STA $3f66 ; (advcartridge + 1)
0d67 : 20 d6 0d JSR $0dd6 ; (irq_border_on.s0 + 0)
0d6a : a9 01 __ LDA #$01
0d6c : a6 ba __ LDX $ba 
0d6e : d0 02 __ BNE $0d72 ; (loadcartridge.s0 + 21)
0d70 : a2 08 __ LDX #$08
0d72 : a0 00 __ LDY #$00
0d74 : 20 ba ff JSR $ffba 
0d77 : a9 0c __ LDA #$0c
0d79 : a2 f3 __ LDX #$f3
0d7b : a0 3e __ LDY #$3e
0d7d : 20 bd ff JSR $ffbd 
0d80 : a9 00 __ LDA #$00
0d82 : a2 80 __ LDX #$80
0d84 : a0 40 __ LDY #$40
0d86 : 20 d5 ff JSR $ffd5 
0d89 : b0 03 __ BCS $0d8e ; (loadcartridge.s0 + 49)
0d8b : 4c 96 0d JMP $0d96 ; (loadcartridge.s0 + 57)
0d8e : 20 ec 0d JSR $0dec ; (irq_border_off.s0 + 0)
0d91 : a9 00 __ LDA #$00
0d93 : 85 1b __ STA ACCU + 0 
0d95 : 60 __ __ RTS
0d96 : 20 ec 0d JSR $0dec ; (irq_border_off.s0 + 0)
0d99 : ad 65 3f LDA $3f65 ; (advcartridge + 0)
0d9c : 85 43 __ STA T0 + 0 
0d9e : 18 __ __ CLC
0d9f : 69 02 __ ADC #$02
0da1 : 8d 65 3f STA $3f65 ; (advcartridge + 0)
0da4 : ad 66 3f LDA $3f66 ; (advcartridge + 1)
0da7 : 85 44 __ STA T0 + 1 
0da9 : 69 00 __ ADC #$00
0dab : 8d 66 3f STA $3f66 ; (advcartridge + 1)
0dae : a0 01 __ LDY #$01
0db0 : b1 43 __ LDA (T0 + 0),y 
0db2 : 85 14 __ STA P7 
0db4 : 18 __ __ CLC
0db5 : 88 __ __ DEY
0db6 : b1 43 __ LDA (T0 + 0),y 
0db8 : 85 13 __ STA P6 
0dba : 6d 65 3f ADC $3f65 ; (advcartridge + 0)
0dbd : 8d 67 3f STA $3f67 ; (tmp2 + 0)
0dc0 : ad 66 3f LDA $3f66 ; (advcartridge + 1)
0dc3 : 65 14 __ ADC P7 
0dc5 : 8d 68 3f STA $3f68 ; (tmp2 + 1)
0dc8 : a5 13 __ LDA P6 
0dca : 05 14 __ ORA P7 
0dcc : f0 05 __ BEQ $0dd3 ; (loadcartridge.s2 + 0)
.s1:
0dce : 20 f9 0d JSR $0df9 ; (setupcartridge.s0 + 0)
0dd1 : a9 01 __ LDA #$01
.s2:
0dd3 : 85 1b __ STA ACCU + 0 
.s1001:
0dd5 : 60 __ __ RTS
--------------------------------------------------------------------
irq_border_on: ; irq_border_on()->void
.s0:
0dd6 : 4c df 0d JMP $0ddf ; (irq_border_on.s0 + 9)
0dd9 : 8e 20 d0 STX $d020 
0ddc : 4c fe f6 JMP $f6fe 
0ddf : 78 __ __ SEI
0de0 : a9 d9 __ LDA #$d9
0de2 : a2 0d __ LDX #$0d
0de4 : 8d 28 03 STA $0328 
0de7 : 8e 29 03 STX $0329 
0dea : 58 __ __ CLI
.s1001:
0deb : 60 __ __ RTS
--------------------------------------------------------------------
irq_border_off: ; irq_border_off()->void
.s0:
0dec : 78 __ __ SEI
0ded : a9 ed __ LDA #$ed
0def : a2 f6 __ LDX #$f6
0df1 : 8d 28 03 STA $0328 
0df4 : 8e 29 03 STX $0329 
0df7 : 58 __ __ CLI
.s1001:
0df8 : 60 __ __ RTS
--------------------------------------------------------------------
setupcartridge: ; setupcartridge(u16)->void
.s0:
0df9 : ad 65 3f LDA $3f65 ; (advcartridge + 0)
0dfc : aa __ __ TAX
0dfd : 18 __ __ CLC
0dfe : 65 13 __ ADC P6 ; (iln + 0)
0e00 : 85 43 __ STA T1 + 0 
0e02 : ad 66 3f LDA $3f66 ; (advcartridge + 1)
0e05 : 85 1c __ STA ACCU + 1 
0e07 : 65 14 __ ADC P7 ; (iln + 1)
0e09 : 85 44 __ STA T1 + 1 
0e0b : 38 __ __ SEC
0e0c : a9 80 __ LDA #$80
0e0e : e5 43 __ SBC T1 + 0 
0e10 : 8d 69 3f STA $3f69 ; (freemem + 0)
0e13 : a9 cb __ LDA #$cb
0e15 : e5 44 __ SBC T1 + 1 
0e17 : 8d 6a 3f STA $3f6a ; (freemem + 1)
0e1a : ad 67 3f LDA $3f67 ; (tmp2 + 0)
0e1d : 85 43 __ STA T1 + 0 
0e1f : ad 68 3f LDA $3f68 ; (tmp2 + 1)
0e22 : 85 44 __ STA T1 + 1 
0e24 : a0 02 __ LDY #$02
0e26 : b1 43 __ LDA (T1 + 0),y 
0e28 : 8d 6b 3f STA $3f6b ; (opcode_vrbidx_count + 0)
0e2b : a0 04 __ LDY #$04
0e2d : b1 43 __ LDA (T1 + 0),y 
0e2f : 8d 6c 3f STA $3f6c ; (obj_count + 0)
0e32 : 8a __ __ TXA
0e33 : 18 __ __ CLC
0e34 : a0 0a __ LDY #$0a
0e36 : 71 43 __ ADC (T1 + 0),y 
0e38 : 8d 6d 3f STA $3f6d ; (shortdict + 0)
0e3b : a5 1c __ LDA ACCU + 1 
0e3d : c8 __ __ INY
0e3e : 71 43 __ ADC (T1 + 0),y 
0e40 : 8d 6e 3f STA $3f6e ; (shortdict + 1)
0e43 : 8a __ __ TXA
0e44 : 18 __ __ CLC
0e45 : c8 __ __ INY
0e46 : 71 43 __ ADC (T1 + 0),y 
0e48 : 8d 6f 3f STA $3f6f ; (advnames + 0)
0e4b : a5 1c __ LDA ACCU + 1 
0e4d : c8 __ __ INY
0e4e : 71 43 __ ADC (T1 + 0),y 
0e50 : 8d 70 3f STA $3f70 ; (advnames + 1)
0e53 : 8a __ __ TXA
0e54 : 18 __ __ CLC
0e55 : c8 __ __ INY
0e56 : 71 43 __ ADC (T1 + 0),y 
0e58 : 8d 71 3f STA $3f71 ; (advdesc + 0)
0e5b : a5 1c __ LDA ACCU + 1 
0e5d : c8 __ __ INY
0e5e : 71 43 __ ADC (T1 + 0),y 
0e60 : 8d 72 3f STA $3f72 ; (advdesc + 1)
0e63 : 8a __ __ TXA
0e64 : 18 __ __ CLC
0e65 : c8 __ __ INY
0e66 : 71 43 __ ADC (T1 + 0),y 
0e68 : 8d 73 3f STA $3f73 ; (msgs + 0)
0e6b : a5 1c __ LDA ACCU + 1 
0e6d : c8 __ __ INY
0e6e : 71 43 __ ADC (T1 + 0),y 
0e70 : 8d 74 3f STA $3f74 ; (msgs + 1)
0e73 : 8a __ __ TXA
0e74 : 18 __ __ CLC
0e75 : c8 __ __ INY
0e76 : 71 43 __ ADC (T1 + 0),y 
0e78 : 8d 75 3f STA $3f75 ; (msgs2 + 0)
0e7b : a5 1c __ LDA ACCU + 1 
0e7d : c8 __ __ INY
0e7e : 71 43 __ ADC (T1 + 0),y 
0e80 : 8d 76 3f STA $3f76 ; (msgs2 + 1)
0e83 : 8a __ __ TXA
0e84 : 18 __ __ CLC
0e85 : c8 __ __ INY
0e86 : 71 43 __ ADC (T1 + 0),y 
0e88 : 8d 77 3f STA $3f77 ; (verbs + 0)
0e8b : a5 1c __ LDA ACCU + 1 
0e8d : c8 __ __ INY
0e8e : 71 43 __ ADC (T1 + 0),y 
0e90 : 8d 78 3f STA $3f78 ; (verbs + 1)
0e93 : 8a __ __ TXA
0e94 : 18 __ __ CLC
0e95 : c8 __ __ INY
0e96 : 71 43 __ ADC (T1 + 0),y 
0e98 : 8d 79 3f STA $3f79 ; (objs + 0)
0e9b : a5 1c __ LDA ACCU + 1 
0e9d : c8 __ __ INY
0e9e : 71 43 __ ADC (T1 + 0),y 
0ea0 : 8d 7a 3f STA $3f7a ; (objs + 1)
0ea3 : 8a __ __ TXA
0ea4 : 18 __ __ CLC
0ea5 : c8 __ __ INY
0ea6 : 71 43 __ ADC (T1 + 0),y 
0ea8 : 8d 7b 3f STA $3f7b ; (objs_dir + 0)
0eab : a5 1c __ LDA ACCU + 1 
0ead : c8 __ __ INY
0eae : 71 43 __ ADC (T1 + 0),y 
0eb0 : 8d 7c 3f STA $3f7c ; (objs_dir + 1)
0eb3 : 8a __ __ TXA
0eb4 : 18 __ __ CLC
0eb5 : c8 __ __ INY
0eb6 : 71 43 __ ADC (T1 + 0),y 
0eb8 : 8d 7d 3f STA $3f7d ; (rooms + 0)
0ebb : a5 1c __ LDA ACCU + 1 
0ebd : c8 __ __ INY
0ebe : 71 43 __ ADC (T1 + 0),y 
0ec0 : 8d 7e 3f STA $3f7e ; (rooms + 1)
0ec3 : 8a __ __ TXA
0ec4 : 18 __ __ CLC
0ec5 : c8 __ __ INY
0ec6 : 71 43 __ ADC (T1 + 0),y 
0ec8 : 8d 7f 3f STA $3f7f ; (packdata + 0)
0ecb : a5 1c __ LDA ACCU + 1 
0ecd : c8 __ __ INY
0ece : 71 43 __ ADC (T1 + 0),y 
0ed0 : 8d 80 3f STA $3f80 ; (packdata + 1)
0ed3 : 8a __ __ TXA
0ed4 : 18 __ __ CLC
0ed5 : c8 __ __ INY
0ed6 : 71 43 __ ADC (T1 + 0),y 
0ed8 : 8d 81 3f STA $3f81 ; (opcode_vrbidx_dir + 0)
0edb : a5 1c __ LDA ACCU + 1 
0edd : c8 __ __ INY
0ede : 71 43 __ ADC (T1 + 0),y 
0ee0 : 8d 82 3f STA $3f82 ; (opcode_vrbidx_dir + 1)
0ee3 : 8a __ __ TXA
0ee4 : 18 __ __ CLC
0ee5 : c8 __ __ INY
0ee6 : 71 43 __ ADC (T1 + 0),y 
0ee8 : 8d 83 3f STA $3f83 ; (opcode_vrbidx_data + 0)
0eeb : a5 1c __ LDA ACCU + 1 
0eed : c8 __ __ INY
0eee : 71 43 __ ADC (T1 + 0),y 
0ef0 : 8d 84 3f STA $3f84 ; (opcode_vrbidx_data + 1)
0ef3 : 8a __ __ TXA
0ef4 : 18 __ __ CLC
0ef5 : c8 __ __ INY
0ef6 : 71 43 __ ADC (T1 + 0),y 
0ef8 : 8d 85 3f STA $3f85 ; (opcode_pos + 0)
0efb : a5 1c __ LDA ACCU + 1 
0efd : c8 __ __ INY
0efe : 71 43 __ ADC (T1 + 0),y 
0f00 : 8d 86 3f STA $3f86 ; (opcode_pos + 1)
0f03 : 8a __ __ TXA
0f04 : 18 __ __ CLC
0f05 : c8 __ __ INY
0f06 : 71 43 __ ADC (T1 + 0),y 
0f08 : 8d 87 3f STA $3f87 ; (opcode_len + 0)
0f0b : a5 1c __ LDA ACCU + 1 
0f0d : c8 __ __ INY
0f0e : 71 43 __ ADC (T1 + 0),y 
0f10 : 8d 88 3f STA $3f88 ; (opcode_len + 1)
0f13 : 8a __ __ TXA
0f14 : 18 __ __ CLC
0f15 : c8 __ __ INY
0f16 : 71 43 __ ADC (T1 + 0),y 
0f18 : 8d 89 3f STA $3f89 ; (opcode_data + 0)
0f1b : a5 1c __ LDA ACCU + 1 
0f1d : c8 __ __ INY
0f1e : 71 43 __ ADC (T1 + 0),y 
0f20 : 8d 8a 3f STA $3f8a ; (opcode_data + 1)
0f23 : 8a __ __ TXA
0f24 : 18 __ __ CLC
0f25 : c8 __ __ INY
0f26 : 71 43 __ ADC (T1 + 0),y 
0f28 : 8d 8b 3f STA $3f8b ; (roomnameid + 0)
0f2b : a5 1c __ LDA ACCU + 1 
0f2d : c8 __ __ INY
0f2e : 71 43 __ ADC (T1 + 0),y 
0f30 : 8d 8c 3f STA $3f8c ; (roomnameid + 1)
0f33 : 8a __ __ TXA
0f34 : 18 __ __ CLC
0f35 : c8 __ __ INY
0f36 : 71 43 __ ADC (T1 + 0),y 
0f38 : 8d 8d 3f STA $3f8d ; (roomdescid + 0)
0f3b : a5 1c __ LDA ACCU + 1 
0f3d : c8 __ __ INY
0f3e : 71 43 __ ADC (T1 + 0),y 
0f40 : 8d 8e 3f STA $3f8e ; (roomdescid + 1)
0f43 : 8a __ __ TXA
0f44 : 18 __ __ CLC
0f45 : c8 __ __ INY
0f46 : 71 43 __ ADC (T1 + 0),y 
0f48 : 8d 8f 3f STA $3f8f ; (roomimg + 0)
0f4b : a5 1c __ LDA ACCU + 1 
0f4d : c8 __ __ INY
0f4e : 71 43 __ ADC (T1 + 0),y 
0f50 : 8d 90 3f STA $3f90 ; (roomimg + 1)
0f53 : 8a __ __ TXA
0f54 : 18 __ __ CLC
0f55 : c8 __ __ INY
0f56 : 71 43 __ ADC (T1 + 0),y 
0f58 : 85 45 __ STA T2 + 0 
0f5a : a5 1c __ LDA ACCU + 1 
0f5c : c8 __ __ INY
0f5d : 71 43 __ ADC (T1 + 0),y 
0f5f : 85 46 __ STA T2 + 1 
0f61 : 8d 92 3f STA $3f92 ; (roomovrimg + 1)
0f64 : a5 45 __ LDA T2 + 0 
0f66 : 8d 91 3f STA $3f91 ; (roomovrimg + 0)
0f69 : 8a __ __ TXA
0f6a : 18 __ __ CLC
0f6b : c8 __ __ INY
0f6c : 71 43 __ ADC (T1 + 0),y 
0f6e : 8d 93 3f STA $3f93 ; (objnameid + 0)
0f71 : a5 1c __ LDA ACCU + 1 
0f73 : c8 __ __ INY
0f74 : 71 43 __ ADC (T1 + 0),y 
0f76 : 8d 94 3f STA $3f94 ; (objnameid + 1)
0f79 : 8a __ __ TXA
0f7a : 18 __ __ CLC
0f7b : c8 __ __ INY
0f7c : 71 43 __ ADC (T1 + 0),y 
0f7e : 8d 95 3f STA $3f95 ; (objdescid + 0)
0f81 : a5 1c __ LDA ACCU + 1 
0f83 : c8 __ __ INY
0f84 : 71 43 __ ADC (T1 + 0),y 
0f86 : 8d 96 3f STA $3f96 ; (objdescid + 1)
0f89 : 8a __ __ TXA
0f8a : 18 __ __ CLC
0f8b : a0 36 __ LDY #$36
0f8d : 71 43 __ ADC (T1 + 0),y 
0f8f : 85 0f __ STA P2 
0f91 : a5 1c __ LDA ACCU + 1 
0f93 : c8 __ __ INY
0f94 : 71 43 __ ADC (T1 + 0),y 
0f96 : 85 10 __ STA P3 
0f98 : 8d 98 3f STA $3f98 ; (objattr + 1)
0f9b : a5 0f __ LDA P2 
0f9d : 8d 97 3f STA $3f97 ; (objattr + 0)
0fa0 : 8a __ __ TXA
0fa1 : 18 __ __ CLC
0fa2 : c8 __ __ INY
0fa3 : 71 43 __ ADC (T1 + 0),y 
0fa5 : 8d 99 3f STA $3f99 ; (objloc + 0)
0fa8 : a5 1c __ LDA ACCU + 1 
0faa : c8 __ __ INY
0fab : 71 43 __ ADC (T1 + 0),y 
0fad : 8d 9a 3f STA $3f9a ; (objloc + 1)
0fb0 : 8a __ __ TXA
0fb1 : 18 __ __ CLC
0fb2 : c8 __ __ INY
0fb3 : 71 43 __ ADC (T1 + 0),y 
0fb5 : 85 47 __ STA T5 + 0 
0fb7 : a5 1c __ LDA ACCU + 1 
0fb9 : c8 __ __ INY
0fba : 71 43 __ ADC (T1 + 0),y 
0fbc : 85 48 __ STA T5 + 1 
0fbe : 8d 9c 3f STA $3f9c ; (objattrex + 1)
0fc1 : a5 47 __ LDA T5 + 0 
0fc3 : 8d 9b 3f STA $3f9b ; (objattrex + 0)
0fc6 : 8a __ __ TXA
0fc7 : 18 __ __ CLC
0fc8 : c8 __ __ INY
0fc9 : 71 43 __ ADC (T1 + 0),y 
0fcb : 8d 9d 3f STA $3f9d ; (roomstart + 0)
0fce : a5 1c __ LDA ACCU + 1 
0fd0 : c8 __ __ INY
0fd1 : 71 43 __ ADC (T1 + 0),y 
0fd3 : 8d 9e 3f STA $3f9e ; (roomstart + 1)
0fd6 : 8a __ __ TXA
0fd7 : 18 __ __ CLC
0fd8 : c8 __ __ INY
0fd9 : 71 43 __ ADC (T1 + 0),y 
0fdb : 85 49 __ STA T6 + 0 
0fdd : a5 1c __ LDA ACCU + 1 
0fdf : c8 __ __ INY
0fe0 : 71 43 __ ADC (T1 + 0),y 
0fe2 : 85 4a __ STA T6 + 1 
0fe4 : 8d a0 3f STA $3fa0 ; (roomattr + 1)
0fe7 : a5 49 __ LDA T6 + 0 
0fe9 : 8d 9f 3f STA $3f9f ; (roomattr + 0)
0fec : 8a __ __ TXA
0fed : 18 __ __ CLC
0fee : c8 __ __ INY
0fef : 71 43 __ ADC (T1 + 0),y 
0ff1 : 85 4b __ STA T7 + 0 
0ff3 : a5 1c __ LDA ACCU + 1 
0ff5 : c8 __ __ INY
0ff6 : 71 43 __ ADC (T1 + 0),y 
0ff8 : 85 4c __ STA T7 + 1 
0ffa : 8d a2 3f STA $3fa2 ; (roomattrex + 1)
0ffd : a5 4b __ LDA T7 + 0 
0fff : 8d a1 3f STA $3fa1 ; (roomattrex + 0)
1002 : 8a __ __ TXA
1003 : 18 __ __ CLC
1004 : c8 __ __ INY
1005 : 71 43 __ ADC (T1 + 0),y 
1007 : 85 4d __ STA T8 + 0 
1009 : a5 1c __ LDA ACCU + 1 
100b : c8 __ __ INY
100c : 71 43 __ ADC (T1 + 0),y 
100e : 85 4e __ STA T8 + 1 
1010 : 8d a4 3f STA $3fa4 ; (bitvars + 1)
1013 : a5 4d __ LDA T8 + 0 
1015 : 8d a3 3f STA $3fa3 ; (bitvars + 0)
1018 : 8a __ __ TXA
1019 : 18 __ __ CLC
101a : c8 __ __ INY
101b : 71 43 __ ADC (T1 + 0),y 
101d : 8d a5 3f STA $3fa5 ; (vars + 0)
1020 : a5 1c __ LDA ACCU + 1 
1022 : c8 __ __ INY
1023 : 71 43 __ ADC (T1 + 0),y 
1025 : 8d a6 3f STA $3fa6 ; (vars + 1)
1028 : 8a __ __ TXA
1029 : 18 __ __ CLC
102a : c8 __ __ INY
102b : 71 43 __ ADC (T1 + 0),y 
102d : 85 1b __ STA ACCU + 0 
102f : a5 1c __ LDA ACCU + 1 
1031 : c8 __ __ INY
1032 : 71 43 __ ADC (T1 + 0),y 
1034 : 8d a8 3f STA $3fa8 ; (imagesidx + 1)
1037 : a5 1b __ LDA ACCU + 0 
1039 : 8d a7 3f STA $3fa7 ; (imagesidx + 0)
103c : 8a __ __ TXA
103d : 18 __ __ CLC
103e : c8 __ __ INY
103f : 71 43 __ ADC (T1 + 0),y 
1041 : 8d a9 3f STA $3fa9 ; (imagesdata + 0)
1044 : aa __ __ TAX
1045 : a5 1c __ LDA ACCU + 1 
1047 : c8 __ __ INY
1048 : 71 43 __ ADC (T1 + 0),y 
104a : 8d aa 3f STA $3faa ; (imagesdata + 1)
104d : 18 __ __ CLC
104e : a5 43 __ LDA T1 + 0 
1050 : 69 4c __ ADC #$4c
1052 : 8d 67 3f STA $3f67 ; (tmp2 + 0)
1055 : a5 44 __ LDA T1 + 1 
1057 : 69 00 __ ADC #$00
1059 : 8d 68 3f STA $3f68 ; (tmp2 + 1)
105c : c8 __ __ INY
105d : b1 43 __ LDA (T1 + 0),y 
105f : 85 11 __ STA P4 
1061 : c8 __ __ INY
1062 : b1 43 __ LDA (T1 + 0),y 
1064 : 85 12 __ STA P5 
1066 : 8d ac 3f STA $3fac ; (origram_len + 1)
1069 : a5 11 __ LDA P4 
106b : 8d ab 3f STA $3fab ; (origram_len + 0)
106e : a9 00 __ LDA #$00
1070 : 85 0d __ STA P0 
1072 : a9 05 __ LDA #$05
1074 : 85 0e __ STA P1 
1076 : ad aa 3f LDA $3faa ; (imagesdata + 1)
1079 : cd a8 3f CMP $3fa8 ; (imagesidx + 1)
107c : d0 12 __ BNE $1090 ; (setupcartridge.s3 + 0)
.s1010:
107e : e4 1b __ CPX ACCU + 0 
1080 : d0 0e __ BNE $1090 ; (setupcartridge.s3 + 0)
.s1:
1082 : a9 00 __ LDA #$00
1084 : 8d a7 3f STA $3fa7 ; (imagesidx + 0)
1087 : 8d a8 3f STA $3fa8 ; (imagesidx + 1)
108a : 8d a9 3f STA $3fa9 ; (imagesdata + 0)
108d : 8d aa 3f STA $3faa ; (imagesdata + 1)
.s3:
1090 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
1093 : a9 00 __ LDA #$00
1095 : 8d ad 3f STA $3fad ; (tmp + 0)
1098 : a9 04 __ LDA #$04
109a : 8d ae 3f STA $3fae ; (tmp + 1)
109d : 8d b0 3f STA $3fb0 ; (vrb + 1)
10a0 : 8d 68 3f STA $3f68 ; (tmp2 + 1)
10a3 : a9 28 __ LDA #$28
10a5 : 8d af 3f STA $3faf ; (vrb + 0)
10a8 : a9 32 __ LDA #$32
10aa : 8d 67 3f STA $3f67 ; (tmp2 + 0)
10ad : a5 46 __ LDA T2 + 1 
10af : c5 4a __ CMP T6 + 1 
10b1 : d0 0e __ BNE $10c1 ; (setupcartridge.s9 + 0)
.s1008:
10b3 : a5 45 __ LDA T2 + 0 
10b5 : c5 49 __ CMP T6 + 0 
10b7 : d0 08 __ BNE $10c1 ; (setupcartridge.s9 + 0)
.s4:
10b9 : a9 00 __ LDA #$00
10bb : 8d 91 3f STA $3f91 ; (roomovrimg + 0)
10be : 8d 92 3f STA $3f92 ; (roomovrimg + 1)
.s9:
10c1 : a5 48 __ LDA T5 + 1 
10c3 : c5 4c __ CMP T7 + 1 
10c5 : d0 0e __ BNE $10d5 ; (setupcartridge.s12 + 0)
.s1004:
10c7 : a5 4b __ LDA T7 + 0 
10c9 : c5 47 __ CMP T5 + 0 
10cb : d0 08 __ BNE $10d5 ; (setupcartridge.s12 + 0)
.s10:
10cd : a9 00 __ LDA #$00
10cf : 8d a1 3f STA $3fa1 ; (roomattrex + 0)
10d2 : 8d a2 3f STA $3fa2 ; (roomattrex + 1)
.s12:
10d5 : a5 48 __ LDA T5 + 1 
10d7 : c5 4e __ CMP T8 + 1 
10d9 : d0 0e __ BNE $10e9 ; (setupcartridge.s1001 + 0)
.s1002:
10db : a5 47 __ LDA T5 + 0 
10dd : c5 4d __ CMP T8 + 0 
10df : d0 08 __ BNE $10e9 ; (setupcartridge.s1001 + 0)
.s13:
10e1 : a9 00 __ LDA #$00
10e3 : 8d 9b 3f STA $3f9b ; (objattrex + 0)
10e6 : 8d 9c 3f STA $3f9c ; (objattrex + 1)
.s1001:
10e9 : 60 __ __ RTS
--------------------------------------------------------------------
10ea : __ __ __ BYT 44 49 53 4b 20 45 52 52 4f 52 00                : DISK ERROR.
--------------------------------------------------------------------
puts: ; puts(const u8*)->void
.s0:
10f5 : a0 00 __ LDY #$00
10f7 : b1 0d __ LDA (P0),y 
10f9 : f0 0b __ BEQ $1106 ; (puts.s1001 + 0)
10fb : 20 07 11 JSR $1107 ; (putpch + 0)
10fe : e6 0d __ INC P0 
1100 : d0 f3 __ BNE $10f5 ; (puts.s0 + 0)
1102 : e6 0e __ INC P1 
1104 : d0 ef __ BNE $10f5 ; (puts.s0 + 0)
.s1001:
1106 : 60 __ __ RTS
--------------------------------------------------------------------
putpch: ; putpch
1107 : ae 00 3f LDX $3f00 ; (giocharmap + 0)
110a : e0 01 __ CPX #$01
110c : 90 26 __ BCC $1134 ; (putpch + 45)
110e : c9 0a __ CMP #$0a
1110 : d0 02 __ BNE $1114 ; (putpch + 13)
1112 : a9 0d __ LDA #$0d
1114 : c9 09 __ CMP #$09
1116 : f0 1f __ BEQ $1137 ; (putpch + 48)
1118 : e0 02 __ CPX #$02
111a : 90 18 __ BCC $1134 ; (putpch + 45)
111c : c9 41 __ CMP #$41
111e : 90 14 __ BCC $1134 ; (putpch + 45)
1120 : c9 7b __ CMP #$7b
1122 : b0 10 __ BCS $1134 ; (putpch + 45)
1124 : c9 61 __ CMP #$61
1126 : b0 04 __ BCS $112c ; (putpch + 37)
1128 : c9 5b __ CMP #$5b
112a : b0 08 __ BCS $1134 ; (putpch + 45)
112c : 49 20 __ EOR #$20
112e : e0 03 __ CPX #$03
1130 : f0 02 __ BEQ $1134 ; (putpch + 45)
1132 : 29 df __ AND #$df
1134 : 4c d2 ff JMP $ffd2 
1137 : 38 __ __ SEC
1138 : 20 f0 ff JSR $fff0 
113b : 98 __ __ TYA
113c : 29 03 __ AND #$03
113e : 49 03 __ EOR #$03
1140 : aa __ __ TAX
1141 : a9 20 __ LDA #$20
1143 : 20 d2 ff JSR $ffd2 
1146 : ca __ __ DEX
1147 : 10 fa __ BPL $1143 ; (putpch + 60)
1149 : 60 __ __ RTS
--------------------------------------------------------------------
114a : __ __ __ BYT 0a 50 4c 45 41 53 45 20 54 55 52 4e 20 56 49 52 : .PLEASE TURN VIR
115a : __ __ __ BYT 54 55 41 4c 20 44 45 56 49 43 45 20 4f 52 20 54 : TUAL DEVICE OR T
116a : __ __ __ BYT 52 55 45 20 45 4d 55 4c 41 54 49 4f 4e 20 4f 4e : RUE EMULATION ON
117a : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
IRQ_gfx_init: ; IRQ_gfx_init()->void
.s0:
117b : 78 __ __ SEI
117c : a0 7f __ LDY #$7f
117e : 8c 0d dc STY $dc0d 
1181 : ad 1a d0 LDA $d01a 
1184 : 09 01 __ ORA #$01
1186 : 8d 1a d0 STA $d01a 
1189 : ad 11 d0 LDA $d011 
118c : 29 7f __ AND #$7f
118e : 8d 11 d0 STA $d011 
1191 : a9 05 __ LDA #$05
1193 : 8d 12 d0 STA $d012 
1196 : a2 a2 __ LDX #$a2
1198 : a0 11 __ LDY #$11
119a : 8e 14 03 STX $0314 
119d : 8c 15 03 STY $0315 
11a0 : 58 __ __ CLI
.s1001:
11a1 : 60 __ __ RTS
--------------------------------------------------------------------
IRQ_bitmapmode: ; IRQ_bitmapmode()->void
.s0:
11a2 : a9 ff __ LDA #$ff
11a4 : 8d 19 d0 STA $d019 
11a7 : 20 bd 11 JSR $11bd ; (do_bitmapmode.s0 + 0)
11aa : a9 96 __ LDA #$96
11ac : 8d 12 d0 STA $d012 
11af : a2 f6 __ LDX #$f6
11b1 : a0 11 __ LDY #$11
11b3 : 8e 14 03 STX $0314 
11b6 : 8c 15 03 STY $0315 
11b9 : 4c 81 ea JMP $ea81 
.s1001:
11bc : 60 __ __ RTS
--------------------------------------------------------------------
do_bitmapmode: ; do_bitmapmode()->void
.s0:
11bd : ad 11 d0 LDA $d011 
11c0 : 29 1f __ AND #$1f
11c2 : 09 20 __ ORA #$20
11c4 : 8d 11 d0 STA $d011 
11c7 : ad 16 d0 LDA $d016 
11ca : 09 10 __ ORA #$10
11cc : 8d 16 d0 STA $d016 
11cf : ad 18 d0 LDA $d018 
11d2 : 29 f0 __ AND #$f0
11d4 : 09 08 __ ORA #$08
11d6 : 8d 18 d0 STA $d018 
11d9 : ad 02 dd LDA $dd02 
11dc : 09 03 __ ORA #$03
11de : 8d 02 dd STA $dd02 
11e1 : ad 00 dd LDA $dd00 
11e4 : 29 fc __ AND #$fc
11e6 : 09 00 __ ORA #$00
11e8 : 8d 00 dd STA $dd00 
11eb : ad 18 d0 LDA $d018 
11ee : 29 0f __ AND #$0f
11f0 : 09 c0 __ ORA #$c0
11f2 : 8d 18 d0 STA $d018 
.s1001:
11f5 : 60 __ __ RTS
--------------------------------------------------------------------
IRQ_textmode: ; IRQ_textmode()->void
.s0:
11f6 : a9 ff __ LDA #$ff
11f8 : 8d 19 d0 STA $d019 
11fb : 20 b3 0c JSR $0cb3 ; (do_textmode.s0 + 0)
11fe : a9 05 __ LDA #$05
1200 : 8d 12 d0 STA $d012 
1203 : a2 a2 __ LDX #$a2
1205 : a0 11 __ LDY #$11
1207 : 8e 14 03 STX $0314 
120a : 8c 15 03 STY $0315 
120d : 4c 81 ea JMP $ea81 
.s1001:
1210 : 60 __ __ RTS
--------------------------------------------------------------------
clean: ; clean()->void
.s0:
1211 : a9 00 __ LDA #$00
1213 : 85 0d __ STA P0 
1215 : 85 0f __ STA P2 
1217 : 85 10 __ STA P3 
1219 : 85 12 __ STA P5 
121b : a9 08 __ LDA #$08
121d : 85 11 __ STA P4 
121f : a5 01 __ LDA $01 
1221 : 85 43 __ STA T0 + 0 
1223 : a9 34 __ LDA #$34
1225 : 85 01 __ STA $01 
1227 : a9 f2 __ LDA #$f2
1229 : 85 0e __ STA P1 
122b : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
122e : a5 43 __ LDA T0 + 0 
1230 : 85 01 __ STA $01 
.s1001:
1232 : 60 __ __ RTS
--------------------------------------------------------------------
adv_start: ; adv_start()->void
.s0:
1233 : a9 01 __ LDA #$01
1235 : 8d b1 3f STA $3fb1 ; (clearfull + 0)
1238 : 20 4f 12 JSR $124f ; (ui_clear.s0 + 0)
123b : ad 9d 3f LDA $3f9d ; (roomstart + 0)
123e : 85 43 __ STA T0 + 0 
1240 : ad 9e 3f LDA $3f9e ; (roomstart + 1)
1243 : 85 44 __ STA T0 + 1 
1245 : a0 00 __ LDY #$00
1247 : b1 43 __ LDA (T0 + 0),y 
1249 : 8d b3 3f STA $3fb3 ; (newroom + 0)
124c : 4c d3 12 JMP $12d3 ; (room_load.s1000 + 0)
--------------------------------------------------------------------
ui_clear: ; ui_clear()->void
.s0:
124f : a9 00 __ LDA #$00
1251 : 8d 03 3f STA $3f03 ; (text_y + 0)
1254 : 8d b2 3f STA $3fb2 ; (al + 0)
1257 : ad b1 3f LDA $3fb1 ; (clearfull + 0)
125a : f0 3c __ BEQ $1298 ; (ui_clear.s3 + 0)
.s1:
125c : a9 20 __ LDA #$20
125e : 85 0f __ STA P2 
1260 : a9 00 __ LDA #$00
1262 : 85 10 __ STA P3 
1264 : 85 12 __ STA P5 
1266 : a9 28 __ LDA #$28
1268 : 85 11 __ STA P4 
126a : a9 08 __ LDA #$08
126c : 85 0d __ STA P0 
126e : a9 f6 __ LDA #$f6
1270 : 85 0e __ STA P1 
1272 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
1275 : a9 00 __ LDA #$00
1277 : 85 0f __ STA P2 
1279 : 85 10 __ STA P3 
127b : 85 12 __ STA P5 
127d : a9 28 __ LDA #$28
127f : 85 11 __ STA P4 
1281 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
1284 : 18 __ __ CLC
1285 : 69 08 __ ADC #$08
1287 : 85 0d __ STA P0 
1289 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
128c : 69 02 __ ADC #$02
128e : 85 0e __ STA P1 
1290 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
1293 : a9 00 __ LDA #$00
1295 : 8d b1 3f STA $3fb1 ; (clearfull + 0)
.s3:
1298 : a9 20 __ LDA #$20
129a : 85 0f __ STA P2 
129c : a9 00 __ LDA #$00
129e : 85 10 __ STA P3 
12a0 : a9 b8 __ LDA #$b8
12a2 : 85 11 __ STA P4 
12a4 : a9 01 __ LDA #$01
12a6 : 85 12 __ STA P5 
12a8 : a9 30 __ LDA #$30
12aa : 85 0d __ STA P0 
12ac : a9 f6 __ LDA #$f6
12ae : 85 0e __ STA P1 
12b0 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
12b3 : a9 00 __ LDA #$00
12b5 : 85 0f __ STA P2 
12b7 : 85 10 __ STA P3 
12b9 : a9 b8 __ LDA #$b8
12bb : 85 11 __ STA P4 
12bd : a9 01 __ LDA #$01
12bf : 85 12 __ STA P5 
12c1 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
12c4 : 18 __ __ CLC
12c5 : 69 30 __ ADC #$30
12c7 : 85 0d __ STA P0 
12c9 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
12cc : 69 02 __ ADC #$02
12ce : 85 0e __ STA P1 
12d0 : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
--------------------------------------------------------------------
room_load: ; room_load()->void
.s1000:
12d3 : a5 53 __ LDA T0 + 0 
12d5 : 8d d8 cb STA $cbd8 ; (room_load@stack + 0)
.l2:
12d8 : a9 02 __ LDA #$02
12da : 8d b4 3f STA $3fb4 ; (cmd + 0)
12dd : a9 ff __ LDA #$ff
12df : 8d b5 3f STA $3fb5 ; (obj1 + 0)
12e2 : 20 47 13 JSR $1347 ; (adv_run.s1000 + 0)
12e5 : ad b3 3f LDA $3fb3 ; (newroom + 0)
12e8 : 85 53 __ STA T0 + 0 
12ea : 8d 04 3f STA $3f04 ; (room + 0)
12ed : 20 aa 32 JSR $32aa ; (os_roomimage_load.s0 + 0)
12f0 : ad 9f 3f LDA $3f9f ; (roomattr + 0)
12f3 : 18 __ __ CLC
12f4 : 65 53 __ ADC T0 + 0 
12f6 : 85 43 __ STA T1 + 0 
12f8 : ad a0 3f LDA $3fa0 ; (roomattr + 1)
12fb : 69 00 __ ADC #$00
12fd : 85 44 __ STA T1 + 1 
12ff : a0 00 __ LDY #$00
1301 : 8c b6 3f STY $3fb6 ; (executed + 0)
1304 : b1 43 __ LDA (T1 + 0),y 
1306 : aa __ __ TAX
1307 : 29 01 __ AND #$01
1309 : d0 15 __ BNE $1320 ; (room_load.s7 + 0)
.s4:
130b : 8d b4 3f STA $3fb4 ; (cmd + 0)
130e : a9 ff __ LDA #$ff
1310 : 8d b5 3f STA $3fb5 ; (obj1 + 0)
1313 : 8a __ __ TXA
1314 : 09 01 __ ORA #$01
1316 : 91 43 __ STA (T1 + 0),y 
1318 : 20 47 13 JSR $1347 ; (adv_run.s1000 + 0)
131b : ad b6 3f LDA $3fb6 ; (executed + 0)
131e : d0 0d __ BNE $132d ; (room_load.s28 + 0)
.s7:
1320 : a9 01 __ LDA #$01
1322 : 8d b4 3f STA $3fb4 ; (cmd + 0)
1325 : a9 ff __ LDA #$ff
1327 : 8d b5 3f STA $3fb5 ; (obj1 + 0)
132a : 20 47 13 JSR $1347 ; (adv_run.s1000 + 0)
.s28:
132d : 20 3e 34 JSR $343e ; (adv_onturn.s0 + 0)
1330 : ad 51 3f LDA $3f51 ; (nextroom + 0)
1333 : c9 fa __ CMP #$fa
1335 : f0 0a __ BEQ $1341 ; (room_load.s1001 + 0)
.s10:
1337 : 8d b3 3f STA $3fb3 ; (newroom + 0)
133a : a9 fa __ LDA #$fa
133c : 8d 51 3f STA $3f51 ; (nextroom + 0)
133f : d0 97 __ BNE $12d8 ; (room_load.l2 + 0)
.s1001:
1341 : ad d8 cb LDA $cbd8 ; (room_load@stack + 0)
1344 : 85 53 __ STA T0 + 0 
1346 : 60 __ __ RTS
--------------------------------------------------------------------
adv_run: ; adv_run()->void
.s1000:
1347 : a2 04 __ LDX #$04
1349 : b5 53 __ LDA T0 + 0,x 
134b : 9d d9 cb STA $cbd9,x ; (adv_run@stack + 0)
134e : ca __ __ DEX
134f : 10 f8 __ BPL $1349 ; (adv_run.s1000 + 2)
.s0:
1351 : a9 00 __ LDA #$00
1353 : 8d b6 3f STA $3fb6 ; (executed + 0)
1356 : ad 6b 3f LDA $3f6b ; (opcode_vrbidx_count + 0)
1359 : cd b4 3f CMP $3fb4 ; (cmd + 0)
135c : b0 03 __ BCS $1361 ; (adv_run.s3 + 0)
.s1:
135e : 8d b4 3f STA $3fb4 ; (cmd + 0)
.s3:
1361 : ad b4 3f LDA $3fb4 ; (cmd + 0)
1364 : 0a __ __ ASL
1365 : 85 54 __ STA T2 + 0 
1367 : a9 00 __ LDA #$00
1369 : 2a __ __ ROL
136a : aa __ __ TAX
136b : ad 81 3f LDA $3f81 ; (opcode_vrbidx_dir + 0)
136e : 65 54 __ ADC T2 + 0 
1370 : 85 54 __ STA T2 + 0 
1372 : 8a __ __ TXA
1373 : 6d 82 3f ADC $3f82 ; (opcode_vrbidx_dir + 1)
1376 : 85 55 __ STA T2 + 1 
1378 : a0 00 __ LDY #$00
137a : b1 54 __ LDA (T2 + 0),y 
137c : 85 56 __ STA T3 + 0 
137e : c8 __ __ INY
137f : b1 54 __ LDA (T2 + 0),y 
1381 : 85 57 __ STA T3 + 1 
1383 : c8 __ __ INY
1384 : b1 54 __ LDA (T2 + 0),y 
1386 : aa __ __ TAX
1387 : c8 __ __ INY
1388 : b1 54 __ LDA (T2 + 0),y 
138a : 86 54 __ STX T2 + 0 
138c : 85 55 __ STA T2 + 1 
138e : ad 04 3f LDA $3f04 ; (room + 0)
1391 : 85 53 __ STA T0 + 0 
1393 : a5 57 __ LDA T3 + 1 
1395 : c5 55 __ CMP T2 + 1 
1397 : d0 04 __ BNE $139d ; (adv_run.l1007 + 0)
.s1006:
1399 : a5 56 __ LDA T3 + 0 
139b : c5 54 __ CMP T2 + 0 
.l1007:
139d : 90 03 __ BCC $13a2 ; (adv_run.s5 + 0)
139f : 4c 27 14 JMP $1427 ; (adv_run.s1001 + 0)
.s5:
13a2 : ad 83 3f LDA $3f83 ; (opcode_vrbidx_data + 0)
13a5 : 65 56 __ ADC T3 + 0 
13a7 : 85 44 __ STA T4 + 0 
13a9 : ad 84 3f LDA $3f84 ; (opcode_vrbidx_data + 1)
13ac : 65 57 __ ADC T3 + 1 
13ae : 85 45 __ STA T4 + 1 
13b0 : a0 00 __ LDY #$00
13b2 : b1 44 __ LDA (T4 + 0),y 
13b4 : 8d b7 3f STA $3fb7 ; (varroom + 0)
13b7 : c5 53 __ CMP T0 + 0 
13b9 : f0 07 __ BEQ $13c2 ; (adv_run.s7 + 0)
.s10:
13bb : ad b7 3f LDA $3fb7 ; (varroom + 0)
13be : c9 f6 __ CMP #$f6
13c0 : d0 4e __ BNE $1410 ; (adv_run.s23 + 0)
.s7:
13c2 : a0 01 __ LDY #$01
13c4 : b1 44 __ LDA (T4 + 0),y 
13c6 : 8d b8 3f STA $3fb8 ; (opcode + 0)
13c9 : 0a __ __ ASL
13ca : 85 47 __ STA T6 + 0 
13cc : a9 00 __ LDA #$00
13ce : 2a __ __ ROL
13cf : aa __ __ TAX
13d0 : ad 85 3f LDA $3f85 ; (opcode_pos + 0)
13d3 : 65 47 __ ADC T6 + 0 
13d5 : 85 47 __ STA T6 + 0 
13d7 : 8a __ __ TXA
13d8 : 6d 86 3f ADC $3f86 ; (opcode_pos + 1)
13db : 85 48 __ STA T6 + 1 
13dd : b1 47 __ LDA (T6 + 0),y 
13df : aa __ __ TAX
13e0 : ad 89 3f LDA $3f89 ; (opcode_data + 0)
13e3 : 18 __ __ CLC
13e4 : 88 __ __ DEY
13e5 : 71 47 __ ADC (T6 + 0),y 
13e7 : 8d b9 3f STA $3fb9 ; (pcode + 0)
13ea : 8a __ __ TXA
13eb : 6d 8a 3f ADC $3f8a ; (opcode_data + 1)
13ee : 8d ba 3f STA $3fba ; (pcode + 1)
13f1 : ad 87 3f LDA $3f87 ; (opcode_len + 0)
13f4 : 85 47 __ STA T6 + 0 
13f6 : ad 88 3f LDA $3f88 ; (opcode_len + 1)
13f9 : 85 48 __ STA T6 + 1 
13fb : ac b8 3f LDY $3fb8 ; (opcode + 0)
13fe : b1 47 __ LDA (T6 + 0),y 
1400 : 8d bb 3f STA $3fbb ; (pcodelen + 0)
1403 : a9 00 __ LDA #$00
1405 : 8d bc 3f STA $3fbc ; (pcodelen + 1)
1408 : 20 32 14 JSR $1432 ; (adv_exec.s1000 + 0)
140b : ad b6 3f LDA $3fb6 ; (executed + 0)
140e : d0 17 __ BNE $1427 ; (adv_run.s1001 + 0)
.s23:
1410 : 18 __ __ CLC
1411 : a5 56 __ LDA T3 + 0 
1413 : 69 02 __ ADC #$02
1415 : 85 56 __ STA T3 + 0 
1417 : a5 57 __ LDA T3 + 1 
1419 : 69 00 __ ADC #$00
141b : 85 57 __ STA T3 + 1 
141d : c5 55 __ CMP T2 + 1 
141f : f0 03 __ BEQ $1424 ; (adv_run.s23 + 20)
1421 : 4c 9d 13 JMP $139d ; (adv_run.l1007 + 0)
1424 : 4c 99 13 JMP $1399 ; (adv_run.s1006 + 0)
.s1001:
1427 : a2 04 __ LDX #$04
1429 : bd d9 cb LDA $cbd9,x ; (adv_run@stack + 0)
142c : 95 53 __ STA T0 + 0,x 
142e : ca __ __ DEX
142f : 10 f8 __ BPL $1429 ; (adv_run.s1001 + 2)
1431 : 60 __ __ RTS
--------------------------------------------------------------------
adv_exec: ; adv_exec()->void
.s1000:
1432 : a2 07 __ LDX #$07
1434 : b5 53 __ LDA T0 + 0,x 
1436 : 9d de cb STA $cbde,x ; (adv_exec@stack + 0)
1439 : ca __ __ DEX
143a : 10 f8 __ BPL $1434 ; (adv_exec.s1000 + 2)
.s0:
143c : a9 00 __ LDA #$00
143e : 8d bd 3f STA $3fbd ; (in + 0)
1441 : 8d be 3f STA $3fbe ; (fail + 0)
1444 : 8d 05 3f STA $3f05 ; (istack + 0)
1447 : 8d bf 3f STA $3fbf ; (used + 0)
144a : 8d c1 3f STA $3fc1 ; (i + 0)
144d : 8d c2 3f STA $3fc2 ; (i + 1)
1450 : ad b5 3f LDA $3fb5 ; (obj1 + 0)
1453 : 8d c0 3f STA $3fc0 ; (thisobj + 0)
1456 : ad bb 3f LDA $3fbb ; (pcodelen + 0)
1459 : 0d bc 3f ORA $3fbc ; (pcodelen + 1)
145c : d0 03 __ BNE $1461 ; (adv_exec.l2 + 0)
145e : 4c 47 15 JMP $1547 ; (adv_exec.s3 + 0)
.l2:
1461 : ad c1 3f LDA $3fc1 ; (i + 0)
1464 : 85 54 __ STA T1 + 0 
1466 : 18 __ __ CLC
1467 : 69 01 __ ADC #$01
1469 : 85 56 __ STA T2 + 0 
146b : 8d c1 3f STA $3fc1 ; (i + 0)
146e : ad c2 3f LDA $3fc2 ; (i + 1)
1471 : 85 55 __ STA T1 + 1 
1473 : 69 00 __ ADC #$00
1475 : 85 57 __ STA T2 + 1 
1477 : 8d c2 3f STA $3fc2 ; (i + 1)
147a : ad b9 3f LDA $3fb9 ; (pcode + 0)
147d : 85 58 __ STA T3 + 0 
147f : 18 __ __ CLC
1480 : 65 54 __ ADC T1 + 0 
1482 : 85 43 __ STA T4 + 0 
1484 : ad ba 3f LDA $3fba ; (pcode + 1)
1487 : 85 59 __ STA T3 + 1 
1489 : 65 55 __ ADC T1 + 1 
148b : 85 44 __ STA T4 + 1 
148d : a0 00 __ LDY #$00
148f : b1 43 __ LDA (T4 + 0),y 
1491 : 8d b8 3f STA $3fb8 ; (opcode + 0)
1494 : c9 88 __ CMP #$88
1496 : d0 03 __ BNE $149b ; (adv_exec.s6 + 0)
1498 : 4c 47 15 JMP $1547 ; (adv_exec.s3 + 0)
.s6:
149b : 85 53 __ STA T0 + 0 
149d : aa __ __ TAX
149e : bd 86 3e LDA $3e86,x ; (font + 532)
14a1 : 10 03 __ BPL $14a6 ; (adv_exec.s9 + 0)
14a3 : 4c 9a 1a JMP $1a9a ; (adv_exec.s8 + 0)
.s9:
14a6 : 8a __ __ TXA
14a7 : e0 92 __ CPX #$92
14a9 : d0 1f __ BNE $14ca ; (adv_exec.s366 + 0)
.s196:
14ab : c8 __ __ INY
14ac : b1 43 __ LDA (T4 + 0),y 
14ae : 85 53 __ STA T0 + 0 
14b0 : 8d c5 3f STA $3fc5 ; (var + 0)
14b3 : 18 __ __ CLC
14b4 : a5 54 __ LDA T1 + 0 
14b6 : 69 02 __ ADC #$02
14b8 : 8d c1 3f STA $3fc1 ; (i + 0)
14bb : a5 55 __ LDA T1 + 1 
14bd : 69 00 __ ADC #$00
14bf : 8d c2 3f STA $3fc2 ; (i + 1)
14c2 : ad f2 3f LDA $3ff2 ; (key + 0)
14c5 : 85 5a __ STA T5 + 0 
14c7 : 4c 5a 19 JMP $195a ; (adv_exec.s338 + 0)
.s366:
14ca : c9 92 __ CMP #$92
14cc : b0 03 __ BCS $14d1 ; (adv_exec.s367 + 0)
14ce : 4c 66 19 JMP $1966 ; (adv_exec.s368 + 0)
.s367:
14d1 : c9 96 __ CMP #$96
14d3 : d0 03 __ BNE $14d8 ; (adv_exec.s380 + 0)
14d5 : 4c de 18 JMP $18de ; (adv_exec.s336 + 0)
.s380:
14d8 : b0 03 __ BCS $14dd ; (adv_exec.s381 + 0)
14da : 4c 6c 18 JMP $186c ; (adv_exec.s382 + 0)
.s381:
14dd : c9 a0 __ CMP #$a0
14df : d0 03 __ BNE $14e4 ; (adv_exec.s386 + 0)
14e1 : 4c 02 17 JMP $1702 ; (adv_exec.s211 + 0)
.s386:
14e4 : c9 b1 __ CMP #$b1
14e6 : f0 04 __ BEQ $14ec ; (adv_exec.s295 + 0)
.s365:
14e8 : a9 01 __ LDA #$01
14ea : d0 47 __ BNE $1533 ; (adv_exec.s1292 + 0)
.s295:
14ec : c8 __ __ INY
14ed : b1 43 __ LDA (T4 + 0),y 
14ef : 8d c5 3f STA $3fc5 ; (var + 0)
14f2 : ee bd 3f INC $3fbd ; (in + 0)
14f5 : 18 __ __ CLC
14f6 : a5 54 __ LDA T1 + 0 
14f8 : 69 02 __ ADC #$02
14fa : 8d c1 3f STA $3fc1 ; (i + 0)
14fd : a5 55 __ LDA T1 + 1 
14ff : 69 00 __ ADC #$00
1501 : 8d c2 3f STA $3fc2 ; (i + 1)
1504 : cc bd 3f CPY $3fbd ; (in + 0)
1507 : b0 05 __ BCS $150e ; (adv_exec.s297 + 0)
.s296:
1509 : ad c6 3f LDA $3fc6 ; (obj2 + 0)
150c : 90 09 __ BCC $1517 ; (adv_exec.s703 + 0)
.s297:
150e : ad c5 3f LDA $3fc5 ; (var + 0)
1511 : 8d c0 3f STA $3fc0 ; (thisobj + 0)
1514 : ad b5 3f LDA $3fb5 ; (obj1 + 0)
.s703:
1517 : cd c5 3f CMP $3fc5 ; (var + 0)
151a : d0 03 __ BNE $151f ; (adv_exec.s299 + 0)
151c : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s299:
151f : c9 f9 __ CMP #$f9
1521 : d0 03 __ BNE $1526 ; (adv_exec.s303 + 0)
1523 : 4c f8 16 JMP $16f8 ; (adv_exec.s302 + 0)
.s303:
1526 : aa __ __ TAX
1527 : ad c5 3f LDA $3fc5 ; (var + 0)
152a : c9 f5 __ CMP #$f5
152c : d0 03 __ BNE $1531 ; (adv_exec.s306 + 0)
152e : 4c ea 16 JMP $16ea ; (adv_exec.s308 + 0)
.s306:
1531 : a9 02 __ LDA #$02
.s1292:
1533 : 8d be 3f STA $3fbe ; (fail + 0)
.s388:
1536 : ad be 3f LDA $3fbe ; (fail + 0)
1539 : c9 02 __ CMP #$02
153b : d0 03 __ BNE $1540 ; (adv_exec.s392 + 0)
153d : 4c 74 16 JMP $1674 ; (adv_exec.s391 + 0)
.s392:
1540 : a9 02 __ LDA #$02
1542 : cd be 3f CMP $3fbe ; (fail + 0)
1545 : 90 1e __ BCC $1565 ; (adv_exec.s418 + 0)
.s3:
1547 : ad be 3f LDA $3fbe ; (fail + 0)
154a : f0 04 __ BEQ $1550 ; (adv_exec.s466 + 0)
.s464:
154c : a9 00 __ LDA #$00
154e : f0 07 __ BEQ $1557 ; (adv_exec.s1001 + 0)
.s466:
1550 : ad bf 3f LDA $3fbf ; (used + 0)
1553 : f0 02 __ BEQ $1557 ; (adv_exec.s1001 + 0)
.s1299:
1555 : a9 01 __ LDA #$01
.s1001:
1557 : 8d b6 3f STA $3fb6 ; (executed + 0)
155a : a2 07 __ LDX #$07
155c : bd de cb LDA $cbde,x ; (adv_exec@stack + 0)
155f : 95 53 __ STA T0 + 0,x 
1561 : ca __ __ DEX
1562 : 10 f8 __ BPL $155c ; (adv_exec.s1001 + 5)
1564 : 60 __ __ RTS
.s418:
1565 : ee 05 3f INC $3f05 ; (istack + 0)
1568 : ad c2 3f LDA $3fc2 ; (i + 1)
156b : cd bc 3f CMP $3fbc ; (pcodelen + 1)
156e : d0 06 __ BNE $1576 ; (adv_exec.s1027 + 0)
.s1026:
1570 : ad c1 3f LDA $3fc1 ; (i + 0)
1573 : cd bb 3f CMP $3fbb ; (pcodelen + 0)
.s1027:
1576 : b0 65 __ BCS $15dd ; (adv_exec.s396 + 0)
.s469:
1578 : ad ba 3f LDA $3fba ; (pcode + 1)
157b : 85 55 __ STA T1 + 1 
157d : ae b9 3f LDX $3fb9 ; (pcode + 0)
.l424:
1580 : 8a __ __ TXA
1581 : 18 __ __ CLC
1582 : 6d c1 3f ADC $3fc1 ; (i + 0)
1585 : 85 58 __ STA T3 + 0 
1587 : a5 55 __ LDA T1 + 1 
1589 : 6d c2 3f ADC $3fc2 ; (i + 1)
158c : 85 59 __ STA T3 + 1 
158e : a0 00 __ LDY #$00
1590 : b1 58 __ LDA (T3 + 0),y 
1592 : c9 88 __ CMP #$88
1594 : f0 47 __ BEQ $15dd ; (adv_exec.s396 + 0)
.s422:
1596 : 8d c7 3f STA $3fc7 ; (ch + 0)
1599 : c9 8d __ CMP #$8d
159b : 90 09 __ BCC $15a6 ; (adv_exec.s426 + 0)
.s428:
159d : c9 97 __ CMP #$97
159f : b0 05 __ BCS $15a6 ; (adv_exec.s426 + 0)
.s425:
15a1 : ee 05 3f INC $3f05 ; (istack + 0)
15a4 : 90 0e __ BCC $15b4 ; (adv_exec.s427 + 0)
.s426:
15a6 : c9 85 __ CMP #$85
15a8 : d0 03 __ BNE $15ad ; (adv_exec.s430 + 0)
15aa : 4c 6a 16 JMP $166a ; (adv_exec.s429 + 0)
.s430:
15ad : c9 87 __ CMP #$87
15af : d0 03 __ BNE $15b4 ; (adv_exec.s427 + 0)
15b1 : 4c 32 16 JMP $1632 ; (adv_exec.s436 + 0)
.s427:
15b4 : 2c c7 3f BIT $3fc7 ; (ch + 0)
15b7 : 10 24 __ BPL $15dd ; (adv_exec.s396 + 0)
.s451:
15b9 : ac c7 3f LDY $3fc7 ; (ch + 0)
15bc : b9 86 3e LDA $3e86,y ; (font + 532)
15bf : 29 7f __ AND #$7f
15c1 : 18 __ __ CLC
15c2 : 6d c1 3f ADC $3fc1 ; (i + 0)
15c5 : 8d c1 3f STA $3fc1 ; (i + 0)
15c8 : a9 00 __ LDA #$00
15ca : 6d c2 3f ADC $3fc2 ; (i + 1)
15cd : 8d c2 3f STA $3fc2 ; (i + 1)
15d0 : cd bc 3f CMP $3fbc ; (pcodelen + 1)
15d3 : d0 06 __ BNE $15db ; (adv_exec.s1007 + 0)
.s1006:
15d5 : ad c1 3f LDA $3fc1 ; (i + 0)
15d8 : cd bb 3f CMP $3fbb ; (pcodelen + 0)
.s1007:
15db : 90 a3 __ BCC $1580 ; (adv_exec.l424 + 0)
.s396:
15dd : ad c1 3f LDA $3fc1 ; (i + 0)
15e0 : 85 54 __ STA T1 + 0 
15e2 : 18 __ __ CLC
15e3 : 69 01 __ ADC #$01
15e5 : 8d c1 3f STA $3fc1 ; (i + 0)
15e8 : ad c2 3f LDA $3fc2 ; (i + 1)
15eb : aa __ __ TAX
15ec : 69 00 __ ADC #$00
15ee : 8d c2 3f STA $3fc2 ; (i + 1)
15f1 : ad b9 3f LDA $3fb9 ; (pcode + 0)
15f4 : 18 __ __ CLC
15f5 : 65 54 __ ADC T1 + 0 
15f7 : 85 54 __ STA T1 + 0 
15f9 : 8a __ __ TXA
15fa : 6d ba 3f ADC $3fba ; (pcode + 1)
15fd : 85 55 __ STA T1 + 1 
15ff : a0 00 __ LDY #$00
1601 : b1 54 __ LDA (T1 + 0),y 
1603 : c9 88 __ CMP #$88
1605 : f0 22 __ BEQ $1629 ; (adv_exec.s411 + 0)
.s413:
1607 : ad be 3f LDA $3fbe ; (fail + 0)
160a : f0 03 __ BEQ $160f ; (adv_exec.s713 + 0)
160c : 4c 4c 15 JMP $154c ; (adv_exec.s464 + 0)
.s713:
160f : ad c1 3f LDA $3fc1 ; (i + 0)
1612 : 85 54 __ STA T1 + 0 
1614 : ad c2 3f LDA $3fc2 ; (i + 1)
.s1286:
1617 : cd bc 3f CMP $3fbc ; (pcodelen + 1)
161a : d0 05 __ BNE $1621 ; (adv_exec.s1003 + 0)
.s1002:
161c : a5 54 __ LDA T1 + 0 
.s1294:
161e : cd bb 3f CMP $3fbb ; (pcodelen + 0)
.s1003:
1621 : 90 03 __ BCC $1626 ; (adv_exec.s1003 + 5)
1623 : 4c 47 15 JMP $1547 ; (adv_exec.s3 + 0)
1626 : 4c 61 14 JMP $1461 ; (adv_exec.l2 + 0)
.s411:
1629 : 8c be 3f STY $3fbe ; (fail + 0)
162c : ce bd 3f DEC $3fbd ; (in + 0)
162f : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
.s436:
1632 : ad 05 3f LDA $3f05 ; (istack + 0)
1635 : c9 01 __ CMP #$01
1637 : f0 0a __ BEQ $1643 ; (adv_exec.s439 + 0)
.s440:
1639 : 09 00 __ ORA #$00
163b : f0 a0 __ BEQ $15dd ; (adv_exec.s396 + 0)
.s448:
163d : ce 05 3f DEC $3f05 ; (istack + 0)
1640 : 4c b9 15 JMP $15b9 ; (adv_exec.s451 + 0)
.s439:
1643 : ad c1 3f LDA $3fc1 ; (i + 0)
1646 : 18 __ __ CLC
1647 : 69 01 __ ADC #$01
1649 : aa __ __ TAX
164a : ad c2 3f LDA $3fc2 ; (i + 1)
164d : 69 00 __ ADC #$00
164f : cd bc 3f CMP $3fbc ; (pcodelen + 1)
1652 : d0 0d __ BNE $1661 ; (adv_exec.s432 + 0)
.s1010:
1654 : ec bb 3f CPX $3fbb ; (pcodelen + 0)
1657 : d0 08 __ BNE $1661 ; (adv_exec.s432 + 0)
.s445:
1659 : ad bf 3f LDA $3fbf ; (used + 0)
165c : d0 03 __ BNE $1661 ; (adv_exec.s432 + 0)
165e : 4c dd 15 JMP $15dd ; (adv_exec.s396 + 0)
.s432:
1661 : 8c 05 3f STY $3f05 ; (istack + 0)
1664 : 8c be 3f STY $3fbe ; (fail + 0)
1667 : 4c dd 15 JMP $15dd ; (adv_exec.s396 + 0)
.s429:
166a : ad 05 3f LDA $3f05 ; (istack + 0)
166d : c9 01 __ CMP #$01
166f : f0 f0 __ BEQ $1661 ; (adv_exec.s432 + 0)
1671 : 4c b4 15 JMP $15b4 ; (adv_exec.s427 + 0)
.s391:
1674 : ad c2 3f LDA $3fc2 ; (i + 1)
1677 : cd bc 3f CMP $3fbc ; (pcodelen + 1)
167a : d0 06 __ BNE $1682 ; (adv_exec.s1039 + 0)
.s1038:
167c : ad c1 3f LDA $3fc1 ; (i + 0)
167f : cd bb 3f CMP $3fbb ; (pcodelen + 0)
.s1039:
1682 : 90 03 __ BCC $1687 ; (adv_exec.s468 + 0)
1684 : 4c dd 15 JMP $15dd ; (adv_exec.s396 + 0)
.s468:
1687 : ad b9 3f LDA $3fb9 ; (pcode + 0)
168a : 85 54 __ STA T1 + 0 
168c : ad ba 3f LDA $3fba ; (pcode + 1)
168f : 85 55 __ STA T1 + 1 
1691 : a2 00 __ LDX #$00
.l395:
1693 : a5 54 __ LDA T1 + 0 
1695 : 6d c1 3f ADC $3fc1 ; (i + 0)
1698 : 85 58 __ STA T3 + 0 
169a : a5 55 __ LDA T1 + 1 
169c : 6d c2 3f ADC $3fc2 ; (i + 1)
169f : 85 59 __ STA T3 + 1 
16a1 : a0 00 __ LDY #$00
16a3 : b1 58 __ LDA (T3 + 0),y 
16a5 : 8d c7 3f STA $3fc7 ; (ch + 0)
16a8 : a8 __ __ TAY
16a9 : c9 88 __ CMP #$88
16ab : d0 2b __ BNE $16d8 ; (adv_exec.s398 + 0)
.s397:
16ad : 8a __ __ TXA
16ae : d0 03 __ BNE $16b3 ; (adv_exec.s400 + 0)
16b0 : 4c dd 15 JMP $15dd ; (adv_exec.s396 + 0)
.s400:
16b3 : ca __ __ DEX
.s407:
16b4 : b9 86 3e LDA $3e86,y ; (font + 532)
16b7 : 29 7f __ AND #$7f
16b9 : 18 __ __ CLC
16ba : 6d c1 3f ADC $3fc1 ; (i + 0)
16bd : 8d c1 3f STA $3fc1 ; (i + 0)
16c0 : a9 00 __ LDA #$00
16c2 : 6d c2 3f ADC $3fc2 ; (i + 1)
16c5 : 8d c2 3f STA $3fc2 ; (i + 1)
16c8 : cd bc 3f CMP $3fbc ; (pcodelen + 1)
16cb : d0 06 __ BNE $16d3 ; (adv_exec.s1031 + 0)
.s1030:
16cd : ad c1 3f LDA $3fc1 ; (i + 0)
16d0 : cd bb 3f CMP $3fbb ; (pcodelen + 0)
.s1031:
16d3 : 90 be __ BCC $1693 ; (adv_exec.l395 + 0)
16d5 : 4c dd 15 JMP $15dd ; (adv_exec.s396 + 0)
.s398:
16d8 : ad c7 3f LDA $3fc7 ; (ch + 0)
16db : c9 b1 __ CMP #$b1
16dd : d0 04 __ BNE $16e3 ; (adv_exec.s399 + 0)
.s404:
16df : e8 __ __ INX
16e0 : 4c b4 16 JMP $16b4 ; (adv_exec.s407 + 0)
.s399:
16e3 : 09 00 __ ORA #$00
16e5 : 30 cd __ BMI $16b4 ; (adv_exec.s407 + 0)
16e7 : 4c dd 15 JMP $15dd ; (adv_exec.s396 + 0)
.s308:
16ea : 8e c0 3f STX $3fc0 ; (thisobj + 0)
.s708:
16ed : ad be 3f LDA $3fbe ; (fail + 0)
16f0 : d0 03 __ BNE $16f5 ; (adv_exec.s708 + 8)
16f2 : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
16f5 : 4c 36 15 JMP $1536 ; (adv_exec.s388 + 0)
.s302:
16f8 : ad c5 3f LDA $3fc5 ; (var + 0)
16fb : c9 ff __ CMP #$ff
16fd : f0 ee __ BEQ $16ed ; (adv_exec.s708 + 0)
16ff : 4c 31 15 JMP $1531 ; (adv_exec.s306 + 0)
.s211:
1702 : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1705 : ad c5 3f LDA $3fc5 ; (var + 0)
1708 : 85 5a __ STA T5 + 0 
170a : 8d c3 3f STA $3fc3 ; (varobj + 0)
170d : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1710 : ad c5 3f LDA $3fc5 ; (var + 0)
1713 : 8d b7 3f STA $3fb7 ; (varroom + 0)
1716 : a5 53 __ LDA T0 + 0 
1718 : c9 94 __ CMP #$94
171a : d0 03 __ BNE $171f ; (adv_exec.s265 + 0)
171c : 4c ca 17 JMP $17ca ; (adv_exec.s213 + 0)
.s265:
171f : b0 03 __ BCS $1724 ; (adv_exec.s266 + 0)
1721 : 4c c3 17 JMP $17c3 ; (adv_exec.s267 + 0)
.s266:
1724 : c9 a0 __ CMP #$a0
1726 : d0 2a __ BNE $1752 ; (adv_exec.s709 + 0)
.s237:
1728 : a5 5a __ LDA T5 + 0 
172a : c9 f3 __ CMP #$f3
172c : f0 5f __ BEQ $178d ; (adv_exec.s238 + 0)
.s239:
172e : ad 99 3f LDA $3f99 ; (objloc + 0)
1731 : 85 56 __ STA T2 + 0 
1733 : ad 9a 3f LDA $3f9a ; (objloc + 1)
1736 : 85 57 __ STA T2 + 1 
1738 : ad c5 3f LDA $3fc5 ; (var + 0)
173b : a4 5a __ LDY T5 + 0 
173d : c9 f4 __ CMP #$f4
173f : f0 2f __ BEQ $1770 ; (adv_exec.s251 + 0)
.s252:
1741 : b1 56 __ LDA (T2 + 0),y 
1743 : cd c5 3f CMP $3fc5 ; (var + 0)
1746 : f0 0a __ BEQ $1752 ; (adv_exec.s709 + 0)
.s258:
1748 : a9 03 __ LDA #$03
174a : 8d be 3f STA $3fbe ; (fail + 0)
174d : a5 53 __ LDA T0 + 0 
174f : 4c 55 17 JMP $1755 ; (adv_exec.s1288 + 0)
.s709:
1752 : ad b8 3f LDA $3fb8 ; (opcode + 0)
.s1288:
1755 : c9 a0 __ CMP #$a0
1757 : d0 94 __ BNE $16ed ; (adv_exec.s708 + 0)
.s273:
1759 : ad be 3f LDA $3fbe ; (fail + 0)
175c : d0 03 __ BNE $1761 ; (adv_exec.s270 + 0)
175e : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
.s270:
1761 : ad bb 3f LDA $3fbb ; (pcodelen + 0)
1764 : 8d c1 3f STA $3fc1 ; (i + 0)
1767 : ad bc 3f LDA $3fbc ; (pcodelen + 1)
176a : 8d c2 3f STA $3fc2 ; (i + 1)
176d : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s251:
1770 : b1 56 __ LDA (T2 + 0),y 
1772 : c9 f8 __ CMP #$f8
1774 : f0 dc __ BEQ $1752 ; (adv_exec.s709 + 0)
.s255:
1776 : cd 04 3f CMP $3f04 ; (room + 0)
1779 : d0 cd __ BNE $1748 ; (adv_exec.s258 + 0)
.s260:
177b : ad 97 3f LDA $3f97 ; (objattr + 0)
177e : 85 56 __ STA T2 + 0 
1780 : ad 98 3f LDA $3f98 ; (objattr + 1)
1783 : 85 57 __ STA T2 + 1 
1785 : b1 56 __ LDA (T2 + 0),y 
1787 : 4a __ __ LSR
1788 : b0 c8 __ BCS $1752 ; (adv_exec.s709 + 0)
178a : 4c 48 17 JMP $1748 ; (adv_exec.s258 + 0)
.s238:
178d : a9 00 __ LDA #$00
178f : 8d c7 3f STA $3fc7 ; (ch + 0)
1792 : ad 6c 3f LDA $3f6c ; (obj_count + 0)
1795 : f0 1d __ BEQ $17b4 ; (adv_exec.s219 + 0)
.s472:
1797 : ad 99 3f LDA $3f99 ; (objloc + 0)
179a : 85 54 __ STA T1 + 0 
179c : ad 9a 3f LDA $3f9a ; (objloc + 1)
179f : 85 55 __ STA T1 + 1 
17a1 : ad c5 3f LDA $3fc5 ; (var + 0)
.l242:
17a4 : ac c7 3f LDY $3fc7 ; (ch + 0)
17a7 : d1 54 __ CMP (T1 + 0),y 
17a9 : f0 09 __ BEQ $17b4 ; (adv_exec.s219 + 0)
.s245:
17ab : c8 __ __ INY
17ac : 8c c7 3f STY $3fc7 ; (ch + 0)
17af : cc 6c 3f CPY $3f6c ; (obj_count + 0)
17b2 : 90 f0 __ BCC $17a4 ; (adv_exec.l242 + 0)
.s219:
17b4 : ad c7 3f LDA $3fc7 ; (ch + 0)
17b7 : cd 6c 3f CMP $3f6c ; (obj_count + 0)
17ba : d0 96 __ BNE $1752 ; (adv_exec.s709 + 0)
.s228:
17bc : a9 03 __ LDA #$03
17be : 8d be 3f STA $3fbe ; (fail + 0)
17c1 : d0 8f __ BNE $1752 ; (adv_exec.s709 + 0)
.s267:
17c3 : c9 90 __ CMP #$90
17c5 : d0 8b __ BNE $1752 ; (adv_exec.s709 + 0)
17c7 : 4c 28 17 JMP $1728 ; (adv_exec.s237 + 0)
.s213:
17ca : 18 __ __ CLC
17cb : a5 58 __ LDA T3 + 0 
17cd : 6d c1 3f ADC $3fc1 ; (i + 0)
17d0 : 85 56 __ STA T2 + 0 
17d2 : a5 59 __ LDA T3 + 1 
17d4 : 6d c2 3f ADC $3fc2 ; (i + 1)
17d7 : 85 57 __ STA T2 + 1 
17d9 : a0 00 __ LDY #$00
17db : b1 56 __ LDA (T2 + 0),y 
17dd : 8d ce 3f STA $3fce ; (varattr + 0)
17e0 : ee c1 3f INC $3fc1 ; (i + 0)
17e3 : d0 03 __ BNE $17e8 ; (adv_exec.s1308 + 0)
.s1307:
17e5 : ee c2 3f INC $3fc2 ; (i + 1)
.s1308:
17e8 : a5 5a __ LDA T5 + 0 
17ea : c9 f3 __ CMP #$f3
17ec : d0 4c __ BNE $183a ; (adv_exec.s215 + 0)
.s214:
17ee : 8c c7 3f STY $3fc7 ; (ch + 0)
17f1 : ad 6c 3f LDA $3f6c ; (obj_count + 0)
17f4 : f0 be __ BEQ $17b4 ; (adv_exec.s219 + 0)
.s471:
17f6 : ad 93 3f LDA $3f93 ; (objnameid + 0)
17f9 : 85 54 __ STA T1 + 0 
17fb : ad 94 3f LDA $3f94 ; (objnameid + 1)
17fe : 85 55 __ STA T1 + 1 
.l218:
1800 : ac c7 3f LDY $3fc7 ; (ch + 0)
1803 : b1 54 __ LDA (T1 + 0),y 
1805 : c9 ff __ CMP #$ff
1807 : f0 25 __ BEQ $182e ; (adv_exec.s220 + 0)
.s221:
1809 : ad 99 3f LDA $3f99 ; (objloc + 0)
180c : 85 58 __ STA T3 + 0 
180e : ad 9a 3f LDA $3f9a ; (objloc + 1)
1811 : 85 59 __ STA T3 + 1 
1813 : b1 58 __ LDA (T3 + 0),y 
1815 : cd b7 3f CMP $3fb7 ; (varroom + 0)
1818 : d0 14 __ BNE $182e ; (adv_exec.s220 + 0)
.s226:
181a : ad 97 3f LDA $3f97 ; (objattr + 0)
181d : 85 58 __ STA T3 + 0 
181f : ad 98 3f LDA $3f98 ; (objattr + 1)
1822 : 85 59 __ STA T3 + 1 
1824 : ad ce 3f LDA $3fce ; (varattr + 0)
1827 : 31 58 __ AND (T3 + 0),y 
1829 : cd ce 3f CMP $3fce ; (varattr + 0)
182c : f0 86 __ BEQ $17b4 ; (adv_exec.s219 + 0)
.s220:
182e : c8 __ __ INY
182f : 8c c7 3f STY $3fc7 ; (ch + 0)
1832 : cc 6c 3f CPY $3f6c ; (obj_count + 0)
1835 : 90 c9 __ BCC $1800 ; (adv_exec.l218 + 0)
1837 : 4c b4 17 JMP $17b4 ; (adv_exec.s219 + 0)
.s215:
183a : ad 99 3f LDA $3f99 ; (objloc + 0)
183d : 85 56 __ STA T2 + 0 
183f : ad 9a 3f LDA $3f9a ; (objloc + 1)
1842 : 85 57 __ STA T2 + 1 
1844 : a4 5a __ LDY T5 + 0 
1846 : b1 56 __ LDA (T2 + 0),y 
1848 : cd c5 3f CMP $3fc5 ; (var + 0)
184b : d0 17 __ BNE $1864 ; (adv_exec.s231 + 0)
.s234:
184d : ad 97 3f LDA $3f97 ; (objattr + 0)
1850 : 85 56 __ STA T2 + 0 
1852 : ad 98 3f LDA $3f98 ; (objattr + 1)
1855 : 85 57 __ STA T2 + 1 
1857 : b1 56 __ LDA (T2 + 0),y 
1859 : 2d ce 3f AND $3fce ; (varattr + 0)
185c : cd ce 3f CMP $3fce ; (varattr + 0)
185f : d0 03 __ BNE $1864 ; (adv_exec.s231 + 0)
1861 : 4c 52 17 JMP $1752 ; (adv_exec.s709 + 0)
.s231:
1864 : a9 03 __ LDA #$03
1866 : 8d be 3f STA $3fbe ; (fail + 0)
1869 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s382:
186c : e0 94 __ CPX #$94
186e : d0 03 __ BNE $1873 ; (adv_exec.s383 + 0)
1870 : 4c 02 17 JMP $1702 ; (adv_exec.s211 + 0)
.s383:
1873 : e0 94 __ CPX #$94
1875 : 90 1a __ BCC $1891 ; (adv_exec.s325 + 0)
.s285:
1877 : 20 f1 20 JSR $20f1 ; (_alignattr.s0 + 0)
187a : 20 ea 21 JSR $21ea ; (_getattrstrid.s0 + 0)
187d : a9 00 __ LDA #$00
187f : 8d cb 3f STA $3fcb ; (text_continue + 0)
1882 : ad c8 3f LDA $3fc8 ; (strid + 0)
1885 : c9 ff __ CMP #$ff
1887 : d0 03 __ BNE $188c ; (adv_exec.s197 + 0)
1889 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s197:
188c : a9 03 __ LDA #$03
188e : 4c 33 15 JMP $1533 ; (adv_exec.s1292 + 0)
.s325:
1891 : a0 01 __ LDY #$01
1893 : b1 43 __ LDA (T4 + 0),y 
1895 : 8d c3 3f STA $3fc3 ; (varobj + 0)
1898 : 18 __ __ CLC
1899 : a5 54 __ LDA T1 + 0 
189b : 69 02 __ ADC #$02
189d : 8d c1 3f STA $3fc1 ; (i + 0)
18a0 : a5 55 __ LDA T1 + 1 
18a2 : 69 00 __ ADC #$00
18a4 : 8d c2 3f STA $3fc2 ; (i + 1)
18a7 : ad c3 3f LDA $3fc3 ; (varobj + 0)
18aa : 4a __ __ LSR
18ab : 4a __ __ LSR
18ac : 4a __ __ LSR
18ad : 18 __ __ CLC
18ae : 6d a3 3f ADC $3fa3 ; (bitvars + 0)
18b1 : 85 56 __ STA T2 + 0 
18b3 : ad a4 3f LDA $3fa4 ; (bitvars + 1)
18b6 : 69 00 __ ADC #$00
18b8 : 85 57 __ STA T2 + 1 
18ba : ad c3 3f LDA $3fc3 ; (varobj + 0)
18bd : 29 07 __ AND #$07
18bf : a8 __ __ TAY
18c0 : b9 53 3f LDA $3f53,y ; (ormask + 0)
18c3 : a0 00 __ LDY #$00
18c5 : 31 56 __ AND (T2 + 0),y 
18c7 : 8d c5 3f STA $3fc5 ; (var + 0)
18ca : e0 8d __ CPX #$8d
18cc : d0 08 __ BNE $18d6 ; (adv_exec.s327 + 0)
.s326:
18ce : ad c5 3f LDA $3fc5 ; (var + 0)
18d1 : f0 b9 __ BEQ $188c ; (adv_exec.s197 + 0)
18d3 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s327:
18d6 : ad c5 3f LDA $3fc5 ; (var + 0)
18d9 : d0 b1 __ BNE $188c ; (adv_exec.s197 + 0)
18db : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s336:
18de : c8 __ __ INY
18df : b1 43 __ LDA (T4 + 0),y 
18e1 : 8d ce 3f STA $3fce ; (varattr + 0)
18e4 : 18 __ __ CLC
18e5 : a5 54 __ LDA T1 + 0 
18e7 : 69 02 __ ADC #$02
18e9 : 8d c1 3f STA $3fc1 ; (i + 0)
18ec : a5 55 __ LDA T1 + 1 
18ee : 69 00 __ ADC #$00
18f0 : 8d c2 3f STA $3fc2 ; (i + 1)
18f3 : ad ce 3f LDA $3fce ; (varattr + 0)
18f6 : 85 54 __ STA T1 + 0 
18f8 : 29 40 __ AND #$40
18fa : 8d c4 3f STA $3fc4 ; (varmode + 0)
18fd : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1900 : ad c5 3f LDA $3fc5 ; (var + 0)
1903 : 85 53 __ STA T0 + 0 
1905 : 8d c3 3f STA $3fc3 ; (varobj + 0)
1908 : a5 54 __ LDA T1 + 0 
190a : 29 80 __ AND #$80
190c : 8d c4 3f STA $3fc4 ; (varmode + 0)
190f : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1912 : ad c5 3f LDA $3fc5 ; (var + 0)
1915 : 85 5a __ STA T5 + 0 
1917 : 8d b7 3f STA $3fb7 ; (varroom + 0)
191a : a5 54 __ LDA T1 + 0 
191c : 29 3f __ AND #$3f
191e : c9 02 __ CMP #$02
1920 : d0 0c __ BNE $192e ; (adv_exec.s358 + 0)
.s348:
1922 : a5 5a __ LDA T5 + 0 
1924 : c5 53 __ CMP T0 + 0 
1926 : 90 03 __ BCC $192b ; (adv_exec.s348 + 9)
1928 : 4c 8c 18 JMP $188c ; (adv_exec.s197 + 0)
192b : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s358:
192e : 90 13 __ BCC $1943 ; (adv_exec.s360 + 0)
.s359:
1930 : c9 03 __ CMP #$03
1932 : f0 03 __ BEQ $1937 ; (adv_exec.s353 + 0)
1934 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s353:
1937 : a5 53 __ LDA T0 + 0 
1939 : c5 5a __ CMP T5 + 0 
193b : 90 03 __ BCC $1940 ; (adv_exec.s353 + 9)
193d : 4c 8c 18 JMP $188c ; (adv_exec.s197 + 0)
1940 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s360:
1943 : 09 00 __ ORA #$00
1945 : f0 13 __ BEQ $195a ; (adv_exec.s338 + 0)
.s361:
1947 : c9 01 __ CMP #$01
1949 : f0 03 __ BEQ $194e ; (adv_exec.s343 + 0)
194b : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s343:
194e : a5 53 __ LDA T0 + 0 
1950 : c5 5a __ CMP T5 + 0 
1952 : d0 03 __ BNE $1957 ; (adv_exec.s343 + 9)
1954 : 4c 8c 18 JMP $188c ; (adv_exec.s197 + 0)
1957 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s338:
195a : a5 53 __ LDA T0 + 0 
.s1287:
195c : c5 5a __ CMP T5 + 0 
195e : f0 03 __ BEQ $1963 ; (adv_exec.s1287 + 7)
1960 : 4c 8c 18 JMP $188c ; (adv_exec.s197 + 0)
1963 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s368:
1966 : c9 8e __ CMP #$8e
1968 : d0 03 __ BNE $196d ; (adv_exec.s369 + 0)
196a : 4c 53 1a JMP $1a53 ; (adv_exec.s201 + 0)
.s369:
196d : 90 03 __ BCC $1972 ; (adv_exec.s371 + 0)
196f : 4c 00 1a JMP $1a00 ; (adv_exec.s370 + 0)
.s371:
1972 : c9 87 __ CMP #$87
1974 : d0 03 __ BNE $1979 ; (adv_exec.s372 + 0)
1976 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s372:
1979 : b0 7b __ BCS $19f6 ; (adv_exec.s373 + 0)
.s374:
197b : c9 85 __ CMP #$85
197d : f0 03 __ BEQ $1982 ; (adv_exec.s174 + 0)
197f : 4c e8 14 JMP $14e8 ; (adv_exec.s365 + 0)
.s174:
1982 : 8c c5 3f STY $3fc5 ; (var + 0)
1985 : a5 57 __ LDA T2 + 1 
1987 : cd bc 3f CMP $3fbc ; (pcodelen + 1)
198a : d0 05 __ BNE $1991 ; (adv_exec.l1151 + 0)
.s1150:
198c : a5 56 __ LDA T2 + 0 
.s1295:
198e : cd bb 3f CMP $3fbb ; (pcodelen + 0)
.l1151:
1991 : 90 03 __ BCC $1996 ; (adv_exec.s176 + 0)
1993 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s176:
1996 : a5 58 __ LDA T3 + 0 
1998 : 6d c1 3f ADC $3fc1 ; (i + 0)
199b : 85 56 __ STA T2 + 0 
199d : a5 59 __ LDA T3 + 1 
199f : 6d c2 3f ADC $3fc2 ; (i + 1)
19a2 : 85 57 __ STA T2 + 1 
19a4 : b1 56 __ LDA (T2 + 0),y 
19a6 : aa __ __ TAX
19a7 : c9 8d __ CMP #$8d
19a9 : 90 0d __ BCC $19b8 ; (adv_exec.s179 + 0)
.s181:
19ab : c9 97 __ CMP #$97
19ad : b0 09 __ BCS $19b8 ; (adv_exec.s179 + 0)
.s178:
19af : ad c5 3f LDA $3fc5 ; (var + 0)
19b2 : 85 5a __ STA T5 + 0 
19b4 : e6 5a __ INC T5 + 0 
19b6 : 90 10 __ BCC $19c8 ; (adv_exec.s707 + 0)
.s179:
19b8 : c9 87 __ CMP #$87
19ba : d0 33 __ BNE $19ef ; (adv_exec.s183 + 0)
.s182:
19bc : ad c5 3f LDA $3fc5 ; (var + 0)
19bf : d0 03 __ BNE $19c4 ; (adv_exec.s185 + 0)
19c1 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s185:
19c4 : 85 5a __ STA T5 + 0 
19c6 : c6 5a __ DEC T5 + 0 
.s707:
19c8 : a5 5a __ LDA T5 + 0 
19ca : 8d c5 3f STA $3fc5 ; (var + 0)
.s180:
19cd : 8e c7 3f STX $3fc7 ; (ch + 0)
19d0 : bd 86 3e LDA $3e86,x ; (font + 532)
19d3 : 29 7f __ AND #$7f
19d5 : 18 __ __ CLC
19d6 : 6d c1 3f ADC $3fc1 ; (i + 0)
19d9 : 8d c1 3f STA $3fc1 ; (i + 0)
19dc : a9 00 __ LDA #$00
19de : 6d c2 3f ADC $3fc2 ; (i + 1)
19e1 : 8d c2 3f STA $3fc2 ; (i + 1)
19e4 : cd bc 3f CMP $3fbc ; (pcodelen + 1)
19e7 : d0 a8 __ BNE $1991 ; (adv_exec.l1151 + 0)
.s1140:
19e9 : ad c1 3f LDA $3fc1 ; (i + 0)
19ec : 4c 8e 19 JMP $198e ; (adv_exec.s1295 + 0)
.s183:
19ef : c9 88 __ CMP #$88
19f1 : d0 da __ BNE $19cd ; (adv_exec.s180 + 0)
19f3 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s373:
19f6 : e0 8d __ CPX #$8d
19f8 : d0 03 __ BNE $19fd ; (adv_exec.s373 + 7)
19fa : 4c 91 18 JMP $1891 ; (adv_exec.s325 + 0)
19fd : 4c e8 14 JMP $14e8 ; (adv_exec.s365 + 0)
.s370:
1a00 : e0 90 __ CPX #$90
1a02 : d0 03 __ BNE $1a07 ; (adv_exec.s377 + 0)
1a04 : 4c 02 17 JMP $1702 ; (adv_exec.s211 + 0)
.s377:
1a07 : c8 __ __ INY
1a08 : b1 43 __ LDA (T4 + 0),y 
1a0a : 8d c5 3f STA $3fc5 ; (var + 0)
1a0d : 18 __ __ CLC
1a0e : a5 54 __ LDA T1 + 0 
1a10 : 69 02 __ ADC #$02
1a12 : 8d c1 3f STA $3fc1 ; (i + 0)
1a15 : a5 55 __ LDA T1 + 1 
1a17 : 69 00 __ ADC #$00
1a19 : 8d c2 3f STA $3fc2 ; (i + 1)
1a1c : e0 90 __ CPX #$90
1a1e : ad c5 3f LDA $3fc5 ; (var + 0)
1a21 : 90 0b __ BCC $1a2e ; (adv_exec.s275 + 0)
.s290:
1a23 : cd 04 3f CMP $3f04 ; (room + 0)
1a26 : f0 03 __ BEQ $1a2b ; (adv_exec.s290 + 8)
1a28 : 4c 8c 18 JMP $188c ; (adv_exec.s197 + 0)
1a2b : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s275:
1a2e : c9 fe __ CMP #$fe
1a30 : d0 0a __ BNE $1a3c ; (adv_exec.s277 + 0)
.s279:
1a32 : ad f6 3f LDA $3ff6 ; (obj1k + 0)
1a35 : c9 02 __ CMP #$02
1a37 : d0 03 __ BNE $1a3c ; (adv_exec.s277 + 0)
1a39 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s277:
1a3c : ad c5 3f LDA $3fc5 ; (var + 0)
1a3f : c9 fd __ CMP #$fd
1a41 : f0 03 __ BEQ $1a46 ; (adv_exec.s283 + 0)
1a43 : 4c 8c 18 JMP $188c ; (adv_exec.s197 + 0)
.s283:
1a46 : ad f7 3f LDA $3ff7 ; (obj2k + 0)
1a49 : c9 02 __ CMP #$02
1a4b : f0 03 __ BEQ $1a50 ; (adv_exec.s283 + 10)
1a4d : 4c 8c 18 JMP $188c ; (adv_exec.s197 + 0)
1a50 : 4c ed 16 JMP $16ed ; (adv_exec.s708 + 0)
.s201:
1a53 : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1a56 : ad c5 3f LDA $3fc5 ; (var + 0)
1a59 : 8d c3 3f STA $3fc3 ; (varobj + 0)
1a5c : 18 __ __ CLC
1a5d : a5 58 __ LDA T3 + 0 
1a5f : 6d c1 3f ADC $3fc1 ; (i + 0)
1a62 : 85 56 __ STA T2 + 0 
1a64 : a5 59 __ LDA T3 + 1 
1a66 : 6d c2 3f ADC $3fc2 ; (i + 1)
1a69 : 85 57 __ STA T2 + 1 
1a6b : a0 00 __ LDY #$00
1a6d : b1 56 __ LDA (T2 + 0),y 
1a6f : 85 5a __ STA T5 + 0 
1a71 : 8d c5 3f STA $3fc5 ; (var + 0)
1a74 : ee c1 3f INC $3fc1 ; (i + 0)
1a77 : d0 03 __ BNE $1a7c ; (adv_exec.s1306 + 0)
.s1305:
1a79 : ee c2 3f INC $3fc2 ; (i + 1)
.s1306:
1a7c : ad c3 3f LDA $3fc3 ; (varobj + 0)
1a7f : c9 f9 __ CMP #$f9
1a81 : d0 03 __ BNE $1a86 ; (adv_exec.s203 + 0)
1a83 : 4c 8c 18 JMP $188c ; (adv_exec.s197 + 0)
.s203:
1a86 : ad 97 3f LDA $3f97 ; (objattr + 0)
1a89 : 85 56 __ STA T2 + 0 
1a8b : ad 98 3f LDA $3f98 ; (objattr + 1)
1a8e : 85 57 __ STA T2 + 1 
1a90 : ac c3 3f LDY $3fc3 ; (varobj + 0)
1a93 : b1 56 __ LDA (T2 + 0),y 
1a95 : 25 5a __ AND T5 + 0 
1a97 : 4c 5c 19 JMP $195c ; (adv_exec.s1287 + 0)
.s8:
1a9a : ee bf 3f INC $3fbf ; (used + 0)
1a9d : 8a __ __ TXA
1a9e : e0 9e __ CPX #$9e
1aa0 : d0 03 __ BNE $1aa5 ; (adv_exec.s121 + 0)
1aa2 : 4c 23 20 JMP $2023 ; (adv_exec.s27 + 0)
.s121:
1aa5 : c9 9e __ CMP #$9e
1aa7 : b0 03 __ BCS $1aac ; (adv_exec.s122 + 0)
1aa9 : 4c 1c 1e JMP $1e1c ; (adv_exec.s123 + 0)
.s122:
1aac : c9 a8 __ CMP #$a8
1aae : d0 35 __ BNE $1ae5 ; (adv_exec.s148 + 0)
.s78:
1ab0 : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1ab3 : ad c5 3f LDA $3fc5 ; (var + 0)
1ab6 : 8d b7 3f STA $3fb7 ; (varroom + 0)
1ab9 : 18 __ __ CLC
1aba : a5 58 __ LDA T3 + 0 
1abc : 6d c1 3f ADC $3fc1 ; (i + 0)
1abf : 85 56 __ STA T2 + 0 
1ac1 : a5 59 __ LDA T3 + 1 
1ac3 : 6d c2 3f ADC $3fc2 ; (i + 1)
1ac6 : 85 57 __ STA T2 + 1 
1ac8 : ad c1 3f LDA $3fc1 ; (i + 0)
1acb : 18 __ __ CLC
1acc : 69 01 __ ADC #$01
1ace : 85 54 __ STA T1 + 0 
1ad0 : ad c2 3f LDA $3fc2 ; (i + 1)
1ad3 : 69 00 __ ADC #$00
1ad5 : 85 55 __ STA T1 + 1 
1ad7 : a0 00 __ LDY #$00
1ad9 : b1 56 __ LDA (T2 + 0),y 
1adb : a8 __ __ TAY
1adc : ad 90 3f LDA $3f90 ; (roomimg + 1)
1adf : ae 8f 3f LDX $3f8f ; (roomimg + 0)
1ae2 : 4c 42 1c JMP $1c42 ; (adv_exec.s716 + 0)
.s148:
1ae5 : b0 03 __ BCS $1aea ; (adv_exec.s149 + 0)
1ae7 : 4c fa 1c JMP $1cfa ; (adv_exec.s150 + 0)
.s149:
1aea : c9 ad __ CMP #$ad
1aec : d0 05 __ BNE $1af3 ; (adv_exec.s162 + 0)
.s46:
1aee : a9 02 __ LDA #$02
1af0 : 4c f4 1c JMP $1cf4 ; (adv_exec.s1289 + 0)
.s162:
1af3 : b0 03 __ BCS $1af8 ; (adv_exec.s163 + 0)
1af5 : 4c 03 1c JMP $1c03 ; (adv_exec.s164 + 0)
.s163:
1af8 : c9 af __ CMP #$af
1afa : d0 03 __ BNE $1aff ; (adv_exec.s169 + 0)
1afc : 4c 8a 1b JMP $1b8a ; (adv_exec.s67 + 0)
.s169:
1aff : 90 1d __ BCC $1b1e ; (adv_exec.s94 + 0)
.s170:
1b01 : c9 b0 __ CMP #$b0
1b03 : f0 07 __ BEQ $1b0c ; (adv_exec.s60 + 0)
.s120:
1b05 : a9 01 __ LDA #$01
1b07 : 8d be 3f STA $3fbe ; (fail + 0)
1b0a : d0 03 __ BNE $1b0f ; (adv_exec.s601 + 0)
.s60:
1b0c : 20 6d 2a JSR $2a6d ; (ui_waitkey.s0 + 0)
.s601:
1b0f : a5 57 __ LDA T2 + 1 
1b11 : cd bc 3f CMP $3fbc ; (pcodelen + 1)
1b14 : f0 03 __ BEQ $1b19 ; (adv_exec.s1168 + 0)
1b16 : 4c 21 16 JMP $1621 ; (adv_exec.s1003 + 0)
.s1168:
1b19 : a5 56 __ LDA T2 + 0 
1b1b : 4c 1e 16 JMP $161e ; (adv_exec.s1294 + 0)
.s94:
1b1e : a0 01 __ LDY #$01
1b20 : b1 43 __ LDA (T4 + 0),y 
1b22 : 8d c3 3f STA $3fc3 ; (varobj + 0)
1b25 : a5 54 __ LDA T1 + 0 
1b27 : 69 02 __ ADC #$02
1b29 : 85 54 __ STA T1 + 0 
1b2b : 8d c1 3f STA $3fc1 ; (i + 0)
1b2e : a5 55 __ LDA T1 + 1 
1b30 : 69 00 __ ADC #$00
1b32 : 85 55 __ STA T1 + 1 
1b34 : 8d c2 3f STA $3fc2 ; (i + 1)
1b37 : ad c3 3f LDA $3fc3 ; (varobj + 0)
1b3a : 4a __ __ LSR
1b3b : 4a __ __ LSR
1b3c : 4a __ __ LSR
1b3d : 8d c5 3f STA $3fc5 ; (var + 0)
1b40 : ad a3 3f LDA $3fa3 ; (bitvars + 0)
1b43 : 18 __ __ CLC
1b44 : 6d c5 3f ADC $3fc5 ; (var + 0)
1b47 : 85 58 __ STA T3 + 0 
1b49 : ad a4 3f LDA $3fa4 ; (bitvars + 1)
1b4c : 69 00 __ ADC #$00
1b4e : 85 59 __ STA T3 + 1 
1b50 : ad c3 3f LDA $3fc3 ; (varobj + 0)
1b53 : 29 07 __ AND #$07
1b55 : 85 56 __ STA T2 + 0 
1b57 : ad bb 3f LDA $3fbb ; (pcodelen + 0)
1b5a : 85 45 __ STA T6 + 0 
1b5c : ad bc 3f LDA $3fbc ; (pcodelen + 1)
1b5f : 85 46 __ STA T6 + 1 
1b61 : 8a __ __ TXA
1b62 : 88 __ __ DEY
1b63 : c9 a4 __ CMP #$a4
1b65 : f0 0a __ BEQ $1b71 ; (adv_exec.s95 + 0)
.s96:
1b67 : a6 56 __ LDX T2 + 0 
1b69 : bd 5b 3f LDA $3f5b,x ; (xormask + 0)
1b6c : 31 58 __ AND (T3 + 0),y 
1b6e : 4c 78 1b JMP $1b78 ; (adv_exec.s633 + 0)
.s95:
1b71 : a6 56 __ LDX T2 + 0 
1b73 : bd 53 3f LDA $3f53,x ; (ormask + 0)
1b76 : 11 58 __ ORA (T3 + 0),y 
.s633:
1b78 : 91 58 __ STA (T3 + 0),y 
1b7a : a5 55 __ LDA T1 + 1 
1b7c : c5 46 __ CMP T6 + 1 
1b7e : f0 03 __ BEQ $1b83 ; (adv_exec.s1172 + 0)
1b80 : 4c 21 16 JMP $1621 ; (adv_exec.s1003 + 0)
.s1172:
1b83 : a5 54 __ LDA T1 + 0 
1b85 : c5 45 __ CMP T6 + 0 
1b87 : 4c 21 16 JMP $1621 ; (adv_exec.s1003 + 0)
.s67:
1b8a : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1b8d : ad c5 3f LDA $3fc5 ; (var + 0)
1b90 : 8d c3 3f STA $3fc3 ; (varobj + 0)
1b93 : 18 __ __ CLC
1b94 : a5 58 __ LDA T3 + 0 
1b96 : 6d c1 3f ADC $3fc1 ; (i + 0)
1b99 : 85 56 __ STA T2 + 0 
1b9b : a5 59 __ LDA T3 + 1 
1b9d : 6d c2 3f ADC $3fc2 ; (i + 1)
1ba0 : 85 57 __ STA T2 + 1 
1ba2 : a0 00 __ LDY #$00
1ba4 : b1 56 __ LDA (T2 + 0),y 
1ba6 : 8d c5 3f STA $3fc5 ; (var + 0)
1ba9 : ad c1 3f LDA $3fc1 ; (i + 0)
1bac : 18 __ __ CLC
1bad : 69 01 __ ADC #$01
1baf : 85 54 __ STA T1 + 0 
1bb1 : 8d c1 3f STA $3fc1 ; (i + 0)
1bb4 : ad c2 3f LDA $3fc2 ; (i + 1)
1bb7 : 69 00 __ ADC #$00
1bb9 : 85 55 __ STA T1 + 1 
1bbb : 8d c2 3f STA $3fc2 ; (i + 1)
1bbe : a5 53 __ LDA T0 + 0 
1bc0 : c9 a5 __ CMP #$a5
1bc2 : f0 25 __ BEQ $1be9 ; (adv_exec.s71 + 0)
.s73:
1bc4 : c9 af __ CMP #$af
1bc6 : f0 03 __ BEQ $1bcb ; (adv_exec.s69 + 0)
1bc8 : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
.s69:
1bcb : ad 97 3f LDA $3f97 ; (objattr + 0)
1bce : 18 __ __ CLC
1bcf : 6d c3 3f ADC $3fc3 ; (varobj + 0)
1bd2 : 85 58 __ STA T3 + 0 
1bd4 : ad 98 3f LDA $3f98 ; (objattr + 1)
1bd7 : 69 00 __ ADC #$00
1bd9 : 85 59 __ STA T3 + 1 
1bdb : a9 ff __ LDA #$ff
1bdd : 4d c5 3f EOR $3fc5 ; (var + 0)
1be0 : 31 58 __ AND (T3 + 0),y 
1be2 : 91 58 __ STA (T3 + 0),y 
.s1293:
1be4 : a5 55 __ LDA T1 + 1 
1be6 : 4c 17 16 JMP $1617 ; (adv_exec.s1286 + 0)
.s71:
1be9 : ad 97 3f LDA $3f97 ; (objattr + 0)
1bec : 18 __ __ CLC
1bed : 6d c3 3f ADC $3fc3 ; (varobj + 0)
1bf0 : 85 56 __ STA T2 + 0 
1bf2 : ad 98 3f LDA $3f98 ; (objattr + 1)
1bf5 : 69 00 __ ADC #$00
1bf7 : 85 57 __ STA T2 + 1 
1bf9 : ad c5 3f LDA $3fc5 ; (var + 0)
1bfc : 11 56 __ ORA (T2 + 0),y 
1bfe : 91 56 __ STA (T2 + 0),y 
1c00 : 4c e4 1b JMP $1be4 ; (adv_exec.s1293 + 0)
.s164:
1c03 : c9 ab __ CMP #$ab
1c05 : f0 70 __ BEQ $1c77 ; (adv_exec.s106 + 0)
.s165:
1c07 : b0 56 __ BCS $1c5f ; (adv_exec.s62 + 0)
.s167:
1c09 : c9 aa __ CMP #$aa
1c0b : f0 03 __ BEQ $1c10 ; (adv_exec.s76 + 0)
1c0d : 4c 05 1b JMP $1b05 ; (adv_exec.s120 + 0)
.s76:
1c10 : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1c13 : ad c5 3f LDA $3fc5 ; (var + 0)
1c16 : 8d b7 3f STA $3fb7 ; (varroom + 0)
1c19 : 18 __ __ CLC
1c1a : a5 58 __ LDA T3 + 0 
1c1c : 6d c1 3f ADC $3fc1 ; (i + 0)
1c1f : 85 56 __ STA T2 + 0 
1c21 : a5 59 __ LDA T3 + 1 
1c23 : 6d c2 3f ADC $3fc2 ; (i + 1)
1c26 : 85 57 __ STA T2 + 1 
1c28 : ad c1 3f LDA $3fc1 ; (i + 0)
1c2b : 18 __ __ CLC
1c2c : 69 01 __ ADC #$01
1c2e : 85 54 __ STA T1 + 0 
1c30 : ad c2 3f LDA $3fc2 ; (i + 1)
1c33 : 69 00 __ ADC #$00
1c35 : 85 55 __ STA T1 + 1 
1c37 : a0 00 __ LDY #$00
1c39 : b1 56 __ LDA (T2 + 0),y 
1c3b : a8 __ __ TAY
1c3c : ad 92 3f LDA $3f92 ; (roomovrimg + 1)
1c3f : ae 91 3f LDX $3f91 ; (roomovrimg + 0)
.s716:
1c42 : 86 56 __ STX T2 + 0 
1c44 : 85 57 __ STA T2 + 1 
1c46 : a5 54 __ LDA T1 + 0 
1c48 : 8d c1 3f STA $3fc1 ; (i + 0)
1c4b : a5 55 __ LDA T1 + 1 
1c4d : 8d c2 3f STA $3fc2 ; (i + 1)
1c50 : 98 __ __ TYA
1c51 : ac c5 3f LDY $3fc5 ; (var + 0)
1c54 : 8d c5 3f STA $3fc5 ; (var + 0)
1c57 : 91 56 __ STA (T2 + 0),y 
1c59 : 20 aa 32 JSR $32aa ; (os_roomimage_load.s0 + 0)
1c5c : 4c e4 1b JMP $1be4 ; (adv_exec.s1293 + 0)
.s62:
1c5f : a5 54 __ LDA T1 + 0 
1c61 : 69 01 __ ADC #$01
1c63 : 85 54 __ STA T1 + 0 
1c65 : 8d c1 3f STA $3fc1 ; (i + 0)
1c68 : a5 55 __ LDA T1 + 1 
1c6a : 69 00 __ ADC #$00
1c6c : 85 55 __ STA T1 + 1 
1c6e : 8d c2 3f STA $3fc2 ; (i + 1)
1c71 : 20 6b 2c JSR $2c6b ; (ui_room_update.l27 + 0)
1c74 : 4c e4 1b JMP $1be4 ; (adv_exec.s1293 + 0)
.s106:
1c77 : a0 01 __ LDY #$01
1c79 : b1 43 __ LDA (T4 + 0),y 
1c7b : 85 5a __ STA T5 + 0 
1c7d : 8d c3 3f STA $3fc3 ; (varobj + 0)
1c80 : 18 __ __ CLC
1c81 : a5 54 __ LDA T1 + 0 
1c83 : 69 02 __ ADC #$02
1c85 : 8d c1 3f STA $3fc1 ; (i + 0)
1c88 : a5 55 __ LDA T1 + 1 
1c8a : 69 00 __ ADC #$00
1c8c : 8d c2 3f STA $3fc2 ; (i + 1)
1c8f : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1c92 : a5 53 __ LDA T0 + 0 
1c94 : c9 84 __ CMP #$84
1c96 : d0 1a __ BNE $1cb2 ; (adv_exec.s114 + 0)
.s110:
1c98 : ad a5 3f LDA $3fa5 ; (vars + 0)
1c9b : 18 __ __ CLC
1c9c : 65 5a __ ADC T5 + 0 
1c9e : 85 54 __ STA T1 + 0 
1ca0 : ad a6 3f LDA $3fa6 ; (vars + 1)
1ca3 : 69 00 __ ADC #$00
1ca5 : 85 55 __ STA T1 + 1 
1ca7 : a0 00 __ LDY #$00
1ca9 : b1 54 __ LDA (T1 + 0),y 
1cab : 38 __ __ SEC
1cac : ed c5 3f SBC $3fc5 ; (var + 0)
1caf : 4c d2 1c JMP $1cd2 ; (adv_exec.s1290 + 0)
.s114:
1cb2 : b0 23 __ BCS $1cd7 ; (adv_exec.s115 + 0)
.s116:
1cb4 : c9 81 __ CMP #$81
1cb6 : f0 03 __ BEQ $1cbb ; (adv_exec.s108 + 0)
1cb8 : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
.s108:
1cbb : ad a5 3f LDA $3fa5 ; (vars + 0)
1cbe : 18 __ __ CLC
1cbf : 65 5a __ ADC T5 + 0 
1cc1 : 85 54 __ STA T1 + 0 
1cc3 : ad a6 3f LDA $3fa6 ; (vars + 1)
1cc6 : 69 00 __ ADC #$00
1cc8 : 85 55 __ STA T1 + 1 
1cca : ad c5 3f LDA $3fc5 ; (var + 0)
1ccd : 18 __ __ CLC
1cce : a0 00 __ LDY #$00
1cd0 : 71 54 __ ADC (T1 + 0),y 
.s1290:
1cd2 : 91 54 __ STA (T1 + 0),y 
1cd4 : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
.s115:
1cd7 : c9 ab __ CMP #$ab
1cd9 : f0 03 __ BEQ $1cde ; (adv_exec.s112 + 0)
1cdb : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
.s112:
1cde : a5 5a __ LDA T5 + 0 
.s717:
1ce0 : 18 __ __ CLC
1ce1 : 6d a5 3f ADC $3fa5 ; (vars + 0)
1ce4 : 85 54 __ STA T1 + 0 
1ce6 : ad a6 3f LDA $3fa6 ; (vars + 1)
.s1291:
1ce9 : 69 00 __ ADC #$00
1ceb : 85 55 __ STA T1 + 1 
1ced : ad c5 3f LDA $3fc5 ; (var + 0)
1cf0 : a0 00 __ LDY #$00
1cf2 : f0 de __ BEQ $1cd2 ; (adv_exec.s1290 + 0)
.s1289:
1cf4 : 8d 3a 3f STA $3f3a ; (quit_request + 0)
1cf7 : 4c 0f 1b JMP $1b0f ; (adv_exec.s601 + 0)
.s150:
1cfa : c9 a3 __ CMP #$a3
1cfc : d0 18 __ BNE $1d16 ; (adv_exec.s151 + 0)
.s50:
1cfe : ad 9d 3f LDA $3f9d ; (roomstart + 0)
1d01 : 85 54 __ STA T1 + 0 
1d03 : ad 9e 3f LDA $3f9e ; (roomstart + 1)
1d06 : 85 55 __ STA T1 + 1 
1d08 : ad 04 3f LDA $3f04 ; (room + 0)
1d0b : 91 54 __ STA (T1 + 0),y 
1d0d : 20 db 2a JSR $2adb ; (adv_save.s0 + 0)
1d10 : ee f1 3f INC $3ff1 ; (saved + 0)
1d13 : 4c 0f 1b JMP $1b0f ; (adv_exec.s601 + 0)
.s151:
1d16 : b0 03 __ BCS $1d1b ; (adv_exec.s152 + 0)
1d18 : 4c a6 1d JMP $1da6 ; (adv_exec.s153 + 0)
.s152:
1d1b : c9 a5 __ CMP #$a5
1d1d : d0 03 __ BNE $1d22 ; (adv_exec.s158 + 0)
1d1f : 4c 8a 1b JMP $1b8a ; (adv_exec.s67 + 0)
.s158:
1d22 : b0 03 __ BCS $1d27 ; (adv_exec.s159 + 0)
1d24 : 4c 1e 1b JMP $1b1e ; (adv_exec.s94 + 0)
.s159:
1d27 : c9 a6 __ CMP #$a6
1d29 : f0 03 __ BEQ $1d2e ; (adv_exec.s80 + 0)
1d2b : 4c 05 1b JMP $1b05 ; (adv_exec.s120 + 0)
.s80:
1d2e : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1d31 : ad c5 3f LDA $3fc5 ; (var + 0)
1d34 : 8d c3 3f STA $3fc3 ; (varobj + 0)
1d37 : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1d3a : ad c5 3f LDA $3fc5 ; (var + 0)
1d3d : 85 53 __ STA T0 + 0 
1d3f : 8d b7 3f STA $3fb7 ; (varroom + 0)
1d42 : a9 00 __ LDA #$00
1d44 : 8d c7 3f STA $3fc7 ; (ch + 0)
1d47 : 8d c5 3f STA $3fc5 ; (var + 0)
1d4a : 18 __ __ CLC
1d4b : a5 58 __ LDA T3 + 0 
1d4d : 6d c1 3f ADC $3fc1 ; (i + 0)
1d50 : 85 56 __ STA T2 + 0 
1d52 : a5 59 __ LDA T3 + 1 
1d54 : 6d c2 3f ADC $3fc2 ; (i + 1)
1d57 : 85 57 __ STA T2 + 1 
1d59 : a0 00 __ LDY #$00
1d5b : b1 56 __ LDA (T2 + 0),y 
1d5d : 8d ce 3f STA $3fce ; (varattr + 0)
1d60 : ee c1 3f INC $3fc1 ; (i + 0)
1d63 : d0 03 __ BNE $1d68 ; (adv_exec.s1304 + 0)
.s1303:
1d65 : ee c2 3f INC $3fc2 ; (i + 1)
.s1304:
1d68 : ad 6c 3f LDA $3f6c ; (obj_count + 0)
1d6b : f0 33 __ BEQ $1da0 ; (adv_exec.s83 + 0)
.s467:
1d6d : ad 99 3f LDA $3f99 ; (objloc + 0)
1d70 : 85 54 __ STA T1 + 0 
1d72 : ad 9a 3f LDA $3f9a ; (objloc + 1)
1d75 : 85 55 __ STA T1 + 1 
.l82:
1d77 : a5 53 __ LDA T0 + 0 
1d79 : ac c7 3f LDY $3fc7 ; (ch + 0)
1d7c : d1 54 __ CMP (T1 + 0),y 
1d7e : d0 17 __ BNE $1d97 ; (adv_exec.s638 + 0)
.s87:
1d80 : ad 97 3f LDA $3f97 ; (objattr + 0)
1d83 : 85 58 __ STA T3 + 0 
1d85 : ad 98 3f LDA $3f98 ; (objattr + 1)
1d88 : 85 59 __ STA T3 + 1 
1d8a : ad ce 3f LDA $3fce ; (varattr + 0)
1d8d : 31 58 __ AND (T3 + 0),y 
1d8f : cd ce 3f CMP $3fce ; (varattr + 0)
1d92 : d0 03 __ BNE $1d97 ; (adv_exec.s638 + 0)
.s84:
1d94 : ee c5 3f INC $3fc5 ; (var + 0)
.s638:
1d97 : c8 __ __ INY
1d98 : 8c c7 3f STY $3fc7 ; (ch + 0)
1d9b : cc 6c 3f CPY $3f6c ; (obj_count + 0)
1d9e : 90 d7 __ BCC $1d77 ; (adv_exec.l82 + 0)
.s83:
1da0 : ad c3 3f LDA $3fc3 ; (varobj + 0)
1da3 : 4c e0 1c JMP $1ce0 ; (adv_exec.s717 + 0)
.s153:
1da6 : e0 a1 __ CPX #$a1
1da8 : d0 22 __ BNE $1dcc ; (adv_exec.s154 + 0)
.s91:
1daa : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1dad : ad c5 3f LDA $3fc5 ; (var + 0)
1db0 : 85 53 __ STA T0 + 0 
1db2 : 8d c3 3f STA $3fc3 ; (varobj + 0)
1db5 : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1db8 : ad c5 3f LDA $3fc5 ; (var + 0)
1dbb : 8d b7 3f STA $3fb7 ; (varroom + 0)
1dbe : ad 99 3f LDA $3f99 ; (objloc + 0)
1dc1 : 18 __ __ CLC
1dc2 : 65 53 __ ADC T0 + 0 
1dc4 : 85 54 __ STA T1 + 0 
1dc6 : ad 9a 3f LDA $3f9a ; (objloc + 1)
1dc9 : 4c e9 1c JMP $1ce9 ; (adv_exec.s1291 + 0)
.s154:
1dcc : e0 a1 __ CPX #$a1
1dce : b0 47 __ BCS $1e17 ; (adv_exec.s44 + 0)
.s156:
1dd0 : e0 9f __ CPX #$9f
1dd2 : f0 03 __ BEQ $1dd7 ; (adv_exec.s13 + 0)
1dd4 : 4c 05 1b JMP $1b05 ; (adv_exec.s120 + 0)
.s13:
1dd7 : e0 9b __ CPX #$9b
1dd9 : f0 14 __ BEQ $1def ; (adv_exec.s14 + 0)
.s15:
1ddb : a9 01 __ LDA #$01
1ddd : 8d c4 3f STA $3fc4 ; (varmode + 0)
1de0 : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1de3 : ad c5 3f LDA $3fc5 ; (var + 0)
1de6 : 8d b7 3f STA $3fb7 ; (varroom + 0)
1de9 : 8d c3 3f STA $3fc3 ; (varobj + 0)
1dec : 4c f2 1d JMP $1df2 ; (adv_exec.s621 + 0)
.s14:
1def : 20 f1 20 JSR $20f1 ; (_alignattr.s0 + 0)
.s621:
1df2 : 20 ea 21 JSR $21ea ; (_getattrstrid.s0 + 0)
1df5 : ad c8 3f LDA $3fc8 ; (strid + 0)
1df8 : c9 ff __ CMP #$ff
1dfa : d0 08 __ BNE $1e04 ; (adv_exec.s18 + 0)
.s17:
1dfc : a9 01 __ LDA #$01
1dfe : 8d be 3f STA $3fbe ; (fail + 0)
1e01 : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
.s18:
1e04 : 20 a6 23 JSR $23a6 ; (_getstring.s0 + 0)
1e07 : ad d1 3f LDA $3fd1 ; (ostr + 0)
1e0a : 85 13 __ STA P6 
1e0c : ad d2 3f LDA $3fd2 ; (ostr + 1)
1e0f : 85 14 __ STA P7 
1e11 : 20 7b 24 JSR $247b ; (ui_text_write.s0 + 0)
1e14 : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
.s44:
1e17 : a9 01 __ LDA #$01
1e19 : 4c f4 1c JMP $1cf4 ; (adv_exec.s1289 + 0)
.s123:
1e1c : c9 8b __ CMP #$8b
1e1e : d0 09 __ BNE $1e29 ; (adv_exec.s124 + 0)
.s64:
1e20 : c8 __ __ INY
1e21 : b1 43 __ LDA (T4 + 0),y 
1e23 : 8d 51 3f STA $3f51 ; (nextroom + 0)
1e26 : 4c 0f 20 JMP $200f ; (adv_exec.s715 + 0)
.s124:
1e29 : b0 03 __ BCS $1e2e ; (adv_exec.s125 + 0)
1e2b : 4c 3d 1f JMP $1f3d ; (adv_exec.s126 + 0)
.s125:
1e2e : e0 9a __ CPX #$9a
1e30 : d0 07 __ BNE $1e39 ; (adv_exec.s1233 + 0)
.s1232:
1e32 : a9 01 __ LDA #$01
1e34 : 85 5a __ STA T5 + 0 
1e36 : 4c f7 1e JMP $1ef7 ; (adv_exec.s36 + 0)
.s1233:
1e39 : 84 5a __ STY T5 + 0 
1e3b : e0 9a __ CPX #$9a
1e3d : 90 6c __ BCC $1eab ; (adv_exec.s140 + 0)
.s139:
1e3f : e0 9c __ CPX #$9c
1e41 : f0 64 __ BEQ $1ea7 ; (adv_exec.s1237 + 0)
.s145:
1e43 : e0 9c __ CPX #$9c
1e45 : 90 90 __ BCC $1dd7 ; (adv_exec.s13 + 0)
.s22:
1e47 : 18 __ __ CLC
1e48 : a5 54 __ LDA T1 + 0 
1e4a : 69 02 __ ADC #$02
1e4c : 85 54 __ STA T1 + 0 
1e4e : 8d c1 3f STA $3fc1 ; (i + 0)
1e51 : a5 55 __ LDA T1 + 1 
1e53 : 69 00 __ ADC #$00
1e55 : 85 55 __ STA T1 + 1 
1e57 : 8d c2 3f STA $3fc2 ; (i + 1)
1e5a : ad 6f 3f LDA $3f6f ; (advnames + 0)
1e5d : 8d c9 3f STA $3fc9 ; (str + 0)
1e60 : ad 70 3f LDA $3f70 ; (advnames + 1)
1e63 : 8d ca 3f STA $3fca ; (str + 1)
1e66 : ad a5 3f LDA $3fa5 ; (vars + 0)
1e69 : 85 58 __ STA T3 + 0 
1e6b : ad a6 3f LDA $3fa6 ; (vars + 1)
1e6e : 85 59 __ STA T3 + 1 
1e70 : a0 01 __ LDY #$01
1e72 : b1 43 __ LDA (T4 + 0),y 
1e74 : a8 __ __ TAY
1e75 : b1 58 __ LDA (T3 + 0),y 
1e77 : a8 __ __ TAY
1e78 : a5 5a __ LDA T5 + 0 
1e7a : d0 09 __ BNE $1e85 ; (adv_exec.s23 + 0)
.s24:
1e7c : ad 8c 3f LDA $3f8c ; (roomnameid + 1)
1e7f : ae 8b 3f LDX $3f8b ; (roomnameid + 0)
1e82 : 4c 8b 1e JMP $1e8b ; (adv_exec.s720 + 0)
.s23:
1e85 : ad 94 3f LDA $3f94 ; (objnameid + 1)
1e88 : ae 93 3f LDX $3f93 ; (objnameid + 0)
.s720:
1e8b : 86 56 __ STX T2 + 0 
1e8d : 85 57 __ STA T2 + 1 
1e8f : b1 56 __ LDA (T2 + 0),y 
1e91 : 8d c8 3f STA $3fc8 ; (strid + 0)
.s719:
1e94 : 20 a6 23 JSR $23a6 ; (_getstring.s0 + 0)
1e97 : ad d1 3f LDA $3fd1 ; (ostr + 0)
1e9a : 85 13 __ STA P6 
1e9c : ad d2 3f LDA $3fd2 ; (ostr + 1)
1e9f : 85 14 __ STA P7 
.s714:
1ea1 : 20 7b 24 JSR $247b ; (ui_text_write.s0 + 0)
1ea4 : 4c e4 1b JMP $1be4 ; (adv_exec.s1293 + 0)
.s1237:
1ea7 : e6 5a __ INC T5 + 0 
1ea9 : d0 9c __ BNE $1e47 ; (adv_exec.s22 + 0)
.s140:
1eab : c9 98 __ CMP #$98
1ead : d0 05 __ BNE $1eb4 ; (adv_exec.s141 + 0)
.s48:
1eaf : a9 03 __ LDA #$03
1eb1 : 4c f4 1c JMP $1cf4 ; (adv_exec.s1289 + 0)
.s141:
1eb4 : b0 41 __ BCS $1ef7 ; (adv_exec.s36 + 0)
.s143:
1eb6 : c9 97 __ CMP #$97
1eb8 : f0 03 __ BEQ $1ebd ; (adv_exec.s89 + 0)
1eba : 4c 05 1b JMP $1b05 ; (adv_exec.s120 + 0)
.s89:
1ebd : 20 fe 20 JSR $20fe ; (_getobj.s0 + 0)
1ec0 : ad c5 3f LDA $3fc5 ; (var + 0)
1ec3 : 8d b7 3f STA $3fb7 ; (varroom + 0)
1ec6 : 18 __ __ CLC
1ec7 : a5 58 __ LDA T3 + 0 
1ec9 : 6d c1 3f ADC $3fc1 ; (i + 0)
1ecc : 85 56 __ STA T2 + 0 
1ece : a5 59 __ LDA T3 + 1 
1ed0 : 6d c2 3f ADC $3fc2 ; (i + 1)
1ed3 : 85 57 __ STA T2 + 1 
1ed5 : a0 00 __ LDY #$00
1ed7 : b1 56 __ LDA (T2 + 0),y 
1ed9 : 8d ce 3f STA $3fce ; (varattr + 0)
1edc : ad c1 3f LDA $3fc1 ; (i + 0)
1edf : 18 __ __ CLC
1ee0 : 69 01 __ ADC #$01
1ee2 : 85 54 __ STA T1 + 0 
1ee4 : 8d c1 3f STA $3fc1 ; (i + 0)
1ee7 : ad c2 3f LDA $3fc2 ; (i + 1)
1eea : 69 00 __ ADC #$00
1eec : 85 55 __ STA T1 + 1 
1eee : 8d c2 3f STA $3fc2 ; (i + 1)
1ef1 : 20 f6 32 JSR $32f6 ; (draw_roomobj.s1000 + 0)
1ef4 : 4c e4 1b JMP $1be4 ; (adv_exec.s1293 + 0)
.s36:
1ef7 : a0 01 __ LDY #$01
1ef9 : b1 43 __ LDA (T4 + 0),y 
1efb : 8d c8 3f STA $3fc8 ; (strid + 0)
1efe : 8d c5 3f STA $3fc5 ; (var + 0)
1f01 : 18 __ __ CLC
1f02 : a5 54 __ LDA T1 + 0 
1f04 : 69 02 __ ADC #$02
1f06 : 85 54 __ STA T1 + 0 
1f08 : 8d c1 3f STA $3fc1 ; (i + 0)
1f0b : a5 55 __ LDA T1 + 1 
1f0d : 69 00 __ ADC #$00
1f0f : 85 55 __ STA T1 + 1 
1f11 : 8d c2 3f STA $3fc2 ; (i + 1)
1f14 : a5 5a __ LDA T5 + 0 
1f16 : d0 09 __ BNE $1f21 ; (adv_exec.s37 + 0)
.s38:
1f18 : ad 74 3f LDA $3f74 ; (msgs + 1)
1f1b : ae 73 3f LDX $3f73 ; (msgs + 0)
1f1e : 4c 27 1f JMP $1f27 ; (adv_exec.s39 + 0)
.s37:
1f21 : ad 76 3f LDA $3f76 ; (msgs2 + 1)
1f24 : ae 75 3f LDX $3f75 ; (msgs2 + 0)
.s39:
1f27 : 8e c9 3f STX $3fc9 ; (str + 0)
1f2a : 8d ca 3f STA $3fca ; (str + 1)
1f2d : ad c8 3f LDA $3fc8 ; (strid + 0)
1f30 : c9 ff __ CMP #$ff
1f32 : f0 03 __ BEQ $1f37 ; (adv_exec.s40 + 0)
1f34 : 4c 94 1e JMP $1e94 ; (adv_exec.s719 + 0)
.s40:
1f37 : 8c be 3f STY $3fbe ; (fail + 0)
1f3a : 4c e4 1b JMP $1be4 ; (adv_exec.s1293 + 0)
.s126:
1f3d : c9 83 __ CMP #$83
1f3f : d0 2b __ BNE $1f6c ; (adv_exec.s127 + 0)
.s54:
1f41 : ad 69 3f LDA $3f69 ; (freemem + 0)
1f44 : 85 0d __ STA P0 
1f46 : ad 6a 3f LDA $3f6a ; (freemem + 1)
1f49 : 85 0e __ STA P1 
1f4b : ad ad 3f LDA $3fad ; (tmp + 0)
1f4e : 85 0f __ STA P2 
1f50 : ad ae 3f LDA $3fae ; (tmp + 1)
1f53 : 85 10 __ STA P3 
1f55 : 20 de 2b JSR $2bde ; (mini_itoa.s0 + 0)
1f58 : a5 0f __ LDA P2 
1f5a : 85 13 __ STA P6 
1f5c : 8d d1 3f STA $3fd1 ; (ostr + 0)
1f5f : a5 10 __ LDA P3 
1f61 : 85 14 __ STA P7 
1f63 : 8d d2 3f STA $3fd2 ; (ostr + 1)
1f66 : 20 7b 24 JSR $247b ; (ui_text_write.s0 + 0)
1f69 : 4c 0f 1b JMP $1b0f ; (adv_exec.s601 + 0)
.s127:
1f6c : b0 7c __ BCS $1fea ; (adv_exec.s128 + 0)
.s129:
1f6e : c9 81 __ CMP #$81
1f70 : d0 03 __ BNE $1f75 ; (adv_exec.s130 + 0)
1f72 : 4c 77 1c JMP $1c77 ; (adv_exec.s106 + 0)
.s130:
1f75 : b0 6d __ BCS $1fe4 ; (adv_exec.s56 + 0)
.s132:
1f77 : c9 80 __ CMP #$80
1f79 : f0 03 __ BEQ $1f7e ; (adv_exec.s99 + 0)
1f7b : 4c 05 1b JMP $1b05 ; (adv_exec.s120 + 0)
.s99:
1f7e : c8 __ __ INY
1f7f : b1 43 __ LDA (T4 + 0),y 
1f81 : 8d c3 3f STA $3fc3 ; (varobj + 0)
1f84 : 18 __ __ CLC
1f85 : a5 54 __ LDA T1 + 0 
1f87 : 69 02 __ ADC #$02
1f89 : 85 54 __ STA T1 + 0 
1f8b : 8d c1 3f STA $3fc1 ; (i + 0)
1f8e : a5 55 __ LDA T1 + 1 
1f90 : 69 00 __ ADC #$00
1f92 : 85 55 __ STA T1 + 1 
1f94 : 8d c2 3f STA $3fc2 ; (i + 1)
1f97 : ad c3 3f LDA $3fc3 ; (varobj + 0)
1f9a : 4a __ __ LSR
1f9b : 4a __ __ LSR
1f9c : 4a __ __ LSR
1f9d : 8d c5 3f STA $3fc5 ; (var + 0)
1fa0 : ad c3 3f LDA $3fc3 ; (varobj + 0)
1fa3 : 29 07 __ AND #$07
1fa5 : aa __ __ TAX
1fa6 : ad a3 3f LDA $3fa3 ; (bitvars + 0)
1fa9 : 18 __ __ CLC
1faa : 6d c5 3f ADC $3fc5 ; (var + 0)
1fad : 85 58 __ STA T3 + 0 
1faf : ad a4 3f LDA $3fa4 ; (bitvars + 1)
1fb2 : 69 00 __ ADC #$00
1fb4 : 85 59 __ STA T3 + 1 
1fb6 : 88 __ __ DEY
1fb7 : b1 58 __ LDA (T3 + 0),y 
1fb9 : 85 5a __ STA T5 + 0 
1fbb : 3d 53 3f AND $3f53,x ; (ormask + 0)
1fbe : 8d ce 3f STA $3fce ; (varattr + 0)
1fc1 : f0 03 __ BEQ $1fc6 ; (adv_exec.s100 + 0)
1fc3 : 4c 0f 16 JMP $160f ; (adv_exec.s713 + 0)
.s100:
1fc6 : bd 53 3f LDA $3f53,x ; (ormask + 0)
1fc9 : 05 5a __ ORA T5 + 0 
1fcb : 91 58 __ STA (T3 + 0),y 
1fcd : ad a5 3f LDA $3fa5 ; (vars + 0)
1fd0 : 85 56 __ STA T2 + 0 
1fd2 : ad a6 3f LDA $3fa6 ; (vars + 1)
1fd5 : 85 57 __ STA T2 + 1 
1fd7 : b1 56 __ LDA (T2 + 0),y 
1fd9 : 18 __ __ CLC
1fda : 69 01 __ ADC #$01
1fdc : 91 56 __ STA (T2 + 0),y 
1fde : 20 02 32 JSR $3202 ; (core_drawscore.s0 + 0)
1fe1 : 4c e4 1b JMP $1be4 ; (adv_exec.s1293 + 0)
.s56:
1fe4 : 20 4f 12 JSR $124f ; (ui_clear.s0 + 0)
1fe7 : 4c 0f 1b JMP $1b0f ; (adv_exec.s601 + 0)
.s128:
1fea : c9 89 __ CMP #$89
1fec : d0 0c __ BNE $1ffa ; (adv_exec.s134 + 0)
.s58:
1fee : 20 c4 2a JSR $2ac4 ; (ui_getkey.l2 + 0)
1ff1 : ad c7 3f LDA $3fc7 ; (ch + 0)
1ff4 : 8d f2 3f STA $3ff2 ; (key + 0)
1ff7 : 4c 0f 1b JMP $1b0f ; (adv_exec.s601 + 0)
.s134:
1ffa : b0 0a __ BCS $2006 ; (adv_exec.s52 + 0)
.s136:
1ffc : c9 84 __ CMP #$84
1ffe : d0 03 __ BNE $2003 ; (adv_exec.s136 + 7)
2000 : 4c 77 1c JMP $1c77 ; (adv_exec.s106 + 0)
2003 : 4c 05 1b JMP $1b05 ; (adv_exec.s120 + 0)
.s52:
2006 : c8 __ __ INY
2007 : b1 43 __ LDA (T4 + 0),y 
2009 : 8d c5 3f STA $3fc5 ; (var + 0)
200c : 8d 43 3f STA $3f43 ; (slowmode + 0)
.s715:
200f : 18 __ __ CLC
2010 : a5 54 __ LDA T1 + 0 
2012 : 69 02 __ ADC #$02
2014 : 85 54 __ STA T1 + 0 
2016 : 8d c1 3f STA $3fc1 ; (i + 0)
2019 : a5 55 __ LDA T1 + 1 
201b : 69 00 __ ADC #$00
201d : 8d c2 3f STA $3fc2 ; (i + 1)
2020 : 4c 17 16 JMP $1617 ; (adv_exec.s1286 + 0)
.s27:
2023 : 8c c7 3f STY $3fc7 ; (ch + 0)
2026 : 18 __ __ CLC
2027 : a5 54 __ LDA T1 + 0 
2029 : 69 02 __ ADC #$02
202b : 85 54 __ STA T1 + 0 
202d : 8d c1 3f STA $3fc1 ; (i + 0)
2030 : a5 55 __ LDA T1 + 1 
2032 : 69 00 __ ADC #$00
2034 : 85 55 __ STA T1 + 1 
2036 : 8d c2 3f STA $3fc2 ; (i + 1)
2039 : ad a5 3f LDA $3fa5 ; (vars + 0)
203c : 85 58 __ STA T3 + 0 
203e : ad a6 3f LDA $3fa6 ; (vars + 1)
2041 : 85 59 __ STA T3 + 1 
2043 : c8 __ __ INY
2044 : b1 43 __ LDA (T4 + 0),y 
2046 : a8 __ __ TAY
2047 : b1 58 __ LDA (T3 + 0),y 
2049 : 8d c8 3f STA $3fc8 ; (strid + 0)
204c : ad ae 3f LDA $3fae ; (tmp + 1)
204f : 85 57 __ STA T2 + 1 
2051 : 8d d2 3f STA $3fd2 ; (ostr + 1)
2054 : 85 14 __ STA P7 
2056 : ad ad 3f LDA $3fad ; (tmp + 0)
2059 : 85 56 __ STA T2 + 0 
205b : 85 13 __ STA P6 
205d : 8d d1 3f STA $3fd1 ; (ostr + 0)
2060 : a9 63 __ LDA #$63
2062 : cd c8 3f CMP $3fc8 ; (strid + 0)
2065 : 90 5e __ BCC $20c5 ; (adv_exec.s28 + 0)
.s30:
2067 : a9 09 __ LDA #$09
2069 : cd c8 3f CMP $3fc8 ; (strid + 0)
206c : b0 28 __ BCS $2096 ; (adv_exec.s33 + 0)
.s31:
206e : ad c7 3f LDA $3fc7 ; (ch + 0)
2071 : 85 53 __ STA T0 + 0 
2073 : ee c7 3f INC $3fc7 ; (ch + 0)
2076 : ad c8 3f LDA $3fc8 ; (strid + 0)
2079 : 85 1b __ STA ACCU + 0 
207b : a9 00 __ LDA #$00
207d : 85 1c __ STA ACCU + 1 
207f : 85 04 __ STA WORK + 1 
2081 : a9 0a __ LDA #$0a
2083 : 85 03 __ STA WORK + 0 
2085 : 20 eb 3b JSR $3beb ; (divmod + 0)
2088 : 18 __ __ CLC
2089 : a5 1b __ LDA ACCU + 0 
208b : 69 30 __ ADC #$30
208d : a4 53 __ LDY T0 + 0 
208f : 91 56 __ STA (T2 + 0),y 
2091 : a5 05 __ LDA WORK + 2 
2093 : 8d c8 3f STA $3fc8 ; (strid + 0)
.s33:
2096 : ad c7 3f LDA $3fc7 ; (ch + 0)
2099 : a8 __ __ TAY
209a : 18 __ __ CLC
209b : 69 01 __ ADC #$01
209d : 8d c7 3f STA $3fc7 ; (ch + 0)
20a0 : aa __ __ TAX
20a1 : ad c8 3f LDA $3fc8 ; (strid + 0)
20a4 : 18 __ __ CLC
20a5 : 69 30 __ ADC #$30
20a7 : 91 56 __ STA (T2 + 0),y 
20a9 : 8a __ __ TXA
20aa : 18 __ __ CLC
20ab : 65 56 __ ADC T2 + 0 
20ad : 85 56 __ STA T2 + 0 
20af : 90 02 __ BCC $20b3 ; (adv_exec.s1302 + 0)
.s1301:
20b1 : e6 57 __ INC T2 + 1 
.s1302:
20b3 : a9 00 __ LDA #$00
20b5 : a8 __ __ TAY
20b6 : 91 56 __ STA (T2 + 0),y 
20b8 : a5 56 __ LDA T2 + 0 
20ba : 8d d4 3f STA $3fd4 ; (etxt + 0)
20bd : a5 57 __ LDA T2 + 1 
20bf : 8d d5 3f STA $3fd5 ; (etxt + 1)
20c2 : 4c a1 1e JMP $1ea1 ; (adv_exec.s714 + 0)
.s28:
20c5 : a9 01 __ LDA #$01
20c7 : 8d c7 3f STA $3fc7 ; (ch + 0)
20ca : ad c8 3f LDA $3fc8 ; (strid + 0)
20cd : 85 1b __ STA ACCU + 0 
20cf : a9 00 __ LDA #$00
20d1 : 85 1c __ STA ACCU + 1 
20d3 : 85 04 __ STA WORK + 1 
20d5 : a9 64 __ LDA #$64
20d7 : 85 03 __ STA WORK + 0 
20d9 : 20 eb 3b JSR $3beb ; (divmod + 0)
20dc : 18 __ __ CLC
20dd : a5 1b __ LDA ACCU + 0 
20df : 69 30 __ ADC #$30
20e1 : a0 00 __ LDY #$00
20e3 : 91 56 __ STA (T2 + 0),y 
20e5 : a5 05 __ LDA WORK + 2 
20e7 : 8d c8 3f STA $3fc8 ; (strid + 0)
20ea : c9 0a __ CMP #$0a
20ec : 90 a8 __ BCC $2096 ; (adv_exec.s33 + 0)
20ee : 4c 6e 20 JMP $206e ; (adv_exec.s31 + 0)
--------------------------------------------------------------------
_alignattr: ; _alignattr()->void
.s0:
20f1 : ad 04 3f LDA $3f04 ; (room + 0)
20f4 : 8d b7 3f STA $3fb7 ; (varroom + 0)
20f7 : ad c0 3f LDA $3fc0 ; (thisobj + 0)
20fa : 8d c3 3f STA $3fc3 ; (varobj + 0)
.s1001:
20fd : 60 __ __ RTS
--------------------------------------------------------------------
_getobj: ; _getobj()->void
.s0:
20fe : ad c1 3f LDA $3fc1 ; (i + 0)
2101 : 85 43 __ STA T0 + 0 
2103 : 18 __ __ CLC
2104 : 69 01 __ ADC #$01
2106 : 8d c1 3f STA $3fc1 ; (i + 0)
2109 : ad c2 3f LDA $3fc2 ; (i + 1)
210c : 85 44 __ STA T0 + 1 
210e : 69 00 __ ADC #$00
2110 : 8d c2 3f STA $3fc2 ; (i + 1)
2113 : ad b9 3f LDA $3fb9 ; (pcode + 0)
2116 : 85 45 __ STA T1 + 0 
2118 : 18 __ __ CLC
2119 : 65 43 __ ADC T0 + 0 
211b : 85 47 __ STA T2 + 0 
211d : ad ba 3f LDA $3fba ; (pcode + 1)
2120 : 85 46 __ STA T1 + 1 
2122 : 65 44 __ ADC T0 + 1 
2124 : 85 48 __ STA T2 + 1 
2126 : a0 00 __ LDY #$00
2128 : b1 47 __ LDA (T2 + 0),y 
212a : 8d c5 3f STA $3fc5 ; (var + 0)
212d : c9 fb __ CMP #$fb
212f : f0 11 __ BEQ $2142 ; (_getobj.s9 + 0)
.s18:
2131 : b0 03 __ BCS $2136 ; (_getobj.s19 + 0)
2133 : 4c c3 21 JMP $21c3 ; (_getobj.s20 + 0)
.s19:
2136 : c9 fd __ CMP #$fd
2138 : d0 06 __ BNE $2140 ; (_getobj.s26 + 0)
.s4:
213a : ad c6 3f LDA $3fc6 ; (obj2 + 0)
213d : 4c bf 21 JMP $21bf ; (_getobj.s1020 + 0)
.s26:
2140 : b0 57 __ BCS $2199 ; (_getobj.s27 + 0)
.s9:
2142 : a0 01 __ LDY #$01
2144 : b1 47 __ LDA (T2 + 0),y 
2146 : 85 49 __ STA T3 + 0 
2148 : 8d c7 3f STA $3fc7 ; (ch + 0)
214b : 18 __ __ CLC
214c : a5 43 __ LDA T0 + 0 
214e : 69 02 __ ADC #$02
2150 : 85 43 __ STA T0 + 0 
2152 : 8d c1 3f STA $3fc1 ; (i + 0)
2155 : a5 44 __ LDA T0 + 1 
2157 : 69 00 __ ADC #$00
2159 : 85 44 __ STA T0 + 1 
215b : 8d c2 3f STA $3fc2 ; (i + 1)
215e : 20 da 21 JSR $21da ; (myrand.s0 + 0)
2161 : a5 49 __ LDA T3 + 0 
2163 : 85 03 __ STA WORK + 0 
2165 : 18 __ __ CLC
2166 : 65 43 __ ADC T0 + 0 
2168 : 8d c1 3f STA $3fc1 ; (i + 0)
216b : a9 00 __ LDA #$00
216d : 65 44 __ ADC T0 + 1 
216f : 8d c2 3f STA $3fc2 ; (i + 1)
2172 : 18 __ __ CLC
2173 : a5 45 __ LDA T1 + 0 
2175 : 65 43 __ ADC T0 + 0 
2177 : 85 43 __ STA T0 + 0 
2179 : a5 46 __ LDA T1 + 1 
217b : 65 44 __ ADC T0 + 1 
217d : 85 44 __ STA T0 + 1 
217f : ad 71 3c LDA $3c71 ; (rnd_a + 0)
2182 : 85 1b __ STA ACCU + 0 
2184 : a9 00 __ LDA #$00
2186 : 85 1c __ STA ACCU + 1 
2188 : 85 04 __ STA WORK + 1 
218a : 20 eb 3b JSR $3beb ; (divmod + 0)
218d : 18 __ __ CLC
218e : a5 43 __ LDA T0 + 0 
2190 : 65 05 __ ADC WORK + 2 
2192 : 85 43 __ STA T0 + 0 
2194 : a5 44 __ LDA T0 + 1 
2196 : 4c b7 21 JMP $21b7 ; (_getobj.s34 + 0)
.s27:
2199 : c9 fe __ CMP #$fe
219b : d0 06 __ BNE $21a3 ; (_getobj.s14 + 0)
.s2:
219d : ad b5 3f LDA $3fb5 ; (obj1 + 0)
21a0 : 4c bf 21 JMP $21bf ; (_getobj.s1020 + 0)
.s14:
21a3 : ad c4 3f LDA $3fc4 ; (varmode + 0)
21a6 : f0 1a __ BEQ $21c2 ; (_getobj.s1001 + 0)
.s15:
21a8 : 8c c4 3f STY $3fc4 ; (varmode + 0)
21ab : ad a5 3f LDA $3fa5 ; (vars + 0)
21ae : 18 __ __ CLC
21af : 6d c5 3f ADC $3fc5 ; (var + 0)
21b2 : 85 43 __ STA T0 + 0 
21b4 : ad a6 3f LDA $3fa6 ; (vars + 1)
.s34:
21b7 : 69 00 __ ADC #$00
21b9 : 85 44 __ STA T0 + 1 
21bb : a0 00 __ LDY #$00
21bd : b1 43 __ LDA (T0 + 0),y 
.s1020:
21bf : 8d c5 3f STA $3fc5 ; (var + 0)
.s1001:
21c2 : 60 __ __ RTS
.s20:
21c3 : c9 f4 __ CMP #$f4
21c5 : f0 fb __ BEQ $21c2 ; (_getobj.s1001 + 0)
.s21:
21c7 : b0 07 __ BCS $21d0 ; (_getobj.s22 + 0)
.s23:
21c9 : c9 f3 __ CMP #$f3
21cb : f0 f5 __ BEQ $21c2 ; (_getobj.s1001 + 0)
21cd : 4c a3 21 JMP $21a3 ; (_getobj.s14 + 0)
.s22:
21d0 : c9 f7 __ CMP #$f7
21d2 : d0 cf __ BNE $21a3 ; (_getobj.s14 + 0)
.s6:
21d4 : ad 04 3f LDA $3f04 ; (room + 0)
21d7 : 4c bf 21 JMP $21bf ; (_getobj.s1020 + 0)
--------------------------------------------------------------------
myrand: ; myrand()->void
.s0:
21da : ad 71 3c LDA $3c71 ; (rnd_a + 0)
21dd : f0 05 __ BEQ $21e4 ; (myrand.s0 + 10)
21df : 0a __ __ ASL
21e0 : f0 04 __ BEQ $21e6 ; (myrand.s0 + 12)
21e2 : 90 02 __ BCC $21e6 ; (myrand.s0 + 12)
21e4 : 49 1d __ EOR #$1d
21e6 : 8d 71 3c STA $3c71 ; (rnd_a + 0)
.s1001:
21e9 : 60 __ __ RTS
--------------------------------------------------------------------
_getattrstrid: ; _getattrstrid()->void
.s0:
21ea : a9 ff __ LDA #$ff
21ec : 8d c8 3f STA $3fc8 ; (strid + 0)
21ef : ad c1 3f LDA $3fc1 ; (i + 0)
21f2 : 85 1b __ STA ACCU + 0 
21f4 : 18 __ __ CLC
21f5 : 69 01 __ ADC #$01
21f7 : 8d c1 3f STA $3fc1 ; (i + 0)
21fa : ad c2 3f LDA $3fc2 ; (i + 1)
21fd : aa __ __ TAX
21fe : 69 00 __ ADC #$00
2200 : 8d c2 3f STA $3fc2 ; (i + 1)
2203 : ad b9 3f LDA $3fb9 ; (pcode + 0)
2206 : 18 __ __ CLC
2207 : 65 1b __ ADC ACCU + 0 
2209 : 85 1b __ STA ACCU + 0 
220b : 8a __ __ TXA
220c : 6d ba 3f ADC $3fba ; (pcode + 1)
220f : 85 1c __ STA ACCU + 1 
2211 : a0 00 __ LDY #$00
2213 : b1 1b __ LDA (ACCU + 0),y 
2215 : 8d c5 3f STA $3fc5 ; (var + 0)
2218 : 85 1b __ STA ACCU + 0 
221a : 29 3f __ AND #$3f
221c : d0 03 __ BNE $2221 ; (_getattrstrid.s47 + 0)
221e : 4c 7f 23 JMP $237f ; (_getattrstrid.s2 + 0)
.s47:
2221 : c9 01 __ CMP #$01
2223 : d0 03 __ BNE $2228 ; (_getattrstrid.s12 + 0)
2225 : 4c 51 23 JMP $2351 ; (_getattrstrid.s7 + 0)
.s12:
2228 : aa __ __ TAX
2229 : 06 1b __ ASL ACCU + 0 
222b : 30 0e __ BMI $223b ; (_getattrstrid.s13 + 0)
.s14:
222d : ad a1 3f LDA $3fa1 ; (roomattrex + 0)
2230 : 85 1b __ STA ACCU + 0 
2232 : ad b7 3f LDA $3fb7 ; (varroom + 0)
2235 : ac a2 3f LDY $3fa2 ; (roomattrex + 1)
2238 : 4c 46 22 JMP $2246 ; (_getattrstrid.s1014 + 0)
.s13:
223b : ad 9b 3f LDA $3f9b ; (objattrex + 0)
223e : 85 1b __ STA ACCU + 0 
2240 : ad c3 3f LDA $3fc3 ; (varobj + 0)
2243 : ac 9c 3f LDY $3f9c ; (objattrex + 1)
.s1014:
2246 : 8c cd 3f STY $3fcd ; (txt + 1)
2249 : 8d c4 3f STA $3fc4 ; (varmode + 0)
224c : a5 1b __ LDA ACCU + 0 
224e : 8d cc 3f STA $3fcc ; (txt + 0)
2251 : 98 __ __ TYA
2252 : 05 1b __ ORA ACCU + 0 
2254 : d0 03 __ BNE $2259 ; (_getattrstrid.s17 + 0)
2256 : 4c 4b 23 JMP $234b ; (_getattrstrid.s16 + 0)
.s17:
2259 : 8e ce 3f STX $3fce ; (varattr + 0)
.l20:
225c : ad cc 3f LDA $3fcc ; (txt + 0)
225f : 85 1b __ STA ACCU + 0 
2261 : 18 __ __ CLC
2262 : 69 01 __ ADC #$01
2264 : 8d cc 3f STA $3fcc ; (txt + 0)
2267 : ad cd 3f LDA $3fcd ; (txt + 1)
226a : 85 1c __ STA ACCU + 1 
226c : 69 00 __ ADC #$00
226e : 8d cd 3f STA $3fcd ; (txt + 1)
2271 : a0 00 __ LDY #$00
2273 : b1 1b __ LDA (ACCU + 0),y 
2275 : 8d cf 3f STA $3fcf ; (a + 0)
2278 : c9 ff __ CMP #$ff
227a : d0 03 __ BNE $227f ; (_getattrstrid.s24 + 0)
227c : 4c 18 23 JMP $2318 ; (_getattrstrid.s21 + 0)
.s24:
227f : 85 1d __ STA ACCU + 2 
2281 : 18 __ __ CLC
2282 : a5 1b __ LDA ACCU + 0 
2284 : 69 02 __ ADC #$02
2286 : 85 43 __ STA T1 + 0 
2288 : a5 1c __ LDA ACCU + 1 
228a : 69 00 __ ADC #$00
228c : aa __ __ TAX
228d : a5 1d __ LDA ACCU + 2 
228f : 29 7f __ AND #$7f
2291 : cd ce 3f CMP $3fce ; (varattr + 0)
2294 : f0 25 __ BEQ $22bb ; (_getattrstrid.s26 + 0)
.s27:
2296 : c8 __ __ INY
2297 : b1 1b __ LDA (ACCU + 0),y 
2299 : 85 1b __ STA ACCU + 0 
229b : 18 __ __ CLC
229c : 65 43 __ ADC T1 + 0 
229e : 90 01 __ BCC $22a1 ; (_getattrstrid.s1023 + 0)
.s1022:
22a0 : e8 __ __ INX
.s1023:
22a1 : 24 1d __ BIT ACCU + 2 
22a3 : 30 0c __ BMI $22b1 ; (_getattrstrid.s41 + 0)
.s42:
22a5 : 18 __ __ CLC
22a6 : 65 1b __ ADC ACCU + 0 
22a8 : 8d cc 3f STA $3fcc ; (txt + 0)
22ab : 8a __ __ TXA
22ac : 69 00 __ ADC #$00
22ae : 4c b5 22 JMP $22b5 ; (_getattrstrid.s1017 + 0)
.s41:
22b1 : 8d cc 3f STA $3fcc ; (txt + 0)
22b4 : 8a __ __ TXA
.s1017:
22b5 : 8d cd 3f STA $3fcd ; (txt + 1)
22b8 : 4c 5c 22 JMP $225c ; (_getattrstrid.l20 + 0)
.s26:
22bb : 8e cd 3f STX $3fcd ; (txt + 1)
22be : a5 43 __ LDA T1 + 0 
22c0 : 8d cc 3f STA $3fcc ; (txt + 0)
22c3 : a5 1d __ LDA ACCU + 2 
22c5 : 10 0d __ BPL $22d4 ; (_getattrstrid.s30 + 0)
.s29:
22c7 : 86 44 __ STX T1 + 1 
22c9 : ac c4 3f LDY $3fc4 ; (varmode + 0)
22cc : b1 43 __ LDA (T1 + 0),y 
22ce : 8d c8 3f STA $3fc8 ; (strid + 0)
22d1 : 4c 1d 23 JMP $231d ; (_getattrstrid.s109 + 0)
.s30:
22d4 : 18 __ __ CLC
22d5 : 69 ff __ ADC #$ff
22d7 : 8d cf 3f STA $3fcf ; (a + 0)
22da : a5 1d __ LDA ACCU + 2 
22dc : f0 3a __ BEQ $2318 ; (_getattrstrid.s21 + 0)
.s49:
22de : ae c4 3f LDX $3fc4 ; (varmode + 0)
.l34:
22e1 : ad cc 3f LDA $3fcc ; (txt + 0)
22e4 : 85 1b __ STA ACCU + 0 
22e6 : ad cd 3f LDA $3fcd ; (txt + 1)
22e9 : 85 1c __ STA ACCU + 1 
22eb : a0 01 __ LDY #$01
22ed : b1 1b __ LDA (ACCU + 0),y 
22ef : 85 1d __ STA ACCU + 2 
22f1 : 88 __ __ DEY
22f2 : b1 1b __ LDA (ACCU + 0),y 
22f4 : 85 1e __ STA ACCU + 3 
22f6 : 8d cf 3f STA $3fcf ; (a + 0)
22f9 : 18 __ __ CLC
22fa : a5 1b __ LDA ACCU + 0 
22fc : 69 02 __ ADC #$02
22fe : 8d cc 3f STA $3fcc ; (txt + 0)
2301 : a5 1c __ LDA ACCU + 1 
2303 : 69 00 __ ADC #$00
2305 : 8d cd 3f STA $3fcd ; (txt + 1)
2308 : e4 1e __ CPX ACCU + 3 
230a : f0 2e __ BEQ $233a ; (_getattrstrid.s36 + 0)
.s33:
230c : 18 __ __ CLC
230d : a5 1e __ LDA ACCU + 3 
230f : 69 ff __ ADC #$ff
2311 : 8d cf 3f STA $3fcf ; (a + 0)
2314 : a5 1e __ LDA ACCU + 3 
2316 : d0 c9 __ BNE $22e1 ; (_getattrstrid.l34 + 0)
.s21:
2318 : ad cf 3f LDA $3fcf ; (a + 0)
231b : 85 1d __ STA ACCU + 2 
.s109:
231d : a9 00 __ LDA #$00
231f : 8d c4 3f STA $3fc4 ; (varmode + 0)
2322 : a5 1d __ LDA ACCU + 2 
2324 : c9 ff __ CMP #$ff
2326 : f0 11 __ BEQ $2339 ; (_getattrstrid.s1001 + 0)
.s44:
2328 : a9 01 __ LDA #$01
232a : 8d cb 3f STA $3fcb ; (text_continue + 0)
232d : ad 71 3f LDA $3f71 ; (advdesc + 0)
2330 : 8d c9 3f STA $3fc9 ; (str + 0)
2333 : ad 72 3f LDA $3f72 ; (advdesc + 1)
2336 : 8d ca 3f STA $3fca ; (str + 1)
.s1001:
2339 : 60 __ __ RTS
.s36:
233a : 8c c4 3f STY $3fc4 ; (varmode + 0)
233d : a5 1d __ LDA ACCU + 2 
233f : 8d c8 3f STA $3fc8 ; (strid + 0)
2342 : a5 1e __ LDA ACCU + 3 
2344 : c9 ff __ CMP #$ff
2346 : f0 f1 __ BEQ $2339 ; (_getattrstrid.s1001 + 0)
2348 : 4c 28 23 JMP $2328 ; (_getattrstrid.s44 + 0)
.s16:
234b : a9 ff __ LDA #$ff
.s1016:
234d : 8d c8 3f STA $3fc8 ; (strid + 0)
2350 : 60 __ __ RTS
.s7:
2351 : ad 71 3f LDA $3f71 ; (advdesc + 0)
2354 : 8d c9 3f STA $3fc9 ; (str + 0)
2357 : ad 72 3f LDA $3f72 ; (advdesc + 1)
235a : 8d ca 3f STA $3fca ; (str + 1)
235d : 06 1b __ ASL ACCU + 0 
235f : 30 12 __ BMI $2373 ; (_getattrstrid.s8 + 0)
.s9:
2361 : ad 8e 3f LDA $3f8e ; (roomdescid + 1)
2364 : ae 8d 3f LDX $3f8d ; (roomdescid + 0)
.s1019:
2367 : ac b7 3f LDY $3fb7 ; (varroom + 0)
.s99:
236a : 86 43 __ STX T1 + 0 
236c : 85 44 __ STA T1 + 1 
236e : b1 43 __ LDA (T1 + 0),y 
2370 : 4c 4d 23 JMP $234d ; (_getattrstrid.s1016 + 0)
.s8:
2373 : ad 96 3f LDA $3f96 ; (objdescid + 1)
2376 : ae 95 3f LDX $3f95 ; (objdescid + 0)
.s1018:
2379 : ac c3 3f LDY $3fc3 ; (varobj + 0)
237c : 4c 6a 23 JMP $236a ; (_getattrstrid.s99 + 0)
.s2:
237f : a9 01 __ LDA #$01
2381 : 8d cb 3f STA $3fcb ; (text_continue + 0)
2384 : ad 6f 3f LDA $3f6f ; (advnames + 0)
2387 : 8d c9 3f STA $3fc9 ; (str + 0)
238a : ad 70 3f LDA $3f70 ; (advnames + 1)
238d : 8d ca 3f STA $3fca ; (str + 1)
2390 : 06 1b __ ASL ACCU + 0 
2392 : 10 09 __ BPL $239d ; (_getattrstrid.s4 + 0)
.s3:
2394 : ad 94 3f LDA $3f94 ; (objnameid + 1)
2397 : ae 93 3f LDX $3f93 ; (objnameid + 0)
239a : 4c 79 23 JMP $2379 ; (_getattrstrid.s1018 + 0)
.s4:
239d : ad 8c 3f LDA $3f8c ; (roomnameid + 1)
23a0 : ae 8b 3f LDX $3f8b ; (roomnameid + 0)
23a3 : 4c 67 23 JMP $2367 ; (_getattrstrid.s1019 + 0)
--------------------------------------------------------------------
_getstring: ; _getstring()->void
.s0:
23a6 : a9 00 __ LDA #$00
23a8 : 8d d0 3f STA $3fd0 ; (_strid + 0)
23ab : ad c9 3f LDA $3fc9 ; (str + 0)
23ae : 8d d1 3f STA $3fd1 ; (ostr + 0)
23b1 : ad ca 3f LDA $3fca ; (str + 1)
23b4 : 8d d2 3f STA $3fd2 ; (ostr + 1)
23b7 : ad c8 3f LDA $3fc8 ; (strid + 0)
23ba : 85 1d __ STA ACCU + 2 
23bc : f0 5a __ BEQ $2418 ; (_getstring.s3 + 0)
.l2:
23be : ad c9 3f LDA $3fc9 ; (str + 0)
23c1 : 85 1b __ STA ACCU + 0 
23c3 : 18 __ __ CLC
23c4 : 69 01 __ ADC #$01
23c6 : 8d c9 3f STA $3fc9 ; (str + 0)
23c9 : ad ca 3f LDA $3fca ; (str + 1)
23cc : 85 1c __ STA ACCU + 1 
23ce : 69 00 __ ADC #$00
23d0 : 8d ca 3f STA $3fca ; (str + 1)
23d3 : a0 00 __ LDY #$00
23d5 : b1 1b __ LDA (ACCU + 0),y 
23d7 : 8d d3 3f STA $3fd3 ; (len + 0)
23da : ee d0 3f INC $3fd0 ; (_strid + 0)
23dd : c9 ff __ CMP #$ff
23df : d0 15 __ BNE $23f6 ; (_getstring.s6 + 0)
.s4:
23e1 : c8 __ __ INY
23e2 : b1 1b __ LDA (ACCU + 0),y 
23e4 : 8d d3 3f STA $3fd3 ; (len + 0)
23e7 : 18 __ __ CLC
23e8 : a5 1b __ LDA ACCU + 0 
23ea : 69 01 __ ADC #$01
23ec : 8d c9 3f STA $3fc9 ; (str + 0)
23ef : a5 1c __ LDA ACCU + 1 
23f1 : 69 01 __ ADC #$01
23f3 : 8d ca 3f STA $3fca ; (str + 1)
.s6:
23f6 : ad c9 3f LDA $3fc9 ; (str + 0)
23f9 : 18 __ __ CLC
23fa : 6d d3 3f ADC $3fd3 ; (len + 0)
23fd : 8d c9 3f STA $3fc9 ; (str + 0)
2400 : 90 03 __ BCC $2405 ; (_getstring.s1009 + 0)
.s1008:
2402 : ee ca 3f INC $3fca ; (str + 1)
.s1009:
2405 : ad c9 3f LDA $3fc9 ; (str + 0)
2408 : 8d d1 3f STA $3fd1 ; (ostr + 0)
240b : ad ca 3f LDA $3fca ; (str + 1)
240e : 8d d2 3f STA $3fd2 ; (ostr + 1)
2411 : ad d0 3f LDA $3fd0 ; (_strid + 0)
2414 : c5 1d __ CMP ACCU + 2 
2416 : 90 a6 __ BCC $23be ; (_getstring.l2 + 0)
.s3:
2418 : ad d1 3f LDA $3fd1 ; (ostr + 0)
241b : 85 1b __ STA ACCU + 0 
241d : 18 __ __ CLC
241e : 69 01 __ ADC #$01
2420 : 8d d1 3f STA $3fd1 ; (ostr + 0)
2423 : ad d2 3f LDA $3fd2 ; (ostr + 1)
2426 : 85 1c __ STA ACCU + 1 
2428 : 69 00 __ ADC #$00
242a : 8d d2 3f STA $3fd2 ; (ostr + 1)
242d : a0 00 __ LDY #$00
242f : b1 1b __ LDA (ACCU + 0),y 
2431 : 8d d3 3f STA $3fd3 ; (len + 0)
2434 : 18 __ __ CLC
2435 : 6d d1 3f ADC $3fd1 ; (ostr + 0)
2438 : 8d d4 3f STA $3fd4 ; (etxt + 0)
243b : ad d2 3f LDA $3fd2 ; (ostr + 1)
243e : 69 00 __ ADC #$00
2440 : 8d d5 3f STA $3fd5 ; (etxt + 1)
2443 : ad d3 3f LDA $3fd3 ; (len + 0)
2446 : c9 ff __ CMP #$ff
2448 : d0 30 __ BNE $247a ; (_getstring.s1001 + 0)
.s7:
244a : c8 __ __ INY
244b : b1 1b __ LDA (ACCU + 0),y 
244d : 8d d3 3f STA $3fd3 ; (len + 0)
2450 : 18 __ __ CLC
2451 : a5 1b __ LDA ACCU + 0 
2453 : 69 02 __ ADC #$02
2455 : 8d d1 3f STA $3fd1 ; (ostr + 0)
2458 : a5 1c __ LDA ACCU + 1 
245a : 69 00 __ ADC #$00
245c : 8d d2 3f STA $3fd2 ; (ostr + 1)
245f : ad d4 3f LDA $3fd4 ; (etxt + 0)
2462 : 18 __ __ CLC
2463 : 6d d3 3f ADC $3fd3 ; (len + 0)
2466 : aa __ __ TAX
2467 : ad d5 3f LDA $3fd5 ; (etxt + 1)
246a : 69 00 __ ADC #$00
246c : a8 __ __ TAY
246d : 8a __ __ TXA
246e : 18 __ __ CLC
246f : 69 01 __ ADC #$01
2471 : 8d d4 3f STA $3fd4 ; (etxt + 0)
2474 : 90 01 __ BCC $2477 ; (_getstring.s1011 + 0)
.s1010:
2476 : c8 __ __ INY
.s1011:
2477 : 8c d5 3f STY $3fd5 ; (etxt + 1)
.s1001:
247a : 60 __ __ RTS
--------------------------------------------------------------------
ui_text_write: ; ui_text_write(u8*)->void
.s0:
247b : a9 01 __ LDA #$01
247d : 8d d6 3f STA $3fd6 ; (txt_col + 0)
2480 : a5 13 __ LDA P6 ; (text + 0)
2482 : 8d cc 3f STA $3fcc ; (txt + 0)
2485 : a5 14 __ LDA P7 ; (text + 1)
2487 : 8d cd 3f STA $3fcd ; (txt + 1)
248a : ad d7 3f LDA $3fd7 ; (text_attach + 0)
248d : f0 07 __ BEQ $2496 ; (ui_text_write.s2 + 0)
.s1:
248f : a9 00 __ LDA #$00
2491 : 8d d7 3f STA $3fd7 ; (text_attach + 0)
2494 : f0 15 __ BEQ $24ab ; (ui_text_write.l5 + 0)
.s2:
2496 : 8d d8 3f STA $3fd8 ; (txt_rev + 0)
2499 : 8d d9 3f STA $3fd9 ; (txt_x + 0)
249c : ad 03 3f LDA $3f03 ; (text_y + 0)
249f : 18 __ __ CLC
24a0 : 69 0e __ ADC #$0e
24a2 : 8d da 3f STA $3fda ; (txt_y + 0)
24a5 : 4c ab 24 JMP $24ab ; (ui_text_write.l5 + 0)
.s8:
24a8 : 20 6d 2a JSR $2a6d ; (ui_waitkey.s0 + 0)
.l5:
24ab : 20 ff 24 JSR $24ff ; (core_drawtext.l138 + 0)
24ae : ad db 3f LDA $3fdb ; (_ch + 0)
24b1 : d0 f5 __ BNE $24a8 ; (ui_text_write.s8 + 0)
.s7:
24b3 : ad cc 3f LDA $3fcc ; (txt + 0)
24b6 : 85 1f __ STA ADDR + 0 
24b8 : ad cd 3f LDA $3fcd ; (txt + 1)
24bb : 18 __ __ CLC
24bc : 69 ff __ ADC #$ff
24be : 85 20 __ STA ADDR + 1 
24c0 : a0 ff __ LDY #$ff
24c2 : b1 1f __ LDA (ADDR + 0),y 
24c4 : c9 2b __ CMP #$2b
24c6 : f0 21 __ BEQ $24e9 ; (ui_text_write.s10 + 0)
.s11:
24c8 : ad cb 3f LDA $3fcb ; (text_continue + 0)
24cb : f0 07 __ BEQ $24d4 ; (ui_text_write.s17 + 0)
.s16:
24cd : a9 01 __ LDA #$01
24cf : 8d d7 3f STA $3fd7 ; (text_attach + 0)
24d2 : d0 0c __ BNE $24e0 ; (ui_text_write.s1004 + 0)
.s17:
24d4 : ad da 3f LDA $3fda ; (txt_y + 0)
24d7 : 38 __ __ SEC
24d8 : e9 0e __ SBC #$0e
24da : 8d 03 3f STA $3f03 ; (text_y + 0)
24dd : 20 50 2a JSR $2a50 ; (cr.l30 + 0)
.s1004:
24e0 : a9 00 __ LDA #$00
24e2 : 8d cb 3f STA $3fcb ; (text_continue + 0)
24e5 : ee b2 3f INC $3fb2 ; (al + 0)
.s1001:
24e8 : 60 __ __ RTS
.s10:
24e9 : a9 01 __ LDA #$01
24eb : 8d d7 3f STA $3fd7 ; (text_attach + 0)
24ee : a9 00 __ LDA #$00
24f0 : 8d cb 3f STA $3fcb ; (text_continue + 0)
24f3 : ee b2 3f INC $3fb2 ; (al + 0)
24f6 : ad d9 3f LDA $3fd9 ; (txt_x + 0)
24f9 : f0 ed __ BEQ $24e8 ; (ui_text_write.s1001 + 0)
.s13:
24fb : ce d9 3f DEC $3fd9 ; (txt_x + 0)
24fe : 60 __ __ RTS
--------------------------------------------------------------------
core_drawtext: ; core_drawtext()->void
.l138:
24ff : 20 66 27 JSR $2766 ; (_getnextch.s0 + 0)
2502 : ad db 3f LDA $3fdb ; (_ch + 0)
2505 : f0 0d __ BEQ $2514 ; (core_drawtext.s1001 + 0)
.l2:
2507 : ad b2 3f LDA $3fb2 ; (al + 0)
250a : c9 0a __ CMP #$0a
250c : ad db 3f LDA $3fdb ; (_ch + 0)
250f : 90 04 __ BCC $2515 ; (core_drawtext.s6 + 0)
.s4:
2511 : 8d dc 3f STA $3fdc ; (_ech + 0)
.s1001:
2514 : 60 __ __ RTS
.s6:
2515 : c9 1f __ CMP #$1f
2517 : d0 06 __ BNE $251f ; (core_drawtext.s9 + 0)
.s8:
2519 : 20 7d 28 JSR $287d ; (core_cr.l34 + 0)
251c : 4c ff 24 JMP $24ff ; (core_drawtext.l138 + 0)
.s9:
251f : a9 00 __ LDA #$00
2521 : 8d 38 3f STA $3f38 ; (align + 0)
2524 : 8d 39 3f STA $3f39 ; (align + 1)
2527 : 8d e1 3f STA $3fe1 ; (ll + 0)
252a : 8d e2 3f STA $3fe2 ; (ll + 1)
252d : 8d e3 3f STA $3fe3 ; (spl + 0)
2530 : 8d e4 3f STA $3fe4 ; (spl + 1)
2533 : ad db 3f LDA $3fdb ; (_ch + 0)
2536 : f0 5f __ BEQ $2597 ; (core_drawtext.s13 + 0)
.l15:
2538 : ad e1 3f LDA $3fe1 ; (ll + 0)
253b : 85 4c __ STA T3 + 0 
253d : 18 __ __ CLC
253e : 6d d9 3f ADC $3fd9 ; (txt_x + 0)
2541 : aa __ __ TAX
2542 : ad e2 3f LDA $3fe2 ; (ll + 1)
2545 : 85 4d __ STA T3 + 1 
2547 : 69 00 __ ADC #$00
2549 : d0 4c __ BNE $2597 ; (core_drawtext.s13 + 0)
.s1036:
254b : e0 28 __ CPX #$28
254d : b0 48 __ BCS $2597 ; (core_drawtext.s13 + 0)
.s14:
254f : ad db 3f LDA $3fdb ; (_ch + 0)
2552 : c9 1f __ CMP #$1f
2554 : f0 41 __ BEQ $2597 ; (core_drawtext.s13 + 0)
.s12:
2556 : c9 5c __ CMP #$5c
2558 : d0 03 __ BNE $255d ; (core_drawtext.s17 + 0)
255a : 4c a9 26 JMP $26a9 ; (core_drawtext.s16 + 0)
.s17:
255d : 85 49 __ STA T0 + 0 
255f : c9 20 __ CMP #$20
2561 : d0 0d __ BNE $2570 ; (core_drawtext.s57 + 0)
.s55:
2563 : a5 4c __ LDA T3 + 0 
2565 : 8d e3 3f STA $3fe3 ; (spl + 0)
2568 : a5 4d __ LDA T3 + 1 
256a : 8d e4 3f STA $3fe4 ; (spl + 1)
256d : 20 06 2a JSR $2a06 ; (_savechpos.s0 + 0)
.s57:
2570 : ad d8 3f LDA $3fd8 ; (txt_rev + 0)
2573 : 18 __ __ CLC
2574 : 65 49 __ ADC T0 + 0 
2576 : a6 4c __ LDX T3 + 0 
2578 : 9d 00 40 STA $4000,x ; (_buffer + 0)
257b : ad d6 3f LDA $3fd6 ; (txt_col + 0)
257e : 9d 2a 40 STA $402a,x ; (_cbuffer + 0)
2581 : 8a __ __ TXA
2582 : 18 __ __ CLC
2583 : 69 01 __ ADC #$01
2585 : 8d e1 3f STA $3fe1 ; (ll + 0)
2588 : a5 4d __ LDA T3 + 1 
258a : 69 00 __ ADC #$00
258c : 8d e2 3f STA $3fe2 ; (ll + 1)
.s137:
258f : 20 66 27 JSR $2766 ; (_getnextch.s0 + 0)
2592 : ad db 3f LDA $3fdb ; (_ch + 0)
2595 : d0 a1 __ BNE $2538 ; (core_drawtext.l15 + 0)
.s13:
2597 : ad d9 3f LDA $3fd9 ; (txt_x + 0)
259a : 85 4a __ STA T2 + 0 
259c : 18 __ __ CLC
259d : 6d e1 3f ADC $3fe1 ; (ll + 0)
25a0 : aa __ __ TAX
25a1 : ad e2 3f LDA $3fe2 ; (ll + 1)
25a4 : 69 00 __ ADC #$00
25a6 : 85 4d __ STA T3 + 1 
25a8 : d0 0d __ BNE $25b7 ; (core_drawtext.s59 + 0)
.s1007:
25aa : e0 28 __ CPX #$28
25ac : d0 09 __ BNE $25b7 ; (core_drawtext.s59 + 0)
.s61:
25ae : ad db 3f LDA $3fdb ; (_ch + 0)
25b1 : f0 1e __ BEQ $25d1 ; (core_drawtext.s125 + 0)
.s62:
25b3 : c9 20 __ CMP #$20
25b5 : f0 1a __ BEQ $25d1 ; (core_drawtext.s125 + 0)
.s59:
25b7 : a5 4d __ LDA T3 + 1 
25b9 : d0 04 __ BNE $25bf ; (core_drawtext.s63 + 0)
.s1004:
25bb : e0 28 __ CPX #$28
25bd : 90 12 __ BCC $25d1 ; (core_drawtext.s125 + 0)
.s63:
25bf : 20 2b 2a JSR $2a2b ; (_restorechpos.s0 + 0)
25c2 : ad e3 3f LDA $3fe3 ; (spl + 0)
25c5 : 8d e1 3f STA $3fe1 ; (ll + 0)
25c8 : ad e4 3f LDA $3fe4 ; (spl + 1)
25cb : 8d e2 3f STA $3fe2 ; (ll + 1)
25ce : 20 66 27 JSR $2766 ; (_getnextch.s0 + 0)
.s125:
25d1 : ad 39 3f LDA $3f39 ; (align + 1)
25d4 : d0 36 __ BNE $260c ; (core_drawtext.s66 + 0)
.s1003:
25d6 : ad 38 3f LDA $3f38 ; (align + 0)
25d9 : c9 01 __ CMP #$01
25db : d0 0b __ BNE $25e8 ; (core_drawtext.s71 + 0)
.s69:
25dd : 38 __ __ SEC
25de : a9 28 __ LDA #$28
25e0 : ed e1 3f SBC $3fe1 ; (ll + 0)
25e3 : 85 4c __ STA T3 + 0 
25e5 : 4c 04 26 JMP $2604 ; (core_drawtext.s136 + 0)
.s71:
25e8 : ad 39 3f LDA $3f39 ; (align + 1)
25eb : d0 1f __ BNE $260c ; (core_drawtext.s66 + 0)
.s1002:
25ed : ad 38 3f LDA $3f38 ; (align + 0)
25f0 : c9 02 __ CMP #$02
25f2 : d0 18 __ BNE $260c ; (core_drawtext.s66 + 0)
.s67:
25f4 : 38 __ __ SEC
25f5 : a9 28 __ LDA #$28
25f7 : ed e1 3f SBC $3fe1 ; (ll + 0)
25fa : 85 4c __ STA T3 + 0 
25fc : a9 00 __ LDA #$00
25fe : ed e2 3f SBC $3fe2 ; (ll + 1)
2601 : 4a __ __ LSR
2602 : 66 4c __ ROR T3 + 0 
.s136:
2604 : 18 __ __ CLC
2605 : a5 4c __ LDA T3 + 0 
2607 : 65 4a __ ADC T2 + 0 
2609 : 8d d9 3f STA $3fd9 ; (txt_x + 0)
.s66:
260c : ad da 3f LDA $3fda ; (txt_y + 0)
260f : 0a __ __ ASL
2610 : 85 1b __ STA ACCU + 0 
2612 : a9 00 __ LDA #$00
2614 : 2a __ __ ROL
2615 : 06 1b __ ASL ACCU + 0 
2617 : 2a __ __ ROL
2618 : aa __ __ TAX
2619 : a5 1b __ LDA ACCU + 0 
261b : 6d da 3f ADC $3fda ; (txt_y + 0)
261e : 85 4a __ STA T2 + 0 
2620 : 8a __ __ TXA
2621 : 69 00 __ ADC #$00
2623 : 06 4a __ ASL T2 + 0 
2625 : 2a __ __ ROL
2626 : 06 4a __ ASL T2 + 0 
2628 : 2a __ __ ROL
2629 : 06 4a __ ASL T2 + 0 
262b : 2a __ __ ROL
262c : 85 4b __ STA T2 + 1 
262e : ad d9 3f LDA $3fd9 ; (txt_x + 0)
2631 : 85 4e __ STA T4 + 0 
2633 : ad ef 3e LDA $3eef ; (video_ram + 0)
2636 : 18 __ __ CLC
2637 : 65 4a __ ADC T2 + 0 
2639 : aa __ __ TAX
263a : ad f0 3e LDA $3ef0 ; (video_ram + 1)
263d : 65 4b __ ADC T2 + 1 
263f : a8 __ __ TAY
2640 : 8a __ __ TXA
2641 : 18 __ __ CLC
2642 : 65 4e __ ADC T4 + 0 
2644 : 85 0d __ STA P0 
2646 : 90 01 __ BCC $2649 ; (core_drawtext.s1045 + 0)
.s1044:
2648 : c8 __ __ INY
.s1045:
2649 : 84 0e __ STY P1 
264b : a9 00 __ LDA #$00
264d : 85 0f __ STA P2 
264f : a9 40 __ LDA #$40
2651 : 85 10 __ STA P3 
2653 : ad e1 3f LDA $3fe1 ; (ll + 0)
2656 : 85 4c __ STA T3 + 0 
2658 : 85 11 __ STA P4 
265a : ad e2 3f LDA $3fe2 ; (ll + 1)
265d : 85 4d __ STA T3 + 1 
265f : 85 12 __ STA P5 
2661 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
2664 : a5 4c __ LDA T3 + 0 
2666 : 85 11 __ STA P4 
2668 : a5 4d __ LDA T3 + 1 
266a : 85 12 __ STA P5 
266c : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
266f : 18 __ __ CLC
2670 : 65 4a __ ADC T2 + 0 
2672 : aa __ __ TAX
2673 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
2676 : 65 4b __ ADC T2 + 1 
2678 : a8 __ __ TAY
2679 : 8a __ __ TXA
267a : 18 __ __ CLC
267b : 65 4e __ ADC T4 + 0 
267d : 85 0d __ STA P0 
267f : 90 01 __ BCC $2682 ; (core_drawtext.s1047 + 0)
.s1046:
2681 : c8 __ __ INY
.s1047:
2682 : 84 0e __ STY P1 
2684 : a9 2a __ LDA #$2a
2686 : 85 0f __ STA P2 
2688 : a9 40 __ LDA #$40
268a : 85 10 __ STA P3 
268c : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
268f : 18 __ __ CLC
2690 : a5 4c __ LDA T3 + 0 
2692 : 65 4e __ ADC T4 + 0 
2694 : 8d d9 3f STA $3fd9 ; (txt_x + 0)
2697 : ad db 3f LDA $3fdb ; (_ch + 0)
269a : d0 01 __ BNE $269d ; (core_drawtext.s74 + 0)
269c : 60 __ __ RTS
.s74:
269d : 20 7d 28 JSR $287d ; (core_cr.l34 + 0)
26a0 : ad db 3f LDA $3fdb ; (_ch + 0)
26a3 : d0 01 __ BNE $26a6 ; (core_drawtext.s74 + 9)
26a5 : 60 __ __ RTS
26a6 : 4c 07 25 JMP $2507 ; (core_drawtext.l2 + 0)
.s16:
26a9 : 20 66 27 JSR $2766 ; (_getnextch.s0 + 0)
26ac : ad db 3f LDA $3fdb ; (_ch + 0)
26af : c9 16 __ CMP #$16
26b1 : f0 27 __ BEQ $26da ; (core_drawtext.s77 + 0)
.s41:
26b3 : 90 7c __ BCC $2731 ; (core_drawtext.s43 + 0)
.s42:
26b5 : c9 19 __ CMP #$19
26b7 : d0 04 __ BNE $26bd ; (core_drawtext.s50 + 0)
.s28:
26b9 : a9 07 __ LDA #$07
26bb : d0 0b __ BNE $26c8 ; (core_drawtext.s1043 + 0)
.s50:
26bd : b0 0f __ BCS $26ce ; (core_drawtext.s51 + 0)
.s52:
26bf : c9 17 __ CMP #$17
26c1 : f0 03 __ BEQ $26c6 ; (core_drawtext.s30 + 0)
26c3 : 4c 8f 25 JMP $258f ; (core_drawtext.s137 + 0)
.s30:
26c6 : a9 01 __ LDA #$01
.s1043:
26c8 : 8d d6 3f STA $3fd6 ; (txt_col + 0)
26cb : 4c 8f 25 JMP $258f ; (core_drawtext.s137 + 0)
.s51:
26ce : c9 56 __ CMP #$56
26d0 : f0 03 __ BEQ $26d5 ; (core_drawtext.s32 + 0)
26d2 : 4c 8f 25 JMP $258f ; (core_drawtext.s137 + 0)
.s32:
26d5 : a9 01 __ LDA #$01
26d7 : 8d e5 3f STA $3fe5 ; (u + 0)
.s77:
26da : a9 00 __ LDA #$00
26dc : 8d e6 3f STA $3fe6 ; (v + 0)
.l34:
26df : ad af 3f LDA $3faf ; (vrb + 0)
26e2 : 85 4c __ STA T3 + 0 
26e4 : ad b0 3f LDA $3fb0 ; (vrb + 1)
26e7 : 85 4d __ STA T3 + 1 
26e9 : ac e6 3f LDY $3fe6 ; (v + 0)
26ec : b1 4c __ LDA (T3 + 0),y 
26ee : d0 03 __ BNE $26f3 ; (core_drawtext.s35 + 0)
26f0 : 4c 8f 25 JMP $258f ; (core_drawtext.s137 + 0)
.s35:
26f3 : 84 49 __ STY T0 + 0 
26f5 : ad e1 3f LDA $3fe1 ; (ll + 0)
26f8 : 85 4e __ STA T4 + 0 
26fa : ad d8 3f LDA $3fd8 ; (txt_rev + 0)
26fd : 18 __ __ CLC
26fe : 71 4c __ ADC (T3 + 0),y 
2700 : aa __ __ TAX
2701 : a4 4e __ LDY T4 + 0 
2703 : 99 00 40 STA $4000,y ; (_buffer + 0)
2706 : ad d6 3f LDA $3fd6 ; (txt_col + 0)
2709 : c8 __ __ INY
270a : 8c e1 3f STY $3fe1 ; (ll + 0)
270d : 99 29 40 STA $4029,y ; (_buffer + 41)
2710 : a9 00 __ LDA #$00
2712 : 8d e2 3f STA $3fe2 ; (ll + 1)
2715 : a4 49 __ LDY T0 + 0 
2717 : c8 __ __ INY
2718 : 8c e6 3f STY $3fe6 ; (v + 0)
271b : ad e5 3f LDA $3fe5 ; (u + 0)
271e : f0 bf __ BEQ $26df ; (core_drawtext.l34 + 0)
.s37:
2720 : a9 00 __ LDA #$00
2722 : 8d e5 3f STA $3fe5 ; (u + 0)
2725 : 8a __ __ TXA
2726 : 18 __ __ CLC
2727 : 69 40 __ ADC #$40
2729 : a6 4e __ LDX T4 + 0 
272b : 9d 00 40 STA $4000,x ; (_buffer + 0)
272e : 4c df 26 JMP $26df ; (core_drawtext.l34 + 0)
.s43:
2731 : c9 0c __ CMP #$0c
2733 : d0 07 __ BNE $273c ; (core_drawtext.s44 + 0)
.s24:
2735 : a9 00 __ LDA #$00
2737 : 8d 38 3f STA $3f38 ; (align + 0)
273a : f0 10 __ BEQ $274c ; (core_drawtext.s1041 + 0)
.s44:
273c : 90 14 __ BCC $2752 ; (core_drawtext.s46 + 0)
.s45:
273e : c9 12 __ CMP #$12
2740 : f0 03 __ BEQ $2745 ; (core_drawtext.s22 + 0)
2742 : 4c 8f 25 JMP $258f ; (core_drawtext.s137 + 0)
.s22:
2745 : a9 01 __ LDA #$01
.s1042:
2747 : 8d 38 3f STA $3f38 ; (align + 0)
274a : a9 00 __ LDA #$00
.s1041:
274c : 8d 39 3f STA $3f39 ; (align + 1)
274f : 4c 8f 25 JMP $258f ; (core_drawtext.s137 + 0)
.s46:
2752 : c9 03 __ CMP #$03
2754 : d0 04 __ BNE $275a ; (core_drawtext.s47 + 0)
.s20:
2756 : a9 02 __ LDA #$02
2758 : d0 ed __ BNE $2747 ; (core_drawtext.s1042 + 0)
.s47:
275a : c9 07 __ CMP #$07
275c : f0 03 __ BEQ $2761 ; (core_drawtext.s26 + 0)
275e : 4c 8f 25 JMP $258f ; (core_drawtext.s137 + 0)
.s26:
2761 : a9 0c __ LDA #$0c
2763 : 4c c8 26 JMP $26c8 ; (core_drawtext.s1043 + 0)
--------------------------------------------------------------------
_getnextch: ; _getnextch()->void
.s0:
2766 : ad dc 3f LDA $3fdc ; (_ech + 0)
2769 : f0 08 __ BEQ $2773 ; (_getnextch.s2 + 0)
.s1:
276b : a2 00 __ LDX #$00
276d : 8e dc 3f STX $3fdc ; (_ech + 0)
2770 : 4c 18 28 JMP $2818 ; (_getnextch.s1015 + 0)
.s2:
2773 : ad dd 3f LDA $3fdd ; (_cplx + 0)
2776 : cd de 3f CMP $3fde ; (_cplw + 0)
2779 : b0 17 __ BCS $2792 ; (_getnextch.s5 + 0)
.s4:
277b : 85 1b __ STA ACCU + 0 
277d : 69 01 __ ADC #$01
277f : 8d dd 3f STA $3fdd ; (_cplx + 0)
2782 : ad df 3f LDA $3fdf ; (_cpl + 0)
2785 : 18 __ __ CLC
2786 : 65 1b __ ADC ACCU + 0 
2788 : 85 43 __ STA T2 + 0 
278a : ad e0 3f LDA $3fe0 ; (_cpl + 1)
278d : 69 00 __ ADC #$00
278f : 4c 12 28 JMP $2812 ; (_getnextch.s29 + 0)
.s5:
2792 : ad cc 3f LDA $3fcc ; (txt + 0)
2795 : 85 43 __ STA T2 + 0 
2797 : ad cd 3f LDA $3fcd ; (txt + 1)
279a : 85 44 __ STA T2 + 1 
279c : cd d5 3f CMP $3fd5 ; (etxt + 1)
279f : d0 0b __ BNE $27ac ; (_getnextch.s8 + 0)
.s1010:
27a1 : a5 43 __ LDA T2 + 0 
27a3 : cd d4 3f CMP $3fd4 ; (etxt + 0)
27a6 : d0 04 __ BNE $27ac ; (_getnextch.s8 + 0)
.s7:
27a8 : a9 00 __ LDA #$00
27aa : f0 6c __ BEQ $2818 ; (_getnextch.s1015 + 0)
.s8:
27ac : 18 __ __ CLC
27ad : a5 43 __ LDA T2 + 0 
27af : 69 01 __ ADC #$01
27b1 : 8d cc 3f STA $3fcc ; (txt + 0)
27b4 : a5 44 __ LDA T2 + 1 
27b6 : 69 00 __ ADC #$00
27b8 : 8d cd 3f STA $3fcd ; (txt + 1)
27bb : a0 00 __ LDY #$00
27bd : b1 43 __ LDA (T2 + 0),y 
27bf : 8d db 3f STA $3fdb ; (_ch + 0)
27c2 : c9 5d __ CMP #$5d
27c4 : d0 07 __ BNE $27cd ; (_getnextch.s13 + 0)
.s10:
27c6 : a9 01 __ LDA #$01
27c8 : 8d db 3f STA $3fdb ; (_ch + 0)
27cb : d0 4f __ BNE $281c ; (_getnextch.s16 + 0)
.s13:
27cd : c9 5e __ CMP #$5e
27cf : d0 18 __ BNE $27e9 ; (_getnextch.s11 + 0)
.s14:
27d1 : c8 __ __ INY
27d2 : b1 43 __ LDA (T2 + 0),y 
27d4 : 8d db 3f STA $3fdb ; (_ch + 0)
27d7 : 18 __ __ CLC
27d8 : a5 43 __ LDA T2 + 0 
27da : 69 02 __ ADC #$02
27dc : 8d cc 3f STA $3fcc ; (txt + 0)
27df : a5 44 __ LDA T2 + 1 
27e1 : 69 00 __ ADC #$00
27e3 : 8d cd 3f STA $3fcd ; (txt + 1)
27e6 : 4c 1c 28 JMP $281c ; (_getnextch.s16 + 0)
.s11:
27e9 : c9 5f __ CMP #$5f
27eb : 90 2e __ BCC $281b ; (_getnextch.s1001 + 0)
.s20:
27ed : 84 44 __ STY T2 + 1 
27ef : a9 02 __ LDA #$02
27f1 : 8d de 3f STA $3fde ; (_cplw + 0)
27f4 : a9 01 __ LDA #$01
27f6 : 8d dd 3f STA $3fdd ; (_cplx + 0)
27f9 : ad db 3f LDA $3fdb ; (_ch + 0)
27fc : e9 5f __ SBC #$5f
27fe : 0a __ __ ASL
27ff : 26 44 __ ROL T2 + 1 
2801 : 18 __ __ CLC
2802 : 6d 7f 3f ADC $3f7f ; (packdata + 0)
2805 : 85 43 __ STA T2 + 0 
2807 : 8d df 3f STA $3fdf ; (_cpl + 0)
280a : ad 80 3f LDA $3f80 ; (packdata + 1)
280d : 65 44 __ ADC T2 + 1 
280f : 8d e0 3f STA $3fe0 ; (_cpl + 1)
.s29:
2812 : 85 44 __ STA T2 + 1 
2814 : a0 00 __ LDY #$00
2816 : b1 43 __ LDA (T2 + 0),y 
.s1015:
2818 : 8d db 3f STA $3fdb ; (_ch + 0)
.s1001:
281b : 60 __ __ RTS
.s16:
281c : a9 01 __ LDA #$01
281e : 8d dd 3f STA $3fdd ; (_cplx + 0)
2821 : ad db 3f LDA $3fdb ; (_ch + 0)
2824 : 85 1b __ STA ACCU + 0 
2826 : e6 1b __ INC ACCU + 0 
2828 : ad 6d 3f LDA $3f6d ; (shortdict + 0)
282b : 85 45 __ STA T3 + 0 
282d : 18 __ __ CLC
282e : 65 1b __ ADC ACCU + 0 
2830 : 85 43 __ STA T2 + 0 
2832 : ad 6e 3f LDA $3f6e ; (shortdict + 1)
2835 : 85 46 __ STA T3 + 1 
2837 : 69 00 __ ADC #$00
2839 : 85 44 __ STA T2 + 1 
283b : a0 00 __ LDY #$00
283d : b1 43 __ LDA (T2 + 0),y 
283f : 85 1c __ STA ACCU + 1 
2841 : b1 45 __ LDA (T3 + 0),y 
2843 : 18 __ __ CLC
2844 : 65 45 __ ADC T3 + 0 
2846 : a8 __ __ TAY
2847 : a5 46 __ LDA T3 + 1 
2849 : 69 00 __ ADC #$00
284b : aa __ __ TAX
284c : 98 __ __ TYA
284d : 18 __ __ CLC
284e : 69 01 __ ADC #$01
2850 : 90 01 __ BCC $2853 ; (_getnextch.s1017 + 0)
.s1016:
2852 : e8 __ __ INX
.s1017:
2853 : 18 __ __ CLC
2854 : 65 1c __ ADC ACCU + 1 
2856 : 8d df 3f STA $3fdf ; (_cpl + 0)
2859 : 90 01 __ BCC $285c ; (_getnextch.s1019 + 0)
.s1018:
285b : e8 __ __ INX
.s1019:
285c : 8e e0 3f STX $3fe0 ; (_cpl + 1)
285f : a0 01 __ LDY #$01
2861 : b1 43 __ LDA (T2 + 0),y 
2863 : 38 __ __ SEC
2864 : e5 1c __ SBC ACCU + 1 
2866 : 8d de 3f STA $3fde ; (_cplw + 0)
2869 : b1 45 __ LDA (T3 + 0),y 
286b : c5 1b __ CMP ACCU + 0 
286d : b0 03 __ BCS $2872 ; (_getnextch.s19 + 0)
.s17:
286f : ee e0 3f INC $3fe0 ; (_cpl + 1)
.s19:
2872 : ad df 3f LDA $3fdf ; (_cpl + 0)
2875 : 85 43 __ STA T2 + 0 
2877 : ad e0 3f LDA $3fe0 ; (_cpl + 1)
287a : 4c 12 28 JMP $2812 ; (_getnextch.s29 + 0)
--------------------------------------------------------------------
core_cr: ; core_cr()->void
.l34:
287d : 2c 11 d0 BIT $d011 
2880 : 10 fb __ BPL $287d ; (core_cr.l34 + 0)
.s1:
2882 : a9 00 __ LDA #$00
2884 : 8d d9 3f STA $3fd9 ; (txt_x + 0)
2887 : ad da 3f LDA $3fda ; (txt_y + 0)
288a : 85 47 __ STA T0 + 0 
288c : 18 __ __ CLC
288d : 69 01 __ ADC #$01
288f : 85 48 __ STA T2 + 0 
2891 : 8d da 3f STA $3fda ; (txt_y + 0)
2894 : ad db 3f LDA $3fdb ; (_ch + 0)
2897 : c9 20 __ CMP #$20
2899 : f0 04 __ BEQ $289f ; (core_cr.s5 + 0)
.s8:
289b : c9 1f __ CMP #$1f
289d : d0 03 __ BNE $28a2 ; (core_cr.s7 + 0)
.s5:
289f : 20 66 27 JSR $2766 ; (_getnextch.s0 + 0)
.s7:
28a2 : a5 48 __ LDA T2 + 0 
28a4 : c9 19 __ CMP #$19
28a6 : 90 08 __ BCC $28b0 ; (core_cr.s11 + 0)
.s9:
28a8 : 20 b4 28 JSR $28b4 ; (scrollup.l71 + 0)
28ab : a5 47 __ LDA T0 + 0 
28ad : 8d da 3f STA $3fda ; (txt_y + 0)
.s11:
28b0 : ee b2 3f INC $3fb2 ; (al + 0)
.s1001:
28b3 : 60 __ __ RTS
--------------------------------------------------------------------
scrollup: ; scrollup()->void
.l71:
28b4 : 2c 11 d0 BIT $d011 
28b7 : 10 fb __ BPL $28b4 ; (scrollup.l71 + 0)
.s1:
28b9 : ad a6 02 LDA $02a6 
28bc : d0 0e __ BNE $28cc ; (scrollup.l9 + 0)
.s5:
28be : a9 96 __ LDA #$96
28c0 : 85 0d __ STA P0 
28c2 : a9 00 __ LDA #$00
28c4 : 85 0e __ STA P1 
28c6 : 20 57 29 JSR $2957 ; (vic_waitLine.s0 + 0)
28c9 : 4c d6 28 JMP $28d6 ; (scrollup.s7 + 0)
.l9:
28cc : 2c 11 d0 BIT $d011 
28cf : 30 fb __ BMI $28cc ; (scrollup.l9 + 0)
.l12:
28d1 : 2c 11 d0 BIT $d011 
28d4 : 10 fb __ BPL $28d1 ; (scrollup.l12 + 0)
.s7:
28d6 : a5 01 __ LDA $01 
28d8 : 8d c7 3f STA $3fc7 ; (ch + 0)
28db : 78 __ __ SEI
28dc : 25 fc __ AND $fc 
28de : 85 01 __ STA $01 
28e0 : a2 28 __ LDX #$28
28e2 : ca __ __ DEX
28e3 : bd 58 f6 LDA $f658,x 
28e6 : 9d 30 f6 STA $f630,x 
28e9 : bd 80 f6 LDA $f680,x 
28ec : 9d 58 f6 STA $f658,x 
28ef : bd a8 f6 LDA $f6a8,x 
28f2 : 9d 80 f6 STA $f680,x 
28f5 : bd d0 f6 LDA $f6d0,x 
28f8 : 9d a8 f6 STA $f6a8,x 
28fb : bd f8 f6 LDA $f6f8,x 
28fe : 9d d0 f6 STA $f6d0,x 
2901 : bd 20 f7 LDA $f720,x 
2904 : 9d f8 f6 STA $f6f8,x 
2907 : bd 48 f7 LDA $f748,x 
290a : 9d 20 f7 STA $f720,x 
290d : bd 70 f7 LDA $f770,x 
2910 : 9d 48 f7 STA $f748,x 
2913 : bd 98 f7 LDA $f798,x 
2916 : 9d 70 f7 STA $f770,x 
2919 : bd c0 f7 LDA $f7c0,x 
291c : 9d 98 f7 STA $f798,x 
291f : a9 20 __ LDA #$20
2921 : 9d c0 f7 STA $f7c0,x 
2924 : e0 00 __ CPX #$00
2926 : d0 ba __ BNE $28e2 ; (scrollup.s7 + 12)
2928 : ad c7 3f LDA $3fc7 ; (ch + 0)
292b : 85 01 __ STA $01 
292d : 58 __ __ CLI
292e : a9 90 __ LDA #$90
2930 : 85 11 __ STA P4 
2932 : a9 01 __ LDA #$01
2934 : 85 12 __ STA P5 
2936 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
2939 : 18 __ __ CLC
293a : 69 30 __ ADC #$30
293c : 85 0d __ STA P0 
293e : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
2941 : 69 02 __ ADC #$02
2943 : 85 0e __ STA P1 
2945 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
2948 : 18 __ __ CLC
2949 : 69 58 __ ADC #$58
294b : 85 0f __ STA P2 
294d : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
2950 : 69 02 __ ADC #$02
2952 : 85 10 __ STA P3 
2954 : 4c 70 29 JMP $2970 ; (memmove.s0 + 0)
--------------------------------------------------------------------
vic_waitLine: ; vic_waitLine(i16)->void
.s0:
2957 : 46 0e __ LSR P1 ; (line + 1)
2959 : a9 00 __ LDA #$00
295b : 6a __ __ ROR
295c : 85 1b __ STA ACCU + 0 
295e : a4 0d __ LDY P0 ; (line + 0)
.l3:
2960 : 98 __ __ TYA
.l1006:
2961 : cd 12 d0 CMP $d012 
2964 : d0 fb __ BNE $2961 ; (vic_waitLine.l1006 + 0)
.s5:
2966 : ad 11 d0 LDA $d011 
2969 : 29 80 __ AND #$80
296b : c5 1b __ CMP ACCU + 0 
296d : d0 f1 __ BNE $2960 ; (vic_waitLine.l3 + 0)
.s1001:
296f : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
2970 : a5 12 __ LDA P5 ; (size + 1)
2972 : 30 5c __ BMI $29d0 ; (memmove.s3 + 0)
.s1006:
2974 : 05 11 __ ORA P4 ; (size + 0)
2976 : f0 58 __ BEQ $29d0 ; (memmove.s3 + 0)
.s1:
2978 : a5 0e __ LDA P1 ; (dst + 1)
297a : c5 10 __ CMP P3 ; (src + 1)
297c : d0 04 __ BNE $2982 ; (memmove.s1005 + 0)
.s1004:
297e : a5 0d __ LDA P0 ; (dst + 0)
2980 : c5 0f __ CMP P2 ; (src + 0)
.s1005:
2982 : 90 55 __ BCC $29d9 ; (memmove.s15 + 0)
.s5:
2984 : a5 10 __ LDA P3 ; (src + 1)
2986 : c5 0e __ CMP P1 ; (dst + 1)
2988 : d0 04 __ BNE $298e ; (memmove.s1003 + 0)
.s1002:
298a : a5 0f __ LDA P2 ; (src + 0)
298c : c5 0d __ CMP P0 ; (dst + 0)
.s1003:
298e : b0 40 __ BCS $29d0 ; (memmove.s3 + 0)
.s9:
2990 : a5 0f __ LDA P2 ; (src + 0)
2992 : 65 11 __ ADC P4 ; (size + 0)
2994 : 85 43 __ STA T4 + 0 
2996 : a5 10 __ LDA P3 ; (src + 1)
2998 : 65 12 __ ADC P5 ; (size + 1)
299a : 85 44 __ STA T4 + 1 
299c : 18 __ __ CLC
299d : a5 0d __ LDA P0 ; (dst + 0)
299f : 65 11 __ ADC P4 ; (size + 0)
29a1 : 85 1b __ STA ACCU + 0 
29a3 : a5 0e __ LDA P1 ; (dst + 1)
29a5 : 65 12 __ ADC P5 ; (size + 1)
29a7 : 85 1c __ STA ACCU + 1 
29a9 : a0 00 __ LDY #$00
29ab : a5 11 __ LDA P4 ; (size + 0)
29ad : f0 02 __ BEQ $29b1 ; (memmove.l1009 + 0)
.s1014:
29af : e6 12 __ INC P5 ; (size + 1)
.l1009:
29b1 : a6 11 __ LDX P4 ; (size + 0)
.l1017:
29b3 : a5 1b __ LDA ACCU + 0 
29b5 : d0 02 __ BNE $29b9 ; (memmove.s1024 + 0)
.s1023:
29b7 : c6 1c __ DEC ACCU + 1 
.s1024:
29b9 : c6 1b __ DEC ACCU + 0 
29bb : a5 43 __ LDA T4 + 0 
29bd : d0 02 __ BNE $29c1 ; (memmove.s1026 + 0)
.s1025:
29bf : c6 44 __ DEC T4 + 1 
.s1026:
29c1 : c6 43 __ DEC T4 + 0 
29c3 : b1 43 __ LDA (T4 + 0),y 
29c5 : 91 1b __ STA (ACCU + 0),y 
29c7 : ca __ __ DEX
29c8 : d0 e9 __ BNE $29b3 ; (memmove.l1017 + 0)
.s1018:
29ca : 86 11 __ STX P4 ; (size + 0)
29cc : c6 12 __ DEC P5 ; (size + 1)
29ce : d0 e1 __ BNE $29b1 ; (memmove.l1009 + 0)
.s3:
29d0 : a5 0d __ LDA P0 ; (dst + 0)
29d2 : 85 1b __ STA ACCU + 0 
29d4 : a5 0e __ LDA P1 ; (dst + 1)
29d6 : 85 1c __ STA ACCU + 1 
.s1001:
29d8 : 60 __ __ RTS
.s15:
29d9 : a5 0d __ LDA P0 ; (dst + 0)
29db : 85 1b __ STA ACCU + 0 
29dd : a5 0e __ LDA P1 ; (dst + 1)
29df : 85 1c __ STA ACCU + 1 
29e1 : a0 00 __ LDY #$00
29e3 : a5 11 __ LDA P4 ; (size + 0)
29e5 : f0 02 __ BEQ $29e9 ; (memmove.l1007 + 0)
.s1012:
29e7 : e6 12 __ INC P5 ; (size + 1)
.l1007:
29e9 : a6 11 __ LDX P4 ; (size + 0)
.l1015:
29eb : b1 0f __ LDA (P2),y ; (src + 0)
29ed : 91 1b __ STA (ACCU + 0),y 
29ef : e6 0f __ INC P2 ; (src + 0)
29f1 : d0 02 __ BNE $29f5 ; (memmove.s1020 + 0)
.s1019:
29f3 : e6 10 __ INC P3 ; (src + 1)
.s1020:
29f5 : e6 1b __ INC ACCU + 0 
29f7 : d0 02 __ BNE $29fb ; (memmove.s1022 + 0)
.s1021:
29f9 : e6 1c __ INC ACCU + 1 
.s1022:
29fb : ca __ __ DEX
29fc : d0 ed __ BNE $29eb ; (memmove.l1015 + 0)
.s1016:
29fe : 86 11 __ STX P4 ; (size + 0)
2a00 : c6 12 __ DEC P5 ; (size + 1)
2a02 : d0 e5 __ BNE $29e9 ; (memmove.l1007 + 0)
2a04 : 90 ca __ BCC $29d0 ; (memmove.s3 + 0)
--------------------------------------------------------------------
_savechpos: ; _savechpos()->void
.s0:
2a06 : ad cc 3f LDA $3fcc ; (txt + 0)
2a09 : 8d e7 3f STA $3fe7 ; (btxt + 0)
2a0c : ad cd 3f LDA $3fcd ; (txt + 1)
2a0f : 8d e8 3f STA $3fe8 ; (btxt + 1)
2a12 : ad df 3f LDA $3fdf ; (_cpl + 0)
2a15 : 8d e9 3f STA $3fe9 ; (b_cpl + 0)
2a18 : ad e0 3f LDA $3fe0 ; (_cpl + 1)
2a1b : 8d ea 3f STA $3fea ; (b_cpl + 1)
2a1e : ad dd 3f LDA $3fdd ; (_cplx + 0)
2a21 : 8d eb 3f STA $3feb ; (b_cplx + 0)
2a24 : ad de 3f LDA $3fde ; (_cplw + 0)
2a27 : 8d ec 3f STA $3fec ; (b_cplw + 0)
.s1001:
2a2a : 60 __ __ RTS
--------------------------------------------------------------------
_restorechpos: ; _restorechpos()->void
.s0:
2a2b : ad e7 3f LDA $3fe7 ; (btxt + 0)
2a2e : 8d cc 3f STA $3fcc ; (txt + 0)
2a31 : ad e8 3f LDA $3fe8 ; (btxt + 1)
2a34 : 8d cd 3f STA $3fcd ; (txt + 1)
2a37 : ad e9 3f LDA $3fe9 ; (b_cpl + 0)
2a3a : 8d df 3f STA $3fdf ; (_cpl + 0)
2a3d : ad ea 3f LDA $3fea ; (b_cpl + 1)
2a40 : 8d e0 3f STA $3fe0 ; (_cpl + 1)
2a43 : ad eb 3f LDA $3feb ; (b_cplx + 0)
2a46 : 8d dd 3f STA $3fdd ; (_cplx + 0)
2a49 : ad ec 3f LDA $3fec ; (b_cplw + 0)
2a4c : 8d de 3f STA $3fde ; (_cplw + 0)
.s1001:
2a4f : 60 __ __ RTS
--------------------------------------------------------------------
cr: ; cr()->void
.l30:
2a50 : 2c 11 d0 BIT $d011 
2a53 : 10 fb __ BPL $2a50 ; (cr.l30 + 0)
.s1:
2a55 : ad 03 3f LDA $3f03 ; (text_y + 0)
2a58 : 85 45 __ STA T0 + 0 
2a5a : 18 __ __ CLC
2a5b : 69 01 __ ADC #$01
2a5d : 8d 03 3f STA $3f03 ; (text_y + 0)
2a60 : c9 0b __ CMP #$0b
2a62 : 90 08 __ BCC $2a6c ; (cr.s1001 + 0)
.s5:
2a64 : 20 b4 28 JSR $28b4 ; (scrollup.l71 + 0)
2a67 : a5 45 __ LDA T0 + 0 
2a69 : 8d 03 3f STA $3f03 ; (text_y + 0)
.s1001:
2a6c : 60 __ __ RTS
--------------------------------------------------------------------
ui_waitkey: ; ui_waitkey()->void
.s0:
2a6d : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
2a70 : 18 __ __ CLC
2a71 : 69 c0 __ ADC #$c0
2a73 : 85 43 __ STA T1 + 0 
2a75 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
2a78 : 69 03 __ ADC #$03
2a7a : 85 44 __ STA T1 + 1 
2a7c : ad ef 3e LDA $3eef ; (video_ram + 0)
2a7f : 18 __ __ CLC
2a80 : 69 c0 __ ADC #$c0
2a82 : 85 45 __ STA T2 + 0 
2a84 : ad f0 3e LDA $3ef0 ; (video_ram + 1)
2a87 : 69 03 __ ADC #$03
2a89 : 85 46 __ STA T2 + 1 
2a8b : a0 12 __ LDY #$12
.l1006:
2a8d : a9 0f __ LDA #$0f
2a8f : 91 43 __ STA (T1 + 0),y 
2a91 : a9 2e __ LDA #$2e
2a93 : 91 45 __ STA (T2 + 0),y 
2a95 : c8 __ __ INY
2a96 : c0 15 __ CPY #$15
2a98 : 90 f3 __ BCC $2a8d ; (ui_waitkey.l1006 + 0)
.s3:
2a9a : a9 15 __ LDA #$15
2a9c : 8d e1 3f STA $3fe1 ; (ll + 0)
2a9f : a9 00 __ LDA #$00
2aa1 : 8d e2 3f STA $3fe2 ; (ll + 1)
2aa4 : 20 c4 2a JSR $2ac4 ; (ui_getkey.l2 + 0)
2aa7 : a0 12 __ LDY #$12
.l1008:
2aa9 : a9 0f __ LDA #$0f
2aab : 91 43 __ STA (T1 + 0),y 
2aad : a9 20 __ LDA #$20
2aaf : 91 45 __ STA (T2 + 0),y 
2ab1 : c8 __ __ INY
2ab2 : c0 15 __ CPY #$15
2ab4 : 90 f3 __ BCC $2aa9 ; (ui_waitkey.l1008 + 0)
.s6:
2ab6 : a9 00 __ LDA #$00
2ab8 : 8d b2 3f STA $3fb2 ; (al + 0)
2abb : 8d e2 3f STA $3fe2 ; (ll + 1)
2abe : a9 15 __ LDA #$15
2ac0 : 8d e1 3f STA $3fe1 ; (ll + 0)
.s1001:
2ac3 : 60 __ __ RTS
--------------------------------------------------------------------
ui_getkey: ; ui_getkey()->void
.l2:
2ac4 : 20 9f ff JSR $ff9f 
2ac7 : 20 e4 ff JSR $ffe4 
2aca : 8d c7 3f STA $3fc7 ; (ch + 0)
2acd : ad c7 3f LDA $3fc7 ; (ch + 0)
2ad0 : d0 08 __ BNE $2ada ; (ui_getkey.s1001 + 0)
.l82:
2ad2 : 2c 11 d0 BIT $d011 
2ad5 : 10 fb __ BPL $2ad2 ; (ui_getkey.l82 + 0)
2ad7 : 4c c4 2a JMP $2ac4 ; (ui_getkey.l2 + 0)
.s1001:
2ada : 60 __ __ RTS
--------------------------------------------------------------------
adv_save: ; adv_save()->u8
.s0:
2adb : a9 00 __ LDA #$00
2add : 85 13 __ STA P6 
2adf : 20 23 2b JSR $2b23 ; (irq_detach.l30 + 0)
2ae2 : a9 d1 __ LDA #$d1
2ae4 : 85 0d __ STA P0 
2ae6 : a9 2b __ LDA #$2b
2ae8 : 85 0e __ STA P1 
2aea : ad 97 3f LDA $3f97 ; (objattr + 0)
2aed : 85 0f __ STA P2 
2aef : ad 98 3f LDA $3f98 ; (objattr + 1)
2af2 : 85 10 __ STA P3 
2af4 : ad ab 3f LDA $3fab ; (origram_len + 0)
2af7 : 85 11 __ STA P4 
2af9 : ad ac 3f LDA $3fac ; (origram_len + 1)
2afc : 85 12 __ STA P5 
2afe : 20 83 2b JSR $2b83 ; (disk_save.s0 + 0)
2b01 : 09 00 __ ORA #$00
2b03 : f0 07 __ BEQ $2b0c ; (adv_save.s1 + 0)
.s2:
2b05 : 20 d6 2b JSR $2bd6 ; (irq_attach.l27 + 0)
2b08 : a9 01 __ LDA #$01
2b0a : d0 14 __ BNE $2b20 ; (adv_save.s1001 + 0)
.s1:
2b0c : a9 02 __ LDA #$02
2b0e : 8d 20 d0 STA $d020 
.l32:
2b11 : 2c 11 d0 BIT $d011 
2b14 : 10 fb __ BPL $2b11 ; (adv_save.l32 + 0)
.s4:
2b16 : a9 00 __ LDA #$00
2b18 : 8d 20 d0 STA $d020 
2b1b : 20 d6 2b JSR $2bd6 ; (irq_attach.l27 + 0)
2b1e : a9 00 __ LDA #$00
.s1001:
2b20 : 85 1b __ STA ACCU + 0 
2b22 : 60 __ __ RTS
--------------------------------------------------------------------
irq_detach: ; irq_detach(u8)->void
.l30:
2b23 : 2c 11 d0 BIT $d011 
2b26 : 10 fb __ BPL $2b23 ; (irq_detach.l30 + 0)
.s1:
2b28 : 20 6e 2b JSR $2b6e ; (IRQ_reset.s0 + 0)
2b2b : a5 13 __ LDA P6 ; (mode + 0)
2b2d : f0 3c __ BEQ $2b6b ; (irq_detach.s5 + 0)
.s6:
2b2f : 20 bd 11 JSR $11bd ; (do_bitmapmode.s0 + 0)
2b32 : a9 00 __ LDA #$00
2b34 : 85 0f __ STA P2 
2b36 : 85 10 __ STA P3 
2b38 : a9 08 __ LDA #$08
2b3a : 85 11 __ STA P4 
2b3c : a9 02 __ LDA #$02
2b3e : 85 12 __ STA P5 
2b40 : a9 e0 __ LDA #$e0
2b42 : 85 0d __ STA P0 
2b44 : a9 f1 __ LDA #$f1
2b46 : 85 0e __ STA P1 
2b48 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
2b4b : a9 00 __ LDA #$00
2b4d : 85 0f __ STA P2 
2b4f : 85 10 __ STA P3 
2b51 : a9 08 __ LDA #$08
2b53 : 85 11 __ STA P4 
2b55 : a9 02 __ LDA #$02
2b57 : 85 12 __ STA P5 
2b59 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
2b5c : 18 __ __ CLC
2b5d : 69 e0 __ ADC #$e0
2b5f : 85 0d __ STA P0 
2b61 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
2b64 : 69 01 __ ADC #$01
2b66 : 85 0e __ STA P1 
2b68 : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
.s5:
2b6b : 4c b3 0c JMP $0cb3 ; (do_textmode.s0 + 0)
--------------------------------------------------------------------
IRQ_reset: ; IRQ_reset()->void
.s0:
2b6e : 78 __ __ SEI
2b6f : ad 1a d0 LDA $d01a 
2b72 : 29 fe __ AND #$fe
2b74 : 8d 1a d0 STA $d01a 
2b77 : a2 81 __ LDX #$81
2b79 : a0 ea __ LDY #$ea
2b7b : 8e 14 03 STX $0314 
2b7e : 8c 15 03 STY $0315 
2b81 : 58 __ __ CLI
.s1001:
2b82 : 60 __ __ RTS
--------------------------------------------------------------------
disk_save: ; disk_save(const u8*,u8*,u16)->u8
.s0:
2b83 : a5 0f __ LDA P2 ; (mem + 0)
2b85 : 8d ed 3f STA $3fed ; (diskmemlow + 0)
2b88 : 18 __ __ CLC
2b89 : 65 11 __ ADC P4 ; (len + 0)
2b8b : 8d ef 3f STA $3fef ; (ediskmemlow + 0)
2b8e : a5 10 __ LDA P3 ; (mem + 1)
2b90 : 8d ee 3f STA $3fee ; (diskmemhi + 0)
2b93 : 65 12 __ ADC P5 ; (len + 1)
2b95 : 8d f0 3f STA $3ff0 ; (ediskmemhi + 0)
2b98 : a9 07 __ LDA #$07
2b9a : a2 3b __ LDX #$3b
2b9c : a0 3f __ LDY #$3f
2b9e : 20 bd ff JSR $ffbd 
2ba1 : a9 01 __ LDA #$01
2ba3 : a6 ba __ LDX $ba 
2ba5 : d0 02 __ BNE $2ba9 ; (disk_save.s0 + 38)
2ba7 : a2 08 __ LDX #$08
2ba9 : a0 00 __ LDY #$00
2bab : 20 ba ff JSR $ffba 
2bae : ad ed 3f LDA $3fed ; (diskmemlow + 0)
2bb1 : 85 c1 __ STA $c1 
2bb3 : ad ee 3f LDA $3fee ; (diskmemhi + 0)
2bb6 : 85 c2 __ STA $c2 
2bb8 : ae ef 3f LDX $3fef ; (ediskmemlow + 0)
2bbb : ac f0 3f LDY $3ff0 ; (ediskmemhi + 0)
2bbe : a9 c1 __ LDA #$c1
2bc0 : 20 d8 ff JSR $ffd8 
2bc3 : b0 05 __ BCS $2bca ; (disk_save.s0 + 71)
2bc5 : a9 01 __ LDA #$01
2bc7 : 85 1b __ STA ACCU + 0 
2bc9 : 60 __ __ RTS
2bca : a9 00 __ LDA #$00
2bcc : 85 1b __ STA ACCU + 0 
.s1001:
2bce : a5 1b __ LDA ACCU + 0 
2bd0 : 60 __ __ RTS
--------------------------------------------------------------------
2bd1 : __ __ __ BYT 73 61 76 65 00                                  : save.
--------------------------------------------------------------------
irq_attach: ; irq_attach()->void
.l27:
2bd6 : 2c 11 d0 BIT $d011 
2bd9 : 10 fb __ BPL $2bd6 ; (irq_attach.l27 + 0)
.s1:
2bdb : 4c 7b 11 JMP $117b ; (IRQ_gfx_init.s0 + 0)
--------------------------------------------------------------------
mini_itoa: ; mini_itoa(i16,u8*)->void
.s0:
2bde : a5 0e __ LDA P1 ; (n + 1)
2be0 : 30 75 __ BMI $2c57 ; (mini_itoa.s3 + 0)
.s1012:
2be2 : d0 06 __ BNE $2bea ; (mini_itoa.s1 + 0)
.s1011:
2be4 : a5 0d __ LDA P0 ; (n + 0)
2be6 : c9 64 __ CMP #$64
2be8 : 90 6d __ BCC $2c57 ; (mini_itoa.s3 + 0)
.s1:
2bea : a5 0f __ LDA P2 ; (s + 0)
2bec : 85 1b __ STA ACCU + 0 
2bee : a5 10 __ LDA P3 ; (s + 1)
2bf0 : 85 1c __ STA ACCU + 1 
2bf2 : a9 30 __ LDA #$30
2bf4 : a0 00 __ LDY #$00
2bf6 : 91 0f __ STA (P2),y ; (s + 0)
2bf8 : a6 0d __ LDX P0 ; (n + 0)
.l1015:
2bfa : b1 1b __ LDA (ACCU + 0),y 
2bfc : 18 __ __ CLC
2bfd : 69 01 __ ADC #$01
2bff : 91 1b __ STA (ACCU + 0),y 
2c01 : 8a __ __ TXA
2c02 : 38 __ __ SEC
2c03 : e9 64 __ SBC #$64
2c05 : aa __ __ TAX
2c06 : a5 0e __ LDA P1 ; (n + 1)
2c08 : e9 00 __ SBC #$00
2c0a : 85 0e __ STA P1 ; (n + 1)
2c0c : d0 ec __ BNE $2bfa ; (mini_itoa.l1015 + 0)
.s1010:
2c0e : e0 64 __ CPX #$64
2c10 : b0 e8 __ BCS $2bfa ; (mini_itoa.l1015 + 0)
.s18:
2c12 : 86 0d __ STX P0 ; (n + 0)
2c14 : a9 01 __ LDA #$01
2c16 : 85 1b __ STA ACCU + 0 
2c18 : e0 0a __ CPX #$0a
2c1a : 90 31 __ BCC $2c4d ; (mini_itoa.s8 + 0)
.s32:
2c1c : a8 __ __ TAY
.s7:
2c1d : a9 30 __ LDA #$30
2c1f : 91 0f __ STA (P2),y ; (s + 0)
2c21 : a5 0d __ LDA P0 ; (n + 0)
2c23 : 30 17 __ BMI $2c3c ; (mini_itoa.s50 + 0)
.s1019:
2c25 : c9 0a __ CMP #$0a
2c27 : 90 13 __ BCC $2c3c ; (mini_itoa.s50 + 0)
.s1017:
2c29 : aa __ __ TAX
.l1013:
2c2a : b1 0f __ LDA (P2),y ; (s + 0)
2c2c : 18 __ __ CLC
2c2d : 69 01 __ ADC #$01
2c2f : 91 0f __ STA (P2),y ; (s + 0)
2c31 : 8a __ __ TXA
2c32 : 38 __ __ SEC
2c33 : e9 0a __ SBC #$0a
2c35 : aa __ __ TAX
2c36 : e0 0a __ CPX #$0a
2c38 : b0 f0 __ BCS $2c2a ; (mini_itoa.l1013 + 0)
.s1018:
2c3a : 85 0d __ STA P0 ; (n + 0)
.s50:
2c3c : e6 1b __ INC ACCU + 0 
.s9:
2c3e : 18 __ __ CLC
2c3f : a5 0d __ LDA P0 ; (n + 0)
2c41 : 69 30 __ ADC #$30
2c43 : a4 1b __ LDY ACCU + 0 
2c45 : 91 0f __ STA (P2),y ; (s + 0)
2c47 : a9 00 __ LDA #$00
2c49 : c8 __ __ INY
2c4a : 91 0f __ STA (P2),y ; (s + 0)
.s1001:
2c4c : 60 __ __ RTS
.s8:
2c4d : a4 1b __ LDY ACCU + 0 
2c4f : f0 ed __ BEQ $2c3e ; (mini_itoa.s9 + 0)
.s13:
2c51 : a9 30 __ LDA #$30
2c53 : 91 0f __ STA (P2),y ; (s + 0)
2c55 : d0 e5 __ BNE $2c3c ; (mini_itoa.s50 + 0)
.s3:
2c57 : a9 00 __ LDA #$00
2c59 : 85 1b __ STA ACCU + 0 
2c5b : a5 0e __ LDA P1 ; (n + 1)
2c5d : 30 ee __ BMI $2c4d ; (mini_itoa.s8 + 0)
.s1007:
2c5f : d0 06 __ BNE $2c67 ; (mini_itoa.s33 + 0)
.s1006:
2c61 : a5 0d __ LDA P0 ; (n + 0)
2c63 : c9 0a __ CMP #$0a
2c65 : 90 e6 __ BCC $2c4d ; (mini_itoa.s8 + 0)
.s33:
2c67 : a0 00 __ LDY #$00
2c69 : f0 b2 __ BEQ $2c1d ; (mini_itoa.s7 + 0)
--------------------------------------------------------------------
ui_room_update: ; ui_room_update()->void
.l27:
2c6b : 2c 11 d0 BIT $d011 
2c6e : 10 fb __ BPL $2c6b ; (ui_room_update.l27 + 0)
.s1:
2c70 : 20 76 2c JSR $2c76 ; (ui_room_gfx_update.l88 + 0)
2c73 : 4c 38 31 JMP $3138 ; (status_update.s0 + 0)
--------------------------------------------------------------------
ui_room_gfx_update: ; ui_room_gfx_update()->void
.l88:
2c76 : 2c 11 d0 BIT $d011 
2c79 : 10 fb __ BPL $2c76 ; (ui_room_gfx_update.l88 + 0)
.s1:
2c7b : 20 9a 2e JSR $2e9a ; (ui_openimage.s0 + 0)
2c7e : a5 1b __ LDA ACCU + 0 
2c80 : d0 03 __ BNE $2c85 ; (ui_room_gfx_update.s5 + 0)
.s6:
2c82 : 4c ed 30 JMP $30ed ; (ui_image_clean.s0 + 0)
.s5:
2c85 : a9 0a __ LDA #$0a
2c87 : 85 15 __ STA P8 
2c89 : a9 00 __ LDA #$00
2c8b : 85 16 __ STA P9 
2c8d : a9 e6 __ LDA #$e6
2c8f : 85 13 __ STA P6 
2c91 : a9 cb __ LDA #$cb
2c93 : 85 14 __ STA P7 
2c95 : 20 73 2f JSR $2f73 ; (ui_read.s0 + 0)
2c98 : a9 ff __ LDA #$ff
2c9a : 4d e6 cb EOR $cbe6 ; (head + 0)
2c9d : 85 4c __ STA T1 + 0 
2c9f : 85 13 __ STA P6 
2ca1 : 38 __ __ SEC
2ca2 : a9 cf __ LDA #$cf
2ca4 : ed e7 cb SBC $cbe7 ; (head + 1)
2ca7 : 85 4d __ STA T1 + 1 
2ca9 : 85 14 __ STA P7 
2cab : ad ee cb LDA $cbee ; (head + 8)
2cae : 18 __ __ CLC
2caf : 6d ea cb ADC $cbea ; (head + 4)
2cb2 : 85 15 __ STA P8 
2cb4 : ad ef cb LDA $cbef ; (head + 9)
2cb7 : 6d eb cb ADC $cbeb ; (head + 5)
2cba : 85 16 __ STA P9 
2cbc : 20 73 2f JSR $2f73 ; (ui_read.s0 + 0)
2cbf : ad 43 3f LDA $3f43 ; (slowmode + 0)
2cc2 : f0 26 __ BEQ $2cea ; (ui_room_gfx_update.s10 + 0)
.s8:
2cc4 : 20 4f 12 JSR $124f ; (ui_clear.s0 + 0)
2cc7 : a9 a0 __ LDA #$a0
2cc9 : 85 0f __ STA P2 
2ccb : a9 00 __ LDA #$00
2ccd : 85 10 __ STA P3 
2ccf : 85 12 __ STA P5 
2cd1 : a9 28 __ LDA #$28
2cd3 : 85 11 __ STA P4 
2cd5 : ad ef 3e LDA $3eef ; (video_ram + 0)
2cd8 : 18 __ __ CLC
2cd9 : 69 08 __ ADC #$08
2cdb : 85 0d __ STA P0 
2cdd : ad f0 3e LDA $3ef0 ; (video_ram + 1)
2ce0 : 69 02 __ ADC #$02
2ce2 : 85 0e __ STA P1 
2ce4 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
2ce7 : 20 63 30 JSR $3063 ; (ui_image_fade.s0 + 0)
.s10:
2cea : a5 01 __ LDA $01 
2cec : 85 4b __ STA T0 + 0 
2cee : a9 34 __ LDA #$34
2cf0 : 85 01 __ STA $01 
2cf2 : ad e9 cb LDA $cbe9 ; (head + 3)
2cf5 : cd eb cb CMP $cbeb ; (head + 5)
2cf8 : d0 08 __ BNE $2d02 ; (ui_room_gfx_update.s12 + 0)
.s1010:
2cfa : ad e8 cb LDA $cbe8 ; (head + 2)
2cfd : cd ea cb CMP $cbea ; (head + 4)
2d00 : f0 16 __ BEQ $2d18 ; (ui_room_gfx_update.s11 + 0)
.s12:
2d02 : a5 13 __ LDA P6 
2d04 : 85 0d __ STA P0 
2d06 : a5 14 __ LDA P7 
2d08 : 85 0e __ STA P1 
2d0a : a9 00 __ LDA #$00
2d0c : 85 0f __ STA P2 
2d0e : a9 f0 __ LDA #$f0
2d10 : 85 10 __ STA P3 
2d12 : 20 c2 0a JSR $0ac2 ; (hunpack.s0 + 0)
2d15 : 4c 35 2d JMP $2d35 ; (ui_room_gfx_update.s13 + 0)
.s11:
2d18 : a9 00 __ LDA #$00
2d1a : 85 0d __ STA P0 
2d1c : a9 f0 __ LDA #$f0
2d1e : 85 0e __ STA P1 
2d20 : a5 13 __ LDA P6 
2d22 : 85 0f __ STA P2 
2d24 : a5 14 __ LDA P7 
2d26 : 85 10 __ STA P3 
2d28 : ad e8 cb LDA $cbe8 ; (head + 2)
2d2b : 85 11 __ STA P4 
2d2d : ad e9 cb LDA $cbe9 ; (head + 3)
2d30 : 85 12 __ STA P5 
2d32 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
.s13:
2d35 : a5 4b __ LDA T0 + 0 
2d37 : 85 01 __ STA $01 
2d39 : a9 00 __ LDA #$00
2d3b : 85 4e __ STA T2 + 0 
2d3d : 85 4f __ STA T2 + 1 
2d3f : 85 1b __ STA ACCU + 0 
2d41 : 85 1c __ STA ACCU + 1 
2d43 : cd ed cb CMP $cbed ; (head + 7)
2d46 : d0 05 __ BNE $2d4d ; (ui_room_gfx_update.l1009 + 0)
.s1008:
2d48 : a5 1b __ LDA ACCU + 0 
2d4a : cd ec cb CMP $cbec ; (head + 6)
.l1009:
2d4d : b0 03 __ BCS $2d52 ; (ui_room_gfx_update.s16 + 0)
2d4f : 4c 47 2e JMP $2e47 ; (ui_room_gfx_update.s15 + 0)
.s16:
2d52 : a9 02 __ LDA #$02
2d54 : 85 15 __ STA P8 
2d56 : a9 00 __ LDA #$00
2d58 : 85 16 __ STA P9 
2d5a : a9 f0 __ LDA #$f0
2d5c : 85 13 __ STA P6 
2d5e : a9 cb __ LDA #$cb
2d60 : 85 14 __ STA P7 
2d62 : 20 73 2f JSR $2f73 ; (ui_read.s0 + 0)
2d65 : ad f0 cb LDA $cbf0 ; (bsize + 0)
2d68 : 0d f1 cb ORA $cbf1 ; (bsize + 1)
2d6b : f0 08 __ BEQ $2d75 ; (ui_room_gfx_update.s19 + 0)
.s27:
2d6d : a9 00 __ LDA #$00
2d6f : 85 4e __ STA T2 + 0 
2d71 : 85 4f __ STA T2 + 1 
2d73 : f0 16 __ BEQ $2d8b ; (ui_room_gfx_update.l18 + 0)
.s19:
2d75 : ad f4 3f LDA $3ff4 ; (fileptr + 0)
2d78 : 0d f5 3f ORA $3ff5 ; (fileptr + 1)
2d7b : d0 05 __ BNE $2d82 ; (ui_room_gfx_update.s24 + 0)
.s25:
2d7d : a9 02 __ LDA #$02
2d7f : 4c e5 30 JMP $30e5 ; (krnio_close.s1000 + 0)
.s24:
2d82 : a9 00 __ LDA #$00
2d84 : 8d f4 3f STA $3ff4 ; (fileptr + 0)
2d87 : 8d f5 3f STA $3ff5 ; (fileptr + 1)
.s1001:
2d8a : 60 __ __ RTS
.l18:
2d8b : a9 f2 __ LDA #$f2
2d8d : 85 13 __ STA P6 
2d8f : a9 cb __ LDA #$cb
2d91 : 85 14 __ STA P7 
2d93 : a9 02 __ LDA #$02
2d95 : 85 15 __ STA P8 
2d97 : a9 00 __ LDA #$00
2d99 : 85 16 __ STA P9 
2d9b : 20 73 2f JSR $2f73 ; (ui_read.s0 + 0)
2d9e : a5 4c __ LDA T1 + 0 
2da0 : 85 13 __ STA P6 
2da2 : a5 4d __ LDA T1 + 1 
2da4 : 85 14 __ STA P7 
2da6 : ad f2 cb LDA $cbf2 ; (size + 0)
2da9 : 85 15 __ STA P8 
2dab : ad f3 cb LDA $cbf3 ; (size + 1)
2dae : 85 16 __ STA P9 
2db0 : 20 73 2f JSR $2f73 ; (ui_read.s0 + 0)
2db3 : a5 01 __ LDA $01 
2db5 : 85 4b __ STA T0 + 0 
2db7 : a9 34 __ LDA #$34
2db9 : 85 01 __ STA $01 
2dbb : ad f0 cb LDA $cbf0 ; (bsize + 0)
2dbe : 38 __ __ SEC
2dbf : e5 4e __ SBC T2 + 0 
2dc1 : aa __ __ TAX
2dc2 : ad f1 cb LDA $cbf1 ; (bsize + 1)
2dc5 : e5 4f __ SBC T2 + 1 
2dc7 : cd f3 cb CMP $cbf3 ; (size + 1)
2dca : d0 05 __ BNE $2dd1 ; (ui_room_gfx_update.s23 + 0)
.s1006:
2dcc : ec f2 cb CPX $cbf2 ; (size + 0)
2dcf : f0 2d __ BEQ $2dfe ; (ui_room_gfx_update.s20 + 0)
.s23:
2dd1 : ad f3 cb LDA $cbf3 ; (size + 1)
2dd4 : cd e7 cb CMP $cbe7 ; (head + 1)
2dd7 : d0 08 __ BNE $2de1 ; (ui_room_gfx_update.s21 + 0)
.s1004:
2dd9 : ad f2 cb LDA $cbf2 ; (size + 0)
2ddc : cd e6 cb CMP $cbe6 ; (head + 0)
2ddf : f0 1d __ BEQ $2dfe ; (ui_room_gfx_update.s20 + 0)
.s21:
2de1 : a5 13 __ LDA P6 
2de3 : 85 0d __ STA P0 
2de5 : a5 14 __ LDA P7 
2de7 : 85 0e __ STA P1 
2de9 : ad 4f 3f LDA $3f4f ; (bitmap_image + 0)
2dec : 18 __ __ CLC
2ded : 65 4e __ ADC T2 + 0 
2def : 85 0f __ STA P2 
2df1 : ad 50 3f LDA $3f50 ; (bitmap_image + 1)
2df4 : 65 4f __ ADC T2 + 1 
2df6 : 85 10 __ STA P3 
2df8 : 20 c2 0a JSR $0ac2 ; (hunpack.s0 + 0)
2dfb : 4c 22 2e JMP $2e22 ; (ui_room_gfx_update.s22 + 0)
.s20:
2dfe : a5 13 __ LDA P6 
2e00 : 85 0f __ STA P2 
2e02 : a5 14 __ LDA P7 
2e04 : 85 10 __ STA P3 
2e06 : ad f2 cb LDA $cbf2 ; (size + 0)
2e09 : 85 11 __ STA P4 
2e0b : ad f3 cb LDA $cbf3 ; (size + 1)
2e0e : 85 12 __ STA P5 
2e10 : ad 4f 3f LDA $3f4f ; (bitmap_image + 0)
2e13 : 18 __ __ CLC
2e14 : 65 4e __ ADC T2 + 0 
2e16 : 85 0d __ STA P0 
2e18 : ad 50 3f LDA $3f50 ; (bitmap_image + 1)
2e1b : 65 4f __ ADC T2 + 1 
2e1d : 85 0e __ STA P1 
2e1f : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
.s22:
2e22 : a5 4b __ LDA T0 + 0 
2e24 : 85 01 __ STA $01 
2e26 : ad e6 cb LDA $cbe6 ; (head + 0)
2e29 : 18 __ __ CLC
2e2a : 65 4e __ ADC T2 + 0 
2e2c : 85 4e __ STA T2 + 0 
2e2e : ad e7 cb LDA $cbe7 ; (head + 1)
2e31 : 65 4f __ ADC T2 + 1 
2e33 : 85 4f __ STA T2 + 1 
2e35 : cd f1 cb CMP $cbf1 ; (bsize + 1)
2e38 : d0 05 __ BNE $2e3f ; (ui_room_gfx_update.s1003 + 0)
.s1002:
2e3a : a5 4e __ LDA T2 + 0 
2e3c : cd f0 cb CMP $cbf0 ; (bsize + 0)
.s1003:
2e3f : b0 03 __ BCS $2e44 ; (ui_room_gfx_update.s1003 + 5)
2e41 : 4c 8b 2d JMP $2d8b ; (ui_room_gfx_update.l18 + 0)
2e44 : 4c 75 2d JMP $2d75 ; (ui_room_gfx_update.s19 + 0)
.s15:
2e47 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
2e4a : 65 4e __ ADC T2 + 0 
2e4c : 85 43 __ STA T4 + 0 
2e4e : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
2e51 : 65 4f __ ADC T2 + 1 
2e53 : 85 44 __ STA T4 + 1 
2e55 : ad ea cb LDA $cbea ; (head + 4)
2e58 : 18 __ __ CLC
2e59 : 65 1b __ ADC ACCU + 0 
2e5b : 85 46 __ STA T6 + 0 
2e5d : ad eb cb LDA $cbeb ; (head + 5)
2e60 : 65 1c __ ADC ACCU + 1 
2e62 : 18 __ __ CLC
2e63 : 65 4d __ ADC T1 + 1 
2e65 : 85 47 __ STA T6 + 1 
2e67 : a4 4c __ LDY T1 + 0 
2e69 : b1 46 __ LDA (T6 + 0),y 
2e6b : aa __ __ TAX
2e6c : 29 0f __ AND #$0f
2e6e : a0 00 __ LDY #$00
2e70 : 91 43 __ STA (T4 + 0),y 
2e72 : 8a __ __ TXA
2e73 : 29 f0 __ AND #$f0
2e75 : 4a __ __ LSR
2e76 : 4a __ __ LSR
2e77 : 4a __ __ LSR
2e78 : 4a __ __ LSR
2e79 : c8 __ __ INY
2e7a : 91 43 __ STA (T4 + 0),y 
2e7c : e6 1b __ INC ACCU + 0 
2e7e : d0 02 __ BNE $2e82 ; (ui_room_gfx_update.s1013 + 0)
.s1012:
2e80 : e6 1c __ INC ACCU + 1 
.s1013:
2e82 : 18 __ __ CLC
2e83 : a5 4e __ LDA T2 + 0 
2e85 : 69 02 __ ADC #$02
2e87 : 85 4e __ STA T2 + 0 
2e89 : 90 02 __ BCC $2e8d ; (ui_room_gfx_update.s1015 + 0)
.s1014:
2e8b : e6 4f __ INC T2 + 1 
.s1015:
2e8d : a5 1c __ LDA ACCU + 1 
2e8f : cd ed cb CMP $cbed ; (head + 7)
2e92 : f0 03 __ BEQ $2e97 ; (ui_room_gfx_update.s1015 + 10)
2e94 : 4c 4d 2d JMP $2d4d ; (ui_room_gfx_update.l1009 + 0)
2e97 : 4c 48 2d JMP $2d48 ; (ui_room_gfx_update.s1008 + 0)
--------------------------------------------------------------------
ui_openimage: ; ui_openimage()->u8
.s0:
2e9a : ad f3 3f LDA $3ff3 ; (imageid + 0)
2e9d : c9 ff __ CMP #$ff
2e9f : d0 05 __ BNE $2ea6 ; (ui_openimage.s3 + 0)
.s1:
2ea1 : a9 00 __ LDA #$00
2ea3 : 4c 30 2f JMP $2f30 ; (ui_openimage.s1001 + 0)
.s3:
2ea6 : 85 1b __ STA ACCU + 0 
2ea8 : a9 00 __ LDA #$00
2eaa : 85 1c __ STA ACCU + 1 
2eac : ad a7 3f LDA $3fa7 ; (imagesidx + 0)
2eaf : 0d a8 3f ORA $3fa8 ; (imagesidx + 1)
2eb2 : f0 2d __ BEQ $2ee1 ; (ui_openimage.s6 + 0)
.s5:
2eb4 : 06 1b __ ASL ACCU + 0 
2eb6 : 26 1c __ ROL ACCU + 1 
2eb8 : ad a7 3f LDA $3fa7 ; (imagesidx + 0)
2ebb : 18 __ __ CLC
2ebc : 65 1b __ ADC ACCU + 0 
2ebe : 85 1b __ STA ACCU + 0 
2ec0 : ad a8 3f LDA $3fa8 ; (imagesidx + 1)
2ec3 : 65 1c __ ADC ACCU + 1 
2ec5 : 85 1c __ STA ACCU + 1 
2ec7 : a0 01 __ LDY #$01
2ec9 : b1 1b __ LDA (ACCU + 0),y 
2ecb : aa __ __ TAX
2ecc : ad a9 3f LDA $3fa9 ; (imagesdata + 0)
2ecf : 18 __ __ CLC
2ed0 : 88 __ __ DEY
2ed1 : 71 1b __ ADC (ACCU + 0),y 
2ed3 : 8d f4 3f STA $3ff4 ; (fileptr + 0)
2ed6 : 8a __ __ TXA
2ed7 : 6d aa 3f ADC $3faa ; (imagesdata + 1)
2eda : 8d f5 3f STA $3ff5 ; (fileptr + 1)
2edd : a9 01 __ LDA #$01
2edf : d0 4f __ BNE $2f30 ; (ui_openimage.s1001 + 0)
.s6:
2ee1 : a2 0b __ LDX #$0b
.l1002:
2ee3 : bd 43 3f LDA $3f43,x ; (slowmode + 0)
2ee6 : 9d f3 cb STA $cbf3,x ; (size + 1)
2ee9 : ca __ __ DEX
2eea : d0 f7 __ BNE $2ee3 ; (ui_openimage.l1002 + 0)
.s1003:
2eec : a9 f4 __ LDA #$f4
2eee : 85 0d __ STA P0 
2ef0 : a9 cb __ LDA #$cb
2ef2 : 85 0e __ STA P1 
2ef4 : a5 ba __ LDA $ba 
2ef6 : d0 02 __ BNE $2efa ; (ui_openimage.s11 + 0)
.s9:
2ef8 : a9 08 __ LDA #$08
.s11:
2efa : 86 1c __ STX ACCU + 1 
2efc : 86 04 __ STX WORK + 1 
2efe : 85 43 __ STA T0 + 0 
2f00 : e6 1b __ INC ACCU + 0 
2f02 : a9 0a __ LDA #$0a
2f04 : 85 03 __ STA WORK + 0 
2f06 : 20 eb 3b JSR $3beb ; (divmod + 0)
2f09 : 18 __ __ CLC
2f0a : a5 1b __ LDA ACCU + 0 
2f0c : 69 30 __ ADC #$30
2f0e : 8d f8 cb STA $cbf8 ; (nm + 4)
2f11 : 18 __ __ CLC
2f12 : a5 05 __ LDA WORK + 2 
2f14 : 69 30 __ ADC #$30
2f16 : 8d f9 cb STA $cbf9 ; (nm + 5)
2f19 : 20 33 2f JSR $2f33 ; (krnio_setnam.s0 + 0)
2f1c : a9 02 __ LDA #$02
2f1e : 85 0d __ STA P0 
2f20 : a5 43 __ LDA T0 + 0 
2f22 : 85 0e __ STA P1 
2f24 : a9 00 __ LDA #$00
2f26 : 85 0f __ STA P2 
2f28 : 20 49 2f JSR $2f49 ; (krnio_open.s0 + 0)
2f2b : c9 01 __ CMP #$01
2f2d : a9 00 __ LDA #$00
2f2f : 2a __ __ ROL
.s1001:
2f30 : 85 1b __ STA ACCU + 0 
2f32 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
2f33 : a5 0d __ LDA P0 
2f35 : 05 0e __ ORA P1 
2f37 : f0 08 __ BEQ $2f41 ; (krnio_setnam.s0 + 14)
2f39 : a0 ff __ LDY #$ff
2f3b : c8 __ __ INY
2f3c : b1 0d __ LDA (P0),y 
2f3e : d0 fb __ BNE $2f3b ; (krnio_setnam.s0 + 8)
2f40 : 98 __ __ TYA
2f41 : a6 0d __ LDX P0 
2f43 : a4 0e __ LDY P1 
2f45 : 20 bd ff JSR $ffbd 
.s1001:
2f48 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_open: ; krnio_open(u8,u8,u8)->bool
.s0:
2f49 : a9 00 __ LDA #$00
2f4b : a6 0d __ LDX P0 ; (fnum + 0)
2f4d : 9d 54 40 STA $4054,x ; (krnio_pstatus + 0)
2f50 : a9 00 __ LDA #$00
2f52 : 85 1b __ STA ACCU + 0 
2f54 : 85 1c __ STA ACCU + 1 
2f56 : a5 0d __ LDA P0 ; (fnum + 0)
2f58 : a6 0e __ LDX P1 
2f5a : a4 0f __ LDY P2 
2f5c : 20 ba ff JSR $ffba 
2f5f : 20 c0 ff JSR $ffc0 
2f62 : 90 08 __ BCC $2f6c ; (krnio_open.s0 + 35)
2f64 : a5 0d __ LDA P0 ; (fnum + 0)
2f66 : 20 c3 ff JSR $ffc3 
2f69 : 4c 70 2f JMP $2f70 ; (krnio_open.s1001 + 0)
2f6c : a9 01 __ LDA #$01
2f6e : 85 1b __ STA ACCU + 0 
.s1001:
2f70 : a5 1b __ LDA ACCU + 0 
2f72 : 60 __ __ RTS
--------------------------------------------------------------------
ui_read: ; ui_read(void*,u16)->void
.s0:
2f73 : a5 15 __ LDA P8 ; (size + 0)
2f75 : 85 11 __ STA P4 
2f77 : a5 16 __ LDA P9 ; (size + 1)
2f79 : 85 12 __ STA P5 
2f7b : ad f5 3f LDA $3ff5 ; (fileptr + 1)
2f7e : 85 48 __ STA T2 + 1 
2f80 : ad f4 3f LDA $3ff4 ; (fileptr + 0)
2f83 : 85 47 __ STA T2 + 0 
2f85 : 05 48 __ ORA T2 + 1 
2f87 : d0 0f __ BNE $2f98 ; (ui_read.s1 + 0)
.s2:
2f89 : a9 02 __ LDA #$02
2f8b : 85 0e __ STA P1 
2f8d : a5 13 __ LDA P6 ; (what + 0)
2f8f : 85 0f __ STA P2 
2f91 : a5 14 __ LDA P7 ; (what + 1)
2f93 : 85 10 __ STA P3 
2f95 : 4c bb 2f JMP $2fbb ; (krnio_read.s0 + 0)
.s1:
2f98 : a5 13 __ LDA P6 ; (what + 0)
2f9a : 85 0d __ STA P0 
2f9c : a5 14 __ LDA P7 ; (what + 1)
2f9e : 85 0e __ STA P1 
2fa0 : a5 47 __ LDA T2 + 0 
2fa2 : 85 0f __ STA P2 
2fa4 : a5 48 __ LDA T2 + 1 
2fa6 : 85 10 __ STA P3 
2fa8 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
2fab : 18 __ __ CLC
2fac : a5 47 __ LDA T2 + 0 
2fae : 65 15 __ ADC P8 ; (size + 0)
2fb0 : 8d f4 3f STA $3ff4 ; (fileptr + 0)
2fb3 : a5 48 __ LDA T2 + 1 
2fb5 : 65 16 __ ADC P9 ; (size + 1)
2fb7 : 8d f5 3f STA $3ff5 ; (fileptr + 1)
.s1001:
2fba : 60 __ __ RTS
--------------------------------------------------------------------
krnio_read: ; krnio_read(u8,u8*,i16)->i16
.s0:
2fbb : a6 0e __ LDX P1 ; (fnum + 0)
2fbd : bd 54 40 LDA $4054,x ; (krnio_pstatus + 0)
2fc0 : c9 40 __ CMP #$40
2fc2 : d0 04 __ BNE $2fc8 ; (krnio_read.s3 + 0)
.s1:
2fc4 : a9 00 __ LDA #$00
2fc6 : f0 0c __ BEQ $2fd4 ; (krnio_read.s1010 + 0)
.s3:
2fc8 : 86 43 __ STX T1 + 0 
2fca : 8a __ __ TXA
2fcb : 20 35 30 JSR $3035 ; (krnio_chkin.s1000 + 0)
2fce : 09 00 __ ORA #$00
2fd0 : d0 07 __ BNE $2fd9 ; (krnio_read.s5 + 0)
.s6:
2fd2 : a9 ff __ LDA #$ff
.s1010:
2fd4 : 85 1b __ STA ACCU + 0 
.s1001:
2fd6 : 85 1c __ STA ACCU + 1 
2fd8 : 60 __ __ RTS
.s5:
2fd9 : a9 00 __ LDA #$00
2fdb : 85 44 __ STA T3 + 0 
2fdd : 85 45 __ STA T3 + 1 
2fdf : a5 12 __ LDA P5 ; (num + 1)
2fe1 : 30 46 __ BMI $3029 ; (krnio_read.s10 + 0)
.s1007:
2fe3 : 05 11 __ ORA P4 ; (num + 0)
2fe5 : f0 42 __ BEQ $3029 ; (krnio_read.s10 + 0)
.l9:
2fe7 : 20 49 30 JSR $3049 ; (krnio_chrin.s0 + 0)
2fea : a5 1b __ LDA ACCU + 0 
2fec : 85 46 __ STA T4 + 0 
2fee : 20 53 30 JSR $3053 ; (krnio_status.s0 + 0)
2ff1 : aa __ __ TAX
2ff2 : a4 43 __ LDY T1 + 0 
2ff4 : 99 54 40 STA $4054,y ; (krnio_pstatus + 0)
2ff7 : 09 00 __ ORA #$00
2ff9 : f0 04 __ BEQ $2fff ; (krnio_read.s13 + 0)
.s14:
2ffb : c9 40 __ CMP #$40
2ffd : d0 2a __ BNE $3029 ; (krnio_read.s10 + 0)
.s13:
2fff : a5 44 __ LDA T3 + 0 
3001 : 85 1b __ STA ACCU + 0 
3003 : 18 __ __ CLC
3004 : a5 10 __ LDA P3 ; (data + 1)
3006 : 65 45 __ ADC T3 + 1 
3008 : 85 1c __ STA ACCU + 1 
300a : a5 46 __ LDA T4 + 0 
300c : a4 0f __ LDY P2 ; (data + 0)
300e : 91 1b __ STA (ACCU + 0),y 
3010 : e6 44 __ INC T3 + 0 
3012 : d0 02 __ BNE $3016 ; (krnio_read.s1012 + 0)
.s1011:
3014 : e6 45 __ INC T3 + 1 
.s1012:
3016 : 8a __ __ TXA
3017 : d0 10 __ BNE $3029 ; (krnio_read.s10 + 0)
.s8:
3019 : 24 12 __ BIT P5 ; (num + 1)
301b : 30 0c __ BMI $3029 ; (krnio_read.s10 + 0)
.s1004:
301d : a5 45 __ LDA T3 + 1 
301f : c5 12 __ CMP P5 ; (num + 1)
3021 : d0 04 __ BNE $3027 ; (krnio_read.s1003 + 0)
.s1002:
3023 : a5 44 __ LDA T3 + 0 
3025 : c5 11 __ CMP P4 ; (num + 0)
.s1003:
3027 : 90 be __ BCC $2fe7 ; (krnio_read.l9 + 0)
.s10:
3029 : 20 5f 30 JSR $305f ; (krnio_clrchn.s0 + 0)
302c : a5 44 __ LDA T3 + 0 
302e : 85 1b __ STA ACCU + 0 
3030 : a5 45 __ LDA T3 + 1 
3032 : 4c d6 2f JMP $2fd6 ; (krnio_read.s1001 + 0)
--------------------------------------------------------------------
krnio_chkin: ; krnio_chkin(u8)->bool
.s1000:
3035 : 85 0d __ STA P0 
.s0:
3037 : a6 0d __ LDX P0 
3039 : 20 c6 ff JSR $ffc6 
303c : a9 00 __ LDA #$00
303e : 85 1c __ STA ACCU + 1 
3040 : b0 02 __ BCS $3044 ; (krnio_chkin.s0 + 13)
3042 : a9 01 __ LDA #$01
3044 : 85 1b __ STA ACCU + 0 
.s1001:
3046 : a5 1b __ LDA ACCU + 0 
3048 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_chrin: ; krnio_chrin()->i16
.s0:
3049 : 20 cf ff JSR $ffcf 
304c : 85 1b __ STA ACCU + 0 
304e : a9 00 __ LDA #$00
3050 : 85 1c __ STA ACCU + 1 
.s1001:
3052 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_status: ; krnio_status()->enum krnioerr
.s0:
3053 : 20 b7 ff JSR $ffb7 
3056 : 85 1b __ STA ACCU + 0 
3058 : a9 00 __ LDA #$00
305a : 85 1c __ STA ACCU + 1 
.s1001:
305c : a5 1b __ LDA ACCU + 0 
305e : 60 __ __ RTS
--------------------------------------------------------------------
krnio_clrchn: ; krnio_clrchn()->void
.s0:
305f : 20 cc ff JSR $ffcc 
.s1001:
3062 : 60 __ __ RTS
--------------------------------------------------------------------
ui_image_fade: ; ui_image_fade()->void
.s0:
3063 : a9 08 __ LDA #$08
3065 : 85 43 __ STA T0 + 0 
3067 : a9 f2 __ LDA #$f2
3069 : 85 44 __ STA T0 + 1 
306b : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
306e : 18 __ __ CLC
306f : 69 08 __ ADC #$08
3071 : 85 45 __ STA T1 + 0 
3073 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
3076 : 69 02 __ ADC #$02
3078 : 85 46 __ STA T1 + 1 
307a : a9 0c __ LDA #$0c
307c : 85 47 __ STA T2 + 0 
.l5:
307e : 2c 11 d0 BIT $d011 
3081 : 10 fb __ BPL $307e ; (ui_image_fade.l5 + 0)
.s4:
3083 : a5 43 __ LDA T0 + 0 
3085 : 85 0d __ STA P0 
3087 : a5 44 __ LDA T0 + 1 
3089 : 85 0e __ STA P1 
308b : a9 00 __ LDA #$00
308d : 85 0f __ STA P2 
308f : 85 10 __ STA P3 
3091 : 85 12 __ STA P5 
3093 : a9 28 __ LDA #$28
3095 : 85 11 __ STA P4 
3097 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
309a : a5 45 __ LDA T1 + 0 
309c : 85 0d __ STA P0 
309e : a5 46 __ LDA T1 + 1 
30a0 : 85 0e __ STA P1 
30a2 : a9 00 __ LDA #$00
30a4 : 85 0f __ STA P2 
30a6 : 85 10 __ STA P3 
30a8 : 85 12 __ STA P5 
30aa : a9 28 __ LDA #$28
30ac : 85 11 __ STA P4 
30ae : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
30b1 : 18 __ __ CLC
30b2 : a5 43 __ LDA T0 + 0 
30b4 : 69 d8 __ ADC #$d8
30b6 : 85 43 __ STA T0 + 0 
30b8 : b0 02 __ BCS $30bc ; (ui_image_fade.s1003 + 0)
.s1002:
30ba : c6 44 __ DEC T0 + 1 
.s1003:
30bc : 18 __ __ CLC
30bd : a5 45 __ LDA T1 + 0 
30bf : 69 d8 __ ADC #$d8
30c1 : 85 45 __ STA T1 + 0 
30c3 : b0 02 __ BCS $30c7 ; (ui_image_fade.s1005 + 0)
.s1004:
30c5 : c6 46 __ DEC T1 + 1 
.s1005:
30c7 : a6 47 __ LDX T2 + 0 
30c9 : c6 47 __ DEC T2 + 0 
30cb : 8a __ __ TXA
30cc : d0 b0 __ BNE $307e ; (ui_image_fade.l5 + 0)
.s3:
30ce : 85 0f __ STA P2 
30d0 : 85 10 __ STA P3 
30d2 : 85 11 __ STA P4 
30d4 : a9 0f __ LDA #$0f
30d6 : 85 12 __ STA P5 
30d8 : ad 4f 3f LDA $3f4f ; (bitmap_image + 0)
30db : 85 0d __ STA P0 
30dd : ad 50 3f LDA $3f50 ; (bitmap_image + 1)
30e0 : 85 0e __ STA P1 
30e2 : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
--------------------------------------------------------------------
krnio_close: ; krnio_close(u8)->void
.s1000:
30e5 : 85 0d __ STA P0 
.s0:
30e7 : a5 0d __ LDA P0 
30e9 : 20 c3 ff JSR $ffc3 
.s1001:
30ec : 60 __ __ RTS
--------------------------------------------------------------------
ui_image_clean: ; ui_image_clean()->void
.s0:
30ed : a9 00 __ LDA #$00
30ef : 85 0f __ STA P2 
30f1 : 85 10 __ STA P3 
30f3 : 85 0d __ STA P0 
30f5 : a9 e0 __ LDA #$e0
30f7 : 85 11 __ STA P4 
30f9 : a9 01 __ LDA #$01
30fb : 85 12 __ STA P5 
30fd : a9 f0 __ LDA #$f0
30ff : 85 0e __ STA P1 
3101 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
3104 : a9 00 __ LDA #$00
3106 : 85 0f __ STA P2 
3108 : 85 10 __ STA P3 
310a : a9 e0 __ LDA #$e0
310c : 85 11 __ STA P4 
310e : a9 01 __ LDA #$01
3110 : 85 12 __ STA P5 
3112 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
3115 : 85 0d __ STA P0 
3117 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
311a : 85 0e __ STA P1 
311c : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
311f : a9 00 __ LDA #$00
3121 : 85 0f __ STA P2 
3123 : 85 10 __ STA P3 
3125 : 85 11 __ STA P4 
3127 : a9 0f __ LDA #$0f
3129 : 85 12 __ STA P5 
312b : ad 4f 3f LDA $3f4f ; (bitmap_image + 0)
312e : 85 0d __ STA P0 
3130 : ad 50 3f LDA $3f50 ; (bitmap_image + 1)
3133 : 85 0e __ STA P1 
3135 : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
--------------------------------------------------------------------
status_update: ; status_update()->void
.s0:
3138 : ad 8b 3f LDA $3f8b ; (roomnameid + 0)
313b : 85 46 __ STA T2 + 0 
313d : ad 8c 3f LDA $3f8c ; (roomnameid + 1)
3140 : 85 47 __ STA T2 + 1 
3142 : ac 04 3f LDY $3f04 ; (room + 0)
3145 : b1 46 __ LDA (T2 + 0),y 
3147 : 8d c8 3f STA $3fc8 ; (strid + 0)
314a : c9 ff __ CMP #$ff
314c : d0 03 __ BNE $3151 ; (status_update.s1 + 0)
314e : 4c da 31 JMP $31da ; (status_update.s2 + 0)
.s1:
3151 : ad 6f 3f LDA $3f6f ; (advnames + 0)
3154 : 8d c9 3f STA $3fc9 ; (str + 0)
3157 : ad 70 3f LDA $3f70 ; (advnames + 1)
315a : 8d ca 3f STA $3fca ; (str + 1)
315d : 20 a6 23 JSR $23a6 ; (_getstring.s0 + 0)
3160 : a9 07 __ LDA #$07
3162 : 85 0f __ STA P2 
3164 : a9 00 __ LDA #$00
3166 : 85 10 __ STA P3 
3168 : 85 12 __ STA P5 
316a : a9 28 __ LDA #$28
316c : 85 11 __ STA P4 
316e : ad d1 3f LDA $3fd1 ; (ostr + 0)
3171 : 8d cc 3f STA $3fcc ; (txt + 0)
3174 : ad d2 3f LDA $3fd2 ; (ostr + 1)
3177 : 8d cd 3f STA $3fcd ; (txt + 1)
317a : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
317d : 18 __ __ CLC
317e : 69 08 __ ADC #$08
3180 : 85 0d __ STA P0 
3182 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
3185 : 69 02 __ ADC #$02
3187 : 85 0e __ STA P1 
3189 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
318c : a9 a0 __ LDA #$a0
318e : 85 0f __ STA P2 
3190 : a9 00 __ LDA #$00
3192 : 85 10 __ STA P3 
3194 : 85 12 __ STA P5 
3196 : a9 28 __ LDA #$28
3198 : 85 11 __ STA P4 
319a : ad ef 3e LDA $3eef ; (video_ram + 0)
319d : 18 __ __ CLC
319e : 69 08 __ ADC #$08
31a0 : 85 0d __ STA P0 
31a2 : ad f0 3e LDA $3ef0 ; (video_ram + 1)
31a5 : 69 02 __ ADC #$02
31a7 : 85 0e __ STA P1 
31a9 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
31ac : a9 00 __ LDA #$00
31ae : 8d b2 3f STA $3fb2 ; (al + 0)
31b1 : 8d d9 3f STA $3fd9 ; (txt_x + 0)
31b4 : a9 07 __ LDA #$07
31b6 : 8d d6 3f STA $3fd6 ; (txt_col + 0)
31b9 : a9 80 __ LDA #$80
31bb : 8d d8 3f STA $3fd8 ; (txt_rev + 0)
31be : a9 0d __ LDA #$0d
31c0 : 8d da 3f STA $3fda ; (txt_y + 0)
31c3 : 20 ff 24 JSR $24ff ; (core_drawtext.l138 + 0)
31c6 : ad a5 3f LDA $3fa5 ; (vars + 0)
31c9 : 85 44 __ STA T1 + 0 
31cb : ad a6 3f LDA $3fa6 ; (vars + 1)
31ce : 85 45 __ STA T1 + 1 
31d0 : a0 01 __ LDY #$01
31d2 : b1 44 __ LDA (T1 + 0),y 
31d4 : d0 01 __ BNE $31d7 ; (status_update.s4 + 0)
.s1001:
31d6 : 60 __ __ RTS
.s4:
31d7 : 4c 02 32 JMP $3202 ; (core_drawscore.s0 + 0)
.s2:
31da : a9 00 __ LDA #$00
31dc : 85 0f __ STA P2 
31de : 85 10 __ STA P3 
31e0 : 85 12 __ STA P5 
31e2 : a9 28 __ LDA #$28
31e4 : 85 11 __ STA P4 
31e6 : a9 a9 __ LDA #$a9
31e8 : 8d cc 3f STA $3fcc ; (txt + 0)
31eb : a9 32 __ LDA #$32
31ed : 8d cd 3f STA $3fcd ; (txt + 1)
31f0 : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
31f3 : 18 __ __ CLC
31f4 : 69 08 __ ADC #$08
31f6 : 85 0d __ STA P0 
31f8 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
31fb : 69 02 __ ADC #$02
31fd : 85 0e __ STA P1 
31ff : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
--------------------------------------------------------------------
core_drawscore: ; core_drawscore()->void
.s0:
3202 : ad a5 3f LDA $3fa5 ; (vars + 0)
3205 : 85 43 __ STA T0 + 0 
3207 : ad a6 3f LDA $3fa6 ; (vars + 1)
320a : 85 44 __ STA T0 + 1 
320c : a0 00 __ LDY #$00
320e : 84 45 __ STY T1 + 0 
3210 : 84 0e __ STY P1 
3212 : b1 43 __ LDA (T0 + 0),y 
3214 : 85 0d __ STA P0 
3216 : ad ad 3f LDA $3fad ; (tmp + 0)
3219 : 85 43 __ STA T0 + 0 
321b : 85 0f __ STA P2 
321d : ad ae 3f LDA $3fae ; (tmp + 1)
3220 : 85 44 __ STA T0 + 1 
3222 : 85 10 __ STA P3 
3224 : 20 de 2b JSR $2bde ; (mini_itoa.s0 + 0)
.l1:
3227 : a4 45 __ LDY T1 + 0 
3229 : e6 45 __ INC T1 + 0 
322b : b1 43 __ LDA (T0 + 0),y 
322d : d0 f8 __ BNE $3227 ; (core_drawscore.l1 + 0)
.s3:
322f : a9 2f __ LDA #$2f
3231 : 91 43 __ STA (T0 + 0),y 
3233 : 18 __ __ CLC
3234 : a5 43 __ LDA T0 + 0 
3236 : 65 45 __ ADC T1 + 0 
3238 : 85 0f __ STA P2 
323a : a5 44 __ LDA T0 + 1 
323c : 69 00 __ ADC #$00
323e : 85 10 __ STA P3 
3240 : ad a5 3f LDA $3fa5 ; (vars + 0)
3243 : 85 43 __ STA T0 + 0 
3245 : ad a6 3f LDA $3fa6 ; (vars + 1)
3248 : 85 44 __ STA T0 + 1 
324a : a0 01 __ LDY #$01
324c : b1 43 __ LDA (T0 + 0),y 
324e : 85 0d __ STA P0 
3250 : a9 00 __ LDA #$00
3252 : 85 0e __ STA P1 
3254 : 20 de 2b JSR $2bde ; (mini_itoa.s0 + 0)
3257 : ad ad 3f LDA $3fad ; (tmp + 0)
325a : 85 43 __ STA T0 + 0 
325c : ad ae 3f LDA $3fae ; (tmp + 1)
325f : 85 44 __ STA T0 + 1 
3261 : a4 45 __ LDY T1 + 0 
3263 : b1 43 __ LDA (T0 + 0),y 
3265 : f0 05 __ BEQ $326c ; (core_drawscore.s6 + 0)
.l5:
3267 : c8 __ __ INY
3268 : b1 43 __ LDA (T0 + 0),y 
326a : d0 fb __ BNE $3267 ; (core_drawscore.l5 + 0)
.s6:
326c : 84 45 __ STY T1 + 0 
326e : 38 __ __ SEC
326f : e5 45 __ SBC T1 + 0 
3271 : 85 43 __ STA T0 + 0 
3273 : a9 00 __ LDA #$00
3275 : e9 00 __ SBC #$00
3277 : aa __ __ TAX
3278 : ad ef 3e LDA $3eef ; (video_ram + 0)
327b : 18 __ __ CLC
327c : 69 30 __ ADC #$30
327e : a8 __ __ TAY
327f : ad f0 3e LDA $3ef0 ; (video_ram + 1)
3282 : 69 02 __ ADC #$02
3284 : 85 1c __ STA ACCU + 1 
3286 : 98 __ __ TYA
3287 : 18 __ __ CLC
3288 : 65 43 __ ADC T0 + 0 
328a : 85 43 __ STA T0 + 0 
328c : 8a __ __ TXA
328d : 65 1c __ ADC ACCU + 1 
328f : 85 44 __ STA T0 + 1 
3291 : a0 00 __ LDY #$00
3293 : f0 05 __ BEQ $329a ; (core_drawscore.l7 + 0)
.s8:
3295 : 09 80 __ ORA #$80
3297 : 91 43 __ STA (T0 + 0),y 
3299 : c8 __ __ INY
.l7:
329a : ad ad 3f LDA $3fad ; (tmp + 0)
329d : 85 1b __ STA ACCU + 0 
329f : ad ae 3f LDA $3fae ; (tmp + 1)
32a2 : 85 1c __ STA ACCU + 1 
32a4 : b1 1b __ LDA (ACCU + 0),y 
32a6 : d0 ed __ BNE $3295 ; (core_drawscore.s8 + 0)
.s1001:
32a8 : 60 __ __ RTS
--------------------------------------------------------------------
32a9 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
os_roomimage_load: ; os_roomimage_load()->void
.s0:
32aa : ad 43 3f LDA $3f43 ; (slowmode + 0)
32ad : c9 02 __ CMP #$02
32af : f0 3a __ BEQ $32eb ; (os_roomimage_load.s1 + 0)
.s3:
32b1 : ad 8f 3f LDA $3f8f ; (roomimg + 0)
32b4 : 85 47 __ STA T4 + 0 
32b6 : ad 90 3f LDA $3f90 ; (roomimg + 1)
32b9 : 85 48 __ STA T4 + 1 
32bb : ac 04 3f LDY $3f04 ; (room + 0)
32be : b1 47 __ LDA (T4 + 0),y 
32c0 : 85 50 __ STA T2 + 0 
32c2 : cd 52 3f CMP $3f52 ; (curimageid + 0)
32c5 : f0 1b __ BEQ $32e2 ; (os_roomimage_load.s5 + 0)
.s4:
32c7 : ad 43 3f LDA $3f43 ; (slowmode + 0)
32ca : 85 13 __ STA P6 
32cc : 20 23 2b JSR $2b23 ; (irq_detach.l30 + 0)
32cf : a5 50 __ LDA T2 + 0 
32d1 : 8d f3 3f STA $3ff3 ; (imageid + 0)
32d4 : 20 6b 2c JSR $2c6b ; (ui_room_update.l27 + 0)
32d7 : 20 d6 2b JSR $2bd6 ; (irq_attach.l27 + 0)
32da : a5 50 __ LDA T2 + 0 
32dc : 8d 52 3f STA $3f52 ; (curimageid + 0)
32df : 4c e5 32 JMP $32e5 ; (os_roomimage_load.l35 + 0)
.s5:
32e2 : 20 38 31 JSR $3138 ; (status_update.s0 + 0)
.l35:
32e5 : 2c 11 d0 BIT $d011 
32e8 : 10 fb __ BPL $32e5 ; (os_roomimage_load.l35 + 0)
.s1001:
32ea : 60 __ __ RTS
.s1:
32eb : ad 52 3f LDA $3f52 ; (curimageid + 0)
32ee : f0 f2 __ BEQ $32e2 ; (os_roomimage_load.s5 + 0)
.s25:
32f0 : a9 00 __ LDA #$00
32f2 : 85 50 __ STA T2 + 0 
32f4 : f0 d1 __ BEQ $32c7 ; (os_roomimage_load.s4 + 0)
--------------------------------------------------------------------
draw_roomobj: ; draw_roomobj()->void
.s1000:
32f6 : a5 53 __ LDA T3 + 0 
32f8 : 8d fe cb STA $cbfe ; (nm + 10)
.s0:
32fb : ad 67 3f LDA $3f67 ; (tmp2 + 0)
32fe : 8d cc 3f STA $3fcc ; (txt + 0)
3301 : ad 68 3f LDA $3f68 ; (tmp2 + 1)
3304 : 8d cd 3f STA $3fcd ; (txt + 1)
3307 : a9 00 __ LDA #$00
3309 : 8d b2 3f STA $3fb2 ; (al + 0)
330c : 85 51 __ STA T1 + 0 
330e : ad 6c 3f LDA $3f6c ; (obj_count + 0)
3311 : d0 03 __ BNE $3316 ; (draw_roomobj.s24 + 0)
3313 : 4c 07 34 JMP $3407 ; (draw_roomobj.s4 + 0)
.s24:
3316 : a9 00 __ LDA #$00
3318 : 85 52 __ STA T2 + 0 
331a : ad 99 3f LDA $3f99 ; (objloc + 0)
331d : 85 4f __ STA T0 + 0 
331f : ad 9a 3f LDA $3f9a ; (objloc + 1)
3322 : 85 50 __ STA T0 + 1 
3324 : ad b7 3f LDA $3fb7 ; (varroom + 0)
3327 : 85 53 __ STA T3 + 0 
.l2:
3329 : a5 53 __ LDA T3 + 0 
332b : a4 52 __ LDY T2 + 0 
332d : d1 4f __ CMP (T0 + 0),y 
332f : f0 03 __ BEQ $3334 ; (draw_roomobj.s5 + 0)
3331 : 4c fb 33 JMP $33fb ; (draw_roomobj.s3 + 0)
.s5:
3334 : ad 97 3f LDA $3f97 ; (objattr + 0)
3337 : 85 45 __ STA T5 + 0 
3339 : ad 98 3f LDA $3f98 ; (objattr + 1)
333c : 85 46 __ STA T5 + 1 
333e : ad ce 3f LDA $3fce ; (varattr + 0)
3341 : 31 45 __ AND (T5 + 0),y 
3343 : cd ce 3f CMP $3fce ; (varattr + 0)
3346 : f0 03 __ BEQ $334b ; (draw_roomobj.s8 + 0)
3348 : 4c fb 33 JMP $33fb ; (draw_roomobj.s3 + 0)
.s8:
334b : ad 93 3f LDA $3f93 ; (objnameid + 0)
334e : 85 45 __ STA T5 + 0 
3350 : ad 94 3f LDA $3f94 ; (objnameid + 1)
3353 : 85 46 __ STA T5 + 1 
3355 : b1 45 __ LDA (T5 + 0),y 
3357 : 8d c8 3f STA $3fc8 ; (strid + 0)
335a : c9 ff __ CMP #$ff
335c : d0 03 __ BNE $3361 ; (draw_roomobj.s12 + 0)
335e : 4c fb 33 JMP $33fb ; (draw_roomobj.s3 + 0)
.s12:
3361 : ad 6f 3f LDA $3f6f ; (advnames + 0)
3364 : 8d c9 3f STA $3fc9 ; (str + 0)
3367 : ad 70 3f LDA $3f70 ; (advnames + 1)
336a : 8d ca 3f STA $3fca ; (str + 1)
336d : 20 a6 23 JSR $23a6 ; (_getstring.s0 + 0)
3370 : a9 01 __ LDA #$01
3372 : 8d d6 3f STA $3fd6 ; (txt_col + 0)
3375 : ad d1 3f LDA $3fd1 ; (ostr + 0)
3378 : 85 43 __ STA T4 + 0 
337a : ad d2 3f LDA $3fd2 ; (ostr + 1)
337d : 85 44 __ STA T4 + 1 
337f : ad d4 3f LDA $3fd4 ; (etxt + 0)
3382 : 85 45 __ STA T5 + 0 
3384 : ad d5 3f LDA $3fd5 ; (etxt + 1)
3387 : 85 46 __ STA T5 + 1 
3389 : a5 51 __ LDA T1 + 0 
338b : f0 17 __ BEQ $33a4 ; (draw_roomobj.s17 + 0)
.s14:
338d : ad cc 3f LDA $3fcc ; (txt + 0)
3390 : 85 49 __ STA T8 + 0 
3392 : ad cd 3f LDA $3fcd ; (txt + 1)
3395 : 85 4a __ STA T8 + 1 
3397 : a9 2c __ LDA #$2c
3399 : a0 00 __ LDY #$00
339b : 91 49 __ STA (T8 + 0),y 
339d : a9 20 __ LDA #$20
339f : c8 __ __ INY
33a0 : 91 49 __ STA (T8 + 0),y 
33a2 : a9 02 __ LDA #$02
.s17:
33a4 : 85 47 __ STA T6 + 0 
33a6 : a5 44 __ LDA T4 + 1 
33a8 : c5 46 __ CMP T5 + 1 
33aa : d0 04 __ BNE $33b0 ; (draw_roomobj.s1007 + 0)
.s1006:
33ac : a5 43 __ LDA T4 + 0 
33ae : c5 45 __ CMP T5 + 0 
.s1007:
33b0 : b0 30 __ BCS $33e2 ; (draw_roomobj.s19 + 0)
.s23:
33b2 : ad cc 3f LDA $3fcc ; (txt + 0)
33b5 : 85 49 __ STA T8 + 0 
33b7 : ad cd 3f LDA $3fcd ; (txt + 1)
33ba : 85 4a __ STA T8 + 1 
.l18:
33bc : a0 00 __ LDY #$00
33be : b1 43 __ LDA (T4 + 0),y 
33c0 : a4 47 __ LDY T6 + 0 
33c2 : 91 49 __ STA (T8 + 0),y 
33c4 : e6 47 __ INC T6 + 0 
33c6 : e6 43 __ INC T4 + 0 
33c8 : d0 02 __ BNE $33cc ; (draw_roomobj.s1015 + 0)
.s1014:
33ca : e6 44 __ INC T4 + 1 
.s1015:
33cc : a5 44 __ LDA T4 + 1 
33ce : c5 46 __ CMP T5 + 1 
33d0 : d0 04 __ BNE $33d6 ; (draw_roomobj.s1005 + 0)
.s1004:
33d2 : a5 43 __ LDA T4 + 0 
33d4 : c5 45 __ CMP T5 + 0 
.s1005:
33d6 : 90 e4 __ BCC $33bc ; (draw_roomobj.l18 + 0)
.s26:
33d8 : a5 43 __ LDA T4 + 0 
33da : 8d d1 3f STA $3fd1 ; (ostr + 0)
33dd : a5 44 __ LDA T4 + 1 
33df : 8d d2 3f STA $3fd2 ; (ostr + 1)
.s19:
33e2 : ad cc 3f LDA $3fcc ; (txt + 0)
33e5 : 18 __ __ CLC
33e6 : 65 47 __ ADC T6 + 0 
33e8 : 85 43 __ STA T4 + 0 
33ea : ad cd 3f LDA $3fcd ; (txt + 1)
33ed : 69 00 __ ADC #$00
33ef : 85 44 __ STA T4 + 1 
33f1 : a9 00 __ LDA #$00
33f3 : a8 __ __ TAY
33f4 : 91 43 __ STA (T4 + 0),y 
33f6 : 20 ff 24 JSR $24ff ; (core_drawtext.l138 + 0)
33f9 : e6 51 __ INC T1 + 0 
.s3:
33fb : e6 52 __ INC T2 + 0 
33fd : a5 52 __ LDA T2 + 0 
33ff : cd 6c 3f CMP $3f6c ; (obj_count + 0)
3402 : b0 03 __ BCS $3407 ; (draw_roomobj.s4 + 0)
3404 : 4c 29 33 JMP $3329 ; (draw_roomobj.l2 + 0)
.s4:
3407 : a5 51 __ LDA T1 + 0 
3409 : f0 2d __ BEQ $3438 ; (draw_roomobj.s1001 + 0)
.s21:
340b : a9 01 __ LDA #$01
340d : 8d d6 3f STA $3fd6 ; (txt_col + 0)
3410 : ad cc 3f LDA $3fcc ; (txt + 0)
3413 : 85 4f __ STA T0 + 0 
3415 : ad cd 3f LDA $3fcd ; (txt + 1)
3418 : 85 50 __ STA T0 + 1 
341a : a9 2e __ LDA #$2e
341c : a0 00 __ LDY #$00
341e : 91 4f __ STA (T0 + 0),y 
3420 : 98 __ __ TYA
3421 : c8 __ __ INY
3422 : 91 4f __ STA (T0 + 0),y 
3424 : 20 ff 24 JSR $24ff ; (core_drawtext.l138 + 0)
3427 : a9 00 __ LDA #$00
3429 : 8d d7 3f STA $3fd7 ; (text_attach + 0)
342c : ad da 3f LDA $3fda ; (txt_y + 0)
342f : 38 __ __ SEC
3430 : e9 0e __ SBC #$0e
3432 : 8d 03 3f STA $3f03 ; (text_y + 0)
3435 : 20 50 2a JSR $2a50 ; (cr.l30 + 0)
.s1001:
3438 : ad fe cb LDA $cbfe ; (nm + 10)
343b : 85 53 __ STA T3 + 0 
343d : 60 __ __ RTS
--------------------------------------------------------------------
adv_onturn: ; adv_onturn()->void
.s0:
343e : a9 03 __ LDA #$03
3440 : 8d b4 3f STA $3fb4 ; (cmd + 0)
3443 : a9 ff __ LDA #$ff
3445 : 8d b5 3f STA $3fb5 ; (obj1 + 0)
3448 : 4c 47 13 JMP $1347 ; (adv_run.s1000 + 0)
--------------------------------------------------------------------
parser_update: ; parser_update()->void
.s1000:
344b : a5 53 __ LDA T3 + 0 
344d : 8d fd cb STA $cbfd ; (nm + 9)
3450 : a5 54 __ LDA T3 + 1 
3452 : 8d fe cb STA $cbfe ; (nm + 10)
.s0:
3455 : a9 00 __ LDA #$00
3457 : 8d b2 3f STA $3fb2 ; (al + 0)
345a : 8d d8 3f STA $3fd8 ; (txt_rev + 0)
345d : a9 01 __ LDA #$01
345f : 8d d9 3f STA $3fd9 ; (txt_x + 0)
3462 : ad 03 3f LDA $3f03 ; (text_y + 0)
3465 : 18 __ __ CLC
3466 : 69 0e __ ADC #$0e
3468 : 8d da 3f STA $3fda ; (txt_y + 0)
346b : 0a __ __ ASL
346c : 85 1b __ STA ACCU + 0 
346e : a9 00 __ LDA #$00
3470 : 2a __ __ ROL
3471 : 06 1b __ ASL ACCU + 0 
3473 : 2a __ __ ROL
3474 : aa __ __ TAX
3475 : a5 1b __ LDA ACCU + 0 
3477 : 6d da 3f ADC $3fda ; (txt_y + 0)
347a : 85 44 __ STA T1 + 0 
347c : 8a __ __ TXA
347d : 69 00 __ ADC #$00
347f : 06 44 __ ASL T1 + 0 
3481 : 2a __ __ ROL
3482 : 06 44 __ ASL T1 + 0 
3484 : 2a __ __ ROL
3485 : 06 44 __ ASL T1 + 0 
3487 : 2a __ __ ROL
3488 : 85 45 __ STA T1 + 1 
348a : ad f1 3e LDA $3ef1 ; (video_colorram + 0)
348d : 85 4f __ STA T2 + 0 
348f : 18 __ __ CLC
3490 : 65 44 __ ADC T1 + 0 
3492 : 85 53 __ STA T3 + 0 
3494 : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
3497 : 85 50 __ STA T2 + 1 
3499 : 65 45 __ ADC T1 + 1 
349b : 85 54 __ STA T3 + 1 
349d : a9 0c __ LDA #$0c
349f : 8d d6 3f STA $3fd6 ; (txt_col + 0)
34a2 : a0 00 __ LDY #$00
34a4 : 91 53 __ STA (T3 + 0),y 
34a6 : ad ef 3e LDA $3eef ; (video_ram + 0)
34a9 : 85 53 __ STA T3 + 0 
34ab : 18 __ __ CLC
34ac : 65 44 __ ADC T1 + 0 
34ae : 85 44 __ STA T1 + 0 
34b0 : ad f0 3e LDA $3ef0 ; (video_ram + 1)
34b3 : 85 54 __ STA T3 + 1 
34b5 : 65 45 __ ADC T1 + 1 
34b7 : 85 45 __ STA T1 + 1 
34b9 : a9 3e __ LDA #$3e
34bb : 91 44 __ STA (T1 + 0),y 
34bd : ad 01 3f LDA $3f01 ; (strcmd + 0)
34c0 : 8d cc 3f STA $3fcc ; (txt + 0)
34c3 : ad 02 3f LDA $3f02 ; (strcmd + 1)
34c6 : 8d cd 3f STA $3fcd ; (txt + 1)
34c9 : 20 ff 24 JSR $24ff ; (core_drawtext.l138 + 0)
34cc : ad da 3f LDA $3fda ; (txt_y + 0)
34cf : 0a __ __ ASL
34d0 : 85 1b __ STA ACCU + 0 
34d2 : a9 00 __ LDA #$00
34d4 : 8d b2 3f STA $3fb2 ; (al + 0)
34d7 : 2a __ __ ROL
34d8 : 06 1b __ ASL ACCU + 0 
34da : 2a __ __ ROL
34db : aa __ __ TAX
34dc : a5 1b __ LDA ACCU + 0 
34de : 6d da 3f ADC $3fda ; (txt_y + 0)
34e1 : 85 44 __ STA T1 + 0 
34e3 : 8a __ __ TXA
34e4 : 69 00 __ ADC #$00
34e6 : 06 44 __ ASL T1 + 0 
34e8 : 2a __ __ ROL
34e9 : 06 44 __ ASL T1 + 0 
34eb : 2a __ __ ROL
34ec : 06 44 __ ASL T1 + 0 
34ee : 2a __ __ ROL
34ef : aa __ __ TAX
34f0 : ad d9 3f LDA $3fd9 ; (txt_x + 0)
34f3 : 18 __ __ CLC
34f4 : 65 44 __ ADC T1 + 0 
34f6 : 85 44 __ STA T1 + 0 
34f8 : 90 01 __ BCC $34fb ; (parser_update.s1003 + 0)
.s1002:
34fa : e8 __ __ INX
.s1003:
34fb : 8a __ __ TXA
34fc : 18 __ __ CLC
34fd : 65 50 __ ADC T2 + 1 
34ff : 85 50 __ STA T2 + 1 
3501 : a9 00 __ LDA #$00
3503 : a4 44 __ LDY T1 + 0 
3505 : 91 4f __ STA (T2 + 0),y 
3507 : 8a __ __ TXA
3508 : 18 __ __ CLC
3509 : 65 54 __ ADC T3 + 1 
350b : 85 45 __ STA T1 + 1 
350d : a9 20 __ LDA #$20
350f : a4 53 __ LDY T3 + 0 
3511 : 91 44 __ STA (T1 + 0),y 
.l27:
3513 : 2c 11 d0 BIT $d011 
3516 : 10 fb __ BPL $3513 ; (parser_update.l27 + 0)
.s1001:
3518 : ad fd cb LDA $cbfd ; (nm + 9)
351b : 85 53 __ STA T3 + 0 
351d : ad fe cb LDA $cbfe ; (nm + 10)
3520 : 85 54 __ STA T3 + 1 
3522 : 60 __ __ RTS
--------------------------------------------------------------------
hide_blink: ; hide_blink()->void
.s0:
3523 : ad da 3f LDA $3fda ; (txt_y + 0)
3526 : 0a __ __ ASL
3527 : 85 1b __ STA ACCU + 0 
3529 : a9 00 __ LDA #$00
352b : 2a __ __ ROL
352c : 06 1b __ ASL ACCU + 0 
352e : 2a __ __ ROL
352f : aa __ __ TAX
3530 : a5 1b __ LDA ACCU + 0 
3532 : 6d da 3f ADC $3fda ; (txt_y + 0)
3535 : 85 1b __ STA ACCU + 0 
3537 : 8a __ __ TXA
3538 : 69 00 __ ADC #$00
353a : 06 1b __ ASL ACCU + 0 
353c : 2a __ __ ROL
353d : 06 1b __ ASL ACCU + 0 
353f : 2a __ __ ROL
3540 : 06 1b __ ASL ACCU + 0 
3542 : 2a __ __ ROL
3543 : aa __ __ TAX
3544 : ad d9 3f LDA $3fd9 ; (txt_x + 0)
3547 : 18 __ __ CLC
3548 : 65 1b __ ADC ACCU + 0 
354a : 90 01 __ BCC $354d ; (hide_blink.s1003 + 0)
.s1002:
354c : e8 __ __ INX
.s1003:
354d : 18 __ __ CLC
354e : 6d f1 3e ADC $3ef1 ; (video_colorram + 0)
3551 : 85 1b __ STA ACCU + 0 
3553 : 8a __ __ TXA
3554 : 6d f2 3e ADC $3ef2 ; (video_colorram + 1)
3557 : 85 1c __ STA ACCU + 1 
3559 : a9 00 __ LDA #$00
355b : a8 __ __ TAY
355c : 91 1b __ STA (ACCU + 0),y 
.s1001:
355e : 60 __ __ RTS
--------------------------------------------------------------------
execute: ; execute()->void
.s1000:
355f : a5 53 __ LDA T0 + 0 
3561 : 8d d0 cb STA $cbd0 ; (execute@stack + 0)
3564 : a5 54 __ LDA T0 + 1 
3566 : 8d d1 cb STA $cbd1 ; (execute@stack + 1)
.s0:
3569 : 20 50 2a JSR $2a50 ; (cr.l30 + 0)
356c : ad 01 3f LDA $3f01 ; (strcmd + 0)
356f : 85 53 __ STA T0 + 0 
3571 : 8d c9 3f STA $3fc9 ; (str + 0)
3574 : ad 02 3f LDA $3f02 ; (strcmd + 1)
3577 : 85 54 __ STA T0 + 1 
3579 : 8d ca 3f STA $3fca ; (str + 1)
357c : 20 95 35 JSR $3595 ; (adv_parse.s1000 + 0)
357f : a9 00 __ LDA #$00
3581 : 8d 63 3f STA $3f63 ; (icmd + 0)
3584 : a8 __ __ TAY
3585 : 91 53 __ STA (T0 + 0),y 
3587 : 20 4b 34 JSR $344b ; (parser_update.s1000 + 0)
.s1001:
358a : ad d0 cb LDA $cbd0 ; (execute@stack + 0)
358d : 85 53 __ STA T0 + 0 
358f : ad d1 cb LDA $cbd1 ; (execute@stack + 1)
3592 : 85 54 __ STA T0 + 1 
3594 : 60 __ __ RTS
--------------------------------------------------------------------
adv_parse: ; adv_parse()->void
.s1000:
3595 : a2 03 __ LDX #$03
3597 : b5 53 __ LDA T1 + 0,x 
3599 : 9d d2 cb STA $cbd2,x ; (adv_parse@stack + 0)
359c : ca __ __ DEX
359d : 10 f8 __ BPL $3597 ; (adv_parse.s1000 + 2)
.s0:
359f : a9 ff __ LDA #$ff
35a1 : 8d b4 3f STA $3fb4 ; (cmd + 0)
35a4 : a9 f9 __ LDA #$f9
35a6 : 8d c6 3f STA $3fc6 ; (obj2 + 0)
35a9 : 8d b5 3f STA $3fb5 ; (obj1 + 0)
35ac : a9 00 __ LDA #$00
35ae : 8d f7 3f STA $3ff7 ; (obj2k + 0)
35b1 : 8d f6 3f STA $3ff6 ; (obj1k + 0)
35b4 : ad c9 3f LDA $3fc9 ; (str + 0)
35b7 : 85 1b __ STA ACCU + 0 
35b9 : 8d d1 3f STA $3fd1 ; (ostr + 0)
35bc : ad ca 3f LDA $3fca ; (str + 1)
35bf : 85 1c __ STA ACCU + 1 
35c1 : 8d d2 3f STA $3fd2 ; (ostr + 1)
35c4 : a0 00 __ LDY #$00
35c6 : b1 1b __ LDA (ACCU + 0),y 
35c8 : f0 26 __ BEQ $35f0 ; (adv_parse.s3 + 0)
.l4:
35ca : ad d1 3f LDA $3fd1 ; (ostr + 0)
35cd : 85 1b __ STA ACCU + 0 
35cf : ad d2 3f LDA $3fd2 ; (ostr + 1)
35d2 : 85 1c __ STA ACCU + 1 
35d4 : a0 00 __ LDY #$00
35d6 : b1 1b __ LDA (ACCU + 0),y 
35d8 : c9 20 __ CMP #$20
35da : d0 14 __ BNE $35f0 ; (adv_parse.s3 + 0)
.s2:
35dc : 18 __ __ CLC
35dd : a5 1b __ LDA ACCU + 0 
35df : 69 01 __ ADC #$01
35e1 : 8d d1 3f STA $3fd1 ; (ostr + 0)
35e4 : a5 1c __ LDA ACCU + 1 
35e6 : 69 00 __ ADC #$00
35e8 : 8d d2 3f STA $3fd2 ; (ostr + 1)
35eb : c8 __ __ INY
35ec : b1 1b __ LDA (ACCU + 0),y 
35ee : d0 da __ BNE $35ca ; (adv_parse.l4 + 0)
.s3:
35f0 : ad d1 3f LDA $3fd1 ; (ostr + 0)
35f3 : 85 1b __ STA ACCU + 0 
35f5 : ad d2 3f LDA $3fd2 ; (ostr + 1)
35f8 : 85 1c __ STA ACCU + 1 
35fa : a0 00 __ LDY #$00
35fc : b1 1b __ LDA (ACCU + 0),y 
35fe : d0 0b __ BNE $360b ; (adv_parse.l9 + 0)
.s1001:
3600 : a2 03 __ LDX #$03
3602 : bd d2 cb LDA $cbd2,x ; (adv_parse@stack + 0)
3605 : 95 53 __ STA T1 + 0,x 
3607 : ca __ __ DEX
3608 : 10 f8 __ BPL $3602 ; (adv_parse.s1001 + 2)
360a : 60 __ __ RTS
.l9:
360b : 8c f8 3f STY $3ff8 ; (strdir + 0)
360e : 8c f9 3f STY $3ff9 ; (strdir + 1)
3611 : ad b4 3f LDA $3fb4 ; (cmd + 0)
3614 : 85 53 __ STA T1 + 0 
3616 : c9 ff __ CMP #$ff
3618 : f0 1f __ BEQ $3639 ; (adv_parse.s1002 + 0)
.s1003:
361a : a9 00 __ LDA #$00
361c : 85 56 __ STA T3 + 0 
361e : ad 79 3f LDA $3f79 ; (objs + 0)
3621 : 8d c9 3f STA $3fc9 ; (str + 0)
3624 : ad 7a 3f LDA $3f7a ; (objs + 1)
3627 : 8d ca 3f STA $3fca ; (str + 1)
362a : ad 7b 3f LDA $3f7b ; (objs_dir + 0)
362d : 8d f8 3f STA $3ff8 ; (strdir + 0)
3630 : ad 7c 3f LDA $3f7c ; (objs_dir + 1)
3633 : 8d f9 3f STA $3ff9 ; (strdir + 1)
3636 : 4c 49 36 JMP $3649 ; (adv_parse.s13 + 0)
.s1002:
3639 : a9 01 __ LDA #$01
363b : 85 56 __ STA T3 + 0 
363d : ad 77 3f LDA $3f77 ; (verbs + 0)
3640 : 8d c9 3f STA $3fc9 ; (str + 0)
3643 : ad 78 3f LDA $3f78 ; (verbs + 1)
3646 : 8d ca 3f STA $3fca ; (str + 1)
.s13:
3649 : ad d1 3f LDA $3fd1 ; (ostr + 0)
364c : 85 54 __ STA T2 + 0 
364e : ad d2 3f LDA $3fd2 ; (ostr + 1)
3651 : 85 55 __ STA T2 + 1 
3653 : 20 7a 37 JSR $377a ; (_findstring.s0 + 0)
3656 : ad fa 3f LDA $3ffa ; (cmdid + 0)
3659 : c9 ff __ CMP #$ff
365b : d0 03 __ BNE $3660 ; (adv_parse.s14 + 0)
365d : 4c 14 37 JMP $3714 ; (adv_parse.s15 + 0)
.s14:
3660 : a5 56 __ LDA T3 + 0 
3662 : f0 24 __ BEQ $3688 ; (adv_parse.s18 + 0)
.s17:
3664 : ad fa 3f LDA $3ffa ; (cmdid + 0)
3667 : 8d b4 3f STA $3fb4 ; (cmd + 0)
366a : a9 09 __ LDA #$09
366c : 85 11 __ STA P4 
366e : ad af 3f LDA $3faf ; (vrb + 0)
3671 : 85 0d __ STA P0 
3673 : ad b0 3f LDA $3fb0 ; (vrb + 1)
3676 : 85 0e __ STA P1 
3678 : ad ad 3f LDA $3fad ; (tmp + 0)
367b : 85 0f __ STA P2 
367d : ad ae 3f LDA $3fae ; (tmp + 1)
3680 : 85 10 __ STA P3 
3682 : 20 6a 3a JSR $3a6a ; (strncpy.s0 + 0)
3685 : 4c a7 36 JMP $36a7 ; (adv_parse.s137 + 0)
.s18:
3688 : ad f6 3f LDA $3ff6 ; (obj1k + 0)
368b : d0 0a __ BNE $3697 ; (adv_parse.s21 + 0)
.s20:
368d : ad fa 3f LDA $3ffa ; (cmdid + 0)
3690 : 8d b5 3f STA $3fb5 ; (obj1 + 0)
3693 : a9 01 __ LDA #$01
3695 : d0 77 __ BNE $370e ; (adv_parse.s1023 + 0)
.s21:
3697 : ad f7 3f LDA $3ff7 ; (obj2k + 0)
369a : d0 0b __ BNE $36a7 ; (adv_parse.s137 + 0)
.s23:
369c : ad fa 3f LDA $3ffa ; (cmdid + 0)
369f : 8d c6 3f STA $3fc6 ; (obj2 + 0)
36a2 : a9 01 __ LDA #$01
.s1024:
36a4 : 8d f7 3f STA $3ff7 ; (obj2k + 0)
.s137:
36a7 : ad d1 3f LDA $3fd1 ; (ostr + 0)
36aa : 85 54 __ STA T2 + 0 
36ac : ad d2 3f LDA $3fd2 ; (ostr + 1)
36af : 85 55 __ STA T2 + 1 
36b1 : a0 00 __ LDY #$00
36b3 : b1 54 __ LDA (T2 + 0),y 
36b5 : f0 26 __ BEQ $36dd ; (adv_parse.s8 + 0)
.l47:
36b7 : ad d1 3f LDA $3fd1 ; (ostr + 0)
36ba : 85 54 __ STA T2 + 0 
36bc : ad d2 3f LDA $3fd2 ; (ostr + 1)
36bf : 85 55 __ STA T2 + 1 
36c1 : a0 00 __ LDY #$00
36c3 : b1 54 __ LDA (T2 + 0),y 
36c5 : c9 20 __ CMP #$20
36c7 : d0 14 __ BNE $36dd ; (adv_parse.s8 + 0)
.s45:
36c9 : 18 __ __ CLC
36ca : a5 54 __ LDA T2 + 0 
36cc : 69 01 __ ADC #$01
36ce : 8d d1 3f STA $3fd1 ; (ostr + 0)
36d1 : a5 55 __ LDA T2 + 1 
36d3 : 69 00 __ ADC #$00
36d5 : 8d d2 3f STA $3fd2 ; (ostr + 1)
36d8 : c8 __ __ INY
36d9 : b1 54 __ LDA (T2 + 0),y 
36db : d0 da __ BNE $36b7 ; (adv_parse.l47 + 0)
.s8:
36dd : ad d1 3f LDA $3fd1 ; (ostr + 0)
36e0 : 85 54 __ STA T2 + 0 
36e2 : ad d2 3f LDA $3fd2 ; (ostr + 1)
36e5 : 85 55 __ STA T2 + 1 
36e7 : a0 00 __ LDY #$00
36e9 : b1 54 __ LDA (T2 + 0),y 
36eb : f0 03 __ BEQ $36f0 ; (adv_parse.s10 + 0)
36ed : 4c 0b 36 JMP $360b ; (adv_parse.l9 + 0)
.s10:
36f0 : 20 47 13 JSR $1347 ; (adv_run.s1000 + 0)
36f3 : 20 3e 34 JSR $343e ; (adv_onturn.s0 + 0)
36f6 : ad 51 3f LDA $3f51 ; (nextroom + 0)
36f9 : c9 fa __ CMP #$fa
36fb : d0 03 __ BNE $3700 ; (adv_parse.s48 + 0)
36fd : 4c 00 36 JMP $3600 ; (adv_parse.s1001 + 0)
.s48:
3700 : 8d b3 3f STA $3fb3 ; (newroom + 0)
3703 : a9 fa __ LDA #$fa
3705 : 8d 51 3f STA $3f51 ; (nextroom + 0)
3708 : 20 d3 12 JSR $12d3 ; (room_load.s1000 + 0)
370b : 4c 00 36 JMP $3600 ; (adv_parse.s1001 + 0)
.s1023:
370e : 8d f6 3f STA $3ff6 ; (obj1k + 0)
3711 : 4c a7 36 JMP $36a7 ; (adv_parse.s137 + 0)
.s15:
3714 : a5 53 __ LDA T1 + 0 
3716 : c9 ff __ CMP #$ff
3718 : f0 8d __ BEQ $36a7 ; (adv_parse.s137 + 0)
.s26:
371a : a5 54 __ LDA T2 + 0 
371c : 8d d1 3f STA $3fd1 ; (ostr + 0)
371f : a5 55 __ LDA T2 + 1 
3721 : 8d d2 3f STA $3fd2 ; (ostr + 1)
3724 : a9 00 __ LDA #$00
3726 : 8d f8 3f STA $3ff8 ; (strdir + 0)
3729 : 8d f9 3f STA $3ff9 ; (strdir + 1)
372c : ad 7d 3f LDA $3f7d ; (rooms + 0)
372f : 8d c9 3f STA $3fc9 ; (str + 0)
3732 : ad 7e 3f LDA $3f7e ; (rooms + 1)
3735 : 8d ca 3f STA $3fca ; (str + 1)
3738 : 20 7a 37 JSR $377a ; (_findstring.s0 + 0)
373b : ad f6 3f LDA $3ff6 ; (obj1k + 0)
373e : f0 1a __ BEQ $375a ; (adv_parse.s29 + 0)
.s30:
3740 : ad f7 3f LDA $3ff7 ; (obj2k + 0)
3743 : f0 03 __ BEQ $3748 ; (adv_parse.s38 + 0)
3745 : 4c a7 36 JMP $36a7 ; (adv_parse.s137 + 0)
.s38:
3748 : ad fa 3f LDA $3ffa ; (cmdid + 0)
374b : c9 ff __ CMP #$ff
374d : d0 03 __ BNE $3752 ; (adv_parse.s41 + 0)
374f : 4c a7 36 JMP $36a7 ; (adv_parse.s137 + 0)
.s41:
3752 : 8d c6 3f STA $3fc6 ; (obj2 + 0)
3755 : a9 02 __ LDA #$02
3757 : 4c a4 36 JMP $36a4 ; (adv_parse.s1024 + 0)
.s29:
375a : ad fa 3f LDA $3ffa ; (cmdid + 0)
375d : c9 ff __ CMP #$ff
375f : d0 12 __ BNE $3773 ; (adv_parse.s32 + 0)
.s33:
3761 : ad b5 3f LDA $3fb5 ; (obj1 + 0)
3764 : c9 f9 __ CMP #$f9
3766 : f0 03 __ BEQ $376b ; (adv_parse.s35 + 0)
3768 : 4c a7 36 JMP $36a7 ; (adv_parse.s137 + 0)
.s35:
376b : a9 ff __ LDA #$ff
376d : 8d b5 3f STA $3fb5 ; (obj1 + 0)
3770 : 4c a7 36 JMP $36a7 ; (adv_parse.s137 + 0)
.s32:
3773 : 8d b5 3f STA $3fb5 ; (obj1 + 0)
3776 : a9 02 __ LDA #$02
3778 : d0 94 __ BNE $370e ; (adv_parse.s1023 + 0)
--------------------------------------------------------------------
_findstring: ; _findstring()->void
.s0:
377a : a9 00 __ LDA #$00
377c : 8d fa 3f STA $3ffa ; (cmdid + 0)
377f : 8d c1 3f STA $3fc1 ; (i + 0)
3782 : 8d c2 3f STA $3fc2 ; (i + 1)
3785 : ad f9 3f LDA $3ff9 ; (strdir + 1)
3788 : 85 44 __ STA T0 + 1 
378a : ad f8 3f LDA $3ff8 ; (strdir + 0)
378d : 85 43 __ STA T0 + 0 
378f : 05 44 __ ORA T0 + 1 
3791 : f0 2d __ BEQ $37c0 ; (_findstring.s10 + 0)
.s1:
3793 : ad d1 3f LDA $3fd1 ; (ostr + 0)
3796 : 85 45 __ STA T1 + 0 
3798 : ad d2 3f LDA $3fd2 ; (ostr + 1)
379b : 85 46 __ STA T1 + 1 
379d : a0 00 __ LDY #$00
379f : b1 45 __ LDA (T1 + 0),y 
37a1 : c9 1a __ CMP #$1a
37a3 : b0 1b __ BCS $37c0 ; (_findstring.s10 + 0)
.s4:
37a5 : 0a __ __ ASL
37a6 : a8 __ __ TAY
37a7 : b1 43 __ LDA (T0 + 0),y 
37a9 : 8d c1 3f STA $3fc1 ; (i + 0)
37ac : c8 __ __ INY
37ad : b1 43 __ LDA (T0 + 0),y 
37af : 8d c2 3f STA $3fc2 ; (i + 1)
37b2 : c9 ff __ CMP #$ff
37b4 : d0 0a __ BNE $37c0 ; (_findstring.s10 + 0)
.s1015:
37b6 : ad c1 3f LDA $3fc1 ; (i + 0)
37b9 : c9 ff __ CMP #$ff
37bb : d0 03 __ BNE $37c0 ; (_findstring.s10 + 0)
37bd : 4c 6a 38 JMP $386a ; (_findstring.s9 + 0)
.s10:
37c0 : ad c9 3f LDA $3fc9 ; (str + 0)
37c3 : 18 __ __ CLC
37c4 : 6d c1 3f ADC $3fc1 ; (i + 0)
37c7 : 85 43 __ STA T0 + 0 
37c9 : ad ca 3f LDA $3fca ; (str + 1)
37cc : 6d c2 3f ADC $3fc2 ; (i + 1)
37cf : 85 44 __ STA T0 + 1 
37d1 : a0 00 __ LDY #$00
37d3 : b1 43 __ LDA (T0 + 0),y 
37d5 : d0 03 __ BNE $37da ; (_findstring.l11 + 0)
37d7 : 4c 6a 38 JMP $386a ; (_findstring.s9 + 0)
.l11:
37da : ad c1 3f LDA $3fc1 ; (i + 0)
37dd : 85 43 __ STA T0 + 0 
37df : 18 __ __ CLC
37e0 : 69 01 __ ADC #$01
37e2 : 85 45 __ STA T1 + 0 
37e4 : 8d c1 3f STA $3fc1 ; (i + 0)
37e7 : ad c2 3f LDA $3fc2 ; (i + 1)
37ea : 85 44 __ STA T0 + 1 
37ec : 69 00 __ ADC #$00
37ee : 85 46 __ STA T1 + 1 
37f0 : 8d c2 3f STA $3fc2 ; (i + 1)
37f3 : ad c9 3f LDA $3fc9 ; (str + 0)
37f6 : 85 48 __ STA T4 + 0 
37f8 : 18 __ __ CLC
37f9 : 65 43 __ ADC T0 + 0 
37fb : 85 43 __ STA T0 + 0 
37fd : ad ca 3f LDA $3fca ; (str + 1)
3800 : 85 49 __ STA T4 + 1 
3802 : 65 44 __ ADC T0 + 1 
3804 : 85 44 __ STA T0 + 1 
3806 : a0 00 __ LDY #$00
3808 : b1 43 __ LDA (T0 + 0),y 
380a : 85 47 __ STA T2 + 0 
380c : 8d d3 3f STA $3fd3 ; (len + 0)
380f : ad d1 3f LDA $3fd1 ; (ostr + 0)
3812 : 85 4a __ STA T5 + 0 
3814 : ad d2 3f LDA $3fd2 ; (ostr + 1)
3817 : 85 4b __ STA T5 + 1 
3819 : c8 __ __ INY
381a : b1 43 __ LDA (T0 + 0),y 
381c : 88 __ __ DEY
381d : d1 4a __ CMP (T5 + 0),y 
381f : d0 03 __ BNE $3824 ; (_findstring.s14 + 0)
3821 : 4c 0c 39 JMP $390c ; (_findstring.s13 + 0)
.s14:
3824 : ad f8 3f LDA $3ff8 ; (strdir + 0)
3827 : 0d f9 3f ORA $3ff9 ; (strdir + 1)
382a : d0 3e __ BNE $386a ; (_findstring.s9 + 0)
.s15:
382c : 18 __ __ CLC
382d : a5 47 __ LDA T2 + 0 
382f : 65 45 __ ADC T1 + 0 
3831 : 85 43 __ STA T0 + 0 
3833 : a9 00 __ LDA #$00
3835 : 65 46 __ ADC T1 + 1 
3837 : aa __ __ TAX
3838 : 18 __ __ CLC
3839 : a5 43 __ LDA T0 + 0 
383b : 69 01 __ ADC #$01
383d : 85 45 __ STA T1 + 0 
383f : 8a __ __ TXA
3840 : 69 00 __ ADC #$00
3842 : 85 46 __ STA T1 + 1 
3844 : 8a __ __ TXA
3845 : 18 __ __ CLC
3846 : 65 49 __ ADC T4 + 1 
3848 : 85 44 __ STA T0 + 1 
384a : a4 48 __ LDY T4 + 0 
384c : b1 43 __ LDA (T0 + 0),y 
384e : aa __ __ TAX
384f : c8 __ __ INY
3850 : b1 43 __ LDA (T0 + 0),y 
3852 : e0 ff __ CPX #$ff
3854 : d0 03 __ BNE $3859 ; (_findstring.s39 + 0)
3856 : 4c da 38 JMP $38da ; (_findstring.s38 + 0)
.s39:
3859 : aa __ __ TAX
385a : a5 45 __ LDA T1 + 0 
385c : 8d c1 3f STA $3fc1 ; (i + 0)
385f : a5 46 __ LDA T1 + 1 
3861 : 8d c2 3f STA $3fc2 ; (i + 1)
3864 : 8a __ __ TXA
3865 : f0 03 __ BEQ $386a ; (_findstring.s9 + 0)
3867 : 4c da 37 JMP $37da ; (_findstring.l11 + 0)
.s9:
386a : a9 ff __ LDA #$ff
386c : 8d fa 3f STA $3ffa ; (cmdid + 0)
386f : a9 00 __ LDA #$00
3871 : 8d c1 3f STA $3fc1 ; (i + 0)
3874 : 8d c2 3f STA $3fc2 ; (i + 1)
3877 : ad d1 3f LDA $3fd1 ; (ostr + 0)
387a : 85 43 __ STA T0 + 0 
387c : ad d2 3f LDA $3fd2 ; (ostr + 1)
387f : 85 44 __ STA T0 + 1 
3881 : a0 00 __ LDY #$00
3883 : b1 43 __ LDA (T0 + 0),y 
3885 : f0 52 __ BEQ $38d9 ; (_findstring.s1001 + 0)
.l44:
3887 : ad d1 3f LDA $3fd1 ; (ostr + 0)
388a : 85 43 __ STA T0 + 0 
388c : ad d2 3f LDA $3fd2 ; (ostr + 1)
388f : 85 44 __ STA T0 + 1 
3891 : a0 00 __ LDY #$00
3893 : b1 43 __ LDA (T0 + 0),y 
3895 : c9 20 __ CMP #$20
3897 : f0 40 __ BEQ $38d9 ; (_findstring.s1001 + 0)
.s42:
3899 : aa __ __ TAX
389a : 18 __ __ CLC
389b : a5 43 __ LDA T0 + 0 
389d : 69 01 __ ADC #$01
389f : 8d d1 3f STA $3fd1 ; (ostr + 0)
38a2 : a5 44 __ LDA T0 + 1 
38a4 : 69 00 __ ADC #$00
38a6 : 8d d2 3f STA $3fd2 ; (ostr + 1)
38a9 : ad c1 3f LDA $3fc1 ; (i + 0)
38ac : 85 45 __ STA T1 + 0 
38ae : ad c2 3f LDA $3fc2 ; (i + 1)
38b1 : d0 20 __ BNE $38d3 ; (_findstring.s114 + 0)
.s1002:
38b3 : a5 45 __ LDA T1 + 0 
38b5 : c9 20 __ CMP #$20
38b7 : b0 1a __ BCS $38d3 ; (_findstring.s114 + 0)
.s45:
38b9 : 8c c2 3f STY $3fc2 ; (i + 1)
38bc : 69 01 __ ADC #$01
38be : 8d c1 3f STA $3fc1 ; (i + 0)
38c1 : ad ad 3f LDA $3fad ; (tmp + 0)
38c4 : 18 __ __ CLC
38c5 : 65 45 __ ADC T1 + 0 
38c7 : 85 45 __ STA T1 + 0 
38c9 : ad ae 3f LDA $3fae ; (tmp + 1)
38cc : 69 00 __ ADC #$00
38ce : 85 46 __ STA T1 + 1 
38d0 : 8a __ __ TXA
38d1 : 91 45 __ STA (T1 + 0),y 
.s114:
38d3 : a0 01 __ LDY #$01
38d5 : b1 43 __ LDA (T0 + 0),y 
38d7 : d0 ae __ BNE $3887 ; (_findstring.l44 + 0)
.s1001:
38d9 : 60 __ __ RTS
.s38:
38da : 0a __ __ ASL
38db : a0 00 __ LDY #$00
38dd : 90 01 __ BCC $38e0 ; (_findstring.s1025 + 0)
.s1024:
38df : c8 __ __ INY
.s1025:
38e0 : 18 __ __ CLC
38e1 : 65 45 __ ADC T1 + 0 
38e3 : aa __ __ TAX
38e4 : 98 __ __ TYA
38e5 : 65 46 __ ADC T1 + 1 
38e7 : a8 __ __ TAY
38e8 : 8a __ __ TXA
38e9 : 18 __ __ CLC
38ea : 69 01 __ ADC #$01
38ec : 8d c1 3f STA $3fc1 ; (i + 0)
38ef : 98 __ __ TYA
38f0 : 69 00 __ ADC #$00
38f2 : 8d c2 3f STA $3fc2 ; (i + 1)
38f5 : 8a __ __ TXA
38f6 : 18 __ __ CLC
38f7 : 65 48 __ ADC T4 + 0 
38f9 : 85 43 __ STA T0 + 0 
38fb : 98 __ __ TYA
38fc : 65 49 __ ADC T4 + 1 
38fe : 85 44 __ STA T0 + 1 
3900 : a0 01 __ LDY #$01
3902 : b1 43 __ LDA (T0 + 0),y 
3904 : d0 03 __ BNE $3909 ; (_findstring.s1025 + 41)
3906 : 4c 6a 38 JMP $386a ; (_findstring.s9 + 0)
3909 : 4c da 37 JMP $37da ; (_findstring.l11 + 0)
.s13:
390c : 18 __ __ CLC
390d : a5 43 __ LDA T0 + 0 
390f : 69 01 __ ADC #$01
3911 : 85 0f __ STA P2 
3913 : a5 44 __ LDA T0 + 1 
3915 : 69 00 __ ADC #$00
3917 : 85 10 __ STA P3 
3919 : 18 __ __ CLC
391a : a5 47 __ LDA T2 + 0 
391c : 65 4a __ ADC T5 + 0 
391e : 85 4c __ STA T8 + 0 
3920 : a5 4b __ LDA T5 + 1 
3922 : 69 00 __ ADC #$00
3924 : 85 4d __ STA T8 + 1 
3926 : a4 47 __ LDY T2 + 0 
3928 : b1 4a __ LDA (T5 + 0),y 
392a : f0 07 __ BEQ $3933 ; (_findstring.s16 + 0)
.s19:
392c : c9 20 __ CMP #$20
392e : f0 03 __ BEQ $3933 ; (_findstring.s16 + 0)
3930 : 4c 2c 38 JMP $382c ; (_findstring.s15 + 0)
.s16:
3933 : 84 11 __ STY P4 
3935 : a5 4a __ LDA T5 + 0 
3937 : 85 0d __ STA P0 
3939 : a5 4b __ LDA T5 + 1 
393b : 85 0e __ STA P1 
393d : a9 00 __ LDA #$00
393f : 85 12 __ STA P5 
3941 : 20 16 3a JSR $3a16 ; (memcmp.s0 + 0)
3944 : a5 1b __ LDA ACCU + 0 
3946 : 05 1c __ ORA ACCU + 1 
3948 : f0 03 __ BEQ $394d ; (_findstring.s20 + 0)
394a : 4c 2c 38 JMP $382c ; (_findstring.s15 + 0)
.s20:
394d : a5 47 __ LDA T2 + 0 
394f : 85 11 __ STA P4 
3951 : a9 00 __ LDA #$00
3953 : 85 12 __ STA P5 
3955 : 18 __ __ CLC
3956 : a5 48 __ LDA T4 + 0 
3958 : 65 45 __ ADC T1 + 0 
395a : 85 0f __ STA P2 
395c : a5 49 __ LDA T4 + 1 
395e : 65 46 __ ADC T1 + 1 
3960 : 85 10 __ STA P3 
3962 : ad ad 3f LDA $3fad ; (tmp + 0)
3965 : 85 43 __ STA T0 + 0 
3967 : 85 0d __ STA P0 
3969 : ad ae 3f LDA $3fae ; (tmp + 1)
396c : 85 44 __ STA T0 + 1 
396e : 85 0e __ STA P1 
3970 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
3973 : a5 4c __ LDA T8 + 0 
3975 : 8d d1 3f STA $3fd1 ; (ostr + 0)
3978 : a5 4d __ LDA T8 + 1 
397a : 8d d2 3f STA $3fd2 ; (ostr + 1)
397d : 18 __ __ CLC
397e : a5 45 __ LDA T1 + 0 
3980 : 65 47 __ ADC T2 + 0 
3982 : 8d c1 3f STA $3fc1 ; (i + 0)
3985 : aa __ __ TAX
3986 : a5 46 __ LDA T1 + 1 
3988 : 69 00 __ ADC #$00
398a : 85 46 __ STA T1 + 1 
398c : 8d c2 3f STA $3fc2 ; (i + 1)
398f : a9 00 __ LDA #$00
3991 : a4 47 __ LDY T2 + 0 
3993 : 91 43 __ STA (T0 + 0),y 
3995 : 86 43 __ STX T0 + 0 
3997 : 18 __ __ CLC
3998 : a5 49 __ LDA T4 + 1 
399a : 65 46 __ ADC T1 + 1 
399c : 85 44 __ STA T0 + 1 
399e : a4 48 __ LDY T4 + 0 
39a0 : b1 43 __ LDA (T0 + 0),y 
39a2 : 8d fa 3f STA $3ffa ; (cmdid + 0)
39a5 : c9 ff __ CMP #$ff
39a7 : f0 01 __ BEQ $39aa ; (_findstring.s23 + 0)
39a9 : 60 __ __ RTS
.s23:
39aa : 8a __ __ TXA
39ab : 18 __ __ CLC
39ac : 69 02 __ ADC #$02
39ae : 8d c1 3f STA $3fc1 ; (i + 0)
39b1 : a5 46 __ LDA T1 + 1 
39b3 : 69 00 __ ADC #$00
39b5 : 8d c2 3f STA $3fc2 ; (i + 1)
39b8 : c8 __ __ INY
39b9 : b1 43 __ LDA (T0 + 0),y 
39bb : aa __ __ TAX
39bc : 18 __ __ CLC
39bd : 69 ff __ ADC #$ff
39bf : 8d d3 3f STA $3fd3 ; (len + 0)
39c2 : 8a __ __ TXA
39c3 : d0 01 __ BNE $39c6 ; (_findstring.s49 + 0)
39c5 : 60 __ __ RTS
.s49:
39c6 : ad 04 3f LDA $3f04 ; (room + 0)
39c9 : 85 47 __ STA T2 + 0 
.l27:
39cb : 18 __ __ CLC
39cc : a5 48 __ LDA T4 + 0 
39ce : 6d c1 3f ADC $3fc1 ; (i + 0)
39d1 : 85 45 __ STA T1 + 0 
39d3 : a5 49 __ LDA T4 + 1 
39d5 : 6d c2 3f ADC $3fc2 ; (i + 1)
39d8 : 85 46 __ STA T1 + 1 
39da : a0 01 __ LDY #$01
39dc : b1 45 __ LDA (T1 + 0),y 
39de : 8d fa 3f STA $3ffa ; (cmdid + 0)
39e1 : ae c1 3f LDX $3fc1 ; (i + 0)
39e4 : 8a __ __ TXA
39e5 : 18 __ __ CLC
39e6 : 69 01 __ ADC #$01
39e8 : 8d c1 3f STA $3fc1 ; (i + 0)
39eb : ad c2 3f LDA $3fc2 ; (i + 1)
39ee : 85 44 __ STA T0 + 1 
39f0 : 69 00 __ ADC #$00
39f2 : 8d c2 3f STA $3fc2 ; (i + 1)
39f5 : a5 47 __ LDA T2 + 0 
39f7 : 88 __ __ DEY
39f8 : d1 45 __ CMP (T1 + 0),y 
39fa : d0 01 __ BNE $39fd ; (_findstring.s31 + 0)
39fc : 60 __ __ RTS
.s31:
39fd : 8a __ __ TXA
39fe : 18 __ __ CLC
39ff : 69 02 __ ADC #$02
3a01 : 8d c1 3f STA $3fc1 ; (i + 0)
3a04 : a5 44 __ LDA T0 + 1 
3a06 : 69 00 __ ADC #$00
3a08 : 8d c2 3f STA $3fc2 ; (i + 1)
3a0b : ad d3 3f LDA $3fd3 ; (len + 0)
3a0e : ce d3 3f DEC $3fd3 ; (len + 0)
3a11 : 09 00 __ ORA #$00
3a13 : d0 b6 __ BNE $39cb ; (_findstring.l27 + 0)
3a15 : 60 __ __ RTS
--------------------------------------------------------------------
memcmp: ; memcmp(const void*,const void*,i16)->i16
.s0:
3a16 : a5 11 __ LDA P4 ; (size + 0)
3a18 : aa __ __ TAX
3a19 : 18 __ __ CLC
3a1a : 69 ff __ ADC #$ff
3a1c : 85 11 __ STA P4 ; (size + 0)
3a1e : a5 12 __ LDA P5 ; (size + 1)
3a20 : 85 1c __ STA ACCU + 1 
3a22 : 69 ff __ ADC #$ff
3a24 : 85 12 __ STA P5 ; (size + 1)
3a26 : 8a __ __ TXA
3a27 : 05 1c __ ORA ACCU + 1 
3a29 : f0 3a __ BEQ $3a65 ; (memcmp.s1006 + 0)
.s1008:
3a2b : a6 11 __ LDX P4 ; (size + 0)
.l2:
3a2d : a0 00 __ LDY #$00
3a2f : b1 0d __ LDA (P0),y ; (ptr1 + 0)
3a31 : d1 0f __ CMP (P2),y ; (ptr2 + 0)
3a33 : b0 04 __ BCS $3a39 ; (memcmp.s5 + 0)
.s4:
3a35 : a9 ff __ LDA #$ff
3a37 : 90 2c __ BCC $3a65 ; (memcmp.s1006 + 0)
.s5:
3a39 : b1 0f __ LDA (P2),y ; (ptr2 + 0)
3a3b : d1 0d __ CMP (P0),y ; (ptr1 + 0)
3a3d : b0 07 __ BCS $3a46 ; (memcmp.s1 + 0)
.s8:
3a3f : a9 01 __ LDA #$01
3a41 : 85 1b __ STA ACCU + 0 
3a43 : 98 __ __ TYA
3a44 : 90 21 __ BCC $3a67 ; (memcmp.s1001 + 0)
.s1:
3a46 : 86 1b __ STX ACCU + 0 
3a48 : 8a __ __ TXA
3a49 : 18 __ __ CLC
3a4a : 69 ff __ ADC #$ff
3a4c : aa __ __ TAX
3a4d : a5 12 __ LDA P5 ; (size + 1)
3a4f : a8 __ __ TAY
3a50 : 69 ff __ ADC #$ff
3a52 : 85 12 __ STA P5 ; (size + 1)
3a54 : e6 0d __ INC P0 ; (ptr1 + 0)
3a56 : d0 02 __ BNE $3a5a ; (memcmp.s1010 + 0)
.s1009:
3a58 : e6 0e __ INC P1 ; (ptr1 + 1)
.s1010:
3a5a : e6 0f __ INC P2 ; (ptr2 + 0)
3a5c : d0 02 __ BNE $3a60 ; (memcmp.s1012 + 0)
.s1011:
3a5e : e6 10 __ INC P3 ; (ptr2 + 1)
.s1012:
3a60 : 98 __ __ TYA
3a61 : 05 1b __ ORA ACCU + 0 
3a63 : d0 c8 __ BNE $3a2d ; (memcmp.l2 + 0)
.s1006:
3a65 : 85 1b __ STA ACCU + 0 
.s1001:
3a67 : 85 1c __ STA ACCU + 1 
3a69 : 60 __ __ RTS
--------------------------------------------------------------------
strncpy: ; strncpy(u8*,const u8*,u8)->u8*
.s0:
3a6a : a5 0d __ LDA P0 ; (destination + 0)
3a6c : 85 1b __ STA ACCU + 0 
3a6e : a5 0e __ LDA P1 ; (destination + 1)
3a70 : 85 1c __ STA ACCU + 1 
3a72 : 05 0d __ ORA P0 ; (destination + 0)
3a74 : d0 05 __ BNE $3a7b ; (strncpy.s2 + 0)
.s1:
3a76 : 85 1b __ STA ACCU + 0 
3a78 : 85 1c __ STA ACCU + 1 
3a7a : 60 __ __ RTS
.s2:
3a7b : a0 00 __ LDY #$00
3a7d : b1 0f __ LDA (P2),y ; (source + 0)
3a7f : f0 2c __ BEQ $3aad ; (strncpy.s7 + 0)
.s1003:
3a81 : a6 11 __ LDX P4 ; (num + 0)
3a83 : 8a __ __ TXA
3a84 : f0 27 __ BEQ $3aad ; (strncpy.s7 + 0)
.l6:
3a86 : a0 00 __ LDY #$00
3a88 : b1 0f __ LDA (P2),y ; (source + 0)
3a8a : 91 0d __ STA (P0),y ; (destination + 0)
3a8c : e6 0d __ INC P0 ; (destination + 0)
3a8e : d0 02 __ BNE $3a92 ; (strncpy.s1006 + 0)
.s1005:
3a90 : e6 0e __ INC P1 ; (destination + 1)
.s1006:
3a92 : a5 0f __ LDA P2 ; (source + 0)
3a94 : 85 43 __ STA T2 + 0 
3a96 : 18 __ __ CLC
3a97 : 69 01 __ ADC #$01
3a99 : 85 0f __ STA P2 ; (source + 0)
3a9b : a5 10 __ LDA P3 ; (source + 1)
3a9d : 85 44 __ STA T2 + 1 
3a9f : 69 00 __ ADC #$00
3aa1 : 85 10 __ STA P3 ; (source + 1)
3aa3 : a0 01 __ LDY #$01
3aa5 : ca __ __ DEX
3aa6 : b1 43 __ LDA (T2 + 0),y 
3aa8 : f0 03 __ BEQ $3aad ; (strncpy.s7 + 0)
.s8:
3aaa : 8a __ __ TXA
3aab : d0 d9 __ BNE $3a86 ; (strncpy.l6 + 0)
.s7:
3aad : a8 __ __ TAY
3aae : 91 0d __ STA (P0),y ; (destination + 0)
.s1001:
3ab0 : 60 __ __ RTS
--------------------------------------------------------------------
charmap: ; charmap(u8)->u8
.s0:
3ab1 : c9 30 __ CMP #$30
3ab3 : 90 04 __ BCC $3ab9 ; (charmap.s2 + 0)
.s4:
3ab5 : c9 3a __ CMP #$3a
3ab7 : 90 24 __ BCC $3add ; (charmap.s1001 + 0)
.s2:
3ab9 : c9 41 __ CMP #$41
3abb : 90 07 __ BCC $3ac4 ; (charmap.s6 + 0)
.s8:
3abd : c9 5b __ CMP #$5b
3abf : b0 03 __ BCS $3ac4 ; (charmap.s6 + 0)
.s5:
3ac1 : 69 c0 __ ADC #$c0
3ac3 : 60 __ __ RTS
.s6:
3ac4 : c9 61 __ CMP #$61
3ac6 : 90 07 __ BCC $3acf ; (charmap.s10 + 0)
.s12:
3ac8 : c9 7b __ CMP #$7b
3aca : b0 03 __ BCS $3acf ; (charmap.s10 + 0)
.s9:
3acc : 69 a0 __ ADC #$a0
3ace : 60 __ __ RTS
.s10:
3acf : c9 20 __ CMP #$20
3ad1 : f0 0a __ BEQ $3add ; (charmap.s1001 + 0)
.s14:
3ad3 : c9 2e __ CMP #$2e
3ad5 : f0 06 __ BEQ $3add ; (charmap.s1001 + 0)
.s17:
3ad7 : c9 2c __ CMP #$2c
3ad9 : f0 02 __ BEQ $3add ; (charmap.s1001 + 0)
.s20:
3adb : a9 00 __ LDA #$00
.s1001:
3add : 60 __ __ RTS
--------------------------------------------------------------------
do_blink: ; do_blink()->void
.s0:
3ade : ee fb 3f INC $3ffb ; (blink + 0)
3ae1 : ad fb 3f LDA $3ffb ; (blink + 0)
3ae4 : c9 5b __ CMP #$5b
3ae6 : 90 5e __ BCC $3b46 ; (do_blink.s1001 + 0)
.s1:
3ae8 : ad da 3f LDA $3fda ; (txt_y + 0)
3aeb : 0a __ __ ASL
3aec : 85 1b __ STA ACCU + 0 
3aee : a9 00 __ LDA #$00
3af0 : 8d fb 3f STA $3ffb ; (blink + 0)
3af3 : 2a __ __ ROL
3af4 : 06 1b __ ASL ACCU + 0 
3af6 : 2a __ __ ROL
3af7 : aa __ __ TAX
3af8 : a5 1b __ LDA ACCU + 0 
3afa : 6d da 3f ADC $3fda ; (txt_y + 0)
3afd : 85 1b __ STA ACCU + 0 
3aff : 8a __ __ TXA
3b00 : 69 00 __ ADC #$00
3b02 : 06 1b __ ASL ACCU + 0 
3b04 : 2a __ __ ROL
3b05 : 06 1b __ ASL ACCU + 0 
3b07 : 2a __ __ ROL
3b08 : 06 1b __ ASL ACCU + 0 
3b0a : 2a __ __ ROL
3b0b : aa __ __ TAX
3b0c : ad d9 3f LDA $3fd9 ; (txt_x + 0)
3b0f : 18 __ __ CLC
3b10 : 65 1b __ ADC ACCU + 0 
3b12 : 85 1b __ STA ACCU + 0 
3b14 : 90 01 __ BCC $3b17 ; (do_blink.s1007 + 0)
.s1006:
3b16 : e8 __ __ INX
.s1007:
3b17 : 86 1c __ STX ACCU + 1 
3b19 : 18 __ __ CLC
3b1a : 6d f1 3e ADC $3ef1 ; (video_colorram + 0)
3b1d : 85 43 __ STA T2 + 0 
3b1f : ad f2 3e LDA $3ef2 ; (video_colorram + 1)
3b22 : 65 1c __ ADC ACCU + 1 
3b24 : 85 44 __ STA T2 + 1 
3b26 : a0 00 __ LDY #$00
3b28 : b1 43 __ LDA (T2 + 0),y 
3b2a : f0 03 __ BEQ $3b2f ; (do_blink.s1008 + 0)
.s1009:
3b2c : 98 __ __ TYA
3b2d : f0 02 __ BEQ $3b31 ; (do_blink.s1010 + 0)
.s1008:
3b2f : a9 0c __ LDA #$0c
.s1010:
3b31 : 91 43 __ STA (T2 + 0),y 
3b33 : ad ef 3e LDA $3eef ; (video_ram + 0)
3b36 : 18 __ __ CLC
3b37 : 65 1b __ ADC ACCU + 0 
3b39 : 85 1b __ STA ACCU + 0 
3b3b : ad f0 3e LDA $3ef0 ; (video_ram + 1)
3b3e : 65 1c __ ADC ACCU + 1 
3b40 : 85 1c __ STA ACCU + 1 
3b42 : a9 6c __ LDA #$6c
3b44 : 91 1b __ STA (ACCU + 0),y 
.s1001:
3b46 : 60 __ __ RTS
--------------------------------------------------------------------
adv_reset: ; adv_reset()->void
.s0:
3b47 : ad 97 3f LDA $3f97 ; (objattr + 0)
3b4a : 85 0d __ STA P0 
3b4c : ad 98 3f LDA $3f98 ; (objattr + 1)
3b4f : 85 0e __ STA P1 
3b51 : a9 00 __ LDA #$00
3b53 : 85 0f __ STA P2 
3b55 : a9 05 __ LDA #$05
3b57 : 85 10 __ STA P3 
3b59 : ad ab 3f LDA $3fab ; (origram_len + 0)
3b5c : 85 11 __ STA P4 
3b5e : ad ac 3f LDA $3fac ; (origram_len + 1)
3b61 : 85 12 __ STA P5 
3b63 : 4c 60 0c JMP $0c60 ; (memcpy.s0 + 0)
--------------------------------------------------------------------
adv_load: ; adv_load()->u8
.s0:
3b66 : a9 00 __ LDA #$00
3b68 : 85 13 __ STA P6 
3b6a : 20 23 2b JSR $2b23 ; (irq_detach.l30 + 0)
3b6d : a9 d1 __ LDA #$d1
3b6f : 85 0d __ STA P0 
3b71 : a9 2b __ LDA #$2b
3b73 : 85 0e __ STA P1 
3b75 : ad 97 3f LDA $3f97 ; (objattr + 0)
3b78 : 85 0f __ STA P2 
3b7a : ad 98 3f LDA $3f98 ; (objattr + 1)
3b7d : 85 10 __ STA P3 
3b7f : ad ab 3f LDA $3fab ; (origram_len + 0)
3b82 : 85 11 __ STA P4 
3b84 : ad ac 3f LDA $3fac ; (origram_len + 1)
3b87 : 85 12 __ STA P5 
3b89 : 20 ae 3b JSR $3bae ; (disk_load.s0 + 0)
3b8c : 09 00 __ ORA #$00
3b8e : f0 07 __ BEQ $3b97 ; (adv_load.s1 + 0)
.s2:
3b90 : 20 d6 2b JSR $2bd6 ; (irq_attach.l27 + 0)
3b93 : a9 01 __ LDA #$01
3b95 : d0 14 __ BNE $3bab ; (adv_load.s1001 + 0)
.s1:
3b97 : a9 02 __ LDA #$02
3b99 : 8d 20 d0 STA $d020 
.l32:
3b9c : 2c 11 d0 BIT $d011 
3b9f : 10 fb __ BPL $3b9c ; (adv_load.l32 + 0)
.s4:
3ba1 : a9 00 __ LDA #$00
3ba3 : 8d 20 d0 STA $d020 
3ba6 : 20 d6 2b JSR $2bd6 ; (irq_attach.l27 + 0)
3ba9 : a9 00 __ LDA #$00
.s1001:
3bab : 85 1b __ STA ACCU + 0 
3bad : 60 __ __ RTS
--------------------------------------------------------------------
disk_load: ; disk_load(const u8*,u8*,u16)->u8
.s0:
3bae : a5 0f __ LDA P2 ; (mem + 0)
3bb0 : 8d ed 3f STA $3fed ; (diskmemlow + 0)
3bb3 : a5 10 __ LDA P3 ; (mem + 1)
3bb5 : 8d ee 3f STA $3fee ; (diskmemhi + 0)
3bb8 : a9 07 __ LDA #$07
3bba : a2 3b __ LDX #$3b
3bbc : a0 3f __ LDY #$3f
3bbe : 20 bd ff JSR $ffbd 
3bc1 : a9 01 __ LDA #$01
3bc3 : a6 ba __ LDX $ba 
3bc5 : d0 02 __ BNE $3bc9 ; (disk_load.s0 + 27)
3bc7 : a2 08 __ LDX #$08
3bc9 : a0 00 __ LDY #$00
3bcb : 20 ba ff JSR $ffba 
3bce : a9 00 __ LDA #$00
3bd0 : ae ed 3f LDX $3fed ; (diskmemlow + 0)
3bd3 : ac ee 3f LDY $3fee ; (diskmemhi + 0)
3bd6 : 20 d5 ff JSR $ffd5 
3bd9 : b0 05 __ BCS $3be0 ; (disk_load.s0 + 50)
3bdb : a9 01 __ LDA #$01
3bdd : 85 1b __ STA ACCU + 0 
3bdf : 60 __ __ RTS
3be0 : a9 00 __ LDA #$00
3be2 : 85 1b __ STA ACCU + 0 
.s1001:
3be4 : a5 1b __ LDA ACCU + 0 
3be6 : 60 __ __ RTS
--------------------------------------------------------------------
os_reset: ; os_reset()->void
.s0:
3be7 : 20 e2 fc JSR $fce2 
.s1001:
3bea : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
3beb : a5 1c __ LDA ACCU + 1 
3bed : d0 31 __ BNE $3c20 ; (divmod + 53)
3bef : a5 04 __ LDA WORK + 1 
3bf1 : d0 1e __ BNE $3c11 ; (divmod + 38)
3bf3 : 85 06 __ STA WORK + 3 
3bf5 : a2 04 __ LDX #$04
3bf7 : 06 1b __ ASL ACCU + 0 
3bf9 : 2a __ __ ROL
3bfa : c5 03 __ CMP WORK + 0 
3bfc : 90 02 __ BCC $3c00 ; (divmod + 21)
3bfe : e5 03 __ SBC WORK + 0 
3c00 : 26 1b __ ROL ACCU + 0 
3c02 : 2a __ __ ROL
3c03 : c5 03 __ CMP WORK + 0 
3c05 : 90 02 __ BCC $3c09 ; (divmod + 30)
3c07 : e5 03 __ SBC WORK + 0 
3c09 : 26 1b __ ROL ACCU + 0 
3c0b : ca __ __ DEX
3c0c : d0 eb __ BNE $3bf9 ; (divmod + 14)
3c0e : 85 05 __ STA WORK + 2 
3c10 : 60 __ __ RTS
3c11 : a5 1b __ LDA ACCU + 0 
3c13 : 85 05 __ STA WORK + 2 
3c15 : a5 1c __ LDA ACCU + 1 
3c17 : 85 06 __ STA WORK + 3 
3c19 : a9 00 __ LDA #$00
3c1b : 85 1b __ STA ACCU + 0 
3c1d : 85 1c __ STA ACCU + 1 
3c1f : 60 __ __ RTS
3c20 : a5 04 __ LDA WORK + 1 
3c22 : d0 1f __ BNE $3c43 ; (divmod + 88)
3c24 : a5 03 __ LDA WORK + 0 
3c26 : 30 1b __ BMI $3c43 ; (divmod + 88)
3c28 : a9 00 __ LDA #$00
3c2a : 85 06 __ STA WORK + 3 
3c2c : a2 10 __ LDX #$10
3c2e : 06 1b __ ASL ACCU + 0 
3c30 : 26 1c __ ROL ACCU + 1 
3c32 : 2a __ __ ROL
3c33 : c5 03 __ CMP WORK + 0 
3c35 : 90 02 __ BCC $3c39 ; (divmod + 78)
3c37 : e5 03 __ SBC WORK + 0 
3c39 : 26 1b __ ROL ACCU + 0 
3c3b : 26 1c __ ROL ACCU + 1 
3c3d : ca __ __ DEX
3c3e : d0 f2 __ BNE $3c32 ; (divmod + 71)
3c40 : 85 05 __ STA WORK + 2 
3c42 : 60 __ __ RTS
3c43 : a9 00 __ LDA #$00
3c45 : 85 05 __ STA WORK + 2 
3c47 : 85 06 __ STA WORK + 3 
3c49 : 84 02 __ STY $02 
3c4b : a0 10 __ LDY #$10
3c4d : 18 __ __ CLC
3c4e : 26 1b __ ROL ACCU + 0 
3c50 : 26 1c __ ROL ACCU + 1 
3c52 : 26 05 __ ROL WORK + 2 
3c54 : 26 06 __ ROL WORK + 3 
3c56 : 38 __ __ SEC
3c57 : a5 05 __ LDA WORK + 2 
3c59 : e5 03 __ SBC WORK + 0 
3c5b : aa __ __ TAX
3c5c : a5 06 __ LDA WORK + 3 
3c5e : e5 04 __ SBC WORK + 1 
3c60 : 90 04 __ BCC $3c66 ; (divmod + 123)
3c62 : 86 05 __ STX WORK + 2 
3c64 : 85 06 __ STA WORK + 3 
3c66 : 88 __ __ DEY
3c67 : d0 e5 __ BNE $3c4e ; (divmod + 99)
3c69 : 26 1b __ ROL ACCU + 0 
3c6b : 26 1c __ ROL ACCU + 1 
3c6d : a4 02 __ LDY $02 
3c6f : 60 __ __ RTS
--------------------------------------------------------------------
spentry:
3c70 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
rnd_a:
3c71 : __ __ __ BYT 3e                                              : >
--------------------------------------------------------------------
font:
3c72 : __ __ __ BYT c7 38 44 4c 4c 40 44 38 03 c5 38 04 3c 44 3c 02 : .8DLL@D8..8.<D<.
3c82 : __ __ __ BYT c6 40 40 78 44 44 78 83 10 c1 3c 43 40 83 10 c1 : .@@xDDx...<C@...
3c92 : __ __ __ BYT 04 83 17 84 18 c4 00 38 44 7c 84 10 c3 0c 10 3c : .......8D|.....<
3ca2 : __ __ __ BYT 43 10 84 20 83 17 c2 04 78 86 30 c8 44 00 00 10 : C.. ....x.0.D...
3cb2 : __ __ __ BYT 00 30 10 10 83 48 c2 08 00 44 08 c1 70 83 18 c3 : .0...H...D..p...
3cc2 : __ __ __ BYT 48 70 48 83 18 83 16 85 18 c4 00 68 54 54 84 28 : HpH........hTT.(
3cd2 : __ __ __ BYT c1 00 84 2f 84 08 c1 38 83 07 84 18 84 6f c2 40 : .../...8.....o.@
3ce2 : __ __ __ BYT 40 87 50 c1 04 84 10 83 79 85 80 c1 38 83 5f c3 : @.P.....y...8._.
3cf2 : __ __ __ BYT 00 10 7c 83 40 c1 0c 83 10 84 37 84 88 83 07 c1 : ..|.@.....7.....
3d02 : __ __ __ BYT 28 84 80 83 08 c2 54 28 84 08 c3 28 10 28 84 50 : (.....T(...(.(.P
3d12 : __ __ __ BYT 84 1f 83 78 c8 00 7c 08 10 20 7c 00 38 45 20 cb : ...x..|.. |.8E .
3d22 : __ __ __ BYT 38 00 0c 12 30 7c 30 62 fc 00 38 45 08 83 70 c3 : 8...0|0b..8E..p.
3d32 : __ __ __ BYT 18 3c 7e 44 18 c6 00 10 30 7f 7f 30 84 48 06 84 : .<~D....0..0.H..
3d42 : __ __ __ BYT a6 84 c5 86 9c 84 4e c3 fe 44 fe 83 0c c2 10 2c : ......N..D.....,
3d52 : __ __ __ BYT 83 87 ca 68 10 00 62 66 0c 18 30 66 46 83 b6 c5 : ...h..bf..0fF...
3d62 : __ __ __ BYT 28 30 46 44 3a 83 30 c1 20 85 28 83 6d c5 20 20 : (0FD:.0. .(.m.  
3d72 : __ __ __ BYT 10 08 00 83 04 c1 08 83 0c 84 8f c1 fe 85 8f c1 : ................
3d82 : __ __ __ BYT 10 84 b9 89 5d 84 2d c1 7c 0a 83 19 c2 02 04 83 : ....].-.|.......
3d92 : __ __ __ BYT 2f c1 40 83 50 c5 4c 54 64 44 38 83 8f c1 70 83 : /.@.P.LTdD8...p.
3da2 : __ __ __ BYT 82 83 b8 c5 44 04 08 30 40 85 08 c2 18 04 83 18 : ....D..0@.......
3db2 : __ __ __ BYT cc 08 18 28 48 7c 08 08 00 7c 40 78 04 84 10 c5 : ...(H|...|@x....
3dc2 : __ __ __ BYT 38 44 40 78 44 83 08 c3 7c 44 08 85 b3 c1 38 83 : 8D@xD...|D....8.
3dd2 : __ __ __ BYT 0d 84 10 83 05 c1 3c 84 20 85 5c 85 78 84 08 c3 : ......<. .\.x...
3de2 : __ __ __ BYT 10 20 0c 83 65 c3 20 10 0c 85 7f 84 81 c3 60 10 : . ..e. .......`.
3df2 : __ __ __ BYT 08 83 79 c1 60 85 68 c1 10 86 29 c2 ff ff 84 2e : ..y.`.h...).....
3e02 : __ __ __ BYT c3 28 44 7c 84 fc 83 5d 83 60 c1 78 84 68 c2 40 : .(D|...].`.x.h.@
3e12 : __ __ __ BYT 40 83 50 c2 70 48 83 16 c2 48 70 83 80 c3 40 78 : @.P.pH...Hp...@x
3e22 : __ __ __ BYT 40 83 98 86 08 84 b8 c2 40 4c 84 78 83 1e 85 38 : @.......@L.x...8
3e32 : __ __ __ BYT c1 38 45 10 c3 38 00 1c 44 08 cb 68 30 00 44 48 : .8E..8..D..h0.DH
3e42 : __ __ __ BYT 50 60 50 48 44 00 46 40 c5 7c 00 44 6c 54 44 44 : P`PHD.F@.|.DlTDD
3e52 : __ __ __ BYT c4 00 44 64 54 83 38 83 30 45 44 c1 38 85 70 86 : ..DdT.8.0ED.8.p.
3e62 : __ __ __ BYT 50 84 0f c1 0c 85 10 84 38 83 60 c1 38 84 d0 c1 : P.......8.`.8...
3e72 : __ __ __ BYT 7c 46 10 84 68 85 30 85 07 c1 28 86 10 c2 54 6c : |F..h.0...(...Tl
3e82 : __ __ __ BYT 83 50 83 0d c1 28 84 58 84 09 83 28 c1 7c 83 d7 : .P...(.X...(.|..
3e92 : __ __ __ BYT c1 20 83 70 c7 20 10 38 04 3c 44 3c 84 08 c6 44 : . .p. .8.<D<...D
3ea2 : __ __ __ BYT 7c 40 3c 00 08 87 08 c4 20 10 00 30 84 a8 84 18 : |@<..... ..0....
3eb2 : __ __ __ BYT 84 50 c2 20 10 84 4a c1 3c 03 c1 3c 83 87 c4 1c : .P. ..J.<..<....
3ec2 : __ __ __ BYT 30 50 28 83 82 83 50 c3 30 48 48 83 fb c2 58 40 : 0P(...P.0HH...X@
3ed2 : __ __ __ BYT 83 5d 85 e0 c2 20 7c 84 f8 83 58 87 08 88 f0 88 : .]... |...X.....
3ee2 : __ __ __ BYT c8 88 a0 48 10 48 28 05 c3 44 7c 00 00          : ...H.H(..D|..
--------------------------------------------------------------------
video_ram:
3eef : __ __ __ BYT 00 f4                                           : ..
--------------------------------------------------------------------
video_colorram:
3ef1 : __ __ __ BYT 00 d8                                           : ..
--------------------------------------------------------------------
advnm:
3ef3 : __ __ __ BYT 41 44 56 43 41 52 54 52 49 44 47 45 00          : ADVCARTRIDGE.
--------------------------------------------------------------------
giocharmap:
3f00 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
strcmd:
3f01 : __ __ __ BYT a7 02                                           : ..
--------------------------------------------------------------------
text_y:
3f03 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room:
3f04 : __ __ __ BYT fa                                              : .
--------------------------------------------------------------------
istack:
3f05 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
opcodeattr:
3f06 : __ __ __ BYT 82 83 81 81 83 01 01 01 01 81 82 82 82 02 03 02 : ................
3f16 : __ __ __ BYT 03 02 02 02 04 02 04 83 81 82 82 82 82 82 82 83 : ................
3f26 : __ __ __ BYT 03 83 81 81 82 83 84 83 83 83 83 83 82 81 82 83 : ................
3f36 : __ __ __ BYT 81 02                                           : ..
--------------------------------------------------------------------
align:
3f38 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
quit_request:
3f3a : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
disknm:
3f3b : __ __ __ BYT 40 30 3a 53 41 56 45 00                         : @0:SAVE.
--------------------------------------------------------------------
slowmode:
3f43 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3f44 : __ __ __ BYT 52 4f 4f 4d 30 31 2c 50 2c 52 00                : ROOM01,P,R.
--------------------------------------------------------------------
bitmap_image:
3f4f : __ __ __ BYT 00 e0                                           : ..
--------------------------------------------------------------------
nextroom:
3f51 : __ __ __ BYT fa                                              : .
--------------------------------------------------------------------
curimageid:
3f52 : __ __ __ BYT ff                                              : .
--------------------------------------------------------------------
ormask:
3f53 : __ __ __ BYT 01 02 04 08 10 20 40 80                         : ..... @.
--------------------------------------------------------------------
xormask:
3f5b : __ __ __ BYT fe fd fb f7 ef df bf 7f                         : ........
--------------------------------------------------------------------
icmd:
3f63 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
hb_len:
3f64 : __ __ __ BSS	1
--------------------------------------------------------------------
advcartridge:
3f65 : __ __ __ BSS	2
--------------------------------------------------------------------
tmp2:
3f67 : __ __ __ BSS	2
--------------------------------------------------------------------
freemem:
3f69 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_count:
3f6b : __ __ __ BSS	1
--------------------------------------------------------------------
obj_count:
3f6c : __ __ __ BSS	1
--------------------------------------------------------------------
shortdict:
3f6d : __ __ __ BSS	2
--------------------------------------------------------------------
advnames:
3f6f : __ __ __ BSS	2
--------------------------------------------------------------------
advdesc:
3f71 : __ __ __ BSS	2
--------------------------------------------------------------------
msgs:
3f73 : __ __ __ BSS	2
--------------------------------------------------------------------
msgs2:
3f75 : __ __ __ BSS	2
--------------------------------------------------------------------
verbs:
3f77 : __ __ __ BSS	2
--------------------------------------------------------------------
objs:
3f79 : __ __ __ BSS	2
--------------------------------------------------------------------
objs_dir:
3f7b : __ __ __ BSS	2
--------------------------------------------------------------------
rooms:
3f7d : __ __ __ BSS	2
--------------------------------------------------------------------
packdata:
3f7f : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_dir:
3f81 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_data:
3f83 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_pos:
3f85 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_len:
3f87 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_data:
3f89 : __ __ __ BSS	2
--------------------------------------------------------------------
roomnameid:
3f8b : __ __ __ BSS	2
--------------------------------------------------------------------
roomdescid:
3f8d : __ __ __ BSS	2
--------------------------------------------------------------------
roomimg:
3f8f : __ __ __ BSS	2
--------------------------------------------------------------------
roomovrimg:
3f91 : __ __ __ BSS	2
--------------------------------------------------------------------
objnameid:
3f93 : __ __ __ BSS	2
--------------------------------------------------------------------
objdescid:
3f95 : __ __ __ BSS	2
--------------------------------------------------------------------
objattr:
3f97 : __ __ __ BSS	2
--------------------------------------------------------------------
objloc:
3f99 : __ __ __ BSS	2
--------------------------------------------------------------------
objattrex:
3f9b : __ __ __ BSS	2
--------------------------------------------------------------------
roomstart:
3f9d : __ __ __ BSS	2
--------------------------------------------------------------------
roomattr:
3f9f : __ __ __ BSS	2
--------------------------------------------------------------------
roomattrex:
3fa1 : __ __ __ BSS	2
--------------------------------------------------------------------
bitvars:
3fa3 : __ __ __ BSS	2
--------------------------------------------------------------------
vars:
3fa5 : __ __ __ BSS	2
--------------------------------------------------------------------
imagesidx:
3fa7 : __ __ __ BSS	2
--------------------------------------------------------------------
imagesdata:
3fa9 : __ __ __ BSS	2
--------------------------------------------------------------------
origram_len:
3fab : __ __ __ BSS	2
--------------------------------------------------------------------
tmp:
3fad : __ __ __ BSS	2
--------------------------------------------------------------------
vrb:
3faf : __ __ __ BSS	2
--------------------------------------------------------------------
clearfull:
3fb1 : __ __ __ BSS	1
--------------------------------------------------------------------
al:
3fb2 : __ __ __ BSS	1
--------------------------------------------------------------------
newroom:
3fb3 : __ __ __ BSS	1
--------------------------------------------------------------------
cmd:
3fb4 : __ __ __ BSS	1
--------------------------------------------------------------------
obj1:
3fb5 : __ __ __ BSS	1
--------------------------------------------------------------------
executed:
3fb6 : __ __ __ BSS	1
--------------------------------------------------------------------
varroom:
3fb7 : __ __ __ BSS	1
--------------------------------------------------------------------
opcode:
3fb8 : __ __ __ BSS	1
--------------------------------------------------------------------
pcode:
3fb9 : __ __ __ BSS	2
--------------------------------------------------------------------
pcodelen:
3fbb : __ __ __ BSS	2
--------------------------------------------------------------------
in:
3fbd : __ __ __ BSS	1
--------------------------------------------------------------------
fail:
3fbe : __ __ __ BSS	1
--------------------------------------------------------------------
used:
3fbf : __ __ __ BSS	1
--------------------------------------------------------------------
thisobj:
3fc0 : __ __ __ BSS	1
--------------------------------------------------------------------
i:
3fc1 : __ __ __ BSS	2
--------------------------------------------------------------------
varobj:
3fc3 : __ __ __ BSS	1
--------------------------------------------------------------------
varmode:
3fc4 : __ __ __ BSS	1
--------------------------------------------------------------------
var:
3fc5 : __ __ __ BSS	1
--------------------------------------------------------------------
obj2:
3fc6 : __ __ __ BSS	1
--------------------------------------------------------------------
ch:
3fc7 : __ __ __ BSS	1
--------------------------------------------------------------------
strid:
3fc8 : __ __ __ BSS	1
--------------------------------------------------------------------
str:
3fc9 : __ __ __ BSS	2
--------------------------------------------------------------------
text_continue:
3fcb : __ __ __ BSS	1
--------------------------------------------------------------------
txt:
3fcc : __ __ __ BSS	2
--------------------------------------------------------------------
varattr:
3fce : __ __ __ BSS	1
--------------------------------------------------------------------
a:
3fcf : __ __ __ BSS	1
--------------------------------------------------------------------
_strid:
3fd0 : __ __ __ BSS	1
--------------------------------------------------------------------
ostr:
3fd1 : __ __ __ BSS	2
--------------------------------------------------------------------
len:
3fd3 : __ __ __ BSS	1
--------------------------------------------------------------------
etxt:
3fd4 : __ __ __ BSS	2
--------------------------------------------------------------------
txt_col:
3fd6 : __ __ __ BSS	1
--------------------------------------------------------------------
text_attach:
3fd7 : __ __ __ BSS	1
--------------------------------------------------------------------
txt_rev:
3fd8 : __ __ __ BSS	1
--------------------------------------------------------------------
txt_x:
3fd9 : __ __ __ BSS	1
--------------------------------------------------------------------
txt_y:
3fda : __ __ __ BSS	1
--------------------------------------------------------------------
_ch:
3fdb : __ __ __ BSS	1
--------------------------------------------------------------------
_ech:
3fdc : __ __ __ BSS	1
--------------------------------------------------------------------
_cplx:
3fdd : __ __ __ BSS	1
--------------------------------------------------------------------
_cplw:
3fde : __ __ __ BSS	1
--------------------------------------------------------------------
_cpl:
3fdf : __ __ __ BSS	2
--------------------------------------------------------------------
ll:
3fe1 : __ __ __ BSS	2
--------------------------------------------------------------------
spl:
3fe3 : __ __ __ BSS	2
--------------------------------------------------------------------
u:
3fe5 : __ __ __ BSS	1
--------------------------------------------------------------------
v:
3fe6 : __ __ __ BSS	1
--------------------------------------------------------------------
btxt:
3fe7 : __ __ __ BSS	2
--------------------------------------------------------------------
b_cpl:
3fe9 : __ __ __ BSS	2
--------------------------------------------------------------------
b_cplx:
3feb : __ __ __ BSS	1
--------------------------------------------------------------------
b_cplw:
3fec : __ __ __ BSS	1
--------------------------------------------------------------------
diskmemlow:
3fed : __ __ __ BSS	1
--------------------------------------------------------------------
diskmemhi:
3fee : __ __ __ BSS	1
--------------------------------------------------------------------
ediskmemlow:
3fef : __ __ __ BSS	1
--------------------------------------------------------------------
ediskmemhi:
3ff0 : __ __ __ BSS	1
--------------------------------------------------------------------
saved:
3ff1 : __ __ __ BSS	1
--------------------------------------------------------------------
key:
3ff2 : __ __ __ BSS	1
--------------------------------------------------------------------
imageid:
3ff3 : __ __ __ BSS	1
--------------------------------------------------------------------
fileptr:
3ff4 : __ __ __ BSS	2
--------------------------------------------------------------------
obj1k:
3ff6 : __ __ __ BSS	1
--------------------------------------------------------------------
obj2k:
3ff7 : __ __ __ BSS	1
--------------------------------------------------------------------
strdir:
3ff8 : __ __ __ BSS	2
--------------------------------------------------------------------
cmdid:
3ffa : __ __ __ BSS	1
--------------------------------------------------------------------
blink:
3ffb : __ __ __ BSS	1
--------------------------------------------------------------------
_buffer:
4000 : __ __ __ BSS	42
--------------------------------------------------------------------
_cbuffer:
402a : __ __ __ BSS	42
--------------------------------------------------------------------
krnio_pstatus:
4054 : __ __ __ BSS	16
