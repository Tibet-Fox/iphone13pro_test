//
//  LuminosityViewController.swift
//  Hey_Groot
//
//  Created by 김경민 on 10/28/23.
//

import Foundation
import UIKit

class LuminosityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색을 흰색으로 설정하고 투명도를 조절
        view.backgroundColor = UIColor.white.withAlphaComponent(1) // 투명도를 1로 설정
        // 네비게이션 바 타이틀 설정
        self.title = "Luminosity"
        
        // 네비게이션 바의 왼쪽에 "sensor" 문구와 화살표 아이콘을 함께 표시
        let sensorItem = UIBarButtonItem(title: "Sensor", style: .plain, target: nil, action: nil)
        
        // 네비게이션 바의 왼쪽에 "화살표" 버튼 추가 (이전 화면으로 돌아가기)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        // 이미지와 타이틀 간 여백 조절
        sensorItem.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: -10)
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        // 두 개의 UIBarButtonItem을 UIStackView로 묶어서 표시
        let combinedItems = [backButton, sensorItem]
        self.navigationItem.leftBarButtonItems = combinedItems
        
    }
    
    
    @objc func backButtonTapped() {
        // "Back" 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        print("Back 버튼이 탭되었습니다.")
        // 화면을 닫고 이전 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)
    }
}

