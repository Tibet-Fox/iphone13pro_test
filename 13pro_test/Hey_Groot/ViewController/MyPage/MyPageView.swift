

import Foundation
import UIKit
import SnapKit
import RxSwift
class MyPageView:UIView{
    
    let disposeBag = DisposeBag()
    
    let tableView:UITableView = {
        let tableview = UITableView()
        tableview.separatorStyle = .none
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel:MyPageViewModel){
        viewModel.bookMarkItems
            .asObservable()
            .bind(to: tableView.rx.items){ tv, row, data in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: IndexPath(row: row, section: 0)) as? MyPageTableViewCell else { return UITableViewCell() }
                let item = viewModel.getoriginItems.value.first(where: {$0[0] == String(data.id!)})
                cell.setData(item ?? [String]())
                return cell
            }.disposed(by: disposeBag)
    }
    
    func layout(){
        [tableView].forEach{
            self.addSubview($0)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
    }
    
    func attribute(){
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
    }
    
    
}

