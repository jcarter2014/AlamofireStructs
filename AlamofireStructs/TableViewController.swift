//
//  ViewController.swift
//  AlamofireStructs
//
//  Created by John Carter on 5/16/18.
//  Copyright © 2018 Jack Carter. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    struct Coin {
        let name: String?
        let price: String?
        let percentChange1: String?
        let percentChange24: String?
        let percentChange7: String?
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    var coins = [Coin]()
    var searchCoins = [Coin]()
    
    let url = "https://api.coinmarketcap.com/v1/ticker/"
    
    @IBAction func showCoins(_ sender: Any) {
        print(coins)
    }
    
    func getPrices() {
        Alamofire.request(url).responseJSON { (response) in
            
            if let JSON = response.result.value as? [[String: Any]] {

                for eachItem in JSON {
                    
                    let currentCoin = Coin(name: eachItem["name"] as? String, price: eachItem["price_usd"] as? String, percentChange1: eachItem["percent_change_1h"] as? String, percentChange24: eachItem["percent_change_24h"] as? String, percentChange7: eachItem["percent_change_7d"] as? String)
                    self.coins.append(currentCoin)
                }
            }
            
            self.tableView.reloadData()
            self.searchCoins = self.coins
            print(self.coins)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "masterToDetail", sender: self)
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = coins[indexPath.row].name
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "masterToDetail" {
            if let detailVC = segue.destination as? ViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    if let name = coins[indexPath.row].name {
                        detailVC.name = name
                    }
                    if let price = coins[indexPath.row].price {
                        detailVC.price = price
                    }
                    if let percentChange1 = coins[indexPath.row].percentChange1 {
                        detailVC.percentChange1 = percentChange1
                    }
                    if let percentChange24 = coins[indexPath.row].percentChange24 {
                        detailVC.percentChange24 = percentChange24
                    }
                    if let percentChange7 = coins[indexPath.row].percentChange7 {
                        detailVC.percentChange7 = percentChange7
                    }
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            coins = searchCoins
            tableView.reloadData()
            return
        }
        //searchCoins = coins
        coins = searchCoins.filter { coin -> Bool in
            //guard let text = searchBar.text else { return false }
            (coin.name?.lowercased().contains(searchText.lowercased()))!
        }
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPrices()
        searchBar.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

