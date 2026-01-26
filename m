Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F11DE3DC
	for <fstests@vger.kernel.org>; Mon, 26 Jan 2026 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456508; cv=none; b=Mo7PiuFIsKy9kVpRqJdL1qnCt/OhK6/4FfTUucF+3hb/gEzPLhMTqQmI8GLfy8hfgHTo0+qk46Gie+HsnZbfQMIX6ZvwFlA9negYby6ucQKQEkOe2d9d+Q9A8t3TdQcRBw84+2yf9uK3OS7UxIhemgY4XXm+uI5HU0116ondhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456508; c=relaxed/simple;
	bh=7jH9Hlf6uUw+CjYs49bkJJdMdTbj5TBWtC/6rhjT1tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0UcIzbGPwQi+3fNuiOVKNc8YFjpARtEetBvwfe8e5Vtj/RXiBq0gWYwQs3eZw75llILmPM3B2UGEJx9m6KNAkXtfg2pOdVBnVwRwf+meLCSijUagfsR8JF0WI3GrwpgZxUhvBJMQEPVouCKpOoRFdPVsETEP4fv2a2bT4+N+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU0/tCCg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU0/tCCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFCEC116C6;
	Mon, 26 Jan 2026 19:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769456507;
	bh=7jH9Hlf6uUw+CjYs49bkJJdMdTbj5TBWtC/6rhjT1tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OU0/tCCg1bdwNgIh10vxr1lIcUtTgrBbTAEiitXqaYocxFO0qvcP6kL0V1J2qB2h7
	 OBibFrY81/fUWkoEe0XSNhTVu6I3hY/jXCJu+2iCwHbrZsNDJ4JhLn7kAk57jTUlXq
	 nu6Qng6aFs32t8rCGib2qkay0g0oBB3biObpNhH6yELYxT6yYdYQ2AnZiM6i/Ot6Vd
	 LrxKMtx2H79v5szVgzPeUQ4wbQICLvpH7CLdC/kqiJzCcNxeYmTm5yVoTpc/4bEVQp
	 GxOH09h6zJFE7ubdNXhOjIvFEYHVuupVIvdzO4ib0HSdcyP+uh60mlB9wwKlsyX6d+
	 GKBaEmyoLKczg==
Date: Mon, 26 Jan 2026 11:41:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, ebiggers@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: test that truncate(2) on fsverity is blocked
Message-ID: <20260126194146.GB5916@frogsfrogsfrogs>
References: <20260126130927.11585-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126130927.11585-1-hch@lst.de>

On Mon, Jan 26, 2026 at 02:08:43PM +0100, Christoph Hellwig wrote:
> truncate(2) doesn't go through open and needs special code to block
> it on fsverity files.  btrfs was missing this check.
> 
> Note that truncate(2) in current core utils uses openat and ftruncate,
> so add our own little test program for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v1:
>  - add the new binary to .gitignore
>  - add a _require_test_program "truncate" call
>  - drop the _require_test call

I'm surprised that xfs_io doesn't have a truncate() wrapper but indeed
it does not.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/truncate.c        | 17 +++++++++++++++++
>  tests/generic/788     | 38 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/788.out |  4 ++++
>  5 files changed, 61 insertions(+), 1 deletion(-)
>  create mode 100644 src/truncate.c
>  create mode 100755 tests/generic/788
>  create mode 100644 tests/generic/788.out
> 
> diff --git a/.gitignore b/.gitignore
> index 82c57f415301..2b5bedd59fce 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -212,6 +212,7 @@ tags
>  /src/dio-writeback-race
>  /src/unlink-fsync
>  /src/file_attr
> +/src/truncate
>  
>  # Symlinked files
>  /tests/generic/035.out
> diff --git a/src/Makefile b/src/Makefile
> index d0a4106e6be8..577d816ae859 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
>  	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> -	dio-writeback-race unlink-fsync
> +	dio-writeback-race unlink-fsync truncate
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/truncate.c b/src/truncate.c
> new file mode 100644
> index 000000000000..4c106d26f29e
> --- /dev/null
> +++ b/src/truncate.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2026 Christoph Hellwig.
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +int main(int argc, char **argv)
> +{
> +	if (truncate(argv[1], 0) < 0) {
> +		perror("truncate");
> +		exit(1);
> +	}
> +
> +	fprintf(stderr, "truncate succeeded\n");
> +}
> diff --git a/tests/generic/788 b/tests/generic/788
> new file mode 100755
> index 000000000000..ac4720d740f0
> --- /dev/null
> +++ b/tests/generic/788
> @@ -0,0 +1,38 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Christoph Hellwig.
> +#
> +# FS QA Test 788
> +#
> +# Test that truncate(2) is blocked on fsverity files.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick verity
> +
> +_cleanup()
> +{
> +	cd /
> +	_restore_fsverity_signatures
> +	rm -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/verity
> +
> +_require_scratch_verity
> +_require_test_program "truncate"
> +
> +_disable_fsverity_signatures
> +
> +_scratch_mkfs_verity &>> $seqres.full
> +_scratch_mount
> +
> +fsv_file=$SCRATCH_MNT/file.fsv
> +
> +_fsv_scratch_begin_subtest "Using truncate(2) on a verity file fails"
> +_fsv_create_enable_file $fsv_file
> +$here/src/truncate $fsv_file
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/788.out b/tests/generic/788.out
> new file mode 100644
> index 000000000000..11074b71f3eb
> --- /dev/null
> +++ b/tests/generic/788.out
> @@ -0,0 +1,4 @@
> +QA output created by 788
> +
> +# Using truncate(2) on a verity file fails
> +truncate: Operation not permitted
> -- 
> 2.47.3
> 
> 
