package require comm

namespace eval communicate {}

set state 0

puts [::comm::comm config -port]

puts "what is the port number of the other guy?"
set otherport [gets stdin]

::comm::comm send $otherport puts ok
while {1} {
	#doing stuff.

}

