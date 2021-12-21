//
//  ViewController.swift
//  pagecontrol
//
//  Created by 莊英祺 on 2021/12/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var customPC: CustomPageControl!
    let otherPagesImage = UIColor.red.image(CGSize(width: 4, height: 4)).withRoundedCorners(radius: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customPC.numberOfPages = 5
        customPC.currentPage = 0
    }


    @IBAction func add(_ sender: Any) {
        let current = customPC.currentPage
        var a = current
        if current + 1 >= customPC.numberOfPages {
            customPC.currentPage = 0
        } else {
            customPC.currentPage = current + 1
        }
        a = customPC.currentPage
        customPC.updateDots()
        
        customPC.currentPage = a
    }
}

