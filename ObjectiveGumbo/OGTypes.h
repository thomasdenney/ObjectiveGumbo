// OGTypes.h
//
// Copyright 2014 Programming Thomas
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

@import Foundation;

/**
 This file contains NS_ENUM style declarations for all of the standard Gumbo node types. They are included here to avoid exposing the C API to client apps.
 */

/**
 Enum for representing the different tag types found in HTML5. Note that this is directly compatible with the GumboTag that is used in Gumbo.
 */
typedef NS_ENUM(NSUInteger, OGTag) {
    OGTagHtml,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/semantics.html#document-metadata
    OGTagHead,
    OGTagTitle,
    OGTagBase,
    OGTagLink,
    OGTagMeta,
    OGTagStyle,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/scripting-1.html#scripting-1
    OGTagScript,
    OGTagNoScript,
    OGTagTemplate,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/sections.html#sections
    OGTagBody,
    OGTagArticle,
    OGTagSection,
    OGTagNav,
    OGTagAside,
    OGTagH1,
    OGTagH2,
    OGTagH3,
    OGTagH4,
    OGTagH5,
    OGTagH6,
    OGTagHGroup,
    OGTagHeader,
    OGTagFooter,
    OGTagAddress,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/grouping-content.html#grouping-content
    OGTagP,
    OGTagHr,
    OGTagPre,
    OGTagBlockQuote,
    OGTagOl,
    OGTagUl,
    OGTagLi,
    OGTagDl,
    OGTagDt,
    OGTagDd,
    OGTagFigure,
    OGTagFigCaption,
    OGTagMain,
    OGTagDiv,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/text-level-semantics.html#text-level-semantics
    OGTagA,
    OGTagEm,
    OGTagStrong,
    OGTagSmall,
    OGTagS,
    OGTagCite,
    OGTagQ,
    OGTagDfn,
    OGTagAbbr,
    OGTagDdata,
    OGTagTime,
    OGTagCode,
    OGTagVar,
    OGTagSamp,
    OGTagKbd,
    OGTagSub,
    OGTagSup,
    OGTagI,
    OGTagB,
    OGTagU,
    OGTagMark,
    OGTagRuby,
    OGTagRt,
    OGTagRp,
    OGTagBdi,
    OGTagBdo,
    OGTagSpan,
    OGTagBr,
    OGTagWbr,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/edits.html#edits
    OGTagINS,
    OGTagDEL,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/embedded-content-1.html#embedded-content-1
    OGTagImage,
    OGTagImg,
    OGTagIFrame,
    OGTagEmbed,
    OGTagObject,
    OGTagParam,
    OGTagVideo,
    OGTagAudio,
    OGTagSource,
    OGTagTrack,
    OGTagCanvas,
    OGTagMap,
    OGTagArea,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/the-map-element.html#mathml
    OGTagMath,
    OGTagMI,
    OGTagMO,
    OGTagMN,
    OGTagMS,
    OGTagMText,
    OGTagMGlyph,
    OGTagMAlignMark,
    OGTagAnnotationXML,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/the-map-element.html#svg-0
    OGTagSVG,
    OGTagForeignObject,
    OGTagDesc,
    // SVG title tags will have GUMBO_TAG_TITLE as with HTML.
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/tabular-data.html#tabular-data
    OGTagTable,
    OGTagCaption,
    OGTagColGroup,
    OGTagCol,
    OGTagTBody,
    OGTagTHead,
    OGTagTFoot,
    OGTagTR,
    OGTagTD,
    OGTagTH,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/forms.html#forms
    OGTagForm,
    OGTagFieldSet,
    OGTagLegend,
    OGTagLabel,
    OGTagInput,
    OGTagButton,
    OGTagSelect,
    OGTagDataList,
    OGTagOptGroup,
    OGTagOption,
    OGTagTextArea,
    OGTagKeygen,
    OGTagOutput,
    OGTagProgress,
    OGTagMeter,
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/interactive-elements.html#interactive-elements
    OGTagDetails,
    OGTagSummary,
    OGTagMenu,
    OGTagMenuItem,
    // Non-conforming elements that nonetheless appear in the HTML5 spec.
    // http://www.whatwg.org/specs/web-apps/current-work/multipage/obsolete.html#non-conforming-features
    OGTagApplet,
    OGTagAcronym,
    OGTagBgSound,
    OGTagDir,
    OGTagFrame,
    OGTagFrameSet,
    OGTagNoFrames,
    OGTagIsIndex,
    OGTagListing,
    OGTagXmp,
    OGTagNextId,
    OGTagNoEmbed,
    OGTagPlainText,
    OGTagRb,
    OGTagStrike,
    OGTagBaseFont,
    OGTagBig,
    OGTagBlink,
    OGTagCenter,
    OGTagFont,
    OGTagMarquee,
    OGTagMutliCol,
    OGTagNoBR,
    OGTagSpacer,
    OGTagTt,
    // Used for all tags that don't have special handling in HTML.
    OGTagUnknown,
    // A marker value to indicate the end of the enum, for iterating over it.
    // Also used as the terminator for varargs functions that take tags.
    OGTagLast
};

typedef NS_ENUM(NSUInteger, OGNamespace) {
    OGNamespaceHTML,
    OGNamespaceSVG,
    OGNameSpaceMATHML
};

/**
 Utility interface for converting between strings and Objective Gumbo tag types.
 @note I will add support directly to a Swift enum in the future.
 */
@interface OGTypes : NSObject

/**
 @param tag A valid Objective Gumbo tag type
 @return A lowercase string for the tag type, or nil if the tag is unknown
 */
+ (NSString*)tagForGumboTag:(OGTag)tag;

/**
 @param tag A lowercase string that you would like to find the Objective Gumbo tag enum for
 @return An Objective Gumbo tag, or OGTagUnkown if identification failed
 */
+ (OGTag)gumboTagForTag:(NSString*)tag;

/**
 @return A static array of strings that represent the Objective Gumbo tag types. The index of this array matches the raw value of the Objective Gumbo tag enum
 @note These code for this method was generated via a series of regular expressions executed on the OGTag declaration.
 */
+ (NSArray*)tagStrings;

@end

