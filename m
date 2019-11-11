Return-Path: <SRS0=0kg8=ZD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E3C43331
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 07:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60203206A3
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 07:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="gyt7nArs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKKHU7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:20:59 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:56146 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfKKHU6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Nov 2019 02:20:58 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id E00522E0AD4;
        Mon, 11 Nov 2019 10:20:54 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id XPqS8uPL64-KsIuD01F;
        Mon, 11 Nov 2019 10:20:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573456854; bh=lrhPtWVrLA6DJI9dpVzBK5PDsqhmY4ygugSfOzz5m6w=;
        h=Message-ID:Subject:Date:References:To:From:In-Reply-To:Cc;
        b=gyt7nArstFlaFrXD3eQXVUq2SWy6x7JCTKfhq/qXvzEKkoKUfoajL9dejnfdJ20mC
         0x5nJwoUFdTU1jD6VTUvtlK0UOHbbvPQctQ9Brlj20in4Xv2zJBoCNYQbbsAyX1amJ
         89UrvfXXFih1Eyf+Vc/dkzDNT2IzMxRQgCpZ/+Yo=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id R8aDnJoBYI-KsU08dmm;
        Mon, 11 Nov 2019 10:20:54 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH 1/2] add generic/585
In-Reply-To: <20191110163332.GF8664@desktop>
References: <20191031103639.3786-1-dmonakhov@openvz.org> <20191110163332.GF8664@desktop>
Date:   Mon, 11 Nov 2019 10:20:54 +0300
Message-ID: <871rue5161.fsf@dmws.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Eryu Guan <guaneryu@gmail.com> writes:

