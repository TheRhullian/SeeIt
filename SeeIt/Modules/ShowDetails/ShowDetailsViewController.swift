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
    @IBOutlet weak var airesLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var episodesTable: UITableView!
    
    // MARK: - Properties
    private var presenter: ShowDetailsPresenter!
    var showSelected: Show!
    var sectionToShow: Int = -1 {
        didSet {
            DispatchQueue.main.async {
                self.episodesTable.reloadData()
                self.episodesTable.scrollToRow(at: IndexPath(row: 0, section: self.sectionToShow), at: .middle, animated: true)
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
        
        // Search for seasons
        if let id = showSelected.show?.id {
            presenter.getSeasons(showId: id)
        }
        
    }
    
    @objc private func showSection(sender: UITapGestureRecognizer) {
        let newSection = sender.view?.tag ?? -1
        self.episodesTable.reloadSections(IndexSet(integer: newSection), with: .automatic)
        self.sectionToShow = newSection
    }
    
    // MARK: - Actions

}

// MARK: - ShowDetailsPresenterDelegate
extension ShowDetailsViewController: ShowDetailsPresenterDelegate {
    func showDetailsPresenter(didGetResults seasons: [SeriesSeason]) {
        DispatchQueue.main.async {
            self.episodesTable.reloadData()
        }
    }
    
}

extension ShowDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == sectionToShow {
            return 5
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.seasons.count
    }
}

// MARK: - ROUTER FUNCTIONS
extension ShowDetailsViewController {
    func navigate(to selected: ShowDetailsRouter) {
    }
}
