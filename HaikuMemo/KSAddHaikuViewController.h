//
//  KSViewController.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/21.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "def.h"
#import "KSImage.h"
#import "Haiku.h"
#import "KSCoreDataController.h"
#import "KSCalc.h"

@interface KSAddHaikuViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

+ (KSAddHaikuViewController *)shardView;

#pragma mark -
#pragma mark ---------- save ----------
- (void)saveHaiku;

#pragma mark -
#pragma mark ---------- haiku ----------
@property (nonatomic, weak) IBOutlet UITextField    *textKami5; //save item
@property (nonatomic, weak) IBOutlet UITextField    *textNaka7; //save item
@property (nonatomic, weak) IBOutlet UITextField    *textShimo5; //save item
@property (nonatomic, retain) NSString              *haiku575;       //save item
@property (nonatomic, retain) NSString              *uuidString;     //save item

#pragma mark -
#pragma mark ---------- photo image ----------
@property (nonatomic, weak) IBOutlet UIImageView    *photoImg; //save item
@property (nonatomic, retain) UIImage               *thumbnailImg;   //save item
@property (nonatomic, retain) UIView                *barTouchControllView;
@property (nonatomic, weak) IBOutlet UIImageView    *naviBarEdit;
@property (nonatomic)           CGRect              initPosi_NaviBarEdit;


#pragma mark -
#pragma mark ---------- action by touched ----------
- (void)done;
- (void)back;
- (void)tapOutside;
- (void)photoLib:(ACTION)act;

@end
