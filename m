Return-Path: <SRS0=elmR=DH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B5C2D0A8
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Sep 2020 05:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE56B20706
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Sep 2020 05:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgI3FdG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Sep 2020 01:33:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48108 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725306AbgI3FdG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Sep 2020 01:33:06 -0400
X-IronPort-AV: E=Sophos;i="5.77,321,1596470400"; 
   d="scan'208";a="99769811"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Sep 2020 13:32:56 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 5584448990F6;
        Wed, 30 Sep 2020 13:32:51 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 30 Sep 2020 13:32:48 +0800
Message-ID: <5F741881.5020309@cn.fujitsu.com>
Date:   Wed, 30 Sep 2020 13:32:49 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     <amir73il@gmail.com>
CC:     Xiao Yang <yangx.jy@cn.fujitsu.com>, <fstests@vger.kernel.org>
Subject: Re: [PATCH] overlay/071: Fix undefined OVL_BASE_SCRATCH_DIR
References: <20200930050409.24705-1-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20200930050409.24705-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 5584448990F6.A8452
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Amir,

I always got diffenent inode number if underlying fileystem is ext4.
------------------------------------------------
# diff -u /var/lib/xfstests/tests/overlay/071.out
/var/lib/xfstests/results//overlay/071.out.bad
--- /var/lib/xfstests/tests/overlay/071.out 2020-09-30
12:59:30.478968816 +0800
+++ /var/lib/xfstests/results//overlay/071.out.bad 2020-09-30
13:13:02.342920819 +0800
@@ -1,2 +1,26 @@
QA output created by 071
+--- /tmp/25096.lower.lo 2020-09-30 13:12:59.594920981 +0800
++++ /tmp/25096.before.lo 2020-09-30 13:12:59.706920975 +0800
+@@ -1,7 +1,7 @@
+-8590721028 file
+-8590721029 symlink
+-8590721030 link
+-8590721031 chrdev
+-8590721032 blkdev
+-8590721033 fifo
+-8590721034 socket
++9223372045445496836 file
++9223372045445496837 symlink
++9223372045445496838 link
++9223372045445496839 chrdev
++9223372045445496840 blkdev
++9223372045445496841 fifo
++9223372045445496842 socket
+file not found by ino 8590721028 (from /tmp/25096.lower.lo) - see
/var/lib/xfstests/results//overlay/071.full
+symlink not found by ino 8590721029 (from /tmp/25096.lower.lo) - see
/var/lib/xfstests/results//overlay/071.full
+link not found by ino 8590721030 (from /tmp/25096.lower.lo) - see
/var/lib/xfstests/results//overlay/071.full
+chrdev not found by ino 8590721031 (from /tmp/25096.lower.lo) - see
/var/lib/xfstests/results//overlay/071.full
+blkdev not found by ino 8590721032 (from /tmp/25096.lower.lo) - see
/var/lib/xfstests/results//overlay/071.full
+fifo not found by ino 8590721033 (from /tmp/25096.lower.lo) - see
/var/lib/xfstests/results//overlay/071.full
+socket not found by ino 8590721034 (from /tmp/25096.lower.lo) - see
/var/lib/xfstests/results//overlay/071.full
Silence is golde
------------------------------------------------
Is this expected behavior? :-)

Best Regards,
Xiao Yang
On 2020/9/30 13:04, Xiao Yang wrote:
> Replace undefined OVL_BASE_SCRATCH_DIR with OVL_BASE_SCRATCH_MNT
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/overlay/071 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/overlay/071 b/tests/overlay/071
> index f18429c9..ac2324c8 100755
> --- a/tests/overlay/071
> +++ b/tests/overlay/071
> @@ -59,9 +59,9 @@ lower=$OVL_BASE_TEST_DIR/$OVL_LOWER-$seq
>  upper=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
>  work=$OVL_BASE_SCRATCH_MNT/$OVL_WORK
>  # Lower dir of nested overlay is the scratch overlay mount at SCRATCH_MNT
> -upper2=$OVL_BASE_SCRATCH_DIR/$OVL_UPPER.2
> -work2=$OVL_BASE_SCRATCH_DIR/$OVL_WORK.2
> -mnt2=$OVL_BASE_SCRATCH_DIR/$OVL_MNT.2
> +upper2=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER.2
> +work2=$OVL_BASE_SCRATCH_MNT/$OVL_WORK.2
> +mnt2=$OVL_BASE_SCRATCH_MNT/$OVL_MNT.2
>  
>  lowerdir=$lower/lowertestdir
>  upperdir=$upper/uppertestdir



