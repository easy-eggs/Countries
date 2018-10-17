//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by mrbesford on 10/15/18.
//  Copyright © 2018 mrbesford. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView!    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var сapitalName: UILabel!
    @IBOutlet weak var descriptionSmall: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
