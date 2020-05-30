;----------------------------------------------------------
;		GAMEHUT SHELL
;		BY JON BURTON - FEB 2018
;----------------------------------------------------------
		INCLUDE	system.s		;INCLUDES LOTS OF SYSTEM CODE TO MAKE ALL THIS POSSIBLE

;----------------------------------------------------------
;		VRAM MEMORY MAP IN HEXADECIMAL
;		(NOTE: CHARACTERS ARE 8 X 8 PIXEL BLOCKS)
;----------------------------------------------------------
;		$0000-$0020			BLANK CHARACTER 0 - 32
;		$0020-$8000			CHARACTERS FOR PLAYFIELDS AND SPRITES 2^15 - 32 = 0x8000 = 32736
;                           Jumps 0xC000 - 0x8000 = 0x4000 = 2^14 = 16384
;		$C000-$D000			CHARACTER MAP FOR PLAYFIELD 1 (4096 BYTES)
;		$E000-$F000			CHARACTER MAP FOR PLAYFIELD 2 (4096 BYTES)

;----------------------------------------------------------
;		USER VARIABLES
;		- PUT ANY VARIABLES YOU NEED HERE
;----------------------------------------------------------
		RSSET	USERRAM
PLAYX:		RS.L	0
PLAY1X:		RS.W	1			;X POSITION OF PLAYFIELD 1
PLAY2X:		RS.W	1			;X POSITION OF PLAYFIELD 2
PLAYY:		RS.L	0
PLAY1Y:		RS.W	1			;Y POSITION OF PLAYFIELD 1
PLAY2Y:		RS.W	1			;Y POSITION OF PLAYFIELD 2
TEMPSCREEN:	RS.B	4096			;RAM TO BUILD TEMPORARY SCREEN MAP
ENDVARS:	RS.B	0

;----------------------------------------------------------
;		INITIALISE USER STUFF
;		- THIS IS WHERE YOU SET UP STUFF BEFORE YOU BEGIN
;----------------------------------------------------------
USERINIT:	MOVE.W	#0,PLAY1X		;SET START PLAYFIELD 1 X POSITION TO ZERO
		MOVE.W	#0,PLAY1Y		;SET START PLAYFIELD 1 Y POSITION TO ZERO

		DMADUMP	GRAPHICS,4*32,$20	;DUMP 4 CHARACTERS (SIZE 32 BYTES EACH) TO VRAM LOCATION $20 (HEXADECIMAL)

		LEA.L	TEMPSCREEN,A0		;POINT A0 TO TEMPORARY BUFFER IN RAM TO BUILD MAP BEFORE WE COPY TO VRAM
		MOVE.W	#8-1,D3			;WE'LL MAKE 8 COPIES OF THIS PATTERN
@L4:		LEA.L	CHARGFX,A1		;POINT A1 TO CHARGFX, WHICH IS THE 8 CHARACTER X 4 CHARACTER PATTERN WE'LL COPY MULITPLE TIMES
		MOVE.W	#4-1,D1			;4 ROWS
@L3:		MOVE.W	#8-1,D0			;COPY EACH ROW REPEATED ACROSS THE SCREEN 8 TIMES HORIZONTALLY
@L2:		MOVE.W	#4-1,D2			;4 LONG-WORDS = 8 CHARACTERS WIDE
@L1:		MOVE.L	(A1)+,(A0)+		;COPY FROM CHARGFX TO THE TEMPSCREEN. THE + MEANS INCREMENT THE POINTERS
		DBRA	D2,@L1			;LOOP BACK TO @L1
		SUB.L	#16,A1			;POINT BACK TO THE START OF THE CURRENT CHARGFX ROW
		DBRA	D0,@L2			;LOOP BACK TO @L2
		ADD.L	#16,A1			;MOVE ONTO THE NEXT CHARGFX ROW
		DBRA	D1,@L3			;LOOP BACK TO @L3
		DBRA	D3,@L4			;LOOP BACK TO @L4

		DMADUMP	TEMPSCREEN,4096,$C000	;COPY TEMPSCREEN WHICH IS 4096 BYTES IN SIZE TO VRAM ADDRESS $C000

		LEA.L	PALETTE1,A0		;DOWNLOAD A PALETTE FOR THE MAP TO USE
		BSR	SETPAL1			;OVERRIGHT FIRST PALETTE
		JSR	DUMPCOLS		;COPY PALETTES TO CRAM (COLOUR RAM)

		RTS

;------------------------------
;	MAIN GAME LOOP
;------------------------------
MAIN:		WAITVBI				;WAITS FOR THE START OF THE NEXT FRAME
		ADD.W	#1,PLAY1X		;SCROLL PLAYFIELD 1 RIGHT BY ONE PIXEL
		ADD.W	#1,PLAY1Y		;SCROLL PLAYFIELD 1 UP BY ONE PIXEL
		BRA	MAIN			;LOOP BACK TO WAIT FOR NEXT FRAME

