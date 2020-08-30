//
//  SearchTableViewController.swift
//  FormUI
//
//  Created by Andrea Di Francia on 04/05/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import UIKit

public protocol SearchTableViewControllerDelegate: class {
    func searchDidComplete(with elem: String)
}

public class SearchTableViewController: UITableViewController {
    public var elements: [String] = []
    var filteredModel: [String] = []
    
    private var cloudElements: [String] = []
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame.size.height = 50
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "*Inserisci testo"
        return searchBar
    }()
    
    private lazy var emptyLabel: InsettableLabel = {
        let label = InsettableLabel()
        label.textInsets = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        label.text = "*Nessun Risultato".localized
        label.textAlignment = .center
        return label
    }()
    
    public weak var delegate: SearchTableViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        tableView.backgroundView = emptyLabel
        tableView.tableHeaderView = searchBar
        tableView.tableHeaderView?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        emptyLabel.isHidden = true
        filteredModel = elements
    }

    deinit {
        print("deinit - SearchTableViewController")
    }
    
    func search(with text: String) {
        filteredModel = text.isEmpty ? elements : elements.filter { $0.description.localizedCaseInsensitiveContains(text) }
        emptyLabel.isHidden = !filteredModel.isEmpty
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell
        cell?.configureCell(with: filteredModel[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.searchDidComplete(with: elements[indexPath.row])
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(with: searchText)
        tableView.reloadData()
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
