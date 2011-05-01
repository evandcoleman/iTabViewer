//
//  iTabViewerAppDelegate.m
//  iTabViewer
//
//  Created by Evan Coleman on 4/30/11.
//  Copyright 2011 Evan Coleman. All rights reserved.
//

#import "iTabViewerAppDelegate.h"
#import "iTunes.h"

@implementation iTabViewerAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSRect screen = [[NSScreen mainScreen] frame];
    [window setFrame:screen display:YES animate:NO];
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc addObserver:self selector:@selector(updateTrackInfo:) name:@"com.apple.iTunes.playerInfo" object:nil];
    [self updateTab];
}

-(void)awakeFromNib {
    [webView setEditable:YES];
    [webView setNeedsDisplay:YES];
    
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    
    NSString *js = @"$(\".menu\").hide();$(\".logonupd\").hide();$(\".ads\").hide();$(\".ads_v\").hide();$(\".ads_footer\").hide();$(\".b headtbl\").hide();";
    [[sender windowScriptObject] evaluateWebScript:js];
    
}

- (void)updateTab {
    iTunesApplication *iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    if([iTunes isRunning]){
        if([iTunes playerState] != iTunesEPlSStopped && thisTrack != [[iTunes currentTrack] databaseID]){
            thisTrack = [[iTunes currentTrack] databaseID];
            NSString *search = [NSString stringWithFormat:@"%@ %@",[[iTunes currentTrack] name],[[iTunes currentTrack] artist]];
            search = [search stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *url = [NSString stringWithFormat:@"http://www.ultimate-guitar.com/search.php?value=%@&search_type=title",search];
            NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            [[webView mainFrame] loadRequest:req];
        }
    }
}

- (IBAction)openInBrowser:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:[webView mainFrameURL]]];
}

- (void) updateTrackInfo:(NSNotification *)notification {
    NSAlert *alert = [[[NSAlert alloc] init] autorelease];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert setMessageText:@"Song Changed"];
    [alert setInformativeText:@"Should I find the corresponding tabs?"];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert beginSheetModalForWindow:window modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    
    if (returnCode == NSAlertFirstButtonReturn) {
        [self updateTab];
    }
    
}

- (IBAction)loadTabs:(id)sender {
    [self updateTab];
}

@end
