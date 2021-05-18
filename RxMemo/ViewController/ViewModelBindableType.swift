//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by 윤형찬 on 2021/05/18.
//

import UIKit

// MVVM 에서는 ViewController가 ViewModel을 속성으로 갖고 바인딩한다.
// 따라서 속성으로 가질 수 있도록 구현하기 위해 프로토콜을 선언한다.
// ViewModel은 다 다르기 때문에 제네릭으로 선언한다.

protocol ViewModelBindableType {
     associatedtype ViewModelType
     
     var viewModel: ViewModelType! { get set }
     func bindViewModel()
}

// ViewController에 추가된 ViewModel 속성에 실제의 ViewModel을 저장하고, bindViewModel 메소드를 자동으로 호출하는 메소드를 구현
extension ViewModelBindableType where Self: UIViewController {
     mutating func bind(viewModel: Self.ViewModelType) {
          self.viewModel = viewModel
          loadViewIfNeeded()
          
          bindViewModel()
     }
}
