; ==========================================================================
; Pet Frogger
; (c) November 1983 by John C. Dale, aka Dalesoft
; for the Commodore Pet 4032
;
; ==========================================================================
; Ported (parodied) to Atari 8-bit computers
; by Ken Jennings (if this were 1983, aka FTR Enterprises)
;
; Version 00, November 2018
; Version 01, December 2018
; Version 02, February 2019
; Version 03, April 2019
;
; --------------------------------------------------------------------------

; ==========================================================================
; Custom Character Set for V02  . . .
;
; Internal Codes for redefined objects.
; Several things going on here in one character set...
; * The usual Mode 2 text:  
;   A-z, a-z, 0-9, and necessary punctuation are used for the instructions 
;   on the title screen.  These are redefined in their natural positions, 
;   so every character does not need to be declared.  
; * Mode 2 color artifacts: 
;   Specific characters are defined for the text in the score lines.  
; * Mode 4, 5 colors colors:
;   This provides the game's beach and rocks graphics, waves, animated
;   boats and water effects. Five colors (including background.)
; Boat Lines:
; COLPF0 = blue (and varieties) for the water waves. 
; COLPF1 = Browns Main boat body. 
; COLPF2 = Boat Seats (collision color used for safe frog on boat.) 
; COLPF3 = White (full screen) Wave effects, Missile colors for frog eyes.
; COLBK  = Water waves (from above line)
; Beach Lines:
; COLPF0 = Water color (from line above)
; COLPF1 = Rock 1 main color
; COLPF2 = Sand background (darker) 
; COLPF3 = White (rock hilight) 
; COLBK  = Sand color
; --------------------------------------------------------------------------

I_BOAT_LF    = $02 ; ", boat, left, front,       animated (2 images)
I_BOAT_LFW   = $03 ; #, boat, left, front waves, animated (8 images)
I_SEATS_L1   = $04 ; $, boat, left, seats 1
I_SEATS_L2   = $05 ; %, boat, left, seats 2
I_SEATS_L3   = $06 ; &, boat, left, seats 3
I_BOAT_EMPTY = $0A ; *, boat, common filler before engine. 
I_BOAT_LB    = $0B ; +, boat, left, back (engine)
I_BOAT_LBW   = $0F ; /, boat, left, back waves,  animated (8 images)

I_BOAT_RBW   = $1b ; ;, boat, right, back waves,   animated (8 images)
I_BOAT_RB    = $1c ; <, boat, right, back (engine)
;I_BOAT_EMPTY
I_SEATS_R3   = $1e ; >, boat, right, seats 3
I_SEATS_R2   = $46 ; ctrl-F, boat, right, seats 2
I_SEATS_R1   = $47 ; ctrl-G, boat, right, seats 1
I_BOAT_RFW   = $49 ; ctrl-I, boat, right, front waves, animated (8 images)
I_BOAT_RF    = $4b ; ctrl-K;, boat, right, front,       animated (2 images)

I_BEACH1     = $4c ; ctrl-L, beach part 1
I_BEACH2     = $4d ; ctrl-M, beach part 2
I_BEACH3     = $4e ; ctrl-N, beach part 3
I_BEACH4     = $4f ; ctrl-O, beach part 4
I_BEACH5     = $51 ; ctrl-Q, beach part 5
I_BEACH6     = $52 ; ctrl-R, beach part 6 (and alternate beack rocks)
I_BEACH7     = $53 ; ctrl-S, beach part 7 (and alternate beach rocks)
I_BEACH8     = $54 ; ctrl-T, beach part 8

I_ROCKS1L    = $55 ; ctrl-U, alternate rocks1 (left)  I_BEACH6
I_ROCKS1R    = $56 ; ctrl-V, alternate rocks1 (right) I_BEACH7
I_ROCKS2     = $57 ; ctrl-W, alternate rocks2 (right) I_BEACH7
I_ROCKS3     = $58 ; ctrl-X, alternate rocks3 (right) I_BEACH7
I_ROCKS4     = $59 ; ctrl-Y, alternate rocks4 (left)  I_BEACH6

I_WATER1     = $5A ; ctrl-Z, Water
I_WATER2     = $5B ; escape, water
I_WATER3     = $5C ; up,     water
I_WATER4     = $5D ; down,   water

