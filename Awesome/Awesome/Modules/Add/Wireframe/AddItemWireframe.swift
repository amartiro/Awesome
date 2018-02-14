//
//  AddItemWireframe.swift
//  Awesome
//
//  Created by Artak on 1/29/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

let AddItemViewControllerIdentifier = "AddItemViewController"


class AddItemWireframe: NSObject{
    
    var addPresenter : AddItemPresenter?
    var shownViewController : UIViewController?
    
    func showAddInterfaceFromNavigationController(_ navController: UINavigationController, _ itemType : ItemType) {
        let newViewController = addViewController()
        newViewController.eventHandler = addPresenter
        addPresenter?.itemType = itemType
        addPresenter?.userInterface = newViewController
        
        navController.pushViewController(newViewController, animated: true)
        
        shownViewController = newViewController
    }
    
    func hideAddInterface() {
        shownViewController?.navigationController?.popViewController(animated: true)
    }
    
    
    func addViewController() -> AddItemViewController {
        let storyboard = mainStoryboard()
        let addViewController: AddItemViewController = storyboard.instantiateViewController(withIdentifier: AddItemViewControllerIdentifier) as! AddItemViewController
        return addViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}


