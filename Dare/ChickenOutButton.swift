//
//  ChickenOutButton.swift
//  Dare
//
//  Created by Louis Olivas on 3/26/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//

import UIKit

class ChickenOutButton: UIButton {

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
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let scaleFactor: CGFloat = 1;
        // CGContextScaleCTM(ctx, scaleFactor, scaleFactor);
        
        /*  Shape   */
        let pathRef = CGPathCreateMutable()
        CGPathMoveToPoint(pathRef, nil, 272.008, 33.016)
        CGPathAddCurveToPoint(pathRef, nil, 272.008, 36.882, 268.836, 40.016, 264.921, 40.016)
        CGPathAddLineToPoint(pathRef, nil, 7.095, 40.016)
        CGPathAddCurveToPoint(pathRef, nil, 3.181, 40.016, 0.008, 36.882, 0.008, 33.016)
        CGPathAddLineToPoint(pathRef, nil, 0.008, 7.016)
        CGPathAddCurveToPoint(pathRef, nil, 0.008, 3.15, 3.181, 0.016, 7.095, 0.016)
        CGPathAddLineToPoint(pathRef, nil, 264.92, 0.016)
        CGPathAddCurveToPoint(pathRef, nil, 268.834, 0.016, 272.008, 3.15, 272.008, 7.016)
        CGPathAddLineToPoint(pathRef, nil, 272.008, 33.016)
        CGPathCloseSubpath(pathRef)
        
        CGContextSetRGBFillColor(ctx, 0.933, 0.294, 0.267, 1)
        CGContextAddPath(ctx, pathRef)
        CGContextFillPath(ctx)
        
        /*  Stroke Path  */
        let strokePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(strokePathRef, nil, 264.92, 0.016)
        CGPathAddCurveToPoint(strokePathRef, nil, 268.834, 0.016, 272.008, 3.15, 272.008, 7.016)
        CGPathAddLineToPoint(strokePathRef, nil, 272.008, 33.016)
        CGPathAddCurveToPoint(strokePathRef, nil, 272.008, 36.882, 268.836, 40.016, 264.921, 40.016)
        CGPathAddLineToPoint(strokePathRef, nil, 7.095, 40.016)
        CGPathAddCurveToPoint(strokePathRef, nil, 3.181, 40.016, 0.008, 36.882, 0.008, 33.016)
        CGPathAddLineToPoint(strokePathRef, nil, 0.008, 7.016)
        CGPathAddCurveToPoint(strokePathRef, nil, 0.008, 3.15, 3.181, 0.016, 7.095, 0.016)
        CGPathAddLineToPoint(strokePathRef, nil, 264.92, 0.016)
        CGPathCloseSubpath(strokePathRef)
        CGPathMoveToPoint(strokePathRef, nil, 264.92, 3.016)
        CGPathAddLineToPoint(strokePathRef, nil, 7.095, 3.016)
        CGPathAddCurveToPoint(strokePathRef, nil, 4.83, 3.016, 3.008, 4.815, 3.008, 7.016)
        CGPathAddLineToPoint(strokePathRef, nil, 3.008, 33.016)
        CGPathAddCurveToPoint(strokePathRef, nil, 3.008, 35.217, 4.83, 37.016, 7.095, 37.016)
        CGPathAddLineToPoint(strokePathRef, nil, 264.921, 37.016)
        CGPathAddCurveToPoint(strokePathRef, nil, 267.187, 37.016, 269.008, 35.217, 269.008, 33.016)
        CGPathAddLineToPoint(strokePathRef, nil, 269.008, 7.016)
        CGPathAddCurveToPoint(strokePathRef, nil, 269.008, 4.816, 267.186, 3.016, 264.92, 3.016)
        CGPathCloseSubpath(strokePathRef)
        
        CGContextSetRGBFillColor(ctx, 0.933, 0.294, 0.267, 1)
        CGContextAddPath(ctx, strokePathRef)
        CGContextFillPath(ctx)
        
        
        /*  Text   */
        let textBox = CGRect(x: 0.008, y: 2, width: 272, height: 38)
        let textStr: CFString = "Chicken out"
        
        let attributedStr = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
        CFAttributedStringReplaceString(attributedStr, CFRange(location: 0, length: 0), textStr)
        
        let fontRef = CTFontCreateWithName("BebasNeueBold", 30, nil)
        let textRange = CFRange(location: 0, length: CFAttributedStringGetLength(attributedStr))
        CFAttributedStringSetAttribute(attributedStr, textRange, kCTFontAttributeName, fontRef)
        
        let textColorComps: [CGFloat] = [0.988, 0.992, 0.992, 1]
        let textColor = CGColorCreate(colorSpace, textColorComps)
        CFAttributedStringSetAttribute(attributedStr, textRange, kCTForegroundColorAttributeName, textColor)
        
        var alignment = CTTextAlignment.TextAlignmentCenter
        var paragraphSettings = CTParagraphStyleSetting(spec: CTParagraphStyleSpecifier.Alignment, valueSize: UInt(sizeof(UInt8)), value: &alignment)
        let paragraphStyle = CTParagraphStyleCreate(&paragraphSettings, 1)
        CFAttributedStringSetAttribute(attributedStr, textRange, kCTParagraphStyleAttributeName, paragraphStyle)
        
        let textBoxPath = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: textBox.size.width, height: textBox.size.height), nil)
        let framesetter = CTFramesetterCreateWithAttributedString(attributedStr)
        let frameRef = CTFramesetterCreateFrame(framesetter, CFRange(location: 0, length: 0), textBoxPath, nil)
        CGContextSaveGState(ctx)
        CGContextTranslateCTM(ctx, textBox.origin.x, textBox.origin.y)
        
        CGContextSetTextMatrix(ctx, CGAffineTransformIdentity)
        CGContextTranslateCTM(ctx, 0.0, textBox.size.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        CTFrameDraw(frameRef, ctx)
        
        CGContextRestoreGState(ctx)

    }
    

}
