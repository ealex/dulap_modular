include <variabile.scad>

/*
    obiectul de baza include manerul
*/
module obiectDeBaza() {
    union() {
        translate([0,0, -grosime_fund_sertar/2])
            cube([adancime_fund_sertar, latime_fund_sertar ,grosime_fund_sertar], true);
        translate([adancime_fund_sertar/2+adancime_maner_fund_sertar/2,0,-grosime_fund_sertar/2])
            cube([adancime_maner_fund_sertar, latime_maner_fund_sertar, grosime_fund_sertar],true);
    }
}


/*
    blocul asta formeaza niste fillet-uri mici in colturile vizibile
*/
module piesaRotunjireExteriorManer() {
    translate([adancime_fund_sertar/2+adancime_maner_fund_sertar-raza_rotunjire_maner_fund_sertar,latime_maner_fund_sertar/2-raza_rotunjire_maner_fund_sertar,-grosime_fund_sertar/2])
        difference() {
            translate([0,0,-grosime_fund_sertar/2])
            cube([raza_rotunjire_maner_fund_sertar,raza_rotunjire_maner_fund_sertar, grosime_fund_sertar]);
            cylinder(h = grosime_fund_sertar, r=raza_rotunjire_maner_fund_sertar, center=true);
        }
}

module piesaRotunjireInteriorManer() {
    translate([adancime_fund_sertar/2+raza_rotunjire_maner_fund_sertar, latime_maner_fund_sertar/2+raza_rotunjire_maner_fund_sertar, -grosime_fund_sertar/2])
    rotate([0,0,-180])
    difference() {
        translate([0,0,-grosime_fund_sertar/2])
        cube([raza_rotunjire_maner_fund_sertar, raza_rotunjire_maner_fund_sertar, grosime_fund_sertar]);
        cylinder(h = grosime_fund_sertar, r=raza_rotunjire_maner_fund_sertar, center=true);
        
    }
}


/*
    sirul de gauri pentru laterala lunga
*/
module gauriLateralaLungaFundSertar() {
    // aici stabilesc unde vine linia suruburilor
    offsetY = latime_fund_sertar/2 - adancime_slot_sertar - toleranta_pereti_sertar - grosime_laterale_sertar/2;
    lungimeUtilizabila = adancime_fund_sertar-2*offset_gauri_laterala_lunga_fund_sertar;
    pas = lungimeUtilizabila/(numar_gauri_laterala_lunga_fund_sertar-1);
    for(cnt=[0:1:numar_gauri_laterala_lunga_fund_sertar-1]) {
        pozitieX = -1*(adancime_fund_sertar/2-offset_gauri_laterala_lunga_fund_sertar) + cnt*pas;
        translate([pozitieX,offsetY,-grosime_fund_sertar/2])
        cylinder(h=grosime_fund_sertar, r=diametru_gauri_holzsurub/2, center=true);
    }
}

/*
    sirul de gauri pentru laterala scurta
*/
module gauriLateralaScurtaFundSertar() {
    offsetX = adancime_fund_sertar/2 - grosime_laterale_sertar/2;
    lungimeUtilizabila = latime_fund_sertar - 2*offset_gauri_laterala_scurta_fund_sertar;
    pas = lungimeUtilizabila / (numar_gauri_laterala_scurta_fund_sertar-1);
    for(cnt=[0:1:(numar_gauri_laterala_scurta_fund_sertar-1)]) {
        pozitieY = -1*(latime_fund_sertar/2-offset_gauri_laterala_scurta_fund_sertar) + pas *cnt;
        translate([offsetX,pozitieY,-grosime_fund_sertar/2])
        cylinder(h=grosime_fund_sertar, r=diametru_gauri_holzsurub/2, center=true);
    }
}


/*
    setul de gauri care e folosit pentru alinierea lateralelor

    numar_gauri_aliniere_laterala_scurta=3;
    offset_gauri_aliniere_laterala_scurta=50;
*/
module gauriAliniereLateralaLungaLaMontare() {
    offsetY = latime_fund_sertar/2 - adancime_slot_sertar - toleranta_pereti_sertar - grosime_laterale_sertar - diametru_gauri_aliniere_margini_sertar/2;
    distantaUtila = adancime_fund_sertar-2*offset_gauri_aliniere_laterala_lunga;
    pas = distantaUtila / (numar_gauri_aliniere_laterala_lunga-1);
    for(cnt=[0:1:(numar_gauri_aliniere_laterala_lunga-1)]) {
        pozitieX = -1*(adancime_fund_sertar/2 - offset_gauri_aliniere_laterala_lunga) + pas*cnt;
        translate([pozitieX,offsetY,-grosime_fund_sertar/2])
            cylinder(h=grosime_fund_sertar, r=diametru_gauri_aliniere_margini_sertar/2, center=true);
    }
}


module gauriAliniereLateralaScurtaLaMontare() {
    pozitieX = -adancime_fund_sertar/2 + grosime_laterale_sertar+diametru_gauri_aliniere_margini_sertar/2;
    distantaUtila = latime_fund_sertar - 2*offset_gauri_aliniere_laterala_scurta;
    pas = distantaUtila / (numar_gauri_aliniere_laterala_lunga-1);
    for(cnt=[0:1:(numar_gauri_aliniere_laterala_lunga-1)]) {
        pozitieY = -1*(latime_fund_sertar/2-offset_gauri_aliniere_laterala_scurta) + cnt*pas;
        translate([pozitieX,pozitieY,-grosime_fund_sertar/2])
            cylinder(h=grosime_fund_sertar, r=diametru_gauri_aliniere_margini_sertar/2, center=true);
    }
}




difference() {
    union() {
        obiectDeBaza();
        piesaRotunjireInteriorManer();
        mirror([0,1,0]) piesaRotunjireInteriorManer();
    }
    piesaRotunjireExteriorManer();
    mirror([0,1,0]) piesaRotunjireExteriorManer();
    if(true==gauri_fixare_laterala_lunga_sertar) {
        gauriLateralaLungaFundSertar();
        mirror([0,1,0]) gauriLateralaLungaFundSertar();
    }
    if(true == gauri_fixare_laterala_scurta_sertar) {
        gauriLateralaScurtaFundSertar();
        mirror([1,0,0]) gauriLateralaScurtaFundSertar();
    }
    if(true == foloseste_pini_aliniere_laterala_lunga) {
        gauriAliniereLateralaLungaLaMontare();
        mirror([0,1,0]) gauriAliniereLateralaLungaLaMontare();
    }
    if(true ==foloseste_pini_aliniere_laterala_scurta) {
        gauriAliniereLateralaScurtaLaMontare();
        mirror([1,0,0]) gauriAliniereLateralaScurtaLaMontare();
    }
}

