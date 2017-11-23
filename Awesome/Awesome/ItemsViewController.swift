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
    case tasks
}

private enum ItemsVCConstants {
    static let segueToItemDetailVCId = "showItemDetail"

}


class ItemsViewController: UIViewController {
    @IBOutlet weak var itemsTableView: UITableView!
    
    var itemType : ItemType! {
        didSet {
            self.title = "\(itemType!)"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow;
      
        //itemsTableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
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
        
        let snakeActionButton = UIAlertAction(title: "Snakes", style: .default) { action -> Void in
            self.itemType = .snakes
        }
        actionSheetController.addAction(snakeActionButton)
        
        let cardActionButton = UIAlertAction(title: "Card Games", style: .default) { action -> Void in
             self.itemType = .cardGames
        }
        actionSheetController.addAction(cardActionButton)
        
        let tasksActionButton = UIAlertAction(title: "Tasks/To Do", style: .default) { action -> Void in
            self.itemType = .tasks

        }
        actionSheetController.addAction(tasksActionButton)

        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func resetItemsAction(_ sender: UIBarButtonItem) {
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        if segue.identifier == ItemsVCConstants.segueToItemDetailVCId,
            let destinationVC = segue.destination as? ItemDetailViewController {
            
            
        }
    }
        
}

extension ItemsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ItemCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        
        cell.titleLabel.text = "Samo"
        cell.levelLbl.text = "8"
        cell.shortDescr.text = "Call cheif"
        return cell
        
    }
    
}

extension ItemsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60;
    }
    
}

extension ItemsViewController : UIActionSheetDelegate {
    
    
}
