//
//  MainWireframe.swift
//  Awesome
//
//  Created by Artak on 2/13/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

let MainViewControllerIdentifier = "MainViewController"

class MainWireframe {
    
    var addWireframe: AddItemWireframe?
    
    var mainPresenter : MainPresenter?
    var rootWireframe : RootWireframe?
    var mainViewController : MainViewController?
    
    func presentInterfaceFromWindow(_ window: UIWindow) {
        let viewController = mainViewControllerFromStoryboard()
        viewController.eventHandler = mainPresenter
        mainViewController = viewController
        mainPresenter?.userInterface = viewController
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func showAddInterface(itemType : ItemType) {
        addWireframe?.showAddInterfaceFromNavigationController((mainViewController?.navigationController)!, itemType)
    }
    
    func mainViewControllerFromStoryboard() -> MainViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: MainViewControllerIdentifier) as! MainViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
