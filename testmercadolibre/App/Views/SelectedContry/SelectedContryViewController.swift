//
//  ViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 21/03/21.
//

import UIKit

class SelectedContryViewController: UIViewController {

    @IBOutlet weak var sitesTableView: UITableView!
    @IBOutlet weak var continueButton: CustomEnabledButton!
    
    var selectedContryViewModel: SelectedContryViewModel?
    
    var listSitesModel = [SiteModel]()
    var siteModel: SiteModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent(){
        selectedContryViewModel = SelectedContryViewModel(selectedContryDelegate: self)
        selectedContryViewModel?.getSites()
        setStateButton()
        
    }
    
    func selectedSite(indexPath: IndexPath){
        var i = 0
        let listSitesModelReference = listSitesModel
        var list = [SiteModel]()
        for site in listSitesModelReference {
            var site1 =  site
            if indexPath.row == i {
                site1.setState(state: true)
                siteModel = site1
            } else {
                site1.setState(state: false)
            }
            list.append(site1)
            i += 1
        }
        listSitesModel = list
        setStateButton()
        sitesTableView.reloadData()
    }
    
    func setStateButton(){
        let listChecks = listSitesModel.first(where: { (siteModel) -> Bool in return siteModel.state })
        continueButton.setEnabled(state: ((listChecks?.state) != nil))
    }


}
//MARK: -Actions
extension SelectedContryViewController {
    @IBAction func continuePressed(button: UIButton) {
        if let siteModel1 = siteModel{
            selectedContryViewModel?.setInternalSite(site: siteModel1)
        }
        
    }
}
//MARK: -UITableViewDelegate
extension SelectedContryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSite(indexPath: indexPath)
    }
}

//MARK: -UITableViewDataSource
extension SelectedContryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSitesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedContryTableViewCell") as? SelectedContryTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.setData(site: listSitesModel[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
//MARK: -SelectedContryTableViewCellDelegate
extension SelectedContryViewController: SelectedContryTableViewCellDelegate{
    func selectedContryTableViewCell(didSelectSwitch state: Bool, indexPath: IndexPath) {
        selectedSite(indexPath: indexPath)
    }
    
    
}
//MARK: -SelectedContryDelegate
extension SelectedContryViewController: SelectedContryDelegate {
    func selectedContry(succesCompleteDetail siteDetail: SiteDetailModel) {
        
    }
    
    func selectedContry(succesComplete listSites: [SiteModel]) {
        self.listSitesModel = listSites
        sitesTableView.reloadData()
    }
    
    func selectedContry(onNoData nodata: String) {
        
    }
    
    func selectedContry(onError error: String) {
        
    }
    
    
}

