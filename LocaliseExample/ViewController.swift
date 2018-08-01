//
//  ViewController.swift
//  LocaliseExample
//
//  Created by dmason on 8/1/18.
//  Copyright © 2018 UFG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    // quick and dirty
    let languages : [String] = [ "en", "es", "fr", "it" ]
    var currentIndex: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = languageDisplayName(language: languages[currentIndex])
        self.tableView.rowHeight = 75.0
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NumberCell", for: indexPath)
        cell.textLabel?.text = NSLocalizedString("\(indexPath.row + 1)", comment: "")
        
        return cell
    }
    
    func languageDisplayName(language: String) -> String
    {
        let locale = NSLocale(localeIdentifier: language)
        return locale.displayName(forKey: NSLocale.Key.identifier, value: language)!
    }
    
    @IBAction func refreshPressed(_ sender: UIBarButtonItem)
    {
        let total = self.languages.count
        var index = Int(arc4random_uniform(UInt32(total)))
        while (index == currentIndex) {
            index = Int(arc4random_uniform(UInt32(total)))
        }
        
        self.currentIndex = index
        Bundle.setLanguage(languages[self.currentIndex])
        
        self.navigationItem.title = languageDisplayName(language: languages[self.currentIndex])
        self.tableView.reloadData()
    }
}
