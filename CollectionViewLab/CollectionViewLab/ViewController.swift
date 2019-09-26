//
//  ViewController.swift
//  CollectionViewLab
//
//  Created by Pursuit on 9/26/19.
//  Copyright © 2019 Neema Philippe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countrySearch: UISearchBar!
    
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    
    var countries = [Country](){
        didSet{
            countryCollectionView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        countryCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    private func loadData() {
        CountryAPIManager.shared.getCountriesList(completionHandler: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success (let countriesLoaded):
                    self.countries = countriesLoaded
                }
            }
            
        })
    }
    
    

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            return UICollectionViewCell()
        }
        let country = countries[indexPath.row]
        cell.countryName.text = country.name
        cell.capitalLabel.text = country.capital
        cell.populationLabel.text = "Population: \( country.population)"
        
        
        return cell
    }
    
}
