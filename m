Received: from userp1040.oracle.com ([156.151.31.81]:48891 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbcFIRlM (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 9 Jun 2016 13:41:12 -0400
Date: Thu, 9 Jun 2016 10:41:04 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfstests: fix unreferenced variables in generic/186 and
 generic/187
Message-ID: <20160609174104.GC10371@birch.djwong.org>
References: <1465409851-27969-1-git-send-email-hch@lst.de>
 <1465409851-27969-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465409851-27969-2-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 08, 2016 at 08:17:31PM +0200, Christoph Hellwig wrote:
> There is not i variable in scope, and the comments suggest the operation
> is to be done on ${file}.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Oops.  Thanks for the fix. :/

Looks good,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/186 | 2 +-
>  tests/generic/187 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/186 b/tests/generic/186
> index 70a0280..5de120a 100755
> --- a/tests/generic/186
> +++ b/tests/generic/186
> @@ -87,7 +87,7 @@ _fragment_freesp()
>  
>  	# Try again anyway
>  	avail=`_get_available_space $SCRATCH_MNT`
> -	$XFS_IO_PROG -fc "pwrite -S 0x65 0 $avail" ${file}.${i}
> +	$XFS_IO_PROG -fc "pwrite -S 0x65 0 $avail" ${file}
>  
>  	# Punch out whatever we need
>  	seq 1 $((nr * 4)) | while read f; do
> diff --git a/tests/generic/187 b/tests/generic/187
> index 25cbcd9..3f534c8 100755
> --- a/tests/generic/187
> +++ b/tests/generic/187
> @@ -88,7 +88,7 @@ _fragment_freesp()
>  
>  	# Try again anyway
>  	avail=`_get_available_space $SCRATCH_MNT`
> -	$XFS_IO_PROG -fc "pwrite -S 0x65 0 $avail" ${file}.${i}
> +	$XFS_IO_PROG -fc "pwrite -S 0x65 0 $avail" ${file}
>  
>  	# Punch out whatever we need
>  	seq 1 $((nr * 4)) | while read f; do
> -- 
> 2.1.4
> 
