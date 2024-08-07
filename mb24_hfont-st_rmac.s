; Copyright 2024 Jean-Baptiste M. "JBQ" "Djaybee" Queru
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU Affero General Public License as
; published by the Free Software Foundation, either version 3 of the
; License, or (at your option) any later version.
;
; As an added restriction, if you make the program available for
; third parties to use on hardware you own (or co-own, lease, rent,
; or otherwise control,) such as public gaming cabinets (whether or
; not in a gaming arcade, whether or not coin-operated or otherwise
; for a fee,) the conditions of section 13 will apply even if no
; network is involved.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
; GNU Affero General Public License for more details.
;
; You should have received a copy of the GNU Affero General Public License
; along with this program. If not, see <https://www.gnu.org/licenses/>.
;
; SPDX-License-Identifier: AGPL-3.0-or-later

; Coding style:
;	- ASCII
;	- hard tabs, 8 characters wide, except in ASCII art
;	- 120 columns overall
;	- Standalone block comments in the first 80 columns
;	- Code-related block comments allowed in the last 80 columns
;	- Note: rulers at 40, 80 and 120 columns help with source width
;
;	- Assembler directives are .lowercase
;	- Mnemomics and registers are lowercase unless otherwise required
;	- Global symbols for code are CamelCase
;	- Symbols for variables are snake_case
;	- Symbols for hardware registers are ALL_CAPS
;	- Related symbols start with the same prefix (so they sort together)
;	- hexadecimal constants are lowercase ($eaf00d).
;
;	- Include but comment out instructions that help readability but
;		don't do anything (e.g. redundant CLC on 6502 when the carry is
;		guaranteed already to be clear). The comment symbol should be
;		where the instruction would be, i.e. not on the first column.
;		There should be an explanation in a comment.
;	- Use the full instruction mnemonic when a shortcut would potentially
;		cause confusion. E.g. use movea instead of move on 680x0 when
;		the code relies on the flags not getting modified.

	.data
	.even
HorizChars:
	dc.l	Horiz32, Horiz33, Horiz34, Horiz39, Horiz39, Horiz39, Horiz39, Horiz39
	dc.l	Horiz40, Horiz41, Horiz44, Horiz44, Horiz44, Horiz45, Horiz46, Horiz47
	dc.l	Horiz48, Horiz49, Horiz50, Horiz51, Horiz52, Horiz53, Horiz54, Horiz55
	dc.l	Horiz56, Horiz57, Horiz58, Horiz63, Horiz63, Horiz63, Horiz63, Horiz63
	dc.l	Horiz64, Horiz65, Horiz66, Horiz67, Horiz68, Horiz69, Horiz70, Horiz71
	dc.l	Horiz72, Horiz73, Horiz74, Horiz75, Horiz76, Horiz77, Horiz78, Horiz79
	dc.l	Horiz80, Horiz81, Horiz82, Horiz83, Horiz84, Horiz85, Horiz86, Horiz87
	dc.l	Horiz88, Horiz89, Horiz90, HorizEnd

HorizFont:
; 32 space
Horiz32:
	dc.w	0
	dc.w	0
	dc.w	0
	dc.w	0

; 33 !
Horiz33:
	dc.w	%110111111
	dc.w	%110111111

	dc.w	0

; 34 "
Horiz34:
	dc.w	%000000111
	dc.w	%000000000
	dc.w	%000000111

	dc.w	0

; 39 '
Horiz39:
	dc.w	%000000100
	dc.w	%000000111
	dc.w	%000000011

	dc.w	0

; 40 (
Horiz40:
	dc.w	%001111100
	dc.w	%011111110
	dc.w	%110000011
	dc.w	%100000001

	dc.w	0

; 41 )
Horiz41:
	dc.w	%100000001
	dc.w	%110000011
	dc.w	%011111110
	dc.w	%001111100

	dc.w	0

; 44 ,
Horiz44:
	dc.w	%100000000
	dc.w	%111000000
	dc.w	%011000000

	dc.w	0

