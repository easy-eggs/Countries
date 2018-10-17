//
//  Country.swift
//  Countries
//
//  Created by mrbesford on 10/17/18.
//  Copyright © 2018 mrbesford. All rights reserved.
//

import Foundation
import RealmSwift

class Country: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var capital: String = ""
    @objc dynamic var flag: String = ""
    @objc dynamic var descriptionSmall: String = ""
    @objc dynamic var descriptionFull: String = ""
    @objc dynamic var population: Int = 0
    @objc dynamic var continent: String = ""
}
