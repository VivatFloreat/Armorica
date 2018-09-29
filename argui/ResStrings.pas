unit ResStrings;

interface

Const
// Exception messages
   // Exceptions on form fmRazp
   C_EXCEPT_MSG_SOLVER_NOT_INIT = 'Neinicializiran problem ali sprememba datumov - pritisni gumb "Prikaži"';
   C_EXCEPT_MSG_DAYS_EXCEEDED = 'Razpored lahko vsebuje najveè %d dni!';
   C_EXCEPT_MSG_SELECT_DATES = 'Izberite spodnji in zgornji datum!';

   C_EXCEPT_MSG_INVALID_DATE_RANGE = 'Razpored lahko vsebuje samo datume med %s in %s';
   C_EXCEPT_MSG_NO_PLAN_ELEMENT = 'Ne morem najti planskega elementa za DDMI %d!';

   C_EXCEPT_MSG_NO_VI_RIS08 = 'Ne najdem obveze (VI_RIS_VI08). Koledar ni nastavljen ali oseba nima reg. skupine.';
   C_EXCEPT_MSG_SELECT_OWNER = 'Izbrati morate lastnika!';

   C_EXCEPT_MSG_MAX_DDMI_LIMIT = 'Napaka: Presegli ste dovoljeno število DDMI (max=%d, n=%d)';
   C_EXCEPT_MSG_MAX_OSEB_LIMIT = 'Napaka: Presegli ste dovoljeno število oseb (max=%d, n=%d)';
   C_EXCEPT_MSG_MAX_PLAN_DDMI_LIMIT = 'Napaka: Presegli ste dovoljeno število planiranih DDMI (datum=%s, max=%d, n=%d)';
   C_EXCEPT_MSG_MAX_PLAN_OSEBE_LIMIT = 'Napaka: Presegli ste dovoljeno število oseb na planiranem DDMI (datum=%s, DDMI=%d, max=%d, n=%d)';
   C_EXCEPT_MSG_NO_SOLUTION = 'Problem nima rešitve. (Datum=%s, DDMI=%s, Potrebno=%d, Razpoložljivo=%d).';
   C_EXCEPT_MSG_NO_SOLUTION_SUM = 'Problem nima rešitve. (Datum=%s, Skupno potrebno število oseb =%d, Skupaj na voljo=%d).';
   C_EXCEPT_MSG_NO_DDMI_ODSOT = 'Ne najdem DDMI za odsotnost! (MNR=%d Datum=%s)';
   C_EXCEPT_MSG_NO_DDMI_RAZP = 'Ne najdem DDMI razporeda! (MNR=%d, Datum=%s Delovišèe=%d, DM=%d, Izmena=%d)';

   // exceptions on form fmDepart
   C_EXCEPT_MSG_SUBDEPART_EXIST = 'Izbrani oddelek vsebuje pododdelke. Brisanje ni možno';

   // exceptions on form fmRazpDemOpt
   C_EXCEPT_MSG_SELECT_DM = 'Prosim izberite vsaj eno delovno mesto!';
   C_EXCEPT_MSG_SELECT_DATE_FROM_DM = 'Prosim izberite zaèetek veljavnosti!';

   // exceptions on form fmPass
   C_EXCEPT_MSG_OLD_PASSWORD_WRONG = 'Staro geslo ni pravilno!';
   C_EXCEPT_MSG_NEW_PASSWORD_DONT_MATCH = 'Preverjanje novega gesla ni uspelo - ponovite vnos!';
   C_EXCEPT_MSG_NEW_PASSWORD_SAME = 'Novo geslo je enako staremu. Prosim, vtipkajte drugaèno geslo.';

   // exceptions on registry handling
   C_EXCEPT_REGISTRY_OPEN = 'Napaka pri odpiranju registra! Kljuè = %s';

   // Display messages
   C_PROGRESS_INFO_INIT =  'Priprava v teku, prosim, poèakajte...';
   C_PROGRESS_INFO_AVAILABILITY_LOAD = 'Pripravljam podatke o razpoložljivosti osebja, prosim, poèakajte...';
   C_PROGRESS_INFO_CALENDAR_LOAD = 'Pripravljam podatke o delovnem koledarju, prosim, poèakajte...';
   C_PROGRESS_INFO_RAZPORED_LOAD = 'Berem podatke o razporedu, prosim, poèakajte...';
   C_PROGRESS_INFO_GRID_PREPARE = 'Pripravljam tabelo za prikaz, prosim, poèakajte...';
   C_PROGRESS_INFO_DATA_SHOW = 'Prikazujem podatke, prosim, poèakajte...';
   C_PROGRESS_INFO_GRID_SIZE = 'Nastavljam širine stolpcev, prosim, poèakajte...';
   C_PROGRESS_INFO_SOLVER_CHECK = 'Preverjam omejitve, prosim, poèakajte...';
   C_PROGRESS_INFO_SOLVER_CHECK_RUN = 'Preverjam rešljivost problema, prosim, poèakajte...';
   C_PROGRESS_INFO_SOLVING = 'Razreševanje v teku, prosim, poèakajte...';

   C_FMDEPART_MSG_DELETEODDELEKVGLOBINO  = 'Napaka pri brisanju org.enote! Verjetno obstajajo zapisi v ostalih tabelah.' ;
   C_FMDEPART_MSG_SBCANCELCLICK =  'Pozor! Nastale spremembe bodo izgubljene! Nadaljujem?';
   C_FMDEPART_MSG_SBDELETECLICK =  'Pozor! Ali naj zares izbrišem org. enoto?';
   C_FMEMPDETAIL_MSG_CONFIRM =  'Pozor! Nastale spremembe bodo izgubljene! Nadaljujem?';
   C_FMEMPDETAIL_ERROR_DELETEEMPLOYEE = 'Napaka pri brisanju delavca! Verjetno obstajajo zapisi v ostalih tabelah.';
   C_FMEMPDETAIL_MSG_BBDELETECARDCLICK = 'Pozor! Ali naj zares izbrišem delavca?';

   C_FMKOPIRAJPLAN_EXCEPTION_BBOKCLICKDATEDOWN = 'Vnesi datumsko spodnjo mejo!';
   C_FMKOPIRAJPLAN_EXCEPTION_BBOKCLICKDATEUP  = 'Vnesi datumsko zgornjo mejo!' ;
   C_FMKOPIRAJPLAN_MSG_BBOKCLICK = 'Pozor! Stari plan bo izbrisan! Nadaljujem?';
   C_FMKOPIRAJPLAN_MSG_BBOKCLICKGEN = 'Generiranje je uspelo!';
   C_FMKOPIRAJPLAN_MSG_BBOKCLICKGENERR = 'Napaka pri generiranju plana!';
   C_FMDEPART_MSG_SHEMA = 'Nobena shema ni izbrana!';

   C_FMPASS_GESLO_SPREMENJENO_OK = 'Geslo je bilo spremenjeno.';
   C_FMPASS_GESLO_SPREMENJENO_ERR = 'Napaka pri spremembi gesla.';

   C_FMPLANDELO_PLAN_NOT_ACTIVE = 'Pozor! Plan ni bil naložen. Vsi podatki bodo izbrisani. Nadaljujem?';
   C_FMPLANDELO_PLAN_EMPTY = 'Pozor! Plan je prazen. Prejšnji podatki bodo izbrisani. Nadaljujem?';
   C_FMPLANDELO_LOAD_NOT_MINI = 'Pozor! Sprožili boste neminimiziran prikaz obstojeèega plana! Operacija lahko traja veè minut. Nadaljujem?';

   C_FMMAIN_PONASTAVI_VSE = 'Pozor! Ponastavili boste vse shranjene parametre (barve, filtre, grupiranja). Nadaljujem?';

   C_FMRAZPDEMOPT_DODELITEV_OK = 'Dodelitev delovnih mest je uspela!';

   C_FMRAZPOSEB_MINIMIZE_PLAN = 'Prilagodim-zmanjšam plan?';
   C_FMRAZPOSEB_SKIP_DAY = 'Preskoèim problematièni dan?';
   C_FMRAZPOSEB_RAZPORED_DIRTY = 'Pozor! Nastale spremembe bodo izgubljene! Nadaljujem?';
   C_FMRAZPOSEB_RAZPORED_EXISTS = 'Na datum %s za osebo %s razpored že obstaja! Ta oseba na ta dan ne bo upoštevana v vašem razporedu!';
   C_FMRAZPOSEB_ERROR_DELETE_ODSOT = 'Napaka med brisanjem odsotnosti iz urne liste! Datum = %s, Oseba = %s  Napaka = %s!';

   C_FMRAZPOSEB_DAY_SKIPED = ' Dan je bil izvzet iz razreševanja.';
   C_FMRAZPOSEB_PLAN_MINIMIZED = ' Potrebno število osebja je bilo zmanjšano.';
// REGISTRY KEY ENTRIES
   C_REGISTRY_KEYNAME_BASE = 'Software\Cetrta Pot\RIS4';
   C_REGISTRY_KEYNAME_ARGUI = 'Programs\ARGUI';

implementation

end.
