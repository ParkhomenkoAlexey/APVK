//
//  FeedViewController.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 22/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol FeedDisplayLogic: class {
    func displayViewModel(_ viewModel:Feed.ViewModel)
}

class FeedViewController: UIViewController, FeedDisplayLogic, UITableViewDelegate, UITableViewDataSource {
    
    
    
    private var interactor: FeedBusinessLogic!
    private var viewModel = Feed.ViewModel.init(cells: [])
    
    // в оригинале private
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assemble()
        table.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: FeedCell.reuseId)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        // достаем всю инфу, она уже вся в ячейках
        interactor.getFeed()
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
    
    // метод вызывается для обновления пользовательского интерфейса
    func displayViewModel(_ viewModel: Feed.ViewModel) {
        self.viewModel = viewModel
        table.reloadData()
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.reuseId, for: indexPath) as! FeedCell
        let cellViewModel = viewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = viewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
}

