//
//  JokeViewController.swift
//  NetworkHelper
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var jokeArr = [Joke]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        loadJokes()
        
    }
    
    func loadJokes() {
        JokeAPIClient.getJokes { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let jokes):
                print(jokes.count)
                self.jokeArr = jokes
            }
        }
    }
    
    
}

extension JokeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokeArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)
        
        let joke = jokeArr[indexPath.row]
        
        cell.textLabel?.text = "\(joke.setup)"
        cell.detailTextLabel?.text = "\(joke.punchline)"

        return cell
    }
    
    
}
