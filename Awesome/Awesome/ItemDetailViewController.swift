//
//  ItemDetailViewController.swift
//  Awesome
//
//  Created by Artak on 11/21/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit
import Kingfisher

private enum ItemDetailVCConstants {
    static let segueToEditVCId = "showEditItem"
}

class ItemDetailViewController: UIViewController {
    var item : CommonItem!
//    fileprivate var dataManager : DataSourceManager?


    @IBOutlet weak var detailView: ItemDetailView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.levelMeter.level = item.level
        detailView.titleLabel.text = item.title
        detailView.shortDescLabel.text = item.shortDesc
        detailView.fullDescLabel.text = item.longDesc
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.dataManager = appDelegate.diContainer.resolve(DataSourceManager.self)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
 //       self.dataManager?.deleteItem(item: item)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ItemDetailVCConstants.segueToEditVCId,
            let destinationVC = segue.destination as? AddNewItemViewController {
            destinationVC.item = item
        }
        
    }
}
