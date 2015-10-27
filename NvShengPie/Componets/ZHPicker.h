//
//  ZHPicker.h
//  ehuangli_swift
//
//  Created by ZhangYuting on 15/4/22.
//  Copyright (c) 2015年 zyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerSelected)(NSString *selectedObj,NSInteger index);
typedef void(^pickerStateBlock)(NSInteger state);

@interface ZHPicker : UIView<UIPickerViewDelegate, UIPickerViewDataSource,UIGestureRecognizerDelegate>

@property(copy, nonatomic) PickerSelected selectedObj;
@property(copy, nonatomic) pickerStateBlock stateBlock;

@property(strong, nonatomic) NSArray *myDataSource;


+ (void)showPickerWithDataSource:(NSArray*)data
                pickerStateBlock:(void(^)(NSInteger state))pickerStateBlock
                   selectedBlock:(void(^)(NSString *selectedObj,NSInteger index))selectedBlock;

@end
