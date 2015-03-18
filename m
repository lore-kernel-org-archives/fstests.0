Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:60693 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754316AbbCRDte (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 17 Mar 2015 23:49:34 -0400
Date: Wed, 18 Mar 2015 14:49:17 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/014: use the POSIX output format of df
Message-ID: <20150318034917.GF10105@dastard>
References: <1425914923-19220-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425914923-19220-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 09, 2015 at 11:28:43PM +0800, Eryu Guan wrote:
> I've seen xfs/014 fails as
> 
> 	[root@dhcp-66-86-3 xfstests]# diff -u tests/xfs/014.out /var/lib/xfstests/results//xfs/014.out.bad
> 	--- tests/xfs/014.out   2015-03-06 14:48:19.000000000 +0800
> 	+++ /var/lib/xfstests/results//xfs/014.out.bad  2015-03-09
> 	22:48:08.660001935 +0800
> 	@@ -1,2 +1,9 @@
> 	 QA output created by 014
> 	  Silence is golden.
> 	  +falloc: invalid option -- '1'
> 	  +falloc: invalid option -- '0'
> 	  +falloc: invalid option -- 'M'
> 	  +falloc [-k] off len -- allocates space associated with part of a file
> 	  via fallocate
> 	  +falloc [-k] off len -- allocates space associated with part of a file
> 	  via fallocate
> 	  +falloc [-k] off len -- allocates space associated with part of a file
> 	  via fallocate
> 	  +falloc [-k] off len -- allocates space associated with part of a file
> 	  via fallocate
> 
> which is because output of "df -m" is split into two lines, and
> freesp is 0, in _consume_free_space() function.
> 
> 	Filesystem           1M-blocks  Used Available Use% Mounted on
> 	/mnt/testarea/scratch/014.fs
> 				 10230  1061      9170  11% /mnt/testarea/scratch/014.mnt
> 
> Now use the POSIX output format of df to make it more portable.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/xfs/014 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/014 b/tests/xfs/014
> index 8866bfe..a2069db 100755
> --- a/tests/xfs/014
> +++ b/tests/xfs/014
> @@ -88,7 +88,7 @@ _consume_free_space()
>  	dir=$1
>  
>  	# allocate all but 10MB of available space
> -	freesp=`df -m $dir | awk '/^\// { print $4 - 10 }'`
> +	freesp=`df -mP $dir | awk '/^\// { print $4 - 10 }'`
>  	$XFS_IO_PROG -f -c "falloc 0 ${freesp}M" $dir/spc

$DF_PROG. from common/config:

export DF_PROG="`set_prog_path df`"
[ "$DF_PROG" = "" ] && _fatal "df not found"
[ "$HOSTOS" = "Linux" ] && export DF_PROG="$DF_PROG -T -P"


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
