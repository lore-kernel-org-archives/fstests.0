Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C62C15B8
	for <fstests@vger.kernel.org>; Sat,  1 Nov 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762012667; cv=none; b=CRiDAp/NiryQWGvYcbTMvDPSwznE9X1dY/sutqTas0rcSrqn3evhe7Nhe5lLrmdB1ZIcAUzRDNms+UlyENxxPg6meIVn7gCWkZJNk/119ewogue+ed0amBwzsFfEYyw91T1fLChBh+RljaJtobfJtPCQ3EdlpLPXI8n3PzSDa5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762012667; c=relaxed/simple;
	bh=tQLVICur2OYCEXV/ZK2B6w5quptySiEeZMJB0iV7NSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWarxmwg+G5NISViLX+GpFUzyVFb2FH8i2TTxlX+Ewd9b43adKEwYR2OkwOVg5YLMVg0LW7xg+diyprUhoxIqZ8ZUxG2D/XD6jHBjEWdNgKKmdDi2lsd707N2sTIqgU+Xf29Wm2/iLkyyFGGg5NiSqXt3o0NhR6OmSwKNuzdjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMMAFb9i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rzYfdJzl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMMAFb9i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rzYfdJzl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762012664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6SaXTR8ikg8/sj6In22tT3j5YC6erO2Ryl20JXHvn8=;
	b=XMMAFb9iHquoONOGPh1lXwk1V9o3GuUO5UxK6YfY3uwZwIg+LseD51h8TP6C0n+HCV/A9r
	dbPaG/sEji7AHGrUFf5rlCAcMyvWsEoWt9Sy90BmIbnDZ15QRmAp5frXyNX0IAZCIZ3nky
	8pWkBeDjjsY/VK+TkWCEqBSuXxk3iHQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-JUc5ktzHOUaXR6KSECBf7w-1; Sat, 01 Nov 2025 11:57:43 -0400
X-MC-Unique: JUc5ktzHOUaXR6KSECBf7w-1
X-Mimecast-MFC-AGG-ID: JUc5ktzHOUaXR6KSECBf7w_1762012662
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2930e2e8e7fso31603115ad.2
        for <fstests@vger.kernel.org>; Sat, 01 Nov 2025 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762012662; x=1762617462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6SaXTR8ikg8/sj6In22tT3j5YC6erO2Ryl20JXHvn8=;
        b=rzYfdJzld29OiilEgUiUE7WocVIN9k4+0o2TQXj8fCy7KiaxUce4mXfMg4KGR4HO0X
         5/7MFY1fxf7MEyu4QW+/1t29QEa8yVaahXPbGGgV4sOUeSIaIIPh7SWdDqKDZ6DK0Vib
         jfrP9UtGpW1dDRjsTYNEC9yP3BR7Ab8epuSOW+4dzeS+jzATfwoOsIFmX8RKsl2lIUhg
         yYbIpzpAuYqWCm0vyk0DywvY5SYy6lxfncfkO6PoSgfKKbgQiywslmY+C9hxkCMS/xoA
         b24hWb1RbwjN9cq50HM8bf5M+VaZ3oo/7cOemh0OJlfCUwihsctvvaKiruAUajL41A6E
         8XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762012662; x=1762617462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6SaXTR8ikg8/sj6In22tT3j5YC6erO2Ryl20JXHvn8=;
        b=ATRJ+NlCCFUHpG88WdvgzJFM8nw8F7BQFA71yOmt/7JJAyVs68D5aunlHgL7DqkAw9
         bKre5hnVD3ye5aBAfi81KqTg25JemJmxReMXjrVY6P6L2pkn9l+GIQUcqgK2/ib644lH
         S2UbGHrsqbK0SyhYm30nvPv2W3AETot4LzqfFWAReTHveUYcBi3AoLcktWNRAIa/Qh6z
         S02tPPiWy238Iri3Bjz+rRrKeHPHk7QPA+o5eyFUtwccc0mnCT8MvDpL0F8dGhCZppuq
         LiaWKDczrUM/IJUyIaGdpMRJAGLWTzzbK0uWnNB6Bm0yvScJzrMJFN+uOcALuf+QpEum
         8/og==
