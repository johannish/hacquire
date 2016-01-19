#!/usr/bin/tclsh

package require struct::matrix
package require report


variable columnCount 12
variable rowCount 9

proc initBoard {} {
	::struct::matrix tiles
	variable rowCount
	variable columnCount

	for {set y 0} {$y < $rowCount} {incr y} {
		tiles add row $y
		for {set x 0} {$x < $columnCount} {incr x} {
			tiles add column $x
		}
	}

	::struct::matrix board
	board add rows $rowCount
	board add columns $columnCount
}

proc placeTile {x_cord y_cord} {
	set x [expr $x_cord -1]
	set y [expr $y_cord -1]
	board set cell $x $y h
}

proc formatBoard {matrix} {
	variable columnCount

	::report::defstyle simpletable {} {
		data	set [split "[string repeat "| "   [columns]]|"]
		top	set [split "[string repeat "+ - " [columns]]+"]
		bottom	set [top get]
		top	enable
		bottom	enable
	}

	::report::report r $columnCount style simpletable
	r printmatrix $matrix
}

initBoard
placeTile 12 1
placeTile 5 9
puts [formatBoard board]
