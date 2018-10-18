//
//  CountryDeatils.swift
//  Countries
//
//  Created by mrbesford on 10/16/18.
//  Copyright © 2018 mrbesford. All rights reserved.
//

import UIKit


class CountryDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
 

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollViewGallery: UIScrollView!
    
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    let maxHeaderHeight: CGFloat = 240;
    let minHeaderHeight: CGFloat = 44;
    var previousScrollOffset: CGFloat = 0;
    
    
    var titleText: String = "default"
    var capitalName: String = "Moscow"
    var countryName: String = "Russia"
    var population: Int = 0
    var continent: String = "Eurasia"
    var descriptionFull: String = "Foo bar"

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //make navigation bar transparent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.contentInsetAdjustmentBehavior = .never
        
        //Fake data for gallery
        var images = [UIImage]()
        images.append(UIImage(named: "i-flag")!)
        images.append(UIImage(named: "i-flag")!)
        images.append(UIImage(named: "i-flag")!)
        images.append(UIImage(named: "i-flag")!)
        
        setGalleryImages(&images)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.headerHeightConstraint.constant = maxHeaderHeight
    }
    
    // MARK: - TableView section
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell", for: indexPath) as! DetailInfoCell

        if indexPath.row == 0 {
            
            let countryNameCell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailNameCell") as! CountryDetailNameCell
            countryNameCell.countryName?.text = countryName
            
            return countryNameCell
        }
        
        if indexPath.row == 1 {
            
            cell.icon?.image = UIImage(named: "i-star")
            cell.title?.text = "Capital"
            cell.dataLabel?.text = capitalName
        }
  
        if indexPath.row == 2 {
            
            cell.icon?.image = UIImage(named: "i-face")
            cell.title?.text = "Population"
            cell.dataLabel?.text = String(population)
        }
        if indexPath.row == 3 {
            
            cell.icon?.image = UIImage(named: "i-earth")
            cell.title?.text = "Continent"
            cell.dataLabel?.text = continent
        }
        if indexPath.row == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutCell
            cell.descriptionFull?.text = descriptionFull
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0);
            
           return cell
        }
        
        return cell
    }
    
    fileprivate func setGalleryImages(_ images: inout [UIImage]) {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let x = scrollViewGallery.frame.size.width * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: scrollViewGallery.frame.width, height: scrollViewGallery.frame.height)
            imageView.contentMode = .scaleToFill
            imageView.image = images[i]
            
            scrollViewGallery.bounces = false
            scrollViewGallery.contentSize.width = scrollViewGallery.frame.size.width * CGFloat(i + 1)
            scrollViewGallery.addSubview(imageView)
        }
    }
}


    


