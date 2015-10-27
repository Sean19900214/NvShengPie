//
//  NvShengPie-Bridging-Header.h
//  NvShengPie
//
//  Created by ZhangYuting on 15/10/25.
//  Copyright © 2015年 wjt. All rights reserved.
//

#import "ZHPicker.h"
#import "KeyChainManager.h"
#import "HUD.h"
#import "ZHDatePicker.h"
#import "JKNotifier.h"



//#import "UIImageView+WebCache.h"
//#import "UIButton+WebCache.h"
#import "UITableView+FDTemplateLayoutCell.h"



#import <CommonCrypto/CommonCrypto.h>
//#import "DWSDK.h"
//#import <pop/POP.h>
//#import <KS3YunSDK/KS3YunSDK.h>
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "MiPushSDK.h"
//#import "MobClick.h"
//#import "AMPopTip.h"
//#import "XHImageViewer.h"
//#import "ZHExampleVideoPlayer.h"
#import "CTAssetsPickerController.h"
#import "ZHVideoTools.h"
#import "ZHFileManager.h"
#import "ALAssetsLibrary+ZHExpand.h"
#import "NSNull+ZHNatural.h"


#define RGBA(r,g,b,a)           [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:(a)]

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

// View 坐标(x,y)和宽高(width,height)
#define ZHX(v)                    (v).frame.origin.x
#define ZHY(v)                    (v).frame.origin.y
#define ZHWIDTH(v)                (v).frame.size.width
#define ZHHEIGHT(v)               (v).frame.size.height


/**
 *  格式化输出日志
 *
 */
#define DEBUGLOG
#ifdef DEBUGLOG
#define ZHLOG( s, ... ) NSLog( @"<类名：%@ 位置：%d>  类方法：%s 输出：%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define ZHLOG( s, ... ) do {} while (0)
#endif

//#endif /* NvShengPie_Bridging_Header_h */
