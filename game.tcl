namespace eval game {
	source ./board.tcl
}

proc game::reset {} {
}

proc game::setup {playerCount} {
	set board::columnCount 12
	set board::rowCount 9
	board::initBoard
}

proc game::start {} {
}
