//
//  FeedCellLayoutCalculator.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 24/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    // допустим пришли сюда с isFullSizedPost == true
    func sizes(postText: String?, isFullSizedPost: Bool, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    struct Sizes: FeedCellSizes {
        var postLabelFrame: CGRect
        var moreTextButtonFrame: CGRect
        var attachmentFrame: CGRect
        var counterPlaceholderFrame: CGRect
        var totalHeight: CGFloat
    }
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, isFullSizedPost: Bool, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        var showMoreTextButton = false
        let fittingWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // ---------------------------Работа с postLabelFrame-------------------------
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.right,
                                                    y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            
            let width = fittingWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(fittingWidth: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * CGFloat(Constants.minifiedPostLimitLines) // 8 строчек есть
            // если пост не "полного размера" и если высота текста в посте больше 8 строчек то показываем кнопку "Показать полностью..."
            if !isFullSizedPost && height > limitHeight {
                // высота текстового блока становится равной  6 строчкам
                height = Constants.postLabelFont.lineHeight * CGFloat(Constants.minfiedPostLines)
                // и показывается кнопка "Показать полностью..."
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // ---------------------------Работа с moreTextButtonFrame---------------------
        var moreTextButtonSize = CGSize.zero
        // если кнопка "Показать полностью..." должна показываться то
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        
        // ---------------------------Работа с attachmentFrame-------------------------
        let attechmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom  // почему .maxY вместо height?
        
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
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     counterPlaceholderFrame: counterPlaceholderFrame,
                     totalHeight: totalHeight)
        
    }
    
}
