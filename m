Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF139C63E
	for <fstests@vger.kernel.org>; Fri, 15 May 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862281; cv=none; b=EIKywBD6fyXHcazDdTTkkXkkoXHQaKt21d5Vp6fhUDIvXkUHGSXu+f2Vu+vwzDAbZNUyiphAZCHm7QE0WX8oa4lrj0b0HJ7Aa+dKu+O57xoGdcLO/eKGmABcoV3wXhZROVxhSVROpLN7SwSCWf3P38LJiBAxRE1wgsZvH40vz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862281; c=relaxed/simple;
	bh=t1qQBrK+cRgELnlc05S5CALyOzD0Mv//pL3ZWuidWzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV8B76WubfB7qDzFB0MNGyyUm4DnUt6mwtXUYuEiseXXV1urFVs3gl0hzd2JVqBPLq6KIxUGYUV5jwzxH77DTi+NawI7QLTvpvGY41flaDyqG2NWJ+bn057Pe0Wqf3fxi3wof8nM4GxG3hHqP7IYXuaxHtnJ7qCnb7rRZes3+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF9K/295; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF9K/295"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5C2C2BCC9;
	Fri, 15 May 2026 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778862281;
	bh=t1qQBrK+cRgELnlc05S5CALyOzD0Mv//pL3ZWuidWzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WF9K/295BaAk1Jngiv7IBaRPDuJQj2ZN/96vvgHe6b2WQVhfMj4v+sOcRKRQHgTG8
	 SdiQyctwlDBreXx8cw0d/ofycblCIVbvTJyrpI0IOLZR8Sb5zvkUzpnyKRopH8r36h
	 qNMls9R0pHVuSlcQIrH4066/73QDQAbbMww/KZCcuv3vaQegVPTq3s0RYLjAe98AFq
	 oI4M9ZQeGbXKhdFPxVKlFdzRFHkHJ3I6WE4gsWON4iNV3kSqJf+t9Soqh2os9o24qo
	 IJTph/jqq5QfIbddElE3P6L7z9D2p17cSBySYABeec8Jg1kQG7I7Gm/Cuv/fNnuJGk
	 VUXVsH0N3mmHQ==
Date: Sat, 16 May 2026 00:24:36 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] vfs: fix dumpable race in create_userns_hierarchy()
Message-ID: <agdH4QrhxBxGrjQH@zlang-mailbox>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>, 
	fstests@vger.kernel.org
References: <20260323-fix-vfs-bugs-v1-1-76a6aed624d9@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fix-vfs-bugs-v1-1-76a6aed624d9@kernel.org>

On Mon, Mar 23, 2026 at 02:32:15PM +0100, Christian Brauner wrote:
> All processes in the userns hierarchy share the same mm_struct due to
> CLONE_VM. When a child calls setresuid() in switch_ids(), the kernel
> clears the dumpable flag on the shared mm. The child immediately
> re-sets it via prctl(PR_SET_DUMPABLE, 1), but there is a window
> between the two where the parent may be opening /proc/PID/ns/user for
> the previous level's child. That open hits ptrace_may_access() which
> checks get_dumpable(mm) and, finding it zero, falls back to
> ptrace_has_cap(mm->user_ns, mode). Since mm->user_ns is init_user_ns
> (the mm was created by real root) and the parent is only ns-root, the
> capability check fails and the open returns -EACCES.
> 
> Fix this by extending the existing two-way socketpair handshake into a
> three-way handshake: the child signals the parent after becoming
> dumpable, then blocks until the parent has opened /proc/PID/ns/user
> and signals back. Only then does the child proceed to
> create_userns_hierarchy() for the next level. This guarantees no
> concurrent setresuid() can clear dumpable while the parent's open() is
> in flight.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

Sorry, a few unforeseen things came up on my end and I lost track of this patch.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  src/vfs/utils.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/src/vfs/utils.c b/src/vfs/utils.c
> index 52bb7e42..0b435afe 100644
> --- a/src/vfs/utils.c
> +++ b/src/vfs/utils.c
> @@ -312,6 +312,18 @@ static int userns_fd_cb(void *data)
>  	if (ret < 0)
>  		return syserror("failure: write to socketpair");
>  
> +	/*
> +	 * Wait for the parent to open our /proc/PID/ns/user before
> +	 * proceeding to create the next userns level. Without this,
> +	 * setresuid() in the next-level child clears the dumpable flag
> +	 * on the shared mm (CLONE_VM) and the parent's open() fails the
> +	 * ptrace_may_access() check with -EACCES because mm->user_ns is
> +	 * init_user_ns where userns processes lack CAP_SYS_PTRACE.
> +	 */
> +	ret = read_nointr(h->fd_event, &c, 1);
> +	if (ret < 0)
> +		return syserror("failure: read from socketpair");
> +
>  	ret = create_userns_hierarchy(++h);
>  	if (ret < 0)
>  		return syserror("failure: userns level %d", h->level);
> @@ -377,6 +389,14 @@ int create_userns_hierarchy(struct userns_hierarchy *h)
>  		goto out_wait;
>  	}
>  
> +	/* Tell the child it can now proceed to create the next level. */
> +	bytes = write_nointr(fd_socket[0], "1", 1);
> +	if (bytes < 0) {
> +		kill(pid, SIGKILL);
> +		syserror("failure: write to socketpair");
> +		goto out_wait;
> +	}
> +
>  	fret = 0;
>  
>  out_wait:
> 
> ---
> base-commit: 3ded3e13c008326d197d11ac975049ed1f8ec922
> change-id: 20260323-fix-vfs-bugs-b4f8a492d6d7
> 
> 
