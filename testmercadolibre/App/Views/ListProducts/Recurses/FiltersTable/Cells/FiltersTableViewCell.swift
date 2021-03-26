//
//  FiltersTableViewCell.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 25/03/21.
//

import UIKit

class FiltersTableViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleFilter: UILabel!
    @IBOutlet weak var valueView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stateSwitch: UISwitch!
    
    var filterData = FilterData(idTitle: "", nameTitle: "", idValue: "", nameValue: "", isTitle: false, state: false)
    static let identifier = "FiltersTableViewCell"
    override var reuseIdentifier: String? { return FiltersTableViewCell.identifier }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValue(filterData: FilterData) {
        self.filterData = filterData
        if filterData.isTitle {
            titleView.isHidden = false
            valueView.isHidden = true
            titleFilter.text = filterData.nameTitle
        } else {
            titleView.isHidden = true
            valueView.isHidden = false
            valueLabel.text = filterData.nameValue
            stateSwitch.isOn = filterData.state
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
