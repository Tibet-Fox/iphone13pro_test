//
//  SearchView.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/10/04.
//


import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
class SearchView:UIView{
    
    let disposeBag = DisposeBag()
    
    let searchBackView:UIView = {
        let view = UIView()
        return view
    }()
    
    let search_TextField:UITextField = {
       let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.placeholder = "검색어를 입력해주세요."
        return textField
    }()
    
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
        
        
    }
    
    func bind(_ viewModel:SearchViewModel){
        viewModel.items
            .asObservable()
            .bind(to: tableView.rx.items){ tv, row, data in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "SarchTableViewCell", for: IndexPath(row: row, section: 0)) as? SarchTableViewCell else { return UITableViewCell() }
                cell.setData(data)
                return cell
            }.disposed(by: disposeBag)
    }
    
    func layout(){
        [searchBackView, tableView].forEach{
            self.addSubview($0)
        }
        
        [search_TextField].forEach{
            self.searchBackView.addSubview($0)
        }
        
        searchBackView.snp.makeConstraints{
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            
        }
        
        search_TextField.snp.makeConstraints{
            $0.top.equalTo(searchBackView.snp.top).offset(20)
            $0.leading.equalTo(searchBackView.snp.leading).offset(20)
            $0.trailing.equalTo(searchBackView.snp.trailing).inset(20)
            $0.bottom.equalTo(searchBackView.snp.bottom).inset(20)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(self.searchBackView.snp.bottom)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func attribute(){
        tableView.register(SarchTableViewCell.self, forCellReuseIdentifier: "SarchTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
