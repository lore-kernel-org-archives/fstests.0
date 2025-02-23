Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD82111
	for <fstests@vger.kernel.org>; Sun, 23 Feb 2025 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740339042; cv=none; b=aaVcl89D5KKKQF1pw5iGXRYorgoRhm6UINlHcqYA0y+RW4JSyewidb/SVwBwm943Fz/KKBs5va4dw1zcoirsRdvzOQ4/F+HwXBjGph6RxVBMC+eR1Zp1uq5Ou1RoRxMrq7Fi86PhoWaLTjqlrGDS94TxEQH7k9CZqYrxU+BNir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740339042; c=relaxed/simple;
	bh=X4MdPycUhwtbQ9mueZwnj+ERZHOl5484NQTqaMuT9TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh+rPbNO30lvdbuQMgC5V1Gs5tQzudcGXNeijJ9nIZFcJiDUNpKI1Y8srQNtK/m2H2Hf7jc/TCUxexC09Ocln9PbSuyyatjDWt7s9ifT2Ymhhr5tvxDwAd377TfiidKZzjI98IVbQySL639/wgEKFE1EjzI0KpMqcvPqYHfPv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8nR/47O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8nR/47O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDDDC4CEDD;
	Sun, 23 Feb 2025 19:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740339041;
	bh=X4MdPycUhwtbQ9mueZwnj+ERZHOl5484NQTqaMuT9TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8nR/47OXDhFR17oPKce4UdsyvWjl54wCRgFQK8ChkrTEL/uaa+iIGpBNX8X7IkxS
	 B5kSwsr+9mGIMCUgdWcs8FUJnhZUsuaqf9yjlxDcqFjKV2D7HdE8YCS6VhqRWfJN+5
	 xekM5CYesTP8uFtHCKvgghw7wpePwAcM2EKo7DgUNjcoVh8QAmHzHjBvwRDYl56OR6
	 4jZhv5PzskkgRwBWZX8yIidksRgRXbi0zsp3kc6st/5ZWlXH5Pr776wmW0xJ+3r4qn
	 Dokehk6aOohetNvSh41Qxl0vn4bylyKSHVDVo9WuQuCwfx0tqrYSyORh8j/xPXdcl9
	 38LKI6+ibqsTw==
Date: Sun, 23 Feb 2025 11:30:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250223193040.GA21799@frogsfrogsfrogs>
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c238e76631b086db592f214beaa6fd94@kernel.org>

On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> Hi all,
> 
> The for-next branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> has just been updated and tagged as v2025.02.23 release.
> 
> Release Notes:
> 1) There's not new test cases in this release, this's a release for bug fixes
>    particularly.
> 2) Reiserfs part is removed from fstests.
> 3) ltp/growfiles is removed too, I think no one needs it.
> 
> I can't list all updates at here, more details please refer to below.
> Thanks for all these contributions!

Thanks, Zorro.  I know the last few months have been rough. :/

--D

