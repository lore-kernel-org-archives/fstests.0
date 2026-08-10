Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58C3093CF
	for <fstests@vger.kernel.org>; Mon, 10 Aug 2026 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394425; cv=none; b=cSMeJc5gWTshAUp78RgK6+05Z2O12IH+YGiaMgtxRQYw8tbukemgWisslhQRzMtJuSRAj+10+7N9Xliu7g1a6EmHxwtarbDYio/vfUEjZ4X6+b1YeNZXrYzyzTJEdhrGwQhnNYxpc8NpNZFLeQJWn016uxMrqi0vQIRH7gIhF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394425; c=relaxed/simple;
	bh=8as0s4hSMTy6bWs+lFtkd/YV60FikXYxZ/cEtceCybE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBNXP63fvLV4lgGFjD/qJA25yL7dIChLDevYIfcFHk6UOisaEsXPMDQ8shpY++HAymFlGm2rDI4a8tIpTw0Cs65VQOFPeqIP8DQkfI1NhMs863b4OmnLFIK0A+E1Ef1zo89ZPsS2wQ7qWwzdEjsdoam9DcxNw7owjcWj5yZXjp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSXacz0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSXacz0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F0F1F000E9;
	Mon, 10 Aug 2026 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786394424;
	bh=/8JIMTP/GBfouBreGfEpnGuXzp80E7ceJPWuMgH7vUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VSXacz0xmtriFeeQJ1Th0kBVr5cXWsQ5U7mqgECDOiuqsSwCWCxT1HZ2n4p2dSBoI
	 QDvHjF/wx9kk3/1PQdcPBggn4JyyJwr14AeCqaj2SOFkWo5ehs1CsDZJKd3l+IphrT
	 kbWnDN5pPP0h3btkVIQN/fcB0lmW9rvr5kLEZoQ6WpEZCKUvYixWZZiV+zlXV8rSVG
	 JQmWF6/Y18cXMI7TymSewmeidjDx8vYxqZiWssggx9NImXGcluFYdrcVc5MvFC5RED
	 UeQX928opZNvAIzm6WPYtOp6kl8xYfES/77kbPQD3m9TacdCRK1buJlcDEBrMmt2UA
	 QvPwtOLZ8Xlug==
Date: Tue, 11 Aug 2026 04:40:18 +0800
From: Zorro Lang <zlang@kernel.org>
To: Zizhi Wo <wozizhi@huaweicloud.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: fstests@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH] idmapped-mounts: probe O_TMPFILE support with the
 caller's mapped id
Message-ID: <anoyQqDV_ga7ttCg@zlang-mailbox>
Mail-Followup-To: Zizhi Wo <wozizhi@huaweicloud.com>, 
	Christian Brauner <brauner@kernel.org>, fstests@vger.kernel.org, yangerkun@huawei.com, 
	chengzhihao1@huawei.com
References: <20260731090253.1665192-1-wozizhi@huaweicloud.com>
 <f705ea52-36da-4fdb-a41e-a67a10830919@huaweicloud.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f705ea52-36da-4fdb-a41e-a67a10830919@huaweicloud.com>

On Thu, Aug 06, 2026 at 02:11:55PM +0800, Zizhi Wo wrote:
> friendly ping...

Hi Zizhi, actually I'm waiting for the fix from vfs list.

Hi Christian,

Could you please take a look at this issue? Quite a few people have submitted
patches trying to fix this test issue. Given that you are the authority on
this topic and previously sent a patchset [1] to fix this kind of issue, I think
accepting your patch would be the best approach to stay aligned with upstream
VFS. Christoph also metioned that [2] last time. I don't want to make this issue
fixing any more complicated. Could you please provide your review point or
rebase your fix on the latest fstests for-next branch, we'll review it ASAP.

[1]
https://lore.kernel.org/fstests/20260615-overlay-idmapped-vfstest-v1-1-c6b3b2228092@kernel.org/

[2]
https://lore.kernel.org/fstests/amCGrQi2sCcgSgHL@infradead.org/

Thanks,
Zorro

