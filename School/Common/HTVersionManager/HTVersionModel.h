//
//  HTVersionModel.h
//  School
//
//  Created by hublot on 2017/6/14.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTUpdateResults;
@interface HTVersionModel : NSObject

@property (nonatomic, strong) NSArray<HTUpdateResults *> *results;

@property (nonatomic, assign) NSInteger resultCount;

@end
@interface HTUpdateResults : NSObject

@property (nonatomic, copy) NSString *primaryGenreName;

@property (nonatomic, copy) NSString *artworkUrl100;

@property (nonatomic, copy) NSString *currency;

@property (nonatomic, copy) NSString *artworkUrl512;

@property (nonatomic, strong) NSArray<NSString *> *ipadScreenshotUrls;

@property (nonatomic, copy) NSString *fileSizeBytes;

@property (nonatomic, strong) NSArray<NSString *> *genres;

@property (nonatomic, strong) NSArray<NSString *> *languageCodesISO2A;

@property (nonatomic, copy) NSString *artworkUrl60;

@property (nonatomic, strong) NSArray<NSString *> *supportedDevices;

@property (nonatomic, copy) NSString *trackViewUrl;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *bundleId;

@property (nonatomic, copy) NSString *artistViewUrl;

@property (nonatomic, copy) NSString *releaseDate;

@property (nonatomic, strong) NSArray *appletvScreenshotUrls;

@property (nonatomic, assign) BOOL isGameCenterEnabled;

@property (nonatomic, copy) NSString *wrapperType;

@property (nonatomic, strong) NSArray<NSString *> *genreIds;

@property (nonatomic, assign) NSInteger trackId;

@property (nonatomic, copy) NSString *minimumOsVersion;

@property (nonatomic, copy) NSString *formattedPrice;

@property (nonatomic, assign) NSInteger primaryGenreId;

@property (nonatomic, copy) NSString *currentVersionReleaseDate;

@property (nonatomic, assign) NSInteger artistId;

@property (nonatomic, copy) NSString *trackContentRating;

@property (nonatomic, copy) NSString *artistName;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *trackCensoredName;

@property (nonatomic, copy) NSString *trackName;

@property (nonatomic, copy) NSString *kind;

@property (nonatomic, strong) NSArray<NSString *> *features;

@property (nonatomic, copy) NSString *contentAdvisoryRating;

@property (nonatomic, strong) NSArray<NSString *> *screenshotUrls;

@property (nonatomic, copy) NSString *releaseNotes;

@property (nonatomic, assign) BOOL isVppDeviceBasedLicensingEnabled;

@property (nonatomic, copy) NSString *sellerName;

@property (nonatomic, strong) NSArray *advisories;

@end
