//
//  GlobalFilterTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 23/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This GlobalFilterTableViewCell class used for creating filter table cell
import UIKit

protocol FilteredContent{
    func selectedContent(dic:[String:Any])
    func selectedIndex(indexpath :[Int])
}

class GlobalFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView           : UIView!
    @IBOutlet weak var productName      : UILabel!
    @IBOutlet weak var dropDownButton   : UIButton!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var topic               = [String]()
    var sectionNumber       = 0
    var identifier          = "FilterCollectionViewCell"
    var selectedContent     = [[Int:Any]]()
    var selectedIndex        = [Int]()
    var lightBlue  = hexStringToUIColor(hex: "#EDF5FF")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        self.productCollectionView.register(UINib.init(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func configure(_ arr: [String], sectionNumber : Int) {
        self.topic = arr
        self.sectionNumber = sectionNumber
        self.productCollectionView.reloadData()
        let height = productCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.collectionViewHeight.constant = height > 240 ? height + 15 : height + 10
        self.productCollectionView.layoutIfNeeded()
        self.productCollectionView.reloadData()
    }
    
    func manageDescriptionLabel(hide: Bool) {
        self.productCollectionView.isHidden = hide
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
//This method is used for crete the collection cell
extension GlobalFilterTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        cell.filteredLabel.text = topic[indexPath.item]
        cell.productSectionName = sectionNumber
        cell.layer.cornerRadius = 6
        cell.filteredLabel.font = UIFont.systemFont(ofSize: 14.0)
        let cellSelected =  selectedTopic.contains(topic[indexPath.item])
        cell.bgView.borderWidth = 1
        cell.bgView.backgroundColor =  cellSelected ? hexStringToUIColor(hex: "#FFF5FA") : lightBlue
        cell.bgView.borderColor     =  cellSelected ? hexStringToUIColor(hex: "#EC187B") : lightBlue
        cell.filteredLabel.textColor = .black
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.topic.count == 0{
            return
        }
        
        if selectedTopic.contains(self.topic[indexPath.item]){
            selectedTopic.remove(self.topic[indexPath.item])
        }else{
            selectedTopic.removeAll()
            selectedTopic.append(self.topic[indexPath.item])
        }
        
        if let cell = collectionView.cellForItem(at: indexPath)as? FilterCollectionViewCell{
            let cellSelected = selectedTopic.contains(topic[indexPath.item])
            var individualDic = [Int:Any]()
            individualDic.updateValue(self.topic[indexPath.item], forKey: cell.productSectionName)
            selectedContent.append(individualDic)
            for row in selectedContent.indices {
                selectedContent[row][cell.productSectionName] = individualDic
            }
            print(selectedContent)
            cell.bgView.backgroundColor =  cellSelected ? hexStringToUIColor(hex: "#FFF5FA") : lightBlue
            cell.bgView.borderColor     =  cellSelected ? hexStringToUIColor(hex: "#EC187B") : lightBlue
            self.productCollectionView.reloadData()
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filter_Selection"), object: nil,userInfo:  ["indexpath" : indexPath,"topic":topic[indexPath.row]])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.topic.count == 0{
            return CGSize()
        }
        let text = self.topic[indexPath.item]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 14.0)]).width + 44.0
        return CGSize(width: cellWidth, height: 38.0)
        
    }
}
extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