> 
> 在 2026/7/31 17:02, Zizhi Wo 写道:
> > From: Zizhi Wo <wozizhi@huawei.com>
> > 
> > Kernel commit 539dce114465 ("fs: refuse O_TMPFILE creation with an
> > unmapped fsuid or fsgid") made vfs_tmpfile() return -EOVERFLOW when the
> > caller's fsuid/fsgid has no mapping in the filesystem's user namespace
> > after applying the mount's idmapping. This is a no-op on non-idmapped
> > mounts and only takes effect on an idmapped mount that does not map the
> > caller.
> > 
> > The idmapped-mount testcases behind generic/696 and generic/697 build an
> > idmapping (e.g. "0 10000 10000") that covers host uid 10000-19999 but
> > not uid 0, then call openat_tmpfile_supported() from the parent process
> > that is still real root (fsuid 0). The probe now gets -EOVERFLOW, falls
> > into the log_errno() branch, and prints
> > 
> >    utils.c: 928: openat_tmpfile_supported - Value too large for defined \
> > data type - failure: create
> > 
> > to stderr. Both testcases expect "Silence is golden", so this spurious
> > output fails them, even though the kernel behavior is correct and the
> > testcases' own assertions all pass.
> > 
> > Move each openat_tmpfile_supported() call into the child, after
> > switch_ids()/switch_userns(), so it probes with the mapped identity the
> > tmpfile section uses. Silencing EOVERFLOW in openat_tmpfile_supported()
> > would make it indistinguishable whether the idmapping genuinely has no
> > mapping for any caller, or the probe just ran in the unmapped parent before
> > the switch.
> > 
> > Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> > ---
> >   src/vfs/idmapped-mounts.c | 32 ++++++++++++++++++++------------
> >   1 file changed, 20 insertions(+), 12 deletions(-)
> > 
> > diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> > index ed9992f9..bfbe9042 100644
> > --- a/src/vfs/idmapped-mounts.c
> > +++ b/src/vfs/idmapped-mounts.c
> > @@ -3838,8 +3838,6 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
> >   		goto out;
> >   	}
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >   	pid = fork();
> >   	if (pid < 0) {
> >   		log_stderr("failure: fork");
> > @@ -3849,6 +3847,8 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
> >   		if (!switch_ids(10000, 11000))
> >   			die("failure: switch fsids");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		/* create regular file via open() */
> >   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> >   		if (file1_fd < 0)
> > @@ -4014,8 +4014,6 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
> >   		goto out;
> >   	}
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >   	pid = fork();
> >   	if (pid < 0) {
> >   		log_stderr("failure: fork");
> > @@ -4025,6 +4023,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
> >   		if (!switch_userns(attr.userns_fd, 0, 0, false))
> >   			die("failure: switch_userns");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		/* create regular file via open() */
> >   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> >   		if (file1_fd < 0)
> > @@ -4133,6 +4133,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
> >   		if (!switch_userns(attr.userns_fd, 0, 0, false))
> >   			die("failure: switch_userns");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		if (!caps_down_fsetid())
> >   			die("failure: caps_down_fsetid");
> > @@ -4257,6 +4259,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
> >   		if (!switch_userns(attr.userns_fd, 0, 1000, false))
> >   			die("failure: switch_userns");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		if (!caps_down_fsetid())
> >   			die("failure: caps_down_fsetid");
> > @@ -7733,8 +7737,6 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
> >   		goto out;
> >   	}
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >   	pid = fork();
> >   	if (pid < 0) {
> >   		log_stderr("failure: fork");
> > @@ -7752,6 +7754,8 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
> >   		if (!switch_ids(10000, 11000))
> >   			die("failure: switch fsids");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		/* create regular file via open() */
> >   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> >   		if (file1_fd < 0)
> > @@ -7947,8 +7951,6 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
> >   		goto out;
> >   	}
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >   	/*
> >   	 * Below we verify that setgid inheritance for a newly created file or
> >   	 * directory works correctly. As part of this we need to verify that
> > @@ -7984,6 +7986,8 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
> >   		if (!switch_userns(attr.userns_fd, 0, 0, false))
> >   			die("failure: switch_userns");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		if (!caps_down_fsetid())
> >   			die("failure: caps_down_fsetid");
> > @@ -8181,8 +8185,6 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
> >   		goto out;
> >   	}
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >   	pid = fork();
> >   	if (pid < 0) {
> >   		log_stderr("failure: fork");
> > @@ -8207,6 +8209,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
> >   		if (!switch_ids(10000, 11000))
> >   			die("failure: switch fsids");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		/* create regular file via open() */
> >   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> >   		if (file1_fd < 0)
> > @@ -8342,6 +8346,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
> >   		if (!switch_ids(10000, 11000))
> >   			die("failure: switch fsids");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		/* create regular file via open() */
> >   		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> >   		if (file1_fd < 0)
> > @@ -8536,8 +8542,6 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
> >   		goto out;
> >   	}
> > -	supported = openat_tmpfile_supported(open_tree_fd);
> > -
> >   	/*
> >   	 * Below we verify that setgid inheritance for a newly created file or
> >   	 * directory works correctly. As part of this we need to verify that
> > @@ -8580,6 +8584,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
> >   		if (!switch_userns(attr.userns_fd, 0, 0, false))
> >   			die("failure: switch_userns");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		if (!caps_down_fsetid())
> >   			die("failure: caps_down_fsetid");
> > @@ -8723,6 +8729,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
> >   		if (!switch_userns(attr.userns_fd, 0, 0, false))
> >   			die("failure: switch_userns");
> > +		supported = openat_tmpfile_supported(open_tree_fd);
> > +
> >   		if (!caps_down_fsetid())
> >   			die("failure: caps_down_fsetid");
> 
