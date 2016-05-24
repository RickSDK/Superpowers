//
//  Board.m
//  Superpowers
//
//  Created by Rick Medved on 2/24/13.
//
//

#import "Board.h"

@implementation Board


+(int)getNationFromId:(int)terrId {
    NSString *terr = [Board getTerrDetailsFromId:terrId];
    NSArray *components = [terr componentsSeparatedByString:@"|"];
    if([components count]>4)
        return [[components objectAtIndex:4] intValue];
    
    return 0;
}

+(NSString *)getNationNameFromId:(int)terrId {
    NSString *terr = [Board getTerrDetailsFromId:terrId];
    NSArray *components = [terr componentsSeparatedByString:@"|"];
    if([components count]>4)
        return [components objectAtIndex:2];
    
    return nil;
}

+(NSString *)getSuperpowerNameFromId:(int)nation {
    NSArray *names = [NSArray arrayWithObjects:
                      @"Empty",
                      @"United States",
                      @"European Union",
                      @"Russian Republic",
                      @"Imperial Japan",
                      @"Communist China",
                      @"Middle-East Federation",
                      @"African Coalition",
                      @"Latin Alliance",
                      nil];
    return [names objectAtIndex:nation];
}

+(NSString *)getTechnologyNameFromId:(int)techId {
    NSArray *names = [NSArray arrayWithObjects:
                      @"Empty",
                      @"Stealth",
                      @"AGM Maverick Missiles",
                      @"Advanced Radar",
                      @"Rocketry",
                      @"Chemical Warheads",
                      @"Anthrax Warheads",
                      @"Homing Torpedoes",
                      @"Cruise Missiles",
                      @"BGM Tomahawk Missiles",
                      @"Factory Automation",
                      @"Mass Production",
                      @"Industry",
                      @"Heavy Bombers",
                      @"Smart Bombs",
                      @"Nuclear Warheads",
                      @"Long Range Aircraft",
                      @"Air Defense Shield",
                      @"Mobility",
                      nil];
    return [names objectAtIndex:techId];
}

+(NSArray *)getNationsForSuperpower:(int)nation {
    NSArray *allNations = [Board getNationArray];
    NSMutableArray *nations = [[NSMutableArray alloc] initWithCapacity:10];
    for(NSString *nationStr in allNations) {
        NSArray *components = [nationStr componentsSeparatedByString:@"|"];
        if([[components objectAtIndex:4] intValue]==nation)
            [nations addObject:[components objectAtIndex:2]];
    }
    return nations;
}

