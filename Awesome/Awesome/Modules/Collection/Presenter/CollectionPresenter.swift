//
//  CollectionPresenter.swift
//  Awesome
//
//  Created by Artak on 1/31/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class CollectionPresenter: NSObject {
    var collectionInteractor : CollectionInteractorInput?
    var collectionWireframe : CollectionWireframe?
    var userInterface : CollectionViewInterface?
    
    var itemType: ItemType = .cardGames{
        didSet {
            if oldValue != itemType {
                collectionInteractor?.findItemsWithType(itemType)
                userInterface?.setTitle(Helper.getItemDisplayName(itemType: itemType))
            }
        }
    }
    
    var items : [CommonItem] = []
    var selectedItemIndex : Int = 0
}

extension CollectionPresenter : CollectionEventHandler {
    func selectedItemType(_ itemtype: ItemType) {
        self.itemType = itemtype
    }
    
    func deleteItemWithIndex(_ index: Int) {
        let item = self.items[index]
        collectionInteractor?.deleteItem(item)
        self.items.remove(at: index)
    }
    
    func selectItemWithIndex(_ index: Int) {
        selectedItemIndex = index
        let item = self.items[index]
        collectionWireframe?.showDetailsInterface(item)
    }
    
    func changeItemsType() {
        userInterface?.showItemTypeDialog()
    }
    
    func addNewItem() {
        collectionWireframe?.showAddInterface(itemType: itemType)
    }
    
    func resetItems() {
        collectionInteractor?.resetItems()
    }
    
    func updateView() {
        
    }
}

extension CollectionPresenter : AddItemDelegate {
    func addItemDidCancelAction() {
        
    }
    
    func addItemDidSaveAction() {
        collectionInteractor?.findItemsWithType(itemType)
    }
}

extension CollectionPresenter : CollectionInteractorOutput {
    func foundItems(_ items: [CommonItem]) {
        if items.count == 0 {
            userInterface?.showNoContentMessage()
        } else {
            updateUserInterfaceWithItems(items)
        }
    }
    
    func updateUserInterfaceWithItems(_ items: [CommonItem]) {
        let displayItems = items.map{
            DisplayItem(title: $0.title, shortDesc: $0.shortDesc, level: $0.level)
        }
        self.items = items
        userInterface?.showItems(displayItems)
    }
    
}
