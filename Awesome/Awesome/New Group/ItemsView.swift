//
//  ItemsView.swift
//  Awesome
//
//  Created by Artak on 12/18/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

protocol ItemsViewDelegate: UITableViewDelegate, UICollectionViewDelegate{
    
}

protocol ItemsViewDataSource: UITableViewDataSource, UICollectionViewDataSource{
    
}

class ItemsView: UIView {

    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    var delegate : ItemsViewDelegate? {
        didSet {
            itemsTableView.delegate = delegate
            itemsCollectionView.delegate = delegate
        }
    }
    
    var dataSource : ItemsViewDataSource? {
        didSet {
            itemsTableView.dataSource = dataSource
            itemsCollectionView.dataSource = dataSource
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let bundles = Bundle.main.loadNibNamed("ItemsView", owner: self, options: nil)
        let xibView = bundles!.first as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    

}
