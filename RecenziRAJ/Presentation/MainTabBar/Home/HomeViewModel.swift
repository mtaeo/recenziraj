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
    
    var onDidTapClassificationItem: ((Classifications.ItemName) -> Void)?
    var showAlert: ((String?, String?, String?) -> Void)?
    var classifications: [VNClassificationObservation] = []
    
    private let authService: AuthService
    
    private lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel.init(for: RecenzirajFinalClassifier.init(configuration: MLModelConfiguration()).model)
            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            }
            
            request.imageCropAndScaleOption = .scaleFit
                        
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
    func updateClassifications(for image: UIImage,
                               completionHandler: @escaping ([VNClassificationObservation]?) -> Void,
                               errorHandler: (Error) -> Void) {
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
        let ciImage = CIImage(image: image)!
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
        
        do {
            onClassificationSucceeded = completionHandler
            try handler.perform([classificationRequest])
        } catch {
            errorHandler(error)
        }
    }
    
    func nicePrint(_ classifications: [VNClassificationObservation]) {
        print("\n\n")
        classifications.forEach { e in
            print("\(e.identifier) + \(e.confidence)")
        }
    }
    
    func numberOfRows() -> Int {
        classifications.count
    }
    
    func getClassificationItemThumbnailName(_ index: Int) -> String {
        Classifications.ItemName.withLabel(classifications[index].identifier)?.thumbnail ?? "placeholder"
    }
    
    func getClassificationItemPercentage(_ index: Int) -> String {
        "\((classifications[index].confidence * 100).rounded()) %"
    }
    
    func getClassificationItemName(_ index: Int) -> String {
        classifications[index].identifier
    }
    
    func didTapClassificationItem(index: Int) {
        guard let itemNameEnum = Classifications.ItemName.withLabel(classifications[index].identifier) else {
            showAlert?("Error",
                      "There was an unknown error with this classification item.",
                      "Confirm")
            return
        }
        onDidTapClassificationItem?(itemNameEnum)
    }
}

private extension HomeViewModel {
    func processClassifications(for request: VNRequest, error: Error?) {
        classifications = request.results as? [VNClassificationObservation] ?? []
        classifications = filterClassifications(classifications)
        
        classifications.isEmpty
            ? onClassificationSucceeded?(nil)
            : onClassificationSucceeded?(classifications)
    }

    func filterClassifications(_ classifications: [VNClassificationObservation]) -> [VNClassificationObservation] {
        classifications.filter { classification in
            Float(classification.confidence) > 0.01
        }
    }
}
