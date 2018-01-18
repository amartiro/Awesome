//
//  ItemFactory.swift
//  Awesome
//
//  Created by Artak on 12/19/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

class ItemFactory: UIView {

    static func parseItem(dict : [String: AnyObject])-> CommonItem{
       let type = dict["item_type"] as! String
        switch type {
        case "SNAKES":
            return SnackItem(withDict: dict)
        case "TODOS":
            return TaskItem(withDict: dict)
        case "CARDGAMES":
            return CardGameItem(withDict: dict)
        default:
            return SnackItem(withDict: dict)
        }
    }
    
     static func parseManagedItem(itemProtocol : CommonItemProtocol)-> CommonItem{
        switch itemProtocol.type {
        case "SNAKES":
            return SnackItem(withProtocl: itemProtocol)
        case "TODOS":
            return TaskItem(withProtocl: itemProtocol)
        case "CARDGAMES":
            return CardGameItem(withProtocl: itemProtocol)
        default:
            return SnackItem(withProtocl: itemProtocol)
        }
    }
}
