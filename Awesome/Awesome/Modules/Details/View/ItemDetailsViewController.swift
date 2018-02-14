//
//  ItemDetailsViewController.swift
//  Awesome
//
//  Created by Artak on 2/6/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController, ItemDetailsViewInterface {
    var eventHandler : ItemDetailsEventHandler?
    
    @IBOutlet weak var detailsView: ItemDetailView!
    
    @IBAction func editButtonAction(_ sender: Any) {
        eventHandler?.editItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler?.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        eventHandler?.reloadItem()
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
}
