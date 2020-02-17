Return-Path: <SRS0=4lTT=4F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC2EC761A4
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 12:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AB220801
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 12:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V37ocGPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgBQMbi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:31:38 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:37171 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgBQMbh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Feb 2020 07:31:37 -0500
Received: by mail-pg1-f172.google.com with SMTP id z12so9087180pgl.4
        for <fstests@vger.kernel.org>; Mon, 17 Feb 2020 04:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ksGHmyr5SSFquIn3nFyF+yMieQW9PDg1b4DaxSzH8Fg=;
        b=V37ocGPUefPDwaY2GEPktYRBYuN6gsPe5JSb5l4duDzfIrZgIh+Lw/ENXwtaVyMhf9
         nHCykMPZH8cdriWi/ZAGWDP9JdDxKzCYiFKlB28yzMaOAzOobAj1ewnrZRPaINl+IS68
         QblgtRclrFU0IdkLG4hkXWbMKMSKOiMGZaXrInE385OwtNzGn0UQbt7BtLpAN+Tvm64G
         qSc0KFFwllXO6l7yOl2hT/nH3yyBByfwt4H0lQdH4YWNIHAlBTa141Vqu8WLJOrJjDCU
         Jn7WLTe5V/qysTP8vhlemo2D2Qo3C6w/dpMJcVHVB6+wvqwKGkHjwy4Ahl71ULgMrekN
         8U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ksGHmyr5SSFquIn3nFyF+yMieQW9PDg1b4DaxSzH8Fg=;
        b=RXz/it2WGSbc9ibegjDplUgu/KhUrphqMqSUY0acLCZCJWoq8AuKoYFNq2yt3VoKXc
         lsfGR5HEhXIrqBLf/4HWULUqLufme61lv/1PuJH/9FXI1MwG2XrQEG2xKkvQ8WBqQ2j+
         c8RzgBq6NxDnTRMWPH4vSF/8paO5J+M+BXYkeBeZsGnZsnd6VhhWmOL5DFBDvfuMZLhe
         jckD+8f8CkH0wYOrKPi5V5WVy1UXGpuYuLuQD1fqUveo+o/hGo89aRuVa+uavjR7CrnX
         Ncg/KZlkXh+3NWJtMXD8VPsgz3XoPXU6l+oxnSXgQ/bUuHhhxPoO3XHCvgbsHTso3OWi
         4+cQ==
X-Gm-Message-State: APjAAAX7FwibZtSl9F+0zZejO1/4zZ2zYHcVnrIkaUnX+GNzcjO+zq8+
        LyrlKB8JrpBZTBm2ojzDYjl/E6Yw
X-Google-Smtp-Source: APXvYqx2ZABnmet1oVqiFnVYoqMly8L8OpOgp5eT3FgpNsJYXLl8UdDIN2Cz4bpspAAcvAJ7eTsJnA==
X-Received: by 2002:a62:15d8:: with SMTP id 207mr16796561pfv.40.1581942696539;
        Mon, 17 Feb 2020 04:31:36 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id z64sm394082pfz.23.2020.02.17.04.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 04:31:35 -0800 (PST)
Date:   Mon, 17 Feb 2020 20:31:30 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     sunyong0511@gmail.com
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        Sun Yong <yosun@suse.com>
Subject: Re: [PATCH v6] fstests: transport two ext4 tests from LTP
Message-ID: <20200217123130.GI2697@desktop>
References: <20200120103453.3906-1-sunyong0511@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120103453.3906-1-sunyong0511@gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 20, 2020 at 06:34:54PM +0800, sunyong0511@gmail.com wrote:
> From: Yong Sun <sunyong0511@gmail.com>
> 
> Recently LTP upstream removed some ext4 tests[1].
> And two of them is still valid to keep. So I transport those two tests here.
> ext4-nsec-timestamps, which is used to test nanosec timestamps of ext4, rewrite into ext4/043 and 044.
> ext4-subdir-limit, which is used to test subdirectory limit of ext4, rewrite into ext4/045.
> 
> [1] https://marc.info/?l=linux-fsdevel&m=157190623919681&w=2
> 
> Signed-off-by: Sun Yong <yosun@suse.com>