+(NSArray *)getNationArray {
    return [NSArray arrayWithObjects:@"|0|Empty|0.gif|0|",
            @"|1|Eastern USA|usa.gif|1|",
            @"|2|Central USA|usa.gif|1|",
            @"|3|Midwest USA|usa.gif|1|",
            @"|4|Western USA|usa.gif|1|",
            @"|5|Alaska|usa.gif|1|",
            @"|6|Hawaii|usa.gif|1|",
            @"|7|Germany|eu.gif|2|",
            @"|8|France|eu.gif|2|",
            @"|9|Spain|eu.gif|2|",
            @"|10|United Kingdom|eu.gif|2|",
            @"|11|Sweden Finland|eu.gif|2|",
            @"|12|Southern Europe|eu.gif|2|",
            @"|13|Russia|rr.gif|3|",
            @"|14|Karelia|rr.gif|3|",
            @"|15|Chechnya|rr.gif|3|",
            @"|16|Caucasus|rr.gif|3|",
            @"|17|Kazakhstan|rr.gif|3|",
            @"|18|Taimyr|rr.gif|3|",
            @"|19|Novosibirsk|rr.gif|3|",
            @"|20|Siberia|rr.gif|3|",
            @"|21|Japan|jap.gif|4|",
            @"|22|Far East|jap.gif|4|",
            @"|23|Okhotsk|jap.gif|4|",
            @"|24|Manchuria|jap.gif|4|",
            @"|25|Peiping|jap.gif|4|",
            @"|26|Taiwan|jap.gif|4|",
            @"|27|Marshall Islands|jap.gif|4|",
            @"|28|Indo-China|chi.gif|5|",
            @"|29|Tibet|chi.gif|5|",
            @"|30|China|chi.gif|5|",
            @"|31|Hong Kong|chi.gif|5|",
            @"|32|Philippines|chi.gif|5|",
            @"|33|Borneo|chi.gif|5|",
            @"|34|Indonesia|chi.gif|5|",
            @"|35|Saudi Arabia|arab.gif|6|",
            @"|36|Turkey|arab.gif|6|",
            @"|37|Syria-Iraq|arab.gif|6|",
            @"|38|Iran|arab.gif|6|",
            @"|39|Afghan-Pakistan|arab.gif|6|",
            @"|40|Egypt|arab.gif|6|",
            @"|41|Libya|arab.gif|6|",
            @"|42|Congo|afr.gif|7|",
            @"|43|West Africa|afr.gif|7|",
            @"|44|Nigeria|afr.gif|7|",
            @"|45|Chad|afr.gif|7|",
            @"|46|Sudan|afr.gif|7|",
            @"|47|Ethiopia|afr.gif|7|",
            @"|48|Kenya|afr.gif|7|",
            @"|49|South Africa|afr.gif|7|",
            @"|50|Brazil|lat.gif|8|",
            @"|51|Mexico|lat.gif|8|",
            @"|52|Panama|lat.gif|8|",
            @"|53|Venezuela|lat.gif|8|",
            @"|54|Peru|lat.gif|8|",
            @"|55|Argentina|lat.gif|8|",
            @"|56|British Columbia|nue.gif|10|",
            @"|57|Central Canada|nue.gif|10|",
            @"|58|Quebec|nue.gif|10|",
            @"|59|Greenland|nue.gif|10|",
            @"|60|Iceland|nue.gif|10|",
            @"|61|Norway|nue.gif|10|",
            @"|62|Ukraine|nue.gif|10|",
            @"|63|Georgia|nue.gif|10|",
            @"|64|Mongolia|nue.gif|10|",
            @"|65|Guam|nue.gif|10|",
            @"|66|Solomon Isls|nue.gif|10|",
            @"|67|New Guinea|nue.gif|10|",
            @"|68|New Zealand|nue.gif|10|",
            @"|69|Austrailia|nue.gif|10|",
            @"|70|India|nue.gif|10|",
            @"|71|Madagascar|nue.gif|10|",
            @"|72|Mozambique|nue.gif|10|",
            @"|73|Angola|nue.gif|10|",
            @"|74|Algeria|nue.gif|10|",
            @"|75|Sierra Leone|nue.gif|10|",
            @"|76|Falkland Isls|nue.gif|10|",
            @"|77|Bolivia|nue.gif|10|",
            @"|78|Cuba|nue.gif|10|",
            @"|79|Alaska Waters|water.gif|99|",
            @"|80|Gulf of Alaska|water.gif|99|",
            @"|81|North Pacific Waters|water.gif|99|",
            @"|82|Western USA Waters|water.gif|99|",
            @"|83|Hawaii Waters|water.gif|99|",
            @"|84|S Hawaii Waters|water.gif|99|",
            @"|85|W. Mexico Waters|water.gif|99|",
            @"|86|W. Panama Waters|water.gif|99|",
            @"|87|South Pacific NW|water.gif|99|",
            @"|88|South Pacific NE|water.gif|99|",
            @"|89|South Pacific SW|water.gif|99|",
            @"|90|South Pacific SE|water.gif|99|",
            @"|91|Peru Waters|water.gif|99|",
            @"|92|W. Argentina Waters|water.gif|99|",
            @"|93|E. Argentina Waters|water.gif|99|",
            @"|94|South Atlantic|water.gif|99|",
            @"|95|Angola Waters|water.gif|99|",
            @"|96|Congo Waters|water.gif|99|",
            @"|97|Sierra Waters|water.gif|99|",
            @"|98|Brazil Waters|water.gif|99|",
            @"|99|Cuba Waters|water.gif|99|",
            @"|100|Gulf of Mexico|water.gif|99|",
            @"|101|E USA Waters|water.gif|99|",
            @"|102|North Atlantic N|water.gif|99|",
            @"|103|North Atlantic S|water.gif|99|",
            @"|104|West Africa Waters|water.gif|99|",
            @"|105|Spain Waters|water.gif|99|",
            @"|106|Quebec Waters|water.gif|99|",
            @"|107|Labrador Sea|water.gif|99|",
            @"|108|Hudson Bay|water.gif|99|",
            @"|109|Denmark Straight|water.gif|99|",
            @"|110|North Sea|water.gif|99|",
            @"|111|Arctic W|water.gif|99|",
            @"|112|Arctic E|water.gif|99|",
            @"|113|Finland Waters|water.gif|99|",
            @"|114|Mediterraniean W|water.gif|99|",
            @"|115|Mediterraniean E|water.gif|99|",
            @"|116|Black Sea|water.gif|99|",
            @"|117|Caspian Sea|water.gif|99|",
            @"|118|Red Sea|water.gif|99|",
            @"|119|Arabian Sea|water.gif|99|",
            @"|120|Bay of Bengal|water.gif|99|",
            @"|121|Kenya Waters|water.gif|99|",
            @"|122|Mozam Waters|water.gif|99|",
            @"|123|South African Waters|water.gif|99|",
            @"|124|South Indian Ocean|water.gif|99|",
            @"|125|Indian Ocean NW|water.gif|99|",
            @"|126|Indian Ocean NE|water.gif|99|",
            @"|127|Indian Ocean SW|water.gif|99|",
            @"|128|Indian Ocean SE|water.gif|99|",
            @"|129|Timor Sea|water.gif|99|",
            @"|130|Indoneasia Waters|water.gif|99|",
            @"|131|Indo-China Waters|water.gif|99|",
            @"|132|Coral Sea|water.gif|99|",
            @"|133|New Zealand waters|water.gif|99|",
            @"|134|Borneo Waters|water.gif|99|",
            @"|135|New Guinea Waters|water.gif|99|",
            @"|136|Solomon Island Waters|water.gif|99|",
            @"|137|Philippine Waters|water.gif|99|",
            @"|138|South China Sea|water.gif|99|",
            @"|139|Taiwan Waters|water.gif|99|",
            @"|140|Marshall Waters|water.gif|99|",
            @"|141|Sea of Japan|water.gif|99|",
            @"|142|E Japan Waters|water.gif|99|",
            @"|143|Guam Waters|water.gif|99|",
            @"|144|Bering Sea|water.gif|99|",
            nil];
}

