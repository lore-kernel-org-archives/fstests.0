Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD6EC48BDF
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Jun 2021 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AE2610A1
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Jun 2021 14:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhFMOyF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Jun 2021 10:54:05 -0400
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:34283 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhFMOyF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Jun 2021 10:54:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08652434|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0570204-0.00133684-0.941643;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.KRmc75d_1623595920;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KRmc75d_1623595920)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sun, 13 Jun 2021 22:52:01 +0800
Date:   Sun, 13 Jun 2021 22:52:00 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        aweits@rit.edu, dhowells@redhat.com, willy@infradead.org
Subject: Re: [PATCH] generic: add a test to ensure that page is properly
 filled before write
Message-ID: <YMYbkDgYdkLkA0BW@desktop>
References: <20210612123154.8098-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612123154.8098-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jun 12, 2021 at 08:31:54AM -0400, Jeff Layton wrote:
> We had a broken optimization in cephfs and netfs lib that could cause
> part of a page to be improperly zeroed-out when writing to an offset
> that was beyond the EOF but in an existing page.
> 
> Add a simple test that would have caught this.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  tests/generic/XXX     | 53 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/XXX.out |  5 ++++

Ah, all the 'XXX' in this test should be replaced with proper seq
number.

>  tests/generic/group   |  1 +
>  3 files changed, 59 insertions(+)
>  create mode 100755 tests/generic/XXX
>  create mode 100644 tests/generic/XXX.out
> 
> diff --git a/tests/generic/XXX b/tests/generic/XXX
> new file mode 100755
> index 000000000000..0ddaaa544609
> --- /dev/null
> +++ b/tests/generic/XXX
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021, Jeff Layton <jlayton@redhat.com>
> +#
> +# FS QA Test No. XXX
> +#
> +# Open a file and write a little data to it. Unmount (to clean out the cache)
> +# and then mount again. Then write some data to it beyond the EOF and ensure
> +# the result is correct. Prompted by a bug in ceph_write_begin. See:
> +#
> +# https://lore.kernel.org/ceph-devel/97002.1623448034@warthog.procyon.org.uk/T/#m9f34b328623b493c529505e12f64f4dfdbddfb27

This looks like a thread 9 months ago. Was the fix merged? If so, it'd
be better to reference the kernel commit here.

Otherwise test looks fine to me.

Thanks,
Eryu

> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $testfile
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +_supported_fs generic
> +_require_test
> +
> +rm -f $seqres.full
> +
> +testfile="$TEST_DIR/test_write_begin.$$"
> +
> +# write some data to file and fsync it out
> +$XFS_IO_PROG -f -c "pwrite -q 0 32" $testfile
> +
> +# cycle the mount to clean out the pagecache
> +_test_cycle_mount
> +
> +# now, write to the file (near the end)
> +$XFS_IO_PROG -c "pwrite -q 32 32" $testfile
> +
> +# dump what we think is in there
> +echo "The result should be 64 bytes filled with 0xcd:"
> +hexdump -C $testfile
> +
> +status=0
> +exit
> diff --git a/tests/generic/XXX.out b/tests/generic/XXX.out
> new file mode 100644
> index 000000000000..4e7653858e51
> --- /dev/null
> +++ b/tests/generic/XXX.out
> @@ -0,0 +1,5 @@
> +QA output created by XXX
> +The result should be 64 bytes filled with 0xcd:
> +00000000  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> +*
> +00000040
> diff --git a/tests/generic/group b/tests/generic/group
> index 9a636b23f243..204a9b548f78 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -641,3 +641,4 @@
>  636 auto quick swap
>  637 auto quick dir
>  638 auto quick rw
> +XXX auto quick rw
> -- 
> 2.31.1
> 
