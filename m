Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB73FDBEE
	for <fstests@vger.kernel.org>; Fri, 15 May 2026 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868272; cv=none; b=DVRz0RcZrCGngaCGtY2h29hSCCoDwcsHNDW9mOuHzxrUpyLxKhOh4QakmzytgIMFjYx43JNosts8JjPAbHlBIpeEKFF+mdvgCVjV07BMW1dubtYYW22U8tlGjTK62N56xUqFy1wRKlfS5KhzvR6uMJJ3WCkiwETxOUT4sI+DSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868272; c=relaxed/simple;
	bh=hhyluz44ErbSva2TqSzBKP/tzE4T6Ba2VRDiTMCqGwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBnCApOvKteL8c94ZkWNA+4oC14zmKxotMN/q5CYZ34DLlIigIo08ut2ebAHxwTmtH6OXloxOp0lE2cZMv6/VGqU438vUpICRuA13UyE4v+e0lB1bFbTarJFLABZxnIE5S66nIlYDmkJ+brVnZdewYHKXiBAFBvz9A4Ks7iFSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK4P7rjY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK4P7rjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CD7C2BCB0;
	Fri, 15 May 2026 18:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778868271;
	bh=hhyluz44ErbSva2TqSzBKP/tzE4T6Ba2VRDiTMCqGwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nK4P7rjY9S8MOvaXom/f/mpIqZTSILZKg4UUZy6hX+VWmuEe1g1ofq6L4pJABNEim
	 YU3xe5gtJK9w24wcFykTnziO0sbcZ2mgbYhCHnz7D6wVLCWJcM+dzpDzt/DBgcA40F
	 NfSH7jfIVITQNvI8WCKjXjjHezcQBatzsEV0yXwerxLZNVrf45ubZNQsoyWTn7udcg
	 UUjfDViJTTpedsQhN0ELFEzbZgXFm1jtf4iGYV/5G6Nn3DlbdXXOp7I01ohenutOM/
	 YbvvReiJKTVFGD0CRtUSZcKFYbhF8ueMDiJ8/d2fJ2ISD4DhmPxUT5ANNHwXQMM+JM
	 fLtVkhoimHMlQ==
Date: Sat, 16 May 2026 02:04:23 +0800
From: Zorro Lang <zlang@kernel.org>
To: Joanne Chang <joannechien@google.com>
Cc: fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v1 2/2] f2fs/021: Fix mount syntax for disabling jquota
Message-ID: <agddkrLATA8noIQ0@zlang-mailbox>
Mail-Followup-To: Joanne Chang <joannechien@google.com>, 
	fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>
References: <20260513032009.2300435-1-joannechien@google.com>
 <20260513032009.2300435-2-joannechien@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513032009.2300435-2-joannechien@google.com>

On Wed, May 13, 2026 at 03:20:09AM +0000, Joanne Chang wrote:
> F2FS has removed the trailing "=" in the mount options for disabling
> user journaled quotas. Update f2fs/021 to try the new syntax first and
> fall back to the legacy syntax if the initial mount attempt fails.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>
> ---
>  tests/f2fs/021 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/f2fs/021 b/tests/f2fs/021
> index 0cacb138..70b10fa8 100755
> --- a/tests/f2fs/021
> +++ b/tests/f2fs/021
> @@ -21,7 +21,9 @@ quotacheck -uc $SCRATCH_MNT
>  _scratch_unmount
>  
>  _scratch_mount "-o usrjquota=aquota.user,jqfmt=vfsold"
> -_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
> +if ! _try_scratch_mount "-o remount,usrjquota,jqfmt=vfsold" >> $seqres.full 2>&1; then
> +	_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
> +fi

I’ve explored several ways to solve this more elegantly. Otherwise, every
single F2FS quota test case might run into this exact same issue. but I can't
find any good idea currently. For example, if we do something in _try_scratch_mount:

	local mount_opts=`_scratch_mount_options $*`
	if [ "$FSTYP" == "f2fs" ]; then
		mount_opts=`_f2fs_quota_options "$mount_opts"`
	fi

However, F2FS seems to only distinguish the '=' usage through a trial mount,
so doing it inside _try_scratch_mount is definitely not a good idea. Is there
a way to probe this without mounting? Like relying on some --help output or
something similar? Any good ideas from others?

Thanks,
Zorro

>  _scratch_unmount
>  
>  echo "Silence is golden"
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
