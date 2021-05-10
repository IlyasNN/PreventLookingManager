import UIKit

class TabBarLayer {
    let controllers: [UIViewController]
    
    private lazy var tabBarController = TabBarViewController()
    
    init(controllers: UIViewController...) {
        self.controllers = controllers
    }
    
    func installTabBarController(selectedIndex: Int) -> TabBarViewController {
        tabBarController.viewControllers = controllers
        tabBarController.selectedIndex = selectedIndex
        
        return tabBarController
    }
}
