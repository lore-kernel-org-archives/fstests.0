Received: from mx1.redhat.com ([209.132.183.28]:48210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbcIVOHq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Sep 2016 10:07:46 -0400
Date: Thu, 22 Sep 2016 09:07:43 -0500
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH 1/3] xfs/260: fix output to match actions
Message-ID: <20160922140743.GA10084@redhat.com>
References: <65c03ebd-ee9c-7439-2642-0362a177ec6d@redhat.com>
 <d52b6d08-437b-c7ad-6122-e282c178faa6@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d52b6d08-437b-c7ad-6122-e282c178faa6@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 20, 2016 at 05:15:47PM -0500, Eric Sandeen wrote:
> The test creates 30 inodes, but says it created 300.
> Just fix that up so the repquota output matches the
> comments in the output file.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Bill O'Donnell <billodo@redhat.com>

> ---
> 
> diff --git a/tests/xfs/260 b/tests/xfs/260
> index 70486ac..9c6162b 100755
> --- a/tests/xfs/260
> +++ b/tests/xfs/260
> @@ -93,7 +93,7 @@ do_test()
>  	done
>  	sync
>  
> -	echo "$qname inode quota after create 300 inodes"
> +	echo "$qname inode quota after creating 30 inodes"
>  	$XFS_QUOTA_PROG -x -c "report $type -N -i" $SCRATCH_MNT | _filter_spaces
>  
>  	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
> diff --git a/tests/xfs/260.out b/tests/xfs/260.out
> index 4965eeb..0b198bf 100644
> --- a/tests/xfs/260.out
> +++ b/tests/xfs/260.out
> @@ -10,7 +10,7 @@ user blocks quota after write 30M data
>  root 0 20480 20480 00 [--------]
>  fsgqa 30720 40960 40960 00 [--------]
>  
> -user inode quota after create 300 inodes
> +user inode quota after creating 30 inodes
>  root 3 20 20 00 [--------]
>  fsgqa 30 40 40 00 [--------]
>  
> @@ -25,7 +25,7 @@ group blocks quota after write 30M data
>  root 0 20480 20480 00 [--------]
>  fsgqa 30720 40960 40960 00 [--------]
>  
> -group inode quota after create 300 inodes
> +group inode quota after creating 30 inodes
>  root 3 20 20 00 [--------]
>  fsgqa 30 40 40 00 [--------]
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