> Thanks,
> Zorro
> 
> The new head of the for-next branch is commit:
> 
> 5b56a2d88819 fstests: remove reiserfs support
> 
> New commits:
> 
> Christoph Hellwig (1):
>       [04d0cf3f8909] generic/370: don't exclude XFS
> 
> Darrick J. Wong (35):
>       [cc379f50f3bd] generic/476: fix fsstress process management
>       [ab459c67c5e0] metadump: make non-local function variables more obvious
>       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
>       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
>       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
>       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
>       [777732b27e62] common/dump: don't replace pids arbitrarily
>       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
>       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
>       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
>       [77548e6066fd] common/rc: create a wrapper for the su command
>       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
>       [c71349150d34] common/rc: hoist pkill to a helper function
>       [91d2880aa029] tools: add a Makefile
>       [88d60f434bd9] common: fix pkill by running test program in a separate session
>       [247ab01fa227] check: run tests in a private pid/mount namespace
>       [949bdf8eae31] check: deprecate using process sessions to isolate test instances
>       [af0f1090e240] common/rc: don't copy fsstress to $TEST_DIR
>       [f43da58ef936] unmount: resume logging of stdout and stderr for filtering
>       [5dc27fd20f80] mkfs: don't hardcode log size
>       [dba402b7e3ae] common/rc: return mount_ret in _try_scratch_mount
>       [9505d04b8073] preamble: fix missing _kill_fsstress
>       [4d9aeeb79f9c] generic/650: revert SOAK DURATION changes
>       [1bb15a27573e] generic/032: fix pinned mount failure
>       [b816737426bf] fuzzy: stop __stress_scrub_fsx_loop if fsx fails
>       [040e74c89192] fuzzy: don't use readarray for xfsfind output
>       [0dfe1fac98d2] fuzzy: always stop the scrub fsstress loop on error
>       [336d73c96a96] fuzzy: port fsx and fsstress loop to use --duration
>       [96d29207c126] fix _require_scratch_duperemove ordering
>       [a8268531ca8b] fsstress: fix a memory leak
>       [e8e29e028faa] fsx: fix leaked log file pointer
>       [4a9e82863917] misc: don't put nr_cpus into the fsstress -n argument
>       [c475ff6ff6d7] common/config: add $here to FSSTRESS_PROG
>       [1c67e8b191fe] config: add FSX_PROG variable
>       [a553e7eba1cf] build: initialize stack variables to zero by default
> 
> David Sterba (2):
>       [9049250b4042] fstests: remove ltp/growfiles
>       [5b56a2d88819] fstests: remove reiserfs support
> 
> Filipe Manana (2):
>       [7122c0315a08] btrfs/254: don't leave mount on test fs in case of failure/interruption
>       [535b72a63a28] btrfs/254: fix test failure in case scratch devices are larger than 50G
> 
> Jeff Layton (1):
>       [bd6e01c81e21] generic/126: run it inside its own subdirectory
> 
> 
> Code Diffstat:
> 
>  .gitignore            |    1 -
>  Makefile              |    2 +-
>  check                 |   91 +-
>  common/config         |   12 +-
>  common/dump           |    1 -
>  common/fuzzy          |  104 +-
>  common/metadump       |   42 +-
>  common/populate       |   13 +-
>  common/preamble       |    2 +-
>  common/quota          |    6 +-
>  common/rc             |  146 ++-
>  common/reflink        |    2 +-
>  configure.ac          |    1 +
>  include/builddefs.in  |    3 +-
>  lib/tlibio.c          |    2 +-
>  ltp/Makefile          |    2 +-
>  ltp/fsstress.c        |    1 +
>  ltp/fsx.c             |    8 +-
>  ltp/growfiles.c       | 2607 -------------------------------------------------
>  m4/package_libcdev.m4 |   14 +
>  src/nsexec.c          |   18 +-
>  src/xfsfind.c         |   14 +-
>  tests/btrfs/254       |    8 +-
>  tests/generic/019     |    2 +-
>  tests/generic/032     |    9 +
>  tests/generic/050     |    2 +-
>  tests/generic/075     |    2 +-
>  tests/generic/085     |    2 +-
>  tests/generic/093     |    2 +-
>  tests/generic/112     |    2 +-
>  tests/generic/125     |    2 +-
>  tests/generic/126     |   17 +-
>  tests/generic/127     |   16 +-
>  tests/generic/128     |    2 +-
>  tests/generic/193     |   36 +-
>  tests/generic/230     |   14 +-
>  tests/generic/231     |    4 +-
>  tests/generic/233     |    2 +-
>  tests/generic/270     |   12 +-
>  tests/generic/310     |    6 +-
>  tests/generic/314     |    2 +-
>  tests/generic/327     |    2 +-
>  tests/generic/328     |    4 +-
>  tests/generic/355     |    2 +-
>  tests/generic/361     |    4 +-
>  tests/generic/370     |   10 +-
>  tests/generic/453     |    6 +-
>  tests/generic/455     |    2 +-
>  tests/generic/456     |    2 +-
>  tests/generic/457     |    2 +-
>  tests/generic/469     |    2 +-
>  tests/generic/476     |    4 +-
>  tests/generic/499     |    2 +-
>  tests/generic/504     |   15 +-
>  tests/generic/511     |    2 +-
>  tests/generic/514     |    2 +-
>  tests/generic/530     |    6 +-
>  tests/generic/531     |    6 +-
>  tests/generic/561     |    2 +-
>  tests/generic/573     |    2 +-
>  tests/generic/590     |    2 +-
>  tests/generic/600     |    2 +-
>  tests/generic/601     |    2 +-
>  tests/generic/603     |   10 +-
>  tests/generic/642     |    2 +-
>  tests/generic/650     |    6 +-
>  tests/generic/673     |    2 +-
>  tests/generic/674     |    2 +-
>  tests/generic/675     |    2 +-
>  tests/generic/680     |    2 +-
>  tests/generic/681     |    2 +-
>  tests/generic/682     |    2 +-
>  tests/generic/683     |    2 +-
>  tests/generic/684     |    2 +-
>  tests/generic/685     |    2 +-
>  tests/generic/686     |    2 +-
>  tests/generic/687     |    2 +-
>  tests/generic/688     |    2 +-
>  tests/generic/691     |    8 +-
>  tests/generic/721     |   10 +-
>  tests/generic/726     |    2 +-
>  tests/generic/727     |    2 +-
>  tests/generic/740     |    2 +-
>  tests/generic/746     |    2 +-
>  tests/generic/750     |    2 +-
>  tests/generic/759     |    7 +-
>  tests/generic/760     |    7 +-
>  tests/xfs/149         |    2 +-
>  tests/xfs/501         |    2 +-
>  tests/xfs/502         |    2 +-
>  tests/xfs/530         |    2 +-
>  tests/xfs/720         |    2 +-
>  tests/xfs/795         |    2 +-
>  tests/xfs/803         |    2 +-
>  tools/Makefile        |   21 +
>  tools/run_privatens   |   28 +
>  tools/run_setsid      |   22 +
>  97 files changed, 596 insertions(+), 2890 deletions(-)
> --
> Zorro Lang
> zlang@kernel.org