; 45 -
Horiz45:
	dc.w	%000010000
	dc.w	%000010000
	dc.w	%000010000
	dc.w	%000010000
	dc.w	%000010000

	dc.w	0

; 46 .
Horiz46:
	dc.w	%110000000
	dc.w	%110000000

	dc.w	0

; 47 /
Horiz47:
	dc.w	%111000000
	dc.w	%111111000
	dc.w	%000111111
	dc.w	%000000111

	dc.w	0

; 48 0
Horiz48:
	dc.w	%001111100
	dc.w	%011111110
	dc.w	%110000011
	dc.w	%100000001
	dc.w	%110000011
	dc.w	%011111110
	dc.w	%001111100

	dc.w	0

; 49 1
Horiz49:
	dc.w	%000000010
	dc.w	%111111111
	dc.w	%111111111

	dc.w	0

; 50 2
Horiz50:
	dc.w	%111000010
	dc.w	%111100011
	dc.w	%100110001
	dc.w	%100010001
	dc.w	%100011111
	dc.w	%100001110

	dc.w	0

; 51 3
Horiz51:
	dc.w	%010000010
	dc.w	%110000011
	dc.w	%100000001
	dc.w	%100010001
	dc.w	%111111111
	dc.w	%011101110

	dc.w	0

; 52 4
Horiz52:
	dc.w	%000011111
	dc.w	%000011111
	dc.w	%000010000
	dc.w	%000010000
	dc.w	%111111111
	dc.w	%111111111

	dc.w	0

; 53 5
Horiz53:
	dc.w	%010011111
	dc.w	%110011111
	dc.w	%100010001
	dc.w	%100010001
	dc.w	%111110001
	dc.w	%011100001

	dc.w	0

; 54 6
Horiz54:
	dc.w	%011111110
	dc.w	%111111111
	dc.w	%100010001
	dc.w	%100010001
	dc.w	%111110011
	dc.w	%011100010

	dc.w	0

; 55 7
Horiz55:
	dc.w	%000000001
	dc.w	%000000001
	dc.w	%111100001
	dc.w	%111111001
	dc.w	%000011111
	dc.w	%000000111

	dc.w	0

; 56 8
Horiz56:
	dc.w	%011101110
	dc.w	%111111111
	dc.w	%100010001
	dc.w	%100010001
	dc.w	%111111111
	dc.w	%011101110

	dc.w	0

; 57 9
Horiz57:
	dc.w	%010001110
	dc.w	%110011111
	dc.w	%100010001
	dc.w	%100010001
	dc.w	%111111111
	dc.w	%011111110

	dc.w	0

; 58 :
Horiz58:
	dc.w	%001101100
	dc.w	%001101100

	dc.w	0

; 63 ?
Horiz63:
	dc.w	%000000110
	dc.w	%000000111
	dc.w	%110110001
	dc.w	%110111001
	dc.w	%000001111
	dc.w	%000000110

	dc.w	0

; 64 @
Horiz64:
	dc.w	%011111110
	dc.w	%111111111
	dc.w	%100000001
	dc.w	%100111001
	dc.w	%101111101
	dc.w	%101000101
	dc.w	%101111111
	dc.w	%001111110

	dc.w	0

; 65 A
Horiz65:
	dc.w	%111111110
	dc.w	%111111111
	dc.w	%000010001
	dc.w	%000010001
	dc.w	%111111111
	dc.w	%111111110

	dc.w	0

; 66 B
Horiz66:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%100010001
	dc.w	%100010001
	dc.w	%111111111
	dc.w	%011101110

	dc.w	0

; 67 C
Horiz67:
	dc.w	%011111110
	dc.w	%111111111
	dc.w	%100000001
	dc.w	%100000001
	dc.w	%110000011
	dc.w	%010000010

	dc.w	0

; 68 D
Horiz68:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%100000001
	dc.w	%100000001
	dc.w	%111111111
	dc.w	%011111110

	dc.w	0

; 69 E
Horiz69:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%100010001
	dc.w	%100010001
	dc.w	%100010001
	dc.w	%100000001

	dc.w	0

