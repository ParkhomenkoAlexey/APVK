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
    func revealPostPostId(for postId: Int)
}


final class FeedInteractor: FeedBusinessLogic {
    
    private let presenter: FeedPresenterLogic
    private let networkService: NetworkService
    
    private var feedResponse: FeedResponse?
    private var revealedPostsIds = [Int]()
    
    init(presenter: FeedPresenterLogic, networkService: NetworkService) {
        self.presenter = presenter
        self.networkService = networkService
    }
    
    // достаем Feed из инета
    func getFeed() {
        networkService.getFeed(completion: { [weak self]
            feedResponse in
            // если достали то 
            //self?.presenter.presentFeed(feedResponse)
            
            self?.feedResponse = feedResponse
            self?.presentFeed()
            }, failure: {
                print("failure Feed Interactor")
        })
    }
    
    func revealPostPostId(for postId: Int) {
        // теперь мы это значение передаем в массив
        revealedPostsIds.append(postId) // что будет если увеличим на 1? на 10? на 100?
        presentFeed()
    }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter.presentFeed(feedResponse, revealedPostIds: revealedPostsIds) // зачем мы в presenter передаем revealedPostIds?
    }
    
}