;----------------------------------------------------------
;		USER VBI ROUTINES
;		- PUT TIME CRITICAL CODE THAT MUST CALLED DURING THE VERTICAL BLANK HERE
;----------------------------------------------------------
USERVBI:	LEA.L	VDP_DATA,A1
		LEA.L	VDP_CONTROL,A2
;SET HORIZONTAL OFFSETS
		MOVE.L	#$7C000003,(A2)
		MOVE.L	PLAYX,(A1)		;THIS TELLS THE VDP (VISUAL DISPLAY PROCESSOR) WHAT X POSITION THE PLAYFIELDS SHOULD BE AT

;SET VERTICAL OFFSETS
		MOVE.L	#$40000010,(A2)		;THIS TELLS THE VDP WHAT Y POSITION THE PLAYFIELDS SHOULD BE AT
		MOVE.L	PLAYY,(A1)
;READ JOYPAD
		BSR	READJOY			;READ THE JOYPAD

		RTS

;----------------------------------------------------------
;		PUT DATA BELOW HERE
;----------------------------------------------------------

;----------------------------------------------------------
;		CHARACTER CODES TO BUILD OUR PATTERN
;
;		THE CODE IS IN THE FORMAT $NNNN
;
;		THE LAST TWO NUMBERS ($00NN) REFER TO THE CHARACTER NUMBER IN VRAM TO USE
;		(THE CHARACTER NUMBER IS THE VRAM ADDRESS DIVIDED BY 32 (OR DIVIDED BY $20 HEXADECIMAL))
;
;		IF THE FIRST NUMBER  ($N000) IS '1' IT MEANS MIRROR THE CHARACTER VERTICALLY
;		IF THE SECOND NUMBER ($0N00) IS '8' IT MEANS MIRROR THE CHARACTER HORIZONTALLY
;
;		SO WHEN WE HAVE A DIAGONAL CHARACTER LINE THIS - / WE CAN MIRROR IT TO GET THIS \
;		SO WE CAN BUILD THIS - /\
;				       \/   USING ONE DIAGONAL AND MIRRORING
;----------------------------------------------------------
CHARGFX:	DC.W	$0003,$0004,$0001,$0001,$0801,$0801,$0804,$0803
		DC.W	$0002,$0002,$0003,$0004,$0804,$0803,$0802,$0802
		DC.W	$1002,$1002,$1003,$1004,$1804,$1803,$1802,$1802
		DC.W	$1003,$1004,$1001,$1001,$1801,$1801,$1804,$1803

;----------------------------------------------------------
;		CHARACTER GRAPHICS
;----------------------------------------------------------
GRAPHICS:	DC.B	$66,$66,$66,$66		;01	FULL CHARACTER USING COLOUR 6
		DC.B	$66,$66,$66,$66
		DC.B	$66,$66,$66,$66
		DC.B	$66,$66,$66,$66
		DC.B	$66,$66,$66,$66
		DC.B	$66,$66,$66,$66
		DC.B	$66,$66,$66,$66
		DC.B	$66,$66,$66,$66

		DC.B	$77,$77,$77,$77		;02	FULL CHARACTER USING COLOUR 7
		DC.B	$77,$77,$77,$77
		DC.B	$77,$77,$77,$77
		DC.B	$77,$77,$77,$77
		DC.B	$77,$77,$77,$77
		DC.B	$77,$77,$77,$77
		DC.B	$77,$77,$77,$77
		DC.B	$77,$77,$77,$77

		DC.B	$FF,$66,$66,$66		;03	HALF OF THE DIAGONAL LINE
		DC.B	$77,$FF,$66,$66
		DC.B	$77,$77,$FF,$66
		DC.B	$77,$77,$77,$FF
		DC.B	$77,$77,$77,$77
		DC.B	$77,$77,$77,$77
		DC.B	$77,$77,$77,$77
		DC.B	$77,$77,$77,$77

		DC.B	$66,$66,$66,$66		;04	OTHER HALF OF THE DIAGONAL LINE
		DC.B	$66,$66,$66,$66
		DC.B	$66,$66,$66,$66
		DC.B	$66,$66,$66,$66
		DC.B	$FF,$66,$66,$66
		DC.B	$77,$FF,$66,$66
		DC.B	$77,$77,$FF,$66
		DC.B	$77,$77,$77,$FF

;----------------------------------------------------------
;		USER PALETTES
;----------------------------------------------------------
PALETTE1:	DC.W	$0000,$0044,$0066,$0088
		DC.W	$00AA,$00EE
		DC.W	$0888,$0F00		;THESE TWO ARE THE ONES WE USE FOR THE TWO TILE COLOURS
		DC.W	$0EEE,$0CCC,$0AAA,$0888
		DC.W	$0666,$0444,$0222,$0000