X-Forwarded-Encrypted: i=1; AJvYcCWa6cZeDlHqAWuWjyaeRi3u8hamHWFcc8KfpePgvCy2Zp5THkKIMhwRxL+zSMsSwz/BYROfT1B9@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmuInBUAHg+FITO3JRVj6GQXDcBPJzXGv4sNW9z6c+CzhHl8o
	RKl+FkWynzdnXNFRV2dGUTWmM3Ybr29r+2HenliJEKSltTWZU6Z2PpI5wnwJ4qzAV74/6FcRhMd
	34IqlyxQJYyd4Gj/pomTdxfOULF035NepTy3DH5FIET7SQcpnqIJzTseYJS4=
X-Gm-Gg: ASbGncttnaPs58I0aB3RLSnV8EINEqI0hfmXfgVmTq+QTFFe3GN6u8Sm6kKQt55yCKT
	xhZGZ81ePA+Yh3puzxDbkZN+5AFC6bUdJSFn/05j2nQd+o64YkRHFdG0YZxUtQgzhDtecWV7cj5
	HnUpvwwr0Kk3aOESdV9q8gGQNULnBbTepYkNjQkGricLCYJ29y96E9Wg9IFKx1Krg5+d4cVzCke
	tWIPISAOK3sEsq+2dobKar4XRyVBm6nPZOt3igsUwVU1BZHwDlR39rnCzWgZqGZzLN5/Je76REY
	3XTpjfUT1eEJh04hnahr8OW+3d37G8Y2zqb4YW0oG43G9+lHWvUmrHS6VAhCYucRg1rhrx61a2k
	jqU+YPme++ck7EBmJ9pPlHI7gRcNM8zNu1jkXXMc=
X-Received: by 2002:a17:902:ea0e:b0:28e:9427:68f6 with SMTP id d9443c01a7336-2951a3e6517mr97897545ad.27.1762012661785;
        Sat, 01 Nov 2025 08:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmUG25Wb3dzCeU4Aeo1UVvHn8jXbwwm3l56VapHhgUQvQqRgH410zOSC7BLDS4FIKU4VlUhA==
X-Received: by 2002:a17:902:ea0e:b0:28e:9427:68f6 with SMTP id d9443c01a7336-2951a3e6517mr97897275ad.27.1762012661166;
        Sat, 01 Nov 2025 08:57:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2953f35bc28sm42990935ad.109.2025.11.01.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:57:40 -0700 (PDT)
Date: Sat, 1 Nov 2025 23:57:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add a new generic test case to verify direct io
 read
Message-ID: <20251101155702.5e2g42ixg3qvh5b5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250926095013.136988-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926095013.136988-1-wqu@suse.com>

