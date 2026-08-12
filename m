Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6066480DE8
	for <fstests@vger.kernel.org>; Wed, 12 Aug 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559021; cv=none; b=kbQR2FsvlljKToVd6FNLG2AsBa3etHzyAH69oqIBoDO7BdQwWN7gF+wz3sBHSa9+6H+cWceE82k2lfXoqxDQ3TMfidEqC8HArVoO3fLuEiuAON4sE5U5KbnqwA+BWYElfDn0yObAGF9hz5FGFFdgYNUHAv4pcBGhOzKuZIF0X0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559021; c=relaxed/simple;
	bh=2C/R8T0R46+aD2/xL2A31GtbQLow52dMbdQtv4jJfWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDe66KuBpLLb07iBmA3wnhC+xABCUnygxrvGqy/KeyvCRze24XjsoV3daakKN08SDpltiYL40d1f18hRkLDNQ3SOBrWz1h+y1wjAS6SRcK8pyz5RqXIb3KcVjocpFtqlExetqxLDUmHcdoCYgQ54Lx+f9Eq5wHInAL3ewXng/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSfRHY2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSfRHY2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A171F000E9;
	Wed, 12 Aug 2026 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786559020;
	bh=Z/RqTLUtoGk0XQafhyBNa8PRsG/eP6cnuggWLPCatpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RSfRHY2FyOjdCZsPdPIRQb2sEMNtqEr6bJv+D6lQ7j+ZHNzs0Km4Fc1urupZ38eXh
	 4+bckD5vT/GfdvSdL14jezvAqhf0bYgS0Soilavir/AVDy8oui6ST9ykAiWcawkEaM
	 242CGAjeVe1GNbPHcRt87+DAF62LzK8OAbNlK7ERt4R/G7ZO9t20yWEgmUxPULqNzN
	 LjcIbUZhXXmVIVfMu6WZp2+UQ7IHJmFbQrjojAPQbLyhtGzTpGpeyr1C7mJRnzMU6L
	 vXz9NBW2m0irsoncxf+SEuVJS/epI1anriMKi64xH7bS97IhHQO8CKSs6QMEHgyYQG
	 joqhUSj8n0Bzw==
Date: Thu, 13 Aug 2026 02:23:36 +0800
From: Zorro Lang <zlang@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/347: Fix sporadic test failures
Message-ID: <any5dTHB0lLr40Id@zlang-mailbox>
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

Since there're no further review comments/objections so far, I'll merge this
patch with one small addition: "_require_xfs_io_command falloc".

Reviewed-by: Zorro Lang <zlang@kernel.org>


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
