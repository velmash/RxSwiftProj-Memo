//
//  CommonViewModel.swift
//  RxMemo
//
//  Created by 윤형찬 on 2021/05/20.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
     let title: Driver<String>
     let sceneCoordinator: SceneCoordinatorType
     let storage: MemoStorageType
     
     init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
          self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
          self.sceneCoordinator = sceneCoordinator
          self.storage = storage
     }
}
