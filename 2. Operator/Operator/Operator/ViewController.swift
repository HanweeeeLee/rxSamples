//
//  ViewController.swift
//  Operator
//
//  Created by hanwe lee on 2021/01/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func operators(_ sender: Any) {
        let vc = OperatorViewController.init(nibName: "OperatorViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func conversionOperators(_ sender: Any) {
        let vc = ConversionOperatorViewController.init(nibName: "ConversionOperatorViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

