Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0904C43F091
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757617; cv=none; b=cuXt3E9SmQLULtE0zu/CGG1xYUjBsGV6pbnUxLcGWsLez62b4JZbrTK2/0hkwWs4PIzxHYAGEt0V2yM3xmYFGZ68Bsq4joMFJtgvoZdNc01ncPK0LP4CM1FX1ZSRr1v0RXiV/mqtph8+9pwteOzVujYEN1pPCMtK23iFwnyC73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757617; c=relaxed/simple;
	bh=+LkxM1fKdI2OqYyozkWA70T8QhErjvLoF07uY+lbnqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpKCTE6aNnd+34/56wK3L8r21aKvEWdmDEKXCEjcC0r9rJUfdiiFHjxWyXJq9VsvB+3EJeMElf607MM3CZ3+zKyK90Re9mGMNkkPGe0KtFlh5MUQZceMCwiH6q6SuXySmnfyay1ZX4GAS6dnAs5oaEd18w3ee7A1rPZKYtIu/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msypQUs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msypQUs7"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 83EB21F000E9;
	Wed, 26 Aug 2026 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757615;
	bh=XGhTdZRQHulIgSb4qP/T0Kbk0PO+h4lkGEacHnUVMbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=msypQUs7TezH2scfXkBPulIjvy514qJFG7tFB//37ujTs5eYJkw+R9ZJI19TEvpJE
	 dk6bqpe0mrS4KhD33yalmHP8ZshnpYjIqP2YIt91JcAxlFKTQadyjGY6Ih+maWMw/2
	 odybOOktAjzeF3Te7tr8MY8p2AoNqezxbPoAIcQiLytLH3MppZMx9Ss64kn57QU5US
	 GQVEF6PPgXf/DcdXdBAloF7YwiNJh8NKmv+dB1ZRs3Qs4sQfZaHqN+1Cg2WAy3o5E4
	 vLkhhGZiikcTO9jxMbuxkw1c8a2MeywU/DHzv4Z+HL7/HJ+wg4o8wJOupVvpzcfqxA
	 uHrEGadi8NvxQ==
Date: Wed, 26 Aug 2026 08:20:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH v2] generic/798: chain xfs_io commands into a single
 invocation
Message-ID: <20260826152014.GT839663@frogsfrogsfrogs>
References: <20260824161518.GP839663@frogsfrogsfrogs>
 <20260826150118.177196-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826150118.177196-1-avinesh.kumar@suse.com>

On Wed, Aug 26, 2026 at 05:01:14PM +0200, Avinesh Kumar wrote:
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
>  tests/generic/798 | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/798 b/tests/generic/798
> index 0fe37646..171878ee 100755
> --- a/tests/generic/798
> +++ b/tests/generic/798
> @@ -27,12 +27,22 @@ for num_page in 1 2 4 8 16; do
>  	echo "=== Test with $num_page pages ==="
>  
>  	rm -f $SCRATCH_MNT/foobar
> -	$XFS_IO_PROG -f -c "pwrite -b $pagesize 0 $size" $SCRATCH_MNT/foobar > /dev/null
> -	# Basic cached number reporting
> -	$XFS_IO_PROG -c "cachestat 0 $size" $SCRATCH_MNT/foobar
>  
> -	# Test dirty page number reporting after a fsync.
> +	# Basic cached number reporting and test dirty page number
> +	# reporting after a fsync.
> +	#
> +	# Do the whole write+cachestat+fsync+cachestat sequence in a
> +	# single xfs_io invocation. Some filesystems (e.g. NFS) flush
> +	# dirty data back to the server as part of their own close()-time
> +	# cache consistency, which would clear the dirty bits before the
> +	# second xfs_io process ever got to run cachestat.
>  	$XFS_IO_PROG -c "fsync" -c "cachestat 0 $size" $SCRATCH_MNT/foobar
> +		$XFS_IO_PROG -f \

Not sure why there are two $XFS_IO_PROG invocations here??

Also the first line of the second invocation should only be indented one
tab, not two.

--D

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
