//
//  MainPresenter.swift
//  Awesome
//
//  Created by Artak on 2/13/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class MainPresenter: NSObject {
    var mainInteractor : MainInteractor?
    var mainWireframe : MainWireframe?
    var userInterface : MainViewInterface!
    
    var itemType: ItemType = .cardGames{
        didSet {
            if oldValue != itemType {
                mainInteractor?.findItemsWithType(itemType)
            }
        }
    }
    
    var items : [CommonItem] = []
    var selectedItemIndex : Int = 0

}

extension MainPresenter: MainEventHandler {
    func cancelEditItem() {
        
    }
    
    func editItemWithTitle(_ title: String, shortDesc: String, longDesc: String?, level: Int) {
        let item = self.items[selectedItemIndex]
        item.title = title
        item.shortDesc = shortDesc
        item.longDesc = longDesc
        item.level = level
        
        mainInteractor?.saveItem(item)
    }
    
    func editItem() {
        
        let item = self.items[selectedItemIndex]
        userInterface.showEditView()
        userInterface.setEditItemTitle(item.title)
        userInterface.setEditItemLevel(item.level)
        userInterface.setEditItemShortDesc(item.shortDesc)
        userInterface.setEditItemLongDesc(item.longDesc)
        
    }
    
    func reloadItem() {
         mainInteractor?.findItemsWithType(itemType)
    }
    
    func viewLoaded() {
        
    }
    
    func addNewItem() {
        mainWireframe?.showAddInterface(itemType: itemType)
    }
    
    func resetItems() {
        
    }
    
    func changeItemsType() {
        userInterface?.showItemTypeDialog()
    }
    
    func selectedItemType(_ itemtype: ItemType) {
         self.itemType = itemtype
         userInterface.setTitle(Helper.getItemDisplayName(itemType: itemType))
    }
    
    func deleteItemWithIndex(_ index: Int) {
        
    }
    
    func updateView() {
        
    }
    
    func selectItemWithIndex(_ index: Int) {
        selectedItemIndex = index
        let item = self.items[index]
        userInterface.showDetailsView()
        userInterface.setItemLevel(item.level)
        userInterface.setItemTitle(item.title)
        userInterface.setItemShortDesc(item.shortDesc)
        userInterface.setItemLongDesc(item.longDesc)
    }
}

extension MainPresenter : MainInteractorOutput {
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
