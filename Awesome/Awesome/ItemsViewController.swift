//
//  ItemsViewController.swift
//  Awesome
//
//  Created by Artak on 11/20/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit
import CoreData

enum ItemType {
    case snakes
    case cardGames
    case todos
}

private enum ItemsVCConstants {
    static let segueToItemDetailVCId = "showItemDetail"
    static let segueToNewItemVCId = "showNewItem"
}


class ItemsViewController: UIViewController, ItemsViewDataSource, ItemsViewDelegate {
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    @IBOutlet weak var itemsView: ItemsView!
    
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionHorizontalInset: CGFloat =  5.0

    fileprivate var isGrid: Bool = true
    fileprivate var items : [CommonItem] = []
    fileprivate var dbItems : [NSManagedObject] = []
    
    var itemType : ItemType = .snakes{
        didSet {
            if oldValue != itemType {
                self.title = Helper.getItemDisplayName(itemType: itemType)
                getItems()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   let vc = self.splitViewController?.navigationController
        self.view.backgroundColor = .clear
//        self.itemsView.dataSource = self as? ItemsViewDataSource
//        self.itemsView.delegate = self as? ItemsViewDelegate
        
       getItems()
    }
    
    func getItems() {
        NetworkManager.sharedInstance.getItems(itemType: Helper.getItemName(itemType: itemType)) { (response, error) in
            if !(response is NSNull) {
                self.items.removeAll()
                for dict in response as! [[String:AnyObject]] {
                    let item = ItemFactory.parseItem(dict: dict)
                    self.items.append(item)
                }
                self.itemsTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isGrid = UIDevice.current.orientation.isLandscape &&  (self.traitCollection.verticalSizeClass == .compact) && (self.traitCollection.horizontalSizeClass == .regular)
        updateViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func editTypeAction(_ sender: UIBarButtonItem) {
        let actionSheetController = UIAlertController(title: "Please select Item type", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let snakeActionButton = UIAlertAction(title: Helper.getItemDisplayName(itemType: .snakes), style: .default) { action -> Void in
            self.itemType = .snakes
        }
        actionSheetController.addAction(snakeActionButton)

        let cardActionButton = UIAlertAction(title: Helper.getItemDisplayName(itemType: .cardGames), style: .default) { action -> Void in
             self.itemType = .cardGames
        }
        actionSheetController.addAction(cardActionButton)
        
        let tasksActionButton = UIAlertAction(title: Helper.getItemDisplayName(itemType: .todos), style: .default) { action -> Void in
            self.itemType = .todos

        }
        actionSheetController.addAction(tasksActionButton)

        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func resetItemsAction(_ sender: UIBarButtonItem) {
    
    }
    
    @IBAction func PlusButtonAction(_ sender: UIButton) {
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        if segue.identifier == ItemsVCConstants.segueToItemDetailVCId,
            let destinationVC = segue.destination as? ItemDetailViewController {
            destinationVC.level = 5
        }
        
        
        if segue.identifier == ItemsVCConstants.segueToNewItemVCId,
            let destinationVC = segue.destination as? AddNewItemViewController {
            destinationVC.level = 5
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        isGrid = UIDevice.current.orientation.isLandscape && (self.traitCollection.horizontalSizeClass == .compact) && (self.traitCollection.verticalSizeClass == .regular)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            isGrid =  isGrid || (self.traitCollection.horizontalSizeClass == .compact) && (self.traitCollection.verticalSizeClass == .regular)
            updateViews()
        } else {
            print("Portrait")
            isGrid = false
            updateViews()
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
    }
    
    func updateViews(){
        itemsTableView.isHidden = isGrid
        itemsCollectionView.isHidden = !isGrid
    }
}

extension ItemsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let item = items[indexPath.row]
        
        let cell: ItemCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        
        cell.titleLabel.text = item.title
        cell.levelLbl.text = "\(item.level)"
        cell.shortDescr.text = item.desc
        return cell
    }
}

extension ItemsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
}

extension ItemsViewController : UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
    }
    
}

extension ItemsViewController : UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = items[indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GridCell
        
        cell.backgroundColor = .red
        cell.levelLabel.text = "\(item.level)"
        cell.shortDescLabel.text = item.desc
        cell.titleLabel.text = item.title
        
        return cell
    }
}

extension ItemsViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionHorizontalInset * (itemsPerRow + 1)
        let availableWidth = view.frame.height - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 3.0)
    }
}

