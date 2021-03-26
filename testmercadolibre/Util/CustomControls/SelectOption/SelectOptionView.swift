//
//  SelectOptionView.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 25/03/21.
//

import Foundation
import UIKit
protocol SelectOptionViewDelegate {
    func selectOptionView(didSelectedItem item: String, index: Int)
    func selectOptionView(didCancel item: String)
}
class SelectOptionView: UIView {

    @IBOutlet weak var selectTextField: UITextField!
    @IBOutlet weak var indicatorLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
    @IBOutlet var controller: UIViewController?
    
    var delegate: SelectOptionViewDelegate?
    var arrayList = [String]() {
        didSet{
            setView()
        }
    }
    var selectItem = ""
    
    @IBOutlet weak var contentView: UIView!
    
    let heightLabelAndView: CGFloat = 32;
    
    private var viewSelect = UIView()
    private var listLabel = [UILabel]()
    private var listButton = [UIButton]()
    private var categoryTextArray = [String]()
    
    private var isFirstCall = false
    
    private var afterFrame = CGRect()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //viewSetup()
        /*self.generalScrollView.isSkeletonable = true
        self.viewSelect.isSkeletonable = true*/
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        //viewSetup()
        
    }
    
    private func loadViewFromNib() -> UIView? {

         let nibName = "SelectOptionView"
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: nibName, bundle: bundle)
         return nib.instantiate(withOwner: self, options: nil).first as? UIView
     }
    
    private func viewSetup() {
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if !isFirstCall {
            self.addSubview(view)
            isFirstCall = true
        }
        
        contentView = view
        setView()
    }
    
    func setView(){
        if !arrayList.isEmpty {
            selectTextField.text = arrayList[0]
        }
    }
    
    @IBAction func openPressed(_ sender: UIButton) {
        if let controller = self.controller {
            DialogSelectOnlyOptionViewController.show(controller: controller, arrayList: arrayList, selectItem: selectItem) { (text) in
                let index = self.categoryTextArray.firstIndex(of: text)
                self.selectTextField.text = text
                self.delegate?.selectOptionView(didSelectedItem: text, index: index ?? 0)
            } cancel: {
                self.delegate?.selectOptionView(didCancel: self.selectItem)
            }

        }
        
    }
}
