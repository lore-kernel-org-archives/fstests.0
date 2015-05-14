Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:46937 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932871AbbENOXw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 May 2015 10:23:52 -0400
Message-ID: <5554AFF7.9040702@sandeen.net>
Date: Thu, 14 May 2015 09:23:51 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs_repair: test for false positive reserved attr name
 use
References: <555414EA.80301@redhat.com> <20150514045546.GC1140@dhcp-13-216.nay.redhat.com> <E4DB2C47-54FA-4DAF-84C0-2F585B7510A4@sandeen.net> <20150514054450.GD1140@dhcp-13-216.nay.redhat.com>
In-Reply-To: <20150514054450.GD1140@dhcp-13-216.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 5/14/15 12:44 AM, Eryu Guan wrote:
> On Thu, May 14, 2015 at 12:23:14AM -0500, Eric Sandeen wrote:
>> All good advice; sigh, I am rusty!  Thanks, will resend with fixes.
>>
>> (Started as using test dev so left some things out; not sure I need a trap if there is nothing to clean up?  Also do we need to require attr on xfs?  Can't remember if we can compile that out, but I guess it's harmless to include it)
> 
> I did a "grep _require_attrs tests/xfs/*" and result showed several
> tests in xfs require attrs. At least it checks if ATTR_PROG exists :)

Yes, I forgot about that ;(

> And I think we need a trap and cleanup even if there's no obvious things
> to clean, some functions use $tmp.xxx internally, a cleanup could remove
> all these tmp files too, and trap plays with exit status, so it's still
> needed.

Fair enough, thanks for the review.

-Eric

