Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:50499 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751036AbcHZEv6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Aug 2016 00:51:58 -0400
Date: Fri, 26 Aug 2016 14:51:15 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [GIT PULL] fstests: updates on 2016-08-20
Message-ID: <20160826045115.GP22388@dastard>
References: <201608201444.u7KEi22g015351@int-mx14.intmail.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201608201444.u7KEi22g015351@int-mx14.intmail.prod.int.phx2.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Aug 20, 2016 at 10:44:01PM +0800, Eryu Guan wrote:
> Eric Sandeen (2):
>       xfs: test xfs_quota "state" command

This test hard codes inode numbers in the golden output. Fails the
moment you change the mkfs parameters away from the default. e.g.
enable rmapbt=1:

xfs/263  - output mismatch (see /home/dave/src/xfstests-dev/results//xfs_1k/xfs/263.out.bad)
    --- tests/xfs/263.out       2016-08-23 16:55:38.026707187 +1000
    +++ /home/dave/src/xfstests-dev/results//xfs_1k/xfs/263.out.bad     2016-08-26 11:13:06.533209472 +1000
    @@ -5,15 +5,15 @@
     User quota state on SCRATCH_MNT (SCRATCH_DEV)
       Accounting: ON
       Enforcement: ON
    -  Inode: #131 (1 blocks, 1 extents)
    +  Inode: #195 (1 blocks, 1 extents)
     Group quota state on SCRATCH_MNT (SCRATCH_DEV)
       Accounting: OFF
    ...
    (Run 'diff -u tests/xfs/263.out /home/dave/src/xfstests-dev/results//xfs_1k/xfs/263.out.bad'  to see the entire diff)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
