//
//  YLDatePickerViewController.h
//  YLPrivateFinancialManagement
//
//  Created by Waterstrong on 2/8/16.
//  Copyright © 2016 mobiletrain. All rights reserved.
//

#import "YLMumViewController.h"

@interface YLDatePickerViewController : YLMumViewController
@property (nonatomic, copy) void(^myDatePicker)(NSDate  *,NSString*);
@end
