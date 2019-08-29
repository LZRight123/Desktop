//
//  __LSApplication.h
//  QiankaDylib
//
//  Created by 梁泽 on 2019/7/15.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSInstallProgressDelegate;
@class LSInstallProgressList;
@class LSApplicationWorkspaceRemoteObserver;
@class LSBundleProxy;
@class _LSApplicationState;
@class _LSDiskUsage;


#pragma mark -
#pragma mark - LSApplicationProxy
@interface LSApplicationProxy : NSObject 
@property (nonatomic, readonly) NSNumber *ODRDiskUsage;
@property (nonatomic, readonly) NSArray *UIBackgroundModes;
@property (nonatomic, readonly) NSArray *VPNPlugins;
@property (nonatomic, readonly) NSArray *activityTypes;
@property (nonatomic, readonly) _LSApplicationState *appState;
@property (nonatomic, readonly) NSArray *appTags;
@property (nonatomic, readonly) NSString *applicationDSID;
@property (nonatomic, readonly) NSString *applicationIdentifier;
@property (nonatomic, readonly) NSString *applicationType;
@property (nonatomic, readonly) NSString *applicationVariant;
@property (nonatomic, readonly) NSArray *audioComponents;
@property (nonatomic, readonly) NSNumber *betaExternalVersionIdentifier;
@property (nonatomic, readonly) int bundleModTime;
@property (nonatomic, readonly) NSString *companionApplicationIdentifier;
@property (readonly) NSString *complicationPrincipalClass;
@property (nonatomic, readonly) NSArray *deviceFamily;
@property (nonatomic, readonly) NSUUID *deviceIdentifierForAdvertising;
@property (nonatomic, readonly) NSUUID *deviceIdentifierForVendor;
@property (nonatomic, readonly) NSArray *directionsModes;
@property (nonatomic, readonly) _LSDiskUsage *diskUsage;
@property (nonatomic, readonly) NSNumber *downloaderDSID;
@property (nonatomic, readonly) NSNumber *dynamicDiskUsage;
@property (nonatomic, readonly) NSArray *externalAccessoryProtocols;
@property (nonatomic, readonly) NSNumber *externalVersionIdentifier;
@property (nonatomic, readonly) NSNumber *familyID;
@property (nonatomic, readonly) bool fileSharingEnabled;
@property (readonly) bool hasComplication;
@property (nonatomic, readonly) bool hasCustomNotification;
@property (nonatomic, readonly) bool hasGlance;
@property (nonatomic, readonly) bool hasMIDBasedSINF;
@property (nonatomic, readonly) bool hasSettingsBundle;
@property (nonatomic, readonly) bool iconIsPrerendered;
@property (nonatomic, readonly) NSProgress *installProgress;
@property (nonatomic, readonly) unsigned long long installType;
@property (nonatomic, readonly) bool isAdHocCodeSigned;
@property (nonatomic, readonly) bool isAppUpdate;
@property (nonatomic, readonly) bool isBetaApp;
@property (nonatomic, readonly) bool isInstalled;
@property (nonatomic, readonly) bool isLaunchProhibited;
@property (nonatomic, readonly) bool isNewsstandApp;
@property (nonatomic, readonly) bool isPlaceholder;
@property (nonatomic, readonly) bool isPurchasedReDownload;
@property (nonatomic, readonly) bool isRestricted;
@property (nonatomic, readonly) bool isStickerProvider;
@property (nonatomic, readonly) bool isWatchKitApp;
@property (nonatomic, readonly) NSNumber *itemID;
@property (nonatomic, readonly) NSString *itemName;
@property (nonatomic, readonly) NSString *minimumSystemVersion;
@property (nonatomic, readonly) bool missingRequiredSINF;
@property (nonatomic, readonly) unsigned long long originalInstallType;
@property (nonatomic, readonly) NSArray *plugInKitPlugins;
@property (nonatomic, readonly) NSString *preferredArchitecture;
@property (nonatomic, copy) NSArray *privateDocumentIconNames;
@property (nonatomic, retain) LSApplicationProxy *privateDocumentTypeOwner;
@property (nonatomic, readonly) NSNumber *purchaserDSID;
@property (nonatomic, readonly) NSString *ratingLabel;
@property (nonatomic, readonly) NSNumber *ratingRank;
@property (nonatomic, readonly) NSDate *registeredDate;
@property (getter=isRemoveableSystemApp, nonatomic, readonly) bool removeableSystemApp;
@property (getter=isRemovedSystemApp, nonatomic, readonly) bool removedSystemApp;
@property (nonatomic, readonly) NSArray *requiredDeviceCapabilities;
@property (nonatomic, readonly) NSString *sdkVersion;
@property (nonatomic, readonly) NSString *shortVersionString;
@property (nonatomic, readonly) bool shouldSkipWatchAppInstall;
@property (nonatomic, readonly) NSString *sourceAppIdentifier;
@property (nonatomic, readonly) NSNumber *staticDiskUsage;
@property (nonatomic, readonly) NSString *storeCohortMetadata;
@property (nonatomic, readonly) NSNumber *storeFront;
@property (readonly) NSArray *supportedComplicationFamilies;
@property (nonatomic, readonly) bool supportsAudiobooks;
@property (nonatomic, readonly) bool supportsExternallyPlayableContent;
@property (nonatomic, readonly) bool supportsODR;
@property (nonatomic, readonly) bool supportsOpenInPlace;
@property (nonatomic, readonly) bool supportsPurgeableLocalStorage;
@property (nonatomic, readonly) NSString *teamID;
@property (nonatomic) bool userInitiatedUninstall;
@property (nonatomic, readonly) NSString *vendorName;
@property (nonatomic, readonly) NSString *watchKitVersion;
@property (getter=isWhitelisted, nonatomic, readonly) bool whitelisted;

