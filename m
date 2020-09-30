Return-Path: <SRS0=elmR=DH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD7C4727E
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Sep 2020 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DD720754
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Sep 2020 14:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgI3OFg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Sep 2020 10:05:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12285 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728149AbgI3OFg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Sep 2020 10:05:36 -0400
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; 
   d="scan'208";a="99788436"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Sep 2020 22:05:26 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id B41D748990D5;
        Wed, 30 Sep 2020 22:05:20 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 30 Sep 2020 22:05:18 +0800
Message-ID: <5F74909E.6040400@cn.fujitsu.com>
Date:   Wed, 30 Sep 2020 22:05:18 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Amir Goldstein <amir73il@gmail.com>
CC:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] overlay/071: Fix undefined OVL_BASE_SCRATCH_DIR
References: <20200930050409.24705-1-yangx.jy@cn.fujitsu.com> <5F741881.5020309@cn.fujitsu.com> <CAOQ4uxhXBbmAiGpiAx8=3TiFi-Or+dfEgET5rHwBTYFd+df1Zg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhXBbmAiGpiAx8=3TiFi-Or+dfEgET5rHwBTYFd+df1Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: B41D748990D5.A817A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/9/30 15:54, Amir Goldstein wrote:
> On Wed, Sep 30, 2020 at 8:33 AM Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>> Hi Amir,
>>
>> I always got diffenent inode number if underlying fileystem is ext4.
>> ------------------------------------------------
>> # diff -u /var/lib/xfstests/tests/overlay/071.out
>> /var/lib/xfstests/results//overlay/071.out.bad
>> --- /var/lib/xfstests/tests/overlay/071.out 2020-09-30
>> 12:59:30.478968816 +0800
>> +++ /var/lib/xfstests/results//overlay/071.out.bad 2020-09-30
>> 13:13:02.342920819 +0800
>> @@ -1,2 +1,26 @@
>> QA output created by 071
>> +--- /tmp/25096.lower.lo 2020-09-30 13:12:59.594920981 +0800
>> ++++ /tmp/25096.before.lo 2020-09-30 13:12:59.706920975 +0800
>> +@@ -1,7 +1,7 @@
>> +-8590721028 file
>> +-8590721029 symlink
>> +-8590721030 link
>> +-8590721031 chrdev
>> +-8590721032 blkdev
>> +-8590721033 fifo
>> +-8590721034 socket
>> ++9223372045445496836 file
>> ++9223372045445496837 symlink
>> ++9223372045445496838 link
>> ++9223372045445496839 chrdev
>> ++9223372045445496840 blkdev
>> ++9223372045445496841 fifo
>> ++9223372045445496842 socket
>> +file not found by ino 8590721028 (from /tmp/25096.lower.lo) - see
>> /var/lib/xfstests/results//overlay/071.full
>> +symlink not found by ino 8590721029 (from /tmp/25096.lower.lo) - see
>> /var/lib/xfstests/results//overlay/071.full
>> +link not found by ino 8590721030 (from /tmp/25096.lower.lo) - see
>> /var/lib/xfstests/results//overlay/071.full
>> +chrdev not found by ino 8590721031 (from /tmp/25096.lower.lo) - see
>> /var/lib/xfstests/results//overlay/071.full
>> +blkdev not found by ino 8590721032 (from /tmp/25096.lower.lo) - see
>> /var/lib/xfstests/results//overlay/071.full
>> +fifo not found by ino 8590721033 (from /tmp/25096.lower.lo) - see
>> /var/lib/xfstests/results//overlay/071.full
>> +socket not found by ino 8590721034 (from /tmp/25096.lower.lo) - see
>> /var/lib/xfstests/results//overlay/071.full
>> Silence is golde
>> ------------------------------------------------
>> Is this expected behavior? :-)
> Yes and No :-)
>
> The result is expected. It is not expected for the test to fail.
> This is a test bug.
>
> The bug is in this line and in the comment above it:
> # Compare inode numbers in lower overlay vs. nested overlay
> # With nested xino lower/lower, all inode numbers overflow xino bits and
> # d_ino/i_ino in nested overlay are the same as in lower overlay.
> check_inode_numbers $lowertestdir $tmp.lower.lo $tmp.before.lo
>
> This test is meant to cover the case of "xino=on/auto, ino overflow" from:
> https://github.com/torvalds/linux/blob/master/Documentation/filesystems/overlayfs.rst#inode-properties
>
> The correct part of the comment is:
> # With nested xino lower, all inode numbers overflow xino bits
> Meaning that all inode numbers at $lowertestdir have the MSB set
> (e.g. file ino 9223372045445496836  = 0x80000002000C0004)
>
> With lower fs xfs, the other part of the comment is also correct:
> # ...and d_ino/i_ino in nested overlay are the same as in lower overlay
>
> Because in the lower overlay ($SCRATCH_MNT/lowertestdir)
> lower files also have the MSB set.
>
> However, because ext4 has a known inode number limit of 32bit
> (see ovl_can_decode_fh) the lower overlay inodes do not have the
> MSB set (e.g. file ino 8590721028 = 0x2000C0004).
>
> Long story short, I think we need to remove this line and comment
> from the test and leave it the same as overlay/070:
>
> # Record inode numbers before copy up
> record_inode_numbers $lowertestdir $tmp.before.lo
> record_inode_numbers $uppertestdir $tmp.before.up
>
> This recording is just for the sake of logging info in 070.full.
Hi Amir,

Thanks a lot for your detailed explanation. :-)
I will spend time to read the related code in kernel.

>> Best Regards,
>> Xiao Yang
>> On 2020/9/30 13:04, Xiao Yang wrote:
>>> Replace undefined OVL_BASE_SCRATCH_DIR with OVL_BASE_SCRATCH_MNT
>>>
>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Reviewed-by: Amir Goldstein<amir73il@gmail.com>
>
> Will you also fix the test bug please.

Sure, I will fix the test bug on a separate patch tomorrow.

Best Regards,
Xiao Yang
> Thanks!
> Amir.
>
>
> .
>



