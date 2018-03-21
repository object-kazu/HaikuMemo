//
//  KSEditViewController.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/08.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSListViewController.h"
#import "def.h"

@interface KSEditViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, assign) id                    delegate;

@property (nonatomic, weak) IBOutlet UITextField    *kami5text;
@property (nonatomic, weak) IBOutlet UITextField    *naka7text;
@property (nonatomic, weak) IBOutlet UITextField    *shimo5text;
@property (nonatomic, weak) IBOutlet UIImageView    *haiku_img;
@property (nonatomic, weak) IBOutlet UIImageView    *menuBar;

@property (nonatomic, retain) NSIndexPath           *indexPath;
@property (nonatomic, retain) Haiku                 *haiku;

- (IBAction)back;
- (IBAction)done;

@end

//delegate method
@interface NSObject (KSEditorViewDelegate)

@end