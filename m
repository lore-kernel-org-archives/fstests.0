Return-Path: <SRS0=7tTV=ZC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D00C43331
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Nov 2019 16:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76643214E0
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Nov 2019 16:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsUFEzbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKJQdp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Nov 2019 11:33:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34066 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfKJQdp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Nov 2019 11:33:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so1250753plr.1
        for <fstests@vger.kernel.org>; Sun, 10 Nov 2019 08:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hYv/uD84l5Ocg/3YaFDS/nvfdN/chJK6PpLrkQbFlhk=;
        b=gsUFEzbEzeGPRxeKlPA4gqIW9KAcSkcVJEyXx0Dar2fFYiKFHLpaO8a46bPChEKxM7
         DELoA2nfzA75mSzlPAnLmBMwu6ySPUBMybH+1jiKkjehP993aAkvuPeqlD0WBflSbAVc
         KllV/aTNq9rLzra9YkmMtebnRT3jDMdrJZnp/g011KGFUfRumm4y6L/89MQYMgJNbKa8
         G/MXRl2FxcIC15XyMMc/iFWbJg96ZW32NuXU027gfaZhVzlqe8m0sEYkRlrb4RWoODrN
         pgFUZEUPoYxpiL7t4aEiFVCqN35QwsxHQ8NBM2lrPIif4oIdeHyi+OMdXe7a+sEXxR6O
         2CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hYv/uD84l5Ocg/3YaFDS/nvfdN/chJK6PpLrkQbFlhk=;
        b=dZgTZlHEa9CNbqaeZ53Yt84xbsqbESII31xoe/O9ySvhOvtAxRwL/lWn04KKeT15uA
         rKf1WxqyH6NF9i3CtcEQ1L2ivOqBvjZ8UtlVGZh4+MT9vp/FzGuD6fOD+RHK5hmLYNne
         U8E0YGfcaYMEVWdL8Wd1b7db5gse4CM5t2NNbw8fkszsgXt6IHv3N7GtIKYLMR62/jQN
         JAXqBaA9MF1DKRwVsa5GhOnj7mOIYIcOw4EH8bJOiG8iKTYZAmJSs0GNgyhCDbxrS5PP
         le7wLtPIuDeQsVcn75mPpgBAW7fUj8HaLXkesNn4ouQGy0yUAPC7MBEow2zKfscvG1NJ
         5bZA==
X-Gm-Message-State: APjAAAW/CmGQUtIKVD9ZTjYZiM8EZqBXEu30uY7AcCqNBjF68H0f32vC
        yg+HwjG6VYQyh+0OysQFITPR1nIz
X-Google-Smtp-Source: APXvYqwqvCBy5D8DY/P6RnOEyvmwA+SMAi1P9/EDKA5w5RXC3aqQ+DVqnMXFR9DZTTOuEfMOmXW7xA==
X-Received: by 2002:a17:902:8bcb:: with SMTP id r11mr11035035plo.11.1573403622315;
        Sun, 10 Nov 2019 08:33:42 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id r22sm15664754pfg.54.2019.11.10.08.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 08:33:40 -0800 (PST)
Date:   Mon, 11 Nov 2019 00:33:35 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Dmitry Monakhov <dmonakhov@openvz.org>
Cc:     fstests@vger.kernel.org, jack@suse.cz,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH 1/2] add generic/585
Message-ID: <20191110163332.GF8664@desktop>
References: <20191031103639.3786-1-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031103639.3786-1-dmonakhov@openvz.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 31, 2019 at 10:36:38AM +0000, Dmitry Monakhov wrote:
> From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> 
> Quotasync may livelock if others tasks generate enough dirty dquots in parallel
> This test case pefrorm fchown to produce dirty quotas
> 
> This test known to detect livelock non-journaled quota for kernels prior to v5.4
> 
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
>  src/Makefile          |   2 +-
>  src/chowner.c         | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++

Missing an entry in .gitingore

