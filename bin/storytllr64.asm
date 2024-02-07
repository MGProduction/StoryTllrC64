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
080e : 8e 4a 3b STX $3b4a ; (spentry + 0)
0811 : a9 42 __ LDA #$42
0813 : 85 19 __ STA IP + 0 
0815 : a9 3e __ LDA #$3e
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 3f __ LDA #$3f
081c : e9 3e __ SBC #$3e
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
0830 : a9 3a __ LDA #$3a
0832 : e9 42 __ SBC #$42
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
084b : a9 cf __ LDA #$cf
084d : 85 23 __ STA SP + 0 
084f : a9 cb __ LDA #$cb
0851 : 85 24 __ STA SP + 1 
0853 : 20 00 09 JSR $0900 ; (main.s1000 + 0)
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
0900 : a5 53 __ LDA T1 + 0 
0902 : 8d d1 cb STA $cbd1 ; (main@stack + 0)
0905 : a5 54 __ LDA T2 + 0 
0907 : 8d d2 cb STA $cbd2 ; (main@stack + 1)
.s0:
090a : 20 80 0a JSR $0a80 ; (os_init.s0 + 0)
090d : 20 28 0d JSR $0d28 ; (do_textmode.s0 + 0)
0910 : a9 0f __ LDA #$0f
0912 : 85 0f __ STA P2 
0914 : a9 c7 __ LDA #$c7
0916 : 85 0d __ STA P0 
0918 : a9 0d __ LDA #$0d
091a : 85 0e __ STA P1 
091c : 20 61 0d JSR $0d61 ; (dos_msg.s0 + 0)
091f : 20 d2 0d JSR $0dd2 ; (loadcartridge.s0 + 0)
0922 : a5 1b __ LDA ACCU + 0 
0924 : d0 03 __ BNE $0929 ; (main.s3 + 0)
0926 : 4c 63 0a JMP $0a63 ; (main.s2 + 0)
.s3:
0929 : a9 00 __ LDA #$00
092b : 85 0f __ STA P2 
092d : 85 10 __ STA P3 
092f : 85 12 __ STA P5 
0931 : a9 50 __ LDA #$50
0933 : 85 11 __ STA P4 
0935 : ad c8 3d LDA $3dc8 ; (video_ram + 0)
0938 : 18 __ __ CLC
0939 : 69 e0 __ ADC #$e0
093b : 85 0d __ STA P0 
093d : ad c9 3d LDA $3dc9 ; (video_ram + 1)
0940 : 69 01 __ ADC #$01
0942 : 85 0e __ STA P1 
0944 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
0947 : a9 00 __ LDA #$00
0949 : 85 0f __ STA P2 
094b : 85 10 __ STA P3 
094d : 85 12 __ STA P5 
094f : a9 50 __ LDA #$50
0951 : 85 11 __ STA P4 
0953 : ad ca 3d LDA $3dca ; (video_colorram + 0)
0956 : 18 __ __ CLC
0957 : 69 e0 __ ADC #$e0
0959 : 85 0d __ STA P0 
095b : ad cb 3d LDA $3dcb ; (video_colorram + 1)
095e : 69 01 __ ADC #$01
0960 : 85 0e __ STA P1 
0962 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
.l124:
0965 : 2c 11 d0 BIT $d011 
0968 : 10 fb __ BPL $0965 ; (main.l124 + 0)
.s6:
096a : 20 b1 11 JSR $11b1 ; (IRQ_gfx_init.s0 + 0)
096d : ad da 3d LDA $3dda ; (strcmd + 0)
0970 : 85 43 __ STA T0 + 0 
0972 : ad db 3d LDA $3ddb ; (strcmd + 1)
0975 : 85 44 __ STA T0 + 1 
0977 : a9 00 __ LDA #$00
0979 : 8d 20 d0 STA $d020 
097c : a8 __ __ TAY
097d : 91 43 __ STA (T0 + 0),y 
097f : 20 47 12 JSR $1247 ; (clean.s0 + 0)
0982 : 20 69 12 JSR $1269 ; (adv_start.s0 + 0)
.l11:
0985 : 20 4f 33 JSR $334f ; (parser_update.s0 + 0)
0988 : a9 00 __ LDA #$00
098a : 8d 9e 3e STA $3e9e ; (ch + 0)
098d : 8d e3 3d STA $3de3 ; (quit_request + 0)
.l14:
0990 : 20 9f ff JSR $ff9f 
0993 : 20 e4 ff JSR $ffe4 
0996 : 8d 9e 3e STA $3e9e ; (ch + 0)
0999 : ad 9e 3e LDA $3e9e ; (ch + 0)
099c : d0 06 __ BNE $09a4 ; (main.s16 + 0)
.s17:
099e : 20 b8 39 JSR $39b8 ; (do_blink.s0 + 0)
09a1 : 4c f9 09 JMP $09f9 ; (main.l127 + 0)
.s16:
09a4 : 85 53 __ STA T1 + 0 
09a6 : 20 13 34 JSR $3413 ; (hide_blink.s0 + 0)
09a9 : a5 53 __ LDA T1 + 0 
09ab : c9 0d __ CMP #$0d
09ad : d0 06 __ BNE $09b5 ; (main.s20 + 0)
.s19:
09af : 20 4f 34 JSR $344f ; (execute.s1000 + 0)
09b2 : 4c f9 09 JMP $09f9 ; (main.l127 + 0)
.s20:
09b5 : c9 91 __ CMP #$91
09b7 : f0 40 __ BEQ $09f9 ; (main.l127 + 0)
.s23:
09b9 : c9 14 __ CMP #$14
09bb : d0 03 __ BNE $09c0 ; (main.s26 + 0)
09bd : 4c 49 0a JMP $0a49 ; (main.s25 + 0)
.s26:
09c0 : ad fc 3d LDA $3dfc ; (icmd + 0)
09c3 : c9 50 __ CMP #$50
09c5 : b0 2f __ BCS $09f6 ; (main.s136 + 0)
.s31:
09c7 : 85 54 __ STA T2 + 0 
09c9 : a5 53 __ LDA T1 + 0 
09cb : 20 8b 39 JSR $398b ; (charmap.s0 + 0)
09ce : 8d 9e 3e STA $3e9e ; (ch + 0)
09d1 : 09 00 __ ORA #$00
09d3 : f0 21 __ BEQ $09f6 ; (main.s136 + 0)
.s34:
09d5 : 18 __ __ CLC
09d6 : a5 54 __ LDA T2 + 0 
09d8 : 69 01 __ ADC #$01
09da : 85 43 __ STA T0 + 0 
09dc : 8d fc 3d STA $3dfc ; (icmd + 0)
09df : ad da 3d LDA $3dda ; (strcmd + 0)
09e2 : 85 45 __ STA T3 + 0 
09e4 : ad db 3d LDA $3ddb ; (strcmd + 1)
09e7 : 85 46 __ STA T3 + 1 
09e9 : ad 9e 3e LDA $3e9e ; (ch + 0)
09ec : a4 54 __ LDY T2 + 0 
09ee : 91 45 __ STA (T3 + 0),y 
.s137:
09f0 : a9 00 __ LDA #$00
09f2 : a4 43 __ LDY T0 + 0 
09f4 : 91 45 __ STA (T3 + 0),y 
.s136:
09f6 : 20 4f 33 JSR $334f ; (parser_update.s0 + 0)
.l127:
09f9 : 2c 11 d0 BIT $d011 
09fc : 10 fb __ BPL $09f9 ; (main.l127 + 0)
.s13:
09fe : ad e3 3d LDA $3de3 ; (quit_request + 0)
0a01 : f0 8d __ BEQ $0990 ; (main.l14 + 0)
.s15:
0a03 : c9 02 __ CMP #$02
0a05 : b0 06 __ BCS $0a0d ; (main.s41 + 0)
.s12:
0a07 : 20 c1 3a JSR $3ac1 ; (os_reset.s0 + 0)
0a0a : 4c 38 0a JMP $0a38 ; (main.s1001 + 0)
.s41:
0a0d : d0 06 __ BNE $0a15 ; (main.s45 + 0)
.s44:
0a0f : 20 21 3a JSR $3a21 ; (adv_reset.s0 + 0)
0a12 : 4c 1c 0a JMP $0a1c ; (main.s51 + 0)
.s45:
0a15 : 20 40 3a JSR $3a40 ; (adv_load.s0 + 0)
0a18 : a5 1b __ LDA ACCU + 0 
0a1a : f0 14 __ BEQ $0a30 ; (main.s135 + 0)
.s51:
0a1c : ad 78 3e LDA $3e78 ; (roomstart + 0)
0a1f : 85 43 __ STA T0 + 0 
0a21 : ad 79 3e LDA $3e79 ; (roomstart + 1)
0a24 : 85 44 __ STA T0 + 1 
0a26 : a0 00 __ LDY #$00
0a28 : b1 43 __ LDA (T0 + 0),y 
0a2a : 8d 8a 3e STA $3e8a ; (newroom + 0)
0a2d : 20 09 13 JSR $1309 ; (room_load.s1000 + 0)
.s135:
0a30 : a9 00 __ LDA #$00
0a32 : 8d e3 3d STA $3de3 ; (quit_request + 0)
0a35 : 4c 85 09 JMP $0985 ; (main.l11 + 0)
.s1001:
0a38 : a9 00 __ LDA #$00
0a3a : 85 1b __ STA ACCU + 0 
0a3c : 85 1c __ STA ACCU + 1 
0a3e : ad d1 cb LDA $cbd1 ; (main@stack + 0)
0a41 : 85 53 __ STA T1 + 0 
0a43 : ad d2 cb LDA $cbd2 ; (main@stack + 1)
0a46 : 85 54 __ STA T2 + 0 
0a48 : 60 __ __ RTS
.s25:
0a49 : ad fc 3d LDA $3dfc ; (icmd + 0)
0a4c : f0 a8 __ BEQ $09f6 ; (main.s136 + 0)
.s28:
0a4e : 38 __ __ SEC
0a4f : e9 01 __ SBC #$01
0a51 : 8d fc 3d STA $3dfc ; (icmd + 0)
0a54 : 85 43 __ STA T0 + 0 
0a56 : ad da 3d LDA $3dda ; (strcmd + 0)
0a59 : 85 45 __ STA T3 + 0 
0a5b : ad db 3d LDA $3ddb ; (strcmd + 1)
0a5e : 85 46 __ STA T3 + 1 
0a60 : 4c f0 09 JMP $09f0 ; (main.s137 + 0)
.s2:
0a63 : a9 0f __ LDA #$0f
0a65 : 85 0f __ STA P2 
0a67 : a9 20 __ LDA #$20
0a69 : 85 0d __ STA P0 
0a6b : a9 11 __ LDA #$11
0a6d : 85 0e __ STA P1 
0a6f : 20 61 0d JSR $0d61 ; (dos_msg.s0 + 0)
0a72 : a9 80 __ LDA #$80
0a74 : 85 0d __ STA P0 
0a76 : a9 11 __ LDA #$11
0a78 : 85 0e __ STA P1 
0a7a : 20 2b 11 JSR $112b ; (puts.s0 + 0)
0a7d : 4c 38 0a JMP $0a38 ; (main.s1001 + 0)
--------------------------------------------------------------------
os_init: ; os_init()->void
.s0:
0a80 : a9 00 __ LDA #$00
0a82 : 8d 21 d0 STA $d021 
0a85 : 8d 20 d0 STA $d020 
0a88 : 20 d7 0a JSR $0ad7 ; (font_load.s0 + 0)
0a8b : ad 8a 02 LDA $028a 
0a8e : 29 3f __ AND #$3f
0a90 : 09 40 __ ORA #$40
0a92 : 8d 8a 02 STA $028a 
0a95 : a9 20 __ LDA #$20
0a97 : 85 0f __ STA P2 
0a99 : a9 00 __ LDA #$00
0a9b : 85 10 __ STA P3 
0a9d : a9 e8 __ LDA #$e8
0a9f : 85 11 __ STA P4 
0aa1 : a9 03 __ LDA #$03
0aa3 : 85 12 __ STA P5 
0aa5 : ad c8 3d LDA $3dc8 ; (video_ram + 0)
0aa8 : 85 0d __ STA P0 
0aaa : ad c9 3d LDA $3dc9 ; (video_ram + 1)
0aad : 85 0e __ STA P1 
0aaf : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
0ab2 : a9 00 __ LDA #$00
0ab4 : 85 0f __ STA P2 
0ab6 : 85 10 __ STA P3 
0ab8 : a9 e8 __ LDA #$e8
0aba : 85 11 __ STA P4 
0abc : a9 03 __ LDA #$03
0abe : 85 12 __ STA P5 
0ac0 : ad ca 3d LDA $3dca ; (video_colorram + 0)
0ac3 : 85 0d __ STA P0 
0ac5 : ad cb 3d LDA $3dcb ; (video_colorram + 1)
0ac8 : 85 0e __ STA P1 
0aca : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
.l29:
0acd : 2c 11 d0 BIT $d011 
0ad0 : 10 fb __ BPL $0acd ; (os_init.l29 + 0)
.s1:
0ad2 : a9 36 __ LDA #$36
0ad4 : 85 01 __ STA $01 
.s1001:
0ad6 : 60 __ __ RTS
--------------------------------------------------------------------
font_load: ; font_load()->void
.s0:
0ad7 : a9 4b __ LDA #$4b
0ad9 : 85 0d __ STA P0 
0adb : a9 3b __ LDA #$3b
0add : 85 0e __ STA P1 
0adf : a9 00 __ LDA #$00
0ae1 : 85 0f __ STA P2 
0ae3 : a9 c0 __ LDA #$c0
0ae5 : 85 10 __ STA P3 
0ae7 : 20 37 0b JSR $0b37 ; (hunpack.s0 + 0)
0aea : a9 00 __ LDA #$00
0aec : 85 11 __ STA P4 
0aee : 85 43 __ STA T1 + 0 
0af0 : 85 0d __ STA P0 
0af2 : a9 04 __ LDA #$04
0af4 : 85 12 __ STA P5 
0af6 : a9 f8 __ LDA #$f8
0af8 : 85 0e __ STA P1 
0afa : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
0afd : a9 c0 __ LDA #$c0
0aff : 85 44 __ STA T1 + 1 
0b01 : a0 00 __ LDY #$00
0b03 : 84 45 __ STY T2 + 0 
0b05 : a2 04 __ LDX #$04
.l1002:
0b07 : a9 ff __ LDA #$ff
0b09 : 38 __ __ SEC
0b0a : f1 43 __ SBC (T1 + 0),y 
0b0c : 91 43 __ STA (T1 + 0),y 
0b0e : c8 __ __ INY
0b0f : d0 02 __ BNE $0b13 ; (font_load.s1005 + 0)
.s1004:
0b11 : e6 44 __ INC T1 + 1 
.s1005:
0b13 : 38 __ __ SEC
0b14 : a5 45 __ LDA T2 + 0 
0b16 : e9 01 __ SBC #$01
0b18 : 85 45 __ STA T2 + 0 
0b1a : b0 01 __ BCS $0b1d ; (font_load.s1007 + 0)
.s1006:
0b1c : ca __ __ DEX
.s1007:
0b1d : 8a __ __ TXA
0b1e : 05 45 __ ORA T2 + 0 
0b20 : d0 e5 __ BNE $0b07 ; (font_load.l1002 + 0)
.s4:
0b22 : 85 0f __ STA P2 
0b24 : 85 11 __ STA P4 
0b26 : 85 0d __ STA P0 
0b28 : a9 c0 __ LDA #$c0
0b2a : 85 10 __ STA P3 
0b2c : a9 04 __ LDA #$04
0b2e : 85 12 __ STA P5 
0b30 : a9 fc __ LDA #$fc
0b32 : 85 0e __ STA P1 
0b34 : 4c d5 0c JMP $0cd5 ; (memcpy.s0 + 0)
--------------------------------------------------------------------
hunpack: ; hunpack(u8*,u8*)->u16
.s0:
0b37 : a9 00 __ LDA #$00
0b39 : 85 1b __ STA ACCU + 0 
0b3b : 85 1c __ STA ACCU + 1 
0b3d : a8 __ __ TAY
0b3e : b1 0d __ LDA (P0),y ; (buf + 0)
0b40 : d0 01 __ BNE $0b43 ; (hunpack.s36 + 0)
0b42 : 60 __ __ RTS
.s36:
0b43 : 84 43 __ STY T3 + 0 
0b45 : 84 44 __ STY T3 + 1 
.l2:
0b47 : 18 __ __ CLC
0b48 : a5 0d __ LDA P0 ; (buf + 0)
0b4a : 65 43 __ ADC T3 + 0 
0b4c : 85 47 __ STA T5 + 0 
0b4e : a5 0e __ LDA P1 ; (buf + 1)
0b50 : 65 44 __ ADC T3 + 1 
0b52 : 85 48 __ STA T5 + 1 
0b54 : a0 00 __ LDY #$00
0b56 : b1 47 __ LDA (T5 + 0),y 
0b58 : aa __ __ TAX
0b59 : 29 3f __ AND #$3f
0b5b : 8d fd 3d STA $3dfd ; (hb_len + 0)
0b5e : 8a __ __ TXA
0b5f : 29 c0 __ AND #$c0
0b61 : aa __ __ TAX
0b62 : a5 43 __ LDA T3 + 0 
0b64 : 85 45 __ STA T4 + 0 
0b66 : 18 __ __ CLC
0b67 : 69 01 __ ADC #$01
0b69 : 85 43 __ STA T3 + 0 
0b6b : a5 44 __ LDA T3 + 1 
0b6d : 85 46 __ STA T4 + 1 
0b6f : 69 00 __ ADC #$00
0b71 : 85 44 __ STA T3 + 1 
0b73 : ad fd 3d LDA $3dfd ; (hb_len + 0)
0b76 : c9 3f __ CMP #$3f
0b78 : d0 13 __ BNE $0b8d ; (hunpack.s6 + 0)
.s4:
0b7a : c8 __ __ INY
0b7b : b1 47 __ LDA (T5 + 0),y 
0b7d : 8d fd 3d STA $3dfd ; (hb_len + 0)
0b80 : 18 __ __ CLC
0b81 : a5 45 __ LDA T4 + 0 
0b83 : 69 02 __ ADC #$02
0b85 : 85 43 __ STA T3 + 0 
0b87 : a5 46 __ LDA T4 + 1 
0b89 : 69 00 __ ADC #$00
0b8b : 85 44 __ STA T3 + 1 
.s6:
0b8d : 8a __ __ TXA
0b8e : e0 c0 __ CPX #$c0
0b90 : d0 03 __ BNE $0b95 ; (hunpack.s8 + 0)
0b92 : 4c 8e 0c JMP $0c8e ; (hunpack.s10 + 0)
.s8:
0b95 : c9 80 __ CMP #$80
0b97 : d0 03 __ BNE $0b9c ; (hunpack.s14 + 0)
0b99 : 4c 2a 0c JMP $0c2a ; (hunpack.s13 + 0)
.s14:
0b9c : c9 40 __ CMP #$40
0b9e : f0 47 __ BEQ $0be7 ; (hunpack.s19 + 0)
.s20:
0ba0 : 09 00 __ ORA #$00
0ba2 : d0 2e __ BNE $0bd2 ; (hunpack.s1 + 0)
.s25:
0ba4 : ad fd 3d LDA $3dfd ; (hb_len + 0)
0ba7 : ce fd 3d DEC $3dfd ; (hb_len + 0)
0baa : 09 00 __ ORA #$00
0bac : f0 24 __ BEQ $0bd2 ; (hunpack.s1 + 0)
.s35:
0bae : a5 0f __ LDA P2 ; (pbuf + 0)
0bb0 : 85 47 __ STA T5 + 0 
0bb2 : a4 1b __ LDY ACCU + 0 
0bb4 : ae fd 3d LDX $3dfd ; (hb_len + 0)
.l1022:
0bb7 : 18 __ __ CLC
0bb8 : a5 10 __ LDA P3 ; (pbuf + 1)
0bba : 65 1c __ ADC ACCU + 1 
0bbc : 85 48 __ STA T5 + 1 
0bbe : a9 00 __ LDA #$00
0bc0 : 91 47 __ STA (T5 + 0),y 
0bc2 : c8 __ __ INY
0bc3 : d0 02 __ BNE $0bc7 ; (hunpack.s1039 + 0)
.s1038:
0bc5 : e6 1c __ INC ACCU + 1 
.s1039:
0bc7 : 8a __ __ TXA
0bc8 : ca __ __ DEX
0bc9 : 09 00 __ ORA #$00
0bcb : d0 ea __ BNE $0bb7 ; (hunpack.l1022 + 0)
.s1015:
0bcd : 84 1b __ STY ACCU + 0 
.s275:
0bcf : 8e fd 3d STX $3dfd ; (hb_len + 0)
.s1:
0bd2 : a5 43 __ LDA T3 + 0 
0bd4 : 85 45 __ STA T4 + 0 
0bd6 : 18 __ __ CLC
0bd7 : a5 0e __ LDA P1 ; (buf + 1)
0bd9 : 65 44 __ ADC T3 + 1 
0bdb : 85 46 __ STA T4 + 1 
0bdd : a4 0d __ LDY P0 ; (buf + 0)
0bdf : b1 45 __ LDA (T4 + 0),y 
0be1 : f0 03 __ BEQ $0be6 ; (hunpack.s1001 + 0)
0be3 : 4c 47 0b JMP $0b47 ; (hunpack.l2 + 0)
.s1001:
0be6 : 60 __ __ RTS
.s19:
0be7 : a5 43 __ LDA T3 + 0 
0be9 : 85 45 __ STA T4 + 0 
0beb : 18 __ __ CLC
0bec : a5 0e __ LDA P1 ; (buf + 1)
0bee : 65 44 __ ADC T3 + 1 
0bf0 : 85 46 __ STA T4 + 1 
0bf2 : a4 0d __ LDY P0 ; (buf + 0)
0bf4 : b1 45 __ LDA (T4 + 0),y 
0bf6 : 85 1d __ STA ACCU + 2 
0bf8 : ae fd 3d LDX $3dfd ; (hb_len + 0)
0bfb : ce fd 3d DEC $3dfd ; (hb_len + 0)
0bfe : e6 43 __ INC T3 + 0 
0c00 : d0 02 __ BNE $0c04 ; (hunpack.s1035 + 0)
.s1034:
0c02 : e6 44 __ INC T3 + 1 
.s1035:
0c04 : 8a __ __ TXA
0c05 : f0 cb __ BEQ $0bd2 ; (hunpack.s1 + 0)
.s34:
0c07 : a5 0f __ LDA P2 ; (pbuf + 0)
0c09 : 85 47 __ STA T5 + 0 
0c0b : a4 1b __ LDY ACCU + 0 
0c0d : ae fd 3d LDX $3dfd ; (hb_len + 0)
.l1014:
0c10 : 86 1b __ STX ACCU + 0 
0c12 : 18 __ __ CLC
0c13 : a5 10 __ LDA P3 ; (pbuf + 1)
0c15 : 65 1c __ ADC ACCU + 1 
0c17 : 85 48 __ STA T5 + 1 
0c19 : a5 1d __ LDA ACCU + 2 
0c1b : 91 47 __ STA (T5 + 0),y 
0c1d : c8 __ __ INY
0c1e : d0 02 __ BNE $0c22 ; (hunpack.s1037 + 0)
.s1036:
0c20 : e6 1c __ INC ACCU + 1 
.s1037:
0c22 : ca __ __ DEX
0c23 : a5 1b __ LDA ACCU + 0 
0c25 : d0 e9 __ BNE $0c10 ; (hunpack.l1014 + 0)
0c27 : 4c cd 0b JMP $0bcd ; (hunpack.s1015 + 0)
.s13:
0c2a : a5 43 __ LDA T3 + 0 
0c2c : 85 45 __ STA T4 + 0 
0c2e : 18 __ __ CLC
0c2f : a5 0e __ LDA P1 ; (buf + 1)
0c31 : 65 44 __ ADC T3 + 1 
0c33 : 85 46 __ STA T4 + 1 
0c35 : a4 0d __ LDY P0 ; (buf + 0)
0c37 : b1 45 __ LDA (T4 + 0),y 
0c39 : 85 1d __ STA ACCU + 2 
0c3b : ae fd 3d LDX $3dfd ; (hb_len + 0)
0c3e : ce fd 3d DEC $3dfd ; (hb_len + 0)
0c41 : e6 43 __ INC T3 + 0 
0c43 : d0 02 __ BNE $0c47 ; (hunpack.s1029 + 0)
.s1028:
0c45 : e6 44 __ INC T3 + 1 
.s1029:
0c47 : 8a __ __ TXA
0c48 : f0 88 __ BEQ $0bd2 ; (hunpack.s1 + 0)
.s33:
0c4a : a5 0f __ LDA P2 ; (pbuf + 0)
0c4c : 85 49 __ STA T6 + 0 
0c4e : 18 __ __ CLC
0c4f : 65 1b __ ADC ACCU + 0 
0c51 : a8 __ __ TAY
0c52 : a5 10 __ LDA P3 ; (pbuf + 1)
0c54 : 65 1c __ ADC ACCU + 1 
0c56 : aa __ __ TAX
0c57 : 98 __ __ TYA
0c58 : 38 __ __ SEC
0c59 : e5 1d __ SBC ACCU + 2 
0c5b : 85 47 __ STA T5 + 0 
0c5d : 8a __ __ TXA
0c5e : e9 00 __ SBC #$00
0c60 : 85 48 __ STA T5 + 1 
0c62 : ae fd 3d LDX $3dfd ; (hb_len + 0)
.l1012:
0c65 : 86 1d __ STX ACCU + 2 
0c67 : 18 __ __ CLC
0c68 : a5 10 __ LDA P3 ; (pbuf + 1)
0c6a : 65 1c __ ADC ACCU + 1 
0c6c : 85 4a __ STA T6 + 1 
0c6e : a0 00 __ LDY #$00
0c70 : b1 47 __ LDA (T5 + 0),y 
0c72 : a4 1b __ LDY ACCU + 0 
0c74 : 91 49 __ STA (T6 + 0),y 
0c76 : 98 __ __ TYA
0c77 : 18 __ __ CLC
0c78 : 69 01 __ ADC #$01
0c7a : 85 1b __ STA ACCU + 0 
0c7c : 90 02 __ BCC $0c80 ; (hunpack.s1031 + 0)
.s1030:
0c7e : e6 1c __ INC ACCU + 1 
.s1031:
0c80 : e6 47 __ INC T5 + 0 
0c82 : d0 02 __ BNE $0c86 ; (hunpack.s1033 + 0)
.s1032:
0c84 : e6 48 __ INC T5 + 1 
.s1033:
0c86 : ca __ __ DEX
0c87 : a5 1d __ LDA ACCU + 2 
0c89 : d0 da __ BNE $0c65 ; (hunpack.l1012 + 0)
0c8b : 4c cf 0b JMP $0bcf ; (hunpack.s275 + 0)
.s10:
0c8e : ad fd 3d LDA $3dfd ; (hb_len + 0)
0c91 : ce fd 3d DEC $3dfd ; (hb_len + 0)
0c94 : 09 00 __ ORA #$00
0c96 : d0 03 __ BNE $0c9b ; (hunpack.s32 + 0)
0c98 : 4c d2 0b JMP $0bd2 ; (hunpack.s1 + 0)
.s32:
0c9b : a5 0f __ LDA P2 ; (pbuf + 0)
0c9d : 85 47 __ STA T5 + 0 
0c9f : a5 0d __ LDA P0 ; (buf + 0)
0ca1 : 85 49 __ STA T6 + 0 
0ca3 : ae fd 3d LDX $3dfd ; (hb_len + 0)
.l1020:
0ca6 : 18 __ __ CLC
0ca7 : a5 10 __ LDA P3 ; (pbuf + 1)
0ca9 : 65 1c __ ADC ACCU + 1 
0cab : 85 48 __ STA T5 + 1 
0cad : 18 __ __ CLC
0cae : a5 0e __ LDA P1 ; (buf + 1)
0cb0 : 65 44 __ ADC T3 + 1 
0cb2 : 85 4a __ STA T6 + 1 
0cb4 : a4 43 __ LDY T3 + 0 
0cb6 : b1 49 __ LDA (T6 + 0),y 
0cb8 : a4 1b __ LDY ACCU + 0 
0cba : 91 47 __ STA (T5 + 0),y 
0cbc : e6 43 __ INC T3 + 0 
0cbe : d0 02 __ BNE $0cc2 ; (hunpack.s1025 + 0)
.s1024:
0cc0 : e6 44 __ INC T3 + 1 
.s1025:
0cc2 : 98 __ __ TYA
0cc3 : 18 __ __ CLC
0cc4 : 69 01 __ ADC #$01
0cc6 : 85 1b __ STA ACCU + 0 
0cc8 : 90 02 __ BCC $0ccc ; (hunpack.s1027 + 0)
.s1026:
0cca : e6 1c __ INC ACCU + 1 
.s1027:
0ccc : 8a __ __ TXA
0ccd : ca __ __ DEX
0cce : 09 00 __ ORA #$00
0cd0 : d0 d4 __ BNE $0ca6 ; (hunpack.l1020 + 0)
0cd2 : 4c cf 0b JMP $0bcf ; (hunpack.s275 + 0)
--------------------------------------------------------------------
memcpy: ; memcpy(void*,const void*,i16)->void*
.s0:
0cd5 : a6 12 __ LDX P5 
0cd7 : f0 10 __ BEQ $0ce9 ; (memcpy.s0 + 20)
0cd9 : a0 00 __ LDY #$00
0cdb : b1 0f __ LDA (P2),y 
0cdd : 91 0d __ STA (P0),y ; (dst + 0)
0cdf : c8 __ __ INY
0ce0 : d0 f9 __ BNE $0cdb ; (memcpy.s0 + 6)
0ce2 : e6 10 __ INC P3 
0ce4 : e6 0e __ INC P1 ; (dst + 1)
0ce6 : ca __ __ DEX
0ce7 : d0 f2 __ BNE $0cdb ; (memcpy.s0 + 6)
0ce9 : a4 11 __ LDY P4 
0ceb : f0 0e __ BEQ $0cfb ; (memcpy.s0 + 38)
0ced : 88 __ __ DEY
0cee : f0 07 __ BEQ $0cf7 ; (memcpy.s0 + 34)
0cf0 : b1 0f __ LDA (P2),y 
0cf2 : 91 0d __ STA (P0),y ; (dst + 0)
0cf4 : 88 __ __ DEY
0cf5 : d0 f9 __ BNE $0cf0 ; (memcpy.s0 + 27)
0cf7 : b1 0f __ LDA (P2),y 
0cf9 : 91 0d __ STA (P0),y ; (dst + 0)
0cfb : a5 0d __ LDA P0 ; (dst + 0)
0cfd : 85 1b __ STA ACCU + 0 
0cff : a5 0e __ LDA P1 ; (dst + 1)
0d01 : 85 1c __ STA ACCU + 1 
.s1001:
0d03 : 60 __ __ RTS
--------------------------------------------------------------------
memset: ; memset(void*,i16,i16)->void*
.s0:
0d04 : a5 0f __ LDA P2 
0d06 : a6 12 __ LDX P5 
0d08 : f0 0c __ BEQ $0d16 ; (memset.s0 + 18)
0d0a : a0 00 __ LDY #$00
0d0c : 91 0d __ STA (P0),y ; (dst + 0)
0d0e : c8 __ __ INY
0d0f : d0 fb __ BNE $0d0c ; (memset.s0 + 8)
0d11 : e6 0e __ INC P1 ; (dst + 1)
0d13 : ca __ __ DEX
0d14 : d0 f6 __ BNE $0d0c ; (memset.s0 + 8)
0d16 : a4 11 __ LDY P4 
0d18 : f0 05 __ BEQ $0d1f ; (memset.s0 + 27)
0d1a : 88 __ __ DEY
0d1b : 91 0d __ STA (P0),y ; (dst + 0)
0d1d : d0 fb __ BNE $0d1a ; (memset.s0 + 22)
0d1f : a5 0d __ LDA P0 ; (dst + 0)
0d21 : 85 1b __ STA ACCU + 0 
0d23 : a5 0e __ LDA P1 ; (dst + 1)
0d25 : 85 1c __ STA ACCU + 1 
.s1001:
0d27 : 60 __ __ RTS
--------------------------------------------------------------------
do_textmode: ; do_textmode()->void
.s0:
0d28 : ad 11 d0 LDA $d011 
0d2b : 29 1f __ AND #$1f
0d2d : 8d 11 d0 STA $d011 
0d30 : ad 16 d0 LDA $d016 
0d33 : 29 ef __ AND #$ef
0d35 : 8d 16 d0 STA $d016 
0d38 : ad 18 d0 LDA $d018 
0d3b : 29 f0 __ AND #$f0
0d3d : 09 06 __ ORA #$06
0d3f : 8d 18 d0 STA $d018 
0d42 : ad 02 dd LDA $dd02 
0d45 : 09 03 __ ORA #$03
0d47 : 8d 02 dd STA $dd02 
0d4a : ad 00 dd LDA $dd00 
0d4d : 29 fc __ AND #$fc
0d4f : 09 00 __ ORA #$00
0d51 : 8d 00 dd STA $dd00 
0d54 : ad 18 d0 LDA $d018 
0d57 : 29 01 __ AND #$01
0d59 : 09 d0 __ ORA #$d0
0d5b : 09 0e __ ORA #$0e
0d5d : 8d 18 d0 STA $d018 
.s1001:
0d60 : 60 __ __ RTS
--------------------------------------------------------------------
dos_msg: ; dos_msg(const u8*,u8)->void
.s0:
0d61 : ad c8 3d LDA $3dc8 ; (video_ram + 0)
0d64 : 18 __ __ CLC
0d65 : 69 e0 __ ADC #$e0
0d67 : aa __ __ TAX
0d68 : ad c9 3d LDA $3dc9 ; (video_ram + 1)
0d6b : 69 01 __ ADC #$01
0d6d : a8 __ __ TAY
0d6e : 8a __ __ TXA
0d6f : 18 __ __ CLC
0d70 : 65 0f __ ADC P2 ; (pos + 0)
0d72 : 85 45 __ STA T2 + 0 
0d74 : 90 01 __ BCC $0d77 ; (dos_msg.s1008 + 0)
.s1007:
0d76 : c8 __ __ INY
.s1008:
0d77 : 84 46 __ STY T2 + 1 
0d79 : ad ca 3d LDA $3dca ; (video_colorram + 0)
0d7c : 18 __ __ CLC
0d7d : 69 e0 __ ADC #$e0
0d7f : aa __ __ TAX
0d80 : ad cb 3d LDA $3dcb ; (video_colorram + 1)
0d83 : 69 01 __ ADC #$01
0d85 : a8 __ __ TAY
0d86 : 8a __ __ TXA
0d87 : 18 __ __ CLC
0d88 : 65 0f __ ADC P2 ; (pos + 0)
0d8a : 85 43 __ STA T1 + 0 
0d8c : 90 01 __ BCC $0d8f ; (dos_msg.s1010 + 0)
.s1009:
0d8e : c8 __ __ INY
.s1010:
0d8f : 84 44 __ STY T1 + 1 
0d91 : a9 00 __ LDA #$00
0d93 : 85 1b __ STA ACCU + 0 
.l1:
0d95 : a4 1b __ LDY ACCU + 0 
0d97 : b1 0d __ LDA (P0),y ; (label + 0)
0d99 : d0 01 __ BNE $0d9c ; (dos_msg.s2 + 0)
.s1001:
0d9b : 60 __ __ RTS
.s2:
0d9c : aa __ __ TAX
0d9d : e6 1b __ INC ACCU + 0 
0d9f : e0 41 __ CPX #$41
0da1 : 90 06 __ BCC $0da9 ; (dos_msg.s6 + 0)
.s7:
0da3 : a9 5a __ LDA #$5a
0da5 : d1 0d __ CMP (P0),y ; (label + 0)
0da7 : b0 03 __ BCS $0dac ; (dos_msg.s4 + 0)
.s6:
0da9 : 8a __ __ TXA
0daa : 90 04 __ BCC $0db0 ; (dos_msg.s1006 + 0)
.s4:
0dac : 8a __ __ TXA
0dad : 18 __ __ CLC
0dae : 69 c0 __ ADC #$c0
.s1006:
0db0 : a0 00 __ LDY #$00
0db2 : 91 45 __ STA (T2 + 0),y 
0db4 : a9 07 __ LDA #$07
0db6 : 91 43 __ STA (T1 + 0),y 
0db8 : e6 45 __ INC T2 + 0 
0dba : d0 02 __ BNE $0dbe ; (dos_msg.s1012 + 0)
.s1011:
0dbc : e6 46 __ INC T2 + 1 
.s1012:
0dbe : e6 43 __ INC T1 + 0 
0dc0 : d0 d3 __ BNE $0d95 ; (dos_msg.l1 + 0)
.s1013:
0dc2 : e6 44 __ INC T1 + 1 
0dc4 : 4c 95 0d JMP $0d95 ; (dos_msg.l1 + 0)
--------------------------------------------------------------------
0dc7 : __ __ __ BYT 4c 4f 41 44 49 4e 47 2e 2e 2e 00                : LOADING....
--------------------------------------------------------------------
loadcartridge: ; loadcartridge()->u8
.s0:
0dd2 : a9 00 __ LDA #$00
0dd4 : 8d fe 3d STA $3dfe ; (advcartridge + 0)
0dd7 : a9 40 __ LDA #$40
0dd9 : 8d ff 3d STA $3dff ; (advcartridge + 1)
0ddc : 20 4b 0e JSR $0e4b ; (irq_border_on.s0 + 0)
0ddf : a9 01 __ LDA #$01
0de1 : a6 ba __ LDX $ba 
0de3 : d0 02 __ BNE $0de7 ; (loadcartridge.s0 + 21)
0de5 : a2 08 __ LDX #$08
0de7 : a0 00 __ LDY #$00
0de9 : 20 ba ff JSR $ffba 
0dec : a9 0c __ LDA #$0c
0dee : a2 cc __ LDX #$cc
0df0 : a0 3d __ LDY #$3d
0df2 : 20 bd ff JSR $ffbd 
0df5 : a9 00 __ LDA #$00
0df7 : a2 00 __ LDX #$00
0df9 : a0 40 __ LDY #$40
0dfb : 20 d5 ff JSR $ffd5 
0dfe : b0 03 __ BCS $0e03 ; (loadcartridge.s0 + 49)
0e00 : 4c 0b 0e JMP $0e0b ; (loadcartridge.s0 + 57)
0e03 : 20 61 0e JSR $0e61 ; (irq_border_off.s0 + 0)
0e06 : a9 00 __ LDA #$00
0e08 : 85 1b __ STA ACCU + 0 
0e0a : 60 __ __ RTS
0e0b : 20 61 0e JSR $0e61 ; (irq_border_off.s0 + 0)
0e0e : ad fe 3d LDA $3dfe ; (advcartridge + 0)
0e11 : 85 43 __ STA T0 + 0 
0e13 : 18 __ __ CLC
0e14 : 69 02 __ ADC #$02
0e16 : 8d fe 3d STA $3dfe ; (advcartridge + 0)
0e19 : ad ff 3d LDA $3dff ; (advcartridge + 1)
0e1c : 85 44 __ STA T0 + 1 
0e1e : 69 00 __ ADC #$00
0e20 : 8d ff 3d STA $3dff ; (advcartridge + 1)
0e23 : a0 01 __ LDY #$01
0e25 : b1 43 __ LDA (T0 + 0),y 
0e27 : 85 14 __ STA P7 
0e29 : 18 __ __ CLC
0e2a : 88 __ __ DEY
0e2b : b1 43 __ LDA (T0 + 0),y 
0e2d : 85 13 __ STA P6 
0e2f : 6d fe 3d ADC $3dfe ; (advcartridge + 0)
0e32 : 8d 42 3e STA $3e42 ; (tmp2 + 0)
0e35 : ad ff 3d LDA $3dff ; (advcartridge + 1)
0e38 : 65 14 __ ADC P7 
0e3a : 8d 43 3e STA $3e43 ; (tmp2 + 1)
0e3d : a5 13 __ LDA P6 
0e3f : 05 14 __ ORA P7 
0e41 : f0 05 __ BEQ $0e48 ; (loadcartridge.s2 + 0)
.s1:
0e43 : 20 6e 0e JSR $0e6e ; (setupcartridge.s0 + 0)
0e46 : a9 01 __ LDA #$01
.s2:
0e48 : 85 1b __ STA ACCU + 0 
.s1001:
0e4a : 60 __ __ RTS
--------------------------------------------------------------------
irq_border_on: ; irq_border_on()->void
.s0:
0e4b : 4c 54 0e JMP $0e54 ; (irq_border_on.s0 + 9)
0e4e : 8e 20 d0 STX $d020 
0e51 : 4c fe f6 JMP $f6fe 
0e54 : 78 __ __ SEI
0e55 : a9 4e __ LDA #$4e
0e57 : a2 0e __ LDX #$0e
0e59 : 8d 28 03 STA $0328 
0e5c : 8e 29 03 STX $0329 
0e5f : 58 __ __ CLI
.s1001:
0e60 : 60 __ __ RTS
--------------------------------------------------------------------
irq_border_off: ; irq_border_off()->void
.s0:
0e61 : 78 __ __ SEI
0e62 : a9 ed __ LDA #$ed
0e64 : a2 f6 __ LDX #$f6
0e66 : 8d 28 03 STA $0328 
0e69 : 8e 29 03 STX $0329 
0e6c : 58 __ __ CLI
.s1001:
0e6d : 60 __ __ RTS
--------------------------------------------------------------------
setupcartridge: ; setupcartridge(u16)->void
.s0:
0e6e : ad fe 3d LDA $3dfe ; (advcartridge + 0)
0e71 : aa __ __ TAX
0e72 : 18 __ __ CLC
0e73 : 65 13 __ ADC P6 ; (iln + 0)
0e75 : 85 45 __ STA T1 + 0 
0e77 : ad ff 3d LDA $3dff ; (advcartridge + 1)
0e7a : 85 44 __ STA T0 + 1 
0e7c : 65 14 __ ADC P7 ; (iln + 1)
0e7e : 85 46 __ STA T1 + 1 
0e80 : 38 __ __ SEC
0e81 : a9 80 __ LDA #$80
0e83 : e5 45 __ SBC T1 + 0 
0e85 : 8d 44 3e STA $3e44 ; (freemem + 0)
0e88 : a9 cb __ LDA #$cb
0e8a : e5 46 __ SBC T1 + 1 
0e8c : 8d 45 3e STA $3e45 ; (freemem + 1)
0e8f : ad 42 3e LDA $3e42 ; (tmp2 + 0)
0e92 : 85 45 __ STA T1 + 0 
0e94 : ad 43 3e LDA $3e43 ; (tmp2 + 1)
0e97 : 85 46 __ STA T1 + 1 
0e99 : a0 02 __ LDY #$02
0e9b : b1 45 __ LDA (T1 + 0),y 
0e9d : 8d 46 3e STA $3e46 ; (opcode_vrbidx_count + 0)
0ea0 : a0 04 __ LDY #$04
0ea2 : b1 45 __ LDA (T1 + 0),y 
0ea4 : 8d 47 3e STA $3e47 ; (obj_count + 0)
0ea7 : 8a __ __ TXA
0ea8 : 18 __ __ CLC
0ea9 : a0 0a __ LDY #$0a
0eab : 71 45 __ ADC (T1 + 0),y 
0ead : 8d 48 3e STA $3e48 ; (shortdict + 0)
0eb0 : a5 44 __ LDA T0 + 1 
0eb2 : c8 __ __ INY
0eb3 : 71 45 __ ADC (T1 + 0),y 
0eb5 : 8d 49 3e STA $3e49 ; (shortdict + 1)
0eb8 : 8a __ __ TXA
0eb9 : 18 __ __ CLC
0eba : c8 __ __ INY
0ebb : 71 45 __ ADC (T1 + 0),y 
0ebd : 8d 4a 3e STA $3e4a ; (advnames + 0)
0ec0 : a5 44 __ LDA T0 + 1 
0ec2 : c8 __ __ INY
0ec3 : 71 45 __ ADC (T1 + 0),y 
0ec5 : 8d 4b 3e STA $3e4b ; (advnames + 1)
0ec8 : 8a __ __ TXA
0ec9 : 18 __ __ CLC
0eca : c8 __ __ INY
0ecb : 71 45 __ ADC (T1 + 0),y 
0ecd : 8d 4c 3e STA $3e4c ; (advdesc + 0)
0ed0 : a5 44 __ LDA T0 + 1 
0ed2 : c8 __ __ INY
0ed3 : 71 45 __ ADC (T1 + 0),y 
0ed5 : 8d 4d 3e STA $3e4d ; (advdesc + 1)
0ed8 : 8a __ __ TXA
0ed9 : 18 __ __ CLC
0eda : c8 __ __ INY
0edb : 71 45 __ ADC (T1 + 0),y 
0edd : 8d 4e 3e STA $3e4e ; (msgs + 0)
0ee0 : a5 44 __ LDA T0 + 1 
0ee2 : c8 __ __ INY
0ee3 : 71 45 __ ADC (T1 + 0),y 
0ee5 : 8d 4f 3e STA $3e4f ; (msgs + 1)
0ee8 : 8a __ __ TXA
0ee9 : 18 __ __ CLC
0eea : c8 __ __ INY
0eeb : 71 45 __ ADC (T1 + 0),y 
0eed : 8d 50 3e STA $3e50 ; (msgs2 + 0)
0ef0 : a5 44 __ LDA T0 + 1 
0ef2 : c8 __ __ INY
0ef3 : 71 45 __ ADC (T1 + 0),y 
0ef5 : 8d 51 3e STA $3e51 ; (msgs2 + 1)
0ef8 : 8a __ __ TXA
0ef9 : 18 __ __ CLC
0efa : c8 __ __ INY
0efb : 71 45 __ ADC (T1 + 0),y 
0efd : 8d 52 3e STA $3e52 ; (verbs + 0)
0f00 : a5 44 __ LDA T0 + 1 
0f02 : c8 __ __ INY
0f03 : 71 45 __ ADC (T1 + 0),y 
0f05 : 8d 53 3e STA $3e53 ; (verbs + 1)
0f08 : 8a __ __ TXA
0f09 : 18 __ __ CLC
0f0a : c8 __ __ INY
0f0b : 71 45 __ ADC (T1 + 0),y 
0f0d : 8d 54 3e STA $3e54 ; (objs + 0)
0f10 : a5 44 __ LDA T0 + 1 
0f12 : c8 __ __ INY
0f13 : 71 45 __ ADC (T1 + 0),y 
0f15 : 8d 55 3e STA $3e55 ; (objs + 1)
0f18 : 8a __ __ TXA
0f19 : 18 __ __ CLC
0f1a : c8 __ __ INY
0f1b : 71 45 __ ADC (T1 + 0),y 
0f1d : 8d 56 3e STA $3e56 ; (objs_dir + 0)
0f20 : a5 44 __ LDA T0 + 1 
0f22 : c8 __ __ INY
0f23 : 71 45 __ ADC (T1 + 0),y 
0f25 : 8d 57 3e STA $3e57 ; (objs_dir + 1)
0f28 : 8a __ __ TXA
0f29 : 18 __ __ CLC
0f2a : c8 __ __ INY
0f2b : 71 45 __ ADC (T1 + 0),y 
0f2d : 8d 58 3e STA $3e58 ; (rooms + 0)
0f30 : a5 44 __ LDA T0 + 1 
0f32 : c8 __ __ INY
0f33 : 71 45 __ ADC (T1 + 0),y 
0f35 : 8d 59 3e STA $3e59 ; (rooms + 1)
0f38 : 8a __ __ TXA
0f39 : 18 __ __ CLC
0f3a : c8 __ __ INY
0f3b : 71 45 __ ADC (T1 + 0),y 
0f3d : 8d 5a 3e STA $3e5a ; (packdata + 0)
0f40 : a5 44 __ LDA T0 + 1 
0f42 : c8 __ __ INY
0f43 : 71 45 __ ADC (T1 + 0),y 
0f45 : 8d 5b 3e STA $3e5b ; (packdata + 1)
0f48 : 8a __ __ TXA
0f49 : 18 __ __ CLC
0f4a : c8 __ __ INY
0f4b : 71 45 __ ADC (T1 + 0),y 
0f4d : 8d 5c 3e STA $3e5c ; (opcode_vrbidx_dir + 0)
0f50 : a5 44 __ LDA T0 + 1 
0f52 : c8 __ __ INY
0f53 : 71 45 __ ADC (T1 + 0),y 
0f55 : 8d 5d 3e STA $3e5d ; (opcode_vrbidx_dir + 1)
0f58 : 8a __ __ TXA
0f59 : 18 __ __ CLC
0f5a : c8 __ __ INY
0f5b : 71 45 __ ADC (T1 + 0),y 
0f5d : 8d 5e 3e STA $3e5e ; (opcode_vrbidx_data + 0)
0f60 : a5 44 __ LDA T0 + 1 
0f62 : c8 __ __ INY
0f63 : 71 45 __ ADC (T1 + 0),y 
0f65 : 8d 5f 3e STA $3e5f ; (opcode_vrbidx_data + 1)
0f68 : 8a __ __ TXA
0f69 : 18 __ __ CLC
0f6a : c8 __ __ INY
0f6b : 71 45 __ ADC (T1 + 0),y 
0f6d : 8d 60 3e STA $3e60 ; (opcode_pos + 0)
0f70 : a5 44 __ LDA T0 + 1 
0f72 : c8 __ __ INY
0f73 : 71 45 __ ADC (T1 + 0),y 
0f75 : 8d 61 3e STA $3e61 ; (opcode_pos + 1)
0f78 : 8a __ __ TXA
0f79 : 18 __ __ CLC
0f7a : c8 __ __ INY
0f7b : 71 45 __ ADC (T1 + 0),y 
0f7d : 8d 62 3e STA $3e62 ; (opcode_len + 0)
0f80 : a5 44 __ LDA T0 + 1 
0f82 : c8 __ __ INY
0f83 : 71 45 __ ADC (T1 + 0),y 
0f85 : 8d 63 3e STA $3e63 ; (opcode_len + 1)
0f88 : 8a __ __ TXA
0f89 : 18 __ __ CLC
0f8a : c8 __ __ INY
0f8b : 71 45 __ ADC (T1 + 0),y 
0f8d : 8d 64 3e STA $3e64 ; (opcode_data + 0)
0f90 : a5 44 __ LDA T0 + 1 
0f92 : c8 __ __ INY
0f93 : 71 45 __ ADC (T1 + 0),y 
0f95 : 8d 65 3e STA $3e65 ; (opcode_data + 1)
0f98 : 8a __ __ TXA
0f99 : 18 __ __ CLC
0f9a : c8 __ __ INY
0f9b : 71 45 __ ADC (T1 + 0),y 
0f9d : 8d 66 3e STA $3e66 ; (roomnameid + 0)
0fa0 : a5 44 __ LDA T0 + 1 
0fa2 : c8 __ __ INY
0fa3 : 71 45 __ ADC (T1 + 0),y 
0fa5 : 8d 67 3e STA $3e67 ; (roomnameid + 1)
0fa8 : 8a __ __ TXA
0fa9 : 18 __ __ CLC
0faa : c8 __ __ INY
0fab : 71 45 __ ADC (T1 + 0),y 
0fad : 8d 68 3e STA $3e68 ; (roomdescid + 0)
0fb0 : a5 44 __ LDA T0 + 1 
0fb2 : c8 __ __ INY
0fb3 : 71 45 __ ADC (T1 + 0),y 
0fb5 : 8d 69 3e STA $3e69 ; (roomdescid + 1)
0fb8 : 8a __ __ TXA
0fb9 : 18 __ __ CLC
0fba : c8 __ __ INY
0fbb : 71 45 __ ADC (T1 + 0),y 
0fbd : 8d 6a 3e STA $3e6a ; (roomimg + 0)
0fc0 : a5 44 __ LDA T0 + 1 
0fc2 : c8 __ __ INY
0fc3 : 71 45 __ ADC (T1 + 0),y 
0fc5 : 8d 6b 3e STA $3e6b ; (roomimg + 1)
0fc8 : 8a __ __ TXA
0fc9 : 18 __ __ CLC
0fca : c8 __ __ INY
0fcb : 71 45 __ ADC (T1 + 0),y 
0fcd : 85 47 __ STA T2 + 0 
0fcf : a5 44 __ LDA T0 + 1 
0fd1 : c8 __ __ INY
0fd2 : 71 45 __ ADC (T1 + 0),y 
0fd4 : 85 48 __ STA T2 + 1 
0fd6 : 8d 6d 3e STA $3e6d ; (roomovrimg + 1)
0fd9 : a5 47 __ LDA T2 + 0 
0fdb : 8d 6c 3e STA $3e6c ; (roomovrimg + 0)
0fde : 8a __ __ TXA
0fdf : 18 __ __ CLC
0fe0 : c8 __ __ INY
0fe1 : 71 45 __ ADC (T1 + 0),y 
0fe3 : 8d 6e 3e STA $3e6e ; (objnameid + 0)
0fe6 : a5 44 __ LDA T0 + 1 
0fe8 : c8 __ __ INY
0fe9 : 71 45 __ ADC (T1 + 0),y 
0feb : 8d 6f 3e STA $3e6f ; (objnameid + 1)
0fee : 8a __ __ TXA
0fef : 18 __ __ CLC
0ff0 : c8 __ __ INY
0ff1 : 71 45 __ ADC (T1 + 0),y 
0ff3 : 8d 70 3e STA $3e70 ; (objdescid + 0)
0ff6 : a5 44 __ LDA T0 + 1 
0ff8 : c8 __ __ INY
0ff9 : 71 45 __ ADC (T1 + 0),y 
0ffb : 8d 71 3e STA $3e71 ; (objdescid + 1)
0ffe : 8a __ __ TXA
0fff : 18 __ __ CLC
1000 : a0 36 __ LDY #$36
1002 : 71 45 __ ADC (T1 + 0),y 
1004 : 85 0f __ STA P2 
1006 : a5 44 __ LDA T0 + 1 
1008 : c8 __ __ INY
1009 : 71 45 __ ADC (T1 + 0),y 
100b : 85 10 __ STA P3 
100d : 8d 73 3e STA $3e73 ; (objattr + 1)
1010 : a5 0f __ LDA P2 
1012 : 8d 72 3e STA $3e72 ; (objattr + 0)
1015 : 8a __ __ TXA
1016 : 18 __ __ CLC
1017 : c8 __ __ INY
1018 : 71 45 __ ADC (T1 + 0),y 
101a : 8d 74 3e STA $3e74 ; (objloc + 0)
101d : a5 44 __ LDA T0 + 1 
101f : c8 __ __ INY
1020 : 71 45 __ ADC (T1 + 0),y 
1022 : 8d 75 3e STA $3e75 ; (objloc + 1)
1025 : 8a __ __ TXA
1026 : 18 __ __ CLC
1027 : c8 __ __ INY
1028 : 71 45 __ ADC (T1 + 0),y 
102a : 85 49 __ STA T5 + 0 
102c : a5 44 __ LDA T0 + 1 
102e : c8 __ __ INY
102f : 71 45 __ ADC (T1 + 0),y 
1031 : 85 4a __ STA T5 + 1 
1033 : 8d 77 3e STA $3e77 ; (objattrex + 1)
1036 : a5 49 __ LDA T5 + 0 
1038 : 8d 76 3e STA $3e76 ; (objattrex + 0)
103b : 8a __ __ TXA
103c : 18 __ __ CLC
103d : c8 __ __ INY
103e : 71 45 __ ADC (T1 + 0),y 
1040 : 8d 78 3e STA $3e78 ; (roomstart + 0)
1043 : a5 44 __ LDA T0 + 1 
1045 : c8 __ __ INY
1046 : 71 45 __ ADC (T1 + 0),y 
1048 : 8d 79 3e STA $3e79 ; (roomstart + 1)
104b : 8a __ __ TXA
104c : 18 __ __ CLC
104d : c8 __ __ INY
104e : 71 45 __ ADC (T1 + 0),y 
1050 : 85 4b __ STA T6 + 0 
1052 : a5 44 __ LDA T0 + 1 
1054 : c8 __ __ INY
1055 : 71 45 __ ADC (T1 + 0),y 
1057 : 85 4c __ STA T6 + 1 
1059 : 8d 7b 3e STA $3e7b ; (roomattr + 1)
105c : a5 4b __ LDA T6 + 0 
105e : 8d 7a 3e STA $3e7a ; (roomattr + 0)
1061 : 8a __ __ TXA
1062 : 18 __ __ CLC
1063 : c8 __ __ INY
1064 : 71 45 __ ADC (T1 + 0),y 
1066 : 85 4d __ STA T7 + 0 
1068 : a5 44 __ LDA T0 + 1 
106a : c8 __ __ INY
106b : 71 45 __ ADC (T1 + 0),y 
106d : 85 4e __ STA T7 + 1 
106f : 8d 7d 3e STA $3e7d ; (roomattrex + 1)
1072 : a5 4d __ LDA T7 + 0 
1074 : 8d 7c 3e STA $3e7c ; (roomattrex + 0)
1077 : 8a __ __ TXA
1078 : 18 __ __ CLC
1079 : c8 __ __ INY
107a : 71 45 __ ADC (T1 + 0),y 
107c : 85 4f __ STA T8 + 0 
107e : a5 44 __ LDA T0 + 1 
1080 : c8 __ __ INY
1081 : 71 45 __ ADC (T1 + 0),y 
1083 : 85 50 __ STA T8 + 1 
1085 : 8d 7f 3e STA $3e7f ; (bitvars + 1)
1088 : a5 4f __ LDA T8 + 0 
108a : 8d 7e 3e STA $3e7e ; (bitvars + 0)
108d : 8a __ __ TXA
108e : 18 __ __ CLC
108f : c8 __ __ INY
1090 : 71 45 __ ADC (T1 + 0),y 
1092 : 8d 80 3e STA $3e80 ; (vars + 0)
1095 : a5 44 __ LDA T0 + 1 
1097 : c8 __ __ INY
1098 : 71 45 __ ADC (T1 + 0),y 
109a : 8d 81 3e STA $3e81 ; (vars + 1)
109d : 18 __ __ CLC
109e : a5 45 __ LDA T1 + 0 
10a0 : 69 48 __ ADC #$48
10a2 : 8d 42 3e STA $3e42 ; (tmp2 + 0)
10a5 : a5 46 __ LDA T1 + 1 
10a7 : 69 00 __ ADC #$00
10a9 : 8d 43 3e STA $3e43 ; (tmp2 + 1)
10ac : c8 __ __ INY
10ad : b1 45 __ LDA (T1 + 0),y 
10af : 85 11 __ STA P4 
10b1 : c8 __ __ INY
10b2 : b1 45 __ LDA (T1 + 0),y 
10b4 : 85 12 __ STA P5 
10b6 : 8d 83 3e STA $3e83 ; (origram_len + 1)
10b9 : a5 11 __ LDA P4 
10bb : 8d 82 3e STA $3e82 ; (origram_len + 0)
10be : a9 00 __ LDA #$00
10c0 : 85 0d __ STA P0 
10c2 : a9 05 __ LDA #$05
10c4 : 85 0e __ STA P1 
10c6 : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
10c9 : a9 00 __ LDA #$00
10cb : 8d 84 3e STA $3e84 ; (tmp + 0)
10ce : a9 04 __ LDA #$04
10d0 : 8d 85 3e STA $3e85 ; (tmp + 1)
10d3 : 8d 87 3e STA $3e87 ; (vrb + 1)
10d6 : 8d 43 3e STA $3e43 ; (tmp2 + 1)
10d9 : a9 28 __ LDA #$28
10db : 8d 86 3e STA $3e86 ; (vrb + 0)
10de : a9 32 __ LDA #$32
10e0 : 8d 42 3e STA $3e42 ; (tmp2 + 0)
10e3 : a5 48 __ LDA T2 + 1 
10e5 : c5 4c __ CMP T6 + 1 
10e7 : d0 0e __ BNE $10f7 ; (setupcartridge.s6 + 0)
.s1008:
10e9 : a5 47 __ LDA T2 + 0 
10eb : c5 4b __ CMP T6 + 0 
10ed : d0 08 __ BNE $10f7 ; (setupcartridge.s6 + 0)
.s1:
10ef : a9 00 __ LDA #$00
10f1 : 8d 6c 3e STA $3e6c ; (roomovrimg + 0)
10f4 : 8d 6d 3e STA $3e6d ; (roomovrimg + 1)
.s6:
10f7 : a5 4a __ LDA T5 + 1 
10f9 : c5 4e __ CMP T7 + 1 
10fb : d0 0e __ BNE $110b ; (setupcartridge.s9 + 0)
.s1004:
10fd : a5 4d __ LDA T7 + 0 
10ff : c5 49 __ CMP T5 + 0 
1101 : d0 08 __ BNE $110b ; (setupcartridge.s9 + 0)
.s7:
1103 : a9 00 __ LDA #$00
1105 : 8d 7c 3e STA $3e7c ; (roomattrex + 0)
1108 : 8d 7d 3e STA $3e7d ; (roomattrex + 1)
.s9:
110b : a5 4a __ LDA T5 + 1 
110d : c5 50 __ CMP T8 + 1 
110f : d0 0e __ BNE $111f ; (setupcartridge.s1001 + 0)
.s1002:
1111 : a5 49 __ LDA T5 + 0 
1113 : c5 4f __ CMP T8 + 0 
1115 : d0 08 __ BNE $111f ; (setupcartridge.s1001 + 0)
.s10:
1117 : a9 00 __ LDA #$00
1119 : 8d 76 3e STA $3e76 ; (objattrex + 0)
111c : 8d 77 3e STA $3e77 ; (objattrex + 1)
.s1001:
111f : 60 __ __ RTS
--------------------------------------------------------------------
1120 : __ __ __ BYT 44 49 53 4b 20 45 52 52 4f 52 00                : DISK ERROR.
--------------------------------------------------------------------
puts: ; puts(const u8*)->void
.s0:
112b : a0 00 __ LDY #$00
112d : b1 0d __ LDA (P0),y 
112f : f0 0b __ BEQ $113c ; (puts.s1001 + 0)
1131 : 20 3d 11 JSR $113d ; (putpch + 0)
1134 : e6 0d __ INC P0 
1136 : d0 f3 __ BNE $112b ; (puts.s0 + 0)
1138 : e6 0e __ INC P1 
113a : d0 ef __ BNE $112b ; (puts.s0 + 0)
.s1001:
113c : 60 __ __ RTS
--------------------------------------------------------------------
putpch: ; putpch
113d : ae d9 3d LDX $3dd9 ; (giocharmap + 0)
1140 : e0 01 __ CPX #$01
1142 : 90 26 __ BCC $116a ; (putpch + 45)
1144 : c9 0a __ CMP #$0a
1146 : d0 02 __ BNE $114a ; (putpch + 13)
1148 : a9 0d __ LDA #$0d
114a : c9 09 __ CMP #$09
114c : f0 1f __ BEQ $116d ; (putpch + 48)
114e : e0 02 __ CPX #$02
1150 : 90 18 __ BCC $116a ; (putpch + 45)
1152 : c9 41 __ CMP #$41
1154 : 90 14 __ BCC $116a ; (putpch + 45)
1156 : c9 7b __ CMP #$7b
1158 : b0 10 __ BCS $116a ; (putpch + 45)
115a : c9 61 __ CMP #$61
115c : b0 04 __ BCS $1162 ; (putpch + 37)
115e : c9 5b __ CMP #$5b
1160 : b0 08 __ BCS $116a ; (putpch + 45)
1162 : 49 20 __ EOR #$20
1164 : e0 03 __ CPX #$03
1166 : f0 02 __ BEQ $116a ; (putpch + 45)
1168 : 29 df __ AND #$df
116a : 4c d2 ff JMP $ffd2 
116d : 38 __ __ SEC
116e : 20 f0 ff JSR $fff0 
1171 : 98 __ __ TYA
1172 : 29 03 __ AND #$03
1174 : 49 03 __ EOR #$03
1176 : aa __ __ TAX
1177 : a9 20 __ LDA #$20
1179 : 20 d2 ff JSR $ffd2 
117c : ca __ __ DEX
117d : 10 fa __ BPL $1179 ; (putpch + 60)
117f : 60 __ __ RTS
--------------------------------------------------------------------
1180 : __ __ __ BYT 0a 50 4c 45 41 53 45 20 54 55 52 4e 20 56 49 52 : .PLEASE TURN VIR
1190 : __ __ __ BYT 54 55 41 4c 20 44 45 56 49 43 45 20 4f 52 20 54 : TUAL DEVICE OR T
11a0 : __ __ __ BYT 52 55 45 20 45 4d 55 4c 41 54 49 4f 4e 20 4f 4e : RUE EMULATION ON
11b0 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
IRQ_gfx_init: ; IRQ_gfx_init()->void
.s0:
11b1 : 78 __ __ SEI
11b2 : a0 7f __ LDY #$7f
11b4 : 8c 0d dc STY $dc0d 
11b7 : ad 1a d0 LDA $d01a 
11ba : 09 01 __ ORA #$01
11bc : 8d 1a d0 STA $d01a 
11bf : ad 11 d0 LDA $d011 
11c2 : 29 7f __ AND #$7f
11c4 : 8d 11 d0 STA $d011 
11c7 : a9 05 __ LDA #$05
11c9 : 8d 12 d0 STA $d012 
11cc : a2 d8 __ LDX #$d8
11ce : a0 11 __ LDY #$11
11d0 : 8e 14 03 STX $0314 
11d3 : 8c 15 03 STY $0315 
11d6 : 58 __ __ CLI
.s1001:
11d7 : 60 __ __ RTS
--------------------------------------------------------------------
IRQ_bitmapmode: ; IRQ_bitmapmode()->void
.s0:
11d8 : a9 ff __ LDA #$ff
11da : 8d 19 d0 STA $d019 
11dd : 20 f3 11 JSR $11f3 ; (do_bitmapmode.s0 + 0)
11e0 : a9 96 __ LDA #$96
11e2 : 8d 12 d0 STA $d012 
11e5 : a2 2c __ LDX #$2c
11e7 : a0 12 __ LDY #$12
11e9 : 8e 14 03 STX $0314 
11ec : 8c 15 03 STY $0315 
11ef : 4c 81 ea JMP $ea81 
.s1001:
11f2 : 60 __ __ RTS
--------------------------------------------------------------------
do_bitmapmode: ; do_bitmapmode()->void
.s0:
11f3 : ad 11 d0 LDA $d011 
11f6 : 29 1f __ AND #$1f
11f8 : 09 20 __ ORA #$20
11fa : 8d 11 d0 STA $d011 
11fd : ad 16 d0 LDA $d016 
1200 : 09 10 __ ORA #$10
1202 : 8d 16 d0 STA $d016 
1205 : ad 18 d0 LDA $d018 
1208 : 29 f0 __ AND #$f0
120a : 09 08 __ ORA #$08
120c : 8d 18 d0 STA $d018 
120f : ad 02 dd LDA $dd02 
1212 : 09 03 __ ORA #$03
1214 : 8d 02 dd STA $dd02 
1217 : ad 00 dd LDA $dd00 
121a : 29 fc __ AND #$fc
121c : 09 00 __ ORA #$00
121e : 8d 00 dd STA $dd00 
1221 : ad 18 d0 LDA $d018 
1224 : 29 0f __ AND #$0f
1226 : 09 c0 __ ORA #$c0
1228 : 8d 18 d0 STA $d018 
.s1001:
122b : 60 __ __ RTS
--------------------------------------------------------------------
IRQ_textmode: ; IRQ_textmode()->void
.s0:
122c : a9 ff __ LDA #$ff
122e : 8d 19 d0 STA $d019 
1231 : 20 28 0d JSR $0d28 ; (do_textmode.s0 + 0)
1234 : a9 05 __ LDA #$05
1236 : 8d 12 d0 STA $d012 
1239 : a2 d8 __ LDX #$d8
123b : a0 11 __ LDY #$11
123d : 8e 14 03 STX $0314 
1240 : 8c 15 03 STY $0315 
1243 : 4c 81 ea JMP $ea81 
.s1001:
1246 : 60 __ __ RTS
--------------------------------------------------------------------
clean: ; clean()->void
.s0:
1247 : a9 00 __ LDA #$00
1249 : 85 0d __ STA P0 
124b : 85 0f __ STA P2 
124d : 85 10 __ STA P3 
124f : 85 12 __ STA P5 
1251 : a9 08 __ LDA #$08
1253 : 85 11 __ STA P4 
1255 : a5 01 __ LDA $01 
1257 : 85 43 __ STA T0 + 0 
1259 : a9 34 __ LDA #$34
125b : 85 01 __ STA $01 
125d : a9 f2 __ LDA #$f2
125f : 85 0e __ STA P1 
1261 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
1264 : a5 43 __ LDA T0 + 0 
1266 : 85 01 __ STA $01 
.s1001:
1268 : 60 __ __ RTS
--------------------------------------------------------------------
adv_start: ; adv_start()->void
.s0:
1269 : a9 01 __ LDA #$01
126b : 8d 88 3e STA $3e88 ; (clearfull + 0)
126e : 20 85 12 JSR $1285 ; (ui_clear.s0 + 0)
1271 : ad 78 3e LDA $3e78 ; (roomstart + 0)
1274 : 85 43 __ STA T0 + 0 
1276 : ad 79 3e LDA $3e79 ; (roomstart + 1)
1279 : 85 44 __ STA T0 + 1 
127b : a0 00 __ LDY #$00
127d : b1 43 __ LDA (T0 + 0),y 
127f : 8d 8a 3e STA $3e8a ; (newroom + 0)
1282 : 4c 09 13 JMP $1309 ; (room_load.s1000 + 0)
--------------------------------------------------------------------
ui_clear: ; ui_clear()->void
.s0:
1285 : a9 00 __ LDA #$00
1287 : 8d dc 3d STA $3ddc ; (text_y + 0)
128a : 8d 89 3e STA $3e89 ; (al + 0)
128d : ad 88 3e LDA $3e88 ; (clearfull + 0)
1290 : f0 3c __ BEQ $12ce ; (ui_clear.s3 + 0)
.s1:
1292 : a9 20 __ LDA #$20
1294 : 85 0f __ STA P2 
1296 : a9 00 __ LDA #$00
1298 : 85 10 __ STA P3 
129a : 85 12 __ STA P5 
129c : a9 28 __ LDA #$28
129e : 85 11 __ STA P4 
12a0 : a9 08 __ LDA #$08
12a2 : 85 0d __ STA P0 
12a4 : a9 f6 __ LDA #$f6
12a6 : 85 0e __ STA P1 
12a8 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
12ab : a9 00 __ LDA #$00
12ad : 85 0f __ STA P2 
12af : 85 10 __ STA P3 
12b1 : 85 12 __ STA P5 
12b3 : a9 28 __ LDA #$28
12b5 : 85 11 __ STA P4 
12b7 : ad ca 3d LDA $3dca ; (video_colorram + 0)
12ba : 18 __ __ CLC
12bb : 69 08 __ ADC #$08
12bd : 85 0d __ STA P0 
12bf : ad cb 3d LDA $3dcb ; (video_colorram + 1)
12c2 : 69 02 __ ADC #$02
12c4 : 85 0e __ STA P1 
12c6 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
12c9 : a9 00 __ LDA #$00
12cb : 8d 88 3e STA $3e88 ; (clearfull + 0)
.s3:
12ce : a9 20 __ LDA #$20
12d0 : 85 0f __ STA P2 
12d2 : a9 00 __ LDA #$00
12d4 : 85 10 __ STA P3 
12d6 : a9 b8 __ LDA #$b8
12d8 : 85 11 __ STA P4 
12da : a9 01 __ LDA #$01
12dc : 85 12 __ STA P5 
12de : a9 30 __ LDA #$30
12e0 : 85 0d __ STA P0 
12e2 : a9 f6 __ LDA #$f6
12e4 : 85 0e __ STA P1 
12e6 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
12e9 : a9 00 __ LDA #$00
12eb : 85 0f __ STA P2 
12ed : 85 10 __ STA P3 
12ef : a9 b8 __ LDA #$b8
12f1 : 85 11 __ STA P4 
12f3 : a9 01 __ LDA #$01
12f5 : 85 12 __ STA P5 
12f7 : ad ca 3d LDA $3dca ; (video_colorram + 0)
12fa : 18 __ __ CLC
12fb : 69 30 __ ADC #$30
12fd : 85 0d __ STA P0 
12ff : ad cb 3d LDA $3dcb ; (video_colorram + 1)
1302 : 69 02 __ ADC #$02
1304 : 85 0e __ STA P1 
1306 : 4c 04 0d JMP $0d04 ; (memset.s0 + 0)
--------------------------------------------------------------------
room_load: ; room_load()->void
.s1000:
1309 : a5 53 __ LDA T0 + 0 
130b : 8d d9 cb STA $cbd9 ; (room_load@stack + 0)
.l2:
130e : a9 02 __ LDA #$02
1310 : 8d 8b 3e STA $3e8b ; (cmd + 0)
1313 : a9 ff __ LDA #$ff
1315 : 8d 8c 3e STA $3e8c ; (obj1 + 0)
1318 : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
131b : ad 8a 3e LDA $3e8a ; (newroom + 0)
131e : 85 53 __ STA T0 + 0 
1320 : 8d dd 3d STA $3ddd ; (room + 0)
1323 : 20 c5 31 JSR $31c5 ; (os_roomimage_load.s0 + 0)
1326 : ad 7a 3e LDA $3e7a ; (roomattr + 0)
1329 : 18 __ __ CLC
132a : 65 53 __ ADC T0 + 0 
132c : 85 43 __ STA T1 + 0 
132e : ad 7b 3e LDA $3e7b ; (roomattr + 1)
1331 : 69 00 __ ADC #$00
1333 : 85 44 __ STA T1 + 1 
1335 : a0 00 __ LDY #$00
1337 : 8c 8d 3e STY $3e8d ; (executed + 0)
133a : b1 43 __ LDA (T1 + 0),y 
133c : aa __ __ TAX
133d : 29 01 __ AND #$01
133f : d0 15 __ BNE $1356 ; (room_load.s7 + 0)
.s4:
1341 : 8d 8b 3e STA $3e8b ; (cmd + 0)
1344 : a9 ff __ LDA #$ff
1346 : 8d 8c 3e STA $3e8c ; (obj1 + 0)
1349 : 8a __ __ TXA
134a : 09 01 __ ORA #$01
134c : 91 43 __ STA (T1 + 0),y 
134e : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
1351 : ad 8d 3e LDA $3e8d ; (executed + 0)
1354 : d0 0d __ BNE $1363 ; (room_load.s28 + 0)
.s7:
1356 : a9 01 __ LDA #$01
1358 : 8d 8b 3e STA $3e8b ; (cmd + 0)
135b : a9 ff __ LDA #$ff
135d : 8d 8c 3e STA $3e8c ; (obj1 + 0)
1360 : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
.s28:
1363 : ad fa 3d LDA $3dfa ; (nextroom + 0)
1366 : c9 fa __ CMP #$fa
1368 : f0 0a __ BEQ $1374 ; (room_load.s1001 + 0)
.s10:
136a : 8d 8a 3e STA $3e8a ; (newroom + 0)
136d : a9 fa __ LDA #$fa
136f : 8d fa 3d STA $3dfa ; (nextroom + 0)
1372 : d0 9a __ BNE $130e ; (room_load.l2 + 0)
.s1001:
1374 : ad d9 cb LDA $cbd9 ; (room_load@stack + 0)
1377 : 85 53 __ STA T0 + 0 
1379 : 60 __ __ RTS
--------------------------------------------------------------------
adv_run: ; adv_run()->void
.s1000:
137a : a2 04 __ LDX #$04
137c : b5 53 __ LDA T0 + 0,x 
137e : 9d da cb STA $cbda,x ; (adv_run@stack + 0)
1381 : ca __ __ DEX
1382 : 10 f8 __ BPL $137c ; (adv_run.s1000 + 2)
.s0:
1384 : a9 00 __ LDA #$00
1386 : 8d 8d 3e STA $3e8d ; (executed + 0)
1389 : ad 46 3e LDA $3e46 ; (opcode_vrbidx_count + 0)
138c : cd 8b 3e CMP $3e8b ; (cmd + 0)
138f : b0 03 __ BCS $1394 ; (adv_run.s3 + 0)
.s1:
1391 : 8d 8b 3e STA $3e8b ; (cmd + 0)
.s3:
1394 : ad 8b 3e LDA $3e8b ; (cmd + 0)
1397 : 0a __ __ ASL
1398 : 85 54 __ STA T2 + 0 
139a : a9 00 __ LDA #$00
139c : 2a __ __ ROL
139d : aa __ __ TAX
139e : ad 5c 3e LDA $3e5c ; (opcode_vrbidx_dir + 0)
13a1 : 65 54 __ ADC T2 + 0 
13a3 : 85 54 __ STA T2 + 0 
13a5 : 8a __ __ TXA
13a6 : 6d 5d 3e ADC $3e5d ; (opcode_vrbidx_dir + 1)
13a9 : 85 55 __ STA T2 + 1 
13ab : a0 00 __ LDY #$00
13ad : b1 54 __ LDA (T2 + 0),y 
13af : 85 56 __ STA T3 + 0 
13b1 : c8 __ __ INY
13b2 : b1 54 __ LDA (T2 + 0),y 
13b4 : 85 57 __ STA T3 + 1 
13b6 : c8 __ __ INY
13b7 : b1 54 __ LDA (T2 + 0),y 
13b9 : aa __ __ TAX
13ba : c8 __ __ INY
13bb : b1 54 __ LDA (T2 + 0),y 
13bd : 86 54 __ STX T2 + 0 
13bf : 85 55 __ STA T2 + 1 
13c1 : ad dd 3d LDA $3ddd ; (room + 0)
13c4 : 85 53 __ STA T0 + 0 
13c6 : a5 57 __ LDA T3 + 1 
13c8 : c5 55 __ CMP T2 + 1 
13ca : d0 04 __ BNE $13d0 ; (adv_run.l1007 + 0)
.s1006:
13cc : a5 56 __ LDA T3 + 0 
13ce : c5 54 __ CMP T2 + 0 
.l1007:
13d0 : 90 03 __ BCC $13d5 ; (adv_run.s5 + 0)
13d2 : 4c 5a 14 JMP $145a ; (adv_run.s1001 + 0)
.s5:
13d5 : ad 5e 3e LDA $3e5e ; (opcode_vrbidx_data + 0)
13d8 : 65 56 __ ADC T3 + 0 
13da : 85 44 __ STA T4 + 0 
13dc : ad 5f 3e LDA $3e5f ; (opcode_vrbidx_data + 1)
13df : 65 57 __ ADC T3 + 1 
13e1 : 85 45 __ STA T4 + 1 
13e3 : a0 00 __ LDY #$00
13e5 : b1 44 __ LDA (T4 + 0),y 
13e7 : 8d 8e 3e STA $3e8e ; (varroom + 0)
13ea : c5 53 __ CMP T0 + 0 
13ec : f0 07 __ BEQ $13f5 ; (adv_run.s7 + 0)
.s10:
13ee : ad 8e 3e LDA $3e8e ; (varroom + 0)
13f1 : c9 f6 __ CMP #$f6
13f3 : d0 4e __ BNE $1443 ; (adv_run.s23 + 0)
.s7:
13f5 : a0 01 __ LDY #$01
13f7 : b1 44 __ LDA (T4 + 0),y 
13f9 : 8d 8f 3e STA $3e8f ; (opcode + 0)
13fc : 0a __ __ ASL
13fd : 85 47 __ STA T6 + 0 
13ff : a9 00 __ LDA #$00
1401 : 2a __ __ ROL
1402 : aa __ __ TAX
1403 : ad 60 3e LDA $3e60 ; (opcode_pos + 0)
1406 : 65 47 __ ADC T6 + 0 
1408 : 85 47 __ STA T6 + 0 
140a : 8a __ __ TXA
140b : 6d 61 3e ADC $3e61 ; (opcode_pos + 1)
140e : 85 48 __ STA T6 + 1 
1410 : b1 47 __ LDA (T6 + 0),y 
1412 : aa __ __ TAX
1413 : ad 64 3e LDA $3e64 ; (opcode_data + 0)
1416 : 18 __ __ CLC
1417 : 88 __ __ DEY
1418 : 71 47 __ ADC (T6 + 0),y 
141a : 8d 90 3e STA $3e90 ; (pcode + 0)
141d : 8a __ __ TXA
141e : 6d 65 3e ADC $3e65 ; (opcode_data + 1)
1421 : 8d 91 3e STA $3e91 ; (pcode + 1)
1424 : ad 62 3e LDA $3e62 ; (opcode_len + 0)
1427 : 85 47 __ STA T6 + 0 
1429 : ad 63 3e LDA $3e63 ; (opcode_len + 1)
142c : 85 48 __ STA T6 + 1 
142e : ac 8f 3e LDY $3e8f ; (opcode + 0)
1431 : b1 47 __ LDA (T6 + 0),y 
1433 : 8d 92 3e STA $3e92 ; (pcodelen + 0)
1436 : a9 00 __ LDA #$00
1438 : 8d 93 3e STA $3e93 ; (pcodelen + 1)
143b : 20 65 14 JSR $1465 ; (adv_exec.s1000 + 0)
143e : ad 8d 3e LDA $3e8d ; (executed + 0)
1441 : d0 17 __ BNE $145a ; (adv_run.s1001 + 0)
.s23:
1443 : 18 __ __ CLC
1444 : a5 56 __ LDA T3 + 0 
1446 : 69 02 __ ADC #$02
1448 : 85 56 __ STA T3 + 0 
144a : a5 57 __ LDA T3 + 1 
144c : 69 00 __ ADC #$00
144e : 85 57 __ STA T3 + 1 
1450 : c5 55 __ CMP T2 + 1 
1452 : f0 03 __ BEQ $1457 ; (adv_run.s23 + 20)
1454 : 4c d0 13 JMP $13d0 ; (adv_run.l1007 + 0)
1457 : 4c cc 13 JMP $13cc ; (adv_run.s1006 + 0)
.s1001:
145a : a2 04 __ LDX #$04
145c : bd da cb LDA $cbda,x ; (adv_run@stack + 0)
145f : 95 53 __ STA T0 + 0,x 
1461 : ca __ __ DEX
1462 : 10 f8 __ BPL $145c ; (adv_run.s1001 + 2)
1464 : 60 __ __ RTS
--------------------------------------------------------------------
adv_exec: ; adv_exec()->void
.s1000:
1465 : a2 06 __ LDX #$06
1467 : b5 53 __ LDA T1 + 0,x 
1469 : 9d df cb STA $cbdf,x ; (adv_exec@stack + 0)
146c : ca __ __ DEX
146d : 10 f8 __ BPL $1467 ; (adv_exec.s1000 + 2)
.s0:
146f : a9 00 __ LDA #$00
1471 : 8d 94 3e STA $3e94 ; (in + 0)
1474 : 8d 95 3e STA $3e95 ; (fail + 0)
1477 : 8d de 3d STA $3dde ; (istack + 0)
147a : 8d 96 3e STA $3e96 ; (used + 0)
147d : 8d 98 3e STA $3e98 ; (i + 0)
1480 : 8d 99 3e STA $3e99 ; (i + 1)
1483 : ad 8c 3e LDA $3e8c ; (obj1 + 0)
1486 : 8d 97 3e STA $3e97 ; (thisobj + 0)
1489 : ad 92 3e LDA $3e92 ; (pcodelen + 0)
148c : 0d 93 3e ORA $3e93 ; (pcodelen + 1)
148f : d0 03 __ BNE $1494 ; (adv_exec.l2 + 0)
1491 : 4c 7a 15 JMP $157a ; (adv_exec.s3 + 0)
.l2:
1494 : ad 98 3e LDA $3e98 ; (i + 0)
1497 : 85 53 __ STA T1 + 0 
1499 : 18 __ __ CLC
149a : 69 01 __ ADC #$01
149c : 85 55 __ STA T2 + 0 
149e : 8d 98 3e STA $3e98 ; (i + 0)
14a1 : ad 99 3e LDA $3e99 ; (i + 1)
14a4 : 85 54 __ STA T1 + 1 
14a6 : 69 00 __ ADC #$00
14a8 : 85 56 __ STA T2 + 1 
14aa : 8d 99 3e STA $3e99 ; (i + 1)
14ad : ad 90 3e LDA $3e90 ; (pcode + 0)
14b0 : 85 57 __ STA T3 + 0 
14b2 : 18 __ __ CLC
14b3 : 65 53 __ ADC T1 + 0 
14b5 : 85 43 __ STA T4 + 0 
14b7 : ad 91 3e LDA $3e91 ; (pcode + 1)
14ba : 85 58 __ STA T3 + 1 
14bc : 65 54 __ ADC T1 + 1 
14be : 85 44 __ STA T4 + 1 
14c0 : a0 00 __ LDY #$00
14c2 : b1 43 __ LDA (T4 + 0),y 
14c4 : 8d 8f 3e STA $3e8f ; (opcode + 0)
14c7 : c9 88 __ CMP #$88
14c9 : d0 03 __ BNE $14ce ; (adv_exec.s6 + 0)
14cb : 4c 7a 15 JMP $157a ; (adv_exec.s3 + 0)
.s6:
14ce : 85 52 __ STA T0 + 0 
14d0 : aa __ __ TAX
14d1 : bd 80 3d LDA $3d80,x ; (font + 565)
14d4 : 10 03 __ BPL $14d9 ; (adv_exec.s9 + 0)
14d6 : 4c cd 1a JMP $1acd ; (adv_exec.s8 + 0)
.s9:
14d9 : 8a __ __ TXA
14da : e0 92 __ CPX #$92
14dc : d0 1f __ BNE $14fd ; (adv_exec.s366 + 0)
.s196:
14de : c8 __ __ INY
14df : b1 43 __ LDA (T4 + 0),y 
14e1 : 85 52 __ STA T0 + 0 
14e3 : 8d 9c 3e STA $3e9c ; (var + 0)
14e6 : 18 __ __ CLC
14e7 : a5 53 __ LDA T1 + 0 
14e9 : 69 02 __ ADC #$02
14eb : 8d 98 3e STA $3e98 ; (i + 0)
14ee : a5 54 __ LDA T1 + 1 
14f0 : 69 00 __ ADC #$00
14f2 : 8d 99 3e STA $3e99 ; (i + 1)
14f5 : ad f3 3e LDA $3ef3 ; (key + 0)
14f8 : 85 59 __ STA T5 + 0 
14fa : 4c 8d 19 JMP $198d ; (adv_exec.s338 + 0)
.s366:
14fd : c9 92 __ CMP #$92
14ff : b0 03 __ BCS $1504 ; (adv_exec.s367 + 0)
1501 : 4c 99 19 JMP $1999 ; (adv_exec.s368 + 0)
.s367:
1504 : c9 96 __ CMP #$96
1506 : d0 03 __ BNE $150b ; (adv_exec.s380 + 0)
1508 : 4c 11 19 JMP $1911 ; (adv_exec.s336 + 0)
.s380:
150b : b0 03 __ BCS $1510 ; (adv_exec.s381 + 0)
150d : 4c 9f 18 JMP $189f ; (adv_exec.s382 + 0)
.s381:
1510 : c9 a0 __ CMP #$a0
1512 : d0 03 __ BNE $1517 ; (adv_exec.s386 + 0)
1514 : 4c 35 17 JMP $1735 ; (adv_exec.s211 + 0)
.s386:
1517 : c9 b1 __ CMP #$b1
1519 : f0 04 __ BEQ $151f ; (adv_exec.s295 + 0)
.s365:
151b : a9 01 __ LDA #$01
151d : d0 47 __ BNE $1566 ; (adv_exec.s1292 + 0)
.s295:
151f : c8 __ __ INY
1520 : b1 43 __ LDA (T4 + 0),y 
1522 : 8d 9c 3e STA $3e9c ; (var + 0)
1525 : ee 94 3e INC $3e94 ; (in + 0)
1528 : 18 __ __ CLC
1529 : a5 53 __ LDA T1 + 0 
152b : 69 02 __ ADC #$02
152d : 8d 98 3e STA $3e98 ; (i + 0)
1530 : a5 54 __ LDA T1 + 1 
1532 : 69 00 __ ADC #$00
1534 : 8d 99 3e STA $3e99 ; (i + 1)
1537 : cc 94 3e CPY $3e94 ; (in + 0)
153a : b0 05 __ BCS $1541 ; (adv_exec.s297 + 0)
.s296:
153c : ad 9d 3e LDA $3e9d ; (obj2 + 0)
153f : 90 09 __ BCC $154a ; (adv_exec.s703 + 0)
.s297:
1541 : ad 9c 3e LDA $3e9c ; (var + 0)
1544 : 8d 97 3e STA $3e97 ; (thisobj + 0)
1547 : ad 8c 3e LDA $3e8c ; (obj1 + 0)
.s703:
154a : cd 9c 3e CMP $3e9c ; (var + 0)
154d : d0 03 __ BNE $1552 ; (adv_exec.s299 + 0)
154f : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s299:
1552 : c9 f9 __ CMP #$f9
1554 : d0 03 __ BNE $1559 ; (adv_exec.s303 + 0)
1556 : 4c 2b 17 JMP $172b ; (adv_exec.s302 + 0)
.s303:
1559 : aa __ __ TAX
155a : ad 9c 3e LDA $3e9c ; (var + 0)
155d : c9 f5 __ CMP #$f5
155f : d0 03 __ BNE $1564 ; (adv_exec.s306 + 0)
1561 : 4c 1d 17 JMP $171d ; (adv_exec.s308 + 0)
.s306:
1564 : a9 02 __ LDA #$02
.s1292:
1566 : 8d 95 3e STA $3e95 ; (fail + 0)
.s388:
1569 : ad 95 3e LDA $3e95 ; (fail + 0)
156c : c9 02 __ CMP #$02
156e : d0 03 __ BNE $1573 ; (adv_exec.s392 + 0)
1570 : 4c a7 16 JMP $16a7 ; (adv_exec.s391 + 0)
.s392:
1573 : a9 02 __ LDA #$02
1575 : cd 95 3e CMP $3e95 ; (fail + 0)
1578 : 90 1e __ BCC $1598 ; (adv_exec.s418 + 0)
.s3:
157a : ad 95 3e LDA $3e95 ; (fail + 0)
157d : f0 04 __ BEQ $1583 ; (adv_exec.s466 + 0)
.s464:
157f : a9 00 __ LDA #$00
1581 : f0 07 __ BEQ $158a ; (adv_exec.s1001 + 0)
.s466:
1583 : ad 96 3e LDA $3e96 ; (used + 0)
1586 : f0 02 __ BEQ $158a ; (adv_exec.s1001 + 0)
.s1299:
1588 : a9 01 __ LDA #$01
.s1001:
158a : 8d 8d 3e STA $3e8d ; (executed + 0)
158d : a2 06 __ LDX #$06
158f : bd df cb LDA $cbdf,x ; (adv_exec@stack + 0)
1592 : 95 53 __ STA T1 + 0,x 
1594 : ca __ __ DEX
1595 : 10 f8 __ BPL $158f ; (adv_exec.s1001 + 5)
1597 : 60 __ __ RTS
.s418:
1598 : ee de 3d INC $3dde ; (istack + 0)
159b : ad 99 3e LDA $3e99 ; (i + 1)
159e : cd 93 3e CMP $3e93 ; (pcodelen + 1)
15a1 : d0 06 __ BNE $15a9 ; (adv_exec.s1027 + 0)
.s1026:
15a3 : ad 98 3e LDA $3e98 ; (i + 0)
15a6 : cd 92 3e CMP $3e92 ; (pcodelen + 0)
.s1027:
15a9 : b0 65 __ BCS $1610 ; (adv_exec.s396 + 0)
.s469:
15ab : ad 91 3e LDA $3e91 ; (pcode + 1)
15ae : 85 54 __ STA T1 + 1 
15b0 : ae 90 3e LDX $3e90 ; (pcode + 0)
.l424:
15b3 : 8a __ __ TXA
15b4 : 18 __ __ CLC
15b5 : 6d 98 3e ADC $3e98 ; (i + 0)
15b8 : 85 57 __ STA T3 + 0 
15ba : a5 54 __ LDA T1 + 1 
15bc : 6d 99 3e ADC $3e99 ; (i + 1)
15bf : 85 58 __ STA T3 + 1 
15c1 : a0 00 __ LDY #$00
15c3 : b1 57 __ LDA (T3 + 0),y 
15c5 : c9 88 __ CMP #$88
15c7 : f0 47 __ BEQ $1610 ; (adv_exec.s396 + 0)
.s422:
15c9 : 8d 9e 3e STA $3e9e ; (ch + 0)
15cc : c9 8d __ CMP #$8d
15ce : 90 09 __ BCC $15d9 ; (adv_exec.s426 + 0)
.s428:
15d0 : c9 97 __ CMP #$97
15d2 : b0 05 __ BCS $15d9 ; (adv_exec.s426 + 0)
.s425:
15d4 : ee de 3d INC $3dde ; (istack + 0)
15d7 : 90 0e __ BCC $15e7 ; (adv_exec.s427 + 0)
.s426:
15d9 : c9 85 __ CMP #$85
15db : d0 03 __ BNE $15e0 ; (adv_exec.s430 + 0)
15dd : 4c 9d 16 JMP $169d ; (adv_exec.s429 + 0)
.s430:
15e0 : c9 87 __ CMP #$87
15e2 : d0 03 __ BNE $15e7 ; (adv_exec.s427 + 0)
15e4 : 4c 65 16 JMP $1665 ; (adv_exec.s436 + 0)
.s427:
15e7 : 2c 9e 3e BIT $3e9e ; (ch + 0)
15ea : 10 24 __ BPL $1610 ; (adv_exec.s396 + 0)
.s451:
15ec : ac 9e 3e LDY $3e9e ; (ch + 0)
15ef : b9 80 3d LDA $3d80,y ; (font + 565)
15f2 : 29 7f __ AND #$7f
15f4 : 18 __ __ CLC
15f5 : 6d 98 3e ADC $3e98 ; (i + 0)
15f8 : 8d 98 3e STA $3e98 ; (i + 0)
15fb : a9 00 __ LDA #$00
15fd : 6d 99 3e ADC $3e99 ; (i + 1)
1600 : 8d 99 3e STA $3e99 ; (i + 1)
1603 : cd 93 3e CMP $3e93 ; (pcodelen + 1)
1606 : d0 06 __ BNE $160e ; (adv_exec.s1007 + 0)
.s1006:
1608 : ad 98 3e LDA $3e98 ; (i + 0)
160b : cd 92 3e CMP $3e92 ; (pcodelen + 0)
.s1007:
160e : 90 a3 __ BCC $15b3 ; (adv_exec.l424 + 0)
.s396:
1610 : ad 98 3e LDA $3e98 ; (i + 0)
1613 : 85 53 __ STA T1 + 0 
1615 : 18 __ __ CLC
1616 : 69 01 __ ADC #$01
1618 : 8d 98 3e STA $3e98 ; (i + 0)
161b : ad 99 3e LDA $3e99 ; (i + 1)
161e : aa __ __ TAX
161f : 69 00 __ ADC #$00
1621 : 8d 99 3e STA $3e99 ; (i + 1)
1624 : ad 90 3e LDA $3e90 ; (pcode + 0)
1627 : 18 __ __ CLC
1628 : 65 53 __ ADC T1 + 0 
162a : 85 53 __ STA T1 + 0 
162c : 8a __ __ TXA
162d : 6d 91 3e ADC $3e91 ; (pcode + 1)
1630 : 85 54 __ STA T1 + 1 
1632 : a0 00 __ LDY #$00
1634 : b1 53 __ LDA (T1 + 0),y 
1636 : c9 88 __ CMP #$88
1638 : f0 22 __ BEQ $165c ; (adv_exec.s411 + 0)
.s413:
163a : ad 95 3e LDA $3e95 ; (fail + 0)
163d : f0 03 __ BEQ $1642 ; (adv_exec.s713 + 0)
163f : 4c 7f 15 JMP $157f ; (adv_exec.s464 + 0)
.s713:
1642 : ad 98 3e LDA $3e98 ; (i + 0)
1645 : 85 53 __ STA T1 + 0 
1647 : ad 99 3e LDA $3e99 ; (i + 1)
.s1286:
164a : cd 93 3e CMP $3e93 ; (pcodelen + 1)
164d : d0 05 __ BNE $1654 ; (adv_exec.s1003 + 0)
.s1002:
164f : a5 53 __ LDA T1 + 0 
.s1294:
1651 : cd 92 3e CMP $3e92 ; (pcodelen + 0)
.s1003:
1654 : 90 03 __ BCC $1659 ; (adv_exec.s1003 + 5)
1656 : 4c 7a 15 JMP $157a ; (adv_exec.s3 + 0)
1659 : 4c 94 14 JMP $1494 ; (adv_exec.l2 + 0)
.s411:
165c : 8c 95 3e STY $3e95 ; (fail + 0)
165f : ce 94 3e DEC $3e94 ; (in + 0)
1662 : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
.s436:
1665 : ad de 3d LDA $3dde ; (istack + 0)
1668 : c9 01 __ CMP #$01
166a : f0 0a __ BEQ $1676 ; (adv_exec.s439 + 0)
.s440:
166c : 09 00 __ ORA #$00
166e : f0 a0 __ BEQ $1610 ; (adv_exec.s396 + 0)
.s448:
1670 : ce de 3d DEC $3dde ; (istack + 0)
1673 : 4c ec 15 JMP $15ec ; (adv_exec.s451 + 0)
.s439:
1676 : ad 98 3e LDA $3e98 ; (i + 0)
1679 : 18 __ __ CLC
167a : 69 01 __ ADC #$01
167c : aa __ __ TAX
167d : ad 99 3e LDA $3e99 ; (i + 1)
1680 : 69 00 __ ADC #$00
1682 : cd 93 3e CMP $3e93 ; (pcodelen + 1)
1685 : d0 0d __ BNE $1694 ; (adv_exec.s432 + 0)
.s1010:
1687 : ec 92 3e CPX $3e92 ; (pcodelen + 0)
168a : d0 08 __ BNE $1694 ; (adv_exec.s432 + 0)
.s445:
168c : ad 96 3e LDA $3e96 ; (used + 0)
168f : d0 03 __ BNE $1694 ; (adv_exec.s432 + 0)
1691 : 4c 10 16 JMP $1610 ; (adv_exec.s396 + 0)
.s432:
1694 : 8c de 3d STY $3dde ; (istack + 0)
1697 : 8c 95 3e STY $3e95 ; (fail + 0)
169a : 4c 10 16 JMP $1610 ; (adv_exec.s396 + 0)
.s429:
169d : ad de 3d LDA $3dde ; (istack + 0)
16a0 : c9 01 __ CMP #$01
16a2 : f0 f0 __ BEQ $1694 ; (adv_exec.s432 + 0)
16a4 : 4c e7 15 JMP $15e7 ; (adv_exec.s427 + 0)
.s391:
16a7 : ad 99 3e LDA $3e99 ; (i + 1)
16aa : cd 93 3e CMP $3e93 ; (pcodelen + 1)
16ad : d0 06 __ BNE $16b5 ; (adv_exec.s1039 + 0)
.s1038:
16af : ad 98 3e LDA $3e98 ; (i + 0)
16b2 : cd 92 3e CMP $3e92 ; (pcodelen + 0)
.s1039:
16b5 : 90 03 __ BCC $16ba ; (adv_exec.s468 + 0)
16b7 : 4c 10 16 JMP $1610 ; (adv_exec.s396 + 0)
.s468:
16ba : ad 90 3e LDA $3e90 ; (pcode + 0)
16bd : 85 53 __ STA T1 + 0 
16bf : ad 91 3e LDA $3e91 ; (pcode + 1)
16c2 : 85 54 __ STA T1 + 1 
16c4 : a2 00 __ LDX #$00
.l395:
16c6 : a5 53 __ LDA T1 + 0 
16c8 : 6d 98 3e ADC $3e98 ; (i + 0)
16cb : 85 57 __ STA T3 + 0 
16cd : a5 54 __ LDA T1 + 1 
16cf : 6d 99 3e ADC $3e99 ; (i + 1)
16d2 : 85 58 __ STA T3 + 1 
16d4 : a0 00 __ LDY #$00
16d6 : b1 57 __ LDA (T3 + 0),y 
16d8 : 8d 9e 3e STA $3e9e ; (ch + 0)
16db : a8 __ __ TAY
16dc : c9 88 __ CMP #$88
16de : d0 2b __ BNE $170b ; (adv_exec.s398 + 0)
.s397:
16e0 : 8a __ __ TXA
16e1 : d0 03 __ BNE $16e6 ; (adv_exec.s400 + 0)
16e3 : 4c 10 16 JMP $1610 ; (adv_exec.s396 + 0)
.s400:
16e6 : ca __ __ DEX
.s407:
16e7 : b9 80 3d LDA $3d80,y ; (font + 565)
16ea : 29 7f __ AND #$7f
16ec : 18 __ __ CLC
16ed : 6d 98 3e ADC $3e98 ; (i + 0)
16f0 : 8d 98 3e STA $3e98 ; (i + 0)
16f3 : a9 00 __ LDA #$00
16f5 : 6d 99 3e ADC $3e99 ; (i + 1)
16f8 : 8d 99 3e STA $3e99 ; (i + 1)
16fb : cd 93 3e CMP $3e93 ; (pcodelen + 1)
16fe : d0 06 __ BNE $1706 ; (adv_exec.s1031 + 0)
.s1030:
1700 : ad 98 3e LDA $3e98 ; (i + 0)
1703 : cd 92 3e CMP $3e92 ; (pcodelen + 0)
.s1031:
1706 : 90 be __ BCC $16c6 ; (adv_exec.l395 + 0)
1708 : 4c 10 16 JMP $1610 ; (adv_exec.s396 + 0)
.s398:
170b : ad 9e 3e LDA $3e9e ; (ch + 0)
170e : c9 b1 __ CMP #$b1
1710 : d0 04 __ BNE $1716 ; (adv_exec.s399 + 0)
.s404:
1712 : e8 __ __ INX
1713 : 4c e7 16 JMP $16e7 ; (adv_exec.s407 + 0)
.s399:
1716 : 09 00 __ ORA #$00
1718 : 30 cd __ BMI $16e7 ; (adv_exec.s407 + 0)
171a : 4c 10 16 JMP $1610 ; (adv_exec.s396 + 0)
.s308:
171d : 8e 97 3e STX $3e97 ; (thisobj + 0)
.s708:
1720 : ad 95 3e LDA $3e95 ; (fail + 0)
1723 : d0 03 __ BNE $1728 ; (adv_exec.s708 + 8)
1725 : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
1728 : 4c 69 15 JMP $1569 ; (adv_exec.s388 + 0)
.s302:
172b : ad 9c 3e LDA $3e9c ; (var + 0)
172e : c9 ff __ CMP #$ff
1730 : f0 ee __ BEQ $1720 ; (adv_exec.s708 + 0)
1732 : 4c 64 15 JMP $1564 ; (adv_exec.s306 + 0)
.s211:
1735 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1738 : ad 9c 3e LDA $3e9c ; (var + 0)
173b : 85 59 __ STA T5 + 0 
173d : 8d 9a 3e STA $3e9a ; (varobj + 0)
1740 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1743 : ad 9c 3e LDA $3e9c ; (var + 0)
1746 : 8d 8e 3e STA $3e8e ; (varroom + 0)
1749 : a5 52 __ LDA T0 + 0 
174b : c9 94 __ CMP #$94
174d : d0 03 __ BNE $1752 ; (adv_exec.s265 + 0)
174f : 4c fd 17 JMP $17fd ; (adv_exec.s213 + 0)
.s265:
1752 : b0 03 __ BCS $1757 ; (adv_exec.s266 + 0)
1754 : 4c f6 17 JMP $17f6 ; (adv_exec.s267 + 0)
.s266:
1757 : c9 a0 __ CMP #$a0
1759 : d0 2a __ BNE $1785 ; (adv_exec.s709 + 0)
.s237:
175b : a5 59 __ LDA T5 + 0 
175d : c9 f3 __ CMP #$f3
175f : f0 5f __ BEQ $17c0 ; (adv_exec.s238 + 0)
.s239:
1761 : ad 74 3e LDA $3e74 ; (objloc + 0)
1764 : 85 55 __ STA T2 + 0 
1766 : ad 75 3e LDA $3e75 ; (objloc + 1)
1769 : 85 56 __ STA T2 + 1 
176b : ad 9c 3e LDA $3e9c ; (var + 0)
176e : a4 59 __ LDY T5 + 0 
1770 : c9 f4 __ CMP #$f4
1772 : f0 2f __ BEQ $17a3 ; (adv_exec.s251 + 0)
.s252:
1774 : b1 55 __ LDA (T2 + 0),y 
1776 : cd 9c 3e CMP $3e9c ; (var + 0)
1779 : f0 0a __ BEQ $1785 ; (adv_exec.s709 + 0)
.s258:
177b : a9 03 __ LDA #$03
177d : 8d 95 3e STA $3e95 ; (fail + 0)
1780 : a5 52 __ LDA T0 + 0 
1782 : 4c 88 17 JMP $1788 ; (adv_exec.s1288 + 0)
.s709:
1785 : ad 8f 3e LDA $3e8f ; (opcode + 0)
.s1288:
1788 : c9 a0 __ CMP #$a0
178a : d0 94 __ BNE $1720 ; (adv_exec.s708 + 0)
.s273:
178c : ad 95 3e LDA $3e95 ; (fail + 0)
178f : d0 03 __ BNE $1794 ; (adv_exec.s270 + 0)
1791 : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
.s270:
1794 : ad 92 3e LDA $3e92 ; (pcodelen + 0)
1797 : 8d 98 3e STA $3e98 ; (i + 0)
179a : ad 93 3e LDA $3e93 ; (pcodelen + 1)
179d : 8d 99 3e STA $3e99 ; (i + 1)
17a0 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s251:
17a3 : b1 55 __ LDA (T2 + 0),y 
17a5 : c9 f8 __ CMP #$f8
17a7 : f0 dc __ BEQ $1785 ; (adv_exec.s709 + 0)
.s255:
17a9 : cd dd 3d CMP $3ddd ; (room + 0)
17ac : d0 cd __ BNE $177b ; (adv_exec.s258 + 0)
.s260:
17ae : ad 72 3e LDA $3e72 ; (objattr + 0)
17b1 : 85 55 __ STA T2 + 0 
17b3 : ad 73 3e LDA $3e73 ; (objattr + 1)
17b6 : 85 56 __ STA T2 + 1 
17b8 : b1 55 __ LDA (T2 + 0),y 
17ba : 4a __ __ LSR
17bb : b0 c8 __ BCS $1785 ; (adv_exec.s709 + 0)
17bd : 4c 7b 17 JMP $177b ; (adv_exec.s258 + 0)
.s238:
17c0 : a9 00 __ LDA #$00
17c2 : 8d 9e 3e STA $3e9e ; (ch + 0)
17c5 : ad 47 3e LDA $3e47 ; (obj_count + 0)
17c8 : f0 1d __ BEQ $17e7 ; (adv_exec.s219 + 0)
.s472:
17ca : ad 74 3e LDA $3e74 ; (objloc + 0)
17cd : 85 53 __ STA T1 + 0 
17cf : ad 75 3e LDA $3e75 ; (objloc + 1)
17d2 : 85 54 __ STA T1 + 1 
17d4 : ad 9c 3e LDA $3e9c ; (var + 0)
.l242:
17d7 : ac 9e 3e LDY $3e9e ; (ch + 0)
17da : d1 53 __ CMP (T1 + 0),y 
17dc : f0 09 __ BEQ $17e7 ; (adv_exec.s219 + 0)
.s245:
17de : c8 __ __ INY
17df : 8c 9e 3e STY $3e9e ; (ch + 0)
17e2 : cc 47 3e CPY $3e47 ; (obj_count + 0)
17e5 : 90 f0 __ BCC $17d7 ; (adv_exec.l242 + 0)
.s219:
17e7 : ad 9e 3e LDA $3e9e ; (ch + 0)
17ea : cd 47 3e CMP $3e47 ; (obj_count + 0)
17ed : d0 96 __ BNE $1785 ; (adv_exec.s709 + 0)
.s228:
17ef : a9 03 __ LDA #$03
17f1 : 8d 95 3e STA $3e95 ; (fail + 0)
17f4 : d0 8f __ BNE $1785 ; (adv_exec.s709 + 0)
.s267:
17f6 : c9 90 __ CMP #$90
17f8 : d0 8b __ BNE $1785 ; (adv_exec.s709 + 0)
17fa : 4c 5b 17 JMP $175b ; (adv_exec.s237 + 0)
.s213:
17fd : 18 __ __ CLC
17fe : a5 57 __ LDA T3 + 0 
1800 : 6d 98 3e ADC $3e98 ; (i + 0)
1803 : 85 55 __ STA T2 + 0 
1805 : a5 58 __ LDA T3 + 1 
1807 : 6d 99 3e ADC $3e99 ; (i + 1)
180a : 85 56 __ STA T2 + 1 
180c : a0 00 __ LDY #$00
180e : b1 55 __ LDA (T2 + 0),y 
1810 : 8d a5 3e STA $3ea5 ; (varattr + 0)
1813 : ee 98 3e INC $3e98 ; (i + 0)
1816 : d0 03 __ BNE $181b ; (adv_exec.s1308 + 0)
.s1307:
1818 : ee 99 3e INC $3e99 ; (i + 1)
.s1308:
181b : a5 59 __ LDA T5 + 0 
181d : c9 f3 __ CMP #$f3
181f : d0 4c __ BNE $186d ; (adv_exec.s215 + 0)
.s214:
1821 : 8c 9e 3e STY $3e9e ; (ch + 0)
1824 : ad 47 3e LDA $3e47 ; (obj_count + 0)
1827 : f0 be __ BEQ $17e7 ; (adv_exec.s219 + 0)
.s471:
1829 : ad 6e 3e LDA $3e6e ; (objnameid + 0)
182c : 85 53 __ STA T1 + 0 
182e : ad 6f 3e LDA $3e6f ; (objnameid + 1)
1831 : 85 54 __ STA T1 + 1 
.l218:
1833 : ac 9e 3e LDY $3e9e ; (ch + 0)
1836 : b1 53 __ LDA (T1 + 0),y 
1838 : c9 ff __ CMP #$ff
183a : f0 25 __ BEQ $1861 ; (adv_exec.s220 + 0)
.s221:
183c : ad 74 3e LDA $3e74 ; (objloc + 0)
183f : 85 57 __ STA T3 + 0 
1841 : ad 75 3e LDA $3e75 ; (objloc + 1)
1844 : 85 58 __ STA T3 + 1 
1846 : b1 57 __ LDA (T3 + 0),y 
1848 : cd 8e 3e CMP $3e8e ; (varroom + 0)
184b : d0 14 __ BNE $1861 ; (adv_exec.s220 + 0)
.s226:
184d : ad 72 3e LDA $3e72 ; (objattr + 0)
1850 : 85 57 __ STA T3 + 0 
1852 : ad 73 3e LDA $3e73 ; (objattr + 1)
1855 : 85 58 __ STA T3 + 1 
1857 : ad a5 3e LDA $3ea5 ; (varattr + 0)
185a : 31 57 __ AND (T3 + 0),y 
185c : cd a5 3e CMP $3ea5 ; (varattr + 0)
185f : f0 86 __ BEQ $17e7 ; (adv_exec.s219 + 0)
.s220:
1861 : c8 __ __ INY
1862 : 8c 9e 3e STY $3e9e ; (ch + 0)
1865 : cc 47 3e CPY $3e47 ; (obj_count + 0)
1868 : 90 c9 __ BCC $1833 ; (adv_exec.l218 + 0)
186a : 4c e7 17 JMP $17e7 ; (adv_exec.s219 + 0)
.s215:
186d : ad 74 3e LDA $3e74 ; (objloc + 0)
1870 : 85 55 __ STA T2 + 0 
1872 : ad 75 3e LDA $3e75 ; (objloc + 1)
1875 : 85 56 __ STA T2 + 1 
1877 : a4 59 __ LDY T5 + 0 
1879 : b1 55 __ LDA (T2 + 0),y 
187b : cd 9c 3e CMP $3e9c ; (var + 0)
187e : d0 17 __ BNE $1897 ; (adv_exec.s231 + 0)
.s234:
1880 : ad 72 3e LDA $3e72 ; (objattr + 0)
1883 : 85 55 __ STA T2 + 0 
1885 : ad 73 3e LDA $3e73 ; (objattr + 1)
1888 : 85 56 __ STA T2 + 1 
188a : b1 55 __ LDA (T2 + 0),y 
188c : 2d a5 3e AND $3ea5 ; (varattr + 0)
188f : cd a5 3e CMP $3ea5 ; (varattr + 0)
1892 : d0 03 __ BNE $1897 ; (adv_exec.s231 + 0)
1894 : 4c 85 17 JMP $1785 ; (adv_exec.s709 + 0)
.s231:
1897 : a9 03 __ LDA #$03
1899 : 8d 95 3e STA $3e95 ; (fail + 0)
189c : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s382:
189f : e0 94 __ CPX #$94
18a1 : d0 03 __ BNE $18a6 ; (adv_exec.s383 + 0)
18a3 : 4c 35 17 JMP $1735 ; (adv_exec.s211 + 0)
.s383:
18a6 : e0 94 __ CPX #$94
18a8 : 90 1a __ BCC $18c4 ; (adv_exec.s325 + 0)
.s285:
18aa : 20 24 21 JSR $2124 ; (_alignattr.s0 + 0)
18ad : 20 2b 22 JSR $222b ; (_getattrstrid.s0 + 0)
18b0 : a9 00 __ LDA #$00
18b2 : 8d a1 3e STA $3ea1 ; (text_continue + 0)
18b5 : ad a2 3e LDA $3ea2 ; (strid + 0)
18b8 : c9 ff __ CMP #$ff
18ba : d0 03 __ BNE $18bf ; (adv_exec.s197 + 0)
18bc : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s197:
18bf : a9 03 __ LDA #$03
18c1 : 4c 66 15 JMP $1566 ; (adv_exec.s1292 + 0)
.s325:
18c4 : a0 01 __ LDY #$01
18c6 : b1 43 __ LDA (T4 + 0),y 
18c8 : 8d 9a 3e STA $3e9a ; (varobj + 0)
18cb : 18 __ __ CLC
18cc : a5 53 __ LDA T1 + 0 
18ce : 69 02 __ ADC #$02
18d0 : 8d 98 3e STA $3e98 ; (i + 0)
18d3 : a5 54 __ LDA T1 + 1 
18d5 : 69 00 __ ADC #$00
18d7 : 8d 99 3e STA $3e99 ; (i + 1)
18da : ad 9a 3e LDA $3e9a ; (varobj + 0)
18dd : 4a __ __ LSR
18de : 4a __ __ LSR
18df : 4a __ __ LSR
18e0 : 18 __ __ CLC
18e1 : 6d 7e 3e ADC $3e7e ; (bitvars + 0)
18e4 : 85 55 __ STA T2 + 0 
18e6 : ad 7f 3e LDA $3e7f ; (bitvars + 1)
18e9 : 69 00 __ ADC #$00
18eb : 85 56 __ STA T2 + 1 
18ed : ad 9a 3e LDA $3e9a ; (varobj + 0)
18f0 : 29 07 __ AND #$07
18f2 : a8 __ __ TAY
18f3 : b9 32 3e LDA $3e32,y ; (ormask + 0)
18f6 : a0 00 __ LDY #$00
18f8 : 31 55 __ AND (T2 + 0),y 
18fa : 8d 9c 3e STA $3e9c ; (var + 0)
18fd : e0 8d __ CPX #$8d
18ff : d0 08 __ BNE $1909 ; (adv_exec.s327 + 0)
.s326:
1901 : ad 9c 3e LDA $3e9c ; (var + 0)
1904 : f0 b9 __ BEQ $18bf ; (adv_exec.s197 + 0)
1906 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s327:
1909 : ad 9c 3e LDA $3e9c ; (var + 0)
190c : d0 b1 __ BNE $18bf ; (adv_exec.s197 + 0)
190e : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s336:
1911 : c8 __ __ INY
1912 : b1 43 __ LDA (T4 + 0),y 
1914 : 8d a5 3e STA $3ea5 ; (varattr + 0)
1917 : 18 __ __ CLC
1918 : a5 53 __ LDA T1 + 0 
191a : 69 02 __ ADC #$02
191c : 8d 98 3e STA $3e98 ; (i + 0)
191f : a5 54 __ LDA T1 + 1 
1921 : 69 00 __ ADC #$00
1923 : 8d 99 3e STA $3e99 ; (i + 1)
1926 : ad a5 3e LDA $3ea5 ; (varattr + 0)
1929 : 85 53 __ STA T1 + 0 
192b : 29 40 __ AND #$40
192d : 8d 9b 3e STA $3e9b ; (varmode + 0)
1930 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1933 : ad 9c 3e LDA $3e9c ; (var + 0)
1936 : 85 52 __ STA T0 + 0 
1938 : 8d 9a 3e STA $3e9a ; (varobj + 0)
193b : a5 53 __ LDA T1 + 0 
193d : 29 80 __ AND #$80
193f : 8d 9b 3e STA $3e9b ; (varmode + 0)
1942 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1945 : ad 9c 3e LDA $3e9c ; (var + 0)
1948 : 85 59 __ STA T5 + 0 
194a : 8d 8e 3e STA $3e8e ; (varroom + 0)
194d : a5 53 __ LDA T1 + 0 
194f : 29 3f __ AND #$3f
1951 : c9 02 __ CMP #$02
1953 : d0 0c __ BNE $1961 ; (adv_exec.s358 + 0)
.s348:
1955 : a5 59 __ LDA T5 + 0 
1957 : c5 52 __ CMP T0 + 0 
1959 : 90 03 __ BCC $195e ; (adv_exec.s348 + 9)
195b : 4c bf 18 JMP $18bf ; (adv_exec.s197 + 0)
195e : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s358:
1961 : 90 13 __ BCC $1976 ; (adv_exec.s360 + 0)
.s359:
1963 : c9 03 __ CMP #$03
1965 : f0 03 __ BEQ $196a ; (adv_exec.s353 + 0)
1967 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s353:
196a : a5 52 __ LDA T0 + 0 
196c : c5 59 __ CMP T5 + 0 
196e : 90 03 __ BCC $1973 ; (adv_exec.s353 + 9)
1970 : 4c bf 18 JMP $18bf ; (adv_exec.s197 + 0)
1973 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s360:
1976 : 09 00 __ ORA #$00
1978 : f0 13 __ BEQ $198d ; (adv_exec.s338 + 0)
.s361:
197a : c9 01 __ CMP #$01
197c : f0 03 __ BEQ $1981 ; (adv_exec.s343 + 0)
197e : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s343:
1981 : a5 52 __ LDA T0 + 0 
1983 : c5 59 __ CMP T5 + 0 
1985 : d0 03 __ BNE $198a ; (adv_exec.s343 + 9)
1987 : 4c bf 18 JMP $18bf ; (adv_exec.s197 + 0)
198a : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s338:
198d : a5 52 __ LDA T0 + 0 
.s1287:
198f : c5 59 __ CMP T5 + 0 
1991 : f0 03 __ BEQ $1996 ; (adv_exec.s1287 + 7)
1993 : 4c bf 18 JMP $18bf ; (adv_exec.s197 + 0)
1996 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s368:
1999 : c9 8e __ CMP #$8e
199b : d0 03 __ BNE $19a0 ; (adv_exec.s369 + 0)
199d : 4c 86 1a JMP $1a86 ; (adv_exec.s201 + 0)
.s369:
19a0 : 90 03 __ BCC $19a5 ; (adv_exec.s371 + 0)
19a2 : 4c 33 1a JMP $1a33 ; (adv_exec.s370 + 0)
.s371:
19a5 : c9 87 __ CMP #$87
19a7 : d0 03 __ BNE $19ac ; (adv_exec.s372 + 0)
19a9 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s372:
19ac : b0 7b __ BCS $1a29 ; (adv_exec.s373 + 0)
.s374:
19ae : c9 85 __ CMP #$85
19b0 : f0 03 __ BEQ $19b5 ; (adv_exec.s174 + 0)
19b2 : 4c 1b 15 JMP $151b ; (adv_exec.s365 + 0)
.s174:
19b5 : 8c 9c 3e STY $3e9c ; (var + 0)
19b8 : a5 56 __ LDA T2 + 1 
19ba : cd 93 3e CMP $3e93 ; (pcodelen + 1)
19bd : d0 05 __ BNE $19c4 ; (adv_exec.l1151 + 0)
.s1150:
19bf : a5 55 __ LDA T2 + 0 
.s1295:
19c1 : cd 92 3e CMP $3e92 ; (pcodelen + 0)
.l1151:
19c4 : 90 03 __ BCC $19c9 ; (adv_exec.s176 + 0)
19c6 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s176:
19c9 : a5 57 __ LDA T3 + 0 
19cb : 6d 98 3e ADC $3e98 ; (i + 0)
19ce : 85 55 __ STA T2 + 0 
19d0 : a5 58 __ LDA T3 + 1 
19d2 : 6d 99 3e ADC $3e99 ; (i + 1)
19d5 : 85 56 __ STA T2 + 1 
19d7 : b1 55 __ LDA (T2 + 0),y 
19d9 : aa __ __ TAX
19da : c9 8d __ CMP #$8d
19dc : 90 0d __ BCC $19eb ; (adv_exec.s179 + 0)
.s181:
19de : c9 97 __ CMP #$97
19e0 : b0 09 __ BCS $19eb ; (adv_exec.s179 + 0)
.s178:
19e2 : ad 9c 3e LDA $3e9c ; (var + 0)
19e5 : 85 59 __ STA T5 + 0 
19e7 : e6 59 __ INC T5 + 0 
19e9 : 90 10 __ BCC $19fb ; (adv_exec.s707 + 0)
.s179:
19eb : c9 87 __ CMP #$87
19ed : d0 33 __ BNE $1a22 ; (adv_exec.s183 + 0)
.s182:
19ef : ad 9c 3e LDA $3e9c ; (var + 0)
19f2 : d0 03 __ BNE $19f7 ; (adv_exec.s185 + 0)
19f4 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s185:
19f7 : 85 59 __ STA T5 + 0 
19f9 : c6 59 __ DEC T5 + 0 
.s707:
19fb : a5 59 __ LDA T5 + 0 
19fd : 8d 9c 3e STA $3e9c ; (var + 0)
.s180:
1a00 : 8e 9e 3e STX $3e9e ; (ch + 0)
1a03 : bd 80 3d LDA $3d80,x ; (font + 565)
1a06 : 29 7f __ AND #$7f
1a08 : 18 __ __ CLC
1a09 : 6d 98 3e ADC $3e98 ; (i + 0)
1a0c : 8d 98 3e STA $3e98 ; (i + 0)
1a0f : a9 00 __ LDA #$00
1a11 : 6d 99 3e ADC $3e99 ; (i + 1)
1a14 : 8d 99 3e STA $3e99 ; (i + 1)
1a17 : cd 93 3e CMP $3e93 ; (pcodelen + 1)
1a1a : d0 a8 __ BNE $19c4 ; (adv_exec.l1151 + 0)
.s1140:
1a1c : ad 98 3e LDA $3e98 ; (i + 0)
1a1f : 4c c1 19 JMP $19c1 ; (adv_exec.s1295 + 0)
.s183:
1a22 : c9 88 __ CMP #$88
1a24 : d0 da __ BNE $1a00 ; (adv_exec.s180 + 0)
1a26 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s373:
1a29 : e0 8d __ CPX #$8d
1a2b : d0 03 __ BNE $1a30 ; (adv_exec.s373 + 7)
1a2d : 4c c4 18 JMP $18c4 ; (adv_exec.s325 + 0)
1a30 : 4c 1b 15 JMP $151b ; (adv_exec.s365 + 0)
.s370:
1a33 : e0 90 __ CPX #$90
1a35 : d0 03 __ BNE $1a3a ; (adv_exec.s377 + 0)
1a37 : 4c 35 17 JMP $1735 ; (adv_exec.s211 + 0)
.s377:
1a3a : c8 __ __ INY
1a3b : b1 43 __ LDA (T4 + 0),y 
1a3d : 8d 9c 3e STA $3e9c ; (var + 0)
1a40 : 18 __ __ CLC
1a41 : a5 53 __ LDA T1 + 0 
1a43 : 69 02 __ ADC #$02
1a45 : 8d 98 3e STA $3e98 ; (i + 0)
1a48 : a5 54 __ LDA T1 + 1 
1a4a : 69 00 __ ADC #$00
1a4c : 8d 99 3e STA $3e99 ; (i + 1)
1a4f : e0 90 __ CPX #$90
1a51 : ad 9c 3e LDA $3e9c ; (var + 0)
1a54 : 90 0b __ BCC $1a61 ; (adv_exec.s275 + 0)
.s290:
1a56 : cd dd 3d CMP $3ddd ; (room + 0)
1a59 : f0 03 __ BEQ $1a5e ; (adv_exec.s290 + 8)
1a5b : 4c bf 18 JMP $18bf ; (adv_exec.s197 + 0)
1a5e : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s275:
1a61 : c9 fe __ CMP #$fe
1a63 : d0 0a __ BNE $1a6f ; (adv_exec.s277 + 0)
.s279:
1a65 : ad f5 3e LDA $3ef5 ; (obj1k + 0)
1a68 : c9 02 __ CMP #$02
1a6a : d0 03 __ BNE $1a6f ; (adv_exec.s277 + 0)
1a6c : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s277:
1a6f : ad 9c 3e LDA $3e9c ; (var + 0)
1a72 : c9 fd __ CMP #$fd
1a74 : f0 03 __ BEQ $1a79 ; (adv_exec.s283 + 0)
1a76 : 4c bf 18 JMP $18bf ; (adv_exec.s197 + 0)
.s283:
1a79 : ad f6 3e LDA $3ef6 ; (obj2k + 0)
1a7c : c9 02 __ CMP #$02
1a7e : f0 03 __ BEQ $1a83 ; (adv_exec.s283 + 10)
1a80 : 4c bf 18 JMP $18bf ; (adv_exec.s197 + 0)
1a83 : 4c 20 17 JMP $1720 ; (adv_exec.s708 + 0)
.s201:
1a86 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1a89 : ad 9c 3e LDA $3e9c ; (var + 0)
1a8c : 8d 9a 3e STA $3e9a ; (varobj + 0)
1a8f : 18 __ __ CLC
1a90 : a5 57 __ LDA T3 + 0 
1a92 : 6d 98 3e ADC $3e98 ; (i + 0)
1a95 : 85 55 __ STA T2 + 0 
1a97 : a5 58 __ LDA T3 + 1 
1a99 : 6d 99 3e ADC $3e99 ; (i + 1)
1a9c : 85 56 __ STA T2 + 1 
1a9e : a0 00 __ LDY #$00
1aa0 : b1 55 __ LDA (T2 + 0),y 
1aa2 : 85 59 __ STA T5 + 0 
1aa4 : 8d 9c 3e STA $3e9c ; (var + 0)
1aa7 : ee 98 3e INC $3e98 ; (i + 0)
1aaa : d0 03 __ BNE $1aaf ; (adv_exec.s1306 + 0)
.s1305:
1aac : ee 99 3e INC $3e99 ; (i + 1)
.s1306:
1aaf : ad 9a 3e LDA $3e9a ; (varobj + 0)
1ab2 : c9 f9 __ CMP #$f9
1ab4 : d0 03 __ BNE $1ab9 ; (adv_exec.s203 + 0)
1ab6 : 4c bf 18 JMP $18bf ; (adv_exec.s197 + 0)
.s203:
1ab9 : ad 72 3e LDA $3e72 ; (objattr + 0)
1abc : 85 55 __ STA T2 + 0 
1abe : ad 73 3e LDA $3e73 ; (objattr + 1)
1ac1 : 85 56 __ STA T2 + 1 
1ac3 : ac 9a 3e LDY $3e9a ; (varobj + 0)
1ac6 : b1 55 __ LDA (T2 + 0),y 
1ac8 : 25 59 __ AND T5 + 0 
1aca : 4c 8f 19 JMP $198f ; (adv_exec.s1287 + 0)
.s8:
1acd : ee 96 3e INC $3e96 ; (used + 0)
1ad0 : 8a __ __ TXA
1ad1 : e0 9e __ CPX #$9e
1ad3 : d0 03 __ BNE $1ad8 ; (adv_exec.s121 + 0)
1ad5 : 4c 56 20 JMP $2056 ; (adv_exec.s27 + 0)
.s121:
1ad8 : c9 9e __ CMP #$9e
1ada : b0 03 __ BCS $1adf ; (adv_exec.s122 + 0)
1adc : 4c 4f 1e JMP $1e4f ; (adv_exec.s123 + 0)
.s122:
1adf : c9 a8 __ CMP #$a8
1ae1 : d0 35 __ BNE $1b18 ; (adv_exec.s148 + 0)
.s78:
1ae3 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1ae6 : ad 9c 3e LDA $3e9c ; (var + 0)
1ae9 : 8d 8e 3e STA $3e8e ; (varroom + 0)
1aec : 18 __ __ CLC
1aed : a5 57 __ LDA T3 + 0 
1aef : 6d 98 3e ADC $3e98 ; (i + 0)
1af2 : 85 55 __ STA T2 + 0 
1af4 : a5 58 __ LDA T3 + 1 
1af6 : 6d 99 3e ADC $3e99 ; (i + 1)
1af9 : 85 56 __ STA T2 + 1 
1afb : ad 98 3e LDA $3e98 ; (i + 0)
1afe : 18 __ __ CLC
1aff : 69 01 __ ADC #$01
1b01 : 85 53 __ STA T1 + 0 
1b03 : ad 99 3e LDA $3e99 ; (i + 1)
1b06 : 69 00 __ ADC #$00
1b08 : 85 54 __ STA T1 + 1 
1b0a : a0 00 __ LDY #$00
1b0c : b1 55 __ LDA (T2 + 0),y 
1b0e : a8 __ __ TAY
1b0f : ad 6b 3e LDA $3e6b ; (roomimg + 1)
1b12 : ae 6a 3e LDX $3e6a ; (roomimg + 0)
1b15 : 4c 75 1c JMP $1c75 ; (adv_exec.s716 + 0)
.s148:
1b18 : b0 03 __ BCS $1b1d ; (adv_exec.s149 + 0)
1b1a : 4c 2d 1d JMP $1d2d ; (adv_exec.s150 + 0)
.s149:
1b1d : c9 ad __ CMP #$ad
1b1f : d0 05 __ BNE $1b26 ; (adv_exec.s162 + 0)
.s46:
1b21 : a9 02 __ LDA #$02
1b23 : 4c 27 1d JMP $1d27 ; (adv_exec.s1289 + 0)
.s162:
1b26 : b0 03 __ BCS $1b2b ; (adv_exec.s163 + 0)
1b28 : 4c 36 1c JMP $1c36 ; (adv_exec.s164 + 0)
.s163:
1b2b : c9 af __ CMP #$af
1b2d : d0 03 __ BNE $1b32 ; (adv_exec.s169 + 0)
1b2f : 4c bd 1b JMP $1bbd ; (adv_exec.s67 + 0)
.s169:
1b32 : 90 1d __ BCC $1b51 ; (adv_exec.s94 + 0)
.s170:
1b34 : c9 b0 __ CMP #$b0
1b36 : f0 07 __ BEQ $1b3f ; (adv_exec.s60 + 0)
.s120:
1b38 : a9 01 __ LDA #$01
1b3a : 8d 95 3e STA $3e95 ; (fail + 0)
1b3d : d0 03 __ BNE $1b42 ; (adv_exec.s601 + 0)
.s60:
1b3f : 20 76 2a JSR $2a76 ; (ui_waitkey.s0 + 0)
.s601:
1b42 : a5 56 __ LDA T2 + 1 
1b44 : cd 93 3e CMP $3e93 ; (pcodelen + 1)
1b47 : f0 03 __ BEQ $1b4c ; (adv_exec.s1168 + 0)
1b49 : 4c 54 16 JMP $1654 ; (adv_exec.s1003 + 0)
.s1168:
1b4c : a5 55 __ LDA T2 + 0 
1b4e : 4c 51 16 JMP $1651 ; (adv_exec.s1294 + 0)
.s94:
1b51 : a0 01 __ LDY #$01
1b53 : b1 43 __ LDA (T4 + 0),y 
1b55 : 8d 9a 3e STA $3e9a ; (varobj + 0)
1b58 : a5 53 __ LDA T1 + 0 
1b5a : 69 02 __ ADC #$02
1b5c : 85 53 __ STA T1 + 0 
1b5e : 8d 98 3e STA $3e98 ; (i + 0)
1b61 : a5 54 __ LDA T1 + 1 
1b63 : 69 00 __ ADC #$00
1b65 : 85 54 __ STA T1 + 1 
1b67 : 8d 99 3e STA $3e99 ; (i + 1)
1b6a : ad 9a 3e LDA $3e9a ; (varobj + 0)
1b6d : 4a __ __ LSR
1b6e : 4a __ __ LSR
1b6f : 4a __ __ LSR
1b70 : 8d 9c 3e STA $3e9c ; (var + 0)
1b73 : ad 7e 3e LDA $3e7e ; (bitvars + 0)
1b76 : 18 __ __ CLC
1b77 : 6d 9c 3e ADC $3e9c ; (var + 0)
1b7a : 85 57 __ STA T3 + 0 
1b7c : ad 7f 3e LDA $3e7f ; (bitvars + 1)
1b7f : 69 00 __ ADC #$00
1b81 : 85 58 __ STA T3 + 1 
1b83 : ad 9a 3e LDA $3e9a ; (varobj + 0)
1b86 : 29 07 __ AND #$07
1b88 : 85 55 __ STA T2 + 0 
1b8a : ad 92 3e LDA $3e92 ; (pcodelen + 0)
1b8d : 85 45 __ STA T6 + 0 
1b8f : ad 93 3e LDA $3e93 ; (pcodelen + 1)
1b92 : 85 46 __ STA T6 + 1 
1b94 : 8a __ __ TXA
1b95 : 88 __ __ DEY
1b96 : c9 a4 __ CMP #$a4
1b98 : f0 0a __ BEQ $1ba4 ; (adv_exec.s95 + 0)
.s96:
1b9a : a6 55 __ LDX T2 + 0 
1b9c : bd 3a 3e LDA $3e3a,x ; (xormask + 0)
1b9f : 31 57 __ AND (T3 + 0),y 
1ba1 : 4c ab 1b JMP $1bab ; (adv_exec.s633 + 0)
.s95:
1ba4 : a6 55 __ LDX T2 + 0 
1ba6 : bd 32 3e LDA $3e32,x ; (ormask + 0)
1ba9 : 11 57 __ ORA (T3 + 0),y 
.s633:
1bab : 91 57 __ STA (T3 + 0),y 
1bad : a5 54 __ LDA T1 + 1 
1baf : c5 46 __ CMP T6 + 1 
1bb1 : f0 03 __ BEQ $1bb6 ; (adv_exec.s1172 + 0)
1bb3 : 4c 54 16 JMP $1654 ; (adv_exec.s1003 + 0)
.s1172:
1bb6 : a5 53 __ LDA T1 + 0 
1bb8 : c5 45 __ CMP T6 + 0 
1bba : 4c 54 16 JMP $1654 ; (adv_exec.s1003 + 0)
.s67:
1bbd : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1bc0 : ad 9c 3e LDA $3e9c ; (var + 0)
1bc3 : 8d 9a 3e STA $3e9a ; (varobj + 0)
1bc6 : 18 __ __ CLC
1bc7 : a5 57 __ LDA T3 + 0 
1bc9 : 6d 98 3e ADC $3e98 ; (i + 0)
1bcc : 85 55 __ STA T2 + 0 
1bce : a5 58 __ LDA T3 + 1 
1bd0 : 6d 99 3e ADC $3e99 ; (i + 1)
1bd3 : 85 56 __ STA T2 + 1 
1bd5 : a0 00 __ LDY #$00
1bd7 : b1 55 __ LDA (T2 + 0),y 
1bd9 : 8d 9c 3e STA $3e9c ; (var + 0)
1bdc : ad 98 3e LDA $3e98 ; (i + 0)
1bdf : 18 __ __ CLC
1be0 : 69 01 __ ADC #$01
1be2 : 85 53 __ STA T1 + 0 
1be4 : 8d 98 3e STA $3e98 ; (i + 0)
1be7 : ad 99 3e LDA $3e99 ; (i + 1)
1bea : 69 00 __ ADC #$00
1bec : 85 54 __ STA T1 + 1 
1bee : 8d 99 3e STA $3e99 ; (i + 1)
1bf1 : a5 52 __ LDA T0 + 0 
1bf3 : c9 a5 __ CMP #$a5
1bf5 : f0 25 __ BEQ $1c1c ; (adv_exec.s71 + 0)
.s73:
1bf7 : c9 af __ CMP #$af
1bf9 : f0 03 __ BEQ $1bfe ; (adv_exec.s69 + 0)
1bfb : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
.s69:
1bfe : ad 72 3e LDA $3e72 ; (objattr + 0)
1c01 : 18 __ __ CLC
1c02 : 6d 9a 3e ADC $3e9a ; (varobj + 0)
1c05 : 85 57 __ STA T3 + 0 
1c07 : ad 73 3e LDA $3e73 ; (objattr + 1)
1c0a : 69 00 __ ADC #$00
1c0c : 85 58 __ STA T3 + 1 
1c0e : a9 ff __ LDA #$ff
1c10 : 4d 9c 3e EOR $3e9c ; (var + 0)
1c13 : 31 57 __ AND (T3 + 0),y 
1c15 : 91 57 __ STA (T3 + 0),y 
.s1293:
1c17 : a5 54 __ LDA T1 + 1 
1c19 : 4c 4a 16 JMP $164a ; (adv_exec.s1286 + 0)
.s71:
1c1c : ad 72 3e LDA $3e72 ; (objattr + 0)
1c1f : 18 __ __ CLC
1c20 : 6d 9a 3e ADC $3e9a ; (varobj + 0)
1c23 : 85 55 __ STA T2 + 0 
1c25 : ad 73 3e LDA $3e73 ; (objattr + 1)
1c28 : 69 00 __ ADC #$00
1c2a : 85 56 __ STA T2 + 1 
1c2c : ad 9c 3e LDA $3e9c ; (var + 0)
1c2f : 11 55 __ ORA (T2 + 0),y 
1c31 : 91 55 __ STA (T2 + 0),y 
1c33 : 4c 17 1c JMP $1c17 ; (adv_exec.s1293 + 0)
.s164:
1c36 : c9 ab __ CMP #$ab
1c38 : f0 70 __ BEQ $1caa ; (adv_exec.s106 + 0)
.s165:
1c3a : b0 56 __ BCS $1c92 ; (adv_exec.s62 + 0)
.s167:
1c3c : c9 aa __ CMP #$aa
1c3e : f0 03 __ BEQ $1c43 ; (adv_exec.s76 + 0)
1c40 : 4c 38 1b JMP $1b38 ; (adv_exec.s120 + 0)
.s76:
1c43 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1c46 : ad 9c 3e LDA $3e9c ; (var + 0)
1c49 : 8d 8e 3e STA $3e8e ; (varroom + 0)
1c4c : 18 __ __ CLC
1c4d : a5 57 __ LDA T3 + 0 
1c4f : 6d 98 3e ADC $3e98 ; (i + 0)
1c52 : 85 55 __ STA T2 + 0 
1c54 : a5 58 __ LDA T3 + 1 
1c56 : 6d 99 3e ADC $3e99 ; (i + 1)
1c59 : 85 56 __ STA T2 + 1 
1c5b : ad 98 3e LDA $3e98 ; (i + 0)
1c5e : 18 __ __ CLC
1c5f : 69 01 __ ADC #$01
1c61 : 85 53 __ STA T1 + 0 
1c63 : ad 99 3e LDA $3e99 ; (i + 1)
1c66 : 69 00 __ ADC #$00
1c68 : 85 54 __ STA T1 + 1 
1c6a : a0 00 __ LDY #$00
1c6c : b1 55 __ LDA (T2 + 0),y 
1c6e : a8 __ __ TAY
1c6f : ad 6d 3e LDA $3e6d ; (roomovrimg + 1)
1c72 : ae 6c 3e LDX $3e6c ; (roomovrimg + 0)
.s716:
1c75 : 86 55 __ STX T2 + 0 
1c77 : 85 56 __ STA T2 + 1 
1c79 : a5 53 __ LDA T1 + 0 
1c7b : 8d 98 3e STA $3e98 ; (i + 0)
1c7e : a5 54 __ LDA T1 + 1 
1c80 : 8d 99 3e STA $3e99 ; (i + 1)
1c83 : 98 __ __ TYA
1c84 : ac 9c 3e LDY $3e9c ; (var + 0)
1c87 : 8d 9c 3e STA $3e9c ; (var + 0)
1c8a : 91 55 __ STA (T2 + 0),y 
1c8c : 20 c5 31 JSR $31c5 ; (os_roomimage_load.s0 + 0)
1c8f : 4c 17 1c JMP $1c17 ; (adv_exec.s1293 + 0)
.s62:
1c92 : a5 53 __ LDA T1 + 0 
1c94 : 69 01 __ ADC #$01
1c96 : 85 53 __ STA T1 + 0 
1c98 : 8d 98 3e STA $3e98 ; (i + 0)
1c9b : a5 54 __ LDA T1 + 1 
1c9d : 69 00 __ ADC #$00
1c9f : 85 54 __ STA T1 + 1 
1ca1 : 8d 99 3e STA $3e99 ; (i + 1)
1ca4 : 20 74 2c JSR $2c74 ; (ui_room_update.l27 + 0)
1ca7 : 4c 17 1c JMP $1c17 ; (adv_exec.s1293 + 0)
.s106:
1caa : a0 01 __ LDY #$01
1cac : b1 43 __ LDA (T4 + 0),y 
1cae : 85 59 __ STA T5 + 0 
1cb0 : 8d 9a 3e STA $3e9a ; (varobj + 0)
1cb3 : 18 __ __ CLC
1cb4 : a5 53 __ LDA T1 + 0 
1cb6 : 69 02 __ ADC #$02
1cb8 : 8d 98 3e STA $3e98 ; (i + 0)
1cbb : a5 54 __ LDA T1 + 1 
1cbd : 69 00 __ ADC #$00
1cbf : 8d 99 3e STA $3e99 ; (i + 1)
1cc2 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1cc5 : a5 52 __ LDA T0 + 0 
1cc7 : c9 84 __ CMP #$84
1cc9 : d0 1a __ BNE $1ce5 ; (adv_exec.s114 + 0)
.s110:
1ccb : ad 80 3e LDA $3e80 ; (vars + 0)
1cce : 18 __ __ CLC
1ccf : 65 59 __ ADC T5 + 0 
1cd1 : 85 53 __ STA T1 + 0 
1cd3 : ad 81 3e LDA $3e81 ; (vars + 1)
1cd6 : 69 00 __ ADC #$00
1cd8 : 85 54 __ STA T1 + 1 
1cda : a0 00 __ LDY #$00
1cdc : b1 53 __ LDA (T1 + 0),y 
1cde : 38 __ __ SEC
1cdf : ed 9c 3e SBC $3e9c ; (var + 0)
1ce2 : 4c 05 1d JMP $1d05 ; (adv_exec.s1290 + 0)
.s114:
1ce5 : b0 23 __ BCS $1d0a ; (adv_exec.s115 + 0)
.s116:
1ce7 : c9 81 __ CMP #$81
1ce9 : f0 03 __ BEQ $1cee ; (adv_exec.s108 + 0)
1ceb : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
.s108:
1cee : ad 80 3e LDA $3e80 ; (vars + 0)
1cf1 : 18 __ __ CLC
1cf2 : 65 59 __ ADC T5 + 0 
1cf4 : 85 53 __ STA T1 + 0 
1cf6 : ad 81 3e LDA $3e81 ; (vars + 1)
1cf9 : 69 00 __ ADC #$00
1cfb : 85 54 __ STA T1 + 1 
1cfd : ad 9c 3e LDA $3e9c ; (var + 0)
1d00 : 18 __ __ CLC
1d01 : a0 00 __ LDY #$00
1d03 : 71 53 __ ADC (T1 + 0),y 
.s1290:
1d05 : 91 53 __ STA (T1 + 0),y 
1d07 : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
.s115:
1d0a : c9 ab __ CMP #$ab
1d0c : f0 03 __ BEQ $1d11 ; (adv_exec.s112 + 0)
1d0e : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
.s112:
1d11 : a5 59 __ LDA T5 + 0 
.s717:
1d13 : 18 __ __ CLC
1d14 : 6d 80 3e ADC $3e80 ; (vars + 0)
1d17 : 85 53 __ STA T1 + 0 
1d19 : ad 81 3e LDA $3e81 ; (vars + 1)
.s1291:
1d1c : 69 00 __ ADC #$00
1d1e : 85 54 __ STA T1 + 1 
1d20 : ad 9c 3e LDA $3e9c ; (var + 0)
1d23 : a0 00 __ LDY #$00
1d25 : f0 de __ BEQ $1d05 ; (adv_exec.s1290 + 0)
.s1289:
1d27 : 8d e3 3d STA $3de3 ; (quit_request + 0)
1d2a : 4c 42 1b JMP $1b42 ; (adv_exec.s601 + 0)
.s150:
1d2d : c9 a3 __ CMP #$a3
1d2f : d0 18 __ BNE $1d49 ; (adv_exec.s151 + 0)
.s50:
1d31 : ad 78 3e LDA $3e78 ; (roomstart + 0)
1d34 : 85 53 __ STA T1 + 0 
1d36 : ad 79 3e LDA $3e79 ; (roomstart + 1)
1d39 : 85 54 __ STA T1 + 1 
1d3b : ad dd 3d LDA $3ddd ; (room + 0)
1d3e : 91 53 __ STA (T1 + 0),y 
1d40 : 20 e4 2a JSR $2ae4 ; (adv_save.s0 + 0)
1d43 : ee f2 3e INC $3ef2 ; (saved + 0)
1d46 : 4c 42 1b JMP $1b42 ; (adv_exec.s601 + 0)
.s151:
1d49 : b0 03 __ BCS $1d4e ; (adv_exec.s152 + 0)
1d4b : 4c d9 1d JMP $1dd9 ; (adv_exec.s153 + 0)
.s152:
1d4e : c9 a5 __ CMP #$a5
1d50 : d0 03 __ BNE $1d55 ; (adv_exec.s158 + 0)
1d52 : 4c bd 1b JMP $1bbd ; (adv_exec.s67 + 0)
.s158:
1d55 : b0 03 __ BCS $1d5a ; (adv_exec.s159 + 0)
1d57 : 4c 51 1b JMP $1b51 ; (adv_exec.s94 + 0)
.s159:
1d5a : c9 a6 __ CMP #$a6
1d5c : f0 03 __ BEQ $1d61 ; (adv_exec.s80 + 0)
1d5e : 4c 38 1b JMP $1b38 ; (adv_exec.s120 + 0)
.s80:
1d61 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1d64 : ad 9c 3e LDA $3e9c ; (var + 0)
1d67 : 8d 9a 3e STA $3e9a ; (varobj + 0)
1d6a : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1d6d : ad 9c 3e LDA $3e9c ; (var + 0)
1d70 : 85 52 __ STA T0 + 0 
1d72 : 8d 8e 3e STA $3e8e ; (varroom + 0)
1d75 : a9 00 __ LDA #$00
1d77 : 8d 9e 3e STA $3e9e ; (ch + 0)
1d7a : 8d 9c 3e STA $3e9c ; (var + 0)
1d7d : 18 __ __ CLC
1d7e : a5 57 __ LDA T3 + 0 
1d80 : 6d 98 3e ADC $3e98 ; (i + 0)
1d83 : 85 55 __ STA T2 + 0 
1d85 : a5 58 __ LDA T3 + 1 
1d87 : 6d 99 3e ADC $3e99 ; (i + 1)
1d8a : 85 56 __ STA T2 + 1 
1d8c : a0 00 __ LDY #$00
1d8e : b1 55 __ LDA (T2 + 0),y 
1d90 : 8d a5 3e STA $3ea5 ; (varattr + 0)
1d93 : ee 98 3e INC $3e98 ; (i + 0)
1d96 : d0 03 __ BNE $1d9b ; (adv_exec.s1304 + 0)
.s1303:
1d98 : ee 99 3e INC $3e99 ; (i + 1)
.s1304:
1d9b : ad 47 3e LDA $3e47 ; (obj_count + 0)
1d9e : f0 33 __ BEQ $1dd3 ; (adv_exec.s83 + 0)
.s467:
1da0 : ad 74 3e LDA $3e74 ; (objloc + 0)
1da3 : 85 53 __ STA T1 + 0 
1da5 : ad 75 3e LDA $3e75 ; (objloc + 1)
1da8 : 85 54 __ STA T1 + 1 
.l82:
1daa : a5 52 __ LDA T0 + 0 
1dac : ac 9e 3e LDY $3e9e ; (ch + 0)
1daf : d1 53 __ CMP (T1 + 0),y 
1db1 : d0 17 __ BNE $1dca ; (adv_exec.s638 + 0)
.s87:
1db3 : ad 72 3e LDA $3e72 ; (objattr + 0)
1db6 : 85 57 __ STA T3 + 0 
1db8 : ad 73 3e LDA $3e73 ; (objattr + 1)
1dbb : 85 58 __ STA T3 + 1 
1dbd : ad a5 3e LDA $3ea5 ; (varattr + 0)
1dc0 : 31 57 __ AND (T3 + 0),y 
1dc2 : cd a5 3e CMP $3ea5 ; (varattr + 0)
1dc5 : d0 03 __ BNE $1dca ; (adv_exec.s638 + 0)
.s84:
1dc7 : ee 9c 3e INC $3e9c ; (var + 0)
.s638:
1dca : c8 __ __ INY
1dcb : 8c 9e 3e STY $3e9e ; (ch + 0)
1dce : cc 47 3e CPY $3e47 ; (obj_count + 0)
1dd1 : 90 d7 __ BCC $1daa ; (adv_exec.l82 + 0)
.s83:
1dd3 : ad 9a 3e LDA $3e9a ; (varobj + 0)
1dd6 : 4c 13 1d JMP $1d13 ; (adv_exec.s717 + 0)
.s153:
1dd9 : e0 a1 __ CPX #$a1
1ddb : d0 22 __ BNE $1dff ; (adv_exec.s154 + 0)
.s91:
1ddd : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1de0 : ad 9c 3e LDA $3e9c ; (var + 0)
1de3 : 85 52 __ STA T0 + 0 
1de5 : 8d 9a 3e STA $3e9a ; (varobj + 0)
1de8 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1deb : ad 9c 3e LDA $3e9c ; (var + 0)
1dee : 8d 8e 3e STA $3e8e ; (varroom + 0)
1df1 : ad 74 3e LDA $3e74 ; (objloc + 0)
1df4 : 18 __ __ CLC
1df5 : 65 52 __ ADC T0 + 0 
1df7 : 85 53 __ STA T1 + 0 
1df9 : ad 75 3e LDA $3e75 ; (objloc + 1)
1dfc : 4c 1c 1d JMP $1d1c ; (adv_exec.s1291 + 0)
.s154:
1dff : e0 a1 __ CPX #$a1
1e01 : b0 47 __ BCS $1e4a ; (adv_exec.s44 + 0)
.s156:
1e03 : e0 9f __ CPX #$9f
1e05 : f0 03 __ BEQ $1e0a ; (adv_exec.s13 + 0)
1e07 : 4c 38 1b JMP $1b38 ; (adv_exec.s120 + 0)
.s13:
1e0a : e0 9b __ CPX #$9b
1e0c : f0 14 __ BEQ $1e22 ; (adv_exec.s14 + 0)
.s15:
1e0e : a9 01 __ LDA #$01
1e10 : 8d 9b 3e STA $3e9b ; (varmode + 0)
1e13 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1e16 : ad 9c 3e LDA $3e9c ; (var + 0)
1e19 : 8d 8e 3e STA $3e8e ; (varroom + 0)
1e1c : 8d 9a 3e STA $3e9a ; (varobj + 0)
1e1f : 4c 25 1e JMP $1e25 ; (adv_exec.s621 + 0)
.s14:
1e22 : 20 24 21 JSR $2124 ; (_alignattr.s0 + 0)
.s621:
1e25 : 20 2b 22 JSR $222b ; (_getattrstrid.s0 + 0)
1e28 : ad a2 3e LDA $3ea2 ; (strid + 0)
1e2b : c9 ff __ CMP #$ff
1e2d : d0 08 __ BNE $1e37 ; (adv_exec.s18 + 0)
.s17:
1e2f : a9 01 __ LDA #$01
1e31 : 8d 95 3e STA $3e95 ; (fail + 0)
1e34 : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
.s18:
1e37 : 20 be 23 JSR $23be ; (_getstring.s0 + 0)
1e3a : ad a8 3e LDA $3ea8 ; (ostr + 0)
1e3d : 85 13 __ STA P6 
1e3f : ad a9 3e LDA $3ea9 ; (ostr + 1)
1e42 : 85 14 __ STA P7 
1e44 : 20 93 24 JSR $2493 ; (ui_text_write.s0 + 0)
1e47 : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
.s44:
1e4a : a9 01 __ LDA #$01
1e4c : 4c 27 1d JMP $1d27 ; (adv_exec.s1289 + 0)
.s123:
1e4f : c9 8b __ CMP #$8b
1e51 : d0 09 __ BNE $1e5c ; (adv_exec.s124 + 0)
.s64:
1e53 : c8 __ __ INY
1e54 : b1 43 __ LDA (T4 + 0),y 
1e56 : 8d fa 3d STA $3dfa ; (nextroom + 0)
1e59 : 4c 42 20 JMP $2042 ; (adv_exec.s715 + 0)
.s124:
1e5c : b0 03 __ BCS $1e61 ; (adv_exec.s125 + 0)
1e5e : 4c 70 1f JMP $1f70 ; (adv_exec.s126 + 0)
.s125:
1e61 : e0 9a __ CPX #$9a
1e63 : d0 07 __ BNE $1e6c ; (adv_exec.s1233 + 0)
.s1232:
1e65 : a9 01 __ LDA #$01
1e67 : 85 59 __ STA T5 + 0 
1e69 : 4c 2a 1f JMP $1f2a ; (adv_exec.s36 + 0)
.s1233:
1e6c : 84 59 __ STY T5 + 0 
1e6e : e0 9a __ CPX #$9a
1e70 : 90 6c __ BCC $1ede ; (adv_exec.s140 + 0)
.s139:
1e72 : e0 9c __ CPX #$9c
1e74 : f0 64 __ BEQ $1eda ; (adv_exec.s1237 + 0)
.s145:
1e76 : e0 9c __ CPX #$9c
1e78 : 90 90 __ BCC $1e0a ; (adv_exec.s13 + 0)
.s22:
1e7a : 18 __ __ CLC
1e7b : a5 53 __ LDA T1 + 0 
1e7d : 69 02 __ ADC #$02
1e7f : 85 53 __ STA T1 + 0 
1e81 : 8d 98 3e STA $3e98 ; (i + 0)
1e84 : a5 54 __ LDA T1 + 1 
1e86 : 69 00 __ ADC #$00
1e88 : 85 54 __ STA T1 + 1 
1e8a : 8d 99 3e STA $3e99 ; (i + 1)
1e8d : ad 4a 3e LDA $3e4a ; (advnames + 0)
1e90 : 8d 9f 3e STA $3e9f ; (str + 0)
1e93 : ad 4b 3e LDA $3e4b ; (advnames + 1)
1e96 : 8d a0 3e STA $3ea0 ; (str + 1)
1e99 : ad 80 3e LDA $3e80 ; (vars + 0)
1e9c : 85 57 __ STA T3 + 0 
1e9e : ad 81 3e LDA $3e81 ; (vars + 1)
1ea1 : 85 58 __ STA T3 + 1 
1ea3 : a0 01 __ LDY #$01
1ea5 : b1 43 __ LDA (T4 + 0),y 
1ea7 : a8 __ __ TAY
1ea8 : b1 57 __ LDA (T3 + 0),y 
1eaa : a8 __ __ TAY
1eab : a5 59 __ LDA T5 + 0 
1ead : d0 09 __ BNE $1eb8 ; (adv_exec.s23 + 0)
.s24:
1eaf : ad 67 3e LDA $3e67 ; (roomnameid + 1)
1eb2 : ae 66 3e LDX $3e66 ; (roomnameid + 0)
1eb5 : 4c be 1e JMP $1ebe ; (adv_exec.s720 + 0)
.s23:
1eb8 : ad 6f 3e LDA $3e6f ; (objnameid + 1)
1ebb : ae 6e 3e LDX $3e6e ; (objnameid + 0)
.s720:
1ebe : 86 55 __ STX T2 + 0 
1ec0 : 85 56 __ STA T2 + 1 
1ec2 : b1 55 __ LDA (T2 + 0),y 
1ec4 : 8d a2 3e STA $3ea2 ; (strid + 0)
.s719:
1ec7 : 20 be 23 JSR $23be ; (_getstring.s0 + 0)
1eca : ad a8 3e LDA $3ea8 ; (ostr + 0)
1ecd : 85 13 __ STA P6 
1ecf : ad a9 3e LDA $3ea9 ; (ostr + 1)
1ed2 : 85 14 __ STA P7 
.s714:
1ed4 : 20 93 24 JSR $2493 ; (ui_text_write.s0 + 0)
1ed7 : 4c 17 1c JMP $1c17 ; (adv_exec.s1293 + 0)
.s1237:
1eda : e6 59 __ INC T5 + 0 
1edc : d0 9c __ BNE $1e7a ; (adv_exec.s22 + 0)
.s140:
1ede : c9 98 __ CMP #$98
1ee0 : d0 05 __ BNE $1ee7 ; (adv_exec.s141 + 0)
.s48:
1ee2 : a9 03 __ LDA #$03
1ee4 : 4c 27 1d JMP $1d27 ; (adv_exec.s1289 + 0)
.s141:
1ee7 : b0 41 __ BCS $1f2a ; (adv_exec.s36 + 0)
.s143:
1ee9 : c9 97 __ CMP #$97
1eeb : f0 03 __ BEQ $1ef0 ; (adv_exec.s89 + 0)
1eed : 4c 38 1b JMP $1b38 ; (adv_exec.s120 + 0)
.s89:
1ef0 : 20 31 21 JSR $2131 ; (_getobj.s0 + 0)
1ef3 : ad 9c 3e LDA $3e9c ; (var + 0)
1ef6 : 8d 8e 3e STA $3e8e ; (varroom + 0)
1ef9 : 18 __ __ CLC
1efa : a5 57 __ LDA T3 + 0 
1efc : 6d 98 3e ADC $3e98 ; (i + 0)
1eff : 85 55 __ STA T2 + 0 
1f01 : a5 58 __ LDA T3 + 1 
1f03 : 6d 99 3e ADC $3e99 ; (i + 1)
1f06 : 85 56 __ STA T2 + 1 
1f08 : a0 00 __ LDY #$00
1f0a : b1 55 __ LDA (T2 + 0),y 
1f0c : 8d a5 3e STA $3ea5 ; (varattr + 0)
1f0f : ad 98 3e LDA $3e98 ; (i + 0)
1f12 : 18 __ __ CLC
1f13 : 69 01 __ ADC #$01
1f15 : 85 53 __ STA T1 + 0 
1f17 : 8d 98 3e STA $3e98 ; (i + 0)
1f1a : ad 99 3e LDA $3e99 ; (i + 1)
1f1d : 69 00 __ ADC #$00
1f1f : 85 54 __ STA T1 + 1 
1f21 : 8d 99 3e STA $3e99 ; (i + 1)
1f24 : 20 11 32 JSR $3211 ; (draw_roomobj.s0 + 0)
1f27 : 4c 17 1c JMP $1c17 ; (adv_exec.s1293 + 0)
.s36:
1f2a : a0 01 __ LDY #$01
1f2c : b1 43 __ LDA (T4 + 0),y 
1f2e : 8d a2 3e STA $3ea2 ; (strid + 0)
1f31 : 8d 9c 3e STA $3e9c ; (var + 0)
1f34 : 18 __ __ CLC
1f35 : a5 53 __ LDA T1 + 0 
1f37 : 69 02 __ ADC #$02
1f39 : 85 53 __ STA T1 + 0 
1f3b : 8d 98 3e STA $3e98 ; (i + 0)
1f3e : a5 54 __ LDA T1 + 1 
1f40 : 69 00 __ ADC #$00
1f42 : 85 54 __ STA T1 + 1 
1f44 : 8d 99 3e STA $3e99 ; (i + 1)
1f47 : a5 59 __ LDA T5 + 0 
1f49 : d0 09 __ BNE $1f54 ; (adv_exec.s37 + 0)
.s38:
1f4b : ad 4f 3e LDA $3e4f ; (msgs + 1)
1f4e : ae 4e 3e LDX $3e4e ; (msgs + 0)
1f51 : 4c 5a 1f JMP $1f5a ; (adv_exec.s39 + 0)
.s37:
1f54 : ad 51 3e LDA $3e51 ; (msgs2 + 1)
1f57 : ae 50 3e LDX $3e50 ; (msgs2 + 0)
.s39:
1f5a : 8e 9f 3e STX $3e9f ; (str + 0)
1f5d : 8d a0 3e STA $3ea0 ; (str + 1)
1f60 : ad a2 3e LDA $3ea2 ; (strid + 0)
1f63 : c9 ff __ CMP #$ff
1f65 : f0 03 __ BEQ $1f6a ; (adv_exec.s40 + 0)
1f67 : 4c c7 1e JMP $1ec7 ; (adv_exec.s719 + 0)
.s40:
1f6a : 8c 95 3e STY $3e95 ; (fail + 0)
1f6d : 4c 17 1c JMP $1c17 ; (adv_exec.s1293 + 0)
.s126:
1f70 : c9 83 __ CMP #$83
1f72 : d0 2b __ BNE $1f9f ; (adv_exec.s127 + 0)
.s54:
1f74 : ad 44 3e LDA $3e44 ; (freemem + 0)
1f77 : 85 0d __ STA P0 
1f79 : ad 45 3e LDA $3e45 ; (freemem + 1)
1f7c : 85 0e __ STA P1 
1f7e : ad 84 3e LDA $3e84 ; (tmp + 0)
1f81 : 85 0f __ STA P2 
1f83 : ad 85 3e LDA $3e85 ; (tmp + 1)
1f86 : 85 10 __ STA P3 
1f88 : 20 e7 2b JSR $2be7 ; (mini_itoa.s0 + 0)
1f8b : a5 0f __ LDA P2 
1f8d : 85 13 __ STA P6 
1f8f : 8d a8 3e STA $3ea8 ; (ostr + 0)
1f92 : a5 10 __ LDA P3 
1f94 : 85 14 __ STA P7 
1f96 : 8d a9 3e STA $3ea9 ; (ostr + 1)
1f99 : 20 93 24 JSR $2493 ; (ui_text_write.s0 + 0)
1f9c : 4c 42 1b JMP $1b42 ; (adv_exec.s601 + 0)
.s127:
1f9f : b0 7c __ BCS $201d ; (adv_exec.s128 + 0)
.s129:
1fa1 : c9 81 __ CMP #$81
1fa3 : d0 03 __ BNE $1fa8 ; (adv_exec.s130 + 0)
1fa5 : 4c aa 1c JMP $1caa ; (adv_exec.s106 + 0)
.s130:
1fa8 : b0 6d __ BCS $2017 ; (adv_exec.s56 + 0)
.s132:
1faa : c9 80 __ CMP #$80
1fac : f0 03 __ BEQ $1fb1 ; (adv_exec.s99 + 0)
1fae : 4c 38 1b JMP $1b38 ; (adv_exec.s120 + 0)
.s99:
1fb1 : c8 __ __ INY
1fb2 : b1 43 __ LDA (T4 + 0),y 
1fb4 : 8d 9a 3e STA $3e9a ; (varobj + 0)
1fb7 : 18 __ __ CLC
1fb8 : a5 53 __ LDA T1 + 0 
1fba : 69 02 __ ADC #$02
1fbc : 85 53 __ STA T1 + 0 
1fbe : 8d 98 3e STA $3e98 ; (i + 0)
1fc1 : a5 54 __ LDA T1 + 1 
1fc3 : 69 00 __ ADC #$00
1fc5 : 85 54 __ STA T1 + 1 
1fc7 : 8d 99 3e STA $3e99 ; (i + 1)
1fca : ad 9a 3e LDA $3e9a ; (varobj + 0)
1fcd : 4a __ __ LSR
1fce : 4a __ __ LSR
1fcf : 4a __ __ LSR
1fd0 : 8d 9c 3e STA $3e9c ; (var + 0)
1fd3 : ad 9a 3e LDA $3e9a ; (varobj + 0)
1fd6 : 29 07 __ AND #$07
1fd8 : aa __ __ TAX
1fd9 : ad 7e 3e LDA $3e7e ; (bitvars + 0)
1fdc : 18 __ __ CLC
1fdd : 6d 9c 3e ADC $3e9c ; (var + 0)
1fe0 : 85 57 __ STA T3 + 0 
1fe2 : ad 7f 3e LDA $3e7f ; (bitvars + 1)
1fe5 : 69 00 __ ADC #$00
1fe7 : 85 58 __ STA T3 + 1 
1fe9 : 88 __ __ DEY
1fea : b1 57 __ LDA (T3 + 0),y 
1fec : 85 59 __ STA T5 + 0 
1fee : 3d 32 3e AND $3e32,x ; (ormask + 0)
1ff1 : 8d a5 3e STA $3ea5 ; (varattr + 0)
1ff4 : f0 03 __ BEQ $1ff9 ; (adv_exec.s100 + 0)
1ff6 : 4c 42 16 JMP $1642 ; (adv_exec.s713 + 0)
.s100:
1ff9 : bd 32 3e LDA $3e32,x ; (ormask + 0)
1ffc : 05 59 __ ORA T5 + 0 
1ffe : 91 57 __ STA (T3 + 0),y 
2000 : ad 80 3e LDA $3e80 ; (vars + 0)
2003 : 85 55 __ STA T2 + 0 
2005 : ad 81 3e LDA $3e81 ; (vars + 1)
2008 : 85 56 __ STA T2 + 1 
200a : b1 55 __ LDA (T2 + 0),y 
200c : 18 __ __ CLC
200d : 69 01 __ ADC #$01
200f : 91 55 __ STA (T2 + 0),y 
2011 : 20 1d 31 JSR $311d ; (core_drawscore.s0 + 0)
2014 : 4c 17 1c JMP $1c17 ; (adv_exec.s1293 + 0)
.s56:
2017 : 20 85 12 JSR $1285 ; (ui_clear.s0 + 0)
201a : 4c 42 1b JMP $1b42 ; (adv_exec.s601 + 0)
.s128:
201d : c9 89 __ CMP #$89
201f : d0 0c __ BNE $202d ; (adv_exec.s134 + 0)
.s58:
2021 : 20 cd 2a JSR $2acd ; (ui_getkey.l2 + 0)
2024 : ad 9e 3e LDA $3e9e ; (ch + 0)
2027 : 8d f3 3e STA $3ef3 ; (key + 0)
202a : 4c 42 1b JMP $1b42 ; (adv_exec.s601 + 0)
.s134:
202d : b0 0a __ BCS $2039 ; (adv_exec.s52 + 0)
.s136:
202f : c9 84 __ CMP #$84
2031 : d0 03 __ BNE $2036 ; (adv_exec.s136 + 7)
2033 : 4c aa 1c JMP $1caa ; (adv_exec.s106 + 0)
2036 : 4c 38 1b JMP $1b38 ; (adv_exec.s120 + 0)
.s52:
2039 : c8 __ __ INY
203a : b1 43 __ LDA (T4 + 0),y 
203c : 8d 9c 3e STA $3e9c ; (var + 0)
203f : 8d ec 3d STA $3dec ; (slowmode + 0)
.s715:
2042 : 18 __ __ CLC
2043 : a5 53 __ LDA T1 + 0 
2045 : 69 02 __ ADC #$02
2047 : 85 53 __ STA T1 + 0 
2049 : 8d 98 3e STA $3e98 ; (i + 0)
204c : a5 54 __ LDA T1 + 1 
204e : 69 00 __ ADC #$00
2050 : 8d 99 3e STA $3e99 ; (i + 1)
2053 : 4c 4a 16 JMP $164a ; (adv_exec.s1286 + 0)
.s27:
2056 : 8c 9e 3e STY $3e9e ; (ch + 0)
2059 : 18 __ __ CLC
205a : a5 53 __ LDA T1 + 0 
205c : 69 02 __ ADC #$02
205e : 85 53 __ STA T1 + 0 
2060 : 8d 98 3e STA $3e98 ; (i + 0)
2063 : a5 54 __ LDA T1 + 1 
2065 : 69 00 __ ADC #$00
2067 : 85 54 __ STA T1 + 1 
2069 : 8d 99 3e STA $3e99 ; (i + 1)
206c : ad 80 3e LDA $3e80 ; (vars + 0)
206f : 85 57 __ STA T3 + 0 
2071 : ad 81 3e LDA $3e81 ; (vars + 1)
2074 : 85 58 __ STA T3 + 1 
2076 : c8 __ __ INY
2077 : b1 43 __ LDA (T4 + 0),y 
2079 : a8 __ __ TAY
207a : b1 57 __ LDA (T3 + 0),y 
207c : 8d a2 3e STA $3ea2 ; (strid + 0)
207f : ad 85 3e LDA $3e85 ; (tmp + 1)
2082 : 85 56 __ STA T2 + 1 
2084 : 8d a9 3e STA $3ea9 ; (ostr + 1)
2087 : 85 14 __ STA P7 
2089 : ad 84 3e LDA $3e84 ; (tmp + 0)
208c : 85 55 __ STA T2 + 0 
208e : 85 13 __ STA P6 
2090 : 8d a8 3e STA $3ea8 ; (ostr + 0)
2093 : a9 63 __ LDA #$63
2095 : cd a2 3e CMP $3ea2 ; (strid + 0)
2098 : 90 5e __ BCC $20f8 ; (adv_exec.s28 + 0)
.s30:
209a : a9 09 __ LDA #$09
209c : cd a2 3e CMP $3ea2 ; (strid + 0)
209f : b0 28 __ BCS $20c9 ; (adv_exec.s33 + 0)
.s31:
20a1 : ad 9e 3e LDA $3e9e ; (ch + 0)
20a4 : 85 52 __ STA T0 + 0 
20a6 : ee 9e 3e INC $3e9e ; (ch + 0)
20a9 : ad a2 3e LDA $3ea2 ; (strid + 0)
20ac : 85 1b __ STA ACCU + 0 
20ae : a9 00 __ LDA #$00
20b0 : 85 1c __ STA ACCU + 1 
20b2 : 85 04 __ STA WORK + 1 
20b4 : a9 0a __ LDA #$0a
20b6 : 85 03 __ STA WORK + 0 
20b8 : 20 c5 3a JSR $3ac5 ; (divmod + 0)
20bb : 18 __ __ CLC
20bc : a5 1b __ LDA ACCU + 0 
20be : 69 30 __ ADC #$30
20c0 : a4 52 __ LDY T0 + 0 
20c2 : 91 55 __ STA (T2 + 0),y 
20c4 : a5 05 __ LDA WORK + 2 
20c6 : 8d a2 3e STA $3ea2 ; (strid + 0)
.s33:
20c9 : ad 9e 3e LDA $3e9e ; (ch + 0)
20cc : a8 __ __ TAY
20cd : 18 __ __ CLC
20ce : 69 01 __ ADC #$01
20d0 : 8d 9e 3e STA $3e9e ; (ch + 0)
20d3 : aa __ __ TAX
20d4 : ad a2 3e LDA $3ea2 ; (strid + 0)
20d7 : 18 __ __ CLC
20d8 : 69 30 __ ADC #$30
20da : 91 55 __ STA (T2 + 0),y 
20dc : 8a __ __ TXA
20dd : 18 __ __ CLC
20de : 65 55 __ ADC T2 + 0 
20e0 : 85 55 __ STA T2 + 0 
20e2 : 90 02 __ BCC $20e6 ; (adv_exec.s1302 + 0)
.s1301:
20e4 : e6 56 __ INC T2 + 1 
.s1302:
20e6 : a9 00 __ LDA #$00
20e8 : a8 __ __ TAY
20e9 : 91 55 __ STA (T2 + 0),y 
20eb : a5 55 __ LDA T2 + 0 
20ed : 8d ab 3e STA $3eab ; (etxt + 0)
20f0 : a5 56 __ LDA T2 + 1 
20f2 : 8d ac 3e STA $3eac ; (etxt + 1)
20f5 : 4c d4 1e JMP $1ed4 ; (adv_exec.s714 + 0)
.s28:
20f8 : a9 01 __ LDA #$01
20fa : 8d 9e 3e STA $3e9e ; (ch + 0)
20fd : ad a2 3e LDA $3ea2 ; (strid + 0)
2100 : 85 1b __ STA ACCU + 0 
2102 : a9 00 __ LDA #$00
2104 : 85 1c __ STA ACCU + 1 
2106 : 85 04 __ STA WORK + 1 
2108 : a9 64 __ LDA #$64
210a : 85 03 __ STA WORK + 0 
210c : 20 c5 3a JSR $3ac5 ; (divmod + 0)
210f : 18 __ __ CLC
2110 : a5 1b __ LDA ACCU + 0 
2112 : 69 30 __ ADC #$30
2114 : a0 00 __ LDY #$00
2116 : 91 55 __ STA (T2 + 0),y 
2118 : a5 05 __ LDA WORK + 2 
211a : 8d a2 3e STA $3ea2 ; (strid + 0)
211d : c9 0a __ CMP #$0a
211f : 90 a8 __ BCC $20c9 ; (adv_exec.s33 + 0)
2121 : 4c a1 20 JMP $20a1 ; (adv_exec.s31 + 0)
--------------------------------------------------------------------
_alignattr: ; _alignattr()->void
.s0:
2124 : ad dd 3d LDA $3ddd ; (room + 0)
2127 : 8d 8e 3e STA $3e8e ; (varroom + 0)
212a : ad 97 3e LDA $3e97 ; (thisobj + 0)
212d : 8d 9a 3e STA $3e9a ; (varobj + 0)
.s1001:
2130 : 60 __ __ RTS
--------------------------------------------------------------------
_getobj: ; _getobj()->void
.s0:
2131 : ad 98 3e LDA $3e98 ; (i + 0)
2134 : 85 43 __ STA T0 + 0 
2136 : 18 __ __ CLC
2137 : 69 01 __ ADC #$01
2139 : 8d 98 3e STA $3e98 ; (i + 0)
213c : ad 99 3e LDA $3e99 ; (i + 1)
213f : 85 44 __ STA T0 + 1 
2141 : 69 00 __ ADC #$00
2143 : 8d 99 3e STA $3e99 ; (i + 1)
2146 : ad 90 3e LDA $3e90 ; (pcode + 0)
2149 : 85 45 __ STA T1 + 0 
214b : 18 __ __ CLC
214c : 65 43 __ ADC T0 + 0 
214e : 85 47 __ STA T2 + 0 
2150 : ad 91 3e LDA $3e91 ; (pcode + 1)
2153 : 85 46 __ STA T1 + 1 
2155 : 65 44 __ ADC T0 + 1 
2157 : 85 48 __ STA T2 + 1 
2159 : a0 00 __ LDY #$00
215b : b1 47 __ LDA (T2 + 0),y 
215d : 8d 9c 3e STA $3e9c ; (var + 0)
2160 : c9 fb __ CMP #$fb
2162 : f0 11 __ BEQ $2175 ; (_getobj.s9 + 0)
.s18:
2164 : b0 03 __ BCS $2169 ; (_getobj.s19 + 0)
2166 : 4c ed 21 JMP $21ed ; (_getobj.s20 + 0)
.s19:
2169 : c9 fd __ CMP #$fd
216b : d0 06 __ BNE $2173 ; (_getobj.s26 + 0)
.s4:
216d : ad 9d 3e LDA $3e9d ; (obj2 + 0)
2170 : 4c e9 21 JMP $21e9 ; (_getobj.s1020 + 0)
.s26:
2173 : b0 4e __ BCS $21c3 ; (_getobj.s27 + 0)
.s9:
2175 : a0 01 __ LDY #$01
2177 : b1 47 __ LDA (T2 + 0),y 
2179 : 85 49 __ STA T3 + 0 
217b : 8d 9e 3e STA $3e9e ; (ch + 0)
217e : 18 __ __ CLC
217f : a5 43 __ LDA T0 + 0 
2181 : 69 02 __ ADC #$02
2183 : 85 43 __ STA T0 + 0 
2185 : 8d 98 3e STA $3e98 ; (i + 0)
2188 : a5 44 __ LDA T0 + 1 
218a : 69 00 __ ADC #$00
218c : 85 44 __ STA T0 + 1 
218e : 8d 99 3e STA $3e99 ; (i + 1)
2191 : 20 04 22 JSR $2204 ; (rand.s0 + 0)
2194 : a5 49 __ LDA T3 + 0 
2196 : 85 03 __ STA WORK + 0 
2198 : 18 __ __ CLC
2199 : 65 43 __ ADC T0 + 0 
219b : 8d 98 3e STA $3e98 ; (i + 0)
219e : a9 00 __ LDA #$00
21a0 : 85 04 __ STA WORK + 1 
21a2 : 65 44 __ ADC T0 + 1 
21a4 : 8d 99 3e STA $3e99 ; (i + 1)
21a7 : 18 __ __ CLC
21a8 : a5 45 __ LDA T1 + 0 
21aa : 65 43 __ ADC T0 + 0 
21ac : 85 43 __ STA T0 + 0 
21ae : a5 46 __ LDA T1 + 1 
21b0 : 65 44 __ ADC T0 + 1 
21b2 : 85 44 __ STA T0 + 1 
21b4 : 20 c5 3a JSR $3ac5 ; (divmod + 0)
21b7 : 18 __ __ CLC
21b8 : a5 43 __ LDA T0 + 0 
21ba : 65 05 __ ADC WORK + 2 
21bc : 85 43 __ STA T0 + 0 
21be : a5 44 __ LDA T0 + 1 
21c0 : 4c e1 21 JMP $21e1 ; (_getobj.s34 + 0)
.s27:
21c3 : c9 fe __ CMP #$fe
21c5 : d0 06 __ BNE $21cd ; (_getobj.s14 + 0)
.s2:
21c7 : ad 8c 3e LDA $3e8c ; (obj1 + 0)
21ca : 4c e9 21 JMP $21e9 ; (_getobj.s1020 + 0)
.s14:
21cd : ad 9b 3e LDA $3e9b ; (varmode + 0)
21d0 : f0 1a __ BEQ $21ec ; (_getobj.s1001 + 0)
.s15:
21d2 : 8c 9b 3e STY $3e9b ; (varmode + 0)
21d5 : ad 80 3e LDA $3e80 ; (vars + 0)
21d8 : 18 __ __ CLC
21d9 : 6d 9c 3e ADC $3e9c ; (var + 0)
21dc : 85 43 __ STA T0 + 0 
21de : ad 81 3e LDA $3e81 ; (vars + 1)
.s34:
21e1 : 69 00 __ ADC #$00
21e3 : 85 44 __ STA T0 + 1 
21e5 : a0 00 __ LDY #$00
21e7 : b1 43 __ LDA (T0 + 0),y 
.s1020:
21e9 : 8d 9c 3e STA $3e9c ; (var + 0)
.s1001:
21ec : 60 __ __ RTS
.s20:
21ed : c9 f4 __ CMP #$f4
21ef : f0 fb __ BEQ $21ec ; (_getobj.s1001 + 0)
.s21:
21f1 : b0 07 __ BCS $21fa ; (_getobj.s22 + 0)
.s23:
21f3 : c9 f3 __ CMP #$f3
21f5 : f0 f5 __ BEQ $21ec ; (_getobj.s1001 + 0)
21f7 : 4c cd 21 JMP $21cd ; (_getobj.s14 + 0)
.s22:
21fa : c9 f7 __ CMP #$f7
21fc : d0 cf __ BNE $21cd ; (_getobj.s14 + 0)
.s6:
21fe : ad dd 3d LDA $3ddd ; (room + 0)
2201 : 4c e9 21 JMP $21e9 ; (_getobj.s1020 + 0)
--------------------------------------------------------------------
rand: ; rand()->u16
.s0:
2204 : ad e0 3d LDA $3de0 ; (seed + 1)
2207 : 4a __ __ LSR
2208 : ad df 3d LDA $3ddf ; (seed + 0)
220b : 6a __ __ ROR
220c : aa __ __ TAX
220d : a9 00 __ LDA #$00
220f : 6a __ __ ROR
2210 : 4d df 3d EOR $3ddf ; (seed + 0)
2213 : 85 1b __ STA ACCU + 0 
2215 : 8a __ __ TXA
2216 : 4d e0 3d EOR $3de0 ; (seed + 1)
2219 : 85 1c __ STA ACCU + 1 
221b : 4a __ __ LSR
221c : 45 1b __ EOR ACCU + 0 
221e : 8d df 3d STA $3ddf ; (seed + 0)
2221 : 85 1b __ STA ACCU + 0 
2223 : 45 1c __ EOR ACCU + 1 
2225 : 8d e0 3d STA $3de0 ; (seed + 1)
2228 : 85 1c __ STA ACCU + 1 
.s1001:
222a : 60 __ __ RTS
--------------------------------------------------------------------
_getattrstrid: ; _getattrstrid()->void
.s0:
222b : ad 98 3e LDA $3e98 ; (i + 0)
222e : 85 1b __ STA ACCU + 0 
2230 : 18 __ __ CLC
2231 : 69 01 __ ADC #$01
2233 : 8d 98 3e STA $3e98 ; (i + 0)
2236 : ad 99 3e LDA $3e99 ; (i + 1)
2239 : aa __ __ TAX
223a : 69 00 __ ADC #$00
223c : 8d 99 3e STA $3e99 ; (i + 1)
223f : ad 90 3e LDA $3e90 ; (pcode + 0)
2242 : 18 __ __ CLC
2243 : 65 1b __ ADC ACCU + 0 
2245 : 85 1b __ STA ACCU + 0 
2247 : 8a __ __ TXA
2248 : 6d 91 3e ADC $3e91 ; (pcode + 1)
224b : 85 1c __ STA ACCU + 1 
224d : a0 00 __ LDY #$00
224f : b1 1b __ LDA (ACCU + 0),y 
2251 : 8d 9c 3e STA $3e9c ; (var + 0)
2254 : 85 1b __ STA ACCU + 0 
2256 : 29 3f __ AND #$3f
2258 : d0 03 __ BNE $225d ; (_getattrstrid.s46 + 0)
225a : 4c 97 23 JMP $2397 ; (_getattrstrid.s2 + 0)
.s46:
225d : c9 01 __ CMP #$01
225f : d0 03 __ BNE $2264 ; (_getattrstrid.s12 + 0)
2261 : 4c 69 23 JMP $2369 ; (_getattrstrid.s7 + 0)
.s12:
2264 : aa __ __ TAX
2265 : 06 1b __ ASL ACCU + 0 
2267 : 30 0e __ BMI $2277 ; (_getattrstrid.s13 + 0)
.s14:
2269 : ad 7c 3e LDA $3e7c ; (roomattrex + 0)
226c : 85 1b __ STA ACCU + 0 
226e : ad 8e 3e LDA $3e8e ; (varroom + 0)
2271 : ac 7d 3e LDY $3e7d ; (roomattrex + 1)
2274 : 4c 82 22 JMP $2282 ; (_getattrstrid.s1012 + 0)
.s13:
2277 : ad 76 3e LDA $3e76 ; (objattrex + 0)
227a : 85 1b __ STA ACCU + 0 
227c : ad 9a 3e LDA $3e9a ; (varobj + 0)
227f : ac 77 3e LDY $3e77 ; (objattrex + 1)
.s1012:
2282 : 8c a4 3e STY $3ea4 ; (txt + 1)
2285 : 8d 9b 3e STA $3e9b ; (varmode + 0)
2288 : a5 1b __ LDA ACCU + 0 
228a : 8d a3 3e STA $3ea3 ; (txt + 0)
228d : 98 __ __ TYA
228e : 05 1b __ ORA ACCU + 0 
2290 : d0 03 __ BNE $2295 ; (_getattrstrid.s17 + 0)
2292 : 4c 63 23 JMP $2363 ; (_getattrstrid.s16 + 0)
.s17:
2295 : 8e a5 3e STX $3ea5 ; (varattr + 0)
.l20:
2298 : ad a3 3e LDA $3ea3 ; (txt + 0)
229b : 85 1b __ STA ACCU + 0 
229d : 18 __ __ CLC
229e : 69 01 __ ADC #$01
22a0 : 8d a3 3e STA $3ea3 ; (txt + 0)
22a3 : ad a4 3e LDA $3ea4 ; (txt + 1)
22a6 : 85 1c __ STA ACCU + 1 
22a8 : 69 00 __ ADC #$00
22aa : 8d a4 3e STA $3ea4 ; (txt + 1)
22ad : a0 00 __ LDY #$00
22af : b1 1b __ LDA (ACCU + 0),y 
22b1 : 8d a6 3e STA $3ea6 ; (a + 0)
22b4 : c9 ff __ CMP #$ff
22b6 : d0 04 __ BNE $22bc ; (_getattrstrid.s24 + 0)
.s21:
22b8 : 8c 9b 3e STY $3e9b ; (varmode + 0)
22bb : 60 __ __ RTS
.s24:
22bc : ad a6 3e LDA $3ea6 ; (a + 0)
22bf : 29 7f __ AND #$7f
22c1 : cd a5 3e CMP $3ea5 ; (varattr + 0)
22c4 : f0 2b __ BEQ $22f1 ; (_getattrstrid.s26 + 0)
.s27:
22c6 : c8 __ __ INY
22c7 : b1 1b __ LDA (ACCU + 0),y 
22c9 : 85 1d __ STA ACCU + 2 
22cb : 18 __ __ CLC
22cc : a5 1b __ LDA ACCU + 0 
22ce : 69 02 __ ADC #$02
22d0 : aa __ __ TAX
22d1 : a5 1c __ LDA ACCU + 1 
22d3 : 69 00 __ ADC #$00
22d5 : a8 __ __ TAY
22d6 : 8a __ __ TXA
22d7 : 18 __ __ CLC
22d8 : 65 1d __ ADC ACCU + 2 
22da : 90 01 __ BCC $22dd ; (_getattrstrid.s1020 + 0)
.s1019:
22dc : c8 __ __ INY
.s1020:
22dd : 2c a6 3e BIT $3ea6 ; (a + 0)
22e0 : 30 06 __ BMI $22e8 ; (_getattrstrid.s86 + 0)
.s41:
22e2 : 18 __ __ CLC
22e3 : 65 1d __ ADC ACCU + 2 
22e5 : 90 01 __ BCC $22e8 ; (_getattrstrid.s86 + 0)
.s1021:
22e7 : c8 __ __ INY
.s86:
22e8 : 8c a4 3e STY $3ea4 ; (txt + 1)
22eb : 8d a3 3e STA $3ea3 ; (txt + 0)
22ee : 4c 98 22 JMP $2298 ; (_getattrstrid.l20 + 0)
.s26:
22f1 : 2c a6 3e BIT $3ea6 ; (a + 0)
22f4 : 30 37 __ BMI $232d ; (_getattrstrid.s29 + 0)
.l33:
22f6 : ad a6 3e LDA $3ea6 ; (a + 0)
22f9 : f0 9d __ BEQ $2298 ; (_getattrstrid.l20 + 0)
.s34:
22fb : ad a3 3e LDA $3ea3 ; (txt + 0)
22fe : 85 1b __ STA ACCU + 0 
2300 : ad a4 3e LDA $3ea4 ; (txt + 1)
2303 : 85 1c __ STA ACCU + 1 
2305 : a0 01 __ LDY #$01
2307 : b1 1b __ LDA (ACCU + 0),y 
2309 : aa __ __ TAX
230a : 88 __ __ DEY
230b : b1 1b __ LDA (ACCU + 0),y 
230d : 8d a6 3e STA $3ea6 ; (a + 0)
2310 : 18 __ __ CLC
2311 : a5 1b __ LDA ACCU + 0 
2313 : 69 02 __ ADC #$02
2315 : 8d a3 3e STA $3ea3 ; (txt + 0)
2318 : a5 1c __ LDA ACCU + 1 
231a : 69 00 __ ADC #$00
231c : 8d a4 3e STA $3ea4 ; (txt + 1)
231f : ad 9b 3e LDA $3e9b ; (varmode + 0)
2322 : cd a6 3e CMP $3ea6 ; (a + 0)
2325 : d0 cf __ BNE $22f6 ; (_getattrstrid.l33 + 0)
.s36:
2327 : 8e a2 3e STX $3ea2 ; (strid + 0)
232a : 4c 98 22 JMP $2298 ; (_getattrstrid.l20 + 0)
.s29:
232d : 18 __ __ CLC
232e : a5 1b __ LDA ACCU + 0 
2330 : 69 02 __ ADC #$02
2332 : 8d a3 3e STA $3ea3 ; (txt + 0)
2335 : a5 1c __ LDA ACCU + 1 
2337 : 69 00 __ ADC #$00
2339 : 8d a4 3e STA $3ea4 ; (txt + 1)
233c : 98 __ __ TYA
233d : ac 9b 3e LDY $3e9b ; (varmode + 0)
2340 : 8d 9b 3e STA $3e9b ; (varmode + 0)
2343 : c8 __ __ INY
2344 : c8 __ __ INY
2345 : b1 1b __ LDA (ACCU + 0),y 
2347 : 8d a2 3e STA $3ea2 ; (strid + 0)
234a : ad a6 3e LDA $3ea6 ; (a + 0)
234d : c9 ff __ CMP #$ff
234f : f0 11 __ BEQ $2362 ; (_getattrstrid.s1001 + 0)
.s43:
2351 : a9 01 __ LDA #$01
2353 : 8d a1 3e STA $3ea1 ; (text_continue + 0)
2356 : ad 4c 3e LDA $3e4c ; (advdesc + 0)
2359 : 8d 9f 3e STA $3e9f ; (str + 0)
235c : ad 4d 3e LDA $3e4d ; (advdesc + 1)
235f : 8d a0 3e STA $3ea0 ; (str + 1)
.s1001:
2362 : 60 __ __ RTS
.s16:
2363 : a9 ff __ LDA #$ff
.s1014:
2365 : 8d a2 3e STA $3ea2 ; (strid + 0)
2368 : 60 __ __ RTS
.s7:
2369 : ad 4c 3e LDA $3e4c ; (advdesc + 0)
236c : 8d 9f 3e STA $3e9f ; (str + 0)
236f : ad 4d 3e LDA $3e4d ; (advdesc + 1)
2372 : 8d a0 3e STA $3ea0 ; (str + 1)
2375 : 06 1b __ ASL ACCU + 0 
2377 : 30 12 __ BMI $238b ; (_getattrstrid.s8 + 0)
.s9:
2379 : ad 69 3e LDA $3e69 ; (roomdescid + 1)
237c : ae 68 3e LDX $3e68 ; (roomdescid + 0)
.s1016:
237f : ac 8e 3e LDY $3e8e ; (varroom + 0)
.s85:
2382 : 86 1b __ STX ACCU + 0 
2384 : 85 1c __ STA ACCU + 1 
2386 : b1 1b __ LDA (ACCU + 0),y 
2388 : 4c 65 23 JMP $2365 ; (_getattrstrid.s1014 + 0)
.s8:
238b : ad 71 3e LDA $3e71 ; (objdescid + 1)
238e : ae 70 3e LDX $3e70 ; (objdescid + 0)
.s1015:
2391 : ac 9a 3e LDY $3e9a ; (varobj + 0)
2394 : 4c 82 23 JMP $2382 ; (_getattrstrid.s85 + 0)
.s2:
2397 : a9 01 __ LDA #$01
2399 : 8d a1 3e STA $3ea1 ; (text_continue + 0)
239c : ad 4a 3e LDA $3e4a ; (advnames + 0)
239f : 8d 9f 3e STA $3e9f ; (str + 0)
23a2 : ad 4b 3e LDA $3e4b ; (advnames + 1)
23a5 : 8d a0 3e STA $3ea0 ; (str + 1)
23a8 : 06 1b __ ASL ACCU + 0 
23aa : 10 09 __ BPL $23b5 ; (_getattrstrid.s4 + 0)
.s3:
23ac : ad 6f 3e LDA $3e6f ; (objnameid + 1)
23af : ae 6e 3e LDX $3e6e ; (objnameid + 0)
23b2 : 4c 91 23 JMP $2391 ; (_getattrstrid.s1015 + 0)
.s4:
23b5 : ad 67 3e LDA $3e67 ; (roomnameid + 1)
23b8 : ae 66 3e LDX $3e66 ; (roomnameid + 0)
23bb : 4c 7f 23 JMP $237f ; (_getattrstrid.s1016 + 0)
--------------------------------------------------------------------
_getstring: ; _getstring()->void
.s0:
23be : a9 00 __ LDA #$00
23c0 : 8d a7 3e STA $3ea7 ; (_strid + 0)
23c3 : ad 9f 3e LDA $3e9f ; (str + 0)
23c6 : 8d a8 3e STA $3ea8 ; (ostr + 0)
23c9 : ad a0 3e LDA $3ea0 ; (str + 1)
23cc : 8d a9 3e STA $3ea9 ; (ostr + 1)
23cf : ad a2 3e LDA $3ea2 ; (strid + 0)
23d2 : 85 1d __ STA ACCU + 2 
23d4 : f0 5a __ BEQ $2430 ; (_getstring.s3 + 0)
.l2:
23d6 : ad 9f 3e LDA $3e9f ; (str + 0)
23d9 : 85 1b __ STA ACCU + 0 
23db : 18 __ __ CLC
23dc : 69 01 __ ADC #$01
23de : 8d 9f 3e STA $3e9f ; (str + 0)
23e1 : ad a0 3e LDA $3ea0 ; (str + 1)
23e4 : 85 1c __ STA ACCU + 1 
23e6 : 69 00 __ ADC #$00
23e8 : 8d a0 3e STA $3ea0 ; (str + 1)
23eb : a0 00 __ LDY #$00
23ed : b1 1b __ LDA (ACCU + 0),y 
23ef : 8d aa 3e STA $3eaa ; (len + 0)
23f2 : ee a7 3e INC $3ea7 ; (_strid + 0)
23f5 : c9 ff __ CMP #$ff
23f7 : d0 15 __ BNE $240e ; (_getstring.s6 + 0)
.s4:
23f9 : c8 __ __ INY
23fa : b1 1b __ LDA (ACCU + 0),y 
23fc : 8d aa 3e STA $3eaa ; (len + 0)
23ff : 18 __ __ CLC
2400 : a5 1b __ LDA ACCU + 0 
2402 : 69 01 __ ADC #$01
2404 : 8d 9f 3e STA $3e9f ; (str + 0)
2407 : a5 1c __ LDA ACCU + 1 
2409 : 69 01 __ ADC #$01
240b : 8d a0 3e STA $3ea0 ; (str + 1)
.s6:
240e : ad 9f 3e LDA $3e9f ; (str + 0)
2411 : 18 __ __ CLC
2412 : 6d aa 3e ADC $3eaa ; (len + 0)
2415 : 8d 9f 3e STA $3e9f ; (str + 0)
2418 : 90 03 __ BCC $241d ; (_getstring.s1009 + 0)
.s1008:
241a : ee a0 3e INC $3ea0 ; (str + 1)
.s1009:
241d : ad 9f 3e LDA $3e9f ; (str + 0)
2420 : 8d a8 3e STA $3ea8 ; (ostr + 0)
2423 : ad a0 3e LDA $3ea0 ; (str + 1)
2426 : 8d a9 3e STA $3ea9 ; (ostr + 1)
2429 : ad a7 3e LDA $3ea7 ; (_strid + 0)
242c : c5 1d __ CMP ACCU + 2 
242e : 90 a6 __ BCC $23d6 ; (_getstring.l2 + 0)
.s3:
2430 : ad a8 3e LDA $3ea8 ; (ostr + 0)
2433 : 85 1b __ STA ACCU + 0 
2435 : 18 __ __ CLC
2436 : 69 01 __ ADC #$01
2438 : 8d a8 3e STA $3ea8 ; (ostr + 0)
243b : ad a9 3e LDA $3ea9 ; (ostr + 1)
243e : 85 1c __ STA ACCU + 1 
2440 : 69 00 __ ADC #$00
2442 : 8d a9 3e STA $3ea9 ; (ostr + 1)
2445 : a0 00 __ LDY #$00
2447 : b1 1b __ LDA (ACCU + 0),y 
2449 : 8d aa 3e STA $3eaa ; (len + 0)
244c : 18 __ __ CLC
244d : 6d a8 3e ADC $3ea8 ; (ostr + 0)
2450 : 8d ab 3e STA $3eab ; (etxt + 0)
2453 : ad a9 3e LDA $3ea9 ; (ostr + 1)
2456 : 69 00 __ ADC #$00
2458 : 8d ac 3e STA $3eac ; (etxt + 1)
245b : ad aa 3e LDA $3eaa ; (len + 0)
245e : c9 ff __ CMP #$ff
2460 : d0 30 __ BNE $2492 ; (_getstring.s1001 + 0)
.s7:
2462 : c8 __ __ INY
2463 : b1 1b __ LDA (ACCU + 0),y 
2465 : 8d aa 3e STA $3eaa ; (len + 0)
2468 : 18 __ __ CLC
2469 : a5 1b __ LDA ACCU + 0 
246b : 69 02 __ ADC #$02
246d : 8d a8 3e STA $3ea8 ; (ostr + 0)
2470 : a5 1c __ LDA ACCU + 1 
2472 : 69 00 __ ADC #$00
2474 : 8d a9 3e STA $3ea9 ; (ostr + 1)
2477 : ad ab 3e LDA $3eab ; (etxt + 0)
247a : 18 __ __ CLC
247b : 6d aa 3e ADC $3eaa ; (len + 0)
247e : aa __ __ TAX
247f : ad ac 3e LDA $3eac ; (etxt + 1)
2482 : 69 00 __ ADC #$00
2484 : a8 __ __ TAY
2485 : 8a __ __ TXA
2486 : 18 __ __ CLC
2487 : 69 01 __ ADC #$01
2489 : 8d ab 3e STA $3eab ; (etxt + 0)
248c : 90 01 __ BCC $248f ; (_getstring.s1011 + 0)
.s1010:
248e : c8 __ __ INY
.s1011:
248f : 8c ac 3e STY $3eac ; (etxt + 1)
.s1001:
2492 : 60 __ __ RTS
--------------------------------------------------------------------
ui_text_write: ; ui_text_write(u8*)->void
.s0:
2493 : a9 01 __ LDA #$01
2495 : 8d ad 3e STA $3ead ; (txt_col + 0)
2498 : a5 13 __ LDA P6 ; (text + 0)
249a : 8d a3 3e STA $3ea3 ; (txt + 0)
249d : a5 14 __ LDA P7 ; (text + 1)
249f : 8d a4 3e STA $3ea4 ; (txt + 1)
24a2 : ad ae 3e LDA $3eae ; (text_attach + 0)
24a5 : f0 07 __ BEQ $24ae ; (ui_text_write.s2 + 0)
.s1:
24a7 : a9 00 __ LDA #$00
24a9 : 8d ae 3e STA $3eae ; (text_attach + 0)
24ac : f0 15 __ BEQ $24c3 ; (ui_text_write.l5 + 0)
.s2:
24ae : 8d af 3e STA $3eaf ; (txt_rev + 0)
24b1 : 8d b0 3e STA $3eb0 ; (txt_x + 0)
24b4 : ad dc 3d LDA $3ddc ; (text_y + 0)
24b7 : 18 __ __ CLC
24b8 : 69 0e __ ADC #$0e
24ba : 8d b1 3e STA $3eb1 ; (txt_y + 0)
24bd : 4c c3 24 JMP $24c3 ; (ui_text_write.l5 + 0)
.s8:
24c0 : 20 76 2a JSR $2a76 ; (ui_waitkey.s0 + 0)
.l5:
24c3 : 20 17 25 JSR $2517 ; (core_drawtext.l138 + 0)
24c6 : ad b2 3e LDA $3eb2 ; (_ch + 0)
24c9 : d0 f5 __ BNE $24c0 ; (ui_text_write.s8 + 0)
.s7:
24cb : ad a3 3e LDA $3ea3 ; (txt + 0)
24ce : 85 1f __ STA ADDR + 0 
24d0 : ad a4 3e LDA $3ea4 ; (txt + 1)
24d3 : 18 __ __ CLC
24d4 : 69 ff __ ADC #$ff
24d6 : 85 20 __ STA ADDR + 1 
24d8 : a0 ff __ LDY #$ff
24da : b1 1f __ LDA (ADDR + 0),y 
24dc : c9 2b __ CMP #$2b
24de : f0 21 __ BEQ $2501 ; (ui_text_write.s10 + 0)
.s11:
24e0 : ad a1 3e LDA $3ea1 ; (text_continue + 0)
24e3 : f0 07 __ BEQ $24ec ; (ui_text_write.s17 + 0)
.s16:
24e5 : a9 01 __ LDA #$01
24e7 : 8d ae 3e STA $3eae ; (text_attach + 0)
24ea : d0 0c __ BNE $24f8 ; (ui_text_write.s1004 + 0)
.s17:
24ec : ad b1 3e LDA $3eb1 ; (txt_y + 0)
24ef : 38 __ __ SEC
24f0 : e9 0e __ SBC #$0e
24f2 : 8d dc 3d STA $3ddc ; (text_y + 0)
24f5 : 20 59 2a JSR $2a59 ; (cr.l30 + 0)
.s1004:
24f8 : a9 00 __ LDA #$00
24fa : 8d a1 3e STA $3ea1 ; (text_continue + 0)
24fd : ee 89 3e INC $3e89 ; (al + 0)
.s1001:
2500 : 60 __ __ RTS
.s10:
2501 : a9 01 __ LDA #$01
2503 : 8d ae 3e STA $3eae ; (text_attach + 0)
2506 : a9 00 __ LDA #$00
2508 : 8d a1 3e STA $3ea1 ; (text_continue + 0)
250b : ee 89 3e INC $3e89 ; (al + 0)
250e : ad b0 3e LDA $3eb0 ; (txt_x + 0)
2511 : f0 ed __ BEQ $2500 ; (ui_text_write.s1001 + 0)
.s13:
2513 : ce b0 3e DEC $3eb0 ; (txt_x + 0)
2516 : 60 __ __ RTS
--------------------------------------------------------------------
core_drawtext: ; core_drawtext()->void
.l138:
2517 : 20 7e 27 JSR $277e ; (_getnextch.s0 + 0)
251a : ad b2 3e LDA $3eb2 ; (_ch + 0)
251d : f0 0d __ BEQ $252c ; (core_drawtext.s1001 + 0)
.l2:
251f : ad 89 3e LDA $3e89 ; (al + 0)
2522 : c9 09 __ CMP #$09
2524 : ad b2 3e LDA $3eb2 ; (_ch + 0)
2527 : 90 04 __ BCC $252d ; (core_drawtext.s6 + 0)
.s4:
2529 : 8d b3 3e STA $3eb3 ; (_ech + 0)
.s1001:
252c : 60 __ __ RTS
.s6:
252d : c9 1f __ CMP #$1f
252f : d0 06 __ BNE $2537 ; (core_drawtext.s9 + 0)
.s8:
2531 : 20 86 28 JSR $2886 ; (core_cr.l34 + 0)
2534 : 4c 17 25 JMP $2517 ; (core_drawtext.l138 + 0)
.s9:
2537 : a9 00 __ LDA #$00
2539 : 8d e1 3d STA $3de1 ; (align + 0)
253c : 8d e2 3d STA $3de2 ; (align + 1)
253f : 8d b8 3e STA $3eb8 ; (ll + 0)
2542 : 8d b9 3e STA $3eb9 ; (ll + 1)
2545 : 8d ba 3e STA $3eba ; (spl + 0)
2548 : 8d bb 3e STA $3ebb ; (spl + 1)
254b : ad b2 3e LDA $3eb2 ; (_ch + 0)
254e : f0 5f __ BEQ $25af ; (core_drawtext.s13 + 0)
.l15:
2550 : ad b8 3e LDA $3eb8 ; (ll + 0)
2553 : 85 4a __ STA T3 + 0 
2555 : 18 __ __ CLC
2556 : 6d b0 3e ADC $3eb0 ; (txt_x + 0)
2559 : aa __ __ TAX
255a : ad b9 3e LDA $3eb9 ; (ll + 1)
255d : 85 4b __ STA T3 + 1 
255f : 69 00 __ ADC #$00
2561 : d0 4c __ BNE $25af ; (core_drawtext.s13 + 0)
.s1036:
2563 : e0 28 __ CPX #$28
2565 : b0 48 __ BCS $25af ; (core_drawtext.s13 + 0)
.s14:
2567 : ad b2 3e LDA $3eb2 ; (_ch + 0)
256a : c9 1f __ CMP #$1f
256c : f0 41 __ BEQ $25af ; (core_drawtext.s13 + 0)
.s12:
256e : c9 5c __ CMP #$5c
2570 : d0 03 __ BNE $2575 ; (core_drawtext.s17 + 0)
2572 : 4c c1 26 JMP $26c1 ; (core_drawtext.s16 + 0)
.s17:
2575 : 85 47 __ STA T0 + 0 
2577 : c9 20 __ CMP #$20
2579 : d0 0d __ BNE $2588 ; (core_drawtext.s57 + 0)
.s55:
257b : a5 4a __ LDA T3 + 0 
257d : 8d ba 3e STA $3eba ; (spl + 0)
2580 : a5 4b __ LDA T3 + 1 
2582 : 8d bb 3e STA $3ebb ; (spl + 1)
2585 : 20 0f 2a JSR $2a0f ; (_savechpos.s0 + 0)
.s57:
2588 : ad af 3e LDA $3eaf ; (txt_rev + 0)
258b : 18 __ __ CLC
258c : 65 47 __ ADC T0 + 0 
258e : a6 4a __ LDX T3 + 0 
2590 : 9d be 3e STA $3ebe,x ; (_buffer + 0)
2593 : ad ad 3e LDA $3ead ; (txt_col + 0)
2596 : 9d 00 3f STA $3f00,x ; (_cbuffer + 0)
2599 : 8a __ __ TXA
259a : 18 __ __ CLC
259b : 69 01 __ ADC #$01
259d : 8d b8 3e STA $3eb8 ; (ll + 0)
25a0 : a5 4b __ LDA T3 + 1 
25a2 : 69 00 __ ADC #$00
25a4 : 8d b9 3e STA $3eb9 ; (ll + 1)
.s137:
25a7 : 20 7e 27 JSR $277e ; (_getnextch.s0 + 0)
25aa : ad b2 3e LDA $3eb2 ; (_ch + 0)
25ad : d0 a1 __ BNE $2550 ; (core_drawtext.l15 + 0)
.s13:
25af : ad b0 3e LDA $3eb0 ; (txt_x + 0)
25b2 : 85 48 __ STA T2 + 0 
25b4 : 18 __ __ CLC
25b5 : 6d b8 3e ADC $3eb8 ; (ll + 0)
25b8 : aa __ __ TAX
25b9 : ad b9 3e LDA $3eb9 ; (ll + 1)
25bc : 69 00 __ ADC #$00
25be : 85 4b __ STA T3 + 1 
25c0 : d0 0d __ BNE $25cf ; (core_drawtext.s59 + 0)
.s1007:
25c2 : e0 28 __ CPX #$28
25c4 : d0 09 __ BNE $25cf ; (core_drawtext.s59 + 0)
.s61:
25c6 : ad b2 3e LDA $3eb2 ; (_ch + 0)
25c9 : f0 1e __ BEQ $25e9 ; (core_drawtext.s125 + 0)
.s62:
25cb : c9 20 __ CMP #$20
25cd : f0 1a __ BEQ $25e9 ; (core_drawtext.s125 + 0)
.s59:
25cf : a5 4b __ LDA T3 + 1 
25d1 : d0 04 __ BNE $25d7 ; (core_drawtext.s63 + 0)
.s1004:
25d3 : e0 28 __ CPX #$28
25d5 : 90 12 __ BCC $25e9 ; (core_drawtext.s125 + 0)
.s63:
25d7 : 20 34 2a JSR $2a34 ; (_restorechpos.s0 + 0)
25da : ad ba 3e LDA $3eba ; (spl + 0)
25dd : 8d b8 3e STA $3eb8 ; (ll + 0)
25e0 : ad bb 3e LDA $3ebb ; (spl + 1)
25e3 : 8d b9 3e STA $3eb9 ; (ll + 1)
25e6 : 20 7e 27 JSR $277e ; (_getnextch.s0 + 0)
.s125:
25e9 : ad e2 3d LDA $3de2 ; (align + 1)
25ec : d0 36 __ BNE $2624 ; (core_drawtext.s66 + 0)
.s1003:
25ee : ad e1 3d LDA $3de1 ; (align + 0)
25f1 : c9 01 __ CMP #$01
25f3 : d0 0b __ BNE $2600 ; (core_drawtext.s71 + 0)
.s69:
25f5 : 38 __ __ SEC
25f6 : a9 28 __ LDA #$28
25f8 : ed b8 3e SBC $3eb8 ; (ll + 0)
25fb : 85 4a __ STA T3 + 0 
25fd : 4c 1c 26 JMP $261c ; (core_drawtext.s136 + 0)
.s71:
2600 : ad e2 3d LDA $3de2 ; (align + 1)
2603 : d0 1f __ BNE $2624 ; (core_drawtext.s66 + 0)
.s1002:
2605 : ad e1 3d LDA $3de1 ; (align + 0)
2608 : c9 02 __ CMP #$02
260a : d0 18 __ BNE $2624 ; (core_drawtext.s66 + 0)
.s67:
260c : 38 __ __ SEC
260d : a9 28 __ LDA #$28
260f : ed b8 3e SBC $3eb8 ; (ll + 0)
2612 : 85 4a __ STA T3 + 0 
2614 : a9 00 __ LDA #$00
2616 : ed b9 3e SBC $3eb9 ; (ll + 1)
2619 : 4a __ __ LSR
261a : 66 4a __ ROR T3 + 0 
.s136:
261c : 18 __ __ CLC
261d : a5 4a __ LDA T3 + 0 
261f : 65 48 __ ADC T2 + 0 
2621 : 8d b0 3e STA $3eb0 ; (txt_x + 0)
.s66:
2624 : ad b1 3e LDA $3eb1 ; (txt_y + 0)
2627 : 0a __ __ ASL
2628 : 85 1b __ STA ACCU + 0 
262a : a9 00 __ LDA #$00
262c : 2a __ __ ROL
262d : 06 1b __ ASL ACCU + 0 
262f : 2a __ __ ROL
2630 : aa __ __ TAX
2631 : a5 1b __ LDA ACCU + 0 
2633 : 6d b1 3e ADC $3eb1 ; (txt_y + 0)
2636 : 85 48 __ STA T2 + 0 
2638 : 8a __ __ TXA
2639 : 69 00 __ ADC #$00
263b : 06 48 __ ASL T2 + 0 
263d : 2a __ __ ROL
263e : 06 48 __ ASL T2 + 0 
2640 : 2a __ __ ROL
2641 : 06 48 __ ASL T2 + 0 
2643 : 2a __ __ ROL
2644 : 85 49 __ STA T2 + 1 
2646 : ad b0 3e LDA $3eb0 ; (txt_x + 0)
2649 : 85 4c __ STA T4 + 0 
264b : ad c8 3d LDA $3dc8 ; (video_ram + 0)
264e : 18 __ __ CLC
264f : 65 48 __ ADC T2 + 0 
2651 : aa __ __ TAX
2652 : ad c9 3d LDA $3dc9 ; (video_ram + 1)
2655 : 65 49 __ ADC T2 + 1 
2657 : a8 __ __ TAY
2658 : 8a __ __ TXA
2659 : 18 __ __ CLC
265a : 65 4c __ ADC T4 + 0 
265c : 85 0d __ STA P0 
265e : 90 01 __ BCC $2661 ; (core_drawtext.s1045 + 0)
.s1044:
2660 : c8 __ __ INY
.s1045:
2661 : 84 0e __ STY P1 
2663 : a9 be __ LDA #$be
2665 : 85 0f __ STA P2 
2667 : a9 3e __ LDA #$3e
2669 : 85 10 __ STA P3 
266b : ad b8 3e LDA $3eb8 ; (ll + 0)
266e : 85 4a __ STA T3 + 0 
2670 : 85 11 __ STA P4 
2672 : ad b9 3e LDA $3eb9 ; (ll + 1)
2675 : 85 4b __ STA T3 + 1 
2677 : 85 12 __ STA P5 
2679 : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
267c : a5 4a __ LDA T3 + 0 
267e : 85 11 __ STA P4 
2680 : a5 4b __ LDA T3 + 1 
2682 : 85 12 __ STA P5 
2684 : ad ca 3d LDA $3dca ; (video_colorram + 0)
2687 : 18 __ __ CLC
2688 : 65 48 __ ADC T2 + 0 
268a : aa __ __ TAX
268b : ad cb 3d LDA $3dcb ; (video_colorram + 1)
268e : 65 49 __ ADC T2 + 1 
2690 : a8 __ __ TAY
2691 : 8a __ __ TXA
2692 : 18 __ __ CLC
2693 : 65 4c __ ADC T4 + 0 
2695 : 85 0d __ STA P0 
2697 : 90 01 __ BCC $269a ; (core_drawtext.s1047 + 0)
.s1046:
2699 : c8 __ __ INY
.s1047:
269a : 84 0e __ STY P1 
269c : a9 00 __ LDA #$00
269e : 85 0f __ STA P2 
26a0 : a9 3f __ LDA #$3f
26a2 : 85 10 __ STA P3 
26a4 : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
26a7 : 18 __ __ CLC
26a8 : a5 4a __ LDA T3 + 0 
26aa : 65 4c __ ADC T4 + 0 
26ac : 8d b0 3e STA $3eb0 ; (txt_x + 0)
26af : ad b2 3e LDA $3eb2 ; (_ch + 0)
26b2 : d0 01 __ BNE $26b5 ; (core_drawtext.s74 + 0)
26b4 : 60 __ __ RTS
.s74:
26b5 : 20 86 28 JSR $2886 ; (core_cr.l34 + 0)
26b8 : ad b2 3e LDA $3eb2 ; (_ch + 0)
26bb : d0 01 __ BNE $26be ; (core_drawtext.s74 + 9)
26bd : 60 __ __ RTS
26be : 4c 1f 25 JMP $251f ; (core_drawtext.l2 + 0)
.s16:
26c1 : 20 7e 27 JSR $277e ; (_getnextch.s0 + 0)
26c4 : ad b2 3e LDA $3eb2 ; (_ch + 0)
26c7 : c9 16 __ CMP #$16
26c9 : f0 27 __ BEQ $26f2 ; (core_drawtext.s77 + 0)
.s41:
26cb : 90 7c __ BCC $2749 ; (core_drawtext.s43 + 0)
.s42:
26cd : c9 19 __ CMP #$19
26cf : d0 04 __ BNE $26d5 ; (core_drawtext.s50 + 0)
.s28:
26d1 : a9 07 __ LDA #$07
26d3 : d0 0b __ BNE $26e0 ; (core_drawtext.s1043 + 0)
.s50:
26d5 : b0 0f __ BCS $26e6 ; (core_drawtext.s51 + 0)
.s52:
26d7 : c9 17 __ CMP #$17
26d9 : f0 03 __ BEQ $26de ; (core_drawtext.s30 + 0)
26db : 4c a7 25 JMP $25a7 ; (core_drawtext.s137 + 0)
.s30:
26de : a9 01 __ LDA #$01
.s1043:
26e0 : 8d ad 3e STA $3ead ; (txt_col + 0)
26e3 : 4c a7 25 JMP $25a7 ; (core_drawtext.s137 + 0)
.s51:
26e6 : c9 56 __ CMP #$56
26e8 : f0 03 __ BEQ $26ed ; (core_drawtext.s32 + 0)
26ea : 4c a7 25 JMP $25a7 ; (core_drawtext.s137 + 0)
.s32:
26ed : a9 01 __ LDA #$01
26ef : 8d bc 3e STA $3ebc ; (u + 0)
.s77:
26f2 : a9 00 __ LDA #$00
26f4 : 8d bd 3e STA $3ebd ; (v + 0)
.l34:
26f7 : ad 86 3e LDA $3e86 ; (vrb + 0)
26fa : 85 4a __ STA T3 + 0 
26fc : ad 87 3e LDA $3e87 ; (vrb + 1)
26ff : 85 4b __ STA T3 + 1 
2701 : ac bd 3e LDY $3ebd ; (v + 0)
2704 : b1 4a __ LDA (T3 + 0),y 
2706 : d0 03 __ BNE $270b ; (core_drawtext.s35 + 0)
2708 : 4c a7 25 JMP $25a7 ; (core_drawtext.s137 + 0)
.s35:
270b : 84 47 __ STY T0 + 0 
270d : ad b8 3e LDA $3eb8 ; (ll + 0)
2710 : 85 4c __ STA T4 + 0 
2712 : ad af 3e LDA $3eaf ; (txt_rev + 0)
2715 : 18 __ __ CLC
2716 : 71 4a __ ADC (T3 + 0),y 
2718 : aa __ __ TAX
2719 : a4 4c __ LDY T4 + 0 
271b : 99 be 3e STA $3ebe,y ; (_buffer + 0)
271e : ad ad 3e LDA $3ead ; (txt_col + 0)
2721 : c8 __ __ INY
2722 : 8c b8 3e STY $3eb8 ; (ll + 0)
2725 : 99 ff 3e STA $3eff,y 
2728 : a9 00 __ LDA #$00
272a : 8d b9 3e STA $3eb9 ; (ll + 1)
272d : a4 47 __ LDY T0 + 0 
272f : c8 __ __ INY
2730 : 8c bd 3e STY $3ebd ; (v + 0)
2733 : ad bc 3e LDA $3ebc ; (u + 0)
2736 : f0 bf __ BEQ $26f7 ; (core_drawtext.l34 + 0)
.s37:
2738 : a9 00 __ LDA #$00
273a : 8d bc 3e STA $3ebc ; (u + 0)
273d : 8a __ __ TXA
273e : 18 __ __ CLC
273f : 69 40 __ ADC #$40
2741 : a6 4c __ LDX T4 + 0 
2743 : 9d be 3e STA $3ebe,x ; (_buffer + 0)
2746 : 4c f7 26 JMP $26f7 ; (core_drawtext.l34 + 0)
.s43:
2749 : c9 0c __ CMP #$0c
274b : d0 07 __ BNE $2754 ; (core_drawtext.s44 + 0)
.s24:
274d : a9 00 __ LDA #$00
274f : 8d e1 3d STA $3de1 ; (align + 0)
2752 : f0 10 __ BEQ $2764 ; (core_drawtext.s1041 + 0)
.s44:
2754 : 90 14 __ BCC $276a ; (core_drawtext.s46 + 0)
.s45:
2756 : c9 12 __ CMP #$12
2758 : f0 03 __ BEQ $275d ; (core_drawtext.s22 + 0)
275a : 4c a7 25 JMP $25a7 ; (core_drawtext.s137 + 0)
.s22:
275d : a9 01 __ LDA #$01
.s1042:
275f : 8d e1 3d STA $3de1 ; (align + 0)
2762 : a9 00 __ LDA #$00
.s1041:
2764 : 8d e2 3d STA $3de2 ; (align + 1)
2767 : 4c a7 25 JMP $25a7 ; (core_drawtext.s137 + 0)
.s46:
276a : c9 03 __ CMP #$03
276c : d0 04 __ BNE $2772 ; (core_drawtext.s47 + 0)
.s20:
276e : a9 02 __ LDA #$02
2770 : d0 ed __ BNE $275f ; (core_drawtext.s1042 + 0)
.s47:
2772 : c9 07 __ CMP #$07
2774 : f0 03 __ BEQ $2779 ; (core_drawtext.s26 + 0)
2776 : 4c a7 25 JMP $25a7 ; (core_drawtext.s137 + 0)
.s26:
2779 : a9 0c __ LDA #$0c
277b : 4c e0 26 JMP $26e0 ; (core_drawtext.s1043 + 0)
--------------------------------------------------------------------
_getnextch: ; _getnextch()->void
.s0:
277e : ad b3 3e LDA $3eb3 ; (_ech + 0)
2781 : f0 08 __ BEQ $278b ; (_getnextch.s2 + 0)
.s1:
2783 : a2 00 __ LDX #$00
2785 : 8e b3 3e STX $3eb3 ; (_ech + 0)
2788 : 4c 30 28 JMP $2830 ; (_getnextch.s1013 + 0)
.s2:
278b : ad b4 3e LDA $3eb4 ; (_cplx + 0)
278e : cd b5 3e CMP $3eb5 ; (_cplw + 0)
2791 : b0 17 __ BCS $27aa ; (_getnextch.s5 + 0)
.s4:
2793 : 85 1b __ STA ACCU + 0 
2795 : 69 01 __ ADC #$01
2797 : 8d b4 3e STA $3eb4 ; (_cplx + 0)
279a : ad b6 3e LDA $3eb6 ; (_cpl + 0)
279d : 18 __ __ CLC
279e : 65 1b __ ADC ACCU + 0 
27a0 : 85 1b __ STA ACCU + 0 
27a2 : ad b7 3e LDA $3eb7 ; (_cpl + 1)
27a5 : 69 00 __ ADC #$00
27a7 : 4c 2a 28 JMP $282a ; (_getnextch.s25 + 0)
.s5:
27aa : ad a3 3e LDA $3ea3 ; (txt + 0)
27ad : 85 1b __ STA ACCU + 0 
27af : ad a4 3e LDA $3ea4 ; (txt + 1)
27b2 : 85 1c __ STA ACCU + 1 
27b4 : cd ac 3e CMP $3eac ; (etxt + 1)
27b7 : d0 0b __ BNE $27c4 ; (_getnextch.s8 + 0)
.s1008:
27b9 : a5 1b __ LDA ACCU + 0 
27bb : cd ab 3e CMP $3eab ; (etxt + 0)
27be : d0 04 __ BNE $27c4 ; (_getnextch.s8 + 0)
.s7:
27c0 : a9 00 __ LDA #$00
27c2 : f0 6c __ BEQ $2830 ; (_getnextch.s1013 + 0)
.s8:
27c4 : 18 __ __ CLC
27c5 : a5 1b __ LDA ACCU + 0 
27c7 : 69 01 __ ADC #$01
27c9 : 8d a3 3e STA $3ea3 ; (txt + 0)
27cc : a5 1c __ LDA ACCU + 1 
27ce : 69 00 __ ADC #$00
27d0 : 8d a4 3e STA $3ea4 ; (txt + 1)
27d3 : a0 00 __ LDY #$00
27d5 : b1 1b __ LDA (ACCU + 0),y 
27d7 : 8d b2 3e STA $3eb2 ; (_ch + 0)
27da : c9 5d __ CMP #$5d
27dc : d0 07 __ BNE $27e5 ; (_getnextch.s13 + 0)
.s10:
27de : a9 01 __ LDA #$01
27e0 : 8d b2 3e STA $3eb2 ; (_ch + 0)
27e3 : d0 4f __ BNE $2834 ; (_getnextch.s16 + 0)
.s13:
27e5 : c9 5e __ CMP #$5e
27e7 : d0 18 __ BNE $2801 ; (_getnextch.s11 + 0)
.s14:
27e9 : c8 __ __ INY
27ea : b1 1b __ LDA (ACCU + 0),y 
27ec : 8d b2 3e STA $3eb2 ; (_ch + 0)
27ef : 18 __ __ CLC
27f0 : a5 1b __ LDA ACCU + 0 
27f2 : 69 02 __ ADC #$02
27f4 : 8d a3 3e STA $3ea3 ; (txt + 0)
27f7 : a5 1c __ LDA ACCU + 1 
27f9 : 69 00 __ ADC #$00
27fb : 8d a4 3e STA $3ea4 ; (txt + 1)
27fe : 4c 34 28 JMP $2834 ; (_getnextch.s16 + 0)
.s11:
2801 : c9 5f __ CMP #$5f
2803 : 90 2e __ BCC $2833 ; (_getnextch.s1001 + 0)
.s17:
2805 : 84 1c __ STY ACCU + 1 
2807 : a9 02 __ LDA #$02
2809 : 8d b5 3e STA $3eb5 ; (_cplw + 0)
280c : a9 01 __ LDA #$01
280e : 8d b4 3e STA $3eb4 ; (_cplx + 0)
2811 : ad b2 3e LDA $3eb2 ; (_ch + 0)
2814 : e9 5f __ SBC #$5f
2816 : 0a __ __ ASL
2817 : 26 1c __ ROL ACCU + 1 
2819 : 18 __ __ CLC
281a : 6d 5a 3e ADC $3e5a ; (packdata + 0)
281d : 85 1b __ STA ACCU + 0 
281f : 8d b6 3e STA $3eb6 ; (_cpl + 0)
2822 : ad 5b 3e LDA $3e5b ; (packdata + 1)
2825 : 65 1c __ ADC ACCU + 1 
2827 : 8d b7 3e STA $3eb7 ; (_cpl + 1)
.s25:
282a : 85 1c __ STA ACCU + 1 
282c : a0 00 __ LDY #$00
282e : b1 1b __ LDA (ACCU + 0),y 
.s1013:
2830 : 8d b2 3e STA $3eb2 ; (_ch + 0)
.s1001:
2833 : 60 __ __ RTS
.s16:
2834 : a9 01 __ LDA #$01
2836 : 8d b4 3e STA $3eb4 ; (_cplx + 0)
2839 : ad 48 3e LDA $3e48 ; (shortdict + 0)
283c : 85 43 __ STA T3 + 0 
283e : 18 __ __ CLC
283f : 6d b2 3e ADC $3eb2 ; (_ch + 0)
2842 : 85 1b __ STA ACCU + 0 
2844 : ad 49 3e LDA $3e49 ; (shortdict + 1)
2847 : 85 44 __ STA T3 + 1 
2849 : 69 00 __ ADC #$00
284b : 85 1c __ STA ACCU + 1 
284d : a0 00 __ LDY #$00
284f : b1 43 __ LDA (T3 + 0),y 
2851 : 18 __ __ CLC
2852 : 65 43 __ ADC T3 + 0 
2854 : 90 02 __ BCC $2858 ; (_getnextch.s1015 + 0)
.s1014:
2856 : e6 44 __ INC T3 + 1 
.s1015:
2858 : 18 __ __ CLC
2859 : 69 01 __ ADC #$01
285b : 85 43 __ STA T3 + 0 
285d : a5 44 __ LDA T3 + 1 
285f : 69 00 __ ADC #$00
2861 : aa __ __ TAX
2862 : b1 1b __ LDA (ACCU + 0),y 
2864 : 85 1d __ STA ACCU + 2 
2866 : 18 __ __ CLC
2867 : 65 43 __ ADC T3 + 0 
2869 : 85 43 __ STA T3 + 0 
286b : 8d b6 3e STA $3eb6 ; (_cpl + 0)
286e : 8a __ __ TXA
286f : 69 00 __ ADC #$00
2871 : 85 44 __ STA T3 + 1 
2873 : 8d b7 3e STA $3eb7 ; (_cpl + 1)
2876 : b1 43 __ LDA (T3 + 0),y 
2878 : 8d b2 3e STA $3eb2 ; (_ch + 0)
287b : a0 01 __ LDY #$01
287d : b1 1b __ LDA (ACCU + 0),y 
287f : 38 __ __ SEC
2880 : e5 1d __ SBC ACCU + 2 
2882 : 8d b5 3e STA $3eb5 ; (_cplw + 0)
2885 : 60 __ __ RTS
--------------------------------------------------------------------
core_cr: ; core_cr()->void
.l34:
2886 : 2c 11 d0 BIT $d011 
2889 : 10 fb __ BPL $2886 ; (core_cr.l34 + 0)
.s1:
288b : a9 00 __ LDA #$00
288d : 8d b0 3e STA $3eb0 ; (txt_x + 0)
2890 : ad b1 3e LDA $3eb1 ; (txt_y + 0)
2893 : 85 45 __ STA T0 + 0 
2895 : 18 __ __ CLC
2896 : 69 01 __ ADC #$01
2898 : 85 46 __ STA T2 + 0 
289a : 8d b1 3e STA $3eb1 ; (txt_y + 0)
289d : ad b2 3e LDA $3eb2 ; (_ch + 0)
28a0 : c9 20 __ CMP #$20
28a2 : f0 04 __ BEQ $28a8 ; (core_cr.s5 + 0)
.s8:
28a4 : c9 1f __ CMP #$1f
28a6 : d0 03 __ BNE $28ab ; (core_cr.s7 + 0)
.s5:
28a8 : 20 7e 27 JSR $277e ; (_getnextch.s0 + 0)
.s7:
28ab : a5 46 __ LDA T2 + 0 
28ad : c9 19 __ CMP #$19
28af : 90 08 __ BCC $28b9 ; (core_cr.s11 + 0)
.s9:
28b1 : 20 bd 28 JSR $28bd ; (scrollup.l71 + 0)
28b4 : a5 45 __ LDA T0 + 0 
28b6 : 8d b1 3e STA $3eb1 ; (txt_y + 0)
.s11:
28b9 : ee 89 3e INC $3e89 ; (al + 0)
.s1001:
28bc : 60 __ __ RTS
--------------------------------------------------------------------
scrollup: ; scrollup()->void
.l71:
28bd : 2c 11 d0 BIT $d011 
28c0 : 10 fb __ BPL $28bd ; (scrollup.l71 + 0)
.s1:
28c2 : ad a6 02 LDA $02a6 
28c5 : d0 0e __ BNE $28d5 ; (scrollup.l9 + 0)
.s5:
28c7 : a9 96 __ LDA #$96
28c9 : 85 0d __ STA P0 
28cb : a9 00 __ LDA #$00
28cd : 85 0e __ STA P1 
28cf : 20 60 29 JSR $2960 ; (vic_waitLine.s0 + 0)
28d2 : 4c df 28 JMP $28df ; (scrollup.s7 + 0)
.l9:
28d5 : 2c 11 d0 BIT $d011 
28d8 : 30 fb __ BMI $28d5 ; (scrollup.l9 + 0)
.l12:
28da : 2c 11 d0 BIT $d011 
28dd : 10 fb __ BPL $28da ; (scrollup.l12 + 0)
.s7:
28df : a5 01 __ LDA $01 
28e1 : 8d 9e 3e STA $3e9e ; (ch + 0)
28e4 : 78 __ __ SEI
28e5 : 25 fc __ AND $fc 
28e7 : 85 01 __ STA $01 
28e9 : a2 28 __ LDX #$28
28eb : ca __ __ DEX
28ec : bd 58 f6 LDA $f658,x 
28ef : 9d 30 f6 STA $f630,x 
28f2 : bd 80 f6 LDA $f680,x 
28f5 : 9d 58 f6 STA $f658,x 
28f8 : bd a8 f6 LDA $f6a8,x 
28fb : 9d 80 f6 STA $f680,x 
28fe : bd d0 f6 LDA $f6d0,x 
2901 : 9d a8 f6 STA $f6a8,x 
2904 : bd f8 f6 LDA $f6f8,x 
2907 : 9d d0 f6 STA $f6d0,x 
290a : bd 20 f7 LDA $f720,x 
290d : 9d f8 f6 STA $f6f8,x 
2910 : bd 48 f7 LDA $f748,x 
2913 : 9d 20 f7 STA $f720,x 
2916 : bd 70 f7 LDA $f770,x 
2919 : 9d 48 f7 STA $f748,x 
291c : bd 98 f7 LDA $f798,x 
291f : 9d 70 f7 STA $f770,x 
2922 : bd c0 f7 LDA $f7c0,x 
2925 : 9d 98 f7 STA $f798,x 
2928 : a9 20 __ LDA #$20
292a : 9d c0 f7 STA $f7c0,x 
292d : e0 00 __ CPX #$00
292f : d0 ba __ BNE $28eb ; (scrollup.s7 + 12)
2931 : ad 9e 3e LDA $3e9e ; (ch + 0)
2934 : 85 01 __ STA $01 
2936 : 58 __ __ CLI
2937 : a9 90 __ LDA #$90
2939 : 85 11 __ STA P4 
293b : a9 01 __ LDA #$01
293d : 85 12 __ STA P5 
293f : ad ca 3d LDA $3dca ; (video_colorram + 0)
2942 : 18 __ __ CLC
2943 : 69 30 __ ADC #$30
2945 : 85 0d __ STA P0 
2947 : ad cb 3d LDA $3dcb ; (video_colorram + 1)
294a : 69 02 __ ADC #$02
294c : 85 0e __ STA P1 
294e : ad ca 3d LDA $3dca ; (video_colorram + 0)
2951 : 18 __ __ CLC
2952 : 69 58 __ ADC #$58
2954 : 85 0f __ STA P2 
2956 : ad cb 3d LDA $3dcb ; (video_colorram + 1)
2959 : 69 02 __ ADC #$02
295b : 85 10 __ STA P3 
295d : 4c 79 29 JMP $2979 ; (memmove.s0 + 0)
--------------------------------------------------------------------
vic_waitLine: ; vic_waitLine(i16)->void
.s0:
2960 : 46 0e __ LSR P1 ; (line + 1)
2962 : a9 00 __ LDA #$00
2964 : 6a __ __ ROR
2965 : 85 1b __ STA ACCU + 0 
2967 : a4 0d __ LDY P0 ; (line + 0)
.l3:
2969 : 98 __ __ TYA
.l1006:
296a : cd 12 d0 CMP $d012 
296d : d0 fb __ BNE $296a ; (vic_waitLine.l1006 + 0)
.s5:
296f : ad 11 d0 LDA $d011 
2972 : 29 80 __ AND #$80
2974 : c5 1b __ CMP ACCU + 0 
2976 : d0 f1 __ BNE $2969 ; (vic_waitLine.l3 + 0)
.s1001:
2978 : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
2979 : a5 12 __ LDA P5 ; (size + 1)
297b : 30 5c __ BMI $29d9 ; (memmove.s3 + 0)
.s1006:
297d : 05 11 __ ORA P4 ; (size + 0)
297f : f0 58 __ BEQ $29d9 ; (memmove.s3 + 0)
.s1:
2981 : a5 0e __ LDA P1 ; (dst + 1)
2983 : c5 10 __ CMP P3 ; (src + 1)
2985 : d0 04 __ BNE $298b ; (memmove.s1005 + 0)
.s1004:
2987 : a5 0d __ LDA P0 ; (dst + 0)
2989 : c5 0f __ CMP P2 ; (src + 0)
.s1005:
298b : 90 55 __ BCC $29e2 ; (memmove.s15 + 0)
.s5:
298d : a5 10 __ LDA P3 ; (src + 1)
298f : c5 0e __ CMP P1 ; (dst + 1)
2991 : d0 04 __ BNE $2997 ; (memmove.s1003 + 0)
.s1002:
2993 : a5 0f __ LDA P2 ; (src + 0)
2995 : c5 0d __ CMP P0 ; (dst + 0)
.s1003:
2997 : b0 40 __ BCS $29d9 ; (memmove.s3 + 0)
.s9:
2999 : a5 0f __ LDA P2 ; (src + 0)
299b : 65 11 __ ADC P4 ; (size + 0)
299d : 85 43 __ STA T4 + 0 
299f : a5 10 __ LDA P3 ; (src + 1)
29a1 : 65 12 __ ADC P5 ; (size + 1)
29a3 : 85 44 __ STA T4 + 1 
29a5 : 18 __ __ CLC
29a6 : a5 0d __ LDA P0 ; (dst + 0)
29a8 : 65 11 __ ADC P4 ; (size + 0)
29aa : 85 1b __ STA ACCU + 0 
29ac : a5 0e __ LDA P1 ; (dst + 1)
29ae : 65 12 __ ADC P5 ; (size + 1)
29b0 : 85 1c __ STA ACCU + 1 
29b2 : a0 00 __ LDY #$00
29b4 : a5 11 __ LDA P4 ; (size + 0)
29b6 : f0 02 __ BEQ $29ba ; (memmove.l1009 + 0)
.s1014:
29b8 : e6 12 __ INC P5 ; (size + 1)
.l1009:
29ba : a6 11 __ LDX P4 ; (size + 0)
.l1017:
29bc : a5 1b __ LDA ACCU + 0 
29be : d0 02 __ BNE $29c2 ; (memmove.s1024 + 0)
.s1023:
29c0 : c6 1c __ DEC ACCU + 1 
.s1024:
29c2 : c6 1b __ DEC ACCU + 0 
29c4 : a5 43 __ LDA T4 + 0 
29c6 : d0 02 __ BNE $29ca ; (memmove.s1026 + 0)
.s1025:
29c8 : c6 44 __ DEC T4 + 1 
.s1026:
29ca : c6 43 __ DEC T4 + 0 
29cc : b1 43 __ LDA (T4 + 0),y 
29ce : 91 1b __ STA (ACCU + 0),y 
29d0 : ca __ __ DEX
29d1 : d0 e9 __ BNE $29bc ; (memmove.l1017 + 0)
.s1018:
29d3 : 86 11 __ STX P4 ; (size + 0)
29d5 : c6 12 __ DEC P5 ; (size + 1)
29d7 : d0 e1 __ BNE $29ba ; (memmove.l1009 + 0)
.s3:
29d9 : a5 0d __ LDA P0 ; (dst + 0)
29db : 85 1b __ STA ACCU + 0 
29dd : a5 0e __ LDA P1 ; (dst + 1)
29df : 85 1c __ STA ACCU + 1 
.s1001:
29e1 : 60 __ __ RTS
.s15:
29e2 : a5 0d __ LDA P0 ; (dst + 0)
29e4 : 85 1b __ STA ACCU + 0 
29e6 : a5 0e __ LDA P1 ; (dst + 1)
29e8 : 85 1c __ STA ACCU + 1 
29ea : a0 00 __ LDY #$00
29ec : a5 11 __ LDA P4 ; (size + 0)
29ee : f0 02 __ BEQ $29f2 ; (memmove.l1007 + 0)
.s1012:
29f0 : e6 12 __ INC P5 ; (size + 1)
.l1007:
29f2 : a6 11 __ LDX P4 ; (size + 0)
.l1015:
29f4 : b1 0f __ LDA (P2),y ; (src + 0)
29f6 : 91 1b __ STA (ACCU + 0),y 
29f8 : e6 0f __ INC P2 ; (src + 0)
29fa : d0 02 __ BNE $29fe ; (memmove.s1020 + 0)
.s1019:
29fc : e6 10 __ INC P3 ; (src + 1)
.s1020:
29fe : e6 1b __ INC ACCU + 0 
2a00 : d0 02 __ BNE $2a04 ; (memmove.s1022 + 0)
.s1021:
2a02 : e6 1c __ INC ACCU + 1 
.s1022:
2a04 : ca __ __ DEX
2a05 : d0 ed __ BNE $29f4 ; (memmove.l1015 + 0)
.s1016:
2a07 : 86 11 __ STX P4 ; (size + 0)
2a09 : c6 12 __ DEC P5 ; (size + 1)
2a0b : d0 e5 __ BNE $29f2 ; (memmove.l1007 + 0)
2a0d : 90 ca __ BCC $29d9 ; (memmove.s3 + 0)
--------------------------------------------------------------------
_savechpos: ; _savechpos()->void
.s0:
2a0f : ad a3 3e LDA $3ea3 ; (txt + 0)
2a12 : 8d e8 3e STA $3ee8 ; (btxt + 0)
2a15 : ad a4 3e LDA $3ea4 ; (txt + 1)
2a18 : 8d e9 3e STA $3ee9 ; (btxt + 1)
2a1b : ad b6 3e LDA $3eb6 ; (_cpl + 0)
2a1e : 8d ea 3e STA $3eea ; (b_cpl + 0)
2a21 : ad b7 3e LDA $3eb7 ; (_cpl + 1)
2a24 : 8d eb 3e STA $3eeb ; (b_cpl + 1)
2a27 : ad b4 3e LDA $3eb4 ; (_cplx + 0)
2a2a : 8d ec 3e STA $3eec ; (b_cplx + 0)
2a2d : ad b5 3e LDA $3eb5 ; (_cplw + 0)
2a30 : 8d ed 3e STA $3eed ; (b_cplw + 0)
.s1001:
2a33 : 60 __ __ RTS
--------------------------------------------------------------------
_restorechpos: ; _restorechpos()->void
.s0:
2a34 : ad e8 3e LDA $3ee8 ; (btxt + 0)
2a37 : 8d a3 3e STA $3ea3 ; (txt + 0)
2a3a : ad e9 3e LDA $3ee9 ; (btxt + 1)
2a3d : 8d a4 3e STA $3ea4 ; (txt + 1)
2a40 : ad ea 3e LDA $3eea ; (b_cpl + 0)
2a43 : 8d b6 3e STA $3eb6 ; (_cpl + 0)
2a46 : ad eb 3e LDA $3eeb ; (b_cpl + 1)
2a49 : 8d b7 3e STA $3eb7 ; (_cpl + 1)
2a4c : ad ec 3e LDA $3eec ; (b_cplx + 0)
2a4f : 8d b4 3e STA $3eb4 ; (_cplx + 0)
2a52 : ad ed 3e LDA $3eed ; (b_cplw + 0)
2a55 : 8d b5 3e STA $3eb5 ; (_cplw + 0)
.s1001:
2a58 : 60 __ __ RTS
--------------------------------------------------------------------
cr: ; cr()->void
.l30:
2a59 : 2c 11 d0 BIT $d011 
2a5c : 10 fb __ BPL $2a59 ; (cr.l30 + 0)
.s1:
2a5e : ad dc 3d LDA $3ddc ; (text_y + 0)
2a61 : 85 45 __ STA T0 + 0 
2a63 : 18 __ __ CLC
2a64 : 69 01 __ ADC #$01
2a66 : 8d dc 3d STA $3ddc ; (text_y + 0)
2a69 : c9 0b __ CMP #$0b
2a6b : 90 08 __ BCC $2a75 ; (cr.s1001 + 0)
.s5:
2a6d : 20 bd 28 JSR $28bd ; (scrollup.l71 + 0)
2a70 : a5 45 __ LDA T0 + 0 
2a72 : 8d dc 3d STA $3ddc ; (text_y + 0)
.s1001:
2a75 : 60 __ __ RTS
--------------------------------------------------------------------
ui_waitkey: ; ui_waitkey()->void
.s0:
2a76 : ad ca 3d LDA $3dca ; (video_colorram + 0)
2a79 : 18 __ __ CLC
2a7a : 69 c0 __ ADC #$c0
2a7c : 85 43 __ STA T1 + 0 
2a7e : ad cb 3d LDA $3dcb ; (video_colorram + 1)
2a81 : 69 03 __ ADC #$03
2a83 : 85 44 __ STA T1 + 1 
2a85 : ad c8 3d LDA $3dc8 ; (video_ram + 0)
2a88 : 18 __ __ CLC
2a89 : 69 c0 __ ADC #$c0
2a8b : 85 45 __ STA T2 + 0 
2a8d : ad c9 3d LDA $3dc9 ; (video_ram + 1)
2a90 : 69 03 __ ADC #$03
2a92 : 85 46 __ STA T2 + 1 
2a94 : a0 12 __ LDY #$12
.l1006:
2a96 : a9 0f __ LDA #$0f
2a98 : 91 43 __ STA (T1 + 0),y 
2a9a : a9 2e __ LDA #$2e
2a9c : 91 45 __ STA (T2 + 0),y 
2a9e : c8 __ __ INY
2a9f : c0 15 __ CPY #$15
2aa1 : 90 f3 __ BCC $2a96 ; (ui_waitkey.l1006 + 0)
.s3:
2aa3 : a9 15 __ LDA #$15
2aa5 : 8d b8 3e STA $3eb8 ; (ll + 0)
2aa8 : a9 00 __ LDA #$00
2aaa : 8d b9 3e STA $3eb9 ; (ll + 1)
2aad : 20 cd 2a JSR $2acd ; (ui_getkey.l2 + 0)
2ab0 : a0 12 __ LDY #$12
.l1008:
2ab2 : a9 0f __ LDA #$0f
2ab4 : 91 43 __ STA (T1 + 0),y 
2ab6 : a9 20 __ LDA #$20
2ab8 : 91 45 __ STA (T2 + 0),y 
2aba : c8 __ __ INY
2abb : c0 15 __ CPY #$15
2abd : 90 f3 __ BCC $2ab2 ; (ui_waitkey.l1008 + 0)
.s6:
2abf : a9 00 __ LDA #$00
2ac1 : 8d 89 3e STA $3e89 ; (al + 0)
2ac4 : 8d b9 3e STA $3eb9 ; (ll + 1)
2ac7 : a9 15 __ LDA #$15
2ac9 : 8d b8 3e STA $3eb8 ; (ll + 0)
.s1001:
2acc : 60 __ __ RTS
--------------------------------------------------------------------
ui_getkey: ; ui_getkey()->void
.l2:
2acd : 20 9f ff JSR $ff9f 
2ad0 : 20 e4 ff JSR $ffe4 
2ad3 : 8d 9e 3e STA $3e9e ; (ch + 0)
2ad6 : ad 9e 3e LDA $3e9e ; (ch + 0)
2ad9 : d0 08 __ BNE $2ae3 ; (ui_getkey.s1001 + 0)
.l82:
2adb : 2c 11 d0 BIT $d011 
2ade : 10 fb __ BPL $2adb ; (ui_getkey.l82 + 0)
2ae0 : 4c cd 2a JMP $2acd ; (ui_getkey.l2 + 0)
.s1001:
2ae3 : 60 __ __ RTS
--------------------------------------------------------------------
adv_save: ; adv_save()->u8
.s0:
2ae4 : a9 00 __ LDA #$00
2ae6 : 85 13 __ STA P6 
2ae8 : 20 2c 2b JSR $2b2c ; (irq_detach.l30 + 0)
2aeb : a9 da __ LDA #$da
2aed : 85 0d __ STA P0 
2aef : a9 2b __ LDA #$2b
2af1 : 85 0e __ STA P1 
2af3 : ad 72 3e LDA $3e72 ; (objattr + 0)
2af6 : 85 0f __ STA P2 
2af8 : ad 73 3e LDA $3e73 ; (objattr + 1)
2afb : 85 10 __ STA P3 
2afd : ad 82 3e LDA $3e82 ; (origram_len + 0)
2b00 : 85 11 __ STA P4 
2b02 : ad 83 3e LDA $3e83 ; (origram_len + 1)
2b05 : 85 12 __ STA P5 
2b07 : 20 8c 2b JSR $2b8c ; (disk_save.s0 + 0)
2b0a : 09 00 __ ORA #$00
2b0c : f0 07 __ BEQ $2b15 ; (adv_save.s1 + 0)
.s2:
2b0e : 20 df 2b JSR $2bdf ; (irq_attach.l27 + 0)
2b11 : a9 01 __ LDA #$01
2b13 : d0 14 __ BNE $2b29 ; (adv_save.s1001 + 0)
.s1:
2b15 : a9 02 __ LDA #$02
2b17 : 8d 20 d0 STA $d020 
.l32:
2b1a : 2c 11 d0 BIT $d011 
2b1d : 10 fb __ BPL $2b1a ; (adv_save.l32 + 0)
.s4:
2b1f : a9 00 __ LDA #$00
2b21 : 8d 20 d0 STA $d020 
2b24 : 20 df 2b JSR $2bdf ; (irq_attach.l27 + 0)
2b27 : a9 00 __ LDA #$00
.s1001:
2b29 : 85 1b __ STA ACCU + 0 
2b2b : 60 __ __ RTS
--------------------------------------------------------------------
irq_detach: ; irq_detach(u8)->void
.l30:
2b2c : 2c 11 d0 BIT $d011 
2b2f : 10 fb __ BPL $2b2c ; (irq_detach.l30 + 0)
.s1:
2b31 : 20 77 2b JSR $2b77 ; (IRQ_reset.s0 + 0)
2b34 : a5 13 __ LDA P6 ; (mode + 0)
2b36 : f0 3c __ BEQ $2b74 ; (irq_detach.s5 + 0)
.s6:
2b38 : 20 f3 11 JSR $11f3 ; (do_bitmapmode.s0 + 0)
2b3b : a9 00 __ LDA #$00
2b3d : 85 0f __ STA P2 
2b3f : 85 10 __ STA P3 
2b41 : a9 08 __ LDA #$08
2b43 : 85 11 __ STA P4 
2b45 : a9 02 __ LDA #$02
2b47 : 85 12 __ STA P5 
2b49 : a9 e0 __ LDA #$e0
2b4b : 85 0d __ STA P0 
2b4d : a9 f1 __ LDA #$f1
2b4f : 85 0e __ STA P1 
2b51 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
2b54 : a9 00 __ LDA #$00
2b56 : 85 0f __ STA P2 
2b58 : 85 10 __ STA P3 
2b5a : a9 08 __ LDA #$08
2b5c : 85 11 __ STA P4 
2b5e : a9 02 __ LDA #$02
2b60 : 85 12 __ STA P5 
2b62 : ad ca 3d LDA $3dca ; (video_colorram + 0)
2b65 : 18 __ __ CLC
2b66 : 69 e0 __ ADC #$e0
2b68 : 85 0d __ STA P0 
2b6a : ad cb 3d LDA $3dcb ; (video_colorram + 1)
2b6d : 69 01 __ ADC #$01
2b6f : 85 0e __ STA P1 
2b71 : 4c 04 0d JMP $0d04 ; (memset.s0 + 0)
.s5:
2b74 : 4c 28 0d JMP $0d28 ; (do_textmode.s0 + 0)
--------------------------------------------------------------------
IRQ_reset: ; IRQ_reset()->void
.s0:
2b77 : 78 __ __ SEI
2b78 : ad 1a d0 LDA $d01a 
2b7b : 29 fe __ AND #$fe
2b7d : 8d 1a d0 STA $d01a 
2b80 : a2 81 __ LDX #$81
2b82 : a0 ea __ LDY #$ea
2b84 : 8e 14 03 STX $0314 
2b87 : 8c 15 03 STY $0315 
2b8a : 58 __ __ CLI
.s1001:
2b8b : 60 __ __ RTS
--------------------------------------------------------------------
disk_save: ; disk_save(const u8*,u8*,u16)->u8
.s0:
2b8c : a5 0f __ LDA P2 ; (mem + 0)
2b8e : 8d ee 3e STA $3eee ; (diskmemlow + 0)
2b91 : 18 __ __ CLC
2b92 : 65 11 __ ADC P4 ; (len + 0)
2b94 : 8d f0 3e STA $3ef0 ; (ediskmemlow + 0)
2b97 : a5 10 __ LDA P3 ; (mem + 1)
2b99 : 8d ef 3e STA $3eef ; (diskmemhi + 0)
2b9c : 65 12 __ ADC P5 ; (len + 1)
2b9e : 8d f1 3e STA $3ef1 ; (ediskmemhi + 0)
2ba1 : a9 07 __ LDA #$07
2ba3 : a2 e4 __ LDX #$e4
2ba5 : a0 3d __ LDY #$3d
2ba7 : 20 bd ff JSR $ffbd 
2baa : a9 01 __ LDA #$01
2bac : a6 ba __ LDX $ba 
2bae : d0 02 __ BNE $2bb2 ; (disk_save.s0 + 38)
2bb0 : a2 08 __ LDX #$08
2bb2 : a0 00 __ LDY #$00
2bb4 : 20 ba ff JSR $ffba 
2bb7 : ad ee 3e LDA $3eee ; (diskmemlow + 0)
2bba : 85 c1 __ STA $c1 
2bbc : ad ef 3e LDA $3eef ; (diskmemhi + 0)
2bbf : 85 c2 __ STA $c2 
2bc1 : ae f0 3e LDX $3ef0 ; (ediskmemlow + 0)
2bc4 : ac f1 3e LDY $3ef1 ; (ediskmemhi + 0)
2bc7 : a9 c1 __ LDA #$c1
2bc9 : 20 d8 ff JSR $ffd8 
2bcc : b0 05 __ BCS $2bd3 ; (disk_save.s0 + 71)
2bce : a9 01 __ LDA #$01
2bd0 : 85 1b __ STA ACCU + 0 
2bd2 : 60 __ __ RTS
2bd3 : a9 00 __ LDA #$00
2bd5 : 85 1b __ STA ACCU + 0 
.s1001:
2bd7 : a5 1b __ LDA ACCU + 0 
2bd9 : 60 __ __ RTS
--------------------------------------------------------------------
2bda : __ __ __ BYT 73 61 76 65 00                                  : save.
--------------------------------------------------------------------
irq_attach: ; irq_attach()->void
.l27:
2bdf : 2c 11 d0 BIT $d011 
2be2 : 10 fb __ BPL $2bdf ; (irq_attach.l27 + 0)
.s1:
2be4 : 4c b1 11 JMP $11b1 ; (IRQ_gfx_init.s0 + 0)
--------------------------------------------------------------------
mini_itoa: ; mini_itoa(i16,u8*)->void
.s0:
2be7 : a5 0e __ LDA P1 ; (n + 1)
2be9 : 30 75 __ BMI $2c60 ; (mini_itoa.s3 + 0)
.s1012:
2beb : d0 06 __ BNE $2bf3 ; (mini_itoa.s1 + 0)
.s1011:
2bed : a5 0d __ LDA P0 ; (n + 0)
2bef : c9 64 __ CMP #$64
2bf1 : 90 6d __ BCC $2c60 ; (mini_itoa.s3 + 0)
.s1:
2bf3 : a5 0f __ LDA P2 ; (s + 0)
2bf5 : 85 1b __ STA ACCU + 0 
2bf7 : a5 10 __ LDA P3 ; (s + 1)
2bf9 : 85 1c __ STA ACCU + 1 
2bfb : a9 30 __ LDA #$30
2bfd : a0 00 __ LDY #$00
2bff : 91 0f __ STA (P2),y ; (s + 0)
2c01 : a6 0d __ LDX P0 ; (n + 0)
.l1015:
2c03 : b1 1b __ LDA (ACCU + 0),y 
2c05 : 18 __ __ CLC
2c06 : 69 01 __ ADC #$01
2c08 : 91 1b __ STA (ACCU + 0),y 
2c0a : 8a __ __ TXA
2c0b : 38 __ __ SEC
2c0c : e9 64 __ SBC #$64
2c0e : aa __ __ TAX
2c0f : a5 0e __ LDA P1 ; (n + 1)
2c11 : e9 00 __ SBC #$00
2c13 : 85 0e __ STA P1 ; (n + 1)
2c15 : d0 ec __ BNE $2c03 ; (mini_itoa.l1015 + 0)
.s1010:
2c17 : e0 64 __ CPX #$64
2c19 : b0 e8 __ BCS $2c03 ; (mini_itoa.l1015 + 0)
.s18:
2c1b : 86 0d __ STX P0 ; (n + 0)
2c1d : a9 01 __ LDA #$01
2c1f : 85 1b __ STA ACCU + 0 
2c21 : e0 0a __ CPX #$0a
2c23 : 90 31 __ BCC $2c56 ; (mini_itoa.s8 + 0)
.s32:
2c25 : a8 __ __ TAY
.s7:
2c26 : a9 30 __ LDA #$30
2c28 : 91 0f __ STA (P2),y ; (s + 0)
2c2a : a5 0d __ LDA P0 ; (n + 0)
2c2c : 30 17 __ BMI $2c45 ; (mini_itoa.s50 + 0)
.s1019:
2c2e : c9 0a __ CMP #$0a
2c30 : 90 13 __ BCC $2c45 ; (mini_itoa.s50 + 0)
.s1017:
2c32 : aa __ __ TAX
.l1013:
2c33 : b1 0f __ LDA (P2),y ; (s + 0)
2c35 : 18 __ __ CLC
2c36 : 69 01 __ ADC #$01
2c38 : 91 0f __ STA (P2),y ; (s + 0)
2c3a : 8a __ __ TXA
2c3b : 38 __ __ SEC
2c3c : e9 0a __ SBC #$0a
2c3e : aa __ __ TAX
2c3f : e0 0a __ CPX #$0a
2c41 : b0 f0 __ BCS $2c33 ; (mini_itoa.l1013 + 0)
.s1018:
2c43 : 85 0d __ STA P0 ; (n + 0)
.s50:
2c45 : e6 1b __ INC ACCU + 0 
.s9:
2c47 : 18 __ __ CLC
2c48 : a5 0d __ LDA P0 ; (n + 0)
2c4a : 69 30 __ ADC #$30
2c4c : a4 1b __ LDY ACCU + 0 
2c4e : 91 0f __ STA (P2),y ; (s + 0)
2c50 : a9 00 __ LDA #$00
2c52 : c8 __ __ INY
2c53 : 91 0f __ STA (P2),y ; (s + 0)
.s1001:
2c55 : 60 __ __ RTS
.s8:
2c56 : a4 1b __ LDY ACCU + 0 
2c58 : f0 ed __ BEQ $2c47 ; (mini_itoa.s9 + 0)
.s13:
2c5a : a9 30 __ LDA #$30
2c5c : 91 0f __ STA (P2),y ; (s + 0)
2c5e : d0 e5 __ BNE $2c45 ; (mini_itoa.s50 + 0)
.s3:
2c60 : a9 00 __ LDA #$00
2c62 : 85 1b __ STA ACCU + 0 
2c64 : a5 0e __ LDA P1 ; (n + 1)
2c66 : 30 ee __ BMI $2c56 ; (mini_itoa.s8 + 0)
.s1007:
2c68 : d0 06 __ BNE $2c70 ; (mini_itoa.s33 + 0)
.s1006:
2c6a : a5 0d __ LDA P0 ; (n + 0)
2c6c : c9 0a __ CMP #$0a
2c6e : 90 e6 __ BCC $2c56 ; (mini_itoa.s8 + 0)
.s33:
2c70 : a0 00 __ LDY #$00
2c72 : f0 b2 __ BEQ $2c26 ; (mini_itoa.s7 + 0)
--------------------------------------------------------------------
ui_room_update: ; ui_room_update()->void
.l27:
2c74 : 2c 11 d0 BIT $d011 
2c77 : 10 fb __ BPL $2c74 ; (ui_room_update.l27 + 0)
.s1:
2c79 : 20 7f 2c JSR $2c7f ; (ui_room_gfx_update.l88 + 0)
2c7c : 4c 53 30 JMP $3053 ; (status_update.s0 + 0)
--------------------------------------------------------------------
ui_room_gfx_update: ; ui_room_gfx_update()->void
.l88:
2c7f : 2c 11 d0 BIT $d011 
2c82 : 10 fb __ BPL $2c7f ; (ui_room_gfx_update.l88 + 0)
.s1:
2c84 : a2 0b __ LDX #$0b
.l1002:
2c86 : bd ec 3d LDA $3dec,x ; (slowmode + 0)
2c89 : 9d f3 cb STA $cbf3,x ; (size + 1)
2c8c : ca __ __ DEX
2c8d : d0 f7 __ BNE $2c86 ; (ui_room_gfx_update.l1002 + 0)
.s1003:
2c8f : a9 f4 __ LDA #$f4
2c91 : 85 0d __ STA P0 
2c93 : a9 cb __ LDA #$cb
2c95 : 85 0e __ STA P1 
2c97 : a5 ba __ LDA $ba 
2c99 : d0 02 __ BNE $2c9d ; (ui_room_gfx_update.s7 + 0)
.s5:
2c9b : a9 08 __ LDA #$08
.s7:
2c9d : 86 1c __ STX ACCU + 1 
2c9f : 86 04 __ STX WORK + 1 
2ca1 : 85 4b __ STA T0 + 0 
2ca3 : ae f4 3e LDX $3ef4 ; (imageid + 0)
2ca6 : e8 __ __ INX
2ca7 : 86 1b __ STX ACCU + 0 
2ca9 : a9 0a __ LDA #$0a
2cab : 85 03 __ STA WORK + 0 
2cad : 20 c5 3a JSR $3ac5 ; (divmod + 0)
2cb0 : 18 __ __ CLC
2cb1 : a5 1b __ LDA ACCU + 0 
2cb3 : 69 30 __ ADC #$30
2cb5 : 8d f8 cb STA $cbf8 ; (nm + 4)
2cb8 : 18 __ __ CLC
2cb9 : a5 05 __ LDA WORK + 2 
2cbb : 69 30 __ ADC #$30
2cbd : 8d f9 cb STA $cbf9 ; (nm + 5)
2cc0 : 20 e1 2e JSR $2ee1 ; (krnio_setnam.s0 + 0)
2cc3 : a9 02 __ LDA #$02
2cc5 : 85 0d __ STA P0 
2cc7 : a5 4b __ LDA T0 + 0 
2cc9 : 85 0e __ STA P1 
2ccb : a9 00 __ LDA #$00
2ccd : 85 0f __ STA P2 
2ccf : 20 f7 2e JSR $2ef7 ; (krnio_open.s0 + 0)
2cd2 : 09 00 __ ORA #$00
2cd4 : d0 01 __ BNE $2cd7 ; (ui_room_gfx_update.s8 + 0)
.s1001:
2cd6 : 60 __ __ RTS
.s8:
2cd7 : a9 02 __ LDA #$02
2cd9 : 85 0e __ STA P1 
2cdb : a9 0a __ LDA #$0a
2cdd : 85 11 __ STA P4 
2cdf : a9 00 __ LDA #$00
2ce1 : 85 12 __ STA P5 
2ce3 : a9 e6 __ LDA #$e6
2ce5 : 85 0f __ STA P2 
2ce7 : a9 cb __ LDA #$cb
2ce9 : 85 10 __ STA P3 
2ceb : 20 21 2f JSR $2f21 ; (krnio_read.s0 + 0)
2cee : a9 02 __ LDA #$02
2cf0 : 85 0e __ STA P1 
2cf2 : a9 ff __ LDA #$ff
2cf4 : 4d e6 cb EOR $cbe6 ; (head + 0)
2cf7 : 85 4c __ STA T1 + 0 
2cf9 : 85 0f __ STA P2 
2cfb : 38 __ __ SEC
2cfc : a9 cf __ LDA #$cf
2cfe : ed e7 cb SBC $cbe7 ; (head + 1)
2d01 : 85 4d __ STA T1 + 1 
2d03 : 85 10 __ STA P3 
2d05 : ad ee cb LDA $cbee ; (head + 8)
2d08 : 18 __ __ CLC
2d09 : 6d ea cb ADC $cbea ; (head + 4)
2d0c : 85 11 __ STA P4 
2d0e : ad ef cb LDA $cbef ; (head + 9)
2d11 : 6d eb cb ADC $cbeb ; (head + 5)
2d14 : 85 12 __ STA P5 
2d16 : 20 21 2f JSR $2f21 ; (krnio_read.s0 + 0)
2d19 : ad ec 3d LDA $3dec ; (slowmode + 0)
2d1c : f0 26 __ BEQ $2d44 ; (ui_room_gfx_update.s13 + 0)
.s11:
2d1e : 20 85 12 JSR $1285 ; (ui_clear.s0 + 0)
2d21 : a9 a0 __ LDA #$a0
2d23 : 85 0f __ STA P2 
2d25 : a9 00 __ LDA #$00
2d27 : 85 10 __ STA P3 
2d29 : 85 12 __ STA P5 
2d2b : a9 28 __ LDA #$28
2d2d : 85 11 __ STA P4 
2d2f : ad c8 3d LDA $3dc8 ; (video_ram + 0)
2d32 : 18 __ __ CLC
2d33 : 69 08 __ ADC #$08
2d35 : 85 0d __ STA P0 
2d37 : ad c9 3d LDA $3dc9 ; (video_ram + 1)
2d3a : 69 02 __ ADC #$02
2d3c : 85 0e __ STA P1 
2d3e : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
2d41 : 20 c9 2f JSR $2fc9 ; (ui_image_fade.s0 + 0)
.s13:
2d44 : a5 01 __ LDA $01 
2d46 : 85 4b __ STA T0 + 0 
2d48 : a9 34 __ LDA #$34
2d4a : 85 01 __ STA $01 
2d4c : ad e9 cb LDA $cbe9 ; (head + 3)
2d4f : cd eb cb CMP $cbeb ; (head + 5)
2d52 : d0 08 __ BNE $2d5c ; (ui_room_gfx_update.s15 + 0)
.s1012:
2d54 : ad e8 cb LDA $cbe8 ; (head + 2)
2d57 : cd ea cb CMP $cbea ; (head + 4)
2d5a : f0 16 __ BEQ $2d72 ; (ui_room_gfx_update.s14 + 0)
.s15:
2d5c : a5 4c __ LDA T1 + 0 
2d5e : 85 0d __ STA P0 
2d60 : a5 4d __ LDA T1 + 1 
2d62 : 85 0e __ STA P1 
2d64 : a9 00 __ LDA #$00
2d66 : 85 0f __ STA P2 
2d68 : a9 f0 __ LDA #$f0
2d6a : 85 10 __ STA P3 
2d6c : 20 37 0b JSR $0b37 ; (hunpack.s0 + 0)
2d6f : 4c 8f 2d JMP $2d8f ; (ui_room_gfx_update.s16 + 0)
.s14:
2d72 : a9 00 __ LDA #$00
2d74 : 85 0d __ STA P0 
2d76 : a9 f0 __ LDA #$f0
2d78 : 85 0e __ STA P1 
2d7a : a5 4c __ LDA T1 + 0 
2d7c : 85 0f __ STA P2 
2d7e : a5 4d __ LDA T1 + 1 
2d80 : 85 10 __ STA P3 
2d82 : ad e8 cb LDA $cbe8 ; (head + 2)
2d85 : 85 11 __ STA P4 
2d87 : ad e9 cb LDA $cbe9 ; (head + 3)
2d8a : 85 12 __ STA P5 
2d8c : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
.s16:
2d8f : a5 4b __ LDA T0 + 0 
2d91 : 85 01 __ STA $01 
2d93 : a9 00 __ LDA #$00
2d95 : 85 4e __ STA T3 + 0 
2d97 : 85 4f __ STA T3 + 1 
2d99 : 85 1b __ STA ACCU + 0 
2d9b : 85 1c __ STA ACCU + 1 
2d9d : cd ed cb CMP $cbed ; (head + 7)
2da0 : d0 05 __ BNE $2da7 ; (ui_room_gfx_update.l1011 + 0)
.s1010:
2da2 : a5 1b __ LDA ACCU + 0 
2da4 : cd ec cb CMP $cbec ; (head + 6)
.l1011:
2da7 : b0 03 __ BCS $2dac ; (ui_room_gfx_update.s19 + 0)
2da9 : 4c 8e 2e JMP $2e8e ; (ui_room_gfx_update.s18 + 0)
.s19:
2dac : a9 02 __ LDA #$02
2dae : 85 0e __ STA P1 
2db0 : 85 11 __ STA P4 
2db2 : a9 00 __ LDA #$00
2db4 : 85 12 __ STA P5 
2db6 : a9 f0 __ LDA #$f0
2db8 : 85 0f __ STA P2 
2dba : a9 cb __ LDA #$cb
2dbc : 85 10 __ STA P3 
2dbe : 20 21 2f JSR $2f21 ; (krnio_read.s0 + 0)
2dc1 : ad f0 cb LDA $cbf0 ; (bsize + 0)
2dc4 : 0d f1 cb ORA $cbf1 ; (bsize + 1)
2dc7 : d0 05 __ BNE $2dce ; (ui_room_gfx_update.s27 + 0)
.s22:
2dc9 : a9 02 __ LDA #$02
2dcb : 4c 4b 30 JMP $304b ; (krnio_close.s1000 + 0)
.s27:
2dce : a9 00 __ LDA #$00
2dd0 : 85 4e __ STA T3 + 0 
2dd2 : 85 4f __ STA T3 + 1 
.l21:
2dd4 : a9 02 __ LDA #$02
2dd6 : 85 0e __ STA P1 
2dd8 : 85 11 __ STA P4 
2dda : a9 f2 __ LDA #$f2
2ddc : 85 0f __ STA P2 
2dde : a9 cb __ LDA #$cb
2de0 : 85 10 __ STA P3 
2de2 : a9 00 __ LDA #$00
2de4 : 85 12 __ STA P5 
2de6 : 20 21 2f JSR $2f21 ; (krnio_read.s0 + 0)
2de9 : a9 02 __ LDA #$02
2deb : 85 0e __ STA P1 
2ded : a5 4c __ LDA T1 + 0 
2def : 85 0f __ STA P2 
2df1 : a5 4d __ LDA T1 + 1 
2df3 : 85 10 __ STA P3 
2df5 : ad f2 cb LDA $cbf2 ; (size + 0)
2df8 : 85 11 __ STA P4 
2dfa : ad f3 cb LDA $cbf3 ; (size + 1)
2dfd : 85 12 __ STA P5 
2dff : 20 21 2f JSR $2f21 ; (krnio_read.s0 + 0)
2e02 : a5 01 __ LDA $01 
2e04 : 85 4b __ STA T0 + 0 
2e06 : a9 34 __ LDA #$34
2e08 : 85 01 __ STA $01 
2e0a : ad f0 cb LDA $cbf0 ; (bsize + 0)
2e0d : 38 __ __ SEC
2e0e : e5 4e __ SBC T3 + 0 
2e10 : 85 44 __ STA T5 + 0 
2e12 : ad f1 cb LDA $cbf1 ; (bsize + 1)
2e15 : e5 4f __ SBC T3 + 1 
2e17 : cd f3 cb CMP $cbf3 ; (size + 1)
2e1a : d0 07 __ BNE $2e23 ; (ui_room_gfx_update.s26 + 0)
.s1008:
2e1c : ad f2 cb LDA $cbf2 ; (size + 0)
2e1f : c5 44 __ CMP T5 + 0 
2e21 : f0 2d __ BEQ $2e50 ; (ui_room_gfx_update.s23 + 0)
.s26:
2e23 : ad f3 cb LDA $cbf3 ; (size + 1)
2e26 : cd e7 cb CMP $cbe7 ; (head + 1)
2e29 : d0 08 __ BNE $2e33 ; (ui_room_gfx_update.s24 + 0)
.s1006:
2e2b : ad f2 cb LDA $cbf2 ; (size + 0)
2e2e : cd e6 cb CMP $cbe6 ; (head + 0)
2e31 : f0 1d __ BEQ $2e50 ; (ui_room_gfx_update.s23 + 0)
.s24:
2e33 : a5 0f __ LDA P2 
2e35 : 85 0d __ STA P0 
2e37 : a5 10 __ LDA P3 
2e39 : 85 0e __ STA P1 
2e3b : ad f8 3d LDA $3df8 ; (bitmap_image + 0)
2e3e : 18 __ __ CLC
2e3f : 65 4e __ ADC T3 + 0 
2e41 : 85 0f __ STA P2 
2e43 : ad f9 3d LDA $3df9 ; (bitmap_image + 1)
2e46 : 65 4f __ ADC T3 + 1 
2e48 : 85 10 __ STA P3 
2e4a : 20 37 0b JSR $0b37 ; (hunpack.s0 + 0)
2e4d : 4c 69 2e JMP $2e69 ; (ui_room_gfx_update.s25 + 0)
.s23:
2e50 : 85 11 __ STA P4 
2e52 : ad f3 cb LDA $cbf3 ; (size + 1)
2e55 : 85 12 __ STA P5 
2e57 : ad f8 3d LDA $3df8 ; (bitmap_image + 0)
2e5a : 18 __ __ CLC
2e5b : 65 4e __ ADC T3 + 0 
2e5d : 85 0d __ STA P0 
2e5f : ad f9 3d LDA $3df9 ; (bitmap_image + 1)
2e62 : 65 4f __ ADC T3 + 1 
2e64 : 85 0e __ STA P1 
2e66 : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
.s25:
2e69 : a5 4b __ LDA T0 + 0 
2e6b : 85 01 __ STA $01 
2e6d : ad e6 cb LDA $cbe6 ; (head + 0)
2e70 : 18 __ __ CLC
2e71 : 65 4e __ ADC T3 + 0 
2e73 : 85 4e __ STA T3 + 0 
2e75 : ad e7 cb LDA $cbe7 ; (head + 1)
2e78 : 65 4f __ ADC T3 + 1 
2e7a : 85 4f __ STA T3 + 1 
2e7c : cd f1 cb CMP $cbf1 ; (bsize + 1)
2e7f : d0 05 __ BNE $2e86 ; (ui_room_gfx_update.s1005 + 0)
.s1004:
2e81 : a5 4e __ LDA T3 + 0 
2e83 : cd f0 cb CMP $cbf0 ; (bsize + 0)
.s1005:
2e86 : b0 03 __ BCS $2e8b ; (ui_room_gfx_update.s1005 + 5)
2e88 : 4c d4 2d JMP $2dd4 ; (ui_room_gfx_update.l21 + 0)
2e8b : 4c c9 2d JMP $2dc9 ; (ui_room_gfx_update.s22 + 0)
.s18:
2e8e : ad ca 3d LDA $3dca ; (video_colorram + 0)
2e91 : 65 4e __ ADC T3 + 0 
2e93 : 85 44 __ STA T5 + 0 
2e95 : ad cb 3d LDA $3dcb ; (video_colorram + 1)
2e98 : 65 4f __ ADC T3 + 1 
2e9a : 85 45 __ STA T5 + 1 
2e9c : ad ea cb LDA $cbea ; (head + 4)
2e9f : 18 __ __ CLC
2ea0 : 65 1b __ ADC ACCU + 0 
2ea2 : 85 46 __ STA T6 + 0 
2ea4 : ad eb cb LDA $cbeb ; (head + 5)
2ea7 : 65 1c __ ADC ACCU + 1 
2ea9 : 18 __ __ CLC
2eaa : 65 4d __ ADC T1 + 1 
2eac : 85 47 __ STA T6 + 1 
2eae : a4 4c __ LDY T1 + 0 
2eb0 : b1 46 __ LDA (T6 + 0),y 
2eb2 : aa __ __ TAX
2eb3 : 29 0f __ AND #$0f
2eb5 : a0 00 __ LDY #$00
2eb7 : 91 44 __ STA (T5 + 0),y 
2eb9 : 8a __ __ TXA
2eba : 29 f0 __ AND #$f0
2ebc : 4a __ __ LSR
2ebd : 4a __ __ LSR
2ebe : 4a __ __ LSR
2ebf : 4a __ __ LSR
2ec0 : c8 __ __ INY
2ec1 : 91 44 __ STA (T5 + 0),y 
2ec3 : e6 1b __ INC ACCU + 0 
2ec5 : d0 02 __ BNE $2ec9 ; (ui_room_gfx_update.s1015 + 0)
.s1014:
2ec7 : e6 1c __ INC ACCU + 1 
.s1015:
2ec9 : 18 __ __ CLC
2eca : a5 4e __ LDA T3 + 0 
2ecc : 69 02 __ ADC #$02
2ece : 85 4e __ STA T3 + 0 
2ed0 : 90 02 __ BCC $2ed4 ; (ui_room_gfx_update.s1017 + 0)
.s1016:
2ed2 : e6 4f __ INC T3 + 1 
.s1017:
2ed4 : a5 1c __ LDA ACCU + 1 
2ed6 : cd ed cb CMP $cbed ; (head + 7)
2ed9 : f0 03 __ BEQ $2ede ; (ui_room_gfx_update.s1017 + 10)
2edb : 4c a7 2d JMP $2da7 ; (ui_room_gfx_update.l1011 + 0)
2ede : 4c a2 2d JMP $2da2 ; (ui_room_gfx_update.s1010 + 0)
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
2ee1 : a5 0d __ LDA P0 
2ee3 : 05 0e __ ORA P1 
2ee5 : f0 08 __ BEQ $2eef ; (krnio_setnam.s0 + 14)
2ee7 : a0 ff __ LDY #$ff
2ee9 : c8 __ __ INY
2eea : b1 0d __ LDA (P0),y 
2eec : d0 fb __ BNE $2ee9 ; (krnio_setnam.s0 + 8)
2eee : 98 __ __ TYA
2eef : a6 0d __ LDX P0 
2ef1 : a4 0e __ LDY P1 
2ef3 : 20 bd ff JSR $ffbd 
.s1001:
2ef6 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_open: ; krnio_open(u8,u8,u8)->bool
.s0:
2ef7 : a9 00 __ LDA #$00
2ef9 : a6 0d __ LDX P0 ; (fnum + 0)
2efb : 9d 2a 3f STA $3f2a,x ; (krnio_pstatus + 0)
2efe : a9 00 __ LDA #$00
2f00 : 85 1b __ STA ACCU + 0 
2f02 : 85 1c __ STA ACCU + 1 
2f04 : a5 0d __ LDA P0 ; (fnum + 0)
2f06 : a6 0e __ LDX P1 
2f08 : a4 0f __ LDY P2 
2f0a : 20 ba ff JSR $ffba 
2f0d : 20 c0 ff JSR $ffc0 
2f10 : 90 08 __ BCC $2f1a ; (krnio_open.s0 + 35)
2f12 : a5 0d __ LDA P0 ; (fnum + 0)
2f14 : 20 c3 ff JSR $ffc3 
2f17 : 4c 1e 2f JMP $2f1e ; (krnio_open.s1001 + 0)
2f1a : a9 01 __ LDA #$01
2f1c : 85 1b __ STA ACCU + 0 
.s1001:
2f1e : a5 1b __ LDA ACCU + 0 
2f20 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_read: ; krnio_read(u8,u8*,i16)->i16
.s0:
2f21 : a6 0e __ LDX P1 ; (fnum + 0)
2f23 : bd 2a 3f LDA $3f2a,x ; (krnio_pstatus + 0)
2f26 : c9 40 __ CMP #$40
2f28 : d0 04 __ BNE $2f2e ; (krnio_read.s3 + 0)
.s1:
2f2a : a9 00 __ LDA #$00
2f2c : f0 0c __ BEQ $2f3a ; (krnio_read.s1010 + 0)
.s3:
2f2e : 86 43 __ STX T1 + 0 
2f30 : 8a __ __ TXA
2f31 : 20 9b 2f JSR $2f9b ; (krnio_chkin.s1000 + 0)
2f34 : 09 00 __ ORA #$00
2f36 : d0 07 __ BNE $2f3f ; (krnio_read.s5 + 0)
.s6:
2f38 : a9 ff __ LDA #$ff
.s1010:
2f3a : 85 1b __ STA ACCU + 0 
.s1001:
2f3c : 85 1c __ STA ACCU + 1 
2f3e : 60 __ __ RTS
.s5:
2f3f : a9 00 __ LDA #$00
2f41 : 85 44 __ STA T3 + 0 
2f43 : 85 45 __ STA T3 + 1 
2f45 : a5 12 __ LDA P5 ; (num + 1)
2f47 : 30 46 __ BMI $2f8f ; (krnio_read.s10 + 0)
.s1007:
2f49 : 05 11 __ ORA P4 ; (num + 0)
2f4b : f0 42 __ BEQ $2f8f ; (krnio_read.s10 + 0)
.l9:
2f4d : 20 af 2f JSR $2faf ; (krnio_chrin.s0 + 0)
2f50 : a5 1b __ LDA ACCU + 0 
2f52 : 85 46 __ STA T4 + 0 
2f54 : 20 b9 2f JSR $2fb9 ; (krnio_status.s0 + 0)
2f57 : aa __ __ TAX
2f58 : a4 43 __ LDY T1 + 0 
2f5a : 99 2a 3f STA $3f2a,y ; (krnio_pstatus + 0)
2f5d : 09 00 __ ORA #$00
2f5f : f0 04 __ BEQ $2f65 ; (krnio_read.s13 + 0)
.s14:
2f61 : c9 40 __ CMP #$40
2f63 : d0 2a __ BNE $2f8f ; (krnio_read.s10 + 0)
.s13:
2f65 : a5 44 __ LDA T3 + 0 
2f67 : 85 1b __ STA ACCU + 0 
2f69 : 18 __ __ CLC
2f6a : a5 10 __ LDA P3 ; (data + 1)
2f6c : 65 45 __ ADC T3 + 1 
2f6e : 85 1c __ STA ACCU + 1 
2f70 : a5 46 __ LDA T4 + 0 
2f72 : a4 0f __ LDY P2 ; (data + 0)
2f74 : 91 1b __ STA (ACCU + 0),y 
2f76 : e6 44 __ INC T3 + 0 
2f78 : d0 02 __ BNE $2f7c ; (krnio_read.s1012 + 0)
.s1011:
2f7a : e6 45 __ INC T3 + 1 
.s1012:
2f7c : 8a __ __ TXA
2f7d : d0 10 __ BNE $2f8f ; (krnio_read.s10 + 0)
.s8:
2f7f : 24 12 __ BIT P5 ; (num + 1)
2f81 : 30 0c __ BMI $2f8f ; (krnio_read.s10 + 0)
.s1004:
2f83 : a5 45 __ LDA T3 + 1 
2f85 : c5 12 __ CMP P5 ; (num + 1)
2f87 : d0 04 __ BNE $2f8d ; (krnio_read.s1003 + 0)
.s1002:
2f89 : a5 44 __ LDA T3 + 0 
2f8b : c5 11 __ CMP P4 ; (num + 0)
.s1003:
2f8d : 90 be __ BCC $2f4d ; (krnio_read.l9 + 0)
.s10:
2f8f : 20 c5 2f JSR $2fc5 ; (krnio_clrchn.s0 + 0)
2f92 : a5 44 __ LDA T3 + 0 
2f94 : 85 1b __ STA ACCU + 0 
2f96 : a5 45 __ LDA T3 + 1 
2f98 : 4c 3c 2f JMP $2f3c ; (krnio_read.s1001 + 0)
--------------------------------------------------------------------
krnio_chkin: ; krnio_chkin(u8)->bool
.s1000:
2f9b : 85 0d __ STA P0 
.s0:
2f9d : a6 0d __ LDX P0 
2f9f : 20 c6 ff JSR $ffc6 
2fa2 : a9 00 __ LDA #$00
2fa4 : 85 1c __ STA ACCU + 1 
2fa6 : b0 02 __ BCS $2faa ; (krnio_chkin.s0 + 13)
2fa8 : a9 01 __ LDA #$01
2faa : 85 1b __ STA ACCU + 0 
.s1001:
2fac : a5 1b __ LDA ACCU + 0 
2fae : 60 __ __ RTS
--------------------------------------------------------------------
krnio_chrin: ; krnio_chrin()->i16
.s0:
2faf : 20 cf ff JSR $ffcf 
2fb2 : 85 1b __ STA ACCU + 0 
2fb4 : a9 00 __ LDA #$00
2fb6 : 85 1c __ STA ACCU + 1 
.s1001:
2fb8 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_status: ; krnio_status()->enum krnioerr
.s0:
2fb9 : 20 b7 ff JSR $ffb7 
2fbc : 85 1b __ STA ACCU + 0 
2fbe : a9 00 __ LDA #$00
2fc0 : 85 1c __ STA ACCU + 1 
.s1001:
2fc2 : a5 1b __ LDA ACCU + 0 
2fc4 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_clrchn: ; krnio_clrchn()->void
.s0:
2fc5 : 20 cc ff JSR $ffcc 
.s1001:
2fc8 : 60 __ __ RTS
--------------------------------------------------------------------
ui_image_fade: ; ui_image_fade()->void
.s0:
2fc9 : a9 08 __ LDA #$08
2fcb : 85 43 __ STA T0 + 0 
2fcd : a9 f2 __ LDA #$f2
2fcf : 85 44 __ STA T0 + 1 
2fd1 : ad ca 3d LDA $3dca ; (video_colorram + 0)
2fd4 : 18 __ __ CLC
2fd5 : 69 08 __ ADC #$08
2fd7 : 85 45 __ STA T1 + 0 
2fd9 : ad cb 3d LDA $3dcb ; (video_colorram + 1)
2fdc : 69 02 __ ADC #$02
2fde : 85 46 __ STA T1 + 1 
2fe0 : a9 0c __ LDA #$0c
2fe2 : 85 47 __ STA T2 + 0 
.l5:
2fe4 : 2c 11 d0 BIT $d011 
2fe7 : 10 fb __ BPL $2fe4 ; (ui_image_fade.l5 + 0)
.s4:
2fe9 : a5 43 __ LDA T0 + 0 
2feb : 85 0d __ STA P0 
2fed : a5 44 __ LDA T0 + 1 
2fef : 85 0e __ STA P1 
2ff1 : a9 00 __ LDA #$00
2ff3 : 85 0f __ STA P2 
2ff5 : 85 10 __ STA P3 
2ff7 : 85 12 __ STA P5 
2ff9 : a9 28 __ LDA #$28
2ffb : 85 11 __ STA P4 
2ffd : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
3000 : a5 45 __ LDA T1 + 0 
3002 : 85 0d __ STA P0 
3004 : a5 46 __ LDA T1 + 1 
3006 : 85 0e __ STA P1 
3008 : a9 00 __ LDA #$00
300a : 85 0f __ STA P2 
300c : 85 10 __ STA P3 
300e : 85 12 __ STA P5 
3010 : a9 28 __ LDA #$28
3012 : 85 11 __ STA P4 
3014 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
3017 : 18 __ __ CLC
3018 : a5 43 __ LDA T0 + 0 
301a : 69 d8 __ ADC #$d8
301c : 85 43 __ STA T0 + 0 
301e : b0 02 __ BCS $3022 ; (ui_image_fade.s1003 + 0)
.s1002:
3020 : c6 44 __ DEC T0 + 1 
.s1003:
3022 : 18 __ __ CLC
3023 : a5 45 __ LDA T1 + 0 
3025 : 69 d8 __ ADC #$d8
3027 : 85 45 __ STA T1 + 0 
3029 : b0 02 __ BCS $302d ; (ui_image_fade.s1005 + 0)
.s1004:
302b : c6 46 __ DEC T1 + 1 
.s1005:
302d : a6 47 __ LDX T2 + 0 
302f : c6 47 __ DEC T2 + 0 
3031 : 8a __ __ TXA
3032 : d0 b0 __ BNE $2fe4 ; (ui_image_fade.l5 + 0)
.s3:
3034 : 85 0f __ STA P2 
3036 : 85 10 __ STA P3 
3038 : 85 11 __ STA P4 
303a : a9 0f __ LDA #$0f
303c : 85 12 __ STA P5 
303e : ad f8 3d LDA $3df8 ; (bitmap_image + 0)
3041 : 85 0d __ STA P0 
3043 : ad f9 3d LDA $3df9 ; (bitmap_image + 1)
3046 : 85 0e __ STA P1 
3048 : 4c 04 0d JMP $0d04 ; (memset.s0 + 0)
--------------------------------------------------------------------
krnio_close: ; krnio_close(u8)->void
.s1000:
304b : 85 0d __ STA P0 
.s0:
304d : a5 0d __ LDA P0 
304f : 20 c3 ff JSR $ffc3 
.s1001:
3052 : 60 __ __ RTS
--------------------------------------------------------------------
status_update: ; status_update()->void
.s0:
3053 : ad 66 3e LDA $3e66 ; (roomnameid + 0)
3056 : 85 46 __ STA T2 + 0 
3058 : ad 67 3e LDA $3e67 ; (roomnameid + 1)
305b : 85 47 __ STA T2 + 1 
305d : ac dd 3d LDY $3ddd ; (room + 0)
3060 : b1 46 __ LDA (T2 + 0),y 
3062 : 8d a2 3e STA $3ea2 ; (strid + 0)
3065 : c9 ff __ CMP #$ff
3067 : d0 03 __ BNE $306c ; (status_update.s1 + 0)
3069 : 4c f5 30 JMP $30f5 ; (status_update.s2 + 0)
.s1:
306c : ad 4a 3e LDA $3e4a ; (advnames + 0)
306f : 8d 9f 3e STA $3e9f ; (str + 0)
3072 : ad 4b 3e LDA $3e4b ; (advnames + 1)
3075 : 8d a0 3e STA $3ea0 ; (str + 1)
3078 : 20 be 23 JSR $23be ; (_getstring.s0 + 0)
307b : a9 07 __ LDA #$07
307d : 85 0f __ STA P2 
307f : a9 00 __ LDA #$00
3081 : 85 10 __ STA P3 
3083 : 85 12 __ STA P5 
3085 : a9 28 __ LDA #$28
3087 : 85 11 __ STA P4 
3089 : ad a8 3e LDA $3ea8 ; (ostr + 0)
308c : 8d a3 3e STA $3ea3 ; (txt + 0)
308f : ad a9 3e LDA $3ea9 ; (ostr + 1)
3092 : 8d a4 3e STA $3ea4 ; (txt + 1)
3095 : ad ca 3d LDA $3dca ; (video_colorram + 0)
3098 : 18 __ __ CLC
3099 : 69 08 __ ADC #$08
309b : 85 0d __ STA P0 
309d : ad cb 3d LDA $3dcb ; (video_colorram + 1)
30a0 : 69 02 __ ADC #$02
30a2 : 85 0e __ STA P1 
30a4 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
30a7 : a9 a0 __ LDA #$a0
30a9 : 85 0f __ STA P2 
30ab : a9 00 __ LDA #$00
30ad : 85 10 __ STA P3 
30af : 85 12 __ STA P5 
30b1 : a9 28 __ LDA #$28
30b3 : 85 11 __ STA P4 
30b5 : ad c8 3d LDA $3dc8 ; (video_ram + 0)
30b8 : 18 __ __ CLC
30b9 : 69 08 __ ADC #$08
30bb : 85 0d __ STA P0 
30bd : ad c9 3d LDA $3dc9 ; (video_ram + 1)
30c0 : 69 02 __ ADC #$02
30c2 : 85 0e __ STA P1 
30c4 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
30c7 : a9 00 __ LDA #$00
30c9 : 8d 89 3e STA $3e89 ; (al + 0)
30cc : 8d b0 3e STA $3eb0 ; (txt_x + 0)
30cf : a9 07 __ LDA #$07
30d1 : 8d ad 3e STA $3ead ; (txt_col + 0)
30d4 : a9 80 __ LDA #$80
30d6 : 8d af 3e STA $3eaf ; (txt_rev + 0)
30d9 : a9 0d __ LDA #$0d
30db : 8d b1 3e STA $3eb1 ; (txt_y + 0)
30de : 20 17 25 JSR $2517 ; (core_drawtext.l138 + 0)
30e1 : ad 80 3e LDA $3e80 ; (vars + 0)
30e4 : 85 44 __ STA T1 + 0 
30e6 : ad 81 3e LDA $3e81 ; (vars + 1)
30e9 : 85 45 __ STA T1 + 1 
30eb : a0 01 __ LDY #$01
30ed : b1 44 __ LDA (T1 + 0),y 
30ef : d0 01 __ BNE $30f2 ; (status_update.s4 + 0)
.s1001:
30f1 : 60 __ __ RTS
.s4:
30f2 : 4c 1d 31 JMP $311d ; (core_drawscore.s0 + 0)
.s2:
30f5 : a9 00 __ LDA #$00
30f7 : 85 0f __ STA P2 
30f9 : 85 10 __ STA P3 
30fb : 85 12 __ STA P5 
30fd : a9 28 __ LDA #$28
30ff : 85 11 __ STA P4 
3101 : a9 c4 __ LDA #$c4
3103 : 8d a3 3e STA $3ea3 ; (txt + 0)
3106 : a9 31 __ LDA #$31
3108 : 8d a4 3e STA $3ea4 ; (txt + 1)
310b : ad ca 3d LDA $3dca ; (video_colorram + 0)
310e : 18 __ __ CLC
310f : 69 08 __ ADC #$08
3111 : 85 0d __ STA P0 
3113 : ad cb 3d LDA $3dcb ; (video_colorram + 1)
3116 : 69 02 __ ADC #$02
3118 : 85 0e __ STA P1 
311a : 4c 04 0d JMP $0d04 ; (memset.s0 + 0)
--------------------------------------------------------------------
core_drawscore: ; core_drawscore()->void
.s0:
311d : ad 80 3e LDA $3e80 ; (vars + 0)
3120 : 85 43 __ STA T0 + 0 
3122 : ad 81 3e LDA $3e81 ; (vars + 1)
3125 : 85 44 __ STA T0 + 1 
3127 : a0 00 __ LDY #$00
3129 : 84 45 __ STY T1 + 0 
312b : 84 0e __ STY P1 
312d : b1 43 __ LDA (T0 + 0),y 
312f : 85 0d __ STA P0 
3131 : ad 84 3e LDA $3e84 ; (tmp + 0)
3134 : 85 43 __ STA T0 + 0 
3136 : 85 0f __ STA P2 
3138 : ad 85 3e LDA $3e85 ; (tmp + 1)
313b : 85 44 __ STA T0 + 1 
313d : 85 10 __ STA P3 
313f : 20 e7 2b JSR $2be7 ; (mini_itoa.s0 + 0)
.l1:
3142 : a4 45 __ LDY T1 + 0 
3144 : e6 45 __ INC T1 + 0 
3146 : b1 43 __ LDA (T0 + 0),y 
3148 : d0 f8 __ BNE $3142 ; (core_drawscore.l1 + 0)
.s3:
314a : a9 2f __ LDA #$2f
314c : 91 43 __ STA (T0 + 0),y 
314e : 18 __ __ CLC
314f : a5 43 __ LDA T0 + 0 
3151 : 65 45 __ ADC T1 + 0 
3153 : 85 0f __ STA P2 
3155 : a5 44 __ LDA T0 + 1 
3157 : 69 00 __ ADC #$00
3159 : 85 10 __ STA P3 
315b : ad 80 3e LDA $3e80 ; (vars + 0)
315e : 85 43 __ STA T0 + 0 
3160 : ad 81 3e LDA $3e81 ; (vars + 1)
3163 : 85 44 __ STA T0 + 1 
3165 : a0 01 __ LDY #$01
3167 : b1 43 __ LDA (T0 + 0),y 
3169 : 85 0d __ STA P0 
316b : a9 00 __ LDA #$00
316d : 85 0e __ STA P1 
316f : 20 e7 2b JSR $2be7 ; (mini_itoa.s0 + 0)
3172 : ad 84 3e LDA $3e84 ; (tmp + 0)
3175 : 85 43 __ STA T0 + 0 
3177 : ad 85 3e LDA $3e85 ; (tmp + 1)
317a : 85 44 __ STA T0 + 1 
317c : a4 45 __ LDY T1 + 0 
317e : b1 43 __ LDA (T0 + 0),y 
3180 : f0 05 __ BEQ $3187 ; (core_drawscore.s6 + 0)
.l5:
3182 : c8 __ __ INY
3183 : b1 43 __ LDA (T0 + 0),y 
3185 : d0 fb __ BNE $3182 ; (core_drawscore.l5 + 0)
.s6:
3187 : 84 45 __ STY T1 + 0 
3189 : 38 __ __ SEC
318a : e5 45 __ SBC T1 + 0 
318c : 85 43 __ STA T0 + 0 
318e : a9 00 __ LDA #$00
3190 : e9 00 __ SBC #$00
3192 : aa __ __ TAX
3193 : ad c8 3d LDA $3dc8 ; (video_ram + 0)
3196 : 18 __ __ CLC
3197 : 69 30 __ ADC #$30
3199 : a8 __ __ TAY
319a : ad c9 3d LDA $3dc9 ; (video_ram + 1)
319d : 69 02 __ ADC #$02
319f : 85 1c __ STA ACCU + 1 
31a1 : 98 __ __ TYA
31a2 : 18 __ __ CLC
31a3 : 65 43 __ ADC T0 + 0 
31a5 : 85 43 __ STA T0 + 0 
31a7 : 8a __ __ TXA
31a8 : 65 1c __ ADC ACCU + 1 
31aa : 85 44 __ STA T0 + 1 
31ac : a0 00 __ LDY #$00
31ae : f0 05 __ BEQ $31b5 ; (core_drawscore.l7 + 0)
.s8:
31b0 : 09 80 __ ORA #$80
31b2 : 91 43 __ STA (T0 + 0),y 
31b4 : c8 __ __ INY
.l7:
31b5 : ad 84 3e LDA $3e84 ; (tmp + 0)
31b8 : 85 1b __ STA ACCU + 0 
31ba : ad 85 3e LDA $3e85 ; (tmp + 1)
31bd : 85 1c __ STA ACCU + 1 
31bf : b1 1b __ LDA (ACCU + 0),y 
31c1 : d0 ed __ BNE $31b0 ; (core_drawscore.s8 + 0)
.s1001:
31c3 : 60 __ __ RTS
--------------------------------------------------------------------
31c4 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
os_roomimage_load: ; os_roomimage_load()->void
.s0:
31c5 : ad ec 3d LDA $3dec ; (slowmode + 0)
31c8 : c9 02 __ CMP #$02
31ca : f0 3a __ BEQ $3206 ; (os_roomimage_load.s1 + 0)
.s3:
31cc : ad 6a 3e LDA $3e6a ; (roomimg + 0)
31cf : 85 47 __ STA T4 + 0 
31d1 : ad 6b 3e LDA $3e6b ; (roomimg + 1)
31d4 : 85 48 __ STA T4 + 1 
31d6 : ac dd 3d LDY $3ddd ; (room + 0)
31d9 : b1 47 __ LDA (T4 + 0),y 
31db : 85 50 __ STA T2 + 0 
31dd : cd fb 3d CMP $3dfb ; (curimageid + 0)
31e0 : f0 1b __ BEQ $31fd ; (os_roomimage_load.s5 + 0)
.s4:
31e2 : ad ec 3d LDA $3dec ; (slowmode + 0)
31e5 : 85 13 __ STA P6 
31e7 : 20 2c 2b JSR $2b2c ; (irq_detach.l30 + 0)
31ea : a5 50 __ LDA T2 + 0 
31ec : 8d f4 3e STA $3ef4 ; (imageid + 0)
31ef : 20 74 2c JSR $2c74 ; (ui_room_update.l27 + 0)
31f2 : 20 df 2b JSR $2bdf ; (irq_attach.l27 + 0)
31f5 : a5 50 __ LDA T2 + 0 
31f7 : 8d fb 3d STA $3dfb ; (curimageid + 0)
31fa : 4c 00 32 JMP $3200 ; (os_roomimage_load.l35 + 0)
.s5:
31fd : 20 53 30 JSR $3053 ; (status_update.s0 + 0)
.l35:
3200 : 2c 11 d0 BIT $d011 
3203 : 10 fb __ BPL $3200 ; (os_roomimage_load.l35 + 0)
.s1001:
3205 : 60 __ __ RTS
.s1:
3206 : ad fb 3d LDA $3dfb ; (curimageid + 0)
3209 : f0 f2 __ BEQ $31fd ; (os_roomimage_load.s5 + 0)
.s25:
320b : a9 00 __ LDA #$00
320d : 85 50 __ STA T2 + 0 
320f : f0 d1 __ BEQ $31e2 ; (os_roomimage_load.s4 + 0)
--------------------------------------------------------------------
draw_roomobj: ; draw_roomobj()->void
.s0:
3211 : ad 42 3e LDA $3e42 ; (tmp2 + 0)
3214 : 8d a3 3e STA $3ea3 ; (txt + 0)
3217 : ad 43 3e LDA $3e43 ; (tmp2 + 1)
321a : 8d a4 3e STA $3ea4 ; (txt + 1)
321d : a9 00 __ LDA #$00
321f : 8d 89 3e STA $3e89 ; (al + 0)
3222 : 85 4f __ STA T1 + 0 
3224 : ad 47 3e LDA $3e47 ; (obj_count + 0)
3227 : d0 03 __ BNE $322c ; (draw_roomobj.s24 + 0)
3229 : 4c 1d 33 JMP $331d ; (draw_roomobj.s4 + 0)
.s24:
322c : a9 00 __ LDA #$00
322e : 85 50 __ STA T2 + 0 
3230 : ad 74 3e LDA $3e74 ; (objloc + 0)
3233 : 85 4d __ STA T0 + 0 
3235 : ad 75 3e LDA $3e75 ; (objloc + 1)
3238 : 85 4e __ STA T0 + 1 
323a : ad 8e 3e LDA $3e8e ; (varroom + 0)
323d : 85 51 __ STA T3 + 0 
.l2:
323f : a5 51 __ LDA T3 + 0 
3241 : a4 50 __ LDY T2 + 0 
3243 : d1 4d __ CMP (T0 + 0),y 
3245 : f0 03 __ BEQ $324a ; (draw_roomobj.s5 + 0)
3247 : 4c 11 33 JMP $3311 ; (draw_roomobj.s3 + 0)
.s5:
324a : ad 72 3e LDA $3e72 ; (objattr + 0)
324d : 85 45 __ STA T5 + 0 
324f : ad 73 3e LDA $3e73 ; (objattr + 1)
3252 : 85 46 __ STA T5 + 1 
3254 : ad a5 3e LDA $3ea5 ; (varattr + 0)
3257 : 31 45 __ AND (T5 + 0),y 
3259 : cd a5 3e CMP $3ea5 ; (varattr + 0)
325c : f0 03 __ BEQ $3261 ; (draw_roomobj.s8 + 0)
325e : 4c 11 33 JMP $3311 ; (draw_roomobj.s3 + 0)
.s8:
3261 : ad 6e 3e LDA $3e6e ; (objnameid + 0)
3264 : 85 45 __ STA T5 + 0 
3266 : ad 6f 3e LDA $3e6f ; (objnameid + 1)
3269 : 85 46 __ STA T5 + 1 
326b : b1 45 __ LDA (T5 + 0),y 
326d : 8d a2 3e STA $3ea2 ; (strid + 0)
3270 : c9 ff __ CMP #$ff
3272 : d0 03 __ BNE $3277 ; (draw_roomobj.s12 + 0)
3274 : 4c 11 33 JMP $3311 ; (draw_roomobj.s3 + 0)
.s12:
3277 : ad 4a 3e LDA $3e4a ; (advnames + 0)
327a : 8d 9f 3e STA $3e9f ; (str + 0)
327d : ad 4b 3e LDA $3e4b ; (advnames + 1)
3280 : 8d a0 3e STA $3ea0 ; (str + 1)
3283 : 20 be 23 JSR $23be ; (_getstring.s0 + 0)
3286 : a9 01 __ LDA #$01
3288 : 8d ad 3e STA $3ead ; (txt_col + 0)
328b : ad a8 3e LDA $3ea8 ; (ostr + 0)
328e : 85 43 __ STA T4 + 0 
3290 : ad a9 3e LDA $3ea9 ; (ostr + 1)
3293 : 85 44 __ STA T4 + 1 
3295 : ad ab 3e LDA $3eab ; (etxt + 0)
3298 : 85 45 __ STA T5 + 0 
329a : ad ac 3e LDA $3eac ; (etxt + 1)
329d : 85 46 __ STA T5 + 1 
329f : a5 4f __ LDA T1 + 0 
32a1 : f0 17 __ BEQ $32ba ; (draw_roomobj.s17 + 0)
.s14:
32a3 : ad a3 3e LDA $3ea3 ; (txt + 0)
32a6 : 85 49 __ STA T8 + 0 
32a8 : ad a4 3e LDA $3ea4 ; (txt + 1)
32ab : 85 4a __ STA T8 + 1 
32ad : a9 2c __ LDA #$2c
32af : a0 00 __ LDY #$00
32b1 : 91 49 __ STA (T8 + 0),y 
32b3 : a9 20 __ LDA #$20
32b5 : c8 __ __ INY
32b6 : 91 49 __ STA (T8 + 0),y 
32b8 : a9 02 __ LDA #$02
.s17:
32ba : 85 47 __ STA T6 + 0 
32bc : a5 44 __ LDA T4 + 1 
32be : c5 46 __ CMP T5 + 1 
32c0 : d0 04 __ BNE $32c6 ; (draw_roomobj.s1007 + 0)
.s1006:
32c2 : a5 43 __ LDA T4 + 0 
32c4 : c5 45 __ CMP T5 + 0 
.s1007:
32c6 : b0 30 __ BCS $32f8 ; (draw_roomobj.s19 + 0)
.s23:
32c8 : ad a3 3e LDA $3ea3 ; (txt + 0)
32cb : 85 49 __ STA T8 + 0 
32cd : ad a4 3e LDA $3ea4 ; (txt + 1)
32d0 : 85 4a __ STA T8 + 1 
.l18:
32d2 : a0 00 __ LDY #$00
32d4 : b1 43 __ LDA (T4 + 0),y 
32d6 : a4 47 __ LDY T6 + 0 
32d8 : 91 49 __ STA (T8 + 0),y 
32da : e6 47 __ INC T6 + 0 
32dc : e6 43 __ INC T4 + 0 
32de : d0 02 __ BNE $32e2 ; (draw_roomobj.s1015 + 0)
.s1014:
32e0 : e6 44 __ INC T4 + 1 
.s1015:
32e2 : a5 44 __ LDA T4 + 1 
32e4 : c5 46 __ CMP T5 + 1 
32e6 : d0 04 __ BNE $32ec ; (draw_roomobj.s1005 + 0)
.s1004:
32e8 : a5 43 __ LDA T4 + 0 
32ea : c5 45 __ CMP T5 + 0 
.s1005:
32ec : 90 e4 __ BCC $32d2 ; (draw_roomobj.l18 + 0)
.s26:
32ee : a5 43 __ LDA T4 + 0 
32f0 : 8d a8 3e STA $3ea8 ; (ostr + 0)
32f3 : a5 44 __ LDA T4 + 1 
32f5 : 8d a9 3e STA $3ea9 ; (ostr + 1)
.s19:
32f8 : ad a3 3e LDA $3ea3 ; (txt + 0)
32fb : 18 __ __ CLC
32fc : 65 47 __ ADC T6 + 0 
32fe : 85 43 __ STA T4 + 0 
3300 : ad a4 3e LDA $3ea4 ; (txt + 1)
3303 : 69 00 __ ADC #$00
3305 : 85 44 __ STA T4 + 1 
3307 : a9 00 __ LDA #$00
3309 : a8 __ __ TAY
330a : 91 43 __ STA (T4 + 0),y 
330c : 20 17 25 JSR $2517 ; (core_drawtext.l138 + 0)
330f : e6 4f __ INC T1 + 0 
.s3:
3311 : e6 50 __ INC T2 + 0 
3313 : a5 50 __ LDA T2 + 0 
3315 : cd 47 3e CMP $3e47 ; (obj_count + 0)
3318 : b0 03 __ BCS $331d ; (draw_roomobj.s4 + 0)
331a : 4c 3f 32 JMP $323f ; (draw_roomobj.l2 + 0)
.s4:
331d : a5 4f __ LDA T1 + 0 
331f : f0 2d __ BEQ $334e ; (draw_roomobj.s1001 + 0)
.s21:
3321 : a9 01 __ LDA #$01
3323 : 8d ad 3e STA $3ead ; (txt_col + 0)
3326 : ad a3 3e LDA $3ea3 ; (txt + 0)
3329 : 85 4d __ STA T0 + 0 
332b : ad a4 3e LDA $3ea4 ; (txt + 1)
332e : 85 4e __ STA T0 + 1 
3330 : a9 2e __ LDA #$2e
3332 : a0 00 __ LDY #$00
3334 : 91 4d __ STA (T0 + 0),y 
3336 : 98 __ __ TYA
3337 : c8 __ __ INY
3338 : 91 4d __ STA (T0 + 0),y 
333a : 20 17 25 JSR $2517 ; (core_drawtext.l138 + 0)
333d : a9 00 __ LDA #$00
333f : 8d ae 3e STA $3eae ; (text_attach + 0)
3342 : ad b1 3e LDA $3eb1 ; (txt_y + 0)
3345 : 38 __ __ SEC
3346 : e9 0e __ SBC #$0e
3348 : 8d dc 3d STA $3ddc ; (text_y + 0)
334b : 4c 59 2a JMP $2a59 ; (cr.l30 + 0)
.s1001:
334e : 60 __ __ RTS
--------------------------------------------------------------------
parser_update: ; parser_update()->void
.s0:
334f : a9 00 __ LDA #$00
3351 : 8d 89 3e STA $3e89 ; (al + 0)
3354 : 8d af 3e STA $3eaf ; (txt_rev + 0)
3357 : a9 01 __ LDA #$01
3359 : 8d b0 3e STA $3eb0 ; (txt_x + 0)
335c : ad dc 3d LDA $3ddc ; (text_y + 0)
335f : 18 __ __ CLC
3360 : 69 0e __ ADC #$0e
3362 : 8d b1 3e STA $3eb1 ; (txt_y + 0)
3365 : 0a __ __ ASL
3366 : 85 1b __ STA ACCU + 0 
3368 : a9 00 __ LDA #$00
336a : 2a __ __ ROL
336b : 06 1b __ ASL ACCU + 0 
336d : 2a __ __ ROL
336e : aa __ __ TAX
336f : a5 1b __ LDA ACCU + 0 
3371 : 6d b1 3e ADC $3eb1 ; (txt_y + 0)
3374 : 85 44 __ STA T1 + 0 
3376 : 8a __ __ TXA
3377 : 69 00 __ ADC #$00
3379 : 06 44 __ ASL T1 + 0 
337b : 2a __ __ ROL
337c : 06 44 __ ASL T1 + 0 
337e : 2a __ __ ROL
337f : 06 44 __ ASL T1 + 0 
3381 : 2a __ __ ROL
3382 : 85 45 __ STA T1 + 1 
3384 : ad ca 3d LDA $3dca ; (video_colorram + 0)
3387 : 85 4d __ STA T2 + 0 
3389 : 18 __ __ CLC
338a : 65 44 __ ADC T1 + 0 
338c : 85 4f __ STA T3 + 0 
338e : ad cb 3d LDA $3dcb ; (video_colorram + 1)
3391 : 85 4e __ STA T2 + 1 
3393 : 65 45 __ ADC T1 + 1 
3395 : 85 50 __ STA T3 + 1 
3397 : a9 0c __ LDA #$0c
3399 : 8d ad 3e STA $3ead ; (txt_col + 0)
339c : a0 00 __ LDY #$00
339e : 91 4f __ STA (T3 + 0),y 
33a0 : ad c8 3d LDA $3dc8 ; (video_ram + 0)
33a3 : 85 4f __ STA T3 + 0 
33a5 : 18 __ __ CLC
33a6 : 65 44 __ ADC T1 + 0 
33a8 : 85 44 __ STA T1 + 0 
33aa : ad c9 3d LDA $3dc9 ; (video_ram + 1)
33ad : 85 50 __ STA T3 + 1 
33af : 65 45 __ ADC T1 + 1 
33b1 : 85 45 __ STA T1 + 1 
33b3 : a9 3e __ LDA #$3e
33b5 : 91 44 __ STA (T1 + 0),y 
33b7 : ad da 3d LDA $3dda ; (strcmd + 0)
33ba : 8d a3 3e STA $3ea3 ; (txt + 0)
33bd : ad db 3d LDA $3ddb ; (strcmd + 1)
33c0 : 8d a4 3e STA $3ea4 ; (txt + 1)
33c3 : 20 17 25 JSR $2517 ; (core_drawtext.l138 + 0)
33c6 : ad b1 3e LDA $3eb1 ; (txt_y + 0)
33c9 : 0a __ __ ASL
33ca : 85 1b __ STA ACCU + 0 
33cc : a9 00 __ LDA #$00
33ce : 8d 89 3e STA $3e89 ; (al + 0)
33d1 : 2a __ __ ROL
33d2 : 06 1b __ ASL ACCU + 0 
33d4 : 2a __ __ ROL
33d5 : aa __ __ TAX
33d6 : a5 1b __ LDA ACCU + 0 
33d8 : 6d b1 3e ADC $3eb1 ; (txt_y + 0)
33db : 85 44 __ STA T1 + 0 
33dd : 8a __ __ TXA
33de : 69 00 __ ADC #$00
33e0 : 06 44 __ ASL T1 + 0 
33e2 : 2a __ __ ROL
33e3 : 06 44 __ ASL T1 + 0 
33e5 : 2a __ __ ROL
33e6 : 06 44 __ ASL T1 + 0 
33e8 : 2a __ __ ROL
33e9 : aa __ __ TAX
33ea : ad b0 3e LDA $3eb0 ; (txt_x + 0)
33ed : 18 __ __ CLC
33ee : 65 44 __ ADC T1 + 0 
33f0 : 85 44 __ STA T1 + 0 
33f2 : 90 01 __ BCC $33f5 ; (parser_update.s1003 + 0)
.s1002:
33f4 : e8 __ __ INX
.s1003:
33f5 : 8a __ __ TXA
33f6 : 18 __ __ CLC
33f7 : 65 4e __ ADC T2 + 1 
33f9 : 85 4e __ STA T2 + 1 
33fb : a9 00 __ LDA #$00
33fd : a4 44 __ LDY T1 + 0 
33ff : 91 4d __ STA (T2 + 0),y 
3401 : 8a __ __ TXA
3402 : 18 __ __ CLC
3403 : 65 50 __ ADC T3 + 1 
3405 : 85 45 __ STA T1 + 1 
3407 : a9 20 __ LDA #$20
3409 : a4 4f __ LDY T3 + 0 
340b : 91 44 __ STA (T1 + 0),y 
.l27:
340d : 2c 11 d0 BIT $d011 
3410 : 10 fb __ BPL $340d ; (parser_update.l27 + 0)
.s1001:
3412 : 60 __ __ RTS
--------------------------------------------------------------------
hide_blink: ; hide_blink()->void
.s0:
3413 : ad b1 3e LDA $3eb1 ; (txt_y + 0)
3416 : 0a __ __ ASL
3417 : 85 1b __ STA ACCU + 0 
3419 : a9 00 __ LDA #$00
341b : 2a __ __ ROL
341c : 06 1b __ ASL ACCU + 0 
341e : 2a __ __ ROL
341f : aa __ __ TAX
3420 : a5 1b __ LDA ACCU + 0 
3422 : 6d b1 3e ADC $3eb1 ; (txt_y + 0)
3425 : 85 1b __ STA ACCU + 0 
3427 : 8a __ __ TXA
3428 : 69 00 __ ADC #$00
342a : 06 1b __ ASL ACCU + 0 
342c : 2a __ __ ROL
342d : 06 1b __ ASL ACCU + 0 
342f : 2a __ __ ROL
3430 : 06 1b __ ASL ACCU + 0 
3432 : 2a __ __ ROL
3433 : aa __ __ TAX
3434 : ad b0 3e LDA $3eb0 ; (txt_x + 0)
3437 : 18 __ __ CLC
3438 : 65 1b __ ADC ACCU + 0 
343a : 90 01 __ BCC $343d ; (hide_blink.s1003 + 0)
.s1002:
343c : e8 __ __ INX
.s1003:
343d : 18 __ __ CLC
343e : 6d ca 3d ADC $3dca ; (video_colorram + 0)
3441 : 85 1b __ STA ACCU + 0 
3443 : 8a __ __ TXA
3444 : 6d cb 3d ADC $3dcb ; (video_colorram + 1)
3447 : 85 1c __ STA ACCU + 1 
3449 : a9 00 __ LDA #$00
344b : a8 __ __ TAY
344c : 91 1b __ STA (ACCU + 0),y 
.s1001:
344e : 60 __ __ RTS
--------------------------------------------------------------------
execute: ; execute()->void
.s1000:
344f : a5 53 __ LDA T0 + 0 
3451 : 8d d3 cb STA $cbd3 ; (execute@stack + 0)
3454 : a5 54 __ LDA T0 + 1 
3456 : 8d d4 cb STA $cbd4 ; (execute@stack + 1)
.s0:
3459 : 20 59 2a JSR $2a59 ; (cr.l30 + 0)
345c : ad da 3d LDA $3dda ; (strcmd + 0)
345f : 85 53 __ STA T0 + 0 
3461 : 8d 9f 3e STA $3e9f ; (str + 0)
3464 : ad db 3d LDA $3ddb ; (strcmd + 1)
3467 : 85 54 __ STA T0 + 1 
3469 : 8d a0 3e STA $3ea0 ; (str + 1)
346c : 20 85 34 JSR $3485 ; (adv_parse.s1000 + 0)
346f : a9 00 __ LDA #$00
3471 : 8d fc 3d STA $3dfc ; (icmd + 0)
3474 : a8 __ __ TAY
3475 : 91 53 __ STA (T0 + 0),y 
3477 : 20 4f 33 JSR $334f ; (parser_update.s0 + 0)
.s1001:
347a : ad d3 cb LDA $cbd3 ; (execute@stack + 0)
347d : 85 53 __ STA T0 + 0 
347f : ad d4 cb LDA $cbd4 ; (execute@stack + 1)
3482 : 85 54 __ STA T0 + 1 
3484 : 60 __ __ RTS
--------------------------------------------------------------------
adv_parse: ; adv_parse()->void
.s1000:
3485 : a5 53 __ LDA T1 + 0 
3487 : 8d d5 cb STA $cbd5 ; (adv_parse@stack + 0)
348a : a5 54 __ LDA T3 + 0 
348c : 8d d6 cb STA $cbd6 ; (adv_parse@stack + 1)
.s0:
348f : a9 ff __ LDA #$ff
3491 : 8d 8b 3e STA $3e8b ; (cmd + 0)
3494 : a9 f9 __ LDA #$f9
3496 : 8d 9d 3e STA $3e9d ; (obj2 + 0)
3499 : 8d 8c 3e STA $3e8c ; (obj1 + 0)
349c : a9 00 __ LDA #$00
349e : 8d f6 3e STA $3ef6 ; (obj2k + 0)
34a1 : 8d f5 3e STA $3ef5 ; (obj1k + 0)
34a4 : ad 9f 3e LDA $3e9f ; (str + 0)
34a7 : 85 1b __ STA ACCU + 0 
34a9 : 8d a8 3e STA $3ea8 ; (ostr + 0)
34ac : ad a0 3e LDA $3ea0 ; (str + 1)
34af : 85 1c __ STA ACCU + 1 
34b1 : 8d a9 3e STA $3ea9 ; (ostr + 1)
34b4 : a0 00 __ LDY #$00
34b6 : b1 1b __ LDA (ACCU + 0),y 
34b8 : f0 26 __ BEQ $34e0 ; (adv_parse.s3 + 0)
.l4:
34ba : ad a8 3e LDA $3ea8 ; (ostr + 0)
34bd : 85 1b __ STA ACCU + 0 
34bf : ad a9 3e LDA $3ea9 ; (ostr + 1)
34c2 : 85 1c __ STA ACCU + 1 
34c4 : a0 00 __ LDY #$00
34c6 : b1 1b __ LDA (ACCU + 0),y 
34c8 : c9 20 __ CMP #$20
34ca : d0 14 __ BNE $34e0 ; (adv_parse.s3 + 0)
.s2:
34cc : 18 __ __ CLC
34cd : a5 1b __ LDA ACCU + 0 
34cf : 69 01 __ ADC #$01
34d1 : 8d a8 3e STA $3ea8 ; (ostr + 0)
34d4 : a5 1c __ LDA ACCU + 1 
34d6 : 69 00 __ ADC #$00
34d8 : 8d a9 3e STA $3ea9 ; (ostr + 1)
34db : c8 __ __ INY
34dc : b1 1b __ LDA (ACCU + 0),y 
34de : d0 da __ BNE $34ba ; (adv_parse.l4 + 0)
.s3:
34e0 : ad a8 3e LDA $3ea8 ; (ostr + 0)
34e3 : 85 1b __ STA ACCU + 0 
34e5 : ad a9 3e LDA $3ea9 ; (ostr + 1)
34e8 : 85 1c __ STA ACCU + 1 
34ea : a0 00 __ LDY #$00
34ec : b1 1b __ LDA (ACCU + 0),y 
34ee : f0 35 __ BEQ $3525 ; (adv_parse.s1001 + 0)
.l8:
34f0 : ad a8 3e LDA $3ea8 ; (ostr + 0)
34f3 : 85 1b __ STA ACCU + 0 
34f5 : ad a9 3e LDA $3ea9 ; (ostr + 1)
34f8 : 85 1c __ STA ACCU + 1 
34fa : a0 00 __ LDY #$00
34fc : b1 1b __ LDA (ACCU + 0),y 
34fe : d0 30 __ BNE $3530 ; (adv_parse.s9 + 0)
.s10:
3500 : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
3503 : ad fa 3d LDA $3dfa ; (nextroom + 0)
3506 : c9 fa __ CMP #$fa
3508 : f0 0e __ BEQ $3518 ; (adv_parse.s49 + 0)
.s48:
350a : 8d 8a 3e STA $3e8a ; (newroom + 0)
350d : a9 fa __ LDA #$fa
350f : 8d fa 3d STA $3dfa ; (nextroom + 0)
3512 : 20 09 13 JSR $1309 ; (room_load.s1000 + 0)
3515 : 4c 25 35 JMP $3525 ; (adv_parse.s1001 + 0)
.s49:
3518 : a9 03 __ LDA #$03
351a : 8d 8b 3e STA $3e8b ; (cmd + 0)
351d : a9 ff __ LDA #$ff
351f : 8d 8c 3e STA $3e8c ; (obj1 + 0)
3522 : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
.s1001:
3525 : ad d5 cb LDA $cbd5 ; (adv_parse@stack + 0)
3528 : 85 53 __ STA T1 + 0 
352a : ad d6 cb LDA $cbd6 ; (adv_parse@stack + 1)
352d : 85 54 __ STA T3 + 0 
352f : 60 __ __ RTS
.s9:
3530 : 8c f7 3e STY $3ef7 ; (strdir + 0)
3533 : 8c f8 3e STY $3ef8 ; (strdir + 1)
3536 : ad 8b 3e LDA $3e8b ; (cmd + 0)
3539 : 85 53 __ STA T1 + 0 
353b : c9 ff __ CMP #$ff
353d : f0 1d __ BEQ $355c ; (adv_parse.s1004 + 0)
.s1005:
353f : 84 54 __ STY T3 + 0 
3541 : ad 54 3e LDA $3e54 ; (objs + 0)
3544 : 8d 9f 3e STA $3e9f ; (str + 0)
3547 : ad 55 3e LDA $3e55 ; (objs + 1)
354a : 8d a0 3e STA $3ea0 ; (str + 1)
354d : ad 56 3e LDA $3e56 ; (objs_dir + 0)
3550 : 8d f7 3e STA $3ef7 ; (strdir + 0)
3553 : ad 57 3e LDA $3e57 ; (objs_dir + 1)
3556 : 8d f8 3e STA $3ef8 ; (strdir + 1)
3559 : 4c 6c 35 JMP $356c ; (adv_parse.s113 + 0)
.s1004:
355c : a9 01 __ LDA #$01
355e : 85 54 __ STA T3 + 0 
3560 : ad 52 3e LDA $3e52 ; (verbs + 0)
3563 : 8d 9f 3e STA $3e9f ; (str + 0)
3566 : ad 53 3e LDA $3e53 ; (verbs + 1)
3569 : 8d a0 3e STA $3ea0 ; (str + 1)
.s113:
356c : 20 51 36 JSR $3651 ; (_findstring.s0 + 0)
356f : ad f9 3e LDA $3ef9 ; (cmdid + 0)
3572 : c9 ff __ CMP #$ff
3574 : d0 03 __ BNE $3579 ; (adv_parse.s14 + 0)
3576 : 4c 05 36 JMP $3605 ; (adv_parse.s15 + 0)
.s14:
3579 : a5 54 __ LDA T3 + 0 
357b : f0 24 __ BEQ $35a1 ; (adv_parse.s18 + 0)
.s17:
357d : ad f9 3e LDA $3ef9 ; (cmdid + 0)
3580 : 8d 8b 3e STA $3e8b ; (cmd + 0)
3583 : a9 09 __ LDA #$09
3585 : 85 11 __ STA P4 
3587 : ad 86 3e LDA $3e86 ; (vrb + 0)
358a : 85 0d __ STA P0 
358c : ad 87 3e LDA $3e87 ; (vrb + 1)
358f : 85 0e __ STA P1 
3591 : ad 84 3e LDA $3e84 ; (tmp + 0)
3594 : 85 0f __ STA P2 
3596 : ad 85 3e LDA $3e85 ; (tmp + 1)
3599 : 85 10 __ STA P3 
359b : 20 44 39 JSR $3944 ; (strncpy.s0 + 0)
359e : 4c ba 35 JMP $35ba ; (adv_parse.s132 + 0)
.s18:
35a1 : ad f5 3e LDA $3ef5 ; (obj1k + 0)
35a4 : d0 04 __ BNE $35aa ; (adv_parse.s21 + 0)
.s20:
35a6 : a9 01 __ LDA #$01
35a8 : d0 4f __ BNE $35f9 ; (adv_parse.s1023 + 0)
.s21:
35aa : ad f6 3e LDA $3ef6 ; (obj2k + 0)
35ad : d0 0b __ BNE $35ba ; (adv_parse.s132 + 0)
.s23:
35af : a9 01 __ LDA #$01
.s1024:
35b1 : 8d f6 3e STA $3ef6 ; (obj2k + 0)
35b4 : ad f9 3e LDA $3ef9 ; (cmdid + 0)
35b7 : 8d 9d 3e STA $3e9d ; (obj2 + 0)
.s132:
35ba : ad a8 3e LDA $3ea8 ; (ostr + 0)
35bd : 85 1b __ STA ACCU + 0 
35bf : ad a9 3e LDA $3ea9 ; (ostr + 1)
35c2 : 85 1c __ STA ACCU + 1 
35c4 : a0 00 __ LDY #$00
35c6 : b1 1b __ LDA (ACCU + 0),y 
35c8 : d0 03 __ BNE $35cd ; (adv_parse.l47 + 0)
35ca : 4c f0 34 JMP $34f0 ; (adv_parse.l8 + 0)
.l47:
35cd : ad a8 3e LDA $3ea8 ; (ostr + 0)
35d0 : 85 1b __ STA ACCU + 0 
35d2 : ad a9 3e LDA $3ea9 ; (ostr + 1)
35d5 : 85 1c __ STA ACCU + 1 
35d7 : a0 00 __ LDY #$00
35d9 : b1 1b __ LDA (ACCU + 0),y 
35db : c9 20 __ CMP #$20
35dd : f0 03 __ BEQ $35e2 ; (adv_parse.s45 + 0)
35df : 4c f0 34 JMP $34f0 ; (adv_parse.l8 + 0)
.s45:
35e2 : 18 __ __ CLC
35e3 : a5 1b __ LDA ACCU + 0 
35e5 : 69 01 __ ADC #$01
35e7 : 8d a8 3e STA $3ea8 ; (ostr + 0)
35ea : a5 1c __ LDA ACCU + 1 
35ec : 69 00 __ ADC #$00
35ee : 8d a9 3e STA $3ea9 ; (ostr + 1)
35f1 : c8 __ __ INY
35f2 : b1 1b __ LDA (ACCU + 0),y 
35f4 : d0 d7 __ BNE $35cd ; (adv_parse.l47 + 0)
35f6 : 4c f0 34 JMP $34f0 ; (adv_parse.l8 + 0)
.s1023:
35f9 : 8d f5 3e STA $3ef5 ; (obj1k + 0)
35fc : ad f9 3e LDA $3ef9 ; (cmdid + 0)
.s1025:
35ff : 8d 8c 3e STA $3e8c ; (obj1 + 0)
3602 : 4c ba 35 JMP $35ba ; (adv_parse.s132 + 0)
.s15:
3605 : a5 53 __ LDA T1 + 0 
3607 : c9 ff __ CMP #$ff
3609 : f0 af __ BEQ $35ba ; (adv_parse.s132 + 0)
.s26:
360b : a9 00 __ LDA #$00
360d : 8d f7 3e STA $3ef7 ; (strdir + 0)
3610 : 8d f8 3e STA $3ef8 ; (strdir + 1)
3613 : ad 58 3e LDA $3e58 ; (rooms + 0)
3616 : 8d 9f 3e STA $3e9f ; (str + 0)
3619 : ad 59 3e LDA $3e59 ; (rooms + 1)
361c : 8d a0 3e STA $3ea0 ; (str + 1)
361f : 20 51 36 JSR $3651 ; (_findstring.s0 + 0)
3622 : ad f5 3e LDA $3ef5 ; (obj1k + 0)
3625 : f0 11 __ BEQ $3638 ; (adv_parse.s29 + 0)
.s30:
3627 : ad f6 3e LDA $3ef6 ; (obj2k + 0)
362a : d0 8e __ BNE $35ba ; (adv_parse.s132 + 0)
.s38:
362c : ad f9 3e LDA $3ef9 ; (cmdid + 0)
362f : c9 ff __ CMP #$ff
3631 : f0 87 __ BEQ $35ba ; (adv_parse.s132 + 0)
.s41:
3633 : a9 02 __ LDA #$02
3635 : 4c b1 35 JMP $35b1 ; (adv_parse.s1024 + 0)
.s29:
3638 : ad f9 3e LDA $3ef9 ; (cmdid + 0)
363b : c9 ff __ CMP #$ff
363d : d0 0e __ BNE $364d ; (adv_parse.s32 + 0)
.s33:
363f : ad 8c 3e LDA $3e8c ; (obj1 + 0)
3642 : c9 f9 __ CMP #$f9
3644 : f0 03 __ BEQ $3649 ; (adv_parse.s35 + 0)
3646 : 4c ba 35 JMP $35ba ; (adv_parse.s132 + 0)
.s35:
3649 : a9 ff __ LDA #$ff
364b : d0 b2 __ BNE $35ff ; (adv_parse.s1025 + 0)
.s32:
364d : a9 02 __ LDA #$02
364f : d0 a8 __ BNE $35f9 ; (adv_parse.s1023 + 0)
--------------------------------------------------------------------
_findstring: ; _findstring()->void
.s0:
3651 : a9 00 __ LDA #$00
3653 : 8d f9 3e STA $3ef9 ; (cmdid + 0)
3656 : 8d 98 3e STA $3e98 ; (i + 0)
3659 : 8d 99 3e STA $3e99 ; (i + 1)
365c : ad f8 3e LDA $3ef8 ; (strdir + 1)
365f : 85 44 __ STA T0 + 1 
3661 : ad f7 3e LDA $3ef7 ; (strdir + 0)
3664 : 85 43 __ STA T0 + 0 
3666 : 05 44 __ ORA T0 + 1 
3668 : f0 30 __ BEQ $369a ; (_findstring.s10 + 0)
.s1:
366a : ad a8 3e LDA $3ea8 ; (ostr + 0)
366d : 85 45 __ STA T1 + 0 
366f : ad a9 3e LDA $3ea9 ; (ostr + 1)
3672 : 85 46 __ STA T1 + 1 
3674 : a0 00 __ LDY #$00
3676 : b1 45 __ LDA (T1 + 0),y 
3678 : c9 1a __ CMP #$1a
367a : 90 03 __ BCC $367f ; (_findstring.s4 + 0)
367c : 4c 44 37 JMP $3744 ; (_findstring.s9 + 0)
.s4:
367f : 0a __ __ ASL
3680 : a8 __ __ TAY
3681 : b1 43 __ LDA (T0 + 0),y 
3683 : 8d 98 3e STA $3e98 ; (i + 0)
3686 : c8 __ __ INY
3687 : b1 43 __ LDA (T0 + 0),y 
3689 : 8d 99 3e STA $3e99 ; (i + 1)
368c : c9 ff __ CMP #$ff
368e : d0 0a __ BNE $369a ; (_findstring.s10 + 0)
.s1015:
3690 : ad 98 3e LDA $3e98 ; (i + 0)
3693 : c9 ff __ CMP #$ff
3695 : d0 03 __ BNE $369a ; (_findstring.s10 + 0)
3697 : 4c 44 37 JMP $3744 ; (_findstring.s9 + 0)
.s10:
369a : ad 9f 3e LDA $3e9f ; (str + 0)
369d : 18 __ __ CLC
369e : 6d 98 3e ADC $3e98 ; (i + 0)
36a1 : 85 43 __ STA T0 + 0 
36a3 : ad a0 3e LDA $3ea0 ; (str + 1)
36a6 : 6d 99 3e ADC $3e99 ; (i + 1)
36a9 : 85 44 __ STA T0 + 1 
36ab : a0 00 __ LDY #$00
36ad : b1 43 __ LDA (T0 + 0),y 
36af : d0 03 __ BNE $36b4 ; (_findstring.l11 + 0)
36b1 : 4c 44 37 JMP $3744 ; (_findstring.s9 + 0)
.l11:
36b4 : ad 98 3e LDA $3e98 ; (i + 0)
36b7 : 85 43 __ STA T0 + 0 
36b9 : 18 __ __ CLC
36ba : 69 01 __ ADC #$01
36bc : 85 45 __ STA T1 + 0 
36be : 8d 98 3e STA $3e98 ; (i + 0)
36c1 : ad 99 3e LDA $3e99 ; (i + 1)
36c4 : 85 44 __ STA T0 + 1 
36c6 : 69 00 __ ADC #$00
36c8 : 85 46 __ STA T1 + 1 
36ca : 8d 99 3e STA $3e99 ; (i + 1)
36cd : ad 9f 3e LDA $3e9f ; (str + 0)
36d0 : 85 48 __ STA T4 + 0 
36d2 : 18 __ __ CLC
36d3 : 65 43 __ ADC T0 + 0 
36d5 : 85 43 __ STA T0 + 0 
36d7 : ad a0 3e LDA $3ea0 ; (str + 1)
36da : 85 49 __ STA T4 + 1 
36dc : 65 44 __ ADC T0 + 1 
36de : 85 44 __ STA T0 + 1 
36e0 : a0 00 __ LDY #$00
36e2 : b1 43 __ LDA (T0 + 0),y 
36e4 : 85 47 __ STA T2 + 0 
36e6 : 8d aa 3e STA $3eaa ; (len + 0)
36e9 : ad a8 3e LDA $3ea8 ; (ostr + 0)
36ec : 85 4a __ STA T5 + 0 
36ee : ad a9 3e LDA $3ea9 ; (ostr + 1)
36f1 : 85 4b __ STA T5 + 1 
36f3 : c8 __ __ INY
36f4 : b1 43 __ LDA (T0 + 0),y 
36f6 : 88 __ __ DEY
36f7 : d1 4a __ CMP (T5 + 0),y 
36f9 : d0 03 __ BNE $36fe ; (_findstring.s14 + 0)
36fb : 4c e6 37 JMP $37e6 ; (_findstring.s13 + 0)
.s14:
36fe : ad f7 3e LDA $3ef7 ; (strdir + 0)
3701 : 0d f8 3e ORA $3ef8 ; (strdir + 1)
3704 : d0 3e __ BNE $3744 ; (_findstring.s9 + 0)
.s15:
3706 : 18 __ __ CLC
3707 : a5 47 __ LDA T2 + 0 
3709 : 65 45 __ ADC T1 + 0 
370b : 85 43 __ STA T0 + 0 
370d : a9 00 __ LDA #$00
370f : 65 46 __ ADC T1 + 1 
3711 : aa __ __ TAX
3712 : 18 __ __ CLC
3713 : a5 43 __ LDA T0 + 0 
3715 : 69 01 __ ADC #$01
3717 : 85 45 __ STA T1 + 0 
3719 : 8a __ __ TXA
371a : 69 00 __ ADC #$00
371c : 85 46 __ STA T1 + 1 
371e : 8a __ __ TXA
371f : 18 __ __ CLC
3720 : 65 49 __ ADC T4 + 1 
3722 : 85 44 __ STA T0 + 1 
3724 : a4 48 __ LDY T4 + 0 
3726 : b1 43 __ LDA (T0 + 0),y 
3728 : aa __ __ TAX
3729 : c8 __ __ INY
372a : b1 43 __ LDA (T0 + 0),y 
372c : e0 ff __ CPX #$ff
372e : d0 03 __ BNE $3733 ; (_findstring.s39 + 0)
3730 : 4c b4 37 JMP $37b4 ; (_findstring.s38 + 0)
.s39:
3733 : aa __ __ TAX
3734 : a5 45 __ LDA T1 + 0 
3736 : 8d 98 3e STA $3e98 ; (i + 0)
3739 : a5 46 __ LDA T1 + 1 
373b : 8d 99 3e STA $3e99 ; (i + 1)
373e : 8a __ __ TXA
373f : f0 03 __ BEQ $3744 ; (_findstring.s9 + 0)
3741 : 4c b4 36 JMP $36b4 ; (_findstring.l11 + 0)
.s9:
3744 : a9 ff __ LDA #$ff
3746 : 8d f9 3e STA $3ef9 ; (cmdid + 0)
3749 : a9 00 __ LDA #$00
374b : 8d 98 3e STA $3e98 ; (i + 0)
374e : 8d 99 3e STA $3e99 ; (i + 1)
3751 : ad a8 3e LDA $3ea8 ; (ostr + 0)
3754 : 85 43 __ STA T0 + 0 
3756 : ad a9 3e LDA $3ea9 ; (ostr + 1)
3759 : 85 44 __ STA T0 + 1 
375b : a0 00 __ LDY #$00
375d : b1 43 __ LDA (T0 + 0),y 
375f : f0 52 __ BEQ $37b3 ; (_findstring.s1001 + 0)
.l44:
3761 : ad a8 3e LDA $3ea8 ; (ostr + 0)
3764 : 85 43 __ STA T0 + 0 
3766 : ad a9 3e LDA $3ea9 ; (ostr + 1)
3769 : 85 44 __ STA T0 + 1 
376b : a0 00 __ LDY #$00
376d : b1 43 __ LDA (T0 + 0),y 
376f : c9 20 __ CMP #$20
3771 : f0 40 __ BEQ $37b3 ; (_findstring.s1001 + 0)
.s42:
3773 : aa __ __ TAX
3774 : 18 __ __ CLC
3775 : a5 43 __ LDA T0 + 0 
3777 : 69 01 __ ADC #$01
3779 : 8d a8 3e STA $3ea8 ; (ostr + 0)
377c : a5 44 __ LDA T0 + 1 
377e : 69 00 __ ADC #$00
3780 : 8d a9 3e STA $3ea9 ; (ostr + 1)
3783 : ad 98 3e LDA $3e98 ; (i + 0)
3786 : 85 45 __ STA T1 + 0 
3788 : ad 99 3e LDA $3e99 ; (i + 1)
378b : d0 20 __ BNE $37ad ; (_findstring.s114 + 0)
.s1002:
378d : a5 45 __ LDA T1 + 0 
378f : c9 20 __ CMP #$20
3791 : b0 1a __ BCS $37ad ; (_findstring.s114 + 0)
.s45:
3793 : 8c 99 3e STY $3e99 ; (i + 1)
3796 : 69 01 __ ADC #$01
3798 : 8d 98 3e STA $3e98 ; (i + 0)
379b : ad 84 3e LDA $3e84 ; (tmp + 0)
379e : 18 __ __ CLC
379f : 65 45 __ ADC T1 + 0 
37a1 : 85 45 __ STA T1 + 0 
37a3 : ad 85 3e LDA $3e85 ; (tmp + 1)
37a6 : 69 00 __ ADC #$00
37a8 : 85 46 __ STA T1 + 1 
37aa : 8a __ __ TXA
37ab : 91 45 __ STA (T1 + 0),y 
.s114:
37ad : a0 01 __ LDY #$01
37af : b1 43 __ LDA (T0 + 0),y 
37b1 : d0 ae __ BNE $3761 ; (_findstring.l44 + 0)
.s1001:
37b3 : 60 __ __ RTS
.s38:
37b4 : 0a __ __ ASL
37b5 : a0 00 __ LDY #$00
37b7 : 90 01 __ BCC $37ba ; (_findstring.s1025 + 0)
.s1024:
37b9 : c8 __ __ INY
.s1025:
37ba : 18 __ __ CLC
37bb : 65 45 __ ADC T1 + 0 
37bd : aa __ __ TAX
37be : 98 __ __ TYA
37bf : 65 46 __ ADC T1 + 1 
37c1 : a8 __ __ TAY
37c2 : 8a __ __ TXA
37c3 : 18 __ __ CLC
37c4 : 69 01 __ ADC #$01
37c6 : 8d 98 3e STA $3e98 ; (i + 0)
37c9 : 98 __ __ TYA
37ca : 69 00 __ ADC #$00
37cc : 8d 99 3e STA $3e99 ; (i + 1)
37cf : 8a __ __ TXA
37d0 : 18 __ __ CLC
37d1 : 65 48 __ ADC T4 + 0 
37d3 : 85 43 __ STA T0 + 0 
37d5 : 98 __ __ TYA
37d6 : 65 49 __ ADC T4 + 1 
37d8 : 85 44 __ STA T0 + 1 
37da : a0 01 __ LDY #$01
37dc : b1 43 __ LDA (T0 + 0),y 
37de : d0 03 __ BNE $37e3 ; (_findstring.s1025 + 41)
37e0 : 4c 44 37 JMP $3744 ; (_findstring.s9 + 0)
37e3 : 4c b4 36 JMP $36b4 ; (_findstring.l11 + 0)
.s13:
37e6 : 18 __ __ CLC
37e7 : a5 43 __ LDA T0 + 0 
37e9 : 69 01 __ ADC #$01
37eb : 85 0f __ STA P2 
37ed : a5 44 __ LDA T0 + 1 
37ef : 69 00 __ ADC #$00
37f1 : 85 10 __ STA P3 
37f3 : 18 __ __ CLC
37f4 : a5 47 __ LDA T2 + 0 
37f6 : 65 4a __ ADC T5 + 0 
37f8 : 85 4c __ STA T8 + 0 
37fa : a5 4b __ LDA T5 + 1 
37fc : 69 00 __ ADC #$00
37fe : 85 4d __ STA T8 + 1 
3800 : a4 47 __ LDY T2 + 0 
3802 : b1 4a __ LDA (T5 + 0),y 
3804 : f0 07 __ BEQ $380d ; (_findstring.s16 + 0)
.s19:
3806 : c9 20 __ CMP #$20
3808 : f0 03 __ BEQ $380d ; (_findstring.s16 + 0)
380a : 4c 06 37 JMP $3706 ; (_findstring.s15 + 0)
.s16:
380d : 84 11 __ STY P4 
380f : a5 4a __ LDA T5 + 0 
3811 : 85 0d __ STA P0 
3813 : a5 4b __ LDA T5 + 1 
3815 : 85 0e __ STA P1 
3817 : a9 00 __ LDA #$00
3819 : 85 12 __ STA P5 
381b : 20 f0 38 JSR $38f0 ; (memcmp.s0 + 0)
381e : a5 1b __ LDA ACCU + 0 
3820 : 05 1c __ ORA ACCU + 1 
3822 : f0 03 __ BEQ $3827 ; (_findstring.s20 + 0)
3824 : 4c 06 37 JMP $3706 ; (_findstring.s15 + 0)
.s20:
3827 : a5 47 __ LDA T2 + 0 
3829 : 85 11 __ STA P4 
382b : a9 00 __ LDA #$00
382d : 85 12 __ STA P5 
382f : 18 __ __ CLC
3830 : a5 48 __ LDA T4 + 0 
3832 : 65 45 __ ADC T1 + 0 
3834 : 85 0f __ STA P2 
3836 : a5 49 __ LDA T4 + 1 
3838 : 65 46 __ ADC T1 + 1 
383a : 85 10 __ STA P3 
383c : ad 84 3e LDA $3e84 ; (tmp + 0)
383f : 85 43 __ STA T0 + 0 
3841 : 85 0d __ STA P0 
3843 : ad 85 3e LDA $3e85 ; (tmp + 1)
3846 : 85 44 __ STA T0 + 1 
3848 : 85 0e __ STA P1 
384a : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
384d : a5 4c __ LDA T8 + 0 
384f : 8d a8 3e STA $3ea8 ; (ostr + 0)
3852 : a5 4d __ LDA T8 + 1 
3854 : 8d a9 3e STA $3ea9 ; (ostr + 1)
3857 : 18 __ __ CLC
3858 : a5 45 __ LDA T1 + 0 
385a : 65 47 __ ADC T2 + 0 
385c : 8d 98 3e STA $3e98 ; (i + 0)
385f : aa __ __ TAX
3860 : a5 46 __ LDA T1 + 1 
3862 : 69 00 __ ADC #$00
3864 : 85 46 __ STA T1 + 1 
3866 : 8d 99 3e STA $3e99 ; (i + 1)
3869 : a9 00 __ LDA #$00
386b : a4 47 __ LDY T2 + 0 
386d : 91 43 __ STA (T0 + 0),y 
386f : 86 43 __ STX T0 + 0 
3871 : 18 __ __ CLC
3872 : a5 49 __ LDA T4 + 1 
3874 : 65 46 __ ADC T1 + 1 
3876 : 85 44 __ STA T0 + 1 
3878 : a4 48 __ LDY T4 + 0 
387a : b1 43 __ LDA (T0 + 0),y 
387c : 8d f9 3e STA $3ef9 ; (cmdid + 0)
387f : c9 ff __ CMP #$ff
3881 : f0 01 __ BEQ $3884 ; (_findstring.s23 + 0)
3883 : 60 __ __ RTS
.s23:
3884 : 8a __ __ TXA
3885 : 18 __ __ CLC
3886 : 69 02 __ ADC #$02
3888 : 8d 98 3e STA $3e98 ; (i + 0)
388b : a5 46 __ LDA T1 + 1 
388d : 69 00 __ ADC #$00
388f : 8d 99 3e STA $3e99 ; (i + 1)
3892 : c8 __ __ INY
3893 : b1 43 __ LDA (T0 + 0),y 
3895 : aa __ __ TAX
3896 : 18 __ __ CLC
3897 : 69 ff __ ADC #$ff
3899 : 8d aa 3e STA $3eaa ; (len + 0)
389c : 8a __ __ TXA
389d : d0 01 __ BNE $38a0 ; (_findstring.s49 + 0)
389f : 60 __ __ RTS
.s49:
38a0 : ad dd 3d LDA $3ddd ; (room + 0)
38a3 : 85 47 __ STA T2 + 0 
.l27:
38a5 : 18 __ __ CLC
38a6 : a5 48 __ LDA T4 + 0 
38a8 : 6d 98 3e ADC $3e98 ; (i + 0)
38ab : 85 45 __ STA T1 + 0 
38ad : a5 49 __ LDA T4 + 1 
38af : 6d 99 3e ADC $3e99 ; (i + 1)
38b2 : 85 46 __ STA T1 + 1 
38b4 : a0 01 __ LDY #$01
38b6 : b1 45 __ LDA (T1 + 0),y 
38b8 : 8d f9 3e STA $3ef9 ; (cmdid + 0)
38bb : ae 98 3e LDX $3e98 ; (i + 0)
38be : 8a __ __ TXA
38bf : 18 __ __ CLC
38c0 : 69 01 __ ADC #$01
38c2 : 8d 98 3e STA $3e98 ; (i + 0)
38c5 : ad 99 3e LDA $3e99 ; (i + 1)
38c8 : 85 44 __ STA T0 + 1 
38ca : 69 00 __ ADC #$00
38cc : 8d 99 3e STA $3e99 ; (i + 1)
38cf : a5 47 __ LDA T2 + 0 
38d1 : 88 __ __ DEY
38d2 : d1 45 __ CMP (T1 + 0),y 
38d4 : d0 01 __ BNE $38d7 ; (_findstring.s31 + 0)
38d6 : 60 __ __ RTS
.s31:
38d7 : 8a __ __ TXA
38d8 : 18 __ __ CLC
38d9 : 69 02 __ ADC #$02
38db : 8d 98 3e STA $3e98 ; (i + 0)
38de : a5 44 __ LDA T0 + 1 
38e0 : 69 00 __ ADC #$00
38e2 : 8d 99 3e STA $3e99 ; (i + 1)
38e5 : ad aa 3e LDA $3eaa ; (len + 0)
38e8 : ce aa 3e DEC $3eaa ; (len + 0)
38eb : 09 00 __ ORA #$00
38ed : d0 b6 __ BNE $38a5 ; (_findstring.l27 + 0)
38ef : 60 __ __ RTS
--------------------------------------------------------------------
memcmp: ; memcmp(const void*,const void*,i16)->i16
.s0:
38f0 : a5 11 __ LDA P4 ; (size + 0)
38f2 : aa __ __ TAX
38f3 : 18 __ __ CLC
38f4 : 69 ff __ ADC #$ff
38f6 : 85 11 __ STA P4 ; (size + 0)
38f8 : a5 12 __ LDA P5 ; (size + 1)
38fa : 85 1c __ STA ACCU + 1 
38fc : 69 ff __ ADC #$ff
38fe : 85 12 __ STA P5 ; (size + 1)
3900 : 8a __ __ TXA
3901 : 05 1c __ ORA ACCU + 1 
3903 : f0 3a __ BEQ $393f ; (memcmp.s1006 + 0)
.s1008:
3905 : a6 11 __ LDX P4 ; (size + 0)
.l2:
3907 : a0 00 __ LDY #$00
3909 : b1 0d __ LDA (P0),y ; (ptr1 + 0)
390b : d1 0f __ CMP (P2),y ; (ptr2 + 0)
390d : b0 04 __ BCS $3913 ; (memcmp.s5 + 0)
.s4:
390f : a9 ff __ LDA #$ff
3911 : 90 2c __ BCC $393f ; (memcmp.s1006 + 0)
.s5:
3913 : b1 0f __ LDA (P2),y ; (ptr2 + 0)
3915 : d1 0d __ CMP (P0),y ; (ptr1 + 0)
3917 : b0 07 __ BCS $3920 ; (memcmp.s1 + 0)
.s8:
3919 : a9 01 __ LDA #$01
391b : 85 1b __ STA ACCU + 0 
391d : 98 __ __ TYA
391e : 90 21 __ BCC $3941 ; (memcmp.s1001 + 0)
.s1:
3920 : 86 1b __ STX ACCU + 0 
3922 : 8a __ __ TXA
3923 : 18 __ __ CLC
3924 : 69 ff __ ADC #$ff
3926 : aa __ __ TAX
3927 : a5 12 __ LDA P5 ; (size + 1)
3929 : a8 __ __ TAY
392a : 69 ff __ ADC #$ff
392c : 85 12 __ STA P5 ; (size + 1)
392e : e6 0d __ INC P0 ; (ptr1 + 0)
3930 : d0 02 __ BNE $3934 ; (memcmp.s1010 + 0)
.s1009:
3932 : e6 0e __ INC P1 ; (ptr1 + 1)
.s1010:
3934 : e6 0f __ INC P2 ; (ptr2 + 0)
3936 : d0 02 __ BNE $393a ; (memcmp.s1012 + 0)
.s1011:
3938 : e6 10 __ INC P3 ; (ptr2 + 1)
.s1012:
393a : 98 __ __ TYA
393b : 05 1b __ ORA ACCU + 0 
393d : d0 c8 __ BNE $3907 ; (memcmp.l2 + 0)
.s1006:
393f : 85 1b __ STA ACCU + 0 
.s1001:
3941 : 85 1c __ STA ACCU + 1 
3943 : 60 __ __ RTS
--------------------------------------------------------------------
strncpy: ; strncpy(u8*,const u8*,u8)->u8*
.s0:
3944 : a5 0d __ LDA P0 ; (destination + 0)
3946 : 85 1b __ STA ACCU + 0 
3948 : a5 0e __ LDA P1 ; (destination + 1)
394a : 85 1c __ STA ACCU + 1 
394c : 05 0d __ ORA P0 ; (destination + 0)
394e : d0 05 __ BNE $3955 ; (strncpy.s2 + 0)
.s1:
3950 : 85 1b __ STA ACCU + 0 
3952 : 85 1c __ STA ACCU + 1 
3954 : 60 __ __ RTS
.s2:
3955 : a0 00 __ LDY #$00
3957 : b1 0f __ LDA (P2),y ; (source + 0)
3959 : f0 2c __ BEQ $3987 ; (strncpy.s7 + 0)
.s1003:
395b : a6 11 __ LDX P4 ; (num + 0)
395d : 8a __ __ TXA
395e : f0 27 __ BEQ $3987 ; (strncpy.s7 + 0)
.l6:
3960 : a0 00 __ LDY #$00
3962 : b1 0f __ LDA (P2),y ; (source + 0)
3964 : 91 0d __ STA (P0),y ; (destination + 0)
3966 : e6 0d __ INC P0 ; (destination + 0)
3968 : d0 02 __ BNE $396c ; (strncpy.s1006 + 0)
.s1005:
396a : e6 0e __ INC P1 ; (destination + 1)
.s1006:
396c : a5 0f __ LDA P2 ; (source + 0)
396e : 85 43 __ STA T2 + 0 
3970 : 18 __ __ CLC
3971 : 69 01 __ ADC #$01
3973 : 85 0f __ STA P2 ; (source + 0)
3975 : a5 10 __ LDA P3 ; (source + 1)
3977 : 85 44 __ STA T2 + 1 
3979 : 69 00 __ ADC #$00
397b : 85 10 __ STA P3 ; (source + 1)
397d : a0 01 __ LDY #$01
397f : ca __ __ DEX
3980 : b1 43 __ LDA (T2 + 0),y 
3982 : f0 03 __ BEQ $3987 ; (strncpy.s7 + 0)
.s8:
3984 : 8a __ __ TXA
3985 : d0 d9 __ BNE $3960 ; (strncpy.l6 + 0)
.s7:
3987 : a8 __ __ TAY
3988 : 91 0d __ STA (P0),y ; (destination + 0)
.s1001:
398a : 60 __ __ RTS
--------------------------------------------------------------------
charmap: ; charmap(u8)->u8
.s0:
398b : c9 30 __ CMP #$30
398d : 90 04 __ BCC $3993 ; (charmap.s2 + 0)
.s4:
398f : c9 3a __ CMP #$3a
3991 : 90 24 __ BCC $39b7 ; (charmap.s1001 + 0)
.s2:
3993 : c9 41 __ CMP #$41
3995 : 90 07 __ BCC $399e ; (charmap.s6 + 0)
.s8:
3997 : c9 5b __ CMP #$5b
3999 : b0 03 __ BCS $399e ; (charmap.s6 + 0)
.s5:
399b : 69 c0 __ ADC #$c0
399d : 60 __ __ RTS
.s6:
399e : c9 61 __ CMP #$61
39a0 : 90 07 __ BCC $39a9 ; (charmap.s10 + 0)
.s12:
39a2 : c9 7b __ CMP #$7b
39a4 : b0 03 __ BCS $39a9 ; (charmap.s10 + 0)
.s9:
39a6 : 69 a0 __ ADC #$a0
39a8 : 60 __ __ RTS
.s10:
39a9 : c9 20 __ CMP #$20
39ab : f0 0a __ BEQ $39b7 ; (charmap.s1001 + 0)
.s14:
39ad : c9 2e __ CMP #$2e
39af : f0 06 __ BEQ $39b7 ; (charmap.s1001 + 0)
.s17:
39b1 : c9 2c __ CMP #$2c
39b3 : f0 02 __ BEQ $39b7 ; (charmap.s1001 + 0)
.s20:
39b5 : a9 00 __ LDA #$00
.s1001:
39b7 : 60 __ __ RTS
--------------------------------------------------------------------
do_blink: ; do_blink()->void
.s0:
39b8 : ee fa 3e INC $3efa ; (blink + 0)
39bb : ad fa 3e LDA $3efa ; (blink + 0)
39be : c9 5b __ CMP #$5b
39c0 : 90 5e __ BCC $3a20 ; (do_blink.s1001 + 0)
.s1:
39c2 : ad b1 3e LDA $3eb1 ; (txt_y + 0)
39c5 : 0a __ __ ASL
39c6 : 85 1b __ STA ACCU + 0 
39c8 : a9 00 __ LDA #$00
39ca : 8d fa 3e STA $3efa ; (blink + 0)
39cd : 2a __ __ ROL
39ce : 06 1b __ ASL ACCU + 0 
39d0 : 2a __ __ ROL
39d1 : aa __ __ TAX
39d2 : a5 1b __ LDA ACCU + 0 
39d4 : 6d b1 3e ADC $3eb1 ; (txt_y + 0)
39d7 : 85 1b __ STA ACCU + 0 
39d9 : 8a __ __ TXA
39da : 69 00 __ ADC #$00
39dc : 06 1b __ ASL ACCU + 0 
39de : 2a __ __ ROL
39df : 06 1b __ ASL ACCU + 0 
39e1 : 2a __ __ ROL
39e2 : 06 1b __ ASL ACCU + 0 
39e4 : 2a __ __ ROL
39e5 : aa __ __ TAX
39e6 : ad b0 3e LDA $3eb0 ; (txt_x + 0)
39e9 : 18 __ __ CLC
39ea : 65 1b __ ADC ACCU + 0 
39ec : 85 1b __ STA ACCU + 0 
39ee : 90 01 __ BCC $39f1 ; (do_blink.s1007 + 0)
.s1006:
39f0 : e8 __ __ INX
.s1007:
39f1 : 86 1c __ STX ACCU + 1 
39f3 : 18 __ __ CLC
39f4 : 6d ca 3d ADC $3dca ; (video_colorram + 0)
39f7 : 85 43 __ STA T2 + 0 
39f9 : ad cb 3d LDA $3dcb ; (video_colorram + 1)
39fc : 65 1c __ ADC ACCU + 1 
39fe : 85 44 __ STA T2 + 1 
3a00 : a0 00 __ LDY #$00
3a02 : b1 43 __ LDA (T2 + 0),y 
3a04 : f0 03 __ BEQ $3a09 ; (do_blink.s1008 + 0)
.s1009:
3a06 : 98 __ __ TYA
3a07 : f0 02 __ BEQ $3a0b ; (do_blink.s1010 + 0)
.s1008:
3a09 : a9 0c __ LDA #$0c
.s1010:
3a0b : 91 43 __ STA (T2 + 0),y 
3a0d : ad c8 3d LDA $3dc8 ; (video_ram + 0)
3a10 : 18 __ __ CLC
3a11 : 65 1b __ ADC ACCU + 0 
3a13 : 85 1b __ STA ACCU + 0 
3a15 : ad c9 3d LDA $3dc9 ; (video_ram + 1)
3a18 : 65 1c __ ADC ACCU + 1 
3a1a : 85 1c __ STA ACCU + 1 
3a1c : a9 6c __ LDA #$6c
3a1e : 91 1b __ STA (ACCU + 0),y 
.s1001:
3a20 : 60 __ __ RTS
--------------------------------------------------------------------
adv_reset: ; adv_reset()->void
.s0:
3a21 : ad 72 3e LDA $3e72 ; (objattr + 0)
3a24 : 85 0d __ STA P0 
3a26 : ad 73 3e LDA $3e73 ; (objattr + 1)
3a29 : 85 0e __ STA P1 
3a2b : a9 00 __ LDA #$00
3a2d : 85 0f __ STA P2 
3a2f : a9 05 __ LDA #$05
3a31 : 85 10 __ STA P3 
3a33 : ad 82 3e LDA $3e82 ; (origram_len + 0)
3a36 : 85 11 __ STA P4 
3a38 : ad 83 3e LDA $3e83 ; (origram_len + 1)
3a3b : 85 12 __ STA P5 
3a3d : 4c d5 0c JMP $0cd5 ; (memcpy.s0 + 0)
--------------------------------------------------------------------
adv_load: ; adv_load()->u8
.s0:
3a40 : a9 00 __ LDA #$00
3a42 : 85 13 __ STA P6 
3a44 : 20 2c 2b JSR $2b2c ; (irq_detach.l30 + 0)
3a47 : a9 da __ LDA #$da
3a49 : 85 0d __ STA P0 
3a4b : a9 2b __ LDA #$2b
3a4d : 85 0e __ STA P1 
3a4f : ad 72 3e LDA $3e72 ; (objattr + 0)
3a52 : 85 0f __ STA P2 
3a54 : ad 73 3e LDA $3e73 ; (objattr + 1)
3a57 : 85 10 __ STA P3 
3a59 : ad 82 3e LDA $3e82 ; (origram_len + 0)
3a5c : 85 11 __ STA P4 
3a5e : ad 83 3e LDA $3e83 ; (origram_len + 1)
3a61 : 85 12 __ STA P5 
3a63 : 20 88 3a JSR $3a88 ; (disk_load.s0 + 0)
3a66 : 09 00 __ ORA #$00
3a68 : f0 07 __ BEQ $3a71 ; (adv_load.s1 + 0)
.s2:
3a6a : 20 df 2b JSR $2bdf ; (irq_attach.l27 + 0)
3a6d : a9 01 __ LDA #$01
3a6f : d0 14 __ BNE $3a85 ; (adv_load.s1001 + 0)
.s1:
3a71 : a9 02 __ LDA #$02
3a73 : 8d 20 d0 STA $d020 
.l32:
3a76 : 2c 11 d0 BIT $d011 
3a79 : 10 fb __ BPL $3a76 ; (adv_load.l32 + 0)
.s4:
3a7b : a9 00 __ LDA #$00
3a7d : 8d 20 d0 STA $d020 
3a80 : 20 df 2b JSR $2bdf ; (irq_attach.l27 + 0)
3a83 : a9 00 __ LDA #$00
.s1001:
3a85 : 85 1b __ STA ACCU + 0 
3a87 : 60 __ __ RTS
--------------------------------------------------------------------
disk_load: ; disk_load(const u8*,u8*,u16)->u8
.s0:
3a88 : a5 0f __ LDA P2 ; (mem + 0)
3a8a : 8d ee 3e STA $3eee ; (diskmemlow + 0)
3a8d : a5 10 __ LDA P3 ; (mem + 1)
3a8f : 8d ef 3e STA $3eef ; (diskmemhi + 0)
3a92 : a9 07 __ LDA #$07
3a94 : a2 e4 __ LDX #$e4
3a96 : a0 3d __ LDY #$3d
3a98 : 20 bd ff JSR $ffbd 
3a9b : a9 01 __ LDA #$01
3a9d : a6 ba __ LDX $ba 
3a9f : d0 02 __ BNE $3aa3 ; (disk_load.s0 + 27)
3aa1 : a2 08 __ LDX #$08
3aa3 : a0 00 __ LDY #$00
3aa5 : 20 ba ff JSR $ffba 
3aa8 : a9 00 __ LDA #$00
3aaa : ae ee 3e LDX $3eee ; (diskmemlow + 0)
3aad : ac ef 3e LDY $3eef ; (diskmemhi + 0)
3ab0 : 20 d5 ff JSR $ffd5 
3ab3 : b0 05 __ BCS $3aba ; (disk_load.s0 + 50)
3ab5 : a9 01 __ LDA #$01
3ab7 : 85 1b __ STA ACCU + 0 
3ab9 : 60 __ __ RTS
3aba : a9 00 __ LDA #$00
3abc : 85 1b __ STA ACCU + 0 
.s1001:
3abe : a5 1b __ LDA ACCU + 0 
3ac0 : 60 __ __ RTS
--------------------------------------------------------------------
os_reset: ; os_reset()->void
.s0:
3ac1 : 20 e2 fc JSR $fce2 
.s1001:
3ac4 : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
3ac5 : a5 1c __ LDA ACCU + 1 
3ac7 : d0 31 __ BNE $3afa ; (divmod + 53)
3ac9 : a5 04 __ LDA WORK + 1 
3acb : d0 1e __ BNE $3aeb ; (divmod + 38)
3acd : 85 06 __ STA WORK + 3 
3acf : a2 04 __ LDX #$04
3ad1 : 06 1b __ ASL ACCU + 0 
3ad3 : 2a __ __ ROL
3ad4 : c5 03 __ CMP WORK + 0 
3ad6 : 90 02 __ BCC $3ada ; (divmod + 21)
3ad8 : e5 03 __ SBC WORK + 0 
3ada : 26 1b __ ROL ACCU + 0 
3adc : 2a __ __ ROL
3add : c5 03 __ CMP WORK + 0 
3adf : 90 02 __ BCC $3ae3 ; (divmod + 30)
3ae1 : e5 03 __ SBC WORK + 0 
3ae3 : 26 1b __ ROL ACCU + 0 
3ae5 : ca __ __ DEX
3ae6 : d0 eb __ BNE $3ad3 ; (divmod + 14)
3ae8 : 85 05 __ STA WORK + 2 
3aea : 60 __ __ RTS
3aeb : a5 1b __ LDA ACCU + 0 
3aed : 85 05 __ STA WORK + 2 
3aef : a5 1c __ LDA ACCU + 1 
3af1 : 85 06 __ STA WORK + 3 
3af3 : a9 00 __ LDA #$00
3af5 : 85 1b __ STA ACCU + 0 
3af7 : 85 1c __ STA ACCU + 1 
3af9 : 60 __ __ RTS
3afa : a5 04 __ LDA WORK + 1 
3afc : d0 1f __ BNE $3b1d ; (divmod + 88)
3afe : a5 03 __ LDA WORK + 0 
3b00 : 30 1b __ BMI $3b1d ; (divmod + 88)
3b02 : a9 00 __ LDA #$00
3b04 : 85 06 __ STA WORK + 3 
3b06 : a2 10 __ LDX #$10
3b08 : 06 1b __ ASL ACCU + 0 
3b0a : 26 1c __ ROL ACCU + 1 
3b0c : 2a __ __ ROL
3b0d : c5 03 __ CMP WORK + 0 
3b0f : 90 02 __ BCC $3b13 ; (divmod + 78)
3b11 : e5 03 __ SBC WORK + 0 
3b13 : 26 1b __ ROL ACCU + 0 
3b15 : 26 1c __ ROL ACCU + 1 
3b17 : ca __ __ DEX
3b18 : d0 f2 __ BNE $3b0c ; (divmod + 71)
3b1a : 85 05 __ STA WORK + 2 
3b1c : 60 __ __ RTS
3b1d : a9 00 __ LDA #$00
3b1f : 85 05 __ STA WORK + 2 
3b21 : 85 06 __ STA WORK + 3 
3b23 : 84 02 __ STY $02 
3b25 : a0 10 __ LDY #$10
3b27 : 18 __ __ CLC
3b28 : 26 1b __ ROL ACCU + 0 
3b2a : 26 1c __ ROL ACCU + 1 
3b2c : 26 05 __ ROL WORK + 2 
3b2e : 26 06 __ ROL WORK + 3 
3b30 : 38 __ __ SEC
3b31 : a5 05 __ LDA WORK + 2 
3b33 : e5 03 __ SBC WORK + 0 
3b35 : aa __ __ TAX
3b36 : a5 06 __ LDA WORK + 3 
3b38 : e5 04 __ SBC WORK + 1 
3b3a : 90 04 __ BCC $3b40 ; (divmod + 123)
3b3c : 86 05 __ STX WORK + 2 
3b3e : 85 06 __ STA WORK + 3 
3b40 : 88 __ __ DEY
3b41 : d0 e5 __ BNE $3b28 ; (divmod + 99)
3b43 : 26 1b __ ROL ACCU + 0 
3b45 : 26 1c __ ROL ACCU + 1 
3b47 : a4 02 __ LDY $02 
3b49 : 60 __ __ RTS
--------------------------------------------------------------------
spentry:
3b4a : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
font:
3b4b : __ __ __ BYT c7 38 44 4c 4c 40 44 38 03 c5 38 04 3c 44 3c 02 : .8DLL@D8..8.<D<.
3b5b : __ __ __ BYT c6 40 40 78 44 44 78 83 10 c1 3c 43 40 83 10 c1 : .@@xDDx...<C@...
3b6b : __ __ __ BYT 04 83 17 84 18 c4 00 38 44 7c 84 10 c3 0c 10 3c : .......8D|.....<
3b7b : __ __ __ BYT 43 10 84 20 83 17 c2 04 78 86 30 c8 44 00 00 10 : C.. ....x.0.D...
3b8b : __ __ __ BYT 00 30 10 10 83 48 c2 08 00 44 08 c1 70 83 18 c3 : .0...H...D..p...
3b9b : __ __ __ BYT 48 70 48 83 18 83 16 85 18 c4 00 68 54 54 84 28 : HpH........hTT.(
3bab : __ __ __ BYT c1 00 84 2f 84 08 c1 38 83 07 84 18 84 6f c2 40 : .../...8.....o.@
3bbb : __ __ __ BYT 40 87 50 c1 04 84 10 83 79 85 80 c1 38 83 5f c3 : @.P.....y...8._.
3bcb : __ __ __ BYT 00 10 7c 83 40 c1 0c 83 10 84 37 84 88 83 07 c1 : ..|.@.....7.....
3bdb : __ __ __ BYT 28 84 80 83 08 c2 54 28 84 08 c3 28 10 28 84 50 : (.....T(...(.(.P
3beb : __ __ __ BYT 84 1f 83 78 c8 00 7c 08 10 20 7c 00 38 45 20 cb : ...x..|.. |.8E .
3bfb : __ __ __ BYT 38 00 0c 12 30 7c 30 62 fc 00 38 45 08 83 70 c3 : 8...0|0b..8E..p.
3c0b : __ __ __ BYT 18 3c 7e 44 18 c6 00 10 30 7f 7f 30 84 48 06 84 : .<~D....0..0.H..
3c1b : __ __ __ BYT a6 84 c5 86 9c 84 4e c3 fe 44 fe 83 0c c2 10 2c : ......N..D.....,
3c2b : __ __ __ BYT 83 87 ca 68 10 00 62 66 0c 18 30 66 46 83 b6 c5 : ...h..bf..0fF...
3c3b : __ __ __ BYT 28 30 46 44 3a 83 30 c1 20 85 28 83 6d c5 20 20 : (0FD:.0. .(.m.  
3c4b : __ __ __ BYT 10 08 00 83 04 c1 08 83 0c 84 8f c1 fe 85 8f c1 : ................
3c5b : __ __ __ BYT 10 84 b9 89 5d 84 2d c1 7c 0a 83 19 c2 02 04 83 : ....].-.|.......
3c6b : __ __ __ BYT 2f c1 40 83 50 c5 4c 54 64 44 38 83 8f c1 70 83 : /.@.P.LTdD8...p.
3c7b : __ __ __ BYT 82 83 b8 c5 44 04 08 30 40 85 08 c2 18 04 83 18 : ....D..0@.......
3c8b : __ __ __ BYT cc 08 18 28 48 7c 08 08 00 7c 40 78 04 84 10 c5 : ...(H|...|@x....
3c9b : __ __ __ BYT 38 44 40 78 44 83 08 c3 7c 44 08 85 b3 c1 38 83 : 8D@xD...|D....8.
3cab : __ __ __ BYT 0d 84 10 83 05 c1 3c 84 20 85 5c 85 78 84 08 c3 : ......<. .\.x...
3cbb : __ __ __ BYT 10 20 0c 83 65 c3 20 10 0c 85 7f 84 81 c3 60 10 : . ..e. .......`.
3ccb : __ __ __ BYT 08 83 79 c1 60 85 68 c1 10 86 29 c2 ff ff 84 2e : ..y.`.h...).....
3cdb : __ __ __ BYT c3 28 44 7c 84 fc 83 5d 83 60 c1 78 84 68 c2 40 : .(D|...].`.x.h.@
3ceb : __ __ __ BYT 40 83 50 c2 70 48 83 16 c2 48 70 83 80 c3 40 78 : @.P.pH...Hp...@x
3cfb : __ __ __ BYT 40 83 98 86 08 84 b8 c2 40 4c 84 78 83 1e 85 38 : @.......@L.x...8
3d0b : __ __ __ BYT c1 38 45 10 c3 38 00 1c 44 08 cb 68 30 00 44 48 : .8E..8..D..h0.DH
3d1b : __ __ __ BYT 50 60 50 48 44 00 46 40 c5 7c 00 44 6c 54 44 44 : P`PHD.F@.|.DlTDD
3d2b : __ __ __ BYT c4 00 44 64 54 83 38 83 30 45 44 c1 38 85 70 86 : ..DdT.8.0ED.8.p.
3d3b : __ __ __ BYT 50 84 0f c1 0c 85 10 84 38 83 60 c1 38 84 d0 c1 : P.......8.`.8...
3d4b : __ __ __ BYT 7c 46 10 84 68 85 30 85 07 c1 28 86 10 c2 54 6c : |F..h.0...(...Tl
3d5b : __ __ __ BYT 83 50 83 0d c1 28 84 58 84 09 83 28 c1 7c 83 d7 : .P...(.X...(.|..
3d6b : __ __ __ BYT c1 20 83 70 c7 20 10 38 04 3c 44 3c 84 08 c6 44 : . .p. .8.<D<...D
3d7b : __ __ __ BYT 7c 40 3c 00 08 87 08 c4 20 10 00 30 84 a8 84 18 : |@<..... ..0....
3d8b : __ __ __ BYT 84 50 c2 20 10 84 4a c1 3c 03 c1 3c 83 87 c4 1c : .P. ..J.<..<....
3d9b : __ __ __ BYT 30 50 28 83 82 83 50 c3 30 48 48 83 fb c2 58 40 : 0P(...P.0HH...X@
3dab : __ __ __ BYT 83 5d 85 e0 c2 20 7c 84 f8 83 58 87 08 88 f0 88 : .]... |...X.....
3dbb : __ __ __ BYT c8 88 a0 48 10 48 28 05 c3 44 7c 00 00          : ...H.H(..D|..
--------------------------------------------------------------------
video_ram:
3dc8 : __ __ __ BYT 00 f4                                           : ..
--------------------------------------------------------------------
video_colorram:
3dca : __ __ __ BYT 00 d8                                           : ..
--------------------------------------------------------------------
advnm:
3dcc : __ __ __ BYT 41 44 56 43 41 52 54 52 49 44 47 45 00          : ADVCARTRIDGE.
--------------------------------------------------------------------
giocharmap:
3dd9 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
strcmd:
3dda : __ __ __ BYT a7 02                                           : ..
--------------------------------------------------------------------
text_y:
3ddc : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room:
3ddd : __ __ __ BYT fa                                              : .
--------------------------------------------------------------------
istack:
3dde : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
seed:
3ddf : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
align:
3de1 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
quit_request:
3de3 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
disknm:
3de4 : __ __ __ BYT 40 30 3a 53 41 56 45 00                         : @0:SAVE.
--------------------------------------------------------------------
slowmode:
3dec : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3ded : __ __ __ BYT 52 4f 4f 4d 30 31 2c 50 2c 52 00                : ROOM01,P,R.
--------------------------------------------------------------------
bitmap_image:
3df8 : __ __ __ BYT 00 e0                                           : ..
--------------------------------------------------------------------
nextroom:
3dfa : __ __ __ BYT fa                                              : .
--------------------------------------------------------------------
curimageid:
3dfb : __ __ __ BYT ff                                              : .
--------------------------------------------------------------------
icmd:
3dfc : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
hb_len:
3dfd : __ __ __ BSS	1
--------------------------------------------------------------------
advcartridge:
3dfe : __ __ __ BSS	2
--------------------------------------------------------------------
opcodeattr:
3e00 : __ __ __ BYT 82 83 81 81 83 01 01 01 01 81 82 82 82 02 03 02 : ................
3e10 : __ __ __ BYT 03 02 02 02 04 02 04 83 81 82 82 82 82 82 82 83 : ................
3e20 : __ __ __ BYT 03 83 81 81 82 83 84 83 83 83 83 83 82 81 82 83 : ................
3e30 : __ __ __ BYT 81 02                                           : ..
--------------------------------------------------------------------
ormask:
3e32 : __ __ __ BYT 01 02 04 08 10 20 40 80                         : ..... @.
--------------------------------------------------------------------
xormask:
3e3a : __ __ __ BYT fe fd fb f7 ef df bf 7f                         : ........
--------------------------------------------------------------------
tmp2:
3e42 : __ __ __ BSS	2
--------------------------------------------------------------------
freemem:
3e44 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_count:
3e46 : __ __ __ BSS	1
--------------------------------------------------------------------
obj_count:
3e47 : __ __ __ BSS	1
--------------------------------------------------------------------
shortdict:
3e48 : __ __ __ BSS	2
--------------------------------------------------------------------
advnames:
3e4a : __ __ __ BSS	2
--------------------------------------------------------------------
advdesc:
3e4c : __ __ __ BSS	2
--------------------------------------------------------------------
msgs:
3e4e : __ __ __ BSS	2
--------------------------------------------------------------------
msgs2:
3e50 : __ __ __ BSS	2
--------------------------------------------------------------------
verbs:
3e52 : __ __ __ BSS	2
--------------------------------------------------------------------
objs:
3e54 : __ __ __ BSS	2
--------------------------------------------------------------------
objs_dir:
3e56 : __ __ __ BSS	2
--------------------------------------------------------------------
rooms:
3e58 : __ __ __ BSS	2
--------------------------------------------------------------------
packdata:
3e5a : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_dir:
3e5c : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_data:
3e5e : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_pos:
3e60 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_len:
3e62 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_data:
3e64 : __ __ __ BSS	2
--------------------------------------------------------------------
roomnameid:
3e66 : __ __ __ BSS	2
--------------------------------------------------------------------
roomdescid:
3e68 : __ __ __ BSS	2
--------------------------------------------------------------------
roomimg:
3e6a : __ __ __ BSS	2
--------------------------------------------------------------------
roomovrimg:
3e6c : __ __ __ BSS	2
--------------------------------------------------------------------
objnameid:
3e6e : __ __ __ BSS	2
--------------------------------------------------------------------
objdescid:
3e70 : __ __ __ BSS	2
--------------------------------------------------------------------
objattr:
3e72 : __ __ __ BSS	2
--------------------------------------------------------------------
objloc:
3e74 : __ __ __ BSS	2
--------------------------------------------------------------------
objattrex:
3e76 : __ __ __ BSS	2
--------------------------------------------------------------------
roomstart:
3e78 : __ __ __ BSS	2
--------------------------------------------------------------------
roomattr:
3e7a : __ __ __ BSS	2
--------------------------------------------------------------------
roomattrex:
3e7c : __ __ __ BSS	2
--------------------------------------------------------------------
bitvars:
3e7e : __ __ __ BSS	2
--------------------------------------------------------------------
vars:
3e80 : __ __ __ BSS	2
--------------------------------------------------------------------
origram_len:
3e82 : __ __ __ BSS	2
--------------------------------------------------------------------
tmp:
3e84 : __ __ __ BSS	2
--------------------------------------------------------------------
vrb:
3e86 : __ __ __ BSS	2
--------------------------------------------------------------------
clearfull:
3e88 : __ __ __ BSS	1
--------------------------------------------------------------------
al:
3e89 : __ __ __ BSS	1
--------------------------------------------------------------------
newroom:
3e8a : __ __ __ BSS	1
--------------------------------------------------------------------
cmd:
3e8b : __ __ __ BSS	1
--------------------------------------------------------------------
obj1:
3e8c : __ __ __ BSS	1
--------------------------------------------------------------------
executed:
3e8d : __ __ __ BSS	1
--------------------------------------------------------------------
varroom:
3e8e : __ __ __ BSS	1
--------------------------------------------------------------------
opcode:
3e8f : __ __ __ BSS	1
--------------------------------------------------------------------
pcode:
3e90 : __ __ __ BSS	2
--------------------------------------------------------------------
pcodelen:
3e92 : __ __ __ BSS	2
--------------------------------------------------------------------
in:
3e94 : __ __ __ BSS	1
--------------------------------------------------------------------
fail:
3e95 : __ __ __ BSS	1
--------------------------------------------------------------------
used:
3e96 : __ __ __ BSS	1
--------------------------------------------------------------------
thisobj:
3e97 : __ __ __ BSS	1
--------------------------------------------------------------------
i:
3e98 : __ __ __ BSS	2
--------------------------------------------------------------------
varobj:
3e9a : __ __ __ BSS	1
--------------------------------------------------------------------
varmode:
3e9b : __ __ __ BSS	1
--------------------------------------------------------------------
var:
3e9c : __ __ __ BSS	1
--------------------------------------------------------------------
obj2:
3e9d : __ __ __ BSS	1
--------------------------------------------------------------------
ch:
3e9e : __ __ __ BSS	1
--------------------------------------------------------------------
str:
3e9f : __ __ __ BSS	2
--------------------------------------------------------------------
text_continue:
3ea1 : __ __ __ BSS	1
--------------------------------------------------------------------
strid:
3ea2 : __ __ __ BSS	1
--------------------------------------------------------------------
txt:
3ea3 : __ __ __ BSS	2
--------------------------------------------------------------------
varattr:
3ea5 : __ __ __ BSS	1
--------------------------------------------------------------------
a:
3ea6 : __ __ __ BSS	1
--------------------------------------------------------------------
_strid:
3ea7 : __ __ __ BSS	1
--------------------------------------------------------------------
ostr:
3ea8 : __ __ __ BSS	2
--------------------------------------------------------------------
len:
3eaa : __ __ __ BSS	1
--------------------------------------------------------------------
etxt:
3eab : __ __ __ BSS	2
--------------------------------------------------------------------
txt_col:
3ead : __ __ __ BSS	1
--------------------------------------------------------------------
text_attach:
3eae : __ __ __ BSS	1
--------------------------------------------------------------------
txt_rev:
3eaf : __ __ __ BSS	1
--------------------------------------------------------------------
txt_x:
3eb0 : __ __ __ BSS	1
--------------------------------------------------------------------
txt_y:
3eb1 : __ __ __ BSS	1
--------------------------------------------------------------------
_ch:
3eb2 : __ __ __ BSS	1
--------------------------------------------------------------------
_ech:
3eb3 : __ __ __ BSS	1
--------------------------------------------------------------------
_cplx:
3eb4 : __ __ __ BSS	1
--------------------------------------------------------------------
_cplw:
3eb5 : __ __ __ BSS	1
--------------------------------------------------------------------
_cpl:
3eb6 : __ __ __ BSS	2
--------------------------------------------------------------------
ll:
3eb8 : __ __ __ BSS	2
--------------------------------------------------------------------
spl:
3eba : __ __ __ BSS	2
--------------------------------------------------------------------
u:
3ebc : __ __ __ BSS	1
--------------------------------------------------------------------
v:
3ebd : __ __ __ BSS	1
--------------------------------------------------------------------
_buffer:
3ebe : __ __ __ BSS	42
--------------------------------------------------------------------
btxt:
3ee8 : __ __ __ BSS	2
--------------------------------------------------------------------
b_cpl:
3eea : __ __ __ BSS	2
--------------------------------------------------------------------
b_cplx:
3eec : __ __ __ BSS	1
--------------------------------------------------------------------
b_cplw:
3eed : __ __ __ BSS	1
--------------------------------------------------------------------
diskmemlow:
3eee : __ __ __ BSS	1
--------------------------------------------------------------------
diskmemhi:
3eef : __ __ __ BSS	1
--------------------------------------------------------------------
ediskmemlow:
3ef0 : __ __ __ BSS	1
--------------------------------------------------------------------
ediskmemhi:
3ef1 : __ __ __ BSS	1
--------------------------------------------------------------------
saved:
3ef2 : __ __ __ BSS	1
--------------------------------------------------------------------
key:
3ef3 : __ __ __ BSS	1
--------------------------------------------------------------------
imageid:
3ef4 : __ __ __ BSS	1
--------------------------------------------------------------------
obj1k:
3ef5 : __ __ __ BSS	1
--------------------------------------------------------------------
obj2k:
3ef6 : __ __ __ BSS	1
--------------------------------------------------------------------
strdir:
3ef7 : __ __ __ BSS	2
--------------------------------------------------------------------
cmdid:
3ef9 : __ __ __ BSS	1
--------------------------------------------------------------------
blink:
3efa : __ __ __ BSS	1
--------------------------------------------------------------------
_cbuffer:
3f00 : __ __ __ BSS	42
--------------------------------------------------------------------
krnio_pstatus:
3f2a : __ __ __ BSS	16
