//
//  ViewController.m
//  light
//
//  Created by Eric Giannini on 5/7/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tableData;

@property (nonatomic, strong) UIBarButtonItem *addBarButtonItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.tableData = [[NSMutableArray alloc] initWithObjects:@"item one", @"item two", @"item three", @"item four", @"item five", @"item six", nil];
    
    self.navigationItem.rightBarButtonItem = self.addBarButtonItem;
    
    [_tableView reloadData];
    
    [self.view addSubview:self.tableView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIBarButtonItem *)addBarButtonItem {
    
    if (!_addBarButtonItem) {
        _addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self.navigationItem.rightBarButtonItem.target
                                                                          action:self.navigationItem.rightBarButtonItem.action];
        
    }
    return _addBarButtonItem;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
        [_tableView setDelegate:self];
        
        [_tableView setDataSource:self];
        
        return _tableView;
    }
    
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    
    return cell;
}



@end
