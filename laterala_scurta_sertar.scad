include <variabile.scad>

module obiectDeBaza() {
    latimeLateralaScurta = latime_fund_sertar - 2*adancime_slot_sertar - 2*toleranta_pereti_sertar - 2*grosime_laterale_sertar;
    inlatimeLateralaScurta = inaltime_utila_segment_dulap-toleranta_inaltime_sertar;
    echo("---");
    echo("LATERALA SCURTA SERTAR");
    echo("latime LateralaScurta:", latimeLateralaScurta);
    echo("inaltime LateralaScurta:", inlatimeLateralaScurta);
    translate([0,0, -grosime_laterale_sertar/2])
        cube([latimeLateralaScurta, inlatimeLateralaScurta ,grosime_laterale_sertar], true);
}

module gauraManer() {
    if(1==gaura_maner) {
        translate([0,0,-grosime_laterale_sertar/2])
            cylinder(h=grosime_laterale_sertar, r=diametru_gaura_maner/2, center=true);
    } else {
    }
}


difference() {
    obiectDeBaza();
    gauraManer();
}
