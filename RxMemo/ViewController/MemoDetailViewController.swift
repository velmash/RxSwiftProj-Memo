//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by 윤형찬 on 2021/05/18.
//

import UIKit

class MemoDetailViewController: UIViewController, ViewModelBindableType {
     
     var viewModel: MemoDetailViewModel!
     
     @IBOutlet weak var listTableView: UITableView!
     @IBOutlet weak var deleteButton: UIToolbar!
     @IBOutlet weak var editButton: UIToolbar!
     @IBOutlet weak var shareButton: UIToolbar!
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
     }
     func bindViewModel() {
          viewModel.title
               .drive(navigationItem.rx.title)
               .disposed(by: rx.disposeBag)
          
          viewModel.content
               .bind(to: listTableView.rx.items) { tableview, row, value in
                    switch row {
                    case 0:
                         let cell = tableview.dequeueReusableCell(withIdentifier: "contentCell")!
                         cell.textLabel?.text = value
                         return cell
                    case 1:
                         let cell = tableview.dequeueReusableCell(withIdentifier: "dateCell")!
                         cell.textLabel?.text = value
                    default:
                         fatalError()
                    }
               }
               .disposed(by: rx.disposeBag)
     }
}
