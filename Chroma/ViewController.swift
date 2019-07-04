//
//  ViewController.swift
//  DoodlePoints
//
//  Created by Erik Salas on 5/23/19.
//  Copyright © 2019 Erik Salas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var hud: UIButton!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var menuBackground: UIView!
    @IBOutlet weak var point: UIButton!
    @IBOutlet weak var size: UIButton!
    
    @IBOutlet weak var pointSliderBackground: UIView!
    @IBOutlet weak var suppliesMenuBackground: UIView!
    @IBOutlet weak var menuStack: UIStackView!
    @IBOutlet weak var pointSliderStack: UIStackView!
    @IBOutlet weak var suppliesMenuStack: UIStackView!
    
    
    @IBOutlet weak var pointImageBackground: UIImageView!
    @IBOutlet weak var pointImage: UIImageView!

    @IBOutlet weak var pointSlider: UISlider!
    @IBOutlet weak var pointCount: UILabel!
    @IBOutlet weak var blackWhite: UIButton!
    
    var swiped = false
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var pointWidth: CGFloat = 17.0
    var opacity: CGFloat = 1.0
    var imageOpacity: CGFloat = 1.0
    var hideAll = false
    var hideSlider = true
    var hideSupplies = true
    var canvasColor = UIColor.white
    var newCanvas = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointSliderBackground.isHidden = true
        pointSliderStack.isHidden = true
        suppliesMenuBackground.isHidden = true
        suppliesMenuStack.isHidden = true
        updateCustomization()
    
    }
    
   
    @IBAction func blue(_ sender: Any) {
        (red, green, blue) = (0, 0, 255)
        updateCustomization()
    }
    
    @IBAction func green(_ sender: Any) {
        (red, green, blue) = (0, 128, 0)
        updateCustomization()
    }
    
    @IBAction func yellow(_ sender: Any) {
        (red, green, blue) = (255, 255, 0)
        updateCustomization()
    }
    
    @IBAction func pink(_ sender: Any) {
        (red, green, blue) = (255,192,203)
        updateCustomization()
    }
    
    @IBAction func orange(_ sender: Any) {
        (red, green, blue) = (255, 140, 0)
        updateCustomization()
    }
    
    @IBAction func brown(_ sender: Any) {
        (red, green, blue) = (139, 69, 19)
        updateCustomization()
    }
    
    @IBAction func red(_ sender: Any) {
        (red, green, blue) = (255, 0, 0)
        updateCustomization()
    }
    
    @IBAction func blackWhite(_ sender: Any) {
        if canvasColor == UIColor.white {
            (red, green, blue) = (0, 0, 0)
        } else if canvasColor == UIColor.black {
            (red, green, blue) = (255, 255, 255)
        }
        updateCustomization()
    }
    
    @IBAction func sizeSlider(_ sender: Any) {
        pointWidth = CGFloat(round(pointSlider.value))
        pointCount.text = String(format: "%.0f", pointSlider.value)
        updateCustomization()
    }
    
    
    @IBAction func erase(_ sender: Any) {
        if canvasColor == UIColor.white {
            (red, green, blue) = (255, 255, 255)
        } else if canvasColor == UIColor.black {
            (red, green, blue) = (0, 0, 0)
        }
        print("erasing?")
        updateCustomization()
    }
    
    @IBAction func pointChoice(_ sender: UIButton) {
        
        if sender == point {
            hideSupplies = !hideSupplies
            if hideSupplies {
                suppliesMenuBackground.isHidden = true
                suppliesMenuStack.isHidden = true
            } else {
                suppliesMenuBackground.isHidden = false
                suppliesMenuStack.isHidden = false
                pointSliderBackground.isHidden = true
                pointSliderStack.isHidden = true
                hideSlider = true
            }
        }
        
        if sender == size {
            hideSlider = !hideSlider
            if hideSlider {
                pointSliderBackground.isHidden = true
                pointSliderStack.isHidden = true
            } else {
                pointSliderBackground.isHidden = false
                pointSliderStack.isHidden = false
                suppliesMenuBackground.isHidden = true
                suppliesMenuStack.isHidden = true
                hideSupplies = true
                pointSliderStack.superview?.bringSubviewToFront(pointSliderStack)
            }
        }
    }
    
    @IBAction func save(_ sender: Any) {
        UIGraphicsBeginImageContext(mainImage.bounds.size)
        mainImage.image?.draw(in: CGRect(x: 0, y: 0, width: mainImage.frame.size.width, height: mainImage.frame.size.height))
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        present(activity, animated: true, completion: nil)
    }
    
    @IBAction func reset(_ sender: Any) {
        mainImage.image = nil
    }
    
    @IBAction func hud(_ sender: Any) {
        hideAll = !hideAll
        if hideAll {
            hud.setImage(UIImage(named: "menu.png"), for: .normal)
            reset.isHidden = true
            menuBackground.isHidden = true
            menuStack.isHidden = true
            pointSliderBackground.isHidden = true
            pointSliderStack.isHidden = true
            suppliesMenuBackground.isHidden = true
            suppliesMenuStack.isHidden = true
            pointImageBackground.isHidden = true
            pointImage.isHidden = true
            hideSupplies = true
            hideSlider = true
//            save.isHidden = true
        } else {
            hud.setImage(UIImage(named: "close.png"), for: .normal)
            reset.isHidden = false
            menuBackground.isHidden = false
            menuStack.isHidden = false
//            pointSliderBackground.isHidden = false
//            pointSliderStack.isHidden = false
//            suppliesMenuBackground.isHidden = false
//            suppliesMenuStack.isHidden = false
            pointImageBackground.isHidden = false
            pointImage.isHidden = false
//            save.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        guard let touch = touches.first else { return }
        lastPoint = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        guard let touch = touches.first as UITouch? else { return }
        let currentPoint = touch.location(in: view)
        
        // if the user is using opacity
        if opacity != 1 {
            drawLineWithOpacity(from: lastPoint, to: currentPoint, image: tempImage, pointWidth: pointWidth, red: red, green: green, blue: blue, opacity: 1, imageOpacity: imageOpacity)
            // if the user is using the white eraser, draw the eraser with no opacity
            if (red, green, blue) == (255, 255, 255) && canvasColor == UIColor.white {
                drawLineWithOpacity(from: lastPoint, to: currentPoint, image: tempImage, pointWidth: pointWidth, red: red, green: green, blue: blue, opacity: 1, imageOpacity: 1)
                // if the user is using the black eraser, draw the eraser with no opacity
            } else if (red, green, blue) == (0, 0, 0) && canvasColor == UIColor.black {
                drawLineWithOpacity(from: lastPoint, to: currentPoint, image: tempImage, pointWidth: pointWidth, red: red, green: green, blue: blue, opacity: 1, imageOpacity: 1)
            }
            // if the user is not using opacity
        } else {
            drawLine(fromPoint: lastPoint, toPoint: currentPoint)
        }
        
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if the user lifted their finger off the screen, stop drawing the line
        if !swiped {
            if opacity != 1 {
                drawLineWithOpacity(from: lastPoint, to: lastPoint, image: tempImage, pointWidth: pointWidth, red: red, green: green, blue: blue, opacity: 1, imageOpacity: imageOpacity)
            } else {
                drawLine(fromPoint: lastPoint, toPoint: lastPoint)
            }
        }
        
        // if using the white eraser
        if opacity != 1 && (red, green, blue) == (255, 255, 255) && canvasColor == UIColor.white {
            imageWhenTouchesEnded(withOpacity: 1.0)
        // if using the black eraser
        } else if opacity != 1 && (red, green, blue) == (0, 0, 0) && canvasColor == UIColor.black {
            imageWhenTouchesEnded(withOpacity: 1.0)
        // if using opacity
        } else if opacity != 1 {
            imageWhenTouchesEnded(withOpacity: imageOpacity)
        // if not using opacity
        } else {
            imageWhenTouchesEnded(withOpacity: opacity)
        }
    }
    
    //drawing line without opacity
    func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        tempImage.image?.draw(in: self.view.bounds)
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(pointWidth)
        context.setStrokeColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: opacity)
        context.setBlendMode(CGBlendMode.normal)
        context.strokePath()
        tempImage.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImage.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    //drawing line with opacity
    func drawLineWithOpacity(from fromPoint: CGPoint, to toPoint: CGPoint, image: UIImageView, pointWidth: CGFloat, red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat, imageOpacity: CGFloat) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        image.image?.draw(in: self.view.bounds)
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(pointWidth)
        context.setStrokeColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: opacity)
        context.setBlendMode(CGBlendMode.normal)
        context.strokePath()
        image.image = UIGraphicsGetImageFromCurrentImageContext()
        image.alpha = imageOpacity
        UIGraphicsEndImageContext()
    }
    
    func imageWhenTouchesEnded(withOpacity: CGFloat) {
        UIGraphicsBeginImageContext(tempImage.frame.size)
        mainImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        tempImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: withOpacity)
        mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tempImage.image = nil
    }
    
    // update view
    func updateCustomization() {
        UIGraphicsBeginImageContext(pointImage.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.setLineCap(.round)
        context.setLineWidth(pointWidth)
        if (red, green, blue) == (255, 255, 255) && canvasColor == UIColor.white {
            context.setStrokeColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
        } else if (red, green, blue) == (0, 0, 0) && canvasColor == UIColor.black {
            context.setStrokeColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
        } else {
            context.setStrokeColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: opacity)
        }
        context.move(to: CGPoint(x: pointImage.frame.width / 2, y: pointImage.frame.height / 2))
        context.addLine(to: CGPoint(x: pointImage.frame.width / 2, y: pointImage.frame.height / 2))
        context.strokePath()
        pointImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        pointSlider.value = Float(pointWidth)
        pointCount.text = String(format: "%.0f", pointWidth)
//        print("\(opacity) opacity viewcontroller")
//        print("\(imageOpacity) imageOpacity viewcontroller")
        
        if newCanvas {
            if canvasColor == UIColor.white {
                mainImage.image = nil
                mainImage.backgroundColor = canvasColor
                blackWhite.setImage(UIImage(named: "black.png"), for: .normal)
                pointCount.textColor = UIColor.black
                menuBackground.backgroundColor = UIColor.white.withAlphaComponent(0.40)
                pointSliderBackground.backgroundColor = UIColor.white.withAlphaComponent(0.40)
                suppliesMenuBackground.backgroundColor = UIColor.white.withAlphaComponent(0.40)
            } else {
                mainImage.image = nil
                mainImage.backgroundColor = canvasColor
                blackWhite.setImage(UIImage(named: "white.png"), for: .normal)
                pointCount.textColor = UIColor.white
                menuBackground.backgroundColor = UIColor.black.withAlphaComponent(0.40)
                pointSliderBackground.backgroundColor = UIColor.black.withAlphaComponent(0.40)
                suppliesMenuBackground.backgroundColor = UIColor.black.withAlphaComponent(0.40)

            }
            
            newCanvas = false
        }
        
        hud.layer.cornerRadius = 15
        reset.layer.cornerRadius = 15
        save.layer.cornerRadius = 15
        menuBackground.layer.cornerRadius = 10
        pointSliderBackground.layer.cornerRadius = 10
        suppliesMenuBackground.layer.cornerRadius = 10
///////////        utilities.layer.cornerRadius = 4
//        whiteCanvas.layer.borderColor = UIColor.white.cgColor
//        whiteCanvas.layer.borderWidth = 1
//        blackCanvas.layer.cornerRadius = 2
//        blackCanvas.layer.borderColor = UIColor.black.cgColor
//        blackCanvas.layer.borderWidth = 1
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SettingsViewController
        destinationVC.delegate = self
        destinationVC.pointWidth = pointWidth
        destinationVC.red = red / 255
        destinationVC.blue = blue / 255
        destinationVC.green = green / 255
        destinationVC.opacity = opacity
        destinationVC.imageOpacity = imageOpacity
        destinationVC.canvasColor = canvasColor
        destinationVC.newCanvas = newCanvas
    }
}

extension ViewController: SettingsViewControllerDelegate {
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController) {
        pointWidth = settingsViewController.pointWidth
        canvasColor = settingsViewController.canvasColor
        newCanvas = settingsViewController.newCanvas
        red = settingsViewController.red * 255
        blue = settingsViewController.blue * 255
        green = settingsViewController.green * 255
        opacity = settingsViewController.opacity
        imageOpacity = settingsViewController.imageOpacity
        pointSlider.value = Float(pointWidth)
        updateCustomization()
    }
}
