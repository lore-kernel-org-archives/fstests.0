Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ABA3321BD
	for <fstests@vger.kernel.org>; Sat,  5 Sep 2026 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788582886; cv=none; b=atWtwmEvpm7k+UCV/VBXZeJyeA3RpfDBCdKEulQGtZ+3/uEENZlLmOV0HupRIUkuy7AHsN05fLPjLeA+bzEeY4eUdOEpITErhcF9ADuMazF2y6DHA/VWkR9hGdyg4THScZC1McZSEgTcKvd+v2nj7T4c6DAs5HnqYE8U7ERIOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788582886; c=relaxed/simple;
	bh=Ikx7iWGaSCGyHIHhhKvEJxcEnR5upnrE8b/bGr4wOTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdDtvVrsTz2fRCRHnrILrI0QRPHuwisKBDQK5oO9/S/6gG5n8QOUYSu6GIXwDe5m+a+rbD4IF3m0+25O1jUEjveOUMozUOdAQ3ycxfPU/lgt6iOCIAx9bXXY7RHQugcaDb4ZqTHL0UZVFTuaStRGkEXkpWlREH3ZyoLcHutiYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKbPODKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKbPODKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C488E1F00A3D;
	Sat,  5 Sep 2026 04:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788582884;
	bh=/rJHoUSAd3aRw+KHlZHT1r48o0hG7/WcffBup2E6EjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EKbPODKlr4o4K54yQQ3ymStV6g6PtLiZs5DYITy2VfIPfxUZhwecp0fLnsg6CLVVZ
	 adTwLJnuscMKpopheQA2HOjZVj2OHkaEX7hO+TwkDZwII+odcAxNVswPSH8HEgxj/A
	 4v+7qdq2xMJK3BUv9ODF4/vpMfUUmW6PU56q+64ct37no9Dd1pf70aJIj3uz+chk1i
	 zz6JAL3WlEoeQMB94BumPsMh8DiNxBj0I2QV6aqxEHeIQyqhgxZzew2kVInATs4WDu
	 LzsbEjx1992M+BER5WdvZ9/0X2F9GpuR8TZ3HLYp+USNeiGskgiuCqq583e9dK1z3B
	 CUECbsDMuz6fg==
Date: Sat, 5 Sep 2026 12:34:39 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/009: fix race condition in orphan inode test
Message-ID: <apubxk9g6mWXvX5c@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260817091137.1503208-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817091137.1503208-1-chao@kernel.org>

On Mon, Aug 17, 2026 at 09:11:37AM +0000, Chao Yu wrote:
> f2fs/009     81s ... [failed, exit status 1]- output mismatch (see /share/git/fstests/results//f2fs/009.out.bad)
>     --- tests/f2fs/009.out      2026-06-12 08:46:32.819432390 +0800
>     +++ /share/git/fstests/results//f2fs/009.out.bad    2026-08-17 13:09:35.000000000 +0800
>     @@ -1,2 +1,3 @@
>      QA output created by 009
>     -Silence is golden
>     +can't find corruption
>     +(see /share/git/fstests/results//f2fs/009.full for details)
>     ...
>     (Run 'diff -u /share/git/fstests/tests/f2fs/009.out /share/git/fstests/results//f2fs/009.out.bad'  to see the entire diff)
> 
> HINT: You _MAY_ be missing f2fs-tools fix:
>       958cd6e fsck.f2fs: support to repair corrupted i_links
> 
> f2fs_io write ... atomic_commit ... 5000 runs in the background and has
> an initial delay before invoking F2FS_IOC_START_ATOMIC_WRITE. Without a
> sleep in the test script, rm and _scratch_shutdown -f run immediately
> before f2fs_io enters atomic mode, causing f2fs_io to fail and
> preventing the orphan inode from being committed to the on-disk
> checkpoint.
> 
> Add a 2-second sleep to let f2fs_io enter atomic mode, record its PID,
> then shutdown -f to ensure the orphan inode is written to the checkpoint,
> and clean up the background process properly.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Make sense to me,

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/f2fs/009 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> index afb3bc98f..df8bef96c 100755
> --- a/tests/f2fs/009
> +++ b/tests/f2fs/009
> @@ -106,10 +106,14 @@ check_links 0 0
>  touch $filename
>  ino=`stat -c '%i' $filename`
>  $F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
> +pid=$!
> +sleep 2
>  stat $filename >> $seqres.full
>  rm $filename
>  _scratch_shutdown -f
> -sleep 6
> +sleep 4
> +kill $pid &> /dev/null
> +wait $pid &> /dev/null
>  check_links 1 0 $ino
>  
>  # hardlink
> -- 
> 2.49.0
> 
