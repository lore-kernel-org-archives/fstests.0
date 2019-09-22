Received: from mx1.redhat.com ([209.132.183.28]:35274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfIVLRn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 22 Sep 2019 07:17:43 -0400
Date: Sun, 22 Sep 2019 19:25:12 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v2] common/xfs: wipe the XFS superblock of each AGs
Message-ID: <20190922112512.GP7239@dhcp-12-102.nay.redhat.com>
References: <20190920062327.14747-1-zlang@redhat.com>
 <20190920153443.GR2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920153443.GR2229799@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 20, 2019 at 08:34:43AM -0700, Darrick J. Wong wrote:
> On Fri, Sep 20, 2019 at 02:23:27PM +0800, Zorro Lang wrote:
> > xfs/030 always fails after d0e484ac699f ("check: wipe scratch devices
> > between tests") get merged.
> > 
> > Due to xfs/030 does a sized(100m) mkfs. Before we merge above commit,
> > mkfs.xfs detects an old primary superblock, it will write zeroes to
> > all superblocks before formatting the new filesystem. But this won't
> > be done if we wipe the first superblock(by merging above commit).
> > 
> > That means if we make a (smaller) sized xfs after wipefs, those *old*
> > superblocks which created by last time mkfs.xfs will be left on disk.
> > Then when we do xfs_repair, if xfs_repair can't find the first SB, it
> > will go to find those *old* SB at first. When it finds them,
> > everyting goes wrong.
> > 
> > So I try to get XFS AG geometry(by default) and then try to erase all
> > superblocks. Thanks Darrick J. Wong helped to analyze this issue.
> > 
> > Reported-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > V2 did below changes:
> > 1) Use xfs_db to detect the real xfs geometry
> > 2) Do a $FSTYP specified wipe before trying to wipefs all scratch devices
> > 
> > Thanks,
> > Zorro
> > 
> >  common/rc  |  8 ++++++++
> >  common/xfs | 20 ++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 66c7fd4d..56329747 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4045,6 +4045,14 @@ _try_wipe_scratch_devs()
> >  {
> >  	test -x "$WIPEFS_PROG" || return 0
> >  
> > +	# Do specified filesystem wipe at first
> > +	case "$FSTYP" in
> > +	"xfs")
> > +		_try_wipe_scratch_xfs
> > +		;;
> > +	esac
> > +
> > +	# Then do wipefs on all scratch devices
> >  	for dev in $SCRATCH_DEV_POOL $SCRATCH_DEV $SCRATCH_LOGDEV $SCRATCH_RTDEV; do
> >  		test -b $dev && $WIPEFS_PROG -a $dev
> >  	done
> > diff --git a/common/xfs b/common/xfs
> > index 1bce3c18..082a1744 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -884,3 +884,23 @@ _xfs_mount_agcount()
> >  {
> >  	$XFS_INFO_PROG "$1" | grep agcount= | sed -e 's/^.*agcount=\([0-9]*\),.*$/\1/g'
> >  }
> > +
> > +# Wipe the superblock of each XFS AGs
> > +_try_wipe_scratch_xfs()
> > +{
> > +	local num='^[0-9]+$'
> > +	local agcount
> > +	local agsize
> > +	local dbsize
> > +
> > +	agcount=`_scratch_xfs_get_sb_field agcount 2>/dev/null`
> > +	agsize=`_scratch_xfs_get_sb_field agblocks 2>/dev/null`
> > +	dbsize=`_scratch_xfs_get_sb_field blocksize 2>/dev/null`
> > +
> > +	if [[ $agcount =~ $num && $agsize =~ $num && $dbsize =~ $num ]];then
> > +		for ((i = 0; i < agcount; i++)); do
> > +			$XFS_IO_PROG -c "pwrite $((i * dbsize * agsize)) $dbsize" \
> > +				$SCRATCH_DEV >/dev/null;
> > +		done
> > +	fi
> 
> What happened to the loop that simulates a _scratch_mkfs_xfs run (to get
> the AG geometry) and then zaps that too?  You need both zeroing loops to
> make sure xfs/030 doesn't trip over old superblocks, right?

Hi,

Sorry I'm not sure what you mean. Do you mean I'd better to do two zeroing
loops, one is as above, the other is for default mkfs.xfs geometry as
below[1]?

Thanks,
Zorro

[1]
  local tmp=`mktemp -u`
  _scratch_mkfs_xfs -N 2>/dev/null | perl -ne '
    if (/^meta-data=.*\s+agcount=(\d+), agsize=(\d+) blks/) {
      print STDOUT "agcount=$1\nagsize=$2\n";
    }
    if (/^data\s+=\s+bsize=(\d+)\s/) {
      print STDOUT "dbsize=$1\n";
    }' > $tmp.mkfs

  . $tmp.mkfs
  if [ -n "$agcount" -a -n "$agsize" -a -n "$dbsize" ];then
    for ((i = 0; i < agcount; i++)); do
      $XFS_IO_PROG -c "pwrite $((i * dbsize * agsize)) $dbsize" \
         $SCRATCH_DEV >/dev/null;
    done
  fi
  rm -f $tmp.mkfs



> 
> --D
> 
> > +}
> > -- 
> > 2.20.1
> > 
