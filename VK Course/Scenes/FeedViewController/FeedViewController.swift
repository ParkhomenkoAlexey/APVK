//
//  FeedViewController.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 22/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var networkService: NetworkService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authService = AppDelegate.shared().authService!
        networkService = NetworkService(authService: authService)
        networkService.getFeed(completion: { (feedResponse) in
            
        }, failure: {
            
        })
        
    }
    
    
}

