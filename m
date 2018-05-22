Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:27345 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751060AbeEVFTU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 May 2018 01:19:20 -0400
Date: Tue, 22 May 2018 15:19:16 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/132: umount scratch device after finishing test
Message-ID: <20180522051916.GT10363@dastard>
References: <1526704344-19615-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180521023631.GN10363@dastard>
 <5B027930.4050203@cn.fujitsu.com>
 <20180521224641.GR23861@dastard>
 <5B039746.1000309@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B039746.1000309@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Tue, May 22, 2018 at 12:06:30PM +0800, Xiao Yang wrote:
> On 2018/05/22 6:46, Dave Chinner wrote:
> >On Mon, May 21, 2018 at 03:45:52PM +0800, Xiao Yang wrote:
> >>On 2018/05/21 10:36, Dave Chinner wrote:
> >>>On Sat, May 19, 2018 at 12:32:24PM +0800, Xiao Yang wrote:
> >>>>xfs/132 and xfs/133 running together got the following error:
> >>>>------------------------------------------------------------
> >>>>...
> >>>>xfs/132 1s ... 1s
> >>>>xfs/133 1s ... [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//xfs/133.out.bad)
> >>>>...
> >>>>QA output created by 133
> >>>>-Format and mount
> >>>>-Corrupt filesystem
> >>>>-Remount, try to append
> >>>>-Write did not succeed (ok).
> >>>>+SCRATCH_DEV=/dev/sda11 is mounted but not on SCRATCH_MNT=common/config: - aborting
> >>>>+Already mounted result:
> >>>>+/dev/sda11 /mnt/xfstests/scratch
> >>>>...
> >>>>------------------------------------------------------------
> >>>>
> >>>>xfs/132 led to XFS shutdown due to the corrupted inode, but it didn't rectify XFS
> >>>>by umount scratch device.
> >>>AFAIK, we don't have to unmount the scratch device when a test
> >>>finishes - the test harness is supposed to do that and make sure
> >>>that it is in the correct state for the next test to run.
> >>>
> >>>It seems that somewhere along the line this got broken. - I'm
> >>>guessing the fact that this test also says "don't check the scratch
> >>>device" the test harness is failing to unmount it because it's not
> >>>running _check_scratch_device. I'm guessing that it should at least
> >>>run _scratch_unmount....
> >>Hi Dave,
> >>
> >>Could we just make the test harness call _scratch_unmount after running every test, as below:
> >>--------------------------------------------------------------
> >>diff --git a/check b/check
> >>index 96198ac..63ece67 100755
> >>--- a/check
> >>+++ b/check
> >>@@ -815,6 +815,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
> >>                 _make_testcase_report "$tc_status"
> >>             fi
> >>             seq="after_$seqnum"
> >>+           _scratch_unmount 2>   /dev/null
> >>         done
> >>         sect_stop=`_wallclock`
> >>         interrupt=false
> >Sort of. The problem is in _check_filesystem, though, where it does
> >nothing when _require_scratch_nocheck() is used. It needs to cycle
> >the mount in this case, and then the main loop doesn't need to be
> >touched...
> Hi Dave,
> 
> What about cycling the mount when _require_scratch_nocheck() or _notrun is called?
> --------------------------------------------------------------------
> diff --git a/check b/check
> index 96198ac..ea94524 100755
> --- a/check
> +++ b/check
> @@ -489,10 +489,14 @@ _check_filesystems()
>         if [ -f ${RESULT_DIR}/require_test ]; then
>                 _check_test_fs || err=true
>                 rm -f ${RESULT_DIR}/require_test*
> +       else
> +               _test_cycle_mount
>         fi
>         if [ -f ${RESULT_DIR}/require_scratch ]; then
>                 _check_scratch_fs || err=true
>                 rm -f ${RESULT_DIR}/require_scratch*
> +       else
> +               _scratch_cycle_mount
>         fi
>  }
> --------------------------------------------------------------------

I would just unmount them. _require_test will mount the test device
if it's unmounted, and _require_scratch unmounts it if it is
mounted. Hence there is no real need to mount it again here,
especially as trying to mount a corrupt scratch device can throw
errors...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
