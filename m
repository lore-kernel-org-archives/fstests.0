Received: from mx1.redhat.com ([209.132.183.28]:54217 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdGRFFJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Jul 2017 01:05:09 -0400
Date: Tue, 18 Jul 2017 13:05:07 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [RFC PATCH] check: try to fix the test device if it gets
 corrupted
Message-ID: <20170718050507.GU2478@eguan.usersys.redhat.com>
References: <20170302232050.31125-1-tytso@mit.edu>
 <20170303090332.GP14226@eguan.usersys.redhat.com>
 <20170303172157.GA5070@birch.djwong.org>
 <20170303230129.apzqe77r4d5jtf63@thunk.org>
 <20170327014802.wc5as2tdgecy3rzu@thunk.org>
 <20170327085103.GQ14226@eguan.usersys.redhat.com>
 <20170716013058.r46jceccqmoedkde@thunk.org>
 <20170717234508.GB4217@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717234508.GB4217@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 17, 2017 at 04:45:08PM -0700, Darrick J. Wong wrote:
> On Sat, Jul 15, 2017 at 09:30:58PM -0400, Theodore Ts'o wrote:
> > On Mon, Mar 27, 2017 at 04:51:03PM +0800, Eryu Guan wrote:
> > > 
> > > Sorry I lost this thread, I thought I've replied but apparently I didn't..
> > > 
> > > I agreed with both of you and Darrick, I think we can try to repair the
> > > corrupted test fs, and if repair succeeds we can continue the test, and
> > > stop running the whole test if repair fails.
> > 
> > Sorry for the delay in getting back to this.  Things got busy and this
> > got dropped on my end.
> > 
> > I've fixed the whitespace nits that you pointed out and am using _log_err.
> > 
> > > I think we should try to fix other filesystems too?
> > 
> > Hmm...  yeah.  The main reason why I hadn't was because xfs has
> > _scratch_xfs_repair and _scratch_xfs_check, which are very similar.
> > But _check_xfs_test_fs looks *very* different from _scratch_xfs_check,
> > and I'm not sure why.
> 
> _check_xfs_filesystem is a helper that does all the checking that we can
> do to an xfs filesystem (online fsck, the old xfs_check, and the newer
> xfs_repair).  AFAICT that's what all new xfstest code should be calling.
> xfs_check is obsolete.

Agreed.

> 
> _check_xfs_test_fs calls _check_xfs_filesystem and then, weirdly, calls
> a nonexistent tool calld xfs_repair_ipaths to .... I assume fix all the
> problems that can crop with the Irix XFS parent pointer implementation.
> None of that exists on Linux and Irix is long dead, so I assume the
> "check for ipath consistency" can go away entirely.

Agreed.

> 
> _scratch_xfs_check calls xfs_check directly, so I think it should get
> replaced with _check_scratch_fs, which calls _check_xfs_filesystem.

Agreed again :)

> 
> <keep scrolling>
> 
> > 
> > So I've created a _repair_xfs_test_fs which is modelled after the
> > simpler _scratch_xfs_repair function, but I'm not 100% sure that is
> > correct.
> > 
> > Anyways, WDYT?
> > 
> > 						- Ted
> > 
> > From 96a13cc22878ee5c016a606d76f8e9a6bd84eb20 Mon Sep 17 00:00:00 2001
> > From: Theodore Ts'o <tytso@mit.edu>
> > Date: Wed, 1 Mar 2017 19:54:08 -0500
> > Subject: [PATCH] check: try to fix the test device if it gets corrupted
> > 
> > If the test device gets corrupted all subsequent tests will fail.  To
> > prevent this from causing all subsequent tests to be useless, try
> > repair the file system on TEST_DEV if possible.  We don't need to do
> > this with the scratch device since that file system gets recreated
> > each time anyway.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  check      |  7 ++++++-
> >  common/rc  | 41 +++++++++++++++++++++++++++++++++++++++++
> >  common/xfs | 12 ++++++++++++
> >  3 files changed, 59 insertions(+), 1 deletion(-)
> > 
> > diff --git a/check b/check
> > index f8db3cd6..d89d2e91 100755
> > --- a/check
> > +++ b/check
> > @@ -476,7 +476,12 @@ _summary()
> >  _check_filesystems()
> >  {
> >  	if [ -f ${RESULT_DIR}/require_test ]; then
> > -		_check_test_fs || err=true
> > +		if ! _check_test_fs ; then
> > +			err=true
> > +			echo "Trying to repair broken TEST_DEV file system"
> > +			_repair_test_fs

Should we stop running if _repair_test_fs failed to fix TEST_DEV? I
think that was what Darrick first suggested. And I think unfixable
errors will cause subsequent tests to fail too.

> > +			_test_mount
> > +		fi
> >  		rm -f ${RESULT_DIR}/require_test*
> >  	fi
> >  	if [ -f ${RESULT_DIR}/require_scratch ]; then
> > diff --git a/common/rc b/common/rc
> > index 328b6b07..d37a1611 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1201,6 +1201,47 @@ _repair_scratch_fs()
> >      esac
> >  }
> >  
> > +_repair_test_fs()
> > +{
> > +	case $FSTYP in
> > +	xfs)
> > +		_repair_xfs_test_fs "$@" >$tmp.repair 2>&1
> > +		res=$?

