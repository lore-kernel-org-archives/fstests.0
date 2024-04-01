Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27D446D5
	for <fstests@vger.kernel.org>; Mon,  1 Apr 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983354; cv=none; b=YJd6T39RE2r8PefJgeYEFkAA3fUCN9BIi1xnpYY9C6FOyYP2ksQWu4G5OPurF7r44L5XDjtyrJT+UYB0itXskAxKX+zIFGIdQgWbj2Az57jWutShSPpjF2CER7FNH1CM7Y92WmrjoQLAYuKKe0CJBUR9KuL+OT7yrdW0lAbK/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983354; c=relaxed/simple;
	bh=GbbsKn53wCdF9dSL9v3D/o/fnJuHHus5ZcB0NfHWoQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZHOR8qf0pSDime+DUEOT2cbuV48BIQjyQZsLs4u8t742882YjsByY7IWIDNnEojrZKV5QfibVZOImD3muDJlFY+aC40/CNe2q9H+Nzj+wkr9HJEG2GnDFbA8WK9DlM9YuW+Ory0v11w2KJuKyPc+uw8beF/Hyt+6QKC/Uvd6gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHsDeUvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHsDeUvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7517CC433C7;
	Mon,  1 Apr 2024 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711983354;
	bh=GbbsKn53wCdF9dSL9v3D/o/fnJuHHus5ZcB0NfHWoQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHsDeUvnS476WMJ0tvwrXQ97YA0rTan2+UEor20CRFOL0nFdzlj2caGZ3L2BaxNdK
	 xWAMyUPi5+Xz34zLXussB9V8nMsEF9spxZnDeJBW6AdxFaSSTiWI6qhEczY1rGnpfn
	 WuU+j+Qj8X9341GxgS5BZcWi7pBwn1enza7Fqas8mgl8y3KBHVpM96y5tT+PrDi8O7
	 SmqHlfk9LYvSmk70/jwVesk9ABmOFiIXZIylB98OPDP3d00m3BLyAqoTXukYgNBtwS
	 6pju+njoMHv0a90qn9Xkoxzbff8hCL62oIYL+/oidwx9zoBESSvGhvifEzAH2kcyZ9
	 nrE5MIxIFEw/w==
Date: Mon, 1 Apr 2024 07:55:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] ext4/01{2,9}: fix invalid filesystem option 'journal'
Message-ID: <20240401145553.GG6379@frogsfrogsfrogs>
References: <20240401095709.12304-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401095709.12304-1-luis.henriques@linux.dev>

On Mon, Apr 01, 2024 at 10:57:08AM +0100, Luis Henriques (SUSE) wrote:
> Creating an ext4 filesystem using '-O journal' will fail with:
> 
>     Invalid filesystem option set: journal
> 
> Fix it by replacing it by '-O has_journal', which ensures the filesystem
> (ext3 or ext4) is created with a journal.  While there, also redirect stderr
> and stdout to the full log.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> changes since v1 (after tytso's review):
> - instead of dropping '-O journal', replace it by '-O has_journal'
> - redirect std{out,err} to log
> - use _scratch_mkfs instead of _scratch_mkfs_ext4
> 
>  tests/ext4/012 | 2 +-
>  tests/ext4/019 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/ext4/012 b/tests/ext4/012
> index c49e8ef4483b..358874a1caf1 100755
> --- a/tests/ext4/012
> +++ b/tests/ext4/012
> @@ -32,7 +32,7 @@ TESTDIR="${SCRATCH_MNT}/scratchdir"
>  TESTFILE="${TESTDIR}/testfile"
>  
>  echo "+ create scratch fs"
> -_scratch_mkfs_ext4 -O journal > /dev/null 2>&1
> +_scratch_mkfs -O has_journal >> $seqres.full 2>&1
>  
>  echo "+ mount fs image"
>  _scratch_mount
> diff --git a/tests/ext4/019 b/tests/ext4/019
> index ab5f50c66b6f..f0514093981b 100755
> --- a/tests/ext4/019
> +++ b/tests/ext4/019
> @@ -32,7 +32,7 @@ TESTDIR="${SCRATCH_MNT}/scratchdir"
>  TESTFILE="${TESTDIR}/testfile"
>  
>  echo "+ create scratch fs"
> -_scratch_mkfs_ext4 -O journal > /dev/null 2>&1
> +_scratch_mkfs -O has_journal >> $seqres.full 2>&1
>  
>  echo "+ mount fs image"
>  _scratch_mount
> 
