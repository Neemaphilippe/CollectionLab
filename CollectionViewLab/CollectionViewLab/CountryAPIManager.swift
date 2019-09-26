//
//  CountryAPIManager.swift
//  CollectionViewLab
//
//  Created by Pursuit on 9/26/19.
//  Copyright © 2019 Neema Philippe. All rights reserved.
//

import Foundation

class CountryAPIManager {
    
    private init(){}
    
    static let shared = CountryAPIManager()
    
    func getCountriesList(completionHandler: @escaping (Result<[Country], AppError>)-> Void){
        let urlStr = "https://restcountries.eu/rest/v2/name/united"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
    }
    
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) {(result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let countryInfo = try JSONDecoder().decode([Country].self, from: data)
                    completionHandler(.success(countryInfo))
                }catch{
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }
            
        }
    
    
    }
    
    
}
