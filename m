Received: from mx1.redhat.com ([209.132.183.28]:46474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbdCBEcO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 1 Mar 2017 23:32:14 -0500
Date: Thu, 2 Mar 2017 12:22:12 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] ext4/306: require 64bit feature to run ext4/306
Message-ID: <20170302042212.GI14226@eguan.usersys.redhat.com>
References: <20170301085939.GG14226@eguan.usersys.redhat.com>
 <1488421466-3303-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488421466-3303-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 02, 2017 at 10:24:26AM +0800, Xiao Yang wrote:
> The 64bit feature isn't supported by mkfs.ext4 on RHEL6, so
> we add _require_ext4_mkfs_64bit to check it.  If 64bit feature
> isn't supported, we could skip this case.  This feature has
> been produced by 'commit 02d6f47e9647d ("mke2fs: Fix up mke2fs
> to be able to make 64-bit file systems")'.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc      | 11 +++++++++++
>  tests/ext4/306 |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 8f23334..8c4f1c3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1669,6 +1669,17 @@ _require_scratch_ext4_crc()
>  	_scratch_unmount
>  }
>  
> +# this test requires the 64bit feature to be available in mkfs.ext4
> +_require_ext4_mkfs_64bit()
> +{
> +	local testfile=$TEST_DIR/$$.64bit
> +
> +	touch $testfile
> +	$MKFS_EXT4_PROG -F -O 64bit -n $testfile 512m >/dev/null 2>&1 \
> +	   || _notrun "mkfs.ext4 doesn't have 64bit feature"
> +	rm -f $testfile
> +}

Sorry, I didn't realize earlier that _require_mkfs_mkfs_bigalloc() runs
mkfs test against $SCRATCH_DEV too. Seems we should fix it too.

Can you please factor out a new helper, e.g. _mkfs_ext4_supported(), to
accept mkfs options and return mkfs status? So that _require_ext4_mkfs_*
could use this new helper, just pass different feature bits it wants to
test. e.g.

_require_ext4_mkfs_64bit()
{
	_mkfs_ext4_supported -O 64bit || \
		_notrun "mkfs.ext4 doesn't have 64bit feature"
}

Thanks!

Eryu
