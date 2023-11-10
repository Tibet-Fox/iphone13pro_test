//
//  CharacterCollectionViewCell.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/09.
//

import Foundation
import UIKit


class CharacterCollectionViewCell: UICollectionViewCell{
        
    @IBOutlet weak var characterImage: UIImageView!
    var imageName : String = "" {
        didSet{
            // 쏄의 UI 설정
            self.characterImage.image = UIImage(systemName: imageName)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("CollectionViewCell - awakeFromNib() called")
        contentView.backgroundColor = UIColor.clear
            contentView.layer.cornerRadius = 8
            contentView.layer.borderWidth = 0
            contentView.layer.borderColor = UIColor.clear.cgColor
    }
    
}
