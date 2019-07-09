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
    
    @IBOutlet weak var bluePoint: UIButton!
    @IBOutlet weak var greenPoint: UIButton!
    @IBOutlet weak var yellowPoint: UIButton!
    @IBOutlet weak var pinkPoint: UIButton!
    @IBOutlet weak var orangePoint: UIButton!
    @IBOutlet weak var brownPoint: UIButton!
    @IBOutlet weak var redPoint: UIButton!
    @IBOutlet weak var blackWhitePoint: UIButton!
    @IBOutlet weak var erasePoint: UIButton!
    
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
        (red, green, blue) = (255, 138, 216)
        updateCustomization()
    }
    
    @IBAction func orange(_ sender: Any) {
        (red, green, blue) = (255, 147, 0)
        updateCustomization()
    }
    
    @IBAction func brown(_ sender: Any) {
        (red, green, blue) = (170, 121, 66)
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
        
        if let popoverController = activity.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        
        present(activity, animated: true, completion: nil)

    }
    
    @IBAction func reset(_ sender: Any) {
        
        
//        var textField = UITextField()
//        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//            print("cancel was called")
//        }
//        let addCategory = UIAlertAction(title: "Done", style: .default) { (action) in
//            let newCategory = Category()
//            newCategory.name = textField.text!
//            newCategory.color = UIColor.randomFlat.hexValue()
//            var maxNumber = 0
//
//            let categories = self.realm.objects(Category.self)
//            for (index, _) in categories.enumerated() {
//                if maxNumber < categories[index].order {
//                    maxNumber = categories[index].order
//                }
//
//                maxNumber += 1
//                newCategory.order = maxNumber
//            }
//
//            self.save(category: newCategory)
//            print("new category was saved")
//        }
//
//        addCategory.isEnabled = false
//        alert.addAction(cancel)
//        alert.addAction(addCategory)
//        alert.addTextField { (alertTextField) in
//            alertTextField.enablesReturnKeyAutomatically = true
//            alertTextField.returnKeyType = .done
//            alertTextField.placeholder = "Add new category"
//            textField = alertTextField
//
//            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alertTextField, queue: OperationQueue.main, using:
//                {_ in
//                    let textCount = alertTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
//                    let textIsNotEmpty = textCount > 0
//                    addCategory.isEnabled = textIsNotEmpty
//            })
//        }
        
        let alert = UIAlertController(title: "Recycle Masterpiece", message: "Do you want to recylce your masterpiece by starting a new canvas?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }
        
        let whiteCanvas = UIAlertAction(title: "Start new white canvas", style: .default) { _ in
            self.mainImage.image = nil
            self.canvasColor = UIColor.white
            self.mainImage.backgroundColor = UIColor.white
            //                blackWhitePoint.setImage(UIImage(named: "black.png"), for: .normal)
            self.blackWhitePoint.backgroundColor = UIColor.black
            (self.red, self.green, self.blue) = (0, 0, 0)
            self.pointCount.textColor = UIColor.black
            self.hud.backgroundColor = UIColor.white.withAlphaComponent(0.40)
            self.reset.backgroundColor = UIColor.white.withAlphaComponent(0.40)
            self.menuBackground.backgroundColor = UIColor.white.withAlphaComponent(0.40)
            self.pointSliderBackground.backgroundColor = UIColor.white.withAlphaComponent(0.40)
            self.suppliesMenuBackground.backgroundColor = UIColor.white.withAlphaComponent(0.40)
            
            self.opacity = 1.0
            self.updateCustomization()
        }
        
        let blackCanvas = UIAlertAction(title: "Start new black canvas", style: .default) { _ in
            self.mainImage.image = nil
            self.canvasColor = UIColor.black
            self.mainImage.backgroundColor = UIColor.black
            //                blackWhitePoint.setImage(UIImage(named: "white.png"), for: .normal)
            self.blackWhitePoint.backgroundColor = UIColor.white
            (self.red, self.green, self.blue) = (255, 255, 255)
            self.pointCount.textColor = UIColor.white
            self.hud.backgroundColor = UIColor.black.withAlphaComponent(0.40)
            self.reset.backgroundColor = UIColor.black.withAlphaComponent(0.40)
            self.menuBackground.backgroundColor = UIColor.black.withAlphaComponent(0.40)
            self.pointSliderBackground.backgroundColor = UIColor.black.withAlphaComponent(0.40)
            self.suppliesMenuBackground.backgroundColor = UIColor.black.withAlphaComponent(0.40)
            
            self.opacity = 1.0
            self.updateCustomization()
        }

        
        
        alert.addAction(cancel)
        alert.addAction(whiteCanvas)
        alert.addAction(blackCanvas)
        
        present(alert, animated: true, completion: nil)
        
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
        
//        if newCanvas {
//            if canvasColor == UIColor.white {
//                mainImage.image = nil
//                mainImage.backgroundColor = canvasColor
////                blackWhitePoint.setImage(UIImage(named: "black.png"), for: .normal)
//                blackWhitePoint.backgroundColor = UIColor.black
////                (red, green, blue) = (0, 0, 0)
//                pointCount.textColor = UIColor.black
//                hud.backgroundColor = UIColor.white.withAlphaComponent(0.40)
//                reset.backgroundColor = UIColor.white.withAlphaComponent(0.40)
//                menuBackground.backgroundColor = UIColor.white.withAlphaComponent(0.40)
//                pointSliderBackground.backgroundColor = UIColor.white.withAlphaComponent(0.40)
//                suppliesMenuBackground.backgroundColor = UIColor.white.withAlphaComponent(0.40)
//            } else {
//                mainImage.image = nil
//                mainImage.backgroundColor = canvasColor
////                blackWhitePoint.setImage(UIImage(named: "white.png"), for: .normal)
//                blackWhitePoint.backgroundColor = UIColor.white
////                (red, green, blue) = (255, 255, 255)
//                pointCount.textColor = UIColor.white
//                hud.backgroundColor = UIColor.black.withAlphaComponent(0.40)
//                reset.backgroundColor = UIColor.black.withAlphaComponent(0.40)
//                menuBackground.backgroundColor = UIColor.black.withAlphaComponent(0.40)
//                pointSliderBackground.backgroundColor = UIColor.black.withAlphaComponent(0.40)
//                suppliesMenuBackground.backgroundColor = UIColor.black.withAlphaComponent(0.40)
//
////                if (red, green, blue) == (0, 0, 0) {
////                    (red, green, blue) = (255, 255, 255)
////                }
//
//            }
//
//            newCanvas = false
//        }
        
//        let customBlue = UIColor.init(red: 71, green: 136, blue: 199, alpha: 1)
        
        hud.layer.cornerRadius = 20
        reset.layer.cornerRadius = 20
//        save.layer.cornerRadius = 15
        menuBackground.layer.cornerRadius = 10
        pointSliderBackground.layer.cornerRadius = 10
        suppliesMenuBackground.layer.cornerRadius = 10
        
        bluePoint.layer.cornerRadius = 10
        bluePoint.layer.borderColor = UIColor.clear.cgColor
        bluePoint.layer.borderWidth = 2
        greenPoint.layer.cornerRadius = 10
        greenPoint.layer.borderColor = UIColor.clear.cgColor
        greenPoint.layer.borderWidth = 2
        yellowPoint.layer.cornerRadius = 10
        yellowPoint.layer.borderColor = UIColor.clear.cgColor
        yellowPoint.layer.borderWidth = 2
        pinkPoint.layer.cornerRadius = 10
        pinkPoint.layer.borderColor = UIColor.clear.cgColor
        pinkPoint.layer.borderWidth = 2
        orangePoint.layer.cornerRadius = 10
        orangePoint.layer.borderColor = UIColor.clear.cgColor
        orangePoint.layer.borderWidth = 2
        brownPoint.layer.cornerRadius = 10
        brownPoint.layer.borderColor = UIColor.clear.cgColor
        brownPoint.layer.borderWidth = 2
        redPoint.layer.cornerRadius = 10
        redPoint.layer.borderColor = UIColor.clear.cgColor
        redPoint.layer.borderWidth = 2
        blackWhitePoint.layer.cornerRadius = 10
        blackWhitePoint.layer.borderColor = UIColor.clear.cgColor
        blackWhitePoint.layer.borderWidth = 2
        erasePoint.layer.cornerRadius = 10
        erasePoint.layer.borderColor = UIColor.clear.cgColor
        erasePoint.layer.borderWidth = 2
        
        
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
