//
//  CoreDataManager.swift
//  Awesome
//
//  Created by Artak on 12/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager : DatabaseManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Awesome")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context : NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - Core Data Saving support
    
    func save () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func fetchEntries(_ predicate: NSPredicate, completionBlock: @escaping (([ManagedItem]) -> Void)) {
        let fetchRequest: NSFetchRequest<NSManagedObject>  = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = predicate
        //        fetchRequest.sortDescriptors = sortDescriptors
        
        
        context.perform
            {
                let queryResults = try? self.context.fetch(fetchRequest)
                let managedResults = queryResults! as! [ManagedItem]
                completionBlock(managedResults)
        }
    }
    

    func getItems(itemType : ItemType, completion: @escaping (([CommonItem]) -> Void)) {
        let predicate = NSPredicate(format: "(type == \"\(Helper.getItemName(itemType: itemType) )\")")
        fetchEntries(predicate) { entries in
            let items = self.itemsFromDataStoreEntries(entries)
            completion(items)
        }

    }

    func itemsFromDataStoreEntries(_ entries: [ManagedItem]) -> [CommonItem] {

        var todoItems : [CommonItem] = [CommonItem]()
        for entry in entries {
            let item = ItemFactory.parseManagedItem(itemProtocol: entry)
            todoItems.append(item)
        }
        return todoItems
    }
    
//    func addItem(item : CommonItem)  {
//        coreDataStore?.newItem(item: item)
//    }
//
//    func editItem(item : CommonItem)  {
//        coreDataStore?.editItem(item: item)
//    }
    
    func addOrUpdateItem(item : CommonItem)  {
        let predicate = NSPredicate(format: "id == %@", item.id)

        let fetchRequest: NSFetchRequest<NSManagedObject>  = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = predicate
        
        context.perform
        {
            let queryResults = try? self.context.fetch(fetchRequest)
            let managedResults = queryResults! as! [ManagedItem]
           
            if let managedItem = managedResults.first {
                
                managedItem.imageUrl = item.imageUrl
                managedItem.level = item.level
                managedItem.shortDesc = item.shortDesc
                managedItem.longDesc = item.longDesc
                managedItem.title = item.title
                
            } else {
                let person =
                    NSEntityDescription.insertNewObject(forEntityName: "Item", into: self.context) as! ManagedItem
                
                // 3
                person.setValue(item.title, forKeyPath: "title")
                person.setValue(item.imageUrl, forKeyPath: "imageUrl")
                person.setValue(item.longDesc, forKeyPath: "longDesc")
                person.setValue(item.shortDesc, forKeyPath: "shortDesc")
                person.setValue(item.id, forKeyPath: "serverId")
                person.setValue(item.id, forKeyPath: "id")
                person.setValue(item.level, forKeyPath: "level")
                person.setValue(item.type, forKeyPath: "type")
            }
            
            do {
                try self.context.save()
                print("Success")
                //   people.append(person)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
       
    }
    
    func addItem(item : CommonItem) {
     
        let person = NSEntityDescription.insertNewObject(forEntityName: "Item", into: self.context) as! ManagedItem

        // 3
        person.setValue(item.title, forKeyPath: "title")
        person.setValue(item.imageUrl, forKeyPath: "imageUrl")
        person.setValue(item.longDesc, forKeyPath: "longDesc")
        person.setValue(item.shortDesc, forKeyPath: "shortDesc")
        person.setValue(item.id, forKeyPath: "serverId")
        person.setValue(item.id, forKeyPath: "id")
        person.setValue(item.level, forKeyPath: "level")
        person.setValue(item.type, forKeyPath: "type")
        
        do {
            try self.context.save()
            print("Success")
            //   people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
        

    
}
