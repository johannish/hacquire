#!/usr/bin/tclsh

package require struct::matrix
package require report


variable columnCount 12
variable rowCount 9

proc initBoard {} {
	variable rowCount
	variable columnCount

	::struct::matrix tiles
	tiles add rows $rowCount
	tiles add columns $columnCount

	for {set y 0} {$y < $rowCount} {incr y} {
		for {set x 0} {$x < $columnCount} {incr x} {
			tiles set cell $x $y o
		}
	}

	::struct::matrix board
	board add rows $rowCount
	board add columns $columnCount
}

proc placeTile {x_cord y_cord} {
	set x [expr $x_cord -1]
	set y [expr $y_cord -1]
	board set cell $x $y o
}

proc pickRandomTile {} {
	variable rowCount
	variable columnCount

	while {1} {
		# This method of using rand is inclusive of the lower bounds but not the upper (the multiplier).
		set rand_x [expr { int(rand() * ($columnCount)) }]
		set rand_y [expr { int(rand() * ($rowCount)) }]

		set tile [tiles get cell $rand_x $rand_y]
		if {$tile eq {o}} {
			tiles set cell $rand_x $rand_y {}
			return [dict create x $rand_x y $rand_y]
		}
	}
}

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

	::report::report matrixReport $columnCount style simpletable
}

initBoard
for {set x 0} {$x < 10} {incr x} {
	set randTile [pickRandomTile]
	placeTile [dict get $randTile x] [dict get $randTile y]
}
createMatrixReport
puts [matrixReport printmatrix board]
puts [matrixReport printmatrix tiles]
