Received: from mx1.redhat.com ([209.132.183.28]:33835 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbbGMNuH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 13 Jul 2015 09:50:07 -0400
Date: Mon, 13 Jul 2015 21:50:05 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfs/015: keep create_file running until growfs
 finished
Message-ID: <20150713135005.GB17972@dhcp-13-216.nay.redhat.com>
References: <1436235650-1206-1-git-send-email-xuw2015@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436235650-1206-1-git-send-email-xuw2015@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: xuw2015@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 07, 2015 at 10:20:50AM +0800, xuw2015@gmail.com wrote:
> From: George Wang <xuw2015@gmail.com>
> 
> create_file may run over before growfs, which depends on many reasons. such as
> the schedule algorithm, the workload of testing machine, etc. we should always
> make sure the create_file run over after growfs, then we can get the valid
> result of this test.

Looks good to me.

Reviewed-by: Eryu Guan <eguan@redhat.com>

> 
> Signed-off-by: George Wang <xuw2015@gmail.com>
> ---
>  tests/xfs/015 | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/015 b/tests/xfs/015
> index 4dbf38a..b8fa437 100755
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
> +	# keep running until failed after growfs
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
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