; Special artifact characters for Score:, :Hi, Frogs:, Saved Frogs:
I_BS = $50 ; "S", ctrl-P
I_SC = $41 ; "c", ctrl-A
I_SO = $42 ; "o", ctrl-B
I_SR = $43 ; "r", ctrl-C
I_SE = $44 ; "e", ctrl-D
I_CO = $20 ; ":", @

I_BH = $3E ; "H", ^
I_SI = $3F ; "i", _

I_BF = $3B ; "F", [
I_SG = $3D ; "g", ]
I_SS = $3C ; "s", \

I_BA = $45 ; "a", ctrl-E
I_SV = $48 ; "v", ctrl-H
I_SD = $4A ; "d", ctrl-J

; Frog shapes alternate in the Frog counter to make their 8-pixel wide
; shapes more recognizable.
I_FROG1 = $7E ; DELETE, A Frog for frog counter. 
I_FROG2 = $7F ; TAB, A Frog for frog counter. 


	.align $0400 ; Start at ANTIC's 1K boundary for character sets

 
CHARACTER_SET
; Page 0xE0.  Chars 0 to 31 -- Symbols, numbers
; Char $00: SPACE
	.BYTE $00,$00,$00,$00,$00,$00,$00,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $01:   !
	.BYTE $00,$18,$18,$18,$18,$00,$18,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $02:   "
	.BYTE $30,$78,$00,$00,$0E,$1F,$00,$00
; $30: . . # # . . . .
; $78: . # # # # . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $0E: . . . . # # # .
; $1F: . . . # # # # #
; $00: . . . . . . . .
; $00: . . . . . . . .

; Char $03:   #
	.by $00,$00,$f0,$78,$3c,$1e,$0f,$07
; $00: . . . . . . . .
; $00: . . . . . . . .
; $f0: # # # # . . . .
; $78: . # # # # . . .
; $3c: . . # # # # . .
; $1e: . . . # # # # .
; $0F: . . . . # # # #
; $07: . . . . . # # #

;; Char $04:   $
	.by $00,$00,$0f,$1e,$3c,$78,$f0,$e0
; $00: . . . . . . . .
; $00: . . . . . . . .
; $0f: . . . . # # # #
; $1e: . . . # # # # .
; $3c: . . # # # # . .
; $78: . # # # # . . .
; $f0: # # # # . . . .
; $e0: # # # . . . . .

;; Char $05:   %
	.byte $00,$00,$38,$38,$38,$78,$f0,$e0
; $00: . . . . . . . .
; $00: . . . . . . . .
; $38: . . # # # . . .
; $38: . . # # # . . .
; $38: . . # # # . . .
; $78: . # # # # . . .
; $F0: # # # # . . . .
; $E0: # # # . . . . .

;; Char $06:   &
	.by $00,$00,$1c,$1c,$1c,$1e,$0f,$07
; $00: . . . . . . . .
; $00: . . . . . . . .
; $1c: . . . # # # . .
; $1c: . . . # # # . .
; $1c: . . . # # # . .
; $1e: . . . # # # # .
; $0f: . . . . # # # #
; $07: . . . . . # # #

; Char $07:   '
	.BYTE $00,$18,$18,$18,$00,$00,$00,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $08:   (
	.BYTE $00,$0E,$18,$18,$18,$18,$0E,$00
; $00: . . . . . . . .
; $0E: . . . . # # # .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $0E: . . . . # # # .
; $00: . . . . . . . .
; Char $09:   )
	.BYTE $00,$70,$18,$18,$18,$18,$70,$00
; $00: . . . . . . . .
; $70: . # # # . . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $70: . # # # . . . .
; $00: . . . . . . . .
; Char $0A:   *
	.BYTE $DB,$24,$7E,$7E,$3C,$66,$63,$C1
; $DB: # # . # # . # #
; $24: . . # . . # . .
; $7E: . # # # # # # .
; $7E: . # # # # # # .
; $3C: . . # # # # . .
; $66: . # # . . # # .
; $63: . # # . . . # #
; $C1: # # . . . . . #

; Char $0B:   +
	.by $00,$00,$00,$00,$00,$00,$ff,$ff
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $ff: # # # # # # # #
; $ff: # # # # # # # #

