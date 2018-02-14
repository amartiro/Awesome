//
//  RootWireframe.swift
//  Awesome
//
//  Created by Artak on 1/31/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class RootWireframe: NSObject {
    func showRootViewController(_ viewController: UIViewController, inWindow: UIWindow) {
        let navigationController = navigationControllerFromWindow(inWindow)
        navigationController.viewControllers = [viewController]
    }
    
    func navigationControllerFromWindow(_ window: UIWindow) -> UINavigationController {
        let navigationController = window.rootViewController as! UINavigationController
        return navigationController
    }
}
