//
//  InfoViewController.swift
//  WeatherBrick
//
//  Created by Данік on 25/03/2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import Foundation
import UIKit

final class InfoViewController: UIViewController {
    
    let labelArr: [String] = ["Label 1", "Label 2", "Label 3", "Label 4", "Label 5", "Label 6", "Label 7" ]
    
    @IBAction func hideButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.layer.cornerRadius = min(myView.frame.width, myView.frame.height) / 20
        myView.clipsToBounds = true
    }
    
}
