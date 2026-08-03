Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD03ACA6C
	for <fstests@vger.kernel.org>; Mon,  3 Aug 2026 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785745642; cv=none; b=i+S61bJtu2P/15alTeq5jOiTEFOxgT6hV0VB8GnC+pTXVI0UwYVpYXFQs7vRqqjaq29dSCDPu62iESLMxbBS1Ga7xuOAoDVA7eXBQzmXDsLrFzNmQhCmw8m3AZp2V14ZZf97nhTEeReW/3v/oO8Us7Fo60ktIuAMoNblEo7ICn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785745642; c=relaxed/simple;
	bh=WMVirjFkWmW4Qok8Jujgl7ZismtwxK8kRGzKeEB8Mzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+NND8JkwDiffSnlSRhBpYgJiJ6d9kdFmkUolKOc1pKZ7VopyaoMNvtN6XYoK3Qv5MPYA2E/qfIshtyuNrcAxy8e2NXb1gdwvSsqIA0lv/RQnvOY11er/9a1egFwZ7p+HZ54AX7wb2yvy1KWO4N25nHQ2S7UtCUvri/21mCV2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FviHU7ce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FviHU7ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659D01F000E9;
	Mon,  3 Aug 2026 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785745640;
	bh=HNTSPN2MiljhBeUFb+aT2w264xnKeHouhX6mZYMreBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FviHU7ceWWM2pmB3/Oav7pd723fLeRscnSqy7H4C4a/kqiPfMEmMGgihlevcklHU6
	 SNq7VZSdwzK93DIVqrTdwmUdFdimeGe/Eq6UE/98iB4GnmkNqjUl2TAzUTVgKZEiOX
	 0fAAY7RwKoQSXNOFuTHX6JkcKFkLHlSVaWq2mOqGi2uDchBsM8sLyHLUc/+9QC0btg
	 L99eUnqjE4HMwHnD1Ztat8X3xCSma+f6nYKDNyqRBV/PCL/TdcwfKDha5ml2sSb0NP
	 SiSAV5nsDINBy/TuPrPmE9ymMRY9fzVsQrM6CDcpWPREBGdkjOec28W9eOBvBVq6QG
	 QjnNjZCJc9Vlg==
Date: Mon, 3 Aug 2026 16:27:15 +0800
From: Zorro Lang <zlang@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/347: Fix sporadic test failures
Message-ID: <anBNLS4JmtT8GHGu@zlang-mailbox>
Mail-Followup-To: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
References: <20260730151817.4120874-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730151817.4120874-1-jack@suse.cz>

On Thu, Jul 30, 2026 at 05:18:17PM +0200, Jan Kara wrote:
> generic/347 was occasionally failing on ext4 in our QA due to ext4
> aborting its journal when the filesystem on thinp device was overfilled.
> I have tracked the problem down to journal checkpointing failing to
> write a metadata block to its final location due to ENOSPC failure from
> the thinp device. Modify the test to first preallocate blocks for the
> files and remount the filesystem which practically makes sure all
> involved metadata blocks were written and so their further modifications
> will not fail.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  tests/generic/347 | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/347 b/tests/generic/347
> index 06df0cf9eddc..56538c160392 100755
> --- a/tests/generic/347
> +++ b/tests/generic/347
> @@ -38,7 +38,17 @@ _setup_thin()
>  
>  _workout()
>  {
> -	# Overfill it by a bit
> +	# Preallocate space to avoid failure for metadata writeback
> +	for I in `seq 1 500`; do
> +		$XFS_IO_PROG -f -c "falloc 0 1M" $SCRATCH_MNT/file$I &>/dev/null

Hi Jan,

Thanks for this fix! Adding fallocate introduces an extra dependency via
_require_xfs_io_command "falloc", which will limit some filesystems can
run this test.

Additionally, since the underlying storage is a thinp device, I doubt
`falloc 0 1M` actually triggers physical block allocation on the thin
pool (correct me if I'm wrong). If so, I suspect this 1M * 500 preallocation
might exhaust the 500M BACKING_SIZE prematurely (along with file system
metadata overhead), similar to the pwrite loop below.

Do you think changing it to something smaller, like fallocate 0 64k, would
be better to populate the metadata structures without prematurely running
out of thin pool space?

Thanks,
Zorro

> +	done
> +
> +	# Unmount and check the device to make sure all metadata is written
> +	_dmthin_check_fs
> +	_dmthin_mount
> +
> +	# Write the data blocks to force thinp space allocation.
> +	# Overfill it by a bit.
>  	for I in `seq 1 500`; do
>  		$XFS_IO_PROG -f -c "pwrite -W 0 1M" $SCRATCH_MNT/file$I &>/dev/null
>  	done
> -- 
> 2.51.0
> 
