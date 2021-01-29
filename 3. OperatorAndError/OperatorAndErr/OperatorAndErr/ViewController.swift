//
//  ViewController.swift
//  OperatorAndErr
//
//  Created by hanwe lee on 2021/01/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func combine(_ sender: Any) {
        let vc: CombineViewController = CombineViewController.init(nibName: "CombineViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func skipAndTake(_ sender: Any) {
        let vc: SkipAndTakeViewController = SkipAndTakeViewController.init(nibName: "SkipAndTakeViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func error(_ sender: Any) {
        let vc: ErrorViewController = ErrorViewController.init(nibName: "ErrorViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func httpExample(_ sender: Any) {
        let vc: HTTPExampleViewController = HTTPExampleViewController.init(nibName: "HTTPExampleViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

