//
//  JourneyCoordinator.swift
//  Coordinator Test
//
//  Created by Joshua Colley on 24/01/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation
import UIKit

enum JourneyVC: String {
    case vc1 = "VC1"
    case vc2 = "VC2"
    case vc3 = "VC3"
    case vc4 = "VC4"
}

enum JourneyEnum: Int {
    case journey_1 = 0
    case journey_2 = 1
}

// MARK: - Injection Protocol
// Protocol to allow Coordinator Injection into the View Controller
protocol CoordinatorInjectionProtocol {
    var coordinator: JourneyCoordinatorProtocol? { get set }
    mutating func injectCoordinator(_ coordinator: JourneyCoordinatorProtocol)
}

extension CoordinatorInjectionProtocol where Self: UIViewController {
    // Default implementation to mutate the required View Controller
    mutating func injectCoordinator(_ coordinator: JourneyCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: - Journey Coordinator
protocol JourneyCoordinatorProtocol: class {
    var model: JourneyModel { get set }
    func loadPreviousVC() -> CoordinatorInjectionProtocol?
    func loadNextVC() -> CoordinatorInjectionProtocol?
    func navigateTo(_ vc: JourneyVC) -> [CoordinatorInjectionProtocol]?
    func createJourney(_ journey: JourneyEnum) -> CoordinatorInjectionProtocol?
}

class JourneyCoordinator {
    var journeyType: JourneyEnum!
    var currentVC: JourneyVC?
    var selectedJourney: [JourneyVC] = []
    var model: JourneyModel
    var interactor: JourneyCoordinatorInteractorProtocol!

    init() {
        self.model = JourneyModel()
        self.interactor = JourneyCoordinatorInteractor()
    }
}

// Implement JourneyCoordinator Protocol
extension JourneyCoordinator: JourneyCoordinatorProtocol {
    func createJourney(_ journey: JourneyEnum) -> CoordinatorInjectionProtocol? {
        self.journeyType = journey
        self.selectedJourney = self.interactor.generateJourney(journey: journeyType, model: model)
        debugPrint("@DEBUG: create journey \(journey.rawValue)")
        guard let current = self.selectedJourney.first else { return nil }
        self.currentVC = current
        var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: current.rawValue) as? CoordinatorInjectionProtocol
        vc?.injectCoordinator(self)
        return vc
    }

    func loadPreviousVC() -> CoordinatorInjectionProtocol? {
        debugPrint("@DEBUG: previous VC")
        guard let currentIndex = self.selectedJourney.firstIndex(of: currentVC!) else { return nil }
        guard currentIndex != 0 else { return nil }
        return setupVC(index: currentIndex - 1)
    }

    func loadNextVC() -> CoordinatorInjectionProtocol? {
        debugPrint("@DEBUG: next VC")
        self.selectedJourney = self.interactor.generateJourney(journey: journeyType, model: model)
        guard let currentIndex = self.selectedJourney.firstIndex(of: currentVC!) else { return nil }
        guard currentIndex != self.selectedJourney.count - 1 else { return nil }
        return setupVC(index: currentIndex + 1)
    }

    func navigateTo(_ vc: JourneyVC) -> [CoordinatorInjectionProtocol]? {
        debugPrint("@DEBUG: navigate To called")
        guard let index = self.selectedJourney.firstIndex(of: vc) else { return nil }
        self.currentVC  = vc
        let subset = self.selectedJourney[0...index]
        var VCs: [CoordinatorInjectionProtocol] = []
        subset.forEach { (journeyVC) in
            var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: journeyVC.rawValue) as? CoordinatorInjectionProtocol
            vc?.injectCoordinator(self)
            guard let injectedVC = vc else { return }
            VCs.append(injectedVC)
        }
        return VCs
    }

    // MARK: - Helper Methods
    fileprivate func setupVC(index: Int) -> CoordinatorInjectionProtocol? {
        let targetVC = self.selectedJourney[index]
        self.currentVC = targetVC
        var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: targetVC.rawValue) as? CoordinatorInjectionProtocol
        vc?.injectCoordinator(self)
        return vc
    }
}
