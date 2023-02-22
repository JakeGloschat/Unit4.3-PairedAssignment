//
//  RandomFactViewController.swift
//  BYOA4.3
//
//  Created by Jake Gloschat on 2/22/23.
//

import UIKit

class RandomFactViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var randomFactLabel: UILabel!
    @IBOutlet weak var randomFactButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func randomFactButtonTapped(_ sender: Any) {
        fetchRandomFact()
    }
    
    // MARK: - Properties
    var randomFact: RandomFact?
    
    // MARK: - Functions
    func fetchRandomFact() {
        RandomFactController.fetchRandomFact { randomFact in
            guard let randomFact = randomFact else { return }
            self.randomFact = randomFact
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    func  updateViews() {
        guard let randomFact = randomFact else { return }
        randomFactLabel.text = "\(randomFact.text)"
    }
}



