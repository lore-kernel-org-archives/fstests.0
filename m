Received: from userp1040.oracle.com ([156.151.31.81]:47138 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbcBCU5A (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Feb 2016 15:57:00 -0500
Date: Wed, 3 Feb 2016 12:56:55 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 3/4] xfstests: 912 requires dedup support
Message-ID: <20160203205655.GH22352@birch.djwong.org>
References: <1454515328-1586-1-git-send-email-hch@lst.de>
 <1454515328-1586-4-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454515328-1586-4-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 03, 2016 at 05:02:07PM +0100, Christoph Hellwig wrote:
> See http://www.infradead.org/rpr.html

Applied, thanks.

--D

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/912 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/912 b/tests/generic/912
> index 910f1ea..7a629bc 100755
> --- a/tests/generic/912
> +++ b/tests/generic/912
> @@ -43,7 +43,7 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_os Linux
> -_require_test_reflink
> +_require_test_dedupe
>  _require_cp_reflink
>  
>  rm -f "$seqres.full"
> -- 
> 2.1.4
> 