; Char $0C:   ,
	.BYTE $00,$00,$00,$00,$00,$18,$18,$30
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $30: . . # # . . . .
; Char $0D:   -
	.BYTE $00,$00,$00,$7E,$00,$00,$00,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $0E:   .
	.BYTE $00,$00,$00,$00,$00,$18,$18,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $0F:   /
	.BYTE $00,$00,$00,$0C,$1E,$00,$00,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $0C: . . . . # # . .
; $1E: . . . # # # # .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $10:   0
	.BYTE $00,$7E,$66,$66,$66,$66,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $11:   1
	.BYTE $00,$18,$18,$18,$18,$18,$18,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $12:   2
	.BYTE $00,$7E,$06,$7E,$60,$60,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $13:   3
	.BYTE $00,$7E,$06,$1E,$06,$06,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $1E: . . . # # # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $14:   4
	.BYTE $00,$66,$66,$66,$7E,$06,$06,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $00: . . . . . . . .
; Char $15:   5
	.BYTE $00,$7E,$60,$7E,$06,$06,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $16:   6
	.BYTE $00,$7E,$60,$7E,$66,$66,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $17:   7
	.BYTE $00,$7E,$06,$06,$06,$06,$06,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $00: . . . . . . . .
; Char $18:   8
	.BYTE $00,$7E,$66,$7E,$66,$66,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $19:   9
	.BYTE $00,$7E,$66,$7E,$06,$06,$06,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $00: . . . . . . . .
; Char $1A:   :
	.BYTE $00,$00,$18,$18,$00,$18,$18,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $10: . . . # # . . .
; $10: . . . # # . . .
; $00: . . . . . . . .
; $10: . . . # # . . .
; $10: . . . # # . . .
; $00: . . . . . . . .
; Char $1B:   ;
	.BYTE $00,$30,$78,$00,$00,$00,$0E,$1F
; $00: . . . . . . . .
; $30: . . # # . . . .
; $78: . # # # # . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $0E: . . . . # # # .
; $1F: . . . # # # # #


; Char $1C:   <
	.BYTE $00,$00,$00,$00,$00,$03,$0C,$F0
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $03: . . . . . . # #
; $0C: . . . . # # . .
; $F0: # # # # . . . .


; Char $1D:   =
	.BYTE $00,$00,$7E,$00,$00,$7E,$00,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; $00: . . . . . . . .


; Char $1E:   >
	.BYTE $00,$00,$00,$00,$00,$c0,$30,$0F
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $c0: # # . . . . . .
; $30: . . # # . . . .
; $0F: . . . . # # # #


; Char $1F:   ?
	.BYTE $00,$3C,$66,$0C,$18,$00,$18,$00
; $00: . . . . . . . .
; $3C: . . # # # # . .
; $66: . # # . . # # .
; $0C: . . . . # # . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Page 0xE1.  Chars 32 to 63 -- Uppercase
; Char $20:   @
	.BYTE $00,$00,$10,$10,$00,$10,$10,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $10: . . . # . . . .
; $10: . . . # . . . .
; $00: . . . . . . . .
; $10: . . . # . . . .
; $10: . . . # . . . .
; $00: . . . . . . . .
; Char $21:   A
	.BYTE $00,$7E,$66,$7E,$66,$66,$66,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $22:   B
	.BYTE $00,$7E,$66,$7E,$66,$66,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $23:   C
	.BYTE $00,$7E,$60,$60,$60,$60,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $24:   D
	.BYTE $00,$7C,$66,$66,$66,$66,$7C,$00
; $00: . . . . . . . .
; $7C: . # # # # # . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7C: . # # # # # . .
; $00: . . . . . . . .
; Char $25:   E
	.BYTE $00,$7E,$60,$7C,$60,$60,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $7C: . # # # # # . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $26:   F
	.BYTE $00,$7E,$60,$7C,$60,$60,$60,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $7C: . # # # # # . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $00: . . . . . . . .
; Char $27:   G
	.BYTE $00,$7E,$60,$60,$66,$66,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $28:   H
	.BYTE $00,$66,$66,$7E,$66,$66,$66,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $29:   I
	.BYTE $00,$18,$18,$18,$18,$18,$18,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $2A:   J
	.BYTE $00,$06,$06,$06,$06,$06,$7E,$00
