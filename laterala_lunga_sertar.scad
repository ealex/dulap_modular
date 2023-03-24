include <variabile.scad>

module obiectDeBaza() {
    translate([0,0, -grosime_laterale_sertar/2])
        cube([adancime_fund_sertar, inaltime_utila_segment_dulap ,grosime_laterale_sertar], true);
}


module gauriInLaterala() {
    if(1==numar_gauri_fixare_laterala_lunga_in_scurta) {
        translate([adancime_fund_sertar/2-grosime_laterale_sertar/2,0,-grosime_laterale_sertar/2])
            cylinder(h=grosime_laterale_sertar, r=diametru_gauri_holzsurub/2, center=true);
    } else {
    }
}


difference() {
    obiectDeBaza();
    gauriInLaterala();
    mirror([1,0,0]) gauriInLaterala();
}
