//
//  TabBarViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/03.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
//        self.tabBar.backgroundImage = UIColor(red: 123/255, green: 193/255, blue: 178/255, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
        self.tabBar.unselectedItemTintColor = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)




        let tabOne = HomeViewController()
        let tabOneBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 0)
        tabOne.tabBarItem = tabOneBarItem

        let tabTwo = UINavigationController(rootViewController: SearchViewController())
        let tabTwoBarItem = UITabBarItem(title: "검색", image: UIImage(named: "search"), tag: 1)
        tabTwo.tabBarItem = tabTwoBarItem

        let tabThree = UINavigationController(rootViewController: MyPageViewController())
        let tabThreeBarItem = UITabBarItem(title: "내 정보", image: UIImage(named: "user"), tag: 2)
        tabThree.tabBarItem = tabThreeBarItem

        self.viewControllers = [tabOne, tabTwo, tabThree]
    }

   

}
