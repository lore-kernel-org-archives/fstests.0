Received: from mx1.redhat.com ([209.132.183.28]:59064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756573AbcBWD0z (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 22 Feb 2016 22:26:55 -0500
Date: Tue, 23 Feb 2016 11:26:52 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/135: fix standard error output from _scratch_mkfs
Message-ID: <20160223032652.GC11419@eguan.usersys.redhat.com>
References: <1456191325-1217-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456191325-1217-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 23, 2016 at 09:35:25AM +0800, Xiao Yang wrote:
> 'mke2fs 1.42.9 (28-Dec-2013)' produces as standard error when
> we run generic/135 in ext4 file system. This is a regression
> bug which bring in by commit:
> 4a5cda8 xfstests: do not unmount tmpfs during remount
> That patch remove '2>&1', so i bring that back.

Thanks for the revision! But I noticed that Ted's patch fixed it too,

"common: filter warning messages from mkfs.ext4"

which filters the warnings in _scratch_mkfs_ext4, so that other mkfs
errors can be noticed in the test. So I think it's a better fix :)

Thanks,
Eryu

> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/generic/135 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tests/generic/135 b/tests/generic/135
> index 52418f6..5aa880d 100755
> --- a/tests/generic/135
> +++ b/tests/generic/135
> @@ -41,7 +41,7 @@ _supported_os Linux IRIX
>  
>  _require_odirect
>  _require_scratch
> -_scratch_mkfs >/dev/null
> +_scratch_mkfs &>/dev/null
>  _scratch_mount
>  
>  cd $SCRATCH_MNT
> -- 
> 1.7.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
