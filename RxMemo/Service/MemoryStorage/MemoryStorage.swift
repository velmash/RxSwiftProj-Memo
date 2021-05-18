//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by 윤형찬 on 2021/05/18.
//  자꾸 onNext로 배열을 방출하는 이유는 나중에 tableView에 binding을 하기 위함
//

import Foundation
import RxSwift

class MemoStorage: MemoStorageType {
     private var list = [
          Memo(content: "Hello", insertDate: Date().addingTimeInterval(-10)),
          Memo(content: "Hi", insertDate: Date().addingTimeInterval(-20))
     ]
     
     private lazy var store = BehaviorSubject<[Memo]>(value: list)
     
     @discardableResult
     func createMemo(content: String) -> Observable<Memo> {
          let memo = Memo(content: content)
          list.insert(memo, at: 0)
          
          store.onNext(list)
          
          return Observable.just(memo)
     }
     
     @discardableResult
     func memoList() -> Observable<[Memo]> {
          return store
     }
     
     @discardableResult
     func update(memo: Memo, content: String) -> Observable<Memo> {
          let updated = Memo(original: memo, updatedContent: content)
          
          if let index = list.firstIndex(where: { $0 == memo }) {
               list.remove(at: index)
               list.insert(updated, at: index)
          }
          
          store.onNext(list)
          
          return Observable.just(updated)
     }
     
     @discardableResult
     func delete(memo: Memo) -> Observable<Memo> {
          if let index = list.firstIndex(where: { $0 == memo }) {
               list.remove(at: index)
          }
          
          store.onNext(list)
          
          return Observable.just(memo)
     }
     
     
}