+(NSString *)getTerrDetailsFromId:(int)terrId {
    NSArray *gridTerritories = [Board getNationArray];

    int i=0;
    for(NSString *terr in gridTerritories) {
        if(i==terrId)
            return terr;
        i++;
    }
    return nil;
}

+(int)getTerrFromGrid:(int)grid {
    NSArray *gridTerritories = [NSArray arrayWithObjects:@"250",
                                @"248",
                                @"247",
                                @"205",
                                @"83",
                                @"323",
                                @"180",
                                @"218",
                                @"257",
                                @"138",
                                @"101",
                                @"261",
                                @"147",
                                @"103",
                                @"143",
                                @"145",
                                @"227",
                                @"110",
                                @"189",
                                @"113",
                                @"237",
                                @"116",
                                @"195",
                                @"234",
                                @"273",
                                @"355",
                                @"358",
                                @"391",
                                @"270",
                                @"272",
                                @"353",
                                @"394",
                                @"433",
                                @"472",
                                @"385",
                                @"263",
                                @"304",
                                @"305",
                                @"307",
                                @"342",
                                @"340",
                                @"461",
                                @"377",
                                @"419",
                                @"380",
                                @"382",
                                @"424",
                                @"463",
                                @"581",
                                @"412",
                                @"287",
                                @"328",
                                @"370",
                                @"409",
                                @"531",
                                @"125",
                                @"127",
                                @"170",
                                @"93",
                                @"58",
                                @"99",
                                @"182",
                                @"224",
                                @"232",
                                @"279",
                                @"397",
                                @"477",
                                @"558",
                                @"553",
                                @"349",
                                @"544",
                                @"542",
                                @"540",
                                @"338",
                                @"416",
                                @"572",
                                @"451",
                                @"330",
                                @"162",
                                @"163",
                                @"202",
                                @"244",
                                @"322",
                                @"363",
                                @"366",
                                @"368",
                                @"443",
                                @"446",
                                @"483",
                                @"486",
                                @"449",
                                @"529",
                                @"533",
                                @"535",
                                @"539",
                                @"458",
                                @"456",
                                @"494",
                                @"332",
                                @"288",
                                @"291",
                                @"293",
                                @"333",
                                @"335",
                                @"255",
                                @"173",
                                @"92",
                                @"91",
                                @"176",
                                @"98",
                                @"19",
                                @"23",
                                @"140",
                                @"258",
                                @"301",
                                @"262",
                                @"265",
                                @"425",
                                @"387",
                                @"429",
                                @"464",
                                @"543",
                                @"583",
                                @"585",
                                @"466",
                                @"469",
                                @"546",
                                @"548",
                                @"511",
                                @"471",
                                @"392",
                                @"515",
                                @"517",
                                @"434",
                                @"476",
                                @"398",
                                @"395",
                                @"354",
                                @"356",
                                @"359",
                                @"275",
                                @"277",
                                @"239",
                                @"158", nil];
    int i=0;
    for(NSString *terr in gridTerritories) {
        i++;
        if([terr intValue]==grid)
            return i;
    }
    return 0;
}
@end
