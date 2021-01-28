//
//  OperatorViewController.swift
//  Operator
//
//  Created by hanwe lee on 2021/01/28.
//

import UIKit
import RxSwift

class OperatorViewController: UIViewController { // filter Operator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var bag: DisposeBag = DisposeBag()
    
    //MARK: function
    
    func createObservable() -> Observable<String> {
        let observable: Observable<String> = Observable.create { emitter in
            emitter.onNext("1")
            usleep(1 * 1000 * 1000)
            emitter.onNext("2")
            usleep(1 * 1000 * 1000)
            emitter.onNext("3")
            usleep(1 * 1000 * 1000)
            emitter.onNext("4")
            usleep(1 * 1000 * 1000)
            emitter.onNext("5")
            usleep(1 * 1000 * 1000)
            emitter.onNext("6")
            usleep(1 * 1000 * 1000)
            emitter.onNext("7")
            usleep(1 * 1000 * 1000)
            emitter.onNext("8")
            usleep(1 * 1000 * 1000)
            emitter.onNext("9")
            usleep(1 * 1000 * 1000)
            emitter.onNext("10")
            usleep(1 * 1000 * 1000)
            emitter.onNext("11")
            usleep(1 * 1000 * 1000)
            emitter.onNext("12")
            usleep(1 * 1000 * 1000)
            emitter.onNext("13")
            usleep(1 * 1000 * 1000)
            emitter.onNext("14")
            usleep(1 * 1000 * 1000)
            emitter.onNext("15")
            usleep(1 * 1000 * 1000)
            emitter.onNext("16")
            usleep(1 * 1000 * 1000)
            emitter.onNext("17")
            usleep(1 * 1000 * 1000)
            emitter.onCompleted()
            return Disposables.create()
        }
        return observable
    }
    
    //MARK: test action
    @IBAction func debounce(_ sender: Any) {
        print("start debounce")
        createObservable()
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { value in
                print("value:\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func distinct(_ sender: Any) { //rxSwift엔 distinct 가 없는듯 ㅡ,.ㅡ
        Observable<String>.from(["1","2","2","3","3","3","4","5"])
            .distinctUntilChanged()
            .subscribe(onNext: { value in
                print("recive:\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func elementAt(_ sender: Any) {
        Observable<String>.from(["1","2","3","4","5","6","7","8"])
            .elementAt(2)
            .subscribe(onNext: { value in
                print("value:\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func filter(_ sender: Any) {
        Observable<Int>.range(start: 1, count: 20)
            .filter { value in
                value%2 == 0
            }
            .subscribe(onNext: { value in
                print("value:\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func firstAndLast(_ sender: Any) {
        Observable<Int>.range(start: 1, count: 20)
            .first()
            .subscribe({ value in
                print("value:\(value)")
            })
            .disposed(by: bag)
        
        Observable<Int>.range(start: 1, count: 20)
            .takeLast(1)
            .subscribe({ value in
                print("value:\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func ignoreElements(_ sender: Any) {
        Observable<Int>.range(start: 1, count: 20)
            .ignoreElements()
            .subscribe(onCompleted: {
                print("complete")
            }, onError: { _ in
                print("err")
            })
            .disposed(by: bag)
    }
}
