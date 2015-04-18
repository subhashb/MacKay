//
//  AppDelegate.m
//  MacKay
//
//  Created by Subhash Bhushan on 17/04/15.
//  Copyright (c) 2015 Subhash Bhushan. All rights reserved.
//

#import "AppDelegate.h"

NSStatusItem *statusItem;

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setImage:[NSImage imageNamed:@"logo1"]];
    [statusItem setToolTip:@"Click to publish assets to Kaybus"];
    [statusItem setHighlightMode:YES];
    [statusItem setTarget:self];
    [statusItem setAction:@selector(showMainWindow:)];
    
    [[[NSApplication sharedApplication] mainWindow] setReleasedWhenClosed:NO];
    
    _dragLabel.hidden = NO;
    _spinner.hidden = YES;
    _uploadingLabel.hidden = YES;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)showMainWindow:(id)sender
{
    [self applicationShouldHandleReopen:nil hasVisibleWindows:YES];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    [[[NSApplication sharedApplication] mainWindow] setIsVisible:YES];
    return YES;
}

@end
