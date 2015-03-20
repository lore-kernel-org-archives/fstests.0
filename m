Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:58415 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbbCTUBe (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 16:01:34 -0400
Message-ID: <550C7C9D.4070108@sandeen.net>
Date: Fri, 20 Mar 2015 15:01:33 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] fstests: use mount/umount helpers everywhere
References: <550C46B2.8060407@sandeen.net> <550C473B.5010004@sandeen.net> <20150320185641.GA17374@lenny.home.zabbo.net> <550C6DFB.6040506@sandeen.net>
In-Reply-To: <550C6DFB.6040506@sandeen.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Zach Brown <zab@zabbo.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 3/20/15 1:59 PM, Eric Sandeen wrote:
> On 3/20/15 1:56 PM, Zach Brown wrote:
>> On Fri, Mar 20, 2015 at 11:13:47AM -0500, Eric Sandeen wrote:
>>> Replace every explicit mount/umount of scratch or test devices
>>> with helper functions.  This allows the next patch to add in hooks
>>> to these functions in order to set up & tear down overlayfs on
>>> every mount/umount.
>>
>> Yeah, I don't know about this.
>>
>> For nfs testing we don't setup xfstests to test xfs on block devices and
>> then then magically configure nfs to export and mount it on the side.
>>
>> Wouldn't we treat overlayfs the same way?  It'd be its own fstype whose
>> underlying resources are fs paths?
> 
> Yeah, maybe I need to rethink it.  TBH, I'm not really clear on how
> nfs gets set up in fstests, but I guess I should look.

Hrmph, well (talking to the duck, here) - nfs & cifs have no mkfs, no
fs check, etc.  Overlayfs tests really should, I think.  So it's not
quite like the net-fs tests.

Maybe what we need is an "FSTYP=overlayfs" but but another type for
the underlying filesystem.  And then that starts to look, I think,
a lot like what I sent...

-Eric

