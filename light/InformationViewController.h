//
//  InformationViewController.h
//  light
//
//  Created by Eric Giannini on 5/7/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol InformationViewControllerDelegate

// MARK: - InformationViewControllerDelegate methods


-(void)editingInfoWasFinished;

@end

@interface InformationViewController : UIViewController

// MARK: - public properties

@property (nonatomic, strong) id<InformationViewControllerDelegate> delegate;
@property (nonatomic) int recordIDToEdit;


@end