- (NSString *)applicationIdentifier;
- (NSNumber *)itemID;
+ (LSApplicationProxy *)applicationProxyForIdentifier:(id)arg1;
+ (id)applicationProxyForIdentifier:(id)arg1 placeholder:(bool)arg2;
+ (bool)supportsSecureCoding;

// Image: /System/Library/Frameworks/MobileCoreServices.framework/MobileCoreServices

+ (id)applicationProxyForBundleURL:(id)arg1;
+ (id)applicationProxyForCompanionIdentifier:(id)arg1;
+ (id)applicationProxyForItemID:(id)arg1;
+ (id)applicationProxyWithBundleUnitID:(unsigned int)arg1;

- (id)ODRDiskUsage;
- (id)UIBackgroundModes;
- (bool)UPPValidated;
- (id)VPNPlugins;
- (id)_initWithBundleUnit:(unsigned int)arg1 applicationIdentifier:(id)arg2;
- (id)activityTypes;
- (id)appState;
- (id)appTags;
- (id)applicationDSID;
- (id)applicationType;
- (id)applicationVariant;
- (id)audioComponents;
- (id)betaExternalVersionIdentifier;
- (int)bundleModTime;
- (void)clearAdvertisingIdentifier;
- (id)companionApplicationIdentifier;
- (id)complicationPrincipalClass;
- (void)dealloc;
- (id)description;
- (id)deviceFamily;
- (id)deviceIdentifierForAdvertising;
- (id)deviceIdentifierForVendor;
- (id)directionsModes;
- (id)diskUsage;
- (id)downloaderDSID;
- (id)dynamicDiskUsage;
- (void)encodeWithCoder:(id)arg1;
- (id)externalAccessoryProtocols;
- (id)externalVersionIdentifier;
- (id)familyID;
- (bool)fileSharingEnabled;
- (bool)hasComplication;
- (bool)hasCustomNotification;
- (bool)hasGlance;
- (bool)hasMIDBasedSINF;
- (bool)hasSettingsBundle;
- (id)iconDataForVariant:(int)arg1;
- (bool)iconIsPrerendered;
- (id)iconStyleDomain;
- (id)initWithCoder:(id)arg1;
- (id)installProgress;
- (id)installProgressSync;
- (unsigned long long)installType;
- (bool)isAdHocCodeSigned;
- (bool)isAppUpdate;
- (bool)isBetaApp;
- (bool)isInstalled;
- (bool)isLaunchProhibited;
- (bool)isNewsstandApp;
- (bool)isPlaceholder;
- (bool)isPurchasedReDownload;
- (bool)isRemoveableSystemApp;
- (bool)isRemovedSystemApp;
- (bool)isRestricted;
- (bool)isStickerProvider;
- (bool)isSystemOrInternalApp;
- (bool)isWatchKitApp;
- (bool)isWhitelisted;
- (id)itemName;
- (id)localizedName;
- (id)localizedNameForContext:(id)arg1;
- (id)localizedShortName;
- (id)minimumSystemVersion;
- (bool)missingRequiredSINF;
- (unsigned long long)originalInstallType;
- (id)plugInKitPlugins;
- (id)preferredArchitecture;
- (id)privateDocumentIconNames;
- (id)privateDocumentTypeOwner;
- (bool)profileValidated;
- (id)purchaserDSID;
- (id)ratingLabel;
- (id)ratingRank;
- (id)registeredDate;
- (id)requiredDeviceCapabilities;
- (id)resourcesDirectoryURL;
- (id)sdkVersion;
- (void)setPrivateDocumentIconNames:(id)arg1;
- (void)setPrivateDocumentTypeOwner:(id)arg1;
- (void)setUserInitiatedUninstall:(bool)arg1;
- (NSString *)shortVersionString;
- (bool)shouldSkipWatchAppInstall;
- (id)sourceAppIdentifier;
- (id)staticDiskUsage;
- (id)storeCohortMetadata;
- (id)storeFront;
- (id)supportedComplicationFamilies;
- (bool)supportsAudiobooks;
- (bool)supportsExternallyPlayableContent;
- (bool)supportsODR;
- (bool)supportsOpenInPlace;
- (bool)supportsPurgeableLocalStorage;
- (id)teamID;
- (id)uniqueIdentifier;
- (bool)userInitiatedUninstall;
- (id)vendorName;
- (id)watchKitVersion;

