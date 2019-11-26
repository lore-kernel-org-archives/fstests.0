Return-Path: <SRS0=JLeR=ZS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0EFC432C0
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Nov 2019 16:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB20206BF
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Nov 2019 16:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qZUkKfOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfKZQHg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:07:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44590 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfKZQHg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Nov 2019 11:07:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQFxL2B123180;
        Tue, 26 Nov 2019 16:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=R8W9aqg3mtK5A9A15GNjUKsgwF8d9DFpp3ZfXZ3XysA=;
 b=qZUkKfOSM+4ERmHnrNkPIsM5GrC+TMWKTGHvxErfu6HYV5GkMAkOMlTUT5RZwvUib04J
 DQzWjoZWFzBSTji4d0ZKbaj/urfP9aJ322Iq53vEsw5qNZPs7rohQk4rZGJCKoq/14y6
 pe8W9/HInkJ1tFCKocWUFaqCXDtcoTPebMIgdFj9NULf9cJa+MR9AVzs1sTxt3Sds1up
 dzx2VgltiRkeDQ0urgEOf6VcvTJrhNkBt9eo1iEZd0mkbql7Un+paSQ+p4ZSiX0FfDc1
 VYpLOQB7lOZ+8yM3fSv5l1ZcPXK+InHld+s4l26hQGnAFiVjaLF9wciFIKUtJ215vtiU DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wevqq7u7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 16:06:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQFxDMo047637;
        Tue, 26 Nov 2019 16:06:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wh0rcg74k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 16:06:11 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQG6BL8020943;
        Tue, 26 Nov 2019 16:06:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 08:06:10 -0800
Date:   Tue, 26 Nov 2019 08:06:09 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Sun Yong <sunyong0511@gmail.com>
Cc:     fstests@vger.kernel.org, yosun@suse.com,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: transport two ext4 tests from LTP
Message-ID: <20191126160609.GG6212@magnolia>
References: <CAAPJbvqksutxzznPO1T5Z_pQA-=SuKHLuzp_TOyJu7s3W2tL=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAPJbvqksutxzznPO1T5Z_pQA-=SuKHLuzp_TOyJu7s3W2tL=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260138
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 04, 2019 at 03:30:55PM +0800, Sun Yong wrote:
> Recently LTP upstream removed some ext4 tests[1]. And two of them is
> still valid to keep. So I transport those two tests here.
> 
> ext4-nsec-timestamps, which is used to test nanosec timestamps of
> ext4, rewrite into ext4/043 and 044.
> ext4-subdir-limit, which is used to test subdirectory limit of ext4,
> rewrite into ext4/045.

Might be a good idea to split these into separate patches...

> [1] https://marc.info/?l=linux-fsdevel&m=157190623919681&w=2
> 
> Signed-off-by: Sun Yong <yosun@suse.com>
> ---
> v2: Correct copyright information
> ---
> diff --git a/src/Makefile b/src/Makefile
> index ce6d8610..387293d1 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -16,7 +16,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>      holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
>      t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
>      t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> -    t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent
> +    t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent \
> +    t_ext4_file_time t_create_short_dirs t_create_long_dirs
> 
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>      preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/t_create_long_dirs.c b/src/t_create_long_dirs.c
> new file mode 100644
> index 00000000..76a886aa
> --- /dev/null
> +++ b/src/t_create_long_dirs.c
> @@ -0,0 +1,155 @@
> +/******************************************************************************/
> +/*
>         */

Don't wrap, like Eryu asked.

> +/* Copyright (c) 2009 FUJITSU LIMITED
>         */
> +/*
>         */
> +/* This program is free software;  you can redistribute it and/or
> modify      */
> +/* it under the terms of the GNU General Public License as published
> by       */
> +/* the Free Software Foundation; either version 2 of the License, or
>         */
> +/* (at your option) any later version.

SPDX headers instead of GPL boilerplate, please.

>         */
> +/*
>         */
> +/* This program is distributed in the hope that it will be useful,
>         */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
>         */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>         */
> +/* the GNU General Public License for more details.
>         */
> +/*
>         */
> +/* You should have received a copy of the GNU General Public License
>         */
> +/* along with this program;  if not, write to the Free Software
>         */
> +/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA    */
> +/*
>         */
> +/* Author: Li Zefan <lizf@cn.fujitsu.com>
>         */
> +/*
>         */
> +/******************************************************************************/
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
> +#define NAME_LEN    255
> +#define NCHARS        62
> +#define MAX_LEN1    62
> +#define MAX_LEN2    (62 * 62)
> +#define MAX_LEN3    (62 * 62 * 62)

