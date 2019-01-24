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
    private let dateFormatter: DateFormatter
    
    init(viewController: UIViewController & FeedDisplayLogic) {
        self.viewController = viewController
        
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
    }
    
    func presentFeed(_ feedResponse: FeedResponse) {
        
        let cells = feedResponse.items.map { (feedItem) in
            cellViewModel(from: feedItem, profiles: feedResponse.profiles, groups: feedResponse.groups)
        }
        
        let viewModel = Feed.ViewModel.init(cells: cells)
        viewController.displayViewModel(viewModel) // этот метод насколько я понял берет этот viewModel и обновляет ИМ viewModel который находится в файле FeedViewController.swift
        
    }
    
    // метод который заполняет содержимое ячеек РЕАЛЬНОЙ информацией
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> Feed.ViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        return Feed.ViewModel.Cell.init(iconUrlString: profile?.photo ?? "Noname",
                                        name: profile?.name ?? "Noname",
                                        date: dateTitle,
                                        text: feedItem.text,
                                        moreTextTitle: "",
                                        likes: formattedCounter(feedItem.likes?.count),
                                        comments: formattedCounter(feedItem.comments?.count),
                                        shares: formattedCounter(feedItem.reposts?.count),
                                        views: formattedCounter(feedItem.views?.count))
    }
    
    // видимо поиск профиля или группы по id
    private func profile(for id: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable? {
        //print(id)
        let profilesOrGroups: [ProfileRepresentable] = id >= 0 ? profiles : groups
        let normalizeId = id >= 0 ? id : -id
        // находим по id первого кто совпал
        return profilesOrGroups.first(where: { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalizeId
        })
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        return String(counter)
    }
    
}
