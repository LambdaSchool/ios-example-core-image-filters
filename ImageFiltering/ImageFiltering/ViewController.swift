//
//  ViewController.swift
//  ImageFiltering
//
//  Created by Spencer Curtis on 7/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var blurSlider: UISlider!
    
    let gaussianBlur = CIFilter(name: "CIGaussianBlur")!
    let context = CIContext(options: nil)
    
    var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Lambda")!
        originalImage = image
        imageView.image = image
        
        setUpBlurSlider()
    }
    
    @IBAction func filter(_ sender: UISlider) {
        filterImage()
    }
    
    func filterImage() {
        
        guard let image = originalImage else { return }
        
        let ciImage = CIImage(image: image)
        
        gaussianBlur.setValue(ciImage, forKey: "inputImage")
        gaussianBlur.setValue(blurSlider.value, forKey: "inputRadius")
    
        if let outputImage = gaussianBlur.outputImage,

            let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let filteredImage = UIImage(cgImage: cgImage)
            
            imageView.image = filteredImage
        }
    }
    
    
    func setUpBlurSlider() {
        if let inputRadiusDictionary = gaussianBlur.attributes["inputRadius"] as? [String: Any],
            let sliderMin = inputRadiusDictionary[kCIAttributeSliderMin] as? Float,
            let sliderMax = inputRadiusDictionary[kCIAttributeSliderMax] as? Float,
            let identity = inputRadiusDictionary[kCIAttributeIdentity] as? Float {
            
            blurSlider.minimumValue = sliderMin
            blurSlider.maximumValue = sliderMax
            blurSlider.value = identity
        }
    }
}

