//
//  dareAddButton.swift
//  Dare
//
//  Created by Louis Olivas on 3/26/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class DareAddButton: UIButton {

    /**
    :brief:     Custom drawing code for the accept button, do not make modifications to anything inside of
                this method
    */
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
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
        CGPathMoveToPoint(pathRef, nil, 10.5, 21)
        CGPathAddCurveToPoint(pathRef, nil, 4.701, 21, 0, 16.299, 0, 10.5)
        CGPathAddCurveToPoint(pathRef, nil, 0, 4.701, 4.701, 0, 10.5, 0)
        CGPathAddCurveToPoint(pathRef, nil, 16.299, 0, 21, 4.701, 21, 10.5)
        CGPathAddCurveToPoint(pathRef, nil, 21, 16.299, 16.299, 21, 10.5, 21)
        CGPathCloseSubpath(pathRef)
        CGPathMoveToPoint(pathRef, nil, 10, 5)
        CGPathAddLineToPoint(pathRef, nil, 10, 10)
        CGPathAddLineToPoint(pathRef, nil, 5, 10)
        CGPathAddLineToPoint(pathRef, nil, 5, 11)
        CGPathAddLineToPoint(pathRef, nil, 10, 11)
        CGPathAddLineToPoint(pathRef, nil, 10, 16)
        CGPathAddLineToPoint(pathRef, nil, 11, 16)
        CGPathAddLineToPoint(pathRef, nil, 11, 11)
        CGPathAddLineToPoint(pathRef, nil, 16, 11)
        CGPathAddLineToPoint(pathRef, nil, 16, 10)
        CGPathAddLineToPoint(pathRef, nil, 11, 10)
        CGPathAddLineToPoint(pathRef, nil, 11, 5)
        CGPathCloseSubpath(pathRef)
        
        CGContextSetRGBFillColor(ctx, 0.004, 0.49, 1, 1)
        CGContextAddPath(ctx, pathRef)
        CGContextFillPath(ctx)
        

    
    }
    

}
