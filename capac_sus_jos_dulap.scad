include <variabile.scad>

/*
    obiectul de baza, din care incep sa scad diferite feature-uri
*/
module obiectDeBaza() {
    echo("OBIECT DE BAZA");
    echo("latime_capac_sus_jos", latime_capac_sus_jos);
    echo("adancime_capac_sus_jos", adancime_capac_sus_jos);
    echo("");
    translate([0,0, -grosime_exterior_dulap/2])
        cube([adancime_capac_sus_jos, latime_capac_sus_jos ,grosime_exterior_dulap], true);
}


/*
    gaurile de fixare dintre capace si fundul dulapului
    gaurile sunt simetrice, pentru a avea o piesa simetrica
*/
module gauriSurubPentruFund(pozitieCentru = 0){
    pozitieInitiala = -1*(latime_capac_sus_jos/2 - offset_suruburi_fund);
    distantaUtila = latime_capac_sus_jos - 2*offset_suruburi_fund;
    pas = distantaUtila / (numar_suruburi_capac_fund-1);
    for(cnt=[0:1:numar_suruburi_capac_fund-1]) {
        pozitieY = pozitieInitiala + cnt * pas;
        translate([pozitieCentru,pozitieY,-grosime_exterior_dulap/2])
            cylinder(h=grosime_exterior_dulap,r=diametru_gauri_holzsurub/2, center=true);
    }
}


/*
    aici se formeaza gaurile de prindere
    gaurile sunt simetrice in jurul 0-ului
*/
module gauriSuruburiFixareSusJos() {
    translate([-distanta_suruburi_fixare_module_sus_jos/2,-distanta_suruburi_fixare_module_sus_jos/2,0])
        gauraCompusaLaterala();
    translate([distanta_suruburi_fixare_module_sus_jos/2,distanta_suruburi_fixare_module_sus_jos/2,0])
        gauraCompusaLaterala();
    translate([distanta_suruburi_fixare_module_sus_jos/2,-distanta_suruburi_fixare_module_sus_jos/2,0])
        gauraCompusaLaterala();
    translate([-distanta_suruburi_fixare_module_sus_jos/2,distanta_suruburi_fixare_module_sus_jos/2,0])
        gauraCompusaLaterala();
}

module gauriFixarePicioare() {
    centru_fata_de_x = adancime_capac_sus_jos/2 - (offset_fata + latime_suport_picioare/2);
    centru_fata_de_y = latime_capac_sus_jos/2 - (offset_laterala + latime_suport_picioare/2);
    
    translate([centru_fata_de_x + distanta_gauri_picioare_centru_centru/2, centru_fata_de_y+ distanta_gauri_picioare_centru_centru/2,0])
        gauraCompusaLaterala();
    
    translate([centru_fata_de_x - distanta_gauri_picioare_centru_centru/2, centru_fata_de_y- distanta_gauri_picioare_centru_centru/2,0])
        gauraCompusaLaterala();
    
    translate([centru_fata_de_x + distanta_gauri_picioare_centru_centru/2, centru_fata_de_y - distanta_gauri_picioare_centru_centru/2,0])
        gauraCompusaLaterala();
    
    translate([centru_fata_de_x- distanta_gauri_picioare_centru_centru/2, centru_fata_de_y + distanta_gauri_picioare_centru_centru/2,0])
        gauraCompusaLaterala();
}


//gauriFixarePicioare();


// compun obiectul final

difference(){
    obiectDeBaza();
    gauriSurubPentruFund(adancime_capac_sus_jos/2-grosime_exterior_dulap/2);
    gauriSurubPentruFund(-1*(adancime_capac_sus_jos/2-grosime_exterior_dulap/2));
    gauriSuruburiFixareSusJos();
    if(true==gauri_fixare_picioare) {
        gauriFixarePicioare();
        mirror([1,0,0]) gauriFixarePicioare();
        mirror([0,1,0]) gauriFixarePicioare();
        mirror([1,1,0]) gauriFixarePicioare();
    }
}
