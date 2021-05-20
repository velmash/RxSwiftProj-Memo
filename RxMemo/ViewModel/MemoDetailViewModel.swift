//
//  MemoDetailViewModel.swift
//  RxMemo
//
//  Created by 윤형찬 on 2021/05/18.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel: CommonViewModel {
     let memo: Memo
     
     private var formatter: DateFormatter = {
          let f = DateFormatter()
          f.locale = Locale(identifier: "Ko_kr")
          f.dateStyle = .medium
          f.timeStyle = .medium
          return f
     } ()
     
     var content: BehaviorSubject<[String]>
     
     init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
          self.memo = memo
          
          content = BehaviorSubject<[String]>(value: [
               memo.content,
               formatter.string(from: memo.insertDate)
          ])
          
          super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
     }
}
