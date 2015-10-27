//
//  ZHDatePicker.h
//  Reselling
//
//  Created by ZhangYuting on 15/5/12.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerSelectedBlock)(NSDate *date);
typedef void(^pickerStateBlock)(NSInteger state);

@interface ZHDatePicker : UIView

@property(copy, nonatomic) PickerSelectedBlock selectedObj;
@property(copy, nonatomic) pickerStateBlock stateBlock;

@property(strong, nonatomic) IBOutlet UIDatePicker *myDatePicker;

+ (void)showDatePicker:(NSDate*)now
      pickerStateBlock:(void(^)(NSInteger state))pickerStateBlock
         selectedBlock:(void(^)(NSDate *date))selectedBlock;


@end
