#!/usr/bin/tclsh

source ./board.tcl

set board::columnCount 12
set board::rowCount 9
board::initBoard

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

	::report::report matrixReport $board::columnCount style simpletable
}

for {set x 0} {$x < 10} {incr x} {
	set randTile [board::pickRandomTile]
	board::placeTile [dict get $randTile x] [dict get $randTile y]
}

createMatrixReport
puts [matrixReport printmatrix board::board]
puts [matrixReport printmatrix board::tiles]
