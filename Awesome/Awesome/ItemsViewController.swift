//
//  ItemsViewController.swift
//  Awesome
//
//  Created by Artak on 11/20/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

enum ItemType {
    case snakes
    case cardGames
    case todos
}

private enum ItemsVCConstants {
    static let segueToItemDetailVCId = "showItemDetail"
    static let segueToNewItemVCId = "showNewItem"
}


class ItemsViewController: UIViewController {
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionHorizontalInset: CGFloat =  5.0

    fileprivate var isGrid: Bool = true
    
    var itemType : ItemType = .snakes{
        didSet {
            if oldValue != itemType {
                self.title = Helper.sharedInstance.getItemDisplayName(itemType: itemType)
//                NetworkManager.sharedInstance.getItems(itemType: Helper.sharedInstance.getItemName(itemType: itemType)) { (response, error) in
//              
//                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow;
//        NetworkManager.sharedInstance.getItems(itemType: "SNAKE") { (response, error) in
//
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let snakeActionButton = UIAlertAction(title: Helper.sharedInstance.getItemDisplayName(itemType: .snakes), style: .default) { action -> Void in
            self.itemType = .snakes
        }
        actionSheetController.addAction(snakeActionButton)

        let cardActionButton = UIAlertAction(title: Helper.sharedInstance.getItemDisplayName(itemType: .cardGames), style: .default) { action -> Void in
             self.itemType = .cardGames
        }
        actionSheetController.addAction(cardActionButton)
        
        let tasksActionButton = UIAlertAction(title: Helper.sharedInstance.getItemDisplayName(itemType: .todos), style: .default) { action -> Void in
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
    
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            isGrid = true
            itemsTableView.isHidden = true
            itemsCollectionView.isHidden = false
            
        //    imageView.image = UIImage(named: const2)
        } else {
            print("Portrait")
            isGrid = false
            itemsTableView.isHidden = false
            itemsCollectionView.isHidden = true
            
    //        imageView.image = UIImage(named: const)
        }
    }
}

extension ItemsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
//        if isGrid {
//            let cell: GridCell = tableView.dequeueReusableCell(withIdentifier: "GridCell") as! GridCell
//
//            return cell
//        }
        let cell: ItemCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        
        cell.titleLabel.text = "Samo"
        cell.levelLbl.text = "8"
        cell.shortDescr.text = "Call cheif"
        return cell
        
    }
    
}

extension ItemsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//       if isGrid {
//        return 93
//        }
        return 60;
    }
    
}

extension ItemsViewController : UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        
    }
    
}

extension ItemsViewController : UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 17
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // Configure the cell
        
        cell.backgroundColor = .red
        
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
    

extension ItemsViewController : UIActionSheetDelegate {
    
    
}
