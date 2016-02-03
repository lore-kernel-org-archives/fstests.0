Received: from aserp1040.oracle.com ([141.146.126.69]:22101 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964928AbcBCVNH (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Feb 2016 16:13:07 -0500
Date: Wed, 3 Feb 2016 13:13:01 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 2/4] xfstests: make _scratch_mkfs_blocksized usable
Message-ID: <20160203211301.GK22352@birch.djwong.org>
References: <1454515328-1586-1-git-send-email-hch@lst.de>
 <1454515328-1586-3-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454515328-1586-3-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 03, 2016 at 05:02:06PM +0100, Christoph Hellwig wrote:
> See http://www.infradead.org/rpr.html
> 
> The default mkfs.xfs options contain -b size=4096, so all tests
> using _scratch_mkfs_blocksized won't actually run unless those
> options are changed.  As we're trying to specificly test 1k
> blocks we should always override the default option.
> 
> BTW, why is _scratch_mkfs_blocksized in the reflink file and not
> with more generic helpers?

Uh... I don't know.  I'll move it.  I have a feeling this might have
slipped through the cracks. :/

Applied, thanks.

--D

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/reflink | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/common/reflink b/common/reflink
> index 398e505..bb1068a 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -201,13 +201,7 @@ _scratch_mkfs_blocksized()
>  
>      case $FSTYP in
>      xfs)
> -	# don't override MKFS_OPTIONS that set a block size.
> -	echo $MKFS_OPTIONS |egrep -q "b?size="
> -	if [ $? -eq 0 ]; then
> -		_scratch_mkfs_xfs
> -	else
> -		_scratch_mkfs_xfs -b size=$blocksize
> -	fi
> +	_scratch_mkfs_xfs -b size=$blocksize
>  	;;
>      ext2|ext3|ext4|ocfs2)
>  	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
> -- 
> 2.1.4
> 
