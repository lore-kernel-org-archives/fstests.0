Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347E345CC9
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763642; cv=none; b=PiZz7fMY/WZdZSMu4VoFI3482rXiIXrw/q3KTbD3XiN+tDAQq1FtI+bDDHQqJayN5+v33qfwaM0Z/Pu1/iShc2MzUG3YroLtMIYoEkQfZJU91fXM0hQkB1lnStnnEu6CuyhymJkKXzV0hLEHmH/yppP528XvAGOSh7xVtfU7jTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763642; c=relaxed/simple;
	bh=pEVdjflSNEcpSKxiPKf+/aiB6NieXKHc8Em0gljv3pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf0DvYHvBViQbvj3UbcZMmUHUbeSwIgHgHRwJgjSBQ8wQx50h4KB7WrGySshvthxdDJn/Cq8yHvluyELMdo5o7rmYXdnkXaAHaPpFj1lQUXWXK0/SoL0ff11j3JJm+yiW0A3oMuCmxpDZ9MEYQQYPryvG+xqtaXL825fgqKsfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjgpfPsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjgpfPsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0641F000E9;
	Wed, 26 Aug 2026 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787763630;
	bh=oJF/VGcb8xe28lCs9Y5w/9TycbnNls84e6iEPvvwXPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QjgpfPswh0+Bog9M8D1bS4WIxMzRGh1JLU6roNI6pkVaTW8ESAvvuJwZ82Mdjcdqe
	 1aDoJ0j+l4NZiwk8iQLlnVZHEJQx+VgVIKxkauXHiCQRh1AT0Qi8qbNShpsxAkmviV
	 KUsvC9+5bWkBlG2PJfBG7/STgag//+hejcw/ed9dmmSQ4QE6gnvEhd1EuvrM9J+S+P
	 KDI1zYcofksjpbmBvvC8nct01m7nzB/NAkAYmV/uo1FU+iJ/wEC39xmovZ1YEA/Voi
	 GO5+/AkCASAMXd6icU6VlEzBRD4nDac5c7+jeezRW/6CddewicCj4z2l7m4W9+KlkZ
	 yrjCQyswQc5lA==
Date: Thu, 27 Aug 2026 01:00:25 +0800
From: Zorro Lang <zlang@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: djwong@kernel.org, fstests@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH v3] generic/798: chain xfs_io commands into a single
 invocation
Message-ID: <ao8Th85cP8nAHilE@zlang-mailbox>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>, 
	djwong@kernel.org, fstests@vger.kernel.org, wqu@suse.com
References: <20260826152014.GT839663@frogsfrogsfrogs>
 <20260826155423.183785-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826155423.183785-1-avinesh.kumar@suse.com>

On Wed, Aug 26, 2026 at 05:54:23PM +0200, Avinesh Kumar wrote:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> The write, cachestat, fsync, and cachestat calls were each run as
> separate xfs_io invocations, closing and reopening the file in
> between. Some filesystems flush dirty data back on close(), clearing
> the dirty bit before the first cachestat ever ran, causing test failure
> 
> - output mismatch (see /opt/xfstests/results//generic/798.out.bad)
>     --- tests/generic/798.out	2026-08-20 05:25:39.000000000 -0400
>     +++ /opt/xfstests/results//generic/798.out.bad	2026-08-21 12:30:39.831381108 -0400
>     @@ -1,16 +1,16 @@
>      QA output created by 798
>      === Test with 1 pages ===
>     -Cached: 1, Dirty: 1, Writeback: 0, Evicted: 0, Recently Evicted: 0
>     +Cached: 1, Dirty: 0, Writeback: 0, Evicted: 0, Recently Evicted: 0
>      Cached: 1, Dirty: 0, Writeback: 0, Evicted: 0, Recently Evicted: 0
>      === Test with 2 pages ===
>     -Cached: 2, Dirty: 2, Writeback: 0, Evicted: 0, Recently Evicted: 0
>     ...
> 
> Run the whole sequence on one open file descriptor instead by chaining
> all xfs_io commands in single invocation.
> 
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---

This change is good to me,

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/generic/798 | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/generic/798 b/tests/generic/798
> index 0fe37646..5c81b429 100755
> --- a/tests/generic/798
> +++ b/tests/generic/798
> @@ -27,12 +27,21 @@ for num_page in 1 2 4 8 16; do
>  	echo "=== Test with $num_page pages ==="
>  
>  	rm -f $SCRATCH_MNT/foobar
> -	$XFS_IO_PROG -f -c "pwrite -b $pagesize 0 $size" $SCRATCH_MNT/foobar > /dev/null
> -	# Basic cached number reporting
> -	$XFS_IO_PROG -c "cachestat 0 $size" $SCRATCH_MNT/foobar
>  
> -	# Test dirty page number reporting after a fsync.
> -	$XFS_IO_PROG -c "fsync" -c "cachestat 0 $size" $SCRATCH_MNT/foobar
> +	# Basic cached number reporting and test dirty page number
> +	# reporting after a fsync.
> +	#
> +	# Do the whole write+cachestat+fsync+cachestat sequence in a
> +	# single xfs_io invocation. Some filesystems (e.g. NFS) flush
> +	# dirty data back to the server as part of their own close()-time
> +	# cache consistency, which would clear the dirty bits before the
> +	# second xfs_io process ever got to run cachestat.
> +	$XFS_IO_PROG -f \
> +		-c "pwrite -q -b $pagesize 0 $size" \
> +		-c "cachestat 0 $size" \
> +		-c "fsync" \
> +		-c "cachestat 0 $size" \
> +		$SCRATCH_MNT/foobar
>  done
>  
>  _scratch_unmount
> -- 
> 2.55.0
> 
> 
