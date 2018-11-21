//
//  D3ImagePickerBottomBarView.swift
//  D3ImagePickerView
//
//  Created by Work on 11/4/18.
//  Copyright © 2018 TheMysteryPuzzles. All rights reserved.
//

import UIKit

protocol BottomBarDelegate {
    func didSelect(barItem item: BottomBarItem)
}

class BottomBar: UIView {
    
    var defaultSelectedItem: Int?
    
    var delegate: BottomBarDelegate?{
        didSet{
          bottomBarView.bottomBarDelegate = delegate
        }
    }
    
    private lazy var bottomBarView: BottomBarView = {
       let view = BottomBarView(frame: .zero, defaultSelectedItem: self.defaultSelectedItem)
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    public func addBottomBarItem(barItem item: BottomBarItem){
        bottomBarView.insertItem(item: item)
        self.bottomBarView.reloadData()
    }
    
    init(frame: CGRect, defaultVisibleItem: Int?){
        super.init(frame: frame)
        self.defaultSelectedItem = defaultVisibleItem
        addSubview(bottomBarView)
        NSLayoutConstraint.activate([
            bottomBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBarView.topAnchor.constraint(equalTo: self.topAnchor),
            bottomBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}











    
    
    
    
    
    
    


