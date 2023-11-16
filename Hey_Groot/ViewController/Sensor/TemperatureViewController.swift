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
    // "센서값" 레이블 생성
       let sensorLabel = UILabel()
    
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
        
        
      
        // "센서값" 레이블 추가
               view.addSubview(sensorLabel)
               sensorLabel.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   sensorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   sensorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
               ])
        
        fetchDataFromServer()
        
    }
    
    func fetchDataFromServer() {
        
        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAwMTM3MTUwLCJpYXQiOjE3MDAxMTkxNTAsImp0aSI6ImY5MDBjNzg3MTE2YjQ4NTk5ZDhjZjc0OGI3ZjVjY2ViIiwidXNlcl9pZCI6Mn0.qmkM3o53RDPohhjs362f0mGaGW5T4HVBCOcT0sSJsNo"
        
//        let refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwMDcyMzk1MCwiaWF0IjoxNzAwMTE5MTUwLCJqdGkiOiI1MDE1Yzk0NTQ5N2I0MDIwYjZmZGI5MGIyMmVhMzZkZiIsInVzZXJfaWQiOjJ9.YjZlcZCr-e_srnkkH2-6gBexLKa8ZhVPZdlKZoVmUPE"
        // 연결할 URL
        if let url = URL(string: "http://3.20.48.164:8000/plant/data/") {
            
            // URLSession 객체 생성
            let session = URLSession.shared
            
            // URL 요청을 위한 URLRequest 생성
                   var request = URLRequest(url: url)
                   
                   // 액세스 토큰을 사용하여 Authorization 헤더 추가
                   request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

                   // URLSession 데이터 작업 생성
                   let task = session.dataTask(with: request) { (data, response, error) in
                       // 에러 확인
                       if let error = error {
                           print("에러: \(error)")
                           return
                       }

                       // 데이터 확인
                       if let data = data {
                           // 데이터를 필요에 따라 파싱
                           if let resultString = String(data: data, encoding: .utf8) {
                               print("서버 응답: \(response)")
                               print("서버에서 받은 데이터: \(resultString)")

                               // 필요에 따라 메인 스레드에서 UI 업데이트 수행
                               DispatchQueue.main.async {
                                   
                                   // UI 업데이트 또는 서버에서 받은 데이터 처리
                                   // 예를 들어, plantDataLabel을 받은 데이터로 업데이트할 수 있습니다.
                                   self.sensorLabel.text = resultString
                                   self.plantDataLabel.text = resultString
                               }
                           }
                       }
                   }

                   // 요청을 시작하기 위해 작업을 재개
                   task.resume()
               }
           }

    
    @objc func backButtonTapped() {
        // 화살표 버튼이 탭되었을 때 수행할 동작을 여기에 추가
        print("Back 버튼이 탭되었습니다.")
        // 화면을 닫고 이전 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)
    }
}
