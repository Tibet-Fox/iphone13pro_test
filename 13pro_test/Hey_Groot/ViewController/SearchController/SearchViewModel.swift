//
//  SearchViewModel.swift
//  Hey_Groot
//
//  Created by 서명주 on 2023/09/07.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

struct SearchViewModel{
    
    let items:Signal<[[String]]>
    let getItems = BehaviorRelay<[[String]]>(value: [[]])
    
    let originItems:Signal<[[String]]>
    let getoriginItems = BehaviorRelay<[[String]]>(value: [[]])
    
    
    let titleitems:Signal<[String]>
    let titlegetItems = BehaviorRelay<[String]>(value: [])
    
    
    init(){
        items = getItems
            .asSignal(onErrorSignalWith: .empty())
        
        originItems = getoriginItems
            .asSignal(onErrorSignalWith: .empty())
        
        titleitems = titlegetItems
            .asSignal(onErrorSignalWith: .empty())
    }
    
}

