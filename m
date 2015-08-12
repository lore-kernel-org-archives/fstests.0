Received: from sandeen.net ([63.231.237.45]:57693 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbbHLRht (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 12 Aug 2015 13:37:49 -0400
Message-ID: <55CB846C.6070205@sandeen.net>
Date: Wed, 12 Aug 2015 12:37:48 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/020: use -f option for xfs_repair a fs image
References: <1439400828-23150-1-git-send-email-zlang@redhat.com>
In-Reply-To: <1439400828-23150-1-git-send-email-zlang@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On 8/12/15 12:33 PM, Zorro Lang wrote:
> This case creates a 60t image file on TEST_DIR. Generally
> this's no problem. But if the image sector size is smaller
> than the TEST_DEV sector size, for example we create the
> image on hard 4k TEST_DEV, the test will fail.
> 
> So use -f for xfs_repair will helpful.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/xfs/020 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/020 b/tests/xfs/020
> index dc305c1..120492d 100755
> --- a/tests/xfs/020
> +++ b/tests/xfs/020
> @@ -55,7 +55,7 @@ fsfile=$TEST_DIR/fsfile.$seq
>  rm -f $fsfile
>  
>  $MKFS_PROG -t xfs -d size=60t,file,name=$fsfile >/dev/null
> -$XFS_REPAIR_PROG -o ag_stride=32 -t 1 $fsfile >/dev/null 2>&1
> +$XFS_REPAIR_PROG -f -o ag_stride=32 -t 1 $fsfile >/dev/null 2>&1

Agreed, but we should audit all tests for this problem, I think.

FWIW, the latest upstream will do this automatically...

So for this change, it's fine:

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

but will you see if other tests should be fixed as well?

-Eric

