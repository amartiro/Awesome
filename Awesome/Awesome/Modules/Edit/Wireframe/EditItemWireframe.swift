//
//  EditItemWireframe.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation

import UIKit

let EditItemViewControllerIdentifier = "EditItemViewController"


class EditItemWireframe: NSObject{
    
    var editPresenter : EditItemPresenter!
    var shownViewController : UIViewController?
    
    func showEditInterfaceFromNavigationController(_ navController: UINavigationController, _ item : CommonItem) {
        let newViewController = editViewController()
        newViewController.eventHandler = editPresenter
        editPresenter.item = item
        editPresenter.userInterface = newViewController
        navController.pushViewController(newViewController, animated: true)
        
        shownViewController = newViewController
    }
    
    func hideEditInterface() {
        shownViewController?.navigationController?.popViewController(animated: true)
    }
    
    
    func editViewController() -> EditItemViewController {
        let storyboard = mainStoryboard()
        let editViewController: EditItemViewController = storyboard.instantiateViewController(withIdentifier: EditItemViewControllerIdentifier) as! EditItemViewController
        return editViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
