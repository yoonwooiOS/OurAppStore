//
//  HomeTabBarController.swift
//  OurAppStore
//
//  Created by 김윤우 on 8/8/24.
//

import UIKit

final class HomeTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let apearance = UITabBarAppearance()
        apearance.configureWithOpaqueBackground()
        tabBar.tintColor = .black
        tabBar.standardAppearance = apearance
        tabBar.scrollEdgeAppearance = apearance
        tabBar.unselectedItemTintColor = .gray
        
        let todayVc = TodayViewController()
        let today = UINavigationController(rootViewController: todayVc)
        today.tabBarItem = UITabBarItem(title: "", image: TabBar.today, tag: 0)
        
        let gameVc = GameViewController()
        let game = UINavigationController(rootViewController: gameVc)
        game.tabBarItem = UITabBarItem(title: "", image: TabBar.game, tag: 1)
       
        let appVc = AppViewController()
        let app = UINavigationController(rootViewController: appVc)
        app.tabBarItem = UITabBarItem(title: "", image: TabBar.app, tag: 2)
        
        let arcadeVc = ArcadeViewController()
        let arcade = UINavigationController(rootViewController: arcadeVc)
        arcade.tabBarItem = UITabBarItem(title: "", image: TabBar.arcade, tag: 3)
        
        let searchVc = SearchViewcontroller()
        let search = UINavigationController(rootViewController: searchVc)
        search.tabBarItem = UITabBarItem(title: "", image: TabBar.search, tag: 4)
        
        
        self.setViewControllers([today, game, app, arcade, search], animated: true)
    }
}
