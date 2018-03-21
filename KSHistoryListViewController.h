//
//  KSHistoryListViewController.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/04.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSHaikuCell.h"
#import "def.h"
#import "KSListViewController.h"
#import "KSCoreDataController.h"

@interface KSHistoryListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView      *tableView;
@property (nonatomic, weak) IBOutlet UIView           *bgView;
@property (nonatomic, retain) NSIndexPath             *indexPath;
@property (nonatomic, retain) NSString                *targetIdentify;
@property (nonatomic, retain) NSIndexPath             *deleteIndexPath;

//swipe
@property (nonatomic, retain) IBOutlet UIImageView    *menuBar;

- (IBAction)back;

@end
