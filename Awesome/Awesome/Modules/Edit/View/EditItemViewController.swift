 //
//  EditItemViewController.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController, EditItemViewInterface {
    var eventHandler : EditItemEventHandler?
    @IBOutlet var editView: AddEditView!
    
    fileprivate var itemTitle : String!
    fileprivate var shortDesc : String!
    fileprivate var longDesc : String?
    fileprivate var itemLevel : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editView.delegate = self
        eventHandler?.viewLoaded()
    }
    func setEditItemTitle(_ title: String) {
        itemTitle = title
        editView.titleTextField.text = itemTitle
    }
    
    func setEditItemShortDesc(_ desc: String) {
        shortDesc = desc
        editView.shortDescrTextField.text = shortDesc
    }
    
    func setEditItemLongDesc(_ desc: String?) {
        longDesc = desc
        editView.longDescTextView.text = longDesc
    }
    
    func setEditItemLevel(_ level: Int) {
        itemLevel = level
        editView.levelLabel.text = "\(itemLevel)"
    }
}

extension EditItemViewController : AddEditViewDelegate {
    func increaseLevel() {
        setEditItemLevel(min(itemLevel + 1, 10))
    }
    
    func decreaseLevel() {
        setEditItemLevel(max(itemLevel - 1, 1))
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
            eventHandler?.editItemWithTitle(itemTitle, shortDesc: shortDesc, longDesc: longDesc, level: itemLevel)
    }
}