Thanks a lot for the 6th revision! But I still have some concerns
below..

> ---
> v2: Correct copyright information
> v3: Correct white-space damage
> v4: Add a missing file
> v5: Fix several issue reviewed by Darrick
> v6: Fix several issue reviewed by Eryu, and remove block setting in ext4/045
> Refer to ext4/045 fail https://www.spinics.net/lists/linux-ext4/msg69467.html
> ---
>  .gitignore                |   3 +
>  src/Makefile              |   3 +-
>  src/t_create_long_dirs.c  | 139 +++++++++++++++++++++++++++++++++++++
>  src/t_create_short_dirs.c | 142 ++++++++++++++++++++++++++++++++++++++

It'd be good to have one program be able to create both long and short
dirs, having two progorams to do similar tasks seems not necessary.

>  src/t_get_file_time.c     |  53 ++++++++++++++
>  tests/ext4/043            |  56 +++++++++++++++
>  tests/ext4/043.out        |   2 +
>  tests/ext4/044            |  87 +++++++++++++++++++++++
>  tests/ext4/044.out        |   2 +
>  tests/ext4/045            | 111 +++++++++++++++++++++++++++++
>  tests/ext4/045.out        |   2 +
>  tests/ext4/group          |   3 +
>  12 files changed, 602 insertions(+), 1 deletion(-)
>  create mode 100644 src/t_create_long_dirs.c
>  create mode 100644 src/t_create_short_dirs.c
>  create mode 100644 src/t_get_file_time.c
>  create mode 100755 tests/ext4/043
>  create mode 100644 tests/ext4/043.out
>  create mode 100755 tests/ext4/044
>  create mode 100644 tests/ext4/044.out
>  create mode 100755 tests/ext4/045
>  create mode 100644 tests/ext4/045.out
> 
> diff --git a/.gitignore b/.gitignore
> index d83df7d2..919f5e2e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -118,6 +118,8 @@
>  /src/swapon
>  /src/t_access_root
>  /src/t_attr_corruption
> +/src/t_create_long_dirs
> +/src/t_create_short_dirs
>  /src/t_dir_offset
>  /src/t_dir_offset2
>  /src/t_dir_type
> @@ -126,6 +128,7 @@
>  /src/t_ext4_dax_journal_corruption
>  /src/t_futimens
>  /src/t_getcwd
> +/src/t_get_file_time
>  /src/t_holes
>  /src/t_immutable
>  /src/t_locks_execve
> diff --git a/src/Makefile b/src/Makefile
> index ce6d8610..0ad8e5d4 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -16,7 +16,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
>  	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
>  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> -	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent
> +	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent \
> +	t_get_file_time t_create_short_dirs t_create_long_dirs
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/t_create_long_dirs.c b/src/t_create_long_dirs.c
> new file mode 100644
> index 00000000..fe5b4b64
> --- /dev/null
> +++ b/src/t_create_long_dirs.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2009 FUJITSU LIMITED
> + * Author: Li Zefan <lizf@cn.fujitsu.com>
> + */
> +
> +#define _POSIX_C_SOURCE 200809L
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <fcntl.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include "config.h"
> +
> +/* NCHARS = 10 + 26 + 26 = 62 */
> +#define NAME_LEN	255
> +#define NCHARS		62
> +#define MAX_LEN1	62
> +#define MAX_LEN2	(62 * 62)
> +#define MAX_LEN3	(62 * 62 * 62)
> +
> +/* valid characters for the directory name */
> +char chars[NCHARS + 1] = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
> +
> +/* to store the generated directory name */
> +char name[NAME_LEN + 1];
> +int names;
> +int parent_fd;
> +
> +/*
> + * init_name - initialize the directory name
> + *
> + * Generate a randomized directory name, and then we generate more
> + * directory names based on it.
> + */
> +void init_name(void)
> +{
> +	int i;
> +
> +	srand(time(NULL));
> +
> +	for (i = 0; i < NAME_LEN; i++)
> +		name[i] = chars[rand() % 62];
> +}
> +
> +void create_dir(void)
> +{
> +	if (mkdirat(parent_fd, name, S_IRWXU)) {
> +		perror("mkdir");
> +		exit(1);
> +	}
> +}
> +
> +/*
> + * create_dirs - create @names directory names
> + * @n: how many names to be created
> + *
> + * if n <= 62,       we need to modify 1 char of the name
> + * if n <= 62*62,    we need to modify 2 chars
> + * if n <= 62*62*62, we need to modify 3 chars
> + */
> +void create_dirs(int n)
> +{
> +	int i, j, k;
> +	int depth;
> +
> +	if (n <= MAX_LEN1)
> +		depth = 1;
> +	else if (n <= MAX_LEN2)
> +		depth = 2;
> +	else
> +		depth = 3;
> +
> +	for (i = 0; i < NCHARS; i++) {
> +		name[0] = chars[i];
> +		if (depth == 1) {
> +			create_dir();
> +			if (--n == 0)
> +				return;
> +			continue;
> +		}
> +
> +		for (j = 0; j < NCHARS; j++) {
> +			name[1] = chars[j];
> +			if (depth == 2) {
> +				create_dir();
> +				if (--n == 0)
> +					return;
> +				continue;
> +			}
> +
> +			for (k = 0; k < NCHARS; k++) {
> +				name[2] = chars[k];
> +				create_dir();
> +				if (--n == 0)
> +					return;
> +			}
> +		}
> +	}
> +}
> +
> +void usage()
> +{
> +	fprintf(stderr, "Usage: create_long_dirs nr_dirs parent_dir\n");
> +}
> +
> +/*
> + * Create long-name directories
> + * @argv[1]: directory number
> + * @argv[2]: parent directory
> + */
> +int main(int argc, char *argv[])
> +{
> +	if (argc != 3) {
> +		usage();
> +		return 1;
> +	}
> +
> +	names = atoi(argv[1]);
> +	if (names > MAX_LEN3 || names <= 0) {
> +		usage();
> +		return 1;
> +	}
> +
> +	parent_fd = open(argv[2], O_RDONLY);
> +	if (parent_fd == -1) {
> +		perror("open parent dir failed");
> +		return 1;
> +	}
> +
> +	init_name();
> +
> +	create_dirs(names);
> +
> +	return 0;
> +}
> diff --git a/src/t_create_short_dirs.c b/src/t_create_short_dirs.c
> new file mode 100644
> index 00000000..778506e1
> --- /dev/null
> +++ b/src/t_create_short_dirs.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2009 FUJITSU LIMITED
> + * Author: Li Zefan <lizf@cn.fujitsu.com>
> + */
> +
> +#define _POSIX_C_SOURCE 200809L
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include "config.h"
> +
> +/* NCHARS = 10 + 26 + 26 = 62 */
> +#define NCHARS      62
> +#define MAX_LEN1    62
> +#define MAX_LEN2    (62 * 62)
> +#define MAX_LEN3    (62 * 62 * 62)
> +#define MAX_NAMES   (MAX_LEN1 + MAX_LEN2 + MAX_LEN3)
> +
> +/* valid characters for a directory name */
> +char chars[] = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
> +
> +/* to store the generated directory name */
> +char name[10];
> +int names;
> +int parent_fd;
> +
> +void create_dir(void)
> +{
> +	if (mkdirat(parent_fd, name, S_IRWXU)) {
> +		perror("mkdir");
> +		exit(1);
> +	}
> +}
> +
> +/*
> + * create_1 - create length-1 directory names
> + * @n: how name names to be created
> + */
> +void create_1(int n)
> +{
> +	int i;
> +
> +	name[1] = '\0';
> +	for (i = 0; i < NCHARS; i++) {
> +		name[0] = chars[i];
> +		create_dir();
> +		if (--n == 0)
> +			return;
> +	}
> +}
> +
> +/*
> + * create_2 - generate length-2 directory names
> + * @n: how many names to be created
> + */
> +void create_2(int n)
> +{
> +	int i, j;
> +
> +	name[2] = '\0';
> +	for (i = 0; i < NCHARS; i++) {
> +		name[0] = chars[i];
> +		for (j = 0; j < NCHARS; j++) {
> +			name[1] = chars[j];
> +			create_dir();
> +			if (--n == 0)
> +				return;
> +		}
> +	}
> +}
> +
> +/*
> + * create_3 - generate length-3 directory names
> + * @n: how many names to be created
> + */
> +void create_3(int n)
> +{
> +	int i, j, k;
> +
> +	name[3] = '\0';
> +	for (i = 0; i < NCHARS; i++) {
> +		name[0] = chars[i];
> +		for (j = 0; j < NCHARS; j++) {
> +			name[1] = chars[j];
> +			for (k = 0; k < NCHARS; k++) {
> +				name[2] = chars[k];
> +				create_dir();
> +				if (--n == 0)
> +					return;
> +			}
> +		}
> +	}
> +}
> +
> +void usage()
> +{
> +	fprintf(stderr, "Usage: create_short_dirs nr_dirs parent_dir\n");
> +}
> +
> +/*
> + * Create short-name directoriess
> + * @argv[1]: director number
> + * @argv[2]: the parent directory
> + */
> +int main(int argc, char *argv[])
> +{
> +	if (argc != 3) {
> +		usage();
> +		return 1;
> +	}
> +
> +	names = atoi(argv[1]);
> +	if (names > MAX_NAMES || names <= 0) {
> +		usage();
> +		return 1;
> +	}
> +
> +	parent_fd = open(argv[2], O_RDONLY);
> +	if (parent_fd == -1) {
> +		perror("open parent dir failed");
> +		return 1;
> +	}
> +
> +	create_1(names);
> +	if (names <= MAX_LEN1)
> +		return 0;
> +
> +	names -= MAX_LEN1;
> +	create_2(names);
> +	if (names <= MAX_LEN2)
> +		return 0;
> +
> +	names -= MAX_LEN2;
> +	create_3(names);
> +
> +	return 0;
> +}
> diff --git a/src/t_get_file_time.c b/src/t_get_file_time.c
> new file mode 100644
> index 00000000..de478170
> --- /dev/null
> +++ b/src/t_get_file_time.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2009 FUJITSU LIMITED
> + * Author: Li Zefan <lizf@cn.fujitsu.com>
> + */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +/*
> + * Usage: t_get_file_time <filename> <atime|mtime|ctime> <sec|nsec>
> + */
> +int main(int argc, char *argv[])
> +{
> +	time_t t;
> +	struct stat st;
> +
> +	if (argc != 4) {
> +		fprintf(stderr, "Wrong argument num!\n");
> +		return 1;
> +	}
> +
> +	if (stat(argv[1], &st) != 0) {
> +		perror("stat failed");
> +		return 1;
> +	}
> +
> +	if (strcmp(argv[3], "sec") == 0) {
> +		if (strcmp(argv[2], "atime") == 0)
> +			t = st.st_atime;
> +		else if (strcmp(argv[2], "mtime") == 0)
> +			t = st.st_mtime;
> +		else
> +			t = st.st_ctime;
> +	} else if (strcmp(argv[3], "nsec") == 0) {
> +		if (strcmp(argv[2], "atime") == 0)
> +			t = st.st_atim.tv_nsec;
> +		else if (strcmp(argv[2], "mtime") == 0)
> +			t = st.st_mtim.tv_nsec;
> +		else
> +			t = st.st_ctim.tv_nsec;
> +	} else {
> +		fprintf(stderr, "Wrong argument: %s\n", argv[3]);
> +		return 1;
> +	}
> +
> +	printf("%lu\n", t);
> +
> +	return 0;
> +}
> diff --git a/tests/ext4/043 b/tests/ext4/043
> new file mode 100755
> index 00000000..b526af42
> --- /dev/null
> +++ b/tests/ext4/043
> @@ -0,0 +1,56 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test No. 043
> +#
> +# Test file timestamps are only precise to seconds with 128-byte inodes."
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext3 ext4
> +_supported_os Linux
> +
> +_require_scratch
> +_require_test_program "t_get_file_time"
> +
> +echo "Silence is golden"
> +
> +echo "Start test timestamps with 128 inode size one device $SCRATCH_DEV" >$seqres.full
> +_scratch_mkfs -I 128 >> $seqres.full 2>&1
> +_scratch_mount
> +
> +touch "${SCRATCH_MNT}/tmp_file"
> +
> +atime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file atime nsec`
> +mtime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> +ctime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> +
> +if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
> +	echo "nsec should be zero when extended timestamps are disabled"
> +	echo "atime: $atime, mtime: $mtime, ctime: $ctime"
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/ext4/043.out b/tests/ext4/043.out
> new file mode 100644
> index 00000000..f90f0a57
> --- /dev/null
> +++ b/tests/ext4/043.out
> @@ -0,0 +1,2 @@
> +QA output created by 043
> +Silence is golden
> diff --git a/tests/ext4/044 b/tests/ext4/044
> new file mode 100755
> index 00000000..b1f7a531
> --- /dev/null
> +++ b/tests/ext4/044
> @@ -0,0 +1,87 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test No. 044
> +#
> +# Test file timestamps are precise to nanoseconds with 256-byte inodes
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_supported_os Linux
> +_require_scratch
> +_require_test_program "t_get_file_time"
> +
> +echo "Silence is golden"
> +
> +echo "Test timestamps with 256 inode size one device $SCRATCH_DEV" >$seqres.full
> +_scratch_mkfs -t ext3 -I 256 >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Create file
> +touch "${SCRATCH_MNT}/tmp_file"
> +sleep 1
> +
> +# Change atime, ctime and mtime of the file
> +touch "${SCRATCH_MNT}/tmp_file"
> +
> +cur_time=`date '+%s %N'`
> +sec=`echo $cur_time | awk {'print $1'}`
> +nsec=`echo $cur_time | awk {'print $2'}`

Use $AWK_PROG instead of bare awk

> +
> +sec_atime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file atime sec`
> +sec_mtime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file mtime sec`
> +sec_ctime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file ctime sec`
> +nsec_atime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file atime nsec`
> +nsec_mtime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> +nsec_ctime=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> +
> +# Test nanosecond
> +if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]; then
> +	echo "The timestamp is not nanosecond(nsec_atime: $nsec_atime, \ 

Trailing whitespace in above line.

> +		nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime, cur_time[ns]: $nsec)"
> +fi
> +
> +# Check difference between file time and current time
> +[ $(( $sec_atime - $sec )) -gt 1 ] && echo "The timestamp is wrong, sec_atime: $sec_atime, cur_time[s]: $sec"
> +[ $(( $sec_mtime - $sec )) -gt 1 ] && echo "The timestamp is wrong, sec_atime: $sec_atime, cur_time[s]: $sec"
> +[ $(( $sec_ctime - $sec )) -gt 1 ] && echo "The timestamp is wrong, sec_atime: $sec_atime, cur_time[s]: $sec"

The echo'ed messages are all refering to sec_atime.

And above checks are unable to detect the case that $sec_xtime is
smaller than $sec, as ($sec_xtime - $sec) becomes negative.

We have a _within_tolerance helper to check if the value is within a
given value. Please see other tests for examples.

> +
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +# Test mount to ext3 then mount back to ext4 and check timestamp again
> +_mount -t ext3 `_scratch_mount_options $*` || _fail "ext3 mount failed"
> +_scratch_unmount >> $seqres.full 2>&1
> +_scratch_mount
> +
> +nsec_atime2=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file atime nsec`
> +nsec_mtime2=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> +nsec_ctime2=`$here/src/t_get_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> +
> +[ $nsec_atime -ne $nsec_atime2 ] && echo "File nanosecond timestamp atime has changed unexpected from $nsec_atime to $nsec_atime2"
> +[ $nsec_mtime -ne $nsec_mtime2 ] && echo "File nanosecond timestamp mtime has changed unexpected from $nsec_mtime to $nsec_mtime2"
> +[ $nsec_ctime -ne $nsec_ctime2 ] && echo "File nanosecond timestamp ctime has changed unexpected from $nsec_ctime to $nsec_ctime2"
> +
> +status=0
> +exit
> diff --git a/tests/ext4/044.out b/tests/ext4/044.out
> new file mode 100644
> index 00000000..12a61dc4
> --- /dev/null
> +++ b/tests/ext4/044.out
> @@ -0,0 +1,2 @@
> +QA output created by 044
> +Silence is golden
> diff --git a/tests/ext4/045 b/tests/ext4/045
> new file mode 100755
> index 00000000..29524e48
> --- /dev/null
> +++ b/tests/ext4/045
> @@ -0,0 +1,111 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test No. 045
> +#
> +# Test subdirectory limit of ext4. 
> +# We create more than 65000 subdirectories on the ext4 filesystem.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +SHORT_DIR=1
> +LONG_DIR=2
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_supported_os Linux
> +
> +_require_scratch
> +_require_test_program "t_create_short_dirs"
> +_require_test_program "t_create_long_dirs"
> +_require_dumpe2fs "$DUMPE2FS_PROG" dumpe2fs
> +
> +echo "Silence is golden"
> +
> +# Run a test case
> +# $1: Number of directories to create
> +# $2: create short dir or long dir
> +# $3: parent directory
> +workout()
> +{
> +	local dir_name_len=""
> +	if [ $2 -eq $SHORT_DIR ]; then
> +		dir_name_len="short name"
> +	else
> +		dir_name_len="long name"
> +	fi
> +
> +	echo "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
> +		"Parent dir: $3" >> $seqres.full
> +
> +	_scratch_mkfs "-O extent,dir_nlink,dir_index -I 256" >> $seqres.full 2>&1
> +	_scratch_mount
> +
> +	# create directories
> +	mkdir -p $3 2> /dev/null
> +
> +	if [ $2 -eq $SHORT_DIR ]; then
> +		$here/src/t_create_short_dirs $1 $3
> +	else
> +		$here/src/t_create_long_dirs $1 $3
> +	fi
> +
> +	if [ $? -ne 0 ]; then
> +		nr_dirs=`ls $3 | wc -l`
> +		echo "Failed to create directories - $nr_dirs"
> +		_scratch_unmount
> +		return
> +	fi
> +
> +	# delete directories
> +	cd $3
> +	ls | xargs rmdir
> +	if [ $? -ne 0 ]; then
> +		echo "Failed to remove directories in $3"
> +		cd - > /dev/null
> +		_scratch_unmount
> +		return
> +	fi
> +	cd - > /dev/null
> +	_scratch_unmount
> +
> +	# check dir_nlink is set
> +	$DUMPE2FS_PROG -h $SCRATCH_DEV 2>> $seqres.full | grep '^Filesystem features' | grep -q dir_nlink
> +	if [ $? -ne 0 ]; then
> +		echo "Feature dir_nlink is not set, please check $seqres.full for detail"
> +		return
> +	fi
> +}
> +
> +# main
> +DIR_NUM=65537
> +DIR_LEN=( $SHORT_DIR $LONG_DIR )
> +PARENT_DIR="$SCRATCH_MNT/subdir"
> +
> +for ((i = 0; i < 2; i++)); do
> +>-------workout $DIR_NUM ${DIR_LEN[$i]} $PARENT_DIR

What's the ">-------" ?

Thanks,
Eryu

> +done
> +
> +status=0
> +exit
> diff --git a/tests/ext4/045.out b/tests/ext4/045.out
> new file mode 100644
> index 00000000..66276cfa
> --- /dev/null
> +++ b/tests/ext4/045.out
> @@ -0,0 +1,2 @@
> +QA output created by 045
> +Silence is golden
> diff --git a/tests/ext4/group b/tests/ext4/group
> index 9dfc0d35..5f16684a 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -45,6 +45,9 @@
>  040 dangerous_fuzzers
>  041 dangerous_fuzzers
>  042 auto quick
> +043 auto quick
> +044 auto quick
> +045 auto dir
>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.24.1
> 
