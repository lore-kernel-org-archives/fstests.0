Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:56167 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbfAUWoP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jan 2019 17:44:15 -0500
Date: Tue, 22 Jan 2019 09:44:12 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 2/2] xfs/068: new fsstress operation breaks xfsrestore
 output
Message-ID: <20190121224412.GE4205@dastard>
References: <20190119024258.6864-1-zlang@redhat.com>
 <20190119024258.6864-2-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119024258.6864-2-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jan 19, 2019 at 10:42:58AM +0800, Zorro Lang wrote:
> After fsstress has new operation, xfs/068 has different dump output,
> so change the expected number of files and directories.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/xfs/068.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/068.out b/tests/xfs/068.out
> index fa3a5523..f9ec37b8 100644
> --- a/tests/xfs/068.out
> +++ b/tests/xfs/068.out
> @@ -22,7 +22,7 @@ xfsrestore: session id: ID
>  xfsrestore: media ID: ID
>  xfsrestore: searching media for directory dump
>  xfsrestore: reading directories
> -xfsrestore: 383 directories and 1335 entries processed
> +xfsrestore: 416 directories and 1373 entries processed

Shouldn't you tell fsstress to avoid this new operation so none of
the tests that rely on the number of files created by a specific
fstress seed break?

i.e. changing FSSTRESS_AVOID in common/dump as is done already to
turn off dedupe/clone/copy_file_range for xfsdump/restore tests?

Cheers,

dave.
-- 
Dave Chinner
david@fromorbit.com
