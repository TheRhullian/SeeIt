//  
//  ShowDetailsViewController.swift
//  SeeIt
//
//  Created by Rhullian Damião on 02/02/22.
//

import UIKit

class ShowDetailsViewController: UIViewController {

    enum ShowDetailsRouter {}
    
    // MARK: - Outlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var episodesTable: UITableView!
    
    // MARK: - Properties
    private var presenter: ShowDetailsPresenter!
    var showSelected: Show!
    
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
        self.presenter = ShowDetailsPresenter(delegate: self)
        
        if let showImageUrl = showSelected.show?.image?.original {
            UIImage.getImage(from: showImageUrl) { image in
                DispatchQueue.main.async {
                    self.posterImage.image = image ?? UIImage(named: "placeholder")
                }
            }
        }
        titleLabel.text = showSelected.show?.name
        genresLabel.text = showSelected.show?.genres?.joined(separator: " / ")
        summaryTextView.text = showSelected.show?.summary
    }
    
    // MARK: - Actions

}

// MARK: - ShowDetailsPresenterDelegate
extension ShowDetailsViewController: ShowDetailsPresenterDelegate {
}

// MARK: - ROUTER FUNCTIONS
extension ShowDetailsViewController {
    func navigate(to selected: ShowDetailsRouter) {
    }
}
