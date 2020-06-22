//
//  CustomHandelTool.m
//  ScrollViewDemo
//
//  Created by lixinlot on 2020/4/10.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "CustomHandelTool.h"

#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@implementation CustomHandelTool

#pragma mark - 13位时间戳转换为年月日24小时制
+(NSString *)changeTime:(NSString *)timeString {
    // timeStampString 是服务器返回的13位时间戳
    NSString *timeStampString  = timeString;
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    
    return dateString;
}

#pragma mark - 根据当前时间戳 转换为次日凌晨时间
+ (int)getZeroWithTimeInterverl:(NSTimeInterval)timeInterval {
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];

    NSDateFormatter *dateFomater = [[NSDateFormatter alloc]init];
    dateFomater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *currentDateStr = [dateFomater stringFromDate:currentDate];
    NSLog(@"当前时间 = %@",currentDateStr);

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];

    NSDate *zeroDate = [calendar dateFromComponents:components];
    int zeroTimeInterval = (int)[zeroDate timeIntervalSince1970];
    
    NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:(zeroTimeInterval + 24*60*60)];
    NSString *testDateStr = [dateFomater stringFromDate:testDate];
    NSLog(@"零点时间 == %@", testDateStr);
    
    return zeroTimeInterval + 24*60*60;// zeroTimeInterval 是当天的0点 例如今天2020-03-19 16:30:30  ===> 2020-03-20 00:00:00
}

#pragma mark - 获取当前设备的唯一编号
+ (NSString *)getDeviceTerminalId {
    UIDevice *device = [UIDevice currentDevice];
    NSString *vendor = [[device identifierForVendor] UUIDString];
    return [NSString stringWithFormat:@"%@",vendor];
}

#pragma mark - Json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }else{
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if(err) {
            NSLog(@"json解析失败：%@",err);
            return nil;
        }
        return dic;
    }
}

#pragma mark - 判断字符串，不存在就用空字符串代替
+(NSString*)changeNullToBlank:(NSString*)str {
    if (!str) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",str];
}

#pragma mark -  链接生成二维码
+ (UIImage *)getUrlToErWeiCodePic:(NSString *)urlString {
    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    // 3. 将字符串转换成NSData
    NSData *data = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    return [CustomHandelTool createNonInterpolatedUIImageFormCIImage:outputImage withSize:[UIScreen mainScreen].bounds.size.width-70];//重绘二维码,使其显示清晰
}

#pragma mark - 根据CIImage生成指定大小的UIImage(处理模糊的方法)
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - 判断手机号合法性
+ (BOOL)checkPhone:(NSString *)phoneNumber {
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phoneNumber.length != 11){
        return NO;
    }else{
        NSString * MOBILE = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        
        BOOL isMatch = [regextestmobile evaluateWithObject:phoneNumber];
        return isMatch;
    }
}

#pragma mark - 给控件边框加虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

#pragma mark - 字符串如果小数点是00则取整
+(NSString *)pricePoint:(NSString *)price {
    NSString *string = price;
    NSRange range = [string rangeOfString:@"."];//匹配得到的下标
    if (range.length == 0) {
        return string;
    }
    NSLog(@"rang:%@",NSStringFromRange(range));
    NSString *str2 = [string substringFromIndex:range.location+1];//截取掉下标之后的字符串
    NSString *str1 = [string substringToIndex:range.location];//截取掉下标之前的字符串
    if (![str2 isEqualToString:@"00"]) {
        str1 = string;
    }
    str1 = [NSString stringWithFormat:@"%@",str1];
    NSLog(@"截取的值为：%@",str1);
    return str1;
}

#pragma mark - 字符串如果小数点是00则取整并加上￥
+(NSString *)newPricePoint:(NSString *)price {
    NSString *string = price;
    NSRange range = [string rangeOfString:@"."];//匹配得到的下标
    if (range.length == 0) {
        return [NSString stringWithFormat:@"¥%@",string];
    }
    NSLog(@"rang:%@",NSStringFromRange(range));
    NSString *str2 = [string substringFromIndex:range.location+1];//截取掉下标之后的字符串
    NSString *str1 = [string substringToIndex:range.location];//截取掉下标之前的字符串
    if (![str2 isEqualToString:@"00"]) {
        str1 = string;
    }
    str1 = [NSString stringWithFormat:@"¥%@",str1];
    NSLog(@"截取的值为：%@",str1);
    return str1;
}

