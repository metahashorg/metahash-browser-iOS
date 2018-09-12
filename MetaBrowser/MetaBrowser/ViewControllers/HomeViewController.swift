//
//  ViewController.swift
//  MetaBrowser
//
//  Created by Николай Садчиков on 10.09.2018.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var metabrowserLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let homeService = HomeService()
    var homeItems: [HomeItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributedString1 = NSMutableAttributedString(string: "#Meta", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.6, green: 0.81, blue: 1, alpha: 1)])
        let attributedString2 = NSAttributedString(string: "Browser")
        attributedString1.append(attributedString2)
        metabrowserLabel.attributedText = attributedString1
        
        customizeSearchTextField()
        
        homeService.load { [weak self] in
            if let items = self?.homeService.homeItems {
                self?.homeItems = items
            }
            self?.tableView.reloadData()
        }

        tableView.register(R.nib.homeDataViewCell)
    }

    private func customizeSearchTextField() {
        searchTextField.layer.cornerRadius = 21
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor(red: 0.6, green: 0.81, blue: 1, alpha: 0.3).cgColor
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: "dApp address and search", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.29)])
        
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 19, height: searchTextField.frame.height))
        searchTextField.leftViewMode = .always
        
        searchTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: searchTextField.frame.height))
        searchTextField.rightViewMode = .always
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchTextField.resignFirstResponder()
    }
}

// MARK: - Table View Data Source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cell, for: indexPath)!
        
        if indexPath.row > 0 {
            cell.containerView.backgroundColor = UIColor.clear
            cell.nameLabel.textColor = UIColor(red: 0.6, green: 0.81, blue: 1, alpha: 0.7)
            cell.descriptionLabel.textColor = UIColor.white.withAlphaComponent(0.4)
        }
        
        guard let model = homeItems?[indexPath.row] else {
            return cell
        }
        
        cell.configure(with: model)
        
        return cell
    }
}

// MARK: - Table View Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Text Field Delegate
extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if newString == "" {
            self.homeItems = self.homeService.homeItems
        } else {
            self.homeItems = homeService.filteredItems(with: newString)
        }
        tableView.reloadData()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
