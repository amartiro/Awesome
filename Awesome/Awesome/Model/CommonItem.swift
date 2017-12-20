//
//  CommonItem.swift
//  Awesome
//
//  Created by Artak on 12/14/17.
//  Copyright © 2017 Artak. All rights reserved.
//

class CommonItem {
    var id : String
    var title : String
    var desc : String
    var longDesc : String?
    var level : Int
    
    init() {
        self.id = "default"
        self.title  = "Samo"
        self.desc  = "Samo"
        self.longDesc = "Samo"
        self.level = 5
    }
    
    convenience init(withDict dict: [String: AnyObject]) {
        self.init()
        
        self.id = dict["_id"] as! String
        self.title = dict["title"] as! String
        self.level = dict["level"] as! Int
        self.desc =  dict["short_desc"] as! String
        self.longDesc = dict["long_desc"] as? String
    }
    
}
