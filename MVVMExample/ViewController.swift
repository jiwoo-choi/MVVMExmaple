//
//  ViewController.swift
//  MVVMExample
//
//  Created by Jiwoo Choi on 2018. 5. 26..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    var viewModel : ViewModel!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModel()
        bind()
    }

    func bind() {
        _ = viewModel.outputs.isConnected
        .subscribe(onNext: { (bool) in
            if bool {
                self.error.text = "에러없음"
            } else {
                self.error.text = "에러!"
            }
        }).disposed(by: self.disposeBag)
        
        _ = viewModel.outputs.url
        .subscribe(onNext: { (url) in
            self.url.text = url
        }).disposed(by: self.disposeBag)
        
        _ = btn.rx.tap
        .bind {
            self.viewModel.inputs.inputRequest()
        }.disposed(by: disposeBag)
    }
}

