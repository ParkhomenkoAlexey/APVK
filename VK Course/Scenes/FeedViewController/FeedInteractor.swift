//
//  FeedInteractor.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 23/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

protocol FeedBusinessLogic: class {
    func getFeed()
}


final class FeedInteractor: FeedBusinessLogic {
    
    private let presenter: FeedPresenterLogic
    private let networkService: NetworkService
    
    init(presenter: FeedPresenterLogic, networkService: NetworkService) {
        self.presenter = presenter
        self.networkService = networkService
    }
    
    // достаем Feed из инета
    func getFeed() {
        networkService.getFeed(completion: { [weak self]
            feedResponse in
            // если достали то 
            self?.presenter.presentFeed(feedResponse)
            }, failure: {
                print("failure Feed Interactor")
        })
    }
}
