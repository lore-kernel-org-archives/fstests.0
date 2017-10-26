Received: from mx1.redhat.com ([209.132.183.28]:47224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbdJZGwU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Oct 2017 02:52:20 -0400
Date: Thu, 26 Oct 2017 14:52:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: Add message indicating btrfs-progs support FST
 in read-only mode
Message-ID: <20171026065218.GK3235@eguan.usersys.redhat.com>
References: <1508997466-12859-1-git-send-email-gujx@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508997466-12859-1-git-send-email-gujx@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Gu Jinxiang <gujx@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 26, 2017 at 01:57:46PM +0800, Gu Jinxiang wrote:
> From: Gu JinXiang <gujx@cn.fujitsu.com>
> 
> btrfs-progs now support FST in read-only mode, so when space_cache=v2
> enabled, this test case will fail.
> Add message to help user to understand this status.

Sorry, I don't quite understand the new 'FST' feature. But is it a bug
that we want to fix when mounting with space_cache=v2 option, or we just
couldn't do btrfs-convert in this case? If it's a real bug, I'd say let
the test fail as it is, and track bug in tools like bugzilla not
comments/messages in the test; if it's the latter case, then just
_notrun the test if space_cache=v2 option is specified, e.g.

_exclude_scratch_mount_option "space_cache=v2"

Thanks,
Eryu

> 
> Signed-off-by: Gu JinXiang <gujx@cn.fujitsu.com>
> ---
>  tests/btrfs/012 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index 85c82f07..529e6eca 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -96,6 +96,12 @@ cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT/new
>  
>  _scratch_unmount
>  
> +space_cache_version=$(echo "$MOUNT_OPTIONS" | grep "space_cache=v2")
> +if [ -n "$space_cache_version" ]; then
> +	_fail "since used space_cache=v2 when mount," \
> +	       "and for FST btrfs-progs support is read-only."\
> +	      "so btrfs-convert rollback will fail"
> +fi
>  # Now restore the ext4 device
>  $BTRFS_CONVERT_PROG -r $SCRATCH_DEV >> $seqres.full 2>&1 || \
>  	_fail "btrfs-convert rollback failed"
> -- 
> 2.13.5
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
