//
//  SceneCoordinator.swift
//  RxMemo
//
//  Created by 윤형찬 on 2021/05/18.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {
     private let bag = DisposeBag()
     
     private var window: UIWindow
     private var currentVC: UIViewController
     
     required init(window: UIWindow) {  // 그냥 init이랑 차이점?
          self.window = window
          currentVC = window.rootViewController!
     }
     
     @discardableResult
     func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
          let subject = PublishSubject<Void>()
          
          let target = scene.instantiate()
          
          switch style {
          case .root:
               currentVC = target
               window.rootViewController = target
               subject.onCompleted()
          case .push:
               guard let nav = currentVC.navigationController else {
                    subject.onError(TrainsitionError.NavigationControllerMissing)
                    break
               }
               
               nav.pushViewController(target, animated: animated)
               currentVC = target
               
               subject.onCompleted()
          case .modal:
               currentVC.present(target, animated: animated) {
                    subject.onCompleted()
               }
               currentVC = target
          }
          return subject.ignoreElements()
     }
     
     @discardableResult
     func close(animated: Bool) -> Completable {
          return Completable.create { [unowned self] completable in
               if let presentingVC = self.currentVC.presentingViewController {
                    self.currentVC.dismiss(animated: animated) {
                         self.currentVC = presentingVC
                         completable(.completed)
                    }
               } else if let nav = self.currentVC.navigationController {
                    guard nav.popViewController(animated: animated) != nil else {
                         completable(.error(TrainsitionError.cannotPop))
                         return Disposables.create()
                    }
                    self.currentVC = nav.viewControllers.last!
                    completable(.completed)
               } else {
                    completable(.error(TrainsitionError.unknown))
               }
               return Disposables.create()
          }
     }
     
     
}
