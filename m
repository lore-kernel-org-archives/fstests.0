Received: from mx1.redhat.com ([209.132.183.28]:34220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbdBWLOp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 23 Feb 2017 06:14:45 -0500
Date: Thu, 23 Feb 2017 19:14:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/348: don't run a fuzzer in the auto group
Message-ID: <20170223111444.GD24562@eguan.usersys.redhat.com>
References: <20170223075333.GB22332@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170223075333.GB22332@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 22, 2017 at 11:53:33PM -0800, Darrick J. Wong wrote:
> xfs/348 can cause the kernel to crash by blowing the i_rwsem assert in
> xfs_destroy_inode on the corrupted inode.  Since this is a fuzzer test
> anyway (it calls xfs_db to break the scratch fs), move it to the fuzzers
> group.

I agreed fuzzers group should be added, but I'm not sure about removing
auto group. I think this is a good & targeted regression test that
excrises the code path that patch "xfs: sanity check directory inode
di_size" fixed.

And further more, IMO shared/005,7 and xfs/133,4 belong to auto (and
quick) group too, they're all targeted regression test cases.

If you're worried about crashing kernel by running these tests in auto
group, perhaps we can consider adding them to dangerous group, then run
check with "./check -g auto -x dangerous". But these bugs are all fixed,
the tests shouldn't bring any trouble if running on newer kernels :)

Thanks,
Eryu
