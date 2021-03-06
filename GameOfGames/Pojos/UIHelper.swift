//
//  UIHelper.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/8/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import Foundation
import UIKit

class UIHelper {
   
  class func getBackgroundGradient() -> CAGradientLayer {
    //need to make a new one every time it's called or it disapears from the previous view controller before the next one fully shows
    
    /////////////////////////////////////////////////////////////////////////
    // Gradient:
    //  #409CE3 = rgb(64, 156, 227)
    //   to
    //  #2673B9 = rgb(38, 115, 185)

    // fba52a
    // 5ebceb
    // e22e92
    // 50b154
    // 000000
    // e3e4e8

    //  #33CCBB = rgb(51, 204, 187)
    //   to
    //  #6FD8CD = rgb(111, 216, 205)

    //background:
    //  #5EBCEB = rgb(94, 188, 235)

    
    let screenSize: CGRect = UIScreen.main.bounds
    
    // let colorTop = UIColor(red: 64.0/255.0, green: 156.0/255.0, blue: 227.0/255.0, alpha: 1.0).cgColor
    // let colorBottom = UIColor(red: 38.0/255.0, green: 115.0/255.0, blue: 185.0/255.0, alpha: 1.0).cgColor
    let colorTop = UIColor(red: 94.0/255.0, green: 188.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
    let colorBottom = colorTop

    let grad:CAGradientLayer? = CAGradientLayer()
    
    grad!.colors = [colorTop, colorBottom]
    grad!.locations = [0.0 , 1.0]
    //vertical gradient
    grad!.startPoint = CGPoint(x: 1.0, y: 0.0)
    grad!.endPoint = CGPoint(x: 1.0, y: 1.0)
    
    grad!.frame = CGRect(x: 0.0, y: 0.0, width: screenSize.width, height: screenSize.height)
    
    return grad!;
    /////////////////////////////////////////////////////////////////////////
  }
}
