Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48750 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871AbbEOGPV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 15 May 2015 02:15:21 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4F6FKkC004131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 15 May 2015 02:15:21 -0400
Date: Fri, 15 May 2015 14:15:17 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/032: properly test for corruption from xfs_copy
Message-ID: <20150515061517.GF1140@dhcp-13-216.nay.redhat.com>
References: <5554C010.7020300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5554C010.7020300@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 14, 2015 at 10:32:32AM -0500, Eric Sandeen wrote:
> From the xfs_repair manpage:
> 
>     xfs_repair run without the -n option will always return
>     a status code of 0.
> 
> So we must use "-n" to detect corruption in this test.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good to me.

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
> 	
> 
> diff --git a/tests/xfs/032 b/tests/xfs/032
> index 60c4662..a3fb89f 100755
> --- a/tests/xfs/032
> +++ b/tests/xfs/032
> @@ -68,7 +68,8 @@ while [ $SECTORSIZE -le $PAGESIZE ]; do
>  
>  		$XFS_COPY_PROG -d $SCRATCH_DEV $IMGFILE >> $seqres.full 2>&1 || \
>  			_fail "Copy failed for Sector size $SECTORSIZE Block size $BLOCKSIZE"
> -		$XFS_REPAIR_PROG $IMGFILE >> $seqres.full 2>&1 || \
> +		# Must use "-n" to get exit code; without it xfs_repair always returns 0
> +		$XFS_REPAIR_PROG -n $IMGFILE >> $seqres.full 2>&1 || \
>  			_fail "Copy corrupted for Sector size $SECTORSIZE Block size $BLOCKSIZE"
>  
>  		BLOCKSIZE=$(($BLOCKSIZE * 2));
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
