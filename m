Received: from sandeen.net ([63.231.237.45]:58826 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758200AbcILM7E (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Sep 2016 08:59:04 -0400
Subject: Re: [PATCH v3] xfs/098: fix xfs_repair on newer xfsprogs
References: <20160909122831.GD12847@dhcp12-143.nay.redhat.com>
 <1473657237-13148-1-git-send-email-yangx.jy@cn.fujitsu.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <8daf0b97-0614-6dba-4477-f52c4c7290e1@sandeen.net>
Date: Mon, 12 Sep 2016 07:59:02 -0500
MIME-Version: 1.0
In-Reply-To: <1473657237-13148-1-git-send-email-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
Cc: zlang@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On 9/12/16 12:13 AM, Xiao Yang wrote:
> The obsolete xfs_repair always cleared the log regardless of whether it
> is corrupted.   However current xfs_repair only cleared the log when -L
> option is specified, so xfs_repair without any options failed to clear log
> on newer xfsprogs.  If xfs_repair failed to clear log, xfs_repair -L option
> should be used to clear it.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc     | 10 ++++++----
>  tests/xfs/098 |  2 +-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 04039a4..fda108c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1134,16 +1134,18 @@ _scratch_xfs_repair()
>      $XFS_REPAIR_PROG $SCRATCH_OPTIONS $* $SCRATCH_DEV
>  }
>  
> -# Repair scratch filesystem.  Returns 0 if the FS is good to go (either no
> -# errors found or errors were fixed) and nonzero otherwise; also spits out
> -# a complaint on stderr if fsck didn't tell us that the FS is good to go.
> +# Repair scratch filesystem.  Return 2 if the filesystem has valuable
> +# metadata changes in log which needs to be replayed, 1 if there's
> +# corruption left to be fixed or can't find log head and tail or some
> +# other errors happened, and 0 if nothing wrong or all the corruptions
> +# were fixed.

I'm sorry to nitpick; this looks almost correct to me....

I think the problem here is really due to a bug in xfsprogs, (see patch
[PATCH] xfs_repair: exit with status 2 if log dirtiness is unknown sent
to the xfs list today), but we do need to handle binaries between 4.3.0
and if/when that fix gets applied, so catching any non-zero return value
below does make sense to me.

But the new comment above is very xfs-specific, and _repair_scratch_fs
is a generic function (it has a *) default $FSTYP case...)

And even if /xfs_repair/ returns 2, the bash function
_repair_scratch_fs() won't; $res gets overwritten by the last
call to xfs_repair, at which point there should be no dirty log.
So _repair_scratch_fs() really only returns 0 or 1, even if xfs_repair
may have a return value of 2.  So the new comment is not correct.

To fix that, I would simply leave the comment unchanged.


The other remaining problem I see is this, on a CONFIG_XFS_WARN kernel:

xfs/098 12s ... 12s
_check_dmesg: something found in dmesg (see /mnt/test2/git/xfstests/results//xfs/098.dmesg)
Ran: xfs/098
Failures: xfs/098
Failed 1 of 1 tests

because the failed mount issued warnings, at least on a CONFIG_XFS_WARN build:

[249062.871158] XFS (sdb2): log mount failed
[249063.170109] XFS (sdb2): Mounting V5 Filesystem
[249063.266522] XFS (sdb2): Log inconsistent (didn't find previous header)
[249063.273135] XFS: Assertion failed: 0, file: fs/xfs/xfs_log_recover.c, line: 540
...

so we should probably have a _disable_dmesg_check; I'm not sure if it would
be better to put it in _repair_scratch_fs in the "mount failed, zap
the log" case, or to put it in test 098 directly.  I think it would
be better to put it in 098, because we know we are dealing with a corrupt
log and can expect the message; putting it in _repair_scratch_fs may mask
problems on other tests that use it.

Thanks,
-Eric



>  _repair_scratch_fs()
>  {
>      case $FSTYP in
>      xfs)
>          _scratch_xfs_repair "$@" 2>&1
>  	res=$?
> -	if [ "$res" -eq 2 ]; then
> +	if [ "$res" -ne 0 ]; then
>  		echo "xfs_repair returns $res; replay log?"
>  		_scratch_mount
>  		res=$?
> diff --git a/tests/xfs/098 b/tests/xfs/098
> index d91d617..3743e78 100755
> --- a/tests/xfs/098
> +++ b/tests/xfs/098
> @@ -93,7 +93,7 @@ echo "+ mount image"
>  _scratch_mount 2>/dev/null && _fail "mount should not succeed"
>  
>  echo "+ repair fs"
> -_scratch_xfs_repair >> $seqres.full 2>&1
> +_repair_scratch_fs >> $seqres.full 2>&1
>  
>  echo "+ mount image (2)"
>  _scratch_mount
> 
