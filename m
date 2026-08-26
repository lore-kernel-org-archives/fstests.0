Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236223C4F3
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760953; cv=none; b=PrkbULIa2mPjjQjNWbIvJ+KX9WlHk3KfFq7+FGOZx/QR8O4FxWndzryGgGvO/WqYCrc7Fu2dA2ooHx8ZcrHoSifhStEq5CvPLBIiJecsmC2/l1fY0RWgm67wOxWCxxzkFFZaRC3QjrhbuJxROmC2UiPnBuCoTdyaeV8n5kJu7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760953; c=relaxed/simple;
	bh=/dsT6A4hfbMJ8oU3JboE1rKLUfxuXZCDLGi4FTUX63M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl6R65HnZfl+5K85F+2ZGDn+wCs9cJwyf/HbrPPxOHu0bRqeUmx3znueDjUAjzsgs1ZBg3eaMHETsX/veIUMfRm8itwZ96h2dPHDp6tfJCgYBXa66juihyVRWvt/bkRn6ckzQuMZYyk0GZkoMNVd8RJo9ja3xXbX3ov6xrdFz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnJzRuwK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnJzRuwK"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5B9751F000E9;
	Wed, 26 Aug 2026 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787760951;
	bh=oGVokc8rd7+imdxkz8wvg1LFT5O5yEcblG6F3rOV5X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GnJzRuwK9eTyPn7406T95kwDEMPj5IUzR9+1Anxk2N1XKoH/zRgsm7VcS62Vm3+k2
	 ELU3Tsv0eJExYjU0U6nt4vB989rnVlgHXMd4c+8+RsqX4WJMSGSAYPcHwqSLJ9Xeta
	 8hfhVu0UZ3nOvnxnidnYHJTMGf7GmagbKI9ResMZAUFF5CxjJcTjLXF+H9CTOVhIRL
	 C95ODaL+PP4Mn0vF7C9D3eo7XPtc9QPcSjyebaMUhBVZ1HZSDkd147lSeuFztdjw6R
	 tJ+w1oHX1ODqB3nKU74WnzJHECALhx1zcE8GOVWgpCnfEtdKzgSFWgJ1i8zf6BhB10
	 7UrsYgiHzjyHw==
Date: Wed, 26 Aug 2026 09:15:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH v3] generic/798: chain xfs_io commands into a single
 invocation
Message-ID: <20260826161550.GU839663@frogsfrogsfrogs>
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

Looks good now!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
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
