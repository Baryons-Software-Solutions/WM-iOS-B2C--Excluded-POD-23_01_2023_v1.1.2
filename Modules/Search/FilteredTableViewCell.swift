//
//  FilteredTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 01/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This FilteredTableViewCell class used for creating filter table cell
import UIKit


var selectedTags = [String]()
var selectedTopic = [String]()
var isSearchCalled = false


class FilteredTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView           : UIView!
    @IBOutlet weak var productName      : UILabel!
    @IBOutlet weak var dropDownButton   : UIButton!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var topic = [String]()
    var identifier = "FilterCollectionViewCell"
    var lightBlue = hexStringToUIColor(hex: "#EDF5FF")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        self.productCollectionView.register(UINib.init(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func configure(_ arr: [String]) {
        self.topic = arr
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
// This method is used for create filter collection cell
extension FilteredTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        cell.filteredLabel.text = topic[indexPath.item]
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
        
        if indexPath.row == 0 ||  indexPath.row == 1{
            if selectedTopic.contains(self.topic[indexPath.item]){
                selectedTopic.remove(self.topic[indexPath.item])
            }else{
                selectedTopic.append(self.topic[indexPath.item])
            }
        }else {
            if selectedTopic.contains("All Price"){
                if let index = selectedTopic.firstIndex(of: "All Price") {
                    selectedTopic.remove(at: index)
                }
            }
            if selectedTopic.contains(self.topic[indexPath.item]){
                selectedTopic.remove(self.topic[indexPath.item])
            }else{
                selectedTopic.append(self.topic[indexPath.item])
            }
        }
        print(selectedTopic)
        
        if let cell = collectionView.cellForItem(at: indexPath)as? FilterCollectionViewCell{
            let cellSelected = selectedTopic.contains(topic[indexPath.item])
            cell.bgView.backgroundColor =  cellSelected ? hexStringToUIColor(hex: "#FFF5FA") : lightBlue
            cell.bgView.borderColor     =  cellSelected ? hexStringToUIColor(hex: "#EC187B") : lightBlue
            self.productCollectionView.reloadData()
        }
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

extension Array where Element:Equatable {
    
    @discardableResult mutating func remove(_ element: Element) -> Bool {
        if let index = firstIndex(of: element) {
            self.remove(at: index)
            return true
        }
        return false
    }
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
