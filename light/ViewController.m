//
//  ViewController.m
//  light
//
//  Created by Eric Giannini on 5/7/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, InformationViewControllerDelegate>

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSMutableArray *tableData;

@property (nonatomic, strong) UIBarButtonItem *addBarButtonItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    
//    self.tableData = [[NSMutableArray alloc] initWithObjects:@"item one", @"item two", @"item three", @"item four", @"item five", @"item six", nil];
    
    self.navigationItem.rightBarButtonItem = self.addBarButtonItem;
    
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;

    [self loadData];
    
    [_tableView reloadData];
    
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from person";
    
    // Get the results.
    if (self.tableData != nil) {
        self.tableData = nil;
    }
    self.tableData = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tableView reloadData];
}


- (UIBarButtonItem *)addBarButtonItem {
    
    if (!_addBarButtonItem) {
        
        _addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action: @selector(addPerson:)];
    }
    return _addBarButtonItem;
}

- (void)addPerson:(UIBarButtonItem *)sender {
    InformationViewController *informationVC = [[InformationViewController alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.navigationController pushViewController:informationVC animated:YES];
        
    });
    
    informationVC.delegate = self; 
    
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
    
    NSInteger indexOfFirstname = [self.dbManager.arrColumnNames indexOfObject:@"firstname"];
    NSInteger indexOfLastname = [self.dbManager.arrColumnNames indexOfObject:@"lastname"];
    NSInteger indexOfAge = [self.dbManager.arrColumnNames indexOfObject:@"age"];
    
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[self.tableData objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstname], [[self.tableData objectAtIndex:indexPath.row] objectAtIndex:indexOfLastname]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %@", [[self.tableData objectAtIndex:indexPath.row] objectAtIndex:indexOfAge]];
    
//    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}


-(void)editingInfoWasFinished{
    // Reload the data.
    [self loadData];
}




@end
