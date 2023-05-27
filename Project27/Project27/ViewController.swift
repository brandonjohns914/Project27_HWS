//
//  ViewController.swift
//  Project27
//
//  Created by Brandon Johns on 5/26/23.
//

import UIKit
import CoreGraphics


class ViewController: UIViewController
{

    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        drawRectangle()
    }//viewDidLoad

    @IBAction func redrawTapped(_ sender: Any)
    {
        currentDrawType += 1
        
        if currentDrawType > 5
        {
            currentDrawType = 0
        }//if
        
        
        
        switch currentDrawType
        {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
            
        case 2:
            drawCheckerboard()
            
        case 3:
            drawRotatedSquares()
            
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
            
        default:
            break
        }//switch
        
        
    }//redraw
    
    func drawRectangle()
    {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let image = renderer.image
        { ctx in                                                                                        //ctx = UIGraphicsImageRendererContext
                                                                                                        //where drawing code lives
            let rectangle = CGRect(x: 0, y: 0, width:  512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)                                                              //10 point boarder around rectangle
                                                                                                        //5 points inside and outside
                                                                                                        // because 512 it will miss 5 points on the outside
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        imageView.image = image                                                                         // setting the drawn image to the imageView
    }//drawRectangle
    func drawCircle()
    {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let image = renderer.image
        { ctx in                                                                                        //ctx = UIGraphicsImageRendererContext
                                                                                                        //where drawing code lives
            let rectangle = CGRect(x: 0, y: 0, width:  512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)                                                              //10 point boarder around rectangle
                                                                                                        //5 points inside and outside
                                                                                                        // because 512 it will miss 5 points on the outside
            ctx.cgContext.addEllipse(in: rectangle)                                                     //draws the circle in the rectangle
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        imageView.image = image                                                                         // setting the drawn image to the imageView
    }//drawCircle
    
    func drawCheckerboard()
    {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let image = renderer.image
        { ctx in                                                                                        //ctx = UIGraphicsImageRendererContext
                                                                                                        //where drawing code lives
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8
            {
                for col in 0..<8
                {
                    if (row + col).isMultiple(of: 2)
                    {
                        ctx.cgContext.fill(CGRect(x: col * 64 , y: row * 64, width: 64, height: 64))
                    }//if
                }//col
            }//row
            
        }//image
        imageView.image = image                                                                         // setting the drawn image to the imageView
    }//drawCheckerboard
    
    func drawRotatedSquares()
    {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let image = renderer.image
        { ctx in                                                                                        //ctx = UIGraphicsImageRendererContext
            ctx.cgContext.translateBy(x: 256, y: 256)
            let rotations = 16
            let amount = Double.pi / Double(rotations)                                                  //rotate by pi/16
            
            for _ in 0..<rotations
            {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))                // back and left because drawing from center
                
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)                                     //default line = 1
            ctx.cgContext.strokePath()
            
        }//image
        imageView.image = image
    }//drawRotatedSquares
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image
        { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)

            var first = true                                                                //first line
            var length: CGFloat = 256

            for _ in 0 ..< 256                                                              //256 lines
            {
                ctx.cgContext.rotate(by: .pi / 2)

                if first
                {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))                      //moves to first position
                    first = false
                }//first
                else
                {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))                        //255 lines
                }//else

                length *= 0.99
            }//for

            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }//image

        imageView.image = image
    }//drawLines
    
    func drawImagesAndText() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        let image = renderer.image
        { ctx in
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center                                                          //center line text

            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle ]                                                   //paragraph style and size 36

            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)                    //creating the string and attr

            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)

            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }//image

      
        imageView.image = image
    }//drawImageAndText
}

