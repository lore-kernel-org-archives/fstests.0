Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:45191 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbbEDWsc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 4 May 2015 18:48:32 -0400
Message-ID: <5547F73F.2030303@sandeen.net>
Date: Mon, 04 May 2015 17:48:31 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] xfs/045: can't change UUID on v5 filesystems.
References: <1430776893-25158-1-git-send-email-david@fromorbit.com> <1430776893-25158-4-git-send-email-david@fromorbit.com>
In-Reply-To: <1430776893-25158-4-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 5/4/15 5:01 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> So pass "-m crc=0" to the scratch_mkfs command so that we only run
> on old v4 format filesystems where the UUID can be changed.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

hm, given that I might "fix" this should we instead trap
on an xfs_db uuid failure, and _notrun the test?
(oh, but older xfs_db let it go, didn't it.  sigh).

I guess nothing about the presence of crc vs. non-crc
matters for this test, so turning it off by default is probably ok.
It could use a comment about why it's got "-m crc=0" though, at
least.

-Eric

> ---
>  tests/xfs/045 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/045 b/tests/xfs/045
> index 7d8a4a1..2f5508f 100755
> --- a/tests/xfs/045
> +++ b/tests/xfs/045
> @@ -50,7 +50,7 @@ _require_scratch_nocheck
>  echo "*** get uuid"
>  uuid=`_get_existing_uuid`
>  echo "*** mkfs"
> -if ! _scratch_mkfs_xfs >$tmp.out 2>&1
> +if ! _scratch_mkfs_xfs -m crc=0 >$tmp.out 2>&1
>  then
>      cat $tmp.out
>      echo "!!! failed to mkfs on $SCRATCH_DEV"
> 

