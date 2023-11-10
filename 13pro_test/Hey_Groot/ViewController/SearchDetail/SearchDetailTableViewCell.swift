

import Foundation
import UIKit
import SnapKit

class SearchDetailTableViewCell:UITableViewCell{
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ item:String,_ row:Int,_ viewModel:SearchDetailViewModel){
        if(item.elementsEqual("") && !viewModel.titlegetItems.value[row].elementsEqual("")){
            titleLabel.text =  "\(viewModel.titlegetItems.value[row]) : -"
        }else if(item.elementsEqual("")){
            titleLabel.text =  ""
        }else{
            if viewModel.titlegetItems.value.count > row{
                titleLabel.text =  "\(viewModel.titlegetItems.value[row]) : \(item)"
            }
            
        }
        
        
    }
    
    func layout(){
        [titleLabel].forEach{
            self.contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.contentView.snp.top)
            $0.leading.equalTo(self.contentView.snp.leading).offset(20)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.trailing.equalTo(self.contentView.snp.trailing).inset(20)
            $0.height.equalTo(50)
        }
    }
}

