//
//  NetworkHelper.swift
//  MVVMExample
//
//  Created by Jiwoo Choi on 2018. 5. 26..
//  Copyright © 2018년 test. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol NetworkHelper {
    func request(_ url : String) -> Observable<(String,Bool)>
}

extension NetworkHelper {

    func request(_ url : String) -> Observable<(String,Bool)> {
        
        return Observable<(String,Bool)>.create { (observer) -> Disposable in
            
            Alamofire.request(url).response(completionHandler: { (result) in
                
                if result.error == nil {
                    observer.onNext((url,true))
                    observer.onCompleted()
                } else {
                    observer.onError(result.error!)
                }
                
            })
            return Disposables.create()
        }
    }
}
