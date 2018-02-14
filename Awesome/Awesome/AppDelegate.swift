//
//  AppDelegate.swift
//  Awesome
//
//  Created by Artak on 11/20/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit
import CoreData
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var diContainer : Container = Container()
  


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        diContainer.register(NetworkManager.self) {
            _ in NetworkFactory.getManager()
        }.inObjectScope(.container)
        
        diContainer.register(DatabaseManager.self) {
            _ in DatabaseFactory.getManager()
        }
        
        diContainer.register(DataSourceManager.self) {
            c in DataSourceFactory.getManager(networkManager: c.resolve(NetworkManager.self)!,
                                              databaseManager: c.resolve(DatabaseManager.self)! )
        }
        
        diContainer.register(RootWireframe.self) { c in RootWireframe.init() }
        diContainer.register(MainWireframe.self) { c in MainWireframe.init() }
        diContainer.register(CollectionWireframe.self) { c in CollectionWireframe.init() }
        diContainer.register(AddItemWireframe.self) { c in AddItemWireframe.init() }
        diContainer.register(ItemDetailsWireframe.self) { c in ItemDetailsWireframe.init() }
        diContainer.register(EditItemWireframe.self) { c in EditItemWireframe.init() }

        diContainer.register(CollectionPresenter.self) { c in CollectionPresenter.init() }
        diContainer.register(MainPresenter.self) { c in MainPresenter.init() }
        diContainer.register(AddItemPresenter.self) { c in AddItemPresenter.init() }
        diContainer.register(ItemDetailsPresenter.self) { c in ItemDetailsPresenter.init() }
        diContainer.register(EditItemPresenter.self) { c in EditItemPresenter.init() }
        
        diContainer.register(CollectionDataManager.self) { c in CollectionDataManager.init(dataManager: c.resolve(DataSourceManager.self)! ) }
        diContainer.register(MainDataManager.self) { c in MainDataManager.init(dataManager: c.resolve(DataSourceManager.self)! ) }
        diContainer.register(AddItemDataManager.self) { c in AddItemDataManager.init(dataManager: c.resolve(DataSourceManager.self)! ) }
        diContainer.register(ItemDetailsDataManager.self) { c in ItemDetailsDataManager.init(dataManager: c.resolve(DataSourceManager.self)! ) }
        diContainer.register(EditItemDataManager.self) { c in EditItemDataManager.init(dataManager: c.resolve(DataSourceManager.self)! ) }

        diContainer.register(CollectionInteractor.self) {
            c in CollectionInteractor.init(dataManager: c.resolve(CollectionDataManager.self)!)
        }
        diContainer.register(MainInteractor.self) {
            c in MainInteractor.init(dataManager: c.resolve(MainDataManager.self)!)
        }
        diContainer.register(AddItemInteractor.self) {
            c in AddItemInteractor.init(dataManager: c.resolve(AddItemDataManager.self)!)
        }
        diContainer.register(ItemDetailsInteractor.self) {
            c in ItemDetailsInteractor.init(dataManager: c.resolve(ItemDetailsDataManager.self)!)
        }
        diContainer.register(EditItemInteractor.self) {
            c in EditItemInteractor.init(dataManager: c.resolve(EditItemDataManager.self)!)
        }
        
        let appDependencies = AppDependencies()

        appDependencies.installRootViewControllerIntoWindow(window!)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
         diContainer.resolve(DataSourceManager.self)?.save()
    }

}

