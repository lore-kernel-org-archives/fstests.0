Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:49680 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933550AbaHYWnv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 25 Aug 2014 18:43:51 -0400
Message-ID: <53FBBC26.20700@sandeen.net>
Date: Mon, 25 Aug 2014 17:43:50 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] filter: update xfs_repair filter for new sunit/swidth
 warning
References: <1409006043-31495-1-git-send-email-david@fromorbit.com> <1409006043-31495-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1409006043-31495-3-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 8/25/14, 5:34 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> New xfs_repair programs have a different sunit/swidth warning that
> is triggering failures such as:
> 
>     -Note - stripe unit (0) and width (0) fields have been reset.
>     -Please set with mount -o sunit=<value>,swidth=<value>
>     +Note - stripe unit (0) and width (0) were copied from a backup superblock.
>     +Please reset with mount -o sunit=<value>,swidth=<value> if necessary
> 
> Update the filter to catch both cases and output the old message so
> tests pass again.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Ah, crap, I forgot to do this, I'm sorry.  Thanks.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  common/repair | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/repair b/common/repair
> index 46ca9e0..a157580 100644
> --- a/common/repair
> +++ b/common/repair
> @@ -85,6 +85,9 @@ s/\s+- \d+:\d\d:\d\d:.*\n//g;
>  /^agfl has bad CRC/ && next;
>  # finobt enabled filesystem output
>  s/(inode chunk) (\d+)\/(\d+)/AGNO\/INO/;
> +# sunit/swidth reset messages
> +s/^(Note - .*) were copied.*/\1 fields have been reset./;
> +s/^(Please) reset (with .*) if necessary/\1 set \2/;
>  	print;'
>  }
>  
> 

