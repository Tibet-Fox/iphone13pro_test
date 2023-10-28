import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        //탭바의 외관 설정
//        self.tabBar.backgroundImage = UIColor(red: 123/255, green: 193/255, blue: 178/255, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
        self.tabBar.unselectedItemTintColor = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //탭에 사용될 뷰 컨트롤러 생성
        
        //홈 탭
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let tabOne = homeViewController
        let tabOneBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 0)
        tabOne.tabBarItem = tabOneBarItem
        
        //검색 탭
        let searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        let tabTwo = searchViewController
        let tabTwoBarItem = UITabBarItem(title: "검색", image: UIImage(named: "search"), tag: 1)
        tabTwo.tabBarItem = tabTwoBarItem
        
        //대화 탭
        let speechViewController = storyboard?.instantiateViewController(withIdentifier: "SpeechViewController") as! SpeechViewController

        let tabFour = speechViewController
        let tabFourBarItem = UITabBarItem(title: "대화", image: UIImage(named: "voice"), tag: 2)
        tabFour.tabBarItem = tabFourBarItem
        
        //마이페이지 탭
        let myPageViewController = storyboard?.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController

        let tabThree = myPageViewController
        let tabThreeBarItem = UITabBarItem(title: "내 정보", image: UIImage(named: "user"), tag: 3)
        tabThree.tabBarItem = tabThreeBarItem
        
        //센서 탭
        let sensorViewController = storyboard?.instantiateViewController(withIdentifier: "SensorViewController") as! SensorViewController

        let tabFive = sensorViewController
        let tabFiveBarItem = UITabBarItem(title: "센서", image: UIImage(named: "sensor"), tag: 4)
        tabFive.tabBarItem = tabFiveBarItem

        //탭 바에 뷰 컨트롤러 설정
        self.viewControllers = [tabOne, tabTwo, tabFive, tabFour, tabThree]
    }

   

}

