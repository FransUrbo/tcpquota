# $Header: /usr/lib/cvs/root/tcpquota/lib/utmp_libc6.ph,v 1.2 1998/04/26 20:36:59 turbo Exp $
#
# $Log: utmp_libc6.ph,v $
# Revision 1.2  1998/04/26 20:36:59  turbo
# Added support for libc5 (&utmp'ut_addr_v6 does not exists in libc5).
#
# Revision 1.1  1998/04/26 20:30:34  turbo
# This is a conversion of the file '/usr/include/utmp.h' to be able to read the
# utmp file from perl.
# It is also the libc6/glibc version of the utmp struct...
# Converted from c-header to perl-header with '/usr/bin/c2ph'...
#
#
# This is the way the C struct looks like, with sizes etc...
# struct utmp {                                 Offs     Len  Type
#  short int           utmp.ut_type               0       2    s
#  pid_t               utmp.ut_pid                2       4    i
#  char                utmp.ut_line               6      32    A32
#  char                utmp.ut_id                38       4    A4
#  char                utmp.ut_user              42      32    A32
#  char                utmp.ut_host              74     256    A256
#  struct exit_status  utmp.ut_exit             330       4    s2
#  long                utmp.ut_session          334       4    l
#  struct timeval      utmp.ut_tv               338       8    l2
#  int32_t             utmp.ut_addr_v6          346      16    i4
#  char                utmp.ut_pad              362      20    A20
# }
#

sub utmp'ut_type                     {    0; }  # type of login
sub utmp'ut_pid                      {    1; }  # pid of login-process
sub utmp'ut_line                     {    2; }  # devicename of tty -"/dev/", null-term
sub utmp'ut_id                       {    3; }  # inittab id
sub utmp'ut_user                     {    4; }  # username, not null-term
sub utmp'ut_host                     {    5; }  # hostname for remote login
sub utmp'ut_exit                     {    6; }  # The exit status of a process marked as DEAD_PROCESS
sub utmp'ut_session                  {    8; }  # Session ID, used for windowing
sub utmp'ut_tv                       {    9; }  # Time entry was made
sub utmp'ut_addr_v6                  {   11; }  # IP addr of remote host
sub utmp'pad                         {   15; }  # Reserved for future use

sub utmp'struct                      {   16; }

sub utmp'ut_addr                     {   &utmp'ut_addr_v6; }

sub utmp'typedef {
    local($utmp'index) = shift;
    defined $utmp'index
	? $utmp'typedef[$utmp'index]
	: $utmp'typedef;
}
sub utmp'sizeof {
    local($utmp'index) = shift;
    defined $utmp'index
	? $utmp'sizeof[$utmp'index]
	: $utmp'sizeof;
}
sub utmp'offsetof {
    local($utmp'index) = shift;
    defined $utmpindex
	? $utmp'offsetof[$utmp'index]
	: $utmp'sizeof;
}
sub utmp'typeof {
    local($utmp'index) = shift;
    defined $utmpindex
	? $utmp'typeof[$utmp'index]
	: 'utmp';
}
sub utmp'fieldnames {
    @utmp'fieldnames;
}
sub utmp'isastruct {
    's';
}
$utmp'typedef = 's x2 i A32 A4 A32 A256 s2 l3 i4 A20';
$utmp'sizeof = 384;

@utmp'indices = (0..6,8..9,11,15);

@utmp'typedef[@utmp'indices] = (
  's', 		# ut_type
  'i', 		# ut_pid
  'A32', 	# ut_line
  'A4', 	# ut_id
  'A32', 	# ut_user
  'A256', 	# ut_host
  's2', 	# ut_exit
  'l', 		# ut_session
  'l2', 	# ut_tv
  'i4', 	# ut_addr_v6
  'A20', 	# pad
);

@utmp'sizeof[@utmp'indices] = (
   2,		# ut_type
   4,		# ut_pid
  32,		# ut_line
   4,		# ut_id
  32,		# ut_user
 256,		# ut_host
   4,		# ut_exit
   4,		# ut_session
   8,		# ut_tv
  16,		# ut_addr_v6
  20,		# pad
);

@utmp'offsetof[@utmp'indices] = (
   0,		# ut_type
   4,		# ut_pid
   8,		# ut_line
  40,		# ut_id
  44,		# ut_user
  76,		# ut_host
 332,		# ut_exit
 336,		# ut_session
 340,		# ut_tv
 348,		# ut_addr_v6
 364,		# pad
);

@utmp'typeof[@utmp'indices] = (
  'short int',	# ut_type
  'int',	# ut_pid
  'char',	# ut_line
  'char',	# ut_id
  'char',	# ut_user
  'char',	# ut_host
  'exit_status',# ut_exit
  'long int',	# ut_session
  'timeval',	# ut_tv
  'int[4]',	# ut_addr_v6
  'char',	# pad
);

@utmp'fieldnames[@utmp'indices] = (
  'ut_type',
  'ut_pid',
  'ut_line',
  'ut_id',
  'ut_user',
  'ut_host',
  'ut_exit',
  'ut_session',
  'ut_tv',
  'ut_addr_v6',
  'pad',
);

1;
