Received: from mx1.redhat.com ([209.132.183.28]:55740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965124AbeAJEFz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 9 Jan 2018 23:05:55 -0500
Date: Wed, 10 Jan 2018 12:05:52 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/015: Change the test filesystem size to 101mb
Message-ID: <20180110040552.GY5123@eguan.usersys.redhat.com>
References: <1515401010-26802-1-git-send-email-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515401010-26802-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, dsterba@suse.cz, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 08, 2018 at 10:43:30AM +0200, Nikolay Borisov wrote:
> This test has been failing for btrfs for quite some time,
> at least since 4.7. There are 2 implementation details of btrfs that
> it exposes:
> 
> 1. Currently btrfs filesystem under 100mb are created in Mixed block
> group mode. Freespace accounting for it is not 100% accurate - I've

mkfs.btrfs does this too? Because I noticed _scratch_mkfs_sized adds
'--mixed' mkfs option explicitly.

> observed around 100-200kb discrepancy between a newly created filesystem,
> then writing a file and deleting it and checking the free space. This
> falls within %3 and not %1 as hardcoded in the test. 
> 
> 2. BTRFS won't flush it's delayed allocation on file deletion if less
> than 32mb are deleted. On such files we need to perform sync (missing
> in the test) or wait until time elapses for transaction commit.
> 
> Since mixed mode is somewhat deprecated and btrfs is not really intended
> to be used on really small devices let's just adjust the test to
> create a 101mb fs, which doesn't use mixed mode and really test
> freespace accounting.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  tests/generic/015 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/015 b/tests/generic/015
> index 78f2b13..416c4ae 100755
> --- a/tests/generic/015
> +++ b/tests/generic/015
> @@ -53,7 +53,7 @@ _supported_os Linux
>  _require_scratch
>  _require_no_large_scratch_dev
>  
> -_scratch_mkfs_sized `expr 50 \* 1024 \* 1024` >/dev/null 2>&1 \
> +_scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \

Better to have some comments in the code too, to explain why we choose
101m filesystem size.

Thanks,
Eryu

>      || _fail "mkfs failed"
>  _scratch_mount || _fail "mount failed"
>  out=$SCRATCH_MNT/fillup.$$
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