62?

Oh, 26 + 26 + 10.

> +
> +/* valid characters for the directory name */
> +char chars[NCHARS + 1] =
> +    "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
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
> +    int i;
> +
> +    srand(time(NULL));
> +
> +    for (i = 0; i < NAME_LEN; i++)
> +        name[i] = chars[rand() % 62];
> +}
> +
> +void create_dir(void)
> +{
> +    if (mkdirat(parent_fd, name, S_IRWXU)) {
> +        perror("mkdir");
> +        exit(1);
> +    }
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
> +    int i, j, k;
> +    int depth;
> +
> +    if (n <= MAX_LEN1)
> +        depth = 1;
> +    else if (n <= MAX_LEN2)
> +        depth = 2;
> +    else
> +        depth = 3;
> +
> +    for (i = 0; i < NCHARS; i++) {
> +        name[0] = chars[i];
> +        if (depth == 1) {
> +            create_dir();
> +            if (--n == 0)
> +                return;
> +            continue;
> +        }
> +
> +        for (j = 0; j < NCHARS; j++) {
> +            name[1] = chars[j];
> +            if (depth == 2) {
> +                create_dir();
> +                if (--n == 0)
> +                    return;
> +                continue;
> +            }
> +
> +            for (k = 0; k < NCHARS; k++) {
> +                name[2] = chars[k];
> +                create_dir();
> +                if (--n == 0)
> +                    return;
> +            }
> +        }
> +    }
> +}

I would've thought you could just do:

for (i = 0; i < n; i++) {
	snprintf(name, sizeof(name) - 1, "%0*d", depth, n);
	mkdirat(dir, name, ...);
}

instead of this nested loopy thing, since the goal is to end up with a
subdirectory containing somewhere between 1 and 238328 names in it,
right?

Unless there's some speedup that nested looping gets us?

