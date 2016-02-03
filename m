Received: from aserp1040.oracle.com ([141.146.126.69]:49238 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbcBCU6P (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Feb 2016 15:58:15 -0500
Date: Wed, 3 Feb 2016 12:58:11 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 4/4] xfstests: 899 requires a working filefrag
Message-ID: <20160203205811.GI22352@birch.djwong.org>
References: <1454515328-1586-1-git-send-email-hch@lst.de>
 <1454515328-1586-5-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454515328-1586-5-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 03, 2016 at 05:02:08PM +0100, Christoph Hellwig wrote:
> See http://www.infradead.org/rpr.html
> 
> NFS has neither FIBMAP nor FIEMAP so filefrag will fail.  Handle this
> case gracefully.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/899 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/899 b/tests/generic/899
> index 9b3f973..ce3db38 100755
> --- a/tests/generic/899
> +++ b/tests/generic/899
> @@ -67,6 +67,10 @@ nr=64
>  _pwrite_byte 0x61 0 $((blksz * nr)) "$testdir/file1" >> "$seqres.full"
>  _pwrite_byte 0x62 0 $((blksz * nr)) "$testdir/file3" >> "$seqres.full"
>  _pwrite_byte 0x61 0 $((blksz * nr)) "$testdir/file1.chk" >> "$seqres.full"
> +
> +filefrag -v "$testdir/file1" 2>&1 | grep -q "FIBMAP: Invalid argument" && \
> +	_notrun "filefrag not support on file system type \"$FSTYP\""

I rewrote the test to avoid filefrag.

--D

> +
>  seq 1 2 $((nr-1)) | while read f; do
>  	_reflink_range "$testdir/file1" $((blksz * f)) "$testdir/file3" $((blksz * f)) $blksz >> "$seqres.full"
>  done
> -- 
> 2.1.4
> 
