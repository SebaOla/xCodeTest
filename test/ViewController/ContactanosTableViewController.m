//
//  ContactanosTableViewController.m
//  com.palermo.mobile
//
//  Created by desarrollo on 01/10/14.
//  Copyright (c) 2014 hapsa. All rights reserved.
//

#import "ContactanosTableViewController.h"

@interface ContactanosTableViewController ()
@property (strong, nonatomic) IBOutlet UITextField *tfFirstName;
@property (strong, nonatomic) IBOutlet UITextField *tfLastName;
@property (strong, nonatomic) IBOutlet UITextField *tfPhone;
@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UITextField *tfComment;
@property (strong, nonatomic) NSArray *textFieldsArray;

@end

@implementation ContactanosTableViewController

//INIT
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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self initTextFields];
    // Do any additional setup after loading the view, typically from a nib.
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

-(void) initTextFields
{
    self.TextFieldsArray = [[NSArray alloc] initWithObjects:self.tfFirstName, self.tfLastName, self.tfPhone, self.tfEmail, self.tfComment, nil];
    
    for(UITextField *textField in self.textFieldsArray){
        textField.delegate = self;
    }
    
    [self.textFieldsArray[0] becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}


//TextFields
- (IBAction)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self selectNextTextField:textField];
    return YES;
}

- (void)selectNextTextField:(UITextField *)textField
{
    int pos = [self.textFieldsArray indexOfObject:textField];
    if(pos+1 < self.textFieldsArray.count){
        [self.textFieldsArray[pos+1] becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
}

//SendComment
- (IBAction)sendComment {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    @try{
        [self validateTextFields];
        alert.title=@"El comentario ha sido enviado.";
        
    }
    @catch(NSError *ex){
        alert.message = ex.domain;
    }
    @catch(NSException *ex){
        alert.message = ex.reason;
    }
    
    [alert show];
}

-(void)validateTextFields{
    NSString *error = [[NSString alloc] init];
    
    if(self.tfFirstName.text.length == 0)
    {
        error = [error stringByAppendingString:@"Debe ingresar un nombre.\n"];
    }
    if(self.tfLastName.text.length == 0)
    {
        error = [error stringByAppendingString:@"Debe ingresar un apellido.\n"];
    }
    if(self.tfPhone.text.length == 0)
    {
        error = [error stringByAppendingString:@"Debe ingresar un teléfono.\n"];
    }
    if(self.tfEmail.text.length == 0)
    {
        error = [error stringByAppendingString:@"Debe ingresar un email.\n"];
    }
    else{
        error = [error stringByAppendingString:[self validateMail:self.tfEmail.text]];
    }
    if(self.tfComment.text.length == 0)
    {
        error = [error stringByAppendingString:@"Debe ingresar un comentario.\n"];
    }
    
    if(error.length > 0){
        NSError *e = [NSError errorWithDomain:error code:6000 userInfo:nil];
                    
        @throw e;
    }
}

-(NSString *)validateMail:(NSString*) mail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if([emailTest evaluateWithObject:mail])
        return @"";
    else
        return @"Formato de mail inválido.\n";
}

@end
