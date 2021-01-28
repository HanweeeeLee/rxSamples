//
//  ViewController.swift
//  Observable
//
//  Created by hanwe lee on 2021/01/28.
//

import UIKit
import RxSwift

class Observer: ObserverType {
    typealias Element = String
    
    func on(_ event: Event<String>) {
        print("event: \(event)")
    }
    
    func onNext(_ element: Element) {
        print("onNext :\(element)")
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

class IntObserver: ObserverType {
    typealias Element = Int
    
    func on(_ event: Event<Int>) {
        print("event: \(event)")
    }
    
    func onNext(_ element: Element) {
        print("onNext :\(element)")
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

class ViewController: UIViewController {
    
    //MARK - property
    //MARK: common property
    var observer: Observer = Observer()
    var intObserver: IntObserver = IntObserver()
    var bag: DisposeBag = DisposeBag()
    
    //MARK: from
    let observableFrom: Observable<String> = Observable<String>.from(["from1","from2","from3","from4"])
    
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -  function
    //MARK: create
    func createTest1() {
        let observable: Observable<String> = Observable.create { emitter in
            emitter.onNext("emit 1")
            emitter.onNext("emit 2")
            emitter.onNext("emit 3")
            emitter.onNext("emit 4")
            emitter.onCompleted()
            return Disposables.create()
        }
        
        observable.subscribe(observer)
            .disposed(by: bag)
    }
    
    func createTest2() {
        let observable: Observable<String> = Observable.create { emitter in
            emitter.onNext("emit 1")
            emitter.onNext("emit 2")
            emitter.onNext("emit 3")
            emitter.onNext("emit 4")
            emitter.onError(MyError.test)
            return Disposables.create()
        }
        
        observable.subscribe(observer)
            .disposed(by: bag)
    }
    
    //MARK: from
    func fromTest() {
        self.observableFrom.subscribe(observer)
            .disposed(by: bag)
    }
    
    //MARK: just
    func justTest() {
        Observable.just("A String").subscribe(observer)
            .disposed(by: bag)
        Observable.just("54").subscribe(observer)
            .disposed(by: bag)
//        Observable.just(["this","is","just","array"]).subscribe(observer) //어레이는 안되나봐..
    }
    
    //MARK: range
    func rangeTest() {
        Observable<Int>.range(start: 3, count: 6).subscribe(intObserver)
            .disposed(by: bag)
    }
    
    //MARK: repeatElement
    func repeatElemnetTest() {
        Observable<Int>.repeatElement(3).subscribe(intObserver)
            .disposed(by: bag)
    }
    
    //MARK: interval
    func intervalTest() {
        Observable<Int>.interval(DispatchTimeInterval.seconds(3), scheduler: MainScheduler.instance).subscribe(intObserver)
            .disposed(by: bag)
    }
    
    //MARK: empty
    func emptyTest() {
        Observable<Int>.empty().subscribe(intObserver)
            .disposed(by: bag)
    }
    
    //MARK: never
    func neverTest() {
        Observable<Int>.never().subscribe(intObserver)
            .disposed(by: bag)
    }
    
    //MARK: - action
    @IBAction func testStart(_ sender: Any) {
        createTest1()
        createTest2()
        fromTest()
        justTest()
        rangeTest()
//        repeatElemnetTest() //이거는 주석처리 합시다..
        intervalTest()
        emptyTest()
        neverTest()
    }
    
    @IBAction func disposeSubscribeAction(_ sender: Any) {
        let vc = DisposeSubScribeViewController.init(nibName: "DisposeSubScribeViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func hotAndColdObservableAction(_ sender: Any) {
        let vc = HotAndColdObservableViewController.init(nibName: "HotAndColdObservableViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func hotObservableWithSubjectAction(_ sender: Any) {
        let vc = HotObservableWithSubjectViewController.init(nibName: "HotObservableWithSubjectViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func SubjectAction(_ sender: Any) {
        let vc = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

public enum MyError: Error {
    case test
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .test:
            return NSLocalizedString("it is test error", comment: "My error")
        }
    }
}
