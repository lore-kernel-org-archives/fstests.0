Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:53650 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900AbaIQE1Z (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 17 Sep 2014 00:27:25 -0400
Message-ID: <54190DAB.3020500@sandeen.net>
Date: Tue, 16 Sep 2014 23:27:23 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] check: more tests that shouldn't check the scratch
 device
References: <1410918113-23516-1-git-send-email-david@fromorbit.com> <1410918113-23516-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1410918113-23516-3-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 9/16/14 8:41 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> xfs/200 leaves a dirty log as readonly filesystems don't write
> unmount records to mark the log clean.

I wonder if it'd be better to just add a case that sets it RW again
and mounts/unmounts it, so we *can* check it after these gyrations?

But if for some reason you don't want to change the existing test,
this is probably ok too; if so,

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/xfs/200 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/200 b/tests/xfs/200
> index f4db64f..f0c4337 100755
> --- a/tests/xfs/200
> +++ b/tests/xfs/200
> @@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fs xfs
>  _supported_os Linux
>  
> -_require_scratch
> +_require_scratch_nocheck
>  
>  _scratch_mkfs_xfs >/dev/null 2>&1
>  
> 