// Image: /System/Library/Frameworks/Intents.framework/Intents

- (bool)_inapptrust_isFirstParty;
- (id)__ck_messagesPluginKitProxy;

// Image: /System/Library/PrivateFrameworks/UserNotificationsServer.framework/UserNotificationsServer

+ (id)uns_bundleForBundleIdentifier:(id)arg1;

- (bool)_uns_isReallyInstalled;
- (id)uns_bundle;
- (id)uns_infoDictionary;
- (bool)uns_isSystemApplication;
- (id)uns_path;
- (bool)uns_requiresLocalNotifications;
- (bool)uns_sdkVersionOnOrLaterThan:(id)arg1;
- (bool)uns_shouldUseDefaultDataProvider;
- (bool)uns_usesCloudKit;
- (bool)uns_usesLocalNotifications;

@end



#pragma mark -
#pragma mark - LSPlugInKitProxy
@interface LSPlugInKitProxy : NSObject
@property (nonatomic, readonly) LSBundleProxy *containingBundle;
@property (nonatomic, readonly) NSDictionary *infoPlist;
@property (nonatomic, readonly) bool isOnSystemPartition;
@property (nonatomic, readonly) NSString *originalIdentifier;
@property (nonatomic, readonly) NSString *pluginIdentifier;
@property (nonatomic, readonly) NSDictionary *pluginKitDictionary;
@property (nonatomic, readonly) NSUUID *pluginUUID;
@property (nonatomic, readonly) NSString *protocol;
@property (nonatomic, readonly) NSDate *registrationDate;
@property (nonatomic, readonly) NSString *teamID;

+ (bool)supportsSecureCoding;
- (LSApplicationProxy *)containingBundle;
- (NSString *)pluginIdentifier;
- (NSString *)pluginUUID;
- (NSString *)teamID;

// Image: /System/Library/Frameworks/MobileCoreServices.framework/MobileCoreServices
+ (id)containingBundleIdentifiersForPlugInBundleIdentifiers:(id)arg1 error:(id*)arg2;
+ (id)plugInKitProxyForPlugin:(unsigned int)arg1;
+ (id)plugInKitProxyForUUID:(id)arg1 bundleIdentifier:(id)arg2 pluginIdentifier:(id)arg3 effectiveIdentifier:(id)arg4 version:(id)arg5 bundleURL:(id)arg6;
+ (id)pluginKitProxyForIdentifier:(id)arg1;
+ (id)pluginKitProxyForURL:(id)arg1;
+ (id)pluginKitProxyForUUID:(id)arg1;

