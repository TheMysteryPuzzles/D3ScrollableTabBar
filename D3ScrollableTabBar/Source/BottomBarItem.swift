//
//  BottomBarItem.swift
//  D3ImagePickerView
//
//  Created by Work on 11/4/18.
//  Copyright © 2018 TheMysteryPuzzles. All rights reserved.
//

import UIKit

class  BottomBarItem: UIView {
    
    var isSelected: Bool?{
        didSet{
            if isSelected == true {
                isSelectedView.isHidden = false
            }else{
                isSelectedView.isHidden = true
            }
        }
    }
    private lazy var isSelectedView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private var titleLabel: ItemTextLabel = {
        let label = ItemTextLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setupTitleLabelConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
            ])
    }
    
    private func setupImageViewConstraints(){
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
            ])
    }
    
    init(title: String){
        super.init(frame:.zero)
        addTitleTextLabel(title)
    }
     init(image: UIImage){
        super.init(frame:.zero)
        addImageView()
    }
    
    init(image: UIImage, selectedImage: UIImage){
        super.init(frame:.zero)
        addImageView()
        backgroundColor = UIColor.clear
    }
    
    fileprivate func setupIsSelectedViewConstraints() {
        NSLayoutConstraint.activate([
            
            isSelectedView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            isSelectedView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            isSelectedView.heightAnchor.constraint(equalToConstant: 8),
            isSelectedView.widthAnchor.constraint(equalToConstant: 8)
            ])
    }
    
    override func layoutSubviews() {
         addSubview(isSelectedView)
        
        if self.isSelected != nil && !isSelected! {
              isSelectedView.isHidden = true
        }else{
             isSelectedView.isHidden = false
        }
        setupIsSelectedViewConstraints()
        
        setNeedsDisplay()
    }
    private func addImageView(){
        addSubview(imageView)
        setupImageViewConstraints()
    }
    
    private func addTitleTextLabel(_ text: String){
        titleLabel.text = text
        addSubview(titleLabel)
        setupTitleLabelConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ItemTextLabel: UILabel {
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawText(in rect: CGRect) {
        
        guard text != nil else {
            return super.drawText(in: rect)
        }
        
        let height = self.sizeThatFits(rect.size).height
        let y = (rect.origin.y + rect.height - height) / 2
        super.drawText(in: CGRect(x: 0, y: y, width: rect.width, height: height))
    }
}
