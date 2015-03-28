//
//  ProfilePictureButton.swift
//  Dare
//
//  Created by Louis Olivas on 3/24/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class ProfilePictureButton: UIButton {

    /**
    :brief:     Custom drawing code for the accept button, do not make modifications to anything inside of
                this method
    */
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        #if os(iOS)
            let ctx = UIGraphicsGetCurrentContext()	// iOS
            #else
            let contextPtr = NSGraphicsContext.currentContext()!.graphicsPort	// OS X
            let opaqueCtx = COpaquePointer(contextPtr)
            let ctx = Unmanaged<CGContext>.fromOpaque(opaqueCtx).takeUnretainedValue()
        #endif
        
        // enable the following lines for flipped coordinate systems
        // CGContextTranslateCTM(ctx, 0, self.bounds.size.height)
        // CGContextScaleCTM(ctx, 1, -1)
        
        /*  Shape   */
        let pathRef = CGPathCreateMutable()
        CGPathMoveToPoint(pathRef, nil, 65, 129.656)
        CGPathAddCurveToPoint(pathRef, nil, 29.173, 129.656, 0.13, 100.709, 0.13, 65)
        CGPathAddCurveToPoint(pathRef, nil, 0.13, 29.291, 29.173, 0.344, 65, 0.344)
        CGPathAddCurveToPoint(pathRef, nil, 100.827, 0.344, 129.87, 29.291, 129.87, 65)
        CGPathAddCurveToPoint(pathRef, nil, 129.87, 100.709, 100.827, 129.656, 65, 129.656)
        CGPathCloseSubpath(pathRef)
        
        CGContextSetRGBFillColor(ctx, 0, 0.49, 1, 1)
        CGContextAddPath(ctx, pathRef)
        CGContextFillPath(ctx)
        
        
        /*  Shape 2  */
        let pathRef2 = CGPathCreateMutable()
        CGPathMoveToPoint(pathRef2, nil, 65, 69.731)
        CGPathAddCurveToPoint(pathRef2, nil, 52.371, 69.731, 42.134, 59.846, 42.134, 47.653)
        CGPathAddCurveToPoint(pathRef2, nil, 42.134, 35.46, 52.371, 25.576, 65, 25.576)
        CGPathAddCurveToPoint(pathRef2, nil, 77.629, 25.576, 87.866, 35.46, 87.866, 47.653)
        CGPathAddCurveToPoint(pathRef2, nil, 87.866, 59.846, 77.629, 69.731, 65, 69.731)
        CGPathCloseSubpath(pathRef2)
        
        CGContextSetRGBFillColor(ctx, 1, 1, 1, 1)
        CGContextAddPath(ctx, pathRef2)
        CGContextFillPath(ctx)
        
        
        /*  Shape 3  */
        let pathRef3 = CGPathCreateMutable()
        CGPathMoveToPoint(pathRef3, nil, 69.507, 75.25)
        CGPathAddCurveToPoint(pathRef3, nil, 83.13, 75.25, 94.174, 84.52, 94.174, 95.956)
        CGPathAddLineToPoint(pathRef3, nil, 94.174, 122.712)
        CGPathAddCurveToPoint(pathRef3, nil, 85.223, 127.544, 75.067, 129.402, 65, 129.656)
        CGPathAddCurveToPoint(pathRef3, nil, 54.977, 129.499, 44.715, 127.524, 35.826, 122.712)
        CGPathAddLineToPoint(pathRef3, nil, 35.826, 95.956)
        CGPathAddCurveToPoint(pathRef3, nil, 35.826, 84.52, 46.87, 75.25, 60.493, 75.25)
        CGPathAddLineToPoint(pathRef3, nil, 69.507, 75.25)
        CGPathCloseSubpath(pathRef3)
        
        CGContextSetRGBFillColor(ctx, 1, 1, 1, 1)
        CGContextAddPath(ctx, pathRef3)
        CGContextFillPath(ctx)
        


        
    
    
    
    }


}
