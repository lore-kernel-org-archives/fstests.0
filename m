Received: from mail.kernel.org ([198.145.29.136]:53125 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbbLENLh (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 5 Dec 2015 08:11:37 -0500
Subject: Re: [f2fs-dev] [PATCH 1/3] common/rc: support f2fs for
 _scratch_mkfs_sized
References: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <5662E283.6090900@kernel.org>
Date: Sat, 5 Dec 2015 21:11:31 +0800
MIME-Version: 1.0
In-Reply-To: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

Hi Jaegeuk,

On 12/5/15 6:15 AM, Jaegeuk Kim wrote:
> The mkfs.f2fs has an option to build a certain sized filesystem by giving
> the number of sectors.
> 
> So, this patch adds to use that.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  common/rc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 4c2f42c..ef913b4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -739,6 +739,10 @@ _scratch_mkfs_sized()
>  	$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV \
>  			   `expr $fssize / 1024`
>  	;;
> +    f2fs)
> +	# mkfs.f2fs requires # of sectors as an input for the size
> +	$MKFS_F2FS_PROG $MKFS_OPTIONS $SCRATCH_DEV `expr $fssize / 512`

In mkfs.f2fs, we will calculate fs size based on real sector size of block
device and the input sectors, so if sector size of block device is not 512, our
fs size calculated will be incorrect.

How about fixing it for supporting different sector size?

Thanks,

> +	;;
>      *)
>  	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
>  	;;
> 
