//  
//  HomeViewController.swift
//  SeeIt
//
//  Created by Rhullian Damião on 30/01/22.
//

import UIKit

class HomeViewController: UIViewController {

    enum HomeRouter {}
    
    // MARK: - Outlets
    @IBOutlet weak var homeItemsCollection: UICollectionView!
    
    // MARK: - Properties
    private var presenter: HomePresenter!
    
    // MARK: - View Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupConfig()
        presenter.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.willAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
    }
    
    // MARK: - Methods
    func setupConfig() {
        self.presenter = HomePresenter(delegate: self)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Filmes e Séries"
        self.homeItemsCollection.delegate = self
        self.homeItemsCollection.dataSource = self
        self.homeItemsCollection.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.cellIdentifier)
    }
    
    // MARK: - Actions

}

// MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
}

// MARK: COLLECTION VIEW DELEGATE
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCell.cellIdentifier, for: indexPath) as? HomeItemCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width * 0.9, height: 150)
    }
}

// MARK: - ROUTER FUNCTIONS
extension HomeViewController {
    func navigate(to selected: HomeRouter) {
    }
}
