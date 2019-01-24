//
//  FeedViewModels.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 23/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

// зачем?
// Энум ленты новостей
enum Feed {
    // у ленты новостей есть модель новости (или поста)
    struct ViewModel {
        struct Cell: FeedCellViewModel {
    
            let iconUrlString: String
            let name: String
            let date: String
            let text: String?
            let moreTextTitle: String?
            var likes: String?
            var comments: String?
            var shares: String?
            var views: String?
        }
        // и у ленты новостей есть собственно ячейки с этими новостями
        let cells: [Cell]
    }
}
