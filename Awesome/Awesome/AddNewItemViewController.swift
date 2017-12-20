//
//  AddNewItemViewController.swift
//  Awesome
//
//  Created by Artak on 11/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit
import CoreData

class AddNewItemViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var shortDescrTextField: UITextField!
    @IBOutlet weak var longDescTextView: UITextView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var minusLevelButton: UIButton!
    @IBOutlet weak var plusLevelButton: UIButton!
    
    var level : Int = 10 {
        
        didSet {
            levelLabel?.text = "\(level)"
//            levelMeter?.level = level
//            levelMeter?.counter = 10
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        longDescTextView.layer.borderWidth = 1
        longDescTextView.layer.borderColor = UIColor.gray.cgColor
        longDescTextView.layer.cornerRadius = 5
        
        minusLevelButton.layer.cornerRadius = 5
        plusLevelButton.layer.cornerRadius = 5
        
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
      //  save(name: "Gago")
        
        NetworkManager.sharedInstance.addItem(type: Helper.getItemName(itemType: .cardGames), title: "Blot Bazar", shortDesc: "Bazar Blot", longDesc: "Game for 2/4 people", level: 3) { (response, error) in
            if !(response is NSNull) {
                
            }
        }
    }
    
    @IBAction func minusLevelAction(_ sender: UIButton) {
        if level > 1 {
            level = level - 1
        }
    }
    
    @IBAction func plusLevelAction(_ sender: UIButton) {
        if level < 10 {
            level = level + 1
        }
    }
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Item",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "title")
        
        // 4
        do {
            try managedContext.save()
         //   people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
