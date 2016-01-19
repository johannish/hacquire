package require struct::matrix
package require report

namespace eval board {
	variable columnCount 0
	variable rowCount 0
}

proc board::initBoard {} {
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

proc board::placeTile {x_cord y_cord} {
	set x [expr $x_cord]
	set y [expr $y_cord]
	board set cell $x $y o
}

proc board::pickRandomTile {} {
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

# reset
# setup
# configure
# start
