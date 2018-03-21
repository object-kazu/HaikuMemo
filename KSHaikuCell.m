//
//  KSHaikuCell.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/23.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSHaikuCell.h"
#import "def.h"

@implementation KSHaikuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( !self ) {
        return nil;
    }
    
    //haiku
    
    self.haikuLabel             = [[AttributedLabel alloc]initWithFrame:CGRectZero];
    _haikuLabel.backgroundColor = [UIColor clearColor];
    [_haikuLabel KS_fontSize:18];
    [_haikuLabel KS_tateGaki:YES text:_haikuLabel.text];
    [self.contentView addSubview:_haikuLabel];
    
    //edit date
    _editDate                 = [[AttributedLabel alloc]initWithFrame:CGRectZero];
    _editDate.backgroundColor = [UIColor clearColor];
    _editDate.textColor       = RGB(150, 150, 150);
    [_editDate KS_fontSize:14];
    [_editDate KS_tateGaki:YES text:_editDate.text];
    [self.contentView addSubview:_editDate];
    
    //thumbnail
    _main_img = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_main_img];
    
    //blind cell
    _blindCell = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage    *img = [UIImage imageNamed:@"jpaper.jpg"];
    [_blindCell setImage:img];
    _blindCell.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_blindCell];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark ---------- layout ----------

- (void)layoutSubviews {
    
    // 親クラスのメソッドを呼び出す
    [super layoutSubviews];
    
    //haiku
    self.haikuLabel.backgroundColor = [UIColor clearColor];
    self.haikuLabel.transform = CGAffineTransformMakeRotation(CELL_Rotation * -1);
    self.haikuLabel.frame = CGRectMake(10,
                                       10,
                                       330,
                                       50);
    
    //edit date
    self.editDate.backgroundColor = [UIColor clearColor];
    self.editDate.transform       = CGAffineTransformMakeRotation(CELL_Rotation * -1);
    self.editDate.frame = CGRectMake(210,
                                     45,
                                     150,
                                     50);
    
    //main_img
    _main_img.frame     = [self main_img_init_position];
    _main_img.transform = CGAffineTransformMakeRotation(CELL_Rotation * -1);
    
    CGFloat    cellWidth  = self.frame.size.width;
    CGFloat    cellHeight = self.frame.size.height;
    self.blindCell.frame     = CGRectMake(cellWidth, 0, cellWidth, cellHeight);
    self.blindCell.transform = CGAffineTransformMakeRotation(CELL_Rotation * -1);
    
}

- (void)drawRect:(CGRect)rect {
    // CGContextを用意する
    CGContextRef    context = UIGraphicsGetCurrentContext();
    
    // CGGradientを生成する
    // 生成するためにCGColorSpaceと色データの配列が必要になるので
    // 適当に用意する
    CGGradientRef      gradient;
    CGColorSpaceRef    colorSpace;
    size_t             num_locations = 2;
    CGFloat            locations[2]  = { 0.0, 1.0 };
    
    //start color RGB
    float              r = (float)255 / 255;
    float              g = (float)236 / 255;
    float              b = (float)202 / 255;
    
    CGFloat            components[12] = { r, g,            b,            0.5, //start color
        r,            g,            b,            1.0,
        0.5,          0.5,          0.5,          1.0 }; // end color
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    gradient   = CGGradientCreateWithColorComponents(colorSpace, components,
                                                     locations, num_locations);
    
    // 生成したCGGradientを描画する
    // 始点と終点を指定してやると、その間に直線的なグラデーションが描画される。
    // （横幅は無限大）
    CGPoint    startPoint = CGPointMake(self.frame.size.width / 2, 0.0);
    CGPoint    endPoint   = CGPointMake(self.frame.size.width / 2, self.frame.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    // GradientとColorSpaceを開放する
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
}

//- (CGRect)rRectMake:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
//
////    NSLog(@"rRectMake {%f,%f}{%f,%f}",x,y,width,height);
//
//    CGFloat    rX      = y;
//    CGFloat    rY      = CELL_Height - width - x;
//    CGFloat    rWidth  = height;
//    CGFloat    rHeight = width;
//    CGRect     rec;
//    rec = CGRectMake(rX, rY, rWidth, rHeight);
//
//    return rec;
//}

- (CGRect)main_img_init_position {
    CGRect     screen             = [UIScreen mainScreen].bounds;
    CGFloat    navigationBarHight = 44;
    CGFloat    statusBarHeight    = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat    image_y            = screen.size.height - Thumbnail_height - navigationBarHight - statusBarHeight;
    CGRect     imageFrame         = CGRectMake(image_y, 0, Thumbnail_width, Thumbnail_height);
    
    return imageFrame;
    //    return [self rRectMake:0 y:image_y width:Thumbnail_width height:Thumbnail_height];
}

@end
