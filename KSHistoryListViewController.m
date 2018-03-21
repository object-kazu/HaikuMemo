//
//  KSHistoryListViewController.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/04.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSHistoryListViewController.h"

@interface KSHistoryListViewController ()

@end

@implementation KSHistoryListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _targetIdentify = NULL;
    
#pragma mark -
#pragma mark ---------- rotate table ----------
    // bgView の回転 (時計回りに90°)
    // -90°にしないのにはわけがある！
    CGRect    originalFrame = self.bgView.frame;
    self.bgView.center    = CGPointMake(320 / 2, 480 / 2);
    self.bgView.transform = CGAffineTransformMakeRotation(CELL_Rotation);
    self.bgView.frame     = originalFrame;
    
    // ページ単位でスクロールをかっちり止めるにはYES
    self.tableView.pagingEnabled = YES;
    
    // スクロールバー(インジケーター)が上部に出るので、気になる場合は消しておく
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ( _indexPath == NULL ) return;
    NSArray    *array = [[NSArray alloc] initWithArray:[[KSCoreDataController sharedManager] extractEntityByChild:NO]];
    Haiku      *haiku = [array objectAtIndex:_indexPath.row];
    _targetIdentify = haiku.identifer;
    
    //swip
    //menu bar
    _menuBar.hidden                 = NO;
    _menuBar.frame                  = CGRectMake(0, 0, _menuBar.image.size.width, _menuBar.image.size.height);
    _menuBar.userInteractionEnabled = YES;
    
    UISwipeGestureRecognizer    *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(didSwipeMenu:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.menuBar addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    // cell
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(didSwipeCell:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.tableView addGestureRecognizer:swipeGesture];
    swipeGesture = nil;
    
    //table
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark ---------- swipe ----------

- (void)didSwipeCell:(UISwipeGestureRecognizer *)swipeRecognizer {
    
    if ( [[self.tableView indexPathsForVisibleRows] count] == 0 ) {
        LOG_ERROR_METHOD;
        
        return;
    }
    
    CGPoint    loc = [swipeRecognizer locationInView:self.tableView];
    _deleteIndexPath = [self.tableView indexPathForRowAtPoint:loc];
    
    if ( swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft ) {
        
        UIAlertView    *alert = [[UIAlertView alloc] initWithTitle:@"Delete ?"
                                                           message:@"delete"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"Delete", nil];
        [alert show];
        alert = nil;
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch ( buttonIndex ) {
        case 0:
            if ( alertView.visible ) {
                [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:YES];
            }
            break;
        case 1:
            
            [self deleteHaiku:_deleteIndexPath];
            
        default:
            break;
    }
}

- (void)deleteHaiku:(NSIndexPath *)indexPath {
    
    if ( _indexPath == nil ) {
        LOG_ERROR_METHOD;
        
        return;
    }
    
    KSHaikuCell    *cell = (KSHaikuCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSArray        *src   = [[KSCoreDataController sharedManager] extractEntityByID:_targetIdentify];
    NSArray        *array = [[NSArray alloc] initWithArray:src];
    Haiku          *haiku = [array objectAtIndex:indexPath.row];
    
    //delete flag yesにしておくこと！
    haiku.deleteFlug = DELETE_FLUG_YES;
    
    CGRect    frame = cell.blindCell.frame;
    frame.origin = CGPointMake(0, 0);
    
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         cell.blindCell.frame = frame;
                         
                     }
     
                     completion:^(BOOL finished) {
                         
                         //delete
                         [[KSCoreDataController sharedManager] deleteAnItem:DELETE_FLUG_YES];
                         [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                         
                     }];
    
}

- (void)didSwipeMenu:(UISwipeGestureRecognizer *)swipe {
    
    UIImage        *img       = [UIImage imageNamed:DEFAULTMENU];
    UIImageView    *slideView = [[UIImageView alloc] initWithImage:img];
    CGRect         screen     = [UIScreen mainScreen].bounds;
    slideView.frame = CGRectMake(screen.size.width, 0, img.size.width, img.size.height);
    [_menuBar addSubview:slideView];
    
    if ( swipe.direction == UISwipeGestureRecognizerDirectionLeft ) {
        // back
        
        [UIView animateWithDuration:0.4f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             _menuBar.frame = CGRectMake(-1 * screen.size.width, 0, _menuBar.image.size.width, _menuBar.image.size.height);
                             
                         } completion:^(BOOL finished) {
                             
                             [self back];
                             _menuBar.hidden = YES;
                             
                         }];
        
    }
    
    slideView = nil;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (IBAction)back {
    
    if ( ![self isBeingDismissed] ) {
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger    row = 0;
    
    row = [[KSCoreDataController sharedManager] extractEntityByID:_targetIdentify].count;
    
    return row;
}

//cell 高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CELL_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString       *cellName = @"KSHaikuCell";
    KSHaikuCell    *cell;
    cell = (KSHaikuCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if ( !cell ) {
        cell = [[KSHaikuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    NSArray             *src   = [[KSCoreDataController sharedManager] extractEntityByID:_targetIdentify];
    NSArray             *array = [[NSArray alloc] initWithArray:src];
    Haiku               *haiku = [array objectAtIndex:indexPath.row];
    
    //edit date
    KSKansuuji          *kansuji     = [[KSKansuuji alloc]init];
    KSCalc              *calc        = [[KSCalc alloc]init];
    NSDateComponents    *dateComps   = [calc separateDateComponets:haiku.date];
    NSString            *kansu_date_ = [kansuji dateForHaikuMemo:dateComps.year month:dateComps.month day:dateComps.day];
    cell.editDate.text = kansu_date_;
    
    //haiku
    cell.haikuLabel.text = haiku.haiku575;
    
    //image
    NSData     *imgData  = haiku.image;
    UIImage    *photoImg = [UIImage imageWithData:imgData];
    [cell.main_img setImage:photoImg];
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    kansuji = nil;
    calc    = nil;
    
    return cell;
    
}

@end
