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
createMatrixReport
puts [matrixReport printmatrix board]
puts [matrixReport printmatrix tiles]
