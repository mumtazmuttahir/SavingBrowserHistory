//
//  HistoryTableViewController.h
//  ForEventagrate
//
//  Created by Muttahir Mumtaz on 7/17/16.
//  Copyright © 2016 Muttahir Mumtaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface HistoryTableViewController : UITableViewController

@property (strong) NSMutableArray *historyDetail;
- (IBAction)backToWebView:(id)sender;

@end
