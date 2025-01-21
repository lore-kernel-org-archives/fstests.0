Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035381F1505
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475171; cv=none; b=stZLJ+ilTjYMa4d3GsbOj/z6vbY+CeNe6mcb+6zCz7CXMvT6k5EnluSodOjMHCguMPSLsW+PvIa2wmXSa4uAgHRLuzreKsLKn882V30ZsLz8A0YE2qR82WYozbu9xMjYH+MjimJMKaJ56iONzt0Lf7h3oqtFXMpWF6qmjBeKiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475171; c=relaxed/simple;
	bh=E9GNuaKEvtZXNPBgPvlq89mvF60p8ikZoa1jVNehL34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPLvlHt+2Nf78WU0qmGkTaTM0JdQG/GvZV+0qZ2znyAu+MGA/eHspLX+2ZoKimjaE9jJBWZS7DQaTq+mUQ7cNF9kmbGJFqPhJuLu7SXLxbDNaEGP6yD6AHLMyb2bDVl7mB12RTMy3SOI98+6V96BPMWXX8CjlFveSg2rfnFcWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbZqgyoU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbZqgyoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645EAC4CEE0;
	Tue, 21 Jan 2025 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737475170;
	bh=E9GNuaKEvtZXNPBgPvlq89mvF60p8ikZoa1jVNehL34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbZqgyoUt3zsu2onkYNJf2BvBb6qKoDHbI1GOIjVyq41mc+vCNNjDvyYTOIJP2qaw
	 ut/6jrtxnMcvTdO3k6aiYluygnQl7WukLBoJ3dt4+ZHN0KafVIu2P7B+sgWEguhSiY
	 xI1vAMNEzDIOHTeDZRzkMRSNxtjS95ZTBeraOR5XF6IBgp7zk6uWnCj3ZBtf0tXrm+
	 Up0mHDBR5PuJpUBDg4TN3Sbi6x4GYA724uVVlCZNOEiT41N1SxT17pT+LUIlcsxSYK
	 eGVk88GsBNuv4mhc3bCZIH9c9deb6Rnwx+sYuCOjEN5AWNRXLP2J2uZXJfoqS/92qf
	 d4zrsHH75wUJg==
Date: Tue, 21 Jan 2025 07:59:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH -v2] xfs/32: fix test failure on kernels which don't
 support bs > ps
Message-ID: <20250121155929.GM3557695@frogsfrogsfrogs>
References: <20250117210202.GJ3557695@frogsfrogsfrogs>
 <20250120170109.3770633-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120170109.3770633-1-tytso@mit.edu>

On Mon, Jan 20, 2025 at 12:01:09PM -0500, Theodore Ts'o wrote:
> When trying to mount a file system with a block size > page size on
> kernel which doesn't support this, suppress the error messages from
> showing up in the output file lest it cause test failures.
> 
> Fixes: 0b66f6efd669 ("xfs/032: try running on blocksize > pagesize filesystems")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> v2:
>     As Darrick suggested redirect the output of mount(8) to $seqres.full
>     instead of /dev/null
> 
>  tests/xfs/032 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/032 b/tests/xfs/032
> index 41a9134d8..675881d5b 100755
> --- a/tests/xfs/032
> +++ b/tests/xfs/032
> @@ -44,7 +44,7 @@ for ((; SECTORSIZE <= 65536; SECTORSIZE *= 2)); do
>  		if [ $? -ne 0 ]; then
>  			continue
>  		fi
> -		if ! _try_scratch_mount; then
> +		if ! _try_scratch_mount >> $seqres.full 2>&1 ; then
>  			if [ $BLOCKSIZE -le $PAGESIZE ]; then
>  				_fail "mount $(_scratch_mount_options $*) failed"
>  			fi
> -- 
> 2.45.2
> 
> 