> +
> +void usage()
> +{
> +    fprintf(stderr, "Usage: create_long_dirs nr_dirs parent_dir\n");
> +}
> +
> +/*
> + * Create long-name directories
> + * @argv[1]: directory number
> + * @argv[2]: parent directory
> + */
> +int main(int argc, char *argv[])
> +{
> +    if (argc != 3) {
> +        usage();
> +        return 1;
> +    }
> +
> +    names = atoi(argv[1]);
> +    if (names > MAX_LEN3 || names <= 0) {
> +        usage();
> +        return 1;
> +    }
> +
> +    parent_fd = open(argv[2], O_RDONLY);
> +    if (parent_fd == -1) {
> +        perror("open parent dir failed");
> +        return 1;
> +    }
> +
> +    init_name();
> +
> +    create_dirs(names);
> +
> +    return 0;
> +}
> diff --git a/src/t_create_short_dirs.c b/src/t_create_short_dirs.c
> new file mode 100644
> index 00000000..c5733b9d
> --- /dev/null
> +++ b/src/t_create_short_dirs.c
> @@ -0,0 +1,158 @@
> +/******************************************************************************/
> +/*
>         */
> +/* Copyright (c) 2009 FUJITSU LIMITED
>         */
> +/*
>         */
> +/* This program is free software;  you can redistribute it and/or
> modify      */
> +/* it under the terms of the GNU General Public License as published
> by       */
> +/* the Free Software Foundation; either version 2 of the License, or
>         */
> +/* (at your option) any later version.
>         */
> +/*
>         */
> +/* This program is distributed in the hope that it will be useful,
>         */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
>         */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>         */
> +/* the GNU General Public License for more details.
>         */
> +/*
>         */
> +/* You should have received a copy of the GNU General Public License
>         */
> +/* along with this program;  if not, write to the Free Software
>         */
> +/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA    */
> +/*
>         */
> +/* Author: Li Zefan <lizf@cn.fujitsu.com>
>         */
> +/*
>         */
> +/******************************************************************************/
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
> +/* valid characters for a directory name */
> +char chars[] =
> "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
> +
> +/* to store the generated directory name */
> +char name[10];
> +int names;
> +int parent_fd;
> +
> +/* NCHARS = 10 + 26 + 26 = 62 */
> +#define NCHARS        62
> +#define MAX_LEN1    62
> +#define MAX_LEN2    (62 * 62)
> +#define MAX_LEN3    (62 * 62 * 62)
> +#define MAX_NAMES    (MAX_LEN1 + MAX_LEN2 + MAX_LEN3)
> +
> +void create_dir(void)
> +{
> +    if (mkdirat(parent_fd, name, S_IRWXU)) {
> +        perror("mkdir");
> +        exit(1);
> +    }
> +}
> +
> +/*
> + * create_1 - create length-1 directory names
> + * @n: how name names to be created
> + */
> +void create_1(int n)
> +{
> +    int i;
> +
> +    name[1] = '\0';
> +    for (i = 0; i < NCHARS; i++) {
> +        name[0] = chars[i];
> +        create_dir();
> +        if (--n == 0)
> +            return;
> +    }
> +}
> +
> +/*
> + * create_2 - generate length-2 directory names
> + * @n: how many names to be created
> + */
> +void create_2(int n)
> +{
> +    int i, j;
> +
> +    name[2] = '\0';
> +    for (i = 0; i < NCHARS; i++) {
> +        name[0] = chars[i];
> +        for (j = 0; j < NCHARS; j++) {
> +            name[1] = chars[j];
> +            create_dir();
> +            if (--n == 0)
> +                return;
> +        }
> +    }
> +}
> +
> +/*
> + * create_3 - generate length-3 directory names
> + * @n: how many names to be created
> + */
> +void create_3(int n)
> +{
> +    int i, j, k;
> +
> +    name[3] = '\0';
> +    for (i = 0; i < NCHARS; i++) {
> +        name[0] = chars[i];
> +        for (j = 0; j < NCHARS; j++) {
> +            name[1] = chars[j];
> +            for (k = 0; k < NCHARS; k++) {
> +                name[2] = chars[k];
> +                create_dir();
> +                if (--n == 0)
> +                    return;
> +            }
> +        }
> +    }
> +}
> +
> +void usage()
> +{
> +    fprintf(stderr, "Usage: create_short_dirs nr_dirs parent_dir\n");
> +}
> +
> +/*
> + * Create short-name directoriess
> + * @argv[1]: director number
> + * @argv[2]: the parent directory
> + */
> +int main(int argc, char *argv[])

How does this program differ from the other one?

