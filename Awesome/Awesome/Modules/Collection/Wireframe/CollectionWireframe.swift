//
//  CollectionWireframe.swift
//  Awesome
//
//  Created by Artak on 1/31/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation
import UIKit

let CollectionViewControllerIdentifier = "CollectionViewController"

class CollectionWireframe : NSObject {
    var addWireframe: AddItemWireframe?
    var detailsWireframe: ItemDetailsWireframe?
    
    var collectionPresenter : CollectionPresenter?
    var rootWireframe : RootWireframe?
    var collectionViewController : CollectionViewController?
    
    
    func presentInterfaceFromWindow(_ window: UIWindow) {
        let viewController = collectionViewControllerFromStoryboard()
        viewController.eventHandler = collectionPresenter
        collectionViewController = viewController
        collectionPresenter?.userInterface = viewController
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func showAddInterface(itemType : ItemType) {
        addWireframe?.showAddInterfaceFromNavigationController((collectionViewController?.navigationController)!, itemType)
    }
    
    func showDetailsInterface(_ item : CommonItem) {
        detailsWireframe?.showDetailsInterfaceFromNavigationController((collectionViewController?.navigationController)!, item)
    }
    
    func collectionViewControllerFromStoryboard() -> CollectionViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: CollectionViewControllerIdentifier) as! CollectionViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
}
