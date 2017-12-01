//
//  GroupFeedCell.swift
//  social-app
//
//  Created by Admin on 01.12.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(profileImg: UIImage, email: String, content: String) {
        self.profileImg.image = profileImg
        self.emailLbl.text = email
        self.contentLbl.text = content
    }  
}
