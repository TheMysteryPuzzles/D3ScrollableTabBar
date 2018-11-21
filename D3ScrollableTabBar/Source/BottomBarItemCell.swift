//
//  BottomBarItemCell.swift
//  D3ImagePickerView
//
//  Created by Work on 11/6/18.
//  Copyright © 2018 TheMysteryPuzzles. All rights reserved.
//

import UIKit


class BottomBarItemCell: UICollectionViewCell{
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                if item != nil{
                    item.isSelected = true }
            }else{
                  item.isSelected = false
            }
        }
    }
    
    var item : BottomBarItem!{
        didSet{
            addItem()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.layer.borderWidth = 1
       //  self.layer.borderColor = UIColor.white.cgColor
      }
    
    func addItem(){
        item.frame = self.bounds
        addSubview(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
