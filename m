Received: from mx1.redhat.com ([209.132.183.28]:39510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932155AbdBVKtq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 Feb 2017 05:49:46 -0500
Date: Wed, 22 Feb 2017 18:49:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfs/133,4: make sure xfs_db sets negative i_size
Message-ID: <20170222104944.GX24562@eguan.usersys.redhat.com>
References: <1487583465-17572-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1487755900-6083-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487755900-6083-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 22, 2017 at 05:31:40PM +0800, Xiao Yang wrote:
> 1) xfs/133 and xfs/134 work abnornamlly on RHEL6.8GA and RHEL6.9Beta
>    because xfs_db fails to set i_size to -1 or -512 and reports "usage:
>    write fieldname value".  The special argument "--" is only used to
>    end option-scanning in getopt().  So we should add "--" for write
>    command in xfs_db when -c option is supported by write command.
>    getopt() has been produced by 'commit c9f5e3db22098 ("xfs_db: Allow
>    writes of corrupted data")'.
> 
> 2) When xfs_db fails to set a negative i_size due to unknown error, we
>    can skip these cases which don't trigger the kernel bug.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Sorry for the late review on this patch. I just got some time to look at
xfs/133,4 a bit closely.

It turns out that the EINVAL error you saw is because of

echo m > $testdir/a

and direct append failed because the write offset is not 512-aligned.

Just "touch $testdir/a" should work (you can see test failure on RHEL6.8
with current master).

> ---
>  tests/xfs/133 | 13 ++++++++++++-
>  tests/xfs/134 | 17 ++++++++++++++---
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/133 b/tests/xfs/133
> index d756d2e..91b3b9b 100755
> --- a/tests/xfs/133
> +++ b/tests/xfs/133
> @@ -63,7 +63,18 @@ inum=$(stat -c "%i" $testdir/a)
>  
>  echo "Corrupt filesystem"
>  _scratch_unmount
> -_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -1' >> $seqres.full
> +
> +# 1) we should add "--" for write command in xfs_db when -c option is
> +#    supported by write command.
> +# 2) check whether xfs_db succeeds to set i_size to -1 or not
> +_scratch_xfs_db -x -c "help" | grep -q "write \[-c\]"
> +if [ $? -eq 0 ]; then
> +	_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -1' >> $seqres.full 2>&1 || \
> +	_notrun "Could not set i_size to -1 successfully, skip test."
> +else
> +	_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -1' >> $seqres.full 2>&1 || \
> +	_notrun "Could not set i_size to -1 successfully, skip test."
> +fi

This check looks tedious, and xfs_db doesn't return non-zero on error,
so this will never _notrun.

I'd suggest running the two xfs_db commands unconditionally (with clear
comments), there has to be one suitable call for the xfs_db version in
use, and check core.size is -1/-512 by printing it with xfs_db. e.g.

# <comments about these two calls>
_scratch_xfs_db -x -c "inode ${inum}" -c "write core.size -1" >>$seqres.full 2>&1
_scratch_xfs_db -x -c "inode ${inum}" -c "write core.size -- -1" >>$seqres.full 2>&1

# check core.size and _notrun if it's not set correctly
isize=`_scratch_xfs_db -c "inode ${inum}" -c "print core.size" | $AWK_PROG '{print $3}'`
if [ $isize -ne -1 ]; then
	_notrun "..."
fi

Thanks,
Eryu
