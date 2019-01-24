//
//  FeedViewModels.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 23/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

// зачем?
enum Feed {
    struct ViewModel {
        struct Cell: FeedCellViewModel {
            let iconUrlString: String
            let name: String
            let date: String
            let text: String?
            let moreTextTitle: String?
            let likes: String
            let comments: String
            let shares: String
            let views: String
        }
        let cells: [Cell]
    }
}
