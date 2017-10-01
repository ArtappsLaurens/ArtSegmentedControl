//
//  ViewController.swift
//  CustomSegmentedControlTest
//
//  Created by Laurens Biesheuvel on 27-09-17.
//  Copyright © 2017 Artapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var artSegmentedControl: ArtSegmentedControl!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artSegmentedControl.options = ["First", "Second", "Third"]
        artSegmentedControl.value = 1
        label.text = textForLabel
        //artSegmentedControl.tintColor = .blue
        //artSegmentedControl.options = ["First option", "Second option", "Third option"]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var textForLabel : String {
        return "Selected: \(artSegmentedControl.value)"
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        label.text = textForLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

