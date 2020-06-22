//
//  CustomHandelTool.h
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/4/10.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomHandelTool : NSObject

///13位时间戳转换为年月日24小时制
+(NSString *)changeTime:(NSString *)timeString;
///根据当前时间戳 转换为次日凌晨时间
+ (int)getZeroWithTimeInterverl:(NSTimeInterval)timeInterval;
///获取当前设备的唯一编号
+ (NSString *)getDeviceTerminalId;
///Json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
///判断字符串，不存在就用空字符串代替
+(NSString*)changeNullToBlank:(NSString*)str;
///链接生成二维码
+ (UIImage *)getUrlToErWeiCodePic:(NSString *)urlString;
///判断手机号合法性
+ (BOOL)checkPhone:(NSString *)phoneNumber;
///给控件边框加虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
///字符串如果小数点是00则取整
+(NSString *)pricePoint:(NSString *)price;
///字符串如果小数点是00则取整并加上￥
+(NSString *)newPricePoint:(NSString *)price;
///价格富文本展示
+(NSMutableAttributedString *)priceShowPointWithString:(NSString *)string moneyFontSize:(NSInteger)moneyFontSize pointFontSize:(NSInteger)pointFontSize;
///数字过万转化
+(NSString *)numToThound:(NSString *)countStr type:(NSInteger)type;
///计算文本大小
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
///根据路径获取文件大小
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(CGFloat totalSize))completion;
///根据路径移除文件
+ (void)removeDirectoryPath:(NSString *)directoryPath;
///根据链接获取文件大小
+ (NSString *)getFileSize:(NSString *)url;
///获取缓存大小
+ (NSString *)getCacheSize;
///清理缓存
+ (void)cleanCache;


@end

NS_ASSUME_NONNULL_END
