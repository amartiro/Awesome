//
//  CollectionEventHandler.swift
//  Awesome
//
//  Created by Artak on 2/1/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

protocol CollectionEventHandler {  // View sends user actions to Presenter with this protocol
  
    func addNewItem()
    func resetItems()
    func changeItemsType()
   
    func selectedItemType(_ itemtype : ItemType)
  
    func selectItemWithIndex(_ index: Int)
    func deleteItemWithIndex(_ index: Int)
    
    func updateView()
}
