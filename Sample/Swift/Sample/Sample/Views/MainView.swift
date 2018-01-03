//
//  ViewController.swift
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

import UIKit

class MainView : BaseView<MainViewModel> {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.bindProperty("helloWorld") { (data) in
            print("update helloWorld", data);
            self.label.text = data as? String;
        };
    }
    @IBAction func textFieldChange(_ sender: UITextField)
    {
        self.viewModel?.helloWorld = sender.text;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

