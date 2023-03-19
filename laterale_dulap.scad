include <variabile.scad>

/* 
    creez laterala cu interiorul in sus
    ca sa nu fie nevoie sa o mai manevrez 
    obiectul de baza e de la 0 in jos
*/
module obiectDeBaza() {
    translate([0,0, -grosime_exterior_dulap/2])
        cube([adancime_exterioara_dulap, inaltime_laterala ,grosime_exterior_dulap], true);
}

// sloturile pentru canalele sertarelor
module sloturiCanale() {
    pozitie_primul_slot = -1 * (inaltime_laterala/2 - grosime_exterior_dulap - inaltime_initiala);
    echo(pozitie_primul_slot);
    for( cnt  = [0 : 1: numar_segmente_dulap-1] ) {
        pozitie_slot = pozitie_primul_slot + inaltime_segment_dulap * cnt;
        translate([-(adancime_exterioara_dulap)/2,pozitie_slot,-adancime_slot_sertar])
            // slotul iese putin din suprafata
            // ca diferenta sa fie clara
            cube([adancime_exterioara_dulap, grosime_slot_sertar, adancime_slot_sertar]);
    }
}


/* 
    gaurile pentru holzsuruburi, pe lateralele lungi
    pun cate o gaura in fiecare slot, sa fiu sigur ca am structura
    suficient de rezistenta
*/
module gauriSuruburiLateraleLungi( pozitieCentru = 0 ) {
    pozitie_prima_gaura = -1*(inaltime_laterala/2 - grosime_exterior_dulap -  inaltime_initiala-grosime_slot_sertar-inaltime_utila_segment_dulap/2);
    for( cnt  = [0 : 1: numar_segmente_dulap-1] ) {
        pozitie_gaura = pozitie_prima_gaura + inaltime_segment_dulap*cnt;
        translate([pozitieCentru, pozitie_gaura, -grosime_exterior_dulap/2])
            cylinder(h = grosime_exterior_dulap, r=diametru_gauri_holzsurub/2, center = true);
    }
}


/*
*/
module gauriSuruburiCapaceSusJos( pozitieCentru = 0 ){
    distantaUtila = adancime_exterioara_dulap - 2*offset_suruburi_capace_sus_jos;
    
    pozitieInitiala = -1*(adancime_exterioara_dulap/2-offset_suruburi_capace_sus_jos);
    
    increment = distantaUtila/(numar_suruburi_capace_sus_jos-1);
    
    for(cnt=[0:numar_suruburi_capace_sus_jos-1]) {
        pozitieX = pozitieInitiala + cnt*increment;
        translate([pozitieX, pozitieCentru, -grosime_exterior_dulap/2])
            cylinder(h=grosime_exterior_dulap, r=diametru_gauri_holzsurub/2, center=true);
    }
}


/*
    defineste gaurile de prindere intre module pe laterale.
    
*/
module gauriSuruburiFixareLaterala() {
    // fata de muchia de sus
    pozitie_de_sus = (inaltime_laterala/2 - grosime_exterior_dulap - pozitie_gauri_de_sus*inaltime_segment_dulap + grosime_slot_sertar + inaltime_utila_segment_dulap/2);
    
    translate([distanta_fata_de_centru_gauri_laterale/2,pozitie_de_sus,0])
        gauraCompusaLaterala();
    translate([-1*distanta_fata_de_centru_gauri_laterale/2,pozitie_de_sus,0])
        gauraCompusaLaterala();
    
    // fata de muchia de jos
    pozitie_de_jos = -1*(inaltime_laterala/2 - grosime_exterior_dulap - inaltime_initiala - pozitie_gauri_de_jos*inaltime_segment_dulap + inaltime_utila_segment_dulap/2);
    translate([distanta_fata_de_centru_gauri_laterale/2,pozitie_de_jos,0])
        gauraCompusaLaterala();
    translate([-1*distanta_fata_de_centru_gauri_laterale/2,pozitie_de_jos,0])
        gauraCompusaLaterala();
    
}

/*
    aici se compune obiectul final
    este o diferenta dintre obiectul de baza si toate gaurile
    pentru suruburi si pentru sertar
*/
difference() {
    obiectDeBaza();
    sloturiCanale();
    
    // gauri pentru capacul din fund, 2 seturi, pentru a face lateralele simetrice
    gauriSuruburiLateraleLungi( -1*(adancime_exterioara_dulap/2-grosime_exterior_dulap/2));
    gauriSuruburiLateraleLungi(adancime_exterioara_dulap/2-grosime_exterior_dulap/2);
    
    // gauri pentru capacele de sus si de jos
    gauriSuruburiCapaceSusJos(-1*(inaltime_laterala/2-grosime_exterior_dulap/2));
    gauriSuruburiCapaceSusJos((inaltime_laterala/2-grosime_exterior_dulap/2));
    
    // gaurile pentru suruburile de fixare
    gauriSuruburiFixareLaterala();
}
