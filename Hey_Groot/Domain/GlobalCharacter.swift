//
//  GlobalCharacter.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/10.
//

import Foundation
import UIKit

class GlobalCharacter {
    static let shared = GlobalCharacter()

    var characterImageArray: [UIImage] = []

    init() {
        let image1 = UIImage(named: "Character1")
        let image2 = UIImage(named: "Character2")
        let image3 = UIImage(named: "Character3")

        characterImageArray.append(image1!)
        characterImageArray.append(image2!)
        characterImageArray.append(image3!)
    }
}
