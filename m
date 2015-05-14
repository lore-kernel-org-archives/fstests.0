Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:31932 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933286AbbENDUJ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 13 May 2015 23:20:09 -0400
Date: Thu, 14 May 2015 13:19:52 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/326: Test the permission to set file times
Message-ID: <20150514031952.GP15721@dastard>
References: <20150512234005.GC4316@dastard>
 <1431475654-23274-1-git-send-email-andreas.gruenbacher@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431475654-23274-1-git-send-email-andreas.gruenbacher@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

On Wed, May 13, 2015 at 02:07:34AM +0200, Andreas Gruenbacher wrote:
> Check if setting the file access and modification times to the current time
> and to a specific timestamp is allowed when expected.
> 
> Signed-off-by: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>

Fails on XFS.

/me looks at fs_perms and shudders at all the system() calls.

Looks like there is no testx.file created first.

    --- tests/generic/087.out   2015-05-14 12:22:32.000000000 +1000
    +++ /home/dave/src/xfstests-dev/results//xfs/generic/087.out.bad    2015-05-14 12:41:02.000000000 +1000
    @@ -1,7 +1,19 @@
     QA output created by 087
    -t a 600 file owned by (99/99) as user/group(99/99)  PASS
    -T a 600 file owned by (99/99) as user/group(99/99)  PASS
    +cp: cannot stat 'testx.file': No such file or directory
    +rm: cannot remove 'test.file': No such file or directory
    +t a 600 file owned by (99/99) as user/group(99/99)  FAIL
    +cp: cannot stat 'testx.file': No such file or directory


(yes, I renumbered it to 087)

> +QA_FS_PERMS=$here/src/fs_perms
> +
> +cd $TEST_DIR

Yup, it's missing this:

cd $TEST_DIR
cp $here/src/testx ./testx.file

from generic/126.

I fixed it, but now an rm (from one of those system() calls within
the test program) gets stuck waiting on something else:

[ 2540.235059] rm              S ffff8802e7d87be8 14488  9969   9968
0x00000000
[ 2540.236602]  ffff8802e7d87be8 ffff88042da98000 ffff88028b719850
ffff8802e7d87ce8
[ 2540.238206]  ffff8802e7d88000 ffff88042b4eb000 0000000000000000
ffffc900009f4000
[ 2540.239818]  7fffffffffffffff ffff8802e7d87c08 ffffffff81df05b7
ffff8802f80853b0
[ 2540.241474] Call Trace:
[ 2540.241988]  [<ffffffff81df05b7>] schedule+0x37/0x90
[ 2540.243000]  [<ffffffff81df4541>] schedule_timeout+0x1d1/0x230
[ 2540.244241]  [<ffffffff81df3939>] ? down_write+0x29/0x60
[ 2540.245355]  [<ffffffff811a777b>] ? vma_adjust+0x3db/0x6a0
[ 2540.246487]  [<ffffffff810dcc1e>] wait_woken+0x7e/0xa0
[ 2540.247562]  [<ffffffff818a697d>] n_tty_read+0x25d/0xb00
[ 2540.248703]  [<ffffffff811a7cbf>] ? vma_merge+0xbf/0x270
[ 2540.249819]  [<ffffffff810dcb80>] ? __wake_up_sync+0x20/0x20
[ 2540.250979]  [<ffffffff818a24cd>] tty_read+0x8d/0xf0
[ 2540.251995]  [<ffffffff811c7208>] __vfs_read+0x28/0xf0
[ 2540.253107]  [<ffffffff81788724>] ?
security_file_permission+0x84/0xa0
[ 2540.254458]  [<ffffffff811c7766>] ? rw_verify_area+0x56/0xe0
[ 2540.255619]  [<ffffffff811c7872>] vfs_read+0x82/0x120
[ 2540.256709]  [<ffffffff811c8699>] SyS_read+0x49/0xb0
[ 2540.257733]  [<ffffffff81df582e>] system_call_fastpath+0x12/0x71

# ps -ef
.....
root      9746  9350  0 13:12 pts/0    00:00:00 /bin/bash ./tests/generic/087
uuidd     9965  9746  0 13:12 pts/0    00:00:00 /home/dave/src/xfstests-dev/src/
uuidd     9968  9965  0 13:12 pts/0    00:00:00 sh -c rm test.file
uuidd     9969  9968  0 13:12 pts/0    00:00:00 rm test.file

Perhaps it's waiting for input? should this actually be doing "rm
-f"?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
