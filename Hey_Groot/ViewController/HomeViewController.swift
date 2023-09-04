//
//  HomeViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/03.
//

import Foundation
import UIKit

class HomeViewController: UIViewController{
    
    
    @IBOutlet weak var weatherImage: UIImageView?
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var tempLabel: UILabel?
    @IBOutlet weak var addPlantLabel: UILabel?
    @IBOutlet weak var addPlantBtn: UIButton?
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(red: 0.988, green: 0.98, blue: 0.945, alpha: 1)
        
        let homeParent = UIView()
//        homeParent.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
//        homeParent.layer.backgroundColor = UIColor(red: 0.988, green: 0.98, blue: 0.945, alpha: 1).cgColor

        
        weatherImage?.image = UIImage(systemName: "sun.min.fill")
        if let weatherImage = weatherImage {
            homeParent.addSubview(weatherImage)
        } else {
            print("error")
            // weatherImage가 nil일 때 처리할 로직 추가
        }
//        homeParent.addSubview(cityLabel)
//        homeParent.addSubview(tempLabel)
//        homeParent.addSubview(addPlantLabel)
//        homeParent.addSubview(addPlantBtn)

//        weatherImage?.image = UIImage(systemName: "sun.min.fill")
//        weatherImage.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
//        weatherImage.translatesAutoresizingMaskIntoConstraints = false
//      weatherImage.widthAnchor.constraint(equalToConstant: 119.69).isActive = true
//       weatherImage.heightAnchor.constraint(equalToConstant: 53.61).isActive = true
//        weatherImage.leadingAnchor.constraint(equalTo: homeParent.leadingAnchor, constant: 16).isActive = true
//       weatherImage.topAnchor.constraint(equalTo: homeParent.topAnchor, constant: 144).isActive = true
//
//        cityLabel.frame = CGRect(x: 0, y: 0, width: 86, height: 22)
//        cityLabel.textColor = UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
//        cityLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
//        cityLabel.attributedText = NSMutableAttributedString(string: "경산시 조영동")
//        cityLabel.translatesAutoresizingMaskIntoConstraints = false
//        cityLabel.widthAnchor.constraint(equalToConstant: 86).isActive = true
//
//        tempLabel.frame = CGRect(x: 0, y: 0, width: 70, height: 46)
//        tempLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
//        tempLabel.font = UIFont(name: "SFPro-Medium", size: 44)
//        tempLabel.translatesAutoresizingMaskIntoConstraints = false
//        tempLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
//        tempLabel.heightAnchor.constraint(equalToConstant: 46).isActive = true
//        tempLabel.attributedText = NSMutableAttributedString(string: "23")
//
//        addPlantLabel.frame = CGRect(x: 0, y: 0, width: 144, height: 22)
//        addPlantLabel.textColor = UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
//        addPlantLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
//        addPlantLabel.textAlignment = .center
//        addPlantLabel.attributedText = NSMutableAttributedString(string: "아직 등록한 식물이 없어요!")
//        addPlantLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        addPlantBtn.frame = CGRect(x: 0, y: 0, width: 119, height: 30)
//        addPlantBtn.tintColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1)
//        addPlantBtn.setTitle("식물 등록하기", for: .normal)
//        addPlantBtn.translatesAutoresizingMaskIntoConstraints = false

    }
    
}
