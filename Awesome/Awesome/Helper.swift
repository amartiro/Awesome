//
//  Helper.swift
//  Awesome
//
//  Created by Artak on 12/8/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation


class Helper {
    
    static let sharedInstance: Helper = Helper()
    
    static func getItemName(itemType: ItemType) -> String {
        switch itemType {
        case .snakes:
            return "SNAKES"
        case .cardGames:
            return "CARDGAMES"
        case .todos:
            return "TODOS"
        }
        
    }
    
    static func getItemDisplayName(itemType: ItemType) -> String {
        switch itemType {
        case .snakes:
            return "Snakes"
        case .cardGames:
            return "Card Games"
        case .todos:
            return "Task/To Do"
        }
        
    }
}
