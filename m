Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E04432E6F
	for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587900; cv=none; b=st2EZBb+S33w7wtJOsJmn8pzeeTDDmee7ycJCIz3TT5OoUrW8cSfuFJTsCOMauemHgIz1TK1sKq3oywFnLbILEmPyPBBqNtPL0jOuim4joJIf/tx6HgoqkR1z8FSUntBK0D9ikg4grw+MYIy7W0I25R4grv8p5aKQQF/VwIKap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587900; c=relaxed/simple;
	bh=aLozT1GjPH/7IKA7PU0NO0NIqXVGCgKkD5VHkRaJHRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzhtWotb0U3Fy6INqggVHBPQ3aoFTvrCBMF7iT9tx52ROyV1YfxKyVvvrbr+6FwISQdX3GtuHMUBsldNueph5oKS4prMS96ESO6LirvQm8QcumSaykxW58nQQ0rwOqgMHPhYCUwrA+E2Sf1RRFojIWljF9jOUMz4WyreaEpoPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HozDstaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HozDstaX"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 792851F000E9;
	Mon, 24 Aug 2026 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787587898;
	bh=utguozvcGrrJZAMEsDemkjQP75lCdbbYQGs1JUF0D/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HozDstaXqlhPr2NasFQWZc5Bg8dq+5Og0dWH7A/fg9fST+P+5eZ4WLJrO1MQxZdwh
	 6kIx/IbpTEPJdTdIOZZCI45BFPCfPv6Bm0XFeE84bWgRVcw2/R1P2GEgvT2kRi0oWm
	 PaGObZqddYsISK/Li43w9DeuT3eSPl5GSehAOShFqgRmHcdnvprw2ZuWM3YtO/6Bim
	 e1XKnz4cdPuSD2yTPu/OmnGswYeaV/HbHG1glVDLRkSsN6+ihqOIFEJkcRQfcNjkX/
	 aRoJlZ2ZaJYvq1yqqc7YwYLI7/9BWnDymLfTl2JvHF5Cat4g7c9/Ueh9wP1O5+JhS4
	 yGjTbtHYeSCwg==
Date: Mon, 24 Aug 2026 09:11:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Manognya Singuru <msinguru@redhat.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH] common/xfs: filter mkfs.xfs stripe geometry warning
Message-ID: <20260824161137.GO839663@frogsfrogsfrogs>
References: <20260824065604.43478-1-msinguru@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824065604.43478-1-msinguru@redhat.com>

On Mon, Aug 24, 2026 at 12:26:04PM +0530, Manognya Singuru wrote:
> mkfs.xfs prints a warning when creating small filesystems on devices
> that advertise stripe geometry:
> 
> mkfs.xfs: small data volume, ignoring data volume stripe unit XXX and
> stripe width XXX
> 
> This warning causes several XFS tests to fail their golden output
> comparison when SCRATCH_DEV has striped device geometry such as
> scsi_debug devices.
> 
> Filter the warning in _try_scratch_mkfs_xfs() instead of
> updating individual test expected outputs, as the filesystem is created
> successfully and the warning does not indicate a failure.
> 
> Signed-off-by: Manognya Singuru <msinguru@redhat.com>
> ---
> Tested with xfs/015, xfs/030, xfs/041, xfs/042, xfs/075, xfs/104,
> xfs/109, xfs/168 and xfs/177.
> 
> Output for xfs/030 before the filter:
> QA output created by 030
> ...
> +mkfs.xfs: small data volume, ignoring data volume stripe unit 64 and

How big is this volume?  I'm guessing less than a gigabyte or two?

> stripe width 64
> ...
> Ran: xfs/030
> Failures: xfs/030
> Failed 1 of 1 tests
> 
> Output for xfs/030 after adding the filter:
> xfs/030             15s
> Ran: xfs/030
> Passed all 1 tests
> 
>  common/xfs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/common/xfs b/common/xfs
> index 81add208..98981e62 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -157,7 +157,8 @@ _try_scratch_mkfs_xfs()
>  	local mkfs_cmd="`_scratch_mkfs_xfs_opts`"
>  	local mkfs_filter="sed -e '/less than device physical sector/d' \
>  			       -e '/switching to logical sector/d' \
> -			       -e '/Default configuration/d'"
> +			       -e '/Default configuration/d' \
> +			       -e '/small data volume, ignoring data volume stripe unit/d'"

But yeah, that's not output that we care about.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  	local tmp=`mktemp -u`
>  	local mkfs_status
>  
> -- 
> 2.54.0
> 
> 
