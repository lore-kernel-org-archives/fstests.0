Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:40298 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752296AbcKPVMp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Nov 2016 16:12:45 -0500
Date: Thu, 17 Nov 2016 08:12:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: Block btrfs from test case generic/372
Message-ID: <20161116211241.GC28177@dastard>
References: <20161115081332.6432-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115081332.6432-1-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

(Did you forget to cc fstests@vger.kernel.org?)

On Tue, Nov 15, 2016 at 04:13:32PM +0800, Qu Wenruo wrote:
> Since btrfs always return the whole extent even part of it is shared
> with other files, so the hole/extent counts differs for "file1" in this
> test case.
> 
> For example:
> 
>  /------ File 1 Extent 0-------------\
> /                                     \
> |<----------Extent A------------------>|
> \         /                  \         /
>  \ File 2/                    \ File 2/
>    Ext 0~4K                    Ext 64k~68K
> 
> In that case, fiemap on File 1 will only return 1 large extent A with
> SHARED flag.
> While XFS will split it into 3 extents,  first and last 4K with SHARED
> flag while the rest without SHARED flag.

fiemap should behave the same across all filesystems if at all
possible. This test failure indicates btrfs doesn't report an
accurate representation of shared extents which, IMO, is a btrfs
issue that needs fixing, not a test problem....

Regardless of this....

> This makes the test case meaningless as btrfs doesn't follow such
> assumption.
> So black list btrfs for this test case to avoid false alert.

...  we are not going to add ad-hoc filesystem blacklists for
random tests.

Adding "blacklists" without any explanation of why something has
been blacklisted is simply a bad practice. We use _require rules
to specifically document what functionality is required for the
test and check that it provided.  i.e. this:

_require_explicit_shared_extents()
{
	if [ $FSTYP == "btrfs" ]; then
		_not_run "btrfs can't report accurate shared extent ranges in fiemap"
	fi
}

documents /exactly/ why this test is not run on btrfs.

And, quite frankly, while this is /better/ it still ignores the
fact we have functions like _within_tolerance for allowing a range
of result values to be considered valid rather than just a fixed
value. IOWs, changing the check of the extent count of file 1 post
reflink to use a _within_tolerance range would mean the test would
validate file1 on all reflink supporting filesystems and we don't
need to exclude btrfs at all...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
