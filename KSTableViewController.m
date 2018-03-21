//
//  KSTableViewController.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/23.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSTableViewController.h"

@interface KSTableViewController ()

@end

@implementation KSTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _calc = [[KSCalc alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    _calc = nil;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger counter = [[KSCoreDataController sharedManager].sortedDietNewOld count];
    return counter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
    
    KSHaikuCell* cell;
    cell = (KSHaikuCell*)[tableView dequeueReusableCellWithIdentifier:@"KSHaikuCell"];
    if (!cell) {
        cell = [[KSHaikuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KSHaikuCell"];
    }
    
    NSArray* array = [[NSArray alloc] initWithArray:[KSCoreDataController sharedManager].sortedDietOldNew];
    Haiku* haiku = [array objectAtIndex:indexPath.row];
    
    
//    KSDietCell *cell;
//    cell = (KSDietCell*)[tableView dequeueReusableCellWithIdentifier:@"KSDietCell"];
//    if (!cell) {
//        cell = [[KSDietCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KSDietCell"];
//    }
//    NSArray *array = [[NSArray alloc] initWithArray:[KSDietController sharedManager].sortedDietOldNew];
//    
//    KSDiet *diet = [array objectAtIndex:indexPath.row];
    
    NSDate* _date_ =  haiku.date;
    
    //hidden parameter setting
//    cell.editDay = date_;
//    cell.editBirth = diet.bitrh_day;
//    cell.editDie = diet.die_day;
//    cell.edit_morning = diet.morning;
//    cell.edit_lunch = diet.lunch;
//    cell.edit_dinner = diet.dinner;
//    cell.edit_t_morning = diet.thumbnail_morning;
//    cell.edit_t_lunch = diet.thumbnail_lunch;
//    cell.edit_t_dinner = diet.thumbnail_dinner;
    
    
    NSDateComponents* dateComps = [_calc separateDateComponets:_date_];
    
    cell.year.text = [NSString stringWithFormat:@"%d",dateComps.year];
    cell.month_day.text = [NSString stringWithFormat:@"%02d/%02d",dateComps.month,dateComps.day];
    
//    cell.monthAndDayLabel.text = [NSString stringWithFormat:@"%02d/%02d",dateComps.month,dateComps.day];
    
    
//    thumbnail img
//    KSImage *ks_img = [[KSImage alloc] init];
//    
//    if (diet.thumbnail_morning) {
//        
//        NSData* mData = diet.thumbnail_morning;
//        UIImage *morning_img = [UIImage imageWithData:mData];
//        morning_img = [ks_img getThumbImage:morning_img];
//        [cell.morningImage setImage:morning_img];
//        
//    }else{
//        
//        [cell.morningImage setImage: [UIImage imageNamed:[calc stringConvertImgFileName:diet.morning]]];
//        
//    }
//    
//    if (diet.thumbnail_lunch) {
//        NSData *lData = diet.thumbnail_lunch;
//        UIImage *lunch_img = [UIImage imageWithData:lData];
//        lunch_img = [ks_img getThumbImage:lunch_img];
//        [cell.lunchImage setImage:lunch_img];
//        
//    }else{
//        
//        [cell.lunchImage setImage:[UIImage imageNamed:[calc stringConvertImgFileName:diet.lunch]]];
//    }
//    
//    if (diet.thumbnail_dinner) {
//        NSData* dData = diet.thumbnail_dinner;
//        UIImage *dinner_img = [UIImage imageWithData:dData];
//        dinner_img = [ks_img getThumbImage:dinner_img];
//        [cell.dinnerImage setImage:dinner_img];
//    }else{
//        
//        [cell.dinnerImage setImage:[UIImage imageNamed:[calc stringConvertImgFileName:diet.dinner]]];
//    }
    
    // display only
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    array = nil;
    dateComps = nil;
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
