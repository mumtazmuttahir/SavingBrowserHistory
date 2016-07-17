//
//  BrowserViewController.h
//  ForEventagrate
//
//  Created by Muttahir Mumtaz on 7/17/16.
//  Copyright © 2016 Muttahir Mumtaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface BrowserViewController : UIViewController <UIWebViewDelegate>
- (IBAction)checkHistory:(id)sender;
- (IBAction)loadURL:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
