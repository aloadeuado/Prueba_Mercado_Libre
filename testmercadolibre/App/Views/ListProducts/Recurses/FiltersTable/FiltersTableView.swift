//
//  FiltersTableView.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 25/03/21.
//

import UIKit
protocol FiltersTableViewDelegate {
    func filtersTableView(didGetFilter filterSelecter: FilterData, listFiltersSelecter: [FilterData])
    func filtersTableView(aplyFilter listFiltersSelecter: [FilterData])
}
class FiltersTableView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    var listFilters = [FilterData]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var delegate: FiltersTableViewDelegate?
    
    var apply: (() -> Void)?
    //var listFiltersSelecter = [FilterData]()
    @IBOutlet weak var contentView: UIView!
    
    private var isFirstCall = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //viewSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        //viewSetup()
        
    }
    
    private func loadViewFromNib() -> UIView? {

         let nibName = "FiltersTableView"
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
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: FiltersTableViewCell.identifier,bundle: nil)
        //self.collectionView.register(nib1, forCellWithReuseIdentifier: Constants.ITEM_CELL1)
        tableView.register(nib, forCellReuseIdentifier: FiltersTableViewCell.identifier)
    }
}
//MARK: -Actions
extension FiltersTableView{
    @IBAction func applyPressed(button: CustomButton) {
        delegate?.filtersTableView(aplyFilter: listFilters)
        self.apply?()
    }
}
//MARK: -UITableViewDataSource
extension FiltersTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFilters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FiltersTableViewCell.identifier) as? FiltersTableViewCell else {return UITableViewCell()}
        cell.setValue(filterData: listFilters[indexPath.row])
        
        return cell
    }
    
    
}
//MARK: -UITableViewDataSource
extension FiltersTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listFilters[indexPath.row].state = !self.listFilters[indexPath.row].state
        tableView.reloadData()
        delegate?.filtersTableView(didGetFilter: self.listFilters[indexPath.row], listFiltersSelecter: self.listFilters)
    }
}
