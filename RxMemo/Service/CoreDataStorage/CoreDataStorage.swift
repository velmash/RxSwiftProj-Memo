//
//  CoreDataStorage.swift
//  RxMemo
//
//  Created by 윤형찬 on 2021/05/21.
//

import Foundation
import RxSwift
import CoreData
import RxCoreData

class CoreDataStorage: MemoStorageType {
     let modelName: String
     
     init(modelName: String) { self.modelName = modelName }
     
     private lazy var persistentContainer: NSPersistentContainer = {
         let container = NSPersistentContainer(name: modelName)
         container.loadPersistentStores(completionHandler: { (storeDescription, error) in
             if let error = error as NSError? {
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         })
         return container
     }()
     
     private var mainContext: NSManagedObjectContext {
          return persistentContainer.viewContext
     }
     
     @discardableResult
     func createMemo(content: String) -> Observable<Memo> {
          let memo = Memo(content: content)
          
          do {
               _ = try mainContext.rx.update(memo)
               return Observable.just(memo)
          } catch {
               return Observable.error(error)
          }
     }
     
     @discardableResult
     func memoList() -> Observable<[MemoSectionModel]> {
          return mainContext.rx.entities(Memo.self, sortDescriptors: [NSSortDescriptor(key: "insertDate", ascending: false)])
               .map { resurts in [MemoSectionModel(model: 0, items: resurts)] }
     }
     
     @discardableResult
     func update(memo: Memo, content: String) -> Observable<Memo> {
          let updated = Memo(original: memo, updatedContent: content)
          
          do {
               _ = try mainContext.rx.update(updated)
               return Observable.just(updated)
          } catch {
               return Observable.error(error)
          }
     }
     
     @discardableResult
     func delete(memo: Memo) -> Observable<Memo> {
          do {
               try mainContext.rx.delete(memo)
               return Observable.just(memo)
          } catch {
               return Observable.error(error)
          }
     }
     
     
}
