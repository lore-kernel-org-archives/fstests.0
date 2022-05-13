Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2585EC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 13 May 2022 03:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351518AbiEMDS6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 23:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348514AbiEMDS5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 23:18:57 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2078A7A817
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 20:18:55 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AijZXzq4sV6IkYx8Waa+2MQxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1mEOy2sYDWiGOPbbYDD0KdEiO4zg9h9Vv56Ez9BmTlE5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyTl6ZfNlhSun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpkm8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZ1kQU6PL4EzMVcBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124203611"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 May 2022 11:18:55 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id E5E734D17197
        for <fstests@vger.kernel.org>; Fri, 13 May 2022 11:18:51 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 13 May 2022 11:18:50 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 13 May 2022 11:18:52 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 13 May 2022 11:18:49 +0800
Message-ID: <c5b484fa-2fe0-0e9e-c0c7-9b9cd595d115@fujitsu.com>
Date:   Fri, 13 May 2022 11:18:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] xfs: add memory failure test for dax&reflink mode
To:     <fstests@vger.kernel.org>
References: <20220513031411.2369314-1-ruansy.fnst@fujitsu.com>
 <20220513031411.2369314-3-ruansy.fnst@fujitsu.com>
CC:     <ruansy.fnst@fujitsu.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220513031411.2369314-3-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: E5E734D17197.AE56F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2022/5/13 11:14, Shiyang Ruan 写道:
> Verify that the dax-rmap feature works.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Oh, sorry, I forgot to add Darrick's RVB[1]:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

[1] 
https://lore.kernel.org/fstests/20220427062238.dkgkuzyh3ho2oirt@zlang-mailbox/T/#m0cb12aec91b1ddc92e1907ed0354773778507893

> ---
>   tests/xfs/901     | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>   tests/xfs/901.out |  9 +++++++++
>   2 files changed, 58 insertions(+)
>   create mode 100755 tests/xfs/901
>   create mode 100644 tests/xfs/901.out
> 
> diff --git a/tests/xfs/901 b/tests/xfs/901
> new file mode 100755
> index 00000000..26c1581e
> --- /dev/null
> +++ b/tests/xfs/901
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 901
> +#
> +# Test memory failure mechanism when dax and reflink working together
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone dax
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_check_dmesg
> +_require_scratch_reflink
> +_require_cp_reflink
> +_require_xfs_scratch_rmapbt
> +_require_scratch_dax_mountopt "dax"
> +_require_test_program "t_mmap_cow_memory_failure"
> +
> +echo "Format and mount"
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount "-o dax" >> $seqres.full 2>&1
> +
> +testdir=$SCRATCH_MNT/test-$seq
> +mkdir $testdir
> +
> +echo "Create the original files"
> +filesize=65536
> +_pwrite_byte 0x61 0 $filesize $testdir/testfile >> $seqres.full
> +_cp_reflink $testdir/testfile $testdir/poisonfile >> $seqres.full
> +_scratch_cycle_mount "dax"
> +
> +echo "Inject memory failure (1 page)"
> +# create two processes:
> +#  process1: mread 1 page to cause page fault, and wait
> +#  process2: mread 1 page to cause page fault, then inject poison on this page
> +$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/poisonfile
> +
> +echo "Inject memory failure (2 pages)"
> +$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/poisonfile
> +
> +_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
> +_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
> +
> +# success, all done
> +status=0
> diff --git a/tests/xfs/901.out b/tests/xfs/901.out
> new file mode 100644
> index 00000000..92d64846
> --- /dev/null
> +++ b/tests/xfs/901.out
> @@ -0,0 +1,9 @@
> +QA output created by 901
> +Format and mount
> +Create the original files
> +Inject memory failure (1 page)
> +Inject posion...
> +Process is killed by signal: 7
> +Inject memory failure (2 pages)
> +Inject posion...
> +Process is killed by signal: 7


