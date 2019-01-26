//
//  FeedCell.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 23/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit



final class FeedCell: UITableViewCell {
    
    static let reuseId = "FeedCell"
    
    @IBOutlet private var cardView: UIView!
    @IBOutlet private var iconImageView: WebImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var postLabel: UILabel!
    @IBOutlet private var moreTextButton: UIButton!
    @IBOutlet private var photoImageView: WebImageView!
    @IBOutlet private var likesLabel: UILabel!
    @IBOutlet private var commentsLabel: UILabel!
    @IBOutlet private var sharesLabel: UILabel!
    @IBOutlet private var viewsLabel: UILabel!
    @IBOutlet private var countersPlaceholder: UIView!
    
    // зачем?
    // Готовит ячейку многократного использования для повторного использования делегатом табличного представления.
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        photoImageView.set(imageUrl: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
        
        for item in [likesLabel,commentsLabel,sharesLabel,viewsLabel] {
            item?.lineBreakMode = .byClipping
        }
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        // кроме заполнения информацией ячеек мы также
        // устанавливаем размеры объектов каждой ячейки
        postLabel.frame = viewModel.sizes.postLabelFrame
        photoImageView.frame = viewModel.sizes.attachmentFrame
        countersPlaceholder.frame = viewModel.sizes.counterPlaceholderFrame
        
        
        // если у нас имеются фотографии в после
        if let photoAttachment = viewModel.photoAttachement {
            photoImageView.set(imageUrl: photoAttachment.photoUrlString)
            photoImageView.isHidden = false
        } else {
            photoImageView.isHidden = true
        }
    }
    
    // MARK: - Sizes calculation
    
}
