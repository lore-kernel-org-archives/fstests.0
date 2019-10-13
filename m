Return-Path: <SRS0=0vMW=YG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E6EC4CECE
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Oct 2019 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2033C206A3
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Oct 2019 12:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftNvx92F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfJMMLy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Oct 2019 08:11:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39578 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfJMMLy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Oct 2019 08:11:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so8453695pgj.6
        for <fstests@vger.kernel.org>; Sun, 13 Oct 2019 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ulpu5JMAtik3bzwzhiPP38JegRDQoP/6MAjGe4cQk9w=;
        b=ftNvx92F7GMDYtR3t/P7OPHCY8TmLcbJH7zrQIvj5T/TsHVZL8LO30LISftfKYjVR7
         wlclvZ1aX8sfhpEB3krJy2kuo2kc8PI88cfZzl7pVK/46Opl9SnSUq+sHR9GDrDjKIOX
         Yb4wSrltMNXSvwxrAff7VDPQazppxZBWrLX92/T2dfTrTnGOjdw7R/ru0sc6qm9eYxFg
         pCyQkeHN8n7Cx8ZK+Uia3Fq7rFOlYkxcZXdTQPzSfkUzs0PuMNlgfJ009jpRhNBft4cp
         NMoU4funxqmh6WvZcIDqcjWe5rYdV3ff6HIUaTPa2n5YbISkDtv/Tl7WMTQYpdHr9teu
         XsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ulpu5JMAtik3bzwzhiPP38JegRDQoP/6MAjGe4cQk9w=;
        b=UaJ6wUZHIDlwMot0MgpE4ZtWmsbgoMqjI2RUFhvNvUcjRQeeRvunvs25SvmciO0npF
         xGASYZkMef7j2lh/EUmnpLUiIJl0BAOj/OVIGRPXf91hOMcrRtwrpWz4FLfAlvAtQIAU
         FUVfo5UIbzItLO7329JfSB5bBFFIblVs5j6yUl4HMAKNxXW1YN5LMX++KUpCVV5zuKYd
         SNsf2+UCgJVan5Puh0GMfad0C0gOM1YQ2vz15lOHinCt+CRpaWaAyRBhyBxcgfZJ9JyZ
         j+OaDBxkh1olJwcM9uzXN0pm0sTspeZo2zcDbaOm//8hCgkSkM0O/Khi40pr5ehDuHMQ
         Lz2g==
X-Gm-Message-State: APjAAAWL0q6yWWJTEWBHmzdsbtn+JHMbwX41YQFlcN2hsAtU1wbvn9tJ
        DFwgLuaY2fVn45Nrd6OVq6fqs7rZ
X-Google-Smtp-Source: APXvYqw46ggYV/cqc9WHRilZi4gDmkHwpR51w6P3e2cSKdxMoMO2U8rDpNjPZbD3MoGVy3k0a2IKtg==
X-Received: by 2002:a62:305:: with SMTP id 5mr26669679pfd.67.1570968713617;
        Sun, 13 Oct 2019 05:11:53 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id x72sm21616841pfc.89.2019.10.13.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 05:11:51 -0700 (PDT)
Date:   Sun, 13 Oct 2019 20:11:37 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v2] generic: check reflink multiple mmap write
Message-ID: <20191013121134.GG2622@desktop>
References: <20191010041440.GH13097@magnolia>
 <20191011214120.GI13097@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011214120.GI13097@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 11, 2019 at 02:41:20PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Add a test to make sure that we can handle multiple memory mappings to a
> physical storage extent shared by multiple files, and that we can handle
> the copy on write operation without error.  Make sure we can also handle
> mappings at different offsets in the page cache.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
> v2: test at different offsets
> ---
>  src/Makefile                |    2 -
>  src/mmap-write-concurrent.c |  155 +++++++++++++++++++++++++++++++++++++++++++

I added an entry in .gitignore file.