>  tests/generic/585     |  94 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/585.out |   2 +
>  tests/generic/group   |   1 +
>  5 files changed, 205 insertions(+), 1 deletion(-)
>  create mode 100644 src/chowner.c
>  create mode 100755 tests/generic/585
>  create mode 100644 tests/generic/585.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index ce6d861..b3ab7b4 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -28,7 +28,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
>  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> -	fscrypt-crypt-util bulkstat_null_ocount
> +	fscrypt-crypt-util bulkstat_null_ocount chowner
>  
>  SUBDIRS = log-writes perf
>  
> diff --git a/src/chowner.c b/src/chowner.c
> new file mode 100644
> index 0000000..043cd06
> --- /dev/null
> +++ b/src/chowner.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2019 YANDEX LLC.  All Rights Reserved.
> +// Author: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> +
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <sys/time.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +
> +char *progname;
> +
> +void usage(void)
> +{
> +	printf("Usage %s: [-b uid] [-e uid] [-g] [-P] [-t timeout] FNAME\n", progname);
> +	printf("\t\t -b: begin of uid range\n");
> +	printf("\t\t -e: length of uid range\n");
                         ^^^^^^ should be end of uid range?

> +	printf("\t\t -g: change group uid\n");
> +	printf("\t\t -t: loop timeout\n");
> +	printf("\t\t -P: Do not run chowner loop, only prepare files\n");
> +	exit(1);
> +}
> +int main(int argc, char *const *argv)
> +{
> +	char *filename;
> +	int fd;
> +	int c;
> +	uid_t begin = 2000;
> +	uid_t end = 12000;
> +	unsigned int timeout = 10;
> +	struct timeval start, now, delta = { 0, 0 };
> +	uid_t uid;
> +	gid_t gid = getegid();
> +	int do_group = 0;
> +	int do_prepare = 0;
> +
> +	progname = argv[0];
> +	while ((c = getopt(argc, argv, "b:e:gPt:")) != -1) {
> +		switch (c) {
> +		case 'b':
> +			begin = atoi(optarg);
> +			break;
> +		case 'e':
> +			end = atoi(optarg);
> +			break;
> +		case 'g':
> +			do_group = 1;
> +			break;
> +		case 'P':
> +			do_prepare = 1;
> +			break;
> +		case 't':
> +			timeout = atoi(optarg);
> +			break;
> +		default:
> +			usage();
> +		}
> +	}
> +	if (optind == argc-1)
> +		filename = argv[optind];
> +	else
> +		usage();
> +	if (do_prepare) {
> +		char path[PATH_MAX];
> +		for (uid = begin; uid < end;uid++) {
> +			sprintf(path, "%s.%d", filename, uid);

So in do_prepare case, expect filename to be a filename prefix? Or a
directory? From the test code, it seems to be a dir, but this c code
treats as an filename prefix.

# Preparation step: Create all files with uid in range
# to cache quota in kernel memory
mkdir -p $SCRATCH_MNT/q
$here/src/chowner $SCRATCH_MNT/q -b $begin -e $end -P

> +			fd = open(path, O_RDWR|O_CREAT, 0666);
> +			if (fd < 0) {
> +				perror("open");
> +				exit(1);
> +			}
> +			if (do_group)
> +				gid = uid;
> +			if (fchown(fd, uid, gid)) {
> +				perror("chown");
> +				exit(1);
> +			}
> +			close(fd);
> +		}
> +		return 0;
> +	}
> +	fd = open(filename, O_RDWR|O_CREAT, 0666);
> +	if (fd < 0) {
> +		perror("open");
> +		exit(1);
> +	}
> +	gettimeofday(&start, NULL);
> +
> +	while (1) {
> +		for (uid = begin; uid < end;uid++) {
> +			if (do_group)
> +				gid = uid;
> +			if (fchown(fd, uid, gid)) {
> +				perror("chown");
> +				exit(1);
> +			}
> +		}
> +		gettimeofday(&now, NULL);
> +		timersub(&now, &start, &delta);
> +		if (delta.tv_sec >= timeout)
> +			break;
> +	}
> +	return 0;
> +}
> diff --git a/tests/generic/585 b/tests/generic/585
> new file mode 100755
> index 0000000..d37522a
> --- /dev/null
> +++ b/tests/generic/585
> @@ -0,0 +1,94 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 YANDEX LLC.  All Rights Reserved.
> +#
> +# FS QA Test 585
> +#
> +# Check livelock during quota-sync  while other tasks dirty quotas in parallel.
> +# Run fchown(2) in a loop is the fastest way to produce dirty quotas
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
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/quota
> +
> +
> +begin=2000
> +end=10000
> +nr_proc=$((16 * LOAD_FACTOR))
> +deadline=$((100 * TIME_FACTOR))

