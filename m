Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF20390CA1
	for <fstests@vger.kernel.org>; Sat,  9 May 2026 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317826; cv=none; b=je3o9VelxYQJJpHWBAiQPfI2rIZLlWHtrpJy25m3cS+ElfV/bcciDt3xVZaeX5UXrO8uAyL9XCoJTfeLtxFxxSo07FxqMpTaiMn920LXxeGMsERGEH0CV2kBe/gVKp+H32BHco89cf/gRZBtmygjkr5TOS3QKk/wSr9XslHPNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317826; c=relaxed/simple;
	bh=KAVDtEOKLBGTMFS8HNfs1eVFcNllC/yLi2w4SNclnpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahi0BK6g+Kp6tVRK4V54FCW4s6S0m8hU2OACpEsOeEBDR+JndY3VmOf9PZ+X8bDazJwLdC59M2pcNRWfeX9GQWaxuAsN1ERfFZaBQI4XPgHJeT70bjKbJAU8K393l5e6UFnhL2Lpy+1knWYIGFDTAu+V+s6c3rG4pc6JYlGYsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+MFeKLz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+MFeKLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A139C2BCB4;
	Sat,  9 May 2026 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778317825;
	bh=KAVDtEOKLBGTMFS8HNfs1eVFcNllC/yLi2w4SNclnpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+MFeKLzyvVXWiIHFVVj3uQn7xKdzjJ3xMcX2u72rvy88idSbDoLZungyN6HLaGSH
	 zSt5Lk8iZYhyrfz9/q/GWj/Zi8XmusKmnfCS+Y5l5yVsaxRGH7figGCtFzmqwsQwSu
	 K9K/vkpvvKOcmFZIIg86ed0KoEJI/fyon+/ie3MEKjVMDMc7Ut+HSI1PQy9dnSEeCg
	 4oQbyryTPsntMw0d/CvPqMVlf/AwKzU9hU8BrwlKR0nEN5z6fo8oaeLOzw2207W4Pu
	 twRgis+cfSIt+rst4ZhNEqOSZLiMkzEE4bnQqctRK0Tt+3C+WGFe1zyc3N0GA/GU39
	 GxjWjXXnodzHw==
Date: Sat, 9 May 2026 17:10:21 +0800
From: Zorro Lang <zlang@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] overlay/080: cycle base fs in prepare_midlayer to
 exercise lazy verity load
Message-ID: <af741jzmhTYl0c5Y@zlang-mailbox>
Mail-Followup-To: Colin Walters <walters@verbum.org>, 
	fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
References: <97140e8a-541c-4e0a-accd-cf58dd1feae6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97140e8a-541c-4e0a-accd-cf58dd1feae6@app.fastmail.com>

On Fri, May 08, 2026 at 04:07:39PM -0400, Colin Walters wrote:
> This reproduces the regression reported at:
> https://github.com/bootc-dev/bootc/issues/2174
> 
> Assisted-by: OpenCode (Claude Sonnet 4.6)
> Signed-off-by: Colin Walters <walters@verbum.org>
> ---
>  tests/overlay/080 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/overlay/080 b/tests/overlay/080
> index ce5c2375..ede04dab 100755
> --- a/tests/overlay/080
> +++ b/tests/overlay/080
> @@ -21,6 +21,8 @@ _require_scratch_nocheck
>  _require_scratch_overlay_features redirect_dir metacopy
>  _require_scratch_overlay_lowerdata_layers
>  _require_scratch_overlay_verity
> +_fixed_by_kernel_commit 0c8c88b8eb82a2a41bec5f17c076d6312dc40316 \
                           ^^^^^^^^
A short id is enough, e.g. 0c8c88b8eb82 :)

> +    "ovl: fix verity lazy-load guard broken by fsverity_active() semantic change"
>  
>  # remove all files from previous tests
>  _scratch_mkfs
> @@ -222,6 +224,11 @@ prepare_midlayer()
>         echo -n "changed" > $lowerdir/$subdir$wrongverityname
>         _fsv_enable $lowerdir/$subdir$wrongverityname
>         echo "$lowerdata4" > $lowerdir/$subdir$missingverityname
> +
> +       # Cycle the base fs to evict cached inodes, so the overlay mount
> +       # that follows exercises the lazy verity load path from disk.
> +       _overlay_base_unmount "$OVL_BASE_SCRATCH_DEV" "$OVL_BASE_SCRATCH_MNT"
> +       _overlay_base_scratch_mount
>  }
>  
>  test_common()
> -- 
> 2.52.0
> 
> 
