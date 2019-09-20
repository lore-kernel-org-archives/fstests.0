Received: from mx1.redhat.com ([209.132.183.28]:45658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404405AbfITEYO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 20 Sep 2019 00:24:14 -0400
Date: Fri, 20 Sep 2019 12:31:39 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] common/xfs: wipe the XFS superblock of each AGs
Message-ID: <20190920043139.GO7239@dhcp-12-102.nay.redhat.com>
References: <20190919150024.8346-1-zlang@redhat.com>
 <66503981-2ff3-f28b-fd06-9d6360c930fe@cn.fujitsu.com>
 <20190920024836.GO2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920024836.GO2229799@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 19, 2019 at 07:48:36PM -0700, Darrick J. Wong wrote:
> On Fri, Sep 20, 2019 at 09:52:11AM +0800, Yang Xu wrote:
> > 
> > 
> > on 2019/09/19 23:00, Zorro Lang wrote:
> > > xfs/030 always fails after d0e484ac699f ("check: wipe scratch devices
> > > between tests") get merged.
> > > 
> > > Due to xfs/030 does a sized(100m) mkfs. Before we merge above commit,
> > > mkfs.xfs detects an old primary superblock, it will write zeroes to
> > > all superblocks before formatting the new filesystem. But this won't
> > > be done if we wipe the first superblock(by merging above commit).
> > > 
> > > That means if we make a (smaller) sized xfs after wipefs, those *old*
> > > superblocks which created by last time mkfs.xfs will be left on disk.
> > > Then when we do xfs_repair, if xfs_repair can't find the first SB, it
> > > will go to find those *old* SB at first. When it finds them,
> > > everyting goes wrong.
> > > 
> > > So I try to get XFS AG geometry(by default) and then try to erase all
> > > superblocks. Thanks Darrick J. Wong helped to analyze this issue.
> > Feel free to add Reported-by.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >   common/rc  |  4 ++++
> > >   common/xfs | 23 +++++++++++++++++++++++
> > >   2 files changed, 27 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 66c7fd4d..fe13f659 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -4048,6 +4048,10 @@ _try_wipe_scratch_devs()
> > >   	for dev in $SCRATCH_DEV_POOL $SCRATCH_DEV $SCRATCH_LOGDEV $SCRATCH_RTDEV; do
> > >   		test -b $dev && $WIPEFS_PROG -a $dev
> > >   	done
> > > +
> > > +	if [ "$FSTYP" = "xfs" ];then
> > > +		try_wipe_scratch_xfs
> > I think we should add a simple comment for why we add it.
> > 
> > ps:_scratch_mkfs_xfs also can make case pass. We can use it and add comment.
> > the  try_wipe_scratch_xfs method and the _scratch_mkfs_xfs method are all
> > acceptable for me.
> 
> Yes, I suppose formatting and then wiping per below would also achieve
> our means, but it would come at the extra cost of zeroing the log.  I'm
> not too eager to increase xfstest runtime even more.
> 
> Hmmm, I wonder if xfs_db could just grow a 'wipe all superblocks'
> command....

Haha, I was thinking about that too, and I tried this:
--
agc=`_scratch_xfs_get_sb_field agcount`
wipe_xfs_cmd="$XFS_DB_PROG -x"
for ((i=0; i<agc; i++)); do
	wipe_xfs_cmd="$wipe_xfs_cmd -c \"sb $i\" -c \"write -c magicnum 0x00000000\""
done
wipe_xfs_cmd="$wipe_xfs_cmd $SCRATCH_DEV"
eval $wipe_xfs_cmd
--

The only one problem about this, I think it's the max length of bash command:)

Thanks,
Zorro

> 
> --D
> 
> > > +	fi
> > >   }
> > >   # Only run this on xfs if xfs_scrub is available and has the unicode checker
> > > diff --git a/common/xfs b/common/xfs
> > > index 1bce3c18..34516f82 100644
> > > --- a/common/xfs
> > > +++ b/common/xfs
> > > @@ -884,3 +884,26 @@ _xfs_mount_agcount()
> > >   {
> > >   	$XFS_INFO_PROG "$1" | grep agcount= | sed -e 's/^.*agcount=\([0-9]*\),.*$/\1/g'
> > >   }
> > > +
> > > +# wipe the superblock of each XFS AGs
> > > +try_wipe_scratch_xfs()
> > > +{
> > > +	local tmp=`mktemp -u`
> > > +
> > > +	_scratch_mkfs_xfs -N 2>/dev/null | perl -ne '
> > > +		if (/^meta-data=.*\s+agcount=(\d+), agsize=(\d+) blks/) {
> > > +			print STDOUT "agcount=$1\nagsize=$2\n";
> > > +		}
> > > +		if (/^data\s+=\s+bsize=(\d+)\s/) {
> > > +			print STDOUT "dbsize=$1\n";
> > > +		}' > $tmp.mkfs
> > > +
> > > +	. $tmp.mkfs
> > > +	if [ -n "$agcount" -a -n "$agsize" -a -n "$dbsize" ];then
> > > +		for ((i = 0; i < agcount; i++)); do
> > > +			$XFS_IO_PROG -c "pwrite $((i * dbsize * agsize)) $dbsize" \
> > > +				$SCRATCH_DEV >/dev/null;
> > > +		done
> > > +       fi
> > > +       rm -f $tmp.mkfs
> > > +}
> > > 
> > 
> > 
