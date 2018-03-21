//
//  KSListViewController.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/26.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "KSHaikuCell.h"
#import "Haiku.h"
#import "KSCalc.h"
#import "def.h"
#import "KSCoreDataController.h"
#import "KSHistoryListViewController.h"
#import "AttributedLabel.h"
#import "KSKansuuji.h"
#import "KSEditViewController.h"
#import "KSAddHaikuViewController.h"
#import "KSHelpViewController.h"

@interface KSListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView        *tableView;
@property (nonatomic, weak) IBOutlet UIView             *bgView;
@property (nonatomic, retain) UILabel                   *dateLabel;

@property (strong, nonatomic) NSManagedObjectContext    *managedObjectContext;

@property (strong, nonatomic) NSString                  *kami5;
@property (strong, nonatomic) NSString                  *naka7;
@property (strong, nonatomic) NSString                  *shimo5;

@property (strong, nonatomic) Haiku                     *haikuResults;
@property (strong, nonatomic) KSCalc                    *calc;

//for edit view
@property (nonatomic, retain) NSIndexPath               *selectedIndexPath;
@property (nonatomic, weak) IBOutlet UIBarButtonItem    *gotoEditView;

@property (nonatomic, assign) id                        delegate;
- (IBAction)goToEditView;

//for history view
@property (nonatomic, readonly) NSString            *identify;

//delete item
@property (nonatomic, retain) Haiku                 *deleteHaikku;
@property (nonatomic, retain) NSIndexPath           *deleteIndex;

//swipe
@property (nonatomic, weak) IBOutlet UIImageView    *menuBar;

//help view
@property (nonatomic, retain) UIImageView           *helpview;

@end



//delegate method
@interface NSObject (ListViewControllerDelegate)

- (void)listViewControllerGoToEdit:(KSListViewController *)controller;
- (void)listViewControllerDidModal:(KSListViewController *)controller Data:(NSArray *)data;
- (void)listViewControllerTESTdelegate:(KSListViewController *)controller str:(NSString *)str;

@end
