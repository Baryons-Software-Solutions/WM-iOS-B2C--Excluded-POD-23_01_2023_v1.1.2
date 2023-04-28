//
//  FilterViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 22/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var closeButton              : UIButton!
    @IBOutlet weak var filterBGView             : UIView!
    @IBOutlet weak var filterview               : UIView!
    @IBOutlet weak var filterAppliedLabel       : UILabel!
    @IBOutlet weak var clearbutton              : UIButton!
    @IBOutlet weak var filteredTableView        : UITableView!
    @IBOutlet weak var showResultButton         : UIButton!
    @IBOutlet weak var resultsFoundbutton       : UILabel!
    
    var sectionsList                   = [String]()
    var arrSuppliers : [[String:Any]]  = []
    var arrOutletList : [[String:Any]] = []
    var arrStatusDropdown              = [StatusDropdown]()
    var screenName                     = ""
    var sectionproductArray            = [[String]]()
    var selectedIndexPath              = IndexPath()
    var selectedIndexPathArray         = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIElementsSetUp()
        registerTableViewXibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        assignContentToSections()
        delegatesSetup()
    }
    
    func assignContentToSections(){
        var suppliersArray = [String]()
        for i in 0..<arrSuppliers.count{
            let objCommonModel = CommonModel(data : arrSuppliers[i] as NSDictionary)
            suppliersArray.append(objCommonModel.strTitle)
        }
        sectionproductArray.append(suppliersArray)
        var outletArray = [String]()
        for i in 0..<arrOutletList.count{
            let objCommonModel = CommonModel(data : arrOutletList[i] as NSDictionary)
            outletArray.append(objCommonModel.strTitle)
        }
        sectionproductArray.append(outletArray)
        var statusArray = [String]()
        for i in 0..<self.arrStatusDropdown.count{
            statusArray.append(arrStatusDropdown[i].name)
          print(arrStatusDropdown[i].name)
        }
        sectionproductArray.append(statusArray)
    }
    func registerTableViewXibs(){
        filteredTableView.register(UINib.init(nibName: "GlobalFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "GlobalFilterTableViewCell")
    }
    func UIElementsSetUp(){
        filterBGView.backgroundColor = .black
        filterBGView.alpha           = 0.6
    }
    func delegatesSetup(){
        filteredTableView.delegate = self
        filteredTableView.dataSource = self
    }

    @IBAction func closePopUpAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
}

// MARK: -table view delegate functions
//This method is used for create the table filter cell
extension FilterViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.sectionsList[indexPath.row].count == 0 {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalFilterTableViewCell", for: indexPath)as? GlobalFilterTableViewCell
        cell?.productName.text    = self.sectionsList[indexPath.row]
        cell?.configure(self.sectionproductArray[indexPath.row], sectionNumber:indexPath.row)
        if self.selectedIndexPathArray.contains(indexPath) {
            cell?.productCollectionView.isHidden = true
        }else{
            cell?.productCollectionView.isHidden = false
        }
        cell?.dropDownButton.addTarget(self, action: #selector(dropdown(_:)), for: .touchUpInside)
        cell?.dropDownButton.tag   = indexPath.row

        return cell ?? UITableViewCell()
    }
    
    @objc func dropdown(_ sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        self.selectedIndexPath = indexPath
        if selectedIndexPathArray.contains(selectedIndexPath) {
            selectedIndexPathArray.remove(indexPath)
        }else{
            selectedIndexPathArray.append(indexPath)
        }
        
        self.filteredTableView.reloadRows(at: [selectedIndexPath ] , with: .automatic)
    }
    
}
