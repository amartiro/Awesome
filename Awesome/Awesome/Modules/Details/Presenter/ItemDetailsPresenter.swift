//
//  ItemDetailsPresenter.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class ItemDetailsPresenter:  NSObject {
    var itemDetailsInteractor : ItemDetailsInteractorInput?
    var itemDetailsWireframe : ItemDetailsWireframe?
    var userInterface : ItemDetailsViewInterface?
    
    var itemId : String!
    fileprivate var item : CommonItem?
    
    func configureUserInterfaceForShow(_ viewUserInterface: ItemDetailsViewInterface) {
        if let item = item {
            viewUserInterface.setItemLevel(item.level)
            viewUserInterface.setItemTitle(item.title)
            viewUserInterface.setItemShortDesc(item.shortDesc)
            viewUserInterface.setItemLongDesc(item.longDesc)
        }
    }
    
}

extension ItemDetailsPresenter : ItemDetailsEventHandler {
    func viewLoaded() {
        configureUserInterfaceForShow(userInterface!)
    }
    
    func reloadItem() {
        itemDetailsInteractor?.getItem(id: itemId)
        
    }
    
    func editItem() {
        itemDetailsWireframe?.showEditInterface(item!)
    }
}

extension ItemDetailsPresenter : ItemDetailsInteractorOutput {
    func foundItem(_ item: CommonItem) {
        self.item = item
        configureUserInterfaceForShow(userInterface!)

    }
    
    
}