; $00: . . . . . . . .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $2B:   K
	.BYTE $00,$66,$66,$78,$78,$66,$66,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $78: . # # # # . . .
; $78: . # # # # . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $2C:   L
	.BYTE $00,$60,$60,$60,$60,$60,$7E,$00
; $00: . . . . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $2D:   M
	.BYTE $00,$66,$7E,$7E,$66,$66,$66,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $2E:   N
	.BYTE $00,$66,$76,$7E,$7E,$66,$66,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $76: . # # # . # # .
; $7E: . # # # # # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $2F:   O
	.BYTE $00,$7E,$66,$66,$66,$66,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $30:   P
	.BYTE $00,$7E,$66,$66,$7E,$60,$60,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $00: . . . . . . . .
; Char $31:   Q
	.BYTE $00,$7E,$66,$66,$66,$6C,$76,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $6C: . # # . # # . .
; $76: . # # # . # # .
; $00: . . . . . . . .
; Char $32:   R
	.BYTE $00,$7E,$66,$7E,$6C,$66,$66,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $6C: . # # . # # . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $33:   S
	.BYTE $00,$7E,$60,$7E,$06,$06,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $34:   T
	.BYTE $00,$7E,$18,$18,$18,$18,$18,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $35:   U
	.BYTE $00,$66,$66,$66,$66,$66,$7E,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $36:   V
	.BYTE $00,$66,$66,$66,$66,$66,$18,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $37:   W
	.BYTE $00,$66,$66,$66,$7E,$7E,$66,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $38:   X
	.BYTE $00,$66,$66,$18,$18,$66,$66,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $39:   Y
	.BYTE $00,$66,$66,$18,$18,$18,$18,$00
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $3A:   Z
	.BYTE $00,$7E,$06,$7E,$60,$60,$7E,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $3B:   [
	.BYTE $00,$2A,$20,$28,$20,$20,$20,$00
; $00: . . . . . . . .
; $2A: . . # . # . # .
; $20: . . # . . . . .
; $28: . . # . # . . .
; $20: . . # . . . . .
; $20: . . # . . . . .
; $20: . . # . . . . .
; $00: . . . . . . . .
; Char $3C:   \
	.BYTE $00,$00,$2A,$20,$2A,$02,$2A,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $2A: . . # . # . # .
; $20: . . # . . . . .
; $2A: . . # . # . # .
; $02: . . . . . . # .
; $2A: . . # . # . # .
; $00: . . . . . . . .
; Char $3D:   ]
	.BYTE $00,$00,$2A,$20,$22,$22,$2A,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $2A: . . # . # . # .
; $20: . . # . . . . .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $2A: . . # . # . # .
; $00: . . . . . . . .
; Char $3E:   ^
	.BYTE $00,$22,$22,$2A,$22,$22,$22,$00
; $00: . . . . . . . .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $2A: . . # . # . # .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $00: . . . . . . . .
; Char $3F:   _
	.BYTE $00,$00,$08,$08,$08,$08,$08,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $08: . . . . # . . .
; $08: . . . . # . . .
; $08: . . . . # . . .
; $08: . . . . # . . .
; $08: . . . . # . . .
; $00: . . . . . . . .
; Page 0xE2.  Chars 64 to 95 -- graphics control characters
; Char $40: ctrl-,
	.BYTE $00,$36,$7F,$7F,$3E,$1C,$08,$00
; $00: . . . . . . . .
; $36: . . # # . # # .
; $7F: . # # # # # # #
; $7F: . # # # # # # #
; $3E: . . # # # # # .
; $1C: . . . # # # . .
; $08: . . . . # . . .
; $00: . . . . . . . .
; Char $41: ctrl-A
	.BYTE $00,$00,$2A,$20,$20,$20,$2A,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $2A: . . # . # . # .
; $20: . . # . . . . .
; $20: . . # . . . . .
; $20: . . # . . . . .
; $2A: . . # . # . # .
; $00: . . . . . . . .
; Char $42: ctrl-B
	.BYTE $00,$00,$2A,$22,$22,$22,$2A,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $2A: . . # . # . # .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $2A: . . # . # . # .
; $00: . . . . . . . .
; Char $43: ctrl-C
	.BYTE $00,$00,$2A,$20,$20,$20,$20,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $2A: . . # . # . # .
