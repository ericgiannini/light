//
//  InformationViewController.m
//  light
//
//  Created by Eric Giannini on 5/7/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//


#import "InformationViewController.h"
#import "DBManager.h"

//MARK: - Interface

@interface InformationViewController () <UITextFieldDelegate>

// MARK: - Private Properities for InformationViewController
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *lastNameTextField;
@property (nonatomic, strong) UITextField *ageTextField;
@property (nonatomic, strong) UIBarButtonItem *saveBarButtonItem;

//MARK: - Private Property for database

@property (nonatomic, strong) DBManager *dbManager;

//MARK: - Private method declarations for initialization of subviews & data

- (void)layoutTextFields;
-(void)loadInfoToEdit;

@end



//MARK: - Implementation

@implementation InformationViewController

// MARK: - initialization for subviews & data

- (void)layoutTextFields {
    NSArray *arrayOfTextFields = [[NSArray alloc] initWithObjects:self.nameTextField, self.lastNameTextField, self.ageTextField, nil];
    
    for (UITextField *textField in arrayOfTextFields) {
        
        [self.view addSubview:textField];
        
    }
}

-(void)loadInfoToEdit {
    // Create the query.
    NSString *query = [NSString stringWithFormat:@"select * from person where person=%d", self.recordIDToEdit];
    
    // Load the relevant data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Set the loaded data to the textfields.
    self.nameTextField.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstname"]];
    self.lastNameTextField.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastname"]];
    self.ageTextField.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"age"]];
};

// MARK: - Lazily Initialize instnaces of UITextField, UIBarButtonItem

-(UITextField *)nameTextField {
    
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 93, 280, 30)];
        _nameTextField.placeholder = @"first name";
//        _nameTextField setTintColor:
//        _nameTextField setBackground:
        _nameTextField.autocapitalizationType = YES;
        _nameTextField.returnKeyType = UIReturnKeyDone;
        [_nameTextField setDelegate:self];
        
    }
    
    return _nameTextField;
}
-(UITextField *)lastNameTextField {
    
    if (!_lastNameTextField) {
        _lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 139, 280, 30)];
        _lastNameTextField.placeholder = @"last name";
        //        _nameTextField setTintColor:
        //        _nameTextField setBackground:
        _lastNameTextField.autocapitalizationType = YES;
        _lastNameTextField.returnKeyType = UIReturnKeyDone;
        [_lastNameTextField setDelegate:self];
    }
    
    return _lastNameTextField;
}

-(UITextField *)ageTextField {
    
    if (!_ageTextField) {
        _ageTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 186, 280, 30)];
        _ageTextField.placeholder = @"age";
        //        _nameTextField setTintColor:
        //        _nameTextField setBackground:
        _ageTextField.autocapitalizationType = YES;
        _ageTextField.returnKeyType = UIReturnKeyDone;
        [_ageTextField setDelegate:self];
    }
    
    return _ageTextField;
}


- (UIBarButtonItem *)saveBarButtonItem {
    
    if (!_saveBarButtonItem) {
        _saveBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                          target:self
                                                                           action:@selector(save:)];
    }
    return _saveBarButtonItem;
}


// MARK: - UIBarButtonItem method

-(void)save:(UIBarButtonItem *)sender{
    

    // Prepare the query string.
    NSString *query = [NSString stringWithFormat:@"insert into person values(null, '%@', '%@', %d)", self.nameTextField.text, self.lastNameTextField.text, [self.ageTextField.text intValue]];
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        [self.delegate editingInfoWasFinished];
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }

}

// MARK: - UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


// MARK: - lifecycle of view

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    //the database class will check if the sampledb.sql file exists or not in the documents directory, and it will copy it there if not found.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    
    self.navigationItem.rightBarButtonItem = self.saveBarButtonItem;
    
    [self layoutTextFields];
    
    // Check if should load specific record for editing.
    if (self.recordIDToEdit != -1) {
        // Load the record with the specific ID from the database.
        [self loadInfoToEdit];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
