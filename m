Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:64087 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbfCEUxr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Mar 2019 15:53:47 -0500
Date: Wed, 6 Mar 2019 07:53:44 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power failure
Message-ID: <20190305205344.GC26298@dastard>
References: <20190305114744.129633-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305114744.129633-1-yuchao0@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, linux-f2fs-devel@lists.sourceforge.net, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 05, 2019 at 07:47:44PM +0800, Chao Yu wrote:
> After fsync, filesystem should guarantee inode metadata including
> permission info being persisted, so even after sudden power-cut,
> during mount, we should recover i_mode fields correctly, in order
> to not loss those meta info.
> 
> So adding this testcase to check whether generic filesystem can
> guarantee that.

Can I make a suggestion here?

I've noticed that we are getting a lot of these one-off, random
"fsync persists one specific piece of metadata in one specific case"
tests, mainly in response to some fsync bug that was found in btrfs.
This is reactive, and does not find new bugs in this area.

We are also beyond the point where the number of tests is
maintainable (e.g. to be able to make infrastructure changes), so we
really should be looking to consolidate largely similar tests into
single tests where possible.

I'd strongly suggest that a robust fsync tester should be written
for all the cases that are currently being addressed in an ad hoc
fashion. Then they can be consolidated into a single test run, and
we can get rid of all the one-off "fsync failed on this <specific
thing>" tests from the harness.

Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
and generic/311.

Can we please consider rolling all of these "do something, fsync,
drop-writes, remount check" into fsync-tester.c and do the same for
all future one-off "did fsync persist X" tests?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
