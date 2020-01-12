//
//  VC1.swift
//  Coordinator Test
//
//  Created by Joshua Colley on 24/01/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

class VC1: UIViewController, CoordinatorInjectionProtocol {

    @IBOutlet weak var skipSwitch: UISwitch!

    var coordinator: JourneyCoordinatorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "VC 1"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.setupUI()
    }

    // MARK: - Helper Methods
    fileprivate func setupUI() {
        guard let coordinator = self.coordinator else { return }
        skipSwitch.isOn = coordinator.model.shouldSkipSecondVC
    }

    fileprivate func updateModel() {
        guard let coordinator = self.coordinator else { return }
        coordinator.model.item1 = "Item 1"
        coordinator.model.item2 = skipSwitch.isOn ? "" : coordinator.model.item2
        coordinator.model.shouldSkipSecondVC = skipSwitch.isOn
    }

    // MARK: - Actions
    @IBAction func nextAction(_ sender: Any) {
        self.updateModel()
        guard let vc = coordinator?.loadNextVC() as? UIViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func previousAction(_ sender: Any) {
        debugPrint("@DEBUG: Close")
        self.dismiss(animated: true, completion: nil)
    }
}
