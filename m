Received: from userp2120.oracle.com ([156.151.31.85]:49280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeCLQjw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Mar 2018 12:39:52 -0400
Date: Mon, 12 Mar 2018 09:37:10 -0600
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH v2] fstests: test regression of -EEXIST on creating new
 file after log replay
Message-ID: <20180312153710.GA25561@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
Reply-To: bo.li.liu@oracle.com
References: <20180307235910.12313-1-bo.li.liu@oracle.com>
 <20180310235604.3206-1-bo.li.liu@oracle.com>
 <20180312112826.GK30836@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312112826.GK30836@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 12, 2018 at 07:28:26PM +0800, Eryu Guan wrote:
> On Sat, Mar 10, 2018 at 04:56:04PM -0700, Liu Bo wrote:
> > The regression is introduced to btrfs in linux v4.4 and it refuses to create
> > new files after log replay by returning -EEXIST.
> > 
> > Although the problem is on btrfs only, there is no btrfs stuff in terms of
> > test, so this makes it generic.
> > 
> > The kernel fix is
> >   Btrfs: fix unexpected -EEXIST when creating new inode
> > 
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
...
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	_cleanup_flakey
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/dmflakey
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +_require_dm_target flakey
> > +
> > +rm -f $seqres.full
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> 
> I added a "_require_metadata_journaling $SCRATCH_DEV" here, otherwise
> test fails with ext2, which doesn't have journal.

Ah OK, that makes sense.

Thanks,

-liubo
