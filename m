Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:50728 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbbBEDMq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 4 Feb 2015 22:12:46 -0500
Date: Thu, 5 Feb 2015 14:12:29 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 7/8 v4] tests/xfs: add f2fs testcase and convert them
 being generic
Message-ID: <20150205031229.GH12722@dastard>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
 <1423004840-45315-8-git-send-email-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1423004840-45315-8-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 03, 2015 at 03:07:19PM -0800, Jaegeuk Kim wrote:
> This patch changes the following xfs's testcases to be generic ones by adding
> f2fs support.
> 
>  xfs/051
>  xfs/085
>  xfs/086
>  xfs/087
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  tests/xfs/051          |   18 +-
>  tests/xfs/085          |    9 +-
>  tests/xfs/086          |   34 +-
>  tests/xfs/086.out      | 4722 ------------------------------------------------
>  tests/xfs/086.out.f2fs | 3306 +++++++++++++++++++++++++++++++++
>  tests/xfs/086.out.xfs  | 4722 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/087          |   58 +-
>  tests/xfs/087.out      |  389 ----
>  tests/xfs/087.out.f2fs |  303 ++++
>  tests/xfs/087.out.xfs  |  389 ++++
>  10 files changed, 8812 insertions(+), 5138 deletions(-)
>  delete mode 100644 tests/xfs/086.out
>  create mode 100644 tests/xfs/086.out.f2fs
>  create mode 100644 tests/xfs/086.out.xfs
>  delete mode 100644 tests/xfs/087.out
>  create mode 100644 tests/xfs/087.out.f2fs
>  create mode 100644 tests/xfs/087.out.xfs
> 
> diff --git a/tests/xfs/051 b/tests/xfs/051
> index a84746b..f2f21f0 100755
> --- a/tests/xfs/051
> +++ b/tests/xfs/051
> @@ -45,16 +45,20 @@ _cleanup()
>  . ./common/dmflakey
>  
>  # Modify as appropriate.
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os Linux
>  
>  _require_scratch
> +_require_scratch_shutdown
>  _require_dm_flakey
> -_require_xfs_sysfs debug/log_recovery_delay
> +
> +if [ "$FSTYP" == "xfs" ]; then
> +    _require_xfs_sysfs debug/log_recovery_delay
> +fi

Really, this is an XFS specific test unless you can reliably
trigger IO errors in the middle of log recovery. Otherwise you
aren't actually testing what the regression test is actually trying
to cover.

> diff --git a/tests/xfs/085 b/tests/xfs/085
> index 54c2d01..db394eb 100755
> --- a/tests/xfs/085
> +++ b/tests/xfs/085
> @@ -40,16 +40,21 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
>  . ./common/log
>  
>  # real QA test starts here
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os IRIX Linux
>  
>  rm -f $seqres.full
>  rm -f $tmp.log
>  
>  _require_scratch
> +_require_scratch_shutdown
> +
> +if [ "$FSTYP" == "f2fs" ]; then
> +    _require_dumpf2fs
> +fi

_require_logstate, as per comments in the previous patch.

>  
>  echo "mkfs"
> -_scratch_mkfs_xfs >>$seqres.full 2>&1 \
> +_scratch_mkfs >>$seqres.full 2>&1 \
>      || _fail "mkfs scratch failed"

We don't need to catch failure here, and it needs to be done before
the shutdown require....

>  echo "mount"
> diff --git a/tests/xfs/086 b/tests/xfs/086
> index af09c7f..037b81d 100755
> --- a/tests/xfs/086
> +++ b/tests/xfs/086
> @@ -24,6 +24,7 @@
>  #-----------------------------------------------------------------------
>  #
>  
> +seqfull=$0
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
>  echo "QA output created by $seq"
> @@ -39,17 +40,28 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
>  . ./common/log
>  
>  # real QA test starts here
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os IRIX Linux
>  
>  rm -f $seqres.full $tmp.*
>  _require_scratch
> -_require_v2log
> +_require_scratch_shutdown
> +
> +case "$FSTYP" in
> +    xfs)
> +        _require_v2log
> +        ;;
> +    f2fs)
> +        _require_dumpf2fs
> +esac

It's pretty safe to make this _require_logstate() - v2 log support
has been around long enough with XFS that we probably don't need to
test for it anymore.

> +# link correct .out file
> +_link_out_file_fs $seq.out $seqfull.out

I don't think we need multiple output files.

>  echo "*** init FS"
>  umount $SCRATCH_DEV >/dev/null 2>&1
>  
> -cat >$tmp.seq.params <<EOF
> +cat >$tmp.seq.params.xfs <<EOF
>  # mkfs-opt             mount-opt
>  # ------------------------------
>    version=2            logbsize=32k
> @@ -64,6 +76,20 @@ cat >$tmp.seq.params <<EOF
>    version=2,su=256k    logbsize=256k
>  EOF
>  
> +cat >$tmp.seq.params.f2fs <<EOF
> +# mkfs-opt  mount-opt
> +# ---------------------------
> +  test1     active_logs=6,background_gc=off
> +  test2     active_logs=6,background_gc=off,inline_data
> +  test3     active_logs=6,background_gc=off,inline_dentry
> +  test4     active_logs=6,background_gc=off,inline_dentry,inline_data
> +  test5     active_logs=6,background_gc=off,disable_roll_forward
> +  test6     active_logs=4,background_gc=off
> +  test7     active_logs=2,background_gc=off
> +EOF
> +
> +cat $tmp.seq.params.$FSTYP > $tmp.seq.params

_get_log_configs > $tmp.seq.params

And wrap the log configuration dump into fs specific functions
somewhere. e.g. common/log

Also, it needs to have the same number of options in the table
as the XFS log option table. If you do that, then with one minor
tweak (below) we don't need filesystem specific golden output files.

>  # Do the work for various log params which
>  # should not effect the data content of the log
>  # Try with and without sync'ing - sync'ing will mean that
> @@ -84,7 +110,7 @@ for s in sync nosync ; do
>  
>  	# mkfs the FS
>  	_echofull "mkfs"
> -	_scratch_mkfs_xfs >>$seqres.full 2>&1
> +	_scratch_mkfs >>$seqres.full 2>&1
>  	if [ $? -ne 0 ] ; then 
>  	    _echofull "mkfs failed: $MKFS_OPTIONS"
>  	    continue
> diff --git a/tests/xfs/086.out b/tests/xfs/086.out
> deleted file mode 100644
> index ac56cc2..0000000
> --- a/tests/xfs/086.out
> +++ /dev/null
> @@ -1,4722 +0,0 @@
> -QA output created by 086
> -*** init FS
> ---- mkfs=version=2, mnt=logbsize=32k, sync=sync ---

This is the only output in the golden image file that changes
between xfs and f2fs. It doesn't need to be in the golden output
file - it can just be dumped in the $seqres.full file.

Similar changes can be made to 087 as well.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
