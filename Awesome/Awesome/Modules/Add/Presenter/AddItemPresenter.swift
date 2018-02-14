//
//  AddItemPresenter.swift
//  Awesome
//
//  Created by Artak on 1/29/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class AddItemPresenter: NSObject, AddItemEventHandler {

    var itemType : ItemType!
    
    var addInteractor : AddItemInteractor?
    var addWireframe : AddItemWireframe?
    var addItemDelegate : AddItemDelegate?
    var userInterface : AddItemViewInterface?


    func configureUserInterfaceForShow(_ addViewUserInterface: AddItemViewInterface) {
        addViewUserInterface.setItemLevel(5)
    }
    
    func viewLoaded() {
        configureUserInterfaceForShow(userInterface!)
    }
    
    func cancelAddItem() {
        addWireframe?.hideAddInterface()
        addItemDelegate?.addItemDidCancelAction()
    }
    
    func saveAddItemWithTitle(_ title: String, shortDesc : String, longDesc : String?, level : Int) {
        addInteractor?.saveNewItemWithTitle(title, shortDesc: shortDesc, longDesc: longDesc, level: level, type: Helper.getItemName(itemType: itemType))
        addWireframe?.hideAddInterface()
        addItemDelegate?.addItemDidSaveAction()
    }

}
