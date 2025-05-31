Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C032101F2
	for <fstests@vger.kernel.org>; Sat, 31 May 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748697907; cv=none; b=lVZzrvF6uLubWAE154qm2nX+3BGCoyYttQ/NQMsg4mtooQXoEZNIG24vNnR4rEsKv4kPMiKPrs+kJmcQxQc2vcKseZJ+FOtSDR3Kqoci5ZgCRmZPqbeWVHWYVwDIPQpTbpR3kKlUopb9jTi8CgfsZc4Xp81KfwQbuhi4+TmgJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748697907; c=relaxed/simple;
	bh=KLxzVs/0Dfk1TPO+Nwv1sgN1ufwjrBvmhNVvF1S/XpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI5J2HqZz/1QawRnonjIn/GJ+mnrZlyKj3rk9ugyDvDeD2tbA8atraST4FWEIyrMNXIpQ4D48h7grti0J4GGQWoUtLM7ApZjsQkTPFFODYVRdr6QMb39Qz1s0omznKdImgiA84Mfgr75ARBTBLJPY58OWAuMfTTKLg7kbTMZpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXS0NBGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXS0NBGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6072C4CEE3;
	Sat, 31 May 2025 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748697906;
	bh=KLxzVs/0Dfk1TPO+Nwv1sgN1ufwjrBvmhNVvF1S/XpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXS0NBGPq5m/YhClcSH5Uc9pkSYSV21KhTcYptNrjFza52G9fLtaiD0nHfIsfjNnW
	 pmpZ/ma4QQaKjMNompuWxIASQ9FOGo0Uoa+Gj3kF/H9bt0aofsXz1EzaKF3jp1qoQQ
	 4LKnX3wZ9fovwft+xsnjjRVbm0W4lNcfYK2qc9F04xy/o6pVaMG1OBXloR5F9mdjPK
	 wmaVwkoBlFUrNl09IRblBvZuRbk2c2CFFgZy8KAK3jiCdCqkRXkFrfCMbOyPLuSjEg
	 EKNbHZTI/7rtIZc4nBhSVaLtWNSGDLsUOBO5Qng1Xb92h+n1FOMI5WQzKp0mgsH/us
	 r0Lg79PMgNl0A==
Date: Sat, 31 May 2025 21:25:02 +0800
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: Re: [PATCH] common/rc: _add_dmesg_filter returns when RESULT_DIR is
 null
Message-ID: <20250531132502.thfvgjfiz6gia5as@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250318132459.152699-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318132459.152699-1-zlang@kernel.org>

On Tue, Mar 18, 2025 at 09:24:59PM +0800, Zorro Lang wrote:
> I always hit below error on a system with readonly rootfs:
> 
>   ++ _xfs_prepare_for_eio_shutdown /dev/loop0
>   ...
>   ++ _add_dmesg_filter 'Internal error'
>   ++ local 'regexp=Internal error'
>   ++ local filter_file=/dmesg_filter
>   ++ '[' '!' -e /dmesg_filter ']'
>   ++ echo 'Internal error'
>   ./common/rc: line 4716: /dmesg_filter: Read-only file system
> 
> The RESULT_DIR is null, due to xfstests/check calls _test_mount and
> _scratch_mount before RESULT_DIR creation. And _test_mount does
> _prepare_for_eio_shutdown -> _xfs_prepare_for_eio_shutdown ->
> _add_dmesg_filter "Internal error" when RESULT_DIR is null.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---

ping, any review points about this patch?

Thanks,
Zorro

>  common/rc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index e51686389..01e89747d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4716,6 +4716,12 @@ _check_dmesg_filter()
>  # Add a simple expression to the default dmesg filter
>  _add_dmesg_filter()
>  {
> +	# This function might be called before having RESULT_DIR, do nothing
> +	# if RESULT_DIR isn't created
> +	if [ ! -d "${RESULT_DIR}" ];then
> +		return 1
> +	fi
> +
>  	local regexp="$1"
>  	local filter_file="${RESULT_DIR}/dmesg_filter"
>  
> -- 
> 2.47.1
> 
> 
