Received: from mx1.redhat.com ([209.132.183.28]:60910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751681AbcLHF1p (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Dec 2016 00:27:45 -0500
Date: Thu, 8 Dec 2016 13:27:42 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] fstests: btrfs: Use _require_btrfs_qgroup_report to
 replace open code
Message-ID: <20161208052742.GG29149@eguan.usersys.redhat.com>
References: <20161208020456.16116-1-quwenruo@cn.fujitsu.com>
 <20161208020456.16116-2-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161208020456.16116-2-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 08, 2016 at 10:04:56AM +0800, Qu Wenruo wrote:
> Introduce new _require_btrfs_qgroup_report function, which will check
> the accessibility to "btrfs check --qgroup-report", then set a global
> flag to info _check_scratch_fs() to do extra qgroup check.
> 
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
>  common/rc       | 22 ++++++++++++++++++++++

This needs rebase too.

>  tests/btrfs/022 |  5 +++++
>  tests/btrfs/028 |  5 ++---
>  tests/btrfs/042 |  6 ++----
>  tests/btrfs/099 |  1 +
>  tests/btrfs/104 | 20 +++++---------------
>  tests/btrfs/122 | 10 +++-------
>  tests/btrfs/123 |  5 ++---
>  8 files changed, 42 insertions(+), 32 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 1703232..bce3a09 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2624,6 +2624,20 @@ _check_btrfs_filesystem()
>          mountpoint=`_umount_or_remount_ro $device`
>      fi
>  
> +    # Check qgroup numbers
> +    if [ "$BTRFS_NEED_QGROUP_REPORT" == "yes" ];then

So we can bypass the _require_btrfs_qgroup_report check if we set
BTRFS_NEED_QGROUP_REPORT to "yes" directly, right? How about doing
something like _require_scratch do, e.g. touching some signal file in
$RESULT_DIR and only do qgroup check if that file exists?

> +	    btrfsck $device --qgroup-report > $tmp.qgroup_report 2>&1

Shouldn't "$BTRFS_UTIL_PROG check $device ..." be used for new code? I
might be wrong on this, I think btrfsck is deprecated.

Thanks,
Eryu
