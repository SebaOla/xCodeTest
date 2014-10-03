//
//  NavigationViewController.m
//  com.palermo.mobile
//
//  Created by desarrollo on 01/10/14.
//  Copyright (c) 2014 hapsa. All rights reserved.
//

#import "NavigationViewController.h"
#import "HAPSAUser.h"


@interface NavigationViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NavigationViewController{
    NSArray *menu;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menu = @[@"home", @"contact", @"networking", @"session"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = nil;
    if ([cellIdentifier isEqual:@"session"] || [cellIdentifier isEqual:@"closeSession"]) {
        cell = [self sessionCell: tableView cellForRowAtIndexPath:indexPath];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    }
    
    return cell;
}

-(UITableViewCell *) sessionCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"session";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userJson = [defaults stringForKey:@"user"];
    NSError *myError = nil;
    
    HAPSAUser *user = [[HAPSAUser alloc] initWithString:userJson error:&myError];
    
    if(user && user.token != (id)[NSNull null]){
        identifier = @"closeSession";
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqual:@"Cerrar Sesión"]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:@"" forKey:@"user"];
        [tableView reloadData];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
    
}


@end
