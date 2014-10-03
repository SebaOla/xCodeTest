//
//  LoginViewController.m
//  com.palermo.mobile
//
//  Created by Sebastian  on 01/10/14.
//  Copyright (c) 2014 hapsa. All rights reserved.
//

#import "LoginViewController.h"
#import "HAPSAUser.h"
#import "HomeTableViewController.h"

@interface LoginViewController ()
- (IBAction)acceptBtnDidTouch:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *tfDNI;
@property (strong, nonatomic) IBOutlet UITextField *tfPIN;
@property (strong, nonatomic) NSMutableData *responseData;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)acceptBtnDidTouch:(id)sender {
    NSString *hapsaUrlString = @"http:190.220.6.124:50016/Mobile.svc/";
    NSString *method = @"PlayerValidation";
    NSString *registrationId = @"iphoneId";
    
    if ([_tfDNI.text isEqual: @""] || [_tfPIN.text isEqual: @""]) {
        NSString *message = @"Ingresá tu DNI y PIN.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@/%@", hapsaUrlString, method, _tfDNI.text, _tfPIN.text];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    [request setValue:registrationId forHTTPHeaderField:@"DeviceKey"];
    
    // Convert your data and set your request's HTTPBody property
    //NSString *stringData = @"some data";
    //NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    //request.HTTPBody = requestBodyData;
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *myError = nil;
    
    NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    NSData *dataResponse = [NSJSONSerialization dataWithJSONObject:dicResponse options:NSJSONWritingPrettyPrinted error:&myError];
    NSString *jsonString = [[NSString alloc] initWithData:dataResponse encoding:NSUTF8StringEncoding];
    
    //HAPSAUser *user = [[HAPSAUser alloc] initWithString:jsonString error:&myError];
    
    NSDictionary *error = [dicResponse objectForKey:@"Error"];
    NSString *status = [error objectForKey:@"Status"];
    
    if(![status isEqual: @"ok"]){
        NSString *message = [error objectForKey:@"Mensaje"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:jsonString forKey:@"user"];
    HomeTableViewController *homeTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeTableViewController"];
        [self.navigationController pushViewController:homeTableViewController animated:NO];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSString *message = @"Se a producido un error, intentá mas tarde.";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:nil,nil];
    [alert show];
}
@end
