//
//  GroupCell.swift
//  social-app
//
//  Created by Admin on 30.11.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescriptionLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    
    func configureCell(title: String, description: String, memberCount: Int) {
        self.groupTitleLbl.text = title
        self.groupDescriptionLbl.text = description
        self.memberCountLbl.text = "\(memberCount) members"
    }

    
}
