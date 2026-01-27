Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCA3570B3
	for <fstests@vger.kernel.org>; Tue, 27 Jan 2026 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528836; cv=none; b=FfmBGjAmTBOyJBl+MQhwPjivPJdPxaG8az82xyCPiJWMm7DG6IG9WO3B+GFYHY2ndScR7D5w09K/KiG5DdTBWtlQyfjmYUkvI8xieTo8QC0jkiq9+5LF86xIjzFYCcLi0mMARRFRaxdUZrHKPQuGoEp4erL1KIEKAsooNzFwMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528836; c=relaxed/simple;
	bh=5UBvtJjD/J6g2q2tUVJqjHdn1UZLMUDtZlQ2wQdcrUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjDus/D+VYujaGwAuhp4qpO5+Iq0azQr+wF7+x7DT7yuC0QU1UtMZYBSzc3lJ70CX3Zfa3OloQmsqJTe1UyMwXHpfBNhUHBwNg5aUs6ZZXl2pqm23dy7ewArUAUyy6ccTfb3EYHco4xBQIV6tY7l/TetlkoI4textUmOk9OjugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSwtL/7E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSwtL/7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3B2C116C6;
	Tue, 27 Jan 2026 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769528835;
	bh=5UBvtJjD/J6g2q2tUVJqjHdn1UZLMUDtZlQ2wQdcrUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSwtL/7EsR/udbf09N/WHZHkJ0jIxiiT+yIg/DqGsNZx6DjDe1ME2O/mH31s4HxX1
	 W1Lv1vsi0xTJCqxXeJdTWHQiqTl7VHWCnAiHe3gwrvLCJm1m9UvS2bRL+AkEn1L2PZ
	 Zylt6erVxZr2Gll7EBcCM0Wrvq2MU8mSGTlEG2OL7ukDt7pop6rdrD1JEhSkXK5H2M
	 SB+SJ0lgxC3T7SVAxosLDa9uK7jlQEab1Qe1EVaf55+rxO8DIsVB1c2q4mF8D7jCkK
	 nLgEV9I0cwp3i1Qp+nBQe90CZ3vHjUFZE1+CPEgDGVmbkNR7RTaGfkALh8GNeznJ+2
	 QLnEXLnOK+x5g==
Date: Tue, 27 Jan 2026 07:47:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2026.01.27
Message-ID: <20260127154715.GC5916@frogsfrogsfrogs>
References: <e722a754c0ae8ed500fcdc16736a9202@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e722a754c0ae8ed500fcdc16736a9202@kernel.org>

On Tue, Jan 27, 2026 at 02:58:36PM +0800, Zorro Lang wrote:
> Hi all,
> 
> The for-next branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> has just been updated and tagged as v2026.01.27 release.

I see that master did indeed jump to the Jan 5 tag, but for-next still
seems to be at v2026.01.05?

--D

> Release Notes:
> 1) There're 3 new test cases in this release, includes btrfs/341, btrfs/342 and
>    xfs/841.
> 2) fsstress and fsx don't fail when --duration=0.
> 
> More fixes on btrfs, ext4, f2fs, hfs and xfs, please refer to the details below.
> Thanks for all these contributions.
> 
> Thanks,
> Zorro
> 
> The new head of the for-next branch is commit:
> 
> 69cd20bd0498 xfs: test reproducible builds
> 
> New commits ([N]ew, [U]pdate):
> 
> Darrick J. Wong (2):
> [U]      [754368070ac5] xfs/614: fix test for parent pointers
> [U]      [31f7192f90a8] misc: allow zero duration for fsstress and fsx
> 
> Filipe Manana (2):
> [N]      [8dad086a4701] btrfs: test power failure after fsync and rename exchanging directories
> [U]      [e0ded76267f9] fsx: add missing -T option to getopt_long()
> 
> Jaegeuk Kim (1):
> [U]      [096adc20b3df] f2fs/015: Test correct mkfs options for error cases
> 
> Luca Di Maio (1):
> [N]      [69cd20bd0498] xfs: test reproducible builds
> 
> Nirjhar Roy (IBM) (1):
> [U]      [725b08a6d61a] generic/371: Fix the test to be compatible block sizes upto 64k
> 
> Ojaswin Mujoo (1):
> [U]      [a4dbdc5486b4] generic/108: fix test hand upon failure to create LV
> 
> Qu Wenruo (2):
> [U]      [8d2e1bd3d294] fstests: btrfs/131: add explicit v1 space cache requirement
> [N]      [bc74aaf6859c] fstests: btrfs: add a new test case that is future-proof
> 
> Viacheslav Dubeyko (1):
> [U]      [facf3325d90d] xfstests: hfs/hfsplus don't support metadata journaling
> 
> caokewu (1):
> [U]      [42c2ccaf3700] ext4/307: allocate donor file size dynamically
> 
> 
> Code Diffstat:
> 
>  common/btrfs                     |  25 ++++++
>  common/rc                        |   2 +-
>  common/xfs                       |   3 +
>  ltp/fsstress.c                   |   5 +-
>  ltp/fsx.c                        |   7 +-
>  tests/btrfs/131                  |  12 ++-
>  tests/btrfs/341                  |  73 ++++++++++++++++
>  tests/btrfs/341.out              |  15 ++++
>  tests/btrfs/342                  | 103 +++++++++++++++++++++++
>  tests/btrfs/342.out              |  15 ++++
>  tests/ext4/307                   |   5 +-
>  tests/f2fs/015                   |  10 ++-
>  tests/f2fs/015.out               |  92 ++++++++++----------
>  tests/generic/108                |   7 +-
>  tests/generic/371                |   2 +-
>  tests/xfs/614                    |   1 +
>  tests/xfs/614.cfg                |   4 +
>  tests/xfs/614.out.lba1024_parent | 177 +++++++++++++++++++++++++++++++++++++++
>  tests/xfs/614.out.lba2048_parent | 177 +++++++++++++++++++++++++++++++++++++++
>  tests/xfs/614.out.lba4096_parent | 177 +++++++++++++++++++++++++++++++++++++++
>  tests/xfs/614.out.lba512_parent  | 177 +++++++++++++++++++++++++++++++++++++++
>  tests/xfs/841                    | 173 ++++++++++++++++++++++++++++++++++++++
>  tests/xfs/841.out                |   3 +
>  23 files changed, 1205 insertions(+), 60 deletions(-)
> --
> Zorro Lang
> zlang@kernel.org


