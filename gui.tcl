#! /bin/env tclsh

package require Tk
package require comm
namespace import ::comm::comm

proc hand {master args} {
	set name [namespace current]::[info cmdcount]
	namespace eval $name {
		proc init {master args} {
			variable
		}
		set master 
	}
	$name init
	return $name
}

proc acquire {master args} {
	set name [namespace current]::[info cmdcount]
	namespace eval $name {
		namespace export *
		namespace ensemble create

		proc tag w {
			if {[namespace current] ni [bindtags $w]} {
				bindtags $w [linsert [bindtags $w] 1 [namespace current]]
			}
		}

		proc board master {
			variable state
			lassign [dict get $state board] x y
			for {set i 0} {$i < $x} {incr i} {
				for {set j 0} {$j < $y} {incr j}  {
					label $master.board$i$j -bg yellow -text $i.$j
					tag $master.board$i$j
					grid $master.board$i$j -column $i -row $j
				}
			}
		}
		proc init {master args} {
			variable state [dict merge [set [namespace parent]::state] $args]
			set board [frame $master.board]
			pack $board 
			set hand [frame $master.hand]
			board $board 
		}
	}
	$name init $master
	return $name
}

variable state {
	board {4 8}
	players {}
}


proc controller {} {
	namespace eval controller {
		namespace export *
		namespace ensemble create

	}
	return [namesapce current]::controller
}

proc main {argv0 argv} {
	dict update argv controlport controlport  {}
	puts [list hey!]
	set tile [comm send $controlport tile] 
	puts [list got tile $tile]

	#frame .a1
	#pack .a1
	#acquire .a1 board {12 12}
}

main $argv0 $argv

