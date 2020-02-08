//
//  IntermediaryModels.swift
//  ResturentAppTest
//
//  Created by mac on 03/02/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
struct category: Codable {
    let categories: [String]
}


struct PreperationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String,CodingKey{
        case prepTime = "preparation_time"
    }
}
