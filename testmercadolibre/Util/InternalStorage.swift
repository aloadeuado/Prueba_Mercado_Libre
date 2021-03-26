//
//  InternalStorage.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 23/03/21.
//

import Foundation
import UIKit

func setData(didSetData data: Data, key: String){
    let defaults = UserDefaults.standard
    defaults.set(data, forKey: key)
}

func getData(didGetData key: String) -> Data{
    let defaults = UserDefaults.standard
    if let data = defaults.object(forKey: key) as? Data {
        return data
    }
    return Data()
}

func setString(didSetString data: String, key: String){
    let defaults = UserDefaults.standard
    defaults.set(data, forKey: key)
}

func getString(didGetString key: String) -> String{
    let defaults = UserDefaults.standard
    if let data = defaults.string(forKey: key) as? String {
        return data
    }
    return ""
}
    
