//
//  HomeViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/09/03.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import Alamofire

class MyPageViewController: UIViewController{
//    let disposeBag = DisposeBag()
//    let myPageView = MyPageView()
//    let viewModel = MyPageViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        bind(viewModel)
//        layout()
//        attribute()
//    }
//    
//    func bind(_ viewModel:MyPageViewModel){
//        myPageView.bind(viewModel)
//
//        myPageView.tableView
//            .rx
//            .itemSelected
//            .subscribe {[weak self] event in
//                guard let self = self else { return }
//
//                let index = event.element?.row
//                let cell = self.myPageView.tableView.cellForRow(at: IndexPath(row: index ?? 0, section: 0)) as? MyPageTableViewCell ?? MyPageTableViewCell()
//
//
//
//                let viewController = SearchDetailViewController()
//                viewController.viewModel.getItems.accept(cell.item)
//                viewController.viewModel.titlegetItems.accept(viewModel.titlegetItems.value)
//                self.navigationController?.pushViewController(viewController, animated: true)
//            }.disposed(by: disposeBag)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        Observable.just("http://3.20.48.164:8000/plant/mark/list/")
//            .map { url -> ApiRequest in
//                var params = [String:Any]()
//                let header = HTTPHeader(name: "Authorization", value: "Bearer \(Auth.token.accessToken)")
//                return ApiRequest(params: params, url: url,header: header)
//            }.flatMap{ api -> Observable<[Plant_info]> in
//                return getRequest(api)
//            }.bind{[weak self] data in
//                guard let self = self else { return }
//                self.viewModel.bookMarkGetItems.accept(data)
//            }.disposed(by: disposeBag)
//    }
//
//    func layout(){
//        [myPageView].forEach{
//            self.view.addSubview($0)
//        }
//
//        myPageView.snp.makeConstraints{
//            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
//            $0.leading.equalTo(self.view.snp.leading)
//            $0.trailing.equalTo(self.view.snp.trailing)
//        }
//
//
//    }
//
//    func attribute(){
//        self.view.backgroundColor = .white
//        loadLocationsFromCSV()
//    }
//
//    private func parseCSVAt(url:URL) {
//           do {
//
//               let data = try Data(contentsOf: url)
//               let dataEncoded = String(data: data, encoding: .utf8)
//
//               if var dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
//                   viewModel.titlegetItems.accept(dataArr.remove(at: 0))
//                   dataArr.remove(at: dataArr.count - 1)
//
//                   var value = [[String]]()
//                   for item in dataArr {
//                           value.append(item)
//                   }
//                   viewModel.getItems.accept(value)
//                   viewModel.getoriginItems.accept(value)
//               }
//
//           } catch  {
//               print("Error reading CSV file")
//           }
//       }
//
//    private func loadLocationsFromCSV() {
//        let path = Bundle.main.path(forResource: "plant_info", ofType: "csv")!
//        parseCSVAt(url: URL(fileURLWithPath: path))
//        myPageView.tableView.reloadData()
//    }

}


