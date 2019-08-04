//
//  Canvas.swift
//  Chroma
//
//  Created by Erik Salas on 8/1/19.
//  Copyright © 2019 Erik Salas. All rights reserved.
//
 

import UIKit

class Canvas: UIView {
    
    var path: UIBezierPath!
    var dot: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.darkGray
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var swiped = false
    var canvasRed: CGFloat = 0.0
    var canvasGreen: CGFloat = 0.0
    var canvasBlue: CGFloat = 0.0
    
    var canvasPointWidth: CGFloat = 0.0
    var canvasOpacity: CGFloat = 1.0
    var imageOpacity: CGFloat = 1.0
    var hideAll = false
    var hideSlider = true
    var hideSupplies = true
    
    var canvasLinesArray : [[CGPoint]] = [[CGPoint]]()//[[CGPoint(x: 1.1, y: 1.2), CGPoint(x: 1.1, y: 1.2), CGPoint(x: 1.1, y: 1.2)]]
    var indexed = 0
    var lastX : CGFloat = 0.0
    var lastY  : CGFloat = 0.0
    var currentX  : CGFloat = 0.0
    var currentY  : CGFloat = 0.0
    
    var canvasLastPoint = CGPoint.zero
    var canvasCurrentPoint = CGPoint.zero
    
    func undoFromCanvas() {
        _ = canvasLinesArray.popLast()
        setNeedsDisplay()
        print("undoing from class")
        
    }
    
    func clear() {
        canvasLinesArray.removeAll()
        setNeedsDisplay()
    }
    
    
//    var canvasLinesArray = [[CGPoint]]()
//    var count = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
//        drawLines(fromPoint: canvasLastPoint, toPoint: canvasCurrentPoint, pointWidth: canvasPointWidth, red: canvasRed, green: canvasGreen, blue: canvasBlue, opacity: canvasOpacity, lines: canvasLinesArray)

        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.move(to: canvasLastPoint)
        context.addLine(to: canvasCurrentPoint)
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(canvasPointWidth)
        context.setStrokeColor(red: canvasRed / 255, green: canvasGreen / 255, blue: canvasBlue / 255, alpha: 0.07)
        context.setBlendMode(CGBlendMode.normal)
        context.strokePath()
        
        
        
        setNeedsDisplay()
        
        print("drawing from class")
        
        path = UIBezierPath()
        dot = UIBezierPath()
        
        dot.lineWidth = 20.0
        path.flatness = 0
        path.lineCapStyle = .round
        path.miterLimit = 0
        
        path.lineWidth = 20.0
        path.flatness = 0
        path.lineCapStyle = .round
        path.miterLimit = 0
        
        canvasLinesArray.forEach { (line) in
            for (last, c) in line.enumerated() {
                
                if last == 0 && line.count == 1 {
                    dot.fill()
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!fill")
                }

                if last == 0 {
                    path.move(to: c)
                    print("move")
                    path.addLine(to: c)
                    print("add line")
                }

                if last == 0 {
                    path.move(to: c)
                } else {
                    path.addLine(to: c)
                }
                print("drawing from class")
                //print(i, p)
            }
            
//            for (last, c) in line.enumerated() {
//                
//                if last == 0 {
//                    context.move(to: canvasLastPoint)
//                    
//                    context.addLine(to: canvasLastPoint)
//                }
//                
//                if last == 0 {
//                    context.move(to: canvasLastPoint)
//                } else {
//                    context.addLine(to: canvasCurrentPoint)
//                }
//                print("drawing from class")
//                //print(i, p)
//            }
        }

        context.strokePath()
        path.stroke()
    }
    
//    func drawLines(fromPoint: CGPoint, toPoint: CGPoint, pointWidth: CGFloat, red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat, lines: [[CGPoint]]) {
//
//        print("setting class up")
//
//        canvasLastPoint = fromPoint
//        canvasCurrentPoint = toPoint
//        canvasPointWidth = pointWidth
//        canvasRed = red
//        canvasGreen = green
//        canvasBlue = blue
//        canvasOpacity = opacity
//        canvasLinesArray = lines
//

