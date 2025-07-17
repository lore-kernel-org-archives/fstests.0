Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F411DA62E
	for <fstests@vger.kernel.org>; Thu, 17 Jul 2025 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770250; cv=none; b=YYjJywRWGFf9+h/UkQ36wJCPQ2+2jpCrEuGPCxv+EOFYa1SbASekpPq2kpXfE/LsCWuXWO6Sbegk8nVssDzqItF+hd+hi6q3BdQCfch/0hMsiq/amUm617FS3pPQQfC+WLE7nAv3VWvhKq3dyva9gn+6DaKDp4sEaQ876W3SC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770250; c=relaxed/simple;
	bh=Sv0kp1RGAq7ePz3BH6IJstsU+VxW+IurEAaom4MFlzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5h6hxY9kphtR9BXg+1+rp4y1Arre6uc44bV5NpuXS5olvzO12Ocqfs8RWAy4bZboRg7Vzi0n4Dg/ZVIspQn7t+j6CD4hS+ut6qKXzZtX+2kuDTnjejsQf+owTsBH0n0UcdgJ8Is7b6jdZUNHkHps24rEaUo38PA9iW9arSEu0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU9nlHB1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU9nlHB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B2C4CEE3;
	Thu, 17 Jul 2025 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752770249;
	bh=Sv0kp1RGAq7ePz3BH6IJstsU+VxW+IurEAaom4MFlzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oU9nlHB1LwhwVyFD/5JQ1nX5eTgOaFnIXs8eSSvPiUtv8DtI0ZZW8OQaBu+QhNSlH
	 8WbXvD/beBzMddhJuD/AqxZPLzDpYQYhXTN6RDINKkNOq08BSDTs22R8BLwcbEp1Yq
	 PT+R4fJhRDiX0LFpkqKRpllNw0uxFrxMFclo2Q8f4DuCu4uJmmHHeMB/+ojydbzkai
	 9lkAGyTgfEypTA3xoKOAD79ytl0hvkB45t7+weZF9yfc9A9D0RK59bu5vOZligrwpV
	 lFlywt764dGqBlRJ9Wwbd+l/Faj7PN3QU0/AQxDvy60aSddXkz34hdXD9Kiga1dzDF
	 Zcs0iLI/NWOqw==
Date: Thu, 17 Jul 2025 09:37:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/028: require that the scratch file system has the
 extent feature enabled
Message-ID: <20250717163729.GK2672039@frogsfrogsfrogs>
References: <20250714125154.50015-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714125154.50015-1-tytso@mit.edu>

On Mon, Jul 14, 2025 at 08:51:54AM -0400, Theodore Ts'o wrote:
> If the file system configuration has journalling enabled, but doesn't
> have the extent feature enabled (e.g., when testing the ext3
> configuration) the test will fail since _scratch_populate_cached
> creates files with extents enabled.  So add a check to skip the test
> in that case.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/ext4    | 23 +++++++++++++++++------
>  tests/ext4/028 |  1 +
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/common/ext4 b/common/ext4
> index f88fa5324..06191e304 100644
> --- a/common/ext4
> +++ b/common/ext4
> @@ -165,15 +165,26 @@ _ext4_mdrestore()
>  	return $res
>  }
>  
> -# this test requires the ext4 kernel support crc feature on scratch device
> +# this test requires the ext4 kernel supports a particular feature
> +# on the scratch device
>  #
> +_require_scratch_ext4_feature_enabled()
> +{
> +    if [ -z "$1" ]; then
> +        echo "Usage: _require_scratch_ext4_feature feature"
> +        _exit 1
> +    fi
> +    _scratch_mkfs_ext4 >/dev/null 2>&1
> +    dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -q "$1" || \

This would be a good time to convert this to call $DUMPE2FS_PROG instead
of dumpe2fs directly.

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +	_notrun "$1 not enabled by this filesystem"
> +    _try_scratch_mount >/dev/null 2>&1 \
> +	|| _notrun "Kernel doesn't support $1 feature"
> +    _scratch_unmount
> +}
> +
>  _require_scratch_ext4_crc()
>  {
> -	_scratch_mkfs_ext4 >/dev/null 2>&1
> -	dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -q metadata_csum || _notrun "metadata_csum not supported by this filesystem"
> -	_try_scratch_mount >/dev/null 2>&1 \
> -	   || _notrun "Kernel doesn't support metadata_csum feature"
> -	_scratch_unmount
> +    _require_scratch_ext4_feature_enabled "metadata_csum"
>  }
>  
>  # Check whether the specified feature whether it is supported by
> diff --git a/tests/ext4/028 b/tests/ext4/028
> index 1b8855098..254074f08 100755
> --- a/tests/ext4/028
> +++ b/tests/ext4/028
> @@ -24,6 +24,7 @@ _exclude_fs ext2
>  _exclude_fs ext3
>  
>  _require_scratch
> +_require_scratch_ext4_feature_enabled "extent"
>  _require_populate_commands
>  _require_xfs_io_command "fsmap"
>  
> -- 
> 2.47.2
> 
> 