>  tests/generic/945           |  104 +++++++++++++++++++++++++++++
>  tests/generic/945.out       |   31 +++++++++
>  tests/generic/group         |    1 
>  5 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 src/mmap-write-concurrent.c
>  create mode 100755 tests/generic/945
>  create mode 100644 tests/generic/945.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index ef7cfa63..5bc33e77 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -16,7 +16,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
>  	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
>  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> -	t_ofd_locks t_locks_execve t_mmap_collision
> +	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/mmap-write-concurrent.c b/src/mmap-write-concurrent.c
> new file mode 100644
> index 00000000..38364de8
> --- /dev/null
> +++ b/src/mmap-write-concurrent.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-or-newer
> +/*
> + * Copyright (c) 2019 Oracle.
> + * All Rights Reserved.
> + *
> + * Create writable mappings to multiple files and write them all to test
> + * concurrent mmap writes to the same shared blocks.
> + */
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +struct file_info {
> +	char			*mapping;
> +	off_t			file_offset;
> +	off_t			file_length;
> +	int			fd;
> +};
> +
> +int
> +main(
> +	int			argc,
> +	char			*argv[])
> +{
> +	struct file_info	*fi;
> +	size_t			length;
> +	char			*endptr;
> +	unsigned int		nr_files;
> +	unsigned int		i;
> +	char			*buf;
> +	int			ret;
> +
> +	if (argc < 4) {
> +		printf("Usage: %s len offset file [offset file]...\n", argv[0]);
> +		return 1;
> +	}
> +
> +	/* Parse mwrite length. */
> +	errno = 0;
> +	length = strtoul(argv[1], &endptr, 0);
> +	if (errno) {
> +		perror(argv[1]);
> +		return 1;
> +	}
> +	if (*endptr != '\0') {
> +		fprintf(stderr, "%s: not a proper file length?\n", argv[2]);
> +		return 1;
> +	}
> +
> +	/* Allocate file info */
> +	nr_files = (argc - 2) / 2;
> +
> +	fi = calloc(nr_files, sizeof(struct file_info));
> +	if (!fi) {
> +		perror("calloc file info");
> +		return 1;
> +	}
> +
> +	buf = malloc(length);
> +	if (!buf) {
> +		perror("malloc buf");
> +		return 1;
> +	}
> +
> +	for (i = 0; i < nr_files; i++) {
> +		struct stat	statbuf;
> +		char		*offset = argv[((i + 1) * 2)];
> +		char		*fname = argv[((i + 1) * 2) + 1];
> +
> +		/* Open file, create mapping for the range we want. */
> +		fi[i].fd = open(fname, O_RDWR);
> +		if (fi[i].fd < 0) {
> +			perror(fname);
> +			return 1;
> +		}
> +
> +		/* Parse mwrite offset */
> +		errno = 0;
> +		fi[i].file_offset = strtoul(offset, &endptr, 0);
> +		if (errno) {
> +			perror(argv[1]);
> +			return 1;
> +		}
> +
> +		/* Remember file size */
> +		ret = fstat(fi[i].fd, &statbuf);
> +		if (ret) {
> +			perror(fname);
> +			return 1;
> +		}
> +		fi[i].file_length = statbuf.st_size;
> +
> +		if (fi[i].file_offset + length > fi[i].file_length) {
> +			fprintf(stderr, "%s: file must be %llu bytes\n",
> +				fname,
> +				(unsigned long long)fi[i].file_offset + length);
> +			return 1;
> +		}
> +
> +		/* Create the mapping */
> +		fi[i].mapping = mmap(NULL, fi[i].file_length,
> +				PROT_READ | PROT_WRITE, MAP_SHARED,
> +				fi[i].fd, 0);
> +		if (fi[i].mapping == MAP_FAILED) {
> +			perror(fname);
> +			return 1;
> +		}
> +
> +		/*
> +		 * Make sure the mapping for region we're going to write is
> +		 * already populated in the page cache.
> +		 */
> +		memcpy(buf, fi[i].mapping + fi[i].file_offset, length);
> +	}
> +
> +	/* Dirty the same region in each file to test COW. */
> +	for (i = 0; i < nr_files; i++) {
> +		memset(buf, 0x62 + i, length);
> +		memcpy(fi[i].mapping + fi[i].file_offset, buf, length);
> +	}
> +	for (i = 0; i < nr_files; i++) {
> +		ret = msync(fi[i].mapping, fi[i].file_offset + length, MS_SYNC);
> +		if (ret) {
> +			perror("msync");
> +			return 1;
> +		}
> +	}
> +
> +	/* Close everything. */
> +	for (i = 0; i < nr_files; i++) {
> +		ret = munmap(fi[i].mapping, fi[i].file_length);
> +		if (ret) {
> +			perror("munmap");
> +			return 1;
> +		}
> +
> +		ret = close(fi[i].fd);
> +		if (ret) {
> +			perror("close");
> +			return 1;
> +		}
> +	}
> +
> +	/* Free everything. */
> +	free(buf);
> +	free(fi);
> +
> +	return 0;
> +}
> diff --git a/tests/generic/945 b/tests/generic/945
> new file mode 100755
> index 00000000..38b5883c
> --- /dev/null
> +++ b/tests/generic/945
> @@ -0,0 +1,104 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-newer
> +# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
> +#
> +# FS QA Test No. 945
> +#
> +# Make sure that we can handle multiple mmap writers to the same file.
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.* $testdir
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_supported_os Linux
> +_supported_fs generic
> +_require_command "$FILEFRAG_PROG" filefrag

Also added

_require_test_program "mmap-write-concurrent"

