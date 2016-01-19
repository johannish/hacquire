#! /bin/env tclsh

package require comm
namespace import ::comm::comm
puts [list port [comm configure -port]]
flush stdout



proc tile {} {
	return 1.1
}

vwait forever
