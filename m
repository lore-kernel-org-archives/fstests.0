Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:44597 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbbB0CqC (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Feb 2015 21:46:02 -0500
Message-ID: <54EFDA67.1060606@sandeen.net>
Date: Thu, 26 Feb 2015 20:45:59 -0600
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] generic/065: f2fs serves 64KB size with zero data
References: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1425000227-69601-1-git-send-email-jaegeuk@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On 2/26/15 7:23 PM, Jaegeuk Kim wrote:
> The f2fs provides 64KB size with 0 data after fsync was done to directory file.
> 
> Cc: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  tests/generic/065 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/065 b/tests/generic/065
> index b5a296d..3d2b437 100755
> --- a/tests/generic/065
> +++ b/tests/generic/065
> @@ -139,6 +139,10 @@ ext3)
>  	# a 64Kb file, with all bytes having the value 0xff
>  	[ $hello_digest == "ecb99e6ffea7be1e5419350f725da86b" ] && digest_ok=yes
>  	;;
> +f2fs)
> +	# a 64Kb file, with all bytes having the value 0
> +	[ $hello_digest == "fcd6bcb56c1689fcef28b57c22475bad" ] && digest_ok=yes
> +	;;

whoa... I will admit to having poorly reviewed this test.  Given that this file was
never fsynced, I don't think the test should be looking at file contents *at all*
I'll do an ex post facto review, I think, and really, I think all of the above should
just be removed from the test.  Without fsync, we don't know what's in the file.
(ext3 could be mounted with writeback mode, for example).

-Eric

>  *)
>  	# an empty file
>  	[ $hello_digest == "d41d8cd98f00b204e9800998ecf8427e" ] && digest_ok=yes
> 

