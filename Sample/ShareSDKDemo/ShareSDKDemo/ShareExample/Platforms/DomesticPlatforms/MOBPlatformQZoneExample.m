//
//  MOBPlatformQZoneExample.m
//  ShareSDKDemo
//
//  Created by maxl on 2019/12/19.
//  Copyright © 2019 mob. All rights reserved.
//  文档地址:https://www.mob.com/wiki/detailed?wiki=ShareSDK_chanpinjianjie&id=14

#import "MOBPlatformQZoneExample.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
@implementation MOBPlatformQZoneExample

+ (SSDKPlatformType)platformType{
    return SSDKPlatformSubTypeQZone;
}


- (void)setup{
    SSDKWEAK
    [self addListItemWithImage:MOBVideoShareIcon name:@"本地视频" method:^(MOBPlatformBaseModel * _Nonnull model, NSMutableDictionary * _Nonnull parameters) {
        SSDKSTRONG
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"mp4"];
        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"];
        NSURL *url = [NSURL URLWithString:path];
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized)
            {
                [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
                    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                    //iPad版本QQ 暂时未支持此功能
                    //通用参数设置
                    [parameters SSDKSetupShareParamsByText:SHARESDKDEMO_TEXT
                                                    images:path1
                                                       url:assetURL
                                                     title:@"Share SDK"
                                                      type:SSDKContentTypeVideo];
                    //平台定制
                    //            [parameters SSDKSetupQQParamsByText:SHARESDKDEMO_TEXT
                    //                                          title:@"Share SDK"
                    //                                            url:assetURL
                    //                                  audioFlashURL:nil
                    //                                  videoFlashURL:nil
                    //                                     thumbImage:nil
                    //                                         images:nil
                    //                                           type:SSDKContentTypeVideo
                    //                             forPlatformSubType:SSDKPlatformSubTypeQZone];
                    [self shareWithParameters:parameters];
                }];
            }else{
                UIAlertControllerAlertCreate(@"", @"存储到相册失败")
                .addDefaultAction(@"OK")
                .present();
            }
        }];
    }];
}

/**
 分享文字
 */
-(void)shareText
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置
    [parameters SSDKSetupShareParamsByText:@"Share SDK"
                                    images:nil
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeText];
    //平台定制
    //    [parameters SSDKSetupQQParamsByText:@"Share SDK"
    //                                  title:nil
    //                                    url:nil
    //                          audioFlashURL:nil
    //                          videoFlashURL:nil
    //                             thumbImage:nil
    //                                 images:nil
    //                                   type:SSDKContentTypeVideo
    //                     forPlatformSubType:SSDKPlatformSubTypeQZone];
    [self shareWithParameters:parameters];
}
/**
 分享图片
 */
- (void)shareImage
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *path1 = SHARESDKDEMO_IMAGE_LOCALPATH;
    //通用参数设置
    [parameters SSDKSetupShareParamsByText:SHARESDKDEMO_TEXT
                                    images:@[path1]
                                       url:nil
                                     title:@""
                                      type:SSDKContentTypeImage];
    //平台定制
    //    [parameters SSDKSetupQQParamsByText:@"Share SDK"
    //                                  title:nil
    //                                    url:nil
    //                          audioFlashURL:nil
    //                          videoFlashURL:nil
    //                             thumbImage:nil
    //                                 images:@[path1,path2,path3,path4]
    //                                   type:SSDKContentTypeImage
    //                     forPlatformSubType:SSDKPlatformSubTypeQZone];
    [self shareWithParameters:parameters];
}

- (void)shareTextImage{
    [self shareMutiImage];
}

/**
 分享图片
 */
- (void)shareMutiImage
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *path1 = SHARESDKDEMO_IMAGE_LOCALPATH;
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"shareImg" ofType:@"png"];
    //通用参数设置
    [parameters SSDKSetupShareParamsByText:SHARESDKDEMO_TEXT
                                    images:@[path1,path2]
                                       url:nil
                                     title:@""
                                      type:SSDKContentTypeImage];
    //平台定制
    //    [parameters SSDKSetupQQParamsByText:@"Share SDK"
    //                                  title:nil
    //                                    url:nil
    //                          audioFlashURL:nil
    //                          videoFlashURL:nil
    //                             thumbImage:nil
    //                                 images:@[path1,path2,path3,path4]
    //                                   type:SSDKContentTypeImage
    //                     forPlatformSubType:SSDKPlatformSubTypeQZone];
    [self shareWithParameters:parameters];
}

- (void)shareLink
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSData *data = [NSData dataWithContentsOfURL:SHARESDKDEMO_IMAGE_URL];
    //通用参数设置
    [parameters SSDKSetupShareParamsByText:SHARESDKDEMO_TEXT
                                    images:[UIImage imageWithData:data]
                                       url:[NSURL URLWithString:SHARESDKDEMO_URLSTRING]
                                     title:@"Share SDK"
                                      type:SSDKContentTypeWebPage];
    //平台定制
    //    [parameters SSDKSetupQQParamsByText:@"Share SDK Link Desc"
    //                                  title:@"Share SDK"
    //                                    url:[NSURL URLWithString:@"https://www.mob.com"]
    //                          audioFlashURL:nil
    //                          videoFlashURL:nil
    //                             thumbImage:nil
    //                                 images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
    //                                   type:SSDKContentTypeWebPage
    //                     forPlatformSubType:SSDKPlatformSubTypeQZone];
    
    [self shareWithParameters:parameters];
}

- (void)shareVideo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"mp4"];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"];
    NSURL *url = [NSURL URLWithString:path];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    __weak __typeof__ (self) weakSelf = self;
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if(status == PHAuthorizationStatusAuthorized)
        {
            [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                //iPad版本QQ 暂时未支持此功能
                //通用参数设置
                [parameters SSDKSetupShareParamsByText:SHARESDKDEMO_TEXT
                                                images:path1
                                                   url:assetURL
                                                 title:@"Share SDK"
                                                  type:SSDKContentTypeVideo];
                //平台定制
                //            [parameters SSDKSetupQQParamsByText:SHARESDKDEMO_TEXT
                //                                          title:@"Share SDK"
                //                                            url:assetURL
                //                                  audioFlashURL:nil
                //                                  videoFlashURL:nil
                //                                     thumbImage:nil
                //                                         images:nil
                //                                           type:SSDKContentTypeVideo
                //                             forPlatformSubType:SSDKPlatformSubTypeQZone];
               [weakSelf shareWithParameters:parameters];
            }];
        }else{
            UIAlertControllerAlertCreate(@"", @"存储到相册失败")
            .addDefaultAction(@"OK")
            .present();
        }
    }];
    
    
}

//本地视频
//- (void)shareVideo
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"mp4"];
//    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"];
//
//    NSURL *url = [NSURL URLWithString:path];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters SSDKSetupShareParamsByText:SHARESDKDEMO_TEXT
//                                    images:path1
//                                       url:url
//                                        title:@"Share SDK"
//                                        type:SSDKContentTypeVideo];
//
//    //平台定制
////    [parameters SSDKSetupQQParamsByText:SHARESDKDEMO_TEXT
////                                  title:@"Share SDK"
////                                    url:url
////                          audioFlashURL:nil
////                          videoFlashURL:nil
////                             thumbImage:nil
////                                 images:nil
////                                   type:SSDKContentTypeVideo
////                     forPlatformSubType:SSDKPlatformSubTypeQZone];
//    [self shareWithParameters:parameters];
//
//}
@end
