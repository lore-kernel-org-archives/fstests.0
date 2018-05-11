Received: from userp2130.oracle.com ([156.151.31.86]:51336 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeEKDdZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 May 2018 23:33:25 -0400
Date: Thu, 10 May 2018 20:33:05 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] xfs: new helper grows the mounted scratch XFS
 filesystem
Message-ID: <20180511033305.GG25312@magnolia>
References: <20180510163832.7858-1-zlang@redhat.com>
 <20180510175406.GH4116@magnolia>
 <20180511033113.GE1963@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511033113.GE1963@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 11, 2018 at 11:31:13AM +0800, Zorro Lang wrote:
> On Thu, May 10, 2018 at 10:54:06AM -0700, Darrick J. Wong wrote:
> > On Fri, May 11, 2018 at 12:38:32AM +0800, Zorro Lang wrote:
> > > When test on large SCRATCH_DEV, grow a small XFS to huge size is a
> > > horrible thing (e.g grow 128m to 500T). So add a helper named
> > > _scratch_xfs_growfs() to do below things:
> > > 
> > > 1) If a 'size' argument is specified, the filesystem will not be
> > >    grown larger than that size (depend on the device size).
> > > 2) else if LARGE_SCRATCH_DEV = yes (--large-fs option), the
> > >    filesystem will not be grown larger than 10x the current fs size.
> > > 3) else the scratch filesystem will be expanded to fit the scratch
> > >    device.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > > 
> > > Hi,
> > > 
> > > Thanks Eryu and Darrick help to review this patch.
> > > 
> > > V2 has below changes:
> > > 1) Change function name _scratch_xfs_growfs_limited to _scratch_xfs_growfs
> > > 2) Change the comment about _scratch_xfs_growfs
> > > 3) Change local variable limit_size to max_size
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > >  common/xfs    | 36 ++++++++++++++++++++++++++++++++++++
> > >  tests/xfs/002 |  2 +-
> > >  tests/xfs/127 |  2 +-
> > >  tests/xfs/233 |  2 +-
> > >  4 files changed, 39 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/common/xfs b/common/xfs
> > > index e0bc3f43..a6fe5bf9 100644
> > > --- a/common/xfs
> > > +++ b/common/xfs
> > > @@ -721,3 +721,39 @@ _require_xfs_db_write_array()
> > >  	rm -f $TEST_DIR/$seq.img
> > >  	[ $supported -eq 0 ] && _notrun "xfs_db write can't support array"
> > >  }
> > > +
> > > +# Usage: _scratch_xfs_growfs [max_size_in_bytes]
> > > +#
> > > +# If max_size_in_bytes is specified, the filesystem will *not* be grown larger
> > > +# than that size (depend on the device size).
> > > +# Else if LARGE_SCRATCH_DEV = yes (--large-fs option), the filesystem will
> > > +# not be grown larger than 10x the current fs size.
> > > +# Else the scratch filesystem will be expanded to fit the scratch device.
> > > +_scratch_xfs_growfs()
> > > +{
> > > +	local max_size="$1"
> > > +	local option=""
> > > +
> > > +	if [ "$LARGE_SCRATCH_DEV" = "yes" -o -n "$max_size" ]; then
> > > +		local tmp=`mktemp -u`
> > > +		xfs_info $SCRATCH_MNT | _filter_mkfs > /dev/null 2>$tmp.info
> > 
> > $XFS_INFO_PROG, not xfs_info (?)
> > 
> > Otherwise mostly looks fine to me.
> 
> There's not $XFS_INFO_PROG in xfstests for now.

DOH, sorry, it exists in my tree as a patch that I've been holding onto
for xfsprogs 4.17.  Ignore me for now.

--D

> > 
> > --D
> > 
> > > +		. $tmp.info
> > > +		rm -f $tmp.info
> > > +
> > > +		local fs_size=$((dbsize * dblocks))
> > > +		local dev_size_kb=`_get_device_size $SCRATCH_DEV`
> > > +
> > > +		# default max_size is 10 times current fs size.
> > > +		if [ -z "$max_size" ]; then
> > > +			max_size=$((fs_size * 10))
> > > +		fi
> > > +		# don't limit growfs size if device size is smaller
> > > +		if [ $((dev_size_kb * 1024)) -gt $max_size ]; then
> > > +			option="-D $((max_size / dbsize))"
> > > +		else
> > > +			option=""
> > > +		fi
> > > +	fi
> > > +
> > > +	$XFS_GROWFS_PROG $option $SCRATCH_MNT
> > > +}
> > > diff --git a/tests/xfs/002 b/tests/xfs/002
> > > index 741117be..a77a8719 100755
> > > --- a/tests/xfs/002
> > > +++ b/tests/xfs/002
> > > @@ -68,7 +68,7 @@ _scratch_xfs_db -x -c "sb 2" -c "type data" -c "write fill 0xff 224 4"
> > >  _scratch_mount
> > >  
> > >  # This should pass
> > > -$XFS_GROWFS_PROG $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "growfs failed"
> > > +_scratch_xfs_growfs >> $seqres.full 2>&1 || _fail "growfs failed"
> > >  
> > >  # success, all done
> > >  status=0
> > > diff --git a/tests/xfs/127 b/tests/xfs/127
> > > index 9df99904..272ea959 100755
> > > --- a/tests/xfs/127
> > > +++ b/tests/xfs/127
> > > @@ -61,7 +61,7 @@ _cp_reflink $testdir/original $testdir/copy1
> > >  _cp_reflink $testdir/copy1 $testdir/copy2
> > >  
> > >  echo "Grow fs"
> > > -$XFS_GROWFS_PROG $SCRATCH_MNT 2>&1 |  _filter_growfs >> $seqres.full
> > > +_scratch_xfs_growfs 2>&1 | _filter_growfs >> $seqres.full
> > >  _scratch_cycle_mount
> > >  
> > >  echo "Create more reflink copies"
> > > diff --git a/tests/xfs/233 b/tests/xfs/233
> > > index e61c444d..f3689bc9 100755
> > > --- a/tests/xfs/233
> > > +++ b/tests/xfs/233
> > > @@ -59,7 +59,7 @@ cp -p $testdir/original $testdir/copy1
> > >  cp -p $testdir/copy1 $testdir/copy2
> > >  
> > >  echo "Grow fs"
> > > -$XFS_GROWFS_PROG $SCRATCH_MNT 2>&1 |  _filter_growfs >> $seqres.full
> > > +_scratch_xfs_growfs 2>&1 |  _filter_growfs >> $seqres.full
> > >  _scratch_cycle_mount
> > >  
> > >  echo "Create more copies"
> > > -- 
> > > 2.14.3
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
