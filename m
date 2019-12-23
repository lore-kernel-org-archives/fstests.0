Return-Path: <SRS0=A77W=2N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09793C2D0C0
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 08:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37D8206CB
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 08:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qFLlkXcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfLWIgL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:36:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48852 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfLWIgL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Dec 2019 03:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577090181; x=1608626181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uilhhMaPR+5cf3Nj1nI4Se5fJn+ICPZvSdfzGu/l/bg=;
  b=qFLlkXcgD3io6joVMRKFK7h3HIlJem3enSAYontDlk87OWqhZQ1Pm3oJ
   3Q8A7S2W4Xmqm08mfu/vyRhf41rwQuG5ga2ORy0bYHJzOiJw113+7p9ly
   Kff5ZgrwuXDw5bE7ZJc5X1ekUKBKLCwPVHiL7pAqYxC4wh/vRm429ny1n
   I1KQm1q61mlk3wHPHHV288d1nNWrhlQ4jucZSkS+sEzaYBnD3WjnHJSoU
   P59uwTu/Ttdrver1mwIjL8aU/40AiSzPNwZ3EIapTqWp3pQ7+nbJ3PORv
   fYwEEp9S1cxektHvG/juGmSo04F+6Y+F85+ISUo49Ls9g/lF039Xwzmuq
   Q==;
IronPort-SDR: OEn4Q5m79JoMvzLRod2OzJpL7KolitYCy7JaeWmA9STmd5KLBwn36l7PSuh10uPFA5rB//Ut6J
 XOhmmML3651UBOJl/z84BhA+MQLIg9dS9uUoG3rbjRczY86S2dD9HK+jJJjJFMpf9uVflZDwnj
 LY4xP8rnCpUupHbfk3cqZe5nrXnfsRR1+/GVtgPXiqHr2NilcdrFUSfOOwjYqe0Ing7J8nsKu+
 02/O9ipbfFcrUoYeHI5TRWDUhEy8XiA22TZ7U2g4s8HFGVYvqGfxORGaQ7NgNHIM36LPpZ3j3R
 +FU=
X-IronPort-AV: E=Sophos;i="5.69,346,1571673600"; 
   d="scan'208";a="227582669"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Dec 2019 16:36:21 +0800
IronPort-SDR: RqtyKZwZ8zgYUC/wfPH+DW4DIBAxRwsRySZy7gfJkxRKPGyW5PdwIMrk/5XH+fbdIyTlzsa0FL
 RI/DKa4T151a/MIYYVhN3I6R6w8CdMPTRJyEUuLanLlbTX7jz0LJ8vU/7USFrepX0e1eTZd2cT
 5r14taxG9Sh0nmqRWkif5wYJ741hFClpLaHo+QmkPrs0nbCeAtZoJt9YwVTGRZP8i7phvAJih2
 ZREEax6C0YT3YL6zXX4p+LqQnYppBFy5B53gtMNZcaRY/w2GQpvhhUhrYPWYUtSrjxVziGu4jv
 pBwASolIJCfEGgqqdTWyt8t0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 00:30:04 -0800
IronPort-SDR: IInua9KQ+cuPfk3p2LSHoq278LJNPGi13jLZvcWInpuEACSWWTrwU5H5DF6uzgkWLUbHGVln91
 LNG7kA6yQ5ZGwHAkTCzB01jPYiMpxCrIfA/ilgTMMyh5ONpAtdwJTb1Nvr5lPI0T34mVqL2Z46
 lcayWIIoYl3J1ec5ZN5fvQZmfkTn/2uFDiYxuE7/HDRZBDnqzMx56ny1b2n1FwNjOUWHohYmCl
 X1sJ7sjVM+u2NtuKv3MRg8vQosJLwPphJCr0YkALnGh3AauPupf2Uvd1dTuzCwU2Vj0/Awsizm
 fp4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with SMTP; 23 Dec 2019 00:36:10 -0800
Received: (nullmailer pid 2897502 invoked by uid 1000);
        Mon, 23 Dec 2019 08:36:08 -0000
