//
//  KSHaikuCell.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/23.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "def.h"
#import "AttributedLabel.h"
#import "KSKansuuji.h"

@interface KSHaikuCell : UITableViewCell

@property (strong, nonatomic) UIImageView        *main_img;
@property (strong, nonatomic) NSString           *kami5;
@property (strong, nonatomic) NSString           *naka7;
@property (strong, nonatomic) NSString           *shimo5;
@property (strong, nonatomic) NSString           *haiku575;
@property (strong, nonatomic) NSString           *identifer;
@property (nonatomic, retain) UIImageView        *blindCell;

@property (nonatomic, retain) AttributedLabel    *haikuLabel;
@property (nonatomic, retain) AttributedLabel    *editDate;

//- (CGRect)rRectMake:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
- (CGRect)main_img_init_position;

@end
