//
//  FeedViewModels.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 23/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit

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
            var photoAttachement: FeedCellPhotoAttachmentViewModel?
            var sizes: FeedCellSizes
        }
        
        struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
            var photoUrlString: String?
            var width: Float
            var height: Float
        }
        // и у ленты новостей есть собственно ячейки с этими новостями
        let cells: [Cell]
    }
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    
    static let postLabelFont = UIFont.systemFont(ofSize: 20)
    static let topViewHeight: CGFloat = 60
    static let countersPlaceholderHeight: CGFloat = 44
    
    static let countersPlaceholderViewWidth: CGFloat = 80
    static let countersPlaceholderViewHeight: CGFloat = 44
    
    static let countersPlaceholderViewsIconsSize: CGFloat = 24
    
    // dynamic
    
    //58 - 36 = 22
    static let postLabelInsets = UIEdgeInsets(top: 22 + Constants.topViewHeight, left: 12, bottom: 10, right: 12) // почему 58? 10?
}
