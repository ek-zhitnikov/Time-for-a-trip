//
//  FlightDetailViewController.swift
//  Time for a trip
//
//  Created by Евгений Житников on 15.05.2023.
//

import UIKit

class FlightDetailViewController: UIViewController {
    private var flight: Flight!
    private var likeButton: UIButton!
    private var isLiked: Bool = false

    convenience init(flight: Flight) {
        self.init()
        self.flight = flight
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        setupViews()
        configureFlightDetails()
    }

    private func setupViews() {
        likeButton = UIButton(frame: CGRect(x: 20, y: 200, width: 30, height: 30))
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        view.addSubview(likeButton)
    }

    private func configureFlightDetails() {
        let departureLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 300, height: 30))
        departureLabel.text = "From: \(flight.startCity)"
        view.addSubview(departureLabel)

        let arrivalLabel = UILabel(frame: CGRect(x: 20, y: 140, width: 300, height: 30))
        arrivalLabel.text = "To: \(flight.endCity)"
        view.addSubview(arrivalLabel)

        updateLikeButtonState()
    }

    @objc private func likeButtonTapped() {
        isLiked.toggle()
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        
        UserDefaults.standard.saveLikeState(isLiked, for: flight.searchToken)
    }

    private func updateLikeButtonState() {
        let isLiked = UserDefaults.standard.getLikeState(for: flight.searchToken)
        self.isLiked = isLiked
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
