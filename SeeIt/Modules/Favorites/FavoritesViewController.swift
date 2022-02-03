//  
//  FavoritesViewController.swift
//  SeeIt
//
//  Created by Rhullian Damião on 03/02/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    enum FavoritesRouter {}
    
    // MARK: - Outlets
    @IBOutlet weak var favTable: UITableView!
    
    // MARK: - Properties
    private var presenter: FavoritesPresenter!
    
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
        
        favTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
    }
    
    // MARK: - Methods
    func setupConfig() {
        self.presenter = FavoritesPresenter(delegate: self)
        favTable.delegate = self
        favTable.dataSource = self
    }
    
    // MARK: - Actions

}

// MARK: - FavoritesPresenterDelegate
extension FavoritesViewController: FavoritesPresenterDelegate {
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultsManager.shared.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        
        config.text = UserDefaultsManager.shared.favorites[indexPath.row].show?.name
        config.textProperties.color = .white
        config.textProperties.font = .systemFont(ofSize: 14, weight: .bold)
        
        cell.backgroundColor = .secondaryColor
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            UserDefaultsManager.shared.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
}

// MARK: - ROUTER FUNCTIONS
extension FavoritesViewController {
    func navigate(to selected: FavoritesRouter) {
    }
}
