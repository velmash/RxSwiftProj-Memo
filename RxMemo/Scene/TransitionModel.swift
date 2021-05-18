//
//  TransitionModel.swift
//  RxMemo
//
//  Created by 윤형찬 on 2021/05/18.
//

import Foundation

enum TransitionStyle {
     case root
     case push
     case modal
}

enum TrainsitionError: Error {
     case NavigationControllerMissing
     case cannotPop
     case unknown
}
