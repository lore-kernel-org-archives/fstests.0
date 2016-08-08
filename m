Received: from userp1040.oracle.com ([156.151.31.81]:42129 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbcHHSDi (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 8 Aug 2016 14:03:38 -0400
Date: Mon, 8 Aug 2016 11:03:30 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 15/17] xfs: scrub fs (if still mounted) at the end of the
 test
Message-ID: <20160808180330.GE11291@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914487167.11762.17599617419019795848.stgit@birch.djwong.org>
 <20160808085239.GD27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160808085239.GD27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: david@fromorbit.com, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 08, 2016 at 04:52:39PM +0800, Eryu Guan wrote:
> On Thu, Jul 21, 2016 at 04:47:51PM -0700, Darrick J. Wong wrote:
> > Teach _check_xfs_filesystem to scrub mounted filesystems before
> > unmounting and fscking them.  This is mostly to test the online
> > scrub tool...
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  README        |    3 +++
> >  common/config |    1 +
> >  common/rc     |    7 +++++++
> >  3 files changed, 11 insertions(+)
> > 
> > 
> > diff --git a/README b/README
> > index 4509cc1..c19fcb1 100644
> > --- a/README
> > +++ b/README
> > @@ -84,6 +84,9 @@ Preparing system for tests (IRIX and Linux):
> >                 run xfs_repair -n to check the filesystem; xfs_repair to rebuild
> >                 metadata indexes; and xfs_repair -n (a third time) to check the
> >                 results of the rebuilding.
> > +	     - set TEST_XFS_SCRUB=1 to have _check_xfs_filesystem run
> > +	       xfs_scrub -vd to scrub the filesystem metadata online before
> > +               unmounting to run the offline check.
> 
> Mixed space and tab in above lines, I can fix it at commit time.

Ok.  Sorry about that,

--D

> 
> Thanks,
> Eryu
> 
> >  
> >          - or add a case to the switch in common/config assigning
> >            these variables based on the hostname of your test
> > diff --git a/common/config b/common/config
> > index 08d5d80..168f46c 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -163,6 +163,7 @@ export XFS_REPAIR_PROG="`set_prog_path xfs_repair`"
> >  export XFS_DB_PROG="`set_prog_path xfs_db`"
> >  export XFS_GROWFS_PROG=`set_prog_path xfs_growfs`
> >  export XFS_IO_PROG="`set_prog_path xfs_io`"
> > +export XFS_SCRUB_PROG="`set_prog_path xfs_scrub`"
> >  export XFS_PARALLEL_REPAIR_PROG="`set_prog_path xfs_prepair`"
> >  export XFS_PARALLEL_REPAIR64_PROG="`set_prog_path xfs_prepair64`"
> >  export __XFSDUMP_PROG="`set_prog_path xfsdump`"
> > diff --git a/common/rc b/common/rc
> > index 3b45578..861a721 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2391,6 +2391,13 @@ _check_xfs_filesystem()
> >  
> >      if [ "$type" = "xfs" ]
> >      then
> > +        if [ -n "$TEST_XFS_SCRUB" ] && [ -x "$XFS_SCRUB_PROG" ]; then
> > +            "$XFS_SCRUB_PROG" $scrubflag -vd $device >>$seqres.full
> > +            if [ $? -ne 0 ]; then
> > +                echo "filesystem on $device failed scrub (see $seqres.full)"
> > +                ok=0
> > +            fi
> > +        fi
> >          # mounted ...
> >          mountpoint=`_umount_or_remount_ro $device`
> >      fi
> > 
