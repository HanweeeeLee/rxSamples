//
//  SubjectViewController.swift
//  Observable
//
//  Created by hanwe lee on 2021/01/28.
//

import UIKit
import RxSwift

class SubjectViewController: UIViewController {

    //MARK: - property
    
    var bag: DisposeBag = DisposeBag()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - function

    //MARK: - action
    @IBAction func asyncSubjectTest(_ sender: Any) {
        let observable = Observable.from([1,2,3,4])
        
        let subject = AsyncSubject<Int>()
        
        observable.subscribe(subject)
            .disposed(by: bag)
        subject.subscribe(onNext: { value in
            print("value:\(value)")
        }, onError: { err in
            print("err:\(err.localizedDescription)")
        }, onCompleted: {
            print("complete")
        }, onDisposed: {
            print("disposed")
        })
        .disposed(by: bag)
    }
    
    @IBAction func publishSubjectTest(_ sender: Any) {
        //...
    }
    
    @IBAction func behaviorSubjectTest(_ sender: Any) {
        let subject = BehaviorSubject<Int>(value: 0)
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        subject.onNext(4)
        subject.subscribe(onNext: { value in
            print("value1 :\(value)")
        }, onError: { _ in
            
        }, onCompleted: {
            print("complete")
        }, onDisposed: {
            
        }).disposed(by: bag)
        subject.onNext(5)
        subject.subscribe(onNext: { value in
            print("value2 :\(value)")
        }, onError: { _ in
            
        }, onCompleted: {
            print("complete")
        }, onDisposed: {
            
        }).disposed(by: bag)
        subject.onCompleted()
    }
    
    @IBAction func replaySubjectTest(_ sender: Any) {
        let subject = ReplaySubject<Int>.create(bufferSize: 3)
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        subject.onNext(4)
        subject.subscribe(onNext: { value in
            print("value1 :\(value)")
        }, onError: { _ in
            
        }, onCompleted: {
            print("complete")
        }, onDisposed: {
            
        }).disposed(by: bag)
        subject.onNext(5)
        subject.subscribe(onNext: { value in
            print("value2 :\(value)")
        }, onError: { _ in
            
        }, onCompleted: {
            print("complete")
        }, onDisposed: {
            
        }).disposed(by: bag)
        subject.onCompleted()
    }
    
}