On Fri, Sep 26, 2025 at 07:20:13PM +0930, Qu Wenruo wrote:
> [POSSIBLE PROBLEM]
> For filesystems with data checksum, a user space program can provide a
> block of aligned memory as read buffer, and modify the buffer during the
> read.
> 
> Btrfs used to utilize such memory directly during checksum
> verification, and since the content can be modified by user space, the
> checksum verification can fail easily when such modification happened.
> 
> This will cause a false checksum mismatch alert, and if there is no more
> mirror, the read will fail.
> And even if there is an extra mirror, checksum verification can still
> fail due to user space interference.
> 
> [NEW TEST CASE]
> The new test case is pretty much the same as the existing generic/761,
> utilizing a user space multi-thread program to do a direct read,
> meanwhile modifying the buffer at the same time.
> 
> The new program, dio-read-race, is almost the same, with some changes:
> 
> - O_RDRW flag to open the file
> - Populate the contents of the file
> - Do read and modify
>   Instead of write and modify
> 
> [EXPECTED RESULTS]
> For unpatched kernels, the new test case fails like this:
> 
>  generic/772       - output mismatch (see /home/adam/xfstests/results//generic/772.out.bad)
>      --- tests/generic/772.out	2025-09-26 19:07:37.319000000 +0930
>      +++ /home/adam/xfstests/results//generic/772.out.bad	2025-09-26 19:08:33.873401495 +0930
>      @@ -1,2 +1,3 @@
>       QA output created by 772
>      +io thread failed
>       Silence is golden
>      ...
>      (Run 'diff -u /home/adam/xfstests/tests/generic/772.out /home/adam/xfstests/results//generic/772.out.bad'  to see the entire diff)
> 
>  HINT: You _MAY_ be missing kernel fix:
>        xxxxxxxxxxxx btrfs: fallback to buffered read if the inode has data checksum
> 
> With dmesg recording some checksum mismatch:
> 
>  BTRFS warning (device dm-3): csum failed root 5 ino 257 off 241664 csum 0x13fec125 expected csum 0x8941f998 mirror 1
>  BTRFS error (device dm-3): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>  BTRFS warning (device dm-3): direct IO failed ino 257 op 0x8800 offset 0x3b000 len 4096 err no 10
> 
> For patched kernels, the new test case passes, without any error in
> dmesg:
> 
>  generic/772 6s ...  6s
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

This patch has been there more than 1 month. It works on my side, and
didn't bring in any regressions. I'd like to merge this patch,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  .gitignore            |   1 +
>  src/Makefile          |   2 +-
>  src/dio-read-race.c   | 167 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/772     |  41 +++++++++++
>  tests/generic/772.out |   2 +
>  5 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 src/dio-read-race.c
>  create mode 100755 tests/generic/772
>  create mode 100644 tests/generic/772.out
> 
> diff --git a/.gitignore b/.gitignore
> index 82c57f41..3e950079 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -210,6 +210,7 @@ tags
>  /src/fiemap-fault
>  /src/min_dio_alignment
>  /src/dio-writeback-race
> +/src/dio-read-race
>  /src/unlink-fsync
>  /src/file_attr
>  
> diff --git a/src/Makefile b/src/Makefile
> index 711dbb91..e7dd4db5 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
>  	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> -	dio-writeback-race unlink-fsync
> +	dio-writeback-race dio-read-race unlink-fsync
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/dio-read-race.c b/src/dio-read-race.c
> new file mode 100644
> index 00000000..7c6389e0
> --- /dev/null
> +++ b/src/dio-read-race.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dio-read-race -- test direct IO read with the contents of
> + * the buffer changed during the read, which should not cause any read error.
> + *
> + * Copyright (C) 2025 SUSE Linux Products GmbH.
> + */
> +
> +/*
> + * dio-read-race
> + *
> + * Compile:
> + *
> + *   gcc -Wall -pthread -o dio-read-race dio-read-race.c
> + *
> + * Make sure filesystems with explicit data checksum can handle direct IO
> + * reads correctly, so that even the contents of the direct IO buffer changes
> + * during read, the fs should still work fine without data checksum mismatch.
> + * (Normally by falling back to buffer IO to keep the checksum and contents
> + *  consistent)
> + *
> + * Usage:
> + *
> + *   dio-read-race [-b <buffersize>] [-s <filesize>] <filename>
> + *
> + * Where:
> + *
> + *   <filename> is the name of the test file to create, if the file exists
> + *   it will be overwritten.
> + *
> + *   <buffersize> is the buffer size for direct IO. Users are responsible to
> + *   probe the correct direct IO size and alignment requirement.
> + *   If not specified, the default value will be 4096.
> + *
> + *   <filesize> is the total size of the test file. If not aligned to <blocksize>
> + *   the result file size will be rounded up to <blocksize>.
> + *   If not specified, the default value will be 64MiB.
> + */
> +
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <getopt.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +
> +static int fd = -1;
> +static void *buf = NULL;
> +static unsigned long long filesize = 64 * 1024 * 1024;
> +static int blocksize = 4096;
> +
> +const int orig_pattern = 0x00;
> +const int modify_pattern = 0xff;
> +
> +static void *do_io(void *arg)
> +{
> +	ssize_t ret;
> +
> +	ret = read(fd, buf, blocksize);
> +	pthread_exit((void *)ret);
> +}
> +
> +static void *do_modify(void *arg)
> +{
> +	memset(buf, modify_pattern, blocksize);
> +	pthread_exit(NULL);
> +}
> +
> +int main (int argc, char *argv[])
> +{
> +	pthread_t io_thread;
> +	pthread_t modify_thread;
> +	unsigned long long filepos;
> +	int opt;
> +	int ret = -EINVAL;
> +
> +	while ((opt = getopt(argc, argv, "b:s:")) > 0) {
> +		switch (opt) {
> +		case 'b':
> +			blocksize = atoi(optarg);
> +			if (blocksize == 0) {
> +				fprintf(stderr, "invalid blocksize '%s'\n", optarg);
> +				goto error;
> +			}
> +			break;
> +		case 's':
> +			filesize = atoll(optarg);
> +			if (filesize == 0) {
> +				fprintf(stderr, "invalid filesize '%s'\n", optarg);
> +				goto error;
> +			}
> +			break;
> +		default:
> +			fprintf(stderr, "unknown option '%c'\n", opt);
> +			goto error;
> +		}
> +	}
> +	if (optind >= argc) {
> +		fprintf(stderr, "missing argument\n");
> +		goto error;
> +	}
> +	ret = posix_memalign(&buf, sysconf(_SC_PAGESIZE), blocksize);
> +	if (!buf) {
> +		fprintf(stderr, "failed to allocate aligned memory\n");
> +		exit(EXIT_FAILURE);
> +	}
> +	fd = open(argv[optind], O_DIRECT | O_RDWR | O_CREAT, 0600);
> +	if (fd < 0) {
> +		fprintf(stderr, "failed to open file '%s': %m\n", argv[optind]);
> +		goto error;
> +	}
> +
> +	memset(buf, orig_pattern, blocksize);
> +	/* Create the original file. */
> +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
> +
> +		ret = write(fd, buf, blocksize);
> +		if (ret < 0) {
> +			ret = -errno;
> +			fprintf(stderr, "failed to write the initial content: %m");
> +			goto error;
> +		}
> +	}
> +	ret = lseek(fd, 0, SEEK_SET);
> +	if (ret < 0) {
> +		ret = -errno;
> +		fprintf(stderr, "failed to set file offset to 0: %m");
> +		goto error;
> +	}
> +
> +	/* Do the read race. */
> +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
> +		void *retval = NULL;
> +
> +		memset(buf, orig_pattern, blocksize);
> +		pthread_create(&io_thread, NULL, do_io, NULL);
> +		pthread_create(&modify_thread, NULL, do_modify, NULL);
> +		ret = pthread_join(io_thread, &retval);
> +		if (ret) {
> +			errno = ret;
> +			ret = -ret;
> +			fprintf(stderr, "failed to join io thread: %m\n");
> +			goto error;
> +		}
> +		if ((ssize_t )retval < blocksize) {
> +			ret = -EIO;
> +			fprintf(stderr, "io thread failed\n");
> +			goto error;
> +		}
> +		ret = pthread_join(modify_thread, NULL);
> +		if (ret) {
> +			errno = ret;
> +			ret = -ret;
> +			fprintf(stderr, "failed to join modify thread: %m\n");
> +			goto error;
> +		}
> +	}
> +error:
> +	close(fd);
> +	free(buf);
> +	if (ret < 0)
> +		return EXIT_FAILURE;
> +	return EXIT_SUCCESS;
> +}
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..46593536
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 772
> +#
> +# Making sure direct IO (O_DIRECT) reads won't cause any data checksum mismatch,
> +# even if the contents of the buffer changes during read.
> +#
> +# This is mostly for filesystems with data checksum support, as the content can
> +# be modified by user space during checksum verification.
> +#
> +# To avoid such false alerts, such filesystems should fallback to buffer IO to
> +# avoid inconsistency, and never trust user space memory when checksum is involved.
> +# For filesystems without data checksum support, nothing needs to be bothered.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_require_scratch
> +_require_odirect
> +_require_test_program dio-read-race
> +
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fallback to buffered read if the inode has data checksum"
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +blocksize=$(_get_file_block_size $SCRATCH_MNT)
> +filesize=$(( 64 * 1024 * 1024))
> +
> +echo "blocksize=$blocksize filesize=$filesize" >> $seqres.full
> +
> +$here/src/dio-read-race -b $blocksize -s $filesize $SCRATCH_MNT/foobar
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/772.out b/tests/generic/772.out
> new file mode 100644
> index 00000000..98c13968
> --- /dev/null
> +++ b/tests/generic/772.out
> @@ -0,0 +1,2 @@
> +QA output created by 772
> +Silence is golden
> -- 
> 2.51.0
> 
> 

