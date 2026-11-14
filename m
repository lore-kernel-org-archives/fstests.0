Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668175;
	b=oFfKwCXWDA0BaT+O7Coacla14v8VnJ0rpEOJkDvH9cLkjx6Iwd090CukIYRUIpGGkVjW
	 cmt/ipXJ/9QhzxLKw4gWNSre7kjqKMBecOMfVnXGN5T0qUb20lpI8IzDD8EydDOyLAHXs
	 T2c4vASHDWy/S7/LPiYF+iocdGd/3kHp4PVMHmeDRGyzvCuHyUQzRn2TOFqZuxmwkdqAi
	 G635Y3RukOue0TIZr1HFSL9ia8gYRMt8UpESVAsYIIx0gv/bRpppvUvt6yaxo1ZeLqokC
	 zrGlpS0ZkuKqBqlsHZ9rHIkuaGvEvDZfbRWNL5Sq4FedoNZq7tSlg/gxWpkRRhS2zSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668175;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wVgLqTh2WTK6G26rIIkmRZQ4ErFw1WWeZ1m6Zf4jUUk=;
	b=Orso7f7PlnYzu3+WsnSJuv04tN0kDiwsBtF3ytDO6FeZNS1LxEGsKfeTAs4mfs+tx5/r
	 gTJo2zVylPgkmawdwTyh4aXdj+4GjBngwk22avbsCp+0VYTAlcQ0Tzkjf7DNCLqzE4CUK
	 Td6wR80YfEd+P/AYlC537NaP0e3u2ADw2CxzRkPOVw6triCQAb0GxdKphF64SqtAc1JBo
	 kjKsPd35u2PlRwlYNtHz6nMfjJvQaigk52NmqboTvEwwIa7gbd5HmhmC1eooJG+Ott4Hb
	 LtSYh5wm55AQ+N6IfcNh37YmpYkhxhZotWb+JVwFMHfi7SGBJbmGiMr9nNP+DBakrVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1NOf5Lk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4008606A33D
	for <fstests@vger.kernel.org>; Sat, 14 Nov 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1NOf5Lk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997E91F000C4;
	Sat, 14 Nov 2026 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794668174;
	bh=wVgLqTh2WTK6G26rIIkmRZQ4ErFw1WWeZ1m6Zf4jUUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a1NOf5LkS8E716DPfa34cA4wCih/EYWTq57I6gPKs78CYerJECzVAvVx52LQUxY8l
	 khkadINQzKJXhNb8xgwzeggbhi2ZCKwW2KhSpCdIos79wDKMFVg1lmOSMHFQH7cfa5
	 GOBJzNO6W7tLnBL7HNiT0Gz+5rzIbBsQ1DspSUoxChYPl3aj9sRt+qrGpw/UpQ7Kyl
	 sFVdfHL9wGmhppX2KfWrQe0dGGsBVYDMt9adsrt76B23NcrvxqOWMx2VBbLnEQV12g
	 3l1GrtZ37uQfMscjt9ImqgKqrYQLBKupTh7eRhJEZXu1USIcnTYTUYNzyPfVLlW9mb
	 LZ8SOCmUjmpNQ==
Date: Sat, 14 Nov 2026 22:56:02 +0800
From: Zorro Lang <zlang@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: Re: [PATCH] xfs/654: don't complain if the healthmon xfs_io already
 exited
Message-ID: <avh2d1fvEpQzACN4@zlang-mailbox>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>, 
	fstests@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
References: <20261111152024.163855-1-avinesh.kumar@suse.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111152024.163855-1-avinesh.kumar@suse.com>

On Wed, Nov 11, 2026 at 04:20:19PM +0100, Avinesh Kumar wrote:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> After the unmount, the test resumes the stopped xfs_io healthmon
> process, which reads the "filesystem unmounted" event, sees EOF, and
> exits on its own.  The test then sends it a SIGTERM anyway in case it
> did not exit.  If xfs_io has already exited and been reaped by the
> shell, kill prints "kill: (PID) - No such process" to stderr, which
> doesn't match the golden output:
> 
>     +/opt/xfstests/tests/xfs/654: line 50: kill: (170710) - No such process
>      mount refcount is in range
>      mount + healthmon refcount is in range
> 
> Redirect kill's output to $seqres.full, as _kill_xfs_healer does.
> 
> Fixes: 79f6b1c3 ("xfs: test health monitoring code")
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/xfs/654 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/654 b/tests/xfs/654
> index 012f31a8..e8d815ae 100755
> --- a/tests/xfs/654
> +++ b/tests/xfs/654
> @@ -47,7 +47,7 @@ mon_nomount_refcount="$(_module_refcount xfs)"
>  # Capture mod refcount after continuing healthmon (which should exit due to the
>  # unmount) and killing it.
>  kill -CONT $healer_pid
> -kill $healer_pid
> +kill $healer_pid &>> $seqres.full
>  wait
>  unset healer_pid
>  nomon_nomount_refcount="$(_module_refcount xfs)"
> -- 
> 2.56.0
> 
> 
