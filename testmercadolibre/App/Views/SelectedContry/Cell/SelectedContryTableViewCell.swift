//
//  SelectedContryTableViewCell.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 22/03/21.
//

import Foundation
import UIKit
import SDWebImage
import WebKit
import ABLoaderView

class SelectedContryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentViewShimmer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var flagWebView: WKWebView!
    @IBOutlet weak var stateSwicth: UISwitch!
    
    var delegate: SelectedContryTableViewCellDelegate?
    
    var contryRespository: SelectedContryViewModel?
    var indexPath = IndexPath(row: 0, section: 0)
    func setData(site: SiteModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        contryRespository = SelectedContryViewModel(selectedContryDelegate: self)
        contryRespository?.getSiteDetail(site: site.name)
        titleLabel.text = TextConstants().LABEL_NAME + site.name
        stateSwicth.isOn = site.state
        
    }
    
    func showSpinner() {

            for view1 in contentViewShimmer.subviews {
                 ABLoader().startShining(view1)
             }
         
     }
    
    func stopSpinner() {

            for view1 in contentViewShimmer.subviews {
                ABLoader().stopShining(view1)
            }

           
       }
    
   
}
//MARK: -Actions
extension SelectedContryTableViewCell {
    @IBAction func stateChange(_ sender: UISwitch) {
        delegate?.selectedContryTableViewCell(didSelectSwitch: sender.isOn, indexPath: indexPath)
    }
}
//MARK: -SelectedContryDelegate
extension SelectedContryTableViewCell: SelectedContryDelegate {
    func selectedContry(succesCompleteDetail siteDetail: SiteDetailModel) {
        flagImageView.sd_setImage(with: URL(string: siteDetail.flag))
        region.text = TextConstants().LABEL_REGION + siteDetail.region

        if let url = URL(string: siteDetail.flag) {
            let request = NSURLRequest(url: url )
            flagWebView.load(request as URLRequest)
        }
        
    }
    
    func selectedContry(succesComplete listSites: [SiteModel]) {
        
    }
    
    func selectedContry(onNoData nodata: String) {
        
    }
    
    func selectedContry(onError error: String) {
        
    }
}
//MARK: -SelectedContryTableViewCellDelegate
protocol SelectedContryTableViewCellDelegate {
    func selectedContryTableViewCell(didSelectSwitch state: Bool, indexPath: IndexPath)
}
