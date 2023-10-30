//
//  HumidityViewController.swift
//  Hey_Groot
//
//  Created by 김경민 on 10/28/23.

import Foundation
import UIKit

class HumidityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색을 흰색으로 설정하고 투명도를 조절
        view.backgroundColor = UIColor.white.withAlphaComponent(1) // 투명도를 1로 설정
        
        // 네비게이션 바 타이틀 설정
        self.title = "Humidity"
        
        // 네비게이션 바의 왼쪽에 "화살표" 버튼 추가 (이전 화면으로 돌아가기)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    @objc func backButtonTapped() {
        // "Back" 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        print("Back 버튼이 탭되었습니다.")
        // 화면을 닫고 이전 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)    }
}

