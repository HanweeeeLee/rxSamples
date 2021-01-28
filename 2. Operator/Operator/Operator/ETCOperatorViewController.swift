//
//  ETCOperatorViewController.swift
//  Operator
//
//  Created by hanwe on 2021/01/28.
//

import UIKit
import RxSwift

class ETCOperatorViewController: UIViewController {
    
    //MARK: property
    var bag: DisposeBag = DisposeBag()
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: function
    
    
    //MARK: test action
    
    @IBAction func count(_ sender: Any) { //rxSwift에 없나?
//        Observable.from([1,5,9,7,6,4,3,2,4,6,9])
//            .count
//            .subsc
    }
    
    @IBAction func reduce(_ sender: Any) {
        Observable.of(1,2,3,4,5)
            .reduce(0,accumulator: +)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
    }
    
    @IBAction func error(_ sender: Any) { //rxKotlin이랑 달라서 예제대로 작동을 안함...
//        Observable.of(1,2,3,4,5,6,"err",8,9)
    }
    
}
