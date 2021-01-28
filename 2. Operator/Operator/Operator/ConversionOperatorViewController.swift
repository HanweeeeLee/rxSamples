//
//  ConversionOperatorViewController.swift
//  Operator
//
//  Created by hanwe lee on 2021/01/28.
//

import UIKit
import RxSwift

class ConversionOperatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var bag: DisposeBag = DisposeBag()
    
    //MARK: function
    
    
    //MARK: test action
    @IBAction func map(_ sender: Any) {
        Observable<String>.from(["i","am","a","boy","you","are","a","girl"])
            .map({ value -> String in
                print("map value:\(value)")
                return value + "!"
            })
            .subscribe(onNext: { value in
                print("value :\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func cast(_ sender: Any) {
        
    }
    
    @IBAction func flatMap(_ sender: Any) {
        let sequenceInt = Observable.of(1,2,3)
        let sequenceString = Observable.of("A","B","C","D")
        
        sequenceInt
            .flatMap { (x: Int) -> Observable<String> in
                print("Emit Int Item:\(x)")
                return sequenceString
            }
            .subscribe({
                print("emit String Item:\($0)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func defaultEmpty(_ sender: Any) {
        Observable<Int>.range(start: 1, count: 10)
            .filter { value in
                value > 15
            }
            .ifEmpty(default: 15)
            .subscribe(onNext: { value in
                print("value :\(value)")
            })
            .disposed(by: self.bag)
    }
    
    @IBAction func switchIfEmpty(_ sender: Any) {
        Observable<Int>.range(start: 1, count: 10)
            .filter { value in
                value > 15
            }
            .ifEmpty(switchTo: Observable<Int>.range(start: 20, count: 2))
            .subscribe(onNext: { value in
                print("value :\(value)")
            })
            .disposed(by: self.bag)
    }
    
    @IBAction func startWith(_ sender: Any) {
        Observable.range(start: 0, count: 10)
            .startWith(-1)
            .subscribe(onNext: { value in
                print("received:\(value)")
            })
            .disposed(by: bag)
        Observable.from(["C","C++","Java","Kotlin","Swift","Fortran"])
            .startWith("Programming Languages")
            .subscribe(onNext: { value in
                print("Received:\(value)")
            })
            .disposed(by: bag)
    }
    
    @IBAction func sorted(_ sender: Any) {
        //RxSwift는 오퍼레이터로 지원 안하는듯.. 매핑해서 소팅해야할것같음..
    }
    

}
