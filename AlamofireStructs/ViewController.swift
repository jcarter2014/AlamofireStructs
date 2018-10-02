//
//  ViewController.swift
//  AlamofireStructs
//
//  Created by John Carter on 5/22/18.
//  Copyright © 2018 Jack Carter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oneHourLabel: UILabel!
    @IBOutlet weak var twentyFourHourLabel: UILabel!
    @IBOutlet weak var sevenDayLabel: UILabel!
    
    var name: String?
    var price: String?
    var percentChange1: String?
    var percentChange24: String?
    var percentChange7: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        priceLabel.text = "$\(price ?? "N/A")"
        oneHourLabel.text = "1 hour change: \(percentChange1 ?? "N/A")%"
        twentyFourHourLabel.text = "24 hour change: \(percentChange24 ?? "N/A")%"
        sevenDayLabel.text = "7 day change: \(percentChange7 ?? "N/A")%"
    }


}
