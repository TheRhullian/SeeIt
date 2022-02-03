//  
//  EpisodeDetailsViewController.swift
//  SeeIt
//
//  Created by Rhullian Damião on 03/02/22.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {

    enum EpisodeDetailsRouter {}
    
    // MARK: - Outlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    // MARK: - Properties
    private var presenter: EpisodeDetailsPresenter!
    var episodeSelected: SeasonEpisode!
    
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
        self.presenter = EpisodeDetailsPresenter(delegate: self)
        
        if let showImageUrl = episodeSelected.image?.original {
            UIImage.getImage(from: showImageUrl) { image in
                DispatchQueue.main.async {
                    self.posterImage.image = image ?? UIImage(named: "placeholder")
                }
            }
        }
        if let episodeNumber = episodeSelected.number, let episodeName = episodeSelected.name {
            titleLabel.text = "\(episodeNumber) - \(episodeName)"
        }
        
        if let episodeSeason = episodeSelected.season {
            subtitleLabel.text = "Season \(episodeSeason)"
        }
        
        summaryTextView.text = episodeSelected.summary
    }
    
    // MARK: - Actions

}

// MARK: - EpisodeDetailsPresenterDelegate
extension EpisodeDetailsViewController: EpisodeDetailsPresenterDelegate {
}

// MARK: - ROUTER FUNCTIONS
extension EpisodeDetailsViewController {
    func navigate(to selected: EpisodeDetailsRouter) {
    }
}