; $20: . . # . . . . .
; $20: . . # . . . . .
; $20: . . # . . . . .
; $20: . . # . . . . .
; $00: . . . . . . . .
; Char $44: ctrl-D
	.BYTE $00,$00,$2A,$20,$28,$20,$2A,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $2A: . . # . # . # .
; $20: . . # . . . . .
; $28: . . # . # . . .
; $20: . . # . . . . .
; $2A: . . # . # . # .
; $00: . . . . . . . .
; Char $45: ctrl-E
	.BYTE $00,$00,$2A,$22,$2A,$22,$22,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $2A: . . # . # . # .
; $22: . . # . . . # .
; $2A: . . # . # . # .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $00: . . . . . . . .
; Char $46: ctrl-F
	.BYTE $0F,$0F,$0F,$0F,$F0,$F0,$F0,$F0
; $0F: . . . . # # # #
; $0F: . . . . # # # #
; $0F: . . . . # # # #
; $0F: . . . . # # # #
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; Char $47: ctrl-G
	.BYTE $C0,$E0,$70,$38,$1C,$0E,$07,$03
; $C0: # # . . . . . .
; $E0: # # # . . . . .
; $70: . # # # . . . .
; $38: . . # # # . . .
; $1C: . . . # # # . .
; $0E: . . . . # # # .
; $07: . . . . . # # #
; $03: . . . . . . # #
; Char $48: ctrl-H
	.BYTE $00,$00,$22,$22,$22,$22,$08,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $08: . . . . # . . .
; $00: . . . . . . . .
; Char $49: ctrl-I
	.BYTE $00,$00,$00,$00,$0F,$0F,$0F,$0F
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $0F: . . . . # # # #
; $0F: . . . . # # # #
; $0F: . . . . # # # #
; $0F: . . . . # # # #
; Char $4A: ctrl-J
	.BYTE $00,$00,$28,$22,$22,$22,$28,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $28: . . # . # . . .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $22: . . # . . . # .
; $28: . . # . # . . .
; $00: . . . . . . . .
; Char $4B: ctrl-K
	.BYTE $0F,$0F,$0F,$0F,$00,$00,$00,$00
; $0F: . . . . # # # #
; $0F: . . . . # # # #
; $0F: . . . . # # # #
; $0F: . . . . # # # #
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $4C: ctrl-L
	.BYTE $F0,$F0,$F0,$F0,$00,$00,$00,$00
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $4D: ctrl-M
	.BYTE $FF,$FF,$00,$00,$00,$00,$00,$00
; $FF: # # # # # # # #
; $FF: # # # # # # # #
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $4E: ctrl-N
	.BYTE $00,$00,$00,$00,$00,$00,$FF,$FF
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $FF: # # # # # # # #
; $FF: # # # # # # # #
; Char $4F: ctrl-O
	.BYTE $00,$00,$00,$00,$F0,$F0,$F0,$F0
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; Char $50: ctrl-P
	.BYTE $00,$2A,$20,$2A,$02,$02,$2A,$00
; $00: . . . . . . . .
; $2A: . . # . # . # .
; $20: . . # . . . . .
; $2A: . . # . # . # .
; $02: . . . . . . # .
; $02: . . . . . . # .
; $2A: . . # . # . # .
; $00: . . . . . . . .
; Char $51: ctrl-Q
	.BYTE $00,$00,$00,$1F,$1F,$18,$18,$18
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $1F: . . . # # # # #
; $1F: . . . # # # # #
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; Char $52: ctrl-R
	.BYTE $00,$00,$00,$FF,$FF,$00,$00,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $FF: # # # # # # # #
; $FF: # # # # # # # #
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $53: ctrl-S
	.BYTE $18,$18,$18,$FF,$FF,$18,$18,$18
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $FF: # # # # # # # #
; $FF: # # # # # # # #
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; Char $54: ctrl-T
	.BYTE $FF,$00,$00,$00,$00,$00,$00,$FF
; $FF: # # # # # # # #
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $FF: # # # # # # # #
; Char $55: ctrl-U
	.BYTE $00,$00,$00,$00,$FF,$FF,$FF,$FF
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $FF: # # # # # # # #
; $FF: # # # # # # # #
; $FF: # # # # # # # #
; $FF: # # # # # # # #
; Char $56: ctrl-V
	.BYTE $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
