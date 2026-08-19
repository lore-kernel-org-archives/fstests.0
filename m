Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA83488766
	for <fstests@vger.kernel.org>; Wed, 19 Aug 2026 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156025; cv=none; b=aaLMQ1GvWIjXUl8ZniGcKKL5uQHsBW2NL4h2aqMoJyqFNBxX7+SK7akJ0st2k+J+4UjNHzVizZh3dBIORNe0qWTaa654RA9ZegRgQJYe7fkEGip29dpuVgAGCxRXFH7V7HorG2dDdWSP58OYyJFpdXYbWcIt7WNL/E6V9034+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156025; c=relaxed/simple;
	bh=veFquL2E5wotQAj7uaipYFu7n41SgpRfeVsnBTiTQeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOB6TL7/XfO6BZYuSdaVF1QNVnj0VssglX3hjxyOLBUqPNUiPI/tVutoK56MIUrHnUT7kVnexdmFsUDhDGOhaUbZIqUsyXhp2+4GloRd9qwYKXnBVoqxjc5EKE2g04LjT8QhNYlhlIyUe8ac3A8J+Gjs0KW791GulpmpA4kFNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSuchasl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSuchasl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4BE1F00A3A;
	Wed, 19 Aug 2026 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787156023;
	bh=8n9Bh7/PYzrrT113vUWy0D7OaCSNLEv0ewl8ALXrfss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jSuchaslO3XvW1sdLkM+WcL4ALP351Kan7xfKgmlrDYw25OwyzDffNxHRkRNC9TcI
	 pjFj3rFuqa72oLXgFHy6Aq4L6DAUYfW5SOQWUkkVQeSEH/1mkSLKKleEtoP1YwALep
	 +0gRzGJ35ylWYXxerw8BTG3DBjP/Fq4DScNcSTuGt5nhZ7HU0xPODpNtAD4lu/2y+m
	 CIDKDN4XYwSEDNop4f7qpPq+TLWZOhG2r0Ka2/Oh/vyd6AfqDg6bKsX/NeNYEkbuEy
	 NoLS/rS9/FouqTfHUhuZ4LoHg9BMLAEWgz/QBk7dpud6GjmkPXeRod+ecaKG3gmAme
	 jgYD/6i15jPOA==
Date: Thu, 20 Aug 2026 00:13:38 +0800
From: Zorro Lang <zlang@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] generic/800: TEST_DIR, not TEST_MNT
Message-ID: <aoXVhsgvbc_kCe1J@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, 
	fstests@vger.kernel.org, wqu@suse.com
References: <20260819152726.GA6060@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819152726.GA6060@frogsfrogsfrogs>

On Wed, Aug 19, 2026 at 08:27:26AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Fix this new test regression:
> 
>  --- /run/fstests/bin/tests/generic/800.out	2026-08-18 09:30:13.655513087 -0700
>  +++ /run/fstests/logs/generic/800.out.bad	2026-08-18 16:30:24.107110215 -0700
>  @@ -1,2 +1,4 @@
>   QA output created by 800
>  +/dio-read-source: Read-only file system

Thanks for catching this! My rootfs wasn't configured as read-only, so
I completely missed it.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  +dio read failed
>   Silence is golden
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/800 |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/800 b/tests/generic/800
> index 52a664a17e448b..b79c1a0c052876 100755
> --- a/tests/generic/800
> +++ b/tests/generic/800
> @@ -32,8 +32,8 @@ _cleanup()
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount
>  
> -# Create the 4MiB target file on TEST_MNT as the read source.
> -$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 4M" "$TEST_MNT/dio-read-source" >> $seqres.full
> +# Create the 4MiB target file on TEST_DIR as the read source.
> +$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 4M" "$TEST_DIR/dio-read-source" >> $seqres.full
>  
>  # Another 4MiB target file on SCRATCH_MNT as the mmap dest
>  $XFS_IO_PROG -f -c "pwrite 0 4M" "$SCRATCH_MNT/mmap-dest" >> $seqres.full
> @@ -42,7 +42,7 @@ read_workload()
>  {
>  	_register_cleanup "wait"
>  	while true; do
> -		$here/src/dio-read-into-mmap "$TEST_MNT/dio-read-source" \
> +		$here/src/dio-read-into-mmap "$TEST_DIR/dio-read-source" \
>  			"$SCRATCH_MNT/mmap-dest" &> /dev/null
>  		if [ $? -ne 0 ]; then
>  			echo "dio read failed"
