import UIKit
@IBDesignable
class CustomCellTableViewCell: UITableViewCell {
    
    @IBInspectable var is_cloud: Bool = true
    @IBInspectable var is_not_cloud: Bool = true
    let midx = UIScreen.mainScreen().bounds.width/2
    var midy: CGFloat = 0
    let shapeLayer = CAShapeLayer()
    lazy var label = UILabel()
        
    override func awakeFromNib() {
       super.awakeFromNib()
        //Initialization code
        if is_not_cloud {
            let diameter = min(self.frame.size.width, self.frame.size.height) * 0.7
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: midx,y: 45), radius: CGFloat(diameter/2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
            
            shapeLayer.path = circlePath.CGPath
            
         
            shapeLayer.strokeColor = UIColor(red: 0/255, green: 178/255, blue: 238/255, alpha: 1).CGColor
            shapeLayer.lineWidth = 3
            layer.insertSublayer(shapeLayer, atIndex: 0)
            label.frame = CGRectMake(0, 0, 30, 20)
            label.center = CGPoint(x: midx, y: 45)
            label.font = UIFont(name: "Helvetica Neue", size: 20)
            label.textColor = UIColor.whiteColor()
            label.textAlignment = NSTextAlignment.Center
            self.insertSubview(label, atIndex: 2)
        }
        if is_cloud {
            let cloud_image = UIImageView(frame:(CGRectMake(0, 0, midx*2, 130)))
            cloud_image.center = CGPoint(x: midx, y: 40)
            cloud_image.image = UIImage(named: "cloud")
            cloud_image.contentMode = .ScaleAspectFit
            self.insertSubview(cloud_image, atIndex: 4)
        }
    }
    override func drawRect(rect: CGRect) {
        if is_not_cloud {
            let path = UIBezierPath()
            path.lineWidth = 7
            path.moveToPoint(CGPointMake(midx, 90))
            path.addLineToPoint(CGPointMake(midx, 0))
            UIColor(red: 202/255, green: 225/255, blue: 255/255, alpha: 1).setStroke()
            path.stroke()
        } else if is_cloud {
            let path = UIBezierPath()
            path.lineWidth = 7
            path.moveToPoint(CGPointMake(midx, 150))
            path.addLineToPoint(CGPointMake(midx, 75))
            UIColor(red: 202/255, green: 225/255, blue: 255/255, alpha: 1).setStroke()
            path.stroke()
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
