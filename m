Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC73E3171
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839882; cv=none; b=usrtGl4J1IpvR+DRe9rd8Pi0F6gPK5UtZsnknbrz+Hmql+KDd/T5ziFtp7S/iXY/ekRxSsSFUYpckdA+eKkwiyDy4EknjdTs+plibcDF2lrtbRvQSrcLgrUMy1TW9KRVLG9gEeQf+bpLEBrhwwzOuVizmAXGWeegIitynLYrxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839882; c=relaxed/simple;
	bh=Pb4uwoRmsdLKFyuYvqAJgEMxs8F2AYw9aluPcVcxO5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT0ndBWaMc+44tAuH6LEqHw/nedrP7eHPVrhEbVGDtbepG6/BpdnReCRXrl/WSw9XD+wpWk4lDAm7NSWynsbYZBjQKzENEYJ0sXvHQQB5yvWcMisNSJ664e93AKumxfyiuymnsjKTdVoYpCrd+8QaW2dQ2kWnseiXFIdyrQBmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFQA5SXP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFQA5SXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CD2C19421;
	Fri, 10 Apr 2026 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775839882;
	bh=Pb4uwoRmsdLKFyuYvqAJgEMxs8F2AYw9aluPcVcxO5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFQA5SXP10jDC+6l7xzXD3i1gbAEeA4+PYphogveqZsHK3raiXPIDvfFoUltQciNE
	 1d8lqQ4pv3MN8iD+sgUsNiB0de4Isklkuo+bQQFHSpxVXwx7IA3Q6TdCLkBF8rmxRV
	 eedQeufHM3jemQ+N3VONxMgzTVbxbZX72jhXcVtRS5orv/NWqfyiThmLTcWQ51VZJa
	 Z4GEXYRRGH17sBIzU3Sh0ypkxJSqimUmpn0xtn0Rkq6GVfiaj/3vtaO8YkJevVMtlB
	 +mFo/1GJF6bYsKTUqKtcsoRYdYN0kz/F4oGq613pMAeL6Zbsza9K3eowNlDa2xjZHp
	 c87Z8mKElfTvw==
Date: Fri, 10 Apr 2026 09:51:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	fdmanana@suse.com, ritesh.list@gmail.com, naohiro.aota@wdc.com,
	wqu@suse.com, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 5/6] generic/775: Fix an infinite loop due to variable
 name clash
Message-ID: <20260410165121.GS6212@frogsfrogsfrogs>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <9c8783dc648ef861f81cba8d5d692932b795e262.1775802601.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8783dc648ef861f81cba8d5d692932b795e262.1775802601.git.ojaswin@linux.ibm.com>

On Fri, Apr 10, 2026 at 12:06:05PM +0530, Ojaswin Mujoo wrote:
> We use i as the iteration variable in the main test loop as well as some
> internal loops. Due to this clash, $i variable of main test loops was
> getting modified by the following loop in prep_mixed_mapping().
> 
> 	for ((i=0; i<num_blocks; i++)); do
> 
> If num_blocks is less than 10 (example ext4 with blocksize 4k and
> cluster size 8k) i would always be set as 3 and the main loop would
> never exit. Use local variable to fix this and while we are at it,
> rename it for clarity.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/775 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/775 b/tests/generic/775
> index 2a4287bb..6dc005a0 100755
> --- a/tests/generic/775
> +++ b/tests/generic/775
> @@ -41,7 +41,8 @@ prep_mixed_mapping() {
>  
>  	local operations=("W" "H" "U")
>  	local num_blocks=$((awu_max / blksz))
> -	for ((i=0; i<num_blocks; i++)); do
> +	local blkno
> +	for ((blkno=0; blkno<num_blocks; blkno++)); do
>  		local index=$((RANDOM % ${#operations[@]}))
>  		local map="${operations[$index]}"
>  		local mapping="${mapping}${map}"
> -- 
> 2.53.0
> 
> 
