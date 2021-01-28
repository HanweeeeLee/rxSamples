//
//  HotAndColdObservableViewController.swift
//  Observable
//
//  Created by hanwe lee on 2021/01/28.
//

import UIKit
import RxSwift

class HotAndColdObservableViewController: UIViewController {
    
    //MARK: - property
    
    var bag: DisposeBag = DisposeBag()
    
    var coldObservable: Observable<String> = Observable<String>.from(["hello","my","friends"])
//    var hotObservable: Observable<String> = Observable<String>.from(["hello","my","friends"]).publish()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - function

    //MARK: - action
    @IBAction func testStart(_ sender: Any) {
        self.coldObservable.subscribe(onNext: { value in
            print("cold value1 :\(value)")
            
        }, onError: { err in
            print("err:\(err.localizedDescription)")
            
        }, onCompleted: {
            print("cold1 coldObservable")
        }, onDisposed: {
            print("onDisposed")
        })
        .disposed(by: bag)
        
        self.coldObservable.subscribe(onNext: { value in
            print("cold value2 :\(value)")
            
        }, onError: { err in
            print("err:\(err.localizedDescription)")
            
        }, onCompleted: {
            print("cold2 coldObservable")
        }, onDisposed: {
            print("onDisposed")
        })
        .disposed(by: bag)
        
        let hotObservable: Observable<String> = Observable<String>.from(["i","want","go","home"]).delay(DispatchTimeInterval.seconds(3), scheduler: MainScheduler.instance).publish() // 잘 모르겠음.. 음...
        
        hotObservable.subscribe { (value) in
            print("hot value :\(value)")
        } onError: { (err) in
            print("\(err.localizedDescription)")
        } onCompleted: {
            print("complete hot")
        } onDisposed: {
            print("disposed hot")
        }
        .disposed(by: bag)
    }

}
