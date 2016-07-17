//
//  BrowserViewController.m
//  ForEventagrate
//
//  Created by Muttahir Mumtaz on 7/17/16.
//  Copyright © 2016 Muttahir Mumtaz. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()


@end

@implementation BrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)loadURL:(id)sender {
    NSString *URLString = _urlTextField.text;
    
    
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    bool vURL = [urlTest evaluateWithObject:URLString];
    
    if (!vURL){
        NSLog (@"False url, please try again");
        return;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:URLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}
- (IBAction)loadURLButton:(id)sender {
    NSString *URLString = _urlTextField.text;
    
    
//    NSString *urlRegEx =
//    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
//    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
//    bool vURL = [urlTest evaluateWithObject:URLString];
    
    bool vURL = [self validateUrl:URLString];
    
    if (!vURL){
        NSLog (@"False url, please try again");
        return;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:URLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

-(BOOL) validateUrl: (NSString * ) urlString
{
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:urlString];
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *URLString = [[request URL] absoluteString];
    NSLog(@"The URL is = %@", URLString);
    
    //Getting current date and time
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    NSString *dateAndTime = [dateFormatter stringFromDate:[NSDate date]];
    
    
    //Saving the date, time and URL in Core Data
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDateTimeAndURL = [NSEntityDescription insertNewObjectForEntityForName:@"BrowsingHistoryData" inManagedObjectContext:context];
    [newDateTimeAndURL setValue:dateAndTime forKey:@"date"];
    [newDateTimeAndURL setValue:URLString forKey:@"url"];
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    return YES;
}



- (IBAction)checkHistory:(id)sender {
}
@end
