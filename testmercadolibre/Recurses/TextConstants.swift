//
//  Text.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 22/03/21.
//

import Foundation

class TextConstants {
    var leng = ""
    
    var WS_ERROR_NO_RESPONSE = ""
    var ERROR_SITES_DATA = ""
    var LABEL_NAME = ""
    var LABEL_REGION = ""
    
    init() {
        leng = Locale.current.languageCode ?? "en"
        
        WS_ERROR_NO_RESPONSE = (leng == "en") ? "this service is temporarily out of service": "este servicio esta temporalmente fuera de servicio"
        ERROR_SITES_DATA  = (leng == "en") ? "At this time there are no cities available": "En este momento no hay ciudades disponibles"
        LABEL_NAME = (leng == "en") ? "Name: ": "Nombre: "
        LABEL_REGION = (leng == "en") ? "Region: ": "Region: "
    }
    
    
}
