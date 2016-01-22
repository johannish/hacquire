#! /bin/env tclsh
package require comm


proc main {argv0 argv} {
	set talkto "test.tcl"
	set callto "title"
	lassign [chan pipe] pr pw
	exec [info nameofexecutable]  [file dirname [info script]]/$talkto >@$pw &
	close $pw
	set data [gets $pr]
	set controlport [dict get $data port]
	puts $data
	::comm::comm send $controlport puts a
	puts [::comm::comm send $controlport $callto]
}
main $argv0 $argv
