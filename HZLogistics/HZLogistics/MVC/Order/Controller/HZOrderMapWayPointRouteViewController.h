//
//  HZOrderMapWayPointRouteViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/12.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "UIImage+Rotate.h"

@interface HZOrderMapWayPointRouteViewController : BaseViewController<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, BMKRouteSearchDelegate>{
    
    bool isGeoSearch;
    
}

@property (nonatomic, strong)BMKMapView *mapView;


@property (nonatomic, strong)BMKLocationService *locService;

@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch2;

@property (nonatomic, strong)BMKRouteSearch *routesearch;

@property (nonatomic, strong)NSString *string;
@property (nonatomic, strong)NSString *string2;

@property (assign, nonatomic)float latitude;
@property (assign, nonatomic)float longitude;

@property (nonatomic, strong)NSString *addString;

@property (nonatomic, strong)NSString *latitudeStr;

@property (nonatomic, strong)NSString *longitudeStr;

@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *contoun;

@property (nonatomic, strong)BMKPlanNode *start;
@property (nonatomic, strong)BMKPlanNode *end;

@property (nonatomic, assign)NSInteger num;


@property (nonatomic, strong)NSString *startCityText;
@property (nonatomic, strong)NSString *startAddrText;
@property (nonatomic, strong)NSString *endCityText;
@property (nonatomic, strong)NSString *endAddrText;

@end
