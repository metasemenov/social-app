//
//  UserCell.swift
//  social-app
//
//  Created by Admin on 28.11.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    //Variables
    var showing = false
    
    func configureCell(profileImg img: UIImage, email: String, isSelected: Bool) {
        self.profileImg.image = img
        self.emailLbl.text = email
        if isSelected {
            self.checkImg.isHidden = false
        } else {
            self.checkImg.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                checkImg.isHidden = false
                showing = true
            } else {
            checkImg.isHidden = true
            showing = false
            }
        }
    }

}
