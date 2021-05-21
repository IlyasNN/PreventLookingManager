//
//  TabBarItemView.swift
//  PreventLookingManager_Example
//
//  Created by Илья Соловьёв on 09.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol TabBarItemDelegate: AnyObject {
    func didTap(_ tabBarItem: TabBarItem)
}

class TabBarItem: UITabBarItem {
    var selectedColor: UIColor = UIColor.blue
    var unsectedColor: UIColor = UIColor.grey
    var isSelected = false
}

class TabBarItemView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    public var tabBarItem: TabBarItem! {
        didSet {
            update()
        }
    }
    
    weak var delegate: TabBarItemDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        loadNib()
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
        
    public func configure(_ tabBarItem: TabBarItem) {
        self.tabBarItem = tabBarItem
    }
    
    public func update() {
        imageView.image = tabBarItem.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = tabBarItem.isSelected ? tabBarItem.selectedColor : tabBarItem.unsectedColor
        label.text = tabBarItem.title
        label.textColor = tabBarItem.isSelected ? tabBarItem.selectedColor : tabBarItem.unsectedColor
    }

    @IBAction func tap(_ sender: Any) {
        delegate?.didTap(tabBarItem)
    }
}
