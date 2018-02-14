//
//  CollectionViewController.swift
//  Awesome
//
//  Created by Artak on 1/31/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController : UIViewController, CollectionViewInterface {

    var eventHandler : CollectionEventHandler?  // Presenter
    
    fileprivate var items : [DisplayItem] = []
 //   fileprivate var selectedItem : DisplayItem?

    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.itemsTableView.register(UINib(nibName: "ItemTableCell", bundle: nil), forCellReuseIdentifier: "ItemTableCell")
        
        self.itemsTableView.register(UINib(nibName: "GridTableCell", bundle: nil), forCellReuseIdentifier: "GridTableCell")
        
        self.itemsTableView.rowHeight = 100
        
      //  getItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler?.selectedItemType(.snakes)
    }
    @IBAction func resetButtonAction(_ sender: Any) {
        eventHandler?.resetItems()
    }
    
    @IBAction func changeTypeButtonAction(_ sender: Any) {
        eventHandler?.changeItemsType()
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        eventHandler?.addNewItem()
    }
    
    func showNoContentMessage() {
        
    }
    
    func setTitle(_ title: String){
        self.title = title
    }
    
    func showItems(_ items: [DisplayItem]) {
        self.items = items
        self.itemsTableView.reloadData()
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
        
        self.present(actionSheetController, animated: true) {
        
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
        
        self.itemsTableView.reloadData()
    }
    
}

extension CollectionViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
//        if UIDevice.current.orientation.isLandscape  {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "GridTableCell") as! GridTableCell
//
////            cell.titleLabel.text = item.title
////            cell.levelLbl.text = "\(item.level)"
////            cell.shortDescr.text = item.shortDesc
//
//
//            return cell
//        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell") as! ItemTableCell
        
        cell.titleLabel.text = item.title
        cell.levelLbl.text = "\(item.level)"
        cell.shortDescr.text = item.shortDesc
        

        return cell
 //       }
    }
}

extension CollectionViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if UIDevice.current.orientation.isLandscape  {
//            return 80
//        } else {
            return 60
//        }
    }
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
//        selectedItem = self.items[indexPath.row]
//        return indexPath
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler?.selectItemWithIndex(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
