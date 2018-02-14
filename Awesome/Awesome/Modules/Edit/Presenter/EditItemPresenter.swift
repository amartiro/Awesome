//
//  EditItemPresenter.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

class EditItemPresenter: NSObject {

    var editInteractor : EditItemInteractor?
    var editWireframe : EditItemWireframe?
    var editItemDelegate : EditItemDelegate?
    var userInterface : EditItemViewInterface?

    
    var item : CommonItem!
    
    func configureUserInterfaceForShow(_ editViewUserInterface: EditItemViewInterface) {
        editViewUserInterface.setEditItemLevel(item.level)
        editViewUserInterface.setEditItemTitle(item.title)
        editViewUserInterface.setEditItemLongDesc(item.longDesc)
        editViewUserInterface.setEditItemShortDesc(item.shortDesc)
    }
}

extension EditItemPresenter : EditItemEventHandler {
    func viewLoaded() {
        configureUserInterfaceForShow(userInterface!)
    }
    
    func cancelEditItem() {
        editWireframe?.hideEditInterface()
    }
    
    func editItemWithTitle(_ title: String, shortDesc: String, longDesc: String?, level: Int) {
        item.title = title
        item.shortDesc = shortDesc
        item.longDesc = longDesc
        item.level = level
        
        editInteractor?.saveItem(item)
        editWireframe?.hideEditInterface()
    }
    
}