Date:   Mon, 23 Dec 2019 17:36:08 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Kusanagi Kouichi <slash@ac.auone-net.jp>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/{003,120,192}: Set atime options precisely
Message-ID: <20191223083608.4fytirftalw5arga@naota.dhcp.fujisawa.hgst.com>
References: <20191221085518708.CZTM.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191221085518708.CZTM.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Dec 21, 2019 at 05:55:18PM +0900, Kusanagi Kouichi wrote:
>Make tests pass regardless of options set by MOUNT_OPTIONS.
>
>Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
>---
> common/rc         | 3 +--
> tests/generic/003 | 6 +++---
> tests/generic/120 | 2 +-
> tests/generic/192 | 1 +
> 4 files changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/common/rc b/common/rc
>index 5cdd829b..e2f081c0 100644
>--- a/common/rc
>+++ b/common/rc
>@@ -440,7 +440,7 @@ _test_cycle_mount()
> 	return
>     fi
>     _test_unmount
>-    _test_mount
>+    _test_mount "$@"
> }
>
> _scratch_mkfs_options()

It would be less confusing to have the same interface as
_scratch_cycle_mount().

>@@ -3392,7 +3392,6 @@ _exclude_scratch_mount_option()
>
> _require_atime()
> {
>-	_exclude_scratch_mount_option "noatime"
> 	case $FSTYP in
> 	nfs|cifs)
> 		_notrun "atime related mount options have no effect on $FSTYP"
>diff --git a/tests/generic/003 b/tests/generic/003
>index 767d7059..a634b1a4 100755
>--- a/tests/generic/003
>+++ b/tests/generic/003
>@@ -66,7 +66,7 @@ _compare_stat_times() {
> }
>
> _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
>-_scratch_mount "-o relatime"
>+_scratch_mount "-o atime,nostrictatime,relatime"
>
> if [ "$FSTYP" = "btrfs" ]; then
> 	TPATH=$SCRATCH_MNT/sub1
>@@ -94,7 +94,7 @@ _compare_stat_times NNN "$file1_stat_after_first_access" \
> 	"$file1_stat_after_second_access" "after accessing file1 second time"
>
> # Mounting with nodiratime option
>-_scratch_cycle_mount "nodiratime"
>+_scratch_cycle_mount "atime,nodiratime"
> file1_stat_after_remount=`_stat $TPATH/dir1/file1`
> _compare_stat_times NNN "$file1_stat_after_second_access" \
> 	"$file1_stat_after_remount" "for file1 after remount"
>@@ -120,7 +120,7 @@ _compare_stat_times NNN "$dir2_stat_after_file_creation" \
> 	"$dir2_stat_after_file_access" "for dir2 after file access"
>
> # Mounting with noatime option, creating a file and accessing it
>-_scratch_cycle_mount "noatime"
>+_scratch_cycle_mount "noatime,nostrictatime"
> echo "ccc" > $TPATH/dir2/file3
> file3_stat_before_first_access=`_stat $TPATH/dir2/file3`
> sleep 1
>diff --git a/tests/generic/120 b/tests/generic/120
>index 48ca9508..2f86d9fc 100755
>--- a/tests/generic/120
>+++ b/tests/generic/120
>@@ -44,7 +44,7 @@ _compare_access_times()
>
> }
>
>-if ! _try_scratch_mount "-o noatime" >$tmp.out 2>&1
>+if ! _try_scratch_mount "-o noatime,nostrictatime" >$tmp.out 2>&1
> then
>     cat $tmp.out
>     echo "!!! mount failed"

I'm not sure about these parts, but personally I think it's OK to just
skip atime related tests when you explicitly specify
MOUNT_OPTIONS=noatime. So, you state you want to test FS behavior with
noatime by specifying the MOUNT_OPTIONS, then it would be no use to
run those atime related tests anyway.

Or, we need to add _exclude_scratch_mount_option "strictatime" also?

>diff --git a/tests/generic/192 b/tests/generic/192
>index 50b3d6fd..37197979 100755
>--- a/tests/generic/192
>+++ b/tests/generic/192
>@@ -38,6 +38,7 @@ testfile=$TEST_DIR/testfile
> rm -f $testfile
> rm -f $seqres.full
>
>+_test_cycle_mount -o atime
> echo test >$testfile
> time1=`_access_time $testfile | tee -a $seqres.full`
>
>-- 
>2.24.1
>

