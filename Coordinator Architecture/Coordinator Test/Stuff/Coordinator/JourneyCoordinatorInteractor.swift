//
//  JourneyCoordinatorInteractor.swift
//  Coordinator Test
//
//  Created by Joshua Colley on 25/01/2019.
//  Copyright © 2019 Joshua Colley. All rights reserved.
//

import Foundation

protocol JourneyCoordinatorInteractorProtocol {
    func generateJourney(journey: JourneyEnum, model: JourneyModel) -> [JourneyVC]
    func setupVC() -> CoordinatorInjectionProtocol?
}

class JourneyCoordinatorInteractor: JourneyCoordinatorInteractorProtocol {

    func generateJourney(journey: JourneyEnum, model: JourneyModel) -> [JourneyVC] {
        debugPrint("@DEBUG: Generate Journey")
        switch journey {
        case .journey_1: return createJourneyOne(with: model)
        case .journey_2: return createJourneyTwo(with: model)
        }
    }

    func setupVC() -> CoordinatorInjectionProtocol? {
        return nil
    }

    // Helper Methods
    fileprivate func createJourneyOne(with model: JourneyModel) -> [JourneyVC] {
        if model.shouldSkipSecondVC {
            return [.vc1, .vc3, .vc4]
        } else {
            return [.vc1, .vc2, .vc3, .vc4]
        }
    }

    fileprivate func createJourneyTwo(with model: JourneyModel) -> [JourneyVC] {
        if model.shouldSkipSecondVC {
            return [.vc1, .vc3, .vc4]
        } else {
            return [.vc1, .vc3, .vc2, .vc4]
        }
    }
}
