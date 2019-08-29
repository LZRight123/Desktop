// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "CCHelpTool.h"
#import "__AADevice.h"


#pragma mark -
#pragma mark - AADevice
%hook AADevice
- (NSString *)model { %log; NSString * r = %orig; return r; }
- (NSString *)modelDisplayName { %log; NSString * r = %orig; return r; }
- (NSString *)modelLargePhotoURL1x { %log; NSString * r = %orig; return r; }
- (NSString *)modelLargePhotoURL2x { %log; NSString * r = %orig; return r; }
- (NSString *)modelSmallPhotoURL1x { %log; NSString * r = %orig; return r; }
- (NSString *)modelSmallPhotoURL2x { %log; NSString * r = %orig; return r; }
- (NSString *)name { %log; NSString * r = %orig; return r; }
- (id)initWithDictionary:(id)arg1 { %log; id r = %orig; return r; }
%end














#pragma mark -
#pragma mark - AADeviceInfo
%hook AADeviceInfo
+ (id)apnsToken { %log; id r = %orig; return r; }
+ (id)appleIDClientIdentifier { %log; id r = %orig; return r; }
+ (id)clientInfoHeader { %log; id r = %orig; return r; }
+ (id)infoDictionary { %log; id r = %orig; return r; }
+ (id)osVersion { %log; id r = %orig; return r; }
+ (id)productVersion { %log; id r = %orig; return r; }
+ (id)serialNumber { %log; id r = %orig; return r; }
+ (id)udid { %log; id r = %orig; return r; }
+ (id)userAgentHeader { %log; id r = %orig; return r; }
- (id)apnsToken { %log; id r = %orig; return r; }
- (id)appleIDClientIdentifier { %log; id r = %orig; return r; }
- (id)buildVersion { %log; id r = %orig; return r; }
- (id)clientInfoHeader { %log; id r = %orig; return r; }
- (id)deviceBackingColor { %log; id r = %orig; return r; }
- (id)deviceClass { %log; id r = %orig; return r; }
- (id)deviceColor { %log; id r = %orig; return r; }
- (id)deviceCoverGlassColor { %log; id r = %orig; return r; }
- (id)deviceEnclosureColor { %log; id r = %orig; return r; }
- (id)deviceHousingColor { %log; id r = %orig; return r; }
- (id)deviceInfoDictionary { %log; id r = %orig; return r; }
- (id)deviceName { %log; id r = %orig; return r; }
- (bool)hasCellularCapability { %log; bool r = %orig; return r; }
- (id)internationalMobileEquipmentIdentity { %log; id r = %orig; return r; }
- (id)mobileEquipmentIdentifier { %log; id r = %orig; return r; }
- (id)modelNumber { %log; id r = %orig; return r; }
- (id)osName { %log; id r = %orig; return r; }
- (id)osVersion { %log; id r = %orig; return r; }
- (id)productType { %log; id r = %orig; return r; }
- (id)productVersion { %log; id r = %orig; return r; }
- (id)regionCode { %log; id r = %orig; return r; }
- (id)serialNumber { %log; id r = %orig; return r; }
- (id)storageCapacity { %log; id r = %orig; return r; }
- (id)udid { %log; id r = %orig; return r; }
- (id)userAgent1Header { %log; id r = %orig; return r; }
- (id)wifiMacAddress { %log; id r = %orig; return r; }
%end
