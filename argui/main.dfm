�
 TFMMAIN 0�  TPF0TfmMainfmMainLeft Top� WidthHeight+CaptionARGUI ver 0.1Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style MenumnuMainOldCreateOrder	PositionpoDesktopCenter
OnActivateFormActivateOnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight 
TStatusBar
StatusBar1Left Top�WidthHeightPanelsWidth�  Width, Width2    TToolBarToolBar1Left Top WidthHeight1ButtonHeight&ButtonWidth'CaptionToolBar1ImagesfmGlobals.Images32TabOrder TToolButton	tbMaticniLeft TopHint   Matični podatki delavcevCaption   Matični podatki
ImageIndexParentShowHintShowHint	OnClickPregledzaposlenih1Click  TToolButtontbRazporeditveLeft'TopHintRazporeditve delavcevCaptionRazporeditve delavcev
ImageIndexParentShowHintShowHint	OnClickPregledrazporeditev1Click  TToolButtonToolButton1LeftNTopWidthCaptionToolButton1
ImageIndexStyletbsSeparator  TToolButtonToolButton3LeftaTopHint   Pregled plana deloviščCaptionToolButton3
ImageIndexParentShowHintShowHint	OnClickNovmeseniplan1Click  TToolButtonToolButton4Left� TopHintKopiranje planaCaptionToolButton4
ImageIndex'ParentShowHintShowHint	OnClickKopiranje1Click  TToolButtonToolButton2Left� TopHintOdsotnosti in sidranjaCaptionToolButton2
ImageIndexEParentShowHintShowHint	Visible  TToolButtonToolButton5Left� TopWidthCaptionToolButton5
ImageIndex0StyletbsSeparator  TToolButtonToolButton6Left� TopHintPregled razporedaCaptionToolButton6
ImageIndexBParentShowHintShowHint	OnClickPregledplana1Click   	TMainMenumnuMainLeft� 	TMenuItemOrganizacijskestrukture1CaptionPodjetje 	TMenuItemOrganizacijskesheme1CaptionOrganizacijske shemeOnClickOrganizacijskesheme1Click  	TMenuItemOrganizacijskeenote1CaptionOrganizacijske enoteOnClickOrganizacijskeenote1Click  	TMenuItemN2Caption-  	TMenuItemDelovnamesta1CaptionDelovna mestaOnClickDelovnamesta1Click  	TMenuItemDelovia1Caption   DeloviščaOnClickDelovia1Click  	TMenuItemDelovneizmene1CaptionDelovne izmeneOnClickDelovneizmene1Click   	TMenuItemMatinipodatki1Caption   Matični podatki 	TMenuItemPregledzaposlenih1CaptionDelavciOnClickPregledzaposlenih1Click  	TMenuItemPregledrazporeditev1CaptionRazporeditveOnClickPregledrazporeditev1Click   	TMenuItemPlaniranje1Caption
Planiranje 	TMenuItemNovmeseniplan1Caption   Urejanje mesečnega planaOnClickNovmeseniplan1Click  	TMenuItem
Kopiranje1Caption   Kopiranje mesečnega planaOnClickKopiranje1Click   	TMenuItem
Razporedi1CaptionDelovni razpored 	TMenuItemPregledplana1Caption   Mesečni razporedOnClickPregledplana1Click   	TMenuItemArsolv1CaptionArsolvVisible 	TMenuItemDDMIgenerator1CaptionDDMI generator  	TMenuItemmiDDMIGenfastCaptionDDMI generator - hitra metoda  	TMenuItemUvozrazultatov1CaptionUvoz razporeda iz ARSOLV   	TMenuItem	miArprintCaption	   Poročila  	TMenuItem	Priprava1Caption
Nastavitve 	TMenuItemmiLogonCaptionPonovna prijavaOnClickmiLogonClick  	TMenuItemmiNewPasswordCaptionSprememba geslaOnClickmiNewPasswordClick  	TMenuItemmiPonastaviCaptionPonastavitevOnClickmiPonastaviClick  	TMenuItemmiParamsCaption	ParametriOnClickmiParamsClick  	TMenuItemN1Caption-  	TMenuItem
Oprogramu1Caption
O programuOnClickOprogramu1Click    TOracleDataSet	quReportsSQL.Stringsselect    RPT_NAME,   RPT_PARAMSfrom    TA_RISHREPTwhere #    upper(RPT_EXEC) = 'ARPRINT' and/    (ORA_USER = upper(user) or  ORA_USER = '%')order by RPT_NAME QBEDefinition.QBEFieldDefs
.            RPT_NAME     
   RPT_PARAMS     SessiondmOracle.oraSessionLeft� TStringFieldquReportsRPT_NAME	FieldNameRPT_NAMERequired	Size  TStringFieldquReportsRPT_PARAMS	FieldName
RPT_PARAMSSize�     