//
//  MainViewController.swift
//  Awesome
//
//  Created by Artak on 2/13/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var eventHandler : MainEventHandler?
    
    @IBOutlet weak var editView: AddEditView!
    @IBOutlet weak var detailsView: ItemDetailView!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var chooseTypeBarButton: UIBarButtonItem!
    @IBOutlet weak var editButton: FAButton!
    fileprivate var items : [DisplayItem] = []
    
    
    fileprivate var itemTitle : String!
    fileprivate var shortDesc : String!
    fileprivate var longDesc : String?
    fileprivate var itemLevel : Int = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemsTableView.register(UINib(nibName: "ItemTableCell", bundle: nil), forCellReuseIdentifier: "ItemTableCell")
        editView.delegate = self
        eventHandler?.selectedItemType(.cardGames)
        editView.saveButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler?.selectedItemType(.snakes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItemButtonAction(_ sender: Any) {
        eventHandler?.addNewItem()
    }
    @IBAction func resetButtonAction(_ sender: Any) {
        eventHandler?.resetItems()
    }
    
    @IBAction func changeTypeButtonAction(_ sender: Any) {
        eventHandler?.changeItemsType()
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        eventHandler?.editItem()
    }
}

extension MainViewController : MainViewInterface {
    func showEditView() {
        editView.isHidden =  false
        detailsView.isHidden = true
        editButton.isHidden = true
    }
    
    func showDetailsView() {
        editView.isHidden =  true
        detailsView.isHidden = false
        editButton.isHidden = false
    }
    
    func setTitle(_ title: String) {
        self.title = title
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
    
   
    func setItemTitle(_ title: String) {
        detailsView.titleLabel.text = title
    }
    
    func setItemShortDesc(_ desc: String) {
        detailsView.shortDescLabel.text = desc
    }
    
    func setItemLongDesc(_ desc: String?) {
        detailsView.fullDescLabel.text = desc
    }
    
    func setItemLevel(_ level: Int) {
        detailsView?.levelMeter.level = level
    }
    
    func showNoContentMessage() {
        
    }
    
    func showItems(_ items: [DisplayItem]) {
        self.items = items
        if items.count > 0 {
            self.itemsTableView.reloadData()
            self.itemsTableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
            eventHandler?.selectItemWithIndex(0)
        }       
    }
    
    func showItemTypeDialog() {
        let actionSheetController = UIAlertController(title: "Please select Item type", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let snakeActionButton = UIAlertAction(title: Helper.getItemDisplayName(itemType: .snakes), style: .default) { action -> Void in
            self.eventHandler?.selectedItemType(.snakes)
        }
        actionSheetController.addAction(snakeActionButton)
        
        let cardActionButton = UIAlertAction(title: Helper.getItemDisplayName(itemType: .cardGames), style: .default) { action -> Void in
            self.eventHandler?.selectedItemType(.cardGames)
        }
        actionSheetController.addAction(cardActionButton)
        
        let tasksActionButton = UIAlertAction(title: Helper.getItemDisplayName(itemType: .todos), style: .default) { action -> Void in
            self.eventHandler?.selectedItemType(.todos)
            
        }
        actionSheetController.addAction(tasksActionButton)
        
        let popover = UIPopoverController.init(contentViewController: actionSheetController)
        popover.present(from: chooseTypeBarButton, permittedArrowDirections: .any, animated: true)
    }
}

extension MainViewController: AddEditViewDelegate {
    func increaseLevel() {
        setEditItemLevel(min(itemLevel + 1, 10))
        saveAction()
    }
    
    func decreaseLevel() {
        setEditItemLevel(max(itemLevel - 1, 1))
        saveAction()
    }
    
    func titleChanged(_ title: String) {
        itemTitle = title
        saveAction()
    }
    
    func shortDescrChanged(_ desc: String) {
        shortDesc = desc
        saveAction()
    }
    
    func longDescrChanged(_ desc: String) {
        longDesc = desc
        saveAction()
    }
    
    func saveAction() {
        eventHandler?.editItemWithTitle(itemTitle, shortDesc: shortDesc, longDesc: longDesc, level: itemLevel)
        eventHandler?.reloadItem()
    }
    
    func saveButtonAction() {
        self.saveAction()
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell") as! ItemTableCell

        cell.titleLabel.text = item.title
        cell.levelLbl.text = "\(item.level)"
        cell.shortDescr.text = item.shortDesc
        return cell
    }
}

extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler?.selectItemWithIndex(indexPath.row)
      //  tableView.deselectRow(at: indexPath, animated: true)
    }
}
