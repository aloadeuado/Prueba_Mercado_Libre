//
//  DialogSelectOnlyOptionViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 25/03/21.
//

import UIKit

class DialogSelectMultiFilterViewController: UIViewController {

    @IBOutlet weak var filtersTableView: FiltersTableView!
    
    var listFilters = [FilterData]()
    
    var delegate: FiltersTableViewDelegate?
    var ok: ((String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        initComponent()
    }
    
    func initComponent(){
        filtersTableView.delegate = delegate
        filtersTableView.listFilters = listFilters
        filtersTableView.apply = {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
//MARK: -Show
extension DialogSelectMultiFilterViewController {
    static func show(controller: UIViewController, delegate: FiltersTableViewDelegate, listFilters: [FilterData]) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "DialogSelectMultiFilter", bundle: nil)
        guard let dialog = storyboard.instantiateViewController(withIdentifier: "DialogSelectMultiFilterViewController") as? DialogSelectMultiFilterViewController else { return }
        
        dialog.modalPresentationStyle = .overFullScreen
        dialog.modalTransitionStyle = .crossDissolve
        dialog.delegate = delegate
        dialog.listFilters = listFilters
        controller.present(dialog, animated: true, completion: nil)
        
    }
}
