// See http://iphonedevwiki.net/index.php/Logos


%hook KGURLCmdSender

+ (void)sendToKugouAppCommand:(id)command WithDic:(id)dic inVC:(UIViewController *)viewController {
    %orig();
}

%end
