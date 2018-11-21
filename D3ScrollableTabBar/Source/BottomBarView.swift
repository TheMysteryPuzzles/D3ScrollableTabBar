//
//  BottomBarView.swift
//  D3ImagePickerView
//
//  Created by Work on 11/6/18.
//  Copyright © 2018 TheMysteryPuzzles. All rights reserved.
//

import Foundation

class BottomBarView: UIView{
    
    var bottomBarDelegate: BottomBarDelegate?
    var defaultItem: Int?
    
    private var items = [BottomBarItem]()

    private lazy var itemSize: CGSize = {
   
        switch items.count {
        case 2:
            return CGSize(width: self.frame.width/2, height: self.frame.height)
        case 3:
            return CGSize(width: self.frame.width/3, height: self.frame.height)
        default:
            break
        }
        return CGSize(width: self.frame.width/4, height: self.frame.height)
    }()
    

    private lazy var barCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 1.0
        let view = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    func insertItem(item: BottomBarItem){
        items.append(item)
    }
 
    init(frame: CGRect, defaultSelectedItem: Int?){
        super.init(frame: frame)
        if defaultSelectedItem != nil{
            self.defaultItem = defaultSelectedItem }else{
            defaultItem = 1
        }
        self.backgroundColor = UIColor.clear
        setupBarCollectionView()
       }
    
    
    func reloadData(){
        self.barCollectionView.reloadData()
    }
    
    private func setupBarCollectionView(){
        barCollectionView.dataSource = self
        barCollectionView.delegate = self
        barCollectionView.register(BottomBarItemCell.self, forCellWithReuseIdentifier: "itemCell")
        addSubview(self.barCollectionView)
        
       NSLayoutConstraint.activate([
            barCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            barCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            barCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            barCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
       }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BottomBarView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.items[indexPath.item].tag = indexPath.item
        for item in items{
            item.isSelected = false
        }
        self.items[indexPath.item].isSelected = true
        bottomBarDelegate?.didSelect(barItem: self.items[indexPath.item])
   }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! BottomBarItemCell
        itemCell.item = self.items[indexPath.item]
        itemCell.isSelected = false
        if indexPath.item == defaultItem! {
            if itemCell.item.isSelected == false {
                itemCell.item.isSelected = true
                itemCell.item.tag = defaultItem!
                 bottomBarDelegate?.didSelect(barItem: itemCell.item!)
            }
        }
      return itemCell
    }
}