> +{
> +    if (argc != 3) {
> +        usage();
> +        return 1;
> +    }
> +
> +    names = atoi(argv[1]);
> +    if (names > MAX_NAMES || names <= 0) {
> +        usage();
> +        return 1;
> +    }
> +
> +    parent_fd = open(argv[2], O_RDONLY);
> +    if (parent_fd == -1) {
> +        perror("open parent dir");
> +        return 1;
> +    }
> +
> +    create_1(names);
> +    if (names <= MAX_LEN1)
> +        return 0;
> +
> +    names -= MAX_LEN1;
> +    create_2(names);
> +    if (names <= MAX_LEN2)
> +        return 0;
> +
> +    names -= MAX_LEN2;
> +    create_3(names);
> +
> +    return 0;
> +}
> diff --git a/src/t_ext4_file_time.c b/src/t_ext4_file_time.c
> new file mode 100644
> index 00000000..a10adb3d
> --- /dev/null
> +++ b/src/t_ext4_file_time.c
> @@ -0,0 +1,69 @@
> +/******************************************************************************/
> +/*
>         */
> +/* Copyright (c) 2009 FUJITSU LIMITED
>         */
> +/*
>         */
> +/* This program is free software;  you can redistribute it and/or
> modify      */
> +/* it under the terms of the GNU General Public License as published
> by       */
> +/* the Free Software Foundation; either version 2 of the License, or
>         */
> +/* (at your option) any later version.
>         */
> +/*
>         */
> +/* This program is distributed in the hope that it will be useful,
>         */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
>         */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>         */
> +/* the GNU General Public License for more details.
>         */
> +/*
>         */
> +/* You should have received a copy of the GNU General Public License
>         */
> +/* along with this program;  if not, write to the Free Software
>         */
> +/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA    */
> +/*
>         */
> +/* Author: Li Zefan <lizf@cn.fujitsu.com>
>         */
> +/*
>         */
> +/******************************************************************************/
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +/*
> + * Usage: file_time <filename> <atime|mtime|ctime> <sec|nsec>
> + */
> +int main(int argc, char *argv[])
> +{
> +    time_t t;

Is this program going to fail on 32-bit systems?

> +    struct stat st;
> +
> +    if (argc != 4) {
> +        fprintf(stderr, "Wrong argument num!\n");
> +        return 1;
> +    }
> +
> +    if (stat(argv[1], &st) != 0) {
> +        perror("stat failed");
> +        return 1;
> +    }
> +
> +    if (strcmp(argv[3], "sec") == 0) {
> +        if (strcmp(argv[2], "atime") == 0)
> +            t = st.st_atime;
> +        else if (strcmp(argv[2], "mtime") == 0)
> +            t = st.st_mtime;
> +        else
> +            t = st.st_ctime;
> +    } else if (strcmp(argv[3], "nsec") == 0) {
> +        if (strcmp(argv[2], "atime") == 0)
> +            t = st.st_atim.tv_nsec;
> +        else if (strcmp(argv[2], "mtime") == 0)
> +            t = st.st_mtim.tv_nsec;
> +        else
> +            t = st.st_ctim.tv_nsec;
> +    } else {
> +        fprintf(stderr, "Wrong argument: %s\n", argv[3]);
> +        return 1;
> +    }
> +
> +    printf("%lu\n", t);
> +
> +    return 0;
> +}
> diff --git a/tests/ext4/043 b/tests/ext4/043
> new file mode 100755
> index 00000000..b6e5df9f
> --- /dev/null
> +++ b/tests/ext4/043
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test No. 043
> +#
> +# Transfer from ltp/testcases/kernel/fs/ext4-new-features/ext4_nsec_timestamps
> +# Test file timestamps is second with 128 inode size

(Huh?)

OH, "Test file timestamps are only precise to seconds with 128-byte inodes."

> +#
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
> +    cd /
> +    rm -f $tmp.*
> +    _scratch_cleanup_files
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
> +_require_test_program "t_ext4_file_time"
> +_require_command "$TUNE2FS_PROG" tune2fs
> +
> +echo "Silence is golden"
> +
> +echo "Start test timestamps with 128 inode size one device
> $SCRATCH_DEV" >$seqres.full
> +_scratch_mkfs_ext4 -I 128 >> $seqres.full 2>&1
> +tune2fs -O extents $SCRATCH_DEV >>$seqres.full 2>&1

$TUNE2FS_PROG

Also, why turn on extents?

> +_scratch_mount
> +
> +touch "${SCRATCH_MNT}/tmp_file"
> +
> +atime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
> +mtime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> +ctime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> +
> +if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
> +        echo "Timestamp is not second(atime: $atime, mtime: $mtime,
> ctime: $ctime)" >> $seqres.full

OH, this test checks for nonzero value in the nsec fields when ext4
doesn't support the extended timestamp fields.

> +        _scratch_unmount >> $seqres.full 2>&1

No need to unmount at the end of the test; fstests will do that for you.
For that matter all you need here is:

if [ $atime -ne 0 .... ]; then
	echo "nsec should be zero when extended timestamps are disabled"
	echo "atime: $atime..."
fi

Without any of the "_scratch_unmount" or "exit".  If we fail the if test
and emit the message, the change in golden output will be sufficient for
fstests to mark the test failed.

> +        exit
> +fi
> +echo "Ext4 nanosecond timestamps test with 128 inode size pass" >> $seqres.full
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +# no BUG_ON, all done

BUG_ON?  What are you talking about?  Is there a fix commit that goes
with this?

Also, if this will crash recent kernels then this should be in the
dangerous group, not auto.

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
> index 00000000..3e899f5a
> --- /dev/null
> +++ b/tests/ext4/044
> @@ -0,0 +1,112 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test No. 044
> +#
> +# Transfer from ltp/testcases/kernel/fs/ext4-new-features/ext4_nsec_timestamps
> +# Test file timestamps is nanosecond with 256 inode size

