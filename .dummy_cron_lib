######################################################################
#
# This file/function can be used to do certain stuff on/to the link...
# For example: Double check to se if the ISDN card is working,
#              Trigger mail delivering
# If you want to use this function, just add a comment on the line that
# says: 'return(0);'...
#
sub verify_link {
    return(0);

    # Just check that a signal can go through to the other side...
    # (our card is a little buggy, so it crashes once every now and then)
    if(system("/bin/ping -c 2 $cf{'REM_ADDR'} 2> /dev/null > /dev/null")) {
	# Ping returned a positive value, which means it could not find the
	# other end...
	&logg(1, "HANGUP: Link have crashed (again!), hanging up...\n");

	if( $cf{'PROTOCOL'} eq 'isdn' ) {
	    system("/usr/sbin/isdnctrl hangup ippp0");
	} else {
	    # Can't remember how we hangup a PPP...
	}
    }
}

1;
