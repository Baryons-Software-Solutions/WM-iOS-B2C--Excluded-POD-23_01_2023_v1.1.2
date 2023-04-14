//
//  UIImageviewExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//
// This class used for UI ImageView Extension
import Foundation
import Kingfisher
@IBDesignable
extension UIImageView {
    var imageScaleURL: String? {
        get {
            return nil
        }
        set {
            if newValue != nil {
                //sd_addActivityIndicator()
                //sd_setIndicatorStyle(.gray)
                //sd_setShowActivityIndicatorView(true)
                let url = URL(string: newValue!)
                let processor = DownsamplingImageProcessor(size: self.frame.size)
                // >> RoundCornerImageProcessor(cornerRadius: 20)
                //  self.kf.indicatorType = .activity
                self.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "ic_loadingimage"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0)),
                        .cacheOriginalImage
                    ]) { result in
                        switch result {
                        case .success(let value):
                            print("Task done for: \(value.source.url?.absoluteString ?? "")")
                        case .failure(let error):
                            print("Job failed: \(error.localizedDescription)")
                        }
                    }
                
                //                sd_setImage(with: URL(string: newValue!), completed: nil)
            }
        }
    }
    
    var setUserCicularImageURL: String? {
        get {
            return nil
        }
        set {
            if newValue != nil {
                let url = URL(string: newValue!)
                let processor = DownsamplingImageProcessor(size: self.frame.size)
                >> RoundCornerImageProcessor(cornerRadius: self.frame.size.height / 2)
                //  self.kf.indicatorType = .activity
                self.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "ic_loadingimage"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ]) { result in
                        switch result {
                        case .success(let value):
                            print("Task done for: \(value.source.url?.absoluteString ?? "")")
                        case .failure(let error):
                            print("Job failed: \(error.localizedDescription)")
                        }
                    }
            }
        }
    }
    
    func imageWithGradient(img: UIImage?) -> UIImage {
        UIGraphicsBeginImageContext(img?.size ?? CGSize())
        let context = UIGraphicsGetCurrentContext()
        
        img?.draw(at: CGPoint(x: 0, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 1.0]
        
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        let colors = [top, bottom] as CFArray
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
        
        let startPoint = CGPoint(x: (img?.size.width ?? 0) / 2, y: 0)
        let endPoint = CGPoint(x: (img?.size.width ?? 0) / 2, y: img?.size.height ?? 0)
        
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    func setImage(imageURL: String?, scale: CGSize?, cornerRadius: Int?) {
        guard let imageURL = imageURL else { return }
        let url = URL(string: imageURL)
        let processor = DownsamplingImageProcessor(size: scale ?? self.frame.size)
        
        if let cornerRadius = cornerRadius {
            _ = processor.append(another: RoundCornerImageProcessor(cornerRadius: CGFloat(cornerRadius)))
        }
        
        // >> RoundCornerImageProcessor(cornerRadius: 20)
        //   self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "ic_loadingimage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
    }
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
