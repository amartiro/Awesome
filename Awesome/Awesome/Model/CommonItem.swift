//
//  CommonItem.swift
//  Awesome
//
//  Created by Artak on 12/14/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

enum ItemType : Int{
    case snakes = 0
    case cardGames
    case todos
}

enum ItemStatus : Int{
    case untouched = 0
    case panding_update = 1
    case panding_delete = 2
    case panding_add = 3
    case panding_update_after_add = 4
    case panding_delete_after_add = 5
    case waiting_update = 11
    case waiting_delete = 12
    case waiting_add = 13
    
    init(status : Int) {
        self = ItemStatus(rawValue: status) ?? .untouched
    }
}

protocol CommonItemProtocol {
    var date: Date? { set get }

    var id: String { set get }
    var imageUrl: String? { set get }
    var level: Int { set get }
    var longDesc: String? { set get }
    var serverId: String? { set get }
    var shortDesc: String { set get }
    var title: String { set get }
    var type: String { set get }
    var status: Int {set get}
}

class CommonItem: CommonItemProtocol {
    var date: Date?
    var id : String = ""
    var imageUrl : String? = ""
    var title : String = ""
    var longDesc : String?
    var serverId: String?
    var shortDesc : String = ""
    var level : Int = 0
    var type: String = ""
    var status : Int = 0
    
    convenience init(withProtocl item: CommonItemProtocol) {
        self.init()
        
        self.date = item.date
        self.id = item.id
        self.imageUrl = item.imageUrl
        self.longDesc = item.longDesc
        self.serverId = item.serverId
        self.shortDesc =  item.shortDesc
        self.level = item.level
        self.title = item.title
        self.type = item.type
        self.status = item.status
    }
    
    convenience init(withDict dict: [String: AnyObject]) {
        self.init()
        
        self.id = dict["_id"] as! String
        self.imageUrl = dict["image_url"] as? String
        self.longDesc = dict["long_desc"] as? String
        self.shortDesc =  dict["short_desc"] as! String
        self.title = dict["title"] as! String
        self.level = dict["level"] as! Int
        self.type = dict["item_type"] as! String
        self.status = ItemStatus.untouched.rawValue//dict["status"] as! Int
    }
    
}