; $C0: # # . . . . . .
; $C0: # # . . . . . .
; $C0: # # . . . . . .
; $C0: # # . . . . . .
; $C0: # # . . . . . .
; $C0: # # . . . . . .
; $C0: # # . . . . . .
; $C0: # # . . . . . .
; Char $57: ctrl-W
	.BYTE $00,$00,$00,$FF,$FF,$18,$18,$18
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $FF: # # # # # # # #
; $FF: # # # # # # # #
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; Char $58: ctrl-X
	.BYTE $18,$18,$18,$FF,$FF,$00,$00,$00
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $FF: # # # # # # # #
; $FF: # # # # # # # #
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $59: ctrl-Y
	.BYTE $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; $F0: # # # # . . . .
; Char $5A: ctrl-Z
	.BYTE $18,$18,$18,$1F,$1F,$00,$00,$00
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $1F: . . . # # # # #
; $1F: . . . # # # # #
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $5B: ESCAPE
	.BYTE $78,$60,$78,$60,$7E,$18,$1E,$00
; $78: . # # # # . . .
; $60: . # # . . . . .
; $78: . # # # # . . .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $18: . . . # # . . .
; $1E: . . . # # # # .
; $00: . . . . . . . .
; Char $5C: UP
	.BYTE $00,$18,$3C,$7E,$18,$18,$18,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $3C: . . # # # # . .
; $7E: . # # # # # # .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $5D: DOWN
	.BYTE $00,$18,$18,$18,$7E,$3C,$18,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $7E: . # # # # # # .
; $3C: . . # # # # . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $5E: LEFT
	.BYTE $00,$18,$30,$7E,$30,$18,$00,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $30: . . # # . . . .
; $7E: . # # # # # # .
; $30: . . # # . . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Char $5F: RIGHT
	.BYTE $00,$18,$0C,$7E,$0C,$18,$00,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $0C: . . . . # # . .
; $7E: . # # # # # # .
; $0C: . . . . # # . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; Page 0xE3.  Chars 96 to 127 -- lowercase
; Char $60: ctrl-.
	.BYTE $00,$18,$3C,$7E,$7E,$3C,$18,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $3C: . . # # # # . .
; $7E: . # # # # # # .
; $7E: . # # # # # # .
; $3C: . . # # # # . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $61:   a
	.BYTE $00,$00,$7E,$66,$7E,$66,$66,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $62:   b
	.BYTE $00,$00,$7E,$66,$7E,$66,$7E,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $63:   c
	.BYTE $00,$00,$7C,$60,$60,$60,$7C,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7C: . # # # # # . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $7C: . # # # # # . .
; $00: . . . . . . . .
; Char $64:   d
	.BYTE $00,$00,$7C,$66,$66,$66,$7C,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7C: . # # # # # . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7C: . # # # # # . .
; $00: . . . . . . . .
; Char $65:   e
	.BYTE $00,$00,$7E,$60,$78,$60,$7E,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $78: . # # # # . . .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $66:   f
	.BYTE $00,$00,$7E,$60,$78,$60,$60,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $78: . # # # # . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $00: . . . . . . . .
; Char $67:   g
	.BYTE $00,$00,$7E,$60,$66,$66,$7E,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $68:   h
	.BYTE $00,$00,$66,$66,$7E,$66,$66,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $69:   i
	.BYTE $00,$00,$18,$18,$18,$18,$18,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $6A:   j
	.BYTE $00,$00,$06,$06,$06,$06,$7E,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $6B:   k
	.BYTE $00,$00,$66,$66,$78,$66,$66,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $78: . # # # # . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $6C:   l
	.BYTE $00,$00,$60,$60,$60,$60,$7E,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $6D:   m
	.BYTE $00,$00,$66,$7E,$7E,$66,$66,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $6E:   n
	.BYTE $00,$00,$7E,$66,$66,$66,$66,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $6F:   o
	.BYTE $00,$00,$7E,$66,$66,$66,$7E,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $70:   p
	.BYTE $00,$00,$7E,$66,$7E,$60,$60,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $00: . . . . . . . .
; Char $71:   q
	.BYTE $00,$00,$7E,$66,$7E,$06,$06,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $06: . . . . . # # .
