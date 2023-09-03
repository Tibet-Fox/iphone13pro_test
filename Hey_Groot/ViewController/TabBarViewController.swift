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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let tabOne = HomeViewController()
        let tabOneBarItem = UITabBarItem(title: "탭 1", image: UIImage(named: "tab1"), tag: 0)
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: SearchViewController())
        let tabTwoBarItem = UITabBarItem(title: "탭 2", image: UIImage(named: "tab2"), tag: 1)
        tabTwo.tabBarItem = tabTwoBarItem
        
        let tabThree = UINavigationController(rootViewController: MyPageViewController())
        let tabThreeBarItem = UITabBarItem(title: "탭 3", image: UIImage(named: "tab3"), tag: 2)
        tabThree.tabBarItem = tabThreeBarItem
     
        self.viewControllers = [tabOne, tabTwo, tabThree]
        
        
    }
    
   

}
