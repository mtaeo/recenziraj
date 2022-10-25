//
//  HomeViewModel.swift
//  RecenziRAJ
//
//  Created by Mateo on 08.09.2022..
//

import CoreML
import Vision
import UIKit

final class HomeViewModel: BaseViewModel {
    private let authService: AuthService
    
    private lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel.init(for: RecenzirajClassifier.init(configuration: MLModelConfiguration()).model)
            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            }
            
            return request
        } catch {
            fatalError("Failed to load ML Model: \(error)")
        }
    }()

    private var onClassificationSucceeded: (([VNClassificationObservation]?) -> Void)?
    
    init(authService: AuthService) {
        self.authService = authService
    }
}

extension HomeViewModel {
    func updateClassifications(for image: UIImage, completionHandler: @escaping ([VNClassificationObservation]?) -> Void, errorHandler: (Error) -> Void) {        
        let ciImage = CIImage(image: image)!
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: .up)
        
        do {
            onClassificationSucceeded = completionHandler
            try handler.perform([classificationRequest])
        } catch {
            print("Failed to perform classifications. \n \(error.localizedDescription)")
            errorHandler(error)
        }
    }
    
    func nicePrint(_ classifications: [VNClassificationObservation]) {
        print("\n\n")
        classifications.forEach { e in
            print("\(e.identifier) + \(e.confidence)")
        }
    }
}

private extension HomeViewModel {
    func processClassifications(for request: VNRequest, error: Error?) {
        let classifications = request.results as! [VNClassificationObservation]
                        
        classifications.isEmpty
            ? onClassificationSucceeded?(nil)
            : onClassificationSucceeded?(classifications)
    }
}
