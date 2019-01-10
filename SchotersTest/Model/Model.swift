//
//  File.swift
//  SchotersTest
//
//  Created by nurpariz on 10/01/19.
//  Copyright © 2019 nurpariz. All rights reserved.
//

import Foundation

struct DataCategory {
    var name: String = ""
    
    init(json:[String:Any]) {
        
        name = json["name"] as! String

    }
}
