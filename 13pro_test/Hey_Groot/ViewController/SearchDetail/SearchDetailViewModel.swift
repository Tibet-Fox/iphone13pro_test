

import Foundation
import RxSwift
import RxCocoa

class SearchDetailViewModel{
    
    
    let items:Signal<[String]>
    let getItems = BehaviorRelay<[String]>(value: [])
    
    let titleitems:Signal<[String]>
    let titlegetItems = BehaviorRelay<[String]>(value: [])
    
    
    
    
    init(){
        items = getItems
            .asSignal(onErrorSignalWith: .empty())
        titleitems = titlegetItems
            .asSignal(onErrorSignalWith: .empty())
    }
}

