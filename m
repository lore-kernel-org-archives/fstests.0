Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55661C62A7
	for <fstests@vger.kernel.org>; Mon,  2 Sep 2024 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725308945; cv=none; b=fkyjs0/ZYwmT44qY3bszr056Xc4CCgNtmXFPKrfTyHjmdexyZrLYpU+Ozegf8ZM3BNbplPLQwTBe1MtqaL1FUvFRhA9taf8pFp698r+TDyVyt6t/uJpA6xlct6pFBwpfevB4nWzsFDgSiU0CWmcqg4l35F5YqM9rQbfEIoHpQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725308945; c=relaxed/simple;
	bh=B7pgfp0rgneqQS+fW0L5EA0TRioNToknLbVWYMLeBgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp3NfxuGCodDxp0u75DZTUkvBgWQbxBdExe9cxpZQly978bUaiZkqB15oLKVMEOrDAuNNsSUfjLNuiYIzt9GGdd2vdUR9Kg4YJ8+W7GxT74vwuP5lAJTYLiOOalzHQdz/R6Scjp/V718//LgV9HMwquhf1POwQX0PSkQiks1wiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2HVqWpW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2HVqWpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725308942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flUQvceHWYvWJu5TvXF9cv66uET2sp2iMxqNVK07/z0=;
	b=i2HVqWpWGJ325qJ62bFjw4Kf05+FdBIyTDdFBKHgSsOBbacG+vp0j1fNuMs6+VTYApnqMw
	WnJEN8OeivJ9ODGz/2qF/stZ/CIVohp3z93LNhMYdQ+nCSZTmrEfVT8fEx5LI5jFv6DKjL
	uX3nH8QMn3hr4C9Zi6rff1MJLFHuYEw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-UgIyNsoUPMuHLOc7o67AdQ-1; Mon, 02 Sep 2024 16:29:01 -0400
X-MC-Unique: UgIyNsoUPMuHLOc7o67AdQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7d235d55c41so4256826a12.0
        for <fstests@vger.kernel.org>; Mon, 02 Sep 2024 13:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725308940; x=1725913740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flUQvceHWYvWJu5TvXF9cv66uET2sp2iMxqNVK07/z0=;
        b=eUBsxPbE5dWfyHlo0NbfjJGoTtvafARVWlQVo3yjuuQWytBkvxM95uzXxmm3noL4I1
         YFLXlRgJ1MfugIY4whi5NrrhcbxTM+9P0tXo3dzvpZGUn7jK/jlQQu5vPoiGeCtsXpsd
         00gUGBFwj44RR7MS9XBgYyzh/vNlfidzD39KKEGMKRi+gp2Ve7eRgU5jCC11BOL0ZaX3
         VQDOY9IW7DTd93218dAP8rkQT+wSKBtxZMkiSkK4756GaksL5oEip2FJX6La32HPfsxK
         SC/7d8rasYxIGxcX9WQb/sSk5RONe/Lqj/EiR+5Jkri4RJWtJOuJMwPGTmuqrGue0U5L
         95hQ==
X-Gm-Message-State: AOJu0YzsUYZgHcddoj/68K7K2uv+iF1CTJxsiPEDPG88osMPujg2YYmm
	ro6cO9TWS57B9xgfIS61gmGLHnP8E8QEKyF1ZZdO664gUUkbYYvaRkGN2ba1XVsGZfU1x35zlD1
	MDLM7kPRbOc8+OlBXPw8TXSo5i6ftE05DzZisXiZFygDhTDvHPMj9J38=
X-Received: by 2002:a17:902:d50a:b0:205:68a4:b2d9 with SMTP id d9443c01a7336-20584223126mr28396635ad.48.1725308940245;
        Mon, 02 Sep 2024 13:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT2jP3Oj5ef3trAlqYXeyf8tmtllid/OQRbfdFg9cMDH3PEaH0i7uNt0/Ux6rQBtFzGwvA3Q==
X-Received: by 2002:a17:902:d50a:b0:205:68a4:b2d9 with SMTP id d9443c01a7336-20584223126mr28396445ad.48.1725308939645;
        Mon, 02 Sep 2024 13:28:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd4dbsm69581265ad.64.2024.09.02.13.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 13:28:59 -0700 (PDT)
Date: Tue, 3 Sep 2024 04:28:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test concurrent direct IO writes and fsync
 using same fd
Message-ID: <20240902202856.e5mqgsbwmiwxs4qe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <fa20c58b1a711d9da9899b895a5237f8737163af.1724972803.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa20c58b1a711d9da9899b895a5237f8737163af.1724972803.git.fdmanana@suse.com>

