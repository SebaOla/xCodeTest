//
//  HomeTableViewController.m
//  com.palermo.mobile
//
//  Created by Sebastian  on 30/09/14.
//  Copyright (c) 2014 hapsa. All rights reserved.
//

#import "HomeTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HomeTableViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *budgeLabel;
@end

@implementation HomeTableViewController

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
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_background.jpg"]];
    self.tableView.backgroundView = imageView;
    [_budgeLabel.layer setCornerRadius:2];
    
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1; // you can have your own choice, of course
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7; // you can have your own choice, of course
}

@end
