//
//  AlerMessageThreeOptionsViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 25/03/21.
//

import UIKit

class AlerMessageThreeOptionsViewController: UIViewController {

    @IBOutlet weak var messaggeLabel: UILabel!
    @IBOutlet weak var option1Button: CustomButton!
    @IBOutlet weak var option2Button: CustomButton!
    @IBOutlet weak var option3Button: CustomButton!
    
    var textMessagge = ""
    var textOption1 = ""
    var textOption2 = ""
    var textOption3 = ""
    
    var option1: (() -> Void)?
    var option2: (() -> Void)?
    var option3: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent(){
        messaggeLabel.text = textMessagge
        option1Button.setTitle(textOption1, for: .normal)
        option2Button.setTitle(textOption2, for: .normal)
        option3Button.setTitle(textOption3, for: .normal)
    }

}
//MARK: -Actions
extension AlerMessageThreeOptionsViewController {
    @IBAction func option1Pressed(button: CustomButton) {
        dismiss(animated: true) {
            self.option1?()
        }
    }
    
    @IBAction func option2Pressed(button: CustomButton) {
        dismiss(animated: true) {
            self.option2?()
        }
    }
    
    @IBAction func option3Pressed(button: CustomButton) {
        dismiss(animated: true) {
            self.option3?()
        }
    }
}
// MARK: - Show Alert
extension AlerMessageThreeOptionsViewController {
    
    static func show(controller: UIViewController, textMessagge: String, textOption1: String = TextConstants().ALERT_BUTTON_SAVE_DATA, textOption2: String = TextConstants().ALERT_BUTTON_KEEP_ASKING, textOption3: String = TextConstants().ALERT_BUTTON_CANCEL, option1: (() -> Void)? = nil, option2: (() -> Void)? = nil, option3: (() -> Void)? = nil) {
        let storyboard: UIStoryboard = UIStoryboard(name: "AlerMessageThreeOptions", bundle: nil)
        guard let alert = storyboard.instantiateViewController(withIdentifier: "AlerMessageThreeOptionsViewController") as? AlerMessageThreeOptionsViewController else { return }
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        alert.textMessagge = textMessagge
        alert.textOption1 = textOption1
        alert.textOption2 = textOption2
        alert.textOption3 = textOption3
        alert.option1 = option1
        alert.option2 = option2
        alert.option3 = option3
        controller.present(alert, animated: true, completion: nil)
    }
}
