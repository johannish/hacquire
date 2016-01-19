#!/usr/bin/tclsh

package require report

source ./game.tcl

game::setup 0 

proc createMatrixReport {} {
	variable columnCount

	if {[lsearch [::report::styles] simpletable] < 0} {
		::report::defstyle simpletable {} {
			data	set [split "[string repeat "| "   [columns]]|"]
			top	set [split "[string repeat "+ - " [columns]]+"]
			bottom	set [top get]
			top	enable
			bottom	enable
		}
	}

	::report::report matrixReport $game::board::columnCount style simpletable
}

for {set x 0} {$x < 10} {incr x} {
	set randTile [game::board::pickRandomTile]
	game::board::placeTile [dict get $randTile x] [dict get $randTile y]
}

createMatrixReport
puts [matrixReport printmatrix game::board::board]
puts [matrixReport printmatrix game::board::tiles]
