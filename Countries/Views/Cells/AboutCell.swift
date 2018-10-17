//
//  AboutCell.swift
//  Countries
//
//  Created by mrbesford on 10/17/18.
//  Copyright © 2018 mrbesford. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {


    @IBOutlet weak var descriptionFull: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        descriptionFull.numberOfLines = 0
        descriptionFull.sizeToFit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
