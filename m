Received: from mx1.redhat.com ([209.132.183.28]:53812 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbbGFHF7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 6 Jul 2015 03:05:59 -0400
Date: Mon, 6 Jul 2015 15:05:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/015: make it more robust
Message-ID: <20150706070555.GN1210@dhcp-13-216.nay.redhat.com>
References: <1435943727-6075-1-git-send-email-xuw2015@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1435943727-6075-1-git-send-email-xuw2015@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: xuw2015@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jul 04, 2015 at 01:15:27AM +0800, xuw2015@gmail.com wrote:
> From: George Wang <xuw2015@gmail.com>

Looks good to me overall, some comments below.

How about changing subject to:

xfs/015: make sure create_file finishes after growfs

> 
> create_file may run over before growfs, which depends on many reasons. such as
> the schedule algorithm, the workload of testing machine, etc. we should always
> make sure the create_file run over after growfs, then we can get the valid
> result of this test.

Missing "Signed-off-by" line here.

> ---
>  tests/xfs/015 | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/015 b/tests/xfs/015
> index 4dbf38a..d9d4446 100755
> --- a/tests/xfs/015
> +++ b/tests/xfs/015
> @@ -43,9 +43,16 @@ create_file()
>  {
>  	local dir=$1
>  	local i=0
> -
> -	while echo -n >$dir/testfile_$i; do
> -		let i=$i+1
> +	local in_growfs=false
> +
> +	# keep run until failed after growfs
               ^^^ running

Thanks,
Eryu
> +	while true; do
> +		[ -f $tmp.growfs ] && in_growfs=true
> +		while echo -n >$dir/testfile_$i; do
> +			let i=$i+1
> +		done
> +		$in_growfs && break
> +		usleep 1000
>  	done
>  }
>  
> @@ -89,6 +96,9 @@ echo "Fork $nr_worker workers to consume free inodes in background" >>$seqres.fu
>  echo "Grow fs to $((dblocks * 4)) blocks" >>$seqres.full
>  $XFS_GROWFS_PROG -D $((dblocks * 4)) $SCRATCH_MNT >>$seqres.full
>  
> +# mark xfs_growfs finished to create_file
> +touch $tmp.growfs
> +
>  # Wait for background create_file to hit ENOSPC
>  wait
>  
> -- 
> 1.8.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
