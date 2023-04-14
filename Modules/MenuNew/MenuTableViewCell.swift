//
//  MenuTableViewCell.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 08/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This MenuTableViewCell class used for creating Menu  table cell
import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuImageView            : UIImageView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var subMenuTableView         : UITableView!
    @IBOutlet weak var sideMenuArrow            : UIButton!
    @IBOutlet weak var menuLabelName            : UILabel!
    
    var topic = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subMenuTableView.delegate           = self
        subMenuTableView.dataSource         = self
        self.subMenuTableView.register(UINib.init(nibName: "SubMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SubMenuTableViewCell")
    }
    
    func configure(arr: [String]) {
        self.topic = arr
        self.subMenuTableView.reloadData()
        self.tableViewHeightConstraint.constant = CGFloat(topic.count * 60)
        self.subMenuTableView.layoutIfNeeded()
        self.subMenuTableView.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

extension MenuTableViewCell : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topic.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubMenuTableViewCell") as? SubMenuTableViewCell
        cell?.subMenuLabel.text = topic[indexPath.row]
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "passing_index"), object: nil,userInfo:  ["indexpath" : indexPath,"topic":topic[indexPath.row]])
    }
}