- (bool)UPPValidated;
- (id)_initWithPlugin:(unsigned int)arg1;
- (id)_initWithUUID:(id)arg1 bundleIdentifier:(id)arg2 pluginIdentifier:(id)arg3 effectiveIdentifier:(id)arg4 version:(id)arg5 bundleURL:(id)arg6;
- (id)_valueForEqualityTesting;
- (id)boundIconsDictionary;
- (void)dealloc;
- (id)description;
- (void)encodeWithCoder:(id)arg1;
- (id)iconDataForVariant:(int)arg1;
- (id)infoPlist;
- (id)initWithCoder:(id)arg1;
- (bool)isOnSystemPartition;
- (id)localizedName;
- (id)localizedShortName;
- (id)objectForInfoDictionaryKey:(id)arg1 ofClass:(Class)arg2 inScope:(unsigned long long)arg3;
- (id)originalIdentifier;
- (bool)pluginCanProvideIcon;
- (id)pluginKitDictionary;
- (bool)profileValidated;
- (id)protocol;
- (id)registrationDate;

// Image: /System/Library/Frameworks/UserNotifications.framework/UserNotifications

- (id)_un_applicationBundleURL;

@end


#pragma mark -
#pragma mark - LSApplicationWorkspace
// Image: /System/Library/Frameworks/MobileCoreServices.framework
@interface LSApplicationWorkspace : NSObject
@property (readonly) NSXPCConnection *connection;
@property (readonly) NSMutableDictionary *createdInstallProgresses;
@property (readonly) LSInstallProgressDelegate *delegateProxy;
@property (readonly) LSInstallProgressList *observedInstallProgresses;
@property (readonly) LSApplicationWorkspaceRemoteObserver *remoteObserver;


+ (id)activeManagedConfigurationRestrictionUUIDs;
+ (id)callbackQueue;
+ (id)defaultWorkspace;

