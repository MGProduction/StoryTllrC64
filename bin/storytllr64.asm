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
080e : 8e e4 3a STX $3ae4 ; (spentry + 0)
0811 : a9 d7 __ LDA #$d7
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
0830 : a9 cd __ LDA #$cd
0832 : e9 d7 __ SBC #$d7
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
0935 : ad 62 3d LDA $3d62 ; (video_ram + 0)
0938 : 18 __ __ CLC
0939 : 69 e0 __ ADC #$e0
093b : 85 0d __ STA P0 
093d : ad 63 3d LDA $3d63 ; (video_ram + 1)
0940 : 69 01 __ ADC #$01
0942 : 85 0e __ STA P1 
0944 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
0947 : a9 00 __ LDA #$00
0949 : 85 0f __ STA P2 
094b : 85 10 __ STA P3 
094d : 85 12 __ STA P5 
094f : a9 50 __ LDA #$50
0951 : 85 11 __ STA P4 
0953 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
0956 : 18 __ __ CLC
0957 : 69 e0 __ ADC #$e0
0959 : 85 0d __ STA P0 
095b : ad 65 3d LDA $3d65 ; (video_colorram + 1)
095e : 69 01 __ ADC #$01
0960 : 85 0e __ STA P1 
0962 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
.l124:
0965 : 2c 11 d0 BIT $d011 
0968 : 10 fb __ BPL $0965 ; (main.l124 + 0)
.s6:
096a : 20 b1 11 JSR $11b1 ; (IRQ_gfx_init.s0 + 0)
096d : ad 74 3d LDA $3d74 ; (strcmd + 0)
0970 : 85 43 __ STA T0 + 0 
0972 : ad 75 3d LDA $3d75 ; (strcmd + 1)
0975 : 85 44 __ STA T0 + 1 
0977 : a9 00 __ LDA #$00
0979 : 8d 20 d0 STA $d020 
097c : a8 __ __ TAY
097d : 91 43 __ STA (T0 + 0),y 
097f : 20 47 12 JSR $1247 ; (clean.s0 + 0)
0982 : 20 69 12 JSR $1269 ; (adv_start.s0 + 0)
.l11:
0985 : 20 e9 32 JSR $32e9 ; (parser_update.s0 + 0)
0988 : a9 00 __ LDA #$00
098a : 8d 36 3e STA $3e36 ; (ch + 0)
098d : 8d ad 3d STA $3dad ; (quit_request + 0)
.l14:
0990 : 20 9f ff JSR $ff9f 
0993 : 20 e4 ff JSR $ffe4 
0996 : 8d 36 3e STA $3e36 ; (ch + 0)
0999 : ad 36 3e LDA $3e36 ; (ch + 0)
099c : d0 06 __ BNE $09a4 ; (main.s16 + 0)
.s17:
099e : 20 52 39 JSR $3952 ; (do_blink.s0 + 0)
09a1 : 4c f9 09 JMP $09f9 ; (main.l127 + 0)
.s16:
09a4 : 85 53 __ STA T1 + 0 
09a6 : 20 ad 33 JSR $33ad ; (hide_blink.s0 + 0)
09a9 : a5 53 __ LDA T1 + 0 
09ab : c9 0d __ CMP #$0d
09ad : d0 06 __ BNE $09b5 ; (main.s20 + 0)
.s19:
09af : 20 e9 33 JSR $33e9 ; (execute.s1000 + 0)
09b2 : 4c f9 09 JMP $09f9 ; (main.l127 + 0)
.s20:
09b5 : c9 91 __ CMP #$91
09b7 : f0 40 __ BEQ $09f9 ; (main.l127 + 0)
.s23:
09b9 : c9 14 __ CMP #$14
09bb : d0 03 __ BNE $09c0 ; (main.s26 + 0)
09bd : 4c 49 0a JMP $0a49 ; (main.s25 + 0)
.s26:
09c0 : ad d6 3d LDA $3dd6 ; (icmd + 0)
09c3 : c9 50 __ CMP #$50
09c5 : b0 2f __ BCS $09f6 ; (main.s136 + 0)
.s31:
09c7 : 85 54 __ STA T2 + 0 
09c9 : a5 53 __ LDA T1 + 0 
09cb : 20 25 39 JSR $3925 ; (charmap.s0 + 0)
09ce : 8d 36 3e STA $3e36 ; (ch + 0)
09d1 : 09 00 __ ORA #$00
09d3 : f0 21 __ BEQ $09f6 ; (main.s136 + 0)
.s34:
09d5 : 18 __ __ CLC
09d6 : a5 54 __ LDA T2 + 0 
09d8 : 69 01 __ ADC #$01
09da : 85 43 __ STA T0 + 0 
09dc : 8d d6 3d STA $3dd6 ; (icmd + 0)
09df : ad 74 3d LDA $3d74 ; (strcmd + 0)
09e2 : 85 45 __ STA T3 + 0 
09e4 : ad 75 3d LDA $3d75 ; (strcmd + 1)
09e7 : 85 46 __ STA T3 + 1 
09e9 : ad 36 3e LDA $3e36 ; (ch + 0)
09ec : a4 54 __ LDY T2 + 0 
09ee : 91 45 __ STA (T3 + 0),y 
.s137:
09f0 : a9 00 __ LDA #$00
09f2 : a4 43 __ LDY T0 + 0 
09f4 : 91 45 __ STA (T3 + 0),y 
.s136:
09f6 : 20 e9 32 JSR $32e9 ; (parser_update.s0 + 0)
.l127:
09f9 : 2c 11 d0 BIT $d011 
09fc : 10 fb __ BPL $09f9 ; (main.l127 + 0)
.s13:
09fe : ad ad 3d LDA $3dad ; (quit_request + 0)
0a01 : f0 8d __ BEQ $0990 ; (main.l14 + 0)
.s15:
0a03 : c9 02 __ CMP #$02
0a05 : b0 06 __ BCS $0a0d ; (main.s41 + 0)
.s12:
0a07 : 20 5b 3a JSR $3a5b ; (os_reset.s0 + 0)
0a0a : 4c 38 0a JMP $0a38 ; (main.s1001 + 0)
.s41:
0a0d : d0 06 __ BNE $0a15 ; (main.s45 + 0)
.s44:
0a0f : 20 bb 39 JSR $39bb ; (adv_reset.s0 + 0)
0a12 : 4c 1c 0a JMP $0a1c ; (main.s51 + 0)
.s45:
0a15 : 20 da 39 JSR $39da ; (adv_load.s0 + 0)
0a18 : a5 1b __ LDA ACCU + 0 
0a1a : f0 14 __ BEQ $0a30 ; (main.s135 + 0)
.s51:
0a1c : ad 10 3e LDA $3e10 ; (roomstart + 0)
0a1f : 85 43 __ STA T0 + 0 
0a21 : ad 11 3e LDA $3e11 ; (roomstart + 1)
0a24 : 85 44 __ STA T0 + 1 
0a26 : a0 00 __ LDY #$00
0a28 : b1 43 __ LDA (T0 + 0),y 
0a2a : 8d 22 3e STA $3e22 ; (newroom + 0)
0a2d : 20 09 13 JSR $1309 ; (room_load.s1000 + 0)
.s135:
0a30 : a9 00 __ LDA #$00
0a32 : 8d ad 3d STA $3dad ; (quit_request + 0)
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
0a49 : ad d6 3d LDA $3dd6 ; (icmd + 0)
0a4c : f0 a8 __ BEQ $09f6 ; (main.s136 + 0)
.s28:
0a4e : 38 __ __ SEC
0a4f : e9 01 __ SBC #$01
0a51 : 8d d6 3d STA $3dd6 ; (icmd + 0)
0a54 : 85 43 __ STA T0 + 0 
0a56 : ad 74 3d LDA $3d74 ; (strcmd + 0)
0a59 : 85 45 __ STA T3 + 0 
0a5b : ad 75 3d LDA $3d75 ; (strcmd + 1)
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
0aa5 : ad 62 3d LDA $3d62 ; (video_ram + 0)
0aa8 : 85 0d __ STA P0 
0aaa : ad 63 3d LDA $3d63 ; (video_ram + 1)
0aad : 85 0e __ STA P1 
0aaf : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
0ab2 : a9 00 __ LDA #$00
0ab4 : 85 0f __ STA P2 
0ab6 : 85 10 __ STA P3 
0ab8 : a9 e8 __ LDA #$e8
0aba : 85 11 __ STA P4 
0abc : a9 03 __ LDA #$03
0abe : 85 12 __ STA P5 
0ac0 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
0ac3 : 85 0d __ STA P0 
0ac5 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
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
0ad7 : a9 e5 __ LDA #$e5
0ad9 : 85 0d __ STA P0 
0adb : a9 3a __ LDA #$3a
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
0b5b : 8d d7 3d STA $3dd7 ; (hb_len + 0)
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
0b73 : ad d7 3d LDA $3dd7 ; (hb_len + 0)
0b76 : c9 3f __ CMP #$3f
0b78 : d0 13 __ BNE $0b8d ; (hunpack.s6 + 0)
.s4:
0b7a : c8 __ __ INY
0b7b : b1 47 __ LDA (T5 + 0),y 
0b7d : 8d d7 3d STA $3dd7 ; (hb_len + 0)
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
0ba4 : ad d7 3d LDA $3dd7 ; (hb_len + 0)
0ba7 : ce d7 3d DEC $3dd7 ; (hb_len + 0)
0baa : 09 00 __ ORA #$00
0bac : f0 24 __ BEQ $0bd2 ; (hunpack.s1 + 0)
.s35:
0bae : a5 0f __ LDA P2 ; (pbuf + 0)
0bb0 : 85 47 __ STA T5 + 0 
0bb2 : a4 1b __ LDY ACCU + 0 
0bb4 : ae d7 3d LDX $3dd7 ; (hb_len + 0)
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
0bcf : 8e d7 3d STX $3dd7 ; (hb_len + 0)
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
0bf8 : ae d7 3d LDX $3dd7 ; (hb_len + 0)
0bfb : ce d7 3d DEC $3dd7 ; (hb_len + 0)
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
0c0d : ae d7 3d LDX $3dd7 ; (hb_len + 0)
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
0c3b : ae d7 3d LDX $3dd7 ; (hb_len + 0)
0c3e : ce d7 3d DEC $3dd7 ; (hb_len + 0)
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
0c62 : ae d7 3d LDX $3dd7 ; (hb_len + 0)
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
0c8e : ad d7 3d LDA $3dd7 ; (hb_len + 0)
0c91 : ce d7 3d DEC $3dd7 ; (hb_len + 0)
0c94 : 09 00 __ ORA #$00
0c96 : d0 03 __ BNE $0c9b ; (hunpack.s32 + 0)
0c98 : 4c d2 0b JMP $0bd2 ; (hunpack.s1 + 0)
.s32:
0c9b : a5 0f __ LDA P2 ; (pbuf + 0)
0c9d : 85 47 __ STA T5 + 0 
0c9f : a5 0d __ LDA P0 ; (buf + 0)
0ca1 : 85 49 __ STA T6 + 0 
0ca3 : ae d7 3d LDX $3dd7 ; (hb_len + 0)
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
0d61 : ad 62 3d LDA $3d62 ; (video_ram + 0)
0d64 : 18 __ __ CLC
0d65 : 69 e0 __ ADC #$e0
0d67 : aa __ __ TAX
0d68 : ad 63 3d LDA $3d63 ; (video_ram + 1)
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
0d79 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
0d7c : 18 __ __ CLC
0d7d : 69 e0 __ ADC #$e0
0d7f : aa __ __ TAX
0d80 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
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
0dd4 : 8d d8 3d STA $3dd8 ; (advcartridge + 0)
0dd7 : a9 40 __ LDA #$40
0dd9 : 8d d9 3d STA $3dd9 ; (advcartridge + 1)
0ddc : 20 4b 0e JSR $0e4b ; (irq_border_on.s0 + 0)
0ddf : a9 01 __ LDA #$01
0de1 : a6 ba __ LDX $ba 
0de3 : d0 02 __ BNE $0de7 ; (loadcartridge.s0 + 21)
0de5 : a2 08 __ LDX #$08
0de7 : a0 00 __ LDY #$00
0de9 : 20 ba ff JSR $ffba 
0dec : a9 0c __ LDA #$0c
0dee : a2 66 __ LDX #$66
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
0e0e : ad d8 3d LDA $3dd8 ; (advcartridge + 0)
0e11 : 85 43 __ STA T0 + 0 
0e13 : 18 __ __ CLC
0e14 : 69 02 __ ADC #$02
0e16 : 8d d8 3d STA $3dd8 ; (advcartridge + 0)
0e19 : ad d9 3d LDA $3dd9 ; (advcartridge + 1)
0e1c : 85 44 __ STA T0 + 1 
0e1e : 69 00 __ ADC #$00
0e20 : 8d d9 3d STA $3dd9 ; (advcartridge + 1)
0e23 : a0 01 __ LDY #$01
0e25 : b1 43 __ LDA (T0 + 0),y 
0e27 : 85 14 __ STA P7 
0e29 : 18 __ __ CLC
0e2a : 88 __ __ DEY
0e2b : b1 43 __ LDA (T0 + 0),y 
0e2d : 85 13 __ STA P6 
0e2f : 6d d8 3d ADC $3dd8 ; (advcartridge + 0)
0e32 : 8d da 3d STA $3dda ; (tmp2 + 0)
0e35 : ad d9 3d LDA $3dd9 ; (advcartridge + 1)
0e38 : 65 14 __ ADC P7 
0e3a : 8d db 3d STA $3ddb ; (tmp2 + 1)
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
0e6e : ad d8 3d LDA $3dd8 ; (advcartridge + 0)
0e71 : aa __ __ TAX
0e72 : 18 __ __ CLC
0e73 : 65 13 __ ADC P6 ; (iln + 0)
0e75 : 85 45 __ STA T1 + 0 
0e77 : ad d9 3d LDA $3dd9 ; (advcartridge + 1)
0e7a : 85 44 __ STA T0 + 1 
0e7c : 65 14 __ ADC P7 ; (iln + 1)
0e7e : 85 46 __ STA T1 + 1 
0e80 : 38 __ __ SEC
0e81 : a9 80 __ LDA #$80
0e83 : e5 45 __ SBC T1 + 0 
0e85 : 8d dc 3d STA $3ddc ; (freemem + 0)
0e88 : a9 cb __ LDA #$cb
0e8a : e5 46 __ SBC T1 + 1 
0e8c : 8d dd 3d STA $3ddd ; (freemem + 1)
0e8f : ad da 3d LDA $3dda ; (tmp2 + 0)
0e92 : 85 45 __ STA T1 + 0 
0e94 : ad db 3d LDA $3ddb ; (tmp2 + 1)
0e97 : 85 46 __ STA T1 + 1 
0e99 : a0 02 __ LDY #$02
0e9b : b1 45 __ LDA (T1 + 0),y 
0e9d : 8d de 3d STA $3dde ; (opcode_vrbidx_count + 0)
0ea0 : a0 04 __ LDY #$04
0ea2 : b1 45 __ LDA (T1 + 0),y 
0ea4 : 8d df 3d STA $3ddf ; (obj_count + 0)
0ea7 : 8a __ __ TXA
0ea8 : 18 __ __ CLC
0ea9 : a0 0a __ LDY #$0a
0eab : 71 45 __ ADC (T1 + 0),y 
0ead : 8d e0 3d STA $3de0 ; (shortdict + 0)
0eb0 : a5 44 __ LDA T0 + 1 
0eb2 : c8 __ __ INY
0eb3 : 71 45 __ ADC (T1 + 0),y 
0eb5 : 8d e1 3d STA $3de1 ; (shortdict + 1)
0eb8 : 8a __ __ TXA
0eb9 : 18 __ __ CLC
0eba : c8 __ __ INY
0ebb : 71 45 __ ADC (T1 + 0),y 
0ebd : 8d e2 3d STA $3de2 ; (advnames + 0)
0ec0 : a5 44 __ LDA T0 + 1 
0ec2 : c8 __ __ INY
0ec3 : 71 45 __ ADC (T1 + 0),y 
0ec5 : 8d e3 3d STA $3de3 ; (advnames + 1)
0ec8 : 8a __ __ TXA
0ec9 : 18 __ __ CLC
0eca : c8 __ __ INY
0ecb : 71 45 __ ADC (T1 + 0),y 
0ecd : 8d e4 3d STA $3de4 ; (advdesc + 0)
0ed0 : a5 44 __ LDA T0 + 1 
0ed2 : c8 __ __ INY
0ed3 : 71 45 __ ADC (T1 + 0),y 
0ed5 : 8d e5 3d STA $3de5 ; (advdesc + 1)
0ed8 : 8a __ __ TXA
0ed9 : 18 __ __ CLC
0eda : c8 __ __ INY
0edb : 71 45 __ ADC (T1 + 0),y 
0edd : 8d e6 3d STA $3de6 ; (msgs + 0)
0ee0 : a5 44 __ LDA T0 + 1 
0ee2 : c8 __ __ INY
0ee3 : 71 45 __ ADC (T1 + 0),y 
0ee5 : 8d e7 3d STA $3de7 ; (msgs + 1)
0ee8 : 8a __ __ TXA
0ee9 : 18 __ __ CLC
0eea : c8 __ __ INY
0eeb : 71 45 __ ADC (T1 + 0),y 
0eed : 8d e8 3d STA $3de8 ; (msgs2 + 0)
0ef0 : a5 44 __ LDA T0 + 1 
0ef2 : c8 __ __ INY
0ef3 : 71 45 __ ADC (T1 + 0),y 
0ef5 : 8d e9 3d STA $3de9 ; (msgs2 + 1)
0ef8 : 8a __ __ TXA
0ef9 : 18 __ __ CLC
0efa : c8 __ __ INY
0efb : 71 45 __ ADC (T1 + 0),y 
0efd : 8d ea 3d STA $3dea ; (verbs + 0)
0f00 : a5 44 __ LDA T0 + 1 
0f02 : c8 __ __ INY
0f03 : 71 45 __ ADC (T1 + 0),y 
0f05 : 8d eb 3d STA $3deb ; (verbs + 1)
0f08 : 8a __ __ TXA
0f09 : 18 __ __ CLC
0f0a : c8 __ __ INY
0f0b : 71 45 __ ADC (T1 + 0),y 
0f0d : 8d ec 3d STA $3dec ; (objs + 0)
0f10 : a5 44 __ LDA T0 + 1 
0f12 : c8 __ __ INY
0f13 : 71 45 __ ADC (T1 + 0),y 
0f15 : 8d ed 3d STA $3ded ; (objs + 1)
0f18 : 8a __ __ TXA
0f19 : 18 __ __ CLC
0f1a : c8 __ __ INY
0f1b : 71 45 __ ADC (T1 + 0),y 
0f1d : 8d ee 3d STA $3dee ; (objs_dir + 0)
0f20 : a5 44 __ LDA T0 + 1 
0f22 : c8 __ __ INY
0f23 : 71 45 __ ADC (T1 + 0),y 
0f25 : 8d ef 3d STA $3def ; (objs_dir + 1)
0f28 : 8a __ __ TXA
0f29 : 18 __ __ CLC
0f2a : c8 __ __ INY
0f2b : 71 45 __ ADC (T1 + 0),y 
0f2d : 8d f0 3d STA $3df0 ; (rooms + 0)
0f30 : a5 44 __ LDA T0 + 1 
0f32 : c8 __ __ INY
0f33 : 71 45 __ ADC (T1 + 0),y 
0f35 : 8d f1 3d STA $3df1 ; (rooms + 1)
0f38 : 8a __ __ TXA
0f39 : 18 __ __ CLC
0f3a : c8 __ __ INY
0f3b : 71 45 __ ADC (T1 + 0),y 
0f3d : 8d f2 3d STA $3df2 ; (packdata + 0)
0f40 : a5 44 __ LDA T0 + 1 
0f42 : c8 __ __ INY
0f43 : 71 45 __ ADC (T1 + 0),y 
0f45 : 8d f3 3d STA $3df3 ; (packdata + 1)
0f48 : 8a __ __ TXA
0f49 : 18 __ __ CLC
0f4a : c8 __ __ INY
0f4b : 71 45 __ ADC (T1 + 0),y 
0f4d : 8d f4 3d STA $3df4 ; (opcode_vrbidx_dir + 0)
0f50 : a5 44 __ LDA T0 + 1 
0f52 : c8 __ __ INY
0f53 : 71 45 __ ADC (T1 + 0),y 
0f55 : 8d f5 3d STA $3df5 ; (opcode_vrbidx_dir + 1)
0f58 : 8a __ __ TXA
0f59 : 18 __ __ CLC
0f5a : c8 __ __ INY
0f5b : 71 45 __ ADC (T1 + 0),y 
0f5d : 8d f6 3d STA $3df6 ; (opcode_vrbidx_data + 0)
0f60 : a5 44 __ LDA T0 + 1 
0f62 : c8 __ __ INY
0f63 : 71 45 __ ADC (T1 + 0),y 
0f65 : 8d f7 3d STA $3df7 ; (opcode_vrbidx_data + 1)
0f68 : 8a __ __ TXA
0f69 : 18 __ __ CLC
0f6a : c8 __ __ INY
0f6b : 71 45 __ ADC (T1 + 0),y 
0f6d : 8d f8 3d STA $3df8 ; (opcode_pos + 0)
0f70 : a5 44 __ LDA T0 + 1 
0f72 : c8 __ __ INY
0f73 : 71 45 __ ADC (T1 + 0),y 
0f75 : 8d f9 3d STA $3df9 ; (opcode_pos + 1)
0f78 : 8a __ __ TXA
0f79 : 18 __ __ CLC
0f7a : c8 __ __ INY
0f7b : 71 45 __ ADC (T1 + 0),y 
0f7d : 8d fa 3d STA $3dfa ; (opcode_len + 0)
0f80 : a5 44 __ LDA T0 + 1 
0f82 : c8 __ __ INY
0f83 : 71 45 __ ADC (T1 + 0),y 
0f85 : 8d fb 3d STA $3dfb ; (opcode_len + 1)
0f88 : 8a __ __ TXA
0f89 : 18 __ __ CLC
0f8a : c8 __ __ INY
0f8b : 71 45 __ ADC (T1 + 0),y 
0f8d : 8d fc 3d STA $3dfc ; (opcode_data + 0)
0f90 : a5 44 __ LDA T0 + 1 
0f92 : c8 __ __ INY
0f93 : 71 45 __ ADC (T1 + 0),y 
0f95 : 8d fd 3d STA $3dfd ; (opcode_data + 1)
0f98 : 8a __ __ TXA
0f99 : 18 __ __ CLC
0f9a : c8 __ __ INY
0f9b : 71 45 __ ADC (T1 + 0),y 
0f9d : 8d fe 3d STA $3dfe ; (roomnameid + 0)
0fa0 : a5 44 __ LDA T0 + 1 
0fa2 : c8 __ __ INY
0fa3 : 71 45 __ ADC (T1 + 0),y 
0fa5 : 8d ff 3d STA $3dff ; (roomnameid + 1)
0fa8 : 8a __ __ TXA
0fa9 : 18 __ __ CLC
0faa : c8 __ __ INY
0fab : 71 45 __ ADC (T1 + 0),y 
0fad : 8d 00 3e STA $3e00 ; (roomdescid + 0)
0fb0 : a5 44 __ LDA T0 + 1 
0fb2 : c8 __ __ INY
0fb3 : 71 45 __ ADC (T1 + 0),y 
0fb5 : 8d 01 3e STA $3e01 ; (roomdescid + 1)
0fb8 : 8a __ __ TXA
0fb9 : 18 __ __ CLC
0fba : c8 __ __ INY
0fbb : 71 45 __ ADC (T1 + 0),y 
0fbd : 8d 02 3e STA $3e02 ; (roomimg + 0)
0fc0 : a5 44 __ LDA T0 + 1 
0fc2 : c8 __ __ INY
0fc3 : 71 45 __ ADC (T1 + 0),y 
0fc5 : 8d 03 3e STA $3e03 ; (roomimg + 1)
0fc8 : 8a __ __ TXA
0fc9 : 18 __ __ CLC
0fca : c8 __ __ INY
0fcb : 71 45 __ ADC (T1 + 0),y 
0fcd : 85 47 __ STA T2 + 0 
0fcf : a5 44 __ LDA T0 + 1 
0fd1 : c8 __ __ INY
0fd2 : 71 45 __ ADC (T1 + 0),y 
0fd4 : 85 48 __ STA T2 + 1 
0fd6 : 8d 05 3e STA $3e05 ; (roomovrimg + 1)
0fd9 : a5 47 __ LDA T2 + 0 
0fdb : 8d 04 3e STA $3e04 ; (roomovrimg + 0)
0fde : 8a __ __ TXA
0fdf : 18 __ __ CLC
0fe0 : c8 __ __ INY
0fe1 : 71 45 __ ADC (T1 + 0),y 
0fe3 : 8d 06 3e STA $3e06 ; (objnameid + 0)
0fe6 : a5 44 __ LDA T0 + 1 
0fe8 : c8 __ __ INY
0fe9 : 71 45 __ ADC (T1 + 0),y 
0feb : 8d 07 3e STA $3e07 ; (objnameid + 1)
0fee : 8a __ __ TXA
0fef : 18 __ __ CLC
0ff0 : c8 __ __ INY
0ff1 : 71 45 __ ADC (T1 + 0),y 
0ff3 : 8d 08 3e STA $3e08 ; (objdescid + 0)
0ff6 : a5 44 __ LDA T0 + 1 
0ff8 : c8 __ __ INY
0ff9 : 71 45 __ ADC (T1 + 0),y 
0ffb : 8d 09 3e STA $3e09 ; (objdescid + 1)
0ffe : 8a __ __ TXA
0fff : 18 __ __ CLC
1000 : a0 36 __ LDY #$36
1002 : 71 45 __ ADC (T1 + 0),y 
1004 : 85 0f __ STA P2 
1006 : a5 44 __ LDA T0 + 1 
1008 : c8 __ __ INY
1009 : 71 45 __ ADC (T1 + 0),y 
100b : 85 10 __ STA P3 
100d : 8d 0b 3e STA $3e0b ; (objattr + 1)
1010 : a5 0f __ LDA P2 
1012 : 8d 0a 3e STA $3e0a ; (objattr + 0)
1015 : 8a __ __ TXA
1016 : 18 __ __ CLC
1017 : c8 __ __ INY
1018 : 71 45 __ ADC (T1 + 0),y 
101a : 8d 0c 3e STA $3e0c ; (objloc + 0)
101d : a5 44 __ LDA T0 + 1 
101f : c8 __ __ INY
1020 : 71 45 __ ADC (T1 + 0),y 
1022 : 8d 0d 3e STA $3e0d ; (objloc + 1)
1025 : 8a __ __ TXA
1026 : 18 __ __ CLC
1027 : c8 __ __ INY
1028 : 71 45 __ ADC (T1 + 0),y 
102a : 85 49 __ STA T5 + 0 
102c : a5 44 __ LDA T0 + 1 
102e : c8 __ __ INY
102f : 71 45 __ ADC (T1 + 0),y 
1031 : 85 4a __ STA T5 + 1 
1033 : 8d 0f 3e STA $3e0f ; (objattrex + 1)
1036 : a5 49 __ LDA T5 + 0 
1038 : 8d 0e 3e STA $3e0e ; (objattrex + 0)
103b : 8a __ __ TXA
103c : 18 __ __ CLC
103d : c8 __ __ INY
103e : 71 45 __ ADC (T1 + 0),y 
1040 : 8d 10 3e STA $3e10 ; (roomstart + 0)
1043 : a5 44 __ LDA T0 + 1 
1045 : c8 __ __ INY
1046 : 71 45 __ ADC (T1 + 0),y 
1048 : 8d 11 3e STA $3e11 ; (roomstart + 1)
104b : 8a __ __ TXA
104c : 18 __ __ CLC
104d : c8 __ __ INY
104e : 71 45 __ ADC (T1 + 0),y 
1050 : 85 4b __ STA T6 + 0 
1052 : a5 44 __ LDA T0 + 1 
1054 : c8 __ __ INY
1055 : 71 45 __ ADC (T1 + 0),y 
1057 : 85 4c __ STA T6 + 1 
1059 : 8d 13 3e STA $3e13 ; (roomattr + 1)
105c : a5 4b __ LDA T6 + 0 
105e : 8d 12 3e STA $3e12 ; (roomattr + 0)
1061 : 8a __ __ TXA
1062 : 18 __ __ CLC
1063 : c8 __ __ INY
1064 : 71 45 __ ADC (T1 + 0),y 
1066 : 85 4d __ STA T7 + 0 
1068 : a5 44 __ LDA T0 + 1 
106a : c8 __ __ INY
106b : 71 45 __ ADC (T1 + 0),y 
106d : 85 4e __ STA T7 + 1 
106f : 8d 15 3e STA $3e15 ; (roomattrex + 1)
1072 : a5 4d __ LDA T7 + 0 
1074 : 8d 14 3e STA $3e14 ; (roomattrex + 0)
1077 : 8a __ __ TXA
1078 : 18 __ __ CLC
1079 : c8 __ __ INY
107a : 71 45 __ ADC (T1 + 0),y 
107c : 85 4f __ STA T8 + 0 
107e : a5 44 __ LDA T0 + 1 
1080 : c8 __ __ INY
1081 : 71 45 __ ADC (T1 + 0),y 
1083 : 85 50 __ STA T8 + 1 
1085 : 8d 17 3e STA $3e17 ; (bitvars + 1)
1088 : a5 4f __ LDA T8 + 0 
108a : 8d 16 3e STA $3e16 ; (bitvars + 0)
108d : 8a __ __ TXA
108e : 18 __ __ CLC
108f : c8 __ __ INY
1090 : 71 45 __ ADC (T1 + 0),y 
1092 : 8d 18 3e STA $3e18 ; (vars + 0)
1095 : a5 44 __ LDA T0 + 1 
1097 : c8 __ __ INY
1098 : 71 45 __ ADC (T1 + 0),y 
109a : 8d 19 3e STA $3e19 ; (vars + 1)
109d : 18 __ __ CLC
109e : a5 45 __ LDA T1 + 0 
10a0 : 69 48 __ ADC #$48
10a2 : 8d da 3d STA $3dda ; (tmp2 + 0)
10a5 : a5 46 __ LDA T1 + 1 
10a7 : 69 00 __ ADC #$00
10a9 : 8d db 3d STA $3ddb ; (tmp2 + 1)
10ac : c8 __ __ INY
10ad : b1 45 __ LDA (T1 + 0),y 
10af : 85 11 __ STA P4 
10b1 : c8 __ __ INY
10b2 : b1 45 __ LDA (T1 + 0),y 
10b4 : 85 12 __ STA P5 
10b6 : 8d 1b 3e STA $3e1b ; (origram_len + 1)
10b9 : a5 11 __ LDA P4 
10bb : 8d 1a 3e STA $3e1a ; (origram_len + 0)
10be : a9 00 __ LDA #$00
10c0 : 85 0d __ STA P0 
10c2 : a9 05 __ LDA #$05
10c4 : 85 0e __ STA P1 
10c6 : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
10c9 : a9 00 __ LDA #$00
10cb : 8d 1c 3e STA $3e1c ; (tmp + 0)
10ce : a9 04 __ LDA #$04
10d0 : 8d 1d 3e STA $3e1d ; (tmp + 1)
10d3 : 8d 1f 3e STA $3e1f ; (vrb + 1)
10d6 : 8d db 3d STA $3ddb ; (tmp2 + 1)
10d9 : a9 28 __ LDA #$28
10db : 8d 1e 3e STA $3e1e ; (vrb + 0)
10de : a9 32 __ LDA #$32
10e0 : 8d da 3d STA $3dda ; (tmp2 + 0)
10e3 : a5 48 __ LDA T2 + 1 
10e5 : c5 4c __ CMP T6 + 1 
10e7 : d0 0e __ BNE $10f7 ; (setupcartridge.s6 + 0)
.s1008:
10e9 : a5 47 __ LDA T2 + 0 
10eb : c5 4b __ CMP T6 + 0 
10ed : d0 08 __ BNE $10f7 ; (setupcartridge.s6 + 0)
.s1:
10ef : a9 00 __ LDA #$00
10f1 : 8d 04 3e STA $3e04 ; (roomovrimg + 0)
10f4 : 8d 05 3e STA $3e05 ; (roomovrimg + 1)
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
1105 : 8d 14 3e STA $3e14 ; (roomattrex + 0)
1108 : 8d 15 3e STA $3e15 ; (roomattrex + 1)
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
1119 : 8d 0e 3e STA $3e0e ; (objattrex + 0)
111c : 8d 0f 3e STA $3e0f ; (objattrex + 1)
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
113d : ae 73 3d LDX $3d73 ; (giocharmap + 0)
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
126b : 8d 20 3e STA $3e20 ; (clearfull + 0)
126e : 20 85 12 JSR $1285 ; (ui_clear.s0 + 0)
1271 : ad 10 3e LDA $3e10 ; (roomstart + 0)
1274 : 85 43 __ STA T0 + 0 
1276 : ad 11 3e LDA $3e11 ; (roomstart + 1)
1279 : 85 44 __ STA T0 + 1 
127b : a0 00 __ LDY #$00
127d : b1 43 __ LDA (T0 + 0),y 
127f : 8d 22 3e STA $3e22 ; (newroom + 0)
1282 : 4c 09 13 JMP $1309 ; (room_load.s1000 + 0)
--------------------------------------------------------------------
ui_clear: ; ui_clear()->void
.s0:
1285 : a9 00 __ LDA #$00
1287 : 8d 76 3d STA $3d76 ; (text_y + 0)
128a : 8d 21 3e STA $3e21 ; (al + 0)
128d : ad 20 3e LDA $3e20 ; (clearfull + 0)
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
12b7 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
12ba : 18 __ __ CLC
12bb : 69 08 __ ADC #$08
12bd : 85 0d __ STA P0 
12bf : ad 65 3d LDA $3d65 ; (video_colorram + 1)
12c2 : 69 02 __ ADC #$02
12c4 : 85 0e __ STA P1 
12c6 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
12c9 : a9 00 __ LDA #$00
12cb : 8d 20 3e STA $3e20 ; (clearfull + 0)
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
12f7 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
12fa : 18 __ __ CLC
12fb : 69 30 __ ADC #$30
12fd : 85 0d __ STA P0 
12ff : ad 65 3d LDA $3d65 ; (video_colorram + 1)
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
1310 : 8d 23 3e STA $3e23 ; (cmd + 0)
1313 : a9 ff __ LDA #$ff
1315 : 8d 24 3e STA $3e24 ; (obj1 + 0)
1318 : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
131b : ad 22 3e LDA $3e22 ; (newroom + 0)
131e : 85 53 __ STA T0 + 0 
1320 : 8d 77 3d STA $3d77 ; (room + 0)
1323 : 20 5f 31 JSR $315f ; (os_roomimage_load.s0 + 0)
1326 : ad 12 3e LDA $3e12 ; (roomattr + 0)
1329 : 18 __ __ CLC
132a : 65 53 __ ADC T0 + 0 
132c : 85 43 __ STA T1 + 0 
132e : ad 13 3e LDA $3e13 ; (roomattr + 1)
1331 : 69 00 __ ADC #$00
1333 : 85 44 __ STA T1 + 1 
1335 : a0 00 __ LDY #$00
1337 : 8c 25 3e STY $3e25 ; (executed + 0)
133a : b1 43 __ LDA (T1 + 0),y 
133c : aa __ __ TAX
133d : 29 01 __ AND #$01
133f : d0 15 __ BNE $1356 ; (room_load.s7 + 0)
.s4:
1341 : 8d 23 3e STA $3e23 ; (cmd + 0)
1344 : a9 ff __ LDA #$ff
1346 : 8d 24 3e STA $3e24 ; (obj1 + 0)
1349 : 8a __ __ TXA
134a : 09 01 __ ORA #$01
134c : 91 43 __ STA (T1 + 0),y 
134e : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
1351 : ad 25 3e LDA $3e25 ; (executed + 0)
1354 : d0 0d __ BNE $1363 ; (room_load.s28 + 0)
.s7:
1356 : a9 01 __ LDA #$01
1358 : 8d 23 3e STA $3e23 ; (cmd + 0)
135b : a9 ff __ LDA #$ff
135d : 8d 24 3e STA $3e24 ; (obj1 + 0)
1360 : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
.s28:
1363 : ad c4 3d LDA $3dc4 ; (nextroom + 0)
1366 : c9 fa __ CMP #$fa
1368 : f0 0a __ BEQ $1374 ; (room_load.s1001 + 0)
.s10:
136a : 8d 22 3e STA $3e22 ; (newroom + 0)
136d : a9 fa __ LDA #$fa
136f : 8d c4 3d STA $3dc4 ; (nextroom + 0)
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
1386 : 8d 25 3e STA $3e25 ; (executed + 0)
1389 : ad de 3d LDA $3dde ; (opcode_vrbidx_count + 0)
138c : cd 23 3e CMP $3e23 ; (cmd + 0)
138f : b0 03 __ BCS $1394 ; (adv_run.s3 + 0)
.s1:
1391 : 8d 23 3e STA $3e23 ; (cmd + 0)
.s3:
1394 : ad 23 3e LDA $3e23 ; (cmd + 0)
1397 : 0a __ __ ASL
1398 : 85 54 __ STA T2 + 0 
139a : a9 00 __ LDA #$00
139c : 2a __ __ ROL
139d : aa __ __ TAX
139e : ad f4 3d LDA $3df4 ; (opcode_vrbidx_dir + 0)
13a1 : 65 54 __ ADC T2 + 0 
13a3 : 85 54 __ STA T2 + 0 
13a5 : 8a __ __ TXA
13a6 : 6d f5 3d ADC $3df5 ; (opcode_vrbidx_dir + 1)
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
13c1 : ad 77 3d LDA $3d77 ; (room + 0)
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
13d5 : ad f6 3d LDA $3df6 ; (opcode_vrbidx_data + 0)
13d8 : 65 56 __ ADC T3 + 0 
13da : 85 44 __ STA T4 + 0 
13dc : ad f7 3d LDA $3df7 ; (opcode_vrbidx_data + 1)
13df : 65 57 __ ADC T3 + 1 
13e1 : 85 45 __ STA T4 + 1 
13e3 : a0 00 __ LDY #$00
13e5 : b1 44 __ LDA (T4 + 0),y 
13e7 : 8d 26 3e STA $3e26 ; (varroom + 0)
13ea : c5 53 __ CMP T0 + 0 
13ec : f0 07 __ BEQ $13f5 ; (adv_run.s7 + 0)
.s10:
13ee : ad 26 3e LDA $3e26 ; (varroom + 0)
13f1 : c9 f6 __ CMP #$f6
13f3 : d0 4e __ BNE $1443 ; (adv_run.s23 + 0)
.s7:
13f5 : a0 01 __ LDY #$01
13f7 : b1 44 __ LDA (T4 + 0),y 
13f9 : 8d 27 3e STA $3e27 ; (opcode + 0)
13fc : 0a __ __ ASL
13fd : 85 47 __ STA T6 + 0 
13ff : a9 00 __ LDA #$00
1401 : 2a __ __ ROL
1402 : aa __ __ TAX
1403 : ad f8 3d LDA $3df8 ; (opcode_pos + 0)
1406 : 65 47 __ ADC T6 + 0 
1408 : 85 47 __ STA T6 + 0 
140a : 8a __ __ TXA
140b : 6d f9 3d ADC $3df9 ; (opcode_pos + 1)
140e : 85 48 __ STA T6 + 1 
1410 : b1 47 __ LDA (T6 + 0),y 
1412 : aa __ __ TAX
1413 : ad fc 3d LDA $3dfc ; (opcode_data + 0)
1416 : 18 __ __ CLC
1417 : 88 __ __ DEY
1418 : 71 47 __ ADC (T6 + 0),y 
141a : 8d 28 3e STA $3e28 ; (pcode + 0)
141d : 8a __ __ TXA
141e : 6d fd 3d ADC $3dfd ; (opcode_data + 1)
1421 : 8d 29 3e STA $3e29 ; (pcode + 1)
1424 : ad fa 3d LDA $3dfa ; (opcode_len + 0)
1427 : 85 47 __ STA T6 + 0 
1429 : ad fb 3d LDA $3dfb ; (opcode_len + 1)
142c : 85 48 __ STA T6 + 1 
142e : ac 27 3e LDY $3e27 ; (opcode + 0)
1431 : b1 47 __ LDA (T6 + 0),y 
1433 : 8d 2a 3e STA $3e2a ; (pcodelen + 0)
1436 : a9 00 __ LDA #$00
1438 : 8d 2b 3e STA $3e2b ; (pcodelen + 1)
143b : 20 65 14 JSR $1465 ; (adv_exec.s1000 + 0)
143e : ad 25 3e LDA $3e25 ; (executed + 0)
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
1471 : 8d 2c 3e STA $3e2c ; (in + 0)
1474 : 8d 2d 3e STA $3e2d ; (fail + 0)
1477 : 8d 78 3d STA $3d78 ; (istack + 0)
147a : 8d 2e 3e STA $3e2e ; (used + 0)
147d : 8d 30 3e STA $3e30 ; (i + 0)
1480 : 8d 31 3e STA $3e31 ; (i + 1)
1483 : ad 24 3e LDA $3e24 ; (obj1 + 0)
1486 : 8d 2f 3e STA $3e2f ; (thisobj + 0)
1489 : ad 2a 3e LDA $3e2a ; (pcodelen + 0)
148c : 0d 2b 3e ORA $3e2b ; (pcodelen + 1)
148f : d0 03 __ BNE $1494 ; (adv_exec.l2 + 0)
1491 : 4c 7a 15 JMP $157a ; (adv_exec.s3 + 0)
.l2:
1494 : ad 30 3e LDA $3e30 ; (i + 0)
1497 : 85 53 __ STA T1 + 0 
1499 : 18 __ __ CLC
149a : 69 01 __ ADC #$01
149c : 85 55 __ STA T2 + 0 
149e : 8d 30 3e STA $3e30 ; (i + 0)
14a1 : ad 31 3e LDA $3e31 ; (i + 1)
14a4 : 85 54 __ STA T1 + 1 
14a6 : 69 00 __ ADC #$00
14a8 : 85 56 __ STA T2 + 1 
14aa : 8d 31 3e STA $3e31 ; (i + 1)
14ad : ad 28 3e LDA $3e28 ; (pcode + 0)
14b0 : 85 57 __ STA T3 + 0 
14b2 : 18 __ __ CLC
14b3 : 65 53 __ ADC T1 + 0 
14b5 : 85 43 __ STA T4 + 0 
14b7 : ad 29 3e LDA $3e29 ; (pcode + 1)
14ba : 85 58 __ STA T3 + 1 
14bc : 65 54 __ ADC T1 + 1 
14be : 85 44 __ STA T4 + 1 
14c0 : a0 00 __ LDY #$00
14c2 : b1 43 __ LDA (T4 + 0),y 
14c4 : 8d 27 3e STA $3e27 ; (opcode + 0)
14c7 : c9 88 __ CMP #$88
14c9 : d0 03 __ BNE $14ce ; (adv_exec.s6 + 0)
14cb : 4c 7a 15 JMP $157a ; (adv_exec.s3 + 0)
.s6:
14ce : 85 52 __ STA T0 + 0 
14d0 : aa __ __ TAX
14d1 : bd f9 3c LDA $3cf9,x ; (font + 532)
14d4 : 10 03 __ BPL $14d9 ; (adv_exec.s9 + 0)
14d6 : 4c cd 1a JMP $1acd ; (adv_exec.s8 + 0)
.s9:
14d9 : 8a __ __ TXA
14da : e0 92 __ CPX #$92
14dc : d0 1f __ BNE $14fd ; (adv_exec.s355 + 0)
.s185:
14de : c8 __ __ INY
14df : b1 43 __ LDA (T4 + 0),y 
14e1 : 85 52 __ STA T0 + 0 
14e3 : 8d 34 3e STA $3e34 ; (var + 0)
14e6 : 18 __ __ CLC
14e7 : a5 53 __ LDA T1 + 0 
14e9 : 69 02 __ ADC #$02
14eb : 8d 30 3e STA $3e30 ; (i + 0)
14ee : a5 54 __ LDA T1 + 1 
14f0 : 69 00 __ ADC #$00
14f2 : 8d 31 3e STA $3e31 ; (i + 1)
14f5 : ad b5 3e LDA $3eb5 ; (key + 0)
14f8 : 85 59 __ STA T5 + 0 
14fa : 4c 8d 19 JMP $198d ; (adv_exec.s327 + 0)
.s355:
14fd : c9 92 __ CMP #$92
14ff : b0 03 __ BCS $1504 ; (adv_exec.s356 + 0)
1501 : 4c 99 19 JMP $1999 ; (adv_exec.s357 + 0)
.s356:
1504 : c9 96 __ CMP #$96
1506 : d0 03 __ BNE $150b ; (adv_exec.s369 + 0)
1508 : 4c 11 19 JMP $1911 ; (adv_exec.s325 + 0)
.s369:
150b : b0 03 __ BCS $1510 ; (adv_exec.s370 + 0)
150d : 4c 9f 18 JMP $189f ; (adv_exec.s371 + 0)
.s370:
1510 : c9 9e __ CMP #$9e
1512 : d0 03 __ BNE $1517 ; (adv_exec.s375 + 0)
1514 : 4c 35 17 JMP $1735 ; (adv_exec.s200 + 0)
.s375:
1517 : c9 af __ CMP #$af
1519 : f0 04 __ BEQ $151f ; (adv_exec.s284 + 0)
.s354:
151b : a9 01 __ LDA #$01
151d : d0 47 __ BNE $1566 ; (adv_exec.s1281 + 0)
.s284:
151f : c8 __ __ INY
1520 : b1 43 __ LDA (T4 + 0),y 
1522 : 8d 34 3e STA $3e34 ; (var + 0)
1525 : ee 2c 3e INC $3e2c ; (in + 0)
1528 : 18 __ __ CLC
1529 : a5 53 __ LDA T1 + 0 
152b : 69 02 __ ADC #$02
152d : 8d 30 3e STA $3e30 ; (i + 0)
1530 : a5 54 __ LDA T1 + 1 
1532 : 69 00 __ ADC #$00
1534 : 8d 31 3e STA $3e31 ; (i + 1)
1537 : cc 2c 3e CPY $3e2c ; (in + 0)
153a : b0 05 __ BCS $1541 ; (adv_exec.s286 + 0)
.s285:
153c : ad 35 3e LDA $3e35 ; (obj2 + 0)
153f : 90 09 __ BCC $154a ; (adv_exec.s689 + 0)
.s286:
1541 : ad 34 3e LDA $3e34 ; (var + 0)
1544 : 8d 2f 3e STA $3e2f ; (thisobj + 0)
1547 : ad 24 3e LDA $3e24 ; (obj1 + 0)
.s689:
154a : cd 34 3e CMP $3e34 ; (var + 0)
154d : d0 03 __ BNE $1552 ; (adv_exec.s288 + 0)
154f : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s288:
1552 : c9 f9 __ CMP #$f9
1554 : d0 03 __ BNE $1559 ; (adv_exec.s292 + 0)
1556 : 4c 2b 17 JMP $172b ; (adv_exec.s291 + 0)
.s292:
1559 : aa __ __ TAX
155a : ad 34 3e LDA $3e34 ; (var + 0)
155d : c9 f5 __ CMP #$f5
155f : d0 03 __ BNE $1564 ; (adv_exec.s295 + 0)
1561 : 4c 1d 17 JMP $171d ; (adv_exec.s297 + 0)
.s295:
1564 : a9 02 __ LDA #$02
.s1281:
1566 : 8d 2d 3e STA $3e2d ; (fail + 0)
.s377:
1569 : ad 2d 3e LDA $3e2d ; (fail + 0)
156c : c9 02 __ CMP #$02
156e : d0 03 __ BNE $1573 ; (adv_exec.s381 + 0)
1570 : 4c a7 16 JMP $16a7 ; (adv_exec.s380 + 0)
.s381:
1573 : a9 02 __ LDA #$02
1575 : cd 2d 3e CMP $3e2d ; (fail + 0)
1578 : 90 1e __ BCC $1598 ; (adv_exec.s407 + 0)
.s3:
157a : ad 2d 3e LDA $3e2d ; (fail + 0)
157d : f0 04 __ BEQ $1583 ; (adv_exec.s455 + 0)
.s453:
157f : a9 00 __ LDA #$00
1581 : f0 07 __ BEQ $158a ; (adv_exec.s1001 + 0)
.s455:
1583 : ad 2e 3e LDA $3e2e ; (used + 0)
1586 : f0 02 __ BEQ $158a ; (adv_exec.s1001 + 0)
.s1288:
1588 : a9 01 __ LDA #$01
.s1001:
158a : 8d 25 3e STA $3e25 ; (executed + 0)
158d : a2 06 __ LDX #$06
158f : bd df cb LDA $cbdf,x ; (adv_exec@stack + 0)
1592 : 95 53 __ STA T1 + 0,x 
1594 : ca __ __ DEX
1595 : 10 f8 __ BPL $158f ; (adv_exec.s1001 + 5)
1597 : 60 __ __ RTS
.s407:
1598 : ee 78 3d INC $3d78 ; (istack + 0)
159b : ad 31 3e LDA $3e31 ; (i + 1)
159e : cd 2b 3e CMP $3e2b ; (pcodelen + 1)
15a1 : d0 06 __ BNE $15a9 ; (adv_exec.s1027 + 0)
.s1026:
15a3 : ad 30 3e LDA $3e30 ; (i + 0)
15a6 : cd 2a 3e CMP $3e2a ; (pcodelen + 0)
.s1027:
15a9 : b0 65 __ BCS $1610 ; (adv_exec.s385 + 0)
.s458:
15ab : ad 29 3e LDA $3e29 ; (pcode + 1)
15ae : 85 54 __ STA T1 + 1 
15b0 : ae 28 3e LDX $3e28 ; (pcode + 0)
.l413:
15b3 : 8a __ __ TXA
15b4 : 18 __ __ CLC
15b5 : 6d 30 3e ADC $3e30 ; (i + 0)
15b8 : 85 57 __ STA T3 + 0 
15ba : a5 54 __ LDA T1 + 1 
15bc : 6d 31 3e ADC $3e31 ; (i + 1)
15bf : 85 58 __ STA T3 + 1 
15c1 : a0 00 __ LDY #$00
15c3 : b1 57 __ LDA (T3 + 0),y 
15c5 : c9 88 __ CMP #$88
15c7 : f0 47 __ BEQ $1610 ; (adv_exec.s385 + 0)
.s411:
15c9 : 8d 36 3e STA $3e36 ; (ch + 0)
15cc : c9 8d __ CMP #$8d
15ce : 90 09 __ BCC $15d9 ; (adv_exec.s415 + 0)
.s417:
15d0 : c9 97 __ CMP #$97
15d2 : b0 05 __ BCS $15d9 ; (adv_exec.s415 + 0)
.s414:
15d4 : ee 78 3d INC $3d78 ; (istack + 0)
15d7 : 90 0e __ BCC $15e7 ; (adv_exec.s416 + 0)
.s415:
15d9 : c9 85 __ CMP #$85
15db : d0 03 __ BNE $15e0 ; (adv_exec.s419 + 0)
15dd : 4c 9d 16 JMP $169d ; (adv_exec.s418 + 0)
.s419:
15e0 : c9 87 __ CMP #$87
15e2 : d0 03 __ BNE $15e7 ; (adv_exec.s416 + 0)
15e4 : 4c 65 16 JMP $1665 ; (adv_exec.s425 + 0)
.s416:
15e7 : 2c 36 3e BIT $3e36 ; (ch + 0)
15ea : 10 24 __ BPL $1610 ; (adv_exec.s385 + 0)
.s440:
15ec : ac 36 3e LDY $3e36 ; (ch + 0)
15ef : b9 f9 3c LDA $3cf9,y ; (font + 532)
15f2 : 29 7f __ AND #$7f
15f4 : 18 __ __ CLC
15f5 : 6d 30 3e ADC $3e30 ; (i + 0)
15f8 : 8d 30 3e STA $3e30 ; (i + 0)
15fb : a9 00 __ LDA #$00
15fd : 6d 31 3e ADC $3e31 ; (i + 1)
1600 : 8d 31 3e STA $3e31 ; (i + 1)
1603 : cd 2b 3e CMP $3e2b ; (pcodelen + 1)
1606 : d0 06 __ BNE $160e ; (adv_exec.s1007 + 0)
.s1006:
1608 : ad 30 3e LDA $3e30 ; (i + 0)
160b : cd 2a 3e CMP $3e2a ; (pcodelen + 0)
.s1007:
160e : 90 a3 __ BCC $15b3 ; (adv_exec.l413 + 0)
.s385:
1610 : ad 30 3e LDA $3e30 ; (i + 0)
1613 : 85 53 __ STA T1 + 0 
1615 : 18 __ __ CLC
1616 : 69 01 __ ADC #$01
1618 : 8d 30 3e STA $3e30 ; (i + 0)
161b : ad 31 3e LDA $3e31 ; (i + 1)
161e : aa __ __ TAX
161f : 69 00 __ ADC #$00
1621 : 8d 31 3e STA $3e31 ; (i + 1)
1624 : ad 28 3e LDA $3e28 ; (pcode + 0)
1627 : 18 __ __ CLC
1628 : 65 53 __ ADC T1 + 0 
162a : 85 53 __ STA T1 + 0 
162c : 8a __ __ TXA
162d : 6d 29 3e ADC $3e29 ; (pcode + 1)
1630 : 85 54 __ STA T1 + 1 
1632 : a0 00 __ LDY #$00
1634 : b1 53 __ LDA (T1 + 0),y 
1636 : c9 88 __ CMP #$88
1638 : f0 22 __ BEQ $165c ; (adv_exec.s400 + 0)
.s402:
163a : ad 2d 3e LDA $3e2d ; (fail + 0)
163d : f0 03 __ BEQ $1642 ; (adv_exec.s699 + 0)
163f : 4c 7f 15 JMP $157f ; (adv_exec.s453 + 0)
.s699:
1642 : ad 30 3e LDA $3e30 ; (i + 0)
1645 : 85 53 __ STA T1 + 0 
1647 : ad 31 3e LDA $3e31 ; (i + 1)
.s1275:
164a : cd 2b 3e CMP $3e2b ; (pcodelen + 1)
164d : d0 05 __ BNE $1654 ; (adv_exec.s1003 + 0)
.s1002:
164f : a5 53 __ LDA T1 + 0 
.s1283:
1651 : cd 2a 3e CMP $3e2a ; (pcodelen + 0)
.s1003:
1654 : 90 03 __ BCC $1659 ; (adv_exec.s1003 + 5)
1656 : 4c 7a 15 JMP $157a ; (adv_exec.s3 + 0)
1659 : 4c 94 14 JMP $1494 ; (adv_exec.l2 + 0)
.s400:
165c : 8c 2d 3e STY $3e2d ; (fail + 0)
165f : ce 2c 3e DEC $3e2c ; (in + 0)
1662 : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
.s425:
1665 : ad 78 3d LDA $3d78 ; (istack + 0)
1668 : c9 01 __ CMP #$01
166a : f0 0a __ BEQ $1676 ; (adv_exec.s428 + 0)
.s429:
166c : 09 00 __ ORA #$00
166e : f0 a0 __ BEQ $1610 ; (adv_exec.s385 + 0)
.s437:
1670 : ce 78 3d DEC $3d78 ; (istack + 0)
1673 : 4c ec 15 JMP $15ec ; (adv_exec.s440 + 0)
.s428:
1676 : ad 30 3e LDA $3e30 ; (i + 0)
1679 : 18 __ __ CLC
167a : 69 01 __ ADC #$01
167c : aa __ __ TAX
167d : ad 31 3e LDA $3e31 ; (i + 1)
1680 : 69 00 __ ADC #$00
1682 : cd 2b 3e CMP $3e2b ; (pcodelen + 1)
1685 : d0 0d __ BNE $1694 ; (adv_exec.s421 + 0)
.s1010:
1687 : ec 2a 3e CPX $3e2a ; (pcodelen + 0)
168a : d0 08 __ BNE $1694 ; (adv_exec.s421 + 0)
.s434:
168c : ad 2e 3e LDA $3e2e ; (used + 0)
168f : d0 03 __ BNE $1694 ; (adv_exec.s421 + 0)
1691 : 4c 10 16 JMP $1610 ; (adv_exec.s385 + 0)
.s421:
1694 : 8c 78 3d STY $3d78 ; (istack + 0)
1697 : 8c 2d 3e STY $3e2d ; (fail + 0)
169a : 4c 10 16 JMP $1610 ; (adv_exec.s385 + 0)
.s418:
169d : ad 78 3d LDA $3d78 ; (istack + 0)
16a0 : c9 01 __ CMP #$01
16a2 : f0 f0 __ BEQ $1694 ; (adv_exec.s421 + 0)
16a4 : 4c e7 15 JMP $15e7 ; (adv_exec.s416 + 0)
.s380:
16a7 : ad 31 3e LDA $3e31 ; (i + 1)
16aa : cd 2b 3e CMP $3e2b ; (pcodelen + 1)
16ad : d0 06 __ BNE $16b5 ; (adv_exec.s1039 + 0)
.s1038:
16af : ad 30 3e LDA $3e30 ; (i + 0)
16b2 : cd 2a 3e CMP $3e2a ; (pcodelen + 0)
.s1039:
16b5 : 90 03 __ BCC $16ba ; (adv_exec.s457 + 0)
16b7 : 4c 10 16 JMP $1610 ; (adv_exec.s385 + 0)
.s457:
16ba : ad 28 3e LDA $3e28 ; (pcode + 0)
16bd : 85 53 __ STA T1 + 0 
16bf : ad 29 3e LDA $3e29 ; (pcode + 1)
16c2 : 85 54 __ STA T1 + 1 
16c4 : a2 00 __ LDX #$00
.l384:
16c6 : a5 53 __ LDA T1 + 0 
16c8 : 6d 30 3e ADC $3e30 ; (i + 0)
16cb : 85 57 __ STA T3 + 0 
16cd : a5 54 __ LDA T1 + 1 
16cf : 6d 31 3e ADC $3e31 ; (i + 1)
16d2 : 85 58 __ STA T3 + 1 
16d4 : a0 00 __ LDY #$00
16d6 : b1 57 __ LDA (T3 + 0),y 
16d8 : 8d 36 3e STA $3e36 ; (ch + 0)
16db : a8 __ __ TAY
16dc : c9 88 __ CMP #$88
16de : d0 2b __ BNE $170b ; (adv_exec.s387 + 0)
.s386:
16e0 : 8a __ __ TXA
16e1 : d0 03 __ BNE $16e6 ; (adv_exec.s389 + 0)
16e3 : 4c 10 16 JMP $1610 ; (adv_exec.s385 + 0)
.s389:
16e6 : ca __ __ DEX
.s396:
16e7 : b9 f9 3c LDA $3cf9,y ; (font + 532)
16ea : 29 7f __ AND #$7f
16ec : 18 __ __ CLC
16ed : 6d 30 3e ADC $3e30 ; (i + 0)
16f0 : 8d 30 3e STA $3e30 ; (i + 0)
16f3 : a9 00 __ LDA #$00
16f5 : 6d 31 3e ADC $3e31 ; (i + 1)
16f8 : 8d 31 3e STA $3e31 ; (i + 1)
16fb : cd 2b 3e CMP $3e2b ; (pcodelen + 1)
16fe : d0 06 __ BNE $1706 ; (adv_exec.s1031 + 0)
.s1030:
1700 : ad 30 3e LDA $3e30 ; (i + 0)
1703 : cd 2a 3e CMP $3e2a ; (pcodelen + 0)
.s1031:
1706 : 90 be __ BCC $16c6 ; (adv_exec.l384 + 0)
1708 : 4c 10 16 JMP $1610 ; (adv_exec.s385 + 0)
.s387:
170b : ad 36 3e LDA $3e36 ; (ch + 0)
170e : c9 af __ CMP #$af
1710 : d0 04 __ BNE $1716 ; (adv_exec.s388 + 0)
.s393:
1712 : e8 __ __ INX
1713 : 4c e7 16 JMP $16e7 ; (adv_exec.s396 + 0)
.s388:
1716 : 09 00 __ ORA #$00
1718 : 30 cd __ BMI $16e7 ; (adv_exec.s396 + 0)
171a : 4c 10 16 JMP $1610 ; (adv_exec.s385 + 0)
.s297:
171d : 8e 2f 3e STX $3e2f ; (thisobj + 0)
.s694:
1720 : ad 2d 3e LDA $3e2d ; (fail + 0)
1723 : d0 03 __ BNE $1728 ; (adv_exec.s694 + 8)
1725 : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
1728 : 4c 69 15 JMP $1569 ; (adv_exec.s377 + 0)
.s291:
172b : ad 34 3e LDA $3e34 ; (var + 0)
172e : c9 ff __ CMP #$ff
1730 : f0 ee __ BEQ $1720 ; (adv_exec.s694 + 0)
1732 : 4c 64 15 JMP $1564 ; (adv_exec.s295 + 0)
.s200:
1735 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1738 : ad 34 3e LDA $3e34 ; (var + 0)
173b : 85 59 __ STA T5 + 0 
173d : 8d 32 3e STA $3e32 ; (varobj + 0)
1740 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1743 : ad 34 3e LDA $3e34 ; (var + 0)
1746 : 8d 26 3e STA $3e26 ; (varroom + 0)
1749 : a5 52 __ LDA T0 + 0 
174b : c9 94 __ CMP #$94
174d : d0 03 __ BNE $1752 ; (adv_exec.s254 + 0)
174f : 4c fd 17 JMP $17fd ; (adv_exec.s202 + 0)
.s254:
1752 : b0 03 __ BCS $1757 ; (adv_exec.s255 + 0)
1754 : 4c f6 17 JMP $17f6 ; (adv_exec.s256 + 0)
.s255:
1757 : c9 9e __ CMP #$9e
1759 : d0 2a __ BNE $1785 ; (adv_exec.s695 + 0)
.s226:
175b : a5 59 __ LDA T5 + 0 
175d : c9 f3 __ CMP #$f3
175f : f0 5f __ BEQ $17c0 ; (adv_exec.s227 + 0)
.s228:
1761 : ad 0c 3e LDA $3e0c ; (objloc + 0)
1764 : 85 55 __ STA T2 + 0 
1766 : ad 0d 3e LDA $3e0d ; (objloc + 1)
1769 : 85 56 __ STA T2 + 1 
176b : ad 34 3e LDA $3e34 ; (var + 0)
176e : a4 59 __ LDY T5 + 0 
1770 : c9 f4 __ CMP #$f4
1772 : f0 2f __ BEQ $17a3 ; (adv_exec.s240 + 0)
.s241:
1774 : b1 55 __ LDA (T2 + 0),y 
1776 : cd 34 3e CMP $3e34 ; (var + 0)
1779 : f0 0a __ BEQ $1785 ; (adv_exec.s695 + 0)
.s247:
177b : a9 03 __ LDA #$03
177d : 8d 2d 3e STA $3e2d ; (fail + 0)
1780 : a5 52 __ LDA T0 + 0 
1782 : 4c 88 17 JMP $1788 ; (adv_exec.s1277 + 0)
.s695:
1785 : ad 27 3e LDA $3e27 ; (opcode + 0)
.s1277:
1788 : c9 9e __ CMP #$9e
178a : d0 94 __ BNE $1720 ; (adv_exec.s694 + 0)
.s262:
178c : ad 2d 3e LDA $3e2d ; (fail + 0)
178f : d0 03 __ BNE $1794 ; (adv_exec.s259 + 0)
1791 : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
.s259:
1794 : ad 2a 3e LDA $3e2a ; (pcodelen + 0)
1797 : 8d 30 3e STA $3e30 ; (i + 0)
179a : ad 2b 3e LDA $3e2b ; (pcodelen + 1)
179d : 8d 31 3e STA $3e31 ; (i + 1)
17a0 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s240:
17a3 : b1 55 __ LDA (T2 + 0),y 
17a5 : c9 f8 __ CMP #$f8
17a7 : f0 dc __ BEQ $1785 ; (adv_exec.s695 + 0)
.s244:
17a9 : cd 77 3d CMP $3d77 ; (room + 0)
17ac : d0 cd __ BNE $177b ; (adv_exec.s247 + 0)
.s249:
17ae : ad 0a 3e LDA $3e0a ; (objattr + 0)
17b1 : 85 55 __ STA T2 + 0 
17b3 : ad 0b 3e LDA $3e0b ; (objattr + 1)
17b6 : 85 56 __ STA T2 + 1 
17b8 : b1 55 __ LDA (T2 + 0),y 
17ba : 4a __ __ LSR
17bb : b0 c8 __ BCS $1785 ; (adv_exec.s695 + 0)
17bd : 4c 7b 17 JMP $177b ; (adv_exec.s247 + 0)
.s227:
17c0 : a9 00 __ LDA #$00
17c2 : 8d 36 3e STA $3e36 ; (ch + 0)
17c5 : ad df 3d LDA $3ddf ; (obj_count + 0)
17c8 : f0 1d __ BEQ $17e7 ; (adv_exec.s208 + 0)
.s461:
17ca : ad 0c 3e LDA $3e0c ; (objloc + 0)
17cd : 85 53 __ STA T1 + 0 
17cf : ad 0d 3e LDA $3e0d ; (objloc + 1)
17d2 : 85 54 __ STA T1 + 1 
17d4 : ad 34 3e LDA $3e34 ; (var + 0)
.l231:
17d7 : ac 36 3e LDY $3e36 ; (ch + 0)
17da : d1 53 __ CMP (T1 + 0),y 
17dc : f0 09 __ BEQ $17e7 ; (adv_exec.s208 + 0)
.s234:
17de : c8 __ __ INY
17df : 8c 36 3e STY $3e36 ; (ch + 0)
17e2 : cc df 3d CPY $3ddf ; (obj_count + 0)
17e5 : 90 f0 __ BCC $17d7 ; (adv_exec.l231 + 0)
.s208:
17e7 : ad 36 3e LDA $3e36 ; (ch + 0)
17ea : cd df 3d CMP $3ddf ; (obj_count + 0)
17ed : d0 96 __ BNE $1785 ; (adv_exec.s695 + 0)
.s217:
17ef : a9 03 __ LDA #$03
17f1 : 8d 2d 3e STA $3e2d ; (fail + 0)
17f4 : d0 8f __ BNE $1785 ; (adv_exec.s695 + 0)
.s256:
17f6 : c9 90 __ CMP #$90
17f8 : d0 8b __ BNE $1785 ; (adv_exec.s695 + 0)
17fa : 4c 5b 17 JMP $175b ; (adv_exec.s226 + 0)
.s202:
17fd : 18 __ __ CLC
17fe : a5 57 __ LDA T3 + 0 
1800 : 6d 30 3e ADC $3e30 ; (i + 0)
1803 : 85 55 __ STA T2 + 0 
1805 : a5 58 __ LDA T3 + 1 
1807 : 6d 31 3e ADC $3e31 ; (i + 1)
180a : 85 56 __ STA T2 + 1 
180c : a0 00 __ LDY #$00
180e : b1 55 __ LDA (T2 + 0),y 
1810 : 8d 3d 3e STA $3e3d ; (varattr + 0)
1813 : ee 30 3e INC $3e30 ; (i + 0)
1816 : d0 03 __ BNE $181b ; (adv_exec.s1297 + 0)
.s1296:
1818 : ee 31 3e INC $3e31 ; (i + 1)
.s1297:
181b : a5 59 __ LDA T5 + 0 
181d : c9 f3 __ CMP #$f3
181f : d0 4c __ BNE $186d ; (adv_exec.s204 + 0)
.s203:
1821 : 8c 36 3e STY $3e36 ; (ch + 0)
1824 : ad df 3d LDA $3ddf ; (obj_count + 0)
1827 : f0 be __ BEQ $17e7 ; (adv_exec.s208 + 0)
.s460:
1829 : ad 06 3e LDA $3e06 ; (objnameid + 0)
182c : 85 53 __ STA T1 + 0 
182e : ad 07 3e LDA $3e07 ; (objnameid + 1)
1831 : 85 54 __ STA T1 + 1 
.l207:
1833 : ac 36 3e LDY $3e36 ; (ch + 0)
1836 : b1 53 __ LDA (T1 + 0),y 
1838 : c9 ff __ CMP #$ff
183a : f0 25 __ BEQ $1861 ; (adv_exec.s209 + 0)
.s210:
183c : ad 0c 3e LDA $3e0c ; (objloc + 0)
183f : 85 57 __ STA T3 + 0 
1841 : ad 0d 3e LDA $3e0d ; (objloc + 1)
1844 : 85 58 __ STA T3 + 1 
1846 : b1 57 __ LDA (T3 + 0),y 
1848 : cd 26 3e CMP $3e26 ; (varroom + 0)
184b : d0 14 __ BNE $1861 ; (adv_exec.s209 + 0)
.s215:
184d : ad 0a 3e LDA $3e0a ; (objattr + 0)
1850 : 85 57 __ STA T3 + 0 
1852 : ad 0b 3e LDA $3e0b ; (objattr + 1)
1855 : 85 58 __ STA T3 + 1 
1857 : ad 3d 3e LDA $3e3d ; (varattr + 0)
185a : 31 57 __ AND (T3 + 0),y 
185c : cd 3d 3e CMP $3e3d ; (varattr + 0)
185f : f0 86 __ BEQ $17e7 ; (adv_exec.s208 + 0)
.s209:
1861 : c8 __ __ INY
1862 : 8c 36 3e STY $3e36 ; (ch + 0)
1865 : cc df 3d CPY $3ddf ; (obj_count + 0)
1868 : 90 c9 __ BCC $1833 ; (adv_exec.l207 + 0)
186a : 4c e7 17 JMP $17e7 ; (adv_exec.s208 + 0)
.s204:
186d : ad 0c 3e LDA $3e0c ; (objloc + 0)
1870 : 85 55 __ STA T2 + 0 
1872 : ad 0d 3e LDA $3e0d ; (objloc + 1)
1875 : 85 56 __ STA T2 + 1 
1877 : a4 59 __ LDY T5 + 0 
1879 : b1 55 __ LDA (T2 + 0),y 
187b : cd 34 3e CMP $3e34 ; (var + 0)
187e : d0 17 __ BNE $1897 ; (adv_exec.s220 + 0)
.s223:
1880 : ad 0a 3e LDA $3e0a ; (objattr + 0)
1883 : 85 55 __ STA T2 + 0 
1885 : ad 0b 3e LDA $3e0b ; (objattr + 1)
1888 : 85 56 __ STA T2 + 1 
188a : b1 55 __ LDA (T2 + 0),y 
188c : 2d 3d 3e AND $3e3d ; (varattr + 0)
188f : cd 3d 3e CMP $3e3d ; (varattr + 0)
1892 : d0 03 __ BNE $1897 ; (adv_exec.s220 + 0)
1894 : 4c 85 17 JMP $1785 ; (adv_exec.s695 + 0)
.s220:
1897 : a9 03 __ LDA #$03
1899 : 8d 2d 3e STA $3e2d ; (fail + 0)
189c : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s371:
189f : e0 94 __ CPX #$94
18a1 : d0 03 __ BNE $18a6 ; (adv_exec.s372 + 0)
18a3 : 4c 35 17 JMP $1735 ; (adv_exec.s200 + 0)
.s372:
18a6 : e0 94 __ CPX #$94
18a8 : 90 1a __ BCC $18c4 ; (adv_exec.s314 + 0)
.s274:
18aa : 20 be 20 JSR $20be ; (_alignattr.s0 + 0)
18ad : 20 c5 21 JSR $21c5 ; (_getattrstrid.s0 + 0)
18b0 : a9 00 __ LDA #$00
18b2 : 8d 39 3e STA $3e39 ; (text_continue + 0)
18b5 : ad 3a 3e LDA $3e3a ; (strid + 0)
18b8 : c9 ff __ CMP #$ff
18ba : d0 03 __ BNE $18bf ; (adv_exec.s186 + 0)
18bc : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s186:
18bf : a9 03 __ LDA #$03
18c1 : 4c 66 15 JMP $1566 ; (adv_exec.s1281 + 0)
.s314:
18c4 : a0 01 __ LDY #$01
18c6 : b1 43 __ LDA (T4 + 0),y 
18c8 : 8d 32 3e STA $3e32 ; (varobj + 0)
18cb : 18 __ __ CLC
18cc : a5 53 __ LDA T1 + 0 
18ce : 69 02 __ ADC #$02
18d0 : 8d 30 3e STA $3e30 ; (i + 0)
18d3 : a5 54 __ LDA T1 + 1 
18d5 : 69 00 __ ADC #$00
18d7 : 8d 31 3e STA $3e31 ; (i + 1)
18da : ad 32 3e LDA $3e32 ; (varobj + 0)
18dd : 4a __ __ LSR
18de : 4a __ __ LSR
18df : 4a __ __ LSR
18e0 : 18 __ __ CLC
18e1 : 6d 16 3e ADC $3e16 ; (bitvars + 0)
18e4 : 85 55 __ STA T2 + 0 
18e6 : ad 17 3e LDA $3e17 ; (bitvars + 1)
18e9 : 69 00 __ ADC #$00
18eb : 85 56 __ STA T2 + 1 
18ed : ad 32 3e LDA $3e32 ; (varobj + 0)
18f0 : 29 07 __ AND #$07
18f2 : a8 __ __ TAY
18f3 : b9 c6 3d LDA $3dc6,y ; (ormask + 0)
18f6 : a0 00 __ LDY #$00
18f8 : 31 55 __ AND (T2 + 0),y 
18fa : 8d 34 3e STA $3e34 ; (var + 0)
18fd : e0 8d __ CPX #$8d
18ff : d0 08 __ BNE $1909 ; (adv_exec.s316 + 0)
.s315:
1901 : ad 34 3e LDA $3e34 ; (var + 0)
1904 : f0 b9 __ BEQ $18bf ; (adv_exec.s186 + 0)
1906 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s316:
1909 : ad 34 3e LDA $3e34 ; (var + 0)
190c : d0 b1 __ BNE $18bf ; (adv_exec.s186 + 0)
190e : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s325:
1911 : c8 __ __ INY
1912 : b1 43 __ LDA (T4 + 0),y 
1914 : 8d 3d 3e STA $3e3d ; (varattr + 0)
1917 : 18 __ __ CLC
1918 : a5 53 __ LDA T1 + 0 
191a : 69 02 __ ADC #$02
191c : 8d 30 3e STA $3e30 ; (i + 0)
191f : a5 54 __ LDA T1 + 1 
1921 : 69 00 __ ADC #$00
1923 : 8d 31 3e STA $3e31 ; (i + 1)
1926 : ad 3d 3e LDA $3e3d ; (varattr + 0)
1929 : 85 53 __ STA T1 + 0 
192b : 29 40 __ AND #$40
192d : 8d 33 3e STA $3e33 ; (varmode + 0)
1930 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1933 : ad 34 3e LDA $3e34 ; (var + 0)
1936 : 85 52 __ STA T0 + 0 
1938 : 8d 32 3e STA $3e32 ; (varobj + 0)
193b : a5 53 __ LDA T1 + 0 
193d : 29 80 __ AND #$80
193f : 8d 33 3e STA $3e33 ; (varmode + 0)
1942 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1945 : ad 34 3e LDA $3e34 ; (var + 0)
1948 : 85 59 __ STA T5 + 0 
194a : 8d 26 3e STA $3e26 ; (varroom + 0)
194d : a5 53 __ LDA T1 + 0 
194f : 29 3f __ AND #$3f
1951 : c9 02 __ CMP #$02
1953 : d0 0c __ BNE $1961 ; (adv_exec.s347 + 0)
.s337:
1955 : a5 59 __ LDA T5 + 0 
1957 : c5 52 __ CMP T0 + 0 
1959 : 90 03 __ BCC $195e ; (adv_exec.s337 + 9)
195b : 4c bf 18 JMP $18bf ; (adv_exec.s186 + 0)
195e : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s347:
1961 : 90 13 __ BCC $1976 ; (adv_exec.s349 + 0)
.s348:
1963 : c9 03 __ CMP #$03
1965 : f0 03 __ BEQ $196a ; (adv_exec.s342 + 0)
1967 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s342:
196a : a5 52 __ LDA T0 + 0 
196c : c5 59 __ CMP T5 + 0 
196e : 90 03 __ BCC $1973 ; (adv_exec.s342 + 9)
1970 : 4c bf 18 JMP $18bf ; (adv_exec.s186 + 0)
1973 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s349:
1976 : 09 00 __ ORA #$00
1978 : f0 13 __ BEQ $198d ; (adv_exec.s327 + 0)
.s350:
197a : c9 01 __ CMP #$01
197c : f0 03 __ BEQ $1981 ; (adv_exec.s332 + 0)
197e : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s332:
1981 : a5 52 __ LDA T0 + 0 
1983 : c5 59 __ CMP T5 + 0 
1985 : d0 03 __ BNE $198a ; (adv_exec.s332 + 9)
1987 : 4c bf 18 JMP $18bf ; (adv_exec.s186 + 0)
198a : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s327:
198d : a5 52 __ LDA T0 + 0 
.s1276:
198f : c5 59 __ CMP T5 + 0 
1991 : f0 03 __ BEQ $1996 ; (adv_exec.s1276 + 7)
1993 : 4c bf 18 JMP $18bf ; (adv_exec.s186 + 0)
1996 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s357:
1999 : c9 8e __ CMP #$8e
199b : d0 03 __ BNE $19a0 ; (adv_exec.s358 + 0)
199d : 4c 86 1a JMP $1a86 ; (adv_exec.s190 + 0)
.s358:
19a0 : 90 03 __ BCC $19a5 ; (adv_exec.s360 + 0)
19a2 : 4c 33 1a JMP $1a33 ; (adv_exec.s359 + 0)
.s360:
19a5 : c9 87 __ CMP #$87
19a7 : d0 03 __ BNE $19ac ; (adv_exec.s361 + 0)
19a9 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s361:
19ac : b0 7b __ BCS $1a29 ; (adv_exec.s362 + 0)
.s363:
19ae : c9 85 __ CMP #$85
19b0 : f0 03 __ BEQ $19b5 ; (adv_exec.s163 + 0)
19b2 : 4c 1b 15 JMP $151b ; (adv_exec.s354 + 0)
.s163:
19b5 : 8c 34 3e STY $3e34 ; (var + 0)
19b8 : a5 56 __ LDA T2 + 1 
19ba : cd 2b 3e CMP $3e2b ; (pcodelen + 1)
19bd : d0 05 __ BNE $19c4 ; (adv_exec.l1151 + 0)
.s1150:
19bf : a5 55 __ LDA T2 + 0 
.s1284:
19c1 : cd 2a 3e CMP $3e2a ; (pcodelen + 0)
.l1151:
19c4 : 90 03 __ BCC $19c9 ; (adv_exec.s165 + 0)
19c6 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s165:
19c9 : a5 57 __ LDA T3 + 0 
19cb : 6d 30 3e ADC $3e30 ; (i + 0)
19ce : 85 55 __ STA T2 + 0 
19d0 : a5 58 __ LDA T3 + 1 
19d2 : 6d 31 3e ADC $3e31 ; (i + 1)
19d5 : 85 56 __ STA T2 + 1 
19d7 : b1 55 __ LDA (T2 + 0),y 
19d9 : aa __ __ TAX
19da : c9 8d __ CMP #$8d
19dc : 90 0d __ BCC $19eb ; (adv_exec.s168 + 0)
.s170:
19de : c9 97 __ CMP #$97
19e0 : b0 09 __ BCS $19eb ; (adv_exec.s168 + 0)
.s167:
19e2 : ad 34 3e LDA $3e34 ; (var + 0)
19e5 : 85 59 __ STA T5 + 0 
19e7 : e6 59 __ INC T5 + 0 
19e9 : 90 10 __ BCC $19fb ; (adv_exec.s693 + 0)
.s168:
19eb : c9 87 __ CMP #$87
19ed : d0 33 __ BNE $1a22 ; (adv_exec.s172 + 0)
.s171:
19ef : ad 34 3e LDA $3e34 ; (var + 0)
19f2 : d0 03 __ BNE $19f7 ; (adv_exec.s174 + 0)
19f4 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s174:
19f7 : 85 59 __ STA T5 + 0 
19f9 : c6 59 __ DEC T5 + 0 
.s693:
19fb : a5 59 __ LDA T5 + 0 
19fd : 8d 34 3e STA $3e34 ; (var + 0)
.s169:
1a00 : 8e 36 3e STX $3e36 ; (ch + 0)
1a03 : bd f9 3c LDA $3cf9,x ; (font + 532)
1a06 : 29 7f __ AND #$7f
1a08 : 18 __ __ CLC
1a09 : 6d 30 3e ADC $3e30 ; (i + 0)
1a0c : 8d 30 3e STA $3e30 ; (i + 0)
1a0f : a9 00 __ LDA #$00
1a11 : 6d 31 3e ADC $3e31 ; (i + 1)
1a14 : 8d 31 3e STA $3e31 ; (i + 1)
1a17 : cd 2b 3e CMP $3e2b ; (pcodelen + 1)
1a1a : d0 a8 __ BNE $19c4 ; (adv_exec.l1151 + 0)
.s1140:
1a1c : ad 30 3e LDA $3e30 ; (i + 0)
1a1f : 4c c1 19 JMP $19c1 ; (adv_exec.s1284 + 0)
.s172:
1a22 : c9 88 __ CMP #$88
1a24 : d0 da __ BNE $1a00 ; (adv_exec.s169 + 0)
1a26 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s362:
1a29 : e0 8d __ CPX #$8d
1a2b : d0 03 __ BNE $1a30 ; (adv_exec.s362 + 7)
1a2d : 4c c4 18 JMP $18c4 ; (adv_exec.s314 + 0)
1a30 : 4c 1b 15 JMP $151b ; (adv_exec.s354 + 0)
.s359:
1a33 : e0 90 __ CPX #$90
1a35 : d0 03 __ BNE $1a3a ; (adv_exec.s366 + 0)
1a37 : 4c 35 17 JMP $1735 ; (adv_exec.s200 + 0)
.s366:
1a3a : c8 __ __ INY
1a3b : b1 43 __ LDA (T4 + 0),y 
1a3d : 8d 34 3e STA $3e34 ; (var + 0)
1a40 : 18 __ __ CLC
1a41 : a5 53 __ LDA T1 + 0 
1a43 : 69 02 __ ADC #$02
1a45 : 8d 30 3e STA $3e30 ; (i + 0)
1a48 : a5 54 __ LDA T1 + 1 
1a4a : 69 00 __ ADC #$00
1a4c : 8d 31 3e STA $3e31 ; (i + 1)
1a4f : e0 90 __ CPX #$90
1a51 : ad 34 3e LDA $3e34 ; (var + 0)
1a54 : 90 0b __ BCC $1a61 ; (adv_exec.s264 + 0)
.s279:
1a56 : cd 77 3d CMP $3d77 ; (room + 0)
1a59 : f0 03 __ BEQ $1a5e ; (adv_exec.s279 + 8)
1a5b : 4c bf 18 JMP $18bf ; (adv_exec.s186 + 0)
1a5e : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s264:
1a61 : c9 fe __ CMP #$fe
1a63 : d0 0a __ BNE $1a6f ; (adv_exec.s266 + 0)
.s268:
1a65 : ad c7 3e LDA $3ec7 ; (obj1k + 0)
1a68 : c9 02 __ CMP #$02
1a6a : d0 03 __ BNE $1a6f ; (adv_exec.s266 + 0)
1a6c : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s266:
1a6f : ad 34 3e LDA $3e34 ; (var + 0)
1a72 : c9 fd __ CMP #$fd
1a74 : f0 03 __ BEQ $1a79 ; (adv_exec.s272 + 0)
1a76 : 4c bf 18 JMP $18bf ; (adv_exec.s186 + 0)
.s272:
1a79 : ad c8 3e LDA $3ec8 ; (obj2k + 0)
1a7c : c9 02 __ CMP #$02
1a7e : f0 03 __ BEQ $1a83 ; (adv_exec.s272 + 10)
1a80 : 4c bf 18 JMP $18bf ; (adv_exec.s186 + 0)
1a83 : 4c 20 17 JMP $1720 ; (adv_exec.s694 + 0)
.s190:
1a86 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1a89 : ad 34 3e LDA $3e34 ; (var + 0)
1a8c : 8d 32 3e STA $3e32 ; (varobj + 0)
1a8f : 18 __ __ CLC
1a90 : a5 57 __ LDA T3 + 0 
1a92 : 6d 30 3e ADC $3e30 ; (i + 0)
1a95 : 85 55 __ STA T2 + 0 
1a97 : a5 58 __ LDA T3 + 1 
1a99 : 6d 31 3e ADC $3e31 ; (i + 1)
1a9c : 85 56 __ STA T2 + 1 
1a9e : a0 00 __ LDY #$00
1aa0 : b1 55 __ LDA (T2 + 0),y 
1aa2 : 85 59 __ STA T5 + 0 
1aa4 : 8d 34 3e STA $3e34 ; (var + 0)
1aa7 : ee 30 3e INC $3e30 ; (i + 0)
1aaa : d0 03 __ BNE $1aaf ; (adv_exec.s1295 + 0)
.s1294:
1aac : ee 31 3e INC $3e31 ; (i + 1)
.s1295:
1aaf : ad 32 3e LDA $3e32 ; (varobj + 0)
1ab2 : c9 f9 __ CMP #$f9
1ab4 : d0 03 __ BNE $1ab9 ; (adv_exec.s192 + 0)
1ab6 : 4c bf 18 JMP $18bf ; (adv_exec.s186 + 0)
.s192:
1ab9 : ad 0a 3e LDA $3e0a ; (objattr + 0)
1abc : 85 55 __ STA T2 + 0 
1abe : ad 0b 3e LDA $3e0b ; (objattr + 1)
1ac1 : 85 56 __ STA T2 + 1 
1ac3 : ac 32 3e LDY $3e32 ; (varobj + 0)
1ac6 : b1 55 __ LDA (T2 + 0),y 
1ac8 : 25 59 __ AND T5 + 0 
1aca : 4c 8f 19 JMP $198f ; (adv_exec.s1276 + 0)
.s8:
1acd : ee 2e 3e INC $3e2e ; (used + 0)
1ad0 : 8a __ __ TXA
1ad1 : e0 9d __ CPX #$9d
1ad3 : d0 14 __ BNE $1ae9 ; (adv_exec.s115 + 0)
.s13:
1ad5 : a9 01 __ LDA #$01
1ad7 : 8d 33 3e STA $3e33 ; (varmode + 0)
1ada : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1add : ad 34 3e LDA $3e34 ; (var + 0)
1ae0 : 8d 26 3e STA $3e26 ; (varroom + 0)
1ae3 : 8d 32 3e STA $3e32 ; (varobj + 0)
1ae6 : 4c 10 1f JMP $1f10 ; (adv_exec.s586 + 0)
.s115:
1ae9 : c9 9d __ CMP #$9d
1aeb : b0 03 __ BCS $1af0 ; (adv_exec.s116 + 0)
1aed : 4c 11 1e JMP $1e11 ; (adv_exec.s117 + 0)
.s116:
1af0 : c9 a8 __ CMP #$a8
1af2 : d0 35 __ BNE $1b29 ; (adv_exec.s140 + 0)
.s70:
1af4 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1af7 : ad 34 3e LDA $3e34 ; (var + 0)
1afa : 8d 26 3e STA $3e26 ; (varroom + 0)
1afd : 18 __ __ CLC
1afe : a5 57 __ LDA T3 + 0 
1b00 : 6d 30 3e ADC $3e30 ; (i + 0)
1b03 : 85 55 __ STA T2 + 0 
1b05 : a5 58 __ LDA T3 + 1 
1b07 : 6d 31 3e ADC $3e31 ; (i + 1)
1b0a : 85 56 __ STA T2 + 1 
1b0c : ad 30 3e LDA $3e30 ; (i + 0)
1b0f : 18 __ __ CLC
1b10 : 69 01 __ ADC #$01
1b12 : 85 53 __ STA T1 + 0 
1b14 : ad 31 3e LDA $3e31 ; (i + 1)
1b17 : 69 00 __ ADC #$00
1b19 : 85 54 __ STA T1 + 1 
1b1b : a0 00 __ LDY #$00
1b1d : b1 55 __ LDA (T2 + 0),y 
1b1f : a8 __ __ TAY
1b20 : ad 05 3e LDA $3e05 ; (roomovrimg + 1)
1b23 : ae 04 3e LDX $3e04 ; (roomovrimg + 0)
1b26 : 4c 30 1d JMP $1d30 ; (adv_exec.s702 + 0)
.s140:
1b29 : b0 03 __ BCS $1b2e ; (adv_exec.s141 + 0)
1b2b : 4c e5 1c JMP $1ce5 ; (adv_exec.s142 + 0)
.s141:
1b2e : c9 ac __ CMP #$ac
1b30 : d0 03 __ BNE $1b35 ; (adv_exec.s154 + 0)
1b32 : 4c 78 1c JMP $1c78 ; (adv_exec.s88 + 0)
.s154:
1b35 : b0 03 __ BCS $1b3a ; (adv_exec.s155 + 0)
1b37 : 4c d4 1b JMP $1bd4 ; (adv_exec.s156 + 0)
.s155:
1b3a : c9 ad __ CMP #$ad
1b3c : f0 1d __ BEQ $1b5b ; (adv_exec.s61 + 0)
.s160:
1b3e : c9 ae __ CMP #$ae
1b40 : f0 07 __ BEQ $1b49 ; (adv_exec.s54 + 0)
.s114:
1b42 : a9 01 __ LDA #$01
1b44 : 8d 2d 3e STA $3e2d ; (fail + 0)
1b47 : d0 03 __ BNE $1b4c ; (adv_exec.s590 + 0)
.s54:
1b49 : 20 10 2a JSR $2a10 ; (ui_waitkey.s0 + 0)
.s590:
1b4c : a5 56 __ LDA T2 + 1 
1b4e : cd 2b 3e CMP $3e2b ; (pcodelen + 1)
1b51 : f0 03 __ BEQ $1b56 ; (adv_exec.s1168 + 0)
1b53 : 4c 54 16 JMP $1654 ; (adv_exec.s1003 + 0)
.s1168:
1b56 : a5 55 __ LDA T2 + 0 
1b58 : 4c 51 16 JMP $1651 ; (adv_exec.s1283 + 0)
.s61:
1b5b : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1b5e : ad 34 3e LDA $3e34 ; (var + 0)
1b61 : 8d 32 3e STA $3e32 ; (varobj + 0)
1b64 : 18 __ __ CLC
1b65 : a5 57 __ LDA T3 + 0 
1b67 : 6d 30 3e ADC $3e30 ; (i + 0)
1b6a : 85 55 __ STA T2 + 0 
1b6c : a5 58 __ LDA T3 + 1 
1b6e : 6d 31 3e ADC $3e31 ; (i + 1)
1b71 : 85 56 __ STA T2 + 1 
1b73 : a0 00 __ LDY #$00
1b75 : b1 55 __ LDA (T2 + 0),y 
1b77 : 8d 34 3e STA $3e34 ; (var + 0)
1b7a : ad 30 3e LDA $3e30 ; (i + 0)
1b7d : 18 __ __ CLC
1b7e : 69 01 __ ADC #$01
1b80 : 85 53 __ STA T1 + 0 
1b82 : 8d 30 3e STA $3e30 ; (i + 0)
1b85 : ad 31 3e LDA $3e31 ; (i + 1)
1b88 : 69 00 __ ADC #$00
1b8a : 85 54 __ STA T1 + 1 
1b8c : 8d 31 3e STA $3e31 ; (i + 1)
1b8f : a5 52 __ LDA T0 + 0 
1b91 : c9 a3 __ CMP #$a3
1b93 : f0 25 __ BEQ $1bba ; (adv_exec.s65 + 0)
.s67:
1b95 : c9 ad __ CMP #$ad
1b97 : f0 03 __ BEQ $1b9c ; (adv_exec.s63 + 0)
1b99 : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
.s63:
1b9c : ad 0a 3e LDA $3e0a ; (objattr + 0)
1b9f : 18 __ __ CLC
1ba0 : 6d 32 3e ADC $3e32 ; (varobj + 0)
1ba3 : 85 57 __ STA T3 + 0 
1ba5 : ad 0b 3e LDA $3e0b ; (objattr + 1)
1ba8 : 69 00 __ ADC #$00
1baa : 85 58 __ STA T3 + 1 
1bac : a9 ff __ LDA #$ff
1bae : 4d 34 3e EOR $3e34 ; (var + 0)
1bb1 : 31 57 __ AND (T3 + 0),y 
1bb3 : 91 57 __ STA (T3 + 0),y 
.s1282:
1bb5 : a5 54 __ LDA T1 + 1 
1bb7 : 4c 4a 16 JMP $164a ; (adv_exec.s1275 + 0)
.s65:
1bba : ad 0a 3e LDA $3e0a ; (objattr + 0)
1bbd : 18 __ __ CLC
1bbe : 6d 32 3e ADC $3e32 ; (varobj + 0)
1bc1 : 85 55 __ STA T2 + 0 
1bc3 : ad 0b 3e LDA $3e0b ; (objattr + 1)
1bc6 : 69 00 __ ADC #$00
1bc8 : 85 56 __ STA T2 + 1 
1bca : ad 34 3e LDA $3e34 ; (var + 0)
1bcd : 11 55 __ ORA (T2 + 0),y 
1bcf : 91 55 __ STA (T2 + 0),y 
1bd1 : 4c b5 1b JMP $1bb5 ; (adv_exec.s1282 + 0)
.s156:
1bd4 : c9 aa __ CMP #$aa
1bd6 : d0 19 __ BNE $1bf1 ; (adv_exec.s157 + 0)
.s56:
1bd8 : 18 __ __ CLC
1bd9 : a5 53 __ LDA T1 + 0 
1bdb : 69 02 __ ADC #$02
1bdd : 85 53 __ STA T1 + 0 
1bdf : 8d 30 3e STA $3e30 ; (i + 0)
1be2 : a5 54 __ LDA T1 + 1 
1be4 : 69 00 __ ADC #$00
1be6 : 85 54 __ STA T1 + 1 
1be8 : 8d 31 3e STA $3e31 ; (i + 1)
1beb : 20 0e 2c JSR $2c0e ; (ui_room_update.l27 + 0)
1bee : 4c b5 1b JMP $1bb5 ; (adv_exec.s1282 + 0)
.s157:
1bf1 : 90 08 __ BCC $1bfb ; (adv_exec.s100 + 0)
.s40:
1bf3 : a9 02 __ LDA #$02
.s1280:
1bf5 : 8d ad 3d STA $3dad ; (quit_request + 0)
1bf8 : 4c 4c 1b JMP $1b4c ; (adv_exec.s590 + 0)
.s100:
1bfb : a0 01 __ LDY #$01
1bfd : b1 43 __ LDA (T4 + 0),y 
1bff : 85 59 __ STA T5 + 0 
1c01 : 8d 32 3e STA $3e32 ; (varobj + 0)
1c04 : 18 __ __ CLC
1c05 : a5 53 __ LDA T1 + 0 
1c07 : 69 02 __ ADC #$02
1c09 : 8d 30 3e STA $3e30 ; (i + 0)
1c0c : a5 54 __ LDA T1 + 1 
1c0e : 69 00 __ ADC #$00
1c10 : 8d 31 3e STA $3e31 ; (i + 1)
1c13 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1c16 : a5 52 __ LDA T0 + 0 
1c18 : c9 84 __ CMP #$84
1c1a : d0 1a __ BNE $1c36 ; (adv_exec.s108 + 0)
.s104:
1c1c : ad 18 3e LDA $3e18 ; (vars + 0)
1c1f : 18 __ __ CLC
1c20 : 65 59 __ ADC T5 + 0 
1c22 : 85 53 __ STA T1 + 0 
1c24 : ad 19 3e LDA $3e19 ; (vars + 1)
1c27 : 69 00 __ ADC #$00
1c29 : 85 54 __ STA T1 + 1 
1c2b : a0 00 __ LDY #$00
1c2d : b1 53 __ LDA (T1 + 0),y 
1c2f : 38 __ __ SEC
1c30 : ed 34 3e SBC $3e34 ; (var + 0)
1c33 : 4c 56 1c JMP $1c56 ; (adv_exec.s1278 + 0)
.s108:
1c36 : b0 23 __ BCS $1c5b ; (adv_exec.s109 + 0)
.s110:
1c38 : c9 81 __ CMP #$81
1c3a : f0 03 __ BEQ $1c3f ; (adv_exec.s102 + 0)
1c3c : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
.s102:
1c3f : ad 18 3e LDA $3e18 ; (vars + 0)
1c42 : 18 __ __ CLC
1c43 : 65 59 __ ADC T5 + 0 
1c45 : 85 53 __ STA T1 + 0 
1c47 : ad 19 3e LDA $3e19 ; (vars + 1)
1c4a : 69 00 __ ADC #$00
1c4c : 85 54 __ STA T1 + 1 
1c4e : ad 34 3e LDA $3e34 ; (var + 0)
1c51 : 18 __ __ CLC
1c52 : a0 00 __ LDY #$00
1c54 : 71 53 __ ADC (T1 + 0),y 
.s1278:
1c56 : 91 53 __ STA (T1 + 0),y 
1c58 : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
.s109:
1c5b : c9 a9 __ CMP #$a9
1c5d : f0 03 __ BEQ $1c62 ; (adv_exec.s106 + 0)
1c5f : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
.s106:
1c62 : a5 59 __ LDA T5 + 0 
.s703:
1c64 : 18 __ __ CLC
1c65 : 6d 18 3e ADC $3e18 ; (vars + 0)
1c68 : 85 53 __ STA T1 + 0 
1c6a : ad 19 3e LDA $3e19 ; (vars + 1)
.s1279:
1c6d : 69 00 __ ADC #$00
1c6f : 85 54 __ STA T1 + 1 
1c71 : ad 34 3e LDA $3e34 ; (var + 0)
1c74 : a0 00 __ LDY #$00
1c76 : f0 de __ BEQ $1c56 ; (adv_exec.s1278 + 0)
.s88:
1c78 : a0 01 __ LDY #$01
1c7a : b1 43 __ LDA (T4 + 0),y 
1c7c : 8d 32 3e STA $3e32 ; (varobj + 0)
1c7f : 18 __ __ CLC
1c80 : a5 53 __ LDA T1 + 0 
1c82 : 69 02 __ ADC #$02
1c84 : 85 53 __ STA T1 + 0 
1c86 : 8d 30 3e STA $3e30 ; (i + 0)
1c89 : a5 54 __ LDA T1 + 1 
1c8b : 69 00 __ ADC #$00
1c8d : 85 54 __ STA T1 + 1 
1c8f : 8d 31 3e STA $3e31 ; (i + 1)
1c92 : ad 32 3e LDA $3e32 ; (varobj + 0)
1c95 : 4a __ __ LSR
1c96 : 4a __ __ LSR
1c97 : 4a __ __ LSR
1c98 : 8d 34 3e STA $3e34 ; (var + 0)
1c9b : ad 16 3e LDA $3e16 ; (bitvars + 0)
1c9e : 18 __ __ CLC
1c9f : 6d 34 3e ADC $3e34 ; (var + 0)
1ca2 : 85 57 __ STA T3 + 0 
1ca4 : ad 17 3e LDA $3e17 ; (bitvars + 1)
1ca7 : 69 00 __ ADC #$00
1ca9 : 85 58 __ STA T3 + 1 
1cab : ad 32 3e LDA $3e32 ; (varobj + 0)
1cae : 29 07 __ AND #$07
1cb0 : 85 55 __ STA T2 + 0 
1cb2 : ad 2a 3e LDA $3e2a ; (pcodelen + 0)
1cb5 : 85 45 __ STA T6 + 0 
1cb7 : ad 2b 3e LDA $3e2b ; (pcodelen + 1)
1cba : 85 46 __ STA T6 + 1 
1cbc : 8a __ __ TXA
1cbd : 88 __ __ DEY
1cbe : c9 a2 __ CMP #$a2
1cc0 : f0 0a __ BEQ $1ccc ; (adv_exec.s89 + 0)
.s90:
1cc2 : a6 55 __ LDX T2 + 0 
1cc4 : bd ce 3d LDA $3dce,x ; (xormask + 0)
1cc7 : 31 57 __ AND (T3 + 0),y 
1cc9 : 4c d3 1c JMP $1cd3 ; (adv_exec.s613 + 0)
.s89:
1ccc : a6 55 __ LDX T2 + 0 
1cce : bd c6 3d LDA $3dc6,x ; (ormask + 0)
1cd1 : 11 57 __ ORA (T3 + 0),y 
.s613:
1cd3 : 91 57 __ STA (T3 + 0),y 
1cd5 : a5 54 __ LDA T1 + 1 
1cd7 : c5 46 __ CMP T6 + 1 
1cd9 : f0 03 __ BEQ $1cde ; (adv_exec.s1192 + 0)
1cdb : 4c 54 16 JMP $1654 ; (adv_exec.s1003 + 0)
.s1192:
1cde : a5 53 __ LDA T1 + 0 
1ce0 : c5 45 __ CMP T6 + 0 
1ce2 : 4c 54 16 JMP $1654 ; (adv_exec.s1003 + 0)
.s142:
1ce5 : c9 a2 __ CMP #$a2
1ce7 : f0 8f __ BEQ $1c78 ; (adv_exec.s88 + 0)
.s143:
1ce9 : b0 03 __ BCS $1cee ; (adv_exec.s144 + 0)
1ceb : 4c c5 1d JMP $1dc5 ; (adv_exec.s145 + 0)
.s144:
1cee : c9 a4 __ CMP #$a4
1cf0 : f0 5b __ BEQ $1d4d ; (adv_exec.s74 + 0)
.s150:
1cf2 : b0 03 __ BCS $1cf7 ; (adv_exec.s151 + 0)
1cf4 : 4c 5b 1b JMP $1b5b ; (adv_exec.s61 + 0)
.s151:
1cf7 : c9 a6 __ CMP #$a6
1cf9 : f0 03 __ BEQ $1cfe ; (adv_exec.s72 + 0)
1cfb : 4c 42 1b JMP $1b42 ; (adv_exec.s114 + 0)
.s72:
1cfe : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1d01 : ad 34 3e LDA $3e34 ; (var + 0)
1d04 : 8d 26 3e STA $3e26 ; (varroom + 0)
1d07 : 18 __ __ CLC
1d08 : a5 57 __ LDA T3 + 0 
1d0a : 6d 30 3e ADC $3e30 ; (i + 0)
1d0d : 85 55 __ STA T2 + 0 
1d0f : a5 58 __ LDA T3 + 1 
1d11 : 6d 31 3e ADC $3e31 ; (i + 1)
1d14 : 85 56 __ STA T2 + 1 
1d16 : ad 30 3e LDA $3e30 ; (i + 0)
1d19 : 18 __ __ CLC
1d1a : 69 01 __ ADC #$01
1d1c : 85 53 __ STA T1 + 0 
1d1e : ad 31 3e LDA $3e31 ; (i + 1)
1d21 : 69 00 __ ADC #$00
1d23 : 85 54 __ STA T1 + 1 
1d25 : a0 00 __ LDY #$00
1d27 : b1 55 __ LDA (T2 + 0),y 
1d29 : a8 __ __ TAY
1d2a : ad 03 3e LDA $3e03 ; (roomimg + 1)
1d2d : ae 02 3e LDX $3e02 ; (roomimg + 0)
.s702:
1d30 : 86 55 __ STX T2 + 0 
1d32 : 85 56 __ STA T2 + 1 
1d34 : a5 53 __ LDA T1 + 0 
1d36 : 8d 30 3e STA $3e30 ; (i + 0)
1d39 : a5 54 __ LDA T1 + 1 
1d3b : 8d 31 3e STA $3e31 ; (i + 1)
1d3e : 98 __ __ TYA
1d3f : ac 34 3e LDY $3e34 ; (var + 0)
1d42 : 8d 34 3e STA $3e34 ; (var + 0)
1d45 : 91 55 __ STA (T2 + 0),y 
1d47 : 20 5f 31 JSR $315f ; (os_roomimage_load.s0 + 0)
1d4a : 4c b5 1b JMP $1bb5 ; (adv_exec.s1282 + 0)
.s74:
1d4d : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1d50 : ad 34 3e LDA $3e34 ; (var + 0)
1d53 : 8d 32 3e STA $3e32 ; (varobj + 0)
1d56 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1d59 : ad 34 3e LDA $3e34 ; (var + 0)
1d5c : 85 52 __ STA T0 + 0 
1d5e : 8d 26 3e STA $3e26 ; (varroom + 0)
1d61 : a9 00 __ LDA #$00
1d63 : 8d 36 3e STA $3e36 ; (ch + 0)
1d66 : 8d 34 3e STA $3e34 ; (var + 0)
1d69 : 18 __ __ CLC
1d6a : a5 57 __ LDA T3 + 0 
1d6c : 6d 30 3e ADC $3e30 ; (i + 0)
1d6f : 85 55 __ STA T2 + 0 
1d71 : a5 58 __ LDA T3 + 1 
1d73 : 6d 31 3e ADC $3e31 ; (i + 1)
1d76 : 85 56 __ STA T2 + 1 
1d78 : a0 00 __ LDY #$00
1d7a : b1 55 __ LDA (T2 + 0),y 
1d7c : 8d 3d 3e STA $3e3d ; (varattr + 0)
1d7f : ee 30 3e INC $3e30 ; (i + 0)
1d82 : d0 03 __ BNE $1d87 ; (adv_exec.s1293 + 0)
.s1292:
1d84 : ee 31 3e INC $3e31 ; (i + 1)
.s1293:
1d87 : ad df 3d LDA $3ddf ; (obj_count + 0)
1d8a : f0 33 __ BEQ $1dbf ; (adv_exec.s77 + 0)
.s456:
1d8c : ad 0c 3e LDA $3e0c ; (objloc + 0)
1d8f : 85 53 __ STA T1 + 0 
1d91 : ad 0d 3e LDA $3e0d ; (objloc + 1)
1d94 : 85 54 __ STA T1 + 1 
.l76:
1d96 : a5 52 __ LDA T0 + 0 
1d98 : ac 36 3e LDY $3e36 ; (ch + 0)
1d9b : d1 53 __ CMP (T1 + 0),y 
1d9d : d0 17 __ BNE $1db6 ; (adv_exec.s621 + 0)
.s81:
1d9f : ad 0a 3e LDA $3e0a ; (objattr + 0)
1da2 : 85 57 __ STA T3 + 0 
1da4 : ad 0b 3e LDA $3e0b ; (objattr + 1)
1da7 : 85 58 __ STA T3 + 1 
1da9 : ad 3d 3e LDA $3e3d ; (varattr + 0)
1dac : 31 57 __ AND (T3 + 0),y 
1dae : cd 3d 3e CMP $3e3d ; (varattr + 0)
1db1 : d0 03 __ BNE $1db6 ; (adv_exec.s621 + 0)
.s78:
1db3 : ee 34 3e INC $3e34 ; (var + 0)
.s621:
1db6 : c8 __ __ INY
1db7 : 8c 36 3e STY $3e36 ; (ch + 0)
1dba : cc df 3d CPY $3ddf ; (obj_count + 0)
1dbd : 90 d7 __ BCC $1d96 ; (adv_exec.l76 + 0)
.s77:
1dbf : ad 32 3e LDA $3e32 ; (varobj + 0)
1dc2 : 4c 64 1c JMP $1c64 ; (adv_exec.s703 + 0)
.s145:
1dc5 : c9 a0 __ CMP #$a0
1dc7 : d0 05 __ BNE $1dce ; (adv_exec.s146 + 0)
.s38:
1dc9 : a9 01 __ LDA #$01
1dcb : 4c f5 1b JMP $1bf5 ; (adv_exec.s1280 + 0)
.s146:
1dce : b0 29 __ BCS $1df9 ; (adv_exec.s44 + 0)
.s148:
1dd0 : c9 9f __ CMP #$9f
1dd2 : f0 03 __ BEQ $1dd7 ; (adv_exec.s85 + 0)
1dd4 : 4c 42 1b JMP $1b42 ; (adv_exec.s114 + 0)
.s85:
1dd7 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1dda : ad 34 3e LDA $3e34 ; (var + 0)
1ddd : 85 52 __ STA T0 + 0 
1ddf : 8d 32 3e STA $3e32 ; (varobj + 0)
1de2 : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1de5 : ad 34 3e LDA $3e34 ; (var + 0)
1de8 : 8d 26 3e STA $3e26 ; (varroom + 0)
1deb : ad 0c 3e LDA $3e0c ; (objloc + 0)
1dee : 18 __ __ CLC
1def : 65 52 __ ADC T0 + 0 
1df1 : 85 53 __ STA T1 + 0 
1df3 : ad 0d 3e LDA $3e0d ; (objloc + 1)
1df6 : 4c 6d 1c JMP $1c6d ; (adv_exec.s1279 + 0)
.s44:
1df9 : ad 10 3e LDA $3e10 ; (roomstart + 0)
1dfc : 85 53 __ STA T1 + 0 
1dfe : ad 11 3e LDA $3e11 ; (roomstart + 1)
1e01 : 85 54 __ STA T1 + 1 
1e03 : ad 77 3d LDA $3d77 ; (room + 0)
1e06 : 91 53 __ STA (T1 + 0),y 
1e08 : 20 7e 2a JSR $2a7e ; (adv_save.s0 + 0)
1e0b : ee b4 3e INC $3eb4 ; (saved + 0)
1e0e : 4c 4c 1b JMP $1b4c ; (adv_exec.s590 + 0)
.s117:
1e11 : c9 8b __ CMP #$8b
1e13 : d0 09 __ BNE $1e1e ; (adv_exec.s118 + 0)
.s58:
1e15 : c8 __ __ INY
1e16 : b1 43 __ LDA (T4 + 0),y 
1e18 : 8d c4 3d STA $3dc4 ; (nextroom + 0)
1e1b : 4c aa 20 JMP $20aa ; (adv_exec.s701 + 0)
.s118:
1e1e : b0 03 __ BCS $1e23 ; (adv_exec.s119 + 0)
1e20 : 4c d8 1f JMP $1fd8 ; (adv_exec.s120 + 0)
.s119:
1e23 : e0 9a __ CPX #$9a
1e25 : d0 07 __ BNE $1e2e ; (adv_exec.s1225 + 0)
.s1224:
1e27 : a9 01 __ LDA #$01
1e29 : 85 59 __ STA T5 + 0 
1e2b : 4c 85 1f JMP $1f85 ; (adv_exec.s30 + 0)
.s1225:
1e2e : e0 9a __ CPX #$9a
1e30 : b0 03 __ BCS $1e35 ; (adv_exec.s133 + 0)
1e32 : 4c 35 1f JMP $1f35 ; (adv_exec.s134 + 0)
.s133:
1e35 : c9 9b __ CMP #$9b
1e37 : d0 06 __ BNE $1e3f ; (adv_exec.s21 + 0)
.s14:
1e39 : 20 be 20 JSR $20be ; (_alignattr.s0 + 0)
1e3c : 4c 10 1f JMP $1f10 ; (adv_exec.s586 + 0)
.s21:
1e3f : 8c 36 3e STY $3e36 ; (ch + 0)
1e42 : 18 __ __ CLC
1e43 : a5 53 __ LDA T1 + 0 
1e45 : 69 02 __ ADC #$02
1e47 : 85 53 __ STA T1 + 0 
1e49 : 8d 30 3e STA $3e30 ; (i + 0)
1e4c : a5 54 __ LDA T1 + 1 
1e4e : 69 00 __ ADC #$00
1e50 : 85 54 __ STA T1 + 1 
1e52 : 8d 31 3e STA $3e31 ; (i + 1)
1e55 : ad 18 3e LDA $3e18 ; (vars + 0)
1e58 : 85 57 __ STA T3 + 0 
1e5a : ad 19 3e LDA $3e19 ; (vars + 1)
1e5d : 85 58 __ STA T3 + 1 
1e5f : c8 __ __ INY
1e60 : b1 43 __ LDA (T4 + 0),y 
1e62 : a8 __ __ TAY
1e63 : b1 57 __ LDA (T3 + 0),y 
1e65 : 8d 3a 3e STA $3e3a ; (strid + 0)
1e68 : ad 1d 3e LDA $3e1d ; (tmp + 1)
1e6b : 85 56 __ STA T2 + 1 
1e6d : 8d 41 3e STA $3e41 ; (ostr + 1)
1e70 : 85 14 __ STA P7 
1e72 : ad 1c 3e LDA $3e1c ; (tmp + 0)
1e75 : 85 55 __ STA T2 + 0 
1e77 : 85 13 __ STA P6 
1e79 : 8d 40 3e STA $3e40 ; (ostr + 0)
1e7c : a9 63 __ LDA #$63
1e7e : cd 3a 3e CMP $3e3a ; (strid + 0)
1e81 : 90 61 __ BCC $1ee4 ; (adv_exec.s22 + 0)
.s24:
1e83 : a9 09 __ LDA #$09
1e85 : cd 3a 3e CMP $3e3a ; (strid + 0)
1e88 : b0 28 __ BCS $1eb2 ; (adv_exec.s27 + 0)
.s25:
1e8a : ad 36 3e LDA $3e36 ; (ch + 0)
1e8d : 85 52 __ STA T0 + 0 
1e8f : ee 36 3e INC $3e36 ; (ch + 0)
1e92 : ad 3a 3e LDA $3e3a ; (strid + 0)
1e95 : 85 1b __ STA ACCU + 0 
1e97 : a9 00 __ LDA #$00
1e99 : 85 1c __ STA ACCU + 1 
1e9b : 85 04 __ STA WORK + 1 
1e9d : a9 0a __ LDA #$0a
1e9f : 85 03 __ STA WORK + 0 
1ea1 : 20 5f 3a JSR $3a5f ; (divmod + 0)
1ea4 : 18 __ __ CLC
1ea5 : a5 1b __ LDA ACCU + 0 
1ea7 : 69 30 __ ADC #$30
1ea9 : a4 52 __ LDY T0 + 0 
1eab : 91 55 __ STA (T2 + 0),y 
1ead : a5 05 __ LDA WORK + 2 
1eaf : 8d 3a 3e STA $3e3a ; (strid + 0)
.s27:
1eb2 : ad 36 3e LDA $3e36 ; (ch + 0)
1eb5 : a8 __ __ TAY
1eb6 : 18 __ __ CLC
1eb7 : 69 01 __ ADC #$01
1eb9 : 8d 36 3e STA $3e36 ; (ch + 0)
1ebc : aa __ __ TAX
1ebd : ad 3a 3e LDA $3e3a ; (strid + 0)
1ec0 : 18 __ __ CLC
1ec1 : 69 30 __ ADC #$30
1ec3 : 91 55 __ STA (T2 + 0),y 
1ec5 : 8a __ __ TXA
1ec6 : 18 __ __ CLC
1ec7 : 65 55 __ ADC T2 + 0 
1ec9 : 85 55 __ STA T2 + 0 
1ecb : 90 02 __ BCC $1ecf ; (adv_exec.s1291 + 0)
.s1290:
1ecd : e6 56 __ INC T2 + 1 
.s1291:
1ecf : a9 00 __ LDA #$00
1ed1 : a8 __ __ TAY
1ed2 : 91 55 __ STA (T2 + 0),y 
1ed4 : a5 55 __ LDA T2 + 0 
1ed6 : 8d 43 3e STA $3e43 ; (etxt + 0)
1ed9 : a5 56 __ LDA T2 + 1 
1edb : 8d 44 3e STA $3e44 ; (etxt + 1)
.s700:
1ede : 20 2d 24 JSR $242d ; (ui_text_write.s0 + 0)
1ee1 : 4c b5 1b JMP $1bb5 ; (adv_exec.s1282 + 0)
.s22:
1ee4 : a9 01 __ LDA #$01
1ee6 : 8d 36 3e STA $3e36 ; (ch + 0)
1ee9 : ad 3a 3e LDA $3e3a ; (strid + 0)
1eec : 85 1b __ STA ACCU + 0 
1eee : a9 00 __ LDA #$00
1ef0 : 85 1c __ STA ACCU + 1 
1ef2 : 85 04 __ STA WORK + 1 
1ef4 : a9 64 __ LDA #$64
1ef6 : 85 03 __ STA WORK + 0 
1ef8 : 20 5f 3a JSR $3a5f ; (divmod + 0)
1efb : 18 __ __ CLC
1efc : a5 1b __ LDA ACCU + 0 
1efe : 69 30 __ ADC #$30
1f00 : a0 00 __ LDY #$00
1f02 : 91 55 __ STA (T2 + 0),y 
1f04 : a5 05 __ LDA WORK + 2 
1f06 : 8d 3a 3e STA $3e3a ; (strid + 0)
1f09 : c9 0a __ CMP #$0a
1f0b : 90 a5 __ BCC $1eb2 ; (adv_exec.s27 + 0)
1f0d : 4c 8a 1e JMP $1e8a ; (adv_exec.s25 + 0)
.s586:
1f10 : 20 c5 21 JSR $21c5 ; (_getattrstrid.s0 + 0)
1f13 : ad 3a 3e LDA $3e3a ; (strid + 0)
1f16 : c9 ff __ CMP #$ff
1f18 : d0 08 __ BNE $1f22 ; (adv_exec.s18 + 0)
.s17:
1f1a : a9 01 __ LDA #$01
1f1c : 8d 2d 3e STA $3e2d ; (fail + 0)
1f1f : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
.s18:
1f22 : 20 58 23 JSR $2358 ; (_getstring.s0 + 0)
1f25 : ad 40 3e LDA $3e40 ; (ostr + 0)
1f28 : 85 13 __ STA P6 
1f2a : ad 41 3e LDA $3e41 ; (ostr + 1)
1f2d : 85 14 __ STA P7 
1f2f : 20 2d 24 JSR $242d ; (ui_text_write.s0 + 0)
1f32 : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
.s134:
1f35 : c9 98 __ CMP #$98
1f37 : d0 05 __ BNE $1f3e ; (adv_exec.s135 + 0)
.s42:
1f39 : a9 03 __ LDA #$03
1f3b : 4c f5 1b JMP $1bf5 ; (adv_exec.s1280 + 0)
.s135:
1f3e : 84 59 __ STY T5 + 0 
1f40 : c9 98 __ CMP #$98
1f42 : b0 41 __ BCS $1f85 ; (adv_exec.s30 + 0)
.s137:
1f44 : c9 97 __ CMP #$97
1f46 : f0 03 __ BEQ $1f4b ; (adv_exec.s83 + 0)
1f48 : 4c 42 1b JMP $1b42 ; (adv_exec.s114 + 0)
.s83:
1f4b : 20 cb 20 JSR $20cb ; (_getobj.s0 + 0)
1f4e : ad 34 3e LDA $3e34 ; (var + 0)
1f51 : 8d 26 3e STA $3e26 ; (varroom + 0)
1f54 : 18 __ __ CLC
1f55 : a5 57 __ LDA T3 + 0 
1f57 : 6d 30 3e ADC $3e30 ; (i + 0)
1f5a : 85 55 __ STA T2 + 0 
1f5c : a5 58 __ LDA T3 + 1 
1f5e : 6d 31 3e ADC $3e31 ; (i + 1)
1f61 : 85 56 __ STA T2 + 1 
1f63 : a0 00 __ LDY #$00
1f65 : b1 55 __ LDA (T2 + 0),y 
1f67 : 8d 3d 3e STA $3e3d ; (varattr + 0)
1f6a : ad 30 3e LDA $3e30 ; (i + 0)
1f6d : 18 __ __ CLC
1f6e : 69 01 __ ADC #$01
1f70 : 85 53 __ STA T1 + 0 
1f72 : 8d 30 3e STA $3e30 ; (i + 0)
1f75 : ad 31 3e LDA $3e31 ; (i + 1)
1f78 : 69 00 __ ADC #$00
1f7a : 85 54 __ STA T1 + 1 
1f7c : 8d 31 3e STA $3e31 ; (i + 1)
1f7f : 20 ab 31 JSR $31ab ; (draw_roomobj.s0 + 0)
1f82 : 4c b5 1b JMP $1bb5 ; (adv_exec.s1282 + 0)
.s30:
1f85 : a0 01 __ LDY #$01
1f87 : b1 43 __ LDA (T4 + 0),y 
1f89 : 8d 3a 3e STA $3e3a ; (strid + 0)
1f8c : 8d 34 3e STA $3e34 ; (var + 0)
1f8f : 18 __ __ CLC
1f90 : a5 53 __ LDA T1 + 0 
1f92 : 69 02 __ ADC #$02
1f94 : 85 53 __ STA T1 + 0 
1f96 : 8d 30 3e STA $3e30 ; (i + 0)
1f99 : a5 54 __ LDA T1 + 1 
1f9b : 69 00 __ ADC #$00
1f9d : 85 54 __ STA T1 + 1 
1f9f : 8d 31 3e STA $3e31 ; (i + 1)
1fa2 : a5 59 __ LDA T5 + 0 
1fa4 : d0 09 __ BNE $1faf ; (adv_exec.s31 + 0)
.s32:
1fa6 : ad e7 3d LDA $3de7 ; (msgs + 1)
1fa9 : ae e6 3d LDX $3de6 ; (msgs + 0)
1fac : 4c b5 1f JMP $1fb5 ; (adv_exec.s33 + 0)
.s31:
1faf : ad e9 3d LDA $3de9 ; (msgs2 + 1)
1fb2 : ae e8 3d LDX $3de8 ; (msgs2 + 0)
.s33:
1fb5 : 8e 37 3e STX $3e37 ; (str + 0)
1fb8 : 8d 38 3e STA $3e38 ; (str + 1)
1fbb : ad 3a 3e LDA $3e3a ; (strid + 0)
1fbe : c9 ff __ CMP #$ff
1fc0 : d0 06 __ BNE $1fc8 ; (adv_exec.s35 + 0)
.s34:
1fc2 : 8c 2d 3e STY $3e2d ; (fail + 0)
1fc5 : 4c b5 1b JMP $1bb5 ; (adv_exec.s1282 + 0)
.s35:
1fc8 : 20 58 23 JSR $2358 ; (_getstring.s0 + 0)
1fcb : ad 40 3e LDA $3e40 ; (ostr + 0)
1fce : 85 13 __ STA P6 
1fd0 : ad 41 3e LDA $3e41 ; (ostr + 1)
1fd3 : 85 14 __ STA P7 
1fd5 : 4c de 1e JMP $1ede ; (adv_exec.s700 + 0)
.s120:
1fd8 : c9 83 __ CMP #$83
1fda : d0 2b __ BNE $2007 ; (adv_exec.s121 + 0)
.s48:
1fdc : ad dc 3d LDA $3ddc ; (freemem + 0)
1fdf : 85 0d __ STA P0 
1fe1 : ad dd 3d LDA $3ddd ; (freemem + 1)
1fe4 : 85 0e __ STA P1 
1fe6 : ad 1c 3e LDA $3e1c ; (tmp + 0)
1fe9 : 85 0f __ STA P2 
1feb : ad 1d 3e LDA $3e1d ; (tmp + 1)
1fee : 85 10 __ STA P3 
1ff0 : 20 81 2b JSR $2b81 ; (mini_itoa.s0 + 0)
1ff3 : a5 0f __ LDA P2 
1ff5 : 85 13 __ STA P6 
1ff7 : 8d 40 3e STA $3e40 ; (ostr + 0)
1ffa : a5 10 __ LDA P3 
1ffc : 85 14 __ STA P7 
1ffe : 8d 41 3e STA $3e41 ; (ostr + 1)
2001 : 20 2d 24 JSR $242d ; (ui_text_write.s0 + 0)
2004 : 4c 4c 1b JMP $1b4c ; (adv_exec.s590 + 0)
.s121:
2007 : b0 7c __ BCS $2085 ; (adv_exec.s122 + 0)
.s123:
2009 : c9 81 __ CMP #$81
200b : d0 03 __ BNE $2010 ; (adv_exec.s124 + 0)
200d : 4c fb 1b JMP $1bfb ; (adv_exec.s100 + 0)
.s124:
2010 : b0 6d __ BCS $207f ; (adv_exec.s50 + 0)
.s126:
2012 : c9 80 __ CMP #$80
2014 : f0 03 __ BEQ $2019 ; (adv_exec.s93 + 0)
2016 : 4c 42 1b JMP $1b42 ; (adv_exec.s114 + 0)
.s93:
2019 : c8 __ __ INY
201a : b1 43 __ LDA (T4 + 0),y 
201c : 8d 32 3e STA $3e32 ; (varobj + 0)
201f : 18 __ __ CLC
2020 : a5 53 __ LDA T1 + 0 
2022 : 69 02 __ ADC #$02
2024 : 85 53 __ STA T1 + 0 
2026 : 8d 30 3e STA $3e30 ; (i + 0)
2029 : a5 54 __ LDA T1 + 1 
202b : 69 00 __ ADC #$00
202d : 85 54 __ STA T1 + 1 
202f : 8d 31 3e STA $3e31 ; (i + 1)
2032 : ad 32 3e LDA $3e32 ; (varobj + 0)
2035 : 4a __ __ LSR
2036 : 4a __ __ LSR
2037 : 4a __ __ LSR
2038 : 8d 34 3e STA $3e34 ; (var + 0)
203b : ad 32 3e LDA $3e32 ; (varobj + 0)
203e : 29 07 __ AND #$07
2040 : aa __ __ TAX
2041 : ad 16 3e LDA $3e16 ; (bitvars + 0)
2044 : 18 __ __ CLC
2045 : 6d 34 3e ADC $3e34 ; (var + 0)
2048 : 85 57 __ STA T3 + 0 
204a : ad 17 3e LDA $3e17 ; (bitvars + 1)
204d : 69 00 __ ADC #$00
204f : 85 58 __ STA T3 + 1 
2051 : 88 __ __ DEY
2052 : b1 57 __ LDA (T3 + 0),y 
2054 : 85 59 __ STA T5 + 0 
2056 : 3d c6 3d AND $3dc6,x ; (ormask + 0)
2059 : 8d 3d 3e STA $3e3d ; (varattr + 0)
205c : f0 03 __ BEQ $2061 ; (adv_exec.s94 + 0)
205e : 4c 42 16 JMP $1642 ; (adv_exec.s699 + 0)
.s94:
2061 : bd c6 3d LDA $3dc6,x ; (ormask + 0)
2064 : 05 59 __ ORA T5 + 0 
2066 : 91 57 __ STA (T3 + 0),y 
2068 : ad 18 3e LDA $3e18 ; (vars + 0)
206b : 85 55 __ STA T2 + 0 
206d : ad 19 3e LDA $3e19 ; (vars + 1)
2070 : 85 56 __ STA T2 + 1 
2072 : b1 55 __ LDA (T2 + 0),y 
2074 : 18 __ __ CLC
2075 : 69 01 __ ADC #$01
2077 : 91 55 __ STA (T2 + 0),y 
2079 : 20 b7 30 JSR $30b7 ; (core_drawscore.s0 + 0)
207c : 4c b5 1b JMP $1bb5 ; (adv_exec.s1282 + 0)
.s50:
207f : 20 85 12 JSR $1285 ; (ui_clear.s0 + 0)
2082 : 4c 4c 1b JMP $1b4c ; (adv_exec.s590 + 0)
.s122:
2085 : c9 89 __ CMP #$89
2087 : d0 0c __ BNE $2095 ; (adv_exec.s128 + 0)
.s52:
2089 : 20 67 2a JSR $2a67 ; (ui_getkey.l2 + 0)
208c : ad 36 3e LDA $3e36 ; (ch + 0)
208f : 8d b5 3e STA $3eb5 ; (key + 0)
2092 : 4c 4c 1b JMP $1b4c ; (adv_exec.s590 + 0)
.s128:
2095 : b0 0a __ BCS $20a1 ; (adv_exec.s46 + 0)
.s130:
2097 : c9 84 __ CMP #$84
2099 : d0 03 __ BNE $209e ; (adv_exec.s130 + 7)
209b : 4c fb 1b JMP $1bfb ; (adv_exec.s100 + 0)
209e : 4c 42 1b JMP $1b42 ; (adv_exec.s114 + 0)
.s46:
20a1 : c8 __ __ INY
20a2 : b1 43 __ LDA (T4 + 0),y 
20a4 : 8d 34 3e STA $3e34 ; (var + 0)
20a7 : 8d b6 3d STA $3db6 ; (slowmode + 0)
.s701:
20aa : 18 __ __ CLC
20ab : a5 53 __ LDA T1 + 0 
20ad : 69 02 __ ADC #$02
20af : 85 53 __ STA T1 + 0 
20b1 : 8d 30 3e STA $3e30 ; (i + 0)
20b4 : a5 54 __ LDA T1 + 1 
20b6 : 69 00 __ ADC #$00
20b8 : 8d 31 3e STA $3e31 ; (i + 1)
20bb : 4c 4a 16 JMP $164a ; (adv_exec.s1275 + 0)
--------------------------------------------------------------------
_alignattr: ; _alignattr()->void
.s0:
20be : ad 77 3d LDA $3d77 ; (room + 0)
20c1 : 8d 26 3e STA $3e26 ; (varroom + 0)
20c4 : ad 2f 3e LDA $3e2f ; (thisobj + 0)
20c7 : 8d 32 3e STA $3e32 ; (varobj + 0)
.s1001:
20ca : 60 __ __ RTS
--------------------------------------------------------------------
_getobj: ; _getobj()->void
.s0:
20cb : ad 30 3e LDA $3e30 ; (i + 0)
20ce : 85 43 __ STA T0 + 0 
20d0 : 18 __ __ CLC
20d1 : 69 01 __ ADC #$01
20d3 : 8d 30 3e STA $3e30 ; (i + 0)
20d6 : ad 31 3e LDA $3e31 ; (i + 1)
20d9 : 85 44 __ STA T0 + 1 
20db : 69 00 __ ADC #$00
20dd : 8d 31 3e STA $3e31 ; (i + 1)
20e0 : ad 28 3e LDA $3e28 ; (pcode + 0)
20e3 : 85 45 __ STA T1 + 0 
20e5 : 18 __ __ CLC
20e6 : 65 43 __ ADC T0 + 0 
20e8 : 85 47 __ STA T2 + 0 
20ea : ad 29 3e LDA $3e29 ; (pcode + 1)
20ed : 85 46 __ STA T1 + 1 
20ef : 65 44 __ ADC T0 + 1 
20f1 : 85 48 __ STA T2 + 1 
20f3 : a0 00 __ LDY #$00
20f5 : b1 47 __ LDA (T2 + 0),y 
20f7 : 8d 34 3e STA $3e34 ; (var + 0)
20fa : c9 fb __ CMP #$fb
20fc : f0 11 __ BEQ $210f ; (_getobj.s9 + 0)
.s18:
20fe : b0 03 __ BCS $2103 ; (_getobj.s19 + 0)
2100 : 4c 87 21 JMP $2187 ; (_getobj.s20 + 0)
.s19:
2103 : c9 fd __ CMP #$fd
2105 : d0 06 __ BNE $210d ; (_getobj.s26 + 0)
.s4:
2107 : ad 35 3e LDA $3e35 ; (obj2 + 0)
210a : 4c 83 21 JMP $2183 ; (_getobj.s1020 + 0)
.s26:
210d : b0 4e __ BCS $215d ; (_getobj.s27 + 0)
.s9:
210f : a0 01 __ LDY #$01
2111 : b1 47 __ LDA (T2 + 0),y 
2113 : 85 49 __ STA T3 + 0 
2115 : 8d 36 3e STA $3e36 ; (ch + 0)
2118 : 18 __ __ CLC
2119 : a5 43 __ LDA T0 + 0 
211b : 69 02 __ ADC #$02
211d : 85 43 __ STA T0 + 0 
211f : 8d 30 3e STA $3e30 ; (i + 0)
2122 : a5 44 __ LDA T0 + 1 
2124 : 69 00 __ ADC #$00
2126 : 85 44 __ STA T0 + 1 
2128 : 8d 31 3e STA $3e31 ; (i + 1)
212b : 20 9e 21 JSR $219e ; (rand.s0 + 0)
212e : a5 49 __ LDA T3 + 0 
2130 : 85 03 __ STA WORK + 0 
2132 : 18 __ __ CLC
2133 : 65 43 __ ADC T0 + 0 
2135 : 8d 30 3e STA $3e30 ; (i + 0)
2138 : a9 00 __ LDA #$00
213a : 85 04 __ STA WORK + 1 
213c : 65 44 __ ADC T0 + 1 
213e : 8d 31 3e STA $3e31 ; (i + 1)
2141 : 18 __ __ CLC
2142 : a5 45 __ LDA T1 + 0 
2144 : 65 43 __ ADC T0 + 0 
2146 : 85 43 __ STA T0 + 0 
2148 : a5 46 __ LDA T1 + 1 
214a : 65 44 __ ADC T0 + 1 
214c : 85 44 __ STA T0 + 1 
214e : 20 5f 3a JSR $3a5f ; (divmod + 0)
2151 : 18 __ __ CLC
2152 : a5 43 __ LDA T0 + 0 
2154 : 65 05 __ ADC WORK + 2 
2156 : 85 43 __ STA T0 + 0 
2158 : a5 44 __ LDA T0 + 1 
215a : 4c 7b 21 JMP $217b ; (_getobj.s34 + 0)
.s27:
215d : c9 fe __ CMP #$fe
215f : d0 06 __ BNE $2167 ; (_getobj.s14 + 0)
.s2:
2161 : ad 24 3e LDA $3e24 ; (obj1 + 0)
2164 : 4c 83 21 JMP $2183 ; (_getobj.s1020 + 0)
.s14:
2167 : ad 33 3e LDA $3e33 ; (varmode + 0)
216a : f0 1a __ BEQ $2186 ; (_getobj.s1001 + 0)
.s15:
216c : 8c 33 3e STY $3e33 ; (varmode + 0)
216f : ad 18 3e LDA $3e18 ; (vars + 0)
2172 : 18 __ __ CLC
2173 : 6d 34 3e ADC $3e34 ; (var + 0)
2176 : 85 43 __ STA T0 + 0 
2178 : ad 19 3e LDA $3e19 ; (vars + 1)
.s34:
217b : 69 00 __ ADC #$00
217d : 85 44 __ STA T0 + 1 
217f : a0 00 __ LDY #$00
2181 : b1 43 __ LDA (T0 + 0),y 
.s1020:
2183 : 8d 34 3e STA $3e34 ; (var + 0)
.s1001:
2186 : 60 __ __ RTS
.s20:
2187 : c9 f4 __ CMP #$f4
2189 : f0 fb __ BEQ $2186 ; (_getobj.s1001 + 0)
.s21:
218b : b0 07 __ BCS $2194 ; (_getobj.s22 + 0)
.s23:
218d : c9 f3 __ CMP #$f3
218f : f0 f5 __ BEQ $2186 ; (_getobj.s1001 + 0)
2191 : 4c 67 21 JMP $2167 ; (_getobj.s14 + 0)
.s22:
2194 : c9 f7 __ CMP #$f7
2196 : d0 cf __ BNE $2167 ; (_getobj.s14 + 0)
.s6:
2198 : ad 77 3d LDA $3d77 ; (room + 0)
219b : 4c 83 21 JMP $2183 ; (_getobj.s1020 + 0)
--------------------------------------------------------------------
rand: ; rand()->u16
.s0:
219e : ad aa 3d LDA $3daa ; (seed + 1)
21a1 : 4a __ __ LSR
21a2 : ad a9 3d LDA $3da9 ; (seed + 0)
21a5 : 6a __ __ ROR
21a6 : aa __ __ TAX
21a7 : a9 00 __ LDA #$00
21a9 : 6a __ __ ROR
21aa : 4d a9 3d EOR $3da9 ; (seed + 0)
21ad : 85 1b __ STA ACCU + 0 
21af : 8a __ __ TXA
21b0 : 4d aa 3d EOR $3daa ; (seed + 1)
21b3 : 85 1c __ STA ACCU + 1 
21b5 : 4a __ __ LSR
21b6 : 45 1b __ EOR ACCU + 0 
21b8 : 8d a9 3d STA $3da9 ; (seed + 0)
21bb : 85 1b __ STA ACCU + 0 
21bd : 45 1c __ EOR ACCU + 1 
21bf : 8d aa 3d STA $3daa ; (seed + 1)
21c2 : 85 1c __ STA ACCU + 1 
.s1001:
21c4 : 60 __ __ RTS
--------------------------------------------------------------------
_getattrstrid: ; _getattrstrid()->void
.s0:
21c5 : ad 30 3e LDA $3e30 ; (i + 0)
21c8 : 85 1b __ STA ACCU + 0 
21ca : 18 __ __ CLC
21cb : 69 01 __ ADC #$01
21cd : 8d 30 3e STA $3e30 ; (i + 0)
21d0 : ad 31 3e LDA $3e31 ; (i + 1)
21d3 : aa __ __ TAX
21d4 : 69 00 __ ADC #$00
21d6 : 8d 31 3e STA $3e31 ; (i + 1)
21d9 : ad 28 3e LDA $3e28 ; (pcode + 0)
21dc : 18 __ __ CLC
21dd : 65 1b __ ADC ACCU + 0 
21df : 85 1b __ STA ACCU + 0 
21e1 : 8a __ __ TXA
21e2 : 6d 29 3e ADC $3e29 ; (pcode + 1)
21e5 : 85 1c __ STA ACCU + 1 
21e7 : a0 00 __ LDY #$00
21e9 : b1 1b __ LDA (ACCU + 0),y 
21eb : 8d 34 3e STA $3e34 ; (var + 0)
21ee : 85 1b __ STA ACCU + 0 
21f0 : 29 3f __ AND #$3f
21f2 : d0 03 __ BNE $21f7 ; (_getattrstrid.s46 + 0)
21f4 : 4c 31 23 JMP $2331 ; (_getattrstrid.s2 + 0)
.s46:
21f7 : c9 01 __ CMP #$01
21f9 : d0 03 __ BNE $21fe ; (_getattrstrid.s12 + 0)
21fb : 4c 03 23 JMP $2303 ; (_getattrstrid.s7 + 0)
.s12:
21fe : aa __ __ TAX
21ff : 06 1b __ ASL ACCU + 0 
2201 : 30 0e __ BMI $2211 ; (_getattrstrid.s13 + 0)
.s14:
2203 : ad 14 3e LDA $3e14 ; (roomattrex + 0)
2206 : 85 1b __ STA ACCU + 0 
2208 : ad 26 3e LDA $3e26 ; (varroom + 0)
220b : ac 15 3e LDY $3e15 ; (roomattrex + 1)
220e : 4c 1c 22 JMP $221c ; (_getattrstrid.s1012 + 0)
.s13:
2211 : ad 0e 3e LDA $3e0e ; (objattrex + 0)
2214 : 85 1b __ STA ACCU + 0 
2216 : ad 32 3e LDA $3e32 ; (varobj + 0)
2219 : ac 0f 3e LDY $3e0f ; (objattrex + 1)
.s1012:
221c : 8c 3c 3e STY $3e3c ; (txt + 1)
221f : 8d 33 3e STA $3e33 ; (varmode + 0)
2222 : a5 1b __ LDA ACCU + 0 
2224 : 8d 3b 3e STA $3e3b ; (txt + 0)
2227 : 98 __ __ TYA
2228 : 05 1b __ ORA ACCU + 0 
222a : d0 03 __ BNE $222f ; (_getattrstrid.s17 + 0)
222c : 4c fd 22 JMP $22fd ; (_getattrstrid.s16 + 0)
.s17:
222f : 8e 3d 3e STX $3e3d ; (varattr + 0)
.l20:
2232 : ad 3b 3e LDA $3e3b ; (txt + 0)
2235 : 85 1b __ STA ACCU + 0 
2237 : 18 __ __ CLC
2238 : 69 01 __ ADC #$01
223a : 8d 3b 3e STA $3e3b ; (txt + 0)
223d : ad 3c 3e LDA $3e3c ; (txt + 1)
2240 : 85 1c __ STA ACCU + 1 
2242 : 69 00 __ ADC #$00
2244 : 8d 3c 3e STA $3e3c ; (txt + 1)
2247 : a0 00 __ LDY #$00
2249 : b1 1b __ LDA (ACCU + 0),y 
224b : 8d 3e 3e STA $3e3e ; (a + 0)
224e : c9 ff __ CMP #$ff
2250 : d0 04 __ BNE $2256 ; (_getattrstrid.s24 + 0)
.s21:
2252 : 8c 33 3e STY $3e33 ; (varmode + 0)
2255 : 60 __ __ RTS
.s24:
2256 : ad 3e 3e LDA $3e3e ; (a + 0)
2259 : 29 7f __ AND #$7f
225b : cd 3d 3e CMP $3e3d ; (varattr + 0)
225e : f0 2b __ BEQ $228b ; (_getattrstrid.s26 + 0)
.s27:
2260 : c8 __ __ INY
2261 : b1 1b __ LDA (ACCU + 0),y 
2263 : 85 1d __ STA ACCU + 2 
2265 : 18 __ __ CLC
2266 : a5 1b __ LDA ACCU + 0 
2268 : 69 02 __ ADC #$02
226a : aa __ __ TAX
226b : a5 1c __ LDA ACCU + 1 
226d : 69 00 __ ADC #$00
226f : a8 __ __ TAY
2270 : 8a __ __ TXA
2271 : 18 __ __ CLC
2272 : 65 1d __ ADC ACCU + 2 
2274 : 90 01 __ BCC $2277 ; (_getattrstrid.s1020 + 0)
.s1019:
2276 : c8 __ __ INY
.s1020:
2277 : 2c 3e 3e BIT $3e3e ; (a + 0)
227a : 30 06 __ BMI $2282 ; (_getattrstrid.s86 + 0)
.s41:
227c : 18 __ __ CLC
227d : 65 1d __ ADC ACCU + 2 
227f : 90 01 __ BCC $2282 ; (_getattrstrid.s86 + 0)
.s1021:
2281 : c8 __ __ INY
.s86:
2282 : 8c 3c 3e STY $3e3c ; (txt + 1)
2285 : 8d 3b 3e STA $3e3b ; (txt + 0)
2288 : 4c 32 22 JMP $2232 ; (_getattrstrid.l20 + 0)
.s26:
228b : 2c 3e 3e BIT $3e3e ; (a + 0)
228e : 30 37 __ BMI $22c7 ; (_getattrstrid.s29 + 0)
.l33:
2290 : ad 3e 3e LDA $3e3e ; (a + 0)
2293 : f0 9d __ BEQ $2232 ; (_getattrstrid.l20 + 0)
.s34:
2295 : ad 3b 3e LDA $3e3b ; (txt + 0)
2298 : 85 1b __ STA ACCU + 0 
229a : ad 3c 3e LDA $3e3c ; (txt + 1)
229d : 85 1c __ STA ACCU + 1 
229f : a0 01 __ LDY #$01
22a1 : b1 1b __ LDA (ACCU + 0),y 
22a3 : aa __ __ TAX
22a4 : 88 __ __ DEY
22a5 : b1 1b __ LDA (ACCU + 0),y 
22a7 : 8d 3e 3e STA $3e3e ; (a + 0)
22aa : 18 __ __ CLC
22ab : a5 1b __ LDA ACCU + 0 
22ad : 69 02 __ ADC #$02
22af : 8d 3b 3e STA $3e3b ; (txt + 0)
22b2 : a5 1c __ LDA ACCU + 1 
22b4 : 69 00 __ ADC #$00
22b6 : 8d 3c 3e STA $3e3c ; (txt + 1)
22b9 : ad 33 3e LDA $3e33 ; (varmode + 0)
22bc : cd 3e 3e CMP $3e3e ; (a + 0)
22bf : d0 cf __ BNE $2290 ; (_getattrstrid.l33 + 0)
.s36:
22c1 : 8e 3a 3e STX $3e3a ; (strid + 0)
22c4 : 4c 32 22 JMP $2232 ; (_getattrstrid.l20 + 0)
.s29:
22c7 : 18 __ __ CLC
22c8 : a5 1b __ LDA ACCU + 0 
22ca : 69 02 __ ADC #$02
22cc : 8d 3b 3e STA $3e3b ; (txt + 0)
22cf : a5 1c __ LDA ACCU + 1 
22d1 : 69 00 __ ADC #$00
22d3 : 8d 3c 3e STA $3e3c ; (txt + 1)
22d6 : 98 __ __ TYA
22d7 : ac 33 3e LDY $3e33 ; (varmode + 0)
22da : 8d 33 3e STA $3e33 ; (varmode + 0)
22dd : c8 __ __ INY
22de : c8 __ __ INY
22df : b1 1b __ LDA (ACCU + 0),y 
22e1 : 8d 3a 3e STA $3e3a ; (strid + 0)
22e4 : ad 3e 3e LDA $3e3e ; (a + 0)
22e7 : c9 ff __ CMP #$ff
22e9 : f0 11 __ BEQ $22fc ; (_getattrstrid.s1001 + 0)
.s43:
22eb : a9 01 __ LDA #$01
22ed : 8d 39 3e STA $3e39 ; (text_continue + 0)
22f0 : ad e4 3d LDA $3de4 ; (advdesc + 0)
22f3 : 8d 37 3e STA $3e37 ; (str + 0)
22f6 : ad e5 3d LDA $3de5 ; (advdesc + 1)
22f9 : 8d 38 3e STA $3e38 ; (str + 1)
.s1001:
22fc : 60 __ __ RTS
.s16:
22fd : a9 ff __ LDA #$ff
.s1014:
22ff : 8d 3a 3e STA $3e3a ; (strid + 0)
2302 : 60 __ __ RTS
.s7:
2303 : ad e4 3d LDA $3de4 ; (advdesc + 0)
2306 : 8d 37 3e STA $3e37 ; (str + 0)
2309 : ad e5 3d LDA $3de5 ; (advdesc + 1)
230c : 8d 38 3e STA $3e38 ; (str + 1)
230f : 06 1b __ ASL ACCU + 0 
2311 : 30 12 __ BMI $2325 ; (_getattrstrid.s8 + 0)
.s9:
2313 : ad 01 3e LDA $3e01 ; (roomdescid + 1)
2316 : ae 00 3e LDX $3e00 ; (roomdescid + 0)
.s1016:
2319 : ac 26 3e LDY $3e26 ; (varroom + 0)
.s85:
231c : 86 1b __ STX ACCU + 0 
231e : 85 1c __ STA ACCU + 1 
2320 : b1 1b __ LDA (ACCU + 0),y 
2322 : 4c ff 22 JMP $22ff ; (_getattrstrid.s1014 + 0)
.s8:
2325 : ad 09 3e LDA $3e09 ; (objdescid + 1)
2328 : ae 08 3e LDX $3e08 ; (objdescid + 0)
.s1015:
232b : ac 32 3e LDY $3e32 ; (varobj + 0)
232e : 4c 1c 23 JMP $231c ; (_getattrstrid.s85 + 0)
.s2:
2331 : a9 01 __ LDA #$01
2333 : 8d 39 3e STA $3e39 ; (text_continue + 0)
2336 : ad e2 3d LDA $3de2 ; (advnames + 0)
2339 : 8d 37 3e STA $3e37 ; (str + 0)
233c : ad e3 3d LDA $3de3 ; (advnames + 1)
233f : 8d 38 3e STA $3e38 ; (str + 1)
2342 : 06 1b __ ASL ACCU + 0 
2344 : 10 09 __ BPL $234f ; (_getattrstrid.s4 + 0)
.s3:
2346 : ad 07 3e LDA $3e07 ; (objnameid + 1)
2349 : ae 06 3e LDX $3e06 ; (objnameid + 0)
234c : 4c 2b 23 JMP $232b ; (_getattrstrid.s1015 + 0)
.s4:
234f : ad ff 3d LDA $3dff ; (roomnameid + 1)
2352 : ae fe 3d LDX $3dfe ; (roomnameid + 0)
2355 : 4c 19 23 JMP $2319 ; (_getattrstrid.s1016 + 0)
--------------------------------------------------------------------
_getstring: ; _getstring()->void
.s0:
2358 : a9 00 __ LDA #$00
235a : 8d 3f 3e STA $3e3f ; (_strid + 0)
235d : ad 37 3e LDA $3e37 ; (str + 0)
2360 : 8d 40 3e STA $3e40 ; (ostr + 0)
2363 : ad 38 3e LDA $3e38 ; (str + 1)
2366 : 8d 41 3e STA $3e41 ; (ostr + 1)
2369 : ad 3a 3e LDA $3e3a ; (strid + 0)
236c : 85 1d __ STA ACCU + 2 
236e : f0 5a __ BEQ $23ca ; (_getstring.s3 + 0)
.l2:
2370 : ad 37 3e LDA $3e37 ; (str + 0)
2373 : 85 1b __ STA ACCU + 0 
2375 : 18 __ __ CLC
2376 : 69 01 __ ADC #$01
2378 : 8d 37 3e STA $3e37 ; (str + 0)
237b : ad 38 3e LDA $3e38 ; (str + 1)
237e : 85 1c __ STA ACCU + 1 
2380 : 69 00 __ ADC #$00
2382 : 8d 38 3e STA $3e38 ; (str + 1)
2385 : a0 00 __ LDY #$00
2387 : b1 1b __ LDA (ACCU + 0),y 
2389 : 8d 42 3e STA $3e42 ; (len + 0)
238c : ee 3f 3e INC $3e3f ; (_strid + 0)
238f : c9 ff __ CMP #$ff
2391 : d0 15 __ BNE $23a8 ; (_getstring.s6 + 0)
.s4:
2393 : c8 __ __ INY
2394 : b1 1b __ LDA (ACCU + 0),y 
2396 : 8d 42 3e STA $3e42 ; (len + 0)
2399 : 18 __ __ CLC
239a : a5 1b __ LDA ACCU + 0 
239c : 69 01 __ ADC #$01
239e : 8d 37 3e STA $3e37 ; (str + 0)
23a1 : a5 1c __ LDA ACCU + 1 
23a3 : 69 01 __ ADC #$01
23a5 : 8d 38 3e STA $3e38 ; (str + 1)
.s6:
23a8 : ad 37 3e LDA $3e37 ; (str + 0)
23ab : 18 __ __ CLC
23ac : 6d 42 3e ADC $3e42 ; (len + 0)
23af : 8d 37 3e STA $3e37 ; (str + 0)
23b2 : 90 03 __ BCC $23b7 ; (_getstring.s1009 + 0)
.s1008:
23b4 : ee 38 3e INC $3e38 ; (str + 1)
.s1009:
23b7 : ad 37 3e LDA $3e37 ; (str + 0)
23ba : 8d 40 3e STA $3e40 ; (ostr + 0)
23bd : ad 38 3e LDA $3e38 ; (str + 1)
23c0 : 8d 41 3e STA $3e41 ; (ostr + 1)
23c3 : ad 3f 3e LDA $3e3f ; (_strid + 0)
23c6 : c5 1d __ CMP ACCU + 2 
23c8 : 90 a6 __ BCC $2370 ; (_getstring.l2 + 0)
.s3:
23ca : ad 40 3e LDA $3e40 ; (ostr + 0)
23cd : 85 1b __ STA ACCU + 0 
23cf : 18 __ __ CLC
23d0 : 69 01 __ ADC #$01
23d2 : 8d 40 3e STA $3e40 ; (ostr + 0)
23d5 : ad 41 3e LDA $3e41 ; (ostr + 1)
23d8 : 85 1c __ STA ACCU + 1 
23da : 69 00 __ ADC #$00
23dc : 8d 41 3e STA $3e41 ; (ostr + 1)
23df : a0 00 __ LDY #$00
23e1 : b1 1b __ LDA (ACCU + 0),y 
23e3 : 8d 42 3e STA $3e42 ; (len + 0)
23e6 : 18 __ __ CLC
23e7 : 6d 40 3e ADC $3e40 ; (ostr + 0)
23ea : 8d 43 3e STA $3e43 ; (etxt + 0)
23ed : ad 41 3e LDA $3e41 ; (ostr + 1)
23f0 : 69 00 __ ADC #$00
23f2 : 8d 44 3e STA $3e44 ; (etxt + 1)
23f5 : ad 42 3e LDA $3e42 ; (len + 0)
23f8 : c9 ff __ CMP #$ff
23fa : d0 30 __ BNE $242c ; (_getstring.s1001 + 0)
.s7:
23fc : c8 __ __ INY
23fd : b1 1b __ LDA (ACCU + 0),y 
23ff : 8d 42 3e STA $3e42 ; (len + 0)
2402 : 18 __ __ CLC
2403 : a5 1b __ LDA ACCU + 0 
2405 : 69 02 __ ADC #$02
2407 : 8d 40 3e STA $3e40 ; (ostr + 0)
240a : a5 1c __ LDA ACCU + 1 
240c : 69 00 __ ADC #$00
240e : 8d 41 3e STA $3e41 ; (ostr + 1)
2411 : ad 43 3e LDA $3e43 ; (etxt + 0)
2414 : 18 __ __ CLC
2415 : 6d 42 3e ADC $3e42 ; (len + 0)
2418 : aa __ __ TAX
2419 : ad 44 3e LDA $3e44 ; (etxt + 1)
241c : 69 00 __ ADC #$00
241e : a8 __ __ TAY
241f : 8a __ __ TXA
2420 : 18 __ __ CLC
2421 : 69 01 __ ADC #$01
2423 : 8d 43 3e STA $3e43 ; (etxt + 0)
2426 : 90 01 __ BCC $2429 ; (_getstring.s1011 + 0)
.s1010:
2428 : c8 __ __ INY
.s1011:
2429 : 8c 44 3e STY $3e44 ; (etxt + 1)
.s1001:
242c : 60 __ __ RTS
--------------------------------------------------------------------
ui_text_write: ; ui_text_write(u8*)->void
.s0:
242d : a9 01 __ LDA #$01
242f : 8d 45 3e STA $3e45 ; (txt_col + 0)
2432 : a5 13 __ LDA P6 ; (text + 0)
2434 : 8d 3b 3e STA $3e3b ; (txt + 0)
2437 : a5 14 __ LDA P7 ; (text + 1)
2439 : 8d 3c 3e STA $3e3c ; (txt + 1)
243c : ad 46 3e LDA $3e46 ; (text_attach + 0)
243f : f0 07 __ BEQ $2448 ; (ui_text_write.s2 + 0)
.s1:
2441 : a9 00 __ LDA #$00
2443 : 8d 46 3e STA $3e46 ; (text_attach + 0)
2446 : f0 15 __ BEQ $245d ; (ui_text_write.l5 + 0)
.s2:
2448 : 8d 47 3e STA $3e47 ; (txt_rev + 0)
244b : 8d 48 3e STA $3e48 ; (txt_x + 0)
244e : ad 76 3d LDA $3d76 ; (text_y + 0)
2451 : 18 __ __ CLC
2452 : 69 0e __ ADC #$0e
2454 : 8d 49 3e STA $3e49 ; (txt_y + 0)
2457 : 4c 5d 24 JMP $245d ; (ui_text_write.l5 + 0)
.s8:
245a : 20 10 2a JSR $2a10 ; (ui_waitkey.s0 + 0)
.l5:
245d : 20 b1 24 JSR $24b1 ; (core_drawtext.l138 + 0)
2460 : ad 4a 3e LDA $3e4a ; (_ch + 0)
2463 : d0 f5 __ BNE $245a ; (ui_text_write.s8 + 0)
.s7:
2465 : ad 3b 3e LDA $3e3b ; (txt + 0)
2468 : 85 1f __ STA ADDR + 0 
246a : ad 3c 3e LDA $3e3c ; (txt + 1)
246d : 18 __ __ CLC
246e : 69 ff __ ADC #$ff
2470 : 85 20 __ STA ADDR + 1 
2472 : a0 ff __ LDY #$ff
2474 : b1 1f __ LDA (ADDR + 0),y 
2476 : c9 2b __ CMP #$2b
2478 : f0 21 __ BEQ $249b ; (ui_text_write.s10 + 0)
.s11:
247a : ad 39 3e LDA $3e39 ; (text_continue + 0)
247d : f0 07 __ BEQ $2486 ; (ui_text_write.s17 + 0)
.s16:
247f : a9 01 __ LDA #$01
2481 : 8d 46 3e STA $3e46 ; (text_attach + 0)
2484 : d0 0c __ BNE $2492 ; (ui_text_write.s1004 + 0)
.s17:
2486 : ad 49 3e LDA $3e49 ; (txt_y + 0)
2489 : 38 __ __ SEC
248a : e9 0e __ SBC #$0e
248c : 8d 76 3d STA $3d76 ; (text_y + 0)
248f : 20 f3 29 JSR $29f3 ; (cr.l30 + 0)
.s1004:
2492 : a9 00 __ LDA #$00
2494 : 8d 39 3e STA $3e39 ; (text_continue + 0)
2497 : ee 21 3e INC $3e21 ; (al + 0)
.s1001:
249a : 60 __ __ RTS
.s10:
249b : a9 01 __ LDA #$01
249d : 8d 46 3e STA $3e46 ; (text_attach + 0)
24a0 : a9 00 __ LDA #$00
24a2 : 8d 39 3e STA $3e39 ; (text_continue + 0)
24a5 : ee 21 3e INC $3e21 ; (al + 0)
24a8 : ad 48 3e LDA $3e48 ; (txt_x + 0)
24ab : f0 ed __ BEQ $249a ; (ui_text_write.s1001 + 0)
.s13:
24ad : ce 48 3e DEC $3e48 ; (txt_x + 0)
24b0 : 60 __ __ RTS
--------------------------------------------------------------------
core_drawtext: ; core_drawtext()->void
.l138:
24b1 : 20 18 27 JSR $2718 ; (_getnextch.s0 + 0)
24b4 : ad 4a 3e LDA $3e4a ; (_ch + 0)
24b7 : f0 0d __ BEQ $24c6 ; (core_drawtext.s1001 + 0)
.l2:
24b9 : ad 21 3e LDA $3e21 ; (al + 0)
24bc : c9 09 __ CMP #$09
24be : ad 4a 3e LDA $3e4a ; (_ch + 0)
24c1 : 90 04 __ BCC $24c7 ; (core_drawtext.s6 + 0)
.s4:
24c3 : 8d 4b 3e STA $3e4b ; (_ech + 0)
.s1001:
24c6 : 60 __ __ RTS
.s6:
24c7 : c9 1f __ CMP #$1f
24c9 : d0 06 __ BNE $24d1 ; (core_drawtext.s9 + 0)
.s8:
24cb : 20 20 28 JSR $2820 ; (core_cr.l34 + 0)
24ce : 4c b1 24 JMP $24b1 ; (core_drawtext.l138 + 0)
.s9:
24d1 : a9 00 __ LDA #$00
24d3 : 8d ab 3d STA $3dab ; (align + 0)
24d6 : 8d ac 3d STA $3dac ; (align + 1)
24d9 : 8d 50 3e STA $3e50 ; (ll + 0)
24dc : 8d 51 3e STA $3e51 ; (ll + 1)
24df : 8d 52 3e STA $3e52 ; (spl + 0)
24e2 : 8d 53 3e STA $3e53 ; (spl + 1)
24e5 : ad 4a 3e LDA $3e4a ; (_ch + 0)
24e8 : f0 5f __ BEQ $2549 ; (core_drawtext.s13 + 0)
.l15:
24ea : ad 50 3e LDA $3e50 ; (ll + 0)
24ed : 85 4a __ STA T3 + 0 
24ef : 18 __ __ CLC
24f0 : 6d 48 3e ADC $3e48 ; (txt_x + 0)
24f3 : aa __ __ TAX
24f4 : ad 51 3e LDA $3e51 ; (ll + 1)
24f7 : 85 4b __ STA T3 + 1 
24f9 : 69 00 __ ADC #$00
24fb : d0 4c __ BNE $2549 ; (core_drawtext.s13 + 0)
.s1036:
24fd : e0 28 __ CPX #$28
24ff : b0 48 __ BCS $2549 ; (core_drawtext.s13 + 0)
.s14:
2501 : ad 4a 3e LDA $3e4a ; (_ch + 0)
2504 : c9 1f __ CMP #$1f
2506 : f0 41 __ BEQ $2549 ; (core_drawtext.s13 + 0)
.s12:
2508 : c9 5c __ CMP #$5c
250a : d0 03 __ BNE $250f ; (core_drawtext.s17 + 0)
250c : 4c 5b 26 JMP $265b ; (core_drawtext.s16 + 0)
.s17:
250f : 85 47 __ STA T0 + 0 
2511 : c9 20 __ CMP #$20
2513 : d0 0d __ BNE $2522 ; (core_drawtext.s57 + 0)
.s55:
2515 : a5 4a __ LDA T3 + 0 
2517 : 8d 52 3e STA $3e52 ; (spl + 0)
251a : a5 4b __ LDA T3 + 1 
251c : 8d 53 3e STA $3e53 ; (spl + 1)
251f : 20 a9 29 JSR $29a9 ; (_savechpos.s0 + 0)
.s57:
2522 : ad 47 3e LDA $3e47 ; (txt_rev + 0)
2525 : 18 __ __ CLC
2526 : 65 47 __ ADC T0 + 0 
2528 : a6 4a __ LDX T3 + 0 
252a : 9d 56 3e STA $3e56,x ; (_buffer + 0)
252d : ad 45 3e LDA $3e45 ; (txt_col + 0)
2530 : 9d 80 3e STA $3e80,x ; (_cbuffer + 0)
2533 : 8a __ __ TXA
2534 : 18 __ __ CLC
2535 : 69 01 __ ADC #$01
2537 : 8d 50 3e STA $3e50 ; (ll + 0)
253a : a5 4b __ LDA T3 + 1 
253c : 69 00 __ ADC #$00
253e : 8d 51 3e STA $3e51 ; (ll + 1)
.s137:
2541 : 20 18 27 JSR $2718 ; (_getnextch.s0 + 0)
2544 : ad 4a 3e LDA $3e4a ; (_ch + 0)
2547 : d0 a1 __ BNE $24ea ; (core_drawtext.l15 + 0)
.s13:
2549 : ad 48 3e LDA $3e48 ; (txt_x + 0)
254c : 85 48 __ STA T2 + 0 
254e : 18 __ __ CLC
254f : 6d 50 3e ADC $3e50 ; (ll + 0)
2552 : aa __ __ TAX
2553 : ad 51 3e LDA $3e51 ; (ll + 1)
2556 : 69 00 __ ADC #$00
2558 : 85 4b __ STA T3 + 1 
255a : d0 0d __ BNE $2569 ; (core_drawtext.s59 + 0)
.s1007:
255c : e0 28 __ CPX #$28
255e : d0 09 __ BNE $2569 ; (core_drawtext.s59 + 0)
.s61:
2560 : ad 4a 3e LDA $3e4a ; (_ch + 0)
2563 : f0 1e __ BEQ $2583 ; (core_drawtext.s125 + 0)
.s62:
2565 : c9 20 __ CMP #$20
2567 : f0 1a __ BEQ $2583 ; (core_drawtext.s125 + 0)
.s59:
2569 : a5 4b __ LDA T3 + 1 
256b : d0 04 __ BNE $2571 ; (core_drawtext.s63 + 0)
.s1004:
256d : e0 28 __ CPX #$28
256f : 90 12 __ BCC $2583 ; (core_drawtext.s125 + 0)
.s63:
2571 : 20 ce 29 JSR $29ce ; (_restorechpos.s0 + 0)
2574 : ad 52 3e LDA $3e52 ; (spl + 0)
2577 : 8d 50 3e STA $3e50 ; (ll + 0)
257a : ad 53 3e LDA $3e53 ; (spl + 1)
257d : 8d 51 3e STA $3e51 ; (ll + 1)
2580 : 20 18 27 JSR $2718 ; (_getnextch.s0 + 0)
.s125:
2583 : ad ac 3d LDA $3dac ; (align + 1)
2586 : d0 36 __ BNE $25be ; (core_drawtext.s66 + 0)
.s1003:
2588 : ad ab 3d LDA $3dab ; (align + 0)
258b : c9 01 __ CMP #$01
258d : d0 0b __ BNE $259a ; (core_drawtext.s71 + 0)
.s69:
258f : 38 __ __ SEC
2590 : a9 28 __ LDA #$28
2592 : ed 50 3e SBC $3e50 ; (ll + 0)
2595 : 85 4a __ STA T3 + 0 
2597 : 4c b6 25 JMP $25b6 ; (core_drawtext.s136 + 0)
.s71:
259a : ad ac 3d LDA $3dac ; (align + 1)
259d : d0 1f __ BNE $25be ; (core_drawtext.s66 + 0)
.s1002:
259f : ad ab 3d LDA $3dab ; (align + 0)
25a2 : c9 02 __ CMP #$02
25a4 : d0 18 __ BNE $25be ; (core_drawtext.s66 + 0)
.s67:
25a6 : 38 __ __ SEC
25a7 : a9 28 __ LDA #$28
25a9 : ed 50 3e SBC $3e50 ; (ll + 0)
25ac : 85 4a __ STA T3 + 0 
25ae : a9 00 __ LDA #$00
25b0 : ed 51 3e SBC $3e51 ; (ll + 1)
25b3 : 4a __ __ LSR
25b4 : 66 4a __ ROR T3 + 0 
.s136:
25b6 : 18 __ __ CLC
25b7 : a5 4a __ LDA T3 + 0 
25b9 : 65 48 __ ADC T2 + 0 
25bb : 8d 48 3e STA $3e48 ; (txt_x + 0)
.s66:
25be : ad 49 3e LDA $3e49 ; (txt_y + 0)
25c1 : 0a __ __ ASL
25c2 : 85 1b __ STA ACCU + 0 
25c4 : a9 00 __ LDA #$00
25c6 : 2a __ __ ROL
25c7 : 06 1b __ ASL ACCU + 0 
25c9 : 2a __ __ ROL
25ca : aa __ __ TAX
25cb : a5 1b __ LDA ACCU + 0 
25cd : 6d 49 3e ADC $3e49 ; (txt_y + 0)
25d0 : 85 48 __ STA T2 + 0 
25d2 : 8a __ __ TXA
25d3 : 69 00 __ ADC #$00
25d5 : 06 48 __ ASL T2 + 0 
25d7 : 2a __ __ ROL
25d8 : 06 48 __ ASL T2 + 0 
25da : 2a __ __ ROL
25db : 06 48 __ ASL T2 + 0 
25dd : 2a __ __ ROL
25de : 85 49 __ STA T2 + 1 
25e0 : ad 48 3e LDA $3e48 ; (txt_x + 0)
25e3 : 85 4c __ STA T4 + 0 
25e5 : ad 62 3d LDA $3d62 ; (video_ram + 0)
25e8 : 18 __ __ CLC
25e9 : 65 48 __ ADC T2 + 0 
25eb : aa __ __ TAX
25ec : ad 63 3d LDA $3d63 ; (video_ram + 1)
25ef : 65 49 __ ADC T2 + 1 
25f1 : a8 __ __ TAY
25f2 : 8a __ __ TXA
25f3 : 18 __ __ CLC
25f4 : 65 4c __ ADC T4 + 0 
25f6 : 85 0d __ STA P0 
25f8 : 90 01 __ BCC $25fb ; (core_drawtext.s1045 + 0)
.s1044:
25fa : c8 __ __ INY
.s1045:
25fb : 84 0e __ STY P1 
25fd : a9 56 __ LDA #$56
25ff : 85 0f __ STA P2 
2601 : a9 3e __ LDA #$3e
2603 : 85 10 __ STA P3 
2605 : ad 50 3e LDA $3e50 ; (ll + 0)
2608 : 85 4a __ STA T3 + 0 
260a : 85 11 __ STA P4 
260c : ad 51 3e LDA $3e51 ; (ll + 1)
260f : 85 4b __ STA T3 + 1 
2611 : 85 12 __ STA P5 
2613 : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
2616 : a5 4a __ LDA T3 + 0 
2618 : 85 11 __ STA P4 
261a : a5 4b __ LDA T3 + 1 
261c : 85 12 __ STA P5 
261e : ad 64 3d LDA $3d64 ; (video_colorram + 0)
2621 : 18 __ __ CLC
2622 : 65 48 __ ADC T2 + 0 
2624 : aa __ __ TAX
2625 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
2628 : 65 49 __ ADC T2 + 1 
262a : a8 __ __ TAY
262b : 8a __ __ TXA
262c : 18 __ __ CLC
262d : 65 4c __ ADC T4 + 0 
262f : 85 0d __ STA P0 
2631 : 90 01 __ BCC $2634 ; (core_drawtext.s1047 + 0)
.s1046:
2633 : c8 __ __ INY
.s1047:
2634 : 84 0e __ STY P1 
2636 : a9 80 __ LDA #$80
2638 : 85 0f __ STA P2 
263a : a9 3e __ LDA #$3e
263c : 85 10 __ STA P3 
263e : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
2641 : 18 __ __ CLC
2642 : a5 4a __ LDA T3 + 0 
2644 : 65 4c __ ADC T4 + 0 
2646 : 8d 48 3e STA $3e48 ; (txt_x + 0)
2649 : ad 4a 3e LDA $3e4a ; (_ch + 0)
264c : d0 01 __ BNE $264f ; (core_drawtext.s74 + 0)
264e : 60 __ __ RTS
.s74:
264f : 20 20 28 JSR $2820 ; (core_cr.l34 + 0)
2652 : ad 4a 3e LDA $3e4a ; (_ch + 0)
2655 : d0 01 __ BNE $2658 ; (core_drawtext.s74 + 9)
2657 : 60 __ __ RTS
2658 : 4c b9 24 JMP $24b9 ; (core_drawtext.l2 + 0)
.s16:
265b : 20 18 27 JSR $2718 ; (_getnextch.s0 + 0)
265e : ad 4a 3e LDA $3e4a ; (_ch + 0)
2661 : c9 16 __ CMP #$16
2663 : f0 27 __ BEQ $268c ; (core_drawtext.s77 + 0)
.s41:
2665 : 90 7c __ BCC $26e3 ; (core_drawtext.s43 + 0)
.s42:
2667 : c9 19 __ CMP #$19
2669 : d0 04 __ BNE $266f ; (core_drawtext.s50 + 0)
.s28:
266b : a9 07 __ LDA #$07
266d : d0 0b __ BNE $267a ; (core_drawtext.s1043 + 0)
.s50:
266f : b0 0f __ BCS $2680 ; (core_drawtext.s51 + 0)
.s52:
2671 : c9 17 __ CMP #$17
2673 : f0 03 __ BEQ $2678 ; (core_drawtext.s30 + 0)
2675 : 4c 41 25 JMP $2541 ; (core_drawtext.s137 + 0)
.s30:
2678 : a9 01 __ LDA #$01
.s1043:
267a : 8d 45 3e STA $3e45 ; (txt_col + 0)
267d : 4c 41 25 JMP $2541 ; (core_drawtext.s137 + 0)
.s51:
2680 : c9 56 __ CMP #$56
2682 : f0 03 __ BEQ $2687 ; (core_drawtext.s32 + 0)
2684 : 4c 41 25 JMP $2541 ; (core_drawtext.s137 + 0)
.s32:
2687 : a9 01 __ LDA #$01
2689 : 8d 54 3e STA $3e54 ; (u + 0)
.s77:
268c : a9 00 __ LDA #$00
268e : 8d 55 3e STA $3e55 ; (v + 0)
.l34:
2691 : ad 1e 3e LDA $3e1e ; (vrb + 0)
2694 : 85 4a __ STA T3 + 0 
2696 : ad 1f 3e LDA $3e1f ; (vrb + 1)
2699 : 85 4b __ STA T3 + 1 
269b : ac 55 3e LDY $3e55 ; (v + 0)
269e : b1 4a __ LDA (T3 + 0),y 
26a0 : d0 03 __ BNE $26a5 ; (core_drawtext.s35 + 0)
26a2 : 4c 41 25 JMP $2541 ; (core_drawtext.s137 + 0)
.s35:
26a5 : 84 47 __ STY T0 + 0 
26a7 : ad 50 3e LDA $3e50 ; (ll + 0)
26aa : 85 4c __ STA T4 + 0 
26ac : ad 47 3e LDA $3e47 ; (txt_rev + 0)
26af : 18 __ __ CLC
26b0 : 71 4a __ ADC (T3 + 0),y 
26b2 : aa __ __ TAX
26b3 : a4 4c __ LDY T4 + 0 
26b5 : 99 56 3e STA $3e56,y ; (_buffer + 0)
26b8 : ad 45 3e LDA $3e45 ; (txt_col + 0)
26bb : c8 __ __ INY
26bc : 8c 50 3e STY $3e50 ; (ll + 0)
26bf : 99 7f 3e STA $3e7f,y ; (_buffer + 41)
26c2 : a9 00 __ LDA #$00
26c4 : 8d 51 3e STA $3e51 ; (ll + 1)
26c7 : a4 47 __ LDY T0 + 0 
26c9 : c8 __ __ INY
26ca : 8c 55 3e STY $3e55 ; (v + 0)
26cd : ad 54 3e LDA $3e54 ; (u + 0)
26d0 : f0 bf __ BEQ $2691 ; (core_drawtext.l34 + 0)
.s37:
26d2 : a9 00 __ LDA #$00
26d4 : 8d 54 3e STA $3e54 ; (u + 0)
26d7 : 8a __ __ TXA
26d8 : 18 __ __ CLC
26d9 : 69 40 __ ADC #$40
26db : a6 4c __ LDX T4 + 0 
26dd : 9d 56 3e STA $3e56,x ; (_buffer + 0)
26e0 : 4c 91 26 JMP $2691 ; (core_drawtext.l34 + 0)
.s43:
26e3 : c9 0c __ CMP #$0c
26e5 : d0 07 __ BNE $26ee ; (core_drawtext.s44 + 0)
.s24:
26e7 : a9 00 __ LDA #$00
26e9 : 8d ab 3d STA $3dab ; (align + 0)
26ec : f0 10 __ BEQ $26fe ; (core_drawtext.s1041 + 0)
.s44:
26ee : 90 14 __ BCC $2704 ; (core_drawtext.s46 + 0)
.s45:
26f0 : c9 12 __ CMP #$12
26f2 : f0 03 __ BEQ $26f7 ; (core_drawtext.s22 + 0)
26f4 : 4c 41 25 JMP $2541 ; (core_drawtext.s137 + 0)
.s22:
26f7 : a9 01 __ LDA #$01
.s1042:
26f9 : 8d ab 3d STA $3dab ; (align + 0)
26fc : a9 00 __ LDA #$00
.s1041:
26fe : 8d ac 3d STA $3dac ; (align + 1)
2701 : 4c 41 25 JMP $2541 ; (core_drawtext.s137 + 0)
.s46:
2704 : c9 03 __ CMP #$03
2706 : d0 04 __ BNE $270c ; (core_drawtext.s47 + 0)
.s20:
2708 : a9 02 __ LDA #$02
270a : d0 ed __ BNE $26f9 ; (core_drawtext.s1042 + 0)
.s47:
270c : c9 07 __ CMP #$07
270e : f0 03 __ BEQ $2713 ; (core_drawtext.s26 + 0)
2710 : 4c 41 25 JMP $2541 ; (core_drawtext.s137 + 0)
.s26:
2713 : a9 0c __ LDA #$0c
2715 : 4c 7a 26 JMP $267a ; (core_drawtext.s1043 + 0)
--------------------------------------------------------------------
_getnextch: ; _getnextch()->void
.s0:
2718 : ad 4b 3e LDA $3e4b ; (_ech + 0)
271b : f0 08 __ BEQ $2725 ; (_getnextch.s2 + 0)
.s1:
271d : a2 00 __ LDX #$00
271f : 8e 4b 3e STX $3e4b ; (_ech + 0)
2722 : 4c ca 27 JMP $27ca ; (_getnextch.s1013 + 0)
.s2:
2725 : ad 4c 3e LDA $3e4c ; (_cplx + 0)
2728 : cd 4d 3e CMP $3e4d ; (_cplw + 0)
272b : b0 17 __ BCS $2744 ; (_getnextch.s5 + 0)
.s4:
272d : 85 1b __ STA ACCU + 0 
272f : 69 01 __ ADC #$01
2731 : 8d 4c 3e STA $3e4c ; (_cplx + 0)
2734 : ad 4e 3e LDA $3e4e ; (_cpl + 0)
2737 : 18 __ __ CLC
2738 : 65 1b __ ADC ACCU + 0 
273a : 85 1b __ STA ACCU + 0 
273c : ad 4f 3e LDA $3e4f ; (_cpl + 1)
273f : 69 00 __ ADC #$00
2741 : 4c c4 27 JMP $27c4 ; (_getnextch.s25 + 0)
.s5:
2744 : ad 3b 3e LDA $3e3b ; (txt + 0)
2747 : 85 1b __ STA ACCU + 0 
2749 : ad 3c 3e LDA $3e3c ; (txt + 1)
274c : 85 1c __ STA ACCU + 1 
274e : cd 44 3e CMP $3e44 ; (etxt + 1)
2751 : d0 0b __ BNE $275e ; (_getnextch.s8 + 0)
.s1008:
2753 : a5 1b __ LDA ACCU + 0 
2755 : cd 43 3e CMP $3e43 ; (etxt + 0)
2758 : d0 04 __ BNE $275e ; (_getnextch.s8 + 0)
.s7:
275a : a9 00 __ LDA #$00
275c : f0 6c __ BEQ $27ca ; (_getnextch.s1013 + 0)
.s8:
275e : 18 __ __ CLC
275f : a5 1b __ LDA ACCU + 0 
2761 : 69 01 __ ADC #$01
2763 : 8d 3b 3e STA $3e3b ; (txt + 0)
2766 : a5 1c __ LDA ACCU + 1 
2768 : 69 00 __ ADC #$00
276a : 8d 3c 3e STA $3e3c ; (txt + 1)
276d : a0 00 __ LDY #$00
276f : b1 1b __ LDA (ACCU + 0),y 
2771 : 8d 4a 3e STA $3e4a ; (_ch + 0)
2774 : c9 5d __ CMP #$5d
2776 : d0 07 __ BNE $277f ; (_getnextch.s13 + 0)
.s10:
2778 : a9 01 __ LDA #$01
277a : 8d 4a 3e STA $3e4a ; (_ch + 0)
277d : d0 4f __ BNE $27ce ; (_getnextch.s16 + 0)
.s13:
277f : c9 5e __ CMP #$5e
2781 : d0 18 __ BNE $279b ; (_getnextch.s11 + 0)
.s14:
2783 : c8 __ __ INY
2784 : b1 1b __ LDA (ACCU + 0),y 
2786 : 8d 4a 3e STA $3e4a ; (_ch + 0)
2789 : 18 __ __ CLC
278a : a5 1b __ LDA ACCU + 0 
278c : 69 02 __ ADC #$02
278e : 8d 3b 3e STA $3e3b ; (txt + 0)
2791 : a5 1c __ LDA ACCU + 1 
2793 : 69 00 __ ADC #$00
2795 : 8d 3c 3e STA $3e3c ; (txt + 1)
2798 : 4c ce 27 JMP $27ce ; (_getnextch.s16 + 0)
.s11:
279b : c9 5f __ CMP #$5f
279d : 90 2e __ BCC $27cd ; (_getnextch.s1001 + 0)
.s17:
279f : 84 1c __ STY ACCU + 1 
27a1 : a9 02 __ LDA #$02
27a3 : 8d 4d 3e STA $3e4d ; (_cplw + 0)
27a6 : a9 01 __ LDA #$01
27a8 : 8d 4c 3e STA $3e4c ; (_cplx + 0)
27ab : ad 4a 3e LDA $3e4a ; (_ch + 0)
27ae : e9 5f __ SBC #$5f
27b0 : 0a __ __ ASL
27b1 : 26 1c __ ROL ACCU + 1 
27b3 : 18 __ __ CLC
27b4 : 6d f2 3d ADC $3df2 ; (packdata + 0)
27b7 : 85 1b __ STA ACCU + 0 
27b9 : 8d 4e 3e STA $3e4e ; (_cpl + 0)
27bc : ad f3 3d LDA $3df3 ; (packdata + 1)
27bf : 65 1c __ ADC ACCU + 1 
27c1 : 8d 4f 3e STA $3e4f ; (_cpl + 1)
.s25:
27c4 : 85 1c __ STA ACCU + 1 
27c6 : a0 00 __ LDY #$00
27c8 : b1 1b __ LDA (ACCU + 0),y 
.s1013:
27ca : 8d 4a 3e STA $3e4a ; (_ch + 0)
.s1001:
27cd : 60 __ __ RTS
.s16:
27ce : a9 01 __ LDA #$01
27d0 : 8d 4c 3e STA $3e4c ; (_cplx + 0)
27d3 : ad e0 3d LDA $3de0 ; (shortdict + 0)
27d6 : 85 43 __ STA T3 + 0 
27d8 : 18 __ __ CLC
27d9 : 6d 4a 3e ADC $3e4a ; (_ch + 0)
27dc : 85 1b __ STA ACCU + 0 
27de : ad e1 3d LDA $3de1 ; (shortdict + 1)
27e1 : 85 44 __ STA T3 + 1 
27e3 : 69 00 __ ADC #$00
27e5 : 85 1c __ STA ACCU + 1 
27e7 : a0 00 __ LDY #$00
27e9 : b1 43 __ LDA (T3 + 0),y 
27eb : 18 __ __ CLC
27ec : 65 43 __ ADC T3 + 0 
27ee : 90 02 __ BCC $27f2 ; (_getnextch.s1015 + 0)
.s1014:
27f0 : e6 44 __ INC T3 + 1 
.s1015:
27f2 : 18 __ __ CLC
27f3 : 69 01 __ ADC #$01
27f5 : 85 43 __ STA T3 + 0 
27f7 : a5 44 __ LDA T3 + 1 
27f9 : 69 00 __ ADC #$00
27fb : aa __ __ TAX
27fc : b1 1b __ LDA (ACCU + 0),y 
27fe : 85 1d __ STA ACCU + 2 
2800 : 18 __ __ CLC
2801 : 65 43 __ ADC T3 + 0 
2803 : 85 43 __ STA T3 + 0 
2805 : 8d 4e 3e STA $3e4e ; (_cpl + 0)
2808 : 8a __ __ TXA
2809 : 69 00 __ ADC #$00
280b : 85 44 __ STA T3 + 1 
280d : 8d 4f 3e STA $3e4f ; (_cpl + 1)
2810 : b1 43 __ LDA (T3 + 0),y 
2812 : 8d 4a 3e STA $3e4a ; (_ch + 0)
2815 : a0 01 __ LDY #$01
2817 : b1 1b __ LDA (ACCU + 0),y 
2819 : 38 __ __ SEC
281a : e5 1d __ SBC ACCU + 2 
281c : 8d 4d 3e STA $3e4d ; (_cplw + 0)
281f : 60 __ __ RTS
--------------------------------------------------------------------
core_cr: ; core_cr()->void
.l34:
2820 : 2c 11 d0 BIT $d011 
2823 : 10 fb __ BPL $2820 ; (core_cr.l34 + 0)
.s1:
2825 : a9 00 __ LDA #$00
2827 : 8d 48 3e STA $3e48 ; (txt_x + 0)
282a : ad 49 3e LDA $3e49 ; (txt_y + 0)
282d : 85 45 __ STA T0 + 0 
282f : 18 __ __ CLC
2830 : 69 01 __ ADC #$01
2832 : 85 46 __ STA T2 + 0 
2834 : 8d 49 3e STA $3e49 ; (txt_y + 0)
2837 : ad 4a 3e LDA $3e4a ; (_ch + 0)
283a : c9 20 __ CMP #$20
283c : f0 04 __ BEQ $2842 ; (core_cr.s5 + 0)
.s8:
283e : c9 1f __ CMP #$1f
2840 : d0 03 __ BNE $2845 ; (core_cr.s7 + 0)
.s5:
2842 : 20 18 27 JSR $2718 ; (_getnextch.s0 + 0)
.s7:
2845 : a5 46 __ LDA T2 + 0 
2847 : c9 19 __ CMP #$19
2849 : 90 08 __ BCC $2853 ; (core_cr.s11 + 0)
.s9:
284b : 20 57 28 JSR $2857 ; (scrollup.l71 + 0)
284e : a5 45 __ LDA T0 + 0 
2850 : 8d 49 3e STA $3e49 ; (txt_y + 0)
.s11:
2853 : ee 21 3e INC $3e21 ; (al + 0)
.s1001:
2856 : 60 __ __ RTS
--------------------------------------------------------------------
scrollup: ; scrollup()->void
.l71:
2857 : 2c 11 d0 BIT $d011 
285a : 10 fb __ BPL $2857 ; (scrollup.l71 + 0)
.s1:
285c : ad a6 02 LDA $02a6 
285f : d0 0e __ BNE $286f ; (scrollup.l9 + 0)
.s5:
2861 : a9 96 __ LDA #$96
2863 : 85 0d __ STA P0 
2865 : a9 00 __ LDA #$00
2867 : 85 0e __ STA P1 
2869 : 20 fa 28 JSR $28fa ; (vic_waitLine.s0 + 0)
286c : 4c 79 28 JMP $2879 ; (scrollup.s7 + 0)
.l9:
286f : 2c 11 d0 BIT $d011 
2872 : 30 fb __ BMI $286f ; (scrollup.l9 + 0)
.l12:
2874 : 2c 11 d0 BIT $d011 
2877 : 10 fb __ BPL $2874 ; (scrollup.l12 + 0)
.s7:
2879 : a5 01 __ LDA $01 
287b : 8d 36 3e STA $3e36 ; (ch + 0)
287e : 78 __ __ SEI
287f : 25 fc __ AND $fc 
2881 : 85 01 __ STA $01 
2883 : a2 28 __ LDX #$28
2885 : ca __ __ DEX
2886 : bd 58 f6 LDA $f658,x 
2889 : 9d 30 f6 STA $f630,x 
288c : bd 80 f6 LDA $f680,x 
288f : 9d 58 f6 STA $f658,x 
2892 : bd a8 f6 LDA $f6a8,x 
2895 : 9d 80 f6 STA $f680,x 
2898 : bd d0 f6 LDA $f6d0,x 
289b : 9d a8 f6 STA $f6a8,x 
289e : bd f8 f6 LDA $f6f8,x 
28a1 : 9d d0 f6 STA $f6d0,x 
28a4 : bd 20 f7 LDA $f720,x 
28a7 : 9d f8 f6 STA $f6f8,x 
28aa : bd 48 f7 LDA $f748,x 
28ad : 9d 20 f7 STA $f720,x 
28b0 : bd 70 f7 LDA $f770,x 
28b3 : 9d 48 f7 STA $f748,x 
28b6 : bd 98 f7 LDA $f798,x 
28b9 : 9d 70 f7 STA $f770,x 
28bc : bd c0 f7 LDA $f7c0,x 
28bf : 9d 98 f7 STA $f798,x 
28c2 : a9 20 __ LDA #$20
28c4 : 9d c0 f7 STA $f7c0,x 
28c7 : e0 00 __ CPX #$00
28c9 : d0 ba __ BNE $2885 ; (scrollup.s7 + 12)
28cb : ad 36 3e LDA $3e36 ; (ch + 0)
28ce : 85 01 __ STA $01 
28d0 : 58 __ __ CLI
28d1 : a9 90 __ LDA #$90
28d3 : 85 11 __ STA P4 
28d5 : a9 01 __ LDA #$01
28d7 : 85 12 __ STA P5 
28d9 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
28dc : 18 __ __ CLC
28dd : 69 30 __ ADC #$30
28df : 85 0d __ STA P0 
28e1 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
28e4 : 69 02 __ ADC #$02
28e6 : 85 0e __ STA P1 
28e8 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
28eb : 18 __ __ CLC
28ec : 69 58 __ ADC #$58
28ee : 85 0f __ STA P2 
28f0 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
28f3 : 69 02 __ ADC #$02
28f5 : 85 10 __ STA P3 
28f7 : 4c 13 29 JMP $2913 ; (memmove.s0 + 0)
--------------------------------------------------------------------
vic_waitLine: ; vic_waitLine(i16)->void
.s0:
28fa : 46 0e __ LSR P1 ; (line + 1)
28fc : a9 00 __ LDA #$00
28fe : 6a __ __ ROR
28ff : 85 1b __ STA ACCU + 0 
2901 : a4 0d __ LDY P0 ; (line + 0)
.l3:
2903 : 98 __ __ TYA
.l1006:
2904 : cd 12 d0 CMP $d012 
2907 : d0 fb __ BNE $2904 ; (vic_waitLine.l1006 + 0)
.s5:
2909 : ad 11 d0 LDA $d011 
290c : 29 80 __ AND #$80
290e : c5 1b __ CMP ACCU + 0 
2910 : d0 f1 __ BNE $2903 ; (vic_waitLine.l3 + 0)
.s1001:
2912 : 60 __ __ RTS
--------------------------------------------------------------------
memmove: ; memmove(void*,const void*,i16)->void*
.s0:
2913 : a5 12 __ LDA P5 ; (size + 1)
2915 : 30 5c __ BMI $2973 ; (memmove.s3 + 0)
.s1006:
2917 : 05 11 __ ORA P4 ; (size + 0)
2919 : f0 58 __ BEQ $2973 ; (memmove.s3 + 0)
.s1:
291b : a5 0e __ LDA P1 ; (dst + 1)
291d : c5 10 __ CMP P3 ; (src + 1)
291f : d0 04 __ BNE $2925 ; (memmove.s1005 + 0)
.s1004:
2921 : a5 0d __ LDA P0 ; (dst + 0)
2923 : c5 0f __ CMP P2 ; (src + 0)
.s1005:
2925 : 90 55 __ BCC $297c ; (memmove.s15 + 0)
.s5:
2927 : a5 10 __ LDA P3 ; (src + 1)
2929 : c5 0e __ CMP P1 ; (dst + 1)
292b : d0 04 __ BNE $2931 ; (memmove.s1003 + 0)
.s1002:
292d : a5 0f __ LDA P2 ; (src + 0)
292f : c5 0d __ CMP P0 ; (dst + 0)
.s1003:
2931 : b0 40 __ BCS $2973 ; (memmove.s3 + 0)
.s9:
2933 : a5 0f __ LDA P2 ; (src + 0)
2935 : 65 11 __ ADC P4 ; (size + 0)
2937 : 85 43 __ STA T4 + 0 
2939 : a5 10 __ LDA P3 ; (src + 1)
293b : 65 12 __ ADC P5 ; (size + 1)
293d : 85 44 __ STA T4 + 1 
293f : 18 __ __ CLC
2940 : a5 0d __ LDA P0 ; (dst + 0)
2942 : 65 11 __ ADC P4 ; (size + 0)
2944 : 85 1b __ STA ACCU + 0 
2946 : a5 0e __ LDA P1 ; (dst + 1)
2948 : 65 12 __ ADC P5 ; (size + 1)
294a : 85 1c __ STA ACCU + 1 
294c : a0 00 __ LDY #$00
294e : a5 11 __ LDA P4 ; (size + 0)
2950 : f0 02 __ BEQ $2954 ; (memmove.l1009 + 0)
.s1014:
2952 : e6 12 __ INC P5 ; (size + 1)
.l1009:
2954 : a6 11 __ LDX P4 ; (size + 0)
.l1017:
2956 : a5 1b __ LDA ACCU + 0 
2958 : d0 02 __ BNE $295c ; (memmove.s1024 + 0)
.s1023:
295a : c6 1c __ DEC ACCU + 1 
.s1024:
295c : c6 1b __ DEC ACCU + 0 
295e : a5 43 __ LDA T4 + 0 
2960 : d0 02 __ BNE $2964 ; (memmove.s1026 + 0)
.s1025:
2962 : c6 44 __ DEC T4 + 1 
.s1026:
2964 : c6 43 __ DEC T4 + 0 
2966 : b1 43 __ LDA (T4 + 0),y 
2968 : 91 1b __ STA (ACCU + 0),y 
296a : ca __ __ DEX
296b : d0 e9 __ BNE $2956 ; (memmove.l1017 + 0)
.s1018:
296d : 86 11 __ STX P4 ; (size + 0)
296f : c6 12 __ DEC P5 ; (size + 1)
2971 : d0 e1 __ BNE $2954 ; (memmove.l1009 + 0)
.s3:
2973 : a5 0d __ LDA P0 ; (dst + 0)
2975 : 85 1b __ STA ACCU + 0 
2977 : a5 0e __ LDA P1 ; (dst + 1)
2979 : 85 1c __ STA ACCU + 1 
.s1001:
297b : 60 __ __ RTS
.s15:
297c : a5 0d __ LDA P0 ; (dst + 0)
297e : 85 1b __ STA ACCU + 0 
2980 : a5 0e __ LDA P1 ; (dst + 1)
2982 : 85 1c __ STA ACCU + 1 
2984 : a0 00 __ LDY #$00
2986 : a5 11 __ LDA P4 ; (size + 0)
2988 : f0 02 __ BEQ $298c ; (memmove.l1007 + 0)
.s1012:
298a : e6 12 __ INC P5 ; (size + 1)
.l1007:
298c : a6 11 __ LDX P4 ; (size + 0)
.l1015:
298e : b1 0f __ LDA (P2),y ; (src + 0)
2990 : 91 1b __ STA (ACCU + 0),y 
2992 : e6 0f __ INC P2 ; (src + 0)
2994 : d0 02 __ BNE $2998 ; (memmove.s1020 + 0)
.s1019:
2996 : e6 10 __ INC P3 ; (src + 1)
.s1020:
2998 : e6 1b __ INC ACCU + 0 
299a : d0 02 __ BNE $299e ; (memmove.s1022 + 0)
.s1021:
299c : e6 1c __ INC ACCU + 1 
.s1022:
299e : ca __ __ DEX
299f : d0 ed __ BNE $298e ; (memmove.l1015 + 0)
.s1016:
29a1 : 86 11 __ STX P4 ; (size + 0)
29a3 : c6 12 __ DEC P5 ; (size + 1)
29a5 : d0 e5 __ BNE $298c ; (memmove.l1007 + 0)
29a7 : 90 ca __ BCC $2973 ; (memmove.s3 + 0)
--------------------------------------------------------------------
_savechpos: ; _savechpos()->void
.s0:
29a9 : ad 3b 3e LDA $3e3b ; (txt + 0)
29ac : 8d aa 3e STA $3eaa ; (btxt + 0)
29af : ad 3c 3e LDA $3e3c ; (txt + 1)
29b2 : 8d ab 3e STA $3eab ; (btxt + 1)
29b5 : ad 4e 3e LDA $3e4e ; (_cpl + 0)
29b8 : 8d ac 3e STA $3eac ; (b_cpl + 0)
29bb : ad 4f 3e LDA $3e4f ; (_cpl + 1)
29be : 8d ad 3e STA $3ead ; (b_cpl + 1)
29c1 : ad 4c 3e LDA $3e4c ; (_cplx + 0)
29c4 : 8d ae 3e STA $3eae ; (b_cplx + 0)
29c7 : ad 4d 3e LDA $3e4d ; (_cplw + 0)
29ca : 8d af 3e STA $3eaf ; (b_cplw + 0)
.s1001:
29cd : 60 __ __ RTS
--------------------------------------------------------------------
_restorechpos: ; _restorechpos()->void
.s0:
29ce : ad aa 3e LDA $3eaa ; (btxt + 0)
29d1 : 8d 3b 3e STA $3e3b ; (txt + 0)
29d4 : ad ab 3e LDA $3eab ; (btxt + 1)
29d7 : 8d 3c 3e STA $3e3c ; (txt + 1)
29da : ad ac 3e LDA $3eac ; (b_cpl + 0)
29dd : 8d 4e 3e STA $3e4e ; (_cpl + 0)
29e0 : ad ad 3e LDA $3ead ; (b_cpl + 1)
29e3 : 8d 4f 3e STA $3e4f ; (_cpl + 1)
29e6 : ad ae 3e LDA $3eae ; (b_cplx + 0)
29e9 : 8d 4c 3e STA $3e4c ; (_cplx + 0)
29ec : ad af 3e LDA $3eaf ; (b_cplw + 0)
29ef : 8d 4d 3e STA $3e4d ; (_cplw + 0)
.s1001:
29f2 : 60 __ __ RTS
--------------------------------------------------------------------
cr: ; cr()->void
.l30:
29f3 : 2c 11 d0 BIT $d011 
29f6 : 10 fb __ BPL $29f3 ; (cr.l30 + 0)
.s1:
29f8 : ad 76 3d LDA $3d76 ; (text_y + 0)
29fb : 85 45 __ STA T0 + 0 
29fd : 18 __ __ CLC
29fe : 69 01 __ ADC #$01
2a00 : 8d 76 3d STA $3d76 ; (text_y + 0)
2a03 : c9 0b __ CMP #$0b
2a05 : 90 08 __ BCC $2a0f ; (cr.s1001 + 0)
.s5:
2a07 : 20 57 28 JSR $2857 ; (scrollup.l71 + 0)
2a0a : a5 45 __ LDA T0 + 0 
2a0c : 8d 76 3d STA $3d76 ; (text_y + 0)
.s1001:
2a0f : 60 __ __ RTS
--------------------------------------------------------------------
ui_waitkey: ; ui_waitkey()->void
.s0:
2a10 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
2a13 : 18 __ __ CLC
2a14 : 69 c0 __ ADC #$c0
2a16 : 85 43 __ STA T1 + 0 
2a18 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
2a1b : 69 03 __ ADC #$03
2a1d : 85 44 __ STA T1 + 1 
2a1f : ad 62 3d LDA $3d62 ; (video_ram + 0)
2a22 : 18 __ __ CLC
2a23 : 69 c0 __ ADC #$c0
2a25 : 85 45 __ STA T2 + 0 
2a27 : ad 63 3d LDA $3d63 ; (video_ram + 1)
2a2a : 69 03 __ ADC #$03
2a2c : 85 46 __ STA T2 + 1 
2a2e : a0 12 __ LDY #$12
.l1006:
2a30 : a9 0f __ LDA #$0f
2a32 : 91 43 __ STA (T1 + 0),y 
2a34 : a9 2e __ LDA #$2e
2a36 : 91 45 __ STA (T2 + 0),y 
2a38 : c8 __ __ INY
2a39 : c0 15 __ CPY #$15
2a3b : 90 f3 __ BCC $2a30 ; (ui_waitkey.l1006 + 0)
.s3:
2a3d : a9 15 __ LDA #$15
2a3f : 8d 50 3e STA $3e50 ; (ll + 0)
2a42 : a9 00 __ LDA #$00
2a44 : 8d 51 3e STA $3e51 ; (ll + 1)
2a47 : 20 67 2a JSR $2a67 ; (ui_getkey.l2 + 0)
2a4a : a0 12 __ LDY #$12
.l1008:
2a4c : a9 0f __ LDA #$0f
2a4e : 91 43 __ STA (T1 + 0),y 
2a50 : a9 20 __ LDA #$20
2a52 : 91 45 __ STA (T2 + 0),y 
2a54 : c8 __ __ INY
2a55 : c0 15 __ CPY #$15
2a57 : 90 f3 __ BCC $2a4c ; (ui_waitkey.l1008 + 0)
.s6:
2a59 : a9 00 __ LDA #$00
2a5b : 8d 21 3e STA $3e21 ; (al + 0)
2a5e : 8d 51 3e STA $3e51 ; (ll + 1)
2a61 : a9 15 __ LDA #$15
2a63 : 8d 50 3e STA $3e50 ; (ll + 0)
.s1001:
2a66 : 60 __ __ RTS
--------------------------------------------------------------------
ui_getkey: ; ui_getkey()->void
.l2:
2a67 : 20 9f ff JSR $ff9f 
2a6a : 20 e4 ff JSR $ffe4 
2a6d : 8d 36 3e STA $3e36 ; (ch + 0)
2a70 : ad 36 3e LDA $3e36 ; (ch + 0)
2a73 : d0 08 __ BNE $2a7d ; (ui_getkey.s1001 + 0)
.l82:
2a75 : 2c 11 d0 BIT $d011 
2a78 : 10 fb __ BPL $2a75 ; (ui_getkey.l82 + 0)
2a7a : 4c 67 2a JMP $2a67 ; (ui_getkey.l2 + 0)
.s1001:
2a7d : 60 __ __ RTS
--------------------------------------------------------------------
adv_save: ; adv_save()->u8
.s0:
2a7e : a9 00 __ LDA #$00
2a80 : 85 13 __ STA P6 
2a82 : 20 c6 2a JSR $2ac6 ; (irq_detach.l30 + 0)
2a85 : a9 74 __ LDA #$74
2a87 : 85 0d __ STA P0 
2a89 : a9 2b __ LDA #$2b
2a8b : 85 0e __ STA P1 
2a8d : ad 0a 3e LDA $3e0a ; (objattr + 0)
2a90 : 85 0f __ STA P2 
2a92 : ad 0b 3e LDA $3e0b ; (objattr + 1)
2a95 : 85 10 __ STA P3 
2a97 : ad 1a 3e LDA $3e1a ; (origram_len + 0)
2a9a : 85 11 __ STA P4 
2a9c : ad 1b 3e LDA $3e1b ; (origram_len + 1)
2a9f : 85 12 __ STA P5 
2aa1 : 20 26 2b JSR $2b26 ; (disk_save.s0 + 0)
2aa4 : 09 00 __ ORA #$00
2aa6 : f0 07 __ BEQ $2aaf ; (adv_save.s1 + 0)
.s2:
2aa8 : 20 79 2b JSR $2b79 ; (irq_attach.l27 + 0)
2aab : a9 01 __ LDA #$01
2aad : d0 14 __ BNE $2ac3 ; (adv_save.s1001 + 0)
.s1:
2aaf : a9 02 __ LDA #$02
2ab1 : 8d 20 d0 STA $d020 
.l32:
2ab4 : 2c 11 d0 BIT $d011 
2ab7 : 10 fb __ BPL $2ab4 ; (adv_save.l32 + 0)
.s4:
2ab9 : a9 00 __ LDA #$00
2abb : 8d 20 d0 STA $d020 
2abe : 20 79 2b JSR $2b79 ; (irq_attach.l27 + 0)
2ac1 : a9 00 __ LDA #$00
.s1001:
2ac3 : 85 1b __ STA ACCU + 0 
2ac5 : 60 __ __ RTS
--------------------------------------------------------------------
irq_detach: ; irq_detach(u8)->void
.l30:
2ac6 : 2c 11 d0 BIT $d011 
2ac9 : 10 fb __ BPL $2ac6 ; (irq_detach.l30 + 0)
.s1:
2acb : 20 11 2b JSR $2b11 ; (IRQ_reset.s0 + 0)
2ace : a5 13 __ LDA P6 ; (mode + 0)
2ad0 : f0 3c __ BEQ $2b0e ; (irq_detach.s5 + 0)
.s6:
2ad2 : 20 f3 11 JSR $11f3 ; (do_bitmapmode.s0 + 0)
2ad5 : a9 00 __ LDA #$00
2ad7 : 85 0f __ STA P2 
2ad9 : 85 10 __ STA P3 
2adb : a9 08 __ LDA #$08
2add : 85 11 __ STA P4 
2adf : a9 02 __ LDA #$02
2ae1 : 85 12 __ STA P5 
2ae3 : a9 e0 __ LDA #$e0
2ae5 : 85 0d __ STA P0 
2ae7 : a9 f1 __ LDA #$f1
2ae9 : 85 0e __ STA P1 
2aeb : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
2aee : a9 00 __ LDA #$00
2af0 : 85 0f __ STA P2 
2af2 : 85 10 __ STA P3 
2af4 : a9 08 __ LDA #$08
2af6 : 85 11 __ STA P4 
2af8 : a9 02 __ LDA #$02
2afa : 85 12 __ STA P5 
2afc : ad 64 3d LDA $3d64 ; (video_colorram + 0)
2aff : 18 __ __ CLC
2b00 : 69 e0 __ ADC #$e0
2b02 : 85 0d __ STA P0 
2b04 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
2b07 : 69 01 __ ADC #$01
2b09 : 85 0e __ STA P1 
2b0b : 4c 04 0d JMP $0d04 ; (memset.s0 + 0)
.s5:
2b0e : 4c 28 0d JMP $0d28 ; (do_textmode.s0 + 0)
--------------------------------------------------------------------
IRQ_reset: ; IRQ_reset()->void
.s0:
2b11 : 78 __ __ SEI
2b12 : ad 1a d0 LDA $d01a 
2b15 : 29 fe __ AND #$fe
2b17 : 8d 1a d0 STA $d01a 
2b1a : a2 81 __ LDX #$81
2b1c : a0 ea __ LDY #$ea
2b1e : 8e 14 03 STX $0314 
2b21 : 8c 15 03 STY $0315 
2b24 : 58 __ __ CLI
.s1001:
2b25 : 60 __ __ RTS
--------------------------------------------------------------------
disk_save: ; disk_save(const u8*,u8*,u16)->u8
.s0:
2b26 : a5 0f __ LDA P2 ; (mem + 0)
2b28 : 8d b0 3e STA $3eb0 ; (diskmemlow + 0)
2b2b : 18 __ __ CLC
2b2c : 65 11 __ ADC P4 ; (len + 0)
2b2e : 8d b2 3e STA $3eb2 ; (ediskmemlow + 0)
2b31 : a5 10 __ LDA P3 ; (mem + 1)
2b33 : 8d b1 3e STA $3eb1 ; (diskmemhi + 0)
2b36 : 65 12 __ ADC P5 ; (len + 1)
2b38 : 8d b3 3e STA $3eb3 ; (ediskmemhi + 0)
2b3b : a9 07 __ LDA #$07
2b3d : a2 ae __ LDX #$ae
2b3f : a0 3d __ LDY #$3d
2b41 : 20 bd ff JSR $ffbd 
2b44 : a9 01 __ LDA #$01
2b46 : a6 ba __ LDX $ba 
2b48 : d0 02 __ BNE $2b4c ; (disk_save.s0 + 38)
2b4a : a2 08 __ LDX #$08
2b4c : a0 00 __ LDY #$00
2b4e : 20 ba ff JSR $ffba 
2b51 : ad b0 3e LDA $3eb0 ; (diskmemlow + 0)
2b54 : 85 c1 __ STA $c1 
2b56 : ad b1 3e LDA $3eb1 ; (diskmemhi + 0)
2b59 : 85 c2 __ STA $c2 
2b5b : ae b2 3e LDX $3eb2 ; (ediskmemlow + 0)
2b5e : ac b3 3e LDY $3eb3 ; (ediskmemhi + 0)
2b61 : a9 c1 __ LDA #$c1
2b63 : 20 d8 ff JSR $ffd8 
2b66 : b0 05 __ BCS $2b6d ; (disk_save.s0 + 71)
2b68 : a9 01 __ LDA #$01
2b6a : 85 1b __ STA ACCU + 0 
2b6c : 60 __ __ RTS
2b6d : a9 00 __ LDA #$00
2b6f : 85 1b __ STA ACCU + 0 
.s1001:
2b71 : a5 1b __ LDA ACCU + 0 
2b73 : 60 __ __ RTS
--------------------------------------------------------------------
2b74 : __ __ __ BYT 73 61 76 65 00                                  : save.
--------------------------------------------------------------------
irq_attach: ; irq_attach()->void
.l27:
2b79 : 2c 11 d0 BIT $d011 
2b7c : 10 fb __ BPL $2b79 ; (irq_attach.l27 + 0)
.s1:
2b7e : 4c b1 11 JMP $11b1 ; (IRQ_gfx_init.s0 + 0)
--------------------------------------------------------------------
mini_itoa: ; mini_itoa(i16,u8*)->void
.s0:
2b81 : a5 0e __ LDA P1 ; (n + 1)
2b83 : 30 75 __ BMI $2bfa ; (mini_itoa.s3 + 0)
.s1012:
2b85 : d0 06 __ BNE $2b8d ; (mini_itoa.s1 + 0)
.s1011:
2b87 : a5 0d __ LDA P0 ; (n + 0)
2b89 : c9 64 __ CMP #$64
2b8b : 90 6d __ BCC $2bfa ; (mini_itoa.s3 + 0)
.s1:
2b8d : a5 0f __ LDA P2 ; (s + 0)
2b8f : 85 1b __ STA ACCU + 0 
2b91 : a5 10 __ LDA P3 ; (s + 1)
2b93 : 85 1c __ STA ACCU + 1 
2b95 : a9 30 __ LDA #$30
2b97 : a0 00 __ LDY #$00
2b99 : 91 0f __ STA (P2),y ; (s + 0)
2b9b : a6 0d __ LDX P0 ; (n + 0)
.l1015:
2b9d : b1 1b __ LDA (ACCU + 0),y 
2b9f : 18 __ __ CLC
2ba0 : 69 01 __ ADC #$01
2ba2 : 91 1b __ STA (ACCU + 0),y 
2ba4 : 8a __ __ TXA
2ba5 : 38 __ __ SEC
2ba6 : e9 64 __ SBC #$64
2ba8 : aa __ __ TAX
2ba9 : a5 0e __ LDA P1 ; (n + 1)
2bab : e9 00 __ SBC #$00
2bad : 85 0e __ STA P1 ; (n + 1)
2baf : d0 ec __ BNE $2b9d ; (mini_itoa.l1015 + 0)
.s1010:
2bb1 : e0 64 __ CPX #$64
2bb3 : b0 e8 __ BCS $2b9d ; (mini_itoa.l1015 + 0)
.s18:
2bb5 : 86 0d __ STX P0 ; (n + 0)
2bb7 : a9 01 __ LDA #$01
2bb9 : 85 1b __ STA ACCU + 0 
2bbb : e0 0a __ CPX #$0a
2bbd : 90 31 __ BCC $2bf0 ; (mini_itoa.s8 + 0)
.s32:
2bbf : a8 __ __ TAY
.s7:
2bc0 : a9 30 __ LDA #$30
2bc2 : 91 0f __ STA (P2),y ; (s + 0)
2bc4 : a5 0d __ LDA P0 ; (n + 0)
2bc6 : 30 17 __ BMI $2bdf ; (mini_itoa.s50 + 0)
.s1019:
2bc8 : c9 0a __ CMP #$0a
2bca : 90 13 __ BCC $2bdf ; (mini_itoa.s50 + 0)
.s1017:
2bcc : aa __ __ TAX
.l1013:
2bcd : b1 0f __ LDA (P2),y ; (s + 0)
2bcf : 18 __ __ CLC
2bd0 : 69 01 __ ADC #$01
2bd2 : 91 0f __ STA (P2),y ; (s + 0)
2bd4 : 8a __ __ TXA
2bd5 : 38 __ __ SEC
2bd6 : e9 0a __ SBC #$0a
2bd8 : aa __ __ TAX
2bd9 : e0 0a __ CPX #$0a
2bdb : b0 f0 __ BCS $2bcd ; (mini_itoa.l1013 + 0)
.s1018:
2bdd : 85 0d __ STA P0 ; (n + 0)
.s50:
2bdf : e6 1b __ INC ACCU + 0 
.s9:
2be1 : 18 __ __ CLC
2be2 : a5 0d __ LDA P0 ; (n + 0)
2be4 : 69 30 __ ADC #$30
2be6 : a4 1b __ LDY ACCU + 0 
2be8 : 91 0f __ STA (P2),y ; (s + 0)
2bea : a9 00 __ LDA #$00
2bec : c8 __ __ INY
2bed : 91 0f __ STA (P2),y ; (s + 0)
.s1001:
2bef : 60 __ __ RTS
.s8:
2bf0 : a4 1b __ LDY ACCU + 0 
2bf2 : f0 ed __ BEQ $2be1 ; (mini_itoa.s9 + 0)
.s13:
2bf4 : a9 30 __ LDA #$30
2bf6 : 91 0f __ STA (P2),y ; (s + 0)
2bf8 : d0 e5 __ BNE $2bdf ; (mini_itoa.s50 + 0)
.s3:
2bfa : a9 00 __ LDA #$00
2bfc : 85 1b __ STA ACCU + 0 
2bfe : a5 0e __ LDA P1 ; (n + 1)
2c00 : 30 ee __ BMI $2bf0 ; (mini_itoa.s8 + 0)
.s1007:
2c02 : d0 06 __ BNE $2c0a ; (mini_itoa.s33 + 0)
.s1006:
2c04 : a5 0d __ LDA P0 ; (n + 0)
2c06 : c9 0a __ CMP #$0a
2c08 : 90 e6 __ BCC $2bf0 ; (mini_itoa.s8 + 0)
.s33:
2c0a : a0 00 __ LDY #$00
2c0c : f0 b2 __ BEQ $2bc0 ; (mini_itoa.s7 + 0)
--------------------------------------------------------------------
ui_room_update: ; ui_room_update()->void
.l27:
2c0e : 2c 11 d0 BIT $d011 
2c11 : 10 fb __ BPL $2c0e ; (ui_room_update.l27 + 0)
.s1:
2c13 : 20 19 2c JSR $2c19 ; (ui_room_gfx_update.l88 + 0)
2c16 : 4c ed 2f JMP $2fed ; (status_update.s0 + 0)
--------------------------------------------------------------------
ui_room_gfx_update: ; ui_room_gfx_update()->void
.l88:
2c19 : 2c 11 d0 BIT $d011 
2c1c : 10 fb __ BPL $2c19 ; (ui_room_gfx_update.l88 + 0)
.s1:
2c1e : a2 0b __ LDX #$0b
.l1002:
2c20 : bd b6 3d LDA $3db6,x ; (slowmode + 0)
2c23 : 9d f3 cb STA $cbf3,x ; (size + 1)
2c26 : ca __ __ DEX
2c27 : d0 f7 __ BNE $2c20 ; (ui_room_gfx_update.l1002 + 0)
.s1003:
2c29 : a9 f4 __ LDA #$f4
2c2b : 85 0d __ STA P0 
2c2d : a9 cb __ LDA #$cb
2c2f : 85 0e __ STA P1 
2c31 : a5 ba __ LDA $ba 
2c33 : d0 02 __ BNE $2c37 ; (ui_room_gfx_update.s7 + 0)
.s5:
2c35 : a9 08 __ LDA #$08
.s7:
2c37 : 86 1c __ STX ACCU + 1 
2c39 : 86 04 __ STX WORK + 1 
2c3b : 85 4b __ STA T0 + 0 
2c3d : ae b6 3e LDX $3eb6 ; (imageid + 0)
2c40 : e8 __ __ INX
2c41 : 86 1b __ STX ACCU + 0 
2c43 : a9 0a __ LDA #$0a
2c45 : 85 03 __ STA WORK + 0 
2c47 : 20 5f 3a JSR $3a5f ; (divmod + 0)
2c4a : 18 __ __ CLC
2c4b : a5 1b __ LDA ACCU + 0 
2c4d : 69 30 __ ADC #$30
2c4f : 8d f8 cb STA $cbf8 ; (nm + 4)
2c52 : 18 __ __ CLC
2c53 : a5 05 __ LDA WORK + 2 
2c55 : 69 30 __ ADC #$30
2c57 : 8d f9 cb STA $cbf9 ; (nm + 5)
2c5a : 20 7b 2e JSR $2e7b ; (krnio_setnam.s0 + 0)
2c5d : a9 02 __ LDA #$02
2c5f : 85 0d __ STA P0 
2c61 : a5 4b __ LDA T0 + 0 
2c63 : 85 0e __ STA P1 
2c65 : a9 00 __ LDA #$00
2c67 : 85 0f __ STA P2 
2c69 : 20 91 2e JSR $2e91 ; (krnio_open.s0 + 0)
2c6c : 09 00 __ ORA #$00
2c6e : d0 01 __ BNE $2c71 ; (ui_room_gfx_update.s8 + 0)
.s1001:
2c70 : 60 __ __ RTS
.s8:
2c71 : a9 02 __ LDA #$02
2c73 : 85 0e __ STA P1 
2c75 : a9 0a __ LDA #$0a
2c77 : 85 11 __ STA P4 
2c79 : a9 00 __ LDA #$00
2c7b : 85 12 __ STA P5 
2c7d : a9 e6 __ LDA #$e6
2c7f : 85 0f __ STA P2 
2c81 : a9 cb __ LDA #$cb
2c83 : 85 10 __ STA P3 
2c85 : 20 bb 2e JSR $2ebb ; (krnio_read.s0 + 0)
2c88 : a9 02 __ LDA #$02
2c8a : 85 0e __ STA P1 
2c8c : a9 ff __ LDA #$ff
2c8e : 4d e6 cb EOR $cbe6 ; (head + 0)
2c91 : 85 4c __ STA T1 + 0 
2c93 : 85 0f __ STA P2 
2c95 : 38 __ __ SEC
2c96 : a9 cf __ LDA #$cf
2c98 : ed e7 cb SBC $cbe7 ; (head + 1)
2c9b : 85 4d __ STA T1 + 1 
2c9d : 85 10 __ STA P3 
2c9f : ad ee cb LDA $cbee ; (head + 8)
2ca2 : 18 __ __ CLC
2ca3 : 6d ea cb ADC $cbea ; (head + 4)
2ca6 : 85 11 __ STA P4 
2ca8 : ad ef cb LDA $cbef ; (head + 9)
2cab : 6d eb cb ADC $cbeb ; (head + 5)
2cae : 85 12 __ STA P5 
2cb0 : 20 bb 2e JSR $2ebb ; (krnio_read.s0 + 0)
2cb3 : ad b6 3d LDA $3db6 ; (slowmode + 0)
2cb6 : f0 26 __ BEQ $2cde ; (ui_room_gfx_update.s13 + 0)
.s11:
2cb8 : 20 85 12 JSR $1285 ; (ui_clear.s0 + 0)
2cbb : a9 a0 __ LDA #$a0
2cbd : 85 0f __ STA P2 
2cbf : a9 00 __ LDA #$00
2cc1 : 85 10 __ STA P3 
2cc3 : 85 12 __ STA P5 
2cc5 : a9 28 __ LDA #$28
2cc7 : 85 11 __ STA P4 
2cc9 : ad 62 3d LDA $3d62 ; (video_ram + 0)
2ccc : 18 __ __ CLC
2ccd : 69 08 __ ADC #$08
2ccf : 85 0d __ STA P0 
2cd1 : ad 63 3d LDA $3d63 ; (video_ram + 1)
2cd4 : 69 02 __ ADC #$02
2cd6 : 85 0e __ STA P1 
2cd8 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
2cdb : 20 63 2f JSR $2f63 ; (ui_image_fade.s0 + 0)
.s13:
2cde : a5 01 __ LDA $01 
2ce0 : 85 4b __ STA T0 + 0 
2ce2 : a9 34 __ LDA #$34
2ce4 : 85 01 __ STA $01 
2ce6 : ad e9 cb LDA $cbe9 ; (head + 3)
2ce9 : cd eb cb CMP $cbeb ; (head + 5)
2cec : d0 08 __ BNE $2cf6 ; (ui_room_gfx_update.s15 + 0)
.s1012:
2cee : ad e8 cb LDA $cbe8 ; (head + 2)
2cf1 : cd ea cb CMP $cbea ; (head + 4)
2cf4 : f0 16 __ BEQ $2d0c ; (ui_room_gfx_update.s14 + 0)
.s15:
2cf6 : a5 4c __ LDA T1 + 0 
2cf8 : 85 0d __ STA P0 
2cfa : a5 4d __ LDA T1 + 1 
2cfc : 85 0e __ STA P1 
2cfe : a9 00 __ LDA #$00
2d00 : 85 0f __ STA P2 
2d02 : a9 f0 __ LDA #$f0
2d04 : 85 10 __ STA P3 
2d06 : 20 37 0b JSR $0b37 ; (hunpack.s0 + 0)
2d09 : 4c 29 2d JMP $2d29 ; (ui_room_gfx_update.s16 + 0)
.s14:
2d0c : a9 00 __ LDA #$00
2d0e : 85 0d __ STA P0 
2d10 : a9 f0 __ LDA #$f0
2d12 : 85 0e __ STA P1 
2d14 : a5 4c __ LDA T1 + 0 
2d16 : 85 0f __ STA P2 
2d18 : a5 4d __ LDA T1 + 1 
2d1a : 85 10 __ STA P3 
2d1c : ad e8 cb LDA $cbe8 ; (head + 2)
2d1f : 85 11 __ STA P4 
2d21 : ad e9 cb LDA $cbe9 ; (head + 3)
2d24 : 85 12 __ STA P5 
2d26 : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
.s16:
2d29 : a5 4b __ LDA T0 + 0 
2d2b : 85 01 __ STA $01 
2d2d : a9 00 __ LDA #$00
2d2f : 85 4e __ STA T3 + 0 
2d31 : 85 4f __ STA T3 + 1 
2d33 : 85 1b __ STA ACCU + 0 
2d35 : 85 1c __ STA ACCU + 1 
2d37 : cd ed cb CMP $cbed ; (head + 7)
2d3a : d0 05 __ BNE $2d41 ; (ui_room_gfx_update.l1011 + 0)
.s1010:
2d3c : a5 1b __ LDA ACCU + 0 
2d3e : cd ec cb CMP $cbec ; (head + 6)
.l1011:
2d41 : b0 03 __ BCS $2d46 ; (ui_room_gfx_update.s19 + 0)
2d43 : 4c 28 2e JMP $2e28 ; (ui_room_gfx_update.s18 + 0)
.s19:
2d46 : a9 02 __ LDA #$02
2d48 : 85 0e __ STA P1 
2d4a : 85 11 __ STA P4 
2d4c : a9 00 __ LDA #$00
2d4e : 85 12 __ STA P5 
2d50 : a9 f0 __ LDA #$f0
2d52 : 85 0f __ STA P2 
2d54 : a9 cb __ LDA #$cb
2d56 : 85 10 __ STA P3 
2d58 : 20 bb 2e JSR $2ebb ; (krnio_read.s0 + 0)
2d5b : ad f0 cb LDA $cbf0 ; (bsize + 0)
2d5e : 0d f1 cb ORA $cbf1 ; (bsize + 1)
2d61 : d0 05 __ BNE $2d68 ; (ui_room_gfx_update.s27 + 0)
.s22:
2d63 : a9 02 __ LDA #$02
2d65 : 4c e5 2f JMP $2fe5 ; (krnio_close.s1000 + 0)
.s27:
2d68 : a9 00 __ LDA #$00
2d6a : 85 4e __ STA T3 + 0 
2d6c : 85 4f __ STA T3 + 1 
.l21:
2d6e : a9 02 __ LDA #$02
2d70 : 85 0e __ STA P1 
2d72 : 85 11 __ STA P4 
2d74 : a9 f2 __ LDA #$f2
2d76 : 85 0f __ STA P2 
2d78 : a9 cb __ LDA #$cb
2d7a : 85 10 __ STA P3 
2d7c : a9 00 __ LDA #$00
2d7e : 85 12 __ STA P5 
2d80 : 20 bb 2e JSR $2ebb ; (krnio_read.s0 + 0)
2d83 : a9 02 __ LDA #$02
2d85 : 85 0e __ STA P1 
2d87 : a5 4c __ LDA T1 + 0 
2d89 : 85 0f __ STA P2 
2d8b : a5 4d __ LDA T1 + 1 
2d8d : 85 10 __ STA P3 
2d8f : ad f2 cb LDA $cbf2 ; (size + 0)
2d92 : 85 11 __ STA P4 
2d94 : ad f3 cb LDA $cbf3 ; (size + 1)
2d97 : 85 12 __ STA P5 
2d99 : 20 bb 2e JSR $2ebb ; (krnio_read.s0 + 0)
2d9c : a5 01 __ LDA $01 
2d9e : 85 4b __ STA T0 + 0 
2da0 : a9 34 __ LDA #$34
2da2 : 85 01 __ STA $01 
2da4 : ad f0 cb LDA $cbf0 ; (bsize + 0)
2da7 : 38 __ __ SEC
2da8 : e5 4e __ SBC T3 + 0 
2daa : 85 44 __ STA T5 + 0 
2dac : ad f1 cb LDA $cbf1 ; (bsize + 1)
2daf : e5 4f __ SBC T3 + 1 
2db1 : cd f3 cb CMP $cbf3 ; (size + 1)
2db4 : d0 07 __ BNE $2dbd ; (ui_room_gfx_update.s26 + 0)
.s1008:
2db6 : ad f2 cb LDA $cbf2 ; (size + 0)
2db9 : c5 44 __ CMP T5 + 0 
2dbb : f0 2d __ BEQ $2dea ; (ui_room_gfx_update.s23 + 0)
.s26:
2dbd : ad f3 cb LDA $cbf3 ; (size + 1)
2dc0 : cd e7 cb CMP $cbe7 ; (head + 1)
2dc3 : d0 08 __ BNE $2dcd ; (ui_room_gfx_update.s24 + 0)
.s1006:
2dc5 : ad f2 cb LDA $cbf2 ; (size + 0)
2dc8 : cd e6 cb CMP $cbe6 ; (head + 0)
2dcb : f0 1d __ BEQ $2dea ; (ui_room_gfx_update.s23 + 0)
.s24:
2dcd : a5 0f __ LDA P2 
2dcf : 85 0d __ STA P0 
2dd1 : a5 10 __ LDA P3 
2dd3 : 85 0e __ STA P1 
2dd5 : ad c2 3d LDA $3dc2 ; (bitmap_image + 0)
2dd8 : 18 __ __ CLC
2dd9 : 65 4e __ ADC T3 + 0 
2ddb : 85 0f __ STA P2 
2ddd : ad c3 3d LDA $3dc3 ; (bitmap_image + 1)
2de0 : 65 4f __ ADC T3 + 1 
2de2 : 85 10 __ STA P3 
2de4 : 20 37 0b JSR $0b37 ; (hunpack.s0 + 0)
2de7 : 4c 03 2e JMP $2e03 ; (ui_room_gfx_update.s25 + 0)
.s23:
2dea : 85 11 __ STA P4 
2dec : ad f3 cb LDA $cbf3 ; (size + 1)
2def : 85 12 __ STA P5 
2df1 : ad c2 3d LDA $3dc2 ; (bitmap_image + 0)
2df4 : 18 __ __ CLC
2df5 : 65 4e __ ADC T3 + 0 
2df7 : 85 0d __ STA P0 
2df9 : ad c3 3d LDA $3dc3 ; (bitmap_image + 1)
2dfc : 65 4f __ ADC T3 + 1 
2dfe : 85 0e __ STA P1 
2e00 : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
.s25:
2e03 : a5 4b __ LDA T0 + 0 
2e05 : 85 01 __ STA $01 
2e07 : ad e6 cb LDA $cbe6 ; (head + 0)
2e0a : 18 __ __ CLC
2e0b : 65 4e __ ADC T3 + 0 
2e0d : 85 4e __ STA T3 + 0 
2e0f : ad e7 cb LDA $cbe7 ; (head + 1)
2e12 : 65 4f __ ADC T3 + 1 
2e14 : 85 4f __ STA T3 + 1 
2e16 : cd f1 cb CMP $cbf1 ; (bsize + 1)
2e19 : d0 05 __ BNE $2e20 ; (ui_room_gfx_update.s1005 + 0)
.s1004:
2e1b : a5 4e __ LDA T3 + 0 
2e1d : cd f0 cb CMP $cbf0 ; (bsize + 0)
.s1005:
2e20 : b0 03 __ BCS $2e25 ; (ui_room_gfx_update.s1005 + 5)
2e22 : 4c 6e 2d JMP $2d6e ; (ui_room_gfx_update.l21 + 0)
2e25 : 4c 63 2d JMP $2d63 ; (ui_room_gfx_update.s22 + 0)
.s18:
2e28 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
2e2b : 65 4e __ ADC T3 + 0 
2e2d : 85 44 __ STA T5 + 0 
2e2f : ad 65 3d LDA $3d65 ; (video_colorram + 1)
2e32 : 65 4f __ ADC T3 + 1 
2e34 : 85 45 __ STA T5 + 1 
2e36 : ad ea cb LDA $cbea ; (head + 4)
2e39 : 18 __ __ CLC
2e3a : 65 1b __ ADC ACCU + 0 
2e3c : 85 46 __ STA T6 + 0 
2e3e : ad eb cb LDA $cbeb ; (head + 5)
2e41 : 65 1c __ ADC ACCU + 1 
2e43 : 18 __ __ CLC
2e44 : 65 4d __ ADC T1 + 1 
2e46 : 85 47 __ STA T6 + 1 
2e48 : a4 4c __ LDY T1 + 0 
2e4a : b1 46 __ LDA (T6 + 0),y 
2e4c : aa __ __ TAX
2e4d : 29 0f __ AND #$0f
2e4f : a0 00 __ LDY #$00
2e51 : 91 44 __ STA (T5 + 0),y 
2e53 : 8a __ __ TXA
2e54 : 29 f0 __ AND #$f0
2e56 : 4a __ __ LSR
2e57 : 4a __ __ LSR
2e58 : 4a __ __ LSR
2e59 : 4a __ __ LSR
2e5a : c8 __ __ INY
2e5b : 91 44 __ STA (T5 + 0),y 
2e5d : e6 1b __ INC ACCU + 0 
2e5f : d0 02 __ BNE $2e63 ; (ui_room_gfx_update.s1015 + 0)
.s1014:
2e61 : e6 1c __ INC ACCU + 1 
.s1015:
2e63 : 18 __ __ CLC
2e64 : a5 4e __ LDA T3 + 0 
2e66 : 69 02 __ ADC #$02
2e68 : 85 4e __ STA T3 + 0 
2e6a : 90 02 __ BCC $2e6e ; (ui_room_gfx_update.s1017 + 0)
.s1016:
2e6c : e6 4f __ INC T3 + 1 
.s1017:
2e6e : a5 1c __ LDA ACCU + 1 
2e70 : cd ed cb CMP $cbed ; (head + 7)
2e73 : f0 03 __ BEQ $2e78 ; (ui_room_gfx_update.s1017 + 10)
2e75 : 4c 41 2d JMP $2d41 ; (ui_room_gfx_update.l1011 + 0)
2e78 : 4c 3c 2d JMP $2d3c ; (ui_room_gfx_update.s1010 + 0)
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
.s0:
2e7b : a5 0d __ LDA P0 
2e7d : 05 0e __ ORA P1 
2e7f : f0 08 __ BEQ $2e89 ; (krnio_setnam.s0 + 14)
2e81 : a0 ff __ LDY #$ff
2e83 : c8 __ __ INY
2e84 : b1 0d __ LDA (P0),y 
2e86 : d0 fb __ BNE $2e83 ; (krnio_setnam.s0 + 8)
2e88 : 98 __ __ TYA
2e89 : a6 0d __ LDX P0 
2e8b : a4 0e __ LDY P1 
2e8d : 20 bd ff JSR $ffbd 
.s1001:
2e90 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_open: ; krnio_open(u8,u8,u8)->bool
.s0:
2e91 : a9 00 __ LDA #$00
2e93 : a6 0d __ LDX P0 ; (fnum + 0)
2e95 : 9d b7 3e STA $3eb7,x ; (krnio_pstatus + 0)
2e98 : a9 00 __ LDA #$00
2e9a : 85 1b __ STA ACCU + 0 
2e9c : 85 1c __ STA ACCU + 1 
2e9e : a5 0d __ LDA P0 ; (fnum + 0)
2ea0 : a6 0e __ LDX P1 
2ea2 : a4 0f __ LDY P2 
2ea4 : 20 ba ff JSR $ffba 
2ea7 : 20 c0 ff JSR $ffc0 
2eaa : 90 08 __ BCC $2eb4 ; (krnio_open.s0 + 35)
2eac : a5 0d __ LDA P0 ; (fnum + 0)
2eae : 20 c3 ff JSR $ffc3 
2eb1 : 4c b8 2e JMP $2eb8 ; (krnio_open.s1001 + 0)
2eb4 : a9 01 __ LDA #$01
2eb6 : 85 1b __ STA ACCU + 0 
.s1001:
2eb8 : a5 1b __ LDA ACCU + 0 
2eba : 60 __ __ RTS
--------------------------------------------------------------------
krnio_read: ; krnio_read(u8,u8*,i16)->i16
.s0:
2ebb : a6 0e __ LDX P1 ; (fnum + 0)
2ebd : bd b7 3e LDA $3eb7,x ; (krnio_pstatus + 0)
2ec0 : c9 40 __ CMP #$40
2ec2 : d0 04 __ BNE $2ec8 ; (krnio_read.s3 + 0)
.s1:
2ec4 : a9 00 __ LDA #$00
2ec6 : f0 0c __ BEQ $2ed4 ; (krnio_read.s1010 + 0)
.s3:
2ec8 : 86 43 __ STX T1 + 0 
2eca : 8a __ __ TXA
2ecb : 20 35 2f JSR $2f35 ; (krnio_chkin.s1000 + 0)
2ece : 09 00 __ ORA #$00
2ed0 : d0 07 __ BNE $2ed9 ; (krnio_read.s5 + 0)
.s6:
2ed2 : a9 ff __ LDA #$ff
.s1010:
2ed4 : 85 1b __ STA ACCU + 0 
.s1001:
2ed6 : 85 1c __ STA ACCU + 1 
2ed8 : 60 __ __ RTS
.s5:
2ed9 : a9 00 __ LDA #$00
2edb : 85 44 __ STA T3 + 0 
2edd : 85 45 __ STA T3 + 1 
2edf : a5 12 __ LDA P5 ; (num + 1)
2ee1 : 30 46 __ BMI $2f29 ; (krnio_read.s10 + 0)
.s1007:
2ee3 : 05 11 __ ORA P4 ; (num + 0)
2ee5 : f0 42 __ BEQ $2f29 ; (krnio_read.s10 + 0)
.l9:
2ee7 : 20 49 2f JSR $2f49 ; (krnio_chrin.s0 + 0)
2eea : a5 1b __ LDA ACCU + 0 
2eec : 85 46 __ STA T4 + 0 
2eee : 20 53 2f JSR $2f53 ; (krnio_status.s0 + 0)
2ef1 : aa __ __ TAX
2ef2 : a4 43 __ LDY T1 + 0 
2ef4 : 99 b7 3e STA $3eb7,y ; (krnio_pstatus + 0)
2ef7 : 09 00 __ ORA #$00
2ef9 : f0 04 __ BEQ $2eff ; (krnio_read.s13 + 0)
.s14:
2efb : c9 40 __ CMP #$40
2efd : d0 2a __ BNE $2f29 ; (krnio_read.s10 + 0)
.s13:
2eff : a5 44 __ LDA T3 + 0 
2f01 : 85 1b __ STA ACCU + 0 
2f03 : 18 __ __ CLC
2f04 : a5 10 __ LDA P3 ; (data + 1)
2f06 : 65 45 __ ADC T3 + 1 
2f08 : 85 1c __ STA ACCU + 1 
2f0a : a5 46 __ LDA T4 + 0 
2f0c : a4 0f __ LDY P2 ; (data + 0)
2f0e : 91 1b __ STA (ACCU + 0),y 
2f10 : e6 44 __ INC T3 + 0 
2f12 : d0 02 __ BNE $2f16 ; (krnio_read.s1012 + 0)
.s1011:
2f14 : e6 45 __ INC T3 + 1 
.s1012:
2f16 : 8a __ __ TXA
2f17 : d0 10 __ BNE $2f29 ; (krnio_read.s10 + 0)
.s8:
2f19 : 24 12 __ BIT P5 ; (num + 1)
2f1b : 30 0c __ BMI $2f29 ; (krnio_read.s10 + 0)
.s1004:
2f1d : a5 45 __ LDA T3 + 1 
2f1f : c5 12 __ CMP P5 ; (num + 1)
2f21 : d0 04 __ BNE $2f27 ; (krnio_read.s1003 + 0)
.s1002:
2f23 : a5 44 __ LDA T3 + 0 
2f25 : c5 11 __ CMP P4 ; (num + 0)
.s1003:
2f27 : 90 be __ BCC $2ee7 ; (krnio_read.l9 + 0)
.s10:
2f29 : 20 5f 2f JSR $2f5f ; (krnio_clrchn.s0 + 0)
2f2c : a5 44 __ LDA T3 + 0 
2f2e : 85 1b __ STA ACCU + 0 
2f30 : a5 45 __ LDA T3 + 1 
2f32 : 4c d6 2e JMP $2ed6 ; (krnio_read.s1001 + 0)
--------------------------------------------------------------------
krnio_chkin: ; krnio_chkin(u8)->bool
.s1000:
2f35 : 85 0d __ STA P0 
.s0:
2f37 : a6 0d __ LDX P0 
2f39 : 20 c6 ff JSR $ffc6 
2f3c : a9 00 __ LDA #$00
2f3e : 85 1c __ STA ACCU + 1 
2f40 : b0 02 __ BCS $2f44 ; (krnio_chkin.s0 + 13)
2f42 : a9 01 __ LDA #$01
2f44 : 85 1b __ STA ACCU + 0 
.s1001:
2f46 : a5 1b __ LDA ACCU + 0 
2f48 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_chrin: ; krnio_chrin()->i16
.s0:
2f49 : 20 cf ff JSR $ffcf 
2f4c : 85 1b __ STA ACCU + 0 
2f4e : a9 00 __ LDA #$00
2f50 : 85 1c __ STA ACCU + 1 
.s1001:
2f52 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_status: ; krnio_status()->enum krnioerr
.s0:
2f53 : 20 b7 ff JSR $ffb7 
2f56 : 85 1b __ STA ACCU + 0 
2f58 : a9 00 __ LDA #$00
2f5a : 85 1c __ STA ACCU + 1 
.s1001:
2f5c : a5 1b __ LDA ACCU + 0 
2f5e : 60 __ __ RTS
--------------------------------------------------------------------
krnio_clrchn: ; krnio_clrchn()->void
.s0:
2f5f : 20 cc ff JSR $ffcc 
.s1001:
2f62 : 60 __ __ RTS
--------------------------------------------------------------------
ui_image_fade: ; ui_image_fade()->void
.s0:
2f63 : a9 08 __ LDA #$08
2f65 : 85 43 __ STA T0 + 0 
2f67 : a9 f2 __ LDA #$f2
2f69 : 85 44 __ STA T0 + 1 
2f6b : ad 64 3d LDA $3d64 ; (video_colorram + 0)
2f6e : 18 __ __ CLC
2f6f : 69 08 __ ADC #$08
2f71 : 85 45 __ STA T1 + 0 
2f73 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
2f76 : 69 02 __ ADC #$02
2f78 : 85 46 __ STA T1 + 1 
2f7a : a9 0c __ LDA #$0c
2f7c : 85 47 __ STA T2 + 0 
.l5:
2f7e : 2c 11 d0 BIT $d011 
2f81 : 10 fb __ BPL $2f7e ; (ui_image_fade.l5 + 0)
.s4:
2f83 : a5 43 __ LDA T0 + 0 
2f85 : 85 0d __ STA P0 
2f87 : a5 44 __ LDA T0 + 1 
2f89 : 85 0e __ STA P1 
2f8b : a9 00 __ LDA #$00
2f8d : 85 0f __ STA P2 
2f8f : 85 10 __ STA P3 
2f91 : 85 12 __ STA P5 
2f93 : a9 28 __ LDA #$28
2f95 : 85 11 __ STA P4 
2f97 : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
2f9a : a5 45 __ LDA T1 + 0 
2f9c : 85 0d __ STA P0 
2f9e : a5 46 __ LDA T1 + 1 
2fa0 : 85 0e __ STA P1 
2fa2 : a9 00 __ LDA #$00
2fa4 : 85 0f __ STA P2 
2fa6 : 85 10 __ STA P3 
2fa8 : 85 12 __ STA P5 
2faa : a9 28 __ LDA #$28
2fac : 85 11 __ STA P4 
2fae : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
2fb1 : 18 __ __ CLC
2fb2 : a5 43 __ LDA T0 + 0 
2fb4 : 69 d8 __ ADC #$d8
2fb6 : 85 43 __ STA T0 + 0 
2fb8 : b0 02 __ BCS $2fbc ; (ui_image_fade.s1003 + 0)
.s1002:
2fba : c6 44 __ DEC T0 + 1 
.s1003:
2fbc : 18 __ __ CLC
2fbd : a5 45 __ LDA T1 + 0 
2fbf : 69 d8 __ ADC #$d8
2fc1 : 85 45 __ STA T1 + 0 
2fc3 : b0 02 __ BCS $2fc7 ; (ui_image_fade.s1005 + 0)
.s1004:
2fc5 : c6 46 __ DEC T1 + 1 
.s1005:
2fc7 : a6 47 __ LDX T2 + 0 
2fc9 : c6 47 __ DEC T2 + 0 
2fcb : 8a __ __ TXA
2fcc : d0 b0 __ BNE $2f7e ; (ui_image_fade.l5 + 0)
.s3:
2fce : 85 0f __ STA P2 
2fd0 : 85 10 __ STA P3 
2fd2 : 85 11 __ STA P4 
2fd4 : a9 0f __ LDA #$0f
2fd6 : 85 12 __ STA P5 
2fd8 : ad c2 3d LDA $3dc2 ; (bitmap_image + 0)
2fdb : 85 0d __ STA P0 
2fdd : ad c3 3d LDA $3dc3 ; (bitmap_image + 1)
2fe0 : 85 0e __ STA P1 
2fe2 : 4c 04 0d JMP $0d04 ; (memset.s0 + 0)
--------------------------------------------------------------------
krnio_close: ; krnio_close(u8)->void
.s1000:
2fe5 : 85 0d __ STA P0 
.s0:
2fe7 : a5 0d __ LDA P0 
2fe9 : 20 c3 ff JSR $ffc3 
.s1001:
2fec : 60 __ __ RTS
--------------------------------------------------------------------
status_update: ; status_update()->void
.s0:
2fed : ad fe 3d LDA $3dfe ; (roomnameid + 0)
2ff0 : 85 46 __ STA T2 + 0 
2ff2 : ad ff 3d LDA $3dff ; (roomnameid + 1)
2ff5 : 85 47 __ STA T2 + 1 
2ff7 : ac 77 3d LDY $3d77 ; (room + 0)
2ffa : b1 46 __ LDA (T2 + 0),y 
2ffc : 8d 3a 3e STA $3e3a ; (strid + 0)
2fff : c9 ff __ CMP #$ff
3001 : d0 03 __ BNE $3006 ; (status_update.s1 + 0)
3003 : 4c 8f 30 JMP $308f ; (status_update.s2 + 0)
.s1:
3006 : ad e2 3d LDA $3de2 ; (advnames + 0)
3009 : 8d 37 3e STA $3e37 ; (str + 0)
300c : ad e3 3d LDA $3de3 ; (advnames + 1)
300f : 8d 38 3e STA $3e38 ; (str + 1)
3012 : 20 58 23 JSR $2358 ; (_getstring.s0 + 0)
3015 : a9 07 __ LDA #$07
3017 : 85 0f __ STA P2 
3019 : a9 00 __ LDA #$00
301b : 85 10 __ STA P3 
301d : 85 12 __ STA P5 
301f : a9 28 __ LDA #$28
3021 : 85 11 __ STA P4 
3023 : ad 40 3e LDA $3e40 ; (ostr + 0)
3026 : 8d 3b 3e STA $3e3b ; (txt + 0)
3029 : ad 41 3e LDA $3e41 ; (ostr + 1)
302c : 8d 3c 3e STA $3e3c ; (txt + 1)
302f : ad 64 3d LDA $3d64 ; (video_colorram + 0)
3032 : 18 __ __ CLC
3033 : 69 08 __ ADC #$08
3035 : 85 0d __ STA P0 
3037 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
303a : 69 02 __ ADC #$02
303c : 85 0e __ STA P1 
303e : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
3041 : a9 a0 __ LDA #$a0
3043 : 85 0f __ STA P2 
3045 : a9 00 __ LDA #$00
3047 : 85 10 __ STA P3 
3049 : 85 12 __ STA P5 
304b : a9 28 __ LDA #$28
304d : 85 11 __ STA P4 
304f : ad 62 3d LDA $3d62 ; (video_ram + 0)
3052 : 18 __ __ CLC
3053 : 69 08 __ ADC #$08
3055 : 85 0d __ STA P0 
3057 : ad 63 3d LDA $3d63 ; (video_ram + 1)
305a : 69 02 __ ADC #$02
305c : 85 0e __ STA P1 
305e : 20 04 0d JSR $0d04 ; (memset.s0 + 0)
3061 : a9 00 __ LDA #$00
3063 : 8d 21 3e STA $3e21 ; (al + 0)
3066 : 8d 48 3e STA $3e48 ; (txt_x + 0)
3069 : a9 07 __ LDA #$07
306b : 8d 45 3e STA $3e45 ; (txt_col + 0)
306e : a9 80 __ LDA #$80
3070 : 8d 47 3e STA $3e47 ; (txt_rev + 0)
3073 : a9 0d __ LDA #$0d
3075 : 8d 49 3e STA $3e49 ; (txt_y + 0)
3078 : 20 b1 24 JSR $24b1 ; (core_drawtext.l138 + 0)
307b : ad 18 3e LDA $3e18 ; (vars + 0)
307e : 85 44 __ STA T1 + 0 
3080 : ad 19 3e LDA $3e19 ; (vars + 1)
3083 : 85 45 __ STA T1 + 1 
3085 : a0 01 __ LDY #$01
3087 : b1 44 __ LDA (T1 + 0),y 
3089 : d0 01 __ BNE $308c ; (status_update.s4 + 0)
.s1001:
308b : 60 __ __ RTS
.s4:
308c : 4c b7 30 JMP $30b7 ; (core_drawscore.s0 + 0)
.s2:
308f : a9 00 __ LDA #$00
3091 : 85 0f __ STA P2 
3093 : 85 10 __ STA P3 
3095 : 85 12 __ STA P5 
3097 : a9 28 __ LDA #$28
3099 : 85 11 __ STA P4 
309b : a9 5e __ LDA #$5e
309d : 8d 3b 3e STA $3e3b ; (txt + 0)
30a0 : a9 31 __ LDA #$31
30a2 : 8d 3c 3e STA $3e3c ; (txt + 1)
30a5 : ad 64 3d LDA $3d64 ; (video_colorram + 0)
30a8 : 18 __ __ CLC
30a9 : 69 08 __ ADC #$08
30ab : 85 0d __ STA P0 
30ad : ad 65 3d LDA $3d65 ; (video_colorram + 1)
30b0 : 69 02 __ ADC #$02
30b2 : 85 0e __ STA P1 
30b4 : 4c 04 0d JMP $0d04 ; (memset.s0 + 0)
--------------------------------------------------------------------
core_drawscore: ; core_drawscore()->void
.s0:
30b7 : ad 18 3e LDA $3e18 ; (vars + 0)
30ba : 85 43 __ STA T0 + 0 
30bc : ad 19 3e LDA $3e19 ; (vars + 1)
30bf : 85 44 __ STA T0 + 1 
30c1 : a0 00 __ LDY #$00
30c3 : 84 45 __ STY T1 + 0 
30c5 : 84 0e __ STY P1 
30c7 : b1 43 __ LDA (T0 + 0),y 
30c9 : 85 0d __ STA P0 
30cb : ad 1c 3e LDA $3e1c ; (tmp + 0)
30ce : 85 43 __ STA T0 + 0 
30d0 : 85 0f __ STA P2 
30d2 : ad 1d 3e LDA $3e1d ; (tmp + 1)
30d5 : 85 44 __ STA T0 + 1 
30d7 : 85 10 __ STA P3 
30d9 : 20 81 2b JSR $2b81 ; (mini_itoa.s0 + 0)
.l1:
30dc : a4 45 __ LDY T1 + 0 
30de : e6 45 __ INC T1 + 0 
30e0 : b1 43 __ LDA (T0 + 0),y 
30e2 : d0 f8 __ BNE $30dc ; (core_drawscore.l1 + 0)
.s3:
30e4 : a9 2f __ LDA #$2f
30e6 : 91 43 __ STA (T0 + 0),y 
30e8 : 18 __ __ CLC
30e9 : a5 43 __ LDA T0 + 0 
30eb : 65 45 __ ADC T1 + 0 
30ed : 85 0f __ STA P2 
30ef : a5 44 __ LDA T0 + 1 
30f1 : 69 00 __ ADC #$00
30f3 : 85 10 __ STA P3 
30f5 : ad 18 3e LDA $3e18 ; (vars + 0)
30f8 : 85 43 __ STA T0 + 0 
30fa : ad 19 3e LDA $3e19 ; (vars + 1)
30fd : 85 44 __ STA T0 + 1 
30ff : a0 01 __ LDY #$01
3101 : b1 43 __ LDA (T0 + 0),y 
3103 : 85 0d __ STA P0 
3105 : a9 00 __ LDA #$00
3107 : 85 0e __ STA P1 
3109 : 20 81 2b JSR $2b81 ; (mini_itoa.s0 + 0)
310c : ad 1c 3e LDA $3e1c ; (tmp + 0)
310f : 85 43 __ STA T0 + 0 
3111 : ad 1d 3e LDA $3e1d ; (tmp + 1)
3114 : 85 44 __ STA T0 + 1 
3116 : a4 45 __ LDY T1 + 0 
3118 : b1 43 __ LDA (T0 + 0),y 
311a : f0 05 __ BEQ $3121 ; (core_drawscore.s6 + 0)
.l5:
311c : c8 __ __ INY
311d : b1 43 __ LDA (T0 + 0),y 
311f : d0 fb __ BNE $311c ; (core_drawscore.l5 + 0)
.s6:
3121 : 84 45 __ STY T1 + 0 
3123 : 38 __ __ SEC
3124 : e5 45 __ SBC T1 + 0 
3126 : 85 43 __ STA T0 + 0 
3128 : a9 00 __ LDA #$00
312a : e9 00 __ SBC #$00
312c : aa __ __ TAX
312d : ad 62 3d LDA $3d62 ; (video_ram + 0)
3130 : 18 __ __ CLC
3131 : 69 30 __ ADC #$30
3133 : a8 __ __ TAY
3134 : ad 63 3d LDA $3d63 ; (video_ram + 1)
3137 : 69 02 __ ADC #$02
3139 : 85 1c __ STA ACCU + 1 
313b : 98 __ __ TYA
313c : 18 __ __ CLC
313d : 65 43 __ ADC T0 + 0 
313f : 85 43 __ STA T0 + 0 
3141 : 8a __ __ TXA
3142 : 65 1c __ ADC ACCU + 1 
3144 : 85 44 __ STA T0 + 1 
3146 : a0 00 __ LDY #$00
3148 : f0 05 __ BEQ $314f ; (core_drawscore.l7 + 0)
.s8:
314a : 09 80 __ ORA #$80
314c : 91 43 __ STA (T0 + 0),y 
314e : c8 __ __ INY
.l7:
314f : ad 1c 3e LDA $3e1c ; (tmp + 0)
3152 : 85 1b __ STA ACCU + 0 
3154 : ad 1d 3e LDA $3e1d ; (tmp + 1)
3157 : 85 1c __ STA ACCU + 1 
3159 : b1 1b __ LDA (ACCU + 0),y 
315b : d0 ed __ BNE $314a ; (core_drawscore.s8 + 0)
.s1001:
315d : 60 __ __ RTS
--------------------------------------------------------------------
315e : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
os_roomimage_load: ; os_roomimage_load()->void
.s0:
315f : ad b6 3d LDA $3db6 ; (slowmode + 0)
3162 : c9 02 __ CMP #$02
3164 : f0 3a __ BEQ $31a0 ; (os_roomimage_load.s1 + 0)
.s3:
3166 : ad 02 3e LDA $3e02 ; (roomimg + 0)
3169 : 85 47 __ STA T4 + 0 
316b : ad 03 3e LDA $3e03 ; (roomimg + 1)
316e : 85 48 __ STA T4 + 1 
3170 : ac 77 3d LDY $3d77 ; (room + 0)
3173 : b1 47 __ LDA (T4 + 0),y 
3175 : 85 50 __ STA T2 + 0 
3177 : cd c5 3d CMP $3dc5 ; (curimageid + 0)
317a : f0 1b __ BEQ $3197 ; (os_roomimage_load.s5 + 0)
.s4:
317c : ad b6 3d LDA $3db6 ; (slowmode + 0)
317f : 85 13 __ STA P6 
3181 : 20 c6 2a JSR $2ac6 ; (irq_detach.l30 + 0)
3184 : a5 50 __ LDA T2 + 0 
3186 : 8d b6 3e STA $3eb6 ; (imageid + 0)
3189 : 20 0e 2c JSR $2c0e ; (ui_room_update.l27 + 0)
318c : 20 79 2b JSR $2b79 ; (irq_attach.l27 + 0)
318f : a5 50 __ LDA T2 + 0 
3191 : 8d c5 3d STA $3dc5 ; (curimageid + 0)
3194 : 4c 9a 31 JMP $319a ; (os_roomimage_load.l35 + 0)
.s5:
3197 : 20 ed 2f JSR $2fed ; (status_update.s0 + 0)
.l35:
319a : 2c 11 d0 BIT $d011 
319d : 10 fb __ BPL $319a ; (os_roomimage_load.l35 + 0)
.s1001:
319f : 60 __ __ RTS
.s1:
31a0 : ad c5 3d LDA $3dc5 ; (curimageid + 0)
31a3 : f0 f2 __ BEQ $3197 ; (os_roomimage_load.s5 + 0)
.s25:
31a5 : a9 00 __ LDA #$00
31a7 : 85 50 __ STA T2 + 0 
31a9 : f0 d1 __ BEQ $317c ; (os_roomimage_load.s4 + 0)
--------------------------------------------------------------------
draw_roomobj: ; draw_roomobj()->void
.s0:
31ab : ad da 3d LDA $3dda ; (tmp2 + 0)
31ae : 8d 3b 3e STA $3e3b ; (txt + 0)
31b1 : ad db 3d LDA $3ddb ; (tmp2 + 1)
31b4 : 8d 3c 3e STA $3e3c ; (txt + 1)
31b7 : a9 00 __ LDA #$00
31b9 : 8d 21 3e STA $3e21 ; (al + 0)
31bc : 85 4f __ STA T1 + 0 
31be : ad df 3d LDA $3ddf ; (obj_count + 0)
31c1 : d0 03 __ BNE $31c6 ; (draw_roomobj.s24 + 0)
31c3 : 4c b7 32 JMP $32b7 ; (draw_roomobj.s4 + 0)
.s24:
31c6 : a9 00 __ LDA #$00
31c8 : 85 50 __ STA T2 + 0 
31ca : ad 0c 3e LDA $3e0c ; (objloc + 0)
31cd : 85 4d __ STA T0 + 0 
31cf : ad 0d 3e LDA $3e0d ; (objloc + 1)
31d2 : 85 4e __ STA T0 + 1 
31d4 : ad 26 3e LDA $3e26 ; (varroom + 0)
31d7 : 85 51 __ STA T3 + 0 
.l2:
31d9 : a5 51 __ LDA T3 + 0 
31db : a4 50 __ LDY T2 + 0 
31dd : d1 4d __ CMP (T0 + 0),y 
31df : f0 03 __ BEQ $31e4 ; (draw_roomobj.s5 + 0)
31e1 : 4c ab 32 JMP $32ab ; (draw_roomobj.s3 + 0)
.s5:
31e4 : ad 0a 3e LDA $3e0a ; (objattr + 0)
31e7 : 85 45 __ STA T5 + 0 
31e9 : ad 0b 3e LDA $3e0b ; (objattr + 1)
31ec : 85 46 __ STA T5 + 1 
31ee : ad 3d 3e LDA $3e3d ; (varattr + 0)
31f1 : 31 45 __ AND (T5 + 0),y 
31f3 : cd 3d 3e CMP $3e3d ; (varattr + 0)
31f6 : f0 03 __ BEQ $31fb ; (draw_roomobj.s8 + 0)
31f8 : 4c ab 32 JMP $32ab ; (draw_roomobj.s3 + 0)
.s8:
31fb : ad 06 3e LDA $3e06 ; (objnameid + 0)
31fe : 85 45 __ STA T5 + 0 
3200 : ad 07 3e LDA $3e07 ; (objnameid + 1)
3203 : 85 46 __ STA T5 + 1 
3205 : b1 45 __ LDA (T5 + 0),y 
3207 : 8d 3a 3e STA $3e3a ; (strid + 0)
320a : c9 ff __ CMP #$ff
320c : d0 03 __ BNE $3211 ; (draw_roomobj.s12 + 0)
320e : 4c ab 32 JMP $32ab ; (draw_roomobj.s3 + 0)
.s12:
3211 : ad e2 3d LDA $3de2 ; (advnames + 0)
3214 : 8d 37 3e STA $3e37 ; (str + 0)
3217 : ad e3 3d LDA $3de3 ; (advnames + 1)
321a : 8d 38 3e STA $3e38 ; (str + 1)
321d : 20 58 23 JSR $2358 ; (_getstring.s0 + 0)
3220 : a9 01 __ LDA #$01
3222 : 8d 45 3e STA $3e45 ; (txt_col + 0)
3225 : ad 40 3e LDA $3e40 ; (ostr + 0)
3228 : 85 43 __ STA T4 + 0 
322a : ad 41 3e LDA $3e41 ; (ostr + 1)
322d : 85 44 __ STA T4 + 1 
322f : ad 43 3e LDA $3e43 ; (etxt + 0)
3232 : 85 45 __ STA T5 + 0 
3234 : ad 44 3e LDA $3e44 ; (etxt + 1)
3237 : 85 46 __ STA T5 + 1 
3239 : a5 4f __ LDA T1 + 0 
323b : f0 17 __ BEQ $3254 ; (draw_roomobj.s17 + 0)
.s14:
323d : ad 3b 3e LDA $3e3b ; (txt + 0)
3240 : 85 49 __ STA T8 + 0 
3242 : ad 3c 3e LDA $3e3c ; (txt + 1)
3245 : 85 4a __ STA T8 + 1 
3247 : a9 2c __ LDA #$2c
3249 : a0 00 __ LDY #$00
324b : 91 49 __ STA (T8 + 0),y 
324d : a9 20 __ LDA #$20
324f : c8 __ __ INY
3250 : 91 49 __ STA (T8 + 0),y 
3252 : a9 02 __ LDA #$02
.s17:
3254 : 85 47 __ STA T6 + 0 
3256 : a5 44 __ LDA T4 + 1 
3258 : c5 46 __ CMP T5 + 1 
325a : d0 04 __ BNE $3260 ; (draw_roomobj.s1007 + 0)
.s1006:
325c : a5 43 __ LDA T4 + 0 
325e : c5 45 __ CMP T5 + 0 
.s1007:
3260 : b0 30 __ BCS $3292 ; (draw_roomobj.s19 + 0)
.s23:
3262 : ad 3b 3e LDA $3e3b ; (txt + 0)
3265 : 85 49 __ STA T8 + 0 
3267 : ad 3c 3e LDA $3e3c ; (txt + 1)
326a : 85 4a __ STA T8 + 1 
.l18:
326c : a0 00 __ LDY #$00
326e : b1 43 __ LDA (T4 + 0),y 
3270 : a4 47 __ LDY T6 + 0 
3272 : 91 49 __ STA (T8 + 0),y 
3274 : e6 47 __ INC T6 + 0 
3276 : e6 43 __ INC T4 + 0 
3278 : d0 02 __ BNE $327c ; (draw_roomobj.s1015 + 0)
.s1014:
327a : e6 44 __ INC T4 + 1 
.s1015:
327c : a5 44 __ LDA T4 + 1 
327e : c5 46 __ CMP T5 + 1 
3280 : d0 04 __ BNE $3286 ; (draw_roomobj.s1005 + 0)
.s1004:
3282 : a5 43 __ LDA T4 + 0 
3284 : c5 45 __ CMP T5 + 0 
.s1005:
3286 : 90 e4 __ BCC $326c ; (draw_roomobj.l18 + 0)
.s26:
3288 : a5 43 __ LDA T4 + 0 
328a : 8d 40 3e STA $3e40 ; (ostr + 0)
328d : a5 44 __ LDA T4 + 1 
328f : 8d 41 3e STA $3e41 ; (ostr + 1)
.s19:
3292 : ad 3b 3e LDA $3e3b ; (txt + 0)
3295 : 18 __ __ CLC
3296 : 65 47 __ ADC T6 + 0 
3298 : 85 43 __ STA T4 + 0 
329a : ad 3c 3e LDA $3e3c ; (txt + 1)
329d : 69 00 __ ADC #$00
329f : 85 44 __ STA T4 + 1 
32a1 : a9 00 __ LDA #$00
32a3 : a8 __ __ TAY
32a4 : 91 43 __ STA (T4 + 0),y 
32a6 : 20 b1 24 JSR $24b1 ; (core_drawtext.l138 + 0)
32a9 : e6 4f __ INC T1 + 0 
.s3:
32ab : e6 50 __ INC T2 + 0 
32ad : a5 50 __ LDA T2 + 0 
32af : cd df 3d CMP $3ddf ; (obj_count + 0)
32b2 : b0 03 __ BCS $32b7 ; (draw_roomobj.s4 + 0)
32b4 : 4c d9 31 JMP $31d9 ; (draw_roomobj.l2 + 0)
.s4:
32b7 : a5 4f __ LDA T1 + 0 
32b9 : f0 2d __ BEQ $32e8 ; (draw_roomobj.s1001 + 0)
.s21:
32bb : a9 01 __ LDA #$01
32bd : 8d 45 3e STA $3e45 ; (txt_col + 0)
32c0 : ad 3b 3e LDA $3e3b ; (txt + 0)
32c3 : 85 4d __ STA T0 + 0 
32c5 : ad 3c 3e LDA $3e3c ; (txt + 1)
32c8 : 85 4e __ STA T0 + 1 
32ca : a9 2e __ LDA #$2e
32cc : a0 00 __ LDY #$00
32ce : 91 4d __ STA (T0 + 0),y 
32d0 : 98 __ __ TYA
32d1 : c8 __ __ INY
32d2 : 91 4d __ STA (T0 + 0),y 
32d4 : 20 b1 24 JSR $24b1 ; (core_drawtext.l138 + 0)
32d7 : a9 00 __ LDA #$00
32d9 : 8d 46 3e STA $3e46 ; (text_attach + 0)
32dc : ad 49 3e LDA $3e49 ; (txt_y + 0)
32df : 38 __ __ SEC
32e0 : e9 0e __ SBC #$0e
32e2 : 8d 76 3d STA $3d76 ; (text_y + 0)
32e5 : 4c f3 29 JMP $29f3 ; (cr.l30 + 0)
.s1001:
32e8 : 60 __ __ RTS
--------------------------------------------------------------------
parser_update: ; parser_update()->void
.s0:
32e9 : a9 00 __ LDA #$00
32eb : 8d 21 3e STA $3e21 ; (al + 0)
32ee : 8d 47 3e STA $3e47 ; (txt_rev + 0)
32f1 : a9 01 __ LDA #$01
32f3 : 8d 48 3e STA $3e48 ; (txt_x + 0)
32f6 : ad 76 3d LDA $3d76 ; (text_y + 0)
32f9 : 18 __ __ CLC
32fa : 69 0e __ ADC #$0e
32fc : 8d 49 3e STA $3e49 ; (txt_y + 0)
32ff : 0a __ __ ASL
3300 : 85 1b __ STA ACCU + 0 
3302 : a9 00 __ LDA #$00
3304 : 2a __ __ ROL
3305 : 06 1b __ ASL ACCU + 0 
3307 : 2a __ __ ROL
3308 : aa __ __ TAX
3309 : a5 1b __ LDA ACCU + 0 
330b : 6d 49 3e ADC $3e49 ; (txt_y + 0)
330e : 85 44 __ STA T1 + 0 
3310 : 8a __ __ TXA
3311 : 69 00 __ ADC #$00
3313 : 06 44 __ ASL T1 + 0 
3315 : 2a __ __ ROL
3316 : 06 44 __ ASL T1 + 0 
3318 : 2a __ __ ROL
3319 : 06 44 __ ASL T1 + 0 
331b : 2a __ __ ROL
331c : 85 45 __ STA T1 + 1 
331e : ad 64 3d LDA $3d64 ; (video_colorram + 0)
3321 : 85 4d __ STA T2 + 0 
3323 : 18 __ __ CLC
3324 : 65 44 __ ADC T1 + 0 
3326 : 85 4f __ STA T3 + 0 
3328 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
332b : 85 4e __ STA T2 + 1 
332d : 65 45 __ ADC T1 + 1 
332f : 85 50 __ STA T3 + 1 
3331 : a9 0c __ LDA #$0c
3333 : 8d 45 3e STA $3e45 ; (txt_col + 0)
3336 : a0 00 __ LDY #$00
3338 : 91 4f __ STA (T3 + 0),y 
333a : ad 62 3d LDA $3d62 ; (video_ram + 0)
333d : 85 4f __ STA T3 + 0 
333f : 18 __ __ CLC
3340 : 65 44 __ ADC T1 + 0 
3342 : 85 44 __ STA T1 + 0 
3344 : ad 63 3d LDA $3d63 ; (video_ram + 1)
3347 : 85 50 __ STA T3 + 1 
3349 : 65 45 __ ADC T1 + 1 
334b : 85 45 __ STA T1 + 1 
334d : a9 3e __ LDA #$3e
334f : 91 44 __ STA (T1 + 0),y 
3351 : ad 74 3d LDA $3d74 ; (strcmd + 0)
3354 : 8d 3b 3e STA $3e3b ; (txt + 0)
3357 : ad 75 3d LDA $3d75 ; (strcmd + 1)
335a : 8d 3c 3e STA $3e3c ; (txt + 1)
335d : 20 b1 24 JSR $24b1 ; (core_drawtext.l138 + 0)
3360 : ad 49 3e LDA $3e49 ; (txt_y + 0)
3363 : 0a __ __ ASL
3364 : 85 1b __ STA ACCU + 0 
3366 : a9 00 __ LDA #$00
3368 : 8d 21 3e STA $3e21 ; (al + 0)
336b : 2a __ __ ROL
336c : 06 1b __ ASL ACCU + 0 
336e : 2a __ __ ROL
336f : aa __ __ TAX
3370 : a5 1b __ LDA ACCU + 0 
3372 : 6d 49 3e ADC $3e49 ; (txt_y + 0)
3375 : 85 44 __ STA T1 + 0 
3377 : 8a __ __ TXA
3378 : 69 00 __ ADC #$00
337a : 06 44 __ ASL T1 + 0 
337c : 2a __ __ ROL
337d : 06 44 __ ASL T1 + 0 
337f : 2a __ __ ROL
3380 : 06 44 __ ASL T1 + 0 
3382 : 2a __ __ ROL
3383 : aa __ __ TAX
3384 : ad 48 3e LDA $3e48 ; (txt_x + 0)
3387 : 18 __ __ CLC
3388 : 65 44 __ ADC T1 + 0 
338a : 85 44 __ STA T1 + 0 
338c : 90 01 __ BCC $338f ; (parser_update.s1003 + 0)
.s1002:
338e : e8 __ __ INX
.s1003:
338f : 8a __ __ TXA
3390 : 18 __ __ CLC
3391 : 65 4e __ ADC T2 + 1 
3393 : 85 4e __ STA T2 + 1 
3395 : a9 00 __ LDA #$00
3397 : a4 44 __ LDY T1 + 0 
3399 : 91 4d __ STA (T2 + 0),y 
339b : 8a __ __ TXA
339c : 18 __ __ CLC
339d : 65 50 __ ADC T3 + 1 
339f : 85 45 __ STA T1 + 1 
33a1 : a9 20 __ LDA #$20
33a3 : a4 4f __ LDY T3 + 0 
33a5 : 91 44 __ STA (T1 + 0),y 
.l27:
33a7 : 2c 11 d0 BIT $d011 
33aa : 10 fb __ BPL $33a7 ; (parser_update.l27 + 0)
.s1001:
33ac : 60 __ __ RTS
--------------------------------------------------------------------
hide_blink: ; hide_blink()->void
.s0:
33ad : ad 49 3e LDA $3e49 ; (txt_y + 0)
33b0 : 0a __ __ ASL
33b1 : 85 1b __ STA ACCU + 0 
33b3 : a9 00 __ LDA #$00
33b5 : 2a __ __ ROL
33b6 : 06 1b __ ASL ACCU + 0 
33b8 : 2a __ __ ROL
33b9 : aa __ __ TAX
33ba : a5 1b __ LDA ACCU + 0 
33bc : 6d 49 3e ADC $3e49 ; (txt_y + 0)
33bf : 85 1b __ STA ACCU + 0 
33c1 : 8a __ __ TXA
33c2 : 69 00 __ ADC #$00
33c4 : 06 1b __ ASL ACCU + 0 
33c6 : 2a __ __ ROL
33c7 : 06 1b __ ASL ACCU + 0 
33c9 : 2a __ __ ROL
33ca : 06 1b __ ASL ACCU + 0 
33cc : 2a __ __ ROL
33cd : aa __ __ TAX
33ce : ad 48 3e LDA $3e48 ; (txt_x + 0)
33d1 : 18 __ __ CLC
33d2 : 65 1b __ ADC ACCU + 0 
33d4 : 90 01 __ BCC $33d7 ; (hide_blink.s1003 + 0)
.s1002:
33d6 : e8 __ __ INX
.s1003:
33d7 : 18 __ __ CLC
33d8 : 6d 64 3d ADC $3d64 ; (video_colorram + 0)
33db : 85 1b __ STA ACCU + 0 
33dd : 8a __ __ TXA
33de : 6d 65 3d ADC $3d65 ; (video_colorram + 1)
33e1 : 85 1c __ STA ACCU + 1 
33e3 : a9 00 __ LDA #$00
33e5 : a8 __ __ TAY
33e6 : 91 1b __ STA (ACCU + 0),y 
.s1001:
33e8 : 60 __ __ RTS
--------------------------------------------------------------------
execute: ; execute()->void
.s1000:
33e9 : a5 53 __ LDA T0 + 0 
33eb : 8d d3 cb STA $cbd3 ; (execute@stack + 0)
33ee : a5 54 __ LDA T0 + 1 
33f0 : 8d d4 cb STA $cbd4 ; (execute@stack + 1)
.s0:
33f3 : 20 f3 29 JSR $29f3 ; (cr.l30 + 0)
33f6 : ad 74 3d LDA $3d74 ; (strcmd + 0)
33f9 : 85 53 __ STA T0 + 0 
33fb : 8d 37 3e STA $3e37 ; (str + 0)
33fe : ad 75 3d LDA $3d75 ; (strcmd + 1)
3401 : 85 54 __ STA T0 + 1 
3403 : 8d 38 3e STA $3e38 ; (str + 1)
3406 : 20 1f 34 JSR $341f ; (adv_parse.s1000 + 0)
3409 : a9 00 __ LDA #$00
340b : 8d d6 3d STA $3dd6 ; (icmd + 0)
340e : a8 __ __ TAY
340f : 91 53 __ STA (T0 + 0),y 
3411 : 20 e9 32 JSR $32e9 ; (parser_update.s0 + 0)
.s1001:
3414 : ad d3 cb LDA $cbd3 ; (execute@stack + 0)
3417 : 85 53 __ STA T0 + 0 
3419 : ad d4 cb LDA $cbd4 ; (execute@stack + 1)
341c : 85 54 __ STA T0 + 1 
341e : 60 __ __ RTS
--------------------------------------------------------------------
adv_parse: ; adv_parse()->void
.s1000:
341f : a5 53 __ LDA T1 + 0 
3421 : 8d d5 cb STA $cbd5 ; (adv_parse@stack + 0)
3424 : a5 54 __ LDA T3 + 0 
3426 : 8d d6 cb STA $cbd6 ; (adv_parse@stack + 1)
.s0:
3429 : a9 ff __ LDA #$ff
342b : 8d 23 3e STA $3e23 ; (cmd + 0)
342e : a9 f9 __ LDA #$f9
3430 : 8d 35 3e STA $3e35 ; (obj2 + 0)
3433 : 8d 24 3e STA $3e24 ; (obj1 + 0)
3436 : a9 00 __ LDA #$00
3438 : 8d c8 3e STA $3ec8 ; (obj2k + 0)
343b : 8d c7 3e STA $3ec7 ; (obj1k + 0)
343e : ad 37 3e LDA $3e37 ; (str + 0)
3441 : 85 1b __ STA ACCU + 0 
3443 : 8d 40 3e STA $3e40 ; (ostr + 0)
3446 : ad 38 3e LDA $3e38 ; (str + 1)
3449 : 85 1c __ STA ACCU + 1 
344b : 8d 41 3e STA $3e41 ; (ostr + 1)
344e : a0 00 __ LDY #$00
3450 : b1 1b __ LDA (ACCU + 0),y 
3452 : f0 26 __ BEQ $347a ; (adv_parse.s3 + 0)
.l4:
3454 : ad 40 3e LDA $3e40 ; (ostr + 0)
3457 : 85 1b __ STA ACCU + 0 
3459 : ad 41 3e LDA $3e41 ; (ostr + 1)
345c : 85 1c __ STA ACCU + 1 
345e : a0 00 __ LDY #$00
3460 : b1 1b __ LDA (ACCU + 0),y 
3462 : c9 20 __ CMP #$20
3464 : d0 14 __ BNE $347a ; (adv_parse.s3 + 0)
.s2:
3466 : 18 __ __ CLC
3467 : a5 1b __ LDA ACCU + 0 
3469 : 69 01 __ ADC #$01
346b : 8d 40 3e STA $3e40 ; (ostr + 0)
346e : a5 1c __ LDA ACCU + 1 
3470 : 69 00 __ ADC #$00
3472 : 8d 41 3e STA $3e41 ; (ostr + 1)
3475 : c8 __ __ INY
3476 : b1 1b __ LDA (ACCU + 0),y 
3478 : d0 da __ BNE $3454 ; (adv_parse.l4 + 0)
.s3:
347a : ad 40 3e LDA $3e40 ; (ostr + 0)
347d : 85 1b __ STA ACCU + 0 
347f : ad 41 3e LDA $3e41 ; (ostr + 1)
3482 : 85 1c __ STA ACCU + 1 
3484 : a0 00 __ LDY #$00
3486 : b1 1b __ LDA (ACCU + 0),y 
3488 : f0 35 __ BEQ $34bf ; (adv_parse.s1001 + 0)
.l8:
348a : ad 40 3e LDA $3e40 ; (ostr + 0)
348d : 85 1b __ STA ACCU + 0 
348f : ad 41 3e LDA $3e41 ; (ostr + 1)
3492 : 85 1c __ STA ACCU + 1 
3494 : a0 00 __ LDY #$00
3496 : b1 1b __ LDA (ACCU + 0),y 
3498 : d0 30 __ BNE $34ca ; (adv_parse.s9 + 0)
.s10:
349a : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
349d : ad c4 3d LDA $3dc4 ; (nextroom + 0)
34a0 : c9 fa __ CMP #$fa
34a2 : f0 0e __ BEQ $34b2 ; (adv_parse.s49 + 0)
.s48:
34a4 : 8d 22 3e STA $3e22 ; (newroom + 0)
34a7 : a9 fa __ LDA #$fa
34a9 : 8d c4 3d STA $3dc4 ; (nextroom + 0)
34ac : 20 09 13 JSR $1309 ; (room_load.s1000 + 0)
34af : 4c bf 34 JMP $34bf ; (adv_parse.s1001 + 0)
.s49:
34b2 : a9 03 __ LDA #$03
34b4 : 8d 23 3e STA $3e23 ; (cmd + 0)
34b7 : a9 ff __ LDA #$ff
34b9 : 8d 24 3e STA $3e24 ; (obj1 + 0)
34bc : 20 7a 13 JSR $137a ; (adv_run.s1000 + 0)
.s1001:
34bf : ad d5 cb LDA $cbd5 ; (adv_parse@stack + 0)
34c2 : 85 53 __ STA T1 + 0 
34c4 : ad d6 cb LDA $cbd6 ; (adv_parse@stack + 1)
34c7 : 85 54 __ STA T3 + 0 
34c9 : 60 __ __ RTS
.s9:
34ca : 8c c9 3e STY $3ec9 ; (strdir + 0)
34cd : 8c ca 3e STY $3eca ; (strdir + 1)
34d0 : ad 23 3e LDA $3e23 ; (cmd + 0)
34d3 : 85 53 __ STA T1 + 0 
34d5 : c9 ff __ CMP #$ff
34d7 : f0 1d __ BEQ $34f6 ; (adv_parse.s1004 + 0)
.s1005:
34d9 : 84 54 __ STY T3 + 0 
34db : ad ec 3d LDA $3dec ; (objs + 0)
34de : 8d 37 3e STA $3e37 ; (str + 0)
34e1 : ad ed 3d LDA $3ded ; (objs + 1)
34e4 : 8d 38 3e STA $3e38 ; (str + 1)
34e7 : ad ee 3d LDA $3dee ; (objs_dir + 0)
34ea : 8d c9 3e STA $3ec9 ; (strdir + 0)
34ed : ad ef 3d LDA $3def ; (objs_dir + 1)
34f0 : 8d ca 3e STA $3eca ; (strdir + 1)
34f3 : 4c 06 35 JMP $3506 ; (adv_parse.s113 + 0)
.s1004:
34f6 : a9 01 __ LDA #$01
34f8 : 85 54 __ STA T3 + 0 
34fa : ad ea 3d LDA $3dea ; (verbs + 0)
34fd : 8d 37 3e STA $3e37 ; (str + 0)
3500 : ad eb 3d LDA $3deb ; (verbs + 1)
3503 : 8d 38 3e STA $3e38 ; (str + 1)
.s113:
3506 : 20 eb 35 JSR $35eb ; (_findstring.s0 + 0)
3509 : ad cb 3e LDA $3ecb ; (cmdid + 0)
350c : c9 ff __ CMP #$ff
350e : d0 03 __ BNE $3513 ; (adv_parse.s14 + 0)
3510 : 4c 9f 35 JMP $359f ; (adv_parse.s15 + 0)
.s14:
3513 : a5 54 __ LDA T3 + 0 
3515 : f0 24 __ BEQ $353b ; (adv_parse.s18 + 0)
.s17:
3517 : ad cb 3e LDA $3ecb ; (cmdid + 0)
351a : 8d 23 3e STA $3e23 ; (cmd + 0)
351d : a9 09 __ LDA #$09
351f : 85 11 __ STA P4 
3521 : ad 1e 3e LDA $3e1e ; (vrb + 0)
3524 : 85 0d __ STA P0 
3526 : ad 1f 3e LDA $3e1f ; (vrb + 1)
3529 : 85 0e __ STA P1 
352b : ad 1c 3e LDA $3e1c ; (tmp + 0)
352e : 85 0f __ STA P2 
3530 : ad 1d 3e LDA $3e1d ; (tmp + 1)
3533 : 85 10 __ STA P3 
3535 : 20 de 38 JSR $38de ; (strncpy.s0 + 0)
3538 : 4c 54 35 JMP $3554 ; (adv_parse.s132 + 0)
.s18:
353b : ad c7 3e LDA $3ec7 ; (obj1k + 0)
353e : d0 04 __ BNE $3544 ; (adv_parse.s21 + 0)
.s20:
3540 : a9 01 __ LDA #$01
3542 : d0 4f __ BNE $3593 ; (adv_parse.s1023 + 0)
.s21:
3544 : ad c8 3e LDA $3ec8 ; (obj2k + 0)
3547 : d0 0b __ BNE $3554 ; (adv_parse.s132 + 0)
.s23:
3549 : a9 01 __ LDA #$01
.s1024:
354b : 8d c8 3e STA $3ec8 ; (obj2k + 0)
354e : ad cb 3e LDA $3ecb ; (cmdid + 0)
3551 : 8d 35 3e STA $3e35 ; (obj2 + 0)
.s132:
3554 : ad 40 3e LDA $3e40 ; (ostr + 0)
3557 : 85 1b __ STA ACCU + 0 
3559 : ad 41 3e LDA $3e41 ; (ostr + 1)
355c : 85 1c __ STA ACCU + 1 
355e : a0 00 __ LDY #$00
3560 : b1 1b __ LDA (ACCU + 0),y 
3562 : d0 03 __ BNE $3567 ; (adv_parse.l47 + 0)
3564 : 4c 8a 34 JMP $348a ; (adv_parse.l8 + 0)
.l47:
3567 : ad 40 3e LDA $3e40 ; (ostr + 0)
356a : 85 1b __ STA ACCU + 0 
356c : ad 41 3e LDA $3e41 ; (ostr + 1)
356f : 85 1c __ STA ACCU + 1 
3571 : a0 00 __ LDY #$00
3573 : b1 1b __ LDA (ACCU + 0),y 
3575 : c9 20 __ CMP #$20
3577 : f0 03 __ BEQ $357c ; (adv_parse.s45 + 0)
3579 : 4c 8a 34 JMP $348a ; (adv_parse.l8 + 0)
.s45:
357c : 18 __ __ CLC
357d : a5 1b __ LDA ACCU + 0 
357f : 69 01 __ ADC #$01
3581 : 8d 40 3e STA $3e40 ; (ostr + 0)
3584 : a5 1c __ LDA ACCU + 1 
3586 : 69 00 __ ADC #$00
3588 : 8d 41 3e STA $3e41 ; (ostr + 1)
358b : c8 __ __ INY
358c : b1 1b __ LDA (ACCU + 0),y 
358e : d0 d7 __ BNE $3567 ; (adv_parse.l47 + 0)
3590 : 4c 8a 34 JMP $348a ; (adv_parse.l8 + 0)
.s1023:
3593 : 8d c7 3e STA $3ec7 ; (obj1k + 0)
3596 : ad cb 3e LDA $3ecb ; (cmdid + 0)
.s1025:
3599 : 8d 24 3e STA $3e24 ; (obj1 + 0)
359c : 4c 54 35 JMP $3554 ; (adv_parse.s132 + 0)
.s15:
359f : a5 53 __ LDA T1 + 0 
35a1 : c9 ff __ CMP #$ff
35a3 : f0 af __ BEQ $3554 ; (adv_parse.s132 + 0)
.s26:
35a5 : a9 00 __ LDA #$00
35a7 : 8d c9 3e STA $3ec9 ; (strdir + 0)
35aa : 8d ca 3e STA $3eca ; (strdir + 1)
35ad : ad f0 3d LDA $3df0 ; (rooms + 0)
35b0 : 8d 37 3e STA $3e37 ; (str + 0)
35b3 : ad f1 3d LDA $3df1 ; (rooms + 1)
35b6 : 8d 38 3e STA $3e38 ; (str + 1)
35b9 : 20 eb 35 JSR $35eb ; (_findstring.s0 + 0)
35bc : ad c7 3e LDA $3ec7 ; (obj1k + 0)
35bf : f0 11 __ BEQ $35d2 ; (adv_parse.s29 + 0)
.s30:
35c1 : ad c8 3e LDA $3ec8 ; (obj2k + 0)
35c4 : d0 8e __ BNE $3554 ; (adv_parse.s132 + 0)
.s38:
35c6 : ad cb 3e LDA $3ecb ; (cmdid + 0)
35c9 : c9 ff __ CMP #$ff
35cb : f0 87 __ BEQ $3554 ; (adv_parse.s132 + 0)
.s41:
35cd : a9 02 __ LDA #$02
35cf : 4c 4b 35 JMP $354b ; (adv_parse.s1024 + 0)
.s29:
35d2 : ad cb 3e LDA $3ecb ; (cmdid + 0)
35d5 : c9 ff __ CMP #$ff
35d7 : d0 0e __ BNE $35e7 ; (adv_parse.s32 + 0)
.s33:
35d9 : ad 24 3e LDA $3e24 ; (obj1 + 0)
35dc : c9 f9 __ CMP #$f9
35de : f0 03 __ BEQ $35e3 ; (adv_parse.s35 + 0)
35e0 : 4c 54 35 JMP $3554 ; (adv_parse.s132 + 0)
.s35:
35e3 : a9 ff __ LDA #$ff
35e5 : d0 b2 __ BNE $3599 ; (adv_parse.s1025 + 0)
.s32:
35e7 : a9 02 __ LDA #$02
35e9 : d0 a8 __ BNE $3593 ; (adv_parse.s1023 + 0)
--------------------------------------------------------------------
_findstring: ; _findstring()->void
.s0:
35eb : a9 00 __ LDA #$00
35ed : 8d cb 3e STA $3ecb ; (cmdid + 0)
35f0 : 8d 30 3e STA $3e30 ; (i + 0)
35f3 : 8d 31 3e STA $3e31 ; (i + 1)
35f6 : ad ca 3e LDA $3eca ; (strdir + 1)
35f9 : 85 44 __ STA T0 + 1 
35fb : ad c9 3e LDA $3ec9 ; (strdir + 0)
35fe : 85 43 __ STA T0 + 0 
3600 : 05 44 __ ORA T0 + 1 
3602 : f0 30 __ BEQ $3634 ; (_findstring.s10 + 0)
.s1:
3604 : ad 40 3e LDA $3e40 ; (ostr + 0)
3607 : 85 45 __ STA T1 + 0 
3609 : ad 41 3e LDA $3e41 ; (ostr + 1)
360c : 85 46 __ STA T1 + 1 
360e : a0 00 __ LDY #$00
3610 : b1 45 __ LDA (T1 + 0),y 
3612 : c9 1a __ CMP #$1a
3614 : 90 03 __ BCC $3619 ; (_findstring.s4 + 0)
3616 : 4c de 36 JMP $36de ; (_findstring.s9 + 0)
.s4:
3619 : 0a __ __ ASL
361a : a8 __ __ TAY
361b : b1 43 __ LDA (T0 + 0),y 
361d : 8d 30 3e STA $3e30 ; (i + 0)
3620 : c8 __ __ INY
3621 : b1 43 __ LDA (T0 + 0),y 
3623 : 8d 31 3e STA $3e31 ; (i + 1)
3626 : c9 ff __ CMP #$ff
3628 : d0 0a __ BNE $3634 ; (_findstring.s10 + 0)
.s1015:
362a : ad 30 3e LDA $3e30 ; (i + 0)
362d : c9 ff __ CMP #$ff
362f : d0 03 __ BNE $3634 ; (_findstring.s10 + 0)
3631 : 4c de 36 JMP $36de ; (_findstring.s9 + 0)
.s10:
3634 : ad 37 3e LDA $3e37 ; (str + 0)
3637 : 18 __ __ CLC
3638 : 6d 30 3e ADC $3e30 ; (i + 0)
363b : 85 43 __ STA T0 + 0 
363d : ad 38 3e LDA $3e38 ; (str + 1)
3640 : 6d 31 3e ADC $3e31 ; (i + 1)
3643 : 85 44 __ STA T0 + 1 
3645 : a0 00 __ LDY #$00
3647 : b1 43 __ LDA (T0 + 0),y 
3649 : d0 03 __ BNE $364e ; (_findstring.l11 + 0)
364b : 4c de 36 JMP $36de ; (_findstring.s9 + 0)
.l11:
364e : ad 30 3e LDA $3e30 ; (i + 0)
3651 : 85 43 __ STA T0 + 0 
3653 : 18 __ __ CLC
3654 : 69 01 __ ADC #$01
3656 : 85 45 __ STA T1 + 0 
3658 : 8d 30 3e STA $3e30 ; (i + 0)
365b : ad 31 3e LDA $3e31 ; (i + 1)
365e : 85 44 __ STA T0 + 1 
3660 : 69 00 __ ADC #$00
3662 : 85 46 __ STA T1 + 1 
3664 : 8d 31 3e STA $3e31 ; (i + 1)
3667 : ad 37 3e LDA $3e37 ; (str + 0)
366a : 85 48 __ STA T4 + 0 
366c : 18 __ __ CLC
366d : 65 43 __ ADC T0 + 0 
366f : 85 43 __ STA T0 + 0 
3671 : ad 38 3e LDA $3e38 ; (str + 1)
3674 : 85 49 __ STA T4 + 1 
3676 : 65 44 __ ADC T0 + 1 
3678 : 85 44 __ STA T0 + 1 
367a : a0 00 __ LDY #$00
367c : b1 43 __ LDA (T0 + 0),y 
367e : 85 47 __ STA T2 + 0 
3680 : 8d 42 3e STA $3e42 ; (len + 0)
3683 : ad 40 3e LDA $3e40 ; (ostr + 0)
3686 : 85 4a __ STA T5 + 0 
3688 : ad 41 3e LDA $3e41 ; (ostr + 1)
368b : 85 4b __ STA T5 + 1 
368d : c8 __ __ INY
368e : b1 43 __ LDA (T0 + 0),y 
3690 : 88 __ __ DEY
3691 : d1 4a __ CMP (T5 + 0),y 
3693 : d0 03 __ BNE $3698 ; (_findstring.s14 + 0)
3695 : 4c 80 37 JMP $3780 ; (_findstring.s13 + 0)
.s14:
3698 : ad c9 3e LDA $3ec9 ; (strdir + 0)
369b : 0d ca 3e ORA $3eca ; (strdir + 1)
369e : d0 3e __ BNE $36de ; (_findstring.s9 + 0)
.s15:
36a0 : 18 __ __ CLC
36a1 : a5 47 __ LDA T2 + 0 
36a3 : 65 45 __ ADC T1 + 0 
36a5 : 85 43 __ STA T0 + 0 
36a7 : a9 00 __ LDA #$00
36a9 : 65 46 __ ADC T1 + 1 
36ab : aa __ __ TAX
36ac : 18 __ __ CLC
36ad : a5 43 __ LDA T0 + 0 
36af : 69 01 __ ADC #$01
36b1 : 85 45 __ STA T1 + 0 
36b3 : 8a __ __ TXA
36b4 : 69 00 __ ADC #$00
36b6 : 85 46 __ STA T1 + 1 
36b8 : 8a __ __ TXA
36b9 : 18 __ __ CLC
36ba : 65 49 __ ADC T4 + 1 
36bc : 85 44 __ STA T0 + 1 
36be : a4 48 __ LDY T4 + 0 
36c0 : b1 43 __ LDA (T0 + 0),y 
36c2 : aa __ __ TAX
36c3 : c8 __ __ INY
36c4 : b1 43 __ LDA (T0 + 0),y 
36c6 : e0 ff __ CPX #$ff
36c8 : d0 03 __ BNE $36cd ; (_findstring.s39 + 0)
36ca : 4c 4e 37 JMP $374e ; (_findstring.s38 + 0)
.s39:
36cd : aa __ __ TAX
36ce : a5 45 __ LDA T1 + 0 
36d0 : 8d 30 3e STA $3e30 ; (i + 0)
36d3 : a5 46 __ LDA T1 + 1 
36d5 : 8d 31 3e STA $3e31 ; (i + 1)
36d8 : 8a __ __ TXA
36d9 : f0 03 __ BEQ $36de ; (_findstring.s9 + 0)
36db : 4c 4e 36 JMP $364e ; (_findstring.l11 + 0)
.s9:
36de : a9 ff __ LDA #$ff
36e0 : 8d cb 3e STA $3ecb ; (cmdid + 0)
36e3 : a9 00 __ LDA #$00
36e5 : 8d 30 3e STA $3e30 ; (i + 0)
36e8 : 8d 31 3e STA $3e31 ; (i + 1)
36eb : ad 40 3e LDA $3e40 ; (ostr + 0)
36ee : 85 43 __ STA T0 + 0 
36f0 : ad 41 3e LDA $3e41 ; (ostr + 1)
36f3 : 85 44 __ STA T0 + 1 
36f5 : a0 00 __ LDY #$00
36f7 : b1 43 __ LDA (T0 + 0),y 
36f9 : f0 52 __ BEQ $374d ; (_findstring.s1001 + 0)
.l44:
36fb : ad 40 3e LDA $3e40 ; (ostr + 0)
36fe : 85 43 __ STA T0 + 0 
3700 : ad 41 3e LDA $3e41 ; (ostr + 1)
3703 : 85 44 __ STA T0 + 1 
3705 : a0 00 __ LDY #$00
3707 : b1 43 __ LDA (T0 + 0),y 
3709 : c9 20 __ CMP #$20
370b : f0 40 __ BEQ $374d ; (_findstring.s1001 + 0)
.s42:
370d : aa __ __ TAX
370e : 18 __ __ CLC
370f : a5 43 __ LDA T0 + 0 
3711 : 69 01 __ ADC #$01
3713 : 8d 40 3e STA $3e40 ; (ostr + 0)
3716 : a5 44 __ LDA T0 + 1 
3718 : 69 00 __ ADC #$00
371a : 8d 41 3e STA $3e41 ; (ostr + 1)
371d : ad 30 3e LDA $3e30 ; (i + 0)
3720 : 85 45 __ STA T1 + 0 
3722 : ad 31 3e LDA $3e31 ; (i + 1)
3725 : d0 20 __ BNE $3747 ; (_findstring.s114 + 0)
.s1002:
3727 : a5 45 __ LDA T1 + 0 
3729 : c9 20 __ CMP #$20
372b : b0 1a __ BCS $3747 ; (_findstring.s114 + 0)
.s45:
372d : 8c 31 3e STY $3e31 ; (i + 1)
3730 : 69 01 __ ADC #$01
3732 : 8d 30 3e STA $3e30 ; (i + 0)
3735 : ad 1c 3e LDA $3e1c ; (tmp + 0)
3738 : 18 __ __ CLC
3739 : 65 45 __ ADC T1 + 0 
373b : 85 45 __ STA T1 + 0 
373d : ad 1d 3e LDA $3e1d ; (tmp + 1)
3740 : 69 00 __ ADC #$00
3742 : 85 46 __ STA T1 + 1 
3744 : 8a __ __ TXA
3745 : 91 45 __ STA (T1 + 0),y 
.s114:
3747 : a0 01 __ LDY #$01
3749 : b1 43 __ LDA (T0 + 0),y 
374b : d0 ae __ BNE $36fb ; (_findstring.l44 + 0)
.s1001:
374d : 60 __ __ RTS
.s38:
374e : 0a __ __ ASL
374f : a0 00 __ LDY #$00
3751 : 90 01 __ BCC $3754 ; (_findstring.s1025 + 0)
.s1024:
3753 : c8 __ __ INY
.s1025:
3754 : 18 __ __ CLC
3755 : 65 45 __ ADC T1 + 0 
3757 : aa __ __ TAX
3758 : 98 __ __ TYA
3759 : 65 46 __ ADC T1 + 1 
375b : a8 __ __ TAY
375c : 8a __ __ TXA
375d : 18 __ __ CLC
375e : 69 01 __ ADC #$01
3760 : 8d 30 3e STA $3e30 ; (i + 0)
3763 : 98 __ __ TYA
3764 : 69 00 __ ADC #$00
3766 : 8d 31 3e STA $3e31 ; (i + 1)
3769 : 8a __ __ TXA
376a : 18 __ __ CLC
376b : 65 48 __ ADC T4 + 0 
376d : 85 43 __ STA T0 + 0 
376f : 98 __ __ TYA
3770 : 65 49 __ ADC T4 + 1 
3772 : 85 44 __ STA T0 + 1 
3774 : a0 01 __ LDY #$01
3776 : b1 43 __ LDA (T0 + 0),y 
3778 : d0 03 __ BNE $377d ; (_findstring.s1025 + 41)
377a : 4c de 36 JMP $36de ; (_findstring.s9 + 0)
377d : 4c 4e 36 JMP $364e ; (_findstring.l11 + 0)
.s13:
3780 : 18 __ __ CLC
3781 : a5 43 __ LDA T0 + 0 
3783 : 69 01 __ ADC #$01
3785 : 85 0f __ STA P2 
3787 : a5 44 __ LDA T0 + 1 
3789 : 69 00 __ ADC #$00
378b : 85 10 __ STA P3 
378d : 18 __ __ CLC
378e : a5 47 __ LDA T2 + 0 
3790 : 65 4a __ ADC T5 + 0 
3792 : 85 4c __ STA T8 + 0 
3794 : a5 4b __ LDA T5 + 1 
3796 : 69 00 __ ADC #$00
3798 : 85 4d __ STA T8 + 1 
379a : a4 47 __ LDY T2 + 0 
379c : b1 4a __ LDA (T5 + 0),y 
379e : f0 07 __ BEQ $37a7 ; (_findstring.s16 + 0)
.s19:
37a0 : c9 20 __ CMP #$20
37a2 : f0 03 __ BEQ $37a7 ; (_findstring.s16 + 0)
37a4 : 4c a0 36 JMP $36a0 ; (_findstring.s15 + 0)
.s16:
37a7 : 84 11 __ STY P4 
37a9 : a5 4a __ LDA T5 + 0 
37ab : 85 0d __ STA P0 
37ad : a5 4b __ LDA T5 + 1 
37af : 85 0e __ STA P1 
37b1 : a9 00 __ LDA #$00
37b3 : 85 12 __ STA P5 
37b5 : 20 8a 38 JSR $388a ; (memcmp.s0 + 0)
37b8 : a5 1b __ LDA ACCU + 0 
37ba : 05 1c __ ORA ACCU + 1 
37bc : f0 03 __ BEQ $37c1 ; (_findstring.s20 + 0)
37be : 4c a0 36 JMP $36a0 ; (_findstring.s15 + 0)
.s20:
37c1 : a5 47 __ LDA T2 + 0 
37c3 : 85 11 __ STA P4 
37c5 : a9 00 __ LDA #$00
37c7 : 85 12 __ STA P5 
37c9 : 18 __ __ CLC
37ca : a5 48 __ LDA T4 + 0 
37cc : 65 45 __ ADC T1 + 0 
37ce : 85 0f __ STA P2 
37d0 : a5 49 __ LDA T4 + 1 
37d2 : 65 46 __ ADC T1 + 1 
37d4 : 85 10 __ STA P3 
37d6 : ad 1c 3e LDA $3e1c ; (tmp + 0)
37d9 : 85 43 __ STA T0 + 0 
37db : 85 0d __ STA P0 
37dd : ad 1d 3e LDA $3e1d ; (tmp + 1)
37e0 : 85 44 __ STA T0 + 1 
37e2 : 85 0e __ STA P1 
37e4 : 20 d5 0c JSR $0cd5 ; (memcpy.s0 + 0)
37e7 : a5 4c __ LDA T8 + 0 
37e9 : 8d 40 3e STA $3e40 ; (ostr + 0)
37ec : a5 4d __ LDA T8 + 1 
37ee : 8d 41 3e STA $3e41 ; (ostr + 1)
37f1 : 18 __ __ CLC
37f2 : a5 45 __ LDA T1 + 0 
37f4 : 65 47 __ ADC T2 + 0 
37f6 : 8d 30 3e STA $3e30 ; (i + 0)
37f9 : aa __ __ TAX
37fa : a5 46 __ LDA T1 + 1 
37fc : 69 00 __ ADC #$00
37fe : 85 46 __ STA T1 + 1 
3800 : 8d 31 3e STA $3e31 ; (i + 1)
3803 : a9 00 __ LDA #$00
3805 : a4 47 __ LDY T2 + 0 
3807 : 91 43 __ STA (T0 + 0),y 
3809 : 86 43 __ STX T0 + 0 
380b : 18 __ __ CLC
380c : a5 49 __ LDA T4 + 1 
380e : 65 46 __ ADC T1 + 1 
3810 : 85 44 __ STA T0 + 1 
3812 : a4 48 __ LDY T4 + 0 
3814 : b1 43 __ LDA (T0 + 0),y 
3816 : 8d cb 3e STA $3ecb ; (cmdid + 0)
3819 : c9 ff __ CMP #$ff
381b : f0 01 __ BEQ $381e ; (_findstring.s23 + 0)
381d : 60 __ __ RTS
.s23:
381e : 8a __ __ TXA
381f : 18 __ __ CLC
3820 : 69 02 __ ADC #$02
3822 : 8d 30 3e STA $3e30 ; (i + 0)
3825 : a5 46 __ LDA T1 + 1 
3827 : 69 00 __ ADC #$00
3829 : 8d 31 3e STA $3e31 ; (i + 1)
382c : c8 __ __ INY
382d : b1 43 __ LDA (T0 + 0),y 
382f : aa __ __ TAX
3830 : 18 __ __ CLC
3831 : 69 ff __ ADC #$ff
3833 : 8d 42 3e STA $3e42 ; (len + 0)
3836 : 8a __ __ TXA
3837 : d0 01 __ BNE $383a ; (_findstring.s49 + 0)
3839 : 60 __ __ RTS
.s49:
383a : ad 77 3d LDA $3d77 ; (room + 0)
383d : 85 47 __ STA T2 + 0 
.l27:
383f : 18 __ __ CLC
3840 : a5 48 __ LDA T4 + 0 
3842 : 6d 30 3e ADC $3e30 ; (i + 0)
3845 : 85 45 __ STA T1 + 0 
3847 : a5 49 __ LDA T4 + 1 
3849 : 6d 31 3e ADC $3e31 ; (i + 1)
384c : 85 46 __ STA T1 + 1 
384e : a0 01 __ LDY #$01
3850 : b1 45 __ LDA (T1 + 0),y 
3852 : 8d cb 3e STA $3ecb ; (cmdid + 0)
3855 : ae 30 3e LDX $3e30 ; (i + 0)
3858 : 8a __ __ TXA
3859 : 18 __ __ CLC
385a : 69 01 __ ADC #$01
385c : 8d 30 3e STA $3e30 ; (i + 0)
385f : ad 31 3e LDA $3e31 ; (i + 1)
3862 : 85 44 __ STA T0 + 1 
3864 : 69 00 __ ADC #$00
3866 : 8d 31 3e STA $3e31 ; (i + 1)
3869 : a5 47 __ LDA T2 + 0 
386b : 88 __ __ DEY
386c : d1 45 __ CMP (T1 + 0),y 
386e : d0 01 __ BNE $3871 ; (_findstring.s31 + 0)
3870 : 60 __ __ RTS
.s31:
3871 : 8a __ __ TXA
3872 : 18 __ __ CLC
3873 : 69 02 __ ADC #$02
3875 : 8d 30 3e STA $3e30 ; (i + 0)
3878 : a5 44 __ LDA T0 + 1 
387a : 69 00 __ ADC #$00
387c : 8d 31 3e STA $3e31 ; (i + 1)
387f : ad 42 3e LDA $3e42 ; (len + 0)
3882 : ce 42 3e DEC $3e42 ; (len + 0)
3885 : 09 00 __ ORA #$00
3887 : d0 b6 __ BNE $383f ; (_findstring.l27 + 0)
3889 : 60 __ __ RTS
--------------------------------------------------------------------
memcmp: ; memcmp(const void*,const void*,i16)->i16
.s0:
388a : a5 11 __ LDA P4 ; (size + 0)
388c : aa __ __ TAX
388d : 18 __ __ CLC
388e : 69 ff __ ADC #$ff
3890 : 85 11 __ STA P4 ; (size + 0)
3892 : a5 12 __ LDA P5 ; (size + 1)
3894 : 85 1c __ STA ACCU + 1 
3896 : 69 ff __ ADC #$ff
3898 : 85 12 __ STA P5 ; (size + 1)
389a : 8a __ __ TXA
389b : 05 1c __ ORA ACCU + 1 
389d : f0 3a __ BEQ $38d9 ; (memcmp.s1006 + 0)
.s1008:
389f : a6 11 __ LDX P4 ; (size + 0)
.l2:
38a1 : a0 00 __ LDY #$00
38a3 : b1 0d __ LDA (P0),y ; (ptr1 + 0)
38a5 : d1 0f __ CMP (P2),y ; (ptr2 + 0)
38a7 : b0 04 __ BCS $38ad ; (memcmp.s5 + 0)
.s4:
38a9 : a9 ff __ LDA #$ff
38ab : 90 2c __ BCC $38d9 ; (memcmp.s1006 + 0)
.s5:
38ad : b1 0f __ LDA (P2),y ; (ptr2 + 0)
38af : d1 0d __ CMP (P0),y ; (ptr1 + 0)
38b1 : b0 07 __ BCS $38ba ; (memcmp.s1 + 0)
.s8:
38b3 : a9 01 __ LDA #$01
38b5 : 85 1b __ STA ACCU + 0 
38b7 : 98 __ __ TYA
38b8 : 90 21 __ BCC $38db ; (memcmp.s1001 + 0)
.s1:
38ba : 86 1b __ STX ACCU + 0 
38bc : 8a __ __ TXA
38bd : 18 __ __ CLC
38be : 69 ff __ ADC #$ff
38c0 : aa __ __ TAX
38c1 : a5 12 __ LDA P5 ; (size + 1)
38c3 : a8 __ __ TAY
38c4 : 69 ff __ ADC #$ff
38c6 : 85 12 __ STA P5 ; (size + 1)
38c8 : e6 0d __ INC P0 ; (ptr1 + 0)
38ca : d0 02 __ BNE $38ce ; (memcmp.s1010 + 0)
.s1009:
38cc : e6 0e __ INC P1 ; (ptr1 + 1)
.s1010:
38ce : e6 0f __ INC P2 ; (ptr2 + 0)
38d0 : d0 02 __ BNE $38d4 ; (memcmp.s1012 + 0)
.s1011:
38d2 : e6 10 __ INC P3 ; (ptr2 + 1)
.s1012:
38d4 : 98 __ __ TYA
38d5 : 05 1b __ ORA ACCU + 0 
38d7 : d0 c8 __ BNE $38a1 ; (memcmp.l2 + 0)
.s1006:
38d9 : 85 1b __ STA ACCU + 0 
.s1001:
38db : 85 1c __ STA ACCU + 1 
38dd : 60 __ __ RTS
--------------------------------------------------------------------
strncpy: ; strncpy(u8*,const u8*,u8)->u8*
.s0:
38de : a5 0d __ LDA P0 ; (destination + 0)
38e0 : 85 1b __ STA ACCU + 0 
38e2 : a5 0e __ LDA P1 ; (destination + 1)
38e4 : 85 1c __ STA ACCU + 1 
38e6 : 05 0d __ ORA P0 ; (destination + 0)
38e8 : d0 05 __ BNE $38ef ; (strncpy.s2 + 0)
.s1:
38ea : 85 1b __ STA ACCU + 0 
38ec : 85 1c __ STA ACCU + 1 
38ee : 60 __ __ RTS
.s2:
38ef : a0 00 __ LDY #$00
38f1 : b1 0f __ LDA (P2),y ; (source + 0)
38f3 : f0 2c __ BEQ $3921 ; (strncpy.s7 + 0)
.s1003:
38f5 : a6 11 __ LDX P4 ; (num + 0)
38f7 : 8a __ __ TXA
38f8 : f0 27 __ BEQ $3921 ; (strncpy.s7 + 0)
.l6:
38fa : a0 00 __ LDY #$00
38fc : b1 0f __ LDA (P2),y ; (source + 0)
38fe : 91 0d __ STA (P0),y ; (destination + 0)
3900 : e6 0d __ INC P0 ; (destination + 0)
3902 : d0 02 __ BNE $3906 ; (strncpy.s1006 + 0)
.s1005:
3904 : e6 0e __ INC P1 ; (destination + 1)
.s1006:
3906 : a5 0f __ LDA P2 ; (source + 0)
3908 : 85 43 __ STA T2 + 0 
390a : 18 __ __ CLC
390b : 69 01 __ ADC #$01
390d : 85 0f __ STA P2 ; (source + 0)
390f : a5 10 __ LDA P3 ; (source + 1)
3911 : 85 44 __ STA T2 + 1 
3913 : 69 00 __ ADC #$00
3915 : 85 10 __ STA P3 ; (source + 1)
3917 : a0 01 __ LDY #$01
3919 : ca __ __ DEX
391a : b1 43 __ LDA (T2 + 0),y 
391c : f0 03 __ BEQ $3921 ; (strncpy.s7 + 0)
.s8:
391e : 8a __ __ TXA
391f : d0 d9 __ BNE $38fa ; (strncpy.l6 + 0)
.s7:
3921 : a8 __ __ TAY
3922 : 91 0d __ STA (P0),y ; (destination + 0)
.s1001:
3924 : 60 __ __ RTS
--------------------------------------------------------------------
charmap: ; charmap(u8)->u8
.s0:
3925 : c9 30 __ CMP #$30
3927 : 90 04 __ BCC $392d ; (charmap.s2 + 0)
.s4:
3929 : c9 3a __ CMP #$3a
392b : 90 24 __ BCC $3951 ; (charmap.s1001 + 0)
.s2:
392d : c9 41 __ CMP #$41
392f : 90 07 __ BCC $3938 ; (charmap.s6 + 0)
.s8:
3931 : c9 5b __ CMP #$5b
3933 : b0 03 __ BCS $3938 ; (charmap.s6 + 0)
.s5:
3935 : 69 c0 __ ADC #$c0
3937 : 60 __ __ RTS
.s6:
3938 : c9 61 __ CMP #$61
393a : 90 07 __ BCC $3943 ; (charmap.s10 + 0)
.s12:
393c : c9 7b __ CMP #$7b
393e : b0 03 __ BCS $3943 ; (charmap.s10 + 0)
.s9:
3940 : 69 a0 __ ADC #$a0
3942 : 60 __ __ RTS
.s10:
3943 : c9 20 __ CMP #$20
3945 : f0 0a __ BEQ $3951 ; (charmap.s1001 + 0)
.s14:
3947 : c9 2e __ CMP #$2e
3949 : f0 06 __ BEQ $3951 ; (charmap.s1001 + 0)
.s17:
394b : c9 2c __ CMP #$2c
394d : f0 02 __ BEQ $3951 ; (charmap.s1001 + 0)
.s20:
394f : a9 00 __ LDA #$00
.s1001:
3951 : 60 __ __ RTS
--------------------------------------------------------------------
do_blink: ; do_blink()->void
.s0:
3952 : ee cc 3e INC $3ecc ; (blink + 0)
3955 : ad cc 3e LDA $3ecc ; (blink + 0)
3958 : c9 5b __ CMP #$5b
395a : 90 5e __ BCC $39ba ; (do_blink.s1001 + 0)
.s1:
395c : ad 49 3e LDA $3e49 ; (txt_y + 0)
395f : 0a __ __ ASL
3960 : 85 1b __ STA ACCU + 0 
3962 : a9 00 __ LDA #$00
3964 : 8d cc 3e STA $3ecc ; (blink + 0)
3967 : 2a __ __ ROL
3968 : 06 1b __ ASL ACCU + 0 
396a : 2a __ __ ROL
396b : aa __ __ TAX
396c : a5 1b __ LDA ACCU + 0 
396e : 6d 49 3e ADC $3e49 ; (txt_y + 0)
3971 : 85 1b __ STA ACCU + 0 
3973 : 8a __ __ TXA
3974 : 69 00 __ ADC #$00
3976 : 06 1b __ ASL ACCU + 0 
3978 : 2a __ __ ROL
3979 : 06 1b __ ASL ACCU + 0 
397b : 2a __ __ ROL
397c : 06 1b __ ASL ACCU + 0 
397e : 2a __ __ ROL
397f : aa __ __ TAX
3980 : ad 48 3e LDA $3e48 ; (txt_x + 0)
3983 : 18 __ __ CLC
3984 : 65 1b __ ADC ACCU + 0 
3986 : 85 1b __ STA ACCU + 0 
3988 : 90 01 __ BCC $398b ; (do_blink.s1007 + 0)
.s1006:
398a : e8 __ __ INX
.s1007:
398b : 86 1c __ STX ACCU + 1 
398d : 18 __ __ CLC
398e : 6d 64 3d ADC $3d64 ; (video_colorram + 0)
3991 : 85 43 __ STA T2 + 0 
3993 : ad 65 3d LDA $3d65 ; (video_colorram + 1)
3996 : 65 1c __ ADC ACCU + 1 
3998 : 85 44 __ STA T2 + 1 
399a : a0 00 __ LDY #$00
399c : b1 43 __ LDA (T2 + 0),y 
399e : f0 03 __ BEQ $39a3 ; (do_blink.s1008 + 0)
.s1009:
39a0 : 98 __ __ TYA
39a1 : f0 02 __ BEQ $39a5 ; (do_blink.s1010 + 0)
.s1008:
39a3 : a9 0c __ LDA #$0c
.s1010:
39a5 : 91 43 __ STA (T2 + 0),y 
39a7 : ad 62 3d LDA $3d62 ; (video_ram + 0)
39aa : 18 __ __ CLC
39ab : 65 1b __ ADC ACCU + 0 
39ad : 85 1b __ STA ACCU + 0 
39af : ad 63 3d LDA $3d63 ; (video_ram + 1)
39b2 : 65 1c __ ADC ACCU + 1 
39b4 : 85 1c __ STA ACCU + 1 
39b6 : a9 6c __ LDA #$6c
39b8 : 91 1b __ STA (ACCU + 0),y 
.s1001:
39ba : 60 __ __ RTS
--------------------------------------------------------------------
adv_reset: ; adv_reset()->void
.s0:
39bb : ad 0a 3e LDA $3e0a ; (objattr + 0)
39be : 85 0d __ STA P0 
39c0 : ad 0b 3e LDA $3e0b ; (objattr + 1)
39c3 : 85 0e __ STA P1 
39c5 : a9 00 __ LDA #$00
39c7 : 85 0f __ STA P2 
39c9 : a9 05 __ LDA #$05
39cb : 85 10 __ STA P3 
39cd : ad 1a 3e LDA $3e1a ; (origram_len + 0)
39d0 : 85 11 __ STA P4 
39d2 : ad 1b 3e LDA $3e1b ; (origram_len + 1)
39d5 : 85 12 __ STA P5 
39d7 : 4c d5 0c JMP $0cd5 ; (memcpy.s0 + 0)
--------------------------------------------------------------------
adv_load: ; adv_load()->u8
.s0:
39da : a9 00 __ LDA #$00
39dc : 85 13 __ STA P6 
39de : 20 c6 2a JSR $2ac6 ; (irq_detach.l30 + 0)
39e1 : a9 74 __ LDA #$74
39e3 : 85 0d __ STA P0 
39e5 : a9 2b __ LDA #$2b
39e7 : 85 0e __ STA P1 
39e9 : ad 0a 3e LDA $3e0a ; (objattr + 0)
39ec : 85 0f __ STA P2 
39ee : ad 0b 3e LDA $3e0b ; (objattr + 1)
39f1 : 85 10 __ STA P3 
39f3 : ad 1a 3e LDA $3e1a ; (origram_len + 0)
39f6 : 85 11 __ STA P4 
39f8 : ad 1b 3e LDA $3e1b ; (origram_len + 1)
39fb : 85 12 __ STA P5 
39fd : 20 22 3a JSR $3a22 ; (disk_load.s0 + 0)
3a00 : 09 00 __ ORA #$00
3a02 : f0 07 __ BEQ $3a0b ; (adv_load.s1 + 0)
.s2:
3a04 : 20 79 2b JSR $2b79 ; (irq_attach.l27 + 0)
3a07 : a9 01 __ LDA #$01
3a09 : d0 14 __ BNE $3a1f ; (adv_load.s1001 + 0)
.s1:
3a0b : a9 02 __ LDA #$02
3a0d : 8d 20 d0 STA $d020 
.l32:
3a10 : 2c 11 d0 BIT $d011 
3a13 : 10 fb __ BPL $3a10 ; (adv_load.l32 + 0)
.s4:
3a15 : a9 00 __ LDA #$00
3a17 : 8d 20 d0 STA $d020 
3a1a : 20 79 2b JSR $2b79 ; (irq_attach.l27 + 0)
3a1d : a9 00 __ LDA #$00
.s1001:
3a1f : 85 1b __ STA ACCU + 0 
3a21 : 60 __ __ RTS
--------------------------------------------------------------------
disk_load: ; disk_load(const u8*,u8*,u16)->u8
.s0:
3a22 : a5 0f __ LDA P2 ; (mem + 0)
3a24 : 8d b0 3e STA $3eb0 ; (diskmemlow + 0)
3a27 : a5 10 __ LDA P3 ; (mem + 1)
3a29 : 8d b1 3e STA $3eb1 ; (diskmemhi + 0)
3a2c : a9 07 __ LDA #$07
3a2e : a2 ae __ LDX #$ae
3a30 : a0 3d __ LDY #$3d
3a32 : 20 bd ff JSR $ffbd 
3a35 : a9 01 __ LDA #$01
3a37 : a6 ba __ LDX $ba 
3a39 : d0 02 __ BNE $3a3d ; (disk_load.s0 + 27)
3a3b : a2 08 __ LDX #$08
3a3d : a0 00 __ LDY #$00
3a3f : 20 ba ff JSR $ffba 
3a42 : a9 00 __ LDA #$00
3a44 : ae b0 3e LDX $3eb0 ; (diskmemlow + 0)
3a47 : ac b1 3e LDY $3eb1 ; (diskmemhi + 0)
3a4a : 20 d5 ff JSR $ffd5 
3a4d : b0 05 __ BCS $3a54 ; (disk_load.s0 + 50)
3a4f : a9 01 __ LDA #$01
3a51 : 85 1b __ STA ACCU + 0 
3a53 : 60 __ __ RTS
3a54 : a9 00 __ LDA #$00
3a56 : 85 1b __ STA ACCU + 0 
.s1001:
3a58 : a5 1b __ LDA ACCU + 0 
3a5a : 60 __ __ RTS
--------------------------------------------------------------------
os_reset: ; os_reset()->void
.s0:
3a5b : 20 e2 fc JSR $fce2 
.s1001:
3a5e : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
3a5f : a5 1c __ LDA ACCU + 1 
3a61 : d0 31 __ BNE $3a94 ; (divmod + 53)
3a63 : a5 04 __ LDA WORK + 1 
3a65 : d0 1e __ BNE $3a85 ; (divmod + 38)
3a67 : 85 06 __ STA WORK + 3 
3a69 : a2 04 __ LDX #$04
3a6b : 06 1b __ ASL ACCU + 0 
3a6d : 2a __ __ ROL
3a6e : c5 03 __ CMP WORK + 0 
3a70 : 90 02 __ BCC $3a74 ; (divmod + 21)
3a72 : e5 03 __ SBC WORK + 0 
3a74 : 26 1b __ ROL ACCU + 0 
3a76 : 2a __ __ ROL
3a77 : c5 03 __ CMP WORK + 0 
3a79 : 90 02 __ BCC $3a7d ; (divmod + 30)
3a7b : e5 03 __ SBC WORK + 0 
3a7d : 26 1b __ ROL ACCU + 0 
3a7f : ca __ __ DEX
3a80 : d0 eb __ BNE $3a6d ; (divmod + 14)
3a82 : 85 05 __ STA WORK + 2 
3a84 : 60 __ __ RTS
3a85 : a5 1b __ LDA ACCU + 0 
3a87 : 85 05 __ STA WORK + 2 
3a89 : a5 1c __ LDA ACCU + 1 
3a8b : 85 06 __ STA WORK + 3 
3a8d : a9 00 __ LDA #$00
3a8f : 85 1b __ STA ACCU + 0 
3a91 : 85 1c __ STA ACCU + 1 
3a93 : 60 __ __ RTS
3a94 : a5 04 __ LDA WORK + 1 
3a96 : d0 1f __ BNE $3ab7 ; (divmod + 88)
3a98 : a5 03 __ LDA WORK + 0 
3a9a : 30 1b __ BMI $3ab7 ; (divmod + 88)
3a9c : a9 00 __ LDA #$00
3a9e : 85 06 __ STA WORK + 3 
3aa0 : a2 10 __ LDX #$10
3aa2 : 06 1b __ ASL ACCU + 0 
3aa4 : 26 1c __ ROL ACCU + 1 
3aa6 : 2a __ __ ROL
3aa7 : c5 03 __ CMP WORK + 0 
3aa9 : 90 02 __ BCC $3aad ; (divmod + 78)
3aab : e5 03 __ SBC WORK + 0 
3aad : 26 1b __ ROL ACCU + 0 
3aaf : 26 1c __ ROL ACCU + 1 
3ab1 : ca __ __ DEX
3ab2 : d0 f2 __ BNE $3aa6 ; (divmod + 71)
3ab4 : 85 05 __ STA WORK + 2 
3ab6 : 60 __ __ RTS
3ab7 : a9 00 __ LDA #$00
3ab9 : 85 05 __ STA WORK + 2 
3abb : 85 06 __ STA WORK + 3 
3abd : 84 02 __ STY $02 
3abf : a0 10 __ LDY #$10
3ac1 : 18 __ __ CLC
3ac2 : 26 1b __ ROL ACCU + 0 
3ac4 : 26 1c __ ROL ACCU + 1 
3ac6 : 26 05 __ ROL WORK + 2 
3ac8 : 26 06 __ ROL WORK + 3 
3aca : 38 __ __ SEC
3acb : a5 05 __ LDA WORK + 2 
3acd : e5 03 __ SBC WORK + 0 
3acf : aa __ __ TAX
3ad0 : a5 06 __ LDA WORK + 3 
3ad2 : e5 04 __ SBC WORK + 1 
3ad4 : 90 04 __ BCC $3ada ; (divmod + 123)
3ad6 : 86 05 __ STX WORK + 2 
3ad8 : 85 06 __ STA WORK + 3 
3ada : 88 __ __ DEY
3adb : d0 e5 __ BNE $3ac2 ; (divmod + 99)
3add : 26 1b __ ROL ACCU + 0 
3adf : 26 1c __ ROL ACCU + 1 
3ae1 : a4 02 __ LDY $02 
3ae3 : 60 __ __ RTS
--------------------------------------------------------------------
spentry:
3ae4 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
font:
3ae5 : __ __ __ BYT c7 38 44 4c 4c 40 44 38 03 c5 38 04 3c 44 3c 02 : .8DLL@D8..8.<D<.
3af5 : __ __ __ BYT c6 40 40 78 44 44 78 83 10 c1 3c 43 40 83 10 c1 : .@@xDDx...<C@...
3b05 : __ __ __ BYT 04 83 17 84 18 c4 00 38 44 7c 84 10 c3 0c 10 3c : .......8D|.....<
3b15 : __ __ __ BYT 43 10 84 20 83 17 c2 04 78 86 30 c8 44 00 00 10 : C.. ....x.0.D...
3b25 : __ __ __ BYT 00 30 10 10 83 48 c2 08 00 44 08 c1 70 83 18 c3 : .0...H...D..p...
3b35 : __ __ __ BYT 48 70 48 83 18 83 16 85 18 c4 00 68 54 54 84 28 : HpH........hTT.(
3b45 : __ __ __ BYT c1 00 84 2f 84 08 c1 38 83 07 84 18 84 6f c2 40 : .../...8.....o.@
3b55 : __ __ __ BYT 40 87 50 c1 04 84 10 83 79 85 80 c1 38 83 5f c3 : @.P.....y...8._.
3b65 : __ __ __ BYT 00 10 7c 83 40 c1 0c 83 10 84 37 84 88 83 07 c1 : ..|.@.....7.....
3b75 : __ __ __ BYT 28 84 80 83 08 c2 54 28 84 08 c3 28 10 28 84 50 : (.....T(...(.(.P
3b85 : __ __ __ BYT 84 1f 83 78 c8 00 7c 08 10 20 7c 00 38 45 20 cb : ...x..|.. |.8E .
3b95 : __ __ __ BYT 38 00 0c 12 30 7c 30 62 fc 00 38 45 08 83 70 c3 : 8...0|0b..8E..p.
3ba5 : __ __ __ BYT 18 3c 7e 44 18 c6 00 10 30 7f 7f 30 84 48 06 84 : .<~D....0..0.H..
3bb5 : __ __ __ BYT a6 84 c5 86 9c 84 4e c3 fe 44 fe 83 0c c2 10 2c : ......N..D.....,
3bc5 : __ __ __ BYT 83 87 ca 68 10 00 62 66 0c 18 30 66 46 83 b6 c5 : ...h..bf..0fF...
3bd5 : __ __ __ BYT 28 30 46 44 3a 83 30 c1 20 85 28 83 6d c5 20 20 : (0FD:.0. .(.m.  
3be5 : __ __ __ BYT 10 08 00 83 04 c1 08 83 0c 84 8f c1 fe 85 8f c1 : ................
3bf5 : __ __ __ BYT 10 84 b9 89 5d 84 2d c1 7c 0a 83 19 c2 02 04 83 : ....].-.|.......
3c05 : __ __ __ BYT 2f c1 40 83 50 c5 4c 54 64 44 38 83 8f c1 70 83 : /.@.P.LTdD8...p.
3c15 : __ __ __ BYT 82 83 b8 c5 44 04 08 30 40 85 08 c2 18 04 83 18 : ....D..0@.......
3c25 : __ __ __ BYT cc 08 18 28 48 7c 08 08 00 7c 40 78 04 84 10 c5 : ...(H|...|@x....
3c35 : __ __ __ BYT 38 44 40 78 44 83 08 c3 7c 44 08 85 b3 c1 38 83 : 8D@xD...|D....8.
3c45 : __ __ __ BYT 0d 84 10 83 05 c1 3c 84 20 85 5c 85 78 84 08 c3 : ......<. .\.x...
3c55 : __ __ __ BYT 10 20 0c 83 65 c3 20 10 0c 85 7f 84 81 c3 60 10 : . ..e. .......`.
3c65 : __ __ __ BYT 08 83 79 c1 60 85 68 c1 10 86 29 c2 ff ff 84 2e : ..y.`.h...).....
3c75 : __ __ __ BYT c3 28 44 7c 84 fc 83 5d 83 60 c1 78 84 68 c2 40 : .(D|...].`.x.h.@
3c85 : __ __ __ BYT 40 83 50 c2 70 48 83 16 c2 48 70 83 80 c3 40 78 : @.P.pH...Hp...@x
3c95 : __ __ __ BYT 40 83 98 86 08 84 b8 c2 40 4c 84 78 83 1e 85 38 : @.......@L.x...8
3ca5 : __ __ __ BYT c1 38 45 10 c3 38 00 1c 44 08 cb 68 30 00 44 48 : .8E..8..D..h0.DH
3cb5 : __ __ __ BYT 50 60 50 48 44 00 46 40 c5 7c 00 44 6c 54 44 44 : P`PHD.F@.|.DlTDD
3cc5 : __ __ __ BYT c4 00 44 64 54 83 38 83 30 45 44 c1 38 85 70 86 : ..DdT.8.0ED.8.p.
3cd5 : __ __ __ BYT 50 84 0f c1 0c 85 10 84 38 83 60 c1 38 84 d0 c1 : P.......8.`.8...
3ce5 : __ __ __ BYT 7c 46 10 84 68 85 30 85 07 c1 28 86 10 c2 54 6c : |F..h.0...(...Tl
3cf5 : __ __ __ BYT 83 50 83 0d c1 28 84 58 84 09 83 28 c1 7c 83 d7 : .P...(.X...(.|..
3d05 : __ __ __ BYT c1 20 83 70 c7 20 10 38 04 3c 44 3c 84 08 c6 44 : . .p. .8.<D<...D
3d15 : __ __ __ BYT 7c 40 3c 00 08 87 08 c4 20 10 00 30 84 a8 84 18 : |@<..... ..0....
3d25 : __ __ __ BYT 84 50 c2 20 10 84 4a c1 3c 03 c1 3c 83 87 c4 1c : .P. ..J.<..<....
3d35 : __ __ __ BYT 30 50 28 83 82 83 50 c3 30 48 48 83 fb c2 58 40 : 0P(...P.0HH...X@
3d45 : __ __ __ BYT 83 5d 85 e0 c2 20 7c 84 f8 83 58 87 08 88 f0 88 : .]... |...X.....
3d55 : __ __ __ BYT c8 88 a0 48 10 48 28 05 c3 44 7c 00 00          : ...H.H(..D|..
--------------------------------------------------------------------
video_ram:
3d62 : __ __ __ BYT 00 f4                                           : ..
--------------------------------------------------------------------
video_colorram:
3d64 : __ __ __ BYT 00 d8                                           : ..
--------------------------------------------------------------------
advnm:
3d66 : __ __ __ BYT 41 44 56 43 41 52 54 52 49 44 47 45 00          : ADVCARTRIDGE.
--------------------------------------------------------------------
giocharmap:
3d73 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
strcmd:
3d74 : __ __ __ BYT a7 02                                           : ..
--------------------------------------------------------------------
text_y:
3d76 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
room:
3d77 : __ __ __ BYT fa                                              : .
--------------------------------------------------------------------
istack:
3d78 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
opcodeattr:
3d79 : __ __ __ BYT 82 83 81 81 83 01 01 01 01 81 82 82 82 02 03 02 : ................
3d89 : __ __ __ BYT 03 02 02 02 04 02 04 83 81 82 82 82 82 83 03 83 : ................
3d99 : __ __ __ BYT 81 81 82 83 84 83 83 83 83 83 82 81 82 83 81 02 : ................
--------------------------------------------------------------------
seed:
3da9 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
align:
3dab : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
quit_request:
3dad : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
disknm:
3dae : __ __ __ BYT 40 30 3a 53 41 56 45 00                         : @0:SAVE.
--------------------------------------------------------------------
slowmode:
3db6 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3db7 : __ __ __ BYT 52 4f 4f 4d 30 31 2c 50 2c 52 00                : ROOM01,P,R.
--------------------------------------------------------------------
bitmap_image:
3dc2 : __ __ __ BYT 00 e0                                           : ..
--------------------------------------------------------------------
nextroom:
3dc4 : __ __ __ BYT fa                                              : .
--------------------------------------------------------------------
curimageid:
3dc5 : __ __ __ BYT ff                                              : .
--------------------------------------------------------------------
ormask:
3dc6 : __ __ __ BYT 01 02 04 08 10 20 40 80                         : ..... @.
--------------------------------------------------------------------
xormask:
3dce : __ __ __ BYT fe fd fb f7 ef df bf 7f                         : ........
--------------------------------------------------------------------
icmd:
3dd6 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
hb_len:
3dd7 : __ __ __ BSS	1
--------------------------------------------------------------------
advcartridge:
3dd8 : __ __ __ BSS	2
--------------------------------------------------------------------
tmp2:
3dda : __ __ __ BSS	2
--------------------------------------------------------------------
freemem:
3ddc : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_count:
3dde : __ __ __ BSS	1
--------------------------------------------------------------------
obj_count:
3ddf : __ __ __ BSS	1
--------------------------------------------------------------------
shortdict:
3de0 : __ __ __ BSS	2
--------------------------------------------------------------------
advnames:
3de2 : __ __ __ BSS	2
--------------------------------------------------------------------
advdesc:
3de4 : __ __ __ BSS	2
--------------------------------------------------------------------
msgs:
3de6 : __ __ __ BSS	2
--------------------------------------------------------------------
msgs2:
3de8 : __ __ __ BSS	2
--------------------------------------------------------------------
verbs:
3dea : __ __ __ BSS	2
--------------------------------------------------------------------
objs:
3dec : __ __ __ BSS	2
--------------------------------------------------------------------
objs_dir:
3dee : __ __ __ BSS	2
--------------------------------------------------------------------
rooms:
3df0 : __ __ __ BSS	2
--------------------------------------------------------------------
packdata:
3df2 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_dir:
3df4 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_vrbidx_data:
3df6 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_pos:
3df8 : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_len:
3dfa : __ __ __ BSS	2
--------------------------------------------------------------------
opcode_data:
3dfc : __ __ __ BSS	2
--------------------------------------------------------------------
roomnameid:
3dfe : __ __ __ BSS	2
--------------------------------------------------------------------
roomdescid:
3e00 : __ __ __ BSS	2
--------------------------------------------------------------------
roomimg:
3e02 : __ __ __ BSS	2
--------------------------------------------------------------------
roomovrimg:
3e04 : __ __ __ BSS	2
--------------------------------------------------------------------
objnameid:
3e06 : __ __ __ BSS	2
--------------------------------------------------------------------
objdescid:
3e08 : __ __ __ BSS	2
--------------------------------------------------------------------
objattr:
3e0a : __ __ __ BSS	2
--------------------------------------------------------------------
objloc:
3e0c : __ __ __ BSS	2
--------------------------------------------------------------------
objattrex:
3e0e : __ __ __ BSS	2
--------------------------------------------------------------------
roomstart:
3e10 : __ __ __ BSS	2
--------------------------------------------------------------------
roomattr:
3e12 : __ __ __ BSS	2
--------------------------------------------------------------------
roomattrex:
3e14 : __ __ __ BSS	2
--------------------------------------------------------------------
bitvars:
3e16 : __ __ __ BSS	2
--------------------------------------------------------------------
vars:
3e18 : __ __ __ BSS	2
--------------------------------------------------------------------
origram_len:
3e1a : __ __ __ BSS	2
--------------------------------------------------------------------
tmp:
3e1c : __ __ __ BSS	2
--------------------------------------------------------------------
vrb:
3e1e : __ __ __ BSS	2
--------------------------------------------------------------------
clearfull:
3e20 : __ __ __ BSS	1
--------------------------------------------------------------------
al:
3e21 : __ __ __ BSS	1
--------------------------------------------------------------------
newroom:
3e22 : __ __ __ BSS	1
--------------------------------------------------------------------
cmd:
3e23 : __ __ __ BSS	1
--------------------------------------------------------------------
obj1:
3e24 : __ __ __ BSS	1
--------------------------------------------------------------------
executed:
3e25 : __ __ __ BSS	1
--------------------------------------------------------------------
varroom:
3e26 : __ __ __ BSS	1
--------------------------------------------------------------------
opcode:
3e27 : __ __ __ BSS	1
--------------------------------------------------------------------
pcode:
3e28 : __ __ __ BSS	2
--------------------------------------------------------------------
pcodelen:
3e2a : __ __ __ BSS	2
--------------------------------------------------------------------
in:
3e2c : __ __ __ BSS	1
--------------------------------------------------------------------
fail:
3e2d : __ __ __ BSS	1
--------------------------------------------------------------------
used:
3e2e : __ __ __ BSS	1
--------------------------------------------------------------------
thisobj:
3e2f : __ __ __ BSS	1
--------------------------------------------------------------------
i:
3e30 : __ __ __ BSS	2
--------------------------------------------------------------------
varobj:
3e32 : __ __ __ BSS	1
--------------------------------------------------------------------
varmode:
3e33 : __ __ __ BSS	1
--------------------------------------------------------------------
var:
3e34 : __ __ __ BSS	1
--------------------------------------------------------------------
obj2:
3e35 : __ __ __ BSS	1
--------------------------------------------------------------------
ch:
3e36 : __ __ __ BSS	1
--------------------------------------------------------------------
str:
3e37 : __ __ __ BSS	2
--------------------------------------------------------------------
text_continue:
3e39 : __ __ __ BSS	1
--------------------------------------------------------------------
strid:
3e3a : __ __ __ BSS	1
--------------------------------------------------------------------
txt:
3e3b : __ __ __ BSS	2
--------------------------------------------------------------------
varattr:
3e3d : __ __ __ BSS	1
--------------------------------------------------------------------
a:
3e3e : __ __ __ BSS	1
--------------------------------------------------------------------
_strid:
3e3f : __ __ __ BSS	1
--------------------------------------------------------------------
ostr:
3e40 : __ __ __ BSS	2
--------------------------------------------------------------------
len:
3e42 : __ __ __ BSS	1
--------------------------------------------------------------------
etxt:
3e43 : __ __ __ BSS	2
--------------------------------------------------------------------
txt_col:
3e45 : __ __ __ BSS	1
--------------------------------------------------------------------
text_attach:
3e46 : __ __ __ BSS	1
--------------------------------------------------------------------
txt_rev:
3e47 : __ __ __ BSS	1
--------------------------------------------------------------------
txt_x:
3e48 : __ __ __ BSS	1
--------------------------------------------------------------------
txt_y:
3e49 : __ __ __ BSS	1
--------------------------------------------------------------------
_ch:
3e4a : __ __ __ BSS	1
--------------------------------------------------------------------
_ech:
3e4b : __ __ __ BSS	1
--------------------------------------------------------------------
_cplx:
3e4c : __ __ __ BSS	1
--------------------------------------------------------------------
_cplw:
3e4d : __ __ __ BSS	1
--------------------------------------------------------------------
_cpl:
3e4e : __ __ __ BSS	2
--------------------------------------------------------------------
ll:
3e50 : __ __ __ BSS	2
--------------------------------------------------------------------
spl:
3e52 : __ __ __ BSS	2
--------------------------------------------------------------------
u:
3e54 : __ __ __ BSS	1
--------------------------------------------------------------------
v:
3e55 : __ __ __ BSS	1
--------------------------------------------------------------------
_buffer:
3e56 : __ __ __ BSS	42
--------------------------------------------------------------------
_cbuffer:
3e80 : __ __ __ BSS	42
--------------------------------------------------------------------
btxt:
3eaa : __ __ __ BSS	2
--------------------------------------------------------------------
b_cpl:
3eac : __ __ __ BSS	2
--------------------------------------------------------------------
b_cplx:
3eae : __ __ __ BSS	1
--------------------------------------------------------------------
b_cplw:
3eaf : __ __ __ BSS	1
--------------------------------------------------------------------
diskmemlow:
3eb0 : __ __ __ BSS	1
--------------------------------------------------------------------
diskmemhi:
3eb1 : __ __ __ BSS	1
--------------------------------------------------------------------
ediskmemlow:
3eb2 : __ __ __ BSS	1
--------------------------------------------------------------------
ediskmemhi:
3eb3 : __ __ __ BSS	1
--------------------------------------------------------------------
saved:
3eb4 : __ __ __ BSS	1
--------------------------------------------------------------------
key:
3eb5 : __ __ __ BSS	1
--------------------------------------------------------------------
imageid:
3eb6 : __ __ __ BSS	1
--------------------------------------------------------------------
krnio_pstatus:
3eb7 : __ __ __ BSS	16
--------------------------------------------------------------------
obj1k:
3ec7 : __ __ __ BSS	1
--------------------------------------------------------------------
obj2k:
3ec8 : __ __ __ BSS	1
--------------------------------------------------------------------
strdir:
3ec9 : __ __ __ BSS	2
--------------------------------------------------------------------
cmdid:
3ecb : __ __ __ BSS	1
--------------------------------------------------------------------
blink:
3ecc : __ __ __ BSS	1
