//
//  SearchDetailViewController.swift
//  Hey_Groot
//
//  Created by 여수민 on 2023/09/07.
//

import Foundation
import UIKit
import RxSwift
import RxGesture

class SearchDetailViewController:UIViewController{
    
    let disposeBag = DisposeBag()
    let searchDetailView = SearchDetailView()
    let viewModel = SearchDetailViewModel()
    
    
    var item = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel)
        layout()
        attribute()
    }
    
    func layout(){
        [searchDetailView].forEach{
            self.view.addSubview($0)
        }
        searchDetailView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    func bind(_ viewModel:SearchDetailViewModel){
        searchDetailView.bind(viewModel)
        
        searchDetailView.tableView.rx.panGesture()
            .bind(with: self) { ss, gesture in
                let isDown = gesture.translation(in: ss.searchDetailView.tableView).y < 0
              
                UIView.animate(withDuration: 0.5) {
                    if isDown{
                        ss.searchDetailView.topConstraint?.isActive = true
                        ss.searchDetailView.baseConstraint?.isActive = false
                    }else{
                        ss.searchDetailView.topConstraint?.isActive = false
                        ss.searchDetailView.baseConstraint?.isActive = true
                    }
                    ss.view.layoutIfNeeded()
                    }
               
                //  ss.label.text = isDown ? "down" : "up"
               // ss.label.textColor = isDown ? .red : .blue
            }
            .disposed(by: disposeBag)
        
    }
    
    func attribute(){
        self.view.backgroundColor = .white
        
        
    }
}
