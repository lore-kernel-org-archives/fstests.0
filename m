Received: from mail-pg1-f194.google.com ([209.85.215.194]:33354 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfCWIuO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 23 Mar 2019 04:50:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so3118527pgk.0
        for <fstests@vger.kernel.org>; Sat, 23 Mar 2019 01:50:13 -0700 (PDT)
Date: Sat, 23 Mar 2019 16:50:05 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] xfs/010: Accept the inconsistencies of sparse records
Message-ID: <20190323085005.GS2824@desktop>
References: <1552980533-2138-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552980533-2138-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 19, 2019 at 03:28:53PM +0800, Xiao Yang wrote:
> If sparse inode is enabled, running xfs/010 gets the following error:
> -----------------------------------------------------
> +invalid inode count, AGNO/INO, count 0 ninodes 64
>  finobt record with no free inodes, AGNO/INO
> +invalid inode count, AGNO/INO, count 0 ninodes 64
> -----------------------------------------------------
> 
> We corrupt finobt records forcely, so it's reasonable for repair
> to detect the inconsistencies of sparse records if sparse inode
> is enabled.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

I cannot reproduce this failure, I'm using xfsprogs from upstream
for-next branch and kernel 5.0.

xfs/010 uses a fixed mkfs option to create the target fs:

_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | _filter_mkfs 2>$seqres.full

So adding "-i sparse" to MKFS_OPTIONS won't create xfs with 'sparse'
enabled in test. And even after editing above mkfs options manually in
test, I still couldn't hit the failure. Did I miss anything?

Thanks,
Eryu

> ---
>  tests/xfs/010 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/010 b/tests/xfs/010
> index e220a65..69c019b 100755
> --- a/tests/xfs/010
> +++ b/tests/xfs/010
> @@ -106,8 +106,10 @@ _scratch_unmount
>  # corrupt some finobt records
>  _corrupt_finobt_records $SCRATCH_DEV
>  
> -# repair should detect the inconsistencies
> -_scratch_xfs_repair 2>&1 | _filter_repair
> +# repair should detect the inconsistencies of finobt records
> +# repair can also detect the inconsistencies of sparse records if
> +# sparse inode is enabled, so accept both of outputs by filtering it.
> +_scratch_xfs_repair 2>&1 | _filter_repair | sed -e '/invalid inode count, AGNO\/INO/d'
>  _check_scratch_fs
>  
>  # nuke the finobt root, repair will have to regenerate from the inobt
> -- 
> 1.8.3.1
> 
> 
> 
