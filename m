Received: from aserp1040.oracle.com ([141.146.126.69]:24862 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504AbcHCWIi (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2016 18:08:38 -0400
Date: Wed, 3 Aug 2016 15:08:00 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 06/17] xfs: run xfs_repair at the end of each test
Message-ID: <20160803220800.GR8590@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914481474.11762.2741429828012981240.stgit@birch.djwong.org>
 <20160803091542.GM27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160803091542.GM27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: david@fromorbit.com, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 03, 2016 at 05:15:42PM +0800, Eryu Guan wrote:
> On Thu, Jul 21, 2016 at 04:46:54PM -0700, Darrick J. Wong wrote:
> > Run xfs_repair twice at the end of each test -- once to rebuild
> > the btree indices, and again with -n to check the rebuild work.
> 
> Seems like it's two more xfs_repair, three in total :)

Ok, how about this new commit message?

"xfs: optionally test xfs_repair index rebuilding at the end of each test

"Run xfs_repair twice more at the end of each test -- once to rebuild
the btree indices, and again with -n to check the rebuild work.  This
is in addition to the regular dry-run spot check."

> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  README    |    4 ++++
> >  common/rc |   30 ++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> > 
> > 
> > diff --git a/README b/README
> > index 2647e12..4509cc1 100644
> > --- a/README
> > +++ b/README
> > @@ -80,6 +80,10 @@ Preparing system for tests (IRIX and Linux):
> >                 added to the end of fsstresss and fsx invocations, respectively,
> >                 in case you wish to exclude certain operational modes from these
> >                 tests.
> > +             - set TEST_XFS_REPAIR_REBUILD=1 to have _check_xfs_filesystem
> > +               run xfs_repair -n to check the filesystem; xfs_repair to rebuild
> > +               metadata indexes; and xfs_repair -n (a third time) to check the
> > +               results of the rebuilding.
> >  
> >          - or add a case to the switch in common/config assigning
> >            these variables based on the hostname of your test
> > diff --git a/common/rc b/common/rc
> > index 7c79bf8..3b45578 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2428,6 +2428,36 @@ _check_xfs_filesystem()
> >          ok=0
> >      fi
> >  
> > +    if [ -n "$TEST_XFS_REPAIR_REBUILD" ]; then
> > +        $XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
> > +        if [ $? -ne 0 ]
> > +        then
> > +            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (r) (see $seqres.full)"
> > +
> > +            echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
> > +            echo "*** xfs_repair -n output ***"	>>$seqres.full
> > +            cat $tmp.repair | _fix_malloc		>>$seqres.full
> > +            echo "*** end xfs_repair output"	>>$seqres.full
> > +
> > +            ok=0
> > +        fi
> > +        rm -f $tmp.fs_check $tmp.logprint $tmp.repair
> > +
> > +        $XFS_REPAIR_PROG $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
> > +        if [ $? -ne 0 ]
> > +        then
> > +            echo "_check_xfs_filesystem: filesystem on $device is inconsistent (r) (see $seqres.full)"
> > +
> > +            echo "_check_xfs_filesystem: filesystem on $device is inconsistent" >>$seqres.full
> > +            echo "*** xfs_repair -n output ***"	>>$seqres.full
> > +            cat $tmp.repair | _fix_malloc		>>$seqres.full
> > +            echo "*** end xfs_repair output"	>>$seqres.full
> > +
> > +            ok=0
> > +        fi
> > +        rm -f $tmp.fs_check $tmp.logprint $tmp.repair
> > +    fi
> > +
> 
> I think we can move this hunk after the original xfs_repair and swap the
> xfs_repair order, i.e.
> 
> xfs_repair -n # this is the original repair check
> if <check_rebuild>; then
> 	xfs_repair # do rebuild without -n
> 	xfs_repair -n # check rebuild result
> fi

Ok.

> This seems more clear to me and we can mark which repair is failing more
> easily (right now the three xfs_repairs are all marked as "(r)", it's
> hard to say which one is failing), e.g.
> 
> xfs_repair -n # marked as "(r)", means "repair"
> if <check_rebuild>; then
> 	xfs_repair # mark as "(rb)", means "rebuild"?
> 	xfs_repair -n # mark as "(rr)", means "repair rebuild"?

We might as well use a full word to state which repair run failed.

"filesystem on /dev/sdX is inconsistent (rebuild)"
"filesystem on /dev/sdX is inconsistent (rebuild-reverify)"

--D

> fi
> 
> Thanks,
> Eryu
> 
> >      $XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
> >      if [ $? -ne 0 ]
> >      then
> > 
