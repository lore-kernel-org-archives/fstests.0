Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5E3D9674
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366568; cv=none; b=REK0jGOVDgKzIO87pBbAquIr2gUqCvcaUozvv53XcLW5ZrcXepSlQX2ipLfsmWLbb6BrL7Lz0F/8ae21NVhuYbDAdNEH25llAvuu+UJaW/e8Zt8ocrurcG85djFHji7g7V9hyXw/7+EdR7+E01THs7EtVtGw7fYqujn6w6B5R4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366568; c=relaxed/simple;
	bh=edBlUGKgs6shYelRBry5Ymu9ZoFMwINhDJK/EQA8KWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9eGSC/e4EI9JSMgohUBNlW1pMEE2FL+ZVKHtp29gF7hcznm6UtSgHk4fipID1rkQZ/2HAiAg9MSixmx0ZKJw044PdWPi0aFwa0aBit6+xzlLqMWk+CU2iCF7GtiZPPogMLCU+EHZF2N6I1O31W1MUtniJhNCxi3XJM7AG4+Gp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQtSRN/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQtSRN/6"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1469C1F000FF;
	Fri, 25 Sep 2026 20:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366566;
	bh=CgMVsynJKnYxylOMmkXUrsMrriWYqw4opTvTGsvb780=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SQtSRN/69MqwVQ+0dZ0Kd1LAIMtLzh0uok07O5hi41TZod+X7J6G+plYCtAVzw/kq
	 Y8QVId265rN3Wbq0kEYMj8dtwSlE1eWLN74pknk7TLvjkAkxeuOkgXOQb1ms6m3uEU
	 XI636duQxLQfrWP45OtExT5SDpLnFlsZ9Z/u0uaxKExl5eXbiRYeuquluOrHbOlf9d
	 WFwEqo99GIFQ7NkBqJAegH3QelmjK44Wm82hqnVnIX72mTEuDFTwECIvl6L5zhwrUC
	 JBZkJAKoAVPDW8voOcVMoJKcpkmkeqkj9F0cuPWZr9jEEUonUIWEZoVK38RSBjFkAW
	 98E2PUnBfhOyA==
Date: Fri, 25 Sep 2026 13:02:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH v3 3/4] generic/452: make coping work with multi-call
 binary
Message-ID: <20260925200245.GL6253@frogsfrogsfrogs>
References: <20260925104514.664260-1-aalbersh@kernel.org>
 <20260925104514.664260-4-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925104514.664260-4-aalbersh@kernel.org>

On Fri, Sep 25, 2026 at 12:45:11PM +0200, Andrey Albershteyn wrote:
> On some system coreutils binaries are all symlink to the single
> coreutils binary. Just copying 'ls' will not work in this setup,
> especially, with the different binary name.
> 
> Add 'realpath' to find out the real binary is make it behave like an
> 'ls' by renaming it to 'ls'.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Seems fine to me, though I wonder if we should change this to copy
/bin/echo instead of ls so that the output is more stable...

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/452     | 7 +++++--
>  tests/generic/452.out | 4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/452 b/tests/generic/452
> index a19a79623489..604d978cd98c 100755
> --- a/tests/generic/452
> +++ b/tests/generic/452
> @@ -24,8 +24,11 @@ _exclude_scratch_mount_option "noexec"
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
>  
> -LS="$(type -P ls)"
> -SCRATCH_LS=$SCRATCH_MNT/ls_on_scratch
> +# Resolve full absolute path to the ls binary. This is necessary for multi-call
> +# binaries. In multi-call binary setup "ls" is just a symlink to a binary (e.g.
> +# coreutils) which behaves as "ls" based on the executable name (first arg $0).
> +LS="$(realpath $(type -P ls))"
> +SCRATCH_LS=$SCRATCH_MNT/ls
>  cp $LS $SCRATCH_LS
>  
>  $SCRATCH_LS $SCRATCH_LS | _filter_scratch
> diff --git a/tests/generic/452.out b/tests/generic/452.out
> index 1d24d6b3c83a..436a01e13b09 100644
> --- a/tests/generic/452.out
> +++ b/tests/generic/452.out
> @@ -1,3 +1,3 @@
>  QA output created by 452
> -SCRATCH_MNT/ls_on_scratch
> -SCRATCH_MNT/ls_on_scratch
> +SCRATCH_MNT/ls
> +SCRATCH_MNT/ls
> -- 
> 2.54.0
> 
> 