; 70 F
Horiz70:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%000010001
	dc.w	%000010001
	dc.w	%000010001
	dc.w	%000000001

	dc.w	0

; 71 G
Horiz71:
	dc.w	%011111110
	dc.w	%111111111
	dc.w	%100000001
	dc.w	%100010001
	dc.w	%111110011
	dc.w	%011110010

	dc.w	0

; 72 H
Horiz72:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%000010000
	dc.w	%000010000
	dc.w	%111111111
	dc.w	%111111111

	dc.w	0

; 73 I
Horiz73:
	dc.w	%111111111
	dc.w	%111111111

	dc.w	0

; 74 J
Horiz74:
	dc.w	%011000000
	dc.w	%111000000
	dc.w	%100000000
	dc.w	%100000000
	dc.w	%111111111
	dc.w	%011111111

	dc.w	0

; 75 K
Horiz75:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%000111000
	dc.w	%001101100
	dc.w	%011000110
	dc.w	%110000011
	dc.w	%100000001

	dc.w	0

; 76 L
Horiz76:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%100000000
	dc.w	%100000000
	dc.w	%100000000
	dc.w	%100000000

	dc.w	0

; 77 M
Horiz77:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%000000110
	dc.w	%000001100
	dc.w	%000000110
	dc.w	%111111111
	dc.w	%111111111

	dc.w	0

; 78 N
Horiz78:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%000001100
	dc.w	%000011000
	dc.w	%111111111
	dc.w	%111111111

	dc.w	0

; 79 O
Horiz79:
	dc.w	%011111110
	dc.w	%111111111
	dc.w	%100000001
	dc.w	%100000001
	dc.w	%111111111
	dc.w	%011111110

	dc.w	0

; 80 P
Horiz80:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%000010001
	dc.w	%000010001
	dc.w	%000011111
	dc.w	%000001110

	dc.w	0

; 81 Q
Horiz81:
	dc.w	%011111110
	dc.w	%111111111
	dc.w	%100000001
	dc.w	%101000001
	dc.w	%111000001
	dc.w	%110111111
	dc.w	%111111110

	dc.w	0

; 82 R
Horiz82:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%000010001
	dc.w	%000010001
	dc.w	%111111111
	dc.w	%111101110

	dc.w	0

; 83 S
Horiz83:
	dc.w	%010001110
	dc.w	%110011111
	dc.w	%100010001
	dc.w	%100010001
	dc.w	%111110011
	dc.w	%011100010

	dc.w	0

; 84 T
Horiz84:
	dc.w	%000000001
	dc.w	%000000001
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%000000001
	dc.w	%000000001

	dc.w	0

; 85 U
Horiz85:
	dc.w	%011111111
	dc.w	%111111111
	dc.w	%100000000
	dc.w	%100000000
	dc.w	%111111111
	dc.w	%011111111

	dc.w	0

; 86 V
Horiz86:
	dc.w	%000111111
	dc.w	%001111111
	dc.w	%011000000
	dc.w	%110000000
	dc.w	%011000000
	dc.w	%001111111
	dc.w	%000111111

	dc.w	0

; 87 W
Horiz87:
	dc.w	%111111111
	dc.w	%111111111
	dc.w	%011000000
	dc.w	%001100000
	dc.w	%011000000
	dc.w	%111111111
	dc.w	%111111111

	dc.w	0

; 88 X
Horiz88:
	dc.w	%111101111
	dc.w	%111111111
	dc.w	%000010000
	dc.w	%000010000
	dc.w	%111111111
	dc.w	%111101111

	dc.w	0
; 89 Y
Horiz89:
	dc.w	%000001111
	dc.w	%000011111
	dc.w	%111110000
	dc.w	%111110000
	dc.w	%000011111
	dc.w	%000001111

	dc.w	0

; 90 Z
Horiz90:
	dc.w	%111000001
	dc.w	%111100001
	dc.w	%100110001
	dc.w	%100011001
	dc.w	%100001111
	dc.w	%100000111

	dc.w	0

HorizEnd:
	dc.w	0
