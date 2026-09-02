Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCC456E15
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368757; cv=none; b=DzQFQkeAjaOdRHlYejYBB+vMS9XisSTxOIfN9yoEoqt0ZSvyma0+aiWAdhXdAi9SycqgRZBm1d+LLQdsoQdhNpajI8RHfwdRdkRM0ELMG/0WyhPiyKB+ONaS0grPRU2aAYRJr5me9ztXdRvOy7v/OpzwEierUxzIcP0LQD3nOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368757; c=relaxed/simple;
	bh=R2wGDfsIZVMFksIgFh3GAQjQyYN2OZ4kcJU2Bx7m6rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaSsYfbkgUrkirDGfBXGV3hd+p53Za8HMJTwIYVx4L9jGIZFRlyz6v1yiy3jmJ8OzjssraR3sRv2HVDGu2bfEy3AlJDupy9YYmEbZbWDE8VxDCYMmhFhwRjZqhJF4s4WOzemBUDwYrJIgxrVw0YDRox/pH4n3N94tYrGLUetsYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7F2joVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7F2joVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF81F000E9;
	Wed,  2 Sep 2026 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788368756;
	bh=UkkIJXmm06Q530gnh7GO6HjRrvmtv8fJgdeibS3GebU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A7F2joVxCJ43LB4CVuDnYaREbD1f9Vtnr6zpD3bGGqNfhTk/y9WEVX4pWwk6mygQP
	 cxqETcgsLXlSvswvGYpdNEj7lbNI6R7v4pjVttcxaAsq0jS+ktqLrDVaSvZ6HoAGtH
	 0tEN5k93HlGoPtet0a8tRnMLtYf7/iyE2cv2ny9jKVhRf9EsEj1ZkFLCrpt6ovSKs1
	 WiG2gpwdVv66ShDTEVDcX3OfsjCLaxWHon7kCSReUFma8h+XYqEMfL0ZHMwspYjsN5
	 6thlvpKTVSaq6k8wnYeBdsUdOaGDfPPMyB/5ZU+jGXmYWOE0eDALFN26xsnZL3oZbh
	 1328hSHeB6Vew==
Date: Thu, 3 Sep 2026 01:05:49 +0800
From: Zorro Lang <zlang@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs/015,016: add missing _require_scratch checks
Message-ID: <aphWZOOQLPoN6L1K@zlang-mailbox>
Mail-Followup-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, 
	fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260902050133.2413-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902050133.2413-1-prabhakar.pujeri@dell.com>

Oh, there's one more "add _require_scratch" related patch :)

On Wed, Sep 02, 2026 at 05:01:33AM +0000, Prabhakar Pujeri wrote:
> Both tests run _scratch_mkfs in a loop without first requiring a scratch device, so they fail messily instead of skipping when no scratch device is configured.

This line is too long. I can help to change that when I merge it.
Or *if you have more* similar patches, I can wait for your next
combined patch or patchset.

Reviewed-by: Zorro Lang <zlang@kernel.org>

> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---
>  tests/f2fs/015 | 1 +
>  tests/f2fs/016 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/f2fs/015 b/tests/f2fs/015
> index 54cada4a..75ae91f2 100755
> --- a/tests/f2fs/015
> +++ b/tests/f2fs/015
> @@ -12,6 +12,7 @@ _begin_fstest auto quick mount
>  _require_kernel_config CONFIG_F2FS_FS_XATTR
>  _require_kernel_config CONFIG_F2FS_FS_POSIX_ACL
>  _require_kernel_config CONFIG_F2FS_FAULT_INJECTION
> +_require_scratch
>  
>  options=(
>  #	mount_option			mkfs_option
> diff --git a/tests/f2fs/016 b/tests/f2fs/016
> index a6df827d..e0857e0a 100755
> --- a/tests/f2fs/016
> +++ b/tests/f2fs/016
> @@ -15,6 +15,7 @@ _require_kernel_config CONFIG_F2FS_FS_LZORLE
>  _require_kernel_config CONFIG_F2FS_FS_LZ4
>  _require_kernel_config CONFIG_F2FS_FS_LZ4HC
>  _require_kernel_config CONFIG_F2FS_FS_ZSTD
> +_require_scratch
>  
>  options=(
>  #	mount_option			mkfs_option
> -- 
> 2.55.0
> 
