//
//  SkipAndTakeViewController.swift
//  OperatorAndErr
//
//  Created by hanwe lee on 2021/01/29.
//

import UIKit
import RxSwift

class SkipAndTakeViewController: UIViewController {
    
    //MARK: property
    
    var bag: DisposeBag = DisposeBag()

    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: action
    @IBAction func skip(_ sender: Any) {
        let observable1 = Observable.range(start: 1, count: 10)
        
        observable1
            .skip(5)
            .subscribe(onNext: { value in
                print("value :\(value)")
            })
            .disposed(by: bag)
        
        let observable2 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        observable2
            .skip(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { value in
                print("interval value:\(value)")
            })
            .disposed(by: bag)
            
    }
    
    @IBAction func skipLast(_ sender: Any) { //skip rxSwift에 없음 + skipWhile + skipUntil
        let observable = Observable.range(start: 1, count: 10)
        observable
            .skipWhile { value in
                value % 5 != 0
            }
            .subscribe(onNext: { value in
                print("value :\(value)")
            })
            .disposed(by: bag)
        
        let subject = PublishSubject<Int>()
        let trigger = PublishSubject<Int>()
        
        subject.onNext(1)
        subject.onNext(2)
        
        subject.skipUntil(trigger)
            .subscribe{ print("Skip Until:", $0) }
            .disposed(by: bag)
        trigger.onNext(1)
        subject.onNext(3)
        
    }
    
    @IBAction func take(_ sender: Any) {
        let observable1 = Observable<Int>.range(start: 1, count: 10)
        observable1
            .take(5)
            .subscribe(onNext: { value in
                print("value:\(value)")
            })
            .disposed(by: bag)
        
        let observable2 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable2
            .take(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)
            .subscribe(onNext: { value in
                print("take interval value :\(value)")
            })
            .disposed(by: bag)
        
        Observable.range(start: 1, count: 10)
            .takeWhile { (value) -> Bool in
                value % 5 != 0
            }
            .subscribe(onNext: { value in
                print("task while value :\(value)")
            })
            .disposed(by: bag)
        
        
        
    }
    
}
