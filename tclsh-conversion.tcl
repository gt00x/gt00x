#!/usr/bin/env tclsh

set f [open "COMMS.log" r]
while {[gets $f line] >= 0} {
    set fields [split $line " "]
    set datetime [lindex $fields 0]
    set rest [lrange $fields 1 end]

    set datetime_fields [split $datetime "."]
    set year [lindex $datetime_fields 0]
    set doy [lindex $datetime_fields 1]
    set hour [lindex $datetime_fields 2]
    set minute [lindex $datetime_fields 3]
    set second [lindex $datetime_fields 4]
    set ms [lindex $datetime_fields 5]

    set t [clock scan "$year $doy $hour:$minute:$second" -format "%y %j %H:%M:%S" -base [clock seconds]]
    set timestamp [clock format $t -format "%Y-%m-%d %H:%M:%S.$ms"]
    puts "$timestamp [join $rest]"
}
close $f
