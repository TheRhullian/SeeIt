//  
//  HomeViewController.swift
//  SeeIt
//
//  Created by Rhullian Damião on 30/01/22.
//

import UIKit

class HomeViewController: UIViewController {

    enum HomeRouter {
        case showDetails(show: Show)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var homeItemsCollection: UICollectionView!
    private lazy var searchBar: UISearchBar = {
        let s = UISearchBar()
        s.placeholder = "Search a show"
        s.delegate = self
        s.tintColor = .white
        s.barTintColor = .clear
        s.searchBarStyle = .minimal
        s.barStyle = .default
        s.searchTextField.textColor = .white
        s.sizeToFit()
        return s
    }()
    
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
        self.setupFilterButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
    }
    
    // MARK: - Methods
    private func setupConfig() {
        self.presenter = HomePresenter(delegate: self)
        self.homeItemsCollection.delegate = self
        self.homeItemsCollection.dataSource = self
        self.homeItemsCollection.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.cellIdentifier)
        self.homeItemsCollection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
        self.tapToDismiss()
    }
    
    private func setupFilterButton() {
        let button = UIBarButtonItem(image: .init(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(openSortPopup))
        self.navigationItem.setRightBarButton(button, animated: true)
    }
    
    @objc private func openSortPopup() {
        let alert = UIAlertController(title: "Filter", message: "Filter the list by:", preferredStyle: .actionSheet)
        let alphabeticallyAction = UIAlertAction(title: "Alphabetically", style: .default, handler: { action in
            self.presenter.sortType = .alphabetically
        })
        let avgAction = UIAlertAction(title: "Average", style: .default, handler: { action in
            self.presenter.sortType = .average
        })
        let noneAction = UIAlertAction(title: "None", style: .default, handler: { action in
            self.presenter.sortType = .none
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(alphabeticallyAction)
        alert.addAction(avgAction)
        alert.addAction(noneAction)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    // MARK: - Actions

}

// MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func homePresenter(updateData movies: [Show]) {
        DispatchQueue.main.async {
            self.homeItemsCollection.reloadData()
        }
    }
}

// MARK: COLLECTION VIEW DELEGATE
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeItemCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.moviesResultsSorted.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCell.cellIdentifier, for: indexPath) as? HomeItemCell else {
            return UICollectionViewCell()
        }
        cell.setupInfo(show: presenter.moviesResultsSorted[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
        header.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: header.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: header.rightAnchor),
            searchBar.topAnchor.constraint(equalTo: header.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -10)
        ])
        
        return header
    }
    
    func didSelectItem(with show: Show) {
        navigate(to: .showDetails(show: show))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIViewController.activeTextfield = searchBar.searchTextField
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        presenter.searchMovie(movie: searchText)
    }
}

// MARK: - ROUTER FUNCTIONS
extension HomeViewController {
    func navigate(to selected: HomeRouter) {
        switch selected {
        case .showDetails(let show):
            let vc = ShowDetailsViewController()
            vc.showSelected = show
            self.present(vc, animated: true)
        }
    }
}
