//
//  WS.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 22/03/21.
//

import Foundation
import Alamofire

func getReturnData(url: String, statusCorrect: [Int], ok: @escaping((Data) -> Void), error: @escaping ((String) -> Void)) {

    let request = AF.request(url)
    
    request.response { (response) in
        guard let responseData = response.response else {
            error(TextConstants().WS_ERROR_NO_RESPONSE)
            return
        }
        
        if statusCorrect.contains(responseData.statusCode) {
            guard let data = response.data else {
                error(TextConstants().WS_ERROR_NO_RESPONSE)
                return
            }
            
            ok(data)
        }else {
            guard let responseError = response.error else {
                error(TextConstants().WS_ERROR_NO_RESPONSE)
                return
            }
            error(responseError.localizedDescription)
        }
    }
        
        
}