- (id)URLOverrideForURL:(id)arg1;
- (id)URLSchemesOfType:(long long)arg1;
- (void)_LSClearSchemaCaches;
- (void)_LSFailedToOpenURL:(id)arg1 withBundle:(id)arg2;
- (bool)_LSPrivateDatabaseNeedsRebuild;
- (bool)_LSPrivateRebuildApplicationDatabasesForSystemApps:(bool)arg1 internal:(bool)arg2 user:(bool)arg3;
- (void)_LSPrivateSyncWithMobileInstallation;
- (void)addObserver:(id)arg1;
- (id)allApplications;
- (id)allInstalledApplications;
- (id)applicationForOpeningResource:(id)arg1;
- (id)applicationForUserActivityDomainName:(id)arg1;
- (id)applicationForUserActivityType:(id)arg1;
- (bool)applicationIsInstalled:(id)arg1;
- (id)applicationProxiesWithPlistFlags:(unsigned int)arg1 bundleFlags:(unsigned long long)arg2;
- (id)applicationsAvailableForHandlingURLScheme:(id)arg1;
- (id)applicationsAvailableForOpeningDocument:(id)arg1;
- (id)applicationsAvailableForOpeningURL:(id)arg1;
- (id)applicationsAvailableForOpeningURL:(id)arg1 legacySPI:(bool)arg2;
- (id)applicationsForUserActivityType:(id)arg1;
- (id)applicationsForUserActivityType:(id)arg1 limit:(unsigned long long)arg2;
- (id)applicationsOfType:(unsigned long long)arg1;
- (id)applicationsWithAudioComponents;
- (id)applicationsWithUIBackgroundModes;
- (id)applicationsWithVPNPlugins;
- (id)bundleIdentifiersForMachOUUIDs:(id)arg1 error:(id*)arg2;
- (void)clearAdvertisingIdentifier;
- (void)clearCreatedProgressForBundleID:(id)arg1;
- (id)connection;
- (id)createdInstallProgresses;
- (void)dealloc;
- (id)delegateProxy;
- (id)deviceIdentifierForAdvertising;
- (id)deviceIdentifierForVendor;
- (id)directionsApplications;
- (bool)downgradeApplicationToPlaceholder:(id)arg1 withOptions:(id)arg2 error:(id*)arg3;
- (void)enumerateApplicationsForSiriWithBlock:(id /* block */)arg1;
- (void)enumerateApplicationsOfType:(unsigned long long)arg1 block:(id /* block */)arg2;
- (void)enumerateApplicationsOfType:(unsigned long long)arg1 legacySPI:(bool)arg2 block:(id /* block */)arg3;
- (void)enumerateBundlesOfType:(unsigned long long)arg1 block:(id /* block */)arg2;
- (void)enumerateBundlesOfType:(unsigned long long)arg1 legacySPI:(bool)arg2 block:(id /* block */)arg3;
- (void)enumerateBundlesOfType:(unsigned long long)arg1 usingBlock:(id /* block */)arg2;
- (void)enumeratePluginsMatchingQuery:(id)arg1 withBlock:(id /* block */)arg2;
- (bool)establishConnection;
- (bool)getClaimedActivityTypes:(id*)arg1 domains:(id*)arg2;
- (unsigned long long)getInstallTypeForOptions:(id)arg1 andApp:(id)arg2;
- (void)getKnowledgeUUID:(id*)arg1 andSequenceNumber:(id*)arg2;
- (bool)installApplication:(id)arg1 withOptions:(id)arg2;
- (bool)installApplication:(id)arg1 withOptions:(id)arg2 error:(id*)arg3;
- (bool)installApplication:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 usingBlock:(id /* block */)arg4;
- (id)installBundle:(id)arg1 withOptions:(id)arg2 usingBlock:(id /* block */)arg3 forApp:(id)arg4 withError:(id*)arg5 outInstallProgress:(id*)arg6;
- (bool)installPhaseFinishedForProgress:(id)arg1;
- (id)installProgressForApplication:(id)arg1 withPhase:(unsigned long long)arg2;
- (id)installProgressForBundleID:(id)arg1 makeSynchronous:(unsigned char)arg2;
- (id)installedPlugins;
- (bool)invalidateIconCache:(id)arg1;
- (bool)isApplicationAvailableToOpenURL:(id)arg1 error:(id*)arg2;
- (bool)isApplicationAvailableToOpenURL:(id)arg1 includePrivateURLSchemes:(bool)arg2 error:(id*)arg3;
- (bool)isApplicationAvailableToOpenURLCommon:(id)arg1 includePrivateURLSchemes:(bool)arg2 error:(id*)arg3;
- (id)legacyApplicationProxiesListWithType:(unsigned long long)arg1;
- (id)machOUUIDsForBundleIdentifiers:(id)arg1 error:(id*)arg2;
- (id)observedInstallProgresses;
- (bool)openApplicationWithBundleID:(id)arg1;
- (bool)openSensitiveURL:(id)arg1 withOptions:(id)arg2;
- (bool)openSensitiveURL:(id)arg1 withOptions:(id)arg2 error:(id*)arg3;
- (bool)openURL:(id)arg1;
- (bool)openURL:(id)arg1 withOptions:(id)arg2;
- (bool)openURL:(id)arg1 withOptions:(id)arg2 error:(id*)arg3;
- (void)openUserActivity:(id)arg1 withApplicationProxy:(id)arg2 completionHandler:(id /* block */)arg3;
- (void)openUserActivity:(id)arg1 withApplicationProxy:(id)arg2 options:(id)arg3 completionHandler:(id /* block */)arg4;
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 uniqueDocumentIdentifier:(id)arg3 sourceIsManaged:(bool)arg4 userInfo:(id)arg5 delegate:(id)arg6;
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 uniqueDocumentIdentifier:(id)arg3 userInfo:(id)arg4;
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 uniqueDocumentIdentifier:(id)arg3 userInfo:(id)arg4 delegate:(id)arg5;
- (id)operationToOpenResource:(id)arg1 usingApplication:(id)arg2 userInfo:(id)arg3;
- (id)placeholderApplications;
- (id)pluginsMatchingQuery:(id)arg1 applyFilter:(id /* block */)arg2;
- (id)pluginsWithIdentifiers:(id)arg1 protocols:(id)arg2 version:(id)arg3;
- (id)pluginsWithIdentifiers:(id)arg1 protocols:(id)arg2 version:(id)arg3 applyFilter:(id /* block */)arg4;
- (id)pluginsWithIdentifiers:(id)arg1 protocols:(id)arg2 version:(id)arg3 withFilter:(id /* block */)arg4;
- (id)privateURLSchemes;
- (id)publicURLSchemes;
- (bool)registerApplication:(id)arg1;
- (bool)registerApplicationDictionary:(id)arg1;
- (bool)registerApplicationDictionary:(id)arg1 withObserverNotification:(int)arg2;
- (bool)registerBundleWithInfo:(id)arg1 options:(id)arg2 type:(unsigned long long)arg3 progress:(id)arg4;
- (bool)registerPlugin:(id)arg1;
- (id)remoteObserver;
- (void)removeInstallProgressForBundleID:(id)arg1;
- (void)removeObserver:(id)arg1;
- (id)removedSystemApplications;
- (bool)restoreSystemApplication:(id)arg1;
- (void)scanForApplicationStateChangesFromRank:(id)arg1 toRank:(id)arg2;
- (void)scanForApplicationStateChangesFromWhitelist:(id)arg1 to:(id)arg2;
- (void)sendApplicationStateChangedNotificationsFor:(id)arg1;
- (void)sendInstallNotificationForApp:(id)arg1 withPlugins:(id)arg2;
- (void)sendUninstallNotificationForApp:(id)arg1 withPlugins:(id)arg2;
- (bool)uninstallApplication:(id)arg1 withOptions:(id)arg2;
- (bool)uninstallApplication:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 usingBlock:(id /* block */)arg4;
- (bool)uninstallApplication:(id)arg1 withOptions:(id)arg2 usingBlock:(id /* block */)arg3;
- (bool)uninstallSystemApplication:(id)arg1 withOptions:(id)arg2 usingBlock:(id /* block */)arg3;
- (bool)unregisterApplication:(id)arg1;
- (bool)unregisterPlugin:(id)arg1;
- (id)unrestrictedApplications;
- (bool)updateRecordForApp:(id)arg1 withSINF:(id)arg2 iTunesMetadata:(id)arg3 error:(id*)arg4;
- (bool)updateSINFWithData:(id)arg1 forApplication:(id)arg2 options:(id)arg3 error:(id*)arg4;
- (bool)updateiTunesMetadataWithData:(id)arg1 forApplication:(id)arg2 options:(id)arg3 error:(id*)arg4;