"Test file timestamps are precise to nanoseconds with 256-byte inodes."

> +#
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
> +    cd /
> +    rm -f $tmp.*
> +    _scratch_cleanup_files

Don't bother erasing the scratch fs files, the next _scratch_mkfs will
do that for you.

> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter

I don't think we need filter here...?

> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext3 ext4
> +_supported_os Linux
> +_require_scratch
> +_require_test_program "t_ext4_file_time"
> +
> +echo "Silence is golden"
> +
> +echo "Test timestamps with 256 inode size one device $SCRATCH_DEV"
> >$seqres.full
> +_scratch_mkfs_ext4 -t ext3 -I 256 >> $seqres.full 2>&1
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
> +
> +sec_atime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime sec`
> +sec_mtime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime sec`
> +sec_ctime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime sec`
> +nsec_atime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
> +nsec_mtime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> +nsec_ctime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> +
> +# Test nanosecond
> +if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]; then
> +        echo "The timestamp is not nanosecond(nsec_atime: $nsec_atime, \
> +              nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime)" >>
> $seqres.full
> +        _scratch_unmount >> $seqres.full 2>&1
> +        exit
> +fi
> +
> +diff1=$(( $sec_atime - $sec ))
> +diff2=$(( $sec_mtime - $sec ))
> +diff3=$(( $sec_ctime - $sec ))
> +
> +# Test difference between file time and current time
> +if [ $diff1 -gt 1 -o $diff2 -gt 1 -o $diff2 -gt 1 ]; then
> +        echo "The timestamp is wrong, it must be earlier than the
> current time we got. \
> +             (sec_atime: $sec_atime, sec_mtime: $sec_mtime,
> sec_ctime: $sec_ctime, \
> +             cur_time[s]: $sec)" >> $seqres.full
> +        _scratch_unmount >> $seqres.full 2>&1
> +        exit
> +fi
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +# Test mount to ext3 and then mount back to ext4
> +mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT

Hm... what /is/ the rule about changing filesystem types?  Do we just
open-code _try_scratch_mount to force ext3 here?

_mount -t ext3 `_scratch_mount_options $*` || _fail "ext3 mount failed"

> +if [ $? -ne 0 ]; then
> +        echo "$SCRATCH_DEV fail in mounting to ext3" >> $seqres.full
> +        _scratch_unmount >> $seqres.full 2>&1
> +        exit
> +fi
> +_scratch_unmount >> $seqres.full 2>&1
> +_scratch_mount
> +
> +nsec_atime2=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
> +nsec_mtime2=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> +nsec_ctime2=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> +
> +if [ $nsec_atime -ne $nsec_atime2 -o $nsec_ctime -ne $nsec_ctime2 -o \
> +     $nsec_mtime -ne $nsec_mtime2 ]; then
> +        echo "File nanosecond timestamp has changed \
> +                        unexpected. Before[atime mtime ctime]: $nsec_atime \
> +                        nsec_mtime $nsec_ctime, After[atime mtime ctime]: \
> +                        $nsec_atime2 $nsec_mtime2 $nsec_ctime2)" >>
> $seqres.full
> +        _scratch_unmount >> $seqres.full 2>&1
> +        exit

If you really want to bail out early, do it with _fail, i.e.

_fail "File nanosecond timestamp has changed..."

Please consider doing all these checks individually, not in one huge if
statement.

> +fi
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +# no BUG_ON, all done
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
> index 00000000..c70baa97
> --- /dev/null
> +++ b/tests/ext4/045
> @@ -0,0 +1,148 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test No. 045
> +#
> +# Transfer from
> ltp/testcases/kernel/fs/ext4-new-features/ext4_subdir_limit_test
> +#
> +# Test subdirectory limit of ext4.
> +# We create more than 32000 subdirectorys on the ext4 filesystem.

"subdirectories"

> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +SHORT_DIR=1
> +LONG_DIR=2
> +FAIL=1
> +PASS=0
> +prev_block_size=0
> +prev_result=$FAIL
> +
> +_cleanup()
> +{
> +    cd /
> +    rm -f $tmp.*
> +    _scratch_cleanup_files
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
> +_require_command "$TUNE2FS_PROG" tune2fs
> +_require_command "$E2FSCK_PROG" e2fsck
> +_require_dumpe2fs
> +
> +echo "Silence is golden"
> +
> +# Run a test case
> +# $1: Number of directories to create
> +# $2: create short dir or long dir
> +# $3: parent directory
> +# $4: filesystem block size
> +_workout()

Local functions should not be prefixed with "_"; those are reserved for
common/ library functions.

> +{
> +    local dir_name_len=
> +    if [ $2 -eq $SHORT_DIR ]; then
> +        dir_name_len="short name"
> +    else
> +        dir_name_len="long name"
> +    fi
> +
> +    echo "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
> +          "Parent dir: $3, Block size: $4" >> $seqres.full 2>&1
> +
> +    # Only mkfs if block size has been changed, or previous case failed
> +    if [ $prev_result -ne $PASS -o $4 -ne $prev_block_size ]; then
> +        $MKFS_EXT4_PROG -F -b $4 -I 256 $SCRATCH_DEV >> $seqres.full 2>&1

_scratch_mkfs -b $4 -I 256 ?

> +        prev_block_size=$4
> +        tune2fs -O extents $SCRATCH_DEV >> $seqres.full 2>&1

$TUNE2FS_PROG, do not call tune2fs directly.

Also, why don't you just format the fs with extents turned on in the
first place?

> +    fi
> +    prev_result=$FAIL
> +
> +    _scratch_mount
> +
> +    # create directories
> +    mkdir -p $3 2> /dev/null
> +
> +    if [ $2 -eq $SHORT_DIR ]; then
> +        $here/src/t_create_short_dirs $1 $3
> +    else
> +        $here/src/t_create_long_dirs $1 $3
> +    fi
> +
> +    if [ $? -ne 0 ]; then
> +        nr_dirs=`ls $3 | wc -l`
> +        echo "Failed to create directories - $nr_dirs"
> +        _scratch_unmount
> +        return
> +    fi
> +
> +    # delete directories
> +    cd $3
> +    ls | xargs rmdir
> +    if [ $? -ne 0 ]; then
> +        echo "Failed to remove directories in $3"
> +        cd - > /dev/null
> +        _scratch_unmount
> +        return
> +    fi
> +    cd - > /dev/null
> +    _scratch_unmount
> +
> +    # check dir_nlink is set
> +    dumpe2fs $SCRATCH_DEV 2> /dev/null | grep '^Filesystem features'

$DUMPE2FS_PROG

> | grep -q dir_nlink
> +    if [ $? -ne 0 ]; then
> +        echo "Feature dir_nlink is not set, please check $seqres.full
> for detail"
> +        return
> +    fi
> +
> +    # run fsck to make sure the filesystem has no errors
> +    $E2FSCK_PROG -fy $SCRATCH_DEV >> $seqres.full 2>&1
> +    if [ $? -ne 0 ]; then
> +        echo "fsck: the filesystem has errors, please check
> $seqres.full for detail"

_check_scratch_fs?

> +        return
> +    fi
> +
> +    prev_result=$PASS
> +}
> +
> +# main
> +DIR_LEN=( $SHORT_DIR $LONG_DIR )
> +PARENT_DIR=( "$SCRATCH_MNT" "$SCRATCH_MNT/sub" )
> +BLOCK_SIZE=( 1024 2048 4096 )
> +
> +for ((i = 0; i < 3; i++)); do
> +    for ((j = 0; j < 2; j++)); do
> +        for ((k = 0; k < 2; k++)); do
> +            if [ ${DIR_LEN[$k]} -eq $LONG_DIR -a \
> +                    ${BLOCK_SIZE[$i]} -eq 1024 ]; then
> +                continue
> +            fi
> +            _workout 65537 ${DIR_LEN[$k]} ${PARENT_DIR[$j]} ${BLOCK_SIZE[$i]}
> +        done
> +    done
> +done
> +
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +# no BUG_ON, all done
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
> index 9dfc0d35..8419cdea 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -45,6 +45,9 @@
>  040 dangerous_fuzzers
>  041 dangerous_fuzzers
>  042 auto quick
> +043 auto quick
> +044 auto quick
> +045 auto

"dir" group too?

--D

>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
