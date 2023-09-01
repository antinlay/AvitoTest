//
//  ViewController.swift
//  AvitoTest
//
//  Created by codela on 01/09/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.text = "Hello World!"
        label.textAlignment = .center
        label.center = view.center
        view.addSubview(label)
        view.backgroundColor = .white
    }


}

