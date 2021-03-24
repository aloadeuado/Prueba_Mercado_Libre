//
//  CustomEnabledButton.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 22/03/21.
//

import Foundation
import UIKit

class CustomEnabledButton: CustomButton{
    
    func setEnabled(state: Bool){
        if state {
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.isEnabled = true
        } else {
            self.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            self.isEnabled = false
        }
        
    }
}
