//
//  DatabaseManager.swift
//  Awesome
//
//  Created by Artak on 12/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation

protocol DatabaseManager {
 
    func getItems(itemType : ItemType, completion: @escaping (([CommonItem]) -> Void))
    func getItems(itemStatus : ItemStatus, completion: @escaping (([CommonItem]) -> Void))
    
    func getItem(itemId : String, completion: @escaping ((CommonItem?) -> Void))
    
    func addOrUpdateItem(item : CommonItem)
    func addItem(item : CommonItem)
    func editItem(item : CommonItem)
   
    func deleteItem(item : CommonItem)
    func saveItem(item : CommonItem)
    
    func save()
    func reset()

}