So this test has two "_workout"s, and one takes around 120s, so whole
test takes around 4 minutes, which seems a bit long for a generic test.

What's the reproducibility if you lower the runtime? I'd be good to find
a good banalce between reproducibility and test run time. e.g. 20s for
60% reproducibility is better than 240s for 90%.

> +
> +_workout()

Local functions doesn't need "_" prefix.

> +{
> +    for ((i=0; i < nr_proc; i++))
> +    do

Use tab for indention. And the indentions are not consistent, some lines
use tab and some lines use spaces.

> +	# Spread files to isolated dirs to minimize locking contention
> +	mkdir -p $SCRATCH_MNT/chowner/$i
> +	$here/src/chowner $SCRATCH_MNT/chowner/$i/test -b $begin -e $end \
> +			  -t $((deadline + 10)) &
> +	pids="$pids $!"
> +    done
> +    # Let chowners warm up ...
> +    sleep 5
> +    start=$(date +%s)
> +    for ((i=0;i<3;i++))
> +    do
> +	s=$(date +%s)
> +	# In normal situation command should finish in ~1sec,
> +	# but in case of livelock it will spin until chowners exits
> +	$*
> +	e=$(date +%s)
> +	echo "loop $i: $* runtime: $((e-s))" >> $seqres.full
> +	sleep 2
> +    done
> +    end=$(date +%s)
> +    runtime=$((end-start))
> +    echo "DONE: $* total runtime: $runtime"  >> $seqres.full
> +    kill -TERM $pids 2> /dev/null
> +    wait $pids
> +
> +    [ $runtime -le $deadline ] || \
> +	_fail "Live lock detected, $* runtime: $runtime, deadline: $deadline"
> +}
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_quota
> +#_require_user

Could be removed.

> +_require_scratch
> +_require_command "$KILLALL_PROG" killall

killall is not used, can be removed.

And we need

_require_test_program "chowner"

> +
> +rm -f $seqres.full
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1

Any reason to use sized mkfs?

> +_scratch_mount "-o quota,user"
> +chmod 777 $SCRATCH_MNT
> +quotacheck -u $SCRATCH_MNT 2>/dev/null
> +quotaon -v -u $SCRATCH_MNT >> $seqres.full 2>&1

Above steps could be replaced by:

_qmount_option "usrquota"
_qmount

Thanks,
Eryu

> +
> +# Preparation step: Create all files with uid in range
> +# to cache quota in kernel memory
> +mkdir -p $SCRATCH_MNT/q
> +$here/src/chowner $SCRATCH_MNT/q -b $begin -e $end -P
> +
> +_workout quotasync $SCRATCH_MNT
> +_workout sync
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/585.out b/tests/generic/585.out
> new file mode 100644
> index 0000000..e4dd43b
> --- /dev/null
> +++ b/tests/generic/585.out
> @@ -0,0 +1,2 @@
> +QA output created by 585
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 42ca2b9..703a1b4 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -587,3 +587,4 @@
>  582 auto quick encrypt
>  583 auto quick encrypt
>  584 auto quick encrypt
> +585 auto quota rw stress
> -- 
> 2.7.4
> 
