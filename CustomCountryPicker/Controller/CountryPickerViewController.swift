//
//  CountryPickerViewController.swift
//  CustomCountryPicker
//
//  Created by Tushar on 09/05/23.
//

import UIKit

protocol CountryPickerDelegate: AnyObject {
    func didSelectCountry(country: Country)
}

class CountryPickerViewController: UITableViewController {
    
    weak var delegate: CountryPickerDelegate?
    
    private lazy var countries: [Country] = loadCountries()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryCell")
        
    }
}

extension CountryPickerViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        
        cell.textLabel?.text = "\(country.phoneCode) \(country.name)"
        if let flagImage = UIImage(named: country.flag.uppercased()) {
                cell.imageView?.image = flagImage
            } else {
                print("Error: Flag image not found for country: \(country.flag)")
            }
        return cell
    }
}

extension CountryPickerViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCountry = countries[indexPath.row]
        delegate?.didSelectCountry(country: selectedCountry)
        dismiss(animated: true, completion: nil)
    }
    
    private func loadCountries() -> [Country] {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            print("Error: countries.json file not found")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let countries = try JSONDecoder().decode([Country].self, from: data)
            return countries
        } catch {
            print("Error loading countries: \(error)")
            return []
        }
    }

}
