//
//  AddCharacterViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/09.
//

import Foundation
import UIKit
import PanModal

class AddCharacterViewController : UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        titleLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        titleLabel.attributedText = NSMutableAttributedString(string: "캐릭터 선택")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
        
        //collection view에 대한 설정
        characterCollectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        characterCollectionView?.dataSource=self
        characterCollectionView?.delegate=self
        
        //   ----닙파일이랑 연결----
        //닙파일 연결시켜주기
        let characterCollectionViewCellNib = UINib(nibName: String(describing: CharacterCollectionViewCell.self), bundle: nil)
        
        //가져온 닙파일을 콜렉션뷰에 셀로 등록하기
        self.characterCollectionView?.register(characterCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: CharacterCollectionViewCell.self))
                                            
        //콜렉션 뷰의 콜렉션 뷰 레이아웃 설정하기
        self.characterCollectionView?.collectionViewLayout = createCompositionalLayout()

    }
}

//MARK: - panModal부분 처리
extension AddCharacterViewController: PanModalPresentable{
    var panScrollable: UIScrollView?{
        return characterCollectionView
    }
    var shortFormHeight: PanModalHeight{
        return .contentHeight(300)
    }
    var longFormHeight: PanModalHeight{
        return .maxHeightWithTopInset(40)
    }
}


fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

        // 아이템에 대한 사이즈
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))

        // 아이템 만들기
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // 아이템 간의 간격 설정
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        // 그룹사이즈
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4))

        // 그룹
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

        // 섹션 만들기
        let section = NSCollectionLayoutSection(group: group)

        // 섹션 간격
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        return section
    }
    return layout
}
                                        
//collection view를 몇개 보여주고 각 섹션은 몇개인지 그런거 입력하는 것
//datasource는 프로토콜이 필수임
extension AddCharacterViewController:UICollectionViewDataSource{
    
    //각 섹션에 들어가는 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalCharacter.shared.characterImageArray.count
    }
    
    //각 collection view cell 에 대한 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        //닙 파일 안의 요소에 접근
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterCollectionViewCell.self), for: indexPath) as! CharacterCollectionViewCell

    
        
        //각 cell안에 image 설정
        cell.characterImage.image = GlobalCharacter.shared.characterImageArray[indexPath.row]
        
        return cell
        
    }
    
    
}

//collection view 액션과 관련된 것들
extension AddCharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cellIndex = indexPath.item
        let cellInSection = cellIndex % 3

        print("Cell selected at indexPath: \(indexPath)")

        if cellInSection == 0 {
            GlobalMainCharacter.shared.systemMainImageName = "Character"
            GlobalSpeechCharacter.shared.systemSpeechCharacterImageName = "Character1"
            dismiss(animated: true, completion: nil)
        } else if cellInSection == 1 {
            GlobalMainCharacter.shared.systemMainImageName = "secondCharacter"
            GlobalSpeechCharacter.shared.systemSpeechCharacterImageName = "Character2"
            dismiss(animated: true, completion: nil)
        } else {
            GlobalMainCharacter.shared.systemMainImageName = "thirdCharacter"
            GlobalSpeechCharacter.shared.systemSpeechCharacterImageName = "Character3"
            dismiss(animated: true, completion: nil)
        }
        
        

    }
}
