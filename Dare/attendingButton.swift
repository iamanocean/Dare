//
//  attendingButton.swift
//  Dare
//
//  Created by Matthias Sainz on 4/18/15.
//  Copyright (c) 2015 Louis Olivas. All rights reserved.
//


import UIKit

class AttendingButton: UIButton {

    
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
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let scaleFactor: CGFloat = 1;
        // CGContextScaleCTM(ctx, scaleFactor, scaleFactor);
        
        /*  Shape   */
        let pathRef = CGPathCreateMutable()
        CGPathMoveToPoint(pathRef, nil, 272, 33)
        CGPathAddCurveToPoint(pathRef, nil, 272, 36.866, 268.828, 40, 264.913, 40)
        CGPathAddLineToPoint(pathRef, nil, 7.087, 40)
        CGPathAddCurveToPoint(pathRef, nil, 3.173, 40, -0, 36.866, -0, 33)
        CGPathAddLineToPoint(pathRef, nil, -0, 7)
        CGPathAddCurveToPoint(pathRef, nil, -0, 3.134, 3.173, 0, 7.087, 0)
        CGPathAddLineToPoint(pathRef, nil, 264.912, 0)
        CGPathAddCurveToPoint(pathRef, nil, 268.826, 0, 272, 3.134, 272, 7)
        CGPathAddLineToPoint(pathRef, nil, 272, 33)
        CGPathCloseSubpath(pathRef)
        
        CGContextSetRGBFillColor(ctx, 0.298, 0.847, 0.392, 1)
        CGContextAddPath(ctx, pathRef)
        CGContextFillPath(ctx)
        
        /*  Stroke Path  */
        let strokePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(strokePathRef, nil, 264.912, 0)
        CGPathAddCurveToPoint(strokePathRef, nil, 268.826, 0, 272, 3.134, 272, 7)
        CGPathAddLineToPoint(strokePathRef, nil, 272, 33)
        CGPathAddCurveToPoint(strokePathRef, nil, 272, 36.866, 268.828, 40, 264.913, 40)
        CGPathAddLineToPoint(strokePathRef, nil, 7.087, 40)
        CGPathAddCurveToPoint(strokePathRef, nil, 3.173, 40, -0, 36.866, -0, 33)
        CGPathAddLineToPoint(strokePathRef, nil, 0, 7)
        CGPathAddCurveToPoint(strokePathRef, nil, -0, 3.134, 3.173, 0, 7.087, 0)
        CGPathAddLineToPoint(strokePathRef, nil, 264.912, 0)
        CGPathCloseSubpath(strokePathRef)
        CGPathMoveToPoint(strokePathRef, nil, 264.912, 3)
        CGPathAddLineToPoint(strokePathRef, nil, 7.087, 3)
        CGPathAddCurveToPoint(strokePathRef, nil, 4.822, 3, 3, 4.799, 3, 7)
        CGPathAddLineToPoint(strokePathRef, nil, 3, 33)
        CGPathAddCurveToPoint(strokePathRef, nil, 3, 35.201, 4.822, 37, 7.087, 37)
        CGPathAddLineToPoint(strokePathRef, nil, 264.913, 37)
        CGPathAddCurveToPoint(strokePathRef, nil, 267.179, 37, 269, 35.201, 269, 33)
        CGPathAddLineToPoint(strokePathRef, nil, 269, 7)
        CGPathAddCurveToPoint(strokePathRef, nil, 269, 4.8, 267.178, 3, 264.912, 3)
        CGPathCloseSubpath(strokePathRef)
        
        CGContextSetRGBFillColor(ctx, 0.298, 0.847, 0.392, 1)
        CGContextAddPath(ctx, strokePathRef)
        CGContextFillPath(ctx)
        
        
        /*  Text   */
        let textBox = CGRect(x: -0, y: 1.984, width: 272, height: 38)
        let textStr: CFString = "Attending"
        
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
