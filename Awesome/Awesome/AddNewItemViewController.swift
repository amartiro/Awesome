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

    fileprivate var dataManager : DataSourceManager?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var shortDescrTextField: UITextField!
    @IBOutlet weak var longDescTextView: UITextView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var minusLevelButton: UIButton!
    @IBOutlet weak var plusLevelButton: UIButton!
    
    var itemType : ItemType!
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
        
        let item : CommonItem = CommonItem()
        item.title = titleTextField.text!
        item.shortDesc = shortDescrTextField.text!
        item.longDesc = longDescTextView.text
        item.type = Helper.getItemName(itemType: itemType)
        item.level = level
                
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.dataManager = appDelegate.diContainer.resolve(DataSourceManager.self)!
        
        self.dataManager?.addItem(item: item)
        
      //  self.navigationController?.popViewController(animated: true)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
