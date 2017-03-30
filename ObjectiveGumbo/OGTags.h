//
//  OGTags.m
//  Pods
//
//  Created by Richard Warrender on 29/03/2017.
//
//

#import <Foundation/Foundation.h>
#import "gumbo.h"

typedef NS_ENUM(NSUInteger, OGNamespace) {
    OGNamespaceHTML = GUMBO_NAMESPACE_HTML,
    OGNamespaceSVG = GUMBO_NAMESPACE_SVG,
    OGNamespaceMATHML = GUMBO_NAMESPACE_MATHML,
};

NS_INLINE OGNamespace OGNamespaceFromGumboNamespace(GumboNamespaceEnum g_namespace)
{
    return (OGNamespace)g_namespace;
}

NS_INLINE GumboNamespaceEnum GumboNamespaceFromOGNamespace(OGNamespace og_namespace) {
    return (GumboNamespaceEnum)og_namespace;
}

typedef NS_ENUM(NSUInteger, OGTag) {
    OGTagHTML = GUMBO_TAG_HTML,
    OGTagHead = GUMBO_TAG_HEAD,
    OGTagTitle = GUMBO_TAG_TITLE,
    OGTagBase = GUMBO_TAG_BASE,
    OGTagLink = GUMBO_TAG_LINK,
    OGTagMeta = GUMBO_TAG_META,
    OGTagStyle = GUMBO_TAG_STYLE,
    OGTagScript = GUMBO_TAG_SCRIPT,
    OGTagNoScript = GUMBO_TAG_NOSCRIPT,
    OGTagTemplate = GUMBO_TAG_TEMPLATE,
    OGTagBody = GUMBO_TAG_BODY,
    OGTagArticle = GUMBO_TAG_ARTICLE,
    OGTagSection = GUMBO_TAG_SECTION,
    OGTagNav = GUMBO_TAG_NAV,
    OGTagASide = GUMBO_TAG_ASIDE,
    OGTagH1 = GUMBO_TAG_H1,
    OGTagH2 = GUMBO_TAG_H2,
    OGTagH3 = GUMBO_TAG_H3,
    OGTagH4 = GUMBO_TAG_H4,
    OGTagH5 = GUMBO_TAG_H5,
    OGTagH6 = GUMBO_TAG_H6,
    OGTagHGroup = GUMBO_TAG_HGROUP,
    OGTagHeader = GUMBO_TAG_HEADER,
    OGTagFooter = GUMBO_TAG_FOOTER,
    OGTagAddress = GUMBO_TAG_ADDRESS,
    OGTagP = GUMBO_TAG_P,
    OGTagHR = GUMBO_TAG_HR,
    OGTagPre = GUMBO_TAG_PRE,
    OGTagBlockquote = GUMBO_TAG_BLOCKQUOTE,
    OGTagOL = GUMBO_TAG_OL,
    OGTagUL = GUMBO_TAG_UL,
    OGTagLI = GUMBO_TAG_LI,
    OGTagDL = GUMBO_TAG_DL,
    OGTagDT = GUMBO_TAG_DT,
    OGTagDD = GUMBO_TAG_DD,
    OGTagFigure = GUMBO_TAG_FIGURE,
    OGTagFigCaption = GUMBO_TAG_FIGCAPTION,
    OGTagMain = GUMBO_TAG_MAIN,
    OGTagDiv = GUMBO_TAG_DIV,
    OGTagA = GUMBO_TAG_A,
    OGTagEM = GUMBO_TAG_EM,
    OGTagStrong = GUMBO_TAG_STRONG,
    OGTagSmall = GUMBO_TAG_SMALL,
    OGTagS = GUMBO_TAG_S,
    OGTagCite = GUMBO_TAG_CITE,
    OGTagQ = GUMBO_TAG_Q,
    OGTagDFN = GUMBO_TAG_DFN,
    OGTagAbbr = GUMBO_TAG_ABBR,
    OGTagData = GUMBO_TAG_DATA,
    OGTagTime = GUMBO_TAG_TIME,
    OGTagCode = GUMBO_TAG_CODE,
    OGTagVar = GUMBO_TAG_VAR,
    OGTagSamp = GUMBO_TAG_SAMP,
    OGTagKBD = GUMBO_TAG_KBD,
    OGTagSub = GUMBO_TAG_SUB,
    OGTagSup = GUMBO_TAG_SUP,
    OGTagI = GUMBO_TAG_I,
    OGTagB = GUMBO_TAG_B,
    OGTagU = GUMBO_TAG_U,
    OGTagMark = GUMBO_TAG_MARK,
    OGTagRuby = GUMBO_TAG_RUBY,
    OGTagRT = GUMBO_TAG_RT,
    OGTagRP = GUMBO_TAG_RP,
    OGTagBDI = GUMBO_TAG_BDI,
    OGTagBDO = GUMBO_TAG_BDO,
    OGTagSpan = GUMBO_TAG_SPAN,
    OGTagBR = GUMBO_TAG_BR,
    OGTagWBR = GUMBO_TAG_WBR,
    OGTagIns = GUMBO_TAG_INS,
    OGTagDel = GUMBO_TAG_DEL,
    OGTagImage = GUMBO_TAG_IMAGE,
    OGTagImg = GUMBO_TAG_IMG,
    OGTagIFrame = GUMBO_TAG_IFRAME,
    OGTagEmbed = GUMBO_TAG_EMBED,
    OGTagObject = GUMBO_TAG_OBJECT,
    OGTagParam = GUMBO_TAG_PARAM,
    OGTagVideo = GUMBO_TAG_VIDEO,
    OGTagAudio = GUMBO_TAG_AUDIO,
    OGTagSource = GUMBO_TAG_SOURCE,
    OGTagTrack = GUMBO_TAG_TRACK,
    OGTagCanvas = GUMBO_TAG_CANVAS,
    OGTagMap = GUMBO_TAG_MAP,
    OGTagArea = GUMBO_TAG_AREA,
    OGTagMath = GUMBO_TAG_MATH,
    OGTagMI = GUMBO_TAG_MI,
    OGTagMO = GUMBO_TAG_MO,
    OGTagMN = GUMBO_TAG_MN,
    OGTagMS = GUMBO_TAG_MS,
    OGTagMText = GUMBO_TAG_MTEXT,
    OGTagMGlyph = GUMBO_TAG_MGLYPH,
    OGTagMAlignMark = GUMBO_TAG_MALIGNMARK,
    OGTagAnnotationXML = GUMBO_TAG_ANNOTATION_XML,
    OGTagSVG = GUMBO_TAG_SVG,
    OGTagForeignObject = GUMBO_TAG_FOREIGNOBJECT,
    OGTagDesc = GUMBO_TAG_DESC,
    OGTagTable = GUMBO_TAG_TABLE,
    OGTagCaption = GUMBO_TAG_CAPTION,
    OGTagColGroup = GUMBO_TAG_COLGROUP,
    OGTagCol = GUMBO_TAG_COL,
    OGTagTBody = GUMBO_TAG_TBODY,
    OGTagTHead = GUMBO_TAG_THEAD,
    OGTagTFoot = GUMBO_TAG_TFOOT,
    OGTagTR = GUMBO_TAG_TR,
    OGTagTD = GUMBO_TAG_TD,
    OGTagTH = GUMBO_TAG_TH,
    OGTagForm = GUMBO_TAG_FORM,
    OGTagFieldSet = GUMBO_TAG_FIELDSET,
    OGTagLegend = GUMBO_TAG_LEGEND,
    OGTagLabel = GUMBO_TAG_LABEL,
    OGTagInput = GUMBO_TAG_INPUT,
    OGTagButton = GUMBO_TAG_BUTTON,
    OGTagSelect = GUMBO_TAG_SELECT,
    OGTagDataList = GUMBO_TAG_DATALIST,
    OGTagOptGroup = GUMBO_TAG_OPTGROUP,
    OGTagOption = GUMBO_TAG_OPTION,
    OGTagTextarea = GUMBO_TAG_TEXTAREA,
    OGTagKeyGen = GUMBO_TAG_KEYGEN,
    OGTagOutput = GUMBO_TAG_OUTPUT,
    OGTagProgress = GUMBO_TAG_PROGRESS,
    OGTagMeter = GUMBO_TAG_METER,
    OGTagDetails = GUMBO_TAG_DETAILS,
    OGTagSummary = GUMBO_TAG_SUMMARY,
    OGTagMenu = GUMBO_TAG_MENU,
    OGTagMenuItem = GUMBO_TAG_MENUITEM,
    OGTagApplet = GUMBO_TAG_APPLET,
    OGTagAcronym = GUMBO_TAG_ACRONYM,
    OGTagBGSound = GUMBO_TAG_BGSOUND,
    OGTagDir = GUMBO_TAG_DIR,
    OGTagFrame = GUMBO_TAG_FRAME,
    OGTagFrameSet = GUMBO_TAG_FRAMESET,
    OGTagNoFrames = GUMBO_TAG_NOFRAMES,
    OGTagIsIndex = GUMBO_TAG_ISINDEX,
    OGTagListing = GUMBO_TAG_LISTING,
    OGTagXMP = GUMBO_TAG_XMP,
    OGTagNextID = GUMBO_TAG_NEXTID,
    OGTagNoEmbed = GUMBO_TAG_NOEMBED,
    OGTagPlainText = GUMBO_TAG_PLAINTEXT,
    OGTagRB = GUMBO_TAG_RB,
    OGTagStrike = GUMBO_TAG_STRIKE,
    OGTagBaseFont = GUMBO_TAG_BASEFONT,
    OGTagBig = GUMBO_TAG_BIG,
    OGTagBlink = GUMBO_TAG_BLINK,
    OGTagCenter = GUMBO_TAG_CENTER,
    OGTagFont = GUMBO_TAG_FONT,
    OGTagMarquee = GUMBO_TAG_MARQUEE,
    OGTagMultiCol = GUMBO_TAG_MULTICOL,
    OGTagNoBR = GUMBO_TAG_NOBR,
    OGTagSpacer = GUMBO_TAG_SPACER,
    OGTagTT = GUMBO_TAG_TT,
    OGTagRTC = GUMBO_TAG_RTC,
    OGTagUnknown = GUMBO_TAG_UNKNOWN // Error-check, always ensure this is last in the enum
};

NS_INLINE NSString* NSStringFromOGTag(OGTag tag)
{
    GumboTag gumbo_tag = (GumboTag)tag;
    const char* tag_cString = gumbo_normalized_tagname(gumbo_tag);
    return [NSString stringWithCString:tag_cString encoding:NSUTF8StringEncoding];
}

NS_INLINE OGTag OGTagFromNSString(NSString *string)
{
    if (string.length > 0) {
        const char *tag_cString = string.UTF8String;
        GumboTag gumbo_tag = gumbo_tag_enum(tag_cString);
        return (OGTag)gumbo_tag;
    }
    return OGTagUnknown;
}

NS_INLINE OGTag OGTagFromGumboTag(GumboTag gumbo_tag)
{
    assert(gumbo_tag <= OGTagUnknown); // GumboTag enum is outside of range of OGTag
    return (OGTag)gumbo_tag;
}

NS_INLINE GumboTag GumboTagFromOGTag(OGTag tag)
{
    assert(tag <= OGTagUnknown); // GumboTag enum is outside of range of OGTag
    return (GumboTag)tag;
}
