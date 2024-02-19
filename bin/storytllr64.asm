; Compiled with 1.26.232.0
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
080e : 8e ad 3c STX $3cad ; (spentry + 0)
0811 : a9 25 __ LDA #$25
0813 : 85 19 __ STA IP + 0 
0815 : a9 3d __ LDA #$3d
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 3e __ LDA #$3e
081c : e9 3d __ SBC #$3d
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
0830 : a9 21 __ LDA #$21
0832 : e9 25 __ SBC #$25
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
08b5 : ad af 3c LDA $3caf ; (video_ram + 0)
08b8 : 18 __ __ CLC
08b9 : 69 e0 __ ADC #$e0
08bb : 85 0d __ STA P0 
08bd : ad b0 3c LDA $3cb0 ; (video_ram + 1)
08c0 : 69 01 __ ADC #$01
08c2 : 85 0e __ STA P1 
08c4 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
08c7 : a9 00 __ LDA #$00
08c9 : 85 0f __ STA P2 
08cb : 85 10 __ STA P3 
08cd : 85 12 __ STA P5 
08cf : a9 50 __ LDA #$50
08d1 : 85 11 __ STA P4 
08d3 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
08d6 : 18 __ __ CLC
08d7 : 69 e0 __ ADC #$e0
08d9 : 85 0d __ STA P0 
08db : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
08de : 69 01 __ ADC #$01
08e0 : 85 0e __ STA P1 
08e2 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
.l124:
08e5 : 2c 11 d0 BIT $d011 
08e8 : 10 fb __ BPL $08e5 ; (main.l124 + 0)
.s6:
08ea : 20 7b 11 JSR $117b ; (IRQ_gfx_init.s0 + 0)
08ed : ad c1 3c LDA $3cc1 ; (strcmd + 0)
08f0 : 85 43 __ STA T0 + 0 
08f2 : ad c2 3c LDA $3cc2 ; (strcmd + 1)
08f5 : 85 44 __ STA T0 + 1 
08f7 : a9 00 __ LDA #$00
08f9 : 8d 20 d0 STA $d020 
08fc : a8 __ __ TAY
08fd : 91 43 __ STA (T0 + 0),y 
08ff : 20 11 12 JSR $1211 ; (clean.s0 + 0)
0902 : 20 33 12 JSR $1233 ; (adv_start.s0 + 0)
.l11:
0905 : 20 88 34 JSR $3488 ; (parser_update.s1000 + 0)
0908 : a9 00 __ LDA #$00
090a : 8d 88 3d STA $3d88 ; (ch + 0)
090d : 8d fb 3c STA $3cfb ; (quit_request + 0)
.l14:
0910 : 20 9f ff JSR $ff9f 
0913 : 20 e4 ff JSR $ffe4 
0916 : 8d 88 3d STA $3d88 ; (ch + 0)
0919 : ad 88 3d LDA $3d88 ; (ch + 0)
091c : d0 06 __ BNE $0924 ; (main.s16 + 0)
.s17:
091e : 20 1b 3b JSR $3b1b ; (do_blink.s0 + 0)
0921 : 4c 79 09 JMP $0979 ; (main.l127 + 0)
.s16:
0924 : 85 53 __ STA T1 + 0 
0926 : 20 60 35 JSR $3560 ; (hide_blink.s0 + 0)
0929 : a5 53 __ LDA T1 + 0 
092b : c9 0d __ CMP #$0d
092d : d0 06 __ BNE $0935 ; (main.s20 + 0)
.s19:
092f : 20 9c 35 JSR $359c ; (execute.s1000 + 0)
0932 : 4c 79 09 JMP $0979 ; (main.l127 + 0)
.s20:
0935 : c9 91 __ CMP #$91
0937 : f0 40 __ BEQ $0979 ; (main.l127 + 0)
.s23:
0939 : c9 14 __ CMP #$14
093b : d0 03 __ BNE $0940 ; (main.s26 + 0)
093d : 4c c9 09 JMP $09c9 ; (main.s25 + 0)
.s26:
0940 : ad 24 3d LDA $3d24 ; (icmd + 0)
0943 : c9 50 __ CMP #$50
0945 : b0 2f __ BCS $0976 ; (main.s136 + 0)
.s31:
0947 : 85 54 __ STA T2 + 0 
0949 : a5 53 __ LDA T1 + 0 
094b : 20 ee 3a JSR $3aee ; (charmap.s0 + 0)
094e : 8d 88 3d STA $3d88 ; (ch + 0)
0951 : 09 00 __ ORA #$00
0953 : f0 21 __ BEQ $0976 ; (main.s136 + 0)
.s34:
0955 : 18 __ __ CLC
0956 : a5 54 __ LDA T2 + 0 
0958 : 69 01 __ ADC #$01
095a : 85 43 __ STA T0 + 0 
095c : 8d 24 3d STA $3d24 ; (icmd + 0)
095f : ad c1 3c LDA $3cc1 ; (strcmd + 0)
0962 : 85 45 __ STA T3 + 0 
0964 : ad c2 3c LDA $3cc2 ; (strcmd + 1)
0967 : 85 46 __ STA T3 + 1 
0969 : ad 88 3d LDA $3d88 ; (ch + 0)
096c : a4 54 __ LDY T2 + 0 
096e : 91 45 __ STA (T3 + 0),y 
.s137:
0970 : a9 00 __ LDA #$00
0972 : a4 43 __ LDY T0 + 0 
0974 : 91 45 __ STA (T3 + 0),y 
.s136:
0976 : 20 88 34 JSR $3488 ; (parser_update.s1000 + 0)
.l127:
0979 : 2c 11 d0 BIT $d011 
097c : 10 fb __ BPL $0979 ; (main.l127 + 0)
.s13:
097e : ad fb 3c LDA $3cfb ; (quit_request + 0)
0981 : f0 8d __ BEQ $0910 ; (main.l14 + 0)
.s15:
0983 : c9 02 __ CMP #$02
0985 : b0 06 __ BCS $098d ; (main.s41 + 0)
.s12:
0987 : 20 24 3c JSR $3c24 ; (os_reset.s0 + 0)
098a : 4c b8 09 JMP $09b8 ; (main.s1001 + 0)
.s41:
098d : d0 06 __ BNE $0995 ; (main.s45 + 0)
.s44:
098f : 20 84 3b JSR $3b84 ; (adv_reset.s0 + 0)
0992 : 4c 9c 09 JMP $099c ; (main.s51 + 0)
.s45:
0995 : 20 a3 3b JSR $3ba3 ; (adv_load.s0 + 0)
0998 : a5 1b __ LDA ACCU + 0 
099a : f0 14 __ BEQ $09b0 ; (main.s135 + 0)
.s51:
099c : ad 5e 3d LDA $3d5e ; (roomstart + 0)
099f : 85 43 __ STA T0 + 0 
09a1 : ad 5f 3d LDA $3d5f ; (roomstart + 1)
09a4 : 85 44 __ STA T0 + 1 
09a6 : a0 00 __ LDY #$00
09a8 : b1 43 __ LDA (T0 + 0),y 
09aa : 8d 74 3d STA $3d74 ; (newroom + 0)
09ad : 20 d3 12 JSR $12d3 ; (room_load.s1000 + 0)
.s135:
09b0 : a9 00 __ LDA #$00
09b2 : 8d fb 3c STA $3cfb ; (quit_request + 0)
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
09c9 : ad 24 3d LDA $3d24 ; (icmd + 0)
09cc : f0 a8 __ BEQ $0976 ; (main.s136 + 0)
.s28:
09ce : 38 __ __ SEC
09cf : e9 01 __ SBC #$01
09d1 : 8d 24 3d STA $3d24 ; (icmd + 0)
09d4 : 85 43 __ STA T0 + 0 
09d6 : ad c1 3c LDA $3cc1 ; (strcmd + 0)
09d9 : 85 45 __ STA T3 + 0 
09db : ad c2 3c LDA $3cc2 ; (strcmd + 1)
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
0a28 : ad af 3c LDA $3caf ; (video_ram + 0)
0a2b : 85 0d __ STA P0 
0a2d : ad b0 3c LDA $3cb0 ; (video_ram + 1)
0a30 : 85 0e __ STA P1 
0a32 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
0a35 : a9 00 __ LDA #$00
0a37 : 85 0f __ STA P2 
0a39 : 85 10 __ STA P3 
0a3b : a9 e8 __ LDA #$e8
0a3d : 85 11 __ STA P4 
0a3f : a9 03 __ LDA #$03
0a41 : 85 12 __ STA P5 
0a43 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
0a46 : 85 0d __ STA P0 
0a48 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
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
0a5e : 8d ae 3c STA $3cae ; (rnd_a + 0)
.s1001:
0a61 : 60 __ __ RTS
--------------------------------------------------------------------
font_load: ; font_load()->void
.s0:
0a62 : a9 00 __ LDA #$00
0a64 : 85 0d __ STA P0 
0a66 : a9 40 __ LDA #$40
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
0ae6 : 8d 25 3d STA $3d25 ; (hb_len + 0)
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
0afe : ad 25 3d LDA $3d25 ; (hb_len + 0)
0b01 : c9 3f __ CMP #$3f
0b03 : d0 13 __ BNE $0b18 ; (hunpack.s6 + 0)
.s4:
0b05 : c8 __ __ INY
0b06 : b1 47 __ LDA (T5 + 0),y 
0b08 : 8d 25 3d STA $3d25 ; (hb_len + 0)
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
0b2f : ad 25 3d LDA $3d25 ; (hb_len + 0)
0b32 : ce 25 3d DEC $3d25 ; (hb_len + 0)
0b35 : 09 00 __ ORA #$00
0b37 : f0 24 __ BEQ $0b5d ; (hunpack.s1 + 0)
.s35:
0b39 : a5 0f __ LDA P2 ; (pbuf + 0)
0b3b : 85 47 __ STA T5 + 0 
0b3d : a4 1b __ LDY ACCU + 0 
0b3f : ae 25 3d LDX $3d25 ; (hb_len + 0)
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
0b5a : 8e 25 3d STX $3d25 ; (hb_len + 0)
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
0b83 : ae 25 3d LDX $3d25 ; (hb_len + 0)
0b86 : ce 25 3d DEC $3d25 ; (hb_len + 0)
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
0b98 : ae 25 3d LDX $3d25 ; (hb_len + 0)
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
0bc6 : ae 25 3d LDX $3d25 ; (hb_len + 0)
0bc9 : ce 25 3d DEC $3d25 ; (hb_len + 0)
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
0bed : ae 25 3d LDX $3d25 ; (hb_len + 0)
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
0c19 : ad 25 3d LDA $3d25 ; (hb_len + 0)
0c1c : ce 25 3d DEC $3d25 ; (hb_len + 0)
0c1f : 09 00 __ ORA #$00
0c21 : d0 03 __ BNE $0c26 ; (hunpack.s32 + 0)
0c23 : 4c 5d 0b JMP $0b5d ; (hunpack.s1 + 0)
.s32:
0c26 : a5 0f __ LDA P2 ; (pbuf + 0)
0c28 : 85 47 __ STA T5 + 0 
0c2a : a5 0d __ LDA P0 ; (buf + 0)
0c2c : 85 49 __ STA T6 + 0 
0c2e : ae 25 3d LDX $3d25 ; (hb_len + 0)
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
0cec : ad af 3c LDA $3caf ; (video_ram + 0)
0cef : 18 __ __ CLC
0cf0 : 69 e0 __ ADC #$e0
0cf2 : aa __ __ TAX
0cf3 : ad b0 3c LDA $3cb0 ; (video_ram + 1)
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
0d04 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
0d07 : 18 __ __ CLC
0d08 : 69 e0 __ ADC #$e0
0d0a : aa __ __ TAX
0d0b : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
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
0d5d : a9 00 __ LDA #$00
0d5f : 8d 26 3d STA $3d26 ; (advcartridge + 0)
0d62 : a9 40 __ LDA #$40
0d64 : 8d 27 3d STA $3d27 ; (advcartridge + 1)
0d67 : 20 d6 0d JSR $0dd6 ; (irq_border_on.s0 + 0)
0d6a : a9 01 __ LDA #$01
0d6c : a6 ba __ LDX $ba 
0d6e : d0 02 __ BNE $0d72 ; (loadcartridge.s0 + 21)
0d70 : a2 08 __ LDX #$08
0d72 : a0 00 __ LDY #$00
0d74 : 20 ba ff JSR $ffba 
0d77 : a9 0c __ LDA #$0c
0d79 : a2 b3 __ LDX #$b3
0d7b : a0 3c __ LDY #$3c
0d7d : 20 bd ff JSR $ffbd 
0d80 : a9 00 __ LDA #$00
0d82 : a2 00 __ LDX #$00
0d84 : a0 40 __ LDY #$40
0d86 : 20 d5 ff JSR $ffd5 
0d89 : b0 03 __ BCS $0d8e ; (loadcartridge.s0 + 49)
0d8b : 4c 96 0d JMP $0d96 ; (loadcartridge.s0 + 57)
0d8e : 20 ec 0d JSR $0dec ; (irq_border_off.s0 + 0)
0d91 : a9 00 __ LDA #$00
0d93 : 85 1b __ STA ACCU + 0 
0d95 : 60 __ __ RTS
0d96 : 20 ec 0d JSR $0dec ; (irq_border_off.s0 + 0)
0d99 : ad 26 3d LDA $3d26 ; (advcartridge + 0)
0d9c : 85 43 __ STA T0 + 0 
0d9e : 18 __ __ CLC
0d9f : 69 02 __ ADC #$02
0da1 : 8d 26 3d STA $3d26 ; (advcartridge + 0)
0da4 : ad 27 3d LDA $3d27 ; (advcartridge + 1)
0da7 : 85 44 __ STA T0 + 1 
0da9 : 69 00 __ ADC #$00
0dab : 8d 27 3d STA $3d27 ; (advcartridge + 1)
0dae : a0 01 __ LDY #$01
0db0 : b1 43 __ LDA (T0 + 0),y 
0db2 : 85 14 __ STA P7 
0db4 : 18 __ __ CLC
0db5 : 88 __ __ DEY
0db6 : b1 43 __ LDA (T0 + 0),y 
0db8 : 85 13 __ STA P6 
0dba : 6d 26 3d ADC $3d26 ; (advcartridge + 0)
0dbd : 8d 28 3d STA $3d28 ; (tmp2 + 0)
0dc0 : ad 27 3d LDA $3d27 ; (advcartridge + 1)
0dc3 : 65 14 __ ADC P7 
0dc5 : 8d 29 3d STA $3d29 ; (tmp2 + 1)
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
0df9 : ad 26 3d LDA $3d26 ; (advcartridge + 0)
0dfc : aa __ __ TAX
0dfd : 18 __ __ CLC
0dfe : 65 13 __ ADC P6 ; (iln + 0)
0e00 : 85 43 __ STA T1 + 0 
0e02 : ad 27 3d LDA $3d27 ; (advcartridge + 1)
0e05 : 85 1c __ STA ACCU + 1 
0e07 : 65 14 __ ADC P7 ; (iln + 1)
0e09 : 85 44 __ STA T1 + 1 
0e0b : 38 __ __ SEC
0e0c : a9 80 __ LDA #$80
0e0e : e5 43 __ SBC T1 + 0 
0e10 : 8d 2a 3d STA $3d2a ; (freemem + 0)
0e13 : a9 cb __ LDA #$cb
0e15 : e5 44 __ SBC T1 + 1 
0e17 : 8d 2b 3d STA $3d2b ; (freemem + 1)
0e1a : ad 28 3d LDA $3d28 ; (tmp2 + 0)
0e1d : 85 43 __ STA T1 + 0 
0e1f : ad 29 3d LDA $3d29 ; (tmp2 + 1)
0e22 : 85 44 __ STA T1 + 1 
0e24 : a0 02 __ LDY #$02
0e26 : b1 43 __ LDA (T1 + 0),y 
0e28 : 8d 2c 3d STA $3d2c ; (opcode_vrbidx_count + 0)
0e2b : a0 04 __ LDY #$04
0e2d : b1 43 __ LDA (T1 + 0),y 
0e2f : 8d 2d 3d STA $3d2d ; (obj_count + 0)
0e32 : 8a __ __ TXA
0e33 : 18 __ __ CLC
0e34 : a0 0a __ LDY #$0a
0e36 : 71 43 __ ADC (T1 + 0),y 
0e38 : 8d 2e 3d STA $3d2e ; (shortdict + 0)
0e3b : a5 1c __ LDA ACCU + 1 
0e3d : c8 __ __ INY
0e3e : 71 43 __ ADC (T1 + 0),y 
0e40 : 8d 2f 3d STA $3d2f ; (shortdict + 1)
0e43 : 8a __ __ TXA
0e44 : 18 __ __ CLC
0e45 : c8 __ __ INY
0e46 : 71 43 __ ADC (T1 + 0),y 
0e48 : 8d 30 3d STA $3d30 ; (advnames + 0)
0e4b : a5 1c __ LDA ACCU + 1 
0e4d : c8 __ __ INY
0e4e : 71 43 __ ADC (T1 + 0),y 
0e50 : 8d 31 3d STA $3d31 ; (advnames + 1)
0e53 : 8a __ __ TXA
0e54 : 18 __ __ CLC
0e55 : c8 __ __ INY
0e56 : 71 43 __ ADC (T1 + 0),y 
0e58 : 8d 32 3d STA $3d32 ; (advdesc + 0)
0e5b : a5 1c __ LDA ACCU + 1 
0e5d : c8 __ __ INY
0e5e : 71 43 __ ADC (T1 + 0),y 
0e60 : 8d 33 3d STA $3d33 ; (advdesc + 1)
0e63 : 8a __ __ TXA
0e64 : 18 __ __ CLC
0e65 : c8 __ __ INY
0e66 : 71 43 __ ADC (T1 + 0),y 
0e68 : 8d 34 3d STA $3d34 ; (msgs + 0)
0e6b : a5 1c __ LDA ACCU + 1 
0e6d : c8 __ __ INY
0e6e : 71 43 __ ADC (T1 + 0),y 
0e70 : 8d 35 3d STA $3d35 ; (msgs + 1)
0e73 : 8a __ __ TXA
0e74 : 18 __ __ CLC
0e75 : c8 __ __ INY
0e76 : 71 43 __ ADC (T1 + 0),y 
0e78 : 8d 36 3d STA $3d36 ; (msgs2 + 0)
0e7b : a5 1c __ LDA ACCU + 1 
0e7d : c8 __ __ INY
0e7e : 71 43 __ ADC (T1 + 0),y 
0e80 : 8d 37 3d STA $3d37 ; (msgs2 + 1)
0e83 : 8a __ __ TXA
0e84 : 18 __ __ CLC
0e85 : c8 __ __ INY
0e86 : 71 43 __ ADC (T1 + 0),y 
0e88 : 8d 38 3d STA $3d38 ; (verbs + 0)
0e8b : a5 1c __ LDA ACCU + 1 
0e8d : c8 __ __ INY
0e8e : 71 43 __ ADC (T1 + 0),y 
0e90 : 8d 39 3d STA $3d39 ; (verbs + 1)
0e93 : 8a __ __ TXA
0e94 : 18 __ __ CLC
0e95 : c8 __ __ INY
0e96 : 71 43 __ ADC (T1 + 0),y 
0e98 : 8d 3a 3d STA $3d3a ; (objs + 0)
0e9b : a5 1c __ LDA ACCU + 1 
0e9d : c8 __ __ INY
0e9e : 71 43 __ ADC (T1 + 0),y 
0ea0 : 8d 3b 3d STA $3d3b ; (objs + 1)
0ea3 : 8a __ __ TXA
0ea4 : 18 __ __ CLC
0ea5 : c8 __ __ INY
0ea6 : 71 43 __ ADC (T1 + 0),y 
0ea8 : 8d 3c 3d STA $3d3c ; (objs_dir + 0)
0eab : a5 1c __ LDA ACCU + 1 
0ead : c8 __ __ INY
0eae : 71 43 __ ADC (T1 + 0),y 
0eb0 : 8d 3d 3d STA $3d3d ; (objs_dir + 1)
0eb3 : 8a __ __ TXA
0eb4 : 18 __ __ CLC
0eb5 : c8 __ __ INY
0eb6 : 71 43 __ ADC (T1 + 0),y 
0eb8 : 8d 3e 3d STA $3d3e ; (rooms + 0)
0ebb : a5 1c __ LDA ACCU + 1 
0ebd : c8 __ __ INY
0ebe : 71 43 __ ADC (T1 + 0),y 
0ec0 : 8d 3f 3d STA $3d3f ; (rooms + 1)
0ec3 : 8a __ __ TXA
0ec4 : 18 __ __ CLC
0ec5 : c8 __ __ INY
0ec6 : 71 43 __ ADC (T1 + 0),y 
0ec8 : 8d 40 3d STA $3d40 ; (packdata + 0)
0ecb : a5 1c __ LDA ACCU + 1 
0ecd : c8 __ __ INY
0ece : 71 43 __ ADC (T1 + 0),y 
0ed0 : 8d 41 3d STA $3d41 ; (packdata + 1)
0ed3 : 8a __ __ TXA
0ed4 : 18 __ __ CLC
0ed5 : c8 __ __ INY
0ed6 : 71 43 __ ADC (T1 + 0),y 
0ed8 : 8d 42 3d STA $3d42 ; (opcode_vrbidx_dir + 0)
0edb : a5 1c __ LDA ACCU + 1 
0edd : c8 __ __ INY
0ede : 71 43 __ ADC (T1 + 0),y 
0ee0 : 8d 43 3d STA $3d43 ; (opcode_vrbidx_dir + 1)
0ee3 : 8a __ __ TXA
0ee4 : 18 __ __ CLC
0ee5 : c8 __ __ INY
0ee6 : 71 43 __ ADC (T1 + 0),y 
0ee8 : 8d 44 3d STA $3d44 ; (opcode_vrbidx_data + 0)
0eeb : a5 1c __ LDA ACCU + 1 
0eed : c8 __ __ INY
0eee : 71 43 __ ADC (T1 + 0),y 
0ef0 : 8d 45 3d STA $3d45 ; (opcode_vrbidx_data + 1)
0ef3 : 8a __ __ TXA
0ef4 : 18 __ __ CLC
0ef5 : c8 __ __ INY
0ef6 : 71 43 __ ADC (T1 + 0),y 
0ef8 : 8d 46 3d STA $3d46 ; (opcode_pos + 0)
0efb : a5 1c __ LDA ACCU + 1 
0efd : c8 __ __ INY
0efe : 71 43 __ ADC (T1 + 0),y 
0f00 : 8d 47 3d STA $3d47 ; (opcode_pos + 1)
0f03 : 8a __ __ TXA
0f04 : 18 __ __ CLC
0f05 : c8 __ __ INY
0f06 : 71 43 __ ADC (T1 + 0),y 
0f08 : 8d 48 3d STA $3d48 ; (opcode_len + 0)
0f0b : a5 1c __ LDA ACCU + 1 
0f0d : c8 __ __ INY
0f0e : 71 43 __ ADC (T1 + 0),y 
0f10 : 8d 49 3d STA $3d49 ; (opcode_len + 1)
0f13 : 8a __ __ TXA
0f14 : 18 __ __ CLC
0f15 : c8 __ __ INY
0f16 : 71 43 __ ADC (T1 + 0),y 
0f18 : 8d 4a 3d STA $3d4a ; (opcode_data + 0)
0f1b : a5 1c __ LDA ACCU + 1 
0f1d : c8 __ __ INY
0f1e : 71 43 __ ADC (T1 + 0),y 
0f20 : 8d 4b 3d STA $3d4b ; (opcode_data + 1)
0f23 : 8a __ __ TXA
0f24 : 18 __ __ CLC
0f25 : c8 __ __ INY
0f26 : 71 43 __ ADC (T1 + 0),y 
0f28 : 8d 4c 3d STA $3d4c ; (roomnameid + 0)
0f2b : a5 1c __ LDA ACCU + 1 
0f2d : c8 __ __ INY
0f2e : 71 43 __ ADC (T1 + 0),y 
0f30 : 8d 4d 3d STA $3d4d ; (roomnameid + 1)
0f33 : 8a __ __ TXA
0f34 : 18 __ __ CLC
0f35 : c8 __ __ INY
0f36 : 71 43 __ ADC (T1 + 0),y 
0f38 : 8d 4e 3d STA $3d4e ; (roomdescid + 0)
0f3b : a5 1c __ LDA ACCU + 1 
0f3d : c8 __ __ INY
0f3e : 71 43 __ ADC (T1 + 0),y 
0f40 : 8d 4f 3d STA $3d4f ; (roomdescid + 1)
0f43 : 8a __ __ TXA
0f44 : 18 __ __ CLC
0f45 : c8 __ __ INY
0f46 : 71 43 __ ADC (T1 + 0),y 
0f48 : 8d 50 3d STA $3d50 ; (roomimg + 0)
0f4b : a5 1c __ LDA ACCU + 1 
0f4d : c8 __ __ INY
0f4e : 71 43 __ ADC (T1 + 0),y 
0f50 : 8d 51 3d STA $3d51 ; (roomimg + 1)
0f53 : 8a __ __ TXA
0f54 : 18 __ __ CLC
0f55 : c8 __ __ INY
0f56 : 71 43 __ ADC (T1 + 0),y 
0f58 : 85 45 __ STA T2 + 0 
0f5a : a5 1c __ LDA ACCU + 1 
0f5c : c8 __ __ INY
0f5d : 71 43 __ ADC (T1 + 0),y 
0f5f : 85 46 __ STA T2 + 1 
0f61 : 8d 53 3d STA $3d53 ; (roomovrimg + 1)
0f64 : a5 45 __ LDA T2 + 0 
0f66 : 8d 52 3d STA $3d52 ; (roomovrimg + 0)
0f69 : 8a __ __ TXA
0f6a : 18 __ __ CLC
0f6b : c8 __ __ INY
0f6c : 71 43 __ ADC (T1 + 0),y 
0f6e : 8d 54 3d STA $3d54 ; (objnameid + 0)
0f71 : a5 1c __ LDA ACCU + 1 
0f73 : c8 __ __ INY
0f74 : 71 43 __ ADC (T1 + 0),y 
0f76 : 8d 55 3d STA $3d55 ; (objnameid + 1)
0f79 : 8a __ __ TXA
0f7a : 18 __ __ CLC
0f7b : c8 __ __ INY
0f7c : 71 43 __ ADC (T1 + 0),y 
0f7e : 8d 56 3d STA $3d56 ; (objdescid + 0)
0f81 : a5 1c __ LDA ACCU + 1 
0f83 : c8 __ __ INY
0f84 : 71 43 __ ADC (T1 + 0),y 
0f86 : 8d 57 3d STA $3d57 ; (objdescid + 1)
0f89 : 8a __ __ TXA
0f8a : 18 __ __ CLC
0f8b : a0 36 __ LDY #$36
0f8d : 71 43 __ ADC (T1 + 0),y 
0f8f : 85 0f __ STA P2 
0f91 : a5 1c __ LDA ACCU + 1 
0f93 : c8 __ __ INY
0f94 : 71 43 __ ADC (T1 + 0),y 
0f96 : 85 10 __ STA P3 
0f98 : 8d 59 3d STA $3d59 ; (objattr + 1)
0f9b : a5 0f __ LDA P2 
0f9d : 8d 58 3d STA $3d58 ; (objattr + 0)
0fa0 : 8a __ __ TXA
0fa1 : 18 __ __ CLC
0fa2 : c8 __ __ INY
0fa3 : 71 43 __ ADC (T1 + 0),y 
0fa5 : 8d 5a 3d STA $3d5a ; (objloc + 0)
0fa8 : a5 1c __ LDA ACCU + 1 
0faa : c8 __ __ INY
0fab : 71 43 __ ADC (T1 + 0),y 
0fad : 8d 5b 3d STA $3d5b ; (objloc + 1)
0fb0 : 8a __ __ TXA
0fb1 : 18 __ __ CLC
0fb2 : c8 __ __ INY
0fb3 : 71 43 __ ADC (T1 + 0),y 
0fb5 : 85 47 __ STA T5 + 0 
0fb7 : a5 1c __ LDA ACCU + 1 
0fb9 : c8 __ __ INY
0fba : 71 43 __ ADC (T1 + 0),y 
0fbc : 85 48 __ STA T5 + 1 
0fbe : 8d 5d 3d STA $3d5d ; (objattrex + 1)
0fc1 : a5 47 __ LDA T5 + 0 
0fc3 : 8d 5c 3d STA $3d5c ; (objattrex + 0)
0fc6 : 8a __ __ TXA
0fc7 : 18 __ __ CLC
0fc8 : c8 __ __ INY
0fc9 : 71 43 __ ADC (T1 + 0),y 
0fcb : 8d 5e 3d STA $3d5e ; (roomstart + 0)
0fce : a5 1c __ LDA ACCU + 1 
0fd0 : c8 __ __ INY
0fd1 : 71 43 __ ADC (T1 + 0),y 
0fd3 : 8d 5f 3d STA $3d5f ; (roomstart + 1)
0fd6 : 8a __ __ TXA
0fd7 : 18 __ __ CLC
0fd8 : c8 __ __ INY
0fd9 : 71 43 __ ADC (T1 + 0),y 
0fdb : 85 49 __ STA T6 + 0 
0fdd : a5 1c __ LDA ACCU + 1 
0fdf : c8 __ __ INY
0fe0 : 71 43 __ ADC (T1 + 0),y 
0fe2 : 85 4a __ STA T6 + 1 
0fe4 : 8d 61 3d STA $3d61 ; (roomattr + 1)
0fe7 : a5 49 __ LDA T6 + 0 
0fe9 : 8d 60 3d STA $3d60 ; (roomattr + 0)
0fec : 8a __ __ TXA
0fed : 18 __ __ CLC
0fee : c8 __ __ INY
0fef : 71 43 __ ADC (T1 + 0),y 
0ff1 : 85 4b __ STA T7 + 0 
0ff3 : a5 1c __ LDA ACCU + 1 
0ff5 : c8 __ __ INY
0ff6 : 71 43 __ ADC (T1 + 0),y 
0ff8 : 85 4c __ STA T7 + 1 
0ffa : 8d 63 3d STA $3d63 ; (roomattrex + 1)
0ffd : a5 4b __ LDA T7 + 0 
0fff : 8d 62 3d STA $3d62 ; (roomattrex + 0)
1002 : 8a __ __ TXA
1003 : 18 __ __ CLC
1004 : c8 __ __ INY
1005 : 71 43 __ ADC (T1 + 0),y 
1007 : 85 4d __ STA T8 + 0 
1009 : a5 1c __ LDA ACCU + 1 
100b : c8 __ __ INY
100c : 71 43 __ ADC (T1 + 0),y 
100e : 85 4e __ STA T8 + 1 
1010 : 8d 65 3d STA $3d65 ; (bitvars + 1)
1013 : a5 4d __ LDA T8 + 0 
1015 : 8d 64 3d STA $3d64 ; (bitvars + 0)
1018 : 8a __ __ TXA
1019 : 18 __ __ CLC
101a : c8 __ __ INY
101b : 71 43 __ ADC (T1 + 0),y 
101d : 8d 66 3d STA $3d66 ; (vars + 0)
1020 : a5 1c __ LDA ACCU + 1 
1022 : c8 __ __ INY
1023 : 71 43 __ ADC (T1 + 0),y 
1025 : 8d 67 3d STA $3d67 ; (vars + 1)
1028 : 8a __ __ TXA
1029 : 18 __ __ CLC
102a : c8 __ __ INY
102b : 71 43 __ ADC (T1 + 0),y 
102d : 85 1b __ STA ACCU + 0 
102f : a5 1c __ LDA ACCU + 1 
1031 : c8 __ __ INY
1032 : 71 43 __ ADC (T1 + 0),y 
1034 : 8d 69 3d STA $3d69 ; (imagesidx + 1)
1037 : a5 1b __ LDA ACCU + 0 
1039 : 8d 68 3d STA $3d68 ; (imagesidx + 0)
103c : 8a __ __ TXA
103d : 18 __ __ CLC
103e : c8 __ __ INY
103f : 71 43 __ ADC (T1 + 0),y 
1041 : 8d 6a 3d STA $3d6a ; (imagesdata + 0)
1044 : aa __ __ TAX
1045 : a5 1c __ LDA ACCU + 1 
1047 : c8 __ __ INY
1048 : 71 43 __ ADC (T1 + 0),y 
104a : 8d 6b 3d STA $3d6b ; (imagesdata + 1)
104d : 18 __ __ CLC
104e : a5 43 __ LDA T1 + 0 
1050 : 69 4c __ ADC #$4c
1052 : 8d 28 3d STA $3d28 ; (tmp2 + 0)
1055 : a5 44 __ LDA T1 + 1 
1057 : 69 00 __ ADC #$00
1059 : 8d 29 3d STA $3d29 ; (tmp2 + 1)
105c : c8 __ __ INY
105d : b1 43 __ LDA (T1 + 0),y 
105f : 85 11 __ STA P4 
1061 : c8 __ __ INY
1062 : b1 43 __ LDA (T1 + 0),y 
1064 : 85 12 __ STA P5 
1066 : 8d 6d 3d STA $3d6d ; (origram_len + 1)
1069 : a5 11 __ LDA P4 
106b : 8d 6c 3d STA $3d6c ; (origram_len + 0)
106e : a9 00 __ LDA #$00
1070 : 85 0d __ STA P0 
1072 : a9 05 __ LDA #$05
1074 : 85 0e __ STA P1 
1076 : ad 6b 3d LDA $3d6b ; (imagesdata + 1)
1079 : cd 69 3d CMP $3d69 ; (imagesidx + 1)
107c : d0 12 __ BNE $1090 ; (setupcartridge.s3 + 0)
.s1010:
107e : e4 1b __ CPX ACCU + 0 
1080 : d0 0e __ BNE $1090 ; (setupcartridge.s3 + 0)
.s1:
1082 : a9 00 __ LDA #$00
1084 : 8d 68 3d STA $3d68 ; (imagesidx + 0)
1087 : 8d 69 3d STA $3d69 ; (imagesidx + 1)
108a : 8d 6a 3d STA $3d6a ; (imagesdata + 0)
108d : 8d 6b 3d STA $3d6b ; (imagesdata + 1)
.s3:
1090 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
1093 : a9 00 __ LDA #$00
1095 : 8d 6e 3d STA $3d6e ; (tmp + 0)
1098 : a9 04 __ LDA #$04
109a : 8d 6f 3d STA $3d6f ; (tmp + 1)
109d : 8d 71 3d STA $3d71 ; (vrb + 1)
10a0 : 8d 29 3d STA $3d29 ; (tmp2 + 1)
10a3 : a9 28 __ LDA #$28
10a5 : 8d 70 3d STA $3d70 ; (vrb + 0)
10a8 : a9 32 __ LDA #$32
10aa : 8d 28 3d STA $3d28 ; (tmp2 + 0)
10ad : a5 46 __ LDA T2 + 1 
10af : c5 4a __ CMP T6 + 1 
10b1 : d0 0e __ BNE $10c1 ; (setupcartridge.s9 + 0)
.s1008:
10b3 : a5 45 __ LDA T2 + 0 
10b5 : c5 49 __ CMP T6 + 0 
10b7 : d0 08 __ BNE $10c1 ; (setupcartridge.s9 + 0)
.s4:
10b9 : a9 00 __ LDA #$00
10bb : 8d 52 3d STA $3d52 ; (roomovrimg + 0)
10be : 8d 53 3d STA $3d53 ; (roomovrimg + 1)
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
10cf : 8d 62 3d STA $3d62 ; (roomattrex + 0)
10d2 : 8d 63 3d STA $3d63 ; (roomattrex + 1)
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
10e3 : 8d 5c 3d STA $3d5c ; (objattrex + 0)
10e6 : 8d 5d 3d STA $3d5d ; (objattrex + 1)
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
1107 : ae c0 3c LDX $3cc0 ; (giocharmap + 0)
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
1235 : 8d 72 3d STA $3d72 ; (clearfull + 0)
1238 : 20 4f 12 JSR $124f ; (ui_clear.s0 + 0)
123b : ad 5e 3d LDA $3d5e ; (roomstart + 0)
123e : 85 43 __ STA T0 + 0 
1240 : ad 5f 3d LDA $3d5f ; (roomstart + 1)
1243 : 85 44 __ STA T0 + 1 
1245 : a0 00 __ LDY #$00
1247 : b1 43 __ LDA (T0 + 0),y 
1249 : 8d 74 3d STA $3d74 ; (newroom + 0)
124c : 4c d3 12 JMP $12d3 ; (room_load.s1000 + 0)
--------------------------------------------------------------------
ui_clear: ; ui_clear()->void
.s0:
124f : a9 00 __ LDA #$00
1251 : 8d c3 3c STA $3cc3 ; (text_y + 0)
1254 : 8d 73 3d STA $3d73 ; (al + 0)
1257 : ad 72 3d LDA $3d72 ; (clearfull + 0)
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
1281 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
1284 : 18 __ __ CLC
1285 : 69 08 __ ADC #$08
1287 : 85 0d __ STA P0 
1289 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
128c : 69 02 __ ADC #$02
128e : 85 0e __ STA P1 
1290 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
1293 : a9 00 __ LDA #$00
1295 : 8d 72 3d STA $3d72 ; (clearfull + 0)
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
12c1 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
12c4 : 18 __ __ CLC
12c5 : 69 30 __ ADC #$30
12c7 : 85 0d __ STA P0 
12c9 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
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
12da : 8d 75 3d STA $3d75 ; (cmd + 0)
12dd : a9 ff __ LDA #$ff
12df : 8d 76 3d STA $3d76 ; (obj1 + 0)
12e2 : 20 47 13 JSR $1347 ; (adv_run.s1000 + 0)
12e5 : ad 74 3d LDA $3d74 ; (newroom + 0)
12e8 : 85 53 __ STA T0 + 0 
12ea : 8d c4 3c STA $3cc4 ; (room + 0)
12ed : 20 a1 32 JSR $32a1 ; (os_roomimage_load.s0 + 0)
12f0 : ad 60 3d LDA $3d60 ; (roomattr + 0)
12f3 : 18 __ __ CLC
12f4 : 65 53 __ ADC T0 + 0 
12f6 : 85 43 __ STA T1 + 0 
12f8 : ad 61 3d LDA $3d61 ; (roomattr + 1)
12fb : 69 00 __ ADC #$00
12fd : 85 44 __ STA T1 + 1 
12ff : a0 00 __ LDY #$00
1301 : 8c 77 3d STY $3d77 ; (executed + 0)
1304 : b1 43 __ LDA (T1 + 0),y 
1306 : aa __ __ TAX
1307 : 29 01 __ AND #$01
1309 : d0 15 __ BNE $1320 ; (room_load.s7 + 0)
.s4:
130b : 8d 75 3d STA $3d75 ; (cmd + 0)
130e : a9 ff __ LDA #$ff
1310 : 8d 76 3d STA $3d76 ; (obj1 + 0)
1313 : 8a __ __ TXA
1314 : 09 01 __ ORA #$01
1316 : 91 43 __ STA (T1 + 0),y 
1318 : 20 47 13 JSR $1347 ; (adv_run.s1000 + 0)
131b : ad 77 3d LDA $3d77 ; (executed + 0)
131e : d0 0d __ BNE $132d ; (room_load.s28 + 0)
.s7:
1320 : a9 01 __ LDA #$01
1322 : 8d 75 3d STA $3d75 ; (cmd + 0)
1325 : a9 ff __ LDA #$ff
1327 : 8d 76 3d STA $3d76 ; (obj1 + 0)
132a : 20 47 13 JSR $1347 ; (adv_run.s1000 + 0)
.s28:
132d : 20 7b 34 JSR $347b ; (adv_onturn.s0 + 0)
1330 : ad 13 3d LDA $3d13 ; (nextroom + 0)
1333 : c9 fa __ CMP #$fa
1335 : f0 0a __ BEQ $1341 ; (room_load.s1001 + 0)
.s10:
1337 : 8d 74 3d STA $3d74 ; (newroom + 0)
133a : a9 fa __ LDA #$fa
133c : 8d 13 3d STA $3d13 ; (nextroom + 0)
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
1353 : 8d 77 3d STA $3d77 ; (executed + 0)
1356 : ad 2c 3d LDA $3d2c ; (opcode_vrbidx_count + 0)
1359 : cd 75 3d CMP $3d75 ; (cmd + 0)
135c : b0 03 __ BCS $1361 ; (adv_run.s3 + 0)
.s1:
135e : 8d 75 3d STA $3d75 ; (cmd + 0)
.s3:
1361 : ad 75 3d LDA $3d75 ; (cmd + 0)
1364 : 0a __ __ ASL
1365 : 85 54 __ STA T2 + 0 
1367 : a9 00 __ LDA #$00
1369 : 2a __ __ ROL
136a : aa __ __ TAX
136b : ad 42 3d LDA $3d42 ; (opcode_vrbidx_dir + 0)
136e : 65 54 __ ADC T2 + 0 
1370 : 85 54 __ STA T2 + 0 
1372 : 8a __ __ TXA
1373 : 6d 43 3d ADC $3d43 ; (opcode_vrbidx_dir + 1)
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
138e : ad c4 3c LDA $3cc4 ; (room + 0)
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
13a2 : ad 44 3d LDA $3d44 ; (opcode_vrbidx_data + 0)
13a5 : 65 56 __ ADC T3 + 0 
13a7 : 85 44 __ STA T4 + 0 
13a9 : ad 45 3d LDA $3d45 ; (opcode_vrbidx_data + 1)
13ac : 65 57 __ ADC T3 + 1 
13ae : 85 45 __ STA T4 + 1 
13b0 : a0 00 __ LDY #$00
13b2 : b1 44 __ LDA (T4 + 0),y 
13b4 : 8d 78 3d STA $3d78 ; (varroom + 0)
13b7 : c5 53 __ CMP T0 + 0 
13b9 : f0 07 __ BEQ $13c2 ; (adv_run.s7 + 0)
.s10:
13bb : ad 78 3d LDA $3d78 ; (varroom + 0)
13be : c9 f6 __ CMP #$f6
13c0 : d0 4e __ BNE $1410 ; (adv_run.s23 + 0)
.s7:
13c2 : a0 01 __ LDY #$01
13c4 : b1 44 __ LDA (T4 + 0),y 
13c6 : 8d 79 3d STA $3d79 ; (opcode + 0)
13c9 : 0a __ __ ASL
13ca : 85 47 __ STA T6 + 0 
13cc : a9 00 __ LDA #$00
13ce : 2a __ __ ROL
13cf : aa __ __ TAX
13d0 : ad 46 3d LDA $3d46 ; (opcode_pos + 0)
13d3 : 65 47 __ ADC T6 + 0 
13d5 : 85 47 __ STA T6 + 0 
13d7 : 8a __ __ TXA
13d8 : 6d 47 3d ADC $3d47 ; (opcode_pos + 1)
13db : 85 48 __ STA T6 + 1 
13dd : b1 47 __ LDA (T6 + 0),y 
13df : aa __ __ TAX
13e0 : ad 4a 3d LDA $3d4a ; (opcode_data + 0)
13e3 : 18 __ __ CLC
13e4 : 88 __ __ DEY
13e5 : 71 47 __ ADC (T6 + 0),y 
13e7 : 8d 7a 3d STA $3d7a ; (pcode + 0)
13ea : 8a __ __ TXA
13eb : 6d 4b 3d ADC $3d4b ; (opcode_data + 1)
13ee : 8d 7b 3d STA $3d7b ; (pcode + 1)
13f1 : ad 48 3d LDA $3d48 ; (opcode_len + 0)
13f4 : 85 47 __ STA T6 + 0 
13f6 : ad 49 3d LDA $3d49 ; (opcode_len + 1)
13f9 : 85 48 __ STA T6 + 1 
13fb : ac 79 3d LDY $3d79 ; (opcode + 0)
13fe : b1 47 __ LDA (T6 + 0),y 
1400 : 8d 7c 3d STA $3d7c ; (pcodelen + 0)
1403 : a9 00 __ LDA #$00
1405 : 8d 7d 3d STA $3d7d ; (pcodelen + 1)
1408 : 20 32 14 JSR $1432 ; (adv_exec.s1000 + 0)
140b : ad 77 3d LDA $3d77 ; (executed + 0)
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
143e : 8d 7e 3d STA $3d7e ; (in + 0)
1441 : 8d 7f 3d STA $3d7f ; (fail + 0)
1444 : 8d c5 3c STA $3cc5 ; (istack + 0)
1447 : 8d 80 3d STA $3d80 ; (used + 0)
144a : 8d 82 3d STA $3d82 ; (i + 0)
144d : 8d 83 3d STA $3d83 ; (i + 1)
1450 : ad 76 3d LDA $3d76 ; (obj1 + 0)
1453 : 8d 81 3d STA $3d81 ; (thisobj + 0)
1456 : ad 7c 3d LDA $3d7c ; (pcodelen + 0)
1459 : 0d 7d 3d ORA $3d7d ; (pcodelen + 1)
145c : d0 03 __ BNE $1461 ; (adv_exec.l2 + 0)
145e : 4c 47 15 JMP $1547 ; (adv_exec.s3 + 0)
.l2:
1461 : ad 82 3d LDA $3d82 ; (i + 0)
1464 : 85 54 __ STA T1 + 0 
1466 : 18 __ __ CLC
1467 : 69 01 __ ADC #$01
1469 : 85 56 __ STA T2 + 0 
146b : 8d 82 3d STA $3d82 ; (i + 0)
146e : ad 83 3d LDA $3d83 ; (i + 1)
1471 : 85 55 __ STA T1 + 1 
1473 : 69 00 __ ADC #$00
1475 : 85 57 __ STA T2 + 1 
1477 : 8d 83 3d STA $3d83 ; (i + 1)
147a : ad 7a 3d LDA $3d7a ; (pcode + 0)
147d : 85 58 __ STA T3 + 0 
147f : 18 __ __ CLC
1480 : 65 54 __ ADC T1 + 0 
1482 : 85 43 __ STA T4 + 0 
1484 : ad 7b 3d LDA $3d7b ; (pcode + 1)
1487 : 85 59 __ STA T3 + 1 
1489 : 65 55 __ ADC T1 + 1 
148b : 85 44 __ STA T4 + 1 
148d : a0 00 __ LDY #$00
148f : b1 43 __ LDA (T4 + 0),y 
1491 : 8d 79 3d STA $3d79 ; (opcode + 0)
1494 : c9 88 __ CMP #$88
1496 : d0 03 __ BNE $149b ; (adv_exec.s6 + 0)
1498 : 4c 47 15 JMP $1547 ; (adv_exec.s3 + 0)
.s6:
149b : 85 53 __ STA T0 + 0 
149d : aa __ __ TAX
149e : bd 46 3c LDA $3c46,x ; (divmod + 30)
14a1 : 10 03 __ BPL $14a6 ; (adv_exec.s9 + 0)
14a3 : 4c 9a 1a JMP $1a9a ; (adv_exec.s8 + 0)
.s9:
14a6 : 8a __ __ TXA
14a7 : e0 92 __ CPX #$92
14a9 : d0 1f __ BNE $14ca ; (adv_exec.s316 + 0)
.s162:
14ab : c8 __ __ INY
14ac : b1 43 __ LDA (T4 + 0),y 
14ae : 85 53 __ STA T0 + 0 
14b0 : 8d 86 3d STA $3d86 ; (var + 0)
14b3 : 18 __ __ CLC
14b4 : a5 54 __ LDA T1 + 0 
14b6 : 69 02 __ ADC #$02
14b8 : 8d 82 3d STA $3d82 ; (i + 0)
14bb : a5 55 __ LDA T1 + 1 
14bd : 69 00 __ ADC #$00
14bf : 8d 83 3d STA $3d83 ; (i + 1)
14c2 : ad 1a 3e LDA $3e1a ; (key + 0)
14c5 : 85 5a __ STA T5 + 0 
14c7 : 4c 5a 19 JMP $195a ; (adv_exec.s291 + 0)
.s316:
14ca : c9 92 __ CMP #$92
14cc : b0 03 __ BCS $14d1 ; (adv_exec.s317 + 0)
14ce : 4c 66 19 JMP $1966 ; (adv_exec.s318 + 0)
.s317:
14d1 : c9 96 __ CMP #$96
14d3 : d0 03 __ BNE $14d8 ; (adv_exec.s330 + 0)
14d5 : 4c de 18 JMP $18de ; (adv_exec.s289 + 0)
.s330:
14d8 : b0 03 __ BCS $14dd ; (adv_exec.s331 + 0)
14da : 4c 6c 18 JMP $186c ; (adv_exec.s332 + 0)
.s331:
14dd : c9 a1 __ CMP #$a1
14df : d0 03 __ BNE $14e4 ; (adv_exec.s336 + 0)
14e1 : 4c 02 17 JMP $1702 ; (adv_exec.s173 + 0)
.s336:
14e4 : c9 b2 __ CMP #$b2
14e6 : f0 04 __ BEQ $14ec ; (adv_exec.s251 + 0)
.s315:
14e8 : a9 01 __ LDA #$01
14ea : d0 47 __ BNE $1533 ; (adv_exec.s1288 + 0)
.s251:
14ec : c8 __ __ INY
14ed : b1 43 __ LDA (T4 + 0),y 
14ef : 8d 86 3d STA $3d86 ; (var + 0)
14f2 : ee 7e 3d INC $3d7e ; (in + 0)
14f5 : 18 __ __ CLC
14f6 : a5 54 __ LDA T1 + 0 
14f8 : 69 02 __ ADC #$02
14fa : 8d 82 3d STA $3d82 ; (i + 0)
14fd : a5 55 __ LDA T1 + 1 
14ff : 69 00 __ ADC #$00
1501 : 8d 83 3d STA $3d83 ; (i + 1)
1504 : cc 7e 3d CPY $3d7e ; (in + 0)
1507 : b0 05 __ BCS $150e ; (adv_exec.s253 + 0)
.s252:
1509 : ad 87 3d LDA $3d87 ; (obj2 + 0)
150c : 90 09 __ BCC $1517 ; (adv_exec.s656 + 0)
.s253:
150e : ad 86 3d LDA $3d86 ; (var + 0)
1511 : 8d 81 3d STA $3d81 ; (thisobj + 0)
1514 : ad 76 3d LDA $3d76 ; (obj1 + 0)
.s656:
1517 : cd 86 3d CMP $3d86 ; (var + 0)
151a : d0 03 __ BNE $151f ; (adv_exec.s255 + 0)
151c : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s255:
151f : c9 f9 __ CMP #$f9
1521 : d0 03 __ BNE $1526 ; (adv_exec.s259 + 0)
1523 : 4c f8 16 JMP $16f8 ; (adv_exec.s258 + 0)
.s259:
1526 : aa __ __ TAX
1527 : ad 86 3d LDA $3d86 ; (var + 0)
152a : c9 f5 __ CMP #$f5
152c : d0 03 __ BNE $1531 ; (adv_exec.s262 + 0)
152e : 4c ea 16 JMP $16ea ; (adv_exec.s264 + 0)
.s262:
1531 : a9 02 __ LDA #$02
.s1288:
1533 : 8d 7f 3d STA $3d7f ; (fail + 0)
.s338:
1536 : ad 7f 3d LDA $3d7f ; (fail + 0)
1539 : c9 02 __ CMP #$02
153b : d0 03 __ BNE $1540 ; (adv_exec.s342 + 0)
153d : 4c 74 16 JMP $1674 ; (adv_exec.s341 + 0)
.s342:
1540 : a9 02 __ LDA #$02
1542 : cd 7f 3d CMP $3d7f ; (fail + 0)
1545 : 90 1e __ BCC $1565 ; (adv_exec.s368 + 0)
.s3:
1547 : ad 7f 3d LDA $3d7f ; (fail + 0)
154a : f0 04 __ BEQ $1550 ; (adv_exec.s416 + 0)
.s414:
154c : a9 00 __ LDA #$00
154e : f0 07 __ BEQ $1557 ; (adv_exec.s1001 + 0)
.s416:
1550 : ad 80 3d LDA $3d80 ; (used + 0)
1553 : f0 02 __ BEQ $1557 ; (adv_exec.s1001 + 0)
.s1295:
1555 : a9 01 __ LDA #$01
.s1001:
1557 : 8d 77 3d STA $3d77 ; (executed + 0)
155a : a2 07 __ LDX #$07
155c : bd de cb LDA $cbde,x ; (adv_exec@stack + 0)
155f : 95 53 __ STA T0 + 0,x 
1561 : ca __ __ DEX
1562 : 10 f8 __ BPL $155c ; (adv_exec.s1001 + 5)
1564 : 60 __ __ RTS
.s368:
1565 : ee c5 3c INC $3cc5 ; (istack + 0)
1568 : ad 83 3d LDA $3d83 ; (i + 1)
156b : cd 7d 3d CMP $3d7d ; (pcodelen + 1)
156e : d0 06 __ BNE $1576 ; (adv_exec.s1027 + 0)
.s1026:
1570 : ad 82 3d LDA $3d82 ; (i + 0)
1573 : cd 7c 3d CMP $3d7c ; (pcodelen + 0)
.s1027:
1576 : b0 65 __ BCS $15dd ; (adv_exec.s346 + 0)
.s419:
1578 : ad 7b 3d LDA $3d7b ; (pcode + 1)
157b : 85 55 __ STA T1 + 1 
157d : ae 7a 3d LDX $3d7a ; (pcode + 0)
.l374:
1580 : 8a __ __ TXA
1581 : 18 __ __ CLC
1582 : 6d 82 3d ADC $3d82 ; (i + 0)
1585 : 85 58 __ STA T3 + 0 
1587 : a5 55 __ LDA T1 + 1 
1589 : 6d 83 3d ADC $3d83 ; (i + 1)
158c : 85 59 __ STA T3 + 1 
158e : a0 00 __ LDY #$00
1590 : b1 58 __ LDA (T3 + 0),y 
1592 : c9 88 __ CMP #$88
1594 : f0 47 __ BEQ $15dd ; (adv_exec.s346 + 0)
.s372:
1596 : 8d 88 3d STA $3d88 ; (ch + 0)
1599 : c9 8d __ CMP #$8d
159b : 90 09 __ BCC $15a6 ; (adv_exec.s376 + 0)
.s378:
159d : c9 97 __ CMP #$97
159f : b0 05 __ BCS $15a6 ; (adv_exec.s376 + 0)
.s375:
15a1 : ee c5 3c INC $3cc5 ; (istack + 0)
15a4 : 90 0e __ BCC $15b4 ; (adv_exec.s377 + 0)
.s376:
15a6 : c9 85 __ CMP #$85
15a8 : d0 03 __ BNE $15ad ; (adv_exec.s380 + 0)
15aa : 4c 6a 16 JMP $166a ; (adv_exec.s379 + 0)
.s380:
15ad : c9 87 __ CMP #$87
15af : d0 03 __ BNE $15b4 ; (adv_exec.s377 + 0)
15b1 : 4c 32 16 JMP $1632 ; (adv_exec.s386 + 0)
.s377:
15b4 : 2c 88 3d BIT $3d88 ; (ch + 0)
15b7 : 10 24 __ BPL $15dd ; (adv_exec.s346 + 0)
.s401:
15b9 : ac 88 3d LDY $3d88 ; (ch + 0)
15bc : b9 46 3c LDA $3c46,y ; (divmod + 30)
15bf : 29 7f __ AND #$7f
15c1 : 18 __ __ CLC
15c2 : 6d 82 3d ADC $3d82 ; (i + 0)
15c5 : 8d 82 3d STA $3d82 ; (i + 0)
15c8 : a9 00 __ LDA #$00
15ca : 6d 83 3d ADC $3d83 ; (i + 1)
15cd : 8d 83 3d STA $3d83 ; (i + 1)
15d0 : cd 7d 3d CMP $3d7d ; (pcodelen + 1)
15d3 : d0 06 __ BNE $15db ; (adv_exec.s1007 + 0)
.s1006:
15d5 : ad 82 3d LDA $3d82 ; (i + 0)
15d8 : cd 7c 3d CMP $3d7c ; (pcodelen + 0)
.s1007:
15db : 90 a3 __ BCC $1580 ; (adv_exec.l374 + 0)
.s346:
15dd : ad 82 3d LDA $3d82 ; (i + 0)
15e0 : 85 54 __ STA T1 + 0 
15e2 : 18 __ __ CLC
15e3 : 69 01 __ ADC #$01
15e5 : 8d 82 3d STA $3d82 ; (i + 0)
15e8 : ad 83 3d LDA $3d83 ; (i + 1)
15eb : aa __ __ TAX
15ec : 69 00 __ ADC #$00
15ee : 8d 83 3d STA $3d83 ; (i + 1)
15f1 : ad 7a 3d LDA $3d7a ; (pcode + 0)
15f4 : 18 __ __ CLC
15f5 : 65 54 __ ADC T1 + 0 
15f7 : 85 54 __ STA T1 + 0 
15f9 : 8a __ __ TXA
15fa : 6d 7b 3d ADC $3d7b ; (pcode + 1)
15fd : 85 55 __ STA T1 + 1 
15ff : a0 00 __ LDY #$00
1601 : b1 54 __ LDA (T1 + 0),y 
1603 : c9 88 __ CMP #$88
1605 : f0 22 __ BEQ $1629 ; (adv_exec.s361 + 0)
.s363:
1607 : ad 7f 3d LDA $3d7f ; (fail + 0)
160a : f0 03 __ BEQ $160f ; (adv_exec.s666 + 0)
160c : 4c 4c 15 JMP $154c ; (adv_exec.s414 + 0)
.s666:
160f : ad 82 3d LDA $3d82 ; (i + 0)
1612 : 85 54 __ STA T1 + 0 
1614 : ad 83 3d LDA $3d83 ; (i + 1)
.s1282:
1617 : cd 7d 3d CMP $3d7d ; (pcodelen + 1)
161a : d0 05 __ BNE $1621 ; (adv_exec.s1003 + 0)
.s1002:
161c : a5 54 __ LDA T1 + 0 
.s1290:
161e : cd 7c 3d CMP $3d7c ; (pcodelen + 0)
.s1003:
1621 : 90 03 __ BCC $1626 ; (adv_exec.s1003 + 5)
1623 : 4c 47 15 JMP $1547 ; (adv_exec.s3 + 0)
1626 : 4c 61 14 JMP $1461 ; (adv_exec.l2 + 0)
.s361:
1629 : 8c 7f 3d STY $3d7f ; (fail + 0)
162c : ce 7e 3d DEC $3d7e ; (in + 0)
162f : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s386:
1632 : ad c5 3c LDA $3cc5 ; (istack + 0)
1635 : c9 01 __ CMP #$01
1637 : f0 0a __ BEQ $1643 ; (adv_exec.s389 + 0)
.s390:
1639 : 09 00 __ ORA #$00
163b : f0 a0 __ BEQ $15dd ; (adv_exec.s346 + 0)
.s398:
163d : ce c5 3c DEC $3cc5 ; (istack + 0)
1640 : 4c b9 15 JMP $15b9 ; (adv_exec.s401 + 0)
.s389:
1643 : ad 82 3d LDA $3d82 ; (i + 0)
1646 : 18 __ __ CLC
1647 : 69 01 __ ADC #$01
1649 : aa __ __ TAX
164a : ad 83 3d LDA $3d83 ; (i + 1)
164d : 69 00 __ ADC #$00
164f : cd 7d 3d CMP $3d7d ; (pcodelen + 1)
1652 : d0 0d __ BNE $1661 ; (adv_exec.s382 + 0)
.s1010:
1654 : ec 7c 3d CPX $3d7c ; (pcodelen + 0)
1657 : d0 08 __ BNE $1661 ; (adv_exec.s382 + 0)
.s395:
1659 : ad 80 3d LDA $3d80 ; (used + 0)
165c : d0 03 __ BNE $1661 ; (adv_exec.s382 + 0)
165e : 4c dd 15 JMP $15dd ; (adv_exec.s346 + 0)
.s382:
1661 : 8c c5 3c STY $3cc5 ; (istack + 0)
1664 : 8c 7f 3d STY $3d7f ; (fail + 0)
1667 : 4c dd 15 JMP $15dd ; (adv_exec.s346 + 0)
.s379:
166a : ad c5 3c LDA $3cc5 ; (istack + 0)
166d : c9 01 __ CMP #$01
166f : f0 f0 __ BEQ $1661 ; (adv_exec.s382 + 0)
1671 : 4c b4 15 JMP $15b4 ; (adv_exec.s377 + 0)
.s341:
1674 : ad 83 3d LDA $3d83 ; (i + 1)
1677 : cd 7d 3d CMP $3d7d ; (pcodelen + 1)
167a : d0 06 __ BNE $1682 ; (adv_exec.s1039 + 0)
.s1038:
167c : ad 82 3d LDA $3d82 ; (i + 0)
167f : cd 7c 3d CMP $3d7c ; (pcodelen + 0)
.s1039:
1682 : 90 03 __ BCC $1687 ; (adv_exec.s418 + 0)
1684 : 4c dd 15 JMP $15dd ; (adv_exec.s346 + 0)
.s418:
1687 : ad 7a 3d LDA $3d7a ; (pcode + 0)
168a : 85 54 __ STA T1 + 0 
168c : ad 7b 3d LDA $3d7b ; (pcode + 1)
168f : 85 55 __ STA T1 + 1 
1691 : a2 00 __ LDX #$00
.l345:
1693 : a5 54 __ LDA T1 + 0 
1695 : 6d 82 3d ADC $3d82 ; (i + 0)
1698 : 85 58 __ STA T3 + 0 
169a : a5 55 __ LDA T1 + 1 
169c : 6d 83 3d ADC $3d83 ; (i + 1)
169f : 85 59 __ STA T3 + 1 
16a1 : a0 00 __ LDY #$00
16a3 : b1 58 __ LDA (T3 + 0),y 
16a5 : 8d 88 3d STA $3d88 ; (ch + 0)
16a8 : a8 __ __ TAY
16a9 : c9 88 __ CMP #$88
16ab : d0 2b __ BNE $16d8 ; (adv_exec.s348 + 0)
.s347:
16ad : 8a __ __ TXA
16ae : d0 03 __ BNE $16b3 ; (adv_exec.s350 + 0)
16b0 : 4c dd 15 JMP $15dd ; (adv_exec.s346 + 0)
.s350:
16b3 : ca __ __ DEX
.s357:
16b4 : b9 46 3c LDA $3c46,y ; (divmod + 30)
16b7 : 29 7f __ AND #$7f
16b9 : 18 __ __ CLC
16ba : 6d 82 3d ADC $3d82 ; (i + 0)
16bd : 8d 82 3d STA $3d82 ; (i + 0)
16c0 : a9 00 __ LDA #$00
16c2 : 6d 83 3d ADC $3d83 ; (i + 1)
16c5 : 8d 83 3d STA $3d83 ; (i + 1)
16c8 : cd 7d 3d CMP $3d7d ; (pcodelen + 1)
16cb : d0 06 __ BNE $16d3 ; (adv_exec.s1031 + 0)
.s1030:
16cd : ad 82 3d LDA $3d82 ; (i + 0)
16d0 : cd 7c 3d CMP $3d7c ; (pcodelen + 0)
.s1031:
16d3 : 90 be __ BCC $1693 ; (adv_exec.l345 + 0)
16d5 : 4c dd 15 JMP $15dd ; (adv_exec.s346 + 0)
.s348:
16d8 : ad 88 3d LDA $3d88 ; (ch + 0)
16db : c9 b2 __ CMP #$b2
16dd : d0 04 __ BNE $16e3 ; (adv_exec.s349 + 0)
.s354:
16df : e8 __ __ INX
16e0 : 4c b4 16 JMP $16b4 ; (adv_exec.s357 + 0)
.s349:
16e3 : 09 00 __ ORA #$00
16e5 : 30 cd __ BMI $16b4 ; (adv_exec.s357 + 0)
16e7 : 4c dd 15 JMP $15dd ; (adv_exec.s346 + 0)
.s264:
16ea : 8e 81 3d STX $3d81 ; (thisobj + 0)
.s661:
16ed : ad 7f 3d LDA $3d7f ; (fail + 0)
16f0 : d0 03 __ BNE $16f5 ; (adv_exec.s661 + 8)
16f2 : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
16f5 : 4c 36 15 JMP $1536 ; (adv_exec.s338 + 0)
.s258:
16f8 : ad 86 3d LDA $3d86 ; (var + 0)
16fb : c9 ff __ CMP #$ff
16fd : f0 ee __ BEQ $16ed ; (adv_exec.s661 + 0)
16ff : 4c 31 15 JMP $1531 ; (adv_exec.s262 + 0)
.s173:
1702 : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1705 : ad 86 3d LDA $3d86 ; (var + 0)
1708 : 85 5a __ STA T5 + 0 
170a : 8d 84 3d STA $3d84 ; (varobj + 0)
170d : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1710 : ad 86 3d LDA $3d86 ; (var + 0)
1713 : 8d 78 3d STA $3d78 ; (varroom + 0)
1716 : a5 53 __ LDA T0 + 0 
1718 : c9 94 __ CMP #$94
171a : d0 03 __ BNE $171f ; (adv_exec.s225 + 0)
171c : 4c ca 17 JMP $17ca ; (adv_exec.s175 + 0)
.s225:
171f : b0 03 __ BCS $1724 ; (adv_exec.s226 + 0)
1721 : 4c c3 17 JMP $17c3 ; (adv_exec.s227 + 0)
.s226:
1724 : c9 a1 __ CMP #$a1
1726 : d0 2a __ BNE $1752 ; (adv_exec.s662 + 0)
.s197:
1728 : a5 5a __ LDA T5 + 0 
172a : c9 f3 __ CMP #$f3
172c : f0 5f __ BEQ $178d ; (adv_exec.s198 + 0)
.s199:
172e : ad 5a 3d LDA $3d5a ; (objloc + 0)
1731 : 85 56 __ STA T2 + 0 
1733 : ad 5b 3d LDA $3d5b ; (objloc + 1)
1736 : 85 57 __ STA T2 + 1 
1738 : ad 86 3d LDA $3d86 ; (var + 0)
173b : a4 5a __ LDY T5 + 0 
173d : c9 f4 __ CMP #$f4
173f : f0 2f __ BEQ $1770 ; (adv_exec.s211 + 0)
.s212:
1741 : b1 56 __ LDA (T2 + 0),y 
1743 : cd 86 3d CMP $3d86 ; (var + 0)
1746 : f0 0a __ BEQ $1752 ; (adv_exec.s662 + 0)
.s218:
1748 : a9 03 __ LDA #$03
174a : 8d 7f 3d STA $3d7f ; (fail + 0)
174d : a5 53 __ LDA T0 + 0 
174f : 4c 55 17 JMP $1755 ; (adv_exec.s1284 + 0)
.s662:
1752 : ad 79 3d LDA $3d79 ; (opcode + 0)
.s1284:
1755 : c9 a1 __ CMP #$a1
1757 : d0 94 __ BNE $16ed ; (adv_exec.s661 + 0)
.s233:
1759 : ad 7f 3d LDA $3d7f ; (fail + 0)
175c : d0 03 __ BNE $1761 ; (adv_exec.s230 + 0)
175e : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s230:
1761 : ad 7c 3d LDA $3d7c ; (pcodelen + 0)
1764 : 8d 82 3d STA $3d82 ; (i + 0)
1767 : ad 7d 3d LDA $3d7d ; (pcodelen + 1)
176a : 8d 83 3d STA $3d83 ; (i + 1)
176d : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s211:
1770 : b1 56 __ LDA (T2 + 0),y 
1772 : c9 f8 __ CMP #$f8
1774 : f0 dc __ BEQ $1752 ; (adv_exec.s662 + 0)
.s215:
1776 : cd c4 3c CMP $3cc4 ; (room + 0)
1779 : d0 cd __ BNE $1748 ; (adv_exec.s218 + 0)
.s220:
177b : ad 58 3d LDA $3d58 ; (objattr + 0)
177e : 85 56 __ STA T2 + 0 
1780 : ad 59 3d LDA $3d59 ; (objattr + 1)
1783 : 85 57 __ STA T2 + 1 
1785 : b1 56 __ LDA (T2 + 0),y 
1787 : 4a __ __ LSR
1788 : b0 c8 __ BCS $1752 ; (adv_exec.s662 + 0)
178a : 4c 48 17 JMP $1748 ; (adv_exec.s218 + 0)
.s198:
178d : a9 00 __ LDA #$00
178f : 8d 88 3d STA $3d88 ; (ch + 0)
1792 : ad 2d 3d LDA $3d2d ; (obj_count + 0)
1795 : f0 1d __ BEQ $17b4 ; (adv_exec.s181 + 0)
.s422:
1797 : ad 5a 3d LDA $3d5a ; (objloc + 0)
179a : 85 54 __ STA T1 + 0 
179c : ad 5b 3d LDA $3d5b ; (objloc + 1)
179f : 85 55 __ STA T1 + 1 
17a1 : ad 86 3d LDA $3d86 ; (var + 0)
.l202:
17a4 : ac 88 3d LDY $3d88 ; (ch + 0)
17a7 : d1 54 __ CMP (T1 + 0),y 
17a9 : f0 09 __ BEQ $17b4 ; (adv_exec.s181 + 0)
.s205:
17ab : c8 __ __ INY
17ac : 8c 88 3d STY $3d88 ; (ch + 0)
17af : cc 2d 3d CPY $3d2d ; (obj_count + 0)
17b2 : 90 f0 __ BCC $17a4 ; (adv_exec.l202 + 0)
.s181:
17b4 : ad 88 3d LDA $3d88 ; (ch + 0)
17b7 : cd 2d 3d CMP $3d2d ; (obj_count + 0)
17ba : d0 96 __ BNE $1752 ; (adv_exec.s662 + 0)
.s190:
17bc : a9 03 __ LDA #$03
17be : 8d 7f 3d STA $3d7f ; (fail + 0)
17c1 : d0 8f __ BNE $1752 ; (adv_exec.s662 + 0)
.s227:
17c3 : c9 90 __ CMP #$90
17c5 : d0 8b __ BNE $1752 ; (adv_exec.s662 + 0)
17c7 : 4c 28 17 JMP $1728 ; (adv_exec.s197 + 0)
.s175:
17ca : 18 __ __ CLC
17cb : a5 58 __ LDA T3 + 0 
17cd : 6d 82 3d ADC $3d82 ; (i + 0)
17d0 : 85 56 __ STA T2 + 0 
17d2 : a5 59 __ LDA T3 + 1 
17d4 : 6d 83 3d ADC $3d83 ; (i + 1)
17d7 : 85 57 __ STA T2 + 1 
17d9 : a0 00 __ LDY #$00
17db : b1 56 __ LDA (T2 + 0),y 
17dd : 8d 8f 3d STA $3d8f ; (varattr + 0)
17e0 : ee 82 3d INC $3d82 ; (i + 0)
17e3 : d0 03 __ BNE $17e8 ; (adv_exec.s1304 + 0)
.s1303:
17e5 : ee 83 3d INC $3d83 ; (i + 1)
.s1304:
17e8 : a5 5a __ LDA T5 + 0 
17ea : c9 f3 __ CMP #$f3
17ec : d0 4c __ BNE $183a ; (adv_exec.s177 + 0)
.s176:
17ee : 8c 88 3d STY $3d88 ; (ch + 0)
17f1 : ad 2d 3d LDA $3d2d ; (obj_count + 0)
17f4 : f0 be __ BEQ $17b4 ; (adv_exec.s181 + 0)
.s421:
17f6 : ad 54 3d LDA $3d54 ; (objnameid + 0)
17f9 : 85 54 __ STA T1 + 0 
17fb : ad 55 3d LDA $3d55 ; (objnameid + 1)
17fe : 85 55 __ STA T1 + 1 
.l180:
1800 : ac 88 3d LDY $3d88 ; (ch + 0)
1803 : b1 54 __ LDA (T1 + 0),y 
1805 : c9 ff __ CMP #$ff
1807 : f0 25 __ BEQ $182e ; (adv_exec.s182 + 0)
.s183:
1809 : ad 5a 3d LDA $3d5a ; (objloc + 0)
180c : 85 58 __ STA T3 + 0 
180e : ad 5b 3d LDA $3d5b ; (objloc + 1)
1811 : 85 59 __ STA T3 + 1 
1813 : b1 58 __ LDA (T3 + 0),y 
1815 : cd 78 3d CMP $3d78 ; (varroom + 0)
1818 : d0 14 __ BNE $182e ; (adv_exec.s182 + 0)
.s188:
181a : ad 58 3d LDA $3d58 ; (objattr + 0)
181d : 85 58 __ STA T3 + 0 
181f : ad 59 3d LDA $3d59 ; (objattr + 1)
1822 : 85 59 __ STA T3 + 1 
1824 : ad 8f 3d LDA $3d8f ; (varattr + 0)
1827 : 31 58 __ AND (T3 + 0),y 
1829 : cd 8f 3d CMP $3d8f ; (varattr + 0)
182c : f0 86 __ BEQ $17b4 ; (adv_exec.s181 + 0)
.s182:
182e : c8 __ __ INY
182f : 8c 88 3d STY $3d88 ; (ch + 0)
1832 : cc 2d 3d CPY $3d2d ; (obj_count + 0)
1835 : 90 c9 __ BCC $1800 ; (adv_exec.l180 + 0)
1837 : 4c b4 17 JMP $17b4 ; (adv_exec.s181 + 0)
.s177:
183a : ad 5a 3d LDA $3d5a ; (objloc + 0)
183d : 85 56 __ STA T2 + 0 
183f : ad 5b 3d LDA $3d5b ; (objloc + 1)
1842 : 85 57 __ STA T2 + 1 
1844 : a4 5a __ LDY T5 + 0 
1846 : b1 56 __ LDA (T2 + 0),y 
1848 : cd 86 3d CMP $3d86 ; (var + 0)
184b : d0 17 __ BNE $1864 ; (adv_exec.s193 + 0)
.s196:
184d : ad 58 3d LDA $3d58 ; (objattr + 0)
1850 : 85 56 __ STA T2 + 0 
1852 : ad 59 3d LDA $3d59 ; (objattr + 1)
1855 : 85 57 __ STA T2 + 1 
1857 : b1 56 __ LDA (T2 + 0),y 
1859 : 2d 8f 3d AND $3d8f ; (varattr + 0)
185c : cd 8f 3d CMP $3d8f ; (varattr + 0)
185f : d0 03 __ BNE $1864 ; (adv_exec.s193 + 0)
1861 : 4c 52 17 JMP $1752 ; (adv_exec.s662 + 0)
.s193:
1864 : a9 03 __ LDA #$03
1866 : 8d 7f 3d STA $3d7f ; (fail + 0)
1869 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s332:
186c : e0 94 __ CPX #$94
186e : d0 03 __ BNE $1873 ; (adv_exec.s333 + 0)
1870 : 4c 02 17 JMP $1702 ; (adv_exec.s173 + 0)
.s333:
1873 : e0 94 __ CPX #$94
1875 : 90 1a __ BCC $1891 ; (adv_exec.s279 + 0)
.s243:
1877 : 20 e2 20 JSR $20e2 ; (_alignattr.s0 + 0)
187a : 20 d2 21 JSR $21d2 ; (_getattrstrid.s0 + 0)
187d : a9 00 __ LDA #$00
187f : 8d 8c 3d STA $3d8c ; (text_continue + 0)
1882 : ad 89 3d LDA $3d89 ; (strid + 0)
1885 : c9 ff __ CMP #$ff
1887 : d0 03 __ BNE $188c ; (adv_exec.s163 + 0)
1889 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s163:
188c : a9 03 __ LDA #$03
188e : 4c 33 15 JMP $1533 ; (adv_exec.s1288 + 0)
.s279:
1891 : a0 01 __ LDY #$01
1893 : b1 43 __ LDA (T4 + 0),y 
1895 : 8d 84 3d STA $3d84 ; (varobj + 0)
1898 : 18 __ __ CLC
1899 : a5 54 __ LDA T1 + 0 
189b : 69 02 __ ADC #$02
189d : 8d 82 3d STA $3d82 ; (i + 0)
18a0 : a5 55 __ LDA T1 + 1 
18a2 : 69 00 __ ADC #$00
18a4 : 8d 83 3d STA $3d83 ; (i + 1)
18a7 : ad 84 3d LDA $3d84 ; (varobj + 0)
18aa : 4a __ __ LSR
18ab : 4a __ __ LSR
18ac : 4a __ __ LSR
18ad : 18 __ __ CLC
18ae : 6d 64 3d ADC $3d64 ; (bitvars + 0)
18b1 : 85 56 __ STA T2 + 0 
18b3 : ad 65 3d LDA $3d65 ; (bitvars + 1)
18b6 : 69 00 __ ADC #$00
18b8 : 85 57 __ STA T2 + 1 
18ba : ad 84 3d LDA $3d84 ; (varobj + 0)
18bd : 29 07 __ AND #$07
18bf : a8 __ __ TAY
18c0 : b9 14 3d LDA $3d14,y ; (ormask + 0)
18c3 : a0 00 __ LDY #$00
18c5 : 31 56 __ AND (T2 + 0),y 
18c7 : 8d 86 3d STA $3d86 ; (var + 0)
18ca : e0 8d __ CPX #$8d
18cc : d0 08 __ BNE $18d6 ; (adv_exec.s281 + 0)
.s280:
18ce : ad 86 3d LDA $3d86 ; (var + 0)
18d1 : f0 b9 __ BEQ $188c ; (adv_exec.s163 + 0)
18d3 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s281:
18d6 : ad 86 3d LDA $3d86 ; (var + 0)
18d9 : d0 b1 __ BNE $188c ; (adv_exec.s163 + 0)
18db : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s289:
18de : c8 __ __ INY
18df : b1 43 __ LDA (T4 + 0),y 
18e1 : 8d 8f 3d STA $3d8f ; (varattr + 0)
18e4 : 18 __ __ CLC
18e5 : a5 54 __ LDA T1 + 0 
18e7 : 69 02 __ ADC #$02
18e9 : 8d 82 3d STA $3d82 ; (i + 0)
18ec : a5 55 __ LDA T1 + 1 
18ee : 69 00 __ ADC #$00
18f0 : 8d 83 3d STA $3d83 ; (i + 1)
18f3 : ad 8f 3d LDA $3d8f ; (varattr + 0)
18f6 : 85 54 __ STA T1 + 0 
18f8 : 29 40 __ AND #$40
18fa : 8d 85 3d STA $3d85 ; (varmode + 0)
18fd : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1900 : ad 86 3d LDA $3d86 ; (var + 0)
1903 : 85 53 __ STA T0 + 0 
1905 : 8d 84 3d STA $3d84 ; (varobj + 0)
1908 : a5 54 __ LDA T1 + 0 
190a : 29 80 __ AND #$80
190c : 8d 85 3d STA $3d85 ; (varmode + 0)
190f : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1912 : ad 86 3d LDA $3d86 ; (var + 0)
1915 : 85 5a __ STA T5 + 0 
1917 : 8d 78 3d STA $3d78 ; (varroom + 0)
191a : a5 54 __ LDA T1 + 0 
191c : 29 3f __ AND #$3f
191e : c9 02 __ CMP #$02
1920 : d0 0c __ BNE $192e ; (adv_exec.s308 + 0)
.s299:
1922 : a5 5a __ LDA T5 + 0 
1924 : c5 53 __ CMP T0 + 0 
1926 : 90 03 __ BCC $192b ; (adv_exec.s299 + 9)
1928 : 4c 8c 18 JMP $188c ; (adv_exec.s163 + 0)
192b : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s308:
192e : 90 13 __ BCC $1943 ; (adv_exec.s310 + 0)
.s309:
1930 : c9 03 __ CMP #$03
1932 : f0 03 __ BEQ $1937 ; (adv_exec.s303 + 0)
1934 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s303:
1937 : a5 53 __ LDA T0 + 0 
1939 : c5 5a __ CMP T5 + 0 
193b : 90 03 __ BCC $1940 ; (adv_exec.s303 + 9)
193d : 4c 8c 18 JMP $188c ; (adv_exec.s163 + 0)
1940 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s310:
1943 : 09 00 __ ORA #$00
1945 : f0 13 __ BEQ $195a ; (adv_exec.s291 + 0)
.s311:
1947 : c9 01 __ CMP #$01
1949 : f0 03 __ BEQ $194e ; (adv_exec.s295 + 0)
194b : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s295:
194e : a5 53 __ LDA T0 + 0 
1950 : c5 5a __ CMP T5 + 0 
1952 : d0 03 __ BNE $1957 ; (adv_exec.s295 + 9)
1954 : 4c 8c 18 JMP $188c ; (adv_exec.s163 + 0)
1957 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s291:
195a : a5 53 __ LDA T0 + 0 
.s1283:
195c : c5 5a __ CMP T5 + 0 
195e : f0 03 __ BEQ $1963 ; (adv_exec.s1283 + 7)
1960 : 4c 8c 18 JMP $188c ; (adv_exec.s163 + 0)
1963 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s318:
1966 : c9 8e __ CMP #$8e
1968 : d0 03 __ BNE $196d ; (adv_exec.s319 + 0)
196a : 4c 53 1a JMP $1a53 ; (adv_exec.s166 + 0)
.s319:
196d : 90 03 __ BCC $1972 ; (adv_exec.s321 + 0)
196f : 4c 00 1a JMP $1a00 ; (adv_exec.s320 + 0)
.s321:
1972 : c9 87 __ CMP #$87
1974 : d0 03 __ BNE $1979 ; (adv_exec.s322 + 0)
1976 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s322:
1979 : b0 7b __ BCS $19f6 ; (adv_exec.s323 + 0)
.s324:
197b : c9 85 __ CMP #$85
197d : f0 03 __ BEQ $1982 ; (adv_exec.s142 + 0)
197f : 4c e8 14 JMP $14e8 ; (adv_exec.s315 + 0)
.s142:
1982 : 8c 86 3d STY $3d86 ; (var + 0)
1985 : a5 57 __ LDA T2 + 1 
1987 : cd 7d 3d CMP $3d7d ; (pcodelen + 1)
198a : d0 05 __ BNE $1991 ; (adv_exec.l1151 + 0)
.s1150:
198c : a5 56 __ LDA T2 + 0 
.s1291:
198e : cd 7c 3d CMP $3d7c ; (pcodelen + 0)
.l1151:
1991 : 90 03 __ BCC $1996 ; (adv_exec.s144 + 0)
1993 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s144:
1996 : a5 58 __ LDA T3 + 0 
1998 : 6d 82 3d ADC $3d82 ; (i + 0)
199b : 85 56 __ STA T2 + 0 
199d : a5 59 __ LDA T3 + 1 
199f : 6d 83 3d ADC $3d83 ; (i + 1)
19a2 : 85 57 __ STA T2 + 1 
19a4 : b1 56 __ LDA (T2 + 0),y 
19a6 : aa __ __ TAX
19a7 : c9 8d __ CMP #$8d
19a9 : 90 0d __ BCC $19b8 ; (adv_exec.s147 + 0)
.s149:
19ab : c9 97 __ CMP #$97
19ad : b0 09 __ BCS $19b8 ; (adv_exec.s147 + 0)
.s146:
19af : ad 86 3d LDA $3d86 ; (var + 0)
19b2 : 85 5a __ STA T5 + 0 
19b4 : e6 5a __ INC T5 + 0 
19b6 : 90 10 __ BCC $19c8 ; (adv_exec.s660 + 0)
.s147:
19b8 : c9 87 __ CMP #$87
19ba : d0 33 __ BNE $19ef ; (adv_exec.s151 + 0)
.s150:
19bc : ad 86 3d LDA $3d86 ; (var + 0)
19bf : d0 03 __ BNE $19c4 ; (adv_exec.s153 + 0)
19c1 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s153:
19c4 : 85 5a __ STA T5 + 0 
19c6 : c6 5a __ DEC T5 + 0 
.s660:
19c8 : a5 5a __ LDA T5 + 0 
19ca : 8d 86 3d STA $3d86 ; (var + 0)
.s148:
19cd : 8e 88 3d STX $3d88 ; (ch + 0)
19d0 : bd 46 3c LDA $3c46,x ; (divmod + 30)
19d3 : 29 7f __ AND #$7f
19d5 : 18 __ __ CLC
19d6 : 6d 82 3d ADC $3d82 ; (i + 0)
19d9 : 8d 82 3d STA $3d82 ; (i + 0)
19dc : a9 00 __ LDA #$00
19de : 6d 83 3d ADC $3d83 ; (i + 1)
19e1 : 8d 83 3d STA $3d83 ; (i + 1)
19e4 : cd 7d 3d CMP $3d7d ; (pcodelen + 1)
19e7 : d0 a8 __ BNE $1991 ; (adv_exec.l1151 + 0)
.s1140:
19e9 : ad 82 3d LDA $3d82 ; (i + 0)
19ec : 4c 8e 19 JMP $198e ; (adv_exec.s1291 + 0)
.s151:
19ef : c9 88 __ CMP #$88
19f1 : d0 da __ BNE $19cd ; (adv_exec.s148 + 0)
19f3 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s323:
19f6 : e0 8d __ CPX #$8d
19f8 : d0 03 __ BNE $19fd ; (adv_exec.s323 + 7)
19fa : 4c 91 18 JMP $1891 ; (adv_exec.s279 + 0)
19fd : 4c e8 14 JMP $14e8 ; (adv_exec.s315 + 0)
.s320:
1a00 : e0 90 __ CPX #$90
1a02 : d0 03 __ BNE $1a07 ; (adv_exec.s327 + 0)
1a04 : 4c 02 17 JMP $1702 ; (adv_exec.s173 + 0)
.s327:
1a07 : c8 __ __ INY
1a08 : b1 43 __ LDA (T4 + 0),y 
1a0a : 8d 86 3d STA $3d86 ; (var + 0)
1a0d : 18 __ __ CLC
1a0e : a5 54 __ LDA T1 + 0 
1a10 : 69 02 __ ADC #$02
1a12 : 8d 82 3d STA $3d82 ; (i + 0)
1a15 : a5 55 __ LDA T1 + 1 
1a17 : 69 00 __ ADC #$00
1a19 : 8d 83 3d STA $3d83 ; (i + 1)
1a1c : e0 90 __ CPX #$90
1a1e : ad 86 3d LDA $3d86 ; (var + 0)
1a21 : 90 0b __ BCC $1a2e ; (adv_exec.s234 + 0)
.s247:
1a23 : cd c4 3c CMP $3cc4 ; (room + 0)
1a26 : f0 03 __ BEQ $1a2b ; (adv_exec.s247 + 8)
1a28 : 4c 8c 18 JMP $188c ; (adv_exec.s163 + 0)
1a2b : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s234:
1a2e : c9 fe __ CMP #$fe
1a30 : d0 0a __ BNE $1a3c ; (adv_exec.s236 + 0)
.s238:
1a32 : ad 1b 3e LDA $3e1b ; (obj1k + 0)
1a35 : c9 02 __ CMP #$02
1a37 : d0 03 __ BNE $1a3c ; (adv_exec.s236 + 0)
1a39 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s236:
1a3c : ad 86 3d LDA $3d86 ; (var + 0)
1a3f : c9 fd __ CMP #$fd
1a41 : f0 03 __ BEQ $1a46 ; (adv_exec.s242 + 0)
1a43 : 4c 8c 18 JMP $188c ; (adv_exec.s163 + 0)
.s242:
1a46 : ad 1c 3e LDA $3e1c ; (obj2k + 0)
1a49 : c9 02 __ CMP #$02
1a4b : f0 03 __ BEQ $1a50 ; (adv_exec.s242 + 10)
1a4d : 4c 8c 18 JMP $188c ; (adv_exec.s163 + 0)
1a50 : 4c ed 16 JMP $16ed ; (adv_exec.s661 + 0)
.s166:
1a53 : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1a56 : ad 86 3d LDA $3d86 ; (var + 0)
1a59 : 8d 84 3d STA $3d84 ; (varobj + 0)
1a5c : 18 __ __ CLC
1a5d : a5 58 __ LDA T3 + 0 
1a5f : 6d 82 3d ADC $3d82 ; (i + 0)
1a62 : 85 56 __ STA T2 + 0 
1a64 : a5 59 __ LDA T3 + 1 
1a66 : 6d 83 3d ADC $3d83 ; (i + 1)
1a69 : 85 57 __ STA T2 + 1 
1a6b : a0 00 __ LDY #$00
1a6d : b1 56 __ LDA (T2 + 0),y 
1a6f : 85 5a __ STA T5 + 0 
1a71 : 8d 86 3d STA $3d86 ; (var + 0)
1a74 : ee 82 3d INC $3d82 ; (i + 0)
1a77 : d0 03 __ BNE $1a7c ; (adv_exec.s1302 + 0)
.s1301:
1a79 : ee 83 3d INC $3d83 ; (i + 1)
.s1302:
1a7c : ad 84 3d LDA $3d84 ; (varobj + 0)
1a7f : c9 f9 __ CMP #$f9
1a81 : d0 03 __ BNE $1a86 ; (adv_exec.s168 + 0)
1a83 : 4c 8c 18 JMP $188c ; (adv_exec.s163 + 0)
.s168:
1a86 : ad 58 3d LDA $3d58 ; (objattr + 0)
1a89 : 85 56 __ STA T2 + 0 
1a8b : ad 59 3d LDA $3d59 ; (objattr + 1)
1a8e : 85 57 __ STA T2 + 1 
1a90 : ac 84 3d LDY $3d84 ; (varobj + 0)
1a93 : b1 56 __ LDA (T2 + 0),y 
1a95 : 25 5a __ AND T5 + 0 
1a97 : 4c 5c 19 JMP $195c ; (adv_exec.s1283 + 0)
.s8:
1a9a : ee 80 3d INC $3d80 ; (used + 0)
1a9d : 8a __ __ TXA
1a9e : e0 a0 __ CPX #$a0
1aa0 : d0 03 __ BNE $1aa5 ; (adv_exec.s92 + 0)
1aa2 : 4c 46 1f JMP $1f46 ; (adv_exec.s12 + 0)
.s92:
1aa5 : c9 a0 __ CMP #$a0
1aa7 : b0 03 __ BCS $1aac ; (adv_exec.s93 + 0)
1aa9 : 4c cd 1d JMP $1dcd ; (adv_exec.s94 + 0)
.s93:
1aac : c9 ab __ CMP #$ab
1aae : d0 35 __ BNE $1ae5 ; (adv_exec.s119 + 0)
.s59:
1ab0 : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1ab3 : ad 86 3d LDA $3d86 ; (var + 0)
1ab6 : 8d 78 3d STA $3d78 ; (varroom + 0)
1ab9 : 18 __ __ CLC
1aba : a5 58 __ LDA T3 + 0 
1abc : 6d 82 3d ADC $3d82 ; (i + 0)
1abf : 85 56 __ STA T2 + 0 
1ac1 : a5 59 __ LDA T3 + 1 
1ac3 : 6d 83 3d ADC $3d83 ; (i + 1)
1ac6 : 85 57 __ STA T2 + 1 
1ac8 : ad 82 3d LDA $3d82 ; (i + 0)
1acb : 18 __ __ CLC
1acc : 69 01 __ ADC #$01
1ace : 85 54 __ STA T1 + 0 
1ad0 : ad 83 3d LDA $3d83 ; (i + 1)
1ad3 : 69 00 __ ADC #$00
1ad5 : 85 55 __ STA T1 + 1 
1ad7 : a0 00 __ LDY #$00
1ad9 : b1 56 __ LDA (T2 + 0),y 
1adb : a8 __ __ TAY
1adc : ad 53 3d LDA $3d53 ; (roomovrimg + 1)
1adf : ae 52 3d LDX $3d52 ; (roomovrimg + 0)
1ae2 : 4c ec 1c JMP $1cec ; (adv_exec.s669 + 0)
.s119:
1ae5 : b0 03 __ BCS $1aea ; (adv_exec.s120 + 0)
1ae7 : 4c a1 1c JMP $1ca1 ; (adv_exec.s121 + 0)
.s120:
1aea : c9 af __ CMP #$af
1aec : d0 03 __ BNE $1af1 ; (adv_exec.s133 + 0)
1aee : 4c 34 1c JMP $1c34 ; (adv_exec.s71 + 0)
.s133:
1af1 : b0 03 __ BCS $1af6 ; (adv_exec.s134 + 0)
1af3 : 4c 90 1b JMP $1b90 ; (adv_exec.s135 + 0)
.s134:
1af6 : c9 b0 __ CMP #$b0
1af8 : f0 1d __ BEQ $1b17 ; (adv_exec.s52 + 0)
.s139:
1afa : c9 b1 __ CMP #$b1
1afc : f0 07 __ BEQ $1b05 ; (adv_exec.s49 + 0)
.s91:
1afe : a9 01 __ LDA #$01
1b00 : 8d 7f 3d STA $3d7f ; (fail + 0)
1b03 : d0 03 __ BNE $1b08 ; (adv_exec.s552 + 0)
.s49:
1b05 : 20 55 2a JSR $2a55 ; (ui_waitkey.s0 + 0)
.s552:
1b08 : a5 57 __ LDA T2 + 1 
1b0a : cd 7d 3d CMP $3d7d ; (pcodelen + 1)
1b0d : f0 03 __ BEQ $1b12 ; (adv_exec.s1168 + 0)
1b0f : 4c 21 16 JMP $1621 ; (adv_exec.s1003 + 0)
.s1168:
1b12 : a5 56 __ LDA T2 + 0 
1b14 : 4c 1e 16 JMP $161e ; (adv_exec.s1290 + 0)
.s52:
1b17 : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1b1a : ad 86 3d LDA $3d86 ; (var + 0)
1b1d : 8d 84 3d STA $3d84 ; (varobj + 0)
1b20 : 18 __ __ CLC
1b21 : a5 58 __ LDA T3 + 0 
1b23 : 6d 82 3d ADC $3d82 ; (i + 0)
1b26 : 85 56 __ STA T2 + 0 
1b28 : a5 59 __ LDA T3 + 1 
1b2a : 6d 83 3d ADC $3d83 ; (i + 1)
1b2d : 85 57 __ STA T2 + 1 
1b2f : a0 00 __ LDY #$00
1b31 : b1 56 __ LDA (T2 + 0),y 
1b33 : 8d 86 3d STA $3d86 ; (var + 0)
1b36 : ad 82 3d LDA $3d82 ; (i + 0)
1b39 : 18 __ __ CLC
1b3a : 69 01 __ ADC #$01
1b3c : 85 54 __ STA T1 + 0 
1b3e : 8d 82 3d STA $3d82 ; (i + 0)
1b41 : ad 83 3d LDA $3d83 ; (i + 1)
1b44 : 69 00 __ ADC #$00
1b46 : 85 55 __ STA T1 + 1 
1b48 : 8d 83 3d STA $3d83 ; (i + 1)
1b4b : a5 53 __ LDA T0 + 0 
1b4d : c9 a6 __ CMP #$a6
1b4f : f0 25 __ BEQ $1b76 ; (adv_exec.s55 + 0)
.s57:
1b51 : c9 b0 __ CMP #$b0
1b53 : f0 03 __ BEQ $1b58 ; (adv_exec.s54 + 0)
1b55 : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s54:
1b58 : ad 58 3d LDA $3d58 ; (objattr + 0)
1b5b : 18 __ __ CLC
1b5c : 6d 84 3d ADC $3d84 ; (varobj + 0)
1b5f : 85 58 __ STA T3 + 0 
1b61 : ad 59 3d LDA $3d59 ; (objattr + 1)
1b64 : 69 00 __ ADC #$00
1b66 : 85 59 __ STA T3 + 1 
1b68 : a9 ff __ LDA #$ff
1b6a : 4d 86 3d EOR $3d86 ; (var + 0)
1b6d : 31 58 __ AND (T3 + 0),y 
1b6f : 91 58 __ STA (T3 + 0),y 
.s1289:
1b71 : a5 55 __ LDA T1 + 1 
1b73 : 4c 17 16 JMP $1617 ; (adv_exec.s1282 + 0)
.s55:
1b76 : ad 58 3d LDA $3d58 ; (objattr + 0)
1b79 : 18 __ __ CLC
1b7a : 6d 84 3d ADC $3d84 ; (varobj + 0)
1b7d : 85 56 __ STA T2 + 0 
1b7f : ad 59 3d LDA $3d59 ; (objattr + 1)
1b82 : 69 00 __ ADC #$00
1b84 : 85 57 __ STA T2 + 1 
1b86 : ad 86 3d LDA $3d86 ; (var + 0)
1b89 : 11 56 __ ORA (T2 + 0),y 
1b8b : 91 56 __ STA (T2 + 0),y 
1b8d : 4c 71 1b JMP $1b71 ; (adv_exec.s1289 + 0)
.s135:
1b90 : c9 ad __ CMP #$ad
1b92 : d0 19 __ BNE $1bad ; (adv_exec.s136 + 0)
.s50:
1b94 : 18 __ __ CLC
1b95 : a5 54 __ LDA T1 + 0 
1b97 : 69 02 __ ADC #$02
1b99 : 85 54 __ STA T1 + 0 
1b9b : 8d 82 3d STA $3d82 ; (i + 0)
1b9e : a5 55 __ LDA T1 + 1 
1ba0 : 69 00 __ ADC #$00
1ba2 : 85 55 __ STA T1 + 1 
1ba4 : 8d 83 3d STA $3d83 ; (i + 1)
1ba7 : 20 57 2c JSR $2c57 ; (ui_room_update.s0 + 0)
1baa : 4c 71 1b JMP $1b71 ; (adv_exec.s1289 + 0)
.s136:
1bad : 90 08 __ BCC $1bb7 ; (adv_exec.s79 + 0)
.s38:
1baf : a9 02 __ LDA #$02
.s1287:
1bb1 : 8d fb 3c STA $3cfb ; (quit_request + 0)
1bb4 : 4c 08 1b JMP $1b08 ; (adv_exec.s552 + 0)
.s79:
1bb7 : a0 01 __ LDY #$01
1bb9 : b1 43 __ LDA (T4 + 0),y 
1bbb : 85 5a __ STA T5 + 0 
1bbd : 8d 84 3d STA $3d84 ; (varobj + 0)
1bc0 : 18 __ __ CLC
1bc1 : a5 54 __ LDA T1 + 0 
1bc3 : 69 02 __ ADC #$02
1bc5 : 8d 82 3d STA $3d82 ; (i + 0)
1bc8 : a5 55 __ LDA T1 + 1 
1bca : 69 00 __ ADC #$00
1bcc : 8d 83 3d STA $3d83 ; (i + 1)
1bcf : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1bd2 : a5 53 __ LDA T0 + 0 
1bd4 : c9 84 __ CMP #$84
1bd6 : d0 1a __ BNE $1bf2 ; (adv_exec.s85 + 0)
.s82:
1bd8 : ad 66 3d LDA $3d66 ; (vars + 0)
1bdb : 18 __ __ CLC
1bdc : 65 5a __ ADC T5 + 0 
1bde : 85 54 __ STA T1 + 0 
1be0 : ad 67 3d LDA $3d67 ; (vars + 1)
1be3 : 69 00 __ ADC #$00
1be5 : 85 55 __ STA T1 + 1 
1be7 : a0 00 __ LDY #$00
1be9 : b1 54 __ LDA (T1 + 0),y 
1beb : 38 __ __ SEC
1bec : ed 86 3d SBC $3d86 ; (var + 0)
1bef : 4c 12 1c JMP $1c12 ; (adv_exec.s1285 + 0)
.s85:
1bf2 : b0 23 __ BCS $1c17 ; (adv_exec.s86 + 0)
.s87:
1bf4 : c9 81 __ CMP #$81
1bf6 : f0 03 __ BEQ $1bfb ; (adv_exec.s81 + 0)
1bf8 : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s81:
1bfb : ad 66 3d LDA $3d66 ; (vars + 0)
1bfe : 18 __ __ CLC
1bff : 65 5a __ ADC T5 + 0 
1c01 : 85 54 __ STA T1 + 0 
1c03 : ad 67 3d LDA $3d67 ; (vars + 1)
1c06 : 69 00 __ ADC #$00
1c08 : 85 55 __ STA T1 + 1 
1c0a : ad 86 3d LDA $3d86 ; (var + 0)
1c0d : 18 __ __ CLC
1c0e : a0 00 __ LDY #$00
1c10 : 71 54 __ ADC (T1 + 0),y 
.s1285:
1c12 : 91 54 __ STA (T1 + 0),y 
1c14 : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s86:
1c17 : c9 ac __ CMP #$ac
1c19 : f0 03 __ BEQ $1c1e ; (adv_exec.s83 + 0)
1c1b : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s83:
1c1e : a5 5a __ LDA T5 + 0 
.s670:
1c20 : 18 __ __ CLC
1c21 : 6d 66 3d ADC $3d66 ; (vars + 0)
1c24 : 85 54 __ STA T1 + 0 
1c26 : ad 67 3d LDA $3d67 ; (vars + 1)
.s1286:
1c29 : 69 00 __ ADC #$00
1c2b : 85 55 __ STA T1 + 1 
1c2d : ad 86 3d LDA $3d86 ; (var + 0)
1c30 : a0 00 __ LDY #$00
1c32 : f0 de __ BEQ $1c12 ; (adv_exec.s1285 + 0)
.s71:
1c34 : a0 01 __ LDY #$01
1c36 : b1 43 __ LDA (T4 + 0),y 
1c38 : 8d 84 3d STA $3d84 ; (varobj + 0)
1c3b : 18 __ __ CLC
1c3c : a5 54 __ LDA T1 + 0 
1c3e : 69 02 __ ADC #$02
1c40 : 85 54 __ STA T1 + 0 
1c42 : 8d 82 3d STA $3d82 ; (i + 0)
1c45 : a5 55 __ LDA T1 + 1 
1c47 : 69 00 __ ADC #$00
1c49 : 85 55 __ STA T1 + 1 
1c4b : 8d 83 3d STA $3d83 ; (i + 1)
1c4e : ad 84 3d LDA $3d84 ; (varobj + 0)
1c51 : 4a __ __ LSR
1c52 : 4a __ __ LSR
1c53 : 4a __ __ LSR
1c54 : 8d 86 3d STA $3d86 ; (var + 0)
1c57 : ad 64 3d LDA $3d64 ; (bitvars + 0)
1c5a : 18 __ __ CLC
1c5b : 6d 86 3d ADC $3d86 ; (var + 0)
1c5e : 85 58 __ STA T3 + 0 
1c60 : ad 65 3d LDA $3d65 ; (bitvars + 1)
1c63 : 69 00 __ ADC #$00
1c65 : 85 59 __ STA T3 + 1 
1c67 : ad 84 3d LDA $3d84 ; (varobj + 0)
1c6a : 29 07 __ AND #$07
1c6c : 85 56 __ STA T2 + 0 
1c6e : ad 7c 3d LDA $3d7c ; (pcodelen + 0)
1c71 : 85 45 __ STA T6 + 0 
1c73 : ad 7d 3d LDA $3d7d ; (pcodelen + 1)
1c76 : 85 46 __ STA T6 + 1 
1c78 : 8a __ __ TXA
1c79 : 88 __ __ DEY
1c7a : c9 a5 __ CMP #$a5
1c7c : f0 0a __ BEQ $1c88 ; (adv_exec.s72 + 0)
.s73:
1c7e : a6 56 __ LDX T2 + 0 
1c80 : bd 1c 3d LDA $3d1c,x ; (xormask + 0)
1c83 : 31 58 __ AND (T3 + 0),y 
1c85 : 4c 8f 1c JMP $1c8f ; (adv_exec.s580 + 0)
.s72:
1c88 : a6 56 __ LDX T2 + 0 
1c8a : bd 14 3d LDA $3d14,x ; (ormask + 0)
1c8d : 11 58 __ ORA (T3 + 0),y 
.s580:
1c8f : 91 58 __ STA (T3 + 0),y 
1c91 : a5 55 __ LDA T1 + 1 
1c93 : c5 46 __ CMP T6 + 1 
1c95 : f0 03 __ BEQ $1c9a ; (adv_exec.s1192 + 0)
1c97 : 4c 21 16 JMP $1621 ; (adv_exec.s1003 + 0)
.s1192:
1c9a : a5 54 __ LDA T1 + 0 
1c9c : c5 45 __ CMP T6 + 0 
1c9e : 4c 21 16 JMP $1621 ; (adv_exec.s1003 + 0)
.s121:
1ca1 : c9 a5 __ CMP #$a5
1ca3 : f0 8f __ BEQ $1c34 ; (adv_exec.s71 + 0)
.s122:
1ca5 : b0 03 __ BCS $1caa ; (adv_exec.s123 + 0)
1ca7 : 4c 81 1d JMP $1d81 ; (adv_exec.s124 + 0)
.s123:
1caa : c9 a7 __ CMP #$a7
1cac : f0 5b __ BEQ $1d09 ; (adv_exec.s61 + 0)
.s129:
1cae : b0 03 __ BCS $1cb3 ; (adv_exec.s130 + 0)
1cb0 : 4c 17 1b JMP $1b17 ; (adv_exec.s52 + 0)
.s130:
1cb3 : c9 a9 __ CMP #$a9
1cb5 : f0 03 __ BEQ $1cba ; (adv_exec.s60 + 0)
1cb7 : 4c fe 1a JMP $1afe ; (adv_exec.s91 + 0)
.s60:
1cba : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1cbd : ad 86 3d LDA $3d86 ; (var + 0)
1cc0 : 8d 78 3d STA $3d78 ; (varroom + 0)
1cc3 : 18 __ __ CLC
1cc4 : a5 58 __ LDA T3 + 0 
1cc6 : 6d 82 3d ADC $3d82 ; (i + 0)
1cc9 : 85 56 __ STA T2 + 0 
1ccb : a5 59 __ LDA T3 + 1 
1ccd : 6d 83 3d ADC $3d83 ; (i + 1)
1cd0 : 85 57 __ STA T2 + 1 
1cd2 : ad 82 3d LDA $3d82 ; (i + 0)
1cd5 : 18 __ __ CLC
1cd6 : 69 01 __ ADC #$01
1cd8 : 85 54 __ STA T1 + 0 
1cda : ad 83 3d LDA $3d83 ; (i + 1)
1cdd : 69 00 __ ADC #$00
1cdf : 85 55 __ STA T1 + 1 
1ce1 : a0 00 __ LDY #$00
1ce3 : b1 56 __ LDA (T2 + 0),y 
1ce5 : a8 __ __ TAY
1ce6 : ad 51 3d LDA $3d51 ; (roomimg + 1)
1ce9 : ae 50 3d LDX $3d50 ; (roomimg + 0)
.s669:
1cec : 86 56 __ STX T2 + 0 
1cee : 85 57 __ STA T2 + 1 
1cf0 : a5 54 __ LDA T1 + 0 
1cf2 : 8d 82 3d STA $3d82 ; (i + 0)
1cf5 : a5 55 __ LDA T1 + 1 
1cf7 : 8d 83 3d STA $3d83 ; (i + 1)
1cfa : 98 __ __ TYA
1cfb : ac 86 3d LDY $3d86 ; (var + 0)
1cfe : 8d 86 3d STA $3d86 ; (var + 0)
1d01 : 91 56 __ STA (T2 + 0),y 
1d03 : 20 a1 32 JSR $32a1 ; (os_roomimage_load.s0 + 0)
1d06 : 4c 71 1b JMP $1b71 ; (adv_exec.s1289 + 0)
.s61:
1d09 : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1d0c : ad 86 3d LDA $3d86 ; (var + 0)
1d0f : 8d 84 3d STA $3d84 ; (varobj + 0)
1d12 : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1d15 : ad 86 3d LDA $3d86 ; (var + 0)
1d18 : 85 53 __ STA T0 + 0 
1d1a : 8d 78 3d STA $3d78 ; (varroom + 0)
1d1d : a9 00 __ LDA #$00
1d1f : 8d 88 3d STA $3d88 ; (ch + 0)
1d22 : 8d 86 3d STA $3d86 ; (var + 0)
1d25 : 18 __ __ CLC
1d26 : a5 58 __ LDA T3 + 0 
1d28 : 6d 82 3d ADC $3d82 ; (i + 0)
1d2b : 85 56 __ STA T2 + 0 
1d2d : a5 59 __ LDA T3 + 1 
1d2f : 6d 83 3d ADC $3d83 ; (i + 1)
1d32 : 85 57 __ STA T2 + 1 
1d34 : a0 00 __ LDY #$00
1d36 : b1 56 __ LDA (T2 + 0),y 
1d38 : 8d 8f 3d STA $3d8f ; (varattr + 0)
1d3b : ee 82 3d INC $3d82 ; (i + 0)
1d3e : d0 03 __ BNE $1d43 ; (adv_exec.s1300 + 0)
.s1299:
1d40 : ee 83 3d INC $3d83 ; (i + 1)
.s1300:
1d43 : ad 2d 3d LDA $3d2d ; (obj_count + 0)
1d46 : f0 33 __ BEQ $1d7b ; (adv_exec.s64 + 0)
.s417:
1d48 : ad 5a 3d LDA $3d5a ; (objloc + 0)
1d4b : 85 54 __ STA T1 + 0 
1d4d : ad 5b 3d LDA $3d5b ; (objloc + 1)
1d50 : 85 55 __ STA T1 + 1 
.l63:
1d52 : a5 53 __ LDA T0 + 0 
1d54 : ac 88 3d LDY $3d88 ; (ch + 0)
1d57 : d1 54 __ CMP (T1 + 0),y 
1d59 : d0 17 __ BNE $1d72 ; (adv_exec.s588 + 0)
.s68:
1d5b : ad 58 3d LDA $3d58 ; (objattr + 0)
1d5e : 85 58 __ STA T3 + 0 
1d60 : ad 59 3d LDA $3d59 ; (objattr + 1)
1d63 : 85 59 __ STA T3 + 1 
1d65 : ad 8f 3d LDA $3d8f ; (varattr + 0)
1d68 : 31 58 __ AND (T3 + 0),y 
1d6a : cd 8f 3d CMP $3d8f ; (varattr + 0)
1d6d : d0 03 __ BNE $1d72 ; (adv_exec.s588 + 0)
.s65:
1d6f : ee 86 3d INC $3d86 ; (var + 0)
.s588:
1d72 : c8 __ __ INY
1d73 : 8c 88 3d STY $3d88 ; (ch + 0)
1d76 : cc 2d 3d CPY $3d2d ; (obj_count + 0)
1d79 : 90 d7 __ BCC $1d52 ; (adv_exec.l63 + 0)
.s64:
1d7b : ad 84 3d LDA $3d84 ; (varobj + 0)
1d7e : 4c 20 1c JMP $1c20 ; (adv_exec.s670 + 0)
.s124:
1d81 : c9 a3 __ CMP #$a3
1d83 : d0 05 __ BNE $1d8a ; (adv_exec.s125 + 0)
.s37:
1d85 : a9 01 __ LDA #$01
1d87 : 4c b1 1b JMP $1bb1 ; (adv_exec.s1287 + 0)
.s125:
1d8a : b0 29 __ BCS $1db5 ; (adv_exec.s40 + 0)
.s127:
1d8c : c9 a2 __ CMP #$a2
1d8e : f0 03 __ BEQ $1d93 ; (adv_exec.s70 + 0)
1d90 : 4c fe 1a JMP $1afe ; (adv_exec.s91 + 0)
.s70:
1d93 : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1d96 : ad 86 3d LDA $3d86 ; (var + 0)
1d99 : 85 53 __ STA T0 + 0 
1d9b : 8d 84 3d STA $3d84 ; (varobj + 0)
1d9e : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1da1 : ad 86 3d LDA $3d86 ; (var + 0)
1da4 : 8d 78 3d STA $3d78 ; (varroom + 0)
1da7 : ad 5a 3d LDA $3d5a ; (objloc + 0)
1daa : 18 __ __ CLC
1dab : 65 53 __ ADC T0 + 0 
1dad : 85 54 __ STA T1 + 0 
1daf : ad 5b 3d LDA $3d5b ; (objloc + 1)
1db2 : 4c 29 1c JMP $1c29 ; (adv_exec.s1286 + 0)
.s40:
1db5 : ad 5e 3d LDA $3d5e ; (roomstart + 0)
1db8 : 85 54 __ STA T1 + 0 
1dba : ad 5f 3d LDA $3d5f ; (roomstart + 1)
1dbd : 85 55 __ STA T1 + 1 
1dbf : ad c4 3c LDA $3cc4 ; (room + 0)
1dc2 : 91 54 __ STA (T1 + 0),y 
1dc4 : 20 c3 2a JSR $2ac3 ; (adv_save.s0 + 0)
1dc7 : ee 06 3e INC $3e06 ; (saved + 0)
1dca : 4c 08 1b JMP $1b08 ; (adv_exec.s552 + 0)
.s94:
1dcd : c9 8b __ CMP #$8b
1dcf : d0 09 __ BNE $1dda ; (adv_exec.s95 + 0)
.s51:
1dd1 : c8 __ __ INY
1dd2 : b1 43 __ LDA (T4 + 0),y 
1dd4 : 8d 13 3d STA $3d13 ; (nextroom + 0)
1dd7 : 4c ce 20 JMP $20ce ; (adv_exec.s668 + 0)
.s95:
1dda : b0 03 __ BCS $1ddf ; (adv_exec.s96 + 0)
1ddc : 4c fc 1f JMP $1ffc ; (adv_exec.s97 + 0)
.s96:
1ddf : c9 9a __ CMP #$9a
1de1 : b0 03 __ BCS $1de6 ; (adv_exec.s109 + 0)
1de3 : 4c 86 1f JMP $1f86 ; (adv_exec.s111 + 0)
.s109:
1de6 : a9 9b __ LDA #$9b
1de8 : c5 53 __ CMP T0 + 0 
1dea : 90 54 __ BCC $1e40 ; (adv_exec.s110 + 0)
.s30:
1dec : c8 __ __ INY
1ded : b1 43 __ LDA (T4 + 0),y 
1def : 8d 89 3d STA $3d89 ; (strid + 0)
1df2 : 8d 86 3d STA $3d86 ; (var + 0)
1df5 : a5 54 __ LDA T1 + 0 
1df7 : 69 01 __ ADC #$01
1df9 : 85 54 __ STA T1 + 0 
1dfb : 8d 82 3d STA $3d82 ; (i + 0)
1dfe : a5 55 __ LDA T1 + 1 
1e00 : 69 00 __ ADC #$00
1e02 : 85 55 __ STA T1 + 1 
1e04 : 8d 83 3d STA $3d83 ; (i + 1)
1e07 : e0 9b __ CPX #$9b
1e09 : f0 09 __ BEQ $1e14 ; (adv_exec.s31 + 0)
.s32:
1e0b : ad 35 3d LDA $3d35 ; (msgs + 1)
1e0e : ae 34 3d LDX $3d34 ; (msgs + 0)
1e11 : 4c 1a 1e JMP $1e1a ; (adv_exec.s33 + 0)
.s31:
1e14 : ad 37 3d LDA $3d37 ; (msgs2 + 1)
1e17 : ae 36 3d LDX $3d36 ; (msgs2 + 0)
.s33:
1e1a : 8e 8a 3d STX $3d8a ; (str + 0)
1e1d : 8d 8b 3d STA $3d8b ; (str + 1)
1e20 : ad 89 3d LDA $3d89 ; (strid + 0)
1e23 : c9 ff __ CMP #$ff
1e25 : d0 06 __ BNE $1e2d ; (adv_exec.s672 + 0)
.s34:
1e27 : 8c 7f 3d STY $3d7f ; (fail + 0)
1e2a : 4c 71 1b JMP $1b71 ; (adv_exec.s1289 + 0)
.s672:
1e2d : 20 8e 23 JSR $238e ; (_getstring.s0 + 0)
1e30 : ad 92 3d LDA $3d92 ; (ostr + 0)
1e33 : 85 13 __ STA P6 
1e35 : ad 93 3d LDA $3d93 ; (ostr + 1)
1e38 : 85 14 __ STA P7 
.s667:
1e3a : 20 63 24 JSR $2463 ; (ui_text_write.s0 + 0)
1e3d : 4c 71 1b JMP $1b71 ; (adv_exec.s1289 + 0)
.s110:
1e40 : e0 9d __ CPX #$9d
1e42 : b0 03 __ BCS $1e47 ; (adv_exec.s116 + 0)
1e44 : 4c 46 1f JMP $1f46 ; (adv_exec.s12 + 0)
.s116:
1e47 : a5 54 __ LDA T1 + 0 
1e49 : 69 01 __ ADC #$01
1e4b : 85 54 __ STA T1 + 0 
1e4d : 8d 82 3d STA $3d82 ; (i + 0)
1e50 : a5 55 __ LDA T1 + 1 
1e52 : 69 00 __ ADC #$00
1e54 : 85 55 __ STA T1 + 1 
1e56 : 8d 83 3d STA $3d83 ; (i + 1)
1e59 : ad 66 3d LDA $3d66 ; (vars + 0)
1e5c : 85 58 __ STA T3 + 0 
1e5e : ad 67 3d LDA $3d67 ; (vars + 1)
1e61 : 85 59 __ STA T3 + 1 
1e63 : c8 __ __ INY
1e64 : b1 43 __ LDA (T4 + 0),y 
1e66 : a8 __ __ TAY
1e67 : b1 58 __ LDA (T3 + 0),y 
1e69 : 85 5a __ STA T5 + 0 
1e6b : e0 9f __ CPX #$9f
1e6d : b0 2d __ BCS $1e9c ; (adv_exec.s23 + 0)
.s19:
1e6f : ad 30 3d LDA $3d30 ; (advnames + 0)
1e72 : 8d 8a 3d STA $3d8a ; (str + 0)
1e75 : ad 31 3d LDA $3d31 ; (advnames + 1)
1e78 : 8d 8b 3d STA $3d8b ; (str + 1)
1e7b : e0 9d __ CPX #$9d
1e7d : f0 09 __ BEQ $1e88 ; (adv_exec.s20 + 0)
.s21:
1e7f : ad 4d 3d LDA $3d4d ; (roomnameid + 1)
1e82 : ae 4c 3d LDX $3d4c ; (roomnameid + 0)
1e85 : 4c 8e 1e JMP $1e8e ; (adv_exec.s673 + 0)
.s20:
1e88 : ad 55 3d LDA $3d55 ; (objnameid + 1)
1e8b : ae 54 3d LDX $3d54 ; (objnameid + 0)
.s673:
1e8e : 86 56 __ STX T2 + 0 
1e90 : 85 57 __ STA T2 + 1 
1e92 : a4 5a __ LDY T5 + 0 
1e94 : b1 56 __ LDA (T2 + 0),y 
1e96 : 8d 89 3d STA $3d89 ; (strid + 0)
1e99 : 4c 2d 1e JMP $1e2d ; (adv_exec.s672 + 0)
.s23:
1e9c : a9 00 __ LDA #$00
1e9e : 8d 88 3d STA $3d88 ; (ch + 0)
1ea1 : ad 6f 3d LDA $3d6f ; (tmp + 1)
1ea4 : 85 57 __ STA T2 + 1 
1ea6 : 8d 93 3d STA $3d93 ; (ostr + 1)
1ea9 : 85 14 __ STA P7 
1eab : ad 6e 3d LDA $3d6e ; (tmp + 0)
1eae : 85 56 __ STA T2 + 0 
1eb0 : 85 13 __ STA P6 
1eb2 : 8d 92 3d STA $3d92 ; (ostr + 0)
1eb5 : a5 5a __ LDA T5 + 0 
1eb7 : 8d 89 3d STA $3d89 ; (strid + 0)
1eba : c9 64 __ CMP #$64
1ebc : b0 5d __ BCS $1f1b ; (adv_exec.s24 + 0)
.s26:
1ebe : a9 09 __ LDA #$09
1ec0 : c5 5a __ CMP T5 + 0 
1ec2 : b0 28 __ BCS $1eec ; (adv_exec.s29 + 0)
.s27:
1ec4 : ad 88 3d LDA $3d88 ; (ch + 0)
1ec7 : 85 53 __ STA T0 + 0 
1ec9 : ee 88 3d INC $3d88 ; (ch + 0)
1ecc : ad 89 3d LDA $3d89 ; (strid + 0)
1ecf : 85 1b __ STA ACCU + 0 
1ed1 : a9 00 __ LDA #$00
1ed3 : 85 1c __ STA ACCU + 1 
1ed5 : 85 04 __ STA WORK + 1 
1ed7 : a9 0a __ LDA #$0a
1ed9 : 85 03 __ STA WORK + 0 
1edb : 20 28 3c JSR $3c28 ; (divmod + 0)
1ede : 18 __ __ CLC
1edf : a5 1b __ LDA ACCU + 0 
1ee1 : 69 30 __ ADC #$30
1ee3 : a4 53 __ LDY T0 + 0 
1ee5 : 91 56 __ STA (T2 + 0),y 
1ee7 : a5 05 __ LDA WORK + 2 
1ee9 : 8d 89 3d STA $3d89 ; (strid + 0)
.s29:
1eec : ad 88 3d LDA $3d88 ; (ch + 0)
1eef : a8 __ __ TAY
1ef0 : 18 __ __ CLC
1ef1 : 69 01 __ ADC #$01
1ef3 : 8d 88 3d STA $3d88 ; (ch + 0)
1ef6 : aa __ __ TAX
1ef7 : ad 89 3d LDA $3d89 ; (strid + 0)
1efa : 18 __ __ CLC
1efb : 69 30 __ ADC #$30
1efd : 91 56 __ STA (T2 + 0),y 
1eff : 8a __ __ TXA
1f00 : 18 __ __ CLC
1f01 : 65 56 __ ADC T2 + 0 
1f03 : 85 56 __ STA T2 + 0 
1f05 : 90 02 __ BCC $1f09 ; (adv_exec.s1298 + 0)
.s1297:
1f07 : e6 57 __ INC T2 + 1 
.s1298:
1f09 : a9 00 __ LDA #$00
1f0b : a8 __ __ TAY
1f0c : 91 56 __ STA (T2 + 0),y 
1f0e : a5 56 __ LDA T2 + 0 
1f10 : 8d 95 3d STA $3d95 ; (etxt + 0)
1f13 : a5 57 __ LDA T2 + 1 
1f15 : 8d 96 3d STA $3d96 ; (etxt + 1)
1f18 : 4c 3a 1e JMP $1e3a ; (adv_exec.s667 + 0)
.s24:
1f1b : a9 01 __ LDA #$01
1f1d : 8d 88 3d STA $3d88 ; (ch + 0)
1f20 : a5 5a __ LDA T5 + 0 
1f22 : 85 1b __ STA ACCU + 0 
1f24 : a9 00 __ LDA #$00
1f26 : 85 1c __ STA ACCU + 1 
1f28 : 85 04 __ STA WORK + 1 
1f2a : a9 64 __ LDA #$64
1f2c : 85 03 __ STA WORK + 0 
1f2e : 20 28 3c JSR $3c28 ; (divmod + 0)
1f31 : 18 __ __ CLC
1f32 : a5 1b __ LDA ACCU + 0 
1f34 : 69 30 __ ADC #$30
1f36 : a0 00 __ LDY #$00
1f38 : 91 56 __ STA (T2 + 0),y 
1f3a : a5 05 __ LDA WORK + 2 
1f3c : 8d 89 3d STA $3d89 ; (strid + 0)
1f3f : c9 0a __ CMP #$0a
1f41 : 90 a9 __ BCC $1eec ; (adv_exec.s29 + 0)
1f43 : 4c c4 1e JMP $1ec4 ; (adv_exec.s27 + 0)
.s12:
1f46 : e0 9c __ CPX #$9c
1f48 : f0 14 __ BEQ $1f5e ; (adv_exec.s13 + 0)
.s14:
1f4a : a9 01 __ LDA #$01
1f4c : 8d 85 3d STA $3d85 ; (varmode + 0)
1f4f : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1f52 : ad 86 3d LDA $3d86 ; (var + 0)
1f55 : 8d 78 3d STA $3d78 ; (varroom + 0)
1f58 : 8d 84 3d STA $3d84 ; (varobj + 0)
1f5b : 4c 61 1f JMP $1f61 ; (adv_exec.s547 + 0)
.s13:
1f5e : 20 e2 20 JSR $20e2 ; (_alignattr.s0 + 0)
.s547:
1f61 : 20 d2 21 JSR $21d2 ; (_getattrstrid.s0 + 0)
1f64 : ad 89 3d LDA $3d89 ; (strid + 0)
1f67 : c9 ff __ CMP #$ff
1f69 : d0 08 __ BNE $1f73 ; (adv_exec.s17 + 0)
.s16:
1f6b : a9 01 __ LDA #$01
1f6d : 8d 7f 3d STA $3d7f ; (fail + 0)
1f70 : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s17:
1f73 : 20 8e 23 JSR $238e ; (_getstring.s0 + 0)
1f76 : ad 92 3d LDA $3d92 ; (ostr + 0)
1f79 : 85 13 __ STA P6 
1f7b : ad 93 3d LDA $3d93 ; (ostr + 1)
1f7e : 85 14 __ STA P7 
1f80 : 20 63 24 JSR $2463 ; (ui_text_write.s0 + 0)
1f83 : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s111:
1f86 : c9 98 __ CMP #$98
1f88 : d0 05 __ BNE $1f8f ; (adv_exec.s112 + 0)
.s39:
1f8a : a9 03 __ LDA #$03
1f8c : 4c b1 1b JMP $1bb1 ; (adv_exec.s1287 + 0)
.s112:
1f8f : b0 41 __ BCS $1fd2 ; (adv_exec.s43 + 0)
.s114:
1f91 : c9 97 __ CMP #$97
1f93 : f0 03 __ BEQ $1f98 ; (adv_exec.s69 + 0)
1f95 : 4c fe 1a JMP $1afe ; (adv_exec.s91 + 0)
.s69:
1f98 : 20 ef 20 JSR $20ef ; (_getobj.s0 + 0)
1f9b : ad 86 3d LDA $3d86 ; (var + 0)
1f9e : 8d 78 3d STA $3d78 ; (varroom + 0)
1fa1 : 18 __ __ CLC
1fa2 : a5 58 __ LDA T3 + 0 
1fa4 : 6d 82 3d ADC $3d82 ; (i + 0)
1fa7 : 85 56 __ STA T2 + 0 
1fa9 : a5 59 __ LDA T3 + 1 
1fab : 6d 83 3d ADC $3d83 ; (i + 1)
1fae : 85 57 __ STA T2 + 1 
1fb0 : a0 00 __ LDY #$00
1fb2 : b1 56 __ LDA (T2 + 0),y 
1fb4 : 8d 8f 3d STA $3d8f ; (varattr + 0)
1fb7 : ad 82 3d LDA $3d82 ; (i + 0)
1fba : 18 __ __ CLC
1fbb : 69 01 __ ADC #$01
1fbd : 85 54 __ STA T1 + 0 
1fbf : 8d 82 3d STA $3d82 ; (i + 0)
1fc2 : ad 83 3d LDA $3d83 ; (i + 1)
1fc5 : 69 00 __ ADC #$00
1fc7 : 85 55 __ STA T1 + 1 
1fc9 : 8d 83 3d STA $3d83 ; (i + 1)
1fcc : 20 33 33 JSR $3333 ; (draw_roomobj.s1000 + 0)
1fcf : 4c 71 1b JMP $1b71 ; (adv_exec.s1289 + 0)
.s43:
1fd2 : ad 50 3d LDA $3d50 ; (roomimg + 0)
1fd5 : 85 58 __ STA T3 + 0 
1fd7 : ad 51 3d LDA $3d51 ; (roomimg + 1)
1fda : 85 59 __ STA T3 + 1 
1fdc : ac c4 3c LDY $3cc4 ; (room + 0)
1fdf : b1 58 __ LDA (T3 + 0),y 
1fe1 : cd 05 3d CMP $3d05 ; (curimageid + 0)
1fe4 : d0 03 __ BNE $1fe9 ; (adv_exec.s44 + 0)
1fe6 : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s44:
1fe9 : 85 53 __ STA T0 + 0 
1feb : 8d 07 3e STA $3e07 ; (imageid + 0)
1fee : 20 57 2c JSR $2c57 ; (ui_room_update.s0 + 0)
1ff1 : a5 53 __ LDA T0 + 0 
1ff3 : 8d 05 3d STA $3d05 ; (curimageid + 0)
1ff6 : 20 2f 31 JSR $312f ; (ui_status_update.s0 + 0)
1ff9 : 4c 08 1b JMP $1b08 ; (adv_exec.s552 + 0)
.s97:
1ffc : c9 83 __ CMP #$83
1ffe : d0 2b __ BNE $202b ; (adv_exec.s98 + 0)
.s42:
2000 : ad 2a 3d LDA $3d2a ; (freemem + 0)
2003 : 85 0d __ STA P0 
2005 : ad 2b 3d LDA $3d2b ; (freemem + 1)
2008 : 85 0e __ STA P1 
200a : ad 6e 3d LDA $3d6e ; (tmp + 0)
200d : 85 0f __ STA P2 
200f : ad 6f 3d LDA $3d6f ; (tmp + 1)
2012 : 85 10 __ STA P3 
2014 : 20 ca 2b JSR $2bca ; (mini_itoa.s0 + 0)
2017 : a5 0f __ LDA P2 
2019 : 85 13 __ STA P6 
201b : 8d 92 3d STA $3d92 ; (ostr + 0)
201e : a5 10 __ LDA P3 
2020 : 85 14 __ STA P7 
2022 : 8d 93 3d STA $3d93 ; (ostr + 1)
2025 : 20 63 24 JSR $2463 ; (ui_text_write.s0 + 0)
2028 : 4c 08 1b JMP $1b08 ; (adv_exec.s552 + 0)
.s98:
202b : b0 7c __ BCS $20a9 ; (adv_exec.s99 + 0)
.s100:
202d : c9 81 __ CMP #$81
202f : d0 03 __ BNE $2034 ; (adv_exec.s101 + 0)
2031 : 4c b7 1b JMP $1bb7 ; (adv_exec.s79 + 0)
.s101:
2034 : b0 6d __ BCS $20a3 ; (adv_exec.s47 + 0)
.s103:
2036 : c9 80 __ CMP #$80
2038 : f0 03 __ BEQ $203d ; (adv_exec.s75 + 0)
203a : 4c fe 1a JMP $1afe ; (adv_exec.s91 + 0)
.s75:
203d : c8 __ __ INY
203e : b1 43 __ LDA (T4 + 0),y 
2040 : 8d 84 3d STA $3d84 ; (varobj + 0)
2043 : 18 __ __ CLC
2044 : a5 54 __ LDA T1 + 0 
2046 : 69 02 __ ADC #$02
2048 : 85 54 __ STA T1 + 0 
204a : 8d 82 3d STA $3d82 ; (i + 0)
204d : a5 55 __ LDA T1 + 1 
204f : 69 00 __ ADC #$00
2051 : 85 55 __ STA T1 + 1 
2053 : 8d 83 3d STA $3d83 ; (i + 1)
2056 : ad 84 3d LDA $3d84 ; (varobj + 0)
2059 : 4a __ __ LSR
205a : 4a __ __ LSR
205b : 4a __ __ LSR
205c : 8d 86 3d STA $3d86 ; (var + 0)
205f : ad 84 3d LDA $3d84 ; (varobj + 0)
2062 : 29 07 __ AND #$07
2064 : aa __ __ TAX
2065 : ad 64 3d LDA $3d64 ; (bitvars + 0)
2068 : 18 __ __ CLC
2069 : 6d 86 3d ADC $3d86 ; (var + 0)
206c : 85 58 __ STA T3 + 0 
206e : ad 65 3d LDA $3d65 ; (bitvars + 1)
2071 : 69 00 __ ADC #$00
2073 : 85 59 __ STA T3 + 1 
2075 : 88 __ __ DEY
2076 : b1 58 __ LDA (T3 + 0),y 
2078 : 85 5a __ STA T5 + 0 
207a : 3d 14 3d AND $3d14,x ; (ormask + 0)
207d : 8d 8f 3d STA $3d8f ; (varattr + 0)
2080 : f0 03 __ BEQ $2085 ; (adv_exec.s76 + 0)
2082 : 4c 0f 16 JMP $160f ; (adv_exec.s666 + 0)
.s76:
2085 : bd 14 3d LDA $3d14,x ; (ormask + 0)
2088 : 05 5a __ ORA T5 + 0 
208a : 91 58 __ STA (T3 + 0),y 
208c : ad 66 3d LDA $3d66 ; (vars + 0)
208f : 85 56 __ STA T2 + 0 
2091 : ad 67 3d LDA $3d67 ; (vars + 1)
2094 : 85 57 __ STA T2 + 1 
2096 : b1 56 __ LDA (T2 + 0),y 
2098 : 18 __ __ CLC
2099 : 69 01 __ ADC #$01
209b : 91 56 __ STA (T2 + 0),y 
209d : 20 f9 31 JSR $31f9 ; (core_drawscore.s0 + 0)
20a0 : 4c 71 1b JMP $1b71 ; (adv_exec.s1289 + 0)
.s47:
20a3 : 20 4f 12 JSR $124f ; (ui_clear.s0 + 0)
20a6 : 4c 08 1b JMP $1b08 ; (adv_exec.s552 + 0)
.s99:
20a9 : c9 89 __ CMP #$89
20ab : d0 0c __ BNE $20b9 ; (adv_exec.s105 + 0)
.s48:
20ad : 20 ac 2a JSR $2aac ; (ui_getkey.l2 + 0)
20b0 : ad 88 3d LDA $3d88 ; (ch + 0)
20b3 : 8d 1a 3e STA $3e1a ; (key + 0)
20b6 : 4c 08 1b JMP $1b08 ; (adv_exec.s552 + 0)
.s105:
20b9 : b0 0a __ BCS $20c5 ; (adv_exec.s41 + 0)
.s107:
20bb : c9 84 __ CMP #$84
20bd : d0 03 __ BNE $20c2 ; (adv_exec.s107 + 7)
20bf : 4c b7 1b JMP $1bb7 ; (adv_exec.s79 + 0)
20c2 : 4c fe 1a JMP $1afe ; (adv_exec.s91 + 0)
.s41:
20c5 : c8 __ __ INY
20c6 : b1 43 __ LDA (T4 + 0),y 
20c8 : 8d 86 3d STA $3d86 ; (var + 0)
20cb : 8d 04 3d STA $3d04 ; (slowmode + 0)
.s668:
20ce : 18 __ __ CLC
20cf : a5 54 __ LDA T1 + 0 
20d1 : 69 02 __ ADC #$02
20d3 : 85 54 __ STA T1 + 0 
20d5 : 8d 82 3d STA $3d82 ; (i + 0)
20d8 : a5 55 __ LDA T1 + 1 
20da : 69 00 __ ADC #$00
20dc : 8d 83 3d STA $3d83 ; (i + 1)
20df : 4c 17 16 JMP $1617 ; (adv_exec.s1282 + 0)
--------------------------------------------------------------------
_alignattr: ; _alignattr()->void
.s0:
20e2 : ad c4 3c LDA $3cc4 ; (room + 0)
20e5 : 8d 78 3d STA $3d78 ; (varroom + 0)
20e8 : ad 81 3d LDA $3d81 ; (thisobj + 0)
20eb : 8d 84 3d STA $3d84 ; (varobj + 0)
.s1001:
20ee : 60 __ __ RTS
--------------------------------------------------------------------
_getobj: ; _getobj()->void
.s0:
20ef : ad 82 3d LDA $3d82 ; (i + 0)
20f2 : 85 43 __ STA T0 + 0 
20f4 : 18 __ __ CLC
20f5 : 69 01 __ ADC #$01
20f7 : 8d 82 3d STA $3d82 ; (i + 0)
20fa : ad 83 3d LDA $3d83 ; (i + 1)
20fd : 85 44 __ STA T0 + 1 
20ff : 69 00 __ ADC #$00
2101 : 8d 83 3d STA $3d83 ; (i + 1)
2104 : ad 7a 3d LDA $3d7a ; (pcode + 0)
2107 : 85 45 __ STA T1 + 0 
2109 : 18 __ __ CLC
210a : 65 43 __ ADC T0 + 0 
210c : 85 47 __ STA T2 + 0 
210e : ad 7b 3d LDA $3d7b ; (pcode + 1)
2111 : 85 46 __ STA T1 + 1 
2113 : 65 44 __ ADC T0 + 1 
2115 : 85 48 __ STA T2 + 1 
2117 : a0 00 __ LDY #$00
2119 : b1 47 __ LDA (T2 + 0),y 
211b : 8d 86 3d STA $3d86 ; (var + 0)
211e : c9 fb __ CMP #$fb
2120 : b0 03 __ BCS $2125 ; (_getobj.s12 + 0)
2122 : 4c b0 21 JMP $21b0 ; (_getobj.s14 + 0)
.s12:
2125 : c9 fd __ CMP #$fd
2127 : b0 55 __ BCS $217e ; (_getobj.s13 + 0)
.s5:
2129 : c8 __ __ INY
212a : b1 47 __ LDA (T2 + 0),y 
212c : 85 49 __ STA T3 + 0 
212e : 8d 88 3d STA $3d88 ; (ch + 0)
2131 : a5 43 __ LDA T0 + 0 
2133 : 69 02 __ ADC #$02
2135 : 85 43 __ STA T0 + 0 
2137 : 8d 82 3d STA $3d82 ; (i + 0)
213a : a5 44 __ LDA T0 + 1 
213c : 69 00 __ ADC #$00
213e : 85 44 __ STA T0 + 1 
2140 : 8d 83 3d STA $3d83 ; (i + 1)
2143 : 20 c2 21 JSR $21c2 ; (myrand.s0 + 0)
2146 : a5 49 __ LDA T3 + 0 
2148 : 85 03 __ STA WORK + 0 
214a : 18 __ __ CLC
214b : 65 43 __ ADC T0 + 0 
214d : 8d 82 3d STA $3d82 ; (i + 0)
2150 : a9 00 __ LDA #$00
2152 : 65 44 __ ADC T0 + 1 
2154 : 8d 83 3d STA $3d83 ; (i + 1)
2157 : 18 __ __ CLC
2158 : a5 45 __ LDA T1 + 0 
215a : 65 43 __ ADC T0 + 0 
215c : 85 43 __ STA T0 + 0 
215e : a5 46 __ LDA T1 + 1 
2160 : 65 44 __ ADC T0 + 1 
2162 : 85 44 __ STA T0 + 1 
2164 : ad ae 3c LDA $3cae ; (rnd_a + 0)
2167 : 85 1b __ STA ACCU + 0 
2169 : a9 00 __ LDA #$00
216b : 85 1c __ STA ACCU + 1 
216d : 85 04 __ STA WORK + 1 
216f : 20 28 3c JSR $3c28 ; (divmod + 0)
2172 : 18 __ __ CLC
2173 : a5 43 __ LDA T0 + 0 
2175 : 65 05 __ ADC WORK + 2 
2177 : 85 43 __ STA T0 + 0 
2179 : a5 44 __ LDA T0 + 1 
217b : 4c a4 21 JMP $21a4 ; (_getobj.s23 + 0)
.s13:
217e : d0 06 __ BNE $2186 ; (_getobj.s18 + 0)
.s3:
2180 : ad 87 3d LDA $3d87 ; (obj2 + 0)
2183 : 4c ac 21 JMP $21ac ; (_getobj.s1016 + 0)
.s18:
2186 : c9 fe __ CMP #$fe
2188 : d0 06 __ BNE $2190 ; (_getobj.s8 + 0)
.s2:
218a : ad 76 3d LDA $3d76 ; (obj1 + 0)
218d : 4c ac 21 JMP $21ac ; (_getobj.s1016 + 0)
.s8:
2190 : ad 85 3d LDA $3d85 ; (varmode + 0)
2193 : f0 1a __ BEQ $21af ; (_getobj.s1001 + 0)
.s9:
2195 : 8c 85 3d STY $3d85 ; (varmode + 0)
2198 : ad 66 3d LDA $3d66 ; (vars + 0)
219b : 18 __ __ CLC
219c : 6d 86 3d ADC $3d86 ; (var + 0)
219f : 85 43 __ STA T0 + 0 
21a1 : ad 67 3d LDA $3d67 ; (vars + 1)
.s23:
21a4 : 69 00 __ ADC #$00
21a6 : 85 44 __ STA T0 + 1 
21a8 : a0 00 __ LDY #$00
21aa : b1 43 __ LDA (T0 + 0),y 
.s1016:
21ac : 8d 86 3d STA $3d86 ; (var + 0)
.s1001:
21af : 60 __ __ RTS
.s14:
21b0 : c9 f3 __ CMP #$f3
21b2 : 90 04 __ BCC $21b8 ; (_getobj.s15 + 0)
.s16:
21b4 : c9 f5 __ CMP #$f5
21b6 : 90 f7 __ BCC $21af ; (_getobj.s1001 + 0)
.s15:
21b8 : c9 f7 __ CMP #$f7
21ba : d0 d4 __ BNE $2190 ; (_getobj.s8 + 0)
.s4:
21bc : ad c4 3c LDA $3cc4 ; (room + 0)
21bf : 4c ac 21 JMP $21ac ; (_getobj.s1016 + 0)
--------------------------------------------------------------------
myrand: ; myrand()->void
.s0:
21c2 : ad ae 3c LDA $3cae ; (rnd_a + 0)
21c5 : f0 05 __ BEQ $21cc ; (myrand.s0 + 10)
21c7 : 0a __ __ ASL
21c8 : f0 04 __ BEQ $21ce ; (myrand.s0 + 12)
21ca : 90 02 __ BCC $21ce ; (myrand.s0 + 12)
21cc : 49 1d __ EOR #$1d
21ce : 8d ae 3c STA $3cae ; (rnd_a + 0)
.s1001:
21d1 : 60 __ __ RTS
--------------------------------------------------------------------
_getattrstrid: ; _getattrstrid()->void
.s0:
21d2 : a9 ff __ LDA #$ff
21d4 : 8d 89 3d STA $3d89 ; (strid + 0)
21d7 : ad 82 3d LDA $3d82 ; (i + 0)
21da : 85 1b __ STA ACCU + 0 
21dc : 18 __ __ CLC
21dd : 69 01 __ ADC #$01
21df : 8d 82 3d STA $3d82 ; (i + 0)
21e2 : ad 83 3d LDA $3d83 ; (i + 1)
21e5 : aa __ __ TAX
21e6 : 69 00 __ ADC #$00
21e8 : 8d 83 3d STA $3d83 ; (i + 1)
21eb : ad 7a 3d LDA $3d7a ; (pcode + 0)
21ee : 18 __ __ CLC
21ef : 65 1b __ ADC ACCU + 0 
21f1 : 85 1b __ STA ACCU + 0 
21f3 : 8a __ __ TXA
21f4 : 6d 7b 3d ADC $3d7b ; (pcode + 1)
21f7 : 85 1c __ STA ACCU + 1 
21f9 : a0 00 __ LDY #$00
21fb : b1 1b __ LDA (ACCU + 0),y 
21fd : 8d 86 3d STA $3d86 ; (var + 0)
2200 : 85 1b __ STA ACCU + 0 
2202 : 29 3f __ AND #$3f
2204 : d0 03 __ BNE $2209 ; (_getattrstrid.s46 + 0)
2206 : 4c 67 23 JMP $2367 ; (_getattrstrid.s2 + 0)
.s46:
2209 : c9 01 __ CMP #$01
220b : d0 03 __ BNE $2210 ; (_getattrstrid.s11 + 0)
220d : 4c 39 23 JMP $2339 ; (_getattrstrid.s6 + 0)
.s11:
2210 : aa __ __ TAX
2211 : 06 1b __ ASL ACCU + 0 
2213 : 30 0e __ BMI $2223 ; (_getattrstrid.s12 + 0)
.s13:
2215 : ad 62 3d LDA $3d62 ; (roomattrex + 0)
2218 : 85 1b __ STA ACCU + 0 
221a : ad 78 3d LDA $3d78 ; (varroom + 0)
221d : ac 63 3d LDY $3d63 ; (roomattrex + 1)
2220 : 4c 2e 22 JMP $222e ; (_getattrstrid.s1014 + 0)
.s12:
2223 : ad 5c 3d LDA $3d5c ; (objattrex + 0)
2226 : 85 1b __ STA ACCU + 0 
2228 : ad 84 3d LDA $3d84 ; (varobj + 0)
222b : ac 5d 3d LDY $3d5d ; (objattrex + 1)
.s1014:
222e : 8c 8e 3d STY $3d8e ; (txt + 1)
2231 : 8d 85 3d STA $3d85 ; (varmode + 0)
2234 : a5 1b __ LDA ACCU + 0 
2236 : 8d 8d 3d STA $3d8d ; (txt + 0)
2239 : 98 __ __ TYA
223a : 05 1b __ ORA ACCU + 0 
223c : d0 03 __ BNE $2241 ; (_getattrstrid.s16 + 0)
223e : 4c 33 23 JMP $2333 ; (_getattrstrid.s15 + 0)
.s16:
2241 : 8e 8f 3d STX $3d8f ; (varattr + 0)
.l19:
2244 : ad 8d 3d LDA $3d8d ; (txt + 0)
2247 : 85 1b __ STA ACCU + 0 
2249 : 18 __ __ CLC
224a : 69 01 __ ADC #$01
224c : 8d 8d 3d STA $3d8d ; (txt + 0)
224f : ad 8e 3d LDA $3d8e ; (txt + 1)
2252 : 85 1c __ STA ACCU + 1 
2254 : 69 00 __ ADC #$00
2256 : 8d 8e 3d STA $3d8e ; (txt + 1)
2259 : a0 00 __ LDY #$00
225b : b1 1b __ LDA (ACCU + 0),y 
225d : 8d 90 3d STA $3d90 ; (a + 0)
2260 : c9 ff __ CMP #$ff
2262 : d0 03 __ BNE $2267 ; (_getattrstrid.s23 + 0)
2264 : 4c 00 23 JMP $2300 ; (_getattrstrid.s20 + 0)
.s23:
2267 : 85 1d __ STA ACCU + 2 
2269 : 18 __ __ CLC
226a : a5 1b __ LDA ACCU + 0 
226c : 69 02 __ ADC #$02
226e : 85 43 __ STA T1 + 0 
2270 : a5 1c __ LDA ACCU + 1 
2272 : 69 00 __ ADC #$00
2274 : aa __ __ TAX
2275 : a5 1d __ LDA ACCU + 2 
2277 : 29 7f __ AND #$7f
2279 : cd 8f 3d CMP $3d8f ; (varattr + 0)
227c : f0 25 __ BEQ $22a3 ; (_getattrstrid.s25 + 0)
.s26:
227e : c8 __ __ INY
227f : b1 1b __ LDA (ACCU + 0),y 
2281 : 85 1b __ STA ACCU + 0 
2283 : 18 __ __ CLC
2284 : 65 43 __ ADC T1 + 0 
2286 : 90 01 __ BCC $2289 ; (_getattrstrid.s1023 + 0)
.s1022:
2288 : e8 __ __ INX
.s1023:
2289 : 24 1d __ BIT ACCU + 2 
228b : 30 0c __ BMI $2299 ; (_getattrstrid.s40 + 0)
.s41:
228d : 18 __ __ CLC
228e : 65 1b __ ADC ACCU + 0 
2290 : 8d 8d 3d STA $3d8d ; (txt + 0)
2293 : 8a __ __ TXA
2294 : 69 00 __ ADC #$00
2296 : 4c 9d 22 JMP $229d ; (_getattrstrid.s1017 + 0)
.s40:
2299 : 8d 8d 3d STA $3d8d ; (txt + 0)
229c : 8a __ __ TXA
.s1017:
229d : 8d 8e 3d STA $3d8e ; (txt + 1)
22a0 : 4c 44 22 JMP $2244 ; (_getattrstrid.l19 + 0)
.s25:
22a3 : 8e 8e 3d STX $3d8e ; (txt + 1)
22a6 : a5 43 __ LDA T1 + 0 
22a8 : 8d 8d 3d STA $3d8d ; (txt + 0)
22ab : a5 1d __ LDA ACCU + 2 
22ad : 10 0d __ BPL $22bc ; (_getattrstrid.s29 + 0)
.s28:
22af : 86 44 __ STX T1 + 1 
22b1 : ac 85 3d LDY $3d85 ; (varmode + 0)
22b4 : b1 43 __ LDA (T1 + 0),y 
22b6 : 8d 89 3d STA $3d89 ; (strid + 0)
22b9 : 4c 05 23 JMP $2305 ; (_getattrstrid.s108 + 0)
.s29:
22bc : 18 __ __ CLC
22bd : 69 ff __ ADC #$ff
22bf : 8d 90 3d STA $3d90 ; (a + 0)
22c2 : a5 1d __ LDA ACCU + 2 
22c4 : f0 3a __ BEQ $2300 ; (_getattrstrid.s20 + 0)
.s48:
22c6 : ae 85 3d LDX $3d85 ; (varmode + 0)
.l33:
22c9 : ad 8d 3d LDA $3d8d ; (txt + 0)
22cc : 85 1b __ STA ACCU + 0 
22ce : ad 8e 3d LDA $3d8e ; (txt + 1)
22d1 : 85 1c __ STA ACCU + 1 
22d3 : a0 01 __ LDY #$01
22d5 : b1 1b __ LDA (ACCU + 0),y 
22d7 : 85 1d __ STA ACCU + 2 
22d9 : 88 __ __ DEY
22da : b1 1b __ LDA (ACCU + 0),y 
22dc : 85 1e __ STA ACCU + 3 
22de : 8d 90 3d STA $3d90 ; (a + 0)
22e1 : 18 __ __ CLC
22e2 : a5 1b __ LDA ACCU + 0 
22e4 : 69 02 __ ADC #$02
22e6 : 8d 8d 3d STA $3d8d ; (txt + 0)
22e9 : a5 1c __ LDA ACCU + 1 
22eb : 69 00 __ ADC #$00
22ed : 8d 8e 3d STA $3d8e ; (txt + 1)
22f0 : e4 1e __ CPX ACCU + 3 
22f2 : f0 2e __ BEQ $2322 ; (_getattrstrid.s35 + 0)
.s32:
22f4 : 18 __ __ CLC
22f5 : a5 1e __ LDA ACCU + 3 
22f7 : 69 ff __ ADC #$ff
22f9 : 8d 90 3d STA $3d90 ; (a + 0)
22fc : a5 1e __ LDA ACCU + 3 
22fe : d0 c9 __ BNE $22c9 ; (_getattrstrid.l33 + 0)
.s20:
2300 : ad 90 3d LDA $3d90 ; (a + 0)
2303 : 85 1d __ STA ACCU + 2 
.s108:
2305 : a9 00 __ LDA #$00
2307 : 8d 85 3d STA $3d85 ; (varmode + 0)
230a : a5 1d __ LDA ACCU + 2 
230c : c9 ff __ CMP #$ff
230e : f0 11 __ BEQ $2321 ; (_getattrstrid.s1001 + 0)
.s43:
2310 : a9 01 __ LDA #$01
2312 : 8d 8c 3d STA $3d8c ; (text_continue + 0)
2315 : ad 32 3d LDA $3d32 ; (advdesc + 0)
2318 : 8d 8a 3d STA $3d8a ; (str + 0)
231b : ad 33 3d LDA $3d33 ; (advdesc + 1)
231e : 8d 8b 3d STA $3d8b ; (str + 1)
.s1001:
2321 : 60 __ __ RTS
.s35:
2322 : 8c 85 3d STY $3d85 ; (varmode + 0)
2325 : a5 1d __ LDA ACCU + 2 
2327 : 8d 89 3d STA $3d89 ; (strid + 0)
232a : a5 1e __ LDA ACCU + 3 
232c : c9 ff __ CMP #$ff
232e : f0 f1 __ BEQ $2321 ; (_getattrstrid.s1001 + 0)
2330 : 4c 10 23 JMP $2310 ; (_getattrstrid.s43 + 0)
.s15:
2333 : a9 ff __ LDA #$ff
.s1016:
2335 : 8d 89 3d STA $3d89 ; (strid + 0)
2338 : 60 __ __ RTS
.s6:
2339 : ad 32 3d LDA $3d32 ; (advdesc + 0)
233c : 8d 8a 3d STA $3d8a ; (str + 0)
233f : ad 33 3d LDA $3d33 ; (advdesc + 1)
2342 : 8d 8b 3d STA $3d8b ; (str + 1)
2345 : 06 1b __ ASL ACCU + 0 
2347 : 30 12 __ BMI $235b ; (_getattrstrid.s7 + 0)
.s8:
2349 : ad 4f 3d LDA $3d4f ; (roomdescid + 1)
234c : ae 4e 3d LDX $3d4e ; (roomdescid + 0)
.s1019:
234f : ac 78 3d LDY $3d78 ; (varroom + 0)
.s98:
2352 : 86 43 __ STX T1 + 0 
2354 : 85 44 __ STA T1 + 1 
2356 : b1 43 __ LDA (T1 + 0),y 
2358 : 4c 35 23 JMP $2335 ; (_getattrstrid.s1016 + 0)
.s7:
235b : ad 57 3d LDA $3d57 ; (objdescid + 1)
235e : ae 56 3d LDX $3d56 ; (objdescid + 0)
.s1018:
2361 : ac 84 3d LDY $3d84 ; (varobj + 0)
2364 : 4c 52 23 JMP $2352 ; (_getattrstrid.s98 + 0)
.s2:
2367 : a9 01 __ LDA #$01
2369 : 8d 8c 3d STA $3d8c ; (text_continue + 0)
236c : ad 30 3d LDA $3d30 ; (advnames + 0)
236f : 8d 8a 3d STA $3d8a ; (str + 0)
2372 : ad 31 3d LDA $3d31 ; (advnames + 1)
2375 : 8d 8b 3d STA $3d8b ; (str + 1)
2378 : 06 1b __ ASL ACCU + 0 
237a : 10 09 __ BPL $2385 ; (_getattrstrid.s4 + 0)
.s3:
237c : ad 55 3d LDA $3d55 ; (objnameid + 1)
237f : ae 54 3d LDX $3d54 ; (objnameid + 0)
2382 : 4c 61 23 JMP $2361 ; (_getattrstrid.s1018 + 0)
.s4:
2385 : ad 4d 3d LDA $3d4d ; (roomnameid + 1)
2388 : ae 4c 3d LDX $3d4c ; (roomnameid + 0)
238b : 4c 4f 23 JMP $234f ; (_getattrstrid.s1019 + 0)
--------------------------------------------------------------------
_getstring: ; _getstring()->void
.s0:
238e : a9 00 __ LDA #$00
2390 : 8d 91 3d STA $3d91 ; (_strid + 0)
2393 : ad 8a 3d LDA $3d8a ; (str + 0)
2396 : 8d 92 3d STA $3d92 ; (ostr + 0)
2399 : ad 8b 3d LDA $3d8b ; (str + 1)
239c : 8d 93 3d STA $3d93 ; (ostr + 1)
239f : ad 89 3d LDA $3d89 ; (strid + 0)
23a2 : 85 1d __ STA ACCU + 2 
23a4 : f0 5a __ BEQ $2400 ; (_getstring.s3 + 0)
.l2:
23a6 : ad 8a 3d LDA $3d8a ; (str + 0)
23a9 : 85 1b __ STA ACCU + 0 
23ab : 18 __ __ CLC
23ac : 69 01 __ ADC #$01
23ae : 8d 8a 3d STA $3d8a ; (str + 0)
23b1 : ad 8b 3d LDA $3d8b ; (str + 1)
23b4 : 85 1c __ STA ACCU + 1 
23b6 : 69 00 __ ADC #$00
23b8 : 8d 8b 3d STA $3d8b ; (str + 1)
23bb : a0 00 __ LDY #$00
23bd : b1 1b __ LDA (ACCU + 0),y 
23bf : 8d 94 3d STA $3d94 ; (len + 0)
23c2 : ee 91 3d INC $3d91 ; (_strid + 0)
23c5 : c9 ff __ CMP #$ff
23c7 : d0 15 __ BNE $23de ; (_getstring.s6 + 0)
.s4:
23c9 : c8 __ __ INY
23ca : b1 1b __ LDA (ACCU + 0),y 
23cc : 8d 94 3d STA $3d94 ; (len + 0)
23cf : 18 __ __ CLC
23d0 : a5 1b __ LDA ACCU + 0 
23d2 : 69 01 __ ADC #$01
23d4 : 8d 8a 3d STA $3d8a ; (str + 0)
23d7 : a5 1c __ LDA ACCU + 1 
23d9 : 69 01 __ ADC #$01
23db : 8d 8b 3d STA $3d8b ; (str + 1)
.s6:
23de : ad 8a 3d LDA $3d8a ; (str + 0)
23e1 : 18 __ __ CLC
23e2 : 6d 94 3d ADC $3d94 ; (len + 0)
23e5 : 8d 8a 3d STA $3d8a ; (str + 0)
23e8 : 90 03 __ BCC $23ed ; (_getstring.s1009 + 0)
.s1008:
23ea : ee 8b 3d INC $3d8b ; (str + 1)
.s1009:
23ed : ad 8a 3d LDA $3d8a ; (str + 0)
23f0 : 8d 92 3d STA $3d92 ; (ostr + 0)
23f3 : ad 8b 3d LDA $3d8b ; (str + 1)
23f6 : 8d 93 3d STA $3d93 ; (ostr + 1)
23f9 : ad 91 3d LDA $3d91 ; (_strid + 0)
23fc : c5 1d __ CMP ACCU + 2 
23fe : 90 a6 __ BCC $23a6 ; (_getstring.l2 + 0)
.s3:
2400 : ad 92 3d LDA $3d92 ; (ostr + 0)
2403 : 85 1b __ STA ACCU + 0 
2405 : 18 __ __ CLC
2406 : 69 01 __ ADC #$01
2408 : 8d 92 3d STA $3d92 ; (ostr + 0)
240b : ad 93 3d LDA $3d93 ; (ostr + 1)
240e : 85 1c __ STA ACCU + 1 
2410 : 69 00 __ ADC #$00
2412 : 8d 93 3d STA $3d93 ; (ostr + 1)
2415 : a0 00 __ LDY #$00
2417 : b1 1b __ LDA (ACCU + 0),y 
2419 : 8d 94 3d STA $3d94 ; (len + 0)
241c : 18 __ __ CLC
241d : 6d 92 3d ADC $3d92 ; (ostr + 0)
2420 : 8d 95 3d STA $3d95 ; (etxt + 0)
2423 : ad 93 3d LDA $3d93 ; (ostr + 1)
2426 : 69 00 __ ADC #$00
2428 : 8d 96 3d STA $3d96 ; (etxt + 1)
242b : ad 94 3d LDA $3d94 ; (len + 0)
242e : c9 ff __ CMP #$ff
2430 : d0 30 __ BNE $2462 ; (_getstring.s1001 + 0)
.s7:
2432 : c8 __ __ INY
2433 : b1 1b __ LDA (ACCU + 0),y 
2435 : 8d 94 3d STA $3d94 ; (len + 0)
2438 : 18 __ __ CLC
2439 : a5 1b __ LDA ACCU + 0 
243b : 69 02 __ ADC #$02
243d : 8d 92 3d STA $3d92 ; (ostr + 0)
2440 : a5 1c __ LDA ACCU + 1 
2442 : 69 00 __ ADC #$00
2444 : 8d 93 3d STA $3d93 ; (ostr + 1)
2447 : ad 95 3d LDA $3d95 ; (etxt + 0)
244a : 18 __ __ CLC
244b : 6d 94 3d ADC $3d94 ; (len + 0)
244e : aa __ __ TAX
244f : ad 96 3d LDA $3d96 ; (etxt + 1)
2452 : 69 00 __ ADC #$00
2454 : a8 __ __ TAY
2455 : 8a __ __ TXA
2456 : 18 __ __ CLC
2457 : 69 01 __ ADC #$01
2459 : 8d 95 3d STA $3d95 ; (etxt + 0)
245c : 90 01 __ BCC $245f ; (_getstring.s1011 + 0)
.s1010:
245e : c8 __ __ INY
.s1011:
245f : 8c 96 3d STY $3d96 ; (etxt + 1)
.s1001:
2462 : 60 __ __ RTS
--------------------------------------------------------------------
ui_text_write: ; ui_text_write(u8*)->void
.s0:
2463 : a9 01 __ LDA #$01
2465 : 8d 97 3d STA $3d97 ; (txt_col + 0)
2468 : a5 13 __ LDA P6 ; (text + 0)
246a : 8d 8d 3d STA $3d8d ; (txt + 0)
246d : a5 14 __ LDA P7 ; (text + 1)
246f : 8d 8e 3d STA $3d8e ; (txt + 1)
2472 : ad 98 3d LDA $3d98 ; (text_attach + 0)
2475 : f0 07 __ BEQ $247e ; (ui_text_write.s2 + 0)
.s1:
2477 : a9 00 __ LDA #$00
2479 : 8d 98 3d STA $3d98 ; (text_attach + 0)
247c : f0 15 __ BEQ $2493 ; (ui_text_write.l5 + 0)
.s2:
247e : 8d 99 3d STA $3d99 ; (txt_rev + 0)
2481 : 8d 9a 3d STA $3d9a ; (txt_x + 0)
2484 : ad c3 3c LDA $3cc3 ; (text_y + 0)
2487 : 18 __ __ CLC
2488 : 69 0e __ ADC #$0e
248a : 8d 9b 3d STA $3d9b ; (txt_y + 0)
248d : 4c 93 24 JMP $2493 ; (ui_text_write.l5 + 0)
.s8:
2490 : 20 55 2a JSR $2a55 ; (ui_waitkey.s0 + 0)
.l5:
2493 : 20 e7 24 JSR $24e7 ; (core_drawtext.l130 + 0)
2496 : ad 9c 3d LDA $3d9c ; (_ch + 0)
2499 : d0 f5 __ BNE $2490 ; (ui_text_write.s8 + 0)
.s7:
249b : ad 8d 3d LDA $3d8d ; (txt + 0)
249e : 85 1f __ STA ADDR + 0 
24a0 : ad 8e 3d LDA $3d8e ; (txt + 1)
24a3 : 18 __ __ CLC
24a4 : 69 ff __ ADC #$ff
24a6 : 85 20 __ STA ADDR + 1 
24a8 : a0 ff __ LDY #$ff
24aa : b1 1f __ LDA (ADDR + 0),y 
24ac : c9 2b __ CMP #$2b
24ae : f0 21 __ BEQ $24d1 ; (ui_text_write.s10 + 0)
.s11:
24b0 : ad 8c 3d LDA $3d8c ; (text_continue + 0)
24b3 : f0 07 __ BEQ $24bc ; (ui_text_write.s17 + 0)
.s16:
24b5 : a9 01 __ LDA #$01
24b7 : 8d 98 3d STA $3d98 ; (text_attach + 0)
24ba : d0 0c __ BNE $24c8 ; (ui_text_write.s1004 + 0)
.s17:
24bc : ad 9b 3d LDA $3d9b ; (txt_y + 0)
24bf : 38 __ __ SEC
24c0 : e9 0e __ SBC #$0e
24c2 : 8d c3 3c STA $3cc3 ; (text_y + 0)
24c5 : 20 38 2a JSR $2a38 ; (cr.l30 + 0)
.s1004:
24c8 : a9 00 __ LDA #$00
24ca : 8d 8c 3d STA $3d8c ; (text_continue + 0)
24cd : ee 73 3d INC $3d73 ; (al + 0)
.s1001:
24d0 : 60 __ __ RTS
.s10:
24d1 : a9 01 __ LDA #$01
24d3 : 8d 98 3d STA $3d98 ; (text_attach + 0)
24d6 : a9 00 __ LDA #$00
24d8 : 8d 8c 3d STA $3d8c ; (text_continue + 0)
24db : ee 73 3d INC $3d73 ; (al + 0)
24de : ad 9a 3d LDA $3d9a ; (txt_x + 0)
24e1 : f0 ed __ BEQ $24d0 ; (ui_text_write.s1001 + 0)
.s13:
24e3 : ce 9a 3d DEC $3d9a ; (txt_x + 0)
24e6 : 60 __ __ RTS
--------------------------------------------------------------------
core_drawtext: ; core_drawtext()->void
.l130:
24e7 : 20 4e 27 JSR $274e ; (_getnextch.s0 + 0)
24ea : ad 9c 3d LDA $3d9c ; (_ch + 0)
24ed : f0 0d __ BEQ $24fc ; (core_drawtext.s1001 + 0)
.l2:
24ef : ad 73 3d LDA $3d73 ; (al + 0)
24f2 : c9 0a __ CMP #$0a
24f4 : ad 9c 3d LDA $3d9c ; (_ch + 0)
24f7 : 90 04 __ BCC $24fd ; (core_drawtext.s6 + 0)
.s4:
24f9 : 8d 9d 3d STA $3d9d ; (_ech + 0)
.s1001:
24fc : 60 __ __ RTS
.s6:
24fd : c9 1f __ CMP #$1f
24ff : d0 06 __ BNE $2507 ; (core_drawtext.s9 + 0)
.s8:
2501 : 20 65 28 JSR $2865 ; (core_cr.l34 + 0)
2504 : 4c e7 24 JMP $24e7 ; (core_drawtext.l130 + 0)
.s9:
2507 : a9 00 __ LDA #$00
2509 : 8d f9 3c STA $3cf9 ; (align + 0)
250c : 8d fa 3c STA $3cfa ; (align + 1)
250f : 8d a2 3d STA $3da2 ; (ll + 0)
2512 : 8d a3 3d STA $3da3 ; (ll + 1)
2515 : 8d a4 3d STA $3da4 ; (spl + 0)
2518 : 8d a5 3d STA $3da5 ; (spl + 1)
251b : ad 9c 3d LDA $3d9c ; (_ch + 0)
251e : f0 5f __ BEQ $257f ; (core_drawtext.s13 + 0)
.l15:
2520 : ad a2 3d LDA $3da2 ; (ll + 0)
2523 : 85 4c __ STA T3 + 0 
2525 : 18 __ __ CLC
2526 : 6d 9a 3d ADC $3d9a ; (txt_x + 0)
2529 : aa __ __ TAX
252a : ad a3 3d LDA $3da3 ; (ll + 1)
252d : 85 4d __ STA T3 + 1 
252f : 69 00 __ ADC #$00
2531 : d0 4c __ BNE $257f ; (core_drawtext.s13 + 0)
.s1036:
2533 : e0 28 __ CPX #$28
2535 : b0 48 __ BCS $257f ; (core_drawtext.s13 + 0)
.s14:
2537 : ad 9c 3d LDA $3d9c ; (_ch + 0)
253a : c9 1f __ CMP #$1f
253c : f0 41 __ BEQ $257f ; (core_drawtext.s13 + 0)
.s12:
253e : c9 5c __ CMP #$5c
2540 : d0 03 __ BNE $2545 ; (core_drawtext.s17 + 0)
2542 : 4c 91 26 JMP $2691 ; (core_drawtext.s16 + 0)
.s17:
2545 : 85 49 __ STA T0 + 0 
2547 : c9 20 __ CMP #$20
2549 : d0 0d __ BNE $2558 ; (core_drawtext.s51 + 0)
.s49:
254b : a5 4c __ LDA T3 + 0 
254d : 8d a4 3d STA $3da4 ; (spl + 0)
2550 : a5 4d __ LDA T3 + 1 
2552 : 8d a5 3d STA $3da5 ; (spl + 1)
2555 : 20 ee 29 JSR $29ee ; (_savechpos.s0 + 0)
.s51:
2558 : ad 99 3d LDA $3d99 ; (txt_rev + 0)
255b : 18 __ __ CLC
255c : 65 49 __ ADC T0 + 0 
255e : a6 4c __ LDX T3 + 0 
2560 : 9d a8 3d STA $3da8,x ; (_buffer + 0)
2563 : ad 97 3d LDA $3d97 ; (txt_col + 0)
2566 : 9d d2 3d STA $3dd2,x ; (_cbuffer + 0)
2569 : 8a __ __ TXA
256a : 18 __ __ CLC
256b : 69 01 __ ADC #$01
256d : 8d a2 3d STA $3da2 ; (ll + 0)
2570 : a5 4d __ LDA T3 + 1 
2572 : 69 00 __ ADC #$00
2574 : 8d a3 3d STA $3da3 ; (ll + 1)
.s115:
2577 : 20 4e 27 JSR $274e ; (_getnextch.s0 + 0)
257a : ad 9c 3d LDA $3d9c ; (_ch + 0)
257d : d0 a1 __ BNE $2520 ; (core_drawtext.l15 + 0)
.s13:
257f : ad 9a 3d LDA $3d9a ; (txt_x + 0)
2582 : 85 4a __ STA T2 + 0 
2584 : 18 __ __ CLC
2585 : 6d a2 3d ADC $3da2 ; (ll + 0)
2588 : aa __ __ TAX
2589 : ad a3 3d LDA $3da3 ; (ll + 1)
258c : 69 00 __ ADC #$00
258e : 85 4d __ STA T3 + 1 
2590 : d0 0d __ BNE $259f ; (core_drawtext.s53 + 0)
.s1007:
2592 : e0 28 __ CPX #$28
2594 : d0 09 __ BNE $259f ; (core_drawtext.s53 + 0)
.s55:
2596 : ad 9c 3d LDA $3d9c ; (_ch + 0)
2599 : f0 1e __ BEQ $25b9 ; (core_drawtext.s118 + 0)
.s56:
259b : c9 20 __ CMP #$20
259d : f0 1a __ BEQ $25b9 ; (core_drawtext.s118 + 0)
.s53:
259f : a5 4d __ LDA T3 + 1 
25a1 : d0 04 __ BNE $25a7 ; (core_drawtext.s57 + 0)
.s1004:
25a3 : e0 28 __ CPX #$28
25a5 : 90 12 __ BCC $25b9 ; (core_drawtext.s118 + 0)
.s57:
25a7 : 20 13 2a JSR $2a13 ; (_restorechpos.s0 + 0)
25aa : ad a4 3d LDA $3da4 ; (spl + 0)
25ad : 8d a2 3d STA $3da2 ; (ll + 0)
25b0 : ad a5 3d LDA $3da5 ; (spl + 1)
25b3 : 8d a3 3d STA $3da3 ; (ll + 1)
25b6 : 20 4e 27 JSR $274e ; (_getnextch.s0 + 0)
.s118:
25b9 : ad fa 3c LDA $3cfa ; (align + 1)
25bc : d0 36 __ BNE $25f4 ; (core_drawtext.s60 + 0)
.s1003:
25be : ad f9 3c LDA $3cf9 ; (align + 0)
25c1 : c9 01 __ CMP #$01
25c3 : d0 0b __ BNE $25d0 ; (core_drawtext.s64 + 0)
.s62:
25c5 : 38 __ __ SEC
25c6 : a9 28 __ LDA #$28
25c8 : ed a2 3d SBC $3da2 ; (ll + 0)
25cb : 85 4c __ STA T3 + 0 
25cd : 4c ec 25 JMP $25ec ; (core_drawtext.s129 + 0)
.s64:
25d0 : ad fa 3c LDA $3cfa ; (align + 1)
25d3 : d0 1f __ BNE $25f4 ; (core_drawtext.s60 + 0)
.s1002:
25d5 : ad f9 3c LDA $3cf9 ; (align + 0)
25d8 : c9 02 __ CMP #$02
25da : d0 18 __ BNE $25f4 ; (core_drawtext.s60 + 0)
.s61:
25dc : 38 __ __ SEC
25dd : a9 28 __ LDA #$28
25df : ed a2 3d SBC $3da2 ; (ll + 0)
25e2 : 85 4c __ STA T3 + 0 
25e4 : a9 00 __ LDA #$00
25e6 : ed a3 3d SBC $3da3 ; (ll + 1)
25e9 : 4a __ __ LSR
25ea : 66 4c __ ROR T3 + 0 
.s129:
25ec : 18 __ __ CLC
25ed : a5 4c __ LDA T3 + 0 
25ef : 65 4a __ ADC T2 + 0 
25f1 : 8d 9a 3d STA $3d9a ; (txt_x + 0)
.s60:
25f4 : ad 9b 3d LDA $3d9b ; (txt_y + 0)
25f7 : 0a __ __ ASL
25f8 : 85 1b __ STA ACCU + 0 
25fa : a9 00 __ LDA #$00
25fc : 2a __ __ ROL
25fd : 06 1b __ ASL ACCU + 0 
25ff : 2a __ __ ROL
2600 : aa __ __ TAX
2601 : a5 1b __ LDA ACCU + 0 
2603 : 6d 9b 3d ADC $3d9b ; (txt_y + 0)
2606 : 85 4a __ STA T2 + 0 
2608 : 8a __ __ TXA
2609 : 69 00 __ ADC #$00
260b : 06 4a __ ASL T2 + 0 
260d : 2a __ __ ROL
260e : 06 4a __ ASL T2 + 0 
2610 : 2a __ __ ROL
2611 : 06 4a __ ASL T2 + 0 
2613 : 2a __ __ ROL
2614 : 85 4b __ STA T2 + 1 
2616 : ad 9a 3d LDA $3d9a ; (txt_x + 0)
2619 : 85 4e __ STA T4 + 0 
261b : ad af 3c LDA $3caf ; (video_ram + 0)
261e : 18 __ __ CLC
261f : 65 4a __ ADC T2 + 0 
2621 : aa __ __ TAX
2622 : ad b0 3c LDA $3cb0 ; (video_ram + 1)
2625 : 65 4b __ ADC T2 + 1 
2627 : a8 __ __ TAY
2628 : 8a __ __ TXA
2629 : 18 __ __ CLC
262a : 65 4e __ ADC T4 + 0 
262c : 85 0d __ STA P0 
262e : 90 01 __ BCC $2631 ; (core_drawtext.s1045 + 0)
.s1044:
2630 : c8 __ __ INY
.s1045:
2631 : 84 0e __ STY P1 
2633 : a9 a8 __ LDA #$a8
2635 : 85 0f __ STA P2 
2637 : a9 3d __ LDA #$3d
2639 : 85 10 __ STA P3 
263b : ad a2 3d LDA $3da2 ; (ll + 0)
263e : 85 4c __ STA T3 + 0 
2640 : 85 11 __ STA P4 
2642 : ad a3 3d LDA $3da3 ; (ll + 1)
2645 : 85 4d __ STA T3 + 1 
2647 : 85 12 __ STA P5 
2649 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
264c : a5 4c __ LDA T3 + 0 
264e : 85 11 __ STA P4 
2650 : a5 4d __ LDA T3 + 1 
2652 : 85 12 __ STA P5 
2654 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
2657 : 18 __ __ CLC
2658 : 65 4a __ ADC T2 + 0 
265a : aa __ __ TAX
265b : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
265e : 65 4b __ ADC T2 + 1 
2660 : a8 __ __ TAY
2661 : 8a __ __ TXA
2662 : 18 __ __ CLC
2663 : 65 4e __ ADC T4 + 0 
2665 : 85 0d __ STA P0 
2667 : 90 01 __ BCC $266a ; (core_drawtext.s1047 + 0)
.s1046:
2669 : c8 __ __ INY
.s1047:
266a : 84 0e __ STY P1 
266c : a9 d2 __ LDA #$d2
266e : 85 0f __ STA P2 
2670 : a9 3d __ LDA #$3d
2672 : 85 10 __ STA P3 
2674 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
2677 : 18 __ __ CLC
2678 : a5 4c __ LDA T3 + 0 
267a : 65 4e __ ADC T4 + 0 
267c : 8d 9a 3d STA $3d9a ; (txt_x + 0)
267f : ad 9c 3d LDA $3d9c ; (_ch + 0)
2682 : d0 01 __ BNE $2685 ; (core_drawtext.s67 + 0)
2684 : 60 __ __ RTS
.s67:
2685 : 20 65 28 JSR $2865 ; (core_cr.l34 + 0)
2688 : ad 9c 3d LDA $3d9c ; (_ch + 0)
268b : d0 01 __ BNE $268e ; (core_drawtext.s67 + 9)
268d : 60 __ __ RTS
268e : 4c ef 24 JMP $24ef ; (core_drawtext.l2 + 0)
.s16:
2691 : 20 4e 27 JSR $274e ; (_getnextch.s0 + 0)
2694 : ad 9c 3d LDA $3d9c ; (_ch + 0)
2697 : c9 16 __ CMP #$16
2699 : f0 27 __ BEQ $26c2 ; (core_drawtext.s70 + 0)
.s35:
269b : 90 7c __ BCC $2719 ; (core_drawtext.s37 + 0)
.s36:
269d : c9 19 __ CMP #$19
269f : d0 04 __ BNE $26a5 ; (core_drawtext.s44 + 0)
.s24:
26a1 : a9 07 __ LDA #$07
26a3 : d0 0b __ BNE $26b0 ; (core_drawtext.s1043 + 0)
.s44:
26a5 : b0 0f __ BCS $26b6 ; (core_drawtext.s45 + 0)
.s46:
26a7 : c9 17 __ CMP #$17
26a9 : f0 03 __ BEQ $26ae ; (core_drawtext.s25 + 0)
26ab : 4c 77 25 JMP $2577 ; (core_drawtext.s115 + 0)
.s25:
26ae : a9 01 __ LDA #$01
.s1043:
26b0 : 8d 97 3d STA $3d97 ; (txt_col + 0)
26b3 : 4c 77 25 JMP $2577 ; (core_drawtext.s115 + 0)
.s45:
26b6 : c9 56 __ CMP #$56
26b8 : f0 03 __ BEQ $26bd ; (core_drawtext.s26 + 0)
26ba : 4c 77 25 JMP $2577 ; (core_drawtext.s115 + 0)
.s26:
26bd : a9 01 __ LDA #$01
26bf : 8d a6 3d STA $3da6 ; (u + 0)
.s70:
26c2 : a9 00 __ LDA #$00
26c4 : 8d a7 3d STA $3da7 ; (v + 0)
.l28:
26c7 : ad 70 3d LDA $3d70 ; (vrb + 0)
26ca : 85 4c __ STA T3 + 0 
26cc : ad 71 3d LDA $3d71 ; (vrb + 1)
26cf : 85 4d __ STA T3 + 1 
26d1 : ac a7 3d LDY $3da7 ; (v + 0)
26d4 : b1 4c __ LDA (T3 + 0),y 
26d6 : d0 03 __ BNE $26db ; (core_drawtext.s29 + 0)
26d8 : 4c 77 25 JMP $2577 ; (core_drawtext.s115 + 0)
.s29:
26db : 84 49 __ STY T0 + 0 
26dd : ad a2 3d LDA $3da2 ; (ll + 0)
26e0 : 85 4e __ STA T4 + 0 
26e2 : ad 99 3d LDA $3d99 ; (txt_rev + 0)
26e5 : 18 __ __ CLC
26e6 : 71 4c __ ADC (T3 + 0),y 
26e8 : aa __ __ TAX
26e9 : a4 4e __ LDY T4 + 0 
26eb : 99 a8 3d STA $3da8,y ; (_buffer + 0)
26ee : ad 97 3d LDA $3d97 ; (txt_col + 0)
26f1 : c8 __ __ INY
26f2 : 8c a2 3d STY $3da2 ; (ll + 0)
26f5 : 99 d1 3d STA $3dd1,y ; (_buffer + 41)
26f8 : a9 00 __ LDA #$00
26fa : 8d a3 3d STA $3da3 ; (ll + 1)
26fd : a4 49 __ LDY T0 + 0 
26ff : c8 __ __ INY
2700 : 8c a7 3d STY $3da7 ; (v + 0)
2703 : ad a6 3d LDA $3da6 ; (u + 0)
2706 : f0 bf __ BEQ $26c7 ; (core_drawtext.l28 + 0)
.s31:
2708 : a9 00 __ LDA #$00
270a : 8d a6 3d STA $3da6 ; (u + 0)
270d : 8a __ __ TXA
270e : 18 __ __ CLC
270f : 69 40 __ ADC #$40
2711 : a6 4e __ LDX T4 + 0 
2713 : 9d a8 3d STA $3da8,x ; (_buffer + 0)
2716 : 4c c7 26 JMP $26c7 ; (core_drawtext.l28 + 0)
.s37:
2719 : c9 0c __ CMP #$0c
271b : d0 07 __ BNE $2724 ; (core_drawtext.s38 + 0)
.s22:
271d : a9 00 __ LDA #$00
271f : 8d f9 3c STA $3cf9 ; (align + 0)
2722 : f0 10 __ BEQ $2734 ; (core_drawtext.s1041 + 0)
.s38:
2724 : 90 14 __ BCC $273a ; (core_drawtext.s40 + 0)
.s39:
2726 : c9 12 __ CMP #$12
2728 : f0 03 __ BEQ $272d ; (core_drawtext.s21 + 0)
272a : 4c 77 25 JMP $2577 ; (core_drawtext.s115 + 0)
.s21:
272d : a9 01 __ LDA #$01
.s1042:
272f : 8d f9 3c STA $3cf9 ; (align + 0)
2732 : a9 00 __ LDA #$00
.s1041:
2734 : 8d fa 3c STA $3cfa ; (align + 1)
2737 : 4c 77 25 JMP $2577 ; (core_drawtext.s115 + 0)
.s40:
273a : c9 03 __ CMP #$03
273c : d0 04 __ BNE $2742 ; (core_drawtext.s41 + 0)
.s20:
273e : a9 02 __ LDA #$02
2740 : d0 ed __ BNE $272f ; (core_drawtext.s1042 + 0)
.s41:
2742 : c9 07 __ CMP #$07
2744 : f0 03 __ BEQ $2749 ; (core_drawtext.s23 + 0)
2746 : 4c 77 25 JMP $2577 ; (core_drawtext.s115 + 0)
.s23:
2749 : a9 0c __ LDA #$0c
274b : 4c b0 26 JMP $26b0 ; (core_drawtext.s1043 + 0)
--------------------------------------------------------------------
_getnextch: ; _getnextch()->void
.s0:
274e : ad 9d 3d LDA $3d9d ; (_ech + 0)
2751 : f0 08 __ BEQ $275b ; (_getnextch.s2 + 0)
.s1:
2753 : a2 00 __ LDX #$00
2755 : 8e 9d 3d STX $3d9d ; (_ech + 0)
2758 : 4c 00 28 JMP $2800 ; (_getnextch.s1015 + 0)
.s2:
275b : ad 9e 3d LDA $3d9e ; (_cplx + 0)
275e : cd 9f 3d CMP $3d9f ; (_cplw + 0)
2761 : b0 17 __ BCS $277a ; (_getnextch.s5 + 0)
.s4:
2763 : 85 1b __ STA ACCU + 0 
2765 : 69 01 __ ADC #$01
2767 : 8d 9e 3d STA $3d9e ; (_cplx + 0)
276a : ad a0 3d LDA $3da0 ; (_cpl + 0)
276d : 18 __ __ CLC
276e : 65 1b __ ADC ACCU + 0 
2770 : 85 43 __ STA T2 + 0 
2772 : ad a1 3d LDA $3da1 ; (_cpl + 1)
2775 : 69 00 __ ADC #$00
2777 : 4c fa 27 JMP $27fa ; (_getnextch.s29 + 0)
.s5:
277a : ad 8d 3d LDA $3d8d ; (txt + 0)
277d : 85 43 __ STA T2 + 0 
277f : ad 8e 3d LDA $3d8e ; (txt + 1)
2782 : 85 44 __ STA T2 + 1 
2784 : cd 96 3d CMP $3d96 ; (etxt + 1)
2787 : d0 0b __ BNE $2794 ; (_getnextch.s8 + 0)
.s1010:
2789 : a5 43 __ LDA T2 + 0 
278b : cd 95 3d CMP $3d95 ; (etxt + 0)
278e : d0 04 __ BNE $2794 ; (_getnextch.s8 + 0)
.s7:
2790 : a9 00 __ LDA #$00
2792 : f0 6c __ BEQ $2800 ; (_getnextch.s1015 + 0)
.s8:
2794 : 18 __ __ CLC
2795 : a5 43 __ LDA T2 + 0 
2797 : 69 01 __ ADC #$01
2799 : 8d 8d 3d STA $3d8d ; (txt + 0)
279c : a5 44 __ LDA T2 + 1 
279e : 69 00 __ ADC #$00
27a0 : 8d 8e 3d STA $3d8e ; (txt + 1)
27a3 : a0 00 __ LDY #$00
27a5 : b1 43 __ LDA (T2 + 0),y 
27a7 : 8d 9c 3d STA $3d9c ; (_ch + 0)
27aa : c9 5d __ CMP #$5d
27ac : d0 07 __ BNE $27b5 ; (_getnextch.s13 + 0)
.s10:
27ae : a9 01 __ LDA #$01
27b0 : 8d 9c 3d STA $3d9c ; (_ch + 0)
27b3 : d0 4f __ BNE $2804 ; (_getnextch.s16 + 0)
.s13:
27b5 : c9 5e __ CMP #$5e
27b7 : d0 18 __ BNE $27d1 ; (_getnextch.s11 + 0)
.s14:
27b9 : c8 __ __ INY
27ba : b1 43 __ LDA (T2 + 0),y 
27bc : 8d 9c 3d STA $3d9c ; (_ch + 0)
27bf : 18 __ __ CLC
27c0 : a5 43 __ LDA T2 + 0 
27c2 : 69 02 __ ADC #$02
27c4 : 8d 8d 3d STA $3d8d ; (txt + 0)
27c7 : a5 44 __ LDA T2 + 1 
27c9 : 69 00 __ ADC #$00
27cb : 8d 8e 3d STA $3d8e ; (txt + 1)
27ce : 4c 04 28 JMP $2804 ; (_getnextch.s16 + 0)
.s11:
27d1 : c9 5f __ CMP #$5f
27d3 : 90 2e __ BCC $2803 ; (_getnextch.s1001 + 0)
.s20:
27d5 : 84 44 __ STY T2 + 1 
27d7 : a9 02 __ LDA #$02
27d9 : 8d 9f 3d STA $3d9f ; (_cplw + 0)
27dc : a9 01 __ LDA #$01
27de : 8d 9e 3d STA $3d9e ; (_cplx + 0)
27e1 : ad 9c 3d LDA $3d9c ; (_ch + 0)
27e4 : e9 5f __ SBC #$5f
27e6 : 0a __ __ ASL
27e7 : 26 44 __ ROL T2 + 1 
27e9 : 18 __ __ CLC
27ea : 6d 40 3d ADC $3d40 ; (packdata + 0)
27ed : 85 43 __ STA T2 + 0 
27ef : 8d a0 3d STA $3da0 ; (_cpl + 0)
27f2 : ad 41 3d LDA $3d41 ; (packdata + 1)
27f5 : 65 44 __ ADC T2 + 1 
27f7 : 8d a1 3d STA $3da1 ; (_cpl + 1)
.s29:
27fa : 85 44 __ STA T2 + 1 
27fc : a0 00 __ LDY #$00
27fe : b1 43 __ LDA (T2 + 0),y 
.s1015:
2800 : 8d 9c 3d STA $3d9c ; (_ch + 0)
.s1001:
2803 : 60 __ __ RTS
.s16:
2804 : a9 01 __ LDA #$01
2806 : 8d 9e 3d STA $3d9e ; (_cplx + 0)
2809 : ad 9c 3d LDA $3d9c ; (_ch + 0)
280c : 85 1b __ STA ACCU + 0 
280e : e6 1b __ INC ACCU + 0 
2810 : ad 2e 3d LDA $3d2e ; (shortdict + 0)
2813 : 85 45 __ STA T3 + 0 
2815 : 18 __ __ CLC
2816 : 65 1b __ ADC ACCU + 0 
2818 : 85 43 __ STA T2 + 0 
281a : ad 2f 3d LDA $3d2f ; (shortdict + 1)
281d : 85 46 __ STA T3 + 1 
281f : 69 00 __ ADC #$00
2821 : 85 44 __ STA T2 + 1 
2823 : a0 00 __ LDY #$00
2825 : b1 43 __ LDA (T2 + 0),y 
2827 : 85 1c __ STA ACCU + 1 
2829 : b1 45 __ LDA (T3 + 0),y 
282b : 18 __ __ CLC
282c : 65 45 __ ADC T3 + 0 
282e : a8 __ __ TAY
282f : a5 46 __ LDA T3 + 1 
2831 : 69 00 __ ADC #$00
2833 : aa __ __ TAX
2834 : 98 __ __ TYA
2835 : 18 __ __ CLC
2836 : 69 01 __ ADC #$01
2838 : 90 01 __ BCC $283b ; (_getnextch.s1017 + 0)
.s1016:
283a : e8 __ __ INX
.s1017:
283b : 18 __ __ CLC
283c : 65 1c __ ADC ACCU + 1 
283e : 8d a0 3d STA $3da0 ; (_cpl + 0)
2841 : 90 01 __ BCC $2844 ; (_getnextch.s1019 + 0)
.s1018:
2843 : e8 __ __ INX
.s1019:
2844 : 8e a1 3d STX $3da1 ; (_cpl + 1)
2847 : a0 01 __ LDY #$01
2849 : b1 43 __ LDA (T2 + 0),y 
284b : 38 __ __ SEC
284c : e5 1c __ SBC ACCU + 1 
284e : 8d 9f 3d STA $3d9f ; (_cplw + 0)
2851 : a5 1b __ LDA ACCU + 0 
2853 : d1 45 __ CMP (T3 + 0),y 
2855 : 90 03 __ BCC $285a ; (_getnextch.s19 + 0)
.s17:
2857 : ee a1 3d INC $3da1 ; (_cpl + 1)
.s19:
285a : ad a0 3d LDA $3da0 ; (_cpl + 0)
285d : 85 43 __ STA T2 + 0 
285f : ad a1 3d LDA $3da1 ; (_cpl + 1)
2862 : 4c fa 27 JMP $27fa ; (_getnextch.s29 + 0)
--------------------------------------------------------------------
core_cr: ; core_cr()->void
.l34:
2865 : 2c 11 d0 BIT $d011 
2868 : 10 fb __ BPL $2865 ; (core_cr.l34 + 0)
.s1:
286a : a9 00 __ LDA #$00
286c : 8d 9a 3d STA $3d9a ; (txt_x + 0)
286f : ad 9b 3d LDA $3d9b ; (txt_y + 0)
2872 : 85 47 __ STA T0 + 0 
2874 : 18 __ __ CLC
2875 : 69 01 __ ADC #$01
2877 : 85 48 __ STA T2 + 0 
2879 : 8d 9b 3d STA $3d9b ; (txt_y + 0)
287c : ad 9c 3d LDA $3d9c ; (_ch + 0)
287f : c9 20 __ CMP #$20
2881 : f0 04 __ BEQ $2887 ; (core_cr.s5 + 0)
.s8:
2883 : c9 1f __ CMP #$1f
2885 : d0 03 __ BNE $288a ; (core_cr.s7 + 0)
.s5:
2887 : 20 4e 27 JSR $274e ; (_getnextch.s0 + 0)
.s7:
288a : a5 48 __ LDA T2 + 0 
288c : c9 19 __ CMP #$19
288e : 90 08 __ BCC $2898 ; (core_cr.s11 + 0)
.s9:
2890 : 20 9c 28 JSR $289c ; (scrollup.l71 + 0)
2893 : a5 47 __ LDA T0 + 0 
2895 : 8d 9b 3d STA $3d9b ; (txt_y + 0)
.s11:
2898 : ee 73 3d INC $3d73 ; (al + 0)
.s1001:
289b : 60 __ __ RTS
--------------------------------------------------------------------
scrollup: ; scrollup()->void
.l71:
289c : 2c 11 d0 BIT $d011 
289f : 10 fb __ BPL $289c ; (scrollup.l71 + 0)
.s1:
28a1 : ad a6 02 LDA $02a6 
28a4 : d0 0e __ BNE $28b4 ; (scrollup.l9 + 0)
.s5:
28a6 : a9 96 __ LDA #$96
28a8 : 85 0d __ STA P0 
28aa : a9 00 __ LDA #$00
28ac : 85 0e __ STA P1 
28ae : 20 3f 29 JSR $293f ; (vic_waitLine.s0 + 0)
28b1 : 4c be 28 JMP $28be ; (scrollup.s7 + 0)
.l9:
28b4 : 2c 11 d0 BIT $d011 
28b7 : 30 fb __ BMI $28b4 ; (scrollup.l9 + 0)
.l12:
28b9 : 2c 11 d0 BIT $d011 
28bc : 10 fb __ BPL $28b9 ; (scrollup.l12 + 0)
.s7:
28be : a5 01 __ LDA $01 
28c0 : 8d 88 3d STA $3d88 ; (ch + 0)
28c3 : 78 __ __ SEI
28c4 : 25 fc __ AND $fc 
28c6 : 85 01 __ STA $01 
28c8 : a2 28 __ LDX #$28
28ca : ca __ __ DEX
28cb : bd 58 f6 LDA $f658,x 
28ce : 9d 30 f6 STA $f630,x 
28d1 : bd 80 f6 LDA $f680,x 
28d4 : 9d 58 f6 STA $f658,x 
28d7 : bd a8 f6 LDA $f6a8,x 
28da : 9d 80 f6 STA $f680,x 
28dd : bd d0 f6 LDA $f6d0,x 
28e0 : 9d a8 f6 STA $f6a8,x 
28e3 : bd f8 f6 LDA $f6f8,x 
28e6 : 9d d0 f6 STA $f6d0,x 
28e9 : bd 20 f7 LDA $f720,x 
28ec : 9d f8 f6 STA $f6f8,x 
28ef : bd 48 f7 LDA $f748,x 
28f2 : 9d 20 f7 STA $f720,x 
28f5 : bd 70 f7 LDA $f770,x 
28f8 : 9d 48 f7 STA $f748,x 
28fb : bd 98 f7 LDA $f798,x 
28fe : 9d 70 f7 STA $f770,x 
2901 : bd c0 f7 LDA $f7c0,x 
2904 : 9d 98 f7 STA $f798,x 
2907 : a9 20 __ LDA #$20
2909 : 9d c0 f7 STA $f7c0,x 
290c : e0 00 __ CPX #$00
290e : d0 ba __ BNE $28ca ; (scrollup.s7 + 12)
2910 : ad 88 3d LDA $3d88 ; (ch + 0)
2913 : 85 01 __ STA $01 
2915 : 58 __ __ CLI
2916 : a9 90 __ LDA #$90
2918 : 85 11 __ STA P4 
291a : a9 01 __ LDA #$01
291c : 85 12 __ STA P5 
291e : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
2921 : 18 __ __ CLC
2922 : 69 30 __ ADC #$30
2924 : 85 0d __ STA P0 
2926 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
2929 : 69 02 __ ADC #$02
292b : 85 0e __ STA P1 
292d : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
2930 : 18 __ __ CLC
2931 : 69 58 __ ADC #$58
2933 : 85 0f __ STA P2 
2935 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
2938 : 69 02 __ ADC #$02
293a : 85 10 __ STA P3 
293c : 4c 58 29 JMP $2958 ; (memmove.s0 + 0)
--------------------------------------------------------------------
vic_waitLine: ; vic_waitLine(i16)->void
.s0:
293f : 46 0e __ LSR P1 ; (line + 1)
2941 : a9 00 __ LDA #$00
2943 : 6a __ __ ROR
2944 : 85 1b __ STA ACCU + 0 
2946 : a4 0d __ LDY P0 ; (line + 0)
.l3:
2948 : 98 __ __ TYA
.l1006:
2949 : cd 12 d0 CMP $d012 
294c : d0 fb __ BNE $2949 ; (vic_waitLine.l1006 + 0)
.s5:
294e : ad 11 d0 LDA $d011 
2951 : 29 80 __ AND #$80
2953 : c5 1b __ CMP ACCU + 0 
2955 : d0 f1 __ BNE $2948 ; (vic_waitLine.l3 + 0)
.s1001:
2957 : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
2958 : a5 12 __ LDA P5 ; (size + 1)
295a : 30 5c __ BMI $29b8 ; (memmove.s3 + 0)
.s1006:
295c : 05 11 __ ORA P4 ; (size + 0)
295e : f0 58 __ BEQ $29b8 ; (memmove.s3 + 0)
.s1:
2960 : a5 0e __ LDA P1 ; (dst + 1)
2962 : c5 10 __ CMP P3 ; (src + 1)
2964 : d0 04 __ BNE $296a ; (memmove.s1005 + 0)
.s1004:
2966 : a5 0d __ LDA P0 ; (dst + 0)
2968 : c5 0f __ CMP P2 ; (src + 0)
.s1005:
296a : 90 55 __ BCC $29c1 ; (memmove.s15 + 0)
.s5:
296c : a5 10 __ LDA P3 ; (src + 1)
296e : c5 0e __ CMP P1 ; (dst + 1)
2970 : d0 04 __ BNE $2976 ; (memmove.s1003 + 0)
.s1002:
2972 : a5 0f __ LDA P2 ; (src + 0)
2974 : c5 0d __ CMP P0 ; (dst + 0)
.s1003:
2976 : b0 40 __ BCS $29b8 ; (memmove.s3 + 0)
.s9:
2978 : a5 0f __ LDA P2 ; (src + 0)
297a : 65 11 __ ADC P4 ; (size + 0)
297c : 85 43 __ STA T4 + 0 
297e : a5 10 __ LDA P3 ; (src + 1)
2980 : 65 12 __ ADC P5 ; (size + 1)
2982 : 85 44 __ STA T4 + 1 
2984 : 18 __ __ CLC
2985 : a5 0d __ LDA P0 ; (dst + 0)
2987 : 65 11 __ ADC P4 ; (size + 0)
2989 : 85 1b __ STA ACCU + 0 
298b : a5 0e __ LDA P1 ; (dst + 1)
298d : 65 12 __ ADC P5 ; (size + 1)
298f : 85 1c __ STA ACCU + 1 
2991 : a0 00 __ LDY #$00
2993 : a5 11 __ LDA P4 ; (size + 0)
2995 : f0 02 __ BEQ $2999 ; (memmove.l1009 + 0)
.s1014:
2997 : e6 12 __ INC P5 ; (size + 1)
.l1009:
2999 : a6 11 __ LDX P4 ; (size + 0)
.l1017:
299b : a5 1b __ LDA ACCU + 0 
299d : d0 02 __ BNE $29a1 ; (memmove.s1024 + 0)
.s1023:
299f : c6 1c __ DEC ACCU + 1 
.s1024:
29a1 : c6 1b __ DEC ACCU + 0 
29a3 : a5 43 __ LDA T4 + 0 
29a5 : d0 02 __ BNE $29a9 ; (memmove.s1026 + 0)
.s1025:
29a7 : c6 44 __ DEC T4 + 1 
.s1026:
29a9 : c6 43 __ DEC T4 + 0 
29ab : b1 43 __ LDA (T4 + 0),y 
29ad : 91 1b __ STA (ACCU + 0),y 
29af : ca __ __ DEX
29b0 : d0 e9 __ BNE $299b ; (memmove.l1017 + 0)
.s1018:
29b2 : 86 11 __ STX P4 ; (size + 0)
29b4 : c6 12 __ DEC P5 ; (size + 1)
29b6 : d0 e1 __ BNE $2999 ; (memmove.l1009 + 0)
.s3:
29b8 : a5 0d __ LDA P0 ; (dst + 0)
29ba : 85 1b __ STA ACCU + 0 
29bc : a5 0e __ LDA P1 ; (dst + 1)
29be : 85 1c __ STA ACCU + 1 
.s1001:
29c0 : 60 __ __ RTS
.s15:
29c1 : a5 0d __ LDA P0 ; (dst + 0)
29c3 : 85 1b __ STA ACCU + 0 
29c5 : a5 0e __ LDA P1 ; (dst + 1)
29c7 : 85 1c __ STA ACCU + 1 
29c9 : a0 00 __ LDY #$00
29cb : a5 11 __ LDA P4 ; (size + 0)
29cd : f0 02 __ BEQ $29d1 ; (memmove.l1007 + 0)
.s1012:
29cf : e6 12 __ INC P5 ; (size + 1)
.l1007:
29d1 : a6 11 __ LDX P4 ; (size + 0)
.l1015:
29d3 : b1 0f __ LDA (P2),y ; (src + 0)
29d5 : 91 1b __ STA (ACCU + 0),y 
29d7 : e6 0f __ INC P2 ; (src + 0)
29d9 : d0 02 __ BNE $29dd ; (memmove.s1020 + 0)
.s1019:
29db : e6 10 __ INC P3 ; (src + 1)
.s1020:
29dd : e6 1b __ INC ACCU + 0 
29df : d0 02 __ BNE $29e3 ; (memmove.s1022 + 0)
.s1021:
29e1 : e6 1c __ INC ACCU + 1 
.s1022:
29e3 : ca __ __ DEX
29e4 : d0 ed __ BNE $29d3 ; (memmove.l1015 + 0)
.s1016:
29e6 : 86 11 __ STX P4 ; (size + 0)
29e8 : c6 12 __ DEC P5 ; (size + 1)
29ea : d0 e5 __ BNE $29d1 ; (memmove.l1007 + 0)
29ec : 90 ca __ BCC $29b8 ; (memmove.s3 + 0)
--------------------------------------------------------------------
_savechpos: ; _savechpos()->void
.s0:
29ee : ad 8d 3d LDA $3d8d ; (txt + 0)
29f1 : 8d fc 3d STA $3dfc ; (btxt + 0)
29f4 : ad 8e 3d LDA $3d8e ; (txt + 1)
29f7 : 8d fd 3d STA $3dfd ; (btxt + 1)
29fa : ad a0 3d LDA $3da0 ; (_cpl + 0)
29fd : 8d fe 3d STA $3dfe ; (b_cpl + 0)
2a00 : ad a1 3d LDA $3da1 ; (_cpl + 1)
2a03 : 8d ff 3d STA $3dff ; (b_cpl + 1)
2a06 : ad 9e 3d LDA $3d9e ; (_cplx + 0)
2a09 : 8d 00 3e STA $3e00 ; (b_cplx + 0)
2a0c : ad 9f 3d LDA $3d9f ; (_cplw + 0)
2a0f : 8d 01 3e STA $3e01 ; (b_cplw + 0)
.s1001:
2a12 : 60 __ __ RTS
--------------------------------------------------------------------
_restorechpos: ; _restorechpos()->void
.s0:
2a13 : ad fc 3d LDA $3dfc ; (btxt + 0)
2a16 : 8d 8d 3d STA $3d8d ; (txt + 0)
2a19 : ad fd 3d LDA $3dfd ; (btxt + 1)
2a1c : 8d 8e 3d STA $3d8e ; (txt + 1)
2a1f : ad fe 3d LDA $3dfe ; (b_cpl + 0)
2a22 : 8d a0 3d STA $3da0 ; (_cpl + 0)
2a25 : ad ff 3d LDA $3dff ; (b_cpl + 1)
2a28 : 8d a1 3d STA $3da1 ; (_cpl + 1)
2a2b : ad 00 3e LDA $3e00 ; (b_cplx + 0)
2a2e : 8d 9e 3d STA $3d9e ; (_cplx + 0)
2a31 : ad 01 3e LDA $3e01 ; (b_cplw + 0)
2a34 : 8d 9f 3d STA $3d9f ; (_cplw + 0)
.s1001:
2a37 : 60 __ __ RTS
--------------------------------------------------------------------
cr: ; cr()->void
.l30:
2a38 : 2c 11 d0 BIT $d011 
2a3b : 10 fb __ BPL $2a38 ; (cr.l30 + 0)
.s1:
2a3d : ad c3 3c LDA $3cc3 ; (text_y + 0)
2a40 : 85 45 __ STA T0 + 0 
2a42 : 18 __ __ CLC
2a43 : 69 01 __ ADC #$01
2a45 : 8d c3 3c STA $3cc3 ; (text_y + 0)
2a48 : c9 0b __ CMP #$0b
2a4a : 90 08 __ BCC $2a54 ; (cr.s1001 + 0)
.s5:
2a4c : 20 9c 28 JSR $289c ; (scrollup.l71 + 0)
2a4f : a5 45 __ LDA T0 + 0 
2a51 : 8d c3 3c STA $3cc3 ; (text_y + 0)
.s1001:
2a54 : 60 __ __ RTS
--------------------------------------------------------------------
ui_waitkey: ; ui_waitkey()->void
.s0:
2a55 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
2a58 : 18 __ __ CLC
2a59 : 69 c0 __ ADC #$c0
2a5b : 85 43 __ STA T1 + 0 
2a5d : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
2a60 : 69 03 __ ADC #$03
2a62 : 85 44 __ STA T1 + 1 
2a64 : ad af 3c LDA $3caf ; (video_ram + 0)
2a67 : 18 __ __ CLC
2a68 : 69 c0 __ ADC #$c0
2a6a : 85 45 __ STA T2 + 0 
2a6c : ad b0 3c LDA $3cb0 ; (video_ram + 1)
2a6f : 69 03 __ ADC #$03
2a71 : 85 46 __ STA T2 + 1 
2a73 : a0 12 __ LDY #$12
.l1006:
2a75 : a9 0f __ LDA #$0f
2a77 : 91 43 __ STA (T1 + 0),y 
2a79 : a9 2e __ LDA #$2e
2a7b : 91 45 __ STA (T2 + 0),y 
2a7d : c8 __ __ INY
2a7e : c0 15 __ CPY #$15
2a80 : 90 f3 __ BCC $2a75 ; (ui_waitkey.l1006 + 0)
.s3:
2a82 : a9 15 __ LDA #$15
2a84 : 8d a2 3d STA $3da2 ; (ll + 0)
2a87 : a9 00 __ LDA #$00
2a89 : 8d a3 3d STA $3da3 ; (ll + 1)
2a8c : 20 ac 2a JSR $2aac ; (ui_getkey.l2 + 0)
2a8f : a0 12 __ LDY #$12
.l1008:
2a91 : a9 0f __ LDA #$0f
2a93 : 91 43 __ STA (T1 + 0),y 
2a95 : a9 20 __ LDA #$20
2a97 : 91 45 __ STA (T2 + 0),y 
2a99 : c8 __ __ INY
2a9a : c0 15 __ CPY #$15
2a9c : 90 f3 __ BCC $2a91 ; (ui_waitkey.l1008 + 0)
.s6:
2a9e : a9 00 __ LDA #$00
2aa0 : 8d 73 3d STA $3d73 ; (al + 0)
2aa3 : 8d a3 3d STA $3da3 ; (ll + 1)
2aa6 : a9 15 __ LDA #$15
2aa8 : 8d a2 3d STA $3da2 ; (ll + 0)
.s1001:
2aab : 60 __ __ RTS
--------------------------------------------------------------------
ui_getkey: ; ui_getkey()->void
.l2:
2aac : 20 9f ff JSR $ff9f 
2aaf : 20 e4 ff JSR $ffe4 
2ab2 : 8d 88 3d STA $3d88 ; (ch + 0)
2ab5 : ad 88 3d LDA $3d88 ; (ch + 0)
2ab8 : d0 08 __ BNE $2ac2 ; (ui_getkey.s1001 + 0)
.l82:
2aba : 2c 11 d0 BIT $d011 
2abd : 10 fb __ BPL $2aba ; (ui_getkey.l82 + 0)
2abf : 4c ac 2a JMP $2aac ; (ui_getkey.l2 + 0)
.s1001:
2ac2 : 60 __ __ RTS
--------------------------------------------------------------------
adv_save: ; adv_save()->u8
.s0:
2ac3 : a9 00 __ LDA #$00
2ac5 : 85 13 __ STA P6 
2ac7 : 20 0b 2b JSR $2b0b ; (irq_detach.l31 + 0)
2aca : a9 bd __ LDA #$bd
2acc : 85 0d __ STA P0 
2ace : a9 2b __ LDA #$2b
2ad0 : 85 0e __ STA P1 
2ad2 : ad 58 3d LDA $3d58 ; (objattr + 0)
2ad5 : 85 0f __ STA P2 
2ad7 : ad 59 3d LDA $3d59 ; (objattr + 1)
2ada : 85 10 __ STA P3 
2adc : ad 6c 3d LDA $3d6c ; (origram_len + 0)
2adf : 85 11 __ STA P4 
2ae1 : ad 6d 3d LDA $3d6d ; (origram_len + 1)
2ae4 : 85 12 __ STA P5 
2ae6 : 20 6f 2b JSR $2b6f ; (disk_save.s0 + 0)
2ae9 : 09 00 __ ORA #$00
2aeb : f0 07 __ BEQ $2af4 ; (adv_save.s1 + 0)
.s2:
2aed : 20 c2 2b JSR $2bc2 ; (irq_attach.l27 + 0)
2af0 : a9 01 __ LDA #$01
2af2 : d0 14 __ BNE $2b08 ; (adv_save.s1001 + 0)
.s1:
2af4 : a9 02 __ LDA #$02
2af6 : 8d 20 d0 STA $d020 
.l32:
2af9 : 2c 11 d0 BIT $d011 
2afc : 10 fb __ BPL $2af9 ; (adv_save.l32 + 0)
.s4:
2afe : a9 00 __ LDA #$00
2b00 : 8d 20 d0 STA $d020 
2b03 : 20 c2 2b JSR $2bc2 ; (irq_attach.l27 + 0)
2b06 : a9 00 __ LDA #$00
.s1001:
2b08 : 85 1b __ STA ACCU + 0 
2b0a : 60 __ __ RTS
--------------------------------------------------------------------
irq_detach: ; irq_detach(u8)->void
.l31:
2b0b : 2c 11 d0 BIT $d011 
2b0e : 10 fb __ BPL $2b0b ; (irq_detach.l31 + 0)
.s1:
2b10 : 20 5a 2b JSR $2b5a ; (IRQ_reset.s0 + 0)
2b13 : a5 13 __ LDA P6 ; (mode + 0)
2b15 : f0 40 __ BEQ $2b57 ; (irq_detach.s5 + 0)
.s8:
2b17 : c9 04 __ CMP #$04
2b19 : f0 3c __ BEQ $2b57 ; (irq_detach.s5 + 0)
.s6:
2b1b : 20 bd 11 JSR $11bd ; (do_bitmapmode.s0 + 0)
2b1e : a9 00 __ LDA #$00
2b20 : 85 0f __ STA P2 
2b22 : 85 10 __ STA P3 
2b24 : a9 08 __ LDA #$08
2b26 : 85 11 __ STA P4 
2b28 : a9 02 __ LDA #$02
2b2a : 85 12 __ STA P5 
2b2c : a9 e0 __ LDA #$e0
2b2e : 85 0d __ STA P0 
2b30 : a9 f1 __ LDA #$f1
2b32 : 85 0e __ STA P1 
2b34 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
2b37 : a9 00 __ LDA #$00
2b39 : 85 0f __ STA P2 
2b3b : 85 10 __ STA P3 
2b3d : a9 08 __ LDA #$08
2b3f : 85 11 __ STA P4 
2b41 : a9 02 __ LDA #$02
2b43 : 85 12 __ STA P5 
2b45 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
2b48 : 18 __ __ CLC
2b49 : 69 e0 __ ADC #$e0
2b4b : 85 0d __ STA P0 
2b4d : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
2b50 : 69 01 __ ADC #$01
2b52 : 85 0e __ STA P1 
2b54 : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
.s5:
2b57 : 4c b3 0c JMP $0cb3 ; (do_textmode.s0 + 0)
--------------------------------------------------------------------
IRQ_reset: ; IRQ_reset()->void
.s0:
2b5a : 78 __ __ SEI
2b5b : ad 1a d0 LDA $d01a 
2b5e : 29 fe __ AND #$fe
2b60 : 8d 1a d0 STA $d01a 
2b63 : a2 81 __ LDX #$81
2b65 : a0 ea __ LDY #$ea
2b67 : 8e 14 03 STX $0314 
2b6a : 8c 15 03 STY $0315 
2b6d : 58 __ __ CLI
.s1001:
2b6e : 60 __ __ RTS
--------------------------------------------------------------------
disk_save: ; disk_save(const u8*,u8*,u16)->u8
.s0:
2b6f : a5 0f __ LDA P2 ; (mem + 0)
2b71 : 8d 02 3e STA $3e02 ; (diskmemlow + 0)
2b74 : 18 __ __ CLC
2b75 : 65 11 __ ADC P4 ; (len + 0)
2b77 : 8d 04 3e STA $3e04 ; (ediskmemlow + 0)
2b7a : a5 10 __ LDA P3 ; (mem + 1)
2b7c : 8d 03 3e STA $3e03 ; (diskmemhi + 0)
2b7f : 65 12 __ ADC P5 ; (len + 1)
2b81 : 8d 05 3e STA $3e05 ; (ediskmemhi + 0)
2b84 : a9 07 __ LDA #$07
2b86 : a2 fc __ LDX #$fc
2b88 : a0 3c __ LDY #$3c
2b8a : 20 bd ff JSR $ffbd 
2b8d : a9 01 __ LDA #$01
2b8f : a6 ba __ LDX $ba 
2b91 : d0 02 __ BNE $2b95 ; (disk_save.s0 + 38)
2b93 : a2 08 __ LDX #$08
2b95 : a0 00 __ LDY #$00
2b97 : 20 ba ff JSR $ffba 
2b9a : ad 02 3e LDA $3e02 ; (diskmemlow + 0)
2b9d : 85 c1 __ STA $c1 
2b9f : ad 03 3e LDA $3e03 ; (diskmemhi + 0)
2ba2 : 85 c2 __ STA $c2 
2ba4 : ae 04 3e LDX $3e04 ; (ediskmemlow + 0)
2ba7 : ac 05 3e LDY $3e05 ; (ediskmemhi + 0)
2baa : a9 c1 __ LDA #$c1
2bac : 20 d8 ff JSR $ffd8 
2baf : b0 05 __ BCS $2bb6 ; (disk_save.s0 + 71)
2bb1 : a9 01 __ LDA #$01
2bb3 : 85 1b __ STA ACCU + 0 
2bb5 : 60 __ __ RTS
2bb6 : a9 00 __ LDA #$00
2bb8 : 85 1b __ STA ACCU + 0 
.s1001:
2bba : a5 1b __ LDA ACCU + 0 
2bbc : 60 __ __ RTS
--------------------------------------------------------------------
2bbd : __ __ __ BYT 73 61 76 65 00                                  : save.
--------------------------------------------------------------------
irq_attach: ; irq_attach()->void
.l27:
2bc2 : 2c 11 d0 BIT $d011 
2bc5 : 10 fb __ BPL $2bc2 ; (irq_attach.l27 + 0)
.s1:
2bc7 : 4c 7b 11 JMP $117b ; (IRQ_gfx_init.s0 + 0)
--------------------------------------------------------------------
mini_itoa: ; mini_itoa(i16,u8*)->void
.s0:
2bca : a5 0e __ LDA P1 ; (n + 1)
2bcc : 30 75 __ BMI $2c43 ; (mini_itoa.s3 + 0)
.s1012:
2bce : d0 06 __ BNE $2bd6 ; (mini_itoa.s1 + 0)
.s1011:
2bd0 : a5 0d __ LDA P0 ; (n + 0)
2bd2 : c9 64 __ CMP #$64
2bd4 : 90 6d __ BCC $2c43 ; (mini_itoa.s3 + 0)
.s1:
2bd6 : a5 0f __ LDA P2 ; (s + 0)
2bd8 : 85 1b __ STA ACCU + 0 
2bda : a5 10 __ LDA P3 ; (s + 1)
2bdc : 85 1c __ STA ACCU + 1 
2bde : a9 30 __ LDA #$30
2be0 : a0 00 __ LDY #$00
2be2 : 91 0f __ STA (P2),y ; (s + 0)
2be4 : a6 0d __ LDX P0 ; (n + 0)
.l1015:
2be6 : b1 1b __ LDA (ACCU + 0),y 
2be8 : 18 __ __ CLC
2be9 : 69 01 __ ADC #$01
2beb : 91 1b __ STA (ACCU + 0),y 
2bed : 8a __ __ TXA
2bee : 38 __ __ SEC
2bef : e9 64 __ SBC #$64
2bf1 : aa __ __ TAX
2bf2 : a5 0e __ LDA P1 ; (n + 1)
2bf4 : e9 00 __ SBC #$00
2bf6 : 85 0e __ STA P1 ; (n + 1)
2bf8 : d0 ec __ BNE $2be6 ; (mini_itoa.l1015 + 0)
.s1010:
2bfa : e0 64 __ CPX #$64
2bfc : b0 e8 __ BCS $2be6 ; (mini_itoa.l1015 + 0)
.s18:
2bfe : 86 0d __ STX P0 ; (n + 0)
2c00 : a9 01 __ LDA #$01
2c02 : 85 1b __ STA ACCU + 0 
2c04 : e0 0a __ CPX #$0a
2c06 : 90 31 __ BCC $2c39 ; (mini_itoa.s8 + 0)
.s32:
2c08 : a8 __ __ TAY
.s7:
2c09 : a9 30 __ LDA #$30
2c0b : 91 0f __ STA (P2),y ; (s + 0)
2c0d : a5 0d __ LDA P0 ; (n + 0)
2c0f : 30 17 __ BMI $2c28 ; (mini_itoa.s50 + 0)
.s1019:
2c11 : c9 0a __ CMP #$0a
2c13 : 90 13 __ BCC $2c28 ; (mini_itoa.s50 + 0)
.s1017:
2c15 : aa __ __ TAX
.l1013:
2c16 : b1 0f __ LDA (P2),y ; (s + 0)
2c18 : 18 __ __ CLC
2c19 : 69 01 __ ADC #$01
2c1b : 91 0f __ STA (P2),y ; (s + 0)
2c1d : 8a __ __ TXA
2c1e : 38 __ __ SEC
2c1f : e9 0a __ SBC #$0a
2c21 : aa __ __ TAX
2c22 : e0 0a __ CPX #$0a
2c24 : b0 f0 __ BCS $2c16 ; (mini_itoa.l1013 + 0)
.s1018:
2c26 : 85 0d __ STA P0 ; (n + 0)
.s50:
2c28 : e6 1b __ INC ACCU + 0 
.s9:
2c2a : 18 __ __ CLC
2c2b : a5 0d __ LDA P0 ; (n + 0)
2c2d : 69 30 __ ADC #$30
2c2f : a4 1b __ LDY ACCU + 0 
2c31 : 91 0f __ STA (P2),y ; (s + 0)
2c33 : a9 00 __ LDA #$00
2c35 : c8 __ __ INY
2c36 : 91 0f __ STA (P2),y ; (s + 0)
.s1001:
2c38 : 60 __ __ RTS
.s8:
2c39 : a4 1b __ LDY ACCU + 0 
2c3b : f0 ed __ BEQ $2c2a ; (mini_itoa.s9 + 0)
.s13:
2c3d : a9 30 __ LDA #$30
2c3f : 91 0f __ STA (P2),y ; (s + 0)
2c41 : d0 e5 __ BNE $2c28 ; (mini_itoa.s50 + 0)
.s3:
2c43 : a9 00 __ LDA #$00
2c45 : 85 1b __ STA ACCU + 0 
2c47 : a5 0e __ LDA P1 ; (n + 1)
2c49 : 30 ee __ BMI $2c39 ; (mini_itoa.s8 + 0)
.s1007:
2c4b : d0 06 __ BNE $2c53 ; (mini_itoa.s33 + 0)
.s1006:
2c4d : a5 0d __ LDA P0 ; (n + 0)
2c4f : c9 0a __ CMP #$0a
2c51 : 90 e6 __ BCC $2c39 ; (mini_itoa.s8 + 0)
.s33:
2c53 : a0 00 __ LDY #$00
2c55 : f0 b2 __ BEQ $2c09 ; (mini_itoa.s7 + 0)
--------------------------------------------------------------------
ui_room_update: ; ui_room_update()->void
.s0:
2c57 : ad 04 3d LDA $3d04 ; (slowmode + 0)
2c5a : 85 13 __ STA P6 
2c5c : 20 0b 2b JSR $2b0b ; (irq_detach.l31 + 0)
.l27:
2c5f : 2c 11 d0 BIT $d011 
2c62 : 10 fb __ BPL $2c5f ; (ui_room_update.l27 + 0)
.s1:
2c64 : 20 6a 2c JSR $2c6a ; (ui_room_gfx_update.l88 + 0)
2c67 : 4c c2 2b JMP $2bc2 ; (irq_attach.l27 + 0)
--------------------------------------------------------------------
ui_room_gfx_update: ; ui_room_gfx_update()->void
.l88:
2c6a : 2c 11 d0 BIT $d011 
2c6d : 10 fb __ BPL $2c6a ; (ui_room_gfx_update.l88 + 0)
.s1:
2c6f : 20 90 2e JSR $2e90 ; (ui_openimage.s0 + 0)
2c72 : a5 1b __ LDA ACCU + 0 
2c74 : d0 03 __ BNE $2c79 ; (ui_room_gfx_update.s5 + 0)
.s6:
2c76 : 4c e4 30 JMP $30e4 ; (ui_image_clean.s0 + 0)
.s5:
2c79 : a9 0a __ LDA #$0a
2c7b : 85 15 __ STA P8 
2c7d : a9 00 __ LDA #$00
2c7f : 85 16 __ STA P9 
2c81 : a9 e6 __ LDA #$e6
2c83 : 85 13 __ STA P6 
2c85 : a9 cb __ LDA #$cb
2c87 : 85 14 __ STA P7 
2c89 : 20 69 2f JSR $2f69 ; (ui_read.s0 + 0)
2c8c : a9 ff __ LDA #$ff
2c8e : 4d e6 cb EOR $cbe6 ; (head + 0)
2c91 : 85 4c __ STA T1 + 0 
2c93 : 85 13 __ STA P6 
2c95 : 38 __ __ SEC
2c96 : a9 cf __ LDA #$cf
2c98 : ed e7 cb SBC $cbe7 ; (head + 1)
2c9b : 85 4d __ STA T1 + 1 
2c9d : 85 14 __ STA P7 
2c9f : ad ee cb LDA $cbee ; (head + 8)
2ca2 : 18 __ __ CLC
2ca3 : 6d ea cb ADC $cbea ; (head + 4)
2ca6 : 85 15 __ STA P8 
2ca8 : ad ef cb LDA $cbef ; (head + 9)
2cab : 6d eb cb ADC $cbeb ; (head + 5)
2cae : 85 16 __ STA P9 
2cb0 : 20 69 2f JSR $2f69 ; (ui_read.s0 + 0)
2cb3 : ad 04 3d LDA $3d04 ; (slowmode + 0)
2cb6 : c9 01 __ CMP #$01
2cb8 : d0 26 __ BNE $2ce0 ; (ui_room_gfx_update.s10 + 0)
.s8:
2cba : 20 4f 12 JSR $124f ; (ui_clear.s0 + 0)
2cbd : a9 a0 __ LDA #$a0
2cbf : 85 0f __ STA P2 
2cc1 : a9 00 __ LDA #$00
2cc3 : 85 10 __ STA P3 
2cc5 : 85 12 __ STA P5 
2cc7 : a9 28 __ LDA #$28
2cc9 : 85 11 __ STA P4 
2ccb : ad af 3c LDA $3caf ; (video_ram + 0)
2cce : 18 __ __ CLC
2ccf : 69 08 __ ADC #$08
2cd1 : 85 0d __ STA P0 
2cd3 : ad b0 3c LDA $3cb0 ; (video_ram + 1)
2cd6 : 69 02 __ ADC #$02
2cd8 : 85 0e __ STA P1 
2cda : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
2cdd : 20 59 30 JSR $3059 ; (ui_image_fade.s0 + 0)
.s10:
2ce0 : a5 01 __ LDA $01 
2ce2 : 85 4b __ STA T0 + 0 
2ce4 : a9 34 __ LDA #$34
2ce6 : 85 01 __ STA $01 
2ce8 : ad e9 cb LDA $cbe9 ; (head + 3)
2ceb : cd eb cb CMP $cbeb ; (head + 5)
2cee : d0 08 __ BNE $2cf8 ; (ui_room_gfx_update.s12 + 0)
.s1010:
2cf0 : ad e8 cb LDA $cbe8 ; (head + 2)
2cf3 : cd ea cb CMP $cbea ; (head + 4)
2cf6 : f0 16 __ BEQ $2d0e ; (ui_room_gfx_update.s11 + 0)
.s12:
2cf8 : a5 13 __ LDA P6 
2cfa : 85 0d __ STA P0 
2cfc : a5 14 __ LDA P7 
2cfe : 85 0e __ STA P1 
2d00 : a9 00 __ LDA #$00
2d02 : 85 0f __ STA P2 
2d04 : a9 f0 __ LDA #$f0
2d06 : 85 10 __ STA P3 
2d08 : 20 c2 0a JSR $0ac2 ; (hunpack.s0 + 0)
2d0b : 4c 2b 2d JMP $2d2b ; (ui_room_gfx_update.s13 + 0)
.s11:
2d0e : a9 00 __ LDA #$00
2d10 : 85 0d __ STA P0 
2d12 : a9 f0 __ LDA #$f0
2d14 : 85 0e __ STA P1 
2d16 : a5 13 __ LDA P6 
2d18 : 85 0f __ STA P2 
2d1a : a5 14 __ LDA P7 
2d1c : 85 10 __ STA P3 
2d1e : ad e8 cb LDA $cbe8 ; (head + 2)
2d21 : 85 11 __ STA P4 
2d23 : ad e9 cb LDA $cbe9 ; (head + 3)
2d26 : 85 12 __ STA P5 
2d28 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
.s13:
2d2b : a5 4b __ LDA T0 + 0 
2d2d : 85 01 __ STA $01 
2d2f : a9 00 __ LDA #$00
2d31 : 85 4e __ STA T2 + 0 
2d33 : 85 4f __ STA T2 + 1 
2d35 : 85 1b __ STA ACCU + 0 
2d37 : 85 1c __ STA ACCU + 1 
2d39 : cd ed cb CMP $cbed ; (head + 7)
2d3c : d0 05 __ BNE $2d43 ; (ui_room_gfx_update.l1009 + 0)
.s1008:
2d3e : a5 1b __ LDA ACCU + 0 
2d40 : cd ec cb CMP $cbec ; (head + 6)
.l1009:
2d43 : b0 03 __ BCS $2d48 ; (ui_room_gfx_update.s16 + 0)
2d45 : 4c 3d 2e JMP $2e3d ; (ui_room_gfx_update.s15 + 0)
.s16:
2d48 : a9 02 __ LDA #$02
2d4a : 85 15 __ STA P8 
2d4c : a9 00 __ LDA #$00
2d4e : 85 16 __ STA P9 
2d50 : a9 f0 __ LDA #$f0
2d52 : 85 13 __ STA P6 
2d54 : a9 cb __ LDA #$cb
2d56 : 85 14 __ STA P7 
2d58 : 20 69 2f JSR $2f69 ; (ui_read.s0 + 0)
2d5b : ad f0 cb LDA $cbf0 ; (bsize + 0)
2d5e : 0d f1 cb ORA $cbf1 ; (bsize + 1)
2d61 : f0 08 __ BEQ $2d6b ; (ui_room_gfx_update.s19 + 0)
.s27:
2d63 : a9 00 __ LDA #$00
2d65 : 85 4e __ STA T2 + 0 
2d67 : 85 4f __ STA T2 + 1 
2d69 : f0 16 __ BEQ $2d81 ; (ui_room_gfx_update.l18 + 0)
.s19:
2d6b : ad 08 3e LDA $3e08 ; (fileptr + 0)
2d6e : 0d 09 3e ORA $3e09 ; (fileptr + 1)
2d71 : d0 05 __ BNE $2d78 ; (ui_room_gfx_update.s24 + 0)
.s25:
2d73 : a9 02 __ LDA #$02
2d75 : 4c dc 30 JMP $30dc ; (krnio_close.s1000 + 0)
.s24:
2d78 : a9 00 __ LDA #$00
2d7a : 8d 08 3e STA $3e08 ; (fileptr + 0)
2d7d : 8d 09 3e STA $3e09 ; (fileptr + 1)
.s1001:
2d80 : 60 __ __ RTS
.l18:
2d81 : a9 f2 __ LDA #$f2
2d83 : 85 13 __ STA P6 
2d85 : a9 cb __ LDA #$cb
2d87 : 85 14 __ STA P7 
2d89 : a9 02 __ LDA #$02
2d8b : 85 15 __ STA P8 
2d8d : a9 00 __ LDA #$00
2d8f : 85 16 __ STA P9 
2d91 : 20 69 2f JSR $2f69 ; (ui_read.s0 + 0)
2d94 : a5 4c __ LDA T1 + 0 
2d96 : 85 13 __ STA P6 
2d98 : a5 4d __ LDA T1 + 1 
2d9a : 85 14 __ STA P7 
2d9c : ad f2 cb LDA $cbf2 ; (size + 0)
2d9f : 85 15 __ STA P8 
2da1 : ad f3 cb LDA $cbf3 ; (size + 1)
2da4 : 85 16 __ STA P9 
2da6 : 20 69 2f JSR $2f69 ; (ui_read.s0 + 0)
2da9 : a5 01 __ LDA $01 
2dab : 85 4b __ STA T0 + 0 
2dad : a9 34 __ LDA #$34
2daf : 85 01 __ STA $01 
2db1 : ad f0 cb LDA $cbf0 ; (bsize + 0)
2db4 : 38 __ __ SEC
2db5 : e5 4e __ SBC T2 + 0 
2db7 : aa __ __ TAX
2db8 : ad f1 cb LDA $cbf1 ; (bsize + 1)
2dbb : e5 4f __ SBC T2 + 1 
2dbd : cd f3 cb CMP $cbf3 ; (size + 1)
2dc0 : d0 05 __ BNE $2dc7 ; (ui_room_gfx_update.s23 + 0)
.s1006:
2dc2 : ec f2 cb CPX $cbf2 ; (size + 0)
2dc5 : f0 2d __ BEQ $2df4 ; (ui_room_gfx_update.s20 + 0)
.s23:
2dc7 : ad f3 cb LDA $cbf3 ; (size + 1)
2dca : cd e7 cb CMP $cbe7 ; (head + 1)
2dcd : d0 08 __ BNE $2dd7 ; (ui_room_gfx_update.s21 + 0)
.s1004:
2dcf : ad f2 cb LDA $cbf2 ; (size + 0)
2dd2 : cd e6 cb CMP $cbe6 ; (head + 0)
2dd5 : f0 1d __ BEQ $2df4 ; (ui_room_gfx_update.s20 + 0)
.s21:
2dd7 : a5 13 __ LDA P6 
2dd9 : 85 0d __ STA P0 
2ddb : a5 14 __ LDA P7 
2ddd : 85 0e __ STA P1 
2ddf : ad 11 3d LDA $3d11 ; (bitmap_image + 0)
2de2 : 18 __ __ CLC
2de3 : 65 4e __ ADC T2 + 0 
2de5 : 85 0f __ STA P2 
2de7 : ad 12 3d LDA $3d12 ; (bitmap_image + 1)
2dea : 65 4f __ ADC T2 + 1 
2dec : 85 10 __ STA P3 
2dee : 20 c2 0a JSR $0ac2 ; (hunpack.s0 + 0)
2df1 : 4c 18 2e JMP $2e18 ; (ui_room_gfx_update.s22 + 0)
.s20:
2df4 : a5 13 __ LDA P6 
2df6 : 85 0f __ STA P2 
2df8 : a5 14 __ LDA P7 
2dfa : 85 10 __ STA P3 
2dfc : ad f2 cb LDA $cbf2 ; (size + 0)
2dff : 85 11 __ STA P4 
2e01 : ad f3 cb LDA $cbf3 ; (size + 1)
2e04 : 85 12 __ STA P5 
2e06 : ad 11 3d LDA $3d11 ; (bitmap_image + 0)
2e09 : 18 __ __ CLC
2e0a : 65 4e __ ADC T2 + 0 
2e0c : 85 0d __ STA P0 
2e0e : ad 12 3d LDA $3d12 ; (bitmap_image + 1)
2e11 : 65 4f __ ADC T2 + 1 
2e13 : 85 0e __ STA P1 
2e15 : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
.s22:
2e18 : a5 4b __ LDA T0 + 0 
2e1a : 85 01 __ STA $01 
2e1c : ad e6 cb LDA $cbe6 ; (head + 0)
2e1f : 18 __ __ CLC
2e20 : 65 4e __ ADC T2 + 0 
2e22 : 85 4e __ STA T2 + 0 
2e24 : ad e7 cb LDA $cbe7 ; (head + 1)
2e27 : 65 4f __ ADC T2 + 1 
2e29 : 85 4f __ STA T2 + 1 
2e2b : cd f1 cb CMP $cbf1 ; (bsize + 1)
2e2e : d0 05 __ BNE $2e35 ; (ui_room_gfx_update.s1003 + 0)
.s1002:
2e30 : a5 4e __ LDA T2 + 0 
2e32 : cd f0 cb CMP $cbf0 ; (bsize + 0)
.s1003:
2e35 : b0 03 __ BCS $2e3a ; (ui_room_gfx_update.s1003 + 5)
2e37 : 4c 81 2d JMP $2d81 ; (ui_room_gfx_update.l18 + 0)
2e3a : 4c 6b 2d JMP $2d6b ; (ui_room_gfx_update.s19 + 0)
.s15:
2e3d : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
2e40 : 65 4e __ ADC T2 + 0 
2e42 : 85 43 __ STA T4 + 0 
2e44 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
2e47 : 65 4f __ ADC T2 + 1 
2e49 : 85 44 __ STA T4 + 1 
2e4b : ad ea cb LDA $cbea ; (head + 4)
2e4e : 18 __ __ CLC
2e4f : 65 1b __ ADC ACCU + 0 
2e51 : 85 46 __ STA T6 + 0 
2e53 : ad eb cb LDA $cbeb ; (head + 5)
2e56 : 65 1c __ ADC ACCU + 1 
2e58 : 18 __ __ CLC
2e59 : 65 4d __ ADC T1 + 1 
2e5b : 85 47 __ STA T6 + 1 
2e5d : a4 4c __ LDY T1 + 0 
2e5f : b1 46 __ LDA (T6 + 0),y 
2e61 : aa __ __ TAX
2e62 : 29 0f __ AND #$0f
2e64 : a0 00 __ LDY #$00
2e66 : 91 43 __ STA (T4 + 0),y 
2e68 : 8a __ __ TXA
2e69 : 29 f0 __ AND #$f0
2e6b : 4a __ __ LSR
2e6c : 4a __ __ LSR
2e6d : 4a __ __ LSR
2e6e : 4a __ __ LSR
2e6f : c8 __ __ INY
2e70 : 91 43 __ STA (T4 + 0),y 
2e72 : e6 1b __ INC ACCU + 0 
2e74 : d0 02 __ BNE $2e78 ; (ui_room_gfx_update.s1015 + 0)
.s1014:
2e76 : e6 1c __ INC ACCU + 1 
.s1015:
2e78 : 18 __ __ CLC
2e79 : a5 4e __ LDA T2 + 0 
2e7b : 69 02 __ ADC #$02
2e7d : 85 4e __ STA T2 + 0 
2e7f : 90 02 __ BCC $2e83 ; (ui_room_gfx_update.s1017 + 0)
.s1016:
2e81 : e6 4f __ INC T2 + 1 
.s1017:
2e83 : a5 1c __ LDA ACCU + 1 
2e85 : cd ed cb CMP $cbed ; (head + 7)
2e88 : f0 03 __ BEQ $2e8d ; (ui_room_gfx_update.s1017 + 10)
2e8a : 4c 43 2d JMP $2d43 ; (ui_room_gfx_update.l1009 + 0)
2e8d : 4c 3e 2d JMP $2d3e ; (ui_room_gfx_update.s1008 + 0)
--------------------------------------------------------------------
ui_openimage: ; ui_openimage()->u8
.s0:
2e90 : ad 07 3e LDA $3e07 ; (imageid + 0)
2e93 : c9 ff __ CMP #$ff
2e95 : d0 05 __ BNE $2e9c ; (ui_openimage.s3 + 0)
.s1:
2e97 : a9 00 __ LDA #$00
2e99 : 4c 26 2f JMP $2f26 ; (ui_openimage.s1001 + 0)
.s3:
2e9c : 85 1b __ STA ACCU + 0 
2e9e : a9 00 __ LDA #$00
2ea0 : 85 1c __ STA ACCU + 1 
2ea2 : ad 68 3d LDA $3d68 ; (imagesidx + 0)
2ea5 : 0d 69 3d ORA $3d69 ; (imagesidx + 1)
2ea8 : f0 2d __ BEQ $2ed7 ; (ui_openimage.s6 + 0)
.s5:
2eaa : 06 1b __ ASL ACCU + 0 
2eac : 26 1c __ ROL ACCU + 1 
2eae : ad 68 3d LDA $3d68 ; (imagesidx + 0)
2eb1 : 18 __ __ CLC
2eb2 : 65 1b __ ADC ACCU + 0 
2eb4 : 85 1b __ STA ACCU + 0 
2eb6 : ad 69 3d LDA $3d69 ; (imagesidx + 1)
2eb9 : 65 1c __ ADC ACCU + 1 
2ebb : 85 1c __ STA ACCU + 1 
2ebd : a0 01 __ LDY #$01
2ebf : b1 1b __ LDA (ACCU + 0),y 
2ec1 : aa __ __ TAX
2ec2 : ad 6a 3d LDA $3d6a ; (imagesdata + 0)
2ec5 : 18 __ __ CLC
2ec6 : 88 __ __ DEY
2ec7 : 71 1b __ ADC (ACCU + 0),y 
2ec9 : 8d 08 3e STA $3e08 ; (fileptr + 0)
2ecc : 8a __ __ TXA
2ecd : 6d 6b 3d ADC $3d6b ; (imagesdata + 1)
2ed0 : 8d 09 3e STA $3e09 ; (fileptr + 1)
2ed3 : a9 01 __ LDA #$01
2ed5 : d0 4f __ BNE $2f26 ; (ui_openimage.s1001 + 0)
.s6:
2ed7 : a2 0b __ LDX #$0b
.l1002:
2ed9 : bd 05 3d LDA $3d05,x ; (curimageid + 0)
2edc : 9d f3 cb STA $cbf3,x ; (size + 1)
2edf : ca __ __ DEX
2ee0 : d0 f7 __ BNE $2ed9 ; (ui_openimage.l1002 + 0)
.s1003:
2ee2 : a9 f4 __ LDA #$f4
2ee4 : 85 0d __ STA P0 
2ee6 : a9 cb __ LDA #$cb
2ee8 : 85 0e __ STA P1 
2eea : a5 ba __ LDA $ba 
2eec : d0 02 __ BNE $2ef0 ; (ui_openimage.s11 + 0)
.s9:
2eee : a9 08 __ LDA #$08
.s11:
2ef0 : 86 1c __ STX ACCU + 1 
2ef2 : 86 04 __ STX WORK + 1 
2ef4 : 85 43 __ STA T0 + 0 
2ef6 : e6 1b __ INC ACCU + 0 
2ef8 : a9 0a __ LDA #$0a
2efa : 85 03 __ STA WORK + 0 
2efc : 20 28 3c JSR $3c28 ; (divmod + 0)
2eff : 18 __ __ CLC
2f00 : a5 1b __ LDA ACCU + 0 
2f02 : 69 30 __ ADC #$30
2f04 : 8d f8 cb STA $cbf8 ; (nm + 4)
2f07 : 18 __ __ CLC
2f08 : a5 05 __ LDA WORK + 2 
2f0a : 69 30 __ ADC #$30
2f0c : 8d f9 cb STA $cbf9 ; (nm + 5)
2f0f : 20 29 2f JSR $2f29 ; (krnio_setnam.s0 + 0)
2f12 : a9 02 __ LDA #$02
2f14 : 85 0d __ STA P0 
2f16 : a5 43 __ LDA T0 + 0 
2f18 : 85 0e __ STA P1 
2f1a : a9 00 __ LDA #$00
2f1c : 85 0f __ STA P2 
2f1e : 20 3f 2f JSR $2f3f ; (krnio_open.s0 + 0)
2f21 : c9 01 __ CMP #$01
2f23 : a9 00 __ LDA #$00
2f25 : 2a __ __ ROL
.s1001:
2f26 : 85 1b __ STA ACCU + 0 
2f28 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
2f29 : a5 0d __ LDA P0 
2f2b : 05 0e __ ORA P1 
2f2d : f0 08 __ BEQ $2f37 ; (krnio_setnam.s0 + 14)
2f2f : a0 ff __ LDY #$ff
2f31 : c8 __ __ INY
2f32 : b1 0d __ LDA (P0),y 
2f34 : d0 fb __ BNE $2f31 ; (krnio_setnam.s0 + 8)
2f36 : 98 __ __ TYA
2f37 : a6 0d __ LDX P0 
2f39 : a4 0e __ LDY P1 
2f3b : 20 bd ff JSR $ffbd 
.s1001:
2f3e : 60 __ __ RTS
--------------------------------------------------------------------
krnio_open: ; krnio_open(u8,u8,u8)->bool
.s0:
2f3f : a9 00 __ LDA #$00
2f41 : a6 0d __ LDX P0 ; (fnum + 0)
2f43 : 9d 0a 3e STA $3e0a,x ; (krnio_pstatus + 0)
2f46 : a9 00 __ LDA #$00
2f48 : 85 1b __ STA ACCU + 0 
2f4a : 85 1c __ STA ACCU + 1 
2f4c : a5 0d __ LDA P0 ; (fnum + 0)
2f4e : a6 0e __ LDX P1 
2f50 : a4 0f __ LDY P2 
2f52 : 20 ba ff JSR $ffba 
2f55 : 20 c0 ff JSR $ffc0 
2f58 : 90 08 __ BCC $2f62 ; (krnio_open.s0 + 35)
2f5a : a5 0d __ LDA P0 ; (fnum + 0)
2f5c : 20 c3 ff JSR $ffc3 
2f5f : 4c 66 2f JMP $2f66 ; (krnio_open.s1001 + 0)
2f62 : a9 01 __ LDA #$01
2f64 : 85 1b __ STA ACCU + 0 
.s1001:
2f66 : a5 1b __ LDA ACCU + 0 
2f68 : 60 __ __ RTS
--------------------------------------------------------------------
ui_read: ; ui_read(void*,u16)->void
.s0:
2f69 : a5 15 __ LDA P8 ; (size + 0)
2f6b : 85 11 __ STA P4 
2f6d : a5 16 __ LDA P9 ; (size + 1)
2f6f : 85 12 __ STA P5 
2f71 : ad 09 3e LDA $3e09 ; (fileptr + 1)
2f74 : 85 48 __ STA T2 + 1 
2f76 : ad 08 3e LDA $3e08 ; (fileptr + 0)
2f79 : 85 47 __ STA T2 + 0 
2f7b : 05 48 __ ORA T2 + 1 
2f7d : d0 0f __ BNE $2f8e ; (ui_read.s1 + 0)
.s2:
2f7f : a9 02 __ LDA #$02
2f81 : 85 0e __ STA P1 
2f83 : a5 13 __ LDA P6 ; (what + 0)
2f85 : 85 0f __ STA P2 
2f87 : a5 14 __ LDA P7 ; (what + 1)
2f89 : 85 10 __ STA P3 
2f8b : 4c b1 2f JMP $2fb1 ; (krnio_read.s0 + 0)
.s1:
2f8e : a5 13 __ LDA P6 ; (what + 0)
2f90 : 85 0d __ STA P0 
2f92 : a5 14 __ LDA P7 ; (what + 1)
2f94 : 85 0e __ STA P1 
2f96 : a5 47 __ LDA T2 + 0 
2f98 : 85 0f __ STA P2 
2f9a : a5 48 __ LDA T2 + 1 
2f9c : 85 10 __ STA P3 
2f9e : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
2fa1 : 18 __ __ CLC
2fa2 : a5 47 __ LDA T2 + 0 
2fa4 : 65 15 __ ADC P8 ; (size + 0)
2fa6 : 8d 08 3e STA $3e08 ; (fileptr + 0)
2fa9 : a5 48 __ LDA T2 + 1 
2fab : 65 16 __ ADC P9 ; (size + 1)
2fad : 8d 09 3e STA $3e09 ; (fileptr + 1)
.s1001:
2fb0 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_read: ; krnio_read(u8,u8*,i16)->i16
.s0:
2fb1 : a6 0e __ LDX P1 ; (fnum + 0)
2fb3 : bd 0a 3e LDA $3e0a,x ; (krnio_pstatus + 0)
2fb6 : c9 40 __ CMP #$40
2fb8 : d0 04 __ BNE $2fbe ; (krnio_read.s3 + 0)
.s1:
2fba : a9 00 __ LDA #$00
2fbc : f0 0c __ BEQ $2fca ; (krnio_read.s1010 + 0)
.s3:
2fbe : 86 43 __ STX T1 + 0 
2fc0 : 8a __ __ TXA
2fc1 : 20 2b 30 JSR $302b ; (krnio_chkin.s1000 + 0)
2fc4 : 09 00 __ ORA #$00
2fc6 : d0 07 __ BNE $2fcf ; (krnio_read.s5 + 0)
.s6:
2fc8 : a9 ff __ LDA #$ff
.s1010:
2fca : 85 1b __ STA ACCU + 0 
.s1001:
2fcc : 85 1c __ STA ACCU + 1 
2fce : 60 __ __ RTS
.s5:
2fcf : a9 00 __ LDA #$00
2fd1 : 85 44 __ STA T3 + 0 
2fd3 : 85 45 __ STA T3 + 1 
2fd5 : a5 12 __ LDA P5 ; (num + 1)
2fd7 : 30 46 __ BMI $301f ; (krnio_read.s10 + 0)
.s1007:
2fd9 : 05 11 __ ORA P4 ; (num + 0)
2fdb : f0 42 __ BEQ $301f ; (krnio_read.s10 + 0)
.l9:
2fdd : 20 3f 30 JSR $303f ; (krnio_chrin.s0 + 0)
2fe0 : a5 1b __ LDA ACCU + 0 
2fe2 : 85 46 __ STA T4 + 0 
2fe4 : 20 49 30 JSR $3049 ; (krnio_status.s0 + 0)
2fe7 : aa __ __ TAX
2fe8 : a4 43 __ LDY T1 + 0 
2fea : 99 0a 3e STA $3e0a,y ; (krnio_pstatus + 0)
2fed : 09 00 __ ORA #$00
2fef : f0 04 __ BEQ $2ff5 ; (krnio_read.s13 + 0)
.s14:
2ff1 : c9 40 __ CMP #$40
2ff3 : d0 2a __ BNE $301f ; (krnio_read.s10 + 0)
.s13:
2ff5 : a5 44 __ LDA T3 + 0 
2ff7 : 85 1b __ STA ACCU + 0 
2ff9 : 18 __ __ CLC
2ffa : a5 10 __ LDA P3 ; (data + 1)
2ffc : 65 45 __ ADC T3 + 1 
2ffe : 85 1c __ STA ACCU + 1 
3000 : a5 46 __ LDA T4 + 0 
3002 : a4 0f __ LDY P2 ; (data + 0)
3004 : 91 1b __ STA (ACCU + 0),y 
3006 : e6 44 __ INC T3 + 0 
3008 : d0 02 __ BNE $300c ; (krnio_read.s1012 + 0)
.s1011:
300a : e6 45 __ INC T3 + 1 
.s1012:
300c : 8a __ __ TXA
300d : d0 10 __ BNE $301f ; (krnio_read.s10 + 0)
.s8:
300f : 24 12 __ BIT P5 ; (num + 1)
3011 : 30 0c __ BMI $301f ; (krnio_read.s10 + 0)
.s1004:
3013 : a5 45 __ LDA T3 + 1 
3015 : c5 12 __ CMP P5 ; (num + 1)
3017 : d0 04 __ BNE $301d ; (krnio_read.s1003 + 0)
.s1002:
3019 : a5 44 __ LDA T3 + 0 
301b : c5 11 __ CMP P4 ; (num + 0)
.s1003:
301d : 90 be __ BCC $2fdd ; (krnio_read.l9 + 0)
.s10:
301f : 20 55 30 JSR $3055 ; (krnio_clrchn.s0 + 0)
3022 : a5 44 __ LDA T3 + 0 
3024 : 85 1b __ STA ACCU + 0 
3026 : a5 45 __ LDA T3 + 1 
3028 : 4c cc 2f JMP $2fcc ; (krnio_read.s1001 + 0)
--------------------------------------------------------------------
krnio_chkin: ; krnio_chkin(u8)->bool
.s1000:
302b : 85 0d __ STA P0 
.s0:
302d : a6 0d __ LDX P0 
302f : 20 c6 ff JSR $ffc6 
3032 : a9 00 __ LDA #$00
3034 : 85 1c __ STA ACCU + 1 
3036 : b0 02 __ BCS $303a ; (krnio_chkin.s0 + 13)
3038 : a9 01 __ LDA #$01
303a : 85 1b __ STA ACCU + 0 
.s1001:
303c : a5 1b __ LDA ACCU + 0 
303e : 60 __ __ RTS
--------------------------------------------------------------------
krnio_chrin: ; krnio_chrin()->i16
.s0:
303f : 20 cf ff JSR $ffcf 
3042 : 85 1b __ STA ACCU + 0 
3044 : a9 00 __ LDA #$00
3046 : 85 1c __ STA ACCU + 1 
.s1001:
3048 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_status: ; krnio_status()->enum krnioerr
.s0:
3049 : 20 b7 ff JSR $ffb7 
304c : 85 1b __ STA ACCU + 0 
304e : a9 00 __ LDA #$00
3050 : 85 1c __ STA ACCU + 1 
.s1001:
3052 : a5 1b __ LDA ACCU + 0 
3054 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_clrchn: ; krnio_clrchn()->void
.s0:
3055 : 20 cc ff JSR $ffcc 
.s1001:
3058 : 60 __ __ RTS
--------------------------------------------------------------------
ui_image_fade: ; ui_image_fade()->void
.s0:
3059 : a9 08 __ LDA #$08
305b : 85 43 __ STA T0 + 0 
305d : a9 f2 __ LDA #$f2
305f : 85 44 __ STA T0 + 1 
3061 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
3064 : 18 __ __ CLC
3065 : 69 08 __ ADC #$08
3067 : 85 45 __ STA T1 + 0 
3069 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
306c : 69 02 __ ADC #$02
306e : 85 46 __ STA T1 + 1 
3070 : a9 0c __ LDA #$0c
3072 : 85 47 __ STA T2 + 0 
.l2:
3074 : a5 43 __ LDA T0 + 0 
3076 : 85 0d __ STA P0 
3078 : a5 44 __ LDA T0 + 1 
307a : 85 0e __ STA P1 
307c : a9 00 __ LDA #$00
307e : 85 0f __ STA P2 
3080 : 85 10 __ STA P3 
3082 : 85 12 __ STA P5 
3084 : a9 28 __ LDA #$28
3086 : 85 11 __ STA P4 
3088 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
308b : a5 45 __ LDA T1 + 0 
308d : 85 0d __ STA P0 
308f : a5 46 __ LDA T1 + 1 
3091 : 85 0e __ STA P1 
3093 : a9 00 __ LDA #$00
3095 : 85 0f __ STA P2 
3097 : 85 10 __ STA P3 
3099 : 85 12 __ STA P5 
309b : a9 28 __ LDA #$28
309d : 85 11 __ STA P4 
309f : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
30a2 : 18 __ __ CLC
30a3 : a5 43 __ LDA T0 + 0 
30a5 : 69 d8 __ ADC #$d8
30a7 : 85 43 __ STA T0 + 0 
30a9 : b0 02 __ BCS $30ad ; (ui_image_fade.s1003 + 0)
.s1002:
30ab : c6 44 __ DEC T0 + 1 
.s1003:
30ad : 18 __ __ CLC
30ae : a5 45 __ LDA T1 + 0 
30b0 : 69 d8 __ ADC #$d8
30b2 : 85 45 __ STA T1 + 0 
30b4 : b0 02 __ BCS $30b8 ; (ui_image_fade.l42 + 0)
.s1004:
30b6 : c6 46 __ DEC T1 + 1 
.l42:
30b8 : 2c 11 d0 BIT $d011 
30bb : 10 fb __ BPL $30b8 ; (ui_image_fade.l42 + 0)
.s1:
30bd : a5 47 __ LDA T2 + 0 
30bf : c6 47 __ DEC T2 + 0 
30c1 : 09 00 __ ORA #$00
30c3 : d0 af __ BNE $3074 ; (ui_image_fade.l2 + 0)
.s3:
30c5 : 85 0f __ STA P2 
30c7 : 85 10 __ STA P3 
30c9 : 85 11 __ STA P4 
30cb : a9 0f __ LDA #$0f
30cd : 85 12 __ STA P5 
30cf : ad 11 3d LDA $3d11 ; (bitmap_image + 0)
30d2 : 85 0d __ STA P0 
30d4 : ad 12 3d LDA $3d12 ; (bitmap_image + 1)
30d7 : 85 0e __ STA P1 
30d9 : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
--------------------------------------------------------------------
krnio_close: ; krnio_close(u8)->void
.s1000:
30dc : 85 0d __ STA P0 
.s0:
30de : a5 0d __ LDA P0 
30e0 : 20 c3 ff JSR $ffc3 
.s1001:
30e3 : 60 __ __ RTS
--------------------------------------------------------------------
ui_image_clean: ; ui_image_clean()->void
.s0:
30e4 : a9 00 __ LDA #$00
30e6 : 85 0f __ STA P2 
30e8 : 85 10 __ STA P3 
30ea : 85 0d __ STA P0 
30ec : a9 e0 __ LDA #$e0
30ee : 85 11 __ STA P4 
30f0 : a9 01 __ LDA #$01
30f2 : 85 12 __ STA P5 
30f4 : a9 f0 __ LDA #$f0
30f6 : 85 0e __ STA P1 
30f8 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
30fb : a9 00 __ LDA #$00
30fd : 85 0f __ STA P2 
30ff : 85 10 __ STA P3 
3101 : a9 e0 __ LDA #$e0
3103 : 85 11 __ STA P4 
3105 : a9 01 __ LDA #$01
3107 : 85 12 __ STA P5 
3109 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
310c : 85 0d __ STA P0 
310e : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
3111 : 85 0e __ STA P1 
3113 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
3116 : a9 00 __ LDA #$00
3118 : 85 0f __ STA P2 
311a : 85 10 __ STA P3 
311c : 85 11 __ STA P4 
311e : a9 0f __ LDA #$0f
3120 : 85 12 __ STA P5 
3122 : ad 11 3d LDA $3d11 ; (bitmap_image + 0)
3125 : 85 0d __ STA P0 
3127 : ad 12 3d LDA $3d12 ; (bitmap_image + 1)
312a : 85 0e __ STA P1 
312c : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
--------------------------------------------------------------------
ui_status_update: ; ui_status_update()->void
.s0:
312f : ad 4c 3d LDA $3d4c ; (roomnameid + 0)
3132 : 85 46 __ STA T2 + 0 
3134 : ad 4d 3d LDA $3d4d ; (roomnameid + 1)
3137 : 85 47 __ STA T2 + 1 
3139 : ac c4 3c LDY $3cc4 ; (room + 0)
313c : b1 46 __ LDA (T2 + 0),y 
313e : 8d 89 3d STA $3d89 ; (strid + 0)
3141 : c9 ff __ CMP #$ff
3143 : d0 03 __ BNE $3148 ; (ui_status_update.s1 + 0)
3145 : 4c d1 31 JMP $31d1 ; (ui_status_update.s2 + 0)
.s1:
3148 : ad 30 3d LDA $3d30 ; (advnames + 0)
314b : 8d 8a 3d STA $3d8a ; (str + 0)
314e : ad 31 3d LDA $3d31 ; (advnames + 1)
3151 : 8d 8b 3d STA $3d8b ; (str + 1)
3154 : 20 8e 23 JSR $238e ; (_getstring.s0 + 0)
3157 : a9 07 __ LDA #$07
3159 : 85 0f __ STA P2 
315b : a9 00 __ LDA #$00
315d : 85 10 __ STA P3 
315f : 85 12 __ STA P5 
3161 : a9 28 __ LDA #$28
3163 : 85 11 __ STA P4 
3165 : ad 92 3d LDA $3d92 ; (ostr + 0)
3168 : 8d 8d 3d STA $3d8d ; (txt + 0)
316b : ad 93 3d LDA $3d93 ; (ostr + 1)
316e : 8d 8e 3d STA $3d8e ; (txt + 1)
3171 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
3174 : 18 __ __ CLC
3175 : 69 08 __ ADC #$08
3177 : 85 0d __ STA P0 
3179 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
317c : 69 02 __ ADC #$02
317e : 85 0e __ STA P1 
3180 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
3183 : a9 a0 __ LDA #$a0
3185 : 85 0f __ STA P2 
3187 : a9 00 __ LDA #$00
3189 : 85 10 __ STA P3 
318b : 85 12 __ STA P5 
318d : a9 28 __ LDA #$28
318f : 85 11 __ STA P4 
3191 : ad af 3c LDA $3caf ; (video_ram + 0)
3194 : 18 __ __ CLC
3195 : 69 08 __ ADC #$08
3197 : 85 0d __ STA P0 
3199 : ad b0 3c LDA $3cb0 ; (video_ram + 1)
319c : 69 02 __ ADC #$02
319e : 85 0e __ STA P1 
31a0 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
31a3 : a9 00 __ LDA #$00
31a5 : 8d 73 3d STA $3d73 ; (al + 0)
31a8 : 8d 9a 3d STA $3d9a ; (txt_x + 0)
31ab : a9 07 __ LDA #$07
31ad : 8d 97 3d STA $3d97 ; (txt_col + 0)
31b0 : a9 80 __ LDA #$80
31b2 : 8d 99 3d STA $3d99 ; (txt_rev + 0)
31b5 : a9 0d __ LDA #$0d
31b7 : 8d 9b 3d STA $3d9b ; (txt_y + 0)
31ba : 20 e7 24 JSR $24e7 ; (core_drawtext.l130 + 0)
31bd : ad 66 3d LDA $3d66 ; (vars + 0)
31c0 : 85 44 __ STA T1 + 0 
31c2 : ad 67 3d LDA $3d67 ; (vars + 1)
31c5 : 85 45 __ STA T1 + 1 
31c7 : a0 01 __ LDY #$01
31c9 : b1 44 __ LDA (T1 + 0),y 
31cb : d0 01 __ BNE $31ce ; (ui_status_update.s4 + 0)
.s1001:
31cd : 60 __ __ RTS
.s4:
31ce : 4c f9 31 JMP $31f9 ; (core_drawscore.s0 + 0)
.s2:
31d1 : a9 00 __ LDA #$00
31d3 : 85 0f __ STA P2 
31d5 : 85 10 __ STA P3 
31d7 : 85 12 __ STA P5 
31d9 : a9 28 __ LDA #$28
31db : 85 11 __ STA P4 
31dd : a9 a0 __ LDA #$a0
31df : 8d 8d 3d STA $3d8d ; (txt + 0)
31e2 : a9 32 __ LDA #$32
31e4 : 8d 8e 3d STA $3d8e ; (txt + 1)
31e7 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
31ea : 18 __ __ CLC
31eb : 69 08 __ ADC #$08
31ed : 85 0d __ STA P0 
31ef : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
31f2 : 69 02 __ ADC #$02
31f4 : 85 0e __ STA P1 
31f6 : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
--------------------------------------------------------------------
core_drawscore: ; core_drawscore()->void
.s0:
31f9 : ad 66 3d LDA $3d66 ; (vars + 0)
31fc : 85 43 __ STA T0 + 0 
31fe : ad 67 3d LDA $3d67 ; (vars + 1)
3201 : 85 44 __ STA T0 + 1 
3203 : a0 00 __ LDY #$00
3205 : 84 45 __ STY T1 + 0 
3207 : 84 0e __ STY P1 
3209 : b1 43 __ LDA (T0 + 0),y 
320b : 85 0d __ STA P0 
320d : ad 6e 3d LDA $3d6e ; (tmp + 0)
3210 : 85 43 __ STA T0 + 0 
3212 : 85 0f __ STA P2 
3214 : ad 6f 3d LDA $3d6f ; (tmp + 1)
3217 : 85 44 __ STA T0 + 1 
3219 : 85 10 __ STA P3 
321b : 20 ca 2b JSR $2bca ; (mini_itoa.s0 + 0)
.l1:
321e : a4 45 __ LDY T1 + 0 
3220 : e6 45 __ INC T1 + 0 
3222 : b1 43 __ LDA (T0 + 0),y 
3224 : d0 f8 __ BNE $321e ; (core_drawscore.l1 + 0)
.s3:
3226 : a9 2f __ LDA #$2f
3228 : 91 43 __ STA (T0 + 0),y 
322a : 18 __ __ CLC
322b : a5 43 __ LDA T0 + 0 
322d : 65 45 __ ADC T1 + 0 
322f : 85 0f __ STA P2 
3231 : a5 44 __ LDA T0 + 1 
3233 : 69 00 __ ADC #$00
3235 : 85 10 __ STA P3 
3237 : ad 66 3d LDA $3d66 ; (vars + 0)
323a : 85 43 __ STA T0 + 0 
323c : ad 67 3d LDA $3d67 ; (vars + 1)
323f : 85 44 __ STA T0 + 1 
3241 : a0 01 __ LDY #$01
3243 : b1 43 __ LDA (T0 + 0),y 
3245 : 85 0d __ STA P0 
3247 : a9 00 __ LDA #$00
3249 : 85 0e __ STA P1 
324b : 20 ca 2b JSR $2bca ; (mini_itoa.s0 + 0)
324e : ad 6e 3d LDA $3d6e ; (tmp + 0)
3251 : 85 43 __ STA T0 + 0 
3253 : ad 6f 3d LDA $3d6f ; (tmp + 1)
3256 : 85 44 __ STA T0 + 1 
3258 : a4 45 __ LDY T1 + 0 
325a : b1 43 __ LDA (T0 + 0),y 
325c : f0 05 __ BEQ $3263 ; (core_drawscore.s6 + 0)
.l5:
325e : c8 __ __ INY
325f : b1 43 __ LDA (T0 + 0),y 
3261 : d0 fb __ BNE $325e ; (core_drawscore.l5 + 0)
.s6:
3263 : 84 45 __ STY T1 + 0 
3265 : 38 __ __ SEC
3266 : e5 45 __ SBC T1 + 0 
3268 : 85 43 __ STA T0 + 0 
326a : a9 00 __ LDA #$00
326c : e9 00 __ SBC #$00
326e : aa __ __ TAX
326f : ad af 3c LDA $3caf ; (video_ram + 0)
3272 : 18 __ __ CLC
3273 : 69 30 __ ADC #$30
3275 : a8 __ __ TAY
3276 : ad b0 3c LDA $3cb0 ; (video_ram + 1)
3279 : 69 02 __ ADC #$02
327b : 85 1c __ STA ACCU + 1 
327d : 98 __ __ TYA
327e : 18 __ __ CLC
327f : 65 43 __ ADC T0 + 0 
3281 : 85 43 __ STA T0 + 0 
3283 : 8a __ __ TXA
3284 : 65 1c __ ADC ACCU + 1 
3286 : 85 44 __ STA T0 + 1 
3288 : a0 00 __ LDY #$00
328a : f0 05 __ BEQ $3291 ; (core_drawscore.l7 + 0)
.s8:
328c : 09 80 __ ORA #$80
328e : 91 43 __ STA (T0 + 0),y 
3290 : c8 __ __ INY
.l7:
3291 : ad 6e 3d LDA $3d6e ; (tmp + 0)
3294 : 85 1b __ STA ACCU + 0 
3296 : ad 6f 3d LDA $3d6f ; (tmp + 1)
3299 : 85 1c __ STA ACCU + 1 
329b : b1 1b __ LDA (ACCU + 0),y 
329d : d0 ed __ BNE $328c ; (core_drawscore.s8 + 0)
.s1001:
329f : 60 __ __ RTS
--------------------------------------------------------------------
32a0 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
os_roomimage_load: ; os_roomimage_load()->void
.s0:
32a1 : ad 04 3d LDA $3d04 ; (slowmode + 0)
32a4 : c9 02 __ CMP #$02
32a6 : f0 39 __ BEQ $32e1 ; (os_roomimage_load.s1 + 0)
.s3:
32a8 : ad 50 3d LDA $3d50 ; (roomimg + 0)
32ab : 85 47 __ STA T4 + 0 
32ad : ad 51 3d LDA $3d51 ; (roomimg + 1)
32b0 : 85 48 __ STA T4 + 1 
32b2 : ac c4 3c LDY $3cc4 ; (room + 0)
32b5 : b1 47 __ LDA (T4 + 0),y 
32b7 : 85 50 __ STA T2 + 0 
32b9 : cd 05 3d CMP $3d05 ; (curimageid + 0)
32bc : f0 1a __ BEQ $32d8 ; (os_roomimage_load.s46 + 0)
.s4:
32be : ad 04 3d LDA $3d04 ; (slowmode + 0)
32c1 : c9 04 __ CMP #$04
32c3 : f0 10 __ BEQ $32d5 ; (os_roomimage_load.s7 + 0)
.s8:
32c5 : a5 50 __ LDA T2 + 0 
32c7 : 8d 07 3e STA $3e07 ; (imageid + 0)
32ca : 20 57 2c JSR $2c57 ; (ui_room_update.s0 + 0)
32cd : a5 50 __ LDA T2 + 0 
32cf : 8d 05 3d STA $3d05 ; (curimageid + 0)
32d2 : 4c d8 32 JMP $32d8 ; (os_roomimage_load.s46 + 0)
.s7:
32d5 : 20 ec 32 JSR $32ec ; (ui_image_clear.s0 + 0)
.s46:
32d8 : 20 2f 31 JSR $312f ; (ui_status_update.s0 + 0)
.l38:
32db : 2c 11 d0 BIT $d011 
32de : 10 fb __ BPL $32db ; (os_roomimage_load.l38 + 0)
.s1001:
32e0 : 60 __ __ RTS
.s1:
32e1 : ad 05 3d LDA $3d05 ; (curimageid + 0)
32e4 : f0 f2 __ BEQ $32d8 ; (os_roomimage_load.s46 + 0)
.s28:
32e6 : a9 00 __ LDA #$00
32e8 : 85 50 __ STA T2 + 0 
32ea : f0 d2 __ BEQ $32be ; (os_roomimage_load.s4 + 0)
--------------------------------------------------------------------
ui_image_clear: ; ui_image_clear()->void
.s0:
32ec : a9 00 __ LDA #$00
32ee : 85 0f __ STA P2 
32f0 : 85 10 __ STA P3 
32f2 : 85 11 __ STA P4 
32f4 : 85 0d __ STA P0 
32f6 : a9 0f __ LDA #$0f
32f8 : 85 12 __ STA P5 
32fa : a9 e0 __ LDA #$e0
32fc : 85 0e __ STA P1 
32fe : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
3301 : a9 00 __ LDA #$00
3303 : 85 0f __ STA P2 
3305 : 85 10 __ STA P3 
3307 : a9 07 __ LDA #$07
3309 : 85 11 __ STA P4 
330b : a9 02 __ LDA #$02
330d : 85 12 __ STA P5 
330f : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
3312 : 85 0d __ STA P0 
3314 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
3317 : 85 0e __ STA P1 
3319 : 20 8f 0c JSR $0c8f ; (memset.s0 + 0)
331c : a9 00 __ LDA #$00
331e : 85 0f __ STA P2 
3320 : 85 10 __ STA P3 
3322 : 85 0d __ STA P0 
3324 : a9 07 __ LDA #$07
3326 : 85 11 __ STA P4 
3328 : a9 02 __ LDA #$02
332a : 85 12 __ STA P5 
332c : a9 f0 __ LDA #$f0
332e : 85 0e __ STA P1 
3330 : 4c 8f 0c JMP $0c8f ; (memset.s0 + 0)
--------------------------------------------------------------------
draw_roomobj: ; draw_roomobj()->void
.s1000:
3333 : a5 53 __ LDA T3 + 0 
3335 : 8d fe cb STA $cbfe ; (nm + 10)
.s0:
3338 : ad 28 3d LDA $3d28 ; (tmp2 + 0)
333b : 8d 8d 3d STA $3d8d ; (txt + 0)
333e : ad 29 3d LDA $3d29 ; (tmp2 + 1)
3341 : 8d 8e 3d STA $3d8e ; (txt + 1)
3344 : a9 00 __ LDA #$00
3346 : 8d 73 3d STA $3d73 ; (al + 0)
3349 : 85 51 __ STA T1 + 0 
334b : ad 2d 3d LDA $3d2d ; (obj_count + 0)
334e : d0 03 __ BNE $3353 ; (draw_roomobj.s24 + 0)
3350 : 4c 44 34 JMP $3444 ; (draw_roomobj.s4 + 0)
.s24:
3353 : a9 00 __ LDA #$00
3355 : 85 52 __ STA T2 + 0 
3357 : ad 5a 3d LDA $3d5a ; (objloc + 0)
335a : 85 4f __ STA T0 + 0 
335c : ad 5b 3d LDA $3d5b ; (objloc + 1)
335f : 85 50 __ STA T0 + 1 
3361 : ad 78 3d LDA $3d78 ; (varroom + 0)
3364 : 85 53 __ STA T3 + 0 
.l2:
3366 : a5 53 __ LDA T3 + 0 
3368 : a4 52 __ LDY T2 + 0 
336a : d1 4f __ CMP (T0 + 0),y 
336c : f0 03 __ BEQ $3371 ; (draw_roomobj.s5 + 0)
336e : 4c 38 34 JMP $3438 ; (draw_roomobj.s3 + 0)
.s5:
3371 : ad 58 3d LDA $3d58 ; (objattr + 0)
3374 : 85 45 __ STA T5 + 0 
3376 : ad 59 3d LDA $3d59 ; (objattr + 1)
3379 : 85 46 __ STA T5 + 1 
337b : ad 8f 3d LDA $3d8f ; (varattr + 0)
337e : 31 45 __ AND (T5 + 0),y 
3380 : cd 8f 3d CMP $3d8f ; (varattr + 0)
3383 : f0 03 __ BEQ $3388 ; (draw_roomobj.s8 + 0)
3385 : 4c 38 34 JMP $3438 ; (draw_roomobj.s3 + 0)
.s8:
3388 : ad 54 3d LDA $3d54 ; (objnameid + 0)
338b : 85 45 __ STA T5 + 0 
338d : ad 55 3d LDA $3d55 ; (objnameid + 1)
3390 : 85 46 __ STA T5 + 1 
3392 : b1 45 __ LDA (T5 + 0),y 
3394 : 8d 89 3d STA $3d89 ; (strid + 0)
3397 : c9 ff __ CMP #$ff
3399 : d0 03 __ BNE $339e ; (draw_roomobj.s12 + 0)
339b : 4c 38 34 JMP $3438 ; (draw_roomobj.s3 + 0)
.s12:
339e : ad 30 3d LDA $3d30 ; (advnames + 0)
33a1 : 8d 8a 3d STA $3d8a ; (str + 0)
33a4 : ad 31 3d LDA $3d31 ; (advnames + 1)
33a7 : 8d 8b 3d STA $3d8b ; (str + 1)
33aa : 20 8e 23 JSR $238e ; (_getstring.s0 + 0)
33ad : a9 01 __ LDA #$01
33af : 8d 97 3d STA $3d97 ; (txt_col + 0)
33b2 : ad 92 3d LDA $3d92 ; (ostr + 0)
33b5 : 85 43 __ STA T4 + 0 
33b7 : ad 93 3d LDA $3d93 ; (ostr + 1)
33ba : 85 44 __ STA T4 + 1 
33bc : ad 95 3d LDA $3d95 ; (etxt + 0)
33bf : 85 45 __ STA T5 + 0 
33c1 : ad 96 3d LDA $3d96 ; (etxt + 1)
33c4 : 85 46 __ STA T5 + 1 
33c6 : a5 51 __ LDA T1 + 0 
33c8 : f0 17 __ BEQ $33e1 ; (draw_roomobj.s17 + 0)
.s14:
33ca : ad 8d 3d LDA $3d8d ; (txt + 0)
33cd : 85 49 __ STA T8 + 0 
33cf : ad 8e 3d LDA $3d8e ; (txt + 1)
33d2 : 85 4a __ STA T8 + 1 
33d4 : a9 2c __ LDA #$2c
33d6 : a0 00 __ LDY #$00
33d8 : 91 49 __ STA (T8 + 0),y 
33da : a9 20 __ LDA #$20
33dc : c8 __ __ INY
33dd : 91 49 __ STA (T8 + 0),y 
33df : a9 02 __ LDA #$02
.s17:
33e1 : 85 47 __ STA T6 + 0 
33e3 : a5 44 __ LDA T4 + 1 
33e5 : c5 46 __ CMP T5 + 1 
33e7 : d0 04 __ BNE $33ed ; (draw_roomobj.s1007 + 0)
.s1006:
33e9 : a5 43 __ LDA T4 + 0 
33eb : c5 45 __ CMP T5 + 0 
.s1007:
33ed : b0 30 __ BCS $341f ; (draw_roomobj.s19 + 0)
.s23:
33ef : ad 8d 3d LDA $3d8d ; (txt + 0)
33f2 : 85 49 __ STA T8 + 0 
33f4 : ad 8e 3d LDA $3d8e ; (txt + 1)
33f7 : 85 4a __ STA T8 + 1 
.l18:
33f9 : a0 00 __ LDY #$00
33fb : b1 43 __ LDA (T4 + 0),y 
33fd : a4 47 __ LDY T6 + 0 
33ff : 91 49 __ STA (T8 + 0),y 
3401 : e6 47 __ INC T6 + 0 
3403 : e6 43 __ INC T4 + 0 
3405 : d0 02 __ BNE $3409 ; (draw_roomobj.s1015 + 0)
.s1014:
3407 : e6 44 __ INC T4 + 1 
.s1015:
3409 : a5 44 __ LDA T4 + 1 
340b : c5 46 __ CMP T5 + 1 
340d : d0 04 __ BNE $3413 ; (draw_roomobj.s1005 + 0)
.s1004:
340f : a5 43 __ LDA T4 + 0 
3411 : c5 45 __ CMP T5 + 0 
.s1005:
3413 : 90 e4 __ BCC $33f9 ; (draw_roomobj.l18 + 0)
.s26:
3415 : a5 43 __ LDA T4 + 0 
3417 : 8d 92 3d STA $3d92 ; (ostr + 0)
341a : a5 44 __ LDA T4 + 1 
341c : 8d 93 3d STA $3d93 ; (ostr + 1)
.s19:
341f : ad 8d 3d LDA $3d8d ; (txt + 0)
3422 : 18 __ __ CLC
3423 : 65 47 __ ADC T6 + 0 
3425 : 85 43 __ STA T4 + 0 
3427 : ad 8e 3d LDA $3d8e ; (txt + 1)
342a : 69 00 __ ADC #$00
342c : 85 44 __ STA T4 + 1 
342e : a9 00 __ LDA #$00
3430 : a8 __ __ TAY
3431 : 91 43 __ STA (T4 + 0),y 
3433 : 20 e7 24 JSR $24e7 ; (core_drawtext.l130 + 0)
3436 : e6 51 __ INC T1 + 0 
.s3:
3438 : e6 52 __ INC T2 + 0 
343a : a5 52 __ LDA T2 + 0 
343c : cd 2d 3d CMP $3d2d ; (obj_count + 0)
343f : b0 03 __ BCS $3444 ; (draw_roomobj.s4 + 0)
3441 : 4c 66 33 JMP $3366 ; (draw_roomobj.l2 + 0)
.s4:
3444 : a5 51 __ LDA T1 + 0 
3446 : f0 2d __ BEQ $3475 ; (draw_roomobj.s1001 + 0)
.s21:
3448 : a9 01 __ LDA #$01
344a : 8d 97 3d STA $3d97 ; (txt_col + 0)
344d : ad 8d 3d LDA $3d8d ; (txt + 0)
3450 : 85 4f __ STA T0 + 0 
3452 : ad 8e 3d LDA $3d8e ; (txt + 1)
3455 : 85 50 __ STA T0 + 1 
3457 : a9 2e __ LDA #$2e
3459 : a0 00 __ LDY #$00
345b : 91 4f __ STA (T0 + 0),y 
345d : 98 __ __ TYA
345e : c8 __ __ INY
345f : 91 4f __ STA (T0 + 0),y 
3461 : 20 e7 24 JSR $24e7 ; (core_drawtext.l130 + 0)
3464 : a9 00 __ LDA #$00
3466 : 8d 98 3d STA $3d98 ; (text_attach + 0)
3469 : ad 9b 3d LDA $3d9b ; (txt_y + 0)
346c : 38 __ __ SEC
346d : e9 0e __ SBC #$0e
346f : 8d c3 3c STA $3cc3 ; (text_y + 0)
3472 : 20 38 2a JSR $2a38 ; (cr.l30 + 0)
.s1001:
3475 : ad fe cb LDA $cbfe ; (nm + 10)
3478 : 85 53 __ STA T3 + 0 
347a : 60 __ __ RTS
--------------------------------------------------------------------
adv_onturn: ; adv_onturn()->void
.s0:
347b : a9 03 __ LDA #$03
347d : 8d 75 3d STA $3d75 ; (cmd + 0)
3480 : a9 ff __ LDA #$ff
3482 : 8d 76 3d STA $3d76 ; (obj1 + 0)
3485 : 4c 47 13 JMP $1347 ; (adv_run.s1000 + 0)
--------------------------------------------------------------------
parser_update: ; parser_update()->void
.s1000:
3488 : a5 53 __ LDA T3 + 0 
348a : 8d fd cb STA $cbfd ; (nm + 9)
348d : a5 54 __ LDA T3 + 1 
348f : 8d fe cb STA $cbfe ; (nm + 10)
.s0:
3492 : a9 00 __ LDA #$00
3494 : 8d 73 3d STA $3d73 ; (al + 0)
3497 : 8d 99 3d STA $3d99 ; (txt_rev + 0)
349a : a9 01 __ LDA #$01
349c : 8d 9a 3d STA $3d9a ; (txt_x + 0)
349f : ad c3 3c LDA $3cc3 ; (text_y + 0)
34a2 : 18 __ __ CLC
34a3 : 69 0e __ ADC #$0e
34a5 : 8d 9b 3d STA $3d9b ; (txt_y + 0)
34a8 : 0a __ __ ASL
34a9 : 85 1b __ STA ACCU + 0 
34ab : a9 00 __ LDA #$00
34ad : 2a __ __ ROL
34ae : 06 1b __ ASL ACCU + 0 
34b0 : 2a __ __ ROL
34b1 : aa __ __ TAX
34b2 : a5 1b __ LDA ACCU + 0 
34b4 : 6d 9b 3d ADC $3d9b ; (txt_y + 0)
34b7 : 85 44 __ STA T1 + 0 
34b9 : 8a __ __ TXA
34ba : 69 00 __ ADC #$00
34bc : 06 44 __ ASL T1 + 0 
34be : 2a __ __ ROL
34bf : 06 44 __ ASL T1 + 0 
34c1 : 2a __ __ ROL
34c2 : 06 44 __ ASL T1 + 0 
34c4 : 2a __ __ ROL
34c5 : 85 45 __ STA T1 + 1 
34c7 : ad b1 3c LDA $3cb1 ; (video_colorram + 0)
34ca : 85 4f __ STA T2 + 0 
34cc : 18 __ __ CLC
34cd : 65 44 __ ADC T1 + 0 
34cf : 85 53 __ STA T3 + 0 
34d1 : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
34d4 : 85 50 __ STA T2 + 1 
34d6 : 65 45 __ ADC T1 + 1 
34d8 : 85 54 __ STA T3 + 1 
34da : a9 0c __ LDA #$0c
34dc : 8d 97 3d STA $3d97 ; (txt_col + 0)
34df : a0 00 __ LDY #$00
34e1 : 91 53 __ STA (T3 + 0),y 
34e3 : ad af 3c LDA $3caf ; (video_ram + 0)
34e6 : 85 53 __ STA T3 + 0 
34e8 : 18 __ __ CLC
34e9 : 65 44 __ ADC T1 + 0 
34eb : 85 44 __ STA T1 + 0 
34ed : ad b0 3c LDA $3cb0 ; (video_ram + 1)
34f0 : 85 54 __ STA T3 + 1 
34f2 : 65 45 __ ADC T1 + 1 
34f4 : 85 45 __ STA T1 + 1 
34f6 : a9 3e __ LDA #$3e
34f8 : 91 44 __ STA (T1 + 0),y 
34fa : ad c1 3c LDA $3cc1 ; (strcmd + 0)
34fd : 8d 8d 3d STA $3d8d ; (txt + 0)
3500 : ad c2 3c LDA $3cc2 ; (strcmd + 1)
3503 : 8d 8e 3d STA $3d8e ; (txt + 1)
3506 : 20 e7 24 JSR $24e7 ; (core_drawtext.l130 + 0)
3509 : ad 9b 3d LDA $3d9b ; (txt_y + 0)
350c : 0a __ __ ASL
350d : 85 1b __ STA ACCU + 0 
350f : a9 00 __ LDA #$00
3511 : 8d 73 3d STA $3d73 ; (al + 0)
3514 : 2a __ __ ROL
3515 : 06 1b __ ASL ACCU + 0 
3517 : 2a __ __ ROL
3518 : aa __ __ TAX
3519 : a5 1b __ LDA ACCU + 0 
351b : 6d 9b 3d ADC $3d9b ; (txt_y + 0)
351e : 85 44 __ STA T1 + 0 
3520 : 8a __ __ TXA
3521 : 69 00 __ ADC #$00
3523 : 06 44 __ ASL T1 + 0 
3525 : 2a __ __ ROL
3526 : 06 44 __ ASL T1 + 0 
3528 : 2a __ __ ROL
3529 : 06 44 __ ASL T1 + 0 
352b : 2a __ __ ROL
352c : aa __ __ TAX
352d : ad 9a 3d LDA $3d9a ; (txt_x + 0)
3530 : 18 __ __ CLC
3531 : 65 44 __ ADC T1 + 0 
3533 : 85 44 __ STA T1 + 0 
3535 : 90 01 __ BCC $3538 ; (parser_update.s1003 + 0)
.s1002:
3537 : e8 __ __ INX
.s1003:
3538 : 8a __ __ TXA
3539 : 18 __ __ CLC
353a : 65 50 __ ADC T2 + 1 
353c : 85 50 __ STA T2 + 1 
353e : a9 00 __ LDA #$00
3540 : a4 44 __ LDY T1 + 0 
3542 : 91 4f __ STA (T2 + 0),y 
3544 : 8a __ __ TXA
3545 : 18 __ __ CLC
3546 : 65 54 __ ADC T3 + 1 
3548 : 85 45 __ STA T1 + 1 
354a : a9 20 __ LDA #$20
354c : a4 53 __ LDY T3 + 0 
354e : 91 44 __ STA (T1 + 0),y 
.l27:
3550 : 2c 11 d0 BIT $d011 
3553 : 10 fb __ BPL $3550 ; (parser_update.l27 + 0)
.s1001:
3555 : ad fd cb LDA $cbfd ; (nm + 9)
3558 : 85 53 __ STA T3 + 0 
355a : ad fe cb LDA $cbfe ; (nm + 10)
355d : 85 54 __ STA T3 + 1 
355f : 60 __ __ RTS
--------------------------------------------------------------------
hide_blink: ; hide_blink()->void
.s0:
3560 : ad 9b 3d LDA $3d9b ; (txt_y + 0)
3563 : 0a __ __ ASL
3564 : 85 1b __ STA ACCU + 0 
3566 : a9 00 __ LDA #$00
3568 : 2a __ __ ROL
3569 : 06 1b __ ASL ACCU + 0 
356b : 2a __ __ ROL
356c : aa __ __ TAX
356d : a5 1b __ LDA ACCU + 0 
356f : 6d 9b 3d ADC $3d9b ; (txt_y + 0)
3572 : 85 1b __ STA ACCU + 0 
3574 : 8a __ __ TXA
3575 : 69 00 __ ADC #$00
3577 : 06 1b __ ASL ACCU + 0 
3579 : 2a __ __ ROL
357a : 06 1b __ ASL ACCU + 0 
357c : 2a __ __ ROL
357d : 06 1b __ ASL ACCU + 0 
357f : 2a __ __ ROL
3580 : aa __ __ TAX
3581 : ad 9a 3d LDA $3d9a ; (txt_x + 0)
3584 : 18 __ __ CLC
3585 : 65 1b __ ADC ACCU + 0 
3587 : 90 01 __ BCC $358a ; (hide_blink.s1003 + 0)
.s1002:
3589 : e8 __ __ INX
.s1003:
358a : 18 __ __ CLC
358b : 6d b1 3c ADC $3cb1 ; (video_colorram + 0)
358e : 85 1b __ STA ACCU + 0 
3590 : 8a __ __ TXA
3591 : 6d b2 3c ADC $3cb2 ; (video_colorram + 1)
3594 : 85 1c __ STA ACCU + 1 
3596 : a9 00 __ LDA #$00
3598 : a8 __ __ TAY
3599 : 91 1b __ STA (ACCU + 0),y 
.s1001:
359b : 60 __ __ RTS
--------------------------------------------------------------------
execute: ; execute()->void
.s1000:
359c : a5 53 __ LDA T0 + 0 
359e : 8d d0 cb STA $cbd0 ; (execute@stack + 0)
35a1 : a5 54 __ LDA T0 + 1 
35a3 : 8d d1 cb STA $cbd1 ; (execute@stack + 1)
.s0:
35a6 : 20 38 2a JSR $2a38 ; (cr.l30 + 0)
35a9 : ad c1 3c LDA $3cc1 ; (strcmd + 0)
35ac : 85 53 __ STA T0 + 0 
35ae : 8d 8a 3d STA $3d8a ; (str + 0)
35b1 : ad c2 3c LDA $3cc2 ; (strcmd + 1)
35b4 : 85 54 __ STA T0 + 1 
35b6 : 8d 8b 3d STA $3d8b ; (str + 1)
35b9 : 20 d2 35 JSR $35d2 ; (adv_parse.s1000 + 0)
35bc : a9 00 __ LDA #$00
35be : 8d 24 3d STA $3d24 ; (icmd + 0)
35c1 : a8 __ __ TAY
35c2 : 91 53 __ STA (T0 + 0),y 
35c4 : 20 88 34 JSR $3488 ; (parser_update.s1000 + 0)
.s1001:
35c7 : ad d0 cb LDA $cbd0 ; (execute@stack + 0)
35ca : 85 53 __ STA T0 + 0 
35cc : ad d1 cb LDA $cbd1 ; (execute@stack + 1)
35cf : 85 54 __ STA T0 + 1 
35d1 : 60 __ __ RTS
--------------------------------------------------------------------
adv_parse: ; adv_parse()->void
.s1000:
35d2 : a2 03 __ LDX #$03
35d4 : b5 53 __ LDA T1 + 0,x 
35d6 : 9d d2 cb STA $cbd2,x ; (adv_parse@stack + 0)
35d9 : ca __ __ DEX
35da : 10 f8 __ BPL $35d4 ; (adv_parse.s1000 + 2)
.s0:
35dc : a9 ff __ LDA #$ff
35de : 8d 75 3d STA $3d75 ; (cmd + 0)
35e1 : a9 f9 __ LDA #$f9
35e3 : 8d 87 3d STA $3d87 ; (obj2 + 0)
35e6 : 8d 76 3d STA $3d76 ; (obj1 + 0)
35e9 : a9 00 __ LDA #$00
35eb : 8d 1c 3e STA $3e1c ; (obj2k + 0)
35ee : 8d 1b 3e STA $3e1b ; (obj1k + 0)
35f1 : ad 8a 3d LDA $3d8a ; (str + 0)
35f4 : 85 1b __ STA ACCU + 0 
35f6 : 8d 92 3d STA $3d92 ; (ostr + 0)
35f9 : ad 8b 3d LDA $3d8b ; (str + 1)
35fc : 85 1c __ STA ACCU + 1 
35fe : 8d 93 3d STA $3d93 ; (ostr + 1)
3601 : a0 00 __ LDY #$00
3603 : b1 1b __ LDA (ACCU + 0),y 
3605 : f0 26 __ BEQ $362d ; (adv_parse.s3 + 0)
.l4:
3607 : ad 92 3d LDA $3d92 ; (ostr + 0)
360a : 85 1b __ STA ACCU + 0 
360c : ad 93 3d LDA $3d93 ; (ostr + 1)
360f : 85 1c __ STA ACCU + 1 
3611 : a0 00 __ LDY #$00
3613 : b1 1b __ LDA (ACCU + 0),y 
3615 : c9 20 __ CMP #$20
3617 : d0 14 __ BNE $362d ; (adv_parse.s3 + 0)
.s2:
3619 : 18 __ __ CLC
361a : a5 1b __ LDA ACCU + 0 
361c : 69 01 __ ADC #$01
361e : 8d 92 3d STA $3d92 ; (ostr + 0)
3621 : a5 1c __ LDA ACCU + 1 
3623 : 69 00 __ ADC #$00
3625 : 8d 93 3d STA $3d93 ; (ostr + 1)
3628 : c8 __ __ INY
3629 : b1 1b __ LDA (ACCU + 0),y 
362b : d0 da __ BNE $3607 ; (adv_parse.l4 + 0)
.s3:
362d : ad 92 3d LDA $3d92 ; (ostr + 0)
3630 : 85 1b __ STA ACCU + 0 
3632 : ad 93 3d LDA $3d93 ; (ostr + 1)
3635 : 85 1c __ STA ACCU + 1 
3637 : a0 00 __ LDY #$00
3639 : b1 1b __ LDA (ACCU + 0),y 
363b : d0 0b __ BNE $3648 ; (adv_parse.l9 + 0)
.s1001:
363d : a2 03 __ LDX #$03
363f : bd d2 cb LDA $cbd2,x ; (adv_parse@stack + 0)
3642 : 95 53 __ STA T1 + 0,x 
3644 : ca __ __ DEX
3645 : 10 f8 __ BPL $363f ; (adv_parse.s1001 + 2)
3647 : 60 __ __ RTS
.l9:
3648 : 8c 1d 3e STY $3e1d ; (strdir + 0)
364b : 8c 1e 3e STY $3e1e ; (strdir + 1)
364e : ad 75 3d LDA $3d75 ; (cmd + 0)
3651 : 85 53 __ STA T1 + 0 
3653 : c9 ff __ CMP #$ff
3655 : f0 1f __ BEQ $3676 ; (adv_parse.s1002 + 0)
.s1003:
3657 : a9 00 __ LDA #$00
3659 : 85 56 __ STA T3 + 0 
365b : ad 3a 3d LDA $3d3a ; (objs + 0)
365e : 8d 8a 3d STA $3d8a ; (str + 0)
3661 : ad 3b 3d LDA $3d3b ; (objs + 1)
3664 : 8d 8b 3d STA $3d8b ; (str + 1)
3667 : ad 3c 3d LDA $3d3c ; (objs_dir + 0)
366a : 8d 1d 3e STA $3e1d ; (strdir + 0)
366d : ad 3d 3d LDA $3d3d ; (objs_dir + 1)
3670 : 8d 1e 3e STA $3e1e ; (strdir + 1)
3673 : 4c 86 36 JMP $3686 ; (adv_parse.s13 + 0)
.s1002:
3676 : a9 01 __ LDA #$01
3678 : 85 56 __ STA T3 + 0 
367a : ad 38 3d LDA $3d38 ; (verbs + 0)
367d : 8d 8a 3d STA $3d8a ; (str + 0)
3680 : ad 39 3d LDA $3d39 ; (verbs + 1)
3683 : 8d 8b 3d STA $3d8b ; (str + 1)
.s13:
3686 : ad 92 3d LDA $3d92 ; (ostr + 0)
3689 : 85 54 __ STA T2 + 0 
368b : ad 93 3d LDA $3d93 ; (ostr + 1)
368e : 85 55 __ STA T2 + 1 
3690 : 20 b7 37 JSR $37b7 ; (_findstring.s0 + 0)
3693 : ad 1f 3e LDA $3e1f ; (cmdid + 0)
3696 : c9 ff __ CMP #$ff
3698 : d0 03 __ BNE $369d ; (adv_parse.s14 + 0)
369a : 4c 51 37 JMP $3751 ; (adv_parse.s15 + 0)
.s14:
369d : a5 56 __ LDA T3 + 0 
369f : f0 24 __ BEQ $36c5 ; (adv_parse.s18 + 0)
.s17:
36a1 : ad 1f 3e LDA $3e1f ; (cmdid + 0)
36a4 : 8d 75 3d STA $3d75 ; (cmd + 0)
36a7 : a9 09 __ LDA #$09
36a9 : 85 11 __ STA P4 
36ab : ad 70 3d LDA $3d70 ; (vrb + 0)
36ae : 85 0d __ STA P0 
36b0 : ad 71 3d LDA $3d71 ; (vrb + 1)
36b3 : 85 0e __ STA P1 
36b5 : ad 6e 3d LDA $3d6e ; (tmp + 0)
36b8 : 85 0f __ STA P2 
36ba : ad 6f 3d LDA $3d6f ; (tmp + 1)
36bd : 85 10 __ STA P3 
36bf : 20 a7 3a JSR $3aa7 ; (strncpy.s0 + 0)
36c2 : 4c e4 36 JMP $36e4 ; (adv_parse.s137 + 0)
.s18:
36c5 : ad 1b 3e LDA $3e1b ; (obj1k + 0)
36c8 : d0 0a __ BNE $36d4 ; (adv_parse.s21 + 0)
.s20:
36ca : ad 1f 3e LDA $3e1f ; (cmdid + 0)
36cd : 8d 76 3d STA $3d76 ; (obj1 + 0)
36d0 : a9 01 __ LDA #$01
36d2 : d0 77 __ BNE $374b ; (adv_parse.s1023 + 0)
.s21:
36d4 : ad 1c 3e LDA $3e1c ; (obj2k + 0)
36d7 : d0 0b __ BNE $36e4 ; (adv_parse.s137 + 0)
.s23:
36d9 : ad 1f 3e LDA $3e1f ; (cmdid + 0)
36dc : 8d 87 3d STA $3d87 ; (obj2 + 0)
36df : a9 01 __ LDA #$01
.s1024:
36e1 : 8d 1c 3e STA $3e1c ; (obj2k + 0)
.s137:
36e4 : ad 92 3d LDA $3d92 ; (ostr + 0)
36e7 : 85 54 __ STA T2 + 0 
36e9 : ad 93 3d LDA $3d93 ; (ostr + 1)
36ec : 85 55 __ STA T2 + 1 
36ee : a0 00 __ LDY #$00
36f0 : b1 54 __ LDA (T2 + 0),y 
36f2 : f0 26 __ BEQ $371a ; (adv_parse.s8 + 0)
.l47:
36f4 : ad 92 3d LDA $3d92 ; (ostr + 0)
36f7 : 85 54 __ STA T2 + 0 
36f9 : ad 93 3d LDA $3d93 ; (ostr + 1)
36fc : 85 55 __ STA T2 + 1 
36fe : a0 00 __ LDY #$00
3700 : b1 54 __ LDA (T2 + 0),y 
3702 : c9 20 __ CMP #$20
3704 : d0 14 __ BNE $371a ; (adv_parse.s8 + 0)
.s45:
3706 : 18 __ __ CLC
3707 : a5 54 __ LDA T2 + 0 
3709 : 69 01 __ ADC #$01
370b : 8d 92 3d STA $3d92 ; (ostr + 0)
370e : a5 55 __ LDA T2 + 1 
3710 : 69 00 __ ADC #$00
3712 : 8d 93 3d STA $3d93 ; (ostr + 1)
3715 : c8 __ __ INY
3716 : b1 54 __ LDA (T2 + 0),y 
3718 : d0 da __ BNE $36f4 ; (adv_parse.l47 + 0)
.s8:
371a : ad 92 3d LDA $3d92 ; (ostr + 0)
371d : 85 54 __ STA T2 + 0 
371f : ad 93 3d LDA $3d93 ; (ostr + 1)
3722 : 85 55 __ STA T2 + 1 
3724 : a0 00 __ LDY #$00
3726 : b1 54 __ LDA (T2 + 0),y 
3728 : f0 03 __ BEQ $372d ; (adv_parse.s10 + 0)
372a : 4c 48 36 JMP $3648 ; (adv_parse.l9 + 0)
.s10:
372d : 20 47 13 JSR $1347 ; (adv_run.s1000 + 0)
3730 : 20 7b 34 JSR $347b ; (adv_onturn.s0 + 0)
3733 : ad 13 3d LDA $3d13 ; (nextroom + 0)
3736 : c9 fa __ CMP #$fa
3738 : d0 03 __ BNE $373d ; (adv_parse.s48 + 0)
373a : 4c 3d 36 JMP $363d ; (adv_parse.s1001 + 0)
.s48:
373d : 8d 74 3d STA $3d74 ; (newroom + 0)
3740 : a9 fa __ LDA #$fa
3742 : 8d 13 3d STA $3d13 ; (nextroom + 0)
3745 : 20 d3 12 JSR $12d3 ; (room_load.s1000 + 0)
3748 : 4c 3d 36 JMP $363d ; (adv_parse.s1001 + 0)
.s1023:
374b : 8d 1b 3e STA $3e1b ; (obj1k + 0)
374e : 4c e4 36 JMP $36e4 ; (adv_parse.s137 + 0)
.s15:
3751 : a5 53 __ LDA T1 + 0 
3753 : c9 ff __ CMP #$ff
3755 : f0 8d __ BEQ $36e4 ; (adv_parse.s137 + 0)
.s26:
3757 : a5 54 __ LDA T2 + 0 
3759 : 8d 92 3d STA $3d92 ; (ostr + 0)
375c : a5 55 __ LDA T2 + 1 
375e : 8d 93 3d STA $3d93 ; (ostr + 1)
3761 : a9 00 __ LDA #$00
3763 : 8d 1d 3e STA $3e1d ; (strdir + 0)
3766 : 8d 1e 3e STA $3e1e ; (strdir + 1)
3769 : ad 3e 3d LDA $3d3e ; (rooms + 0)
376c : 8d 8a 3d STA $3d8a ; (str + 0)
376f : ad 3f 3d LDA $3d3f ; (rooms + 1)
3772 : 8d 8b 3d STA $3d8b ; (str + 1)
3775 : 20 b7 37 JSR $37b7 ; (_findstring.s0 + 0)
3778 : ad 1b 3e LDA $3e1b ; (obj1k + 0)
377b : f0 1a __ BEQ $3797 ; (adv_parse.s29 + 0)
.s30:
377d : ad 1c 3e LDA $3e1c ; (obj2k + 0)
3780 : f0 03 __ BEQ $3785 ; (adv_parse.s38 + 0)
3782 : 4c e4 36 JMP $36e4 ; (adv_parse.s137 + 0)
.s38:
3785 : ad 1f 3e LDA $3e1f ; (cmdid + 0)
3788 : c9 ff __ CMP #$ff
378a : d0 03 __ BNE $378f ; (adv_parse.s41 + 0)
378c : 4c e4 36 JMP $36e4 ; (adv_parse.s137 + 0)
.s41:
378f : 8d 87 3d STA $3d87 ; (obj2 + 0)
3792 : a9 02 __ LDA #$02
3794 : 4c e1 36 JMP $36e1 ; (adv_parse.s1024 + 0)
.s29:
3797 : ad 1f 3e LDA $3e1f ; (cmdid + 0)
379a : c9 ff __ CMP #$ff
379c : d0 12 __ BNE $37b0 ; (adv_parse.s32 + 0)
.s33:
379e : ad 76 3d LDA $3d76 ; (obj1 + 0)
37a1 : c9 f9 __ CMP #$f9
37a3 : f0 03 __ BEQ $37a8 ; (adv_parse.s35 + 0)
37a5 : 4c e4 36 JMP $36e4 ; (adv_parse.s137 + 0)
.s35:
37a8 : a9 ff __ LDA #$ff
37aa : 8d 76 3d STA $3d76 ; (obj1 + 0)
37ad : 4c e4 36 JMP $36e4 ; (adv_parse.s137 + 0)
.s32:
37b0 : 8d 76 3d STA $3d76 ; (obj1 + 0)
37b3 : a9 02 __ LDA #$02
37b5 : d0 94 __ BNE $374b ; (adv_parse.s1023 + 0)
--------------------------------------------------------------------
_findstring: ; _findstring()->void
.s0:
37b7 : a9 00 __ LDA #$00
37b9 : 8d 1f 3e STA $3e1f ; (cmdid + 0)
37bc : 8d 82 3d STA $3d82 ; (i + 0)
37bf : 8d 83 3d STA $3d83 ; (i + 1)
37c2 : ad 1e 3e LDA $3e1e ; (strdir + 1)
37c5 : 85 44 __ STA T0 + 1 
37c7 : ad 1d 3e LDA $3e1d ; (strdir + 0)
37ca : 85 43 __ STA T0 + 0 
37cc : 05 44 __ ORA T0 + 1 
37ce : f0 2d __ BEQ $37fd ; (_findstring.s10 + 0)
.s1:
37d0 : ad 92 3d LDA $3d92 ; (ostr + 0)
37d3 : 85 45 __ STA T1 + 0 
37d5 : ad 93 3d LDA $3d93 ; (ostr + 1)
37d8 : 85 46 __ STA T1 + 1 
37da : a0 00 __ LDY #$00
37dc : b1 45 __ LDA (T1 + 0),y 
37de : c9 1a __ CMP #$1a
37e0 : b0 1b __ BCS $37fd ; (_findstring.s10 + 0)
.s4:
37e2 : 0a __ __ ASL
37e3 : a8 __ __ TAY
37e4 : b1 43 __ LDA (T0 + 0),y 
37e6 : 8d 82 3d STA $3d82 ; (i + 0)
37e9 : c8 __ __ INY
37ea : b1 43 __ LDA (T0 + 0),y 
37ec : 8d 83 3d STA $3d83 ; (i + 1)
37ef : c9 ff __ CMP #$ff
37f1 : d0 0a __ BNE $37fd ; (_findstring.s10 + 0)
.s1015:
37f3 : ad 82 3d LDA $3d82 ; (i + 0)
37f6 : c9 ff __ CMP #$ff
37f8 : d0 03 __ BNE $37fd ; (_findstring.s10 + 0)
37fa : 4c a7 38 JMP $38a7 ; (_findstring.s9 + 0)
.s10:
37fd : ad 8a 3d LDA $3d8a ; (str + 0)
3800 : 18 __ __ CLC
3801 : 6d 82 3d ADC $3d82 ; (i + 0)
3804 : 85 43 __ STA T0 + 0 
3806 : ad 8b 3d LDA $3d8b ; (str + 1)
3809 : 6d 83 3d ADC $3d83 ; (i + 1)
380c : 85 44 __ STA T0 + 1 
380e : a0 00 __ LDY #$00
3810 : b1 43 __ LDA (T0 + 0),y 
3812 : d0 03 __ BNE $3817 ; (_findstring.l11 + 0)
3814 : 4c a7 38 JMP $38a7 ; (_findstring.s9 + 0)
.l11:
3817 : ad 82 3d LDA $3d82 ; (i + 0)
381a : 85 43 __ STA T0 + 0 
381c : 18 __ __ CLC
381d : 69 01 __ ADC #$01
381f : 85 45 __ STA T1 + 0 
3821 : 8d 82 3d STA $3d82 ; (i + 0)
3824 : ad 83 3d LDA $3d83 ; (i + 1)
3827 : 85 44 __ STA T0 + 1 
3829 : 69 00 __ ADC #$00
382b : 85 46 __ STA T1 + 1 
382d : 8d 83 3d STA $3d83 ; (i + 1)
3830 : ad 8a 3d LDA $3d8a ; (str + 0)
3833 : 85 48 __ STA T4 + 0 
3835 : 18 __ __ CLC
3836 : 65 43 __ ADC T0 + 0 
3838 : 85 43 __ STA T0 + 0 
383a : ad 8b 3d LDA $3d8b ; (str + 1)
383d : 85 49 __ STA T4 + 1 
383f : 65 44 __ ADC T0 + 1 
3841 : 85 44 __ STA T0 + 1 
3843 : a0 00 __ LDY #$00
3845 : b1 43 __ LDA (T0 + 0),y 
3847 : 85 47 __ STA T2 + 0 
3849 : 8d 94 3d STA $3d94 ; (len + 0)
384c : ad 92 3d LDA $3d92 ; (ostr + 0)
384f : 85 4a __ STA T5 + 0 
3851 : ad 93 3d LDA $3d93 ; (ostr + 1)
3854 : 85 4b __ STA T5 + 1 
3856 : c8 __ __ INY
3857 : b1 43 __ LDA (T0 + 0),y 
3859 : 88 __ __ DEY
385a : d1 4a __ CMP (T5 + 0),y 
385c : d0 03 __ BNE $3861 ; (_findstring.s14 + 0)
385e : 4c 49 39 JMP $3949 ; (_findstring.s13 + 0)
.s14:
3861 : ad 1d 3e LDA $3e1d ; (strdir + 0)
3864 : 0d 1e 3e ORA $3e1e ; (strdir + 1)
3867 : d0 3e __ BNE $38a7 ; (_findstring.s9 + 0)
.s15:
3869 : 18 __ __ CLC
386a : a5 47 __ LDA T2 + 0 
386c : 65 45 __ ADC T1 + 0 
386e : 85 43 __ STA T0 + 0 
3870 : a9 00 __ LDA #$00
3872 : 65 46 __ ADC T1 + 1 
3874 : aa __ __ TAX
3875 : 18 __ __ CLC
3876 : a5 43 __ LDA T0 + 0 
3878 : 69 01 __ ADC #$01
387a : 85 45 __ STA T1 + 0 
387c : 8a __ __ TXA
387d : 69 00 __ ADC #$00
387f : 85 46 __ STA T1 + 1 
3881 : 8a __ __ TXA
3882 : 18 __ __ CLC
3883 : 65 49 __ ADC T4 + 1 
3885 : 85 44 __ STA T0 + 1 
3887 : a4 48 __ LDY T4 + 0 
3889 : b1 43 __ LDA (T0 + 0),y 
388b : aa __ __ TAX
388c : c8 __ __ INY
388d : b1 43 __ LDA (T0 + 0),y 
388f : e0 ff __ CPX #$ff
3891 : d0 03 __ BNE $3896 ; (_findstring.s39 + 0)
3893 : 4c 17 39 JMP $3917 ; (_findstring.s38 + 0)
.s39:
3896 : aa __ __ TAX
3897 : a5 45 __ LDA T1 + 0 
3899 : 8d 82 3d STA $3d82 ; (i + 0)
389c : a5 46 __ LDA T1 + 1 
389e : 8d 83 3d STA $3d83 ; (i + 1)
38a1 : 8a __ __ TXA
38a2 : f0 03 __ BEQ $38a7 ; (_findstring.s9 + 0)
38a4 : 4c 17 38 JMP $3817 ; (_findstring.l11 + 0)
.s9:
38a7 : a9 ff __ LDA #$ff
38a9 : 8d 1f 3e STA $3e1f ; (cmdid + 0)
38ac : a9 00 __ LDA #$00
38ae : 8d 82 3d STA $3d82 ; (i + 0)
38b1 : 8d 83 3d STA $3d83 ; (i + 1)
38b4 : ad 92 3d LDA $3d92 ; (ostr + 0)
38b7 : 85 43 __ STA T0 + 0 
38b9 : ad 93 3d LDA $3d93 ; (ostr + 1)
38bc : 85 44 __ STA T0 + 1 
38be : a0 00 __ LDY #$00
38c0 : b1 43 __ LDA (T0 + 0),y 
38c2 : f0 52 __ BEQ $3916 ; (_findstring.s1001 + 0)
.l44:
38c4 : ad 92 3d LDA $3d92 ; (ostr + 0)
38c7 : 85 43 __ STA T0 + 0 
38c9 : ad 93 3d LDA $3d93 ; (ostr + 1)
38cc : 85 44 __ STA T0 + 1 
38ce : a0 00 __ LDY #$00
38d0 : b1 43 __ LDA (T0 + 0),y 
38d2 : c9 20 __ CMP #$20
38d4 : f0 40 __ BEQ $3916 ; (_findstring.s1001 + 0)
.s42:
38d6 : aa __ __ TAX
38d7 : 18 __ __ CLC
38d8 : a5 43 __ LDA T0 + 0 
38da : 69 01 __ ADC #$01
38dc : 8d 92 3d STA $3d92 ; (ostr + 0)
38df : a5 44 __ LDA T0 + 1 
38e1 : 69 00 __ ADC #$00
38e3 : 8d 93 3d STA $3d93 ; (ostr + 1)
38e6 : ad 82 3d LDA $3d82 ; (i + 0)
38e9 : 85 45 __ STA T1 + 0 
38eb : ad 83 3d LDA $3d83 ; (i + 1)
38ee : d0 20 __ BNE $3910 ; (_findstring.s114 + 0)
.s1002:
38f0 : a5 45 __ LDA T1 + 0 
38f2 : c9 20 __ CMP #$20
38f4 : b0 1a __ BCS $3910 ; (_findstring.s114 + 0)
.s45:
38f6 : 8c 83 3d STY $3d83 ; (i + 1)
38f9 : 69 01 __ ADC #$01
38fb : 8d 82 3d STA $3d82 ; (i + 0)
38fe : ad 6e 3d LDA $3d6e ; (tmp + 0)
3901 : 18 __ __ CLC
3902 : 65 45 __ ADC T1 + 0 
3904 : 85 45 __ STA T1 + 0 
3906 : ad 6f 3d LDA $3d6f ; (tmp + 1)
3909 : 69 00 __ ADC #$00
390b : 85 46 __ STA T1 + 1 
390d : 8a __ __ TXA
390e : 91 45 __ STA (T1 + 0),y 
.s114:
3910 : a0 01 __ LDY #$01
3912 : b1 43 __ LDA (T0 + 0),y 
3914 : d0 ae __ BNE $38c4 ; (_findstring.l44 + 0)
.s1001:
3916 : 60 __ __ RTS
.s38:
3917 : 0a __ __ ASL
3918 : a0 00 __ LDY #$00
391a : 90 01 __ BCC $391d ; (_findstring.s1025 + 0)
.s1024:
391c : c8 __ __ INY
.s1025:
391d : 18 __ __ CLC
391e : 65 45 __ ADC T1 + 0 
3920 : aa __ __ TAX
3921 : 98 __ __ TYA
3922 : 65 46 __ ADC T1 + 1 
3924 : a8 __ __ TAY
3925 : 8a __ __ TXA
3926 : 18 __ __ CLC
3927 : 69 01 __ ADC #$01
3929 : 8d 82 3d STA $3d82 ; (i + 0)
392c : 98 __ __ TYA
392d : 69 00 __ ADC #$00
392f : 8d 83 3d STA $3d83 ; (i + 1)
3932 : 8a __ __ TXA
3933 : 18 __ __ CLC
3934 : 65 48 __ ADC T4 + 0 
3936 : 85 43 __ STA T0 + 0 
3938 : 98 __ __ TYA
3939 : 65 49 __ ADC T4 + 1 
393b : 85 44 __ STA T0 + 1 
393d : a0 01 __ LDY #$01
393f : b1 43 __ LDA (T0 + 0),y 
3941 : d0 03 __ BNE $3946 ; (_findstring.s1025 + 41)
3943 : 4c a7 38 JMP $38a7 ; (_findstring.s9 + 0)
3946 : 4c 17 38 JMP $3817 ; (_findstring.l11 + 0)
.s13:
3949 : 18 __ __ CLC
394a : a5 43 __ LDA T0 + 0 
394c : 69 01 __ ADC #$01
394e : 85 0f __ STA P2 
3950 : a5 44 __ LDA T0 + 1 
3952 : 69 00 __ ADC #$00
3954 : 85 10 __ STA P3 
3956 : 18 __ __ CLC
3957 : a5 47 __ LDA T2 + 0 
3959 : 65 4a __ ADC T5 + 0 
395b : 85 4c __ STA T8 + 0 
395d : a5 4b __ LDA T5 + 1 
395f : 69 00 __ ADC #$00
3961 : 85 4d __ STA T8 + 1 
3963 : a4 47 __ LDY T2 + 0 
3965 : b1 4a __ LDA (T5 + 0),y 
3967 : f0 07 __ BEQ $3970 ; (_findstring.s16 + 0)
.s19:
3969 : c9 20 __ CMP #$20
396b : f0 03 __ BEQ $3970 ; (_findstring.s16 + 0)
396d : 4c 69 38 JMP $3869 ; (_findstring.s15 + 0)
.s16:
3970 : 84 11 __ STY P4 
3972 : a5 4a __ LDA T5 + 0 
3974 : 85 0d __ STA P0 
3976 : a5 4b __ LDA T5 + 1 
3978 : 85 0e __ STA P1 
397a : a9 00 __ LDA #$00
397c : 85 12 __ STA P5 
397e : 20 53 3a JSR $3a53 ; (memcmp.s0 + 0)
3981 : a5 1b __ LDA ACCU + 0 
3983 : 05 1c __ ORA ACCU + 1 
3985 : f0 03 __ BEQ $398a ; (_findstring.s20 + 0)
3987 : 4c 69 38 JMP $3869 ; (_findstring.s15 + 0)
.s20:
398a : a5 47 __ LDA T2 + 0 
398c : 85 11 __ STA P4 
398e : a9 00 __ LDA #$00
3990 : 85 12 __ STA P5 
3992 : 18 __ __ CLC
3993 : a5 48 __ LDA T4 + 0 
3995 : 65 45 __ ADC T1 + 0 
3997 : 85 0f __ STA P2 
3999 : a5 49 __ LDA T4 + 1 
399b : 65 46 __ ADC T1 + 1 
399d : 85 10 __ STA P3 
399f : ad 6e 3d LDA $3d6e ; (tmp + 0)
39a2 : 85 43 __ STA T0 + 0 
39a4 : 85 0d __ STA P0 
39a6 : ad 6f 3d LDA $3d6f ; (tmp + 1)
39a9 : 85 44 __ STA T0 + 1 
39ab : 85 0e __ STA P1 
39ad : 20 60 0c JSR $0c60 ; (memcpy.s0 + 0)
39b0 : a5 4c __ LDA T8 + 0 
39b2 : 8d 92 3d STA $3d92 ; (ostr + 0)
39b5 : a5 4d __ LDA T8 + 1 
39b7 : 8d 93 3d STA $3d93 ; (ostr + 1)
39ba : 18 __ __ CLC
39bb : a5 45 __ LDA T1 + 0 
39bd : 65 47 __ ADC T2 + 0 
39bf : 8d 82 3d STA $3d82 ; (i + 0)
39c2 : aa __ __ TAX
39c3 : a5 46 __ LDA T1 + 1 
39c5 : 69 00 __ ADC #$00
39c7 : 85 46 __ STA T1 + 1 
39c9 : 8d 83 3d STA $3d83 ; (i + 1)
39cc : a9 00 __ LDA #$00
39ce : a4 47 __ LDY T2 + 0 
39d0 : 91 43 __ STA (T0 + 0),y 
39d2 : 86 43 __ STX T0 + 0 
39d4 : 18 __ __ CLC
39d5 : a5 49 __ LDA T4 + 1 
39d7 : 65 46 __ ADC T1 + 1 
39d9 : 85 44 __ STA T0 + 1 
39db : a4 48 __ LDY T4 + 0 
39dd : b1 43 __ LDA (T0 + 0),y 
39df : 8d 1f 3e STA $3e1f ; (cmdid + 0)
39e2 : c9 ff __ CMP #$ff
39e4 : f0 01 __ BEQ $39e7 ; (_findstring.s23 + 0)
39e6 : 60 __ __ RTS
.s23:
39e7 : 8a __ __ TXA
39e8 : 18 __ __ CLC
39e9 : 69 02 __ ADC #$02
39eb : 8d 82 3d STA $3d82 ; (i + 0)
39ee : a5 46 __ LDA T1 + 1 
39f0 : 69 00 __ ADC #$00
39f2 : 8d 83 3d STA $3d83 ; (i + 1)
39f5 : c8 __ __ INY
39f6 : b1 43 __ LDA (T0 + 0),y 
39f8 : aa __ __ TAX
39f9 : 18 __ __ CLC
39fa : 69 ff __ ADC #$ff
39fc : 8d 94 3d STA $3d94 ; (len + 0)
39ff : 8a __ __ TXA
3a00 : d0 01 __ BNE $3a03 ; (_findstring.s49 + 0)
3a02 : 60 __ __ RTS
.s49:
3a03 : ad c4 3c LDA $3cc4 ; (room + 0)
3a06 : 85 47 __ STA T2 + 0 
.l27:
3a08 : 18 __ __ CLC
3a09 : a5 48 __ LDA T4 + 0 
3a0b : 6d 82 3d ADC $3d82 ; (i + 0)
3a0e : 85 45 __ STA T1 + 0 
3a10 : a5 49 __ LDA T4 + 1 
3a12 : 6d 83 3d ADC $3d83 ; (i + 1)
3a15 : 85 46 __ STA T1 + 1 
3a17 : a0 01 __ LDY #$01
3a19 : b1 45 __ LDA (T1 + 0),y 
3a1b : 8d 1f 3e STA $3e1f ; (cmdid + 0)
3a1e : ae 82 3d LDX $3d82 ; (i + 0)
3a21 : 8a __ __ TXA
3a22 : 18 __ __ CLC
3a23 : 69 01 __ ADC #$01
3a25 : 8d 82 3d STA $3d82 ; (i + 0)
3a28 : ad 83 3d LDA $3d83 ; (i + 1)
3a2b : 85 44 __ STA T0 + 1 
3a2d : 69 00 __ ADC #$00
3a2f : 8d 83 3d STA $3d83 ; (i + 1)
3a32 : a5 47 __ LDA T2 + 0 
3a34 : 88 __ __ DEY
3a35 : d1 45 __ CMP (T1 + 0),y 
3a37 : d0 01 __ BNE $3a3a ; (_findstring.s31 + 0)
3a39 : 60 __ __ RTS
.s31:
3a3a : 8a __ __ TXA
3a3b : 18 __ __ CLC
3a3c : 69 02 __ ADC #$02
3a3e : 8d 82 3d STA $3d82 ; (i + 0)
3a41 : a5 44 __ LDA T0 + 1 
3a43 : 69 00 __ ADC #$00
3a45 : 8d 83 3d STA $3d83 ; (i + 1)
3a48 : ad 94 3d LDA $3d94 ; (len + 0)
3a4b : ce 94 3d DEC $3d94 ; (len + 0)
3a4e : 09 00 __ ORA #$00
3a50 : d0 b6 __ BNE $3a08 ; (_findstring.l27 + 0)
3a52 : 60 __ __ RTS
--------------------------------------------------------------------
memcmp: ; memcmp(const void*,const void*,i16)->i16
.s0:
3a53 : a5 11 __ LDA P4 ; (size + 0)
3a55 : aa __ __ TAX
3a56 : 18 __ __ CLC
3a57 : 69 ff __ ADC #$ff
3a59 : 85 11 __ STA P4 ; (size + 0)
3a5b : a5 12 __ LDA P5 ; (size + 1)
3a5d : 85 1c __ STA ACCU + 1 
3a5f : 69 ff __ ADC #$ff
3a61 : 85 12 __ STA P5 ; (size + 1)
3a63 : 8a __ __ TXA
3a64 : 05 1c __ ORA ACCU + 1 
3a66 : f0 3a __ BEQ $3aa2 ; (memcmp.s1006 + 0)
.s1008:
3a68 : a6 11 __ LDX P4 ; (size + 0)
.l2:
3a6a : a0 00 __ LDY #$00
3a6c : b1 0d __ LDA (P0),y ; (ptr1 + 0)
3a6e : d1 0f __ CMP (P2),y ; (ptr2 + 0)
3a70 : b0 04 __ BCS $3a76 ; (memcmp.s5 + 0)
.s4:
3a72 : a9 ff __ LDA #$ff
3a74 : 90 2c __ BCC $3aa2 ; (memcmp.s1006 + 0)
.s5:
3a76 : b1 0f __ LDA (P2),y ; (ptr2 + 0)
3a78 : d1 0d __ CMP (P0),y ; (ptr1 + 0)
3a7a : b0 07 __ BCS $3a83 ; (memcmp.s1 + 0)
.s8:
3a7c : a9 01 __ LDA #$01
3a7e : 85 1b __ STA ACCU + 0 
3a80 : 98 __ __ TYA
3a81 : 90 21 __ BCC $3aa4 ; (memcmp.s1001 + 0)
.s1:
3a83 : 86 1b __ STX ACCU + 0 
3a85 : 8a __ __ TXA
3a86 : 18 __ __ CLC
3a87 : 69 ff __ ADC #$ff
3a89 : aa __ __ TAX
3a8a : a5 12 __ LDA P5 ; (size + 1)
3a8c : a8 __ __ TAY
3a8d : 69 ff __ ADC #$ff
3a8f : 85 12 __ STA P5 ; (size + 1)
3a91 : e6 0d __ INC P0 ; (ptr1 + 0)
3a93 : d0 02 __ BNE $3a97 ; (memcmp.s1010 + 0)
.s1009:
3a95 : e6 0e __ INC P1 ; (ptr1 + 1)
.s1010:
3a97 : e6 0f __ INC P2 ; (ptr2 + 0)
3a99 : d0 02 __ BNE $3a9d ; (memcmp.s1012 + 0)
.s1011:
3a9b : e6 10 __ INC P3 ; (ptr2 + 1)
.s1012:
3a9d : 98 __ __ TYA
3a9e : 05 1b __ ORA ACCU + 0 
3aa0 : d0 c8 __ BNE $3a6a ; (memcmp.l2 + 0)
.s1006:
3aa2 : 85 1b __ STA ACCU + 0 
.s1001:
3aa4 : 85 1c __ STA ACCU + 1 
3aa6 : 60 __ __ RTS
--------------------------------------------------------------------
strncpy: ; strncpy(u8*,const u8*,u8)->u8*
.s0:
3aa7 : a5 0d __ LDA P0 ; (destination + 0)
3aa9 : 85 1b __ STA ACCU + 0 
3aab : a5 0e __ LDA P1 ; (destination + 1)
3aad : 85 1c __ STA ACCU + 1 
3aaf : 05 0d __ ORA P0 ; (destination + 0)
3ab1 : d0 05 __ BNE $3ab8 ; (strncpy.s2 + 0)
.s1:
3ab3 : 85 1b __ STA ACCU + 0 
3ab5 : 85 1c __ STA ACCU + 1 
3ab7 : 60 __ __ RTS
.s2:
3ab8 : a0 00 __ LDY #$00
3aba : b1 0f __ LDA (P2),y ; (source + 0)
3abc : f0 2c __ BEQ $3aea ; (strncpy.s7 + 0)
.s1003:
3abe : a6 11 __ LDX P4 ; (num + 0)
3ac0 : 8a __ __ TXA
3ac1 : f0 27 __ BEQ $3aea ; (strncpy.s7 + 0)
.l6:
3ac3 : a0 00 __ LDY #$00
3ac5 : b1 0f __ LDA (P2),y ; (source + 0)
3ac7 : 91 0d __ STA (P0),y ; (destination + 0)
3ac9 : e6 0d __ INC P0 ; (destination + 0)
3acb : d0 02 __ BNE $3acf ; (strncpy.s1006 + 0)
.s1005:
3acd : e6 0e __ INC P1 ; (destination + 1)
.s1006:
3acf : a5 0f __ LDA P2 ; (source + 0)
3ad1 : 85 43 __ STA T2 + 0 
3ad3 : 18 __ __ CLC
3ad4 : 69 01 __ ADC #$01
3ad6 : 85 0f __ STA P2 ; (source + 0)
3ad8 : a5 10 __ LDA P3 ; (source + 1)
3ada : 85 44 __ STA T2 + 1 
3adc : 69 00 __ ADC #$00
3ade : 85 10 __ STA P3 ; (source + 1)
3ae0 : a0 01 __ LDY #$01
3ae2 : ca __ __ DEX
3ae3 : b1 43 __ LDA (T2 + 0),y 
3ae5 : f0 03 __ BEQ $3aea ; (strncpy.s7 + 0)
.s8:
3ae7 : 8a __ __ TXA
3ae8 : d0 d9 __ BNE $3ac3 ; (strncpy.l6 + 0)
.s7:
3aea : a8 __ __ TAY
3aeb : 91 0d __ STA (P0),y ; (destination + 0)
.s1001:
3aed : 60 __ __ RTS
--------------------------------------------------------------------
charmap: ; charmap(u8)->u8
.s0:
3aee : c9 30 __ CMP #$30
3af0 : 90 04 __ BCC $3af6 ; (charmap.s2 + 0)
.s4:
3af2 : c9 3a __ CMP #$3a
3af4 : 90 24 __ BCC $3b1a ; (charmap.s1001 + 0)
.s2:
3af6 : c9 41 __ CMP #$41
3af8 : 90 07 __ BCC $3b01 ; (charmap.s6 + 0)
.s8:
3afa : c9 5b __ CMP #$5b
3afc : b0 03 __ BCS $3b01 ; (charmap.s6 + 0)
.s5:
3afe : 69 c0 __ ADC #$c0
3b00 : 60 __ __ RTS
.s6:
3b01 : c9 61 __ CMP #$61
3b03 : 90 07 __ BCC $3b0c ; (charmap.s10 + 0)
.s12:
3b05 : c9 7b __ CMP #$7b
3b07 : b0 03 __ BCS $3b0c ; (charmap.s10 + 0)
.s9:
3b09 : 69 a0 __ ADC #$a0
3b0b : 60 __ __ RTS
.s10:
3b0c : c9 20 __ CMP #$20
3b0e : f0 0a __ BEQ $3b1a ; (charmap.s1001 + 0)
.s14:
3b10 : c9 2e __ CMP #$2e
3b12 : f0 06 __ BEQ $3b1a ; (charmap.s1001 + 0)
.s17:
3b14 : c9 2c __ CMP #$2c
3b16 : f0 02 __ BEQ $3b1a ; (charmap.s1001 + 0)
.s20:
3b18 : a9 00 __ LDA #$00
.s1001:
3b1a : 60 __ __ RTS
--------------------------------------------------------------------
do_blink: ; do_blink()->void
.s0:
3b1b : ee 20 3e INC $3e20 ; (blink + 0)
3b1e : ad 20 3e LDA $3e20 ; (blink + 0)
3b21 : c9 5b __ CMP #$5b
3b23 : 90 5e __ BCC $3b83 ; (do_blink.s1001 + 0)
.s1:
3b25 : ad 9b 3d LDA $3d9b ; (txt_y + 0)
3b28 : 0a __ __ ASL
3b29 : 85 1b __ STA ACCU + 0 
3b2b : a9 00 __ LDA #$00
3b2d : 8d 20 3e STA $3e20 ; (blink + 0)
3b30 : 2a __ __ ROL
3b31 : 06 1b __ ASL ACCU + 0 
3b33 : 2a __ __ ROL
3b34 : aa __ __ TAX
3b35 : a5 1b __ LDA ACCU + 0 
3b37 : 6d 9b 3d ADC $3d9b ; (txt_y + 0)
3b3a : 85 1b __ STA ACCU + 0 
3b3c : 8a __ __ TXA
3b3d : 69 00 __ ADC #$00
3b3f : 06 1b __ ASL ACCU + 0 
3b41 : 2a __ __ ROL
3b42 : 06 1b __ ASL ACCU + 0 
3b44 : 2a __ __ ROL
3b45 : 06 1b __ ASL ACCU + 0 
3b47 : 2a __ __ ROL
3b48 : aa __ __ TAX
3b49 : ad 9a 3d LDA $3d9a ; (txt_x + 0)
3b4c : 18 __ __ CLC
3b4d : 65 1b __ ADC ACCU + 0 
3b4f : 85 1b __ STA ACCU + 0 
3b51 : 90 01 __ BCC $3b54 ; (do_blink.s1007 + 0)
.s1006:
3b53 : e8 __ __ INX
.s1007:
3b54 : 86 1c __ STX ACCU + 1 
3b56 : 18 __ __ CLC
3b57 : 6d b1 3c ADC $3cb1 ; (video_colorram + 0)
3b5a : 85 43 __ STA T2 + 0 
3b5c : ad b2 3c LDA $3cb2 ; (video_colorram + 1)
3b5f : 65 1c __ ADC ACCU + 1 
3b61 : 85 44 __ STA T2 + 1 
3b63 : a0 00 __ LDY #$00
3b65 : b1 43 __ LDA (T2 + 0),y 
3b67 : f0 03 __ BEQ $3b6c ; (do_blink.s1008 + 0)
.s1009:
3b69 : 98 __ __ TYA
3b6a : f0 02 __ BEQ $3b6e ; (do_blink.s1010 + 0)
.s1008:
3b6c : a9 0c __ LDA #$0c
.s1010:
3b6e : 91 43 __ STA (T2 + 0),y 
3b70 : ad af 3c LDA $3caf ; (video_ram + 0)
3b73 : 18 __ __ CLC
3b74 : 65 1b __ ADC ACCU + 0 
3b76 : 85 1b __ STA ACCU + 0 
3b78 : ad b0 3c LDA $3cb0 ; (video_ram + 1)
3b7b : 65 1c __ ADC ACCU + 1 
3b7d : 85 1c __ STA ACCU + 1 
3b7f : a9 6c __ LDA #$6c
3b81 : 91 1b __ STA (ACCU + 0),y 
.s1001:
3b83 : 60 __ __ RTS
--------------------------------------------------------------------
adv_reset: ; adv_reset()->void
.s0:
3b84 : ad 58 3d LDA $3d58 ; (objattr + 0)
3b87 : 85 0d __ STA P0 
3b89 : ad 59 3d LDA $3d59 ; (objattr + 1)
3b8c : 85 0e __ STA P1 
3b8e : a9 00 __ LDA #$00
3b90 : 85 0f __ STA P2 
3b92 : a9 05 __ LDA #$05
3b94 : 85 10 __ STA P3 
3b96 : ad 6c 3d LDA $3d6c ; (origram_len + 0)
3b99 : 85 11 __ STA P4 
3b9b : ad 6d 3d LDA $3d6d ; (origram_len + 1)
3b9e : 85 12 __ STA P5 
3ba0 : 4c 60 0c JMP $0c60 ; (memcpy.s0 + 0)
--------------------------------------------------------------------
adv_load: ; adv_load()->u8
.s0:
3ba3 : a9 00 __ LDA #$00
3ba5 : 85 13 __ STA P6 
3ba7 : 20 0b 2b JSR $2b0b ; (irq_detach.l31 + 0)
3baa : a9 bd __ LDA #$bd
3bac : 85 0d __ STA P0 
3bae : a9 2b __ LDA #$2b
3bb0 : 85 0e __ STA P1 
3bb2 : ad 58 3d LDA $3d58 ; (objattr + 0)
3bb5 : 85 0f __ STA P2 
3bb7 : ad 59 3d LDA $3d59 ; (objattr + 1)
3bba : 85 10 __ STA P3 
3bbc : ad 6c 3d LDA $3d6c ; (origram_len + 0)
3bbf : 85 11 __ STA P4 
3bc1 : ad 6d 3d LDA $3d6d ; (origram_len + 1)
3bc4 : 85 12 __ STA P5 
3bc6 : 20 eb 3b JSR $3beb ; (disk_load.s0 + 0)
3bc9 : 09 00 __ ORA #$00
3bcb : f0 07 __ BEQ $3bd4 ; (adv_load.s1 + 0)
.s2:
3bcd : 20 c2 2b JSR $2bc2 ; (irq_attach.l27 + 0)
3bd0 : a9 01 __ LDA #$01
3bd2 : d0 14 __ BNE $3be8 ; (adv_load.s1001 + 0)
.s1:
3bd4 : a9 02 __ LDA #$02
3bd6 : 8d 20 d0 STA $d020 
.l32:
3bd9 : 2c 11 d0 BIT $d011 
3bdc : 10 fb __ BPL $3bd9 ; (adv_load.l32 + 0)
.s4:
3bde : a9 00 __ LDA #$00
3be0 : 8d 20 d0 STA $d020 
3be3 : 20 c2 2b JSR $2bc2 ; (irq_attach.l27 + 0)
3be6 : a9 00 __ LDA #$00
.s1001:
3be8 : 85 1b __ STA ACCU + 0 
3bea : 60 __ __ RTS
--------------------------------------------------------------------
disk_load: ; disk_load(const u8*,u8*,u16)->u8
.s0:
3beb : a5 0f __ LDA P2 ; (mem + 0)
3bed : 8d 02 3e STA $3e02 ; (diskmemlow + 0)
3bf0 : a5 10 __ LDA P3 ; (mem + 1)
3bf2 : 8d 03 3e STA $3e03 ; (diskmemhi + 0)
3bf5 : a9 07 __ LDA #$07
3bf7 : a2 fc __ LDX #$fc
3bf9 : a0 3c __ LDY #$3c
3bfb : 20 bd ff JSR $ffbd 
3bfe : a9 01 __ LDA #$01
3c00 : a6 ba __ LDX $ba 
3c02 : d0 02 __ BNE $3c06 ; (disk_load.s0 + 27)
3c04 : a2 08 __ LDX #$08
3c06 : a0 00 __ LDY #$00
3c08 : 20 ba ff JSR $ffba 
3c0b : a9 00 __ LDA #$00
3c0d : ae 02 3e LDX $3e02 ; (diskmemlow + 0)
3c10 : ac 03 3e LDY $3e03 ; (diskmemhi + 0)
3c13 : 20 d5 ff JSR $ffd5 
3c16 : b0 05 __ BCS $3c1d ; (disk_load.s0 + 50)
3c18 : a9 01 __ LDA #$01
3c1a : 85 1b __ STA ACCU + 0 
3c1c : 60 __ __ RTS
3c1d : a9 00 __ LDA #$00
3c1f : 85 1b __ STA ACCU + 0 
.s1001:
3c21 : a5 1b __ LDA ACCU + 0 
3c23 : 60 __ __ RTS
--------------------------------------------------------------------
os_reset: ; os_reset()->void
.s0:
3c24 : 20 e2 fc JSR $fce2 
.s1001:
3c27 : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
3c28 : a5 1c __ LDA ACCU + 1 
3c2a : d0 31 __ BNE $3c5d ; (divmod + 53)
3c2c : a5 04 __ LDA WORK + 1 
3c2e : d0 1e __ BNE $3c4e ; (divmod + 38)
3c30 : 85 06 __ STA WORK + 3 
3c32 : a2 04 __ LDX #$04
3c34 : 06 1b __ ASL ACCU + 0 
3c36 : 2a __ __ ROL
3c37 : c5 03 __ CMP WORK + 0 
3c39 : 90 02 __ BCC $3c3d ; (divmod + 21)
3c3b : e5 03 __ SBC WORK + 0 
3c3d : 26 1b __ ROL ACCU + 0 
3c3f : 2a __ __ ROL
3c40 : c5 03 __ CMP WORK + 0 
3c42 : 90 02 __ BCC $3c46 ; (divmod + 30)
3c44 : e5 03 __ SBC WORK + 0 
3c46 : 26 1b __ ROL ACCU + 0 
3c48 : ca __ __ DEX
3c49 : d0 eb __ BNE $3c36 ; (divmod + 14)
3c4b : 85 05 __ STA WORK + 2 
3c4d : 60 __ __ RTS
3c4e : a5 1b __ LDA ACCU + 0 
3c50 : 85 05 __ STA WORK + 2 
3c52 : a5 1c __ LDA ACCU + 1 
3c54 : 85 06 __ STA WORK + 3 
3c56 : a9 00 __ LDA #$00
3c58 : 85 1b __ STA ACCU + 0 
3c5a : 85 1c __ STA ACCU + 1 
3c5c : 60 __ __ RTS
3c5d : a5 04 __ LDA WORK + 1 
3c5f : d0 1f __ BNE $3c80 ; (divmod + 88)
3c61 : a5 03 __ LDA WORK + 0 
3c63 : 30 1b __ BMI $3c80 ; (divmod + 88)
3c65 : a9 00 __ LDA #$00
3c67 : 85 06 __ STA WORK + 3 
3c69 : a2 10 __ LDX #$10
3c6b : 06 1b __ ASL ACCU + 0 
3c6d : 26 1c __ ROL ACCU + 1 
3c6f : 2a __ __ ROL
3c70 : c5 03 __ CMP WORK + 0 
3c72 : 90 02 __ BCC $3c76 ; (divmod + 78)
3c74 : e5 03 __ SBC WORK + 0 
3c76 : 26 1b __ ROL ACCU + 0 
3c78 : 26 1c __ ROL ACCU + 1 
3c7a : ca __ __ DEX
3c7b : d0 f2 __ BNE $3c6f ; (divmod + 71)
3c7d : 85 05 __ STA WORK + 2 
3c7f : 60 __ __ RTS
3c80 : a9 00 __ LDA #$00
3c82 : 85 05 __ STA WORK + 2 
3c84 : 85 06 __ STA WORK + 3 
3c86 : 84 02 __ STY $02 
3c88 : a0 10 __ LDY #$10
3c8a : 18 __ __ CLC
3c8b : 26 1b __ ROL ACCU + 0 
3c8d : 26 1c __ ROL ACCU + 1 
3c8f : 26 05 __ ROL WORK + 2 
3c91 : 26 06 __ ROL WORK + 3 
3c93 : 38 __ __ SEC
3c94 : a5 05 __ LDA WORK + 2 
3c96 : e5 03 __ SBC WORK + 0 
3c98 : aa __ __ TAX
3c99 : a5 06 __ LDA WORK + 3 
3c9b : e5 04 __ SBC WORK + 1 
3c9d : 90 04 __ BCC $3ca3 ; (divmod + 123)
3c9f : 86 05 __ STX WORK + 2 
3ca1 : 85 06 __ STA WORK + 3 
3ca3 : 88 __ __ DEY
3ca4 : d0 e5 __ BNE $3c8b ; (divmod + 99)
3ca6 : 26 1b __ ROL ACCU + 0 
3ca8 : 26 1c __ ROL ACCU + 1 
3caa : a4 02 __ LDY $02 
3cac : 60 __ __ RTS
--------------------------------------------------------------------
spentry:
3cad : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
rnd_a:
3cae : __ __ __ BYT 3e                                              : >
--------------------------------------------------------------------
video_ram:
3caf : __ __ __ BYT 00 f4                                           : ..
--------------------------------------------------------------------
video_colorram:
3cb1 : __ __ __ BYT 00 d8                                           : ..
--------------------------------------------------------------------
advnm:
3cb3 : __ __ __ BYT 41 44 56 43 41 52 54 52 49 44 47 45 00          : ADVCARTRIDGE.
--------------------------------------------------------------------
giocharmap:
3cc0 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
strcmd:
3cc1 : __ __ __ BYT a7 02                                           : ..
--------------------------------------------------------------------
text_y:
3cc3 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room:
3cc4 : __ __ __ BYT fa                                              : .
--------------------------------------------------------------------
istack:
3cc5 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
opcodeattr:
3cc6 : __ __ __ BYT 82 83 81 81 83 01 01 01 01 81 82 82 82 02 03 02 : ................
3cd6 : __ __ __ BYT 03 02 02 02 04 02 04 83 81 81 82 82 82 82 82 82 : ................
3ce6 : __ __ __ BYT 83 03 83 81 81 82 83 84 83 83 83 83 83 82 81 82 : ................
3cf6 : __ __ __ BYT 83 81 02                                        : ...
--------------------------------------------------------------------
align:
3cf9 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
quit_request:
3cfb : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
disknm:
3cfc : __ __ __ BYT 40 30 3a 53 41 56 45 00                         : @0:SAVE.
--------------------------------------------------------------------
slowmode:
3d04 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
curimageid:
3d05 : __ __ __ BYT ff                                              : .
--------------------------------------------------------------------
3d06 : __ __ __ BYT 52 4f 4f 4d 30 31 2c 50 2c 52 00                : ROOM01,P,R.
--------------------------------------------------------------------
bitmap_image:
3d11 : __ __ __ BYT 00 e0                                           : ..
--------------------------------------------------------------------
nextroom:
3d13 : __ __ __ BYT fa                                              : .
--------------------------------------------------------------------
ormask:
3d14 : __ __ __ BYT 01 02 04 08 10 20 40 80                         : ..... @.
--------------------------------------------------------------------
xormask:
3d1c : __ __ __ BYT fe fd fb f7 ef df bf 7f                         : ........
--------------------------------------------------------------------
icmd:
3d24 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
hb_len:
3d25 : __ __ __ BSS	1
--------------------------------------------------------------------
advcartridge:
3d26 : __ __ __ BSS	2
--------------------------------------------------------------------
tmp2:
3d28 : __ __ __ BSS	2
--------------------------------------------------------------------
freemem:
3d2a : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_count:
3d2c : __ __ __ BSS	1
--------------------------------------------------------------------
obj_count:
3d2d : __ __ __ BSS	1
--------------------------------------------------------------------
shortdict:
3d2e : __ __ __ BSS	2
--------------------------------------------------------------------
advnames:
3d30 : __ __ __ BSS	2
--------------------------------------------------------------------
advdesc:
3d32 : __ __ __ BSS	2
--------------------------------------------------------------------
msgs:
3d34 : __ __ __ BSS	2
--------------------------------------------------------------------
msgs2:
3d36 : __ __ __ BSS	2
--------------------------------------------------------------------
verbs:
3d38 : __ __ __ BSS	2
--------------------------------------------------------------------
objs:
3d3a : __ __ __ BSS	2
--------------------------------------------------------------------
objs_dir:
3d3c : __ __ __ BSS	2
--------------------------------------------------------------------
rooms:
3d3e : __ __ __ BSS	2
--------------------------------------------------------------------
packdata:
3d40 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_dir:
3d42 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_data:
3d44 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_pos:
3d46 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_len:
3d48 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_data:
3d4a : __ __ __ BSS	2
--------------------------------------------------------------------
roomnameid:
3d4c : __ __ __ BSS	2
--------------------------------------------------------------------
roomdescid:
3d4e : __ __ __ BSS	2
--------------------------------------------------------------------
roomimg:
3d50 : __ __ __ BSS	2
--------------------------------------------------------------------
roomovrimg:
3d52 : __ __ __ BSS	2
--------------------------------------------------------------------
objnameid:
3d54 : __ __ __ BSS	2
--------------------------------------------------------------------
objdescid:
3d56 : __ __ __ BSS	2
--------------------------------------------------------------------
objattr:
3d58 : __ __ __ BSS	2
--------------------------------------------------------------------
objloc:
3d5a : __ __ __ BSS	2
--------------------------------------------------------------------
objattrex:
3d5c : __ __ __ BSS	2
--------------------------------------------------------------------
roomstart:
3d5e : __ __ __ BSS	2
--------------------------------------------------------------------
roomattr:
3d60 : __ __ __ BSS	2
--------------------------------------------------------------------
roomattrex:
3d62 : __ __ __ BSS	2
--------------------------------------------------------------------
bitvars:
3d64 : __ __ __ BSS	2
--------------------------------------------------------------------
vars:
3d66 : __ __ __ BSS	2
--------------------------------------------------------------------
imagesidx:
3d68 : __ __ __ BSS	2
--------------------------------------------------------------------
imagesdata:
3d6a : __ __ __ BSS	2
--------------------------------------------------------------------
origram_len:
3d6c : __ __ __ BSS	2
--------------------------------------------------------------------
tmp:
3d6e : __ __ __ BSS	2
--------------------------------------------------------------------
vrb:
3d70 : __ __ __ BSS	2
--------------------------------------------------------------------
clearfull:
3d72 : __ __ __ BSS	1
--------------------------------------------------------------------
al:
3d73 : __ __ __ BSS	1
--------------------------------------------------------------------
newroom:
3d74 : __ __ __ BSS	1
--------------------------------------------------------------------
cmd:
3d75 : __ __ __ BSS	1
--------------------------------------------------------------------
obj1:
3d76 : __ __ __ BSS	1
--------------------------------------------------------------------
executed:
3d77 : __ __ __ BSS	1
--------------------------------------------------------------------
varroom:
3d78 : __ __ __ BSS	1
--------------------------------------------------------------------
opcode:
3d79 : __ __ __ BSS	1
--------------------------------------------------------------------
pcode:
3d7a : __ __ __ BSS	2
--------------------------------------------------------------------
pcodelen:
3d7c : __ __ __ BSS	2
--------------------------------------------------------------------
in:
3d7e : __ __ __ BSS	1
--------------------------------------------------------------------
fail:
3d7f : __ __ __ BSS	1
--------------------------------------------------------------------
used:
3d80 : __ __ __ BSS	1
--------------------------------------------------------------------
thisobj:
3d81 : __ __ __ BSS	1
--------------------------------------------------------------------
i:
3d82 : __ __ __ BSS	2
--------------------------------------------------------------------
varobj:
3d84 : __ __ __ BSS	1
--------------------------------------------------------------------
varmode:
3d85 : __ __ __ BSS	1
--------------------------------------------------------------------
var:
3d86 : __ __ __ BSS	1
--------------------------------------------------------------------
obj2:
3d87 : __ __ __ BSS	1
--------------------------------------------------------------------
ch:
3d88 : __ __ __ BSS	1
--------------------------------------------------------------------
strid:
3d89 : __ __ __ BSS	1
--------------------------------------------------------------------
str:
3d8a : __ __ __ BSS	2
--------------------------------------------------------------------
text_continue:
3d8c : __ __ __ BSS	1
--------------------------------------------------------------------
txt:
3d8d : __ __ __ BSS	2
--------------------------------------------------------------------
varattr:
3d8f : __ __ __ BSS	1
--------------------------------------------------------------------
a:
3d90 : __ __ __ BSS	1
--------------------------------------------------------------------
_strid:
3d91 : __ __ __ BSS	1
--------------------------------------------------------------------
ostr:
3d92 : __ __ __ BSS	2
--------------------------------------------------------------------
len:
3d94 : __ __ __ BSS	1
--------------------------------------------------------------------
etxt:
3d95 : __ __ __ BSS	2
--------------------------------------------------------------------
txt_col:
3d97 : __ __ __ BSS	1
--------------------------------------------------------------------
text_attach:
3d98 : __ __ __ BSS	1
--------------------------------------------------------------------
txt_rev:
3d99 : __ __ __ BSS	1
--------------------------------------------------------------------
txt_x:
3d9a : __ __ __ BSS	1
--------------------------------------------------------------------
txt_y:
3d9b : __ __ __ BSS	1
--------------------------------------------------------------------
_ch:
3d9c : __ __ __ BSS	1
--------------------------------------------------------------------
_ech:
3d9d : __ __ __ BSS	1
--------------------------------------------------------------------
_cplx:
3d9e : __ __ __ BSS	1
--------------------------------------------------------------------
_cplw:
3d9f : __ __ __ BSS	1
--------------------------------------------------------------------
_cpl:
3da0 : __ __ __ BSS	2
--------------------------------------------------------------------
ll:
3da2 : __ __ __ BSS	2
--------------------------------------------------------------------
spl:
3da4 : __ __ __ BSS	2
--------------------------------------------------------------------
u:
3da6 : __ __ __ BSS	1
--------------------------------------------------------------------
v:
3da7 : __ __ __ BSS	1
--------------------------------------------------------------------
_buffer:
3da8 : __ __ __ BSS	42
--------------------------------------------------------------------
_cbuffer:
3dd2 : __ __ __ BSS	42
--------------------------------------------------------------------
btxt:
3dfc : __ __ __ BSS	2
--------------------------------------------------------------------
b_cpl:
3dfe : __ __ __ BSS	2
--------------------------------------------------------------------
b_cplx:
3e00 : __ __ __ BSS	1
--------------------------------------------------------------------
b_cplw:
3e01 : __ __ __ BSS	1
--------------------------------------------------------------------
diskmemlow:
3e02 : __ __ __ BSS	1
--------------------------------------------------------------------
diskmemhi:
3e03 : __ __ __ BSS	1
--------------------------------------------------------------------
ediskmemlow:
3e04 : __ __ __ BSS	1
--------------------------------------------------------------------
ediskmemhi:
3e05 : __ __ __ BSS	1
--------------------------------------------------------------------
saved:
3e06 : __ __ __ BSS	1
--------------------------------------------------------------------
imageid:
3e07 : __ __ __ BSS	1
--------------------------------------------------------------------
fileptr:
3e08 : __ __ __ BSS	2
--------------------------------------------------------------------
krnio_pstatus:
3e0a : __ __ __ BSS	16
--------------------------------------------------------------------
key:
3e1a : __ __ __ BSS	1
--------------------------------------------------------------------
obj1k:
3e1b : __ __ __ BSS	1
--------------------------------------------------------------------
obj2k:
3e1c : __ __ __ BSS	1
--------------------------------------------------------------------
strdir:
3e1d : __ __ __ BSS	2
--------------------------------------------------------------------
cmdid:
3e1f : __ __ __ BSS	1
--------------------------------------------------------------------
blink:
3e20 : __ __ __ BSS	1
--------------------------------------------------------------------
font:
4000 : __ __ __ BYT c7 38 44 4c 4c 40 44 38 03 c5 38 04 3c 44 3c 02 : .8DLL@D8..8.<D<.
4010 : __ __ __ BYT c6 40 40 78 44 44 78 83 10 c1 3c 43 40 83 10 c1 : .@@xDDx...<C@...
4020 : __ __ __ BYT 04 83 17 84 18 c4 00 38 44 7c 84 10 c3 0c 10 3c : .......8D|.....<
4030 : __ __ __ BYT 43 10 84 20 83 17 c2 04 78 86 30 c8 44 00 00 10 : C.. ....x.0.D...
4040 : __ __ __ BYT 00 30 10 10 83 48 c2 08 00 44 08 c1 70 83 18 c3 : .0...H...D..p...
4050 : __ __ __ BYT 48 70 48 83 18 83 16 85 18 c4 00 68 54 54 84 28 : HpH........hTT.(
4060 : __ __ __ BYT c1 00 84 2f 84 08 c1 38 83 07 84 18 84 6f c2 40 : .../...8.....o.@
4070 : __ __ __ BYT 40 87 50 c1 04 84 10 83 79 85 80 c1 38 83 5f c3 : @.P.....y...8._.
4080 : __ __ __ BYT 00 10 7c 83 40 c1 0c 83 10 84 37 84 88 83 07 c1 : ..|.@.....7.....
4090 : __ __ __ BYT 28 84 80 83 08 c2 54 28 84 08 c3 28 10 28 84 50 : (.....T(...(.(.P
40a0 : __ __ __ BYT 84 1f 83 78 c8 00 7c 08 10 20 7c 00 38 45 20 cb : ...x..|.. |.8E .
40b0 : __ __ __ BYT 38 00 0c 12 30 7c 30 62 fc 00 38 45 08 83 70 c3 : 8...0|0b..8E..p.
40c0 : __ __ __ BYT 18 3c 7e 44 18 c6 00 10 30 7f 7f 30 84 48 06 84 : .<~D....0..0.H..
40d0 : __ __ __ BYT a6 84 c5 86 9c 84 4e c3 fe 44 fe 83 0c c2 10 2c : ......N..D.....,
40e0 : __ __ __ BYT 83 87 ca 68 10 00 62 66 0c 18 30 66 46 83 b6 c5 : ...h..bf..0fF...
40f0 : __ __ __ BYT 28 30 46 44 3a 83 30 c1 20 85 28 83 6d c5 20 20 : (0FD:.0. .(.m.  
4100 : __ __ __ BYT 10 08 00 83 04 c1 08 83 0c 84 8f c1 fe 85 8f c1 : ................
4110 : __ __ __ BYT 10 84 b9 89 5d 84 2d c1 7c 0a 83 19 c2 02 04 83 : ....].-.|.......
4120 : __ __ __ BYT 2f c1 40 83 50 c5 4c 54 64 44 38 83 8f c1 70 83 : /.@.P.LTdD8...p.
4130 : __ __ __ BYT 82 83 b8 c5 44 04 08 30 40 85 08 c2 18 04 83 18 : ....D..0@.......
4140 : __ __ __ BYT cc 08 18 28 48 7c 08 08 00 7c 40 78 04 84 10 c5 : ...(H|...|@x....
4150 : __ __ __ BYT 38 44 40 78 44 83 08 c3 7c 44 08 85 b3 c1 38 83 : 8D@xD...|D....8.
4160 : __ __ __ BYT 0d 84 10 83 05 c1 3c 84 20 85 5c 85 78 84 08 c3 : ......<. .\.x...
4170 : __ __ __ BYT 10 20 0c 83 65 c3 20 10 0c 85 7f 84 81 c3 60 10 : . ..e. .......`.
4180 : __ __ __ BYT 08 83 79 c1 60 85 68 c1 10 86 29 c2 ff ff 84 2e : ..y.`.h...).....
4190 : __ __ __ BYT c3 28 44 7c 84 fc 83 5d 83 60 c1 78 84 68 c2 40 : .(D|...].`.x.h.@
41a0 : __ __ __ BYT 40 83 50 c2 70 48 83 16 c2 48 70 83 80 c3 40 78 : @.P.pH...Hp...@x
41b0 : __ __ __ BYT 40 83 98 86 08 84 b8 c2 40 4c 84 78 83 1e 85 38 : @.......@L.x...8
41c0 : __ __ __ BYT c1 38 45 10 c3 38 00 1c 44 08 cb 68 30 00 44 48 : .8E..8..D..h0.DH
41d0 : __ __ __ BYT 50 60 50 48 44 00 46 40 c5 7c 00 44 6c 54 44 44 : P`PHD.F@.|.DlTDD
41e0 : __ __ __ BYT c4 00 44 64 54 83 38 83 30 45 44 c1 38 85 70 86 : ..DdT.8.0ED.8.p.
41f0 : __ __ __ BYT 50 84 0f c1 0c 85 10 84 38 83 60 c1 38 84 d0 c1 : P.......8.`.8...
4200 : __ __ __ BYT 7c 46 10 84 68 85 30 85 07 c1 28 86 10 c2 54 6c : |F..h.0...(...Tl
4210 : __ __ __ BYT 83 50 83 0d c1 28 84 58 84 09 83 28 c1 7c 83 d7 : .P...(.X...(.|..
4220 : __ __ __ BYT c1 20 83 70 c7 20 10 38 04 3c 44 3c 84 08 c6 44 : . .p. .8.<D<...D
4230 : __ __ __ BYT 7c 40 3c 00 08 87 08 c4 20 10 00 30 84 a8 84 18 : |@<..... ..0....
4240 : __ __ __ BYT 84 50 c2 20 10 84 4a c1 3c 03 c1 3c 83 87 c4 1c : .P. ..J.<..<....
4250 : __ __ __ BYT 30 50 28 83 82 83 50 c3 30 48 48 83 fb c2 58 40 : 0P(...P.0HH...X@
4260 : __ __ __ BYT 83 5d 85 e0 c2 20 7c 84 f8 83 58 87 08 88 f0 88 : .]... |...X.....
4270 : __ __ __ BYT c8 88 a0 48 10 48 28 05 c3 44 7c 00 00          : ...H.H(..D|..
