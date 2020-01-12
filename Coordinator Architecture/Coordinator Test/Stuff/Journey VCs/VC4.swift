//
//  VC4.swift
//  Coordinator Test
//
//  Created by Joshua Colley on 24/01/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import UIKit

class VC4: UIViewController, CoordinatorInjectionProtocol {

    var coordinator: JourneyCoordinatorProtocol?

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var jumpBackButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "VC 4"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.setupUI()
    }

    // MARK: - Helper Methods
    fileprivate func setupUI() {
        guard let coordinator = self.coordinator else { return }
        self.jumpBackButton.isHidden = coordinator.model.shouldSkipSecondVC
        self.label1.text = coordinator.model.item1
        self.label2.text = coordinator.model.item2
        self.label3.text = coordinator.model.item3
    }

    // MARK: - Actions
    @IBAction func previousAction(_ sender: Any) {
        let _ = coordinator?.loadPreviousVC()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func jumpToVC(_ sender: Any) {
        guard let VCs = coordinator?.navigateTo(.vc2) as? [UIViewController] else { return }
        self.navigationController?.setViewControllers(VCs, animated: false)
    }

    @IBAction func doneAction(_ sender: Any) {
        debugPrint("@DEBUG: Done")
        self.dismiss(animated: true, completion: nil)
    }
}
