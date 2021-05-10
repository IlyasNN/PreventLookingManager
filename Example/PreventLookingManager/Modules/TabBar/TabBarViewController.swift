//
//  TabBarViewController.swift
//  PreventLookingScreen_Example
//
//  Created by Илья Соловьёв on 09.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

final class TabBarViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var tabBarTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var tabBarBottomAnchor: NSLayoutConstraint!
    
    var viewControllers = [UIViewController]() {
        didSet {
            updateTabBarView()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            updateSelectedViewController(oldIndex: oldValue, newIndex: selectedIndex)
        }
    }
    
    var selectedViewController: UIViewController {
        guard let viewController = viewControllers[safeIndex: selectedIndex] else {
            fatalError("TabBar: selectedIndex out of boundaries")
        }
        return viewController
    }
    
    /// Checks whether tabBar is hidden
    var isHiddenTabBar: Bool {
        get {
            tabBarView.isHidden
        }
        set {
            tabBarView.isHidden = newValue
        }
    }
    
    /// Check whether tabBar is visible on the screen
    var tabBarIsVisible: Bool {
        self.tabBarView.frame.origin.y < view.frame.height
    }
    
    // MARK: - Lifecycle

	override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTabBarView()
        updateSelectedViewController(oldIndex: nil, newIndex: selectedIndex)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateTabBarView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateAdditionalSafeAreaInsets()
    }
    
    /// If `yOffset > 0` then tab bar moves down. Otherwise it moves up
    private func moveTabBarViewVertically(by yOffset: CGFloat) {
        tabBarTopAnchor.constant += yOffset
        tabBarBottomAnchor.constant -= yOffset
    }
    
    func setTabBarVisible(visible: Bool, duration: TimeInterval = 0.2, animated: Bool = true) {
        if tabBarIsVisible == visible { return }
        let frame = self.tabBarView.frame
        let height = frame.size.height
        let offsetY = visible ? -height : height
        self.moveTabBarViewVertically(by: offsetY)
        guard animated else {
            return
        }
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut) {
            self.view.layoutIfNeeded()
            self.updateAdditionalSafeAreaInsets()
        } completion: { (_) in
        }

    }
    
    func updateAdditionalSafeAreaInsets() {
        let tabBarViewHeight = tabBarView?.bounds.size.height ?? 0
        let defaultSafeAreaBottomInset = view.safeAreaInsets.bottom
        let tabBarVisibleSafeAreaHeight = tabBarIsVisible ? tabBarViewHeight : defaultSafeAreaBottomInset

        var newSafeArea = UIEdgeInsets()
        newSafeArea.bottom += tabBarVisibleSafeAreaHeight - defaultSafeAreaBottomInset

        if let child = children.first {
            child.additionalSafeAreaInsets = newSafeArea
        }
    }
    
    func updateSelectedViewController(oldIndex: Int?, newIndex: Int) {
    
        guard isViewLoaded else {
            return
        }
        
        if let oldIndex = oldIndex {
            let previousVC = viewControllers[oldIndex]
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }

        let vc = viewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        updateAdditionalSafeAreaInsets()
        updateTabBarItems()
    }
    
    func updateTabBarView() {
        guard isViewLoaded else {
            return
        }
        
        stackView?.subviews.forEach({
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
        
        viewControllers.forEach { viewController in
            // viewController. = self
            
            let tabBarItemView = TabBarItemView()
            tabBarItemView.translatesAutoresizingMaskIntoConstraints = false
            
            if let tabBarItem = viewController.tabBarItem as? TabBarItem {
                tabBarItemView.configure(tabBarItem)
                tabBarItemView.delegate = self
                stackView?.addArrangedSubview(tabBarItemView)
            }
        }
    }

    private func updateTabBarItems() {
        stackView.subviews.enumerated().forEach { index, subview in
            if let tabBarItemView = subview as? TabBarItemView {
                tabBarItemView.tabBarItem.isSelected = index == selectedIndex
                tabBarItemView.update()
            }
        }
    }
    
}

extension TabBarViewController: TabBarItemDelegate {
    
    func didTap(_ tabBarItem: TabBarItem) {
        viewControllers.enumerated().forEach { index, controller in
            if let currentTabBarItem = controller.tabBarItem as? TabBarItem,
               currentTabBarItem == tabBarItem {
                selectedIndex = index
            }
        }
    }
    
}
