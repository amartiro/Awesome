//
//  AddNewItemViewController.swift
//  Awesome
//
//  Created by Artak on 11/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var shortDescrTextField: UITextField!
    @IBOutlet weak var longDescTextView: UITextView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var minusLevelButton: UIButton!
    @IBOutlet weak var plusLevelButton: UIButton!
    
    var level = 5 {
        
        didSet {
            levelLabel.text = "\(level)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        longDescTextView.layer.borderWidth = 1
        longDescTextView.layer.borderColor = UIColor.gray.cgColor
        longDescTextView.layer.cornerRadius = 5
        
        minusLevelButton.layer.cornerRadius = 5
        plusLevelButton.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func minusLevelAction(_ sender: UIButton) {
        if level > 0 {
            level = level - 1
        }
    }
    
    @IBAction func plusLevelAction(_ sender: UIButton) {
        if level < 10 {
            level = level + 1
        }
    }
    
    @IBOutlet weak var minusLevelAction: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