Better to declare res as a local variable. I know this was copied from
_repair_scratch_fs, but better to get it improved in new code :)

> > +		if [ "$res" -ne 0 ]; then
> > +			echo "xfs_repair returns $res; replay log?" >>$tmp.repair
> > +			_test_mount
> > +			res=$?
> > +			if [ $res -gt 0 ]; then
> > +				echo "mount returns $res; zap log?" >>$tmp.repair
> > +				_xfs_repair_test_fs -L >>$tmp.repair 2>&1

                                meant _repair_xfs_test_fs here?

> > +				echo "log zap returns $?" >> $tmp.repair
> > +			else
> > +				umount "$TEST_DEV"
> > +			fi
> > +			_xfs_repair_test_fs "$@" >>$tmp.repair 2>&1

same here, _repair_xfs_test_fs is what really being added in common/xfs.
(Though I'd like to rename it, see below.)

> > +			res=$?
> > +		fi
> 
> Structurally this all looks ok, but it's a little weird that we have
> _scratch_xfs_repair for the scratch device (object-verb) but
> _repair_test_fs (verb-object) for the test device.

My best guess is that _repair_scratch_fs and _repair_test_fs are helpers
in a higher level, and are defined in common/rc, they deal with all
filesystem types.

_scratch_xfs_repair is xfs specific, and defined in common/xfs, it only
deals with xfs. So the naming schema is different but they are also in
different "namespace"s, which looks fine to me :)

> 
> --D
> 
> > +		;;
> > +	*)
> > +		# Let's hope fsck -y suffices...
> > +		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
> > +		res=$?
> > +		if test "$res" -lt 4 ; then
> > +			res=0
> > +		fi
> > +		;;
> > +	esac
> > +	if [ $res -ne 0 ]; then
> > +		_log_err "_repair_test_fs: failed, err=$res"
> > +		echo "*** fsck.$FSTYP output ***"	>>$seqres.full
> > +		cat $tmp.repair				>>$seqres.full
> > +		echo "*** end fsck.$FSTYP output"	>>$seqres.full
> > +
> > +	fi
> > +	rm -f $tmp.repair
> > +	return $res
> > +}
> > +
> >  _get_pids_by_name()
> >  {
> >      if [ $# -ne 1 ]
> > diff --git a/common/xfs b/common/xfs
> > index a1ee3847..c8f4e46b 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -443,6 +443,18 @@ _check_xfs_test_fs()
> >  	fi
> >  }
> >  
> > +# modeled after _scratch_xfs_repair
> > +_repair_xfs_test_fs()

Like I mentioned above, this helper is meant to pair with
_scratch_xfs_repair, so following the same naming schema, rename it to
_test_xfs_repair? Like the _test_xfs_logprint and _scratch_xfs_logprint
pair.

Thanks,
Eryu

> > +{
> > +	TEST_OPTIONS=""
> > +	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_LOGDEV" ] && \
> > +		TEST_OPTIONS="-l$TEST_LOGDEV"
> > +	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_RTDEV" ] && \
> > +		TEST_OPTIONS=$TEST_OPTIONS" -r$TEST_RTDEV"
> > +	[ "$LARGE_TEST_DEV" = yes ] && TEST_OPTIONS=$TEST_OPTIONS" -t"
> > +	$XFS_REPAIR_PROG $TEST_OPTIONS $* $TEST_DEV
> > +}
> > +
> >  _require_xfs_test_rmapbt()
> >  {
> >  	_require_test
> > -- 
> > 2.11.0.rc0.7.gbe5a750
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
