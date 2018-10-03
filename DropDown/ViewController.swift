//
//  ViewController.swift
//  DropDown
//
//  Created by Shantaram Kokate on 9/26/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button: UIButton!
    @IBOutlet weak var hCon: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
    }

    @IBAction func buttonClicked(_ sender: Any) {
        let dropDwon = DropDownView(anchorView: button)
        dropDwon.dataSource = ["Hello", "Hi", "Whats up"]
        dropDwon.show(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func mybuttonclick(_ sender: UIButton) {
        let dropDwon = DropDownView(anchorView: sender)
        dropDwon.dataSource = ["Hello", "Hi", "Whats up","GN"]
        dropDwon.show(animated: true)
    }
    
}

