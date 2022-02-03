//  
//  HomePresenter.swift
//  SeeIt
//
//  Created by Rhullian Damião on 30/01/22.
//

import Foundation
import UIKit

protocol HomePresenterDelegate: UIViewController {
    func homePresenter(updateData movies: [Show])
}

class HomePresenter {
    
    enum SortType {
        case alphabetically
        case average
        case none
    }
    
    weak var delegate: HomePresenterDelegate?
    
    private var movieResults: [Show] = [] {
        didSet {
            self.delegate?.homePresenter(updateData: self.moviesResultsSorted)
        }
    }
    
    var moviesResultsSorted: [Show] {
        switch sortType {
        case .alphabetically:
            let sorted = movieResults.sorted(by: {($0.show?.name ?? "") < ($1.show?.name ?? "")})
            return sorted
        case .average:
            let sorted = movieResults.sorted(by: {($0.score ?? 0.0) > ($1.score ?? 0.0)})
            return sorted
        case .none:
            return movieResults
        }
    }
    
    var sortType: SortType = .none {
        didSet {
            self.delegate?.homePresenter(updateData: self.moviesResultsSorted)
        }
    }
    
    init(delegate: HomePresenterDelegate) {
        
        self.delegate = delegate
    }
    
    func didLoad() {
    }
    
    func willAppear() {
    }
    
    func didAppear() {
        if movieResults.isEmpty {
            searchMovie(movie: "Marvel")
        }
    }
    
    func searchMovie(movie: String) {
        DispatchQueue.main.async {
            self.delegate?.fullScreenLoading(hide: false)
        }
        
        let task = URLSession(configuration: .default).showTask(movie: movie) { result, response, error in
            
            if let err = error {
                print(err)
                return
            }
            
            guard let res = result else { return }
            DispatchQueue.main.async {
                self.delegate?.fullScreenLoading(hide: true)
            }
            self.movieResults = res
        }
        task?.resume()
    }
}
