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
          
     }
}
