//  
//  ShowDetailsViewController.swift
//  SeeIt
//
//  Created by Rhullian Damião on 02/02/22.
//

import UIKit

class ShowDetailsViewController: UIViewController {

    enum ShowDetailsRouter {
        case episodeDetails(episode: SeasonEpisode)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var airesLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var episodesTable: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    private var presenter: ShowDetailsPresenter!
    var showSelected: Show!
    var sectionToShow: Int = -1 {
        didSet {
            self.presenter.getEpisodes(season: presenter.seasons[sectionToShow].id ?? -1)
            DispatchQueue.main.async {
                self.episodesTable.reloadData()
            }
        }
    }
    
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
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.didAppear()
    }
    
    // MARK: - Methods
    func setupConfig() {
        self.presenter = ShowDetailsPresenter(delegate: self)
        
        self.episodesTable.delegate = self
        self.episodesTable.dataSource = self
        
        // Search for seasons
        if let id = showSelected.show?.id {
            presenter.getSeasons(showId: id)
        }
    }
    
    func setupLayout() {
        // Set Button State
        setButtonState()
        
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
        
        // Exhibition Dates
        if let end = showSelected.show?.ended {
            airesLabel.text = "Last Episode: \n \(end)"
        } else if let day = showSelected.show?.schedule?.days?.joined(separator: ", "), let time = showSelected.show?.schedule?.time {
            guard !day.isEmpty, !time.isEmpty else {
                airesLabel.isHidden = true
                return
            }
            airesLabel.text = airesLabel.text?.replacingOccurrences(of: "{day}", with: day)
            airesLabel.text = airesLabel.text?.replacingOccurrences(of: "{time}", with: time)
        } else {
            airesLabel.isHidden = true
        }
    }
    
    @objc private func showSection(sender: UITapGestureRecognizer) {
        let newSection = sender.view?.tag ?? -1
        self.episodesTable.reloadSections(IndexSet(integer: newSection), with: .automatic)
        self.sectionToShow = newSection
    }
    
    private func isFavorited() -> Bool {
        return UserDefaultsManager.shared.favorites.contains(where: { $0.show?.id == showSelected.show?.id })
    }
    
    private func setButtonState() {
        if isFavorited() {
            favoriteButton.setTitle("Remove favorite", for: .normal)
        } else {
            favoriteButton.setTitle("Add favorite", for: .normal)
        }
    }
    
    // MARK: - Actions
    @IBAction func addFavoriteTap(_ sender: UIButton) {
        if isFavorited() {
            UserDefaultsManager.shared.favorites.removeAll(where: { $0.show?.id == showSelected.show?.id })
        } else {
            UserDefaultsManager.shared.favorites.append(showSelected)
        }
        
        setButtonState()
    }
}

// MARK: - ShowDetailsPresenterDelegate
extension ShowDetailsViewController: ShowDetailsPresenterDelegate {
    func showDetailsPresenter(didGetResults seasons: [SeriesSeason]) {
        DispatchQueue.main.async {
            self.episodesTable.reloadData()
        }
    }
    
    func showDetailsPresenter(didGetResults episodes: [SeasonEpisode]) {
        DispatchQueue.main.async {
            self.episodesTable.reloadData()
        }
    }
}

extension ShowDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == sectionToShow {
            return presenter.episodes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        let episode = presenter.episodes[indexPath.row]
        if let epNumber = episode.number, let title = episode.name {
            config.textProperties.color = .white
            config.text = "Ep. \(epNumber) - \(title)"
        }

        cell.contentConfiguration = config
        cell.backgroundColor = UIColor(red: 00/255, green: 00/255, blue: 15/255, alpha: 0.6)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        let season = presenter.seasons[section]
        if let seasonNumber = season.number {
            config.textProperties.color = .white
            config.text = "Season \(seasonNumber)"
        }
        
        cell.contentConfiguration = config
        cell.backgroundColor = UIColor(red: 00/255, green: 00/255, blue: 15/255, alpha: 1)
        cell.tag = section
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(showSection))
        cell.addGestureRecognizer(tap)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigate(to: .episodeDetails(episode: presenter.episodes[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.seasons.count
    }
}

// MARK: - ROUTER FUNCTIONS
extension ShowDetailsViewController {
    func navigate(to selected: ShowDetailsRouter) {
        switch selected {
        case .episodeDetails(let episode):
            let vc = EpisodeDetailsViewController()
            vc.episodeSelected = episode
            vc.modalPresentationStyle = .pageSheet
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            self.present(vc, animated: true)
        }
    }
}
