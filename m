Received: from mx1.redhat.com ([209.132.183.28]:60624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbdGFUch (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Jul 2017 16:32:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B67BA4E049
        for <fstests@vger.kernel.org>; Thu,  6 Jul 2017 20:32:36 +0000 (UTC)
Date: Thu, 6 Jul 2017 15:32:34 -0500
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH] xfs/297: fail test if _scratch_mount fails
Message-ID: <20170706203234.GA10001@redhat.com>
References: <20170706180620.58376-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706180620.58376-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 06, 2017 at 02:06:20PM -0400, Brian Foster wrote:
> xfs/297 formats the scratch device with test specific mkfs options
> that limit the use of certain mount options (i.e., if logbsize !=
> 256k). If an incompatible mount option is set, the mount fails but
> the test proceeds to run against the root filesystem.
> 
> Update xfs/297 to fail if the mount of the scratch device fails for
> whatever reason.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> ---
> 
> A couple other options here are to exclude the use of logbsize
> (effectively _notrun the test) or to hardcode the mount with '-o
> logbsize=256k' in the test.  I didn't like the former because it
> excludes even when a valid logbsize is set.  The latter requires us to
> use _require_scratch_nocheck, otherwise the post-test remount fails.
> This configuration is rare enough that this seemed like the least bad
> option.
> 
> Brian
> 
>  tests/xfs/297 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/297 b/tests/xfs/297
> index fe92441..9accffd 100755
> --- a/tests/xfs/297
> +++ b/tests/xfs/297
> @@ -52,7 +52,7 @@ _require_command "$KILLALL_PROG" killall
>  
>  rm -f $seqres.full
>  _scratch_mkfs_xfs -d agcount=16,su=256k,sw=12 -l su=256k,size=5120b >/dev/null 2>&1
> -_scratch_mount >/dev/null 2>&1
> +_scratch_mount >>$seqres.full 2>&1 || _fail "mount failed"
>  
>  STRESS_DIR="$SCRATCH_MNT/testdir"
>  mkdir -p $STRESS_DIR
> -- 
> 2.9.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