; $00: . . . . . . . .
; Char $72:   r
	.BYTE $00,$00,$7E,$60,$60,$60,$60,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $60: . # # . . . . .
; $00: . . . . . . . .
; Char $73:   s
	.BYTE $00,$00,$7E,$60,$7E,$06,$7E,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $74:   t
	.BYTE $00,$00,$7E,$18,$18,$18,$18,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $75:   u
	.BYTE $00,$00,$66,$66,$66,$66,$7E,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $76:   v
	.BYTE $00,$00,$66,$66,$66,$66,$18,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $77:   w
	.BYTE $00,$00,$66,$66,$7E,$7E,$66,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $7E: . # # # # # # .
; $7E: . # # # # # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $78:   x
	.BYTE $00,$00,$66,$66,$18,$66,$66,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $18: . . . # # . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $00: . . . . . . . .
; Char $79:   y
	.BYTE $00,$00,$66,$66,$18,$18,$18,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $66: . # # . . # # .
; $66: . # # . . # # .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $00: . . . . . . . .
; Char $7A:   z
	.BYTE $00,$00,$7E,$06,$7E,$60,$7E,$00
; $00: . . . . . . . .
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $06: . . . . . # # .
; $7E: . # # # # # # .
; $60: . # # . . . . .
; $7E: . # # # # # # .
; $00: . . . . . . . .
; Char $7B: ctrl-;
	.BYTE $00,$18,$3C,$7E,$7E,$18,$3C,$00
; $00: . . . . . . . .
; $18: . . . # # . . .
; $3C: . . # # # # . .
; $7E: . # # # # # # .
; $7E: . # # # # # # .
; $18: . . . # # . . .
; $3C: . . # # # # . .
; $00: . . . . . . . .
; Char $7C:   |
	.BYTE $18,$18,$18,$18,$18,$18,$18,$18
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; $18: . . . # # . . .
; Char $7D: CLEAR
	.BYTE $00,$7E,$78,$7C,$6E,$66,$06,$00
; $00: . . . . . . . .
; $7E: . # # # # # # .
; $78: . # # # # . . .
; $7C: . # # # # # . .
; $6E: . # # . # # # .
; $66: . # # . . # # .
; $06: . . . . . # # .
; $00: . . . . . . . .
; Char $7E: DELETE
	.BYTE $00,$00,$00,$66,$BD,$FF,$44,$3C
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . . 
; $66: . # # . . # # .
; $BD: # . # # # # . #
; $FF: # # # # # # # #
; $44: . # # . . # # .
; $3C: . . # # # # . .
; Char $7F: TAB
	.BYTE $66,$BD,$FF,$44,$3C,$00,$00,$00
; $66: . # # . . # # .
; $BD: # . # # # # . #
; $FF: # # # # # # # #
; $44: . # # . . # # .
; $3C: . . # # # # . .
; $00: . . . . . . . .
; $00: . . . . . . . .
; $00: . . . . . . . . 
; Old Frog
;	.BYTE $E7,$BD,$FF,$7E,$18,$3C,$66,$E7
;; $E7: # # # . . # # #
;; $BD: # . # # # # . #
;; $FF: # # # # # # # #
;; $7E: . # # # # # # .
;; $18: . . . # # . . .
;; $3C: . . # # # # . .
;; $66: . # # . . # # .
;; $E7: # # # . . # # #



; Here we reached the end of the 1K for the Character set, so the rest of this is a new page...

LEFT_BOAT_FRONT_ANIM ; 2 images, each used 4 times with one frame from LEFT_BOAT_WATER_ANIM (16 bytes)


LEFT_BOAT_WATER_ANIM ; 8 frames, water waves at the front of the boat. (64 bytes)


LEFT_BOAT_WAKE_ANIM ; 8 Frames, water behind the engines. (frame 2 == frame 6) (56 bytes)


RIGHT_BOAT_FRONT_ANIM ; 2 images, each used 4 times with one frame from RIGHT_BOAT_WATER_ANIM (16 bytes)


RIGHT_BOAT_WATER_ANIM ; 8 frames, water waves at the front of the boat. (64 bytes)


RIGHT_BOAT_WAKE_ANIM ; 8 Frames, water behind the engines. (frame 2 == frame 6) (56 bytes)

