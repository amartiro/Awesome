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

    fileprivate lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Awesome")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    fileprivate lazy var context : NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - Core Data Saving support
    
    internal func save () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                 let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func reset() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
        do {
            try self.context.execute(deleteRequest)
            print("Delete Success")
            //   people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    fileprivate func fetchEntries(_ predicate: NSPredicate, completionBlock: @escaping (([ManagedItem]) -> Void)) {
        let fetchRequest: NSFetchRequest<NSManagedObject>  = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = predicate
        
        context.perform
            {
                let queryResults = try? self.context.fetch(fetchRequest)
                let managedResults = queryResults! as! [ManagedItem]
                completionBlock(managedResults)
        }
    }
    

    func getItems(itemType : ItemType, completion: @escaping (([CommonItem]) -> Void)) {
        let predicate = NSPredicate(format: "type == %@ AND status != %d AND status != %d AND status != %d" , Helper.getItemName(itemType: itemType), ItemStatus.panding_delete.rawValue, ItemStatus.waiting_delete.rawValue, ItemStatus.panding_delete_after_add.rawValue)

        fetchEntries(predicate) { entries in
            let items = self.itemsFromDataStoreEntries(entries)
            completion(items)
        }
    }
    
    func getItems(itemStatus : ItemStatus, completion: @escaping (([CommonItem]) -> Void)) {
        let predicate = NSPredicate(format: "status != %d" , ItemStatus.panding_delete.rawValue)
        
        fetchEntries(predicate) { entries in
            let items = self.itemsFromDataStoreEntries(entries)
            completion(items)
        }
    }
    
    func getItem(itemId : String, completion: @escaping ((CommonItem?) -> Void)) {
        let predicate = NSPredicate(format: "id == %@", itemId)
        fetchEntries(predicate) { entries in
            let items = self.itemsFromDataStoreEntries(entries)
            completion(items.first)
        }
    }
    

    fileprivate func itemsFromDataStoreEntries(_ entries: [ManagedItem]) -> [CommonItem] {

        var todoItems : [CommonItem] = [CommonItem]()
        for entry in entries {
            let item = ItemFactory.parseManagedItem(itemProtocol: entry)
            todoItems.append(item)
        }
        return todoItems
    }
    
    func updateAfterRequest(item : CommonItem) {
        let predicate = NSPredicate(format: "id == %@", item.id)
        
        let fetchRequest: NSFetchRequest<NSManagedObject>  = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = predicate
        
        context.perform
            {
                let queryResults = try? self.context.fetch(fetchRequest)
                let managedResults = queryResults! as! [ManagedItem]
                
                if let managedItem = managedResults.first {
                    switch managedItem.status {
                        
                    case ItemStatus.waiting_add.rawValue :
                        managedItem.status = ItemStatus.untouched.rawValue
                    case ItemStatus.panding_update.rawValue : break
                        
                    case ItemStatus.panding_delete.rawValue : break
                        
                    case ItemStatus.panding_update.rawValue : break
                        
                    default: break
//                    if managedItem.status == ItemStatus.waiting_add.rawValue {
//                        managedItem.imageUrl = item.imageUrl
//                        managedItem.level = item.level
//                        managedItem.shortDesc = item.shortDesc
//                        managedItem.longDesc = item.longDesc
//                        managedItem.title = item.title
//                        managedItem.status = item.status // must be 'updated'
//                    }
                    }
                    
                } else {
                    
                }
        }
                do {
                    try self.context.save()
                    print("Success")
                    //   people.append(person)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
    }
    
    func addOrUpdateItem(item : CommonItem)  {
        let predicate = NSPredicate(format: "id == %@", item.id)

        let fetchRequest: NSFetchRequest<NSManagedObject>  = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = predicate
        
        context.perform
        {
            let queryResults = try? self.context.fetch(fetchRequest)
            let managedResults = queryResults! as! [ManagedItem]
           
            if let managedItem = managedResults.first {
                if managedItem.status == ItemStatus.untouched.rawValue {  // TODO discuss and deside what to do for other statuses
                    managedItem.imageUrl = item.imageUrl
                    managedItem.level = item.level
                    managedItem.shortDesc = item.shortDesc
                    managedItem.longDesc = item.longDesc
                    managedItem.title = item.title
                    managedItem.status = item.status
                }
            } else {
                let newItem =
                    NSEntityDescription.insertNewObject(forEntityName: "Item", into: self.context) as! ManagedItem
                
                // 3
                newItem.setValue(item.title, forKeyPath: "title")
                newItem.setValue(item.imageUrl, forKeyPath: "imageUrl")
                newItem.setValue(item.longDesc, forKeyPath: "longDesc")
                newItem.setValue(item.shortDesc, forKeyPath: "shortDesc")
                newItem.setValue(item.level, forKeyPath: "level")
                newItem.setValue(item.type, forKeyPath: "type")
                newItem.setValue(item.status, forKeyPath: "status") // must be 'untouched'

                newItem.setValue(item.id, forKeyPath: "serverId")
                newItem.setValue(item.id, forKeyPath: "id")
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
     
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: self.context) as! ManagedItem

        newItem.setValue(item.title, forKeyPath: "title")
        newItem.setValue(item.imageUrl, forKeyPath: "imageUrl")
        newItem.setValue(item.longDesc, forKeyPath: "longDesc")
        newItem.setValue(item.shortDesc, forKeyPath: "shortDesc")
        newItem.setValue(item.level, forKeyPath: "level")
        newItem.setValue(item.type, forKeyPath: "type")
        newItem.setValue(item.status, forKeyPath: "status") // must be ItemStatus.panding_add.rawValue
        
        newItem.setValue(item.id, forKeyPath: "serverId")
        newItem.setValue(item.id, forKeyPath: "id")

        do {
            try self.context.save()
            print("Success")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func editItem(item : CommonItem) {
        let predicate = NSPredicate(format: "id == %@", item.id)
        
        let fetchRequest: NSFetchRequest<NSManagedObject>  = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = predicate
        
        context.perform {
            let queryResults = try? self.context.fetch(fetchRequest)
            let managedResults = queryResults! as! [ManagedItem]
            
            if let managedItem = managedResults.first {
                
                managedItem.imageUrl = item.imageUrl
                managedItem.level = item.level
                managedItem.shortDesc = item.shortDesc
                managedItem.longDesc = item.longDesc
                managedItem.title = item.title
               
                switch managedItem.status {
                    case ItemStatus.waiting_add.rawValue:
                        managedItem.status = ItemStatus.panding_update_after_add.rawValue
                    case ItemStatus.waiting_update.rawValue,
                         ItemStatus.untouched.rawValue:
                        managedItem.status = ItemStatus.panding_update.rawValue
                    default:
                        print(managedItem.status)
                }
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
    
    func deleteItem(item : CommonItem) {
        let predicate = NSPredicate(format: "id == %@", item.id)
        
        let fetchRequest: NSFetchRequest<NSManagedObject>  = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = predicate
        
        context.perform {
            let queryResults = try? self.context.fetch(fetchRequest)
            let managedResults = queryResults! as! [ManagedItem]
            
            if let managedItem = managedResults.first {
                switch managedItem.status {
                case ItemStatus.waiting_add.rawValue,
                     ItemStatus.panding_update_after_add.rawValue:
                    managedItem.status = ItemStatus.panding_delete_after_add.rawValue
                case ItemStatus.waiting_update.rawValue,
                     ItemStatus.panding_update.rawValue,
                     ItemStatus.untouched.rawValue:
                    managedItem.status = ItemStatus.panding_delete.rawValue
                case ItemStatus.panding_add.rawValue:
                    self.context.delete(managedItem)
                default:
                    print(managedItem.status)
                }
            }
            
            do {
                try self.context.save()
                print("Success")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
    func saveItem(item : CommonItem) {
        
        let predicate = NSPredicate(format: "id == %@", item.id)
        
        let fetchRequest: NSFetchRequest<NSManagedObject>  = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = predicate
        
        context.perform {
            let queryResults = try? self.context.fetch(fetchRequest)
            let managedResults = queryResults! as! [ManagedItem]
            
            if let managedItem = managedResults.first {
                
                managedItem.imageUrl = item.imageUrl
                managedItem.level = item.level
                managedItem.shortDesc = item.shortDesc
                managedItem.longDesc = item.longDesc
                managedItem.title = item.title
                managedItem.status = item.status
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
    
  
}
