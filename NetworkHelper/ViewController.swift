//
//  ViewController.swift
//  NetworkHelper
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    let urlString = "https://i.redd.it/7zebjsi4m8a31.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJokes()
        loadPodcasts()
    }
    
    func loadJokes() {
        JokeAPIClient.getJokes { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let jokes):
                print(jokes.count)
            }
        }
    }
    
    func loadPodcasts() {
        PodcastAPIClient.getPodcasts { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let podcast):
                print(podcast.count)
            }
            
        }
    }
    
    

    @IBAction func loadImagePressed(_ sender: UIBarButtonItem) {
        NetworkHelper.shared.performDataTask(with: urlString) { (result) in
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let data):
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
                
            }
        }
    }
    
}

