//
//  InformationViewController.m
//  light
//
//  Created by Eric Giannini on 5/7/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

#import "InformationViewController.h"
#import "DBManager.h"

@interface InformationViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *lastNameTextField;
@property (nonatomic, strong) UITextField *ageTextField;
@property (nonatomic, strong) UIBarButtonItem *saveBarButtonItem;
@property (nonatomic, strong) DBManager *dbManager;



@end

@implementation InformationViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //the database class will check if the sampledb.sql file exists or not in the documents directory, and it will copy it there if not found.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampleDB.sql"];
    
    self.navigationItem.rightBarButtonItem = self.saveBarButtonItem;
    
    [self layoutTextFields];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutTextFields {
    NSArray *arrayOfTextFields = [[NSArray alloc] initWithObjects:self.nameTextField, self.lastNameTextField, self.ageTextField, nil];
    
    for (UITextField *textField in arrayOfTextFields) {
        
        [self.view addSubview:textField];
        
    }
}

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

-(void)save:(id)sender{};

// MARK: - UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
