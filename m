Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54308 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbaJIP6U (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 9 Oct 2014 11:58:20 -0400
Date: Thu, 9 Oct 2014 23:58:17 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests,shared/032: fix fsck failure
Message-ID: <20141009155817.GI13912@dhcp-13-216.nay.redhat.com>
References: <1412895285-10544-1-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412895285-10544-1-git-send-email-wangshilong1991@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Shilong <wangshilong1991@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 09, 2014 at 06:54:45PM -0400, Wang Shilong wrote:
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
> so to make fsck happy later, let's fomrat fs here.
> 
> Signed-off-by: Wang Shilong <wangshilong1991@gmail.com>
> ---
>  tests/shared/032 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/shared/032 b/tests/shared/032
> index 7835e30..7a1a242 100755
> --- a/tests/shared/032
> +++ b/tests/shared/032
> @@ -91,6 +91,9 @@ do
>  	fi
>  done
>  
> +# make fsck happy later.
> +_scratch_mkfs > /dev/null 2>&1
> +

_require_scratch => _require_scratch_nocheck may be the right way to
go, just like 5d0153d does

5d0153d btrfs: use _nocheck for btrfs/011 and btrfs/012

Thanks,
Eryu
>  # success, all done
>  status=0
>  exit
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
