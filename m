Received: from mx1.redhat.com ([209.132.183.28]:43164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762967AbdAIREW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 9 Jan 2017 12:04:22 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DA024D68C
        for <fstests@vger.kernel.org>; Mon,  9 Jan 2017 17:04:23 +0000 (UTC)
Date: Mon, 9 Jan 2017 12:04:21 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] xfs/010: explicitly allow corrupted write in xfs_db
Message-ID: <20170109170421.GE22368@bfoster.bfoster>
References: <9d52a01a-78db-3ee1-66e7-bddd1f3f9598@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d52a01a-78db-3ee1-66e7-bddd1f3f9598@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 09, 2017 at 10:49:21AM -0600, Eric Sandeen wrote:
> xfs/010 wants to write corruption and test how xfs_repair
> deals, but when:
> 
>   xfs: forbid AG btrees with level == 0
> 
> is merged to userspace, this new test fails the write verifier
> in xfs_db.
> 
> Add "-c" to allow the corrupted write, do the corruptions all
> in one xfs_db command (so it doesn't have to re-read the
> corrupted data on 2nd startup), and filter out the
> 
>   "Allowing write of corrupted data and bad CRC"
> 
> output from the "write -c" command.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

> 
> diff --git a/tests/xfs/010 b/tests/xfs/010
> index d350d64..471ec2c 100755
> --- a/tests/xfs/010
> +++ b/tests/xfs/010
> @@ -95,8 +95,11 @@ _corrupt_finobt_root()
>  	dev=$1
>  
>  	# nuke the agi finobt root fields
> -	$XFS_DB_PROG -x -c "agi 0" -c "write free_root 0" $dev
> -	$XFS_DB_PROG -x -c "agi 0" -c "write free_level 0" $dev
> +	$XFS_DB_PROG -x				\
> +		-c "agi 0"			\
> +		-c "write -c free_root 0"	\
> +		-c "write -c free_level 0"	\
> +		$dev | grep -v "Allowing write of corrupted"
>  }
>  
>  # real QA test starts here
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
