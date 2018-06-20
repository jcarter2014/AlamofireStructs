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
        //nameLabel.text = name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
