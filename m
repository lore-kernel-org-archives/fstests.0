Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:34230 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbbCKOv1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 10:51:27 -0400
Message-ID: <5500566D.5080401@sandeen.net>
Date: Wed, 11 Mar 2015 10:51:25 -0400
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] xfs/073: be quiet about mouting with nouuid option
References: <1426072534-12246-1-git-send-email-eguan@redhat.com> <1426072534-12246-5-git-send-email-eguan@redhat.com>
In-Reply-To: <1426072534-12246-5-git-send-email-eguan@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 3/11/15 7:15 AM, Eryu Guan wrote:
> v4 and v5 xfs generate different outputs because v4 xfs only retries
> mount with nouuid option once in the test, v5 xfs tries more times(with
> xfs_copy running with -d option).
> 
> Just be quiet about mounting with nouuid option, it's much easier than
> preparing two different 073.outs and selecting the proper one at runtime

Ah, ok, I see now.  Might have been better to swap the order of your patches
3 and 4 so things work after each patch application.

This does make the test slightly less useful, as we don't know whether we've
properly copied the UUID (if for some strange reason it changed when it
shouldn't) but that doesn't seem too likely or important, so:

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/xfs/073     | 2 +-
>  tests/xfs/073.out | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index f955771..508725f 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -88,7 +88,7 @@ _verify_copy()
>  
>  	mount -t xfs -o loop $target $target_dir 2>/dev/null
>  	if [ $? -ne 0 ]; then
> -		echo retrying mount with nouuid option
> +		echo retrying mount with nouuid option >>$seqres.full
>  		mount -t xfs -o loop -o nouuid $target $target_dir
>  		if [ $? -ne 0 ]; then
>  			echo mount failed - evil!
> diff --git a/tests/xfs/073.out b/tests/xfs/073.out
> index f3b147e..3f27467 100644
> --- a/tests/xfs/073.out
> +++ b/tests/xfs/073.out
> @@ -29,7 +29,6 @@ Creating file <FSIMAGE1>
>  All copies completed.
>  checking new image
>  mounting new image on loopback
> -retrying mount with nouuid option
>  comparing new image files to old
>  comparing new image directories to old
>  comparing new image geometry to old
> 

