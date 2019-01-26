//
//  TableViewCell.swift
//  VK Interface
//
//  Created by Алексей Пархоменко on 25/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit



class FeedCodeCell: UITableViewCell {
    
    static let reuseId = "FeedCodeCell"

    // параметры элементов в ячейке которые динамически никак не изменяются в зависимости от контента
    struct Constants {
        static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
        static let postLabelFont = UIFont.systemFont(ofSize: 15)
        static let topViewHeight: CGFloat = 36
        static let countersPlaceholderHeight: CGFloat = 44
        
        static let countersPlaceholderViewWidth: CGFloat = 80
        static let countersPlaceholderViewHeight: CGFloat = 44
        
        static let countersPlaceholderViewsIconsSize: CGFloat = 24
    }
    
    // хз куда ее девать
    let moreTextButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Показать больше", for: .normal)
        button.isHidden = true
        return button
    }()
    
    // Первый слой
    let cardView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    // Второй слой
    let topView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UILabel = {
       let label = UILabel()
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        return label
    }()
    
    // нужно ли - imageView.translatesAutoresizingMaskIntoConstraints = false ???
    let photoImageView: WebImageView = {
        let imageView = WebImageView()
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let countersPlaceholder: UIView = {
        let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Третий слой на topView
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // Третий слой на countersPlaceholder
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likesImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        overlayFirstLayer() // первый слой
        overlaySecondLayer() // второй слой
        overlayThirdLayerOnTopView() // третий слой на topView
        overlayThirdLayerOnСountersPlaceholder() // третий слой на countersPlaceholder
        overlayFourthLayerOnСountersPlaceholderViews() // червертый слой на вьюшки countersPlaceholder
        
        // про это надо отдельно будет рассказать в курсе
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2 // не работает (по понятным причинам)
        iconImageView.clipsToBounds = true
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    // зачем?
    // Готовит ячейку многократного использования для повторного использования делегатом табличного представления.
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        photoImageView.set(imageUrl: nil)
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
    
    func overlayFourthLayerOnСountersPlaceholderViews() {
        likesView.addSubview(likesImage)
        likesImage.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        helpInFourthLayer(imageView: likesImage, label: likesLabel, view: likesView)
        helpInFourthLayer(imageView: commentsImage, label: commentsLabel, view: commentsView)
        helpInFourthLayer(imageView: sharesImage, label: sharesLabel, view: sharesView)
        helpInFourthLayer(imageView: viewsImage, label: viewsLabel, view: viewsView)
        
    }
    
    private func helpInFourthLayer(imageView: UIImageView, label: UILabel, view: UIView) {
        // imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewsIconsSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewsIconsSize).isActive = true
        
        // label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20)
    }
    
    func overlayThirdLayerOnСountersPlaceholder() {
        countersPlaceholder.addSubview(likesView)
        countersPlaceholder.addSubview(commentsView)
        countersPlaceholder.addSubview(sharesView)
        countersPlaceholder.addSubview(viewsView)
        
        // likesView constraints
        likesView.leadingAnchor.constraint(equalTo: countersPlaceholder.leadingAnchor).isActive = true
        likesView.topAnchor.constraint(equalTo: countersPlaceholder.topAnchor).isActive = true
        likesView.heightAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewHeight).isActive = true
        likesView.widthAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewWidth).isActive = true
        
        // commentsView constraints
        commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
        commentsView.topAnchor.constraint(equalTo: countersPlaceholder.topAnchor).isActive = true
        commentsView.heightAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewHeight).isActive = true
        commentsView.widthAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewWidth).isActive = true
        
        // sharesView constraints
        sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor).isActive = true
        sharesView.topAnchor.constraint(equalTo: countersPlaceholder.topAnchor).isActive = true
        sharesView.heightAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewHeight).isActive = true
        sharesView.widthAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewWidth).isActive = true
        
        // viewsView constraints
        viewsView.trailingAnchor.constraint(equalTo: countersPlaceholder.trailingAnchor).isActive = true
        viewsView.topAnchor.constraint(equalTo: countersPlaceholder.topAnchor).isActive = true
        viewsView.heightAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewHeight).isActive = true
        viewsView.widthAnchor.constraint(equalToConstant: Constants.countersPlaceholderViewWidth).isActive = true
    }
    
    func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        // iconImageView constraints
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // nameLabel constraints
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
        
        // dateLabel constraints
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(photoImageView)
        cardView.addSubview(countersPlaceholder)
        cardView.addSubview(moreTextButton)
        
        // topView constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        // postLabel constraints
        // не нужно

        // photoImageView constraints
        // не нужно
        
        // countersPlaceholder constraints
        // не нужно
        // временно
//        countersPlaceholder.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
//        countersPlaceholder.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
//        countersPlaceholder.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
//        countersPlaceholder.heightAnchor.constraint(equalToConstant: Constants.countersPlaceholderHeight).isActive = true
    }
    
    func overlayFirstLayer() {
        addSubview(cardView)
        
        // cardView constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
