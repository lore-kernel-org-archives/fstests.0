Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73945C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 03:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EE92078E
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 03:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgG2DCT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:02:19 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17293 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728401AbgG2DCS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jul 2020 23:02:18 -0400
X-IronPort-AV: E=Sophos;i="5.75,408,1589212800"; 
   d="scan'208";a="97038843"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Jul 2020 11:02:14 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 7C5394CE505C;
        Wed, 29 Jul 2020 11:02:10 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 29 Jul 2020 11:02:10 +0800
Subject: Re: [PATCH] xfs: test that reflink forces the log if mounted with
 wsync
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eryu Guan <guaneryu@gmail.com>
CC:     fstests <fstests@vger.kernel.org>
References: <20200729025203.GX7600@magnolia>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <0fd7ab73-9b6b-7e71-c50a-c829aaa89326@cn.fujitsu.com>
Date:   Wed, 29 Jul 2020 11:02:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200729025203.GX7600@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 7C5394CE505C.AD4DC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Darrick

I remember this case has been merged into xfstests.

See
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=06fd8dbbfe314410a2f55168f92e98ab93666013

Best Regards
Yang Xu

> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> A code inspection revealed that reflink does not force the log to disk
> even if the filesystem is mounted with wsync.  Add a regression test for
> commit 5833112df7e9a ("xfs: reflink should force the log out if mounted
> with wsync").
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>   tests/xfs/914     |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/xfs/914.out |    7 ++++++
>   tests/xfs/group   |    1 +
>   3 files changed, 73 insertions(+)
>   create mode 100755 tests/xfs/914
>   create mode 100644 tests/xfs/914.out
> 
> diff --git a/tests/xfs/914 b/tests/xfs/914
> new file mode 100755
> index 00000000..b835394a
> --- /dev/null
> +++ b/tests/xfs/914
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020, Oracle and/or its affiliates.  All Rights Reserved.
> +#
> +# FS QA Test No. 914
> +#
> +# Make sure that reflink forces the log out if we mount with wsync.  We test
> +# that it actually forced the log by immediately shutting down the fs without
> +# flushing the log and then remounting to check file contents.
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
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_supported_os Linux
> +_require_scratch_reflink
> +_require_cp_reflink
> +
> +rm -f $seqres.full
> +
> +# Format filesystem and set up quota limits
> +_scratch_mkfs > $seqres.full
> +_scratch_mount -o wsync >> $seqres.full
> +
> +# Set up initial files
> +$XFS_IO_PROG -f -c 'pwrite -S 0x58 0 1m -b 1m' $SCRATCH_MNT/a >> $seqres.full
> +$XFS_IO_PROG -f -c 'pwrite -S 0x59 0 1m -b 1m' $SCRATCH_MNT/c >> $seqres.full
> +_cp_reflink $SCRATCH_MNT/a $SCRATCH_MNT/e
> +_cp_reflink $SCRATCH_MNT/c $SCRATCH_MNT/d
> +touch $SCRATCH_MNT/b
> +sync
> +
> +# Test that setting the reflink flag on the dest file forces the log
> +echo "test reflink flag not set"
> +$XFS_IO_PROG -x -c "reflink $SCRATCH_MNT/a" -c 'shutdown' $SCRATCH_MNT/b >> $seqres.full
> +_scratch_cycle_mount wsync
> +md5sum $SCRATCH_MNT/a $SCRATCH_MNT/b | _filter_scratch
> +
> +# Test forcing the log even if both files are already reflinked
> +echo "test reflink flag already set"
> +$XFS_IO_PROG -x -c "reflink $SCRATCH_MNT/a" -c 'shutdown' $SCRATCH_MNT/d >> $seqres.full
> +_scratch_cycle_mount wsync
> +md5sum $SCRATCH_MNT/a $SCRATCH_MNT/d | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/914.out b/tests/xfs/914.out
> new file mode 100644
> index 00000000..6b19fc65
> --- /dev/null
> +++ b/tests/xfs/914.out
> @@ -0,0 +1,7 @@
> +QA output created by 914
> +test reflink flag not set
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/b
> +test reflink flag already set
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/d
> diff --git a/tests/xfs/group b/tests/xfs/group
> index d6e8d1c3..a3d87124 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -518,3 +518,4 @@
>   518 auto quick quota
>   519 auto quick reflink
>   520 auto quick reflink
> +914 auto quick reflink
> 
> 


