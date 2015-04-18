//
//  DropView.m
//  MacKay
//
//  Created by Subhash Bhushan on 17/04/15.
//  Copyright (c) 2015 Subhash Bhushan. All rights reserved.
//

#import "DropView.h"
#import "Uploader.h"
#import "AppDelegate.h"

@implementation DropView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObjects:
                                       NSColorPboardType, NSFilenamesPboardType, nil]];
        NSLog(@"initialization");
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObject:NSURLPboardType]];
        
        NSLog(@"Registered");
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [[NSColor whiteColor] set];
    NSRectFill(dirtyRect);
    NSLog(@"Drawing");
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    if ([NSImage canInitWithPasteboard:[sender draggingPasteboard]] &&
        [sender draggingSourceOperationMask] & NSDragOperationCopy) {
        return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    NSLog(@"DRAGGING");
    return NSDragOperationCopy;
}

- (void) draggingEnded:(id<NSDraggingInfo>)sender {
    NSLog(@"ENDED");
}

- (void) draggingExited:(id<NSDraggingInfo>)sender {
    NSLog(@"EXITED");
}

- (BOOL) prepareForDragOperation:(id<NSDraggingInfo>)sender {
    return YES;
}

- (BOOL) performDragOperation:(id<NSDraggingInfo>)sender {
    NSPasteboard *pboard = [sender draggingPasteboard];
    NSArray *urls;
    if ([[pboard types] containsObject:NSURLPboardType]) {
        urls = [pboard readObjectsForClasses:@[[NSURL class]] options:nil];
        NSLog(@"URLs are: %@", urls);
    }
    
    for (NSString *item in urls) {
        NSLog(@"%@", item);

        NSString *fileName = [item lastPathComponent];
        
        ((AppDelegate *)[NSApplication sharedApplication].delegate).dragLabel.hidden = YES;
        ((AppDelegate *)[NSApplication sharedApplication].delegate).spinner.hidden = NO;
        ((AppDelegate *)[NSApplication sharedApplication].delegate).uploadingLabel.hidden = NO;
        [((AppDelegate *)[NSApplication sharedApplication].delegate).uploadingLabel setStringValue:[NSString stringWithFormat:@"Uploading %@...", fileName]];
        
        [[Uploader alloc] initWithURL:[NSURL URLWithString:@"https://kaybus.dev/api/assets"]
                               filePath:item
                               fileName:fileName
                               delegate:self
                           doneSelector:@selector(onUploadDone:)
                          errorSelector:@selector(onUploadError:)];
    }
    return YES;
}

- (void) concludeDragOperation:(id<NSDraggingInfo>)sender {
    [self setNeedsDisplay:YES];
}

@end
