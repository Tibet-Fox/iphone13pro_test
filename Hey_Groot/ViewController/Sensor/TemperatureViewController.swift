//
//  TemperatureViewController.swift
//  Hey_Groot
//
//  Created by 김경민 on 10/27/23.
//


import Foundation
import UIKit

class TemperatureViewController: UIViewController {
    
    // 레이블을 생성
    let plantDataLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색을 흰색으로 설정하고 투명도를 조절
        view.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        
        // 네비게이션 바 타이틀 설정
        self.title = "Temperature"
        
        // 네비게이션 바의 왼쪽에 "sensor" 문구와 화살표 아이콘을 함께 표시
        let sensorItem = UIBarButtonItem(title: "Sensor", style: .plain, target: nil, action: nil)
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        // 이미지와 타이틀 간 여백 조절
        sensorItem.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: -10)
        
        // 두 개의 UIBarButtonItem을 UIStackView로 묶어서 표시
        let combinedItems = [backButton, sensorItem]
        self.navigationItem.leftBarButtonItems = combinedItems
        
        // 아두이노 식물 데이터 레이블에 표시
        fetchArduinoPlantData()
    }
    
    func fetchArduinoPlantData() {
        if let url = URL(string: "http://3.20.48.164:8000/plant/data/") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("네트워크 요청 오류: \(error)")
                    return
                }
                
                if let data = data {
                    do {
                        // JSON 데이터를 파싱
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonDictionary = jsonData as? [String: Any] {
                            // 필요한 데이터 추출
                            if let plantData = jsonDictionary["plantData"] as? String {
                                // 레이블에 데이터 표시
                                DispatchQueue.main.async {
                                    self.updatePlantDataLabel(plantData)
                                }
                            }
                        }
                    } catch {
                        print("데이터 파싱 오류: \(error)")
                    }
                }
            }
            task.resume()
        } else {
            print("잘못된 URL입니다.")
        }
    }
    
    // 레이블에 데이터를 업데이트하는 함수
    func updatePlantDataLabel(_ data: String) {
        plantDataLabel.text = data
        plantDataLabel.frame = CGRect(x: 20, y: 100, width: 300, height: 30)
        view.addSubview(plantDataLabel)
    }
    
    @objc func backButtonTapped() {
        // 화살표 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        print("Back 버튼이 탭되었습니다.")
        // 화면을 닫고 이전 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)
    }
}
