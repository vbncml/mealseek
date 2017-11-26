//
//  ViewController.swift
//  MealSeek
//
//  Created by Zhanat on 18.10.17.
//  Copyright © 2017 KBTU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    override func viewDidLoad() {
        mainImage.image = UIImage(named:"main")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("helloworld")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

