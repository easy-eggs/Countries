//
//  DetailInfoCell.swift
//  Countries
//
//  Created by mrbesford on 10/16/18.
//  Copyright © 2018 mrbesford. All rights reserved.
//

import UIKit

class DetailInfoCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
