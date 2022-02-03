//  
//  HomePresenter.swift
//  SeeIt
//
//  Created by Rhullian Damião on 30/01/22.
//

import Foundation
import UIKit

protocol HomePresenterDelegate: UIViewController {
    func homePresenter(didGetResults movies: [Show])
}

class HomePresenter {
    
    weak var delegate: HomePresenterDelegate?
    
    var movieResults: [Show] = [] {
        didSet {
            self.delegate?.homePresenter(didGetResults: self.movieResults)
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
