//
//  ViewController.swift
//  Input MNIST
//
//  Created by Linda Cobb on 6/10/15.
//  Copyright (c) 2015 TimesToCome Mobile. All rights reserved.
//

import UIKit



class ViewController: UIViewController
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let readMNIST = ReadMNIST()
        readMNIST.loadFileImageFile()
        readMNIST.loadLabelFile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

