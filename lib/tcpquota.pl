# $Header: /usr/lib/cvs/root/tcpquota/lib/tcpquota.pl,v 1.57 1998/09/19 01:50:22 turbo Exp $
#
# $Log: tcpquota.pl,v $
# Revision 1.57  1998/09/19 01:50:22  turbo
# * Could not get the '$sth->errstr' to work, but found that it wasn't needed
#   anyway, so removed...
# * Just make sure the 'name' variable contains a value, before we try to do
#   a 'gethostbyname' on it...
#
# Revision 1.56  1998/09/03 01:25:42  turbo
# Fixed some 'ne/eq' bugs regarding the feching from the database (also don't
# prepare the same statement twice, no need to).
#
# Revision 1.55  1998/08/02 17:57:50  turbo
# * Removed the PORT variable, the port is in the SERVER variable...
# * Better spaced debug output when loading the config file, also a 'done'
#   line at the end...
# * On papadoc, when I'm running screen/X, I get the host address ':0:S.0',
#   instead of 'papadoc.nocrew.org:0:S.0'... Take this into account, hopfully
#   it woun't break any thing else...
# * Try to find the address to the 'ut_host' instead of the 'ut_addr'... Hmmm..
#   Wonder how/why i tried to find a address, when I already have one... :)
#
# Revision 1.54  1998/08/01 19:59:41  turbo
# * First quick port to use the generic database interface 'DBI' instead of
#   the 'Msql' interface. This is so that we can go from using mSQL as
#   database, to use the much quicker mySQL server. But by using this generic
#   interface, we can have both... More or less :)
# # Any reference to the Msql function 'query' had to be replaced with, first
#   a 'prepare' then a 'execute'. If the execute fails, then die, or log, or
#   what evere takes us fancy...
# * Any reference to the Msql functions 'fetchrow' and 'numrows', had to be
#   replaced with 'fetchrow_array' and 'rows'.
# * Any reference to the variable 'dh' (as in DatabaseHandle) and 'quotadbh',
#   have been replaced with 'dbh' all over the board, so that we have one common
#   denominator.
# * Found a 'open_sql_server()' function in the 'tcp_masq_openfw' script. Move
#   that to the library, so that we can reuse the function all over the board.
#
# Revision 1.53  1998/06/12 14:47:23  turbo
# * Logg username/hostname if we are running in debug mode...
# * Spell errors fixed in the english translation... I have to rewrite this
#   some day... *sigh*
#
# Revision 1.52  1998/05/29 14:16:49  turbo
# Check the last three minutes worth of masquerading connects instead of the
# last PERIOD sekonds...
#
# Revision 1.51  1998/05/25 16:09:31  turbo
# * Print a bar '|', to separate the two columns in the list database.
# * Do not try to calculate the cost from the LOW_RATE value.... We only need to
#   return number of minutes...
#
# Revision 1.50  1998/05/24 15:48:08  turbo
# * Print the quota output in TWO columns, instead of one (chktcpquota -a)
#   Function: 'list_dbase()'.
#
# Revision 1.49  1998/05/17 11:12:13  turbo
# Bug fixing 'check_localnet()'. Make sure we check each localnet with the
# input to the function (network we want to no if local).
#
# Revision 1.48  1998/05/14 16:57:09  turbo
# * Added two new functions:
#     find_basenet()           => Convert a '42.42.0.0' net to '42.42'.
#     check_localnet()         => Check if the network is one of the local ones.
# * Check for a local network at the same time as we are loading the network
#   trafic data.
# * When waiting for the daemon to close the firewall, when we get the 'closed'
#   from the server, make sure to delete the entry from the database...
#
# Revision 1.47  1998/04/29 13:48:48  turbo
# If we can not find the IP number to the host, return 0 (not -1), and output
# a nice, and descriptive explanation to what's happening...
#
# Revision 1.46  1998/04/26 20:10:47  turbo
# Instead of hardcoding the utmp entry number, use the function's
# that is provided... (ex: '&utmp'ut_addr' returns number 7, the
# sevent'th entry in the utmp struct).
# The only thing one have to do for a libc6 system is to include
# another 'utmp.ph' file (which is from a libc6 utmp.h).
#
# Revision 1.45  1998/04/26 14:37:50  turbo
# Fix the problem with short addresses, like: '205.229.104.5' (oct/hex: 90760653/568e5cd)
# Hopfully it fixes other problems to... :)
#
# Revision 1.44  1998/04/19 19:51:10  turbo
# When we try to exchange a '1' to true, don't!
# Some values _IS_ numeric... (Boolean is now
# ether 'true/yes' or 'false/no').
#
# Revision 1.43  1998/04/19 09:30:46  turbo
# Added real support for a boolean value.
# If a value is 1 or true, it should be changed
# to 'yes', and vise versa...
#
# Revision 1.42  1998/04/18 18:19:08  turbo
# * No need to do a 'foreach' in the message, just print the whole
#   thing at once...
# * Security fix in the 'open()'...
#
# Revision 1.41  1998/04/18 16:38:36  turbo
# Added a new function, send_message, which sends a specific message
# to a user. It first sends to there controlling terminal, and if
# possible to there WINPOPUP.EXE if they are running windows (via
# one of the SAMBA programs)...
#
# Revision 1.40  1998/04/16 20:20:47  turbo
# If the IP number can't be found int the utmp file,
# look up the hostname instead...
#
# Revision 1.39  1998/04/16 18:45:43  turbo
# * Don't fetch the whole database table when we know that we are waiting for one
#   specific host... Just select the one host we are waiting for!
# * If we should be verbose when we are opening the firewall, tell the user
#   why it can take some time before the openhost (ut) script continues..
#   ('Opening the firewall for you, just a moment...')
#
# Revision 1.38  1998/04/16 12:22:36  turbo
# Added the feature to extract a special username from the
# log database...
#
# Revision 1.37  1998/04/14 12:18:56  turbo
# Forgot to change one call to the masq table (used 'date' when I
# should have used 'when').
#
# Revision 1.36  1998/04/13 15:06:03  turbo
# Forgot a 'count' (old name for one of the columns in the masq table)
#
# Revision 1.35  1998/04/13 10:43:44  turbo
# * Make sure we use 'while(! eof(handle) )' when we are reading from a file,
#   must have forgotten about the reading of the config file and the 'netstat'...
# * The new mSQL engine does not understand the column name 'date', it clashes
#   with a column type, so it had to be renamed to 'when', make sure we create
#   the table with the correct name...
#
# Revision 1.34  1998/04/11 14:00:21  turbo
# When we are removing an entry from the database, tell the user
# what is happening (closing firewall, please wait)...
#
# Revision 1.33  1998/04/04 13:26:16  turbo
# When the host have already been opened, check to see if it is opened for
# free access... In that case, say so... ! :)
# Makes it more understandable for novises...
#
# Revision 1.32  1998/03/31 12:32:19  turbo
# Instead of hardcoding the greet/info in the programs, open
# a config file, and just output the lines in that...
#
# Revision 1.31  1998/03/31 11:29:53  turbo
# Only wait for the aqnowlagement, in the 'write_db()' function, from the daemon
# if we are called with the new parameter 'wait' set to TRUE (to make the opening/
# closing of the firewall in batch mode smoother and faster).
#
# Revision 1.30  1998/03/31 10:46:11  turbo
# If we are running 'write_db()' verbosly, don't wait for the daemon
# to aqnowlage the opening of the firewall... Do that in the client
# instead (so that we can issue opening orders, and _THEN_ wait).
#
# Revision 1.29  1998/03/29 18:22:14  turbo
# We have to read from the file 'while(!eof(MASQUERADE))', _NOT_
# 'while(!eof(<MASQUERADE>))'... Woupsi... Also make sure we store the line
# somewhere BEFORE splitting and using it...
#
# Revision 1.28  1998/03/17 21:56:24  turbo
# If one prints a variable, do not use ', but instead "...
#
# Revision 1.27  1998/03/17 18:59:30  turbo
# * Removed some lines that wasn't used
# * Read from the config file while we have something from the filehandle
#   'while(! eof(<CF>) )' didn't work as expected...
#
# Revision 1.26  1998/03/15 10:49:32  turbo
# New kind of perl, make sure we read from a file handle until
# we get EOF...
#
# Revision 1.25  1998/03/14 23:04:23  turbo
# The two columns 'open' and 'free' got mixed up, fixed...
#
# Revision 1.24  1998/03/14 17:32:19  turbo
# * In the 'wait_for_masq()' function, just return TRUE or FALSE if
#   we have got the signal we requested. Do the actual waiting/looping
#   in the 'write_db()' function (which calls the wait_for_masq() func.
# * When we want to close the firewall, make sure we tell the daemon
#   (by writing to the database, then wait until the daemon have wrote
#   the answer back, THEN remove the whole entry from the masq table...
#
# Revision 1.23  1998/03/13 19:46:55  turbo
#   Added a function that hangs around and waiting for the
# daemon to write a '0' or '1' in the masq table (the
# 'open' column), which means that the firewall is opened
# or closed... Function name: 'wait_for_masq()'.
#   This function is called from 'write_db()' just before
# we output the successfull message that the firewall have
# been closed or opened, depending on status of the firewall...
#
# Revision 1.22  1998/03/13 14:38:26  turbo
# Make sure that the {open|close}_for_masq()
# returns the value from the system call...
#
# Revision 1.21  1998/01/23 11:05:36  turbo
# Make sure we do not try to process any empty variables in the 'hex_to_ip()'
# function, perl complain if so. If we try to convert a hex value with less
# than 8 characters, then return '0.0.0.0'.
#
# Revision 1.20  1997/12/04 14:11:16  turbo
# Got the fetching of the IP address from the utmp file to work, updated
# the WHO variable and it's splitting accordingly...
#
# Revision 1.19  1997/12/03 10:16:01  turbo
# * Moved the 'list_dbase()' to the library file, it was (practicaly) used
#   by both the 'chktcpquota' and 'addtcpquota' scripts...
#
# Revision 1.18  1997/12/02 19:01:51  turbo
# Use the VERSION variable instead of hardcoded CVS Revision line...
#
# Revision 1.17  1997/12/01 15:04:39  turbo
# * Update the info output, we are running version 1.35 now...
# * Don't forget the TTY entry, when checking who's online...
#
# Revision 1.16  1997/12/01 13:49:43  turbo
# * When we get the netstat, skip any connections, with our own net as source...
#   (Hmmm... Could this realy be correct?)
# * Skip all type of status exept 'ESTABLISHED' ports...
#
# Revision 1.15  1997/11/26 20:12:28  turbo
# * Some new functions, some moved from some of the binaries to this file instead
#   logg_actions()              => Logg everything that is made to the firewall
#   list_logg()                 => List the logg... (no shit :)
# * We now read the UTMP file instead of using the command 'who'...
# * Fixed the 'rawtime_to_time()', it now calculates the rawtime correctly!!
#
# Revision 1.14  1997/11/20 22:18:47  turbo
# * Moved the 'read from who/w' to a separate function, to ease the rewrite
#   from reading from an external prog, to using the utmp file...
#
# Revision 1.13  1997/11/19 20:13:05  turbo
# * A lot of new function, some moved from 'tcpquotad':
#   find_ip()                => Do a DNS lookup on the hostname.
#   get_netstat()            => Open '/proc/net/tcp' and return all lines.
#   revert_ip()              => Revert the ip from '/proc/net/tcp' to a
#                               humanly readable form.
#   rawtime_to_time()        => Convert the raw time from proc to a human
#                               readable time.
#   get_masquerade()         => Open '/proc/net/ip_masquerade' and return
#                               all lines.
#   check_free_user()        => Find out if a user is in the free group
#   get_masqueraded_online() => Check if the masqueraded host really have
#                               a connection online
#   hex_to_ip()              => Convert the hexadecimal IP address to Internet
#                               IP address
#
# Revision 1.12  1997/11/11 14:55:56  turbo
# Call the free 'user' just free, instead of 'free of charge'...
#
# Revision 1.11  1997/11/11 14:20:17  turbo
# * Moved the functions open_for_masq(), close_for_masq(), closedown() and
#   write_db() to this lib file from 'tcp_masq_openhost' instead, since it was
#   needed by 'tcp_masq_openfw' to...
#
# Revision 1.10  1997/10/16 21:29:07  turbo
# Moved the function 'find_fqdn()' here from the script 'topnet' since it was
# needed else were to...
#
# Revision 1.9  1997/10/16 18:50:20  turbo
# Just added myself to the 'who to talk to incase of problems'... :)
#
# Revision 1.8  1997/10/16 15:58:48  turbo
# Moved the function 'get_timestring()' here since it is needed by more programs.
#
# Revision 1.7  1997/10/16 15:53:50  turbo
# Moved the function 'calculate_cost()' in here instead since it is used by
# many programs...
#
# Revision 1.6  1997/10/12 17:49:58  turbo
# Darn... You can not clear the screen from a SUID program...
#
# Revision 1.5  1997/10/08 20:23:38  turbo
# Before printing the header, clear the screen...
#
# Revision 1.4  1997/09/26 16:19:37  turbo
# Added the CVS header and log...
#
#
sub readconfig {
    local($configfile, $prog) = @_;
    my($tmp);

    open(CF, $configfile) ||
	die "Kan inte öppna $configfile för läsning..\n";

    print "Reading $configfile configfile\n" if $DEBUG;
    while(! eof(CF)) {
	$tmp = <CF>;
	chop($tmp);

	# Skip comments and empty lines...
	next if( $tmp =~ /^\#/ );
	next if( $tmp =~ /^$/ );

	# local config for this prog.  remote proceding string.
	if( $tmp =~ /^$prog/ ) {
	    $tmp =~ s/^($prog)\.//;
	}

	($name,$var)=split(/=/, $tmp);

	$var = 'yes' if( $var eq 'true' );
	$var = 'no'  if( $var eq 'false' );

	printf("  %-24s = %s\n", $name, $var) if $DEBUG;
	$cf{$name} = $var;
    }

    print "Done reading config...\n\n" if $DEBUG;
    close(CF);
}

######################################################################
#
# Open the SQL server...
#
sub open_sql_server {
    undef( $dbh );

    # Open up the database connection...
    $dbh = DBI->connect( "dbi:$cf{'ENGINE'}:tcpquota:$cf{'SERVER'}")
	|| die( "Can't connect to database at '$cf{'SERVER'}." );
}

######################################################################
#
#
sub logg_actions {
    local($database, $string) = @_;
    my($query, $sth);

    # Make sure the table exists...
    $sth = $dbh->prepare("select * from $database");
    if(! $sth->execute ) {
	# Table does not exists, create it...
	$query  = "create table $database ( ";
	$query .=   "when char(14) not null, ";
	$query .=   "user char(8) not null, ";
	$query .=   "action char(57) not null ";
	$query .= ")";

	$sth = $dbh->prepare($query);
	$sth->execute || die "Could not execute query: $sth->errstr";
    }

    $date = get_timestring();

    $query = "insert into $database (when,user,action) values ('$date', '$USER', '$string')";
    $sth = $dbh->prepare($query);
    $sth->execute || die "Could not execute query.\n";
}

######################################################################
#
# list_logg()
#
# Print the log database
#
sub list_logg {
    local($database, $username) = @_;
    my($date, $user, $action, $query, $sth);

    # Query the database.
    if( $username ) {
	$query = "select * from $database where user like '$username'";
    } else {
	$query = "select * from $database";
    }
    $sth = $dbh->prepare($query);
    $sth->execute || die("There is no logging so faar...\n");

    printf("Date     Time  User       Action\n");
    while( ($date,$user,$action) = $sth->fetchrow_array ) {
	printf("%-14s %-10s %-40s\n", $date, $user, $action);
    }

    print "\n\n";
}

######################################################################
#
# list_dbase()
#
# Find out what tables exist in the database...
#
sub list_dbase {
    local($dbase) = @_;
    my(%line, $cost, $sec, $user, $key, $sth, $i);

    # Query the database.
    $sth = $dbh->prepare("select * from $dbase");
    $sth->execute || &terminate( "Error when query..." );

    if( $dbase eq 'tcptab' ) {
	while( ($user,$sec) = $sth->fetchrow_array ) {
	    $cost = calculate_cost($sec);
	    $line{$user} = sprintf("%-10s %9d  (%5d kronor)", $user, $sec, $cost);
	}
    } else {
	while( $user = $sth->fetchrow_array ) {
	    $line{$user} = $user;
	}
    }

    # Sort the list...
    $i = 0;
    foreach $key (sort(keys %line)) {
	if(! $i ) {
	    printf("$line{$key}\t|  ");
	    $i++;
	} else {
	    printf("$line{$key}\n");
	    $i--;
	}
    }

    print "\n";
}

######################################################################
#
# greet( void )
#
sub greet {
    my($tmp);

    # Clear the screen.
#   system( '/usr/bin/clear' );

    print "\t\t TCP Masquerader $VERSION\n";

    if( open(GREET, "$conf_dir/tcpquota.greet.$cf{'LANGUAGE'}") ) {
        while(! eof(GREET) ) {
            $tmp = <GREET>;
            print $tmp;
        }
        close(GREET);
    } else {
	if( $cf{'LANGUAGE'} eq 'svenska' ) {
	    print "Vid problem, prata med system administratören...\n";
	} else {
	    print "If you encounter any problems, talk to your system administrator...\n";
	}
    }
}

######################################################################
#
# info( void )
#
sub info {
    if( open(INFO, "$conf_dir/tcpquota.info.$cf{'LANGUAGE'}") ) {
        while(! eof(INFO) ) {
            $tmp = <INFO>;
            print $tmp;
        }
        close(INFO);
    } else {
	if( $cf{'LANGUAGE'} eq 'svenska' ) {
	    print "Nedan syns det hur många kopplingar ut du har samt hur många gånger\n";
	    print "som servern upptäcker detta och debiterar ditt konto...\n";
	} else {
	    print "Down below you see how many connections you have, and how many times\n";
	    print "the server discovers this, and depits you account...\n";
	}
    }
}

######################################################################
#
# $cost = calculate_cost($sec)
#
sub calculate_cost {
    local($sec) = @_;
    my($add_minus) = 0;
    my($b);

    if(! $sec ) {
	$sec = 0;
    } elsif( $sec =~ /^\-/ ) {
	# remove the leading '-'.
	$sec = (split(/-/, $sec))[1];
	$add_minus = 1;
    }

    # calculate number of minutes.
    $b = int( ($sec / 600) );

    if( $add_minus ) {
	# Add the '-' again...
	$b = "-$b";
    }

    return $b;
}

######################################################################
#
# $date = get_timestring()
#
# find the date for use in the logfile...
#
# Returns a string something like: '10/8-96 16:27'
#
sub get_timestring {
    local($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)= localtime;

    return POSIX::strftime( "%d/%m-%y %H:%M", $sec, $min, $hour, $mday,
			   $mon, $year, $wday, $yday, $isdst);
}

######################################################################
#
# $ip = find_ip( $hostname )
#
# Find the IP for a FQDN (Fully Qualified Domain Name)
#
sub find_ip {
    local($name) = @_;
    my($addr,$a,$b,$c,$d);

    if( $name ) {
	$addr = (gethostbyname($name))[4];
	if( $addr ) {
	    ($a,$b,$c,$d) = unpack('C4', $addr);
	    return("$a.$b.$c.$d");
	} else {
	    return(0);
	}
    } else {
	return(0);
    }
}

######################################################################
#
# $fqdn = find_fqdn( $host_ip )
#
# Find the FQDN (Fully Qualified Domain Name) for a host IP
#
sub find_fqdn {
    local($host_ip) = @_;

    # Find the FQDN of a host...
    if( open(NS, "/usr/bin/host $host_ip 2>/dev/null |") ) {
	$line = <NS>;

	if($line) {
	    chop($line);

	    $fqdn = substr($line, 6);
	} else {
	    $fqdn = $host_ip;
	}
    } else {
	$fqdn = $host_ip;
    }
    close(NS);

    return( $fqdn );
}

######################################################################
#
# proc: find_basenet( void )
#
# get the base network address
# 42.42.0.0  => 42.42
# 
sub find_basenet {
    my(@locnet, @temp, %network, $tmp, $i);

    # Cycle through the localnets...
    @locnet = split(' ', $localnet);
    foreach $tmp (@locnet) {
	@temp = split('\.', $tmp);
	$network{$tmp} = "";

	# Convert 42.42.0.0 => 42.42
	for($i = 0; $i <= 3; $i++) {
	    if($temp[$i]) {
		# Remove the net part...
		$network{$tmp} .= $temp[$i];
	    }

	    if($temp[$i+1]) {
		$network{$tmp} .= ".";
	    }
	}
    }

    return(%network);
}

sub check_localnet {
    local($src, %network) = @_;
    my($tmp, $local_network, $out);

    $local_network = 0; $out = "CHK: ";
  NET:
    foreach $tmp (keys %network) {
	# Skip connect with our own network addresses...

	$out .= sprintf("$src ($network{$tmp}) ");
	if( $src =~ /^$network{$tmp}/ ) {
	    $out .= sprintf("=> LOCAL!\n");
	    $local_network = 1;

	    last NET;
	}
    }

    if( $src eq $cf{'LOC_ADDR'} ) {
	$out .= sprintf("=> LOCAL!\n");
	$local_network = 1;
    }

    if(! $local_network) {
	$out .= sprintf("=> ! LOCAL\n");
    }

    &logg(2, $out);
    return($local_network);
}

######################################################################
#
# proc: find_users()
#
# Get the users currently online...
#
sub get_online {
    my($i, $a, $b, $c, $d, $utmp, $addr, $logg_string);
    my(%ret) = ();

    open(UTMP, '/var/run/utmp');

    $i = 0; $utmp = "";
    while(read(UTMP, $utmp, &utmp'sizeof())) {
        @utmp = unpack(&utmp'typedef(), $utmp);

        if($utmp[&utmp'ut_user]) {
            next if($utmp[&utmp'ut_user] =~ /^LOGIN/);
            next if($utmp[&utmp'ut_host] =~ /^0/);
            next if($utmp[&utmp'ut_type] == 8);

            # Get the hostname, but allow ':x.x' at the end of the hostname string...
	    # Converts 'stalin.ccw.se:1.0' to 'stalin.ccw.se'...
	    $utmp[&utmp'ut_host] =~ /([^:]*).*/;
	    $utmp[&utmp'ut_host] = $1;

	    # Just incase we have a ':0:S.0' address, the ut_host above will be empty...
	    if(! $utmp[&utmp'ut_host] ) {
                $utmp[&utmp'ut_host] = $cf{'LOC_ADDR'};
	    }

	    # Do we have a source address?
	    if( $utmp[&utmp'ut_addr] ) {
		# Octal value == Hex value == IP address (reversed)
		# 11512581674 == 5A282A2A  == 90.40.42.42

		# Get it as a hex digit.
		$src = sprintf("%x", $utmp[&utmp'ut_addr]);
		if(length($src) == 7) {
		    # Fix the problem with the address: '205.229.104.5' (oct/hex: 90760653/568e5cd)
		    # Hopfully it fixes other problems to... :)
		    $src = "0" . $src;
		}

		# Now, output the IP address, in propper order...
		$addr = &revert_ip(&hex_to_ip($src));
	    } else {
		$addr = &find_ip($utmp[&utmp'ut_host]);
	    }

	    # Compose: username hostname tty IPaddr
	    $ret{$i} = sprintf("%-10s %-35s %-7s $addr", $utmp[&utmp'ut_user], $utmp[&utmp'ut_host], $utmp[&utmp'ut_line]);

	    $logg_string = "WHO: $utmp[&utmp'ut_user]/$utmp[&utmp'ut_host]";
	    &logg(2, "$logg_string\n") if($DEBUG);

            $i++;
        }
    }   
    close(UTMP);

    return(%ret);
}

######################################################################
#
# proc: get_netstat()
#
# Get the connect to and from us, not counting any local comm...
#
sub get_netstat {
    my(%netstat, %network);
    my($destin, $uid, $line, $src, $dst, $i);
    my($source, $local_network);

    %network = &find_basenet();

    # Read from 'netstat'...
    open(NETSTAT, "/proc/net/tcp")
	|| &logg(1,"ERROR: Could not open /proc/net/tcp, $!");

    <NETSTAT>; $i = 0;
    while(! eof(NETSTAT) ) {
	$line = <NETSTAT>;

	$src = (split(' ', $line))[1];
	next if( $src =~ /^0100007F/ ); # '127.0.0.1' in reverted hexadecimal form
	next if( $src =~ /^00000000/ ); # '0.0.0.0'   in reverted hexadecimal form

	$stat   = (split(' ', $line))[3];
	next if( $stat !~ /^01/ );      # Only care about 'ESTABLISHED' ports...

	$dst    = (split(' ', $line))[2];
	$uid    = (split(' ', $line))[7];

	$source = &revert_ip(&hex_to_ip((split(':', $src))[0])) . ":" . hex((split(':', $src))[1]);
	$destin = &revert_ip(&hex_to_ip((split(':', $dst))[0])) . ":" . hex((split(':', $dst))[1]);

	next if( &check_localnet($destin, &find_basenet()) );

	$netstat{$i} = "$source $destin $uid $stat";
	$i++;
    }
    close(NETSTAT);

    return(%netstat);
}

######################################################################
#
# proc: check_free_user($username)
#
# find out if a user is in the free group
# 
# Returns: 1 if member of the free group
#          0 if not
#
sub check_free_user {
    local($username) = @_;
    my(@users);

    @users = split(' ', $cf{'USERS'});
    foreach $user (@users) {
	if($user =~ $username) {
	    return(1);
	}
    }

    return(0);
}

######################################################################
#
# proc: get_masqueraded_online()
#
# Check if the masqueraded host really have a connection online...
#
# Returns:   0 if the host is online right now
#            ? for number of connects...
# 
sub get_masqueraded_online {
    local($host) = @_;
    my($line, $time, $src, $dst, $minutes, $seconds, $milisec, $cnts);
    my(%MASQ);

    # Read from 'ipfwadm'...
    %MASQ = &get_masquerade();

    # As default, no connects...
    $cnts = 0; $i = 0;

    while($MASQ{$i}) {
	($src, $dst, $time, $dummy) = split(' ', $MASQ{$i});

	if($src eq $host) {
	    # Tcp kopplingar har 15 minuter som initial timout.
	    # vi tar bara med en kopplin under PERIOD sek
	    # sedan den var aktiv..
	    #
	    ($minutes, $time)    = split(/:/,  $time);
	    ($seconds, $milisec) = split(/\./, $time);

	    # Wrong.... We take the last three minutes...
	    if( $minutes >= 12 && ($seconds >= 20 - $cf{'PERIOD'}) ) {
		$cnts++;
	    }
	}

	$i++;
    }

    return($cnts);
}

######################################################################
#
# get_masquerade()
#
# Get the connects which are masqueraded...
#
sub get_masquerade {
    my(@a, $src, $dst, $time, $type, $line, %masq);

    # Read from 'ipfwadm'...
    open(MASQUERADE,"/proc/net/ip_masquerade")
	|| &logg(1,"Could not open '/proc/net/ip_masquerade', $!");
    <MASQUERADE>; $i = 0;
    while(! eof(MASQUERADE) ) {
	$line = <MASQUERADE>;
	@a = split(' ', $line);

	# We want to know 'time, src, dst, type'
	$src  = &hex_to_ip((split(':', $a[1]))[0]);
	$dst  = &hex_to_ip((split(':', $a[2]))[0]);
	$time = &rawtime_to_time($a[7]);
	$type = "xxx"; # I dont know...

	$masq{$i} = "$src $dst $time $type";

	$i++;
    }
    close(MASQUERADE);

    return(%masq);
}

######################################################################
#
# $ip = hex_to_ip( $hex_ip )
#
# Convert the hexadecimal IP address to Internet IP address
#
sub hex_to_ip {
    local($hex) = @_;
    my($i, $tmp, $ret, $len);

    $ret = "";
    $len = length($hex);
    if( $len == 8 ) {
	for( $i = 0; $i <= 6; $i += 2 ) {
	    $tmp = substr($hex, $i, 2);

	    if( $tmp ) {
		$tmp = hex($tmp);

		$ret .= "$tmp";
		if($i <= 4) {
		    $ret .= ".";
		}
	    }
	}

	return($ret);
    } else {
	return("0.0.0.0");
    }
}

######################################################################
#
# $ip = revert_ip( $ip )
#
# Revert the ip from '1.0.0.127' to '127.0.0.1'
# (the file '/proc/net/tcp' stores the ip in the first order)
#
sub revert_ip {
    local($reverted) = @_;
    my($ipA, $ipB, $ipC, $ipD);

    ($ipA, $ipB, $ipC, $ipD) = split('\.', $reverted);

    return("$ipD.$ipC.$ipB.$ipA");
}

######################################################################
#
# $time = rawtime_to_time( $raw_time )
#
# Convert the raw time from proc to human time
#
# Input a value like '68596'
# (last two is the microsec)
#
# Return a value like '11:25.96'
# (11 min, 25 sec, 96 microsec)
#
sub rawtime_to_time {
    local($raw) = @_;
    my($len, $min, $sec, $mic, $tmp, $time);

    # Default values...
    $min = 0; $sec = 0; $mic = 0;

    $len = length($raw);
    if($len) {
	# Get the micro sec...
	if($len <= 1) {
	    $mic = substr($raw, -1, 1);
	    $raw = substr($raw, 0, -1);
	} elsif($len >= 2) {
	    $mic = substr($raw, -2, 2);
	    $raw = substr($raw, 0, -2);
	}

	# Get min and sec...
	$len = length($raw);
	if($len) {
	    $tmp = substr($raw, 0, $len);

	    $min = int($tmp/60);
	    $sec = $tmp%60;
	}
    }

    $time = sprintf("%0.2d:%0.2d.%0.2d", $min, $sec, $mic);
    return($time);
}

#
# Open firewall for host...
sub open_for_masq {
    # Öppna maskering och accounting för clienten..
    local($ip, $verbose) = @_;
    my($ret);

    $ret = system("/sbin/ipfwadm","-Fa","masquerade","-S","$ip","-D","0/0");

    if( $verbose ) {
	if( $cf{'LANGUAGE'} eq 'svenska' ) {
	    &closedown (10,"Kan inte öppna för masqueradeing... sorry\n") if ($ret / 256 != 0);
	    print "Man kan nu komma ut på Internet från $ip.\n";
	} else {
	    &closedown (10,"Can not open for masquerading... sorry\n") if ($ret / 256 != 0);
	    print "One can now come out on the Internet from $ip.\n";
	}
    }

    return( $ret );
}

#
# Close firewall for host and remove host from masquerading table...
sub close_for_masq {
    local($ip, $verbose) = @_;
    my($ret);

    $ret = system("/sbin/ipfwadm","-Fd","masquerade","-S","$ip","-D","0/0");

    if( $verbose ) {
	if( $cf{'LANGUAGE'} eq 'svenska' ) {
	    &closedown(11, "Kan inte stänga för masqueradeing... Sorry.\n") if($ret / 256 != 0);
	    print "Nu kan man ej längre komma ut från $ip\n";
	} else {
	    &closedown(11, "Can not turn of masquerading... Sorry.\n") if($ret / 256 != 0);
	    print "One can no longer come out from $ip\n";
	}
    }

    return( $ret );
}

#
# Wait until the daemon have updated the masq table...
sub wait_for_masq {
    local($ip, $command) = @_;
    my($sth, $host, $name, $cnts, $tic, $count,$free,$open);

    $sth = $dbh->prepare("select * from masq where host like '$ip'");
    $sth->execute || die( "SELECT: Could not fetch from masq table: $sth->errstr" );

    # Fetch each hit..
    ($host, $name, $cnts, $tic, $count, $open, $free) = $sth->fetchrow_array;

    if( $host ) {
	# This is the host/ip we are waiting for, is it opened/closed?
	if( ($command eq 'open') && ($open eq '1') ) {
	    # It is opened...
	    return( 1 );
	} elsif( ($command eq 'close') && ($open eq '0') ) {
	    # Remove the entry from the database...
	    $sth = $dbh->prepare("delete from masq where host = '$ip'");
	    $sth->execute || die "Sorry could not delete from masq: $dbh->errstr";

	    return( 1 );
	} else {
	    return( 0 );
	}
    } else {
	# Could not fetch the line in the table, tell the caller that it's okay anyway...
	return( 1 );
    }
}

#
# Send a message to a specified user
# Both on there controlling terminal, and if possible to there
# WINPOPUP.EXE if they are running windows (via one of the SAMBA
# programs)...
sub send_message {
    local($user, @message) = @_;
    my(%WHO, $tmp, $dummy, $username);

    # Do a write to the user's terminal...
    if( open(WRITE,"|/usr/bin/write $user") ) {
	# Send the message...
	print WRITE @message;

	# Close the pipe...
	close(WRITE);
    } else {
	&logg(1, "Could not open '/usr/bin/write $user', $!\n");
    }

    # First find the host the user is comming from...
    %WHO = &get_online();

    $i = 0;
    while( ($username, $host, $dummy, $dummy) = split(' ', $WHO{$i}) ) {
	if( $username eq $user ) {
	    # Untaint username, to make the command line secure...
	    if( $host =~ /^([-\@\w.]+)$/) {
		$host = $1;
	    } else {
		&logg(1, "Can not send a SMB messge to $user\@$host, not taint secure\n");
		return;
	    }

	    $ip = &find_ip($host);
	    # Try to open the smbclient program...
	    if( open( SMBCLIENT, "|/usr/bin/smbclient -M $host -I $ip > /dev/null" ) ) {
		# We have found our user, try to send a windows message...
		# The client have to be running 'winpopup' for this to work...
		print SMBCLIENT @message;

		# Send a short generic message, like a 'signature'...
		if( $cf{'LANGUAGE'} eq 'svenska' ) {
		    print SMBCLIENT "\n\nFör att krympa ner WINPOPUP (eller om du kör\n";
		    print SMBCLIENT "WinPopup PLUS), och ta bort detta meddelande,\n";
		    print SMBCLIENT "tryck på papperskorgen (eller 'Close' högst\n";
		    print SMBCLIENT "upp till vänster...\n\n";
		    print SMBCLIENT "Med vänliga hälsningar, administratören.\n";
		} else {
		    print SMBCLIENT "\n\nTo shrink this window, and remove the message,\n";
		    print SMBCLIENT "press the trashcan at the top left...\n";
		    print SMBCLIENT "Regards, the administrator.\n";
		}

		# Close the pipe...
		close(SMBCLIENT);

		# We are done, return...
		return;
	    } else {
		&logg(1, "Could not send a SMB messge to $user\@$host, $!\n");
		return;
	    }
	}

	$i++;
    }
}

#-----------------------------------------------------------------
#
# Msql funcs.. Dessa meckar med msql och interfacet mot tcpquotad
sub closedown {
    local($err, $msg) = @_;

    &remove_from_db($dbh, $ip, $name) if ($db_masq_written);
    print $msg;
    exit $err;

}

# Skriv till msql, så att tcpquotad kan räkna med oss..
sub write_db {
    local($action, $db, $ip, $name, $verbose, $wait) = @_;
    my($sth, $rv, $regname);
    
    if( $action eq 'add' ) {
	# Add host to masquerading table...
	if($name eq 'free') {
	    $free = 1;
	} else {
	    $free = 0;
	}

	$sth = $dbh->prepare("select * from masq where host like '$ip'");
	$rv  = $sth->execute;
	if( $rv eq '1' ) {
	    # There is already an entry with this IP in the database...
	    $regname = ($sth->fetchrow_array)[1]; # Fetch the 2:nd column
	    if($regname eq $name) {
		if(! &check_free_user($regname) ) {
		    if( $cf{'LANGUAGE'} eq 'svenska' ) {
			die "$regname har öppnat $ip för internet access enl mina anteckningar.\nNågot är fel, tala med någon ansvarig...\n";
		    } else {
			die "$regname have opened $ip for internet access according to my notes.\nSomething is wrong, speak to someone in charge...\n";
		    }
		} else {
		    # This host is opened for free...
		    if( $cf{'LANGUAGE'} eq 'svenska' ) {
			die "Datorn ($ip) ar redan oppnad for fri internet access enligt mina anteckningar.\nDet innebar att du inte behover oppna den sjalv...\n";
		    } else {
			die "This host ($ip) is opened for free internet access according to my notes.\nThis means that you don't have to openit yourself...\n";
		    }
		}
	    } else  {
		if( $cf{'LANGUAGE'} eq 'svenska' ) {
		    die "Du har ju redan öppna denna maskin för internet access.\nKolla att du inte har flera telnet sessioner igång!\n";
		} else {
		    die "Your have already opened this machine for internet access.\nDouble check to see that you do not have any more telnet session running!\n";
		}
	    }
	} else {
	    # No entry with this IP in the database...
	    $sth = $dbh->prepare("insert into masq (host,name,cnts,tic,counter,open,free)
                     values('$ip','$name',0,$cf{TICS},0,2,$free)");
	    $sth->execute || die "Could not insert into the masq table: $sth->errstr";
	}

	$db_masq_written=1;
	print "\n" if($verbose);

	if($verbose) {
	    if( $cf{'LANGUAGE'} eq 'svenska' ) {
		printf("\nÖppnar brandväggen för dig, ett ögonblick bara...\n");
	    } else {
		printf("\nOpening the firewall for you, just a moment...\n");
	    }
	}

	if($wait) {
	    # Wait until the daemon have told the table that it is opened...
	    while(! &wait_for_masq($ip, 'open') ) {
		sleep(2);
	    }
	}

	if($verbose) {
	    # Tell the user what's happening...
	    if( $cf{'LANGUAGE'} eq 'svenska' ) {
		print "Du kommer nu att debiteras för IP trafik till $ip.\n";
	    } else {
		print "You will now be debited for IP traffic to $ip.\n";
	    }
	}
    } elsif( $action eq 'rem' ) {
	# Remove host from masquerade table...

	if($verbose) {
	    if( $cf{'LANGUAGE'} eq 'svenska' ) {
		printf("\nStänger brandväggen efter dig, ett ögonblick bara...\n");
	    } else {
		printf("\nClosing the firewall behind you, just a moment...\n");
	    }
	}

	# Tell the database/daemon we want this host closed...
	$sth = $dbh->prepare("update masq set open = 3 where host = '$ip'");
	$sth->execute || die "Could not execute query: $sth->errstr";
	$db_masq_written=0;

	if($wait) {
	    # Wait until the daemon have told the table that it is opened...
	    while(! &wait_for_masq($ip, 'close') ) {
		sleep(2);
	    }

	    # Remove the entry from the database...
	    $sth = $dbh->prepare("delete from masq where host = '$ip'");
	    $sth->execute || die "Could not execute query: $sth->errstr";
	    $db_masq_written=0;
	}

	if($verbose) {
	    if( $cf{'LANGUAGE'} eq 'svenska' ) {
		print "Du debiteras ej längre för IP tid..\n";
	    } else {
		print "You will not be debited for IP time any longer..\n";
	    }
	}
    }
}

1;