// Image: /System/Library/Frameworks/SafariServices.framework/SafariServices

- (void)_sf_openURL:(id)arg1 withOptions:(id)arg2 completionHandler:(id /* block */)arg3;

@end






#pragma mark -
#pragma mark - LSApplicationRestrictionsManager
@interface LSApplicationRestrictionsManager : NSObject
@property (getter=isAdTrackingEnabled, readonly) bool adTrackingEnabled;
@property (readonly) NSSet *blacklistedBundleIDs;
@property (readonly) NSNumber *maximumRating;
@property (getter=isOpenInRestrictionInEffect, readonly) bool openInRestrictionInEffect;
@property (readonly) NSSet *removedSystemApplications;
@property (readonly) NSSet *restrictedBundleIDs;
@property (getter=isWhitelistEnabled, readonly) bool whitelistEnabled;
@property (readonly) NSSet *whitelistedBundleIDs;

+ (id)activeRestrictionIdentifiers;
+ (id)sharedInstance;

- (id)_LSResolveIdentifiers:(id)arg1;
- (void)addPendingChanges:(id)arg1;
- (id)allowedOpenInAppBundleIDsAfterApplyingFilterToAppBundleIDs:(id)arg1 originatingAppBundleID:(id)arg2 originatingAccountIsManaged:(bool)arg3;
- (void)beginListeningForChanges;
- (id)blacklistedBundleID;
- (id)blacklistedBundleIDs;
- (id)calculateSetDifference:(id)arg1 and:(id)arg2;
- (void)clearAllValues;
- (void)clearPendingChanges;
- (void)dealloc;
- (void)handleMCEffectiveSettingsChanged;
- (void)handleMCRemovedSystemAppsChanged;
- (id)init;
- (bool)isAdTrackingEnabled;
- (bool)isAppExtensionRestricted:(id)arg1;
- (bool)isApplicationRemoved:(id)arg1;
- (bool)isApplicationRestricted:(id)arg1;
- (bool)isApplicationRestricted:(id)arg1 checkFeatureRestrictions:(bool)arg2;
- (bool)isFeatureAllowed:(unsigned long long)arg1;
- (bool)isOpenInRestrictionInEffect;
- (bool)isRatingAllowed:(id)arg1;
- (bool)isWhitelistEnabled;
- (id)maximumRating;
- (id)pendingChanges;
- (id)removedSystemApplications;
- (id)restrictedBundleIDs;
- (bool)setApplication:(id)arg1 removed:(bool)arg2;
- (void)setBlacklistedBundleIDs:(id)arg1;
- (void)setRemovedSystemApplications:(id)arg1;
- (void)setRestrictedBundleIDs:(id)arg1;
- (void)setWhitelistedBundleIDs:(id)arg1;
- (id)whitelistedBundleIDs;

@end
