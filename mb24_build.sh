#!/bin/sh
# Copyright 2024 Jean-Baptiste M. "JBQ" "Djaybee" Queru
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# As an added restriction, if you make the program available for
# third parties to use on hardware you own (or co-own, lease, rent,
# or otherwise control,) such as public gaming cabinets (whether or
# not in a gaming arcade, whether or not coin-operated or otherwise
# for a fee,) the conditions of section 13 will apply even if no
# network is involved.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: AGPL-3.0-or-later

mkdir -p tmp

cc mb24_vcurves.c -o tmp/mb24_vcurves -lm
tmp/mb24_vcurves > tmp/mb24_vcurves-st_rmac.s

cc mb24_hcurves.c -o tmp/mb24_hcurves -lm
tmp/mb24_hcurves > tmp/mb24_hcurves-st_rmac.s

cc mb24_scurves.c -o tmp/mb24_scurves -lm
tmp/mb24_scurves > tmp/mb24_scurves-st_rmac.s

cc mb24_lcurves.c -o tmp/mb24_lcurves -lm
tmp/mb24_lcurves > tmp/mb24_lcurves-st_rmac.s

cc mb24_vconvert.c -o tmp/mb24_vconvert
tmp/mb24_vconvert

cc mb24_hconvert.c -o tmp/mb24_hconvert
tmp/mb24_hconvert > tmp/mb24_hfont-st_rmac.s

cc mb24_sconvert.c -o tmp/mb24_sconvert
tmp/mb24_sconvert

cc mb24_lconvert.c -o tmp/mb24_lconvert
tmp/mb24_lconvert


mkdir -p out

~/code/rmac/rmac -s -v -p -4 mb24_main-st_rmac.s -o out/MB24.PRG
