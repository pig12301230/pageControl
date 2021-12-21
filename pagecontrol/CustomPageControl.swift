//
//  CustomPageControl.swift
//  pagecontrol
//
//  Created by 莊英祺 on 2021/12/15.
//

import Foundation
import UIKit

class CustomPageControl: UIPageControl {
    private var currentPageImage: UIImage?

    private var otherPagesImage: UIImage?
    
    private var current: UIColor = .red
    
    private var other: UIColor = .lightGray
    
    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }

    override var currentPage: Int {
        didSet {
//            updateDots()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        otherPagesImage = other.image(CGSize(width: 4, height: 4)).withRoundedCorners(radius: 2)
        currentPageImage = current.image(CGSize(width: 12, height: 4)).withRoundedCorners(radius: 2)
        
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove()
        } else {
            pageIndicatorTintColor = .clear
            currentPageIndicatorTintColor = .clear
            clipsToBounds = false
        }
    }

    private func defaultConfigurationForiOS14AndAbove() {
        if #available(iOS 14.0, *) {
            for index in 0..<numberOfPages {
                let image = (index == currentPage) ? currentPageImage : otherPagesImage
                setIndicatorImage(image, forPage: index)
            }
            
            /*
             Note: If Tint color set to default, Indicator image is not showing. So, give the same tint color based on your Custome Image.
            */
            currentPageIndicatorTintColor = current
            pageIndicatorTintColor = other
            // give the same color as "pagesImage" color.
            
        }
    }

    func updateDots() {
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove()
            print("## update")
        } else {
            for (index, subview) in subviews.enumerated() {
                let imageView: UIImageView
                if let existingImageview = getImageView(forSubview: subview) {
                    imageView = existingImageview
                } else {
                    imageView = UIImageView(image: otherPagesImage)
                    
                    imageView.center = subview.center
                    subview.addSubview(imageView)
                    subview.clipsToBounds = false
                }
                imageView.image = currentPage == index ? currentPageImage : otherPagesImage
            }
        }
    }

    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        } else {
            let view = view.subviews.first { (view) -> Bool in
                return view is UIImageView
            } as? UIImageView

            return view
        }
    }
    
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
       return UIGraphicsImageRenderer(size: size).image { rendererContext in
           self.setFill()
           rendererContext.fill(CGRect(origin: .zero, size: size))
       }
    }
}
           
extension UIImage {
        // image with rounded corners
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
