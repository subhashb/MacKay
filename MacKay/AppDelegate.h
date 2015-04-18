//
//  AppDelegate.h
//  MacKay
//
//  Created by Subhash Bhushan on 17/04/15.
//  Copyright (c) 2015 Subhash Bhushan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
    @property (assign) IBOutlet NSWindow *window;
    @property (weak) IBOutlet NSTextField *dragLabel;
    @property (weak) IBOutlet NSTextField *uploadingLabel;
    @property (weak) IBOutlet NSProgressIndicator *spinner;

@end

