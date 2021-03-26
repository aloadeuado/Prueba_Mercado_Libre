//
//  DialogSelectOnlyOptionViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 25/03/21.
//

import UIKit

class DialogSelectOnlyOptionViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var continueButton: CustomButton!
    
    @IBOutlet weak var cancelButton: CustomButton!
    
    var arrayList = ["1", "2"]
    var selectItem = ""
    
    var ok: ((String) -> Void)?
    var cancel: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        initComponent()
    }

    func initComponent(){
        if !arrayList.isEmpty {
            selectItem = arrayList[0]
        }
        
    }
    
}
//MARK: -Action
extension DialogSelectOnlyOptionViewController {
    @IBAction func continuePressed(_ sender: CustomButton) {
        self.dismiss(animated: true) {
            self.ok?(self.selectItem)
        }
    }
    
    @IBAction func cancelPressed(_ sender: CustomButton) {
        dismiss(animated: true, completion: {
            self.cancel?()
        })
    }
}
//MARK: -UIPickerViewDelegate
extension DialogSelectOnlyOptionViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectItem = arrayList[row]
    }
}
//MARK: -UIPickerViewDataSource
extension DialogSelectOnlyOptionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayList[row]
    }
}
//MARK: -

extension DialogSelectOnlyOptionViewController {
    static func show(controller: UIViewController, arrayList: [String], selectItem: String , ok: @escaping ((String) -> Void), cancel: @escaping (() -> Void)) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "DialogSelectOnlyOption", bundle: nil)
        guard let dialog = storyboard.instantiateViewController(withIdentifier: "DialogSelectOnlyOptionViewController") as? DialogSelectOnlyOptionViewController else { return }
        
        dialog.modalPresentationStyle = .overFullScreen
        dialog.modalTransitionStyle = .crossDissolve
        dialog.arrayList = arrayList
        dialog.selectItem = selectItem
        dialog.ok = ok
        dialog.cancel = cancel
        controller.present(dialog, animated: true, completion: nil)
        
    }
}
