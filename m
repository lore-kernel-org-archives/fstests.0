Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753130AbeEUQYA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 May 2018 12:24:00 -0400
Date: Tue, 22 May 2018 00:23:57 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/475: fix confusing comment
Message-ID: <20180521162357.GI4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180521160734.GJ4910@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521160734.GJ4910@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, May 21, 2018 at 09:07:34AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> The comment about the dmerror switcheroo is hard to understand and
> wrong.  Fix both problems by rewriting it.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  tests/generic/475 |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/475 b/tests/generic/475
> index e31f1251..45072278 100755
> --- a/tests/generic/475
> +++ b/tests/generic/475
> @@ -73,9 +73,11 @@ for i in $(seq 1 $((50 * TIME_FACTOR)) ); do
>  	# recovery
>  	sleep $((RANDOM % 3))
>  
> -	# Loading error table without "--nolockfs" option. Because "--nolockfs"
> -	# won't freeze fs, then some running I/Os may cause XFS to shutdown
> -	# prematurely. That's not what we want to test.
> +	# This test aims to simulate sudden disk failure, which means that we
> +	# do not want to quiesce the filesystem or otherwise give it a chance
> +	# to flush its logs.  Therefore we want to call dmsetup with the
> +	# --nolockfs parameter; to make this happen we must call the load
> +	# error table helper *without* 'lockfs'.

Thanks! This looks good to me!


>  	_dmerror_load_error_table
>  
>  	ps -e | grep fsstress > /dev/null 2>&1
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
