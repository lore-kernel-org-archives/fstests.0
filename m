Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90B3D8111
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272749; cv=none; b=lhwof4/bI9CVLdrevFEpyex5Rtj3NhPv7wO+tlj0ONJWQHQaC6i9q6pX8/8OXb491gQUTYs+okUOYtNpU+Y7UhJJ5EhPRs7iMduArHcDd7MPo2O7KY0wa6bXSMrIWO3eIKzmWm5rgxq+8HNo+l8L9s71w0eRtX9TKACS8qmC+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272749; c=relaxed/simple;
	bh=OuOhqil/bCU2y6QkizUMlNOxMRGsKLzXPALTFHdGwEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBK2/lKLx3auQ88u5umShvmOSJ5HW+jSlmDxe9eEEtw7SGPk1HQJ2rk/LHWX9TGwjCGyuXH9asqcKqisotHd54g9YjbGm50mZQ8mfZUVWte1gityoXe9ZUKDWytZOJyMP+2bST8GFRcxIcxIDLD9GfoSrgLyskJXPh+MjUhlUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgEL3gb7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgEL3gb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079321F000E9;
	Wed, 20 May 2026 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779272742;
	bh=g4Bq9S3vxOU3bf6v1qm5NmuE0ocpy1LnL8pr7lwHcfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DgEL3gb7LzW6WNuSnvlMYDkgXbVwMB+KxmCLWciz3iUFNYezhvJBx8dddg79H/lel
	 yPm16meSqsK01q564xFts9TpM8u150CbOGi4hB5jv0XlmstwHq6QnnuP1d3MPrTmd+
	 mVPLtXqEMO3y31aKr5awy5xJ+vP8+FH7L3ToI+Dd+6Vikyg8X7ft8j+Kdz5ex7Q6RK
	 t8tJd5eWqoyBwpBy7oL2+xdThtR8EmCE0OR2mGu93NQKchGJMkNG8fuC7rFM5FnpWT
	 hO0d2JosPz7HIqxjCOp9+GeROy+1Owq3e+TtRzVepynSbpDlw13SwTs/JSMWwd89Vf
	 wGx8lxRi0lLWA==
Date: Wed, 20 May 2026 18:25:34 +0800
From: Zorro Lang <zlang@kernel.org>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Qu Wenruo <wqu@suse.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Nirjhar Roy <nirjhar.roy.lists@gmail.com>
Subject: Re: [PATCH] generic/563: allow read tolerance for f2fs in scenario 3
Message-ID: <ag2L_qWTqNbAovw5@zlang-mailbox>
Mail-Followup-To: Jan Prusakowski <jprusakowski@google.com>, 
	Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Qu Wenruo <wqu@suse.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Nirjhar Roy <nirjhar.roy.lists@gmail.com>
References: <20260515082608.449455-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515082608.449455-1-jprusakowski@google.com>

On Fri, May 15, 2026 at 08:26:08AM +0000, Jan Prusakowski wrote:
> F2FS is a log-structured file system that allocates new blocks even for
> overwrites. To perform allocation, it may need to read metadata blocks
> (such as the Node Address Table (NAT) or Segment Info Table (SIT)) if
> they are not already in memory.
> 
> In scenario 3 (read -> read/write), unlike scenario 2, there is no prior
> write in the same mount session to load these metadata blocks into memory.
> Therefore, the write operation in the second cgroup triggers metadata
> reads, which are charged to that cgroup.
> 
> Relax the read tolerance for f2fs in scenario 3 to accommodate these
> expected metadata reads, matching the tolerance already used in scenario 2.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
> ---
>  tests/generic/563 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/563 b/tests/generic/563
> index c3705c2f..f95eb073 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -151,7 +151,10 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
>  check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> -check_cg $cgdir/$seq-cg-2 0 0 0 0
> +# F2FS may perform metadata reads during write in this scenario
> +read_tol=0
> +[ "$FSTYP" = "f2fs" ] && read_tol=33792
> +check_cg $cgdir/$seq-cg-2 0 0 $read_tol 0

Make sense to me,

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  
>  if [ "$drop_io_cgroup" = 1 ]; then
>  	echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
