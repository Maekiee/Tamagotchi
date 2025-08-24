
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        
        window?.rootViewController = UINavigationController(rootViewController: isLogin ? TamagotchiTabViewController() : SetTamagotchViewController())
        
        window?.makeKeyAndVisible()
        
    }
    
    func changeRootView(_ vc: UIViewController) {
        guard let window = self.window else { return }
        window.rootViewController = UINavigationController(rootViewController: vc)
        
        UIView.transition(with: window,
                          duration: 0.2,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
      }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
    }


}

