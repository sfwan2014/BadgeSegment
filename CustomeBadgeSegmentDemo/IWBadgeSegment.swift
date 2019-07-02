//
//  IWBadgeSegment.swift
//  BmaxWallet
//
//  Created by tezwez on 2019/7/1.
//  Copyright © 2019 lx. All rights reserved.
//

import UIKit


class IWBadgeSegment: UIControl {

    enum SGContentType: Int {
        case Left
        case Right
        case Body
        case All
    }
    
    private var borderWidth: CGFloat = 1.0
    private var itemWidth: CGFloat = 0
    private var badgeRadius: CGFloat = 14/2.0
    var badgeFont = UIFont.systemFont(ofSize: 10) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    var contentInset: UIEdgeInsets = UIEdgeInsets.init(top: 4, left: 0, bottom: 0, right: 0) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    var badges: [Int]? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var titleFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    var selectedTitleColor: UIColor = UIColor.white {
        didSet{
            self.setNeedsDisplay()
        }
    }
    var normalTitleColor: UIColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.setNeedsDisplay()
        }
    }
    
    var currentIndex: Int = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    var segmentTitles: [String]? {
        didSet {
            badges = [Int].init(repeating: 0, count: segmentTitles?.count ?? 0)
            self.setNeedsDisplay()
        }
    }
    
    convenience init(frame: CGRect, segmentTitles: [String]!) {
        self.init(frame: frame)
        self.segmentTitles = segmentTitles
        self._init()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self._init()
        
//        self.backgroundColor = UIColor.yellow
    }
    
    private func _init(){
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.tintColor = self.normalTitleColor
        
    }
    
    override func draw(_ rect: CGRect) {
        
//        var offsetX: CGFloat = 0
        let count = segmentTitles?.count ?? 0
        let width = (self.frame.size.width-CGFloat(count+1)*borderWidth)/CGFloat(count)
        itemWidth = width
        let height = self.frame.size.height - contentInset.top - contentInset.bottom-borderWidth*2;
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setLineWidth(borderWidth)
        let frame = CGRect.init(x: rect.origin.x+contentInset.left, y: rect.origin.y+contentInset.top, width: rect.size.width-contentInset.left-contentInset.right, height: rect.size.height - contentInset.top - contentInset.bottom)
        self.stroke(context: context,rect: frame, itemCount: count, itemWidth: width)

        for index in 0..<count {
            let title = segmentTitles?[index]
            
            var type = SGContentType.Left
            if index == 0 {
                if index == count - 1{
                    type = SGContentType.All
                }
            } else {
                if index == count - 1{
                    type = SGContentType.Right
                } else {
                    type = SGContentType.Body
                }
            }
            
            let frame = CGRect.init(x:contentInset.left + borderWidth * CGFloat(index+1) + width * CGFloat(index), y: contentInset.top+borderWidth, width: width, height: height)
            
            
            if index == currentIndex {
                self.fillRect(rect: frame, context: context, type: type, isSelected: true)
                
                self.drawText(title, rect: frame, context: context, isSelected: true)
            } else {
                self.fillRect(rect: frame, context: context, type: type, isSelected: false)
                
                self.drawText(title, rect: frame, context: context, isSelected: false)
            }
            
            self.draw(badge: badges![index], rect: frame, context: context)
            
        }
        
    }
    
    private func stroke(context: CGContext, rect frect: CGRect, itemCount: Int, itemWidth: CGFloat){
        context.saveGState()
        context.setStrokeColor(self.tintColor.cgColor)
        context.setLineWidth(borderWidth)
        
        let rect = CGRect.init(x:frect.origin.x, y: frect.origin.y, width: frect.size.width, height: frect.size.height)
        // 上 -------
        context.move(to: CGPoint.init(x:rect.origin.x + cornerRadius+borderWidth/2.0, y: rect.origin.y+borderWidth/2.0))
        context.addLine(to: CGPoint.init(x:rect.origin.x + rect.size.width - cornerRadius - borderWidth/2.0, y: rect.origin.y+borderWidth/2.0))
        
        // 右上圆角
        context.addArc(center: CGPoint.init(x:rect.origin.x + rect.size.width - cornerRadius - borderWidth/2.0, y: rect.origin.y+cornerRadius+borderWidth/2.0), radius: cornerRadius, startAngle: CGFloat(Double.pi/2.0)*3, endAngle: CGFloat(Double.pi*2), clockwise: false)
        
        // 右边
        context.addLine(to: CGPoint.init(x:rect.origin.x + rect.size.width - borderWidth/2.0, y: rect.origin.y + rect.size.height - cornerRadius - borderWidth/2.0))
        
        // 右下圆角
        context.addArc(center: CGPoint.init(x:rect.origin.x + rect.size.width - cornerRadius - borderWidth/2.0, y: rect.origin.y + rect.size.height-cornerRadius-borderWidth/2.0), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2.0), clockwise: false)
        
        // 下
        context.addLine(to: CGPoint.init(x: rect.origin.x + cornerRadius+borderWidth/2.0, y: rect.origin.y + rect.size.height - borderWidth/2.0))
        
        // 左下圆角
        context.addArc(center: CGPoint.init(x: rect.origin.x + cornerRadius+borderWidth/2.0, y: rect.origin.y + rect.size.height-cornerRadius - borderWidth/2.0), radius: cornerRadius, startAngle: CGFloat(Double.pi/2.0), endAngle: CGFloat(Double.pi), clockwise: false)
        
        // 左
        context.addLine(to: CGPoint.init(x: rect.origin.x+borderWidth/2.0, y: rect.origin.y + cornerRadius+borderWidth/2.0))
        
        // 左上圆角
        context.addArc(center: CGPoint.init(x: rect.origin.x + cornerRadius+borderWidth/2.0, y: rect.origin.y+cornerRadius+borderWidth/2.0), radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi/2.0*3), clockwise: false)
        
        context.strokePath()
