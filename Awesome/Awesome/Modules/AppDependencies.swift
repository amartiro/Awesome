//
//  AppDependencies.swift
//  Awesome
//
//  Created by Artak on 1/31/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    fileprivate var collectionWireframe : CollectionWireframe!
    fileprivate var mainWireframe : MainWireframe!
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            collectionWireframe.presentInterfaceFromWindow(window)
        } else {
            mainWireframe.presentInterfaceFromWindow(window)
        }
    }
    
    func configureDependencies() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        collectionWireframe = appDelegate.diContainer.resolve(CollectionWireframe.self)!
        mainWireframe = appDelegate.diContainer.resolve(MainWireframe.self)!

        let rootWireframe = appDelegate.diContainer.resolve(RootWireframe.self)!
        let collectionPresenter = appDelegate.diContainer.resolve(CollectionPresenter.self)!
        let collectionInteractor = appDelegate.diContainer.resolve(CollectionInteractor.self)!
        
        let mainPresenter = appDelegate.diContainer.resolve(MainPresenter.self)!
        let mainInteractor = appDelegate.diContainer.resolve(MainInteractor.self)!
        
        let addWireframe = appDelegate.diContainer.resolve(AddItemWireframe.self)!
        let addPresenter = appDelegate.diContainer.resolve(AddItemPresenter.self)!
        let addInteractor = appDelegate.diContainer.resolve(AddItemInteractor.self)!

        let detailsWireframe = appDelegate.diContainer.resolve(ItemDetailsWireframe.self)!
        let detailsInteractor = appDelegate.diContainer.resolve(ItemDetailsInteractor.self)!
        let detailsPresenter = appDelegate.diContainer.resolve(ItemDetailsPresenter.self)!
        
        let editWireframe = appDelegate.diContainer.resolve(EditItemWireframe.self)!
        let editPresenter = appDelegate.diContainer.resolve(EditItemPresenter.self)!
        let editInteractor = appDelegate.diContainer.resolve(EditItemInteractor.self)!
        
       
        mainWireframe.addWireframe = addWireframe
        mainWireframe.mainPresenter = mainPresenter
        mainWireframe.rootWireframe = rootWireframe
        
        mainPresenter.mainInteractor = mainInteractor
        mainInteractor.output = mainPresenter
        mainPresenter.mainWireframe = mainWireframe
        
        collectionInteractor.output = collectionPresenter
        collectionPresenter.collectionInteractor = collectionInteractor
        collectionPresenter.collectionWireframe = collectionWireframe
        
        collectionWireframe.addWireframe = addWireframe
        collectionWireframe.detailsWireframe = detailsWireframe
        collectionWireframe.collectionPresenter = collectionPresenter
        collectionWireframe.rootWireframe = rootWireframe
        
        editWireframe.editPresenter = editPresenter
        editPresenter.editWireframe = editWireframe
        editPresenter.editInteractor = editInteractor
        
        addWireframe.addPresenter = addPresenter
        addPresenter.addWireframe = addWireframe
        addPresenter.addItemDelegate = collectionPresenter
        addPresenter.addInteractor = addInteractor
        
        detailsWireframe.itemDetailsPresenter = detailsPresenter
        detailsPresenter.itemDetailsWireframe = detailsWireframe
        detailsPresenter.itemDetailsInteractor = detailsInteractor
        detailsInteractor.output = detailsPresenter
        detailsWireframe.editWireframe = editWireframe
        
    }
}
