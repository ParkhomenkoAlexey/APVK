//
//  FeedViewController.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 22/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol FeedDisplayLogic: class {
    func displayUserViewModel(_ userViewModel: Feed.UserViewModel)
    func displayViewModel(_ viewModel:Feed.ViewModel)
}

class FeedViewController: UIViewController, FeedDisplayLogic, UITableViewDelegate, UITableViewDataSource, FeedCellDelegate {
    
    private var interactor: FeedBusinessLogic!
    private var viewModel = Feed.ViewModel.init(cells: [])
    private lazy var titleView = TitleView()
    
    private lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    // в оригинале private
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assemble()
        setupTopBars()
        //table.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: FeedCell.reuseId)
        table.register(FeedCodeCell.self, forCellReuseIdentifier: FeedCodeCell.reuseId)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        interactor.getUser()
        // достаем всю инфу, она уже вся в ячейках
        interactor.getFeed()
        
        table.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ refreshControl: UIRefreshControl) {
        interactor.getFeed()
    }
    
    private func setupTopBars() {
        self.navigationController?.hidesBarsOnSwipe = true
        let topBar = UIView(frame: UIApplication.shared.statusBarFrame)
        topBar.backgroundColor = .white
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.1
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 8
        self.view.addSubview(topBar)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.titleView = titleView
        
    }
    
    private func assemble() {
        // за что отвечает presenter?
        // в качестве входного параметра принимает FeedResponse и возвращает ячейки с готовыми постами
        let screenWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        let feedCellLayoutCalculator = FeedCellLayoutCalculator(screenWidth: screenWidth)
        let presenter = FeedPresenter(viewController: self, cellLayoutCalculator: feedCellLayoutCalculator)
        let authService = AppDelegate.shared().authService!
        let networkService = NetworkService(authService: authService)
        // инициилизируем interactor чтобы в методе viewDidLoad() сделать interactor.getFeed()
        interactor = FeedInteractor(presenter: presenter, networkService: networkService)
    }
    
    // MARK: - FeedDisplayLogic
    
    func displayUserViewModel(_ userViewModel: Feed.UserViewModel) {
        titleView.set(userViewModel: userViewModel)
    }
    
    // метод вызывается для обновления пользовательского интерфейса
    func displayViewModel(_ viewModel: Feed.ViewModel) {
        self.viewModel = viewModel
        table.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.reuseId, for: indexPath) as! FeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCodeCell.reuseId, for: indexPath) as! FeedCodeCell
        let cellViewModel = viewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = viewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = viewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    // MARK: - FeedCellDelegate
    
    func revealPost(for cell: FeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = viewModel.cells[indexPath.row]
        
        // при нажатии на кнопку мы достаем такое понятие как postId у нашей ячейки
        interactor.revealPostPostId(for: cellViewModel.postId) // раскрывает пост по данному ID
    }
    
}

