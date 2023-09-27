//
//  HomeViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/03.
//

import Foundation
import UIKit
import AVFoundation
import CoreLocation

class HomeViewController: UIViewController{
    
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var addPlantBtn: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(red: 0.988, green: 0.98, blue: 0.945, alpha: 1)
        
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManager.delegate = self
    
        
      //  view.backgroundColor = UIColor(red: 0.988, green: 0.98, blue: 0.945, alpha: 1)

        weatherImage.image = UIImage(systemName: "sun.min.fill")
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        weatherImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        weatherImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 78).isActive = true

        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textColor = UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
        cityLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        cityLabel.attributedText = NSMutableAttributedString(string: "경산시 조영동")
        cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26).isActive = true
        cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 52).isActive = true


        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        tempLabel.font = UIFont(name: "SFPro-Medium", size: 44)
        tempLabel.attributedText = NSMutableAttributedString(string: "23°")
        tempLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 46).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        tempLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 84).isActive = true


//        characterImage.translatesAutoresizingMaskIntoConstraints = false
//        characterImage.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
//        characterImage.image = UIImage(named: GlobalMainCharacter.shared.systemMainImageName)
//        characterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10).isActive = true
//        characterImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15).isActive = true
        
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.image = UIImage(named: GlobalMainCharacter.shared.systemMainImageName)

        // centerX와 centerY 제약 조건을 설정합니다.
        characterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        characterImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15).isActive = true

        // 이미지 뷰의 크기를 설정할 수도 있습니다. 예를 들어, 폭과 높이를 200x300으로 설정하려면 다음과 같이 추가합니다.
        characterImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        characterImage.heightAnchor.constraint(equalToConstant: 300).isActive = true

        

        addPlantBtn.translatesAutoresizingMaskIntoConstraints = false
        if let font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15) as UIFont? {
            let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
            let attributedTitle = NSAttributedString(string: "식물 등록하기", attributes: attributes)
            addPlantBtn.setAttributedTitle(attributedTitle, for: .normal)
        } else {
            print("폰트를 로드하지 못했습니다.")
        }
        addPlantBtn.widthAnchor.constraint(equalToConstant: 119).isActive = true
        addPlantBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addPlantBtn.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
        addPlantBtn.layer.cornerRadius = 12
        addPlantBtn.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        addPlantBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addPlantBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 604).isActive = true
        
        
    }
    
    @IBAction func pressAddPlantBtn(_ sender: UIButton) {
        
        guard let gotoAddPlantVC = self.storyboard?.instantiateViewController(withIdentifier: "AddPlantViewController") as? AddPlantViewController else { return }
        gotoAddPlantVC.modalTransitionStyle = .crossDissolve
        gotoAddPlantVC.modalPresentationStyle = .fullScreen
        self.present(gotoAddPlantVC, animated: true, completion: nil)
    }
}


//MARK: - WeatherManagerDelegate

extension HomeViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weather.temperatureString
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
