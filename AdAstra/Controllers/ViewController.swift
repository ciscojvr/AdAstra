//
//  ViewController.swift
//  AdAstra
//
//  Created by Francisco Ozuna on 3/30/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Yesterday":
            print("Yesterday Button Pressed.")
        case "Today":
            print("Today Button Pressed.")
        case "Tomorrow":
            print("Tomorrow Button Pressed.")
        default:
            print("Unknown Button Pressed.")
        }
    }
}

