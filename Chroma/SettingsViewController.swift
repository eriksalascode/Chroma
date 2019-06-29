//
//  SettingsViewController.swift
//  DoodlePoints
//
//  Created by Erik Salas on 5/28/19.
//  Copyright © 2019 Erik Salas. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController)
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var pointImage: UIImageView!
    @IBOutlet weak var pointImageBackground: UIImageView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var pointSlider: UISlider!
    @IBOutlet weak var opacityLabel: UILabel!
    @IBOutlet weak var opacitySlider: UISlider!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var whiteCanvas: UIButton!
    @IBOutlet weak var blackCanvas: UIButton!
    
    @IBOutlet weak var pointCount: UILabel!
    @IBOutlet weak var opacityCount: UILabel!
    
    @IBOutlet weak var close: UIButton!
    
    var pointWidth: CGFloat = 17.0
    var opacity: CGFloat = 1.0
    var imageOpacity: CGFloat = 1.0

    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var canvasColor = UIColor.white
    var newCanvas = false
    
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.updateCustomization()
        self.updateSlidersAndLabels()
        

    }
    
    //call touch methods without any statements to prevent ability to draw from the settings viewcontroller
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.settingsViewControllerFinished(self)
    }
    
    @IBAction func pointSize(_ sender: Any) {
        pointWidth = CGFloat(round(pointSlider.value))
        pointCount.text = String(format: "%.0f", pointSlider.value)
        self.updateCustomization()
    }
    
    @IBAction func opacityChange(_ sender: Any) {
        opacity = CGFloat(opacitySlider.value)
        imageOpacity = opacity
        opacityCount.text = String(format: "%.2f", opacitySlider.value)
        
        if opacity == 1.0 {
            opacityCount.text = "1"
        } else if opacity == 0.0 {
            opacityCount.text = "0"
        }
        self.updateCustomization()
        
        print("\(opacity) opacity settings")
        print("\(imageOpacity) imageOpacity settings")
    }
    
    @IBAction func redColor(_ sender: Any) {
        red = CGFloat(redSlider.value / 255)
        redLabel.text = String(format: "Red: %.0f/255", redSlider.value)
        
        self.updateCustomization()
    }
    
    @IBAction func greenColor(_ sender: Any) {
        green = CGFloat(greenSlider.value / 255)
        greenLabel.text = String(format: "Green: %.0f/255", greenSlider.value)
        
        self.updateCustomization()
    }
    
    @IBAction func blueColor(_ sender: Any) {
        blue = CGFloat(blueSlider.value / 255)
        blueLabel.text = String(format: "Blue: %.0f/255", blueSlider.value)
        
        self.updateCustomization()
        self.updateSlidersAndLabels()
    }
    
    @IBAction func whiteCanvasButton(_ sender: Any) {
        canvasColor = UIColor.white
        newCanvas = true
        setWhiteCanvas()
    }
    
    @IBAction func blackCanvasButton(_ sender: Any) {
        canvasColor = UIColor.black
        newCanvas = true
        setBlackCanvas()
    }
    
    func updateCustomization() {
        UIGraphicsBeginImageContext(pointImage.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.setLineCap(.round)
        context.setLineWidth(pointWidth)
        context.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity)
        context.move(to: CGPoint(x: pointImage.frame.width / 2, y: pointImage.frame.height / 2))
        context.addLine(to: CGPoint(x: pointImage.frame.width / 2, y: pointImage.frame.height / 2))
        context.strokePath()
        pointImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
       
        close.layer.cornerRadius = 15
        whiteCanvas.layer.cornerRadius = 4
        whiteCanvas.layer.borderColor = UIColor.white.cgColor
        whiteCanvas.layer.borderWidth = 1
        blackCanvas.layer.cornerRadius = 4
        blackCanvas.layer.borderColor = UIColor.white.cgColor
        blackCanvas.layer.borderWidth = 1
        
        whiteCanvas.layer.shadowColor = UIColor.black.cgColor
        whiteCanvas.layer.shadowOffset = CGSize(width: 1, height: 1)
        whiteCanvas.layer.shadowOpacity = 1.0
        whiteCanvas.layer.shadowRadius = 0
        whiteCanvas.layer.masksToBounds = false
        blackCanvas.layer.shadowColor = UIColor.black.cgColor
        blackCanvas.layer.shadowOffset = CGSize(width: 1, height: 1)
        blackCanvas.layer.shadowOpacity = 1.0
        blackCanvas.layer.shadowRadius = 0
        blackCanvas.layer.masksToBounds = false
    }
    
    func updateSlidersAndLabels() {
        pointSlider.value = Float(pointWidth)
        pointCount.text = String(format: "%.0f", pointWidth)
        
        opacitySlider.value = Float(opacity)
        opacityCount.text = String(format: "%.2f", opacity)
        if opacity == 1.0 {
            opacityCount.text = "1"
        }
        
        redSlider.value = Float(red * 255)
        greenSlider.value = Float(green * 255)
        blueSlider.value = Float(blue * 255)
        
        redLabel.text = String(format: "Red: %.0f/255", redSlider.value)
        greenLabel.text = String(format: "Green: %.0f/255", greenSlider.value)
        blueLabel.text = String(format: "Blue: %.0f/255", blueSlider.value)

    }
    
    func setWhiteCanvas () {
        whiteCanvas.setTitleColor(UIColor.black, for: .normal)
        whiteCanvas.backgroundColor = UIColor.white
        blackCanvas.layer.borderColor = UIColor.white.cgColor
        blackCanvas.backgroundColor = UIColor.clear
    }
    
    func setBlackCanvas() {
        blackCanvas.backgroundColor = UIColor.black
        blackCanvas.layer.borderColor = UIColor.white.cgColor
        whiteCanvas.setTitleColor(UIColor.white, for: .normal)
        whiteCanvas.backgroundColor = UIColor.clear
    }
}
