//
//  ViewController.swift
//  Time for a trip
//
//  Created by Евгений Житников on 15.05.2023.
//

import UIKit

struct FlightResponse: Decodable {
    let flights: [Flight]
}

struct Flight: Decodable {
    let startDate: String
    let endDate: String
    let startLocationCode: String
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let serviceClass: String
    let seats: [Seat]
    let price: Int
    let searchToken: String
}

struct Seat: Decodable {
    let passengerType: String
    let count: Int
}

class FlightListViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var activityIndicator: UIActivityIndicatorView!
    private var flights: [Flight] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupActivityIndicator()
        
        loadTestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func loadTestData() {
        let testData = createTestData()

        flights = testData

        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width - 40, height: 150)
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FlightCell.self, forCellWithReuseIdentifier: "FlightCell")
        collectionView.backgroundColor = .yellow
        view.addSubview(collectionView)
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    

    private func createTestData() -> [Flight] {
        let flight1 = Flight(startDate: "2023-05-18 00:00:00 +0000 UTC",
                             endDate: "2023-05-20 00:00:00 +0000 UTC",
                             startLocationCode: "ABC",
                             endLocationCode: "XYZ",
                             startCity: "City A",
                             endCity: "City B",
                             serviceClass: "Economy",
                             seats: [],
                             price: 500,
                             searchToken: "ABCXYZ123")

        let flight2 = Flight(startDate: "2023-05-21 00:00:00 +0000 UTC",
                             endDate: "2023-05-23 00:00:00 +0000 UTC",
                             startLocationCode: "DEF",
                             endLocationCode: "GHI",
                             startCity: "City C",
                             endCity: "City D",
                             serviceClass: "Business",
                             seats: [],
                             price: 1000,
                             searchToken: "DEFGHI456")

        return [flight1, flight2]
    }
}

extension FlightListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flights.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightCell", for: indexPath) as! FlightCell
        let flight = flights[indexPath.item]
        cell.configure(with: flight)

        return cell
    }
}

extension FlightListViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        }
}

