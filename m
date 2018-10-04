Received: from userp2120.oracle.com ([156.151.31.85]:47302 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbeJEAuM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Oct 2018 20:50:12 -0400
Date: Thu, 4 Oct 2018 10:55:40 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/122: add struct xfs_unmount_log_format
Message-ID: <20181004175540.GA6703@magnolia>
References: <b1f2c982-8a23-b19b-b94d-e52470fdf5d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f2c982-8a23-b19b-b94d-e52470fdf5d4@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 04, 2018 at 12:27:32PM -0500, Eric Sandeen wrote:
> struct xfs_unmount_log_format used to be anonymous and gained a name
> in 4.19, so add that to the list of expected structures in xfs/122.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Hey, I have a patch that does this too!

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index ad9a0555..92fb46ae 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -98,6 +98,7 @@ sizeof(struct xfs_rtrmap_root) = 4
>  sizeof(struct xfs_rud_log_format) = 16
>  sizeof(struct xfs_rui_log_format) = 16
>  sizeof(struct xfs_scrub_metadata) = 64
> +sizeof(struct xfs_unmount_log_format) = 8
>  sizeof(xfs_agf_t) = 224
>  sizeof(xfs_agfl_t) = 36
>  sizeof(xfs_agi_t) = 336
> 
