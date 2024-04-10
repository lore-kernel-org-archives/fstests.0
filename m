Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E751E878
	for <fstests@vger.kernel.org>; Wed, 10 Apr 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762887; cv=none; b=mncHy0K3DSGulBWPTsa764WhFRlvWXJj3T8kzXHh1h7PSAJlcITRxNEw8ZIbw4PVdyOJ4G0f2b4hkZLw+KsSliJbkP8TYLfIGS4zU3sUTzLUs+cExWooftwSr88U3R0Tw2SQMNB6D+G8Z1IW1fOJSi4EAJs9LGGmceYmno6PWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762887; c=relaxed/simple;
	bh=To3zXIJREVdt/ebhsX7OoeUFfKhlahN9poivbcLHcA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qORcfwoPbk8Vow/Pgp0EK9iO4ToxRFZTRsDT2oYNgxLzJ80EOWw+dwjWkUacgH5QSZ3Ep32ErmmZyi5s/oY1Du00ZyfTzEv3lK3ci8ZlWr8N5C95inmZoyqHcEQq5HkXowTgdQ0OOw4Ygdkk6N56lTONornUCjK6vIsfqdXxD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfNn7Tji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfNn7Tji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B7EC433C7;
	Wed, 10 Apr 2024 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712762887;
	bh=To3zXIJREVdt/ebhsX7OoeUFfKhlahN9poivbcLHcA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfNn7TjiT4XEv4D1XjsJ08lcC/EVVtXTfUDJT6/sX/FrHu/Gw/FYobhBU04l8I04V
	 ojyn46vjq73lq/Zy6lWh/V2Td9URT435t1T4J/LN4/ZRim7iMS/7+0Ffob6dg4izV9
	 A9+7Nr0jGuAWtonIuqXZqh8nSAzUs3iijDr1yckp+NlOIzDN3spY8pqkTmEU+12mTB
	 JsMTXR3d/nhQTZuimy5dUmYUjBss1VAamUBdFXiTID2hvtbittqRRc6N0RDNjKCGy9
	 Ra0/YXjZ8Hw6AaBpVJi3lz5JmLpqb6OW8vx2qvWnYqD5sW/1nmucSnq+ddbdgTu82o
	 fhFZDQxHNcGHA==
Date: Wed, 10 Apr 2024 08:28:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/027: use 300M FS to accommodate XFS limits
Message-ID: <20240410152806.GH634366@frogsfrogsfrogs>
References: <20240410070720.9035-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410070720.9035-1-ddiss@suse.de>

On Wed, Apr 10, 2024 at 05:07:20PM +1000, David Disseldorp wrote:
> As of xfsprogs commit 6e0ed3d1 ("mkfs: stop allowing tiny filesystems")
> attempts to create XFS filesystems sized under 300M fail.
> 
> Lacking MIN_FSSIZE configuration, failure of _scratch_mkfs_sized() in
> generic/027 doesn't halt the test, leading _scratch_mount() to mount any
> previously created (full-size) filesystem. As a result create_file()
> may loop near-endlessly awaiting ENOSPC.
> 
> Use a 300M sized filesystem to support XFS' limit, and explicitly check
> for _scratch_mkfs_sized() failure to avoid endless loops if the limit
> changes again in future.

Hmmm.  Does your test environment export (as in, the bash keyword)
TEST_DEV and TEST_DIR?  mkfs.xfs is supposed to detect fstests and allow
sub-300M filesystems for testing.

The detection breaks if TEST_{DEV,DIR} are set but not exported in the
config file; perhaps fstests ought to be exporting them like it does for
the <cough> other detection key.

--D

> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  tests/generic/027 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/027 b/tests/generic/027
> index 47f1981d..4f8cf6d8 100755
> --- a/tests/generic/027
> +++ b/tests/generic/027
> @@ -35,13 +35,14 @@ _require_scratch
>  
>  echo "Silence is golden"
>  
> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
> +_scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1 \
> +	|| _fail "_scratch_mkfs_sized failed"
>  _scratch_mount
>  
>  echo "Reserve 2M space" >>$seqres.full
>  $XFS_IO_PROG -f -c "pwrite 0 2m" $SCRATCH_MNT/testfile >>$seqres.full 2>&1
>  echo "Fulfill the fs" >>$seqres.full
> -$XFS_IO_PROG -f -c "pwrite 0 254m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
> +$XFS_IO_PROG -f -c "pwrite 0 298m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
>  echo "Remove reserved file" >>$seqres.full
>  rm -f $SCRATCH_MNT/testfile
>  
> -- 
> 2.35.3
> 
> 
