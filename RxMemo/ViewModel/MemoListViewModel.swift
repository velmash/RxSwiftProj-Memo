//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by 윤형찬 on 2021/05/18.
//

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
     var memoList: Observable<[Memo]> {
          return storage.memoList()
     }
}
