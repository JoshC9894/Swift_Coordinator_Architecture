//
//  JourneyModel.swift
//  Coordinator Test
//
//  Created by Joshua Colley on 24/01/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation

struct JourneyModel {
    var item1: String
    var item2: String
    var item3: String
    var shouldSkipSecondVC: Bool
}
extension JourneyModel {
    init() {
        item1 = ""
        item2 = ""
        item3 = ""
        shouldSkipSecondVC = false
    }
}