#pragma mark - 价格富文本展示
+(NSMutableAttributedString *)priceShowPointWithString:(NSString *)string moneyFontSize:(NSInteger)moneyFontSize pointFontSize:(NSInteger)pointFontSize {
    if (string == nil) {
        string = @"";
    }
    NSMutableAttributedString *specsAtt_Str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange scpcsRange = [string rangeOfString:@"¥"];
    if (scpcsRange.length > 0) {
        [specsAtt_Str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:moneyFontSize] range:NSMakeRange(scpcsRange.location, scpcsRange.length)];
    }
    NSRange scpcsRange2 = [string rangeOfString:@"."];
    if (scpcsRange2.length > 0) {
        [specsAtt_Str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:pointFontSize] range:NSMakeRange(scpcsRange2.location, string.length-scpcsRange2.location)];
    }
    
    return specsAtt_Str;
}

#pragma mark - 数字过万转化
+(NSString *)numToThound:(NSString *)countStr type:(NSInteger)type {
    if (countStr.integerValue > 9999) {
        CGFloat count = countStr.integerValue/10000.0;
        NSInteger temp = count * 10;
        CGFloat a = temp / 10.0;
        if (type == 1) {
            return [NSString stringWithFormat:@"%.1fw",a];
        }
    }else{
        return countStr;
    }
    return countStr;
}

#pragma mark - 计算文本大小
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size;
}

#pragma mark - 根据路径获取文件大小
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(CGFloat totalSize))completion {
    NSFileManager *mgr =[NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isDirectory || !isExist) {
        NSException *exception = [NSException exceptionWithName:@"PathError" reason:@"需要传入的是文件夹路径，并且路径要存在！" userInfo:nil];
        [exception raise];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //获取文件夹下所有文件，包括子路径的子路径
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        CGFloat totalSize = 0;
        for (NSString *subPath in subPaths) {
            //获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            //判断隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            //判断是否文件夹
            BOOL isDircetory;
            //判断文件是否存在，并判断是否是文件夹
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDircetory];
            if (isDircetory || !isExist) continue;
            //获取文件属性
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            NSInteger size = [attr fileSize];
            totalSize += size;
        }
        //计算完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
}

#pragma mark - 根据路径移除文件
+ (void)removeDirectoryPath:(NSString *)directoryPath {
    //获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectoey;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectoey];
    
    if (!isExist || !isDirectoey) {
        NSException *exception = [NSException exceptionWithName:@"PathError" reason:@"需要传入的是文件夹路径，并且路径要存在！" userInfo:nil];
        [exception raise];
    }
    //获取cache文件夹下所有文件，不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *subPath in subPaths) {
        //拼接完整路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        //删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }
}

#pragma mark - 根据链接获取文件大小
+ (NSString *)getFileSize:(NSString *)url {
    NSFileManager *file = [NSFileManager defaultManager];
    
    NSDictionary *dict = [file attributesOfItemAtPath:url error:nil];
    
    unsigned long long size = [dict fileSize];
    
    NSString *fileSize;
    if (size >= 1048576) {//1048576bt = 1M  小于1m的显示KB 大于1m显示M
        fileSize = [NSString stringWithFormat:@"%.2lluM",size/1024/1024];
    }else{
        fileSize = [NSString stringWithFormat:@"%.1lluKB",size/1024];
    }
    return fileSize;
}

#pragma mark - 获取缓存大小
+ (NSString *)getCacheSize {
    //得到缓存路径
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSFileManager * manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    //首先判断是否存在缓存文件
    if ([manager fileExistsAtPath:path]) {
        NSArray * childFile = [manager subpathsAtPath:path];
        for (NSString * fileName in childFile) {
            //缓存文件绝对路径
            NSString * absolutPath = [path stringByAppendingPathComponent:fileName];
            size = size + [manager attributesOfItemAtPath:absolutPath error:nil].fileSize;
        }
        //计算sdwebimage的缓存和系统缓存总和
        //size = size + [[SDWebImageManager sharedManager].imageCache getSize];
    }
    NSString *sizeStr = [NSString stringWithFormat:@"%.2fM",size / 1024 / 1024];
    return sizeStr;
}

#pragma mark - 清除缓存
+ (void)cleanCache {
    //获取缓存路径
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSFileManager * manager = [NSFileManager defaultManager];
    //判断是否存在缓存文件
    if ([manager fileExistsAtPath:path]) {
        NSArray * childFile = [manager subpathsAtPath:path];
        //逐个删除缓存文件
        for (NSString *fileName in childFile) {
            NSString * absolutPat = [path stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:absolutPat error:nil];
        }
        //删除sdwebimage的缓存
//        [[SDWebImageManager sharedManager].imageCache clearMemory];
    }
    //这里是又调用了得到缓存文件大小的方法，是因为不确定是否删除了所有的缓存，所以要计算一遍，展示出来
    [self getCacheSize];
//    [MBProgressHUD showWithText:@"清除成功" toView:[UIApplication sharedApplication].keyWindow];
}

@end
