# Databas beskrivning f�r tcp* proggen..
# $Header: /usr/lib/cvs/root/tcpquota/create_database.sql,v 1.10 1998/04/13 10:38:26 turbo Exp $
#
# $Log: create_database.sql,v $
# Revision 1.10  1998/04/13 10:38:26  turbo
# * The new mSQL engine does not use 'PRIMARY KEY' so those had to be removed
# * It does not understand the column name 'count', so it had to be renamed to
#   'counter'
#
# Revision 1.9  1998/03/14 23:03:48  turbo
# Added the column 'open' to the masq table...
#
# Revision 1.8  1997/11/11 14:12:24  turbo
# Added a new row in the masq table, called 'free'. Set to 1 if this host
# is allowed free surfing...
#
# Revision 1.7  1997/06/04 15:25:08  marbud
# Lite f�rklarande text, s� man kan minnas vad de olika kolumnerna anv�nds till.
#
# Revision 1.6  1997/05/29 21:42:06  marbud
# Nu med id f�r perioden.. Enklare att h�lla reda p�....
#
# Revision 1.5  1997/05/29 19:47:04  marbud
# F�rsta f�rs�k till periodisering av quota... Ny tabell som h�ller reda
# p� perioder med historik...
#
# Revision 1.4  1997/04/12 18:55:49  marbud
# Lagt till tcpquotatop i Makefile
#
# tcpquota top �r en ny produkt som visar vilka som debiteras och hur mycket.
#
# Revision 1.3  1997/02/06 21:43:40  marbud
# Nu lite �ndrag.. H�ller nu reda p� hur m�nga g�nger en rad har blivit
# debiterad av tcpquotad och kan �ven h�lla reda p� hur m�nga paket som
# hosten har skickat ut fr�n ccw.se...
#
# Revision 1.2  1997/01/20 23:01:38  marbud
# Lagt till n�gra sm� saker.. Som Primary keys och status f�lt i masq
# tabellen..
#
#
#
# mSQL Dump  (requires mSQL-1.0.6 or better)
#
# Host: localhost    Database: tcpquota
#--------------------------------------------------------


#
# Table structure for table 'tcptab'
#
#
# Namn p� person med tcpquota konto.. (name)
# Personens konto saldo. (quota)
#
CREATE TABLE tcptab (
  name CHAR(20) NOT NULL,
  quota INT
) \g


#
# Table structure for table 'allowed'
#
# Namn p� personer som f�r anv�nda sig av tcpquota (name)
# 
CREATE TABLE allowed (
  name CHAR(20) NOT NULL
) \g


#
# Table structure for table 'masq'
#
# H�ller reda p� vem som sitter p� vilken maskin och maskerarsig ut mot
# n�tet.
#
# Hostname p� maskinen.. IP adress. (host)
# Namn p� personen som har �ppnat hosten. (name)
# Antal kopplingar ut sist servern kollade. (cnts)
# Antal tics sedan maskeringen uppdaterades. (tic)
# Antal debitering denna maskering har debiterats sedan start (counter)
#
#
CREATE TABLE masq (
  host CHAR(15) NOT NULL,
  name CHAR(20) NOT NULL,
  cnts INT,
  tic INT,
  counter INT,
  open INT,
  free INT
) \g

#
# Table for keeping track of total and periodical quotas..
#
# Periodisering av tcpquota debiteringar. 
#
# id f�r perioden. (id)
# periodnamn f�r perioden. Vanligen datum tid (period)
# total quota from periodens start till n�sta period eller nutid. (quota)
#
CREATE TABLE periodtab (
  id int NOT NULL,
  period CHAR(20) NOT NULL,
  quota INT
) \g
