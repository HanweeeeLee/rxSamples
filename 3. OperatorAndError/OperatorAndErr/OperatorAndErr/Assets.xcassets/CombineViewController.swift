//
//  CombineViewController.swift
//  OperatorAndErr
//
//  Created by hanwe lee on 2021/01/29.
//

import UIKit
import RxSwift

class CombineViewController: UIViewController {
    
    //MARK: property
    
    var bag: DisposeBag = DisposeBag()

    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: action
    
    @IBAction func startWith(_ sender: Any) {
        Observable.range(start: 1, count: 10)
            .startWith(1,2,3,4)
            .subscribe(onNext: { value in
                print("value:\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func zip(_ sender: Any) {
        let observable1 = Observable.range(start: 1, count: 10)
        let observable2 = Observable.range(start: 11, count: 20)
        Observable.zip(observable1,observable2)
            .subscribe(onNext: { value in
                print("value:\(value)")
            })
            .disposed(by: bag)
        
        Observable.zip(observable1,observable2)
            .subscribe(onNext: { foo, bar in
                print("value :\(foo + bar)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func combineLatest(_ sender: Any) {
        let observable1 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        let observable2 = Observable<Int>.interval(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
        
        Observable.zip(observable1,observable2)
            .subscribe(onNext: { foo, bar in
                print("zip foo :\(foo) bar:\(bar)")
            })
            .disposed(by: bag)
        
        Observable.combineLatest(observable1,observable2)
            .subscribe(onNext: { foo, bar in
                print("combine foo :\(foo) bar:\(bar)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func merge(_ sender: Any) { //순서를 유지하지 않는다고한다.
        let observable1 = Observable<String>.from(["metalica","megadeth","pantera","slayer","inFlames"])
        let observable2 = Observable<String>.from(["Fender","Gibson","JohnSuhr","musicman","ESP"])
        
        Observable.merge(observable1,observable2)
            .subscribe(onNext: { value in
                print("value :\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func concatenating(_ sender: Any) {
        let observable1 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .take(2)
            .map { (value) -> String in
                return "Observable 1 \(value)"
            }
        let observable2 = Observable<Int>.interval(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
            .map { (value) -> String in
                return "Observable 2:\(value)"
            }
        
        Observable.concat([observable1,observable2])
            .subscribe(onNext: { value in
                print("value :\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func amb(_ sender: Any) { //출처: https://rhammer.tistory.com/350 [고무망치의 Dev N Life]
        let left = PublishSubject<String>()
        let right = PublishSubject <String>()
        
        // 1
        let observable = left.amb(right)
        let disposable = observable.subscribe(onNext: { value in
        print(value)
        })
        
        // 2
        left.onNext("Lisbon")
        right.onNext("Copenhagen")
        left.onNext("London")
        left.onNext("Madrid")
        right.onNext("Vienna")

        disposable.dispose()
        
    }
    
    @IBAction func groupBy(_ sender: Any) {
//        Observable.from([1,2,3,4,5,6,7,8,9,10])
//            .groupBy(keySelector: { i -> String in
//                if i%2 == 0 {
//                    return "odd"
//                } else {
//                    return "even"
//                }
//            } ).flatMap { o -> Observable<String> in // Observable들을 모두 하나로 합쳐줍니다.
//                if o.key == "odd" {
//                    return o.map { v in
//                        "odd \(v)"
//                    }
//                } else {
//                    return o.map { v in
//                        "even \(v)"
//                    }
//                }
//            }
//            .subscribe { event in
//                switch event {
//                case let .next(value):
//                    print(value)
//                default:
//                    print("finished")
//                }
//
//            }.disposed(by: bag)
        let observable = Observable.range(start: 1, count: 50)
        observable.groupBy(keySelector: { value -> String in
            if value%5 == 0 {
                return "true"
            }
            else {
                return "false"
            }
        })
        .subscribe(onNext: { value in
            print("value :\(value)")
        })
        .disposed(by: bag)
        
    }
    
    @IBAction func flatMapAndConcatMap(_ sender: Any) { //flatmap은 순서를 보장하지않지만 빠르고 concatmap은 내부적으로 concat을 사용하기때문에 순서를 보장하지만 병목이 생길 수 있기때문에 느리다.
        Observable.range(start: 1, count: 10)
            .flatMap{ (x: Int) -> Observable<String> in
                return Observable<String>.create{ emitter in
                    emitter.onNext("emit \(x)")
                    emitter.onCompleted()
                    return Disposables.create()
                }
            }
            .subscribe(onNext: { value in
                print("value :\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func switchMap(_ sender: Any) { //rxSwift에 없는듯
//        Observable.range(start: 1, count: 10)
//            .s
    }
    
    
    
    
}
