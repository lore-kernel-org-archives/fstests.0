Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B923FBB70
	for <fstests@vger.kernel.org>; Fri, 15 May 2026 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862400; cv=none; b=sBhmlDGqO9SEwaMr59C50ZQf6Wo3XgBHAWeI6dOyX0qpv66YsndNM9x0QRG/h1CJ25EDuCdfH0nZPhZX6z00h9uLdbAzxqGcFOogLYVDQylrBxa3GzPtmURhYYAbufXqF29dBRco5B+38Num6WDYtmopIlb+9LcQSdkceq1DOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862400; c=relaxed/simple;
	bh=WtmKt0lBFbyllVIq57IekUkSgtGwAHJfJthOnBfCREY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUa97Udc1qXEDIIdd8frGsOa6jownDuHY5OMNZYx2l+FyR7VOXgeCI4lbqE459ngQUQRgZI3wjJcQIxPmIP7cSn14vgXMUj4Sc6ST96JXwWeaCsM8vYsUrvTjFF0y881EacKF6ouXzBFWzJ3VF+7sjRH5kHoKIJCxV1yQy3XhWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjIfqZEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjIfqZEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013F9C2BCB0;
	Fri, 15 May 2026 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778862400;
	bh=WtmKt0lBFbyllVIq57IekUkSgtGwAHJfJthOnBfCREY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjIfqZEjZrYI6Zvd0qsEkZS6UQ81XzXlVqbVNG/oKvAbeDW5+xwG7/pGoqXKXa+oE
	 iy9M31yRFzvIzpHzw7ZS5wWhkek89b1KZGWA14hXLzIgZ/UJyB5I59iwAtHN2c/PC/
	 3e9ucJMQk3Xqu5wxaF5rTnpxzki8h9TKQetYS+DScuF4d4xjJuPbJivSmCYwcxY3Fw
	 HEgfOQwfDgg185At/zBCtXd90dI5k5KAdNlouxSajNBDA0fUG2eMOlI6zV1Vj+aiJc
	 4lsqsX8grdZpmBkGrdxZuDGmtUzhoVrJLzL1HoOj2vIkn2IX3gW03M1ke5izEN6CeS
	 Z0IhFKuapAz1g==
Date: Sat, 16 May 2026 00:26:33 +0800
From: Zorro Lang <zlang@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH v2] ext4/307: Calculate donor size to avoid failures for
 64k bs
Message-ID: <agdJEsrKflGff5wq@zlang-mailbox>
Mail-Followup-To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
References: <20260401100941.76082-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401100941.76082-1-ojaswin@linux.ibm.com>

On Wed, Apr 01, 2026 at 03:39:41PM +0530, Ojaswin Mujoo wrote:
> Calculating size of donor file based on du output causes the following
> issue:
> 
> e4compact.c:68: do_defrag_range: Assertion `donor->length >= len' failed.
> ./common/rc: line 4616: 1583182 Aborted                 (core dumped)
> 
> The issue is that e4compat asserts that the stat.st_size of all files
> combined shouldn't be more than that of the donor file. In case of 64k
> blocksize, fsstress often creates sparse files which have >3G size even
> though their disk utilization is <100M. Since donor file is not big
> enough, this trips e4compat causing the failure.
> 
> Fix this by using stat.st_size rather than du value to get the size.
> Also, make some changes to avoid future ENOSPC like reducing the -n
> passed to fsstress to keep the size around 2G and making sure we use the
> whole SCRATCH disk instead of 500M.
> 
> While we are at it, add some new lines to make the code bit more
> readable.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---

It tests good to me,
Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/ext4/307 | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/ext4/307 b/tests/ext4/307
> index 48073347..ed6fc664 100755
> --- a/tests/ext4/307
> +++ b/tests/ext4/307
> @@ -19,18 +19,26 @@ _workout()
>  	echo ""
>  	echo "Run fsstress"
>  	out=$SCRATCH_MNT/fsstress.$$
> -	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 -d $out`
> +	args=`_scale_fsstress_args -p4 -n500 -f setattr=1 -d $out`
>  	echo "fsstress $args" >> $seqres.full
>  	_run_fsstress $args
> +
>  	find $out -type f > $out.list
>  	cat $out.list | xargs  md5sum > $out.md5sum
> -	# Use -m to get integer MB size to avoid decimals (e.g. 1.5M) which xfs_io rejects
> -	usage=$(du -sm $out | awk '{print $1}')
> +
> +	# Get the total of stat.st_size of each file to determine the
> +	# size of donor file. We use st_size here instead of blocks used
> +	# because thats what e4compat.c checks against.
> +	bytes=$(xargs -r stat -c %s < $out.list | awk '{s+=$1} END{print s}')
> +	echo "Total bytes used: $bytes" >> $seqres.full
> +
>  	echo "Allocate donor file"
> -	$XFS_IO_PROG -c "falloc 0 ${usage}m" -f $SCRATCH_MNT/donor | _filter_xfs_io
> +	$XFS_IO_PROG -c "falloc 0 $bytes" -f $SCRATCH_MNT/donor | _filter_xfs_io
> +
>  	echo "Perform compacting"
>  	cat $out.list | run_check $here/src/e4compact \
>  		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> +
>  	echo "Check data"
>  	run_check md5sum -c $out.md5sum
>  }
> @@ -42,7 +50,7 @@ _require_scratch
>  _require_defrag
>  _require_xfs_io_command "falloc"
>  
> -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mkfs >> $seqres.full 2>&1
>  _scratch_mount
>  
>  _workout
> -- 
> 2.52.0
> 
> 
