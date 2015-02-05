Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:36854 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbbBECMT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 4 Feb 2015 21:12:19 -0500
Date: Thu, 5 Feb 2015 13:11:45 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 4/8 v4] tests/xfs: convert 10 xfs's tests to be generic
 ones
Message-ID: <20150205021145.GE12722@dastard>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
 <1423004840-45315-5-git-send-email-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1423004840-45315-5-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 03, 2015 at 03:07:16PM -0800, Jaegeuk Kim wrote:
> This patch changes ten xfs's testcases to be generic ones, pointed out by Dave.
>  xfs/053         (data exposure)
>  xfs/137         (data vs filesize)
>  xfs/138         (data vs filesize vs truncate)
>  xfs/139         (data vs filesize vs partial truncate)
>  xfs/140         (data vs filesize vs extending truncate)
>  xfs/179         (data vs filesize w/ fsync)
>  xfs/180         (data vs filesize w/ sync)
>  xfs/182         (data vs filesize w/ recovery)
>  xfs/200         (recovery vs ro-block device)
>  xfs/306         (fsstress vs recovery)
> 
> All these tests need _require_scratch_shutdown, and some of them need
> _require_bmap utils.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  tests/xfs/053 |  3 ++-
>  tests/xfs/137 | 10 ++++++----
>  tests/xfs/138 | 10 ++++++----
>  tests/xfs/139 | 10 ++++++----
>  tests/xfs/140 |  8 +++++---
>  tests/xfs/179 |  8 +++++---
>  tests/xfs/180 |  8 +++++---
>  tests/xfs/182 |  8 +++++---
>  tests/xfs/200 |  6 ++++--
>  tests/xfs/306 |  3 ++-
>  10 files changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/tests/xfs/053 b/tests/xfs/053
> index 9749345..a3ebc62 100755
> --- a/tests/xfs/053
> +++ b/tests/xfs/053
> @@ -83,9 +83,10 @@ _crashtest()
>  }
>  
>  # Modify as appropriate.
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_scratch_shutdown

Can't do that - scratch needs to be mkfs'd before you can mount it.

> index 79b3b89..6ec1bcb 100755
> --- a/tests/xfs/137
> +++ b/tests/xfs/137
> @@ -36,11 +36,13 @@ trap "exit \$status" 0 1 2 3 15
>  . ./common/filter
>  
>  # real QA test starts here
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os Linux IRIX
>  
>  _require_scratch
> -_scratch_mkfs_xfs >/dev/null 2>&1
> +_require_scratch_shutdown
> +_require_bmap

needs to be converted to fiemap and that done as a separate step.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
