//
//  ZHPicker.m
//  ehuangli_swift
//
//  Created by ZhangYuting on 15/4/22.
//  Copyright (c) 2015年 zyt. All rights reserved.
//

#import "ZHPicker.h"

@interface ZHPicker (){
    
    NSInteger seletecdIndex;
}

@end

@implementation ZHPicker
@synthesize myDataSource;
@synthesize selectedObj;
@synthesize stateBlock;

- (id)initWithDataSource:(NSArray*)data{

    self = [[[NSBundle mainBundle] loadNibNamed:@"ZHPicker" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
        self.myDataSource = data;
        seletecdIndex = 0;
    }
    return self;
}

+ (void)showPickerWithDataSource:(NSArray*)data
                pickerStateBlock:(void(^)(NSInteger state))pickerStateBlock
                   selectedBlock:(void(^)(NSString *selectedObj,NSInteger index))selectedBlock
{
    if (pickerStateBlock) {
        pickerStateBlock(1);
    }
    
    ZHPicker *pk = [[ZHPicker alloc]initWithDataSource:data];
    pk.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [pk setStateBlock:^(NSInteger state){
        
        if (pickerStateBlock) {
            pickerStateBlock(state);
        }
    }];
    [pk setSelectedObj:^(NSString *selectedObj,NSInteger index){
    
        if (selectedBlock) {
            selectedBlock(selectedObj,index);
        }
    }];

    [[UIApplication sharedApplication].keyWindow addSubview:pk];
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return myDataSource.count;
}

#pragma mark UIPickerView delegate methods
//对于的行显示什么标题
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
           forComponent:(NSInteger)component{
    
    return myDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    
    seletecdIndex = row;
    
    if (self.selectedObj) {
        self.selectedObj(myDataSource[row],row);
    }
}

- (IBAction)selectCurrtenRow:(id)sender{

    [self cancel];

    if (self.selectedObj) {
        self.selectedObj(myDataSource[seletecdIndex],seletecdIndex);
    }
}

- (IBAction)tapGestureAction:(UITapGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        [self cancel];
    }
}

- (void)cancel{

    if (self.stateBlock) {
        self.stateBlock(0);
    }
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.4 animations:^{
        
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

@end
