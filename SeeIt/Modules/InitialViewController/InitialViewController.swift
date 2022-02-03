//
//  ViewController.swift
//  SeeIt
//
//  Created by Rhullian Damião on 28/01/22.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setViewControllers([createTabBar()], animated: true)
    }
    
    private func setupNavigationController(nav: UINavigationController) {
        nav.navigationBar.barTintColor = .secondaryColor
        nav.navigationBar.tintColor = .white
        nav.navigationItem.leftBarButtonItem?.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func createTabBar() -> UITabBarController {
        let tab = UITabBarController()
        tab.tabBar.backgroundColor = .white
        tab.tabBar.tintColor = .primaryColor
        tab.tabBar.unselectedItemTintColor = .placeholder
        tab.viewControllers = [createHomeViewController(), createFavoritesViewController()]
        return tab
    }
    
    private func createHomeViewController() -> UIViewController {
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        setupNavigationController(nav: nav)
        let titleVc = "Filmes e Séries"
        vc.title = titleVc
        vc.tabBarItem = createTabBarItem(title: titleVc, icon: "showsIcon", tag: 0)
        
        return nav
    }
    
    private func createFavoritesViewController() -> UIViewController {
        let vc = FavoritesViewController()
        let nav = UINavigationController(rootViewController: vc)
        let titleVc = "Favoritos"
        vc.title = titleVc
        vc.tabBarItem = createTabBarItem(title: titleVc, icon: "favoritesIcon", tag: 1)
        setupNavigationController(nav: nav)
        
        return nav
    }
    
    private func createTabBarItem(title: String, icon: String, tag: Int) -> UITabBarItem {
        let tabItem = UITabBarItem(title: title, image: UIImage(named: icon), tag: tag)
        return tabItem
    }
}

