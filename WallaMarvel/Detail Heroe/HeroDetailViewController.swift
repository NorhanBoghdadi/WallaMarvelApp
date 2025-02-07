//
//  HeroDetailViewController.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 07/02/2025.
//

import UIKit

final class HeroDetailViewController: UIViewController {
    private let mainView: HeroDetailView
    private let hero: CharacterDataModel
    private let presenter: HeroDetailPresenterProtocol
    
    init(hero: CharacterDataModel, presenter: HeroDetailPresenterProtocol) {
        self.hero = hero
        self.presenter = presenter
        self.mainView = HeroDetailView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        mainView.configure(with: hero)
        Task {
            await presenter.getHeroDetails(id: hero.id)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