//        guard let context = UIGraphicsGetCurrentContext() else {return}
//
////        context.setStrokeColor(UIColor.blue.cgColor)
////        context.setLineWidth(20)
////        context.setLineCap(.round)
//
////        UIGraphicsBeginImageContext(self.view.frame.size)
////        guard let context = UIGraphicsGetCurrentContext() else { return }
////        tempImage.image?.draw(in: self.view.bounds)
//        context.move(to: fromPoint)
//        context.addLine(to: toPoint)
//        context.setLineCap(CGLineCap.round)
//        context.setLineWidth(pointWidth)
//        context.setStrokeColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: opacity)
//        context.setBlendMode(CGBlendMode.normal)
//        context.strokePath()
////        tempImage.image = UIGraphicsGetImageFromCurrentImageContext()
////        tempImage.alpha = opacity
////        UIGraphicsEndImageContext()

//    }
    
    
    //detecting when user begins to draw
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        guard let touch = touches.first?.location(in: nil) else { return }
        //        lastPoint = touch.location(in: self.view)
        
        canvasLinesArray.append([CGPoint]())
        
        guard var lastLine = canvasLinesArray.popLast() else {return}
        lastLine.append(touch)
        canvasLinesArray.append(lastLine)
        print("line started")
    }
    
    
    //detecting when user draws
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        guard let touch = touches.first?.location(in: nil) else { return }
        //        let currentPoint = touch.location(in: view)
        for (indexed, points) in canvasLinesArray.enumerated() {
            for (index, point) in points.enumerated() {
                lastX = point.x
                lastY = point.y
            }
            //You now have just the y coordinate of each point in the array.
            
            //            print(point.y) //Prints y coordinate of each point.
        }
        
        guard var lastLine = canvasLinesArray.popLast() else {return}
        lastLine.append(touch)
        canvasLinesArray.append(lastLine)
        
        for (indexed, points) in canvasLinesArray.enumerated() {
            for (index, point) in points.enumerated() {
                currentX = point.x
                currentY = point.y
            }
            //You now have just the y coordinate of each point in the array.
            
            //            print(point.y) //Prints y coordinate of each point.
        }
        
        canvasLastPoint = CGPoint(x: lastX, y: lastY)
        canvasCurrentPoint = CGPoint(x: currentX, y: currentY)
        
        
        
        
        
        // if the user is using opacity
//        if opacity != 1 {
//            drawLineWithOpacity(from: lastPoint, to: currentPoint, image: tempImage, pointWidth: pointWidth, red: red, green: green, blue: blue, opacity: 1, imageOpacity: imageOpacity)
//            // if the user is using the eraser, draw the eraser with no opacity
//            if (red, green, blue) == (255, 255, 255) {
//                drawLineWithOpacity(from: lastPoint, to: currentPoint, image: tempImage, pointWidth: pointWidth, red: red, green: green, blue: blue, opacity: 1, imageOpacity: 1)
//            }
//            // if the user is not using opacity
//        } else {
//            drawLine(fromPoint: lastPoint, toPoint: currentPoint)
//        }
        
        canvasLastPoint = canvasCurrentPoint
        
        print("line moving")
//        drawView.setNeedsDisplay()
        setNeedsDisplay()
        
        
    }
    
    //detecting when user ends drawing
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if the user lifted their finger off the screen, stop drawing the line
        if !swiped {
//            if opacity != 1 {
//                drawLineWithOpacity(from: lastPoint, to: lastPoint, image: tempImage, pointWidth: pointWidth, red: red, green: green, blue: blue, opacity: 1, imageOpacity: imageOpacity)
//            } else {
//                drawLine(fromPoint: lastPoint, toPoint: lastPoint)
//            }
            
//            drawLine(fromPoint: lastPoint, toPoint: lastPoint)
            
            indexed += 1
        }
        // if using the eraser
//        if opacity != 1 && (red, green, blue) == (255, 255, 255) {
//            imageWhenTouchesEnded(withOpacity: 1.0)
//            // if using opacity
//        } else if opacity != 1 {
//            imageWhenTouchesEnded(withOpacity: imageOpacity)
//            // if not using opacity
//        } else {
//            imageWhenTouchesEnded(withOpacity: opacity)
//        }
        
        print("line ended")
        setNeedsDisplay()
        
    }
}

