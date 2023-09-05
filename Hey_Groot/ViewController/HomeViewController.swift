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
    @IBOutlet weak var addPlantLabel: UILabel!
    @IBOutlet weak var addPlantBtn: UIButton!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//
//        weatherManager.delegate = self
        
        view.backgroundColor = UIColor.white
        
//        let homeParent = UIView()
//        homeParent.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
//        homeParent.layer.backgroundColor = UIColor(red: 0.988, green: 0.98, blue: 0.945, alpha: 1).cgColor
        
//
//        homeParent.addSubview(weatherImage)
//        homeParent.addSubview(cityLabel)
//        homeParent.addSubview(tempLabel)
//        homeParent.addSubview(addPlantLabel)
//        homeParent.addSubview(addPlantBtn)
        
     //   var paragraphStyle = NSMutableParagraphStyle()
        
        weatherImage.image = UIImage(systemName: "sun.min.fill")
        weatherImage.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
      weatherImage.widthAnchor.constraint(equalToConstant: 119.69).isActive = true
       weatherImage.heightAnchor.constraint(equalToConstant: 53.61).isActive = true
        weatherImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
      weatherImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 144).isActive = true
//
//        cityLabel.frame = CGRect(x: 0, y: 0, width: 86, height: 22)
//        cityLabel.textColor = UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
//        cityLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
//      //  paragraphStyle.lineHeightMultiple = 1.15
//        cityLabel.attributedText = NSMutableAttributedString(string: "경산시 조영동")
//        cityLabel.translatesAutoresizingMaskIntoConstraints = false
//        cityLabel.widthAnchor.constraint(equalToConstant: 86).isActive = true
//
//        tempLabel.frame = CGRect(x: 0, y: 0, width: 70, height: 46)
//        tempLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
//        tempLabel.font = UIFont(name: "SFPro-Medium", size: 44)
//        //paragraphStyle.lineHeightMultiple = 0.99
//        // Line height: 52 pt
//        tempLabel.attributedText = NSMutableAttributedString(string: "23°")
//        homeParent.addSubview(tempLabel)
//        tempLabel.translatesAutoresizingMaskIntoConstraints = false
//        tempLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
//        tempLabel.heightAnchor.constraint(equalToConstant: 46).isActive = true
//
//        addPlantLabel.frame = CGRect(x: 0, y: 0, width: 119, height: 30)
//        addPlantLabel.textColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
//        addPlantLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
//        //paragraphStyle.lineHeightMultiple = 1.14
//        addPlantLabel.textAlignment = .center
//        addPlantLabel.attributedText = NSMutableAttributedString(string: "식물 등록하기")
//        homeParent.addSubview(addPlantLabel)
//        addPlantLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

////MARK: - WeatherManagerDelegate
//
//extension HomeViewController: WeatherManagerDelegate {
//    
//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
//        DispatchQueue.main.async {
//            self.tempLabel.text = weather.temperatureString
//            self.weatherImage.image = UIImage(systemName: weather.conditionName)
//            self.cityLabel.text = weather.cityName
//        }
//    }
//    
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}
//
////MARK: - CLLocationManagerDelegate
//
//extension HomeViewController: CLLocationManagerDelegate {
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            locationManager.stopUpdatingLocation()
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            weatherManager.fetchWeather(latitude: lat, longitude: lon)
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//}
