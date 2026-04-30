Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896DB428829
	for <fstests@vger.kernel.org>; Thu, 30 Apr 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567195; cv=none; b=goQv9MkdcpFfva3comWbU50C4cC7foNfhECBOPweg3/ecIQNMyFNDuD+DG+vWnAt6kfjcEFG3RqqUILUpK2Dr88TT+l7bv3TJSVVfxIe1txb4L7sBlr1hCq5uq5tVtegGm8G8yCS52FShSxnrss9Kye2nN0x+O2vBh9FI09OrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567195; c=relaxed/simple;
	bh=vVpkFJoRbh74VDuRV649+csq58sx7eSjH7KPJE3AOjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPCsF0NY7J+XQAsF1qVbQLZ9Q8DQfrQYTUIXfFQ5JhN5VGN8Iu4PWYmMGkBf/UkKvUjNMMnd2dtYwaQph+gzyFisaGE0pJe+z3AVjutoI/itPkWO+ZFMuw/xwdnK+C18oXa+xZi6AjSdPCKdtmkyC03jxjfS7c8EMPJsgCTUQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUcGZ5dC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUcGZ5dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B525C2BCB3;
	Thu, 30 Apr 2026 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567195;
	bh=vVpkFJoRbh74VDuRV649+csq58sx7eSjH7KPJE3AOjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUcGZ5dCurpcP3/X3zQWrnGwyYztbozTxMZsAal59dmG3NKIXD1g80nntOGnukunT
	 +p4g6V6VDMP/VcwzeEhR+zh5OK2djMK5vKvjIDLG7aLJSUrLJrN8O0JGpiIS5t+v94
	 V+FXlbs9uF7JQ490Vh4fKKzPVHfnEh6gHlNjrXWmw2Ah+EAwJ+MRMs7KIXV7WLF7Zi
	 qdi+1ib8MmSgWu2aAKP/8RE5Q6FlL8wM3JyAjemr0r+GVUgeYkJH772f0isHX7huAl
	 HV2IZ47245kGAIJy6o5oJXTXYEEf2dUvESz+8dOPPf3OlGASL26a0nivNJmsv81Uzy
	 WfpDwFvvi0sMA==
Date: Thu, 30 Apr 2026 09:39:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] common/xfs: helper function to check if -l/-d/-r
 concurrecy flags.
Message-ID: <20260430163954.GT7739@frogsfrogsfrogs>
References: <20260430131317.693845-2-lukas@herbolt.com>
 <20260430131317.693845-6-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430131317.693845-6-lukas@herbolt.com>

On Thu, Apr 30, 2026 at 03:13:18PM +0200, Lukas Herbolt wrote:
> Check if the requested flag is supported by the mkfs.xfs on scratch
> device.
> 
> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> ---
>  common/xfs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/xfs b/common/xfs
> index f7a6d2f2f03a..12cf6c273c53 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -2399,3 +2399,9 @@ _require_xfs_healer()
>  	_xfs_healer --supported "$@" &>/dev/null || \
>  		_notrun "health monitoring not supported on this kernel"
>  }
> +
> +# Check if -l/-d/-r concurrency is supported.
> +_scratch_mkfs_supports_concurrency()

This is specific to xfs, so I think the name should reflect that.

_scratch_mkfs_xfs_supports_concurrency

> +{
> +        _scratch_mkfs_xfs_supported $1 concurrency=0
> +}

As I noted downthread, -d and -l gained their concurrency= options in
the same release so we probably ought to do future fstests authors a
favor and note that in the comments or just do something dorky like:

_scratch_mkfs_xfs_supports_concurrency()
{
	local arg="${1:-d}"

	# -d and -l gained concurrency options at the same time
	test "$arg" = "-l" && arg="-d"

	_scratch_mkfs_xfs_supported "$arg" concurrency=0
}

--D

> -- 
> 2.53.0
> 
> 
