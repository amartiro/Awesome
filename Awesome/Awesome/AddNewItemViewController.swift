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
    @IBOutlet weak var levelMeter: LevelMeter!
    
    var level : Int = 10 {
        
        didSet {
            levelLabel?.text = "\(level)"
            levelMeter?.level = level
            levelMeter?.counter = 10
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
    
    @IBOutlet weak var minusLevelAction: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
