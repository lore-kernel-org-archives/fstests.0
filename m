Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05E345EAC
	for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588120; cv=none; b=DQ0sc+4KG5qVUGR89M7UL8pzXy/bnMoDjearLYn5ObUdt+vs/EX+Ur3gf04nqYV60fNeYmLeICWulUUtO1RgV/BFdWZyGvT57MZfyKX01MO5lzFW7vFl0LGhi/grX5a71AjMAtQ0gpH+X8wtcnE9DfAzHEAe1EDny7a2DyUg8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588120; c=relaxed/simple;
	bh=JFQepdlNHiLp780wDWvkvPofDgSZV5NoDqkt/VFDwEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJT22nlC7kHdsm92MXuGqx/A4Nl+HcErQMw16sBVu3/PaigSl4oyDHZBRpN/5d9G8ynSQB2m3PJ3iLsPPu4VduPbnmwE8sjWf3t3wnd1ifIvE+GxTguHPbV7TPy71qO8r93X7Gkj8SYO5byoiu0RmazX9wJAGwWkPaFJV9CUPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J16fxAuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J16fxAuX"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 259811F000E9;
	Mon, 24 Aug 2026 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588119;
	bh=prJ2IAvoxixEb+84YyQiXgudv7tc8vGBGhhJ08umjJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J16fxAuXiqPPjG+djylJA2ABEFDfmcdzpCeEYLYT/Lbeb8EliTDDCPSYYjAo/HHCz
	 mAhreU8ahWFymiJ/8o8Krnxz6zjF5uD4QxCEe1z92vJ2i4abFrhsCRj1dDkleOKTgn
	 BAfH+bY9P9Wdr3rw7w1osT0DmnwYGjdnSzTNV4Ji3f5Vro269pgAb+/NWtHEHa64nV
	 zVaRyghIdnxeRV+T01LMVMgn5AJ850d+pHinocrmRX8HMdkx3awzLl0a6v9DWm/X02
	 EYijI3Q7wjlUyehvszkD4hd8qeNvOiOyE7+psaZRo+7byEB3PgiWovsUti7t3wyoU7
	 fijpXzhaPbKPA==
Date: Mon, 24 Aug 2026 09:15:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] generic/798: exclude nfs from cachestat dirty page
 reporting test
Message-ID: <20260824161518.GP839663@frogsfrogsfrogs>
References: <20260824151107.209027-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824151107.209027-1-avinesh.kumar@suse.com>

On Mon, Aug 24, 2026 at 05:11:06PM +0200, Avinesh Kumar wrote:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> generic/798 checks cachestat() page cache dirty state between write and
> fsync operations.
> 
> On NFS, the client flushes dirty pages to the server during close() to
> enforce its close-to-open consistency model. Because the test uses separate
> xfs_io invocations, the file is closed after writing, leaving pages already
> clean by the time the subsequent cachestat command executes, causing the
> test to fail.
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
> Exclude 'nfs' from running this test.
> 
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  tests/generic/798 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/generic/798 b/tests/generic/798
> index 0fe37646..80b2acc9 100755
> --- a/tests/generic/798
> +++ b/tests/generic/798
> @@ -16,6 +16,12 @@ _require_scratch
>  _exclude_scratch_mount_option "dax"
>  _exclude_scratch_mount_option "sync"
>  
> +# NFS flushes dirty data back to the server on close() as part of its
> +# close-to-open cache consistency model, so a page written and closed in
> +# one xfs_io invocation is no longer dirty by the time cachestat runs in
> +# a later invocation.
> +_exclude_fs nfs

Could you just chain all the xfs_io commands together into a single
invocation?

$XFS_IO_PROG -f \
	-c "pwrite -b $pagesize 0 $size" \
	-c "cachestat 0 $size" \
	-c "fsync" \
	-c "cachestat 0 $size" \
	$SCRATCH_MNT/foobar

to solve this problem?

--D

> +
>  pagesize=$(_get_page_size)
>  
>  _scratch_mkfs > /dev/null
> -- 
> 2.55.0
> 
> 
