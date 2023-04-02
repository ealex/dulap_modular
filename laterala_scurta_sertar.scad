include <variabile.scad>

module obiectDeBaza() {
    latimeLateralaScurta = latime_fund_sertar - 2*adancime_slot_sertar - 2*toleranta_pereti_sertar - 2*grosime_laterale_sertar;
    translate([0,0, -grosime_laterale_sertar/2])
        cube([latimeLateralaScurta, inaltime_utila_segment_dulap ,grosime_laterale_sertar], true);
}



obiectDeBaza();
