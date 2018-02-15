//
//  AddItemViewController.swift
//  Awesome
//
//  Created by Artak on 1/29/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, AddItemViewInterface {

    var eventHandler : AddItemEventHandler?

    @IBOutlet weak var addEditView: AddEditView!
    
    fileprivate var itemTitle : String!
    fileprivate var shortDesc : String!
    fileprivate var longDesc : String?
    fileprivate var itemLevel : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEditView.delegate = self
        eventHandler?.viewLoaded()
    }

    func setItemTitle(_ title: String) {
        itemTitle = title
        addEditView.titleTextField.text = itemTitle
    }
    
    func setItemShortDesc(_ desc: String) {
        shortDesc = desc
        addEditView.shortDescrTextField.text = shortDesc
    }
    
    func setItemLongDesc(_ desc: String?) {
        longDesc = desc
        addEditView.longDescTextView.text = longDesc
    }
    
    func setItemLevel(_ level: Int) {
        itemLevel = level
        addEditView.levelLabel.text = "\(level)"
    }
}

extension AddItemViewController : AddEditViewDelegate {
    func increaseLevel() {
        setItemLevel(min(itemLevel + 1, 10))
    }
    
    func decreaseLevel() {
        setItemLevel(max(itemLevel - 1, 1))
    }
    
    func titleChanged(_ title: String) {
        itemTitle = title
    }
    
    func shortDescrChanged(_ desc: String) {
        shortDesc = desc
    }
    
    func longDescrChanged(_ desc: String) {
        longDesc = desc
    }
    
    func saveButtonAction() {
        eventHandler?.saveAddItemWithTitle(itemTitle, shortDesc: shortDesc, longDesc: longDesc, level: itemLevel)
    }
}
