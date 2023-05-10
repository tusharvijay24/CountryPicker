//
//  DemoViewController.swift
//  CustomCountryPicker
//
//  Created by Tushar on 09/05/23.
//

import UIKit

class DemoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func didTapShowAction(_ sender: UIButton) {
        showCountryPicker()
    }
    
    func showCountryPicker() {
        let countryPickerVC = CountryPickerViewController()
        countryPickerVC.delegate = self
        countryPickerVC.preferredContentSize = CGSize(width: 300, height: 400)
        
        let alertController = UIAlertController(title: "Select Country", message: nil, preferredStyle: .alert)
        alertController.setValue(countryPickerVC, forKey: "contentViewController")
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension DemoViewController: CountryPickerDelegate {
    
    func didSelectCountry(country: Country) {
        print("\(country.name)")
    }
    
}

