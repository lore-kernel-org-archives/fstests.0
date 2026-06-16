Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7D3DA7C5
	for <fstests@vger.kernel.org>; Tue, 16 Jun 2026 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589990; cv=none; b=WPg42ogrI8xc5WVUtq09ghBPsT6xb3NVVKqlGMayU3RVmwEjsNPQThkfBONv+8ZlJcZfeF+zwY73dlX+zHJlPnyP1paoXTcKvC5lcSeXPn317GJ3IZUEfAv9VMmmfdeIscXTTqwWbojwYg6q3kNN3g3nfKuhxDUoJkzbzQsN97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589990; c=relaxed/simple;
	bh=dw2Cvn/ur32UD/gG5oDf/gzwD6BhR9uWldc8FNj2h3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id025YRSNZGXGrFQ/+bCJTXcLFcoqhH1rJqvFbFtiLkQyJBSPUhVDEReZ0mPsFcO1dsCQT8SOd6NQKkE3myUDSu/Dk7shhxOO+xL9ojLqpumZmswSQ6U3dA6NI1SIavqknltycB/prlrgSlOp8W+83sW1bJy2681IbMDeZPGgpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys0gv1As; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys0gv1As"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6AA1F000E9;
	Tue, 16 Jun 2026 06:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781589987;
	bh=8skaFAn8iWz1oYQUx+F0nQwHC7XAZ27/HYL8nRZKzuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ys0gv1AsAR4Uu3fqzwbinne90Nsc6ytcdAegYIFHH3MqIo9dEcl0IAYzI2+5NUTha
	 jbC1oYuQbv7dXsIvyRDVZAzknrhNxJDmS2vReOFJNux9OT3wGyxEjfuoYs2O1egBqs
	 uOHca+WBtXUzVXsjjxZEOQjIw8KIjYOXbxnxnSbHzx0jDnMyAKrUOsqz3h3ay3/Pa/
	 VYd4OGq+htQsC3AWEoMwBuSDeyJQTTpkyY0UcjI8fxmfWWxgCcCsvmxVIz/BpzTf1j
	 KHDAcR0z9uM25x1tobgF5QFTrhID08i4hfGtNXyJgOf/fwoffLPfrNcBaJdivwAaE8
	 4yJJLfGoVGLyQ==
Date: Tue, 16 Jun 2026 14:06:21 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/009: use common _scratch_shutdown helper
Message-ID: <ajDkil_W3kK-jW8c@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260615090558.1627456-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615090558.1627456-1-chao@kernel.org>

On Mon, Jun 15, 2026 at 09:05:58AM +0000, Chao Yu wrote:
> f2fs has supported ioctl(_IOR ('X', 125, uint32_t)), so that
> "f2fs_io shutdown" can be completely replaced w/ _scratch_shutdown(),
> let's clean up in f2fs/009.
> 
> Suggested-by: Zorro Lang <zlang@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/009 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> index fa4a39d16..39a4bad3d 100755
> --- a/tests/f2fs/009
> +++ b/tests/f2fs/009
> @@ -12,6 +12,7 @@
>  _begin_fstest auto quick
>  
>  _require_scratch
> +_require_scratch_shutdown
>  _require_inject_f2fs_command node i_links
>  _require_command "$(type -P socket)" socket
>  
> @@ -106,7 +107,7 @@ ino=`stat -c '%i' $filename`
>  $F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
>  stat $filename >> $seqres.full
>  rm $filename
> -$F2FS_IO_PROG shutdown 1 $SCRATCH_MNT/ >> $seqres.full
> +_scratch_shutdown -f

Great! Glad to see fs specific code being replaced by common helper.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  sleep 6
>  check_links 1 0 $ino
>  
> -- 
> 2.49.0
> 
