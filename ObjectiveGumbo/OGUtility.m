//
//  OGUtility.m
//  Hacker News
//
//  Created by Thomas Denney on 30/08/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "OGUtility.h"

@interface OGUtility ()
@property (nonatomic, strong) NSDictionary *tagDictionary;
@end

@implementation OGUtility

+ (instancetype)sharedInstance
{
    static NSArray *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (NSString *)tagForGumboTag:(GumboTag)tag
{
    return [[self sharedInstance] tagForGumboTag:tag];
}

+ (GumboTag)gumboTagForTag:(NSString *)tag
{
    return [[self sharedInstance] gumboTagForTag:tag];
    
}

- (NSString *)tagForGumboTag:(GumboTag)gumboTag
{
    NSString *tag = self.tagDictionary[@(gumboTag)];
    if (tag == nil) {
        tag = @"unknown";
    }
    return tag;
}

- (GumboTag)gumboTagForTag:(NSString *)tag
{
    __block GumboTag gumboTag = GUMBO_TAG_UNKNOWN;
    [self.tagDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:tag]) {
            gumboTag = (GumboTag)[key integerValue];
            *stop = YES;
        }
    }];
    
    return gumboTag;
}

- (NSDictionary *)tagDictionary
{
    if (_tagDictionary == nil) {
        NSDictionary<NSNumber*, NSString *>* tagDictionary = @{
                                                               @(GUMBO_TAG_HTML): @"html",
                                                               @(GUMBO_TAG_HEAD): @"head",
                                                               @(GUMBO_TAG_TITLE): @"title",
                                                               @(GUMBO_TAG_BASE): @"base",
                                                               @(GUMBO_TAG_LINK): @"link",
                                                               @(GUMBO_TAG_META): @"meta",
                                                               @(GUMBO_TAG_STYLE): @"style",
                                                               @(GUMBO_TAG_SCRIPT): @"script",
                                                               @(GUMBO_TAG_NOSCRIPT): @"noscript",
                                                               @(GUMBO_TAG_TEMPLATE): @"template",
                                                               @(GUMBO_TAG_BODY): @"body",
                                                               @(GUMBO_TAG_SECTION): @"section",
                                                               @(GUMBO_TAG_NAV): @"nav",
                                                               @(GUMBO_TAG_ARTICLE): @"article",
                                                               @(GUMBO_TAG_ASIDE): @"aside",
                                                               @(GUMBO_TAG_H1): @"h1",
                                                               @(GUMBO_TAG_H2): @"h2",
                                                               @(GUMBO_TAG_H3): @"h3",
                                                               @(GUMBO_TAG_H4): @"h4",
                                                               @(GUMBO_TAG_H5): @"h5",
                                                               @(GUMBO_TAG_H6): @"h6",
                                                               @(GUMBO_TAG_HGROUP): @"hgroup",
                                                               @(GUMBO_TAG_HEADER): @"header",
                                                               @(GUMBO_TAG_FOOTER): @"footer",
                                                               @(GUMBO_TAG_ADDRESS): @"address",
                                                               @(GUMBO_TAG_P): @"p",
                                                               @(GUMBO_TAG_HR): @"hr",
                                                               @(GUMBO_TAG_PRE): @"pre",
                                                               @(GUMBO_TAG_BLOCKQUOTE): @"blockquote",
                                                               @(GUMBO_TAG_OL): @"ol",
                                                               @(GUMBO_TAG_UL): @"ul",
                                                               @(GUMBO_TAG_LI): @"li",
                                                               @(GUMBO_TAG_DL): @"dl",
                                                               @(GUMBO_TAG_DT): @"dt",
                                                               @(GUMBO_TAG_DD): @"dd",
                                                               @(GUMBO_TAG_FIGURE): @"figure",
                                                               @(GUMBO_TAG_FIGCAPTION): @"figcaption",
                                                               @(GUMBO_TAG_DIV): @"div",
                                                               @(GUMBO_TAG_A): @"a",
                                                               @(GUMBO_TAG_EM): @"em",
                                                               @(GUMBO_TAG_STRONG): @"strong",
                                                               @(GUMBO_TAG_SMALL): @"small",
                                                               @(GUMBO_TAG_S): @"s",
                                                               @(GUMBO_TAG_CITE): @"cite",
                                                               @(GUMBO_TAG_Q): @"q",
                                                               @(GUMBO_TAG_DFN): @"dfn",
                                                               @(GUMBO_TAG_ABBR): @"abbr",
                                                               @(GUMBO_TAG_TIME): @"time",
                                                               @(GUMBO_TAG_CODE): @"code",
                                                               @(GUMBO_TAG_VAR): @"var",
                                                               @(GUMBO_TAG_SAMP): @"samp",
                                                               @(GUMBO_TAG_KBD): @"kbd",
                                                               @(GUMBO_TAG_SUB): @"sub",
                                                               @(GUMBO_TAG_SUP): @"sup",
                                                               @(GUMBO_TAG_I): @"i",
                                                               @(GUMBO_TAG_B): @"b",
                                                               @(GUMBO_TAG_MARK): @"mark",
                                                               @(GUMBO_TAG_RUBY): @"ruby",
                                                               @(GUMBO_TAG_RT): @"rt",
                                                               @(GUMBO_TAG_RP): @"rp",
                                                               @(GUMBO_TAG_BDI): @"bdi",
                                                               @(GUMBO_TAG_BDO): @"bdo",
                                                               @(GUMBO_TAG_SPAN): @"span",
                                                               @(GUMBO_TAG_BR): @"br",
                                                               @(GUMBO_TAG_WBR): @"wbr",
                                                               @(GUMBO_TAG_INS): @"ins",
                                                               @(GUMBO_TAG_DEL): @"del",
                                                               @(GUMBO_TAG_IMAGE): @"image",
                                                               @(GUMBO_TAG_IMG): @"img",
                                                               @(GUMBO_TAG_IFRAME): @"iframe",
                                                               @(GUMBO_TAG_EMBED): @"embed",
                                                               @(GUMBO_TAG_OBJECT): @"object",
                                                               @(GUMBO_TAG_PARAM): @"param",
                                                               @(GUMBO_TAG_VIDEO): @"video",
                                                               @(GUMBO_TAG_AUDIO): @"audio",
                                                               @(GUMBO_TAG_SOURCE): @"source",
                                                               @(GUMBO_TAG_TRACK): @"track",
                                                               @(GUMBO_TAG_CANVAS): @"canvas",
                                                               @(GUMBO_TAG_MAP): @"map",
                                                               @(GUMBO_TAG_AREA): @"area",
                                                               @(GUMBO_TAG_MATH): @"math",
                                                               @(GUMBO_TAG_MI): @"mi",
                                                               @(GUMBO_TAG_MO): @"mo",
                                                               @(GUMBO_TAG_MN): @"mn",
                                                               @(GUMBO_TAG_MS): @"ms",
                                                               @(GUMBO_TAG_MTEXT): @"mtext",
                                                               @(GUMBO_TAG_MGLYPH): @"mglyph",
                                                               @(GUMBO_TAG_MALIGNMARK): @"malignmark",
                                                               @(GUMBO_TAG_ANNOTATION_XML): @"xml",
                                                               @(GUMBO_TAG_SVG): @"svg",
                                                               @(GUMBO_TAG_FOREIGNOBJECT): @"foreignobject",
                                                               @(GUMBO_TAG_DESC): @"desc",
                                                               @(GUMBO_TAG_TABLE): @"table",
                                                               @(GUMBO_TAG_CAPTION): @"caption",
                                                               @(GUMBO_TAG_COLGROUP): @"colgroup",
                                                               @(GUMBO_TAG_COL): @"col",
                                                               @(GUMBO_TAG_TBODY): @"tbody",
                                                               @(GUMBO_TAG_THEAD): @"thead",
                                                               @(GUMBO_TAG_TFOOT): @"tfoot",
                                                               @(GUMBO_TAG_TR): @"tr",
                                                               @(GUMBO_TAG_TD): @"td",
                                                               @(GUMBO_TAG_TH): @"th",
                                                               @(GUMBO_TAG_FORM): @"form",
                                                               @(GUMBO_TAG_FIELDSET): @"fieldset",
                                                               @(GUMBO_TAG_LEGEND): @"legend",
                                                               @(GUMBO_TAG_LABEL): @"label",
                                                               @(GUMBO_TAG_INPUT): @"input",
                                                               @(GUMBO_TAG_BUTTON): @"button",
                                                               @(GUMBO_TAG_SELECT): @"select",
                                                               @(GUMBO_TAG_DATALIST): @"datalist",
                                                               @(GUMBO_TAG_OPTGROUP): @"optgroup",
                                                               @(GUMBO_TAG_OPTION): @"option",
                                                               @(GUMBO_TAG_TEXTAREA): @"textarea",
                                                               @(GUMBO_TAG_KEYGEN): @"keygen",
                                                               @(GUMBO_TAG_OUTPUT): @"output",
                                                               @(GUMBO_TAG_PROGRESS): @"progress",
                                                               @(GUMBO_TAG_METER): @"meter",
                                                               @(GUMBO_TAG_DETAILS): @"details",
                                                               @(GUMBO_TAG_SUMMARY): @"summary",
                                                               @(GUMBO_TAG_MENU): @"menu",
                                                               @(GUMBO_TAG_APPLET): @"applet",
                                                               @(GUMBO_TAG_ACRONYM): @"acronym",
                                                               @(GUMBO_TAG_BGSOUND): @"bgsound",
                                                               @(GUMBO_TAG_DIR): @"dir",
                                                               @(GUMBO_TAG_FRAME): @"frame",
                                                               @(GUMBO_TAG_FRAMESET): @"frameset",
                                                               @(GUMBO_TAG_NOFRAMES): @"noframes",
                                                               @(GUMBO_TAG_ISINDEX): @"isindex",
                                                               @(GUMBO_TAG_LISTING): @"listing",
                                                               @(GUMBO_TAG_XMP): @"xmp",
                                                               @(GUMBO_TAG_NEXTID): @"nextid",
                                                               @(GUMBO_TAG_NOEMBED): @"noembed",
                                                               @(GUMBO_TAG_PLAINTEXT): @"plaintext",
                                                               @(GUMBO_TAG_RB): @"rb",
                                                               @(GUMBO_TAG_STRIKE): @"strike",
                                                               @(GUMBO_TAG_BASEFONT): @"basefont",
                                                               @(GUMBO_TAG_BIG): @"big",
                                                               @(GUMBO_TAG_BLINK): @"blink",
                                                               @(GUMBO_TAG_CENTER): @"center",
                                                               @(GUMBO_TAG_FONT): @"font",
                                                               @(GUMBO_TAG_MARQUEE): @"marquee",
                                                               @(GUMBO_TAG_MULTICOL): @"multicol",
                                                               @(GUMBO_TAG_NOBR): @"nobr",
                                                               @(GUMBO_TAG_SPACER): @"spacer",
                                                               @(GUMBO_TAG_TT): @"tt",
                                                               @(GUMBO_TAG_U): @"u",
                                                               @(GUMBO_TAG_UNKNOWN): @"unknown"
                                                               };
        _tagDictionary = tagDictionary;
    }
    
    return _tagDictionary;
}

@end
