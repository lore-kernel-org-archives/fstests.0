Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82EC482EB
	for <fstests@vger.kernel.org>; Wed, 13 Nov 2024 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731474422; cv=none; b=n8MVmb4Dx3vF35kt1P9qhmSRzbczSH/QrB7K0llg5lPf+7vdBT3qpvQv5JvFbjvBcN2lDE7D2ARFMMHFLC/lSiDo0IFY6I4r5rqOFzGX1riGWxpgm/WvhsSWHJt/L7YRn69YaqQVO4tj9I7woEM6cOi54UEZeN1EatYNo0DznTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731474422; c=relaxed/simple;
	bh=7t3clnOIFzIZoQD3YAVTHrDoTD03nJQM83S1vniTnxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGnN56vTTs/LMZ8TuZH3QkxxJ/U6QAo24iE9jSx01xwFeQLx2KDsgvEL+jzHji4B08Yg5mK18N7xzR8EWfyDNvxu4Tg6TTnwV9q25W79WLXV3X3BqBnqdLEGvawgCODj4a6lZ+EChZPI0lSTA1eAk06q0OWvmxsRMQYHG4m2D9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYPKjqKu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYPKjqKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42175C4CECF;
	Wed, 13 Nov 2024 05:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731474422;
	bh=7t3clnOIFzIZoQD3YAVTHrDoTD03nJQM83S1vniTnxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYPKjqKuoztV7tXeDkw69l8iPVY5QW4n1R3A8JJcQnyTExzI2WD4rzanaB5DtYklZ
	 eBK4SVVf8E+sxn0GZ43+Lhf+NryYqU7mYR7jdBWtmOAPUuJKGmhrOfeK+BFNTttEDy
	 pl4+4J6XxUHWBp91WTa1zurakm8UepMVbMOr7ykFCrvxRl090aiissXsngQ7+5bDkd
	 49Tw3+bp7Nyqvk7an6SShJUtwCQJ9KoX7CBCWH+CoDEYf8PfZy0/LDnHg7kE2Y1f9s
	 2s7xdvPOxvzqetrIxi5+JRcSUk5xpQrJqJiB17PuAo5HUBKKK3FrkjOvJECgzLXUIM
	 nvs81sAuvcQPA==
Date: Tue, 12 Nov 2024 21:07:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [issue] low version kernel crashes after adding support for
 unshare on XFS testing
Message-ID: <20241113050701.GA9425@frogsfrogsfrogs>
References: <20241111030158.731362-1-maxj.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111030158.731362-1-maxj.fnst@fujitsu.com>

On Mon, Nov 11, 2024 at 11:01:58AM +0800, Ma Xinjian wrote:
> Hi all
> 
> Since xfstests-dev commit 34ce77ce867d27ad7ad9a180489e4311c3cd15e4("fsx: support unshare range fallocate mode") and
> ff07e0a329361c752d77d0f446d247f0ebdb5418("fsstress: add support for FALLOC_FL_UNSHARE_RANGE")
> when running the testcases which use fsx or fsstress on XFS filesystem on Rocky 8.10 (e.g. generic/075 and generic/013),
> the kernel crashes with the following call_trace, could someone help take a look?
> 
> [ 4670.432330] INFO: task fsstress:336323 blocked for more than 120 seconds.
> [ 4670.432334]       Not tainted 4.18.0-553.el8_10.x86_64 #1

               Contact your vendor ^^^^^^^^^^^^^^ for support.

They probably need to backport the funshare input validation fixes that
recently landed in 6.12-rc.

--D

> [ 4670.432335] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 4670.432336] task:fsstress        state:D stack:0     pid:336323 ppid:336321 flags:0x00000080
> [ 4670.432339] Call Trace:
> [ 4670.432341]  __schedule+0x2d1/0x870
> [ 4670.432347]  schedule+0x55/0xf0
> [ 4670.432349]  schedule_preempt_disabled+0xa/0x10
> [ 4670.432352]  rwsem_down_write_slowpath+0x370/0x570
> [ 4670.432356]  ? xfs_buffered_write_iomap_end+0x5c/0xe0 [xfs]
> [ 4670.432400]  down_write+0x29/0x50
> [ 4670.432401]  xfs_ilock+0x98/0x100 [xfs]
> [ 4670.432435]  xfs_buffered_write_iomap_end+0x5c/0xe0 [xfs]
> [ 4670.432467]  ? xfs_iunlock+0xcb/0x110 [xfs]
> [ 4670.432499]  iomap_iter+0x77/0x360
> [ 4670.432502]  iomap_file_unshare+0x76/0x1c0
> [ 4670.432504]  ? kmem_cache_free+0x116/0x300
> [ 4670.432509]  xfs_reflink_unshare+0x55/0x150 [xfs]
> [ 4670.432543]  xfs_file_fallocate+0x3b3/0x480 [xfs]
> [ 4670.432575]  ? __inode_security_revalidate+0x63/0x80
> [ 4670.432578]  ? selinux_file_permission+0x10c/0x140
> [ 4670.432581]  vfs_fallocate+0x140/0x280
> [ 4670.432584]  ksys_fallocate+0x3c/0x80
> [ 4670.432586]  __x64_sys_fallocate+0x1a/0x30
> [ 4670.432588]  do_syscall_64+0x5b/0x1b0
> [ 4670.432591]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> [ 4670.432594] RIP: 0033:0x7f0b8f8d662b
> [ 4670.432598] Code: Unable to access opcode bytes at RIP 0x7f0b8f8d6601.
> [ 4670.432599] RSP: 002b:00007ffee0ad3da8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
> [ 4670.432601] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0b8f8d662b
> [ 4670.432602] RDX: 00000000001d6c8b RSI: 0000000000000040 RDI: 0000000000000003
> [ 4670.432603] RBP: 0000000000000080 R08: 000000000000002a R09: 0000000000000000
> [ 4670.432604] R10: 00000000000967a4 R11: 0000000000000246 R12: 0000000000000040
> [ 4670.432605] R13: 00000000000967a4 R14: 00000000001d6c8b R15: 00007f0b901906b8
> 
> Best regards
> Ma
> 
> 
> 
