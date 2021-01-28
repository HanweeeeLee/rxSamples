//
//  DisposeSubScribeViewController.swift
//  Observable
//
//  Created by hanwe lee on 2021/01/28.
//

import UIKit
import RxSwift

class DisposeSubscribeObserver: ObserverType {
    typealias Element = Int
    
    func on(_ event: Event<Int>) {
        print("event: \(event)")
    }
    
    func onNext(_ element: Element) {
        print("onNext :\(element)")
//        if element >= 10 && !
    }
    
    func onCompleted() {
        print("on complete")
        self.on(.completed)
    }
    
    func onError(_ error: Swift.Error) {
        print("on Error")
        self.on(.error(error))
    }
}

class DisposeSubScribeViewController: UIViewController {

    //MARK: - property
    
    let observale = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
    var observalesDisposable: Disposable? = nil
    var bag: DisposeBag = DisposeBag()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - function

    //MARK: - action
    @IBAction func testStart(_ sender: Any) {
        self.observalesDisposable = observale.subscribe(onNext: { value in
            print("value:\(value)")
            if value >= 10 {
                self.observalesDisposable?.dispose()
            }
        }, onError: { err in
            
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
        })
    }
}
