//
//  HotObservableWithSubjectViewController.swift
//  Observable
//
//  Created by hanwe lee on 2021/01/28.
//

import UIKit
import RxSwift

class HotObservableWithSubjectViewController: UIViewController {

    //MARK: - property
    
    var bag: DisposeBag = DisposeBag()
    var observable = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
    var mySubject = PublishSubject<Int>()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - function

    //MARK: - action
    @IBAction func testStart(_ sender: Any) {
        observable.subscribe(mySubject)
            .disposed(by: bag)
        mySubject.subscribe({
            print("receive: \($0)")
        })
        .disposed(by: bag)
        
        let subject = PublishSubject<String>()
        
        subject.subscribe({ value in
            print("first :\(value)")
        })
        .disposed(by: bag)
        
        subject.on(.next("a"))
        subject.on(.next("b"))
        
        subject.subscribe({ value in
            print("second :\(value)")
        })
        .disposed(by: bag)
        
        subject.on(.next("c"))
        subject.on(.next("d"))
        subject.onCompleted()
        
    }
    
}
