# Databas beskrivning för tcp* proggen..
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
# Lite förklarande text, så man kan minnas vad de olika kolumnerna används till.
#
# Revision 1.6  1997/05/29 21:42:06  marbud
# Nu med id för perioden.. Enklare att hålla reda på....
#
# Revision 1.5  1997/05/29 19:47:04  marbud
# Första försök till periodisering av quota... Ny tabell som håller reda
# på perioder med historik...
#
# Revision 1.4  1997/04/12 18:55:49  marbud
# Lagt till tcpquotatop i Makefile
#
# tcpquota top är en ny produkt som visar vilka som debiteras och hur mycket.
#
# Revision 1.3  1997/02/06 21:43:40  marbud
# Nu lite ändrag.. Håller nu reda på hur många gånger en rad har blivit
# debiterad av tcpquotad och kan även hålla reda på hur många paket som
# hosten har skickat ut från ccw.se...
#
# Revision 1.2  1997/01/20 23:01:38  marbud
# Lagt till några små saker.. Som Primary keys och status fält i masq
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
# Namn på person med tcpquota konto.. (name)
# Personens konto saldo. (quota)
#
CREATE TABLE tcptab (
  name CHAR(20) NOT NULL,
  quota INT
) \g


#
# Table structure for table 'allowed'
#
# Namn på personer som får använda sig av tcpquota (name)
# 
CREATE TABLE allowed (
  name CHAR(20) NOT NULL
) \g


#
# Table structure for table 'masq'
#
# Håller reda på vem som sitter på vilken maskin och maskerarsig ut mot
# nätet.
#
# Hostname på maskinen.. IP adress. (host)
# Namn på personen som har öppnat hosten. (name)
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
# id för perioden. (id)
# periodnamn för perioden. Vanligen datum tid (period)
# total quota from periodens start till nästa period eller nutid. (quota)
#
CREATE TABLE periodtab (
  id int NOT NULL,
  period CHAR(20) NOT NULL,
  quota INT
) \g
