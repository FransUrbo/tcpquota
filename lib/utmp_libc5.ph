# $Header: /usr/lib/cvs/root/tcpquota/lib/utmp_libc5.ph,v 1.1 1997/12/02 19:12:18 turbo Exp $
#
# $Log: utmp_libc5.ph,v $
# Revision 1.1  1997/12/02 19:12:18  turbo
# This is a conversion of the file '/usr/include/utmp.h' to be able to read the
# utmp file from perl.
# Converted from c-header to perl-header with '/usr/bin/c2ph'...
#
#
# This is the way the C struct looks like, with sizes etc...
# struct utmp {
#   short int          utmp.ut_type               0       2    s 
#   int                utmp.ut_pid                4       4    i 
#   char               utmp.ut_line[12]           8      12    A12 
#   char               utmp.ut_id[4]             20       4    A4 
#   long int           utmp.ut_time              24       4    l 
#   char               utmp.ut_user[8]           28       8    A8 
#   char               utmp.ut_host[16]          36      16    A16 
#   long int           utmp.ut_addr              52       4    l 
# }
#

sub utmp'ut_type { 0; }  # type of login
sub utmp'ut_pid  { 1; }  # pid of login-process
sub utmp'ut_line { 2; }  # devicename of tty -"/dev/", null-term
sub utmp'ut_id   { 3; }  # inittab id
sub utmp'ut_time { 4; }  # login time
sub utmp'ut_user { 5; }  # username, not null-term
sub utmp'ut_host { 6; }  # hostname for remote login
sub utmp'ut_addr { 7; }  # IP addr of remote host

sub utmp'struct  { 8; }

sub utmp'typedef {
    local($utmp'index) = shift;
    defined $utmp'index ? $utmp'typedef[$utmp'index] : $utmp'typedef;
}
sub utmp'sizeof {
    local($utmp'index) = shift;
    defined $utmp'index ? $utmp'sizeof[$utmp'index] : $utmp'sizeof;
}
sub utmp'offsetof {
    local($utmp'index) = shift;
    defined $utmpindex ? $utmp'offsetof[$utmp'index] : $utmp'sizeof;
}
sub utmp'typeof {
    local($utmp'index) = shift;
    defined $utmpindex ? $utmp'typeof[$utmp'index] : 'utmp';
}
sub utmp'fieldnames {
    @utmp'fieldnames;
}
sub utmp'isastruct {
    's';
}

$utmp'typedef = 's x2 i A12 A4 l A8 A16 l';
$utmp'sizeof  = 56;

@utmp'indices = (0..7);

@utmp'typedef[@utmp'indices] = (
  's', 	 # ut_type
  'i', 	 # ut_pid
  'A12', # ut_line
  'A4',  # ut_id
  'l',   # ut_time
  'A8',  # ut_user
  'A16', # ut_host
  'l', 	 # ut_addr
);

@utmp'sizeof[@utmp'indices] = (
   2,    # ut_type
   4,    # ut_pid
  12,    # ut_line
   4,    # ut_id
   4,    # ut_time
   8,    # ut_user
  16,    # ut_host
   4,    # ut_addr
);

@utmp'offsetof[@utmp'indices] = (
   0,    # ut_type
   4,    # ut_pid
   8,    # ut_line
  20,    # ut_id
  24,    # ut_time
  28,    # ut_user
  36,    # ut_host
  52,    # ut_addr
);

@utmp'typeof[@utmp'indices] = (
  'short int',  # ut_type
  'int',        # ut_pid
  'char',       # ut_line
  'char',       # ut_id
  'long int',   # ut_time
  'char',       # ut_user
  'char',       # ut_host
  'long int',   # ut_addr
);

@utmp'fieldnames[@utmp'indices] = (
  'ut_type',
  'ut_pid',
  'ut_line',
  'ut_id',
  'ut_time',
  'ut_user',
  'ut_host',
  'ut_addr',
);

1;
