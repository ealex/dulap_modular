//parametrii generali
latime_exterioara_dulap = 200; //mm
adancime_exterioara_dulap = 240; //mm
inaltime_utila_segment_dulap = 21; //inaltimea utila minima
numar_segmente_dulap = 6;

//definitii legate de materiale
grosime_exterior_dulap = 8;
grosime_fund_sertar = 8;
grosime_laterale_sertar = 8;

//gauri de surub si cap surub
diametru_gauri_holzsurub = 2;
diametru_gauri_surub = 6.1;
diametru_cap_surub = 12;
adancime_cap_surub = 5;

// dimensiuni slot-uri
grosime_slot_sertar = grosime_fund_sertar + 1; //1mm toleranta
adancime_slot_sertar = 3;


//variabile specifice lateralei de sertar
inaltime_initiala = 1;// primul slot pleaca putin deasupra fundului
inaltime_segment_dulap = inaltime_utila_segment_dulap + grosime_slot_sertar;
inaltime_laterala = 2*grosime_exterior_dulap + inaltime_initiala + inaltime_segment_dulap*numar_segmente_dulap;

numar_suruburi_capace_sus_jos = 5;
offset_suruburi_capace_sus_jos = 8; // de la marginea placii la centrul primei gauri
distanta_fata_de_centru_gauri_laterale = 80;
pozitie_gauri_de_sus = 2; // sloturi
pozitie_gauri_de_jos = 2; // sloturi


//variabile specifice capacelor de sus si jos
adancime_capac_sus_jos = adancime_exterioara_dulap; //mm
latime_capac_sus_jos = latime_exterioara_dulap - 2*grosime_exterior_dulap;
numar_suruburi_capac_fund = 5; // in cate suruburi fixez fundul
offset_suruburi_fund = 8; // de la marginea bucatii la centrul primei gauri
distanta_suruburi_fixare_module_sus_jos = 100; //mm


//variabile specifice fundului de dulap
distanta_suruburi_fixare_fund = 100; //mm or undef if not required
adancime_fund = inaltime_laterala - 2*grosime_exterior_dulap;
latime_fund = latime_exterioara_dulap - 2*grosime_exterior_dulap;

// functii auxiliare
/*
    formeaza obiectul ce contine capul de surub si surubul
    obiectul se scade din placa de baza
*/
module gauraCompusaLaterala() {
    union() {
        translate([0,0,-adancime_cap_surub/2])
            cylinder(h=adancime_cap_surub, r=diametru_cap_surub/2, center=true);
        translate([0,0,-grosime_exterior_dulap/2])
            cylinder(h=grosime_exterior_dulap , r=diametru_gauri_surub/2,center=true);
    }
}