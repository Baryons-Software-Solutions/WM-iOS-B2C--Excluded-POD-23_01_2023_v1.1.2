//
//  UIImageExtesnion.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension UIImage {
    //    class func imageResize(_ img: UIImage, andResizeTo newSize: CGSize) -> UIImage {
    //        return img.imageScaled(toFit: newSize)
    //    }
    
    func getPixelColor(atLocation location: CGPoint, withFrameSize size: CGSize) -> UIColor {
        let x: CGFloat = (self.size.width) * location.x / size.width
        let y: CGFloat = (self.size.height) * location.y / size.height
        
        let pixelPoint: CGPoint = CGPoint(x: x, y: y)
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelIndex: Int = ((Int(self.size.width) * Int(pixelPoint.y)) + Int(pixelPoint.x)) * 4
        
        let rValue = CGFloat(data[pixelIndex]) / CGFloat(255.0)
        let gValue = CGFloat(data[pixelIndex + 1]) / CGFloat(255.0)
        let bValue = CGFloat(data[pixelIndex + 2]) / CGFloat(255.0)
        let aValue = CGFloat(data[pixelIndex + 3]) / CGFloat(255.0)
        
        return UIColor(red: rValue, green: gValue, blue: bValue, alpha: aValue)
    }
    
    func makeCircularImage(size: CGSize, borderWidth width: CGFloat) -> UIImage {
        // make a CGRect with the image's size
        let circleRect = CGRect(origin: .zero, size: size)
        
        // begin the image context since we're not in a drawRect:
        // UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)
        UIGraphicsBeginImageContextWithOptions(circleRect.size, false, UIScreen.main.scale)
        
        // create a UIBezierPath circle
        let circle = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width * 0.5)
        
        // clip to the circle
        circle.addClip()
        
        UIColor.white.set()
        circle.fill()
        
        // draw the image in the circleRect *AFTER* the context is clipped
        self.draw(in: circleRect)
        
        // create a border (for white background pictures)
        if width > 0 {
            circle.lineWidth = width
            UIColor.white.set()
            circle.stroke()
        }
        
        // get an image from the image context
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end the image context since we're not in a drawRect:
        UIGraphicsEndImageContext()
        
        return roundedImage ?? self
    }
    
    func imageResizeProportionally(withWidth expectedWidth: CGFloat) -> UIImage {
        let image = self

        return image
    }
    
    func imageResizeProportionally(withHeight expectedHeight: CGFloat) -> UIImage {
  
        let image = self
 
        return image
    }
    
    func resizeImage(expectedHeight: CGFloat) -> UIImage {
        var image = self
        let scale = expectedHeight / image.size.height
        let newWidth = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: expectedHeight))
        
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: expectedHeight))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func resizeImageWithWidth(expectedWidth: CGFloat) -> UIImage {
        var image = self
        if image.size.width > expectedWidth {
            let scale = expectedWidth / image.size.width
            let newHeight = image.size.height * scale
            UIGraphicsBeginImageContext(CGSize(width: expectedWidth, height: newHeight))
            
            image.draw(in: CGRect(x: 0, y: 0, width: expectedWidth, height: newHeight))
            image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        return image
    }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func resizeImageWithWidth(expectedWidth: CGFloat, expectedHeight: CGFloat) -> UIImage {
        var image = self
        
        UIGraphicsBeginImageContext(CGSize(width: expectedWidth, height: expectedHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: expectedWidth, height: expectedHeight))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func imageColorChange(With expecetedColor: UIColor) -> UIImage {
        var newImage: UIImage? = self.withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(self.size, false, (newImage?.scale)!)
        expecetedColor.set()
        newImage?.draw(in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(self.size.width), height: CGFloat((newImage?.size.height)!)))
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    class func image(from layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func grayscaleImage() -> UIImage {
        let image = self
        // Create image rectangle with current image width/height
        let imageRect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(image.size.width), height: CGFloat(image.size.height))
        // Grayscale color space
        let colorSpace: CGColorSpace? = CGColorSpaceCreateDeviceGray()
        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        
        let context = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)
     
        context?.draw(image.cgImage!, in: imageRect)

        let imageRef: CGImage = context!.makeImage()!
        // Create a new UIImage object
        let newImage = UIImage(cgImage: imageRef)

        return newImage
    }
    
    var isDark: Bool {
        return self.cgImage?.isDark ?? false
    }
}
extension CGImage {
    var isDark: Bool {
        guard let imageData = self.dataProvider?.data else { return false }
        guard let ptr = CFDataGetBytePtr(imageData) else { return false }
        let length = CFDataGetLength(imageData)
        let threshold = Int(Double(self.width * self.height) * 0.45)
        var darkPixels = 0
        for i in stride(from: 0, to: length, by: 4) {
            let rValue = ptr[i]
            let gValue = ptr[i + 1]
            let bValue = ptr[i + 2]
            let luminance = (0.299 * Double(rValue) + 0.587 * Double(gValue) + 0.114 * Double(bValue))
            if luminance < 150 {
                darkPixels += 1
                if darkPixels > threshold {
                    return true
                }
            }
        }
        return false
    }
}
