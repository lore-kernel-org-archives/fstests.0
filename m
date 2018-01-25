Received: from mx1.redhat.com ([209.132.183.28]:43630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeAYJHS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 Jan 2018 04:07:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80E3013586
        for <fstests@vger.kernel.org>; Thu, 25 Jan 2018 09:07:18 +0000 (UTC)
Date: Thu, 25 Jan 2018 17:07:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/439: mkfs again to avoid corruption failure
Message-ID: <20180125090714.GI18267@eguan.usersys.redhat.com>
References: <20180125073918.22371-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180125073918.22371-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 25, 2018 at 03:39:18PM +0800, Zorro Lang wrote:
> xfs/439 always fails on ppc64 as below:
>   # ./check xfs/439
>   ...
>   ...
>   xfs/439 2s ... 1s
>   _check_xfs_filesystem: filesystem on /dev/sda5 is inconsistent (r)
>   (see /var/lib/xfstests/results//xfs/439.full for details)
>   Ran: xfs/439
>   Failures: xfs/439
>   Failed 1 of 1 tests
> 
>   # xfs_repair -n $SCRATCH_DEV
>   ...
>   ...
>   Phase 6 - check inode connectivity...
>           - traversing filesystem ...
>           - traversal finished ...
>           - moving disconnected inodes to lost+found ...
>   Phase 7 - verify link counts...
>   Maximum metadata LSN (1:2) is ahead of log (1:2).
>   Would format log to cycle 4.
>   No modify flag set, skipping filesystem flush and exiting.
> 
> It can't be fixed by log replay (scratch_mount), so mkfs again to
> make sure the case won't be failed at the end.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

I think we just need _require_scratch_nocheck to skip fsck after test.

Thanks,
Eryu

> ---
>  tests/xfs/439 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/xfs/439 b/tests/xfs/439
> index 7be700cd..cb13a212 100755
> --- a/tests/xfs/439
> +++ b/tests/xfs/439
> @@ -78,6 +78,9 @@ fi
>  # or CONFIG_XFS_DEBUG (when bug_on_assert is disabled) build, so filter them.
>  _check_dmesg _filter_assert_dmesg
>  
> +# mkfs again to avoid xfs corruption at the end of test
> +_scratch_mkfs > /dev/null 2>&1
> +
>  echo "Silence is golden"
>  
>  # success, all done
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
