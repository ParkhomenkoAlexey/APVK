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
    func presentFeed(_ feedResponse: FeedResponse, revealedPostIds: [Int])
}

final class FeedPresenter: FeedPresenterLogic {
    
    
    private unowned let viewController: UIViewController & FeedDisplayLogic
    private let dateFormatter: DateFormatter
    private let cellLayoutCalculator: FeedCellLayoutCalculatorProtocol
    
    init(viewController: UIViewController & FeedDisplayLogic, cellLayoutCalculator: FeedCellLayoutCalculatorProtocol) {
        self.viewController = viewController
        self.cellLayoutCalculator = cellLayoutCalculator
        
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
    }
    
    func presentFeed(_ feedResponse: FeedResponse, revealedPostIds: [Int]) {
        
        // каждый FeedItem преобразуется исходя из функции cellViewModel
        // заполняем массив ячеек
        let cells = feedResponse.items.map { (feedItem) in
            // с каждой FeedItem проделываем:
            cellViewModel(from: feedItem, profiles: feedResponse.profiles, groups: feedResponse.groups, revealedPostsIds: revealedPostIds)
        }
        
        let viewModel = Feed.ViewModel.init(cells: cells)
        viewController.displayViewModel(viewModel) // этот метод насколько я понял берет этот viewModel и обновляет ИМ viewModel который находится в файле FeedViewController.swift
        
    }
    
    // метод который заполняет содержимое ячеек РЕАЛЬНОЙ информацией
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostsIds: [Int]) -> Feed.ViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachemnts = self.photoAttachments(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        
        // пробегаемся по всему массиву revealedPostsIds, если хоть один элемент этого массива равен feedItem.postId то isFullSized == true
        
        let isFullSized = revealedPostsIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        // короткая запись
        // let isFullSized = revealedPostsIds.contains(feedItem.postId)
        //let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        let sizes = cellLayoutCalculator.sizes(postText: postText, isFullSizedPost: isFullSized, photoAttachments: photoAttachemnts)
        
        
        
        return Feed.ViewModel.Cell.init(postId: feedItem.postId,
                                        iconUrlString: profile?.photo ?? "",
                                        name: profile?.name ?? "Noname",
                                        date: dateTitle,
                                        text: postText,
                                        likes: formattedCounter(feedItem.likes?.count),
                                        comments: formattedCounter(feedItem.comments?.count),
                                        shares: formattedCounter(feedItem.reposts?.count),
                                        views: formattedCounter(feedItem.views?.count),
                                        photoAttachements: photoAttachemnts,
                                        sizes: sizes)
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
    
//    private func photoAttachment(feedItem: FeedItem) -> Feed.ViewModel.FeedCellPhotoAttachment? {
//        // .compactMap - Возвращает массив, содержащий ненулевые результаты вызова данного преобразования для каждого элемента этой последовательности.
//        // заполняем массив фотографий из поста
//        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
//            attachment.photo
//        }), let firstPhoto = photos.first else {
//            return nil
//        }
//
//        return Feed.ViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBig,
//                                                           width: firstPhoto.width,
//                                                           height: firstPhoto.height)
//    }
    
    private func photoAttachments(feedItem: FeedItem) -> [Feed.ViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        return attachments.compactMap({ attachment -> Feed.ViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return Feed.ViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBig,
                                                               width: photo.width,
                                                               height: photo.height)
        })
    }
    
}
