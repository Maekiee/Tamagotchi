import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createTabBarController()
    }
    
    func createTabBarController() {
        let tamagotchiTabVC = UIViewController()
        let secondTabVc = UIViewController()
        let settingTabVc = UIViewController()
        
        let tamagotchiTabNav = UINavigationController(rootViewController: tamagotchiTabVC)
        let secondTabNav = UINavigationController(rootViewController: secondTabVc)
        let settingTabNav = UINavigationController(rootViewController: settingTabVc)
        
        tamagotchiTabNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "sunset"), selectedImage: UIImage(systemName: "sunset"))
        secondTabNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "figure.outdoor.soccer"), selectedImage: UIImage(systemName: "figure.outdoor.soccer"))
        settingTabNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape"))
        
        setViewControllers([tamagotchiTabNav, secondTabNav, settingTabNav], animated: false)
    }
}
