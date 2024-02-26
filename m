Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364312CD9B
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966327; cv=none; b=Y4JdKsE+qiS/mzxk1Rdw0ZgOHJPMjcZXHWvRZKWijSmI3XNZzmDGMIClddHcg4QJGuIXNldvnnqQTVvHQrcG/e8cMt54ReydvoRTWvmsUHU8ieEJYLDmSDv4MFXGMxKmWWoi2K4LyGlnz0O9g93O1b1T0WlmqRmUdjjZ+RuOjY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966327; c=relaxed/simple;
	bh=PK9eMixr+gNpPP9xRB8Xxyb+t/umvQGqaTJFybCLjV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUj9ynROgcofzwCdo+sDdU/y6e/UwRRlMYEhWT6a9QY3v174R1apS1biWhm5l4AohHhxkDGqZPaL0kodlJ0JgsKxHkWC74ahHN8dLlEvkpGRJOwNYIisZ88pOBG+gWlpmf7mUXgkriu8/VhGxofN95//U70ajCMjQ8YlR0ba4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcR/oKBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcR/oKBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A09AC433F1;
	Mon, 26 Feb 2024 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708966327;
	bh=PK9eMixr+gNpPP9xRB8Xxyb+t/umvQGqaTJFybCLjV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcR/oKBv8RyDd2GT02GjPd/1ZtyLjCoN0kOLTIZa2rBxVK1P12btuKMEdrCgL8W/1
	 We+L996g4SlOOgjWCC/RE9ilfYHD/2qvzz7QeSgKt9gJgAXd3JU+OdHF3V86L1DiHU
	 v8DirNzB1r0hLoW8W9Vl/yWK4s3cRsy5TAQ0QQlgWd1/CjP/yV26GpWWXrtQpohTz0
	 Da7GiLcgguVIb6hmUqrx8W0EyTAFea/Usj9GgGlQV8sLHLsjQpXNydaaz5jCD4UByx
	 rfXDph/yg98uQ8r1x37Kjgm2EVx9U83ZBm9RgktsBRvtCYIlt240EiOK7Gsqz9i8pb
	 Twy39DWnmVlBg==
Date: Mon, 26 Feb 2024 08:52:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@redhat.com, fstests@vger.kernel.org, jaegeuk@kernel.org
Subject: Re: [PATCH] generic/392: stop checking st_blocks
Message-ID: <20240226165206.GP6188@frogsfrogsfrogs>
References: <20240226100319.280355-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226100319.280355-1-hch@lst.de>

On Mon, Feb 26, 2024 at 11:03:19AM +0100, Christoph Hellwig wrote:
> st_blocks is a rather vaguely defined field.  To quote the Linux stat(2)
> man page:
> 
>     Use of the st_blocks and st_blksize fields may be less portable.
>     (They were introduced in BSD.  The interpretation differs between
>     systems, and possibly on a single system when NFS mounts are
>     involved.)
> 
> or the FreeBSD one:
> 
>     st_blocks   Actual number of blocks allocated for the file in
> 		512-byte units.  As short symbolic links are stored in
> 		the inode, this number may be zero.
> 
> and at least for XFS they include speculative preallocations and
> in-flight COW fork allocations, and the numbers can change when the way
> how data is stored is reorganized.  Because of that it doesn't make sense
> to require st_blocks to not change after a crash even when fsync or
> fdatasync was involved.
> 
> Remove the st_blocks checks and the now superfluous XFS always_cow
> workaround.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I've long found the st_blocks checking suspect, so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/392 | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/generic/392 b/tests/generic/392
> index c4bb3f4b9..0c9efb6df 100755
> --- a/tests/generic/392
> +++ b/tests/generic/392
> @@ -6,7 +6,7 @@
>  #
>  # Test inode's metadata after fsync or fdatasync calls.
>  # In the case of fsync, filesystem should recover all the inode metadata, while
> -# recovering i_blocks and i_size at least for fdatasync.
> +# recovering for fdatasync it should at least recovery i_size.
>  #
>  . ./common/preamble
>  _begin_fstest shutdown auto quick metadata punch
> @@ -28,16 +28,6 @@ _scratch_mkfs >/dev/null 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
>  _scratch_mount
>  
> -# This test requires that i_blocks remains unchanged from the start of the
> -# check_inode_metadata call until after recovery is complete.  fpunch calls
> -# turn into pagecache writes if the arguments are not aligned to the fs
> -# blocksize.  If the range being punched is already mapped to a written extent
> -# and alwayscow is enabled, i_blocks will increase by the size of the COW
> -# staging extent.  This causes stat to report different numbers for %b, which
> -# results in a test failure.  Hence do not run this test if XFS is in alwayscow
> -# mode.
> -test "$FSTYP" = "xfs" && _require_no_xfs_always_cow
> -
>  testfile=$SCRATCH_MNT/testfile
>  
>  # check inode metadata after shutdown
> @@ -47,9 +37,9 @@ check_inode_metadata()
>  
>  	# fsync or fdatasync
>  	if [ $sync_mode = "fsync" ]; then
> -		stat_opt='-c "b: %b s: %s a: %x m: %y c: %z"'
> +		stat_opt='-c "s: %s a: %x m: %y c: %z"'
>  	else
> -		stat_opt='-c "b: %b s: %s"'
> +		stat_opt='-c "s: %s"'
>  	fi
>  
>  	before=`stat "$stat_opt" $testfile`
> -- 
> 2.39.2
> 
> 
