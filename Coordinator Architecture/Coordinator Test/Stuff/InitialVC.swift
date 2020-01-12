//
//  InitialVC.swift
//  Coordinator Test
//
//  Created by Joshua Colley on 24/01/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    @IBAction func startJourney(_ sender: UIButton) {
        guard let journey = JourneyEnum(rawValue: sender.tag) else { return }

        let coordinator = JourneyCoordinator()
        guard let destinationVC = coordinator.createJourney(journey) as? UIViewController else { return }
        let nc = UINavigationController(rootViewController: destinationVC)
        self.present(nc, animated: true, completion: nil)
    }
}
