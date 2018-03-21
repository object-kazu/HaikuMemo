//
//  KSTableViewController.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/23.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "KSHaikuCell.h"
#import "Haiku.h"
#import "KSCalc.h"
#import "def.h"
#import "KSCoreDataController.h"

@interface KSTableViewController : UITableViewController


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//@property (strong,nonatomic) UILabel *year;
//@property (strong,nonatomic) UILabel *month_day;
//@property (weak, nonatomic)  UIImageView *main_img;
//@property (strong,nonatomic) NSString *kami5;
//@property (strong,nonatomic) NSString *naka7;
//@property (strong,nonatomic) NSString *shimo5;

@property (strong, nonatomic) Haiku* haikuResults;
@property (strong, nonatomic) KSCalc* calc;



@end