> On Thu, Oct 31, 2019 at 10:36:38AM +0000, Dmitry Monakhov wrote:
>> From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>> 
>> Quotasync may livelock if others tasks generate enough dirty dquots in parallel
>> This test case pefrorm fchown to produce dirty quotas
>> 
>> This test known to detect livelock non-journaled quota for kernels prior to v5.4
>> 
>> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>> ---
>>  src/Makefile          |   2 +-
>>  src/chowner.c         | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++
>
> Missing an entry in .gitingore
>
>>  tests/generic/585     |  94 ++++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/585.out |   2 +
>>  tests/generic/group   |   1 +
>>  5 files changed, 205 insertions(+), 1 deletion(-)
>>  create mode 100644 src/chowner.c
>>  create mode 100755 tests/generic/585
>>  create mode 100644 tests/generic/585.out
>> 
>> diff --git a/src/Makefile b/src/Makefile
>> index ce6d861..b3ab7b4 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -28,7 +28,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>>  	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
>>  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
>>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>> -	fscrypt-crypt-util bulkstat_null_ocount
>> +	fscrypt-crypt-util bulkstat_null_ocount chowner
>>  
>>  SUBDIRS = log-writes perf
>>  
>> diff --git a/src/chowner.c b/src/chowner.c
>> new file mode 100644
>> index 0000000..043cd06
>> --- /dev/null
>> +++ b/src/chowner.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (c) 2019 YANDEX LLC.  All Rights Reserved.
>> +// Author: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>> +
>> +#include <unistd.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <time.h>
>> +#include <sys/time.h>
>> +#include <fcntl.h>
>> +#include <limits.h>
>> +
>> +char *progname;
>> +
>> +void usage(void)
>> +{
>> +	printf("Usage %s: [-b uid] [-e uid] [-g] [-P] [-t timeout] FNAME\n", progname);
>> +	printf("\t\t -b: begin of uid range\n");
>> +	printf("\t\t -e: length of uid range\n");
>                          ^^^^^^ should be end of uid range?
>
>> +	printf("\t\t -g: change group uid\n");
>> +	printf("\t\t -t: loop timeout\n");
>> +	printf("\t\t -P: Do not run chowner loop, only prepare files\n");
>> +	exit(1);
>> +}
>> +int main(int argc, char *const *argv)
>> +{
>> +	char *filename;
>> +	int fd;
>> +	int c;
>> +	uid_t begin = 2000;
>> +	uid_t end = 12000;
>> +	unsigned int timeout = 10;
>> +	struct timeval start, now, delta = { 0, 0 };
>> +	uid_t uid;
>> +	gid_t gid = getegid();
>> +	int do_group = 0;
>> +	int do_prepare = 0;
>> +
>> +	progname = argv[0];
>> +	while ((c = getopt(argc, argv, "b:e:gPt:")) != -1) {
>> +		switch (c) {
>> +		case 'b':
>> +			begin = atoi(optarg);
>> +			break;
>> +		case 'e':
>> +			end = atoi(optarg);
>> +			break;
>> +		case 'g':
>> +			do_group = 1;
>> +			break;
>> +		case 'P':
>> +			do_prepare = 1;
>> +			break;
>> +		case 't':
>> +			timeout = atoi(optarg);
>> +			break;
>> +		default:
>> +			usage();
>> +		}
>> +	}
>> +	if (optind == argc-1)
>> +		filename = argv[optind];
>> +	else
>> +		usage();
>> +	if (do_prepare) {
>> +		char path[PATH_MAX];
>> +		for (uid = begin; uid < end;uid++) {
>> +			sprintf(path, "%s.%d", filename, uid);
>
> So in do_prepare case, expect filename to be a filename prefix? Or a
> directory? From the test code, it seems to be a dir, but this c code
> treats as an filename prefix.
>
> # Preparation step: Create all files with uid in range
> # to cache quota in kernel memory
> mkdir -p $SCRATCH_MNT/q
> $here/src/chowner $SCRATCH_MNT/q -b $begin -e $end -P
>
>> +			fd = open(path, O_RDWR|O_CREAT, 0666);
>> +			if (fd < 0) {
>> +				perror("open");
>> +				exit(1);
>> +			}
>> +			if (do_group)
>> +				gid = uid;
>> +			if (fchown(fd, uid, gid)) {
>> +				perror("chown");
>> +				exit(1);
>> +			}
>> +			close(fd);
>> +		}
>> +		return 0;
>> +	}
>> +	fd = open(filename, O_RDWR|O_CREAT, 0666);
>> +	if (fd < 0) {
>> +		perror("open");
>> +		exit(1);
>> +	}
>> +	gettimeofday(&start, NULL);
>> +
>> +	while (1) {
>> +		for (uid = begin; uid < end;uid++) {
>> +			if (do_group)
>> +				gid = uid;
>> +			if (fchown(fd, uid, gid)) {
>> +				perror("chown");
>> +				exit(1);
>> +			}
>> +		}
>> +		gettimeofday(&now, NULL);
>> +		timersub(&now, &start, &delta);
>> +		if (delta.tv_sec >= timeout)
>> +			break;
>> +	}
>> +	return 0;
>> +}
>> diff --git a/tests/generic/585 b/tests/generic/585
>> new file mode 100755
>> index 0000000..d37522a
>> --- /dev/null
>> +++ b/tests/generic/585
>> @@ -0,0 +1,94 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 YANDEX LLC.  All Rights Reserved.
>> +#
>> +# FS QA Test 585
>> +#
>> +# Check livelock during quota-sync  while other tasks dirty quotas in parallel.
>> +# Run fchown(2) in a loop is the fastest way to produce dirty quotas
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/quota
>> +
>> +
>> +begin=2000
>> +end=10000
>> +nr_proc=$((16 * LOAD_FACTOR))
>> +deadline=$((100 * TIME_FACTOR))
>
> So this test has two "_workout"s, and one takes around 120s, so whole
> test takes around 4 minutes, which seems a bit long for a generic test.
>
> What's the reproducibility if you lower the runtime? I'd be good to find
> a good banalce between reproducibility and test run time. e.g. 20s for
> 60% reproducibility is better than 240s for 90%.
This happens only in case of deadlock detected, normaly it will
take ~25-30sec. I can lower this number to 20sec.
All other notes are valid and will be fixed in v2.
>
>> +
>> +_workout()
>
> Local functions doesn't need "_" prefix.
>
>> +{
>> +    for ((i=0; i < nr_proc; i++))
>> +    do
>
> Use tab for indention. And the indentions are not consistent, some lines
> use tab and some lines use spaces.
>
>> +	# Spread files to isolated dirs to minimize locking contention
>> +	mkdir -p $SCRATCH_MNT/chowner/$i
>> +	$here/src/chowner $SCRATCH_MNT/chowner/$i/test -b $begin -e $end \
>> +			  -t $((deadline + 10)) &
>> +	pids="$pids $!"
>> +    done
>> +    # Let chowners warm up ...
>> +    sleep 5
>> +    start=$(date +%s)
>> +    for ((i=0;i<3;i++))
>> +    do
>> +	s=$(date +%s)
>> +	# In normal situation command should finish in ~1sec,
>> +	# but in case of livelock it will spin until chowners exits
>> +	$*
>> +	e=$(date +%s)
>> +	echo "loop $i: $* runtime: $((e-s))" >> $seqres.full
>> +	sleep 2
>> +    done
>> +    end=$(date +%s)
>> +    runtime=$((end-start))
>> +    echo "DONE: $* total runtime: $runtime"  >> $seqres.full
>> +    kill -TERM $pids 2> /dev/null
>> +    wait $pids
>> +
>> +    [ $runtime -le $deadline ] || \
>> +	_fail "Live lock detected, $* runtime: $runtime, deadline: $deadline"
>> +}
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_quota
>> +#_require_user
>
> Could be removed.
>
>> +_require_scratch
>> +_require_command "$KILLALL_PROG" killall
>
> killall is not used, can be removed.
>
> And we need
>
> _require_test_program "chowner"
>
>> +
>> +rm -f $seqres.full
>> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
>
> Any reason to use sized mkfs?
>
>> +_scratch_mount "-o quota,user"
>> +chmod 777 $SCRATCH_MNT
>> +quotacheck -u $SCRATCH_MNT 2>/dev/null
>> +quotaon -v -u $SCRATCH_MNT >> $seqres.full 2>&1
>
> Above steps could be replaced by:
>
> _qmount_option "usrquota"
> _qmount
>
> Thanks,
> Eryu
>
>> +
>> +# Preparation step: Create all files with uid in range
>> +# to cache quota in kernel memory
>> +mkdir -p $SCRATCH_MNT/q
>> +$here/src/chowner $SCRATCH_MNT/q -b $begin -e $end -P
>> +
>> +_workout quotasync $SCRATCH_MNT
>> +_workout sync
>> +
>> +echo "Silence is golden"
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/585.out b/tests/generic/585.out
>> new file mode 100644
>> index 0000000..e4dd43b
>> --- /dev/null
>> +++ b/tests/generic/585.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 585
>> +Silence is golden
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 42ca2b9..703a1b4 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -587,3 +587,4 @@
>>  582 auto quick encrypt
>>  583 auto quick encrypt
>>  584 auto quick encrypt
>> +585 auto quota rw stress
>> -- 
>> 2.7.4
>> 
