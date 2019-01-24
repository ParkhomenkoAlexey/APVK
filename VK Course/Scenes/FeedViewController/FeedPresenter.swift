//
//  FeedPresenter.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 23/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

// зачем?
// отвечает за заполнение ячеек нужной информацией
protocol FeedPresenterLogic: class {
    func presentFeed(_ feedResponse: FeedResponse)
}

final class FeedPresenter: FeedPresenterLogic {
    
    
    private unowned let viewController: UIViewController & FeedDisplayLogic
    
    init(viewController: UIViewController & FeedDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentFeed(_ feedResponse: FeedResponse) {
        
        let cells = feedResponse.items.map { cellViewModel(from: $0) }
        let viewModel = Feed.ViewModel.init(cells: cells)
        viewController.displayViewModel(viewModel) // этот метод насколько я понял берет этот viewModel и обновляет ИМ viewModel который находится в файле FeedViewController.swift
        
    }
    
    // метод который заполняет содержимое ячеек РЕАЛЬНОЙ информацией
    private func cellViewModel(from feedItem: FeedItem) -> Feed.ViewModel.Cell {
        return Feed.ViewModel.Cell.init(iconUrlString: "",
                                        name: "asd",
                                        date: "kek",
                                        text: feedItem.text,
                                        moreTextTitle: "",
                                        likes: String(feedItem.likes?.count ?? 0),
                                        comments: String(feedItem.comments?.count ?? 0),
                                        shares: String(feedItem.reposts?.count ?? 0),
                                        views: String(feedItem.views?.count ?? 0))
    }
    
}
