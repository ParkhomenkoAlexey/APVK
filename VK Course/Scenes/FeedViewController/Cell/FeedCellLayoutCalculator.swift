//
//  FeedCellLayoutCalculator.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 24/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    struct Sizes: FeedCellSizes {
        var postLabelFrame: CGRect
        var attachmentFrame: CGRect
        var counterPlaceholderFrame: CGRect
        var totalHeight: CGFloat
    }
    
    private let screenWidth: CGFloat
    //private let systemFont15 = UIFont.systemFont(ofSize: 15)
    
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let fittingWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // ---------------------------Работа с postLabelFrame-------------------------
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.right,
                                                    y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText {
            let width = fittingWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(fittingWidth: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // ---------------------------Работа с attachmentFrame-------------------------
        let attechmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom  // почему .maxY вместо height?
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attechmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachment {
            let ratio = CGFloat(attachment.height / attachment.width)
            attachmentFrame.size = CGSize(width: fittingWidth, height: fittingWidth * ratio)
        }
        
        // ---------------------------Работа с counterPlaceholderFrame-------------------
        let counterPlaceholderFrame = CGRect(x: 0,
                                             y: max(postLabelFrame.maxY, attachmentFrame.maxY), // зачем тут max?
                                             width: fittingWidth,
                                             height: Constants.countersPlaceholderHeight)
        
        // ---------------------------Работа с totalHeight-------------------
        
        let totalHeight = counterPlaceholderFrame.maxY + Constants.cardInsets.bottom // чтооо??? почему ???
    
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     counterPlaceholderFrame: counterPlaceholderFrame,
                     totalHeight: totalHeight)
        
    }
    
}
