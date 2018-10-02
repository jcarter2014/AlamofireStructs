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
    
    struct Coin: Decodable {
        let name: String?
        let price_usd: String?
        let percent_change_1h: String?
        let percent_change_24h: String?
        let percent_change_7d: String?
    }
    
    struct Coins: Decodable {
        let coins: [Coin]
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var coins = [Coin]()
    var searchCoins = [Coin]()
    
    let url = "https://api.coinmarketcap.com/v1/ticker/"
    
    func getPrices() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                let coinList = try
                    JSONDecoder().decode(Array<Coin>.self, from: data)
                for coin in coinList {
                    self.coins.append(coin)
                }

            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchCoins = self.coins
            }
            }.resume()
    }
    
//    func getPrices() {
//        Alamofire.request(url).responseJSON { (response) in
//
//            if let JSON = response.result.value as? [[String: Any]] {
//
//                for eachItem in JSON {
//
//                    let currentCoin = Coin(name: eachItem["name"] as? String, price: eachItem["price_usd"] as? String, percentChange1: eachItem["percent_change_1h"] as? String, percentChange24: eachItem["percent_change_24h"] as? String, percentChange7: eachItem["percent_change_7d"] as? String)
//                    self.coins.append(currentCoin)
//                }
//            }
//
//            self.tableView.reloadData()
//            self.searchCoins = self.coins
//            print(self.coins)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = coins[indexPath.row].name
        let weekChange = coins[indexPath.row].percent_change_7d
        if let weekChangeAsDouble = (weekChange as NSString?)?.doubleValue {
            cell?.detailTextLabel?.text = "\(weekChangeAsDouble)"
            if weekChangeAsDouble > 0.0 {
                cell?.detailTextLabel?.textColor = UIColor.green
            } else {
                cell?.detailTextLabel?.textColor = UIColor.red
            }
        }
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "masterToDetail" {
            if let detailVC = segue.destination as? ViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    if let name = coins[indexPath.row].name {
                        detailVC.name = name
                    }
                    if let price = coins[indexPath.row].price_usd {
                        detailVC.price = price
                    }
                    if let percentChange1 = coins[indexPath.row].percent_change_1h {
                        detailVC.percentChange1 = percentChange1
                    }
                    if let percentChange24 = coins[indexPath.row].percent_change_24h {
                        detailVC.percentChange24 = percentChange24
                    }
                    if let percentChange7 = coins[indexPath.row].percent_change_7d {
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
        
        coins = searchCoins.filter { coin -> Bool in
            
            (coin.name?.lowercased().contains(searchText.lowercased()))!
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPrices()
        searchBar.delegate = self
    }
}

