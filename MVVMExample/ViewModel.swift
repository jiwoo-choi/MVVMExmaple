//
//  ViewModel.swift
//  MVVMExample
//
//  Created by Jiwoo Choi on 2018. 5. 26..
//  Copyright © 2018년 test. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewModelInput {
    
    func inputRequest()
}
protocol ViewModelOutput {
    var url: Observable<String> { get }
    var isConnected: Observable<Bool> { get }

}

protocol ViewModelType {
    var inputs: ViewModelInput { get }
    var outputs: ViewModelOutput { get }
}


class ViewModel: ViewModelInput, ViewModelOutput, ViewModelType, NetworkHelper {
    
   
    let model : Model
    
    var inputs: ViewModelInput { return self }
    var outputs: ViewModelOutput { return self }
    
    var disposeBag = DisposeBag()
    
    var url: Observable<String>
    var isConnected: Observable<Bool>

    
    init() {
        model = Model()
        self.url = model.url.asObservable()
        self.isConnected = model.isConnected.asObservable()
        
    }
}

extension ViewModel {
    
    func inputRequest() {

        self.request("https://www.naver.com")
        .bind {
                self.model.isConnected.value = $0.1
                self.model.url.value = $0.0
        }.disposed(by: self.disposeBag)
    }
}
