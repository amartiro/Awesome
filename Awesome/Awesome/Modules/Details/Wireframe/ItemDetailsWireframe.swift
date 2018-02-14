//
//  ItemDetailsWireframe.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

let ItemDetailsViewControllerIdentifier = "ItemDetailsViewController"


class ItemDetailsWireframe: NSObject {
   
    var editWireframe: EditItemWireframe?
    var itemDetailsPresenter : ItemDetailsPresenter?
    var itemDetailsViewController : ItemDetailsViewController?


    func showDetailsInterfaceFromNavigationController(_ navController: UINavigationController, _ item : CommonItem) {
        let newViewController = detailsViewController()
        itemDetailsPresenter?.itemId = item.id
        itemDetailsPresenter?.userInterface = newViewController
        newViewController.eventHandler = itemDetailsPresenter
        
        navController.pushViewController(newViewController, animated: true)
        self.itemDetailsPresenter?.configureUserInterfaceForShow(newViewController)
        
        itemDetailsViewController = newViewController
        
    }
    
    func showEditInterface(_ item : CommonItem) {
        editWireframe?.showEditInterfaceFromNavigationController((itemDetailsViewController?.navigationController)!, item)
    }
    
    func hideEditInterface() {
        itemDetailsViewController?.navigationController?.popViewController(animated: true)
    }
    
    func detailsViewController() -> ItemDetailsViewController {
        let storyboard = mainStoryboard()
        let detailsViewController: ItemDetailsViewController = storyboard.instantiateViewController(withIdentifier: ItemDetailsViewControllerIdentifier) as! ItemDetailsViewController
        
        print(detailsViewController.view.frame)
        
        return detailsViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
}
