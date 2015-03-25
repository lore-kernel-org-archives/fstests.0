Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbbCYXIx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Mar 2015 19:08:53 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2PN8rfW016269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2015 19:08:53 -0400
Date: Wed, 25 Mar 2015 19:08:51 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 8/9] xfs/014: replace df with $DF_PROG
Message-ID: <20150325230850.GC13510@bfoster.bfoster>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
 <1426846618-23413-9-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426846618-23413-9-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 20, 2015 at 06:16:57PM +0800, Eryu Guan wrote:
> I've seen xfs/014 fails as
> 
>         [root@dhcp-66-86-3 xfstests]# diff -u tests/xfs/014.out /var/lib/xfstests/results//xfs/014.out.bad
>         --- tests/xfs/014.out   2015-03-06 14:48:19.000000000 +0800
>         +++ /var/lib/xfstests/results//xfs/014.out.bad  2015-03-09
>         22:48:08.660001935 +0800
>         @@ -1,2 +1,9 @@
>          QA output created by 014
>           Silence is golden.
>           +falloc: invalid option -- '1'
>           +falloc: invalid option -- '0'
>           +falloc: invalid option -- 'M'
>           +falloc [-k] off len -- allocates space associated with part of a file
>           via fallocate
>           +falloc [-k] off len -- allocates space associated with part of a file
>           via fallocate
>           +falloc [-k] off len -- allocates space associated with part of a file
>           via fallocate
>           +falloc [-k] off len -- allocates space associated with part of a file
>           via fallocate
> 
> which is because output of "df -m" is split into two lines, and
> freesp is 0, in _consume_free_space() function.
> 
>         Filesystem           1M-blocks  Used Available Use% Mounted on
>         /mnt/testarea/scratch/014.fs
>                                  10230  1061      9170  11% /mnt/testarea/scratch/014.mnt
> 
> Appending '-P' option to df fixes this issue. So use $DF_PROG which
> already has -P option set.
> 
> $DF_PROG also sets -T option to print fs type in extra column, so change
> the awk command accordingly to get the correct freespace.
> 
> Also replace awk with $AWK_PROG.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

Looks good..

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/xfs/014 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/014 b/tests/xfs/014
> index 8866bfe..ab3d85b 100755
> --- a/tests/xfs/014
> +++ b/tests/xfs/014
> @@ -88,7 +88,7 @@ _consume_free_space()
>  	dir=$1
>  
>  	# allocate all but 10MB of available space
> -	freesp=`df -m $dir | awk '/^\// { print $4 - 10 }'`
> +	freesp=`$DF_PROG -m $dir | $AWK_PROG '/^\// { print $5 - 10 }'`
>  	$XFS_IO_PROG -f -c "falloc 0 ${freesp}M" $dir/spc
>  }
>  
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
