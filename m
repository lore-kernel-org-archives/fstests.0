Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:45163 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbbEDWqM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 4 May 2015 18:46:12 -0400
Message-ID: <5547F6AE.4050700@sandeen.net>
Date: Mon, 04 May 2015 17:46:06 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] filter: latest xfs_repair is more verbose
References: <1430776893-25158-1-git-send-email-david@fromorbit.com> <1430776893-25158-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1430776893-25158-3-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 5/4/15 5:01 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> It detects more errors, so we need to filter them out to prevent
> golden image mismatches on successful recovery.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  common/repair | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/repair b/common/repair
> index 7a99546..ce6d258 100644
> --- a/common/repair
> +++ b/common/repair
> @@ -83,6 +83,7 @@ s/\s+- \d+:\d\d:\d\d:.*\n//g;
>  /^Metadata corruption detected/ && next;
>  /^Metadata CRC error detected/ && next;
>  /^agfl has bad CRC/ && next;
> +/^bad CRC for inode/ && next;
>  # finobt enabled filesystem output
>  s/(inode chunk) (\d+)\/(\d+)/AGNO\/INO/;
>  # sunit/swidth reset messages
> 

