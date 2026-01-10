Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E621CC62
	for <fstests@vger.kernel.org>; Sat, 10 Jan 2026 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009083; cv=none; b=DR6UNIdJv3uUQlCHbMeQiZEFfSmzE802sGlKcN2AXjDifqqOTi11nCLBkm+Q9NNx4gwJI2zwnQPpgM64TBECP5nHbKGoJX+7V2QKBXEljLB+ntsRxElzlAi2e6CBlApIDNs8M5kjrkuymDA95SUizqMBR0qSA6H/UyrNcFjMnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009083; c=relaxed/simple;
	bh=1SLFpiBB9qlYA2B0NL1BDi/rggkL1u617yITITr0y8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZxeY/1TAtR6nvZ4/R4+6f49TgOEwZm46gj2isZD9M09ybaz3xLlOngtohtOZpvRjsW1Ha9vLgNuf+Y+dP2b+csgvKd9c+Kc4x3qy1rvg/CS0e6x2u9gShYITD2Mnm74jDK3O/fvH9JdgYldK4Q45wMw6DjAK1bzKoLPQt9RNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi1Verq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi1Verq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBECC4CEF1;
	Sat, 10 Jan 2026 01:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768009082;
	bh=1SLFpiBB9qlYA2B0NL1BDi/rggkL1u617yITITr0y8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oi1Verq7l28rgBZS0fdU8RQi8LroRuewJ7vxMwnvhk2UZTZIe+fjDgG4P030svuE1
	 +ps94EWb+TaZadLPigaYcvWLoOwMmHWhUbaDIrF+TVp7mjhGGgRCl96CANiWe8J+pn
	 V63rpkMTjPE8RFXGAEexcPft44JIWW0UEkoo8jG6QMXtJ9U4sxsHsQqZSY2mDlhM15
	 CweqTULTjSOyIf++GSCM0JRQRcV1C1/LgmFa4soUSr1wWwyNeVX8mlq59YfcM9CcOF
	 YroYxBdYyLJsnM3Feetuomr/L8+a2+qLvw8UqVKi2YscCm0gRxzECZnVUQAvz8RhRg
	 GAbsR4KIlJU+g==
Date: Fri, 9 Jan 2026 17:38:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Chang <joannechien@google.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3] common/rc: add _require_blocks_in_file helper
Message-ID: <20260110013802.GB15541@frogsfrogsfrogs>
References: <20260108022501.754320-1-joannechien@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108022501.754320-1-joannechien@google.com>

On Thu, Jan 08, 2026 at 02:25:01AM +0000, Joanne Chang wrote:
> generic/735 attempts to create a file with nearly 2^32 blocks. However,
> some filesystems have a maximum file block limit below this threshold.
> For instance, F2FS is limited to approximately 2^30 blocks due to the
> capacity of the inode. So add _require_blocks_in_file helper to skip the
> test in such cases.
> 
> The helper uses a hardcoded constant instead of a programmatic method,
> so that bugs which affect the maximum file size are not masked.

Not to mention trying to create a file with 1,057,053,439 blocks
allocated to it would probably take forever.

Hang on, we're talking about iblocks (aka the number of blocks allocated
to this inode), not the maximum file size in blocks, right?

If so, then maybe this function and its comments should
s/blocks/iblocks/?  Or am I confused? ;)

--D

> Signed-off-by: Joanne Chang <joannechien@google.com>
> ---
> v2 -> v3: 
> - added explanation for using constants to commit message
> 
> v1 -> v2:
> - changed title from "generic/735: disable for f2fs"
> - used a new helper function instead of _exclude_fs as Christoph Hellwig
>   suggested
> 
>  common/rc         | 16 ++++++++++++++++
>  tests/generic/735 |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index c3cdc220..e92f4854 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6120,6 +6120,22 @@ _require_file_attr_special()
>  	fi
>  }
>  
> +# Require filesystem to accomodate enough blocks in a file
> +_require_blocks_in_file()
> +{
> +	local blocks=$1
> +
> +	case $FSTYP in
> +	f2fs)
> +		if [ $blocks -gt 1057053439 ]; then
> +			_notrun "$blocks blocks per file not supported on $FSTYP"
> +		fi
> +		;;
> +	*)
> +		;;
> +	esac
> +}
> +
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/generic/735 b/tests/generic/735
> index 9bbdf3a1..2fbf125c 100755
> --- a/tests/generic/735
> +++ b/tests/generic/735
> @@ -22,6 +22,7 @@ fi
>  _require_odirect
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "finsert"
> +_require_blocks_in_file $(( (1 << 32) - 1 ))
>  
>  dev_size=$((80 * 1024 * 1024))
>  _scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
> -- 
> 2.52.0.351.gbe84eed79e-goog
> 
> 
