Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5535 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbaJIQ0i (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 9 Oct 2014 12:26:38 -0400
Date: Fri, 10 Oct 2014 00:26:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] xfstests,shared/032: fix fsck failure
Message-ID: <20141009162634.GJ13912@dhcp-13-216.nay.redhat.com>
References: <1412900217-58174-1-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412900217-58174-1-git-send-email-wangshilong1991@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Shilong <wangshilong1991@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 09, 2014 at 08:16:57PM -0400, Wang Shilong wrote:
> while running ./check tests/shared/032, it outputs something like:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 vm01 3.17.0-rc5+
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /mnt/scratch
> 
> shared/032 2s ... 2s
> _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent (see /root/xfstests-dev/results//shared/032.full)
> Ran: shared/032
> Passed all 1 tests
> 
> This is because xfstests will run fsck after each unit test,
> for tests/shared/032, we have reformated SCRATCH_DEV to other fs,
> fix this problem by skipping fsck here.
> 
> Signed-off-by: Wang Shilong <wangshilong1991@gmail.com>
> ---
>  v2->v3: fix commit message....

I was about to point this out, and saw your v3 :)

One nitpick, the "xfstests," part in summary is not necessary to me,
"shared/032: ..." is good enough. Anyway,

Reviewed-by: Eryu Guan <eguan@redhat.com>

>  v1->v2: use _require_scratch_nocheck helper to skip fsck.(pointed by Eryu Guan)
> ---
>  tests/shared/032 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/shared/032 b/tests/shared/032
> index 7835e30..a410003 100755
> --- a/tests/shared/032
> +++ b/tests/shared/032
> @@ -40,7 +40,7 @@ rm -f $seqres.full
>  _supported_fs xfs btrfs
>  _supported_os Linux
>  
> -_require_scratch
> +_require_scratch_nocheck
>  _require_no_large_scratch_dev
>  
>  # mkfs.btrfs did not have overwrite detection at first
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
