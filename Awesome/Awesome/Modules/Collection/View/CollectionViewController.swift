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

    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionHorizontalInset: CGFloat =  15.0


    var eventHandler : CollectionEventHandler?  // Presenter
    
    fileprivate var items : [DisplayItem] = []
 //   fileprivate var selectedItem : DisplayItem?

    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.itemsTableView.register(UINib(nibName: "ItemTableCell", bundle: nil), forCellReuseIdentifier: "ItemTableCell")
        
        self.itemsCollectionView.register(UINib(nibName: "ItemGridCell", bundle: nil), forCellWithReuseIdentifier: "ItemGridCell")
        
      //  self.itemsTableView.rowHeight = 100
        
      //  getItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler?.selectedItemType(.snakes)
        updateViews()
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
        self.itemsCollectionView.reloadData()
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
        updateViews()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
    }
    
    func updateViews(){
        let isGrid = UIDevice.current.orientation.isLandscape && (UIDevice.current.userInterfaceIdiom == .phone)
        
        itemsTableView.isHidden = isGrid
        itemsCollectionView.isHidden = !isGrid
        
        itemsCollectionView.collectionViewLayout.invalidateLayout()
        itemsCollectionView.reloadData()
    }
    
}

extension CollectionViewController : UITableViewDataSource {
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

extension CollectionViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler?.selectItemWithIndex(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CollectionViewController : UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        eventHandler?.selectItemWithIndex(indexPath.row)
    }
}

extension CollectionViewController : UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemGridCell", for: indexPath) as! ItemGridCell
        
        cell.levelLbl?.text = "\(item.level)"
        cell.shortDescr?.text = item.shortDesc
        cell.titleLabel?.text = item.title
        
        return cell
    }
}

extension CollectionViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionHorizontalInset * (itemsPerRow + 1)
        let availableWidth = max(collectionView.frame.height, collectionView.frame.width) - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 4.0)
    }
}
