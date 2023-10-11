include <variabile.scad>

/*
    fundul e mai simplu -e doar un capac cu gauri de fixare
    daca sunt definite
*/
module obiectDeBaza() {
    translate([0,0, -grosime_exterior_dulap/2])
        cube([adancime_fund, latime_fund ,grosime_exterior_dulap], true);
}


/*
    adauga si gaurile de fixare pentru fund
    se genereaza doar daca 'distanta_suruburi_fixare_fund != undef'
*/
module gauriSuruburiFixareFund() {
    if(undef != distanta_suruburi_fixare_fund) {
        translate([-distanta_suruburi_fixare_fund/2,-distanta_suruburi_fixare_fund/2,0])
            gauraCompusaLaterala();
        translate([distanta_suruburi_fixare_fund/2,distanta_suruburi_fixare_fund/2,0])
            gauraCompusaLaterala();
        translate([distanta_suruburi_fixare_fund/2,-distanta_suruburi_fixare_fund/2,0])
            gauraCompusaLaterala();
        translate([-distanta_suruburi_fixare_fund/2,distanta_suruburi_fixare_fund/2,0])
            gauraCompusaLaterala();
    }
}

// compun obiectul final
difference() {
    obiectDeBaza();
    gauriSuruburiFixareFund();
}
