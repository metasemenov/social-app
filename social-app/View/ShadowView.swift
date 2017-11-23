//
//  ShadowView.swift
//  social-app
//
//  Created by Admin on 23.11.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }

    func setupView() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
