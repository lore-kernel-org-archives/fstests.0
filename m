Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:45157 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbbEDWpt (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 4 May 2015 18:45:49 -0400
Message-ID: <5547F69C.6050009@sandeen.net>
Date: Mon, 04 May 2015 17:45:48 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] filter: latest mkfs.xfs makes logical sector size
 noise
References: <1430776893-25158-1-git-send-email-david@fromorbit.com> <1430776893-25158-2-git-send-email-david@fromorbit.com>
In-Reply-To: <1430776893-25158-2-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 5/4/15 5:01 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> On devices that have a logical sector smaller than physical sector,
> this extra, harmless output now occurs:
> 
>      QA output created by 060
>     +specified blocksize 1024 is less than device physical sector size 4096
>     +switching to logical sector size 512
>      Creating directory system to dump using src/fill.
>      Setup .......................................
>      Dumping to files...
> 
> And it causes lots of tests to fail unnecessarily. Filter it.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

But should we just remove that from mkfs output?  It's probably my fault,
but looking at it now, it seems like unnecessary noise.

-Eric

> ---
>  common/rc | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 6ea107e..242dedb 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -365,9 +365,12 @@ _scratch_mkfs_xfs()
>  		mkfs_status=$?
>  	fi
>  
> -	# output stored mkfs output
> -	cat $tmp_dir.mkfserr >&2
> +	# output stored mkfs output, filtering unnecessary warnings from stderr
>  	cat $tmp_dir.mkfsstd
> +	cat $tmp_dir.mkfserr | sed \
> +		-e '/less than device physical sector/d' \
> +		-e '/switching to logical sector/d' \
> +		>&2
>  	rm -f $tmp_dir.mkfserr $tmp_dir.mkfsstd
>  
>  	return $mkfs_status
> 

