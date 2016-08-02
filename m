Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:22865 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753558AbcHBX3w (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 2 Aug 2016 19:29:52 -0400
Date: Wed, 3 Aug 2016 09:23:05 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/095: update warning whitelist
Message-ID: <20160802232305.GQ12670@dastard>
References: <1470042176-31447-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470042176-31447-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 01, 2016 at 11:02:56AM +0200, Christoph Hellwig wrote:
> The recent direct I/O path refactor changed the function name in the
> racing read case.  Update the test case to handle the new name in
> addition to the old one.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/095 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/095 b/tests/generic/095
> index c656ef1..4754992 100755
> --- a/tests/generic/095
> +++ b/tests/generic/095
> @@ -125,9 +125,11 @@ $FIO_PROG $fio_config >>$seqres.full 2>&1
>  filter_xfs_dmesg()
>  {
>  	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
> -	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
> +	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
> +	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
>  	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
> -	    -e "s#$warn2#Intentional warnings in xfs_file_read_iter#"
> +	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
> +	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#"
>  }

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