> +_require_test_reflink
> +_require_cp_reflink
> +
> +rm -f $seqres.full
> +
> +compare() {
> +	for i in $(seq 1 8); do
> +		md5sum $testdir/file$i | _filter_test_dir
> +		echo $testdir/file$i >> $seqres.full
> +		od -tx1 -Ad -c $testdir/file$i >> $seqres.full
> +	done
> +}
> +
> +testdir=$TEST_DIR/test-$seq
> +rm -rf $testdir
> +mkdir $testdir
> +
> +echo "Create the original files"
> +blksz=65536
> +filesz=$((blksz * 4))
> +_pwrite_byte 0x61 0 $filesz $testdir/file1 >> $seqres.full
> +_cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
> +_cp_reflink $testdir/file1 $testdir/file3 >> $seqres.full
> +_cp_reflink $testdir/file1 $testdir/file4 >> $seqres.full
> +_reflink_range $testdir/file1 0 $testdir/file5 $blksz $filesz >> $seqres.full
> +_reflink_range $testdir/file1 0 $testdir/file6 $((blksz * 2)) $filesz >> $seqres.full
> +_reflink_range $testdir/file1 0 $testdir/file7 $((blksz * 3)) $filesz >> $seqres.full
> +_reflink_range $testdir/file1 0 $testdir/file8 $((blksz * 4)) $filesz >> $seqres.full
> +_test_cycle_mount
> +
> +echo "Compare files before cow" | tee -a $seqres.full
> +compare
> +
> +echo "mwrite all copies" | tee -a $seqres.full
> +off=$(( (filesz / 2) - 168 ))
> +len=337
> +./src/mmap-write-concurrent $len \

And used "$here/src/mmap-write-concurrent .." here.

Thanks,
Eryu

> +		$off $testdir/file1 \
> +		$off $testdir/file2 \
> +		$off $testdir/file3 \
> +		$off $testdir/file4 \
> +		$((off + blksz)) $testdir/file5 \
> +		$((off + (blksz * 2))) $testdir/file6 \
> +		$((off + (blksz * 3))) $testdir/file7 \
> +		$((off + (blksz * 4))) $testdir/file8 \
> +		168 $testdir/file1 \
> +		$((blksz - 168)) $testdir/file2 \
> +		$((filesz - 777)) $testdir/file3 \
> +		$(((blksz * 3) - 168)) $testdir/file4 \
> +
> +
> +echo "Compare files before remount" | tee -a $seqres.full
> +compare
> +_test_cycle_mount
> +
> +echo "Compare files after remount" | tee -a $seqres.full
> +compare
> +
> +echo "Check for non-shared extents" | tee -a $seqres.full
> +$FILEFRAG_PROG -v $testdir/file1 $testdir/file2 $testdir/file3 $testdir/file4 \
> +		  $testdir/file5 $testdir/file6 $testdir/file7 $testdir/file8 \
> +		  | grep '^[[:space:]]*[0-9]*:' > $testdir/fiemap
> +cat $testdir/fiemap >> $seqres.full
> +grep -q 'shared' $testdir/fiemap || \
> +		echo "Expected to find shared extents"
> +
> +grep -q -v 'shared' $testdir/fiemap || \
> +		echo "Expected to find non-shared extents"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/945.out b/tests/generic/945.out
> new file mode 100644
> index 00000000..ad1e21ff
> --- /dev/null
> +++ b/tests/generic/945.out
> @@ -0,0 +1,31 @@
> +QA output created by 945
> +Create the original files
> +Compare files before cow
> +c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file1
> +c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file2
> +c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file3
> +c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file4
> +74e6b9b1a03fdf09293c089b002800f8  TEST_DIR/test-945/file5
> +c14f20b97155e3fc11a17532d02ad9df  TEST_DIR/test-945/file6
> +22eb46e0f4a3742c8d86346845b7bc80  TEST_DIR/test-945/file7
> +4d292f06cec9d3f1bece4822cd5ef532  TEST_DIR/test-945/file8
> +mwrite all copies
> +Compare files before remount
> +c1b46135a2620ae6da21bbfd4cbb3cba  TEST_DIR/test-945/file1
> +16f0bc0f97c42d2ad903c519095b8126  TEST_DIR/test-945/file2
> +eb71e3135ca2abf33bb9081e2b49a876  TEST_DIR/test-945/file3
> +2678dfcb77bed4dc29e19836bef82e5b  TEST_DIR/test-945/file4
> +2802d75dbee4f29d62124aa7b473edca  TEST_DIR/test-945/file5
> +acd58cf3d33ef905e26800a0e049223c  TEST_DIR/test-945/file6
> +1b68d203e5a1c1b45a9510bedcd1e126  TEST_DIR/test-945/file7
> +9479709b697ced2e3a57c17bc1b97373  TEST_DIR/test-945/file8
> +Compare files after remount
> +c1b46135a2620ae6da21bbfd4cbb3cba  TEST_DIR/test-945/file1
> +16f0bc0f97c42d2ad903c519095b8126  TEST_DIR/test-945/file2
> +eb71e3135ca2abf33bb9081e2b49a876  TEST_DIR/test-945/file3
> +2678dfcb77bed4dc29e19836bef82e5b  TEST_DIR/test-945/file4
> +2802d75dbee4f29d62124aa7b473edca  TEST_DIR/test-945/file5
> +acd58cf3d33ef905e26800a0e049223c  TEST_DIR/test-945/file6
> +1b68d203e5a1c1b45a9510bedcd1e126  TEST_DIR/test-945/file7
> +9479709b697ced2e3a57c17bc1b97373  TEST_DIR/test-945/file8
> +Check for non-shared extents
> diff --git a/tests/generic/group b/tests/generic/group
> index 4584667f..f77c5b21 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -576,3 +576,4 @@
>  715 dangerous_norepair
>  716 dangerous_norepair
>  720 dangerous_norepair
> +945 auto quick rw clone
