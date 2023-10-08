
import Foundation
import RxSwift
import RxCocoa
import Alamofire

struct ApiRequest{
    var params:[String:Any]
    var url:String
    var header:HTTPHeader
}


func getRequest<T:Codable>(_ apiRequest:ApiRequest, _ method:HTTPMethod = .get) -> Observable<T>{
    return Observable<T>.create{ observer in
        let dataRequest = AF.request(apiRequest.url, method: method, parameters: apiRequest.params,headers: [apiRequest.header]).responseJSON(completionHandler: {
            response in
            switch response.result
            {
            case .success(let obj):
                do
                {
                    
                    print("Response : \(obj)")
                    let dataJson = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let model:T = try JSONDecoder().decode(T.self,from: dataJson )
                    observer.onNext(model)
                }catch let error
                {
                    print("JsonParsingError : \(error.localizedDescription)")
                    observer.onError(error)
                }
                
                
                break
            case .failure(let error):
                print("NetorwkError : \(error.localizedDescription)")
                observer.onError(error)
                break
            }
            observer.onCompleted()
        })
        
        return Disposables.create{dataRequest.cancel()}
    }
}

