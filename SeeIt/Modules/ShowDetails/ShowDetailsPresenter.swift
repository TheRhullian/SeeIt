//  
//  ShowDetailsPresenter.swift
//  SeeIt
//
//  Created by Rhullian Damião on 02/02/22.
//

import Foundation
import UIKit

protocol ShowDetailsPresenterDelegate: UIViewController {
    func showDetailsPresenter(didGetResults seasons: [SeriesSeason])
    func showDetailsPresenter(didGetResults episodes: [SeasonEpisode])
}


class ShowDetailsPresenter {
    
    weak var delegate: ShowDetailsPresenterDelegate?
    var seasons: [SeriesSeason] = [] {
        didSet {
            delegate?.showDetailsPresenter(didGetResults: self.seasons)
        }
    }
    
    var episodes: [SeasonEpisode] = [] {
        didSet {
            delegate?.showDetailsPresenter(didGetResults: self.episodes)
        }
    }
    
    init(delegate: ShowDetailsPresenterDelegate) {
        
        self.delegate = delegate
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
        
    }
    
    func getSeasons(showId: Int) {
        DispatchQueue.main.async {
            self.delegate?.fullScreenLoading(hide: false)
        }
        let task = URLSession(configuration: .default).seriesSeasonTask(seriesId: showId) { result, response, error in
            if let err = error {
                print(err)
                return
            }
            
            guard let res = result else { return }
            DispatchQueue.main.async {
                self.delegate?.fullScreenLoading(hide: true)
            }
            self.seasons = res
        }
        
        task?.resume()
    }
    
    func getEpisodes(season: Int) {
        DispatchQueue.main.async {
            self.delegate?.fullScreenLoading(hide: false)
        }
        let task = URLSession(configuration: .default).seasonEpisodeTask(season: season) { result, response, error in
            if let err = error {
                print(err)
                return
            }
            
            guard let res = result else { return }
            DispatchQueue.main.async {
                self.delegate?.fullScreenLoading(hide: true)
            }
            self.episodes = res
        }
        
        task?.resume()
    }
}
