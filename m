Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55D33CE85
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989409; cv=none; b=Pw5nju2tLER/bTs9WwSPIljLW1cVCKrw/h6U98VDecx0J+UKRN0DKdMfFOllALQpuJBw0PveevJEZVyGk9zNxFu0R7yIbb5orPkpg+twRc5Y+ysApSLc7sDn4i6m14JVfVP/4Q88YKPqh1qloUrcYy/ieyDyZ/GdKjt5gVuoKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989409; c=relaxed/simple;
	bh=5+5GvQsF5aSghxZBfkZSeckEzlVRkv5HVlXbXvKtFDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z75gwROhAo4yidEKH0Fzj8RT1MEa1l5dIuzlZqKjwAjN3CIqPcrKU1rNI2xxgmr0qqWLdMXwEvbe8RAfzI0IZgQmNBl1NAB3StK6TDBtml2yB8lTCjX6ZH4PlpphmCyMUYzRkxO+RGHuBp4Qa5XysBzxW2jfBc9z6+r8Tr3vcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTahcYfW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTahcYfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E808C4CEF5;
	Wed, 17 Dec 2025 16:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765989407;
	bh=5+5GvQsF5aSghxZBfkZSeckEzlVRkv5HVlXbXvKtFDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTahcYfWkY3DnSAP9KKRQF47L3s8HWmag2Wx3lRNj+U9VhpzVjBZ8Te+5ymMYkhnX
	 fk5ufrhTISV5h8BzVu9faAFRlvyLpCCDpijFpVIF+63OKynNZhPn3zA7le7FV66YOn
	 9wYWjcTMIoi3N8fUpqlO3d0bADmwK0WVeAUV7ZX6wfttduclbXX4XSYJ71BdRlQACz
	 9bwpFdvcuRondGyioGMdKxdpMl+DfoZ5J//y3j8Umj5AkKb1Xq73XmCZWwyLMPjdFE
	 YyjZGsTeUBVpqEDAszX0YQhmt9PVjU7MEjXQz6+bFr7ipjd0ACua8mIUXRX9zaj2DK
	 ZWBBKslyl6p5Q==
Date: Wed, 17 Dec 2025 08:36:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/490: fix failure due to deprecated ikeep mount option
Message-ID: <20251217163646.GJ7716@frogsfrogsfrogs>
References: <20251217110819.150741-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217110819.150741-1-ailiop@suse.com>

On Wed, Dec 17, 2025 at 12:08:19PM +0100, Anthony Iliopoulos wrote:
> The ikeep mount option has been deprecated as of kernel commit
> b9a176e54162 ("xfs: remove deprecated mount options"), and after commit
> 3e7ec343f066 ("xfs: loudly complain about defunct mount options") there
> is a warning emitted when testing v5 filesystems.
> 
> Fix it by explicitly requiring and formatting scratch to nocrc/v4, as
> the test cannot otherwise be triggered on v5 without the ikeep option.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

<nod> sorry I missed this one, I only test with XFS_DEBUG=y
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/490 | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/xfs/490 b/tests/xfs/490
> index a3b0747580ea..366acbfa3ef9 100755
> --- a/tests/xfs/490
> +++ b/tests/xfs/490
> @@ -20,6 +20,7 @@ _begin_fstest auto quick
>  # Modify as appropriate.
>  _require_scratch_nocheck
>  _require_xfs_mkfs_finobt
> +_require_xfs_nocrc
>  
>  # Skip the verifier "xfs_check_agi_freecount()" which verify the number of free
>  # inodes in the AGI is correct, when XFS_DEBUG is enabled
> @@ -35,16 +36,7 @@ filter_dmesg()
>  # If enable free inode B+tree, this case will fail on xfs_dialloc_ag_update_inobt,
>  # that's not what we want to test. Due to finobt feature is not necessary for this
>  # test, so disable it directly.
> -_scratch_mkfs_xfs -m finobt=0 | _filter_mkfs 2>$tmp.mkfs >> $seqres.full
> -
> -# On V5 filesystem, this case can't trigger bug because it doesn't read inodes
> -# we are allocating from disk - it simply overwrites them with new inode
> -# information. So use ikeep mount option to stop that.
> -source $tmp.mkfs
> -mount_opt=""
> -if [ $_fs_has_crcs -eq 1 ]; then
> -	mount_opt="-o ikeep"
> -fi
> +_scratch_mkfs_xfs -m crc=0,finobt=0 | _filter_mkfs 2>$tmp.mkfs >> $seqres.full
>  
>  blksz=$(_scratch_xfs_get_sb_field blocksize)
>  agcount=$(_scratch_xfs_get_sb_field agcount)
> -- 
> 2.52.0
> 
> 
