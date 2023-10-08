

import Foundation
import RxSwift
import RxCocoa

class MyPageViewModel{
    let items:Signal<[[String]]>
    let getItems = BehaviorRelay<[[String]]>(value: [[]])

    let originItems:Signal<[[String]]>
    let getoriginItems = BehaviorRelay<[[String]]>(value: [[]])


    let titleitems:Signal<[String]>
    let titlegetItems = BehaviorRelay<[String]>(value: [])

    let bookMarkItems:Signal<[Plant_info]>
    let bookMarkGetItems = BehaviorRelay<[Plant_info]>(value: [])

    init(){
        items = getItems
            .asSignal(onErrorSignalWith: .empty())

        originItems = getoriginItems
            .asSignal(onErrorSignalWith: .empty())

        titleitems = titlegetItems
            .asSignal(onErrorSignalWith: .empty())

        bookMarkItems = bookMarkGetItems
            .asSignal(onErrorSignalWith: .empty())
    }
}