//        context.restoreGState()
        
//        context.saveGState()
//        context.setStrokeColor(self.tintColor.cgColor)
//        context.setLineWidth(0.5)
        
        for index in 0..<itemCount {
            if index == 0 {
                continue
            }
            
            context.move(to: CGPoint.init(x:rect.origin.x + borderWidth/2.0 + borderWidth * CGFloat(index) + itemWidth * CGFloat(index), y: rect.origin.y+borderWidth/2.0))
            context.addLine(to: CGPoint.init(x:rect.origin.x + borderWidth/2.0 + borderWidth * CGFloat(index) + itemWidth * CGFloat(index), y: rect.origin.y + rect.size.height-borderWidth/2.0))
            context.strokePath()
        }
        
        context.restoreGState()
    }
    
    private func fillRect(rect: CGRect!, context: CGContext, type: SGContentType, isSelected: Bool){
        context.saveGState()
        if isSelected {
            context.setFillColor(self.tintColor.cgColor)
//            context.setFillColor(UIColor.blue.cgColor)
        } else {
            context.setFillColor(UIColor.clear.cgColor)
        }
        
        let cornerRadius = self.cornerRadius
        // 上 -------
        context.move(to: CGPoint.init(x: rect.origin.x + cornerRadius, y: rect.origin.y))
        context.addLine(to: CGPoint.init(x: rect.origin.x+rect.size.width - cornerRadius, y: rect.origin.y))
        if type == .Right || type == .All{
            // 右上圆角
            context.addArc(center: CGPoint.init(x: rect.origin.x+rect.size.width - cornerRadius, y: rect.origin.y+cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi/2.0)*3, endAngle: CGFloat(Double.pi*2), clockwise: false)
        } else {
            context.addLine(to: CGPoint.init(x: rect.origin.x+rect.size.width, y: rect.origin.y))
            context.addLine(to: CGPoint.init(x: rect.origin.x+rect.size.width, y: rect.origin.y+cornerRadius))
        }
        
        
        // 右边
        context.addLine(to: CGPoint.init(x: rect.origin.x+rect.size.width, y: rect.origin.y + rect.size.height - cornerRadius))
        
        if type == .Right || type == .All {
            // 右下圆角
            context.addArc(center: CGPoint.init(x: rect.origin.x+rect.size.width - cornerRadius, y: rect.origin.y + rect.size.height-cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2.0), clockwise: false)
        } else {
            context.addLine(to: CGPoint.init(x: rect.origin.x+rect.size.width, y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint.init(x: rect.origin.x+rect.size.width-cornerRadius, y: rect.origin.y + rect.size.height))
        }
        
        
        // 下
        context.addLine(to: CGPoint.init(x: rect.origin.x + cornerRadius, y: rect.origin.y + rect.size.height))
        
        if type == .Left || type == .All {
            // 左下圆角
            context.addArc(center: CGPoint.init(x: rect.origin.x + cornerRadius, y: rect.origin.y + rect.size.height-cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi/2.0), endAngle: CGFloat(Double.pi), clockwise: false)
        } else {
            context.addLine(to: CGPoint.init(x: rect.origin.x, y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint.init(x: rect.origin.x, y: rect.origin.y + rect.size.height-cornerRadius))
        }
        
        
        // 左
        context.addLine(to: CGPoint.init(x: rect.origin.x, y: rect.origin.y + cornerRadius))
        if type == .Left || type == .All {
            // 左上圆角
            context.addArc(center: CGPoint.init(x: rect.origin.x + cornerRadius, y: rect.origin.y+cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi/2.0*3), clockwise: false)
        } else {
            context.addLine(to: CGPoint.init(x: rect.origin.x, y: rect.origin.y))
            context.addLine(to: CGPoint.init(x: rect.origin.x+cornerRadius, y: rect.origin.y))
        }
        context.fillPath()
        
        
        
        context.restoreGState()
    }

    
    private func drawText(_ text: String?, rect: CGRect!, context: CGContext, isSelected: Bool){
        context.saveGState()
        
        var textColor = UIColor.white
        if isSelected {
            context.setStrokeColor(self.selectedTitleColor.cgColor)
            textColor = self.selectedTitleColor
        } else {
            context.setStrokeColor(self.normalTitleColor.cgColor)
            textColor = self.normalTitleColor
        }
        
        context.setFont(titleFont.cgFontRef()!)
        
        var nsStr = NSString.init(string: text!)
        var textSize = nsStr.size(withAttributes: [NSAttributedStringKey.font : self.titleFont])
        
        while textSize.width > itemWidth {
            nsStr = nsStr.substring(to: nsStr.length - 1) as NSString
            let tmpStr = NSString.init(format: "%@...", nsStr)
            textSize = tmpStr.size(withAttributes: [NSAttributedStringKey.font : self.titleFont])
        }
        if nsStr.length < text?.length ?? 0 {
            nsStr = NSString.init(format: "%@...", nsStr)
        }
        
        let point = CGPoint.init(x: rect.origin.x+(itemWidth - textSize.width)/2.0, y: rect.origin.y + (rect.size.height - textSize.height)/2.0)
        
        nsStr.draw(at: point, withAttributes: [NSAttributedStringKey.foregroundColor : textColor, NSAttributedStringKey.font: self.titleFont])
        
//        nsStr.draw(in: rect, withAttributes: [NSAttributedStringKey.foregroundColor : textColor, NSAttributedStringKey.font: self.titleFont])
        
        
        
        context.restoreGState()
    }
    
    private func draw(badge: Int, rect: CGRect, context: CGContext) {
        if badge == 0 {
            return
        }
        let offsetY: CGFloat = contentInset.top
        context.saveGState()
        context.setFillColor(UIColor.white.cgColor)
        let center = CGPoint.init(x: rect.origin.x + itemWidth - badgeRadius + borderWidth, y: rect.origin.y + badgeRadius - offsetY-borderWidth)
        context.addArc(center: center, radius: badgeRadius, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: false)
        context.fillPath()
        context.restoreGState()
        
        context.saveGState()
        context.setFillColor(self.tintColor.cgColor)
        context.addArc(center: center, radius: badgeRadius-0.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: false)
        context.fillPath()
        context.restoreGState()
        
        var badgeStr = NSString.init(format: "%d", badge)
        var font = self.badgeFont
        if badge > 99 {
            badgeStr = "..."
            font = UIFont.init(name: pingFangMedium, size: 8)!
        }
        let textSize = badgeStr.size(withAttributes: [NSAttributedStringKey.font : self.badgeFont])
        let point = CGPoint.init(x: center.x - (textSize.width)/2.0, y: center.y - ( textSize.height)/2.0)
        
        badgeStr.draw(at: point, withAttributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font: font])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()
        let point = touch?.location(in: self)
        
        let index = Int(point!.x) / Int(itemWidth)
        self.currentIndex = index
        
        self.sendActions(for: UIControlEvents.valueChanged)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
