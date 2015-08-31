Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:5957 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751190AbbHaAVq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 30 Aug 2015 20:21:46 -0400
Date: Mon, 31 Aug 2015 10:21:42 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2 v2] Add checks for hard links support.
Message-ID: <20150831002142.GN3902@dastard>
References: <1440757500.29614.26.camel@ari-macbook>
 <20150830234333.GM3902@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150830234333.GM3902@dastard>
Sender: fstests-owner@vger.kernel.org
To: Ari Sundholm <ari@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 31, 2015 at 09:43:33AM +1000, Dave Chinner wrote:
> On Fri, Aug 28, 2015 at 01:25:00PM +0300, Ari Sundholm wrote:
> > From: Ari Sundholm <ari@tuxera.com>
> > 
> > There are filesystems that do not support hard links that we want to run
> > xfstests on. Add a function for checking for support and use it wherever
> > hard links are used.
> 
> As I've already pointed out, all of the filesystems that xfstests
> supports have working hardlinks, so this is a test that will never
> fail for anyone running xfstests on supported filesystems.
> 
> Also, I'm left to wonder what kernel filesystem supports
> journaling but does not support hardlinks (as noted by the number of
> tests you change that have "_require_metadata_journaling"). Why
> aren't you also posting the patches to support the filesystem that
> requires this "don't use hardlinks" patch?

Just to clarify this: I don't care if people are using xfstests to
test proprietary filesystem modules. I'm happy to add proper support
for just about any filesystem, but that support needs to be *in
full* so *anyone* can run the tests on that filesystem.

What I really don't like is people being evasive about the reason
they want something changed. If there isn't a clear, full and
convincing explanation of why a change should be made, then I will
push back until such an explanation is given.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
