import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createTabBarController()
    }
    
    func createTabBarController() {
        let tamagotchiTabVC = TamagotchiTabViewController()
        let secondTabVc = LottoViewController()
        let moviewVC = MovieViewController()
        
        let tamagotchiTabNav = UINavigationController(rootViewController: tamagotchiTabVC)
        let secondTabNav = UINavigationController(rootViewController: secondTabVc)
        let movieNav = UINavigationController(rootViewController: moviewVC)
        
        tamagotchiTabNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "sunset"), selectedImage: UIImage(systemName: "sunset"))
        secondTabNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "bitcoinsign.circle"), selectedImage: UIImage(systemName: "bitcoinsign.circle"))
        movieNav.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "popcorn.circle"), selectedImage: UIImage(systemName: "popcorn.circle"))
        
        setViewControllers([tamagotchiTabNav, secondTabNav, movieNav], animated: false)
    }
}
