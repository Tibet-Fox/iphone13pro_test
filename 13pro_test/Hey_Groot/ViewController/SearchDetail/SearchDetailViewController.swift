import Foundation
import UIKit
import RxSwift
import SnapKit

class SearchDetailViewController: UIViewController {
    
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
    
    func layout() {
        [searchDetailView].forEach {
            self.view.addSubview($0)
        }
        searchDetailView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    func bind(_ viewModel: SearchDetailViewModel) {
        searchDetailView.bind(viewModel)
        
        searchDetailView.bookMark.rx.tap
            .asObservable()
            .map { _ -> URLRequest in
                var params = [String: Any]()
                params["plant_id"] = viewModel.getItems.value[0]
                let url = URL(string: "http://3.20.48.164:8000/plant/mark/")!
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("Bearer \(Auth.token.accessToken)", forHTTPHeaderField: "Authorization")
                
                if let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) {
                    request.httpBody = httpBody
                }
                
                return request
            }
            .flatMap { request -> Observable<Data> in
                return URLSession.shared.rx.data(request: request)
            }
            .bind { [weak self] data in
                guard let self = self else { return }
                if let responseString = String(data: data, encoding: .utf8) {
                    print(responseString)
                }
                self.searchDetailView.bookMark.isSelected = !self.searchDetailView.bookMark.isSelected
            }
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        self.view.backgroundColor = .white
        getBookMarklist()
        addRegisterPlantButton()
    }
    
    func getBookMarklist() {
        Observable.just("http://3.20.48.164:8000/plant/mark/list/")
            .map { urlString -> URLRequest in
                guard let url = URL(string: urlString) else {
                    fatalError("Invalid URL")
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("Bearer \(Auth.token.accessToken)", forHTTPHeaderField: "Authorization")
                return request
            }
            .flatMap { request -> Observable<Data> in
                return URLSession.shared.rx.data(request: request)
            }
            .bind { [weak self] data in
                guard let self = self else { return }
                do {
                    let plantInfo = try JSONDecoder().decode([Plant_info].self, from: data)
                    self.searchDetailView.bookMark.isSelected = plantInfo.contains { $0.id == Int(self.viewModel.getItems.value[0]) }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
            .disposed(by: disposeBag)
    }

    
    // 이 코드는 viewDidLoad() 메서드 안에서 호출해야 합니다.
    func addRegisterPlantButton() {
        let registerPlantButton: UIButton = {
            let button = UIButton()
            button.setTitle("내 식물 등록하기", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(hex: 0x99CE81) // UIColor 확장을 사용하여 사용자 지정 색상 설정
            button.layer.cornerRadius = 12 // 모서리를 둥글게 만듭니다.
            button.addTarget(self, action: #selector(registerPlant), for: .touchUpInside)
            return button
        }()
        
        self.view.addSubview(registerPlantButton)
        registerPlantButton.snp.makeConstraints {
            $0.width.equalTo(358) // 버튼의 너비 설정
            $0.height.equalTo(57) // 버튼의 높이 설정
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20) // 화면 하단에 배치
            $0.centerX.equalTo(self.view) // 가운데 정렬
        }

        // ScrollView의 contentSize를 버튼 아래까지 확장
        self.view.layoutIfNeeded()
        self.searchDetailView.tableView.snp.makeConstraints {
            $0.bottom.equalTo(registerPlantButton.snp.top)
        }
        self.view.layoutIfNeeded()
    }

    @objc func registerPlant() {
        // 실제 데이터베이스에 저장할 데이터를 생성 (PlantData 대신 Dictionary 사용)
        let plantData: [String: Any] = [
            "name": "식물 이름",
            "description": "식물 설명",
            // 필요한 다른 데이터 필드들을 추가
        ]
        
        // JSONEncoder를 사용하여 JSON 데이터를 생성
        if let jsonData = try? JSONSerialization.data(withJSONObject: plantData, options: []) {
            // API 엔드포인트 및 요청 생성
            let url = URL(string: "http://3.20.48.164:8000/plant/request/")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(Auth.token.accessToken)", forHTTPHeaderField: "Authorization")
            request.httpBody = jsonData
            
            // URLSession을 사용하여 API 호출
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("데이터 저장 실패: \(error)")
                } else {
                    print("데이터가 성공적으로 저장되었습니다.")
                    // 화면을 업데이트하거나 다른 작업 수행
                }
            }.resume()
        } else {
            print("JSON 데이터 생성 실패")
        }
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
