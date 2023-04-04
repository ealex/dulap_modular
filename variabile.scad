//parametrii generali
latime_exterioara_dulap = 500; //mm
adancime_exterioara_dulap = 500; //mm
inaltime_utila_segment_dulap = 90; //inaltimea utila minima
numar_segmente_dulap = 4;

//definitii legate de materiale
grosime_exterior_dulap = 15;
grosime_fund_sertar = 15;
grosime_laterale_sertar = 15;

//gauri de surub si cap surub
diametru_gauri_holzsurub = 3;
diametru_gauri_surub = 6.1;
diametru_cap_surub = 12;
adancime_cap_surub = 5;

// dimensiuni slot-uri
grosime_slot_sertar = grosime_fund_sertar + 1; //1mm toleranta
adancime_slot_sertar = 6;

/*
    variabile specifice dulapului exterior
*/
//variabile specifice lateralei de dulap
inaltime_initiala = 1;// primul slot pleaca putin deasupra fundului
inaltime_segment_dulap = inaltime_utila_segment_dulap + grosime_slot_sertar;
inaltime_laterala = 2*grosime_exterior_dulap + inaltime_initiala + inaltime_segment_dulap*numar_segmente_dulap;
echo();
echo("inaltime_segment_dulap: ",inaltime_segment_dulap);
echo("inaltime_laterala: ",inaltime_laterala);
echo();

numar_suruburi_capace_sus_jos = 5;
offset_suruburi_capace_sus_jos = 30; // de la marginea placii la centrul primei gauri
//distanta_fata_de_centru_gauri_laterale = 100;
distanta_fata_de_centru_gauri_laterale =adancime_exterioara_dulap/3;
pozitie_gauri_de_sus = 2; // sloturi
pozitie_gauri_de_jos = 1; // sloturi


//variabile specifice capacelor de sus si jos
adancime_capac_sus_jos = adancime_exterioara_dulap; //mm
latime_capac_sus_jos = latime_exterioara_dulap - 2*grosime_exterior_dulap;
numar_suruburi_capac_fund = 5; // in cate suruburi fixez fundul
offset_suruburi_fund = 30; // de la marginea bucatii la centrul primei gauri
distanta_suruburi_fixare_module_sus_jos = adancime_capac_sus_jos/3; //mm

gauri_fixare_picioare = true;
distanta_gauri_picioare_centru_centru = 50;
latime_suport_picioare = 80;
offset_fata = 30; // de la marginea din fata 
offset_laterala = 30; // de la peretele lateral


//variabile specifice fundului de dulap
distanta_suruburi_fixare_fund = 100; //mm or undef if not required
adancime_fund = inaltime_laterala - 2*grosime_exterior_dulap;
latime_fund = latime_exterioara_dulap - 2*grosime_exterior_dulap;




/*
    variabile specifice sertarelor
*/
toleranta_fund_sertar_laterale = 1;//mm - se imparte la 2 pt cele 2 margini
toleranta_adangime_fund_sertar = 0.5;//mm - sertarul e putin mai scurt
toleranta_pereti_sertar = 0.5; // de fiecare parte, intre dulap si sertar
adancime_maner_fund_sertar = 20;// cat iese manerul in afara
latime_maner_fund_sertar = 80;
raza_rotunjire_maner_fund_sertar=5;

// gauri folosite la ansamblarea sertarului
diametru_gauri_aliniere_margini_sertar=3;
foloseste_pini_aliniere_laterala_lunga = true;
numar_gauri_aliniere_laterala_lunga=3;
offset_gauri_aliniere_laterala_lunga=40;
foloseste_pini_aliniere_laterala_scurta = true;
numar_gauri_aliniere_laterala_scurta=3;
offset_gauri_aliniere_laterala_scurta=30;

// dimensiunile fundului de sertar
adancime_fund_sertar = adancime_capac_sus_jos-grosime_exterior_dulap-toleranta_adangime_fund_sertar;
// e echivalenta cu latimea capacelor sus/jos + adancime sloturi - toleranta in lateral
latime_fund_sertar = (latime_exterioara_dulap - 2*grosime_exterior_dulap) + 2*adancime_slot_sertar - toleranta_fund_sertar_laterale;

// parametrii pentru gaurile ce fixeaza laterala lunga in fundul de sertar
gauri_fixare_laterala_lunga_sertar = true; // pune false ca sa dispara gaurile
offset_gauri_laterala_lunga_fund_sertar = 20;// de la margini, locatia primei gauri
numar_gauri_laterala_lunga_fund_sertar = 3; // numar impar neaparat, >1
assert(numar_gauri_laterala_lunga_fund_sertar>1, "numar_gauri_laterala_lunga_fund_sertar trebuie sa fie mai mare ca 1");
assert(1==numar_gauri_laterala_lunga_fund_sertar%2,"numar_gauri_laterala_lunga_fund_sertar trebuie sa fie un numar impar");

// parametrii pentru gaurile ce fixeaza laterala scurta in fundul de sertar
gauri_fixare_laterala_scurta_sertar = true; // pune false ca sa dispara
offset_gauri_laterala_scurta_fund_sertar = 20;
numar_gauri_laterala_scurta_fund_sertar = 3;
assert(numar_gauri_laterala_scurta_fund_sertar>1,"numar_gauri_laterala_scurta_fund_sertar trebuie sa fie mai mare ca 1");
assert(1==numar_gauri_laterala_scurta_fund_sertar%2,"numar_gauri_laterala_scurta_fund_sertar trebuie sa fie numar impar");

// parametrii pentru laterala lunga de sertar
numar_gauri_fixare_laterala_lunga_in_scurta = 1; // 1 sau numar impar
offset_gauri_laterala_lunga_in_scurta = 0;
assert(1==numar_gauri_fixare_laterala_lunga_in_scurta%2, "numar_gauri_fixare_laterala_lunga_in_scurta trebuie sa fie numar impar");

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