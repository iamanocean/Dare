//
//  DareSubtractButton.swift
//  Dare
//
//  Created by Louis Olivas on 3/26/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class DareSubtractButton: UIButton {

    
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
        CGPathMoveToPoint(pathRef, nil, 10.512, 21.012)
        CGPathAddCurveToPoint(pathRef, nil, 4.713, 21.012, 0.012, 16.311, 0.012, 10.512)
        CGPathAddCurveToPoint(pathRef, nil, 0.012, 4.713, 4.713, 0.012, 10.512, 0.012)
        CGPathAddCurveToPoint(pathRef, nil, 16.311, 0.012, 21.012, 4.713, 21.012, 10.512)
        CGPathAddCurveToPoint(pathRef, nil, 21.012, 16.311, 16.311, 21.012, 10.512, 21.012)
        CGPathCloseSubpath(pathRef)
        CGPathMoveToPoint(pathRef, nil, 5.012, 11.012)
        CGPathAddLineToPoint(pathRef, nil, 16.012, 11.012)
        CGPathAddLineToPoint(pathRef, nil, 16.012, 10.012)
        CGPathAddLineToPoint(pathRef, nil, 5.012, 10.012)
        CGPathCloseSubpath(pathRef)
        
        CGContextSetRGBFillColor(ctx, 0.933, 0.296, 0.267, 1)
        CGContextAddPath(ctx, pathRef)
        CGContextFillPath(ctx)
    }


}