On Fri, Aug 30, 2024 at 12:10:21AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that a program that has 2 threads using the same file descriptor and
> concurrently doing direct IO writes and fsync doesn't trigger any crash
> or deadlock.
> 
> This is motivated by a bug found in btrfs fixed by the following patch:
> 
>   "btrfs: fix race between direct IO write and fsync when using same fd"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  .gitignore                    |   1 +
>  src/Makefile                  |   2 +-
>  src/dio-write-fsync-same-fd.c | 106 ++++++++++++++++++++++++++++++++++
>  tests/generic/363             |  30 ++++++++++
>  tests/generic/363.out         |   2 +
>  5 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 src/dio-write-fsync-same-fd.c
>  create mode 100755 tests/generic/363
>  create mode 100644 tests/generic/363.out
> 
> diff --git a/.gitignore b/.gitignore
> index 36083e9d..57519263 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -76,6 +76,7 @@ tags
>  /src/dio-buf-fault
>  /src/dio-interleaved
>  /src/dio-invalidate-cache
> +/src/dio-write-fsync-same-fd
>  /src/dirhash_collide
>  /src/dirperf
>  /src/dirstress
> diff --git a/src/Makefile b/src/Makefile
> index b3da59a0..b9ad6b5f 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -20,7 +20,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> -	readdir-while-renames dio-append-buf-fault
> +	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/dio-write-fsync-same-fd.c b/src/dio-write-fsync-same-fd.c
> new file mode 100644
> index 00000000..79472a9e
> --- /dev/null
> +++ b/src/dio-write-fsync-same-fd.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
> + */
> +
> +/*
> + * Test two threads working with the same file descriptor, one doing direct IO
> + * writes into the file and the other just doing fsync calls. We want to verify
> + * that there are no crashes or deadlocks.
> + *
> + * This program never finishes, it starts two infinite loops to write and fsync
> + * the file. It's meant to be called with the 'timeout' program from coreutils.
> + */
> +
> +/* Get the O_DIRECT definition. */
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <pthread.h>
> +
> +static int fd;
> +
> +static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
> +{
> +        while (count > 0) {
> +		ssize_t ret;
> +
> +		ret = pwrite(fd, buf, count, offset);
> +		if (ret < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			return ret;
> +		}
> +		count -= ret;
> +		buf += ret;
> +	}
> +	return 0;
> +}
> +
> +static void *fsync_loop(void *arg)
> +{
> +	while (1) {
> +		int ret;
> +
> +		ret = fsync(fd);
> +		if (ret != 0) {
> +			perror("Fsync failed");
> +			exit(6);
> +		}
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	long pagesize;
> +	void *write_buf;
> +	pthread_t fsyncer;
> +	int ret;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> +		return 1;
> +	}
> +
> +	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT, 0666);
> +	if (fd == -1) {
> +		perror("Failed to open/create file");
> +		return 1;
> +	}
> +
> +	pagesize = sysconf(_SC_PAGE_SIZE);
> +	if (pagesize == -1) {
> +		perror("Failed to get page size");
> +		return 2;
> +	}
> +
> +	ret = posix_memalign(&write_buf, pagesize, pagesize);
> +	if (ret) {
> +		perror("Failed to allocate buffer");
> +		return 3;
> +	}
> +
> +	ret = pthread_create(&fsyncer, NULL, fsync_loop, NULL);
> +	if (ret != 0) {
> +		fprintf(stderr, "Failed to create writer thread: %d\n", ret);
> +		return 4;
> +	}
> +
> +	while (1) {
> +		ret = do_write(fd, write_buf, pagesize, 0);
> +		if (ret != 0) {
> +			perror("Write failed");
> +			exit(5);
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/tests/generic/363 b/tests/generic/363
> new file mode 100755
> index 00000000..21159e24
> --- /dev/null
> +++ b/tests/generic/363
> @@ -0,0 +1,30 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 363
> +#
> +# Test that a program that has 2 threads using the same file descriptor and
> +# concurrently doing direct IO writes and fsync doesn't trigger any crash or
> +# deadlock.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_require_test
> +_require_odirect
> +_require_test_program dio-write-fsync-same-fd
> +_require_command "$TIMEOUT_PROG" timeout
> +
> +[ $FSTYP == "btrfs" ] && \
> +	_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix race between direct IO write and fsync when using same fd"
> +
> +# On error the test program writes messages to stderr, causing a golden output
> +# mismatch and making the test fail.
> +$TIMEOUT_PROG 10s $here/src/dio-write-fsync-same-fd $TEST_DIR/dio-write-fsync-same-fd

Hi Filipe,

Thanks for this new test case. How reproducible is this test? I tried to run it on
a linux v6.11-rc3+ without above kernel fix, but test passed. Does this reproducer
need some specical test conditions?

  # ./check -s default generic/363
  SECTION       -- default
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 dell-xxxxx-xx 6.11.0-0.rc3.20240814git6b0f8db921ab.32.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 14 16:46:57 UTC 2024
  MKFS_OPTIONS  -- /dev/sda6
  MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/scratch

  generic/363 10s ...  10s
  Ran: generic/363
  Passed all 1 test

Thanks,
Zorro

> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/363.out b/tests/generic/363.out
> new file mode 100644
> index 00000000..d03d2dc2
> --- /dev/null
> +++ b/tests/generic/363.out
> @@ -0,0 +1,2 @@
> +QA output created by 363
> +Silence is golden
> -- 
> 2.43.0
> 
> 

