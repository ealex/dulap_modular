include <variabile.scad>

/*
    obiectul de baza, din care incep sa scad diferite feature-uri
*/
module obiectDeBaza() {
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



// compun obiectul final
difference(){
    obiectDeBaza();
    gauriSurubPentruFund(adancime_capac_sus_jos/2-grosime_exterior_dulap/2);
    gauriSurubPentruFund(-1*(adancime_capac_sus_jos/2-grosime_exterior_dulap/2));
    gauriSuruburiFixareSusJos();
}
