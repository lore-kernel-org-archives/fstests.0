Received: from userp2120.oracle.com ([156.151.31.85]:38394 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfEHD1C (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 May 2019 23:27:02 -0400
Date: Tue, 7 May 2019 20:26:53 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/532: do not break golden silence if
 attributes_mask is 0
Message-ID: <20190508032653.GC1473023@magnolia>
References: <20190508031144.17895-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508031144.17895-1-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Murphy Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 08, 2019 at 11:11:44AM +0800, Murphy Zhou wrote:
> If the filesystem does not support STATX_ATTR, like NFS, setting
> both attributes and attributes_mask to 0 seems the right thing to
> do. attributes_mask can be 0 only if attributes is also 0.
> This situation is covered by the "&" check in the next line.
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>

Seems fine to me.
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/532 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/532 b/tests/generic/532
> index ac8b7a89..3f8afa4a 100755
> --- a/tests/generic/532
> +++ b/tests/generic/532
> @@ -44,7 +44,6 @@ check_statx_attributes()
>  	echo "MASK:$mask:ATTRS:$attrs:" >> $seqres.full
>  
>  	test -z "$mask" && _notrun "xfs_io statx command does not support attributes_mask"
> -	test $(( mask )) -eq 0 && echo "attributes mask is zero"
>  	test $(( attrs & ~(mask) )) -ne 0 && echo "attributes $attrs do not appear in mask $mask"
>  }
>  
> -- 
> 2.21.0
> 
