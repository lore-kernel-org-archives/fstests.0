Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8B4C433C1
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Mar 2021 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A824061946
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Mar 2021 14:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhCUO3W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Mar 2021 10:29:22 -0400
Received: from out20-50.mail.aliyun.com ([115.124.20.50]:48254 "EHLO
        out20-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhCUO3B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Mar 2021 10:29:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.123584-0.00133245-0.875083;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Jo2TQgm_1616336932;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Jo2TQgm_1616336932)
          by smtp.aliyun-inc.com(10.147.42.22);
          Sun, 21 Mar 2021 22:28:53 +0800
Date:   Sun, 21 Mar 2021 22:28:52 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 1/4] generic/631: add test for detached mount
 propagation
Message-ID: <YFdYJBNeSsDN1sbY@desktop>
References: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
 <20210316103627.2954121-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316103627.2954121-2-christian.brauner@ubuntu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 16, 2021 at 11:36:24AM +0100, Christian Brauner wrote:
> Regression test to verify that creating a series of detached mounts,
> attaching them to the filesystem, and unmounting them does not trigger an
> integer overflow in ns->mounts causing the kernel to block any new mounts in
> count_mounts() and returning ENOSPC because it falsely assumes that the
> maximum number of mounts in the mount namespace has been reached, i.e. it
> thinks it can't fit the new mounts into the mount namespace anymore.
> 
> The test is written in a way that it will leave the host's mount
> namespace intact so we are sure to never make the host's mount namespace
> unuseable!
> 
> Link: https://git.kernel.org/torvalds/c/ee2e3f50629f17b0752b55b2566c15ce8dafb557
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v1 */
> patch not present
> 
> /* v2 */
> patch not present
> 
> /* v3 */
> patch not present
> 
> /* v4 */
> patch not present
> 
> /* v5 */
> patch not present
> 
> /* v6 */
> patch not present
> 
> /* v7 */
> patch not present
> 
> /* v8 */
> patch introduced
> 
> /* v9 */
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - Rebased on current master.
> ---
>  .gitignore                        |   1 +
>  src/Makefile                      |   3 +-
>  src/detached_mounts_propagation.c | 252 ++++++++++++++++++++++++++++++
>  tests/generic/631                 |  41 +++++
>  tests/generic/631.out             |   2 +
>  tests/generic/group               |   1 +
>  6 files changed, 299 insertions(+), 1 deletion(-)
>  create mode 100644 src/detached_mounts_propagation.c
>  create mode 100644 tests/generic/631
>  create mode 100644 tests/generic/631.out
> 
> diff --git a/.gitignore b/.gitignore
> index f3bc0a4f..72bd40a0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -62,6 +62,7 @@
>  /src/cloner
>  /src/dbtest
>  /src/deduperace
> +/src/detached_mounts_propagation
>  /src/devzero
>  /src/dio-interleaved
>  /src/dio-invalidate-cache
> diff --git a/src/Makefile b/src/Makefile
> index 3d729a34..99019e6e 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -29,7 +29,8 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
>  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> -	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail
> +	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> +	detached_mounts_propagation
>  
>  SUBDIRS = log-writes perf
>  
> diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
> new file mode 100644
> index 00000000..4a588e46
> --- /dev/null
> +++ b/src/detached_mounts_propagation.c
> @@ -0,0 +1,252 @@
> +/* SPDX-License-Identifier: LGPL-2.1+ */
> +/*
> + * Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
> + * All Rights Reserved.
> + *
> + * Regression test to verify that creating a series of detached mounts,
> + * attaching them to the filesystem, and unmounting them does not trigger an
> + * integer overflow in ns->mounts causing the kernel to block any new mounts in
> + * count_mounts() and returning ENOSPC because it falsely assumes that the
> + * maximum number of mounts in the mount namespace has been reached, i.e. it
> + * thinks it can't fit the new mounts into the mount namespace anymore.
> + */
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <limits.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +/* open_tree() */
> +#ifndef OPEN_TREE_CLONE
> +#define OPEN_TREE_CLONE 1
> +#endif
> +
> +#ifndef OPEN_TREE_CLOEXEC
> +#define OPEN_TREE_CLOEXEC O_CLOEXEC
> +#endif
> +
> +#ifndef __NR_open_tree
> +	#if defined __alpha__
> +		#define __NR_open_tree 538
> +	#elif defined _MIPS_SIM
> +		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
> +			#define __NR_open_tree 4428
> +		#endif
> +		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
> +			#define __NR_open_tree 6428
> +		#endif
> +		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
> +			#define __NR_open_tree 5428
> +		#endif
> +	#elif defined __ia64__
> +		#define __NR_open_tree (428 + 1024)
> +	#else
> +		#define __NR_open_tree 428
> +	#endif
> +#endif
> +
> +/* move_mount() */
> +#ifndef MOVE_MOUNT_F_EMPTY_PATH
> +#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
> +#endif
> +
> +#ifndef __NR_move_mount
> +	#if defined __alpha__
> +		#define __NR_move_mount 539
> +	#elif defined _MIPS_SIM
> +		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
> +			#define __NR_move_mount 4429
> +		#endif
> +		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
> +			#define __NR_move_mount 6429
> +		#endif
> +		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
> +			#define __NR_move_mount 5429
> +		#endif
> +	#elif defined __ia64__
> +		#define __NR_move_mount (428 + 1024)
> +	#else
> +		#define __NR_move_mount 429
> +	#endif
> +#endif
> +
> +static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
> +{
> +	return syscall(__NR_open_tree, dfd, filename, flags);
> +}
> +
> +static inline int sys_move_mount(int from_dfd, const char *from_pathname, int to_dfd,
> +				 const char *to_pathname, unsigned int flags)
> +{
> +	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
> +}
> +
> +static bool is_shared_mountpoint(const char *path)
> +{
> +	bool shared = false;
> +	FILE *f = NULL;
> +	char *line = NULL;
> +	int i;
> +	size_t len = 0;
> +
> +	f = fopen("/proc/self/mountinfo", "re");
> +	if (!f)
> +		return 0;
> +
> +	while (getline(&line, &len, f) > 0) {
> +		char *slider1, *slider2;
> +
> +		for (slider1 = line, i = 0; slider1 && i < 4; i++)
> +			slider1 = strchr(slider1 + 1, ' ');
> +
> +		if (!slider1)
> +			continue;
> +
> +		slider2 = strchr(slider1 + 1, ' ');
> +		if (!slider2)
> +			continue;
> +
> +		*slider2 = '\0';
> +		if (strcmp(slider1 + 1, path) == 0) {
> +			/* This is the path. Is it shared? */
> +			slider1 = strchr(slider2 + 1, ' ');
> +			if (slider1 && strstr(slider1, "shared:")) {
> +				shared = true;
> +				break;
> +			}
> +		}
> +	}
> +	fclose(f);
> +	free(line);
> +
> +	return shared;
> +}
> +
> +static void usage(void)
> +{
> +	const char *text = "mount-new [--recursive] <base-dir>\n";
> +	fprintf(stderr, "%s", text);
> +	_exit(EXIT_SUCCESS);
> +}
> +
> +#define exit_usage(format, ...)                              \
> +	({                                                   \
> +		fprintf(stderr, format "\n", ##__VA_ARGS__); \
> +		usage();                                     \
> +	})
> +
> +#define exit_log(format, ...)                                \
> +	({                                                   \
> +		fprintf(stderr, format "\n", ##__VA_ARGS__); \
> +		exit(EXIT_FAILURE);                          \
> +	})
> +
> +static const struct option longopts[] = {
> +	{"help",	no_argument,		0,	'a'},
> +	{ NULL,		no_argument,		0,	 0 },
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +	int exit_code = EXIT_SUCCESS, index = 0;
> +	int dfd, fd_tree, new_argc, ret;
> +	char *base_dir;
> +	char *const *new_argv;
> +	char target[PATH_MAX];
> +
> +	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
> +		switch (ret) {
> +		case 'a':
> +			/* fallthrough */
> +		default:
> +			usage();
> +		}
> +	}
> +
> +	new_argv = &argv[optind];
> +	new_argc = argc - optind;
> +	if (new_argc < 1)
> +		exit_usage("Missing base directory\n");
> +	base_dir = new_argv[0];
> +
> +	if (*base_dir != '/')
> +		exit_log("Please specify an absolute path");
> +
> +	/* Ensure that target is a shared mountpoint. */
> +	if (!is_shared_mountpoint(base_dir))
> +		exit_log("Please ensure that \"%s\" is a shared mountpoint", base_dir);
> +
> +	ret = unshare(CLONE_NEWNS);
> +	if (ret < 0)
> +		exit_log("%m - Failed to create new mount namespace");
> +
> +	ret = mount(NULL, base_dir, NULL, MS_REC | MS_SHARED, NULL);
> +	if (ret < 0)
> +		exit_log("%m - Failed to make base_dir shared mountpoint");
> +
> +	dfd = open(base_dir, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
> +	if (dfd < 0)
> +		exit_log("%m - Failed to open base directory \"%s\"", base_dir);
> +
> +	ret = mkdirat(dfd, "detached-move-mount", 0755);
> +	if (ret < 0)
> +		exit_log("%m - Failed to create required temporary directories");
> +
> +	ret = snprintf(target, sizeof(target), "%s/detached-move-mount", base_dir);
> +	if (ret < 0 || (size_t)ret >= sizeof(target))
> +		exit_log("%m - Failed to assemble target path");
> +
> +	/*
> +	 * Having a mount table with 10000 mounts is already quite excessive
> +	 * and shoult account even for weird test systems.
> +	 */
> +	for (size_t i = 0; i < 10000; i++) {
> +		fd_tree = sys_open_tree(dfd, "detached-move-mount",
> +					OPEN_TREE_CLONE |
> +					OPEN_TREE_CLOEXEC |
> +					AT_EMPTY_PATH);
> +		if (fd_tree < 0) {
> +			if (errno == ENOSYS) /* New mount API not (fully) supported. */
> +				break;
> +
> +			fprintf(stderr, "%m - Failed to open %d(detached-move-mount)", dfd);
> +			exit_code = EXIT_FAILURE;
> +			break;
> +		}
> +
> +		ret = sys_move_mount(fd_tree, "", dfd, "detached-move-mount", MOVE_MOUNT_F_EMPTY_PATH);
> +		if (ret < 0) {
> +			if (errno == ENOSPC)
> +				fprintf(stderr, "%m - Buggy mount counting");
> +			else if (errno == ENOSYS) /* New mount API not (fully) supported. */
> +				break;
> +			else
> +				fprintf(stderr, "%m - Failed to attach mount to %d(detached-move-mount)", dfd);
> +			exit_code = EXIT_FAILURE;
> +			break;
> +		}
> +		close(fd_tree);
> +
> +		ret = umount2(target, MNT_DETACH);
> +		if (ret < 0) {
> +			fprintf(stderr, "%m - Failed to unmount %s", target);
> +			exit_code = EXIT_FAILURE;
> +			break;
> +		}
> +	}
> +
> +	(void)unlinkat(dfd, "detached-move-mount", AT_REMOVEDIR);
> +	close(dfd);
> +
> +	exit(exit_code);
> +}
> diff --git a/tests/generic/631 b/tests/generic/631
> new file mode 100644
> index 00000000..e227c448
> --- /dev/null
> +++ b/tests/generic/631
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
> +# All Rights Reserved.
> +#
> +# FS QA Test No. 631
> +#
> +# Regression test to verify that creating a series of detached mounts,
> +# attaching them to the filesystem, and unmounting them does not trigger an
> +# integer overflow in ns->mounts causing the kernel to block any new mounts in
> +# count_mounts() and returning ENOSPC because it falsely assumes that the
> +# maximum number of mounts in the mount namespace has been reached, i.e. it
> +# thinks it can't fit the new mounts into the mount namespace anymore.
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
> +. ./common/rc
> +
> +rm -f $seqres.full
> +
> +_supported_fs generic

_require_test

As test runs directly on $TEST_DIR.

Also needs

_require_test_program "detached_mounts_propagation"

> +
> +$here/src/detached_mounts_propagation $TEST_DIR >> $seqres.full
> +
> +echo silence is golden
> +status=$?

This should go after detached_mounts_propagation command?

Thanks,
Eryu

> +exit
> diff --git a/tests/generic/631.out b/tests/generic/631.out
> new file mode 100644
> index 00000000..ce88f447
> --- /dev/null
> +++ b/tests/generic/631.out
> @@ -0,0 +1,2 @@
> +QA output created by 631
> +silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 7c7531d1..151f8af2 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -633,3 +633,4 @@
>  628 auto quick rw clone
>  629 auto quick rw copy_range
>  630 auto quick rw dedupe clone
> +631 auto quick mount
> -- 
> 2.27.0
