//
//  CountriesListScreenViewController.swift
//  Countries
//
//  Created by mrbesford on 10/15/18.
//  Copyright © 2018 mrbesford. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift




// MARK: - Main VC
class CountriesListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    var presenter: CountiesListPresenter?
    let urlString: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    
    var countriesData:[Country] = []
    var loadLimit = 0
    var refreshControl: UIRefreshControl!
    
  // MARK: - VC life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPullToRefresh()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        getData(urlString: self.urlString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // MARK: - TableView section
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        let item = countriesData[indexPath.row]

        cell.countryName?.text = item.name
        cell.сapitalName?.text = item.capital
        cell.descriptionSmall?.text = item.descriptionSmall
        cell.flagImage.loadImageFromServerURL(urlString: item.flag, PlaceHolderImage: UIImage(named: "i-face")!)
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedRow = indexPath.row
            let receiver = segue.destination as! CountryDetailsVC
            
            receiver.capitalName = countriesData[selectedRow].capital
            receiver.countryName = countriesData[selectedRow].name
            receiver.population = countriesData[selectedRow].population
            receiver.continent = countriesData[selectedRow].continent
            receiver.descriptionFull = countriesData[selectedRow].descriptionFull
        }
        
    }
  
    
    
     // MARK: - Data load
    func getData(urlString: String){
        
        let url = URL(string: urlString)
        
        DispatchQueue.main.async {
            
            URLSession.shared.dataTask(with: (url)!, completionHandler: {(data, response, error) -> Void in
                
                do {
                    self.parseJsonFromData(data)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                    
                } catch _ {
                    print(error)
                }
                
                
            }).resume()
        }
        
    }
    
     // MARK: - JSON 
    fileprivate func parseJsonFromData(_ data: Data?) {
       
        var json = try? JSON(data: data!)
        let countriesArray = json!["countries"].count
        self.loadLimit = countriesArray
        let nextJsonPage = json!["next"].stringValue
        
        for item in 0...countriesArray-1{
            
            let flag = json!["countries"][item]["country_info"]["flag"].stringValue
            let name = json!["countries"][item]["name"].stringValue
            let capital = json!["countries"][item]["capital"].stringValue
            let description_small = json!["countries"][item]["description_small"].stringValue
            let description = json!["countries"][item]["description"].stringValue
            let population = json!["countries"][item]["population"].intValue
            let continent = json!["countries"][item]["continent"].stringValue
            
            let country = Country()
            country.name = name
            country.capital = capital
            country.descriptionSmall = description_small
            country.descriptionFull = description
            country.continent = continent
            country.population = population
            country.flag = flag
            
            
            self.countriesData.append(country)
        }
        
        if nextJsonPage != "" {
            print("next json - true")
            self.getData(urlString: nextJsonPage)
            
        } else {
            print("next json - false")
        }
    }
    
    
    
     // MARK: - Refresh control section
    fileprivate func setupPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: Any) {
        self.countriesData.removeAll()
        getData(urlString: self.urlString)
        self.refreshControl?.endRefreshing()
        
    }


}

  // MARK: - Extensions
extension UIImageView {
    
    public func loadImageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}



