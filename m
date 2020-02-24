Return-Path: <SRS0=n5xI=4M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289BC35673
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 02:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC0B2067D
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 02:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBXCOi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:14:38 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34893 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727151AbgBXCOi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Feb 2020 21:14:38 -0500
X-IronPort-AV: E=Sophos;i="5.70,478,1574092800"; 
   d="scan'208";a="83808934"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Feb 2020 10:14:33 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 4D33D49DF126;
        Mon, 24 Feb 2020 10:04:51 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 24 Feb 2020 10:14:36 +0800
Subject: Re: [PATCH v2] common/log: add -l su option in _xfs_log_config
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     Eryu Guan <guaneryu@gmail.com>, <fstests@vger.kernel.org>
References: <20200220021709.GF9504@magnolia>
 <1582177081-6235-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200223142208.GD3840@desktop> <20200223163710.GL9504@magnolia>
 <a801d86e-80ab-b2fb-ba72-721365a8133e@cn.fujitsu.com>
Message-ID: <484e9bf8-f659-c752-f232-11ee76a353a1@cn.fujitsu.com>
Date:   Mon, 24 Feb 2020 10:14:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <a801d86e-80ab-b2fb-ba72-721365a8133e@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 4D33D49DF126.ADD66
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2020/02/24 9:51, Yang Xu wrote:
> 
> 
> on 2020/02/24 0:37, Darrick J. Wong wrote:
>> On Sun, Feb 23, 2020 at 10:22:10PM +0800, Eryu Guan wrote:
>>> Hi Darrick,
>>>
>>> On Thu, Feb 20, 2020 at 01:38:01PM +0800, Yang Xu wrote:
>>>> Currently, if we don't specify -l sunit or -l su option, mkfs.xfs
>>>> will get the stripe size from underlying device.
>>>>
>>>> It works file on most situations. But on some machine, the size of
>>>> underlying device greater than logbsize of mount options, it will
>>>> report error like "logbuf size must be greater than or equal to log
>>>> stripe size". We can specify -l su=4096 to meet this requirement and
>>>> case can still run normally.
>>>>
>>>> Also, from xfs manpage, version 2 also supports 16k log buf size for
>>>> mount option and case passed(only generic/054,055 used this api) on
>>>> my machine. So delete 32k and 64k with different sunit to be 
>>>> consistented
>>
>> I don't understand why there's a need to be consistent, which means I
>> don't understand why we'd "delete 32k and 64k with different sunit".
>> ext4 tests should not be invoking _xfs_log_config()
> 
> Sorry for the confused message.
> _get_log_configs{
> xfs)
>          _xfs_log_config
>          ;;
>      f2fs)
>          _f2fs_log_config
>          ;;
>      ext4)
>          _ext4_log_config
> 
> }
> xfs ,f2fs, and ext4 all have test1~test10.
> So for a generic case, it should be consistent.
> And only generic/054 055 uses _get_log_configs api and no test case
> used _xfs_log_config api. I think we should keep this(test1~test10, 
> 054.out only 10 times mkfs and mount output)
>>
>>>> with ext4 test num(10) and we can test all logbuf size.
>>
>> Hm?  ext4/010 is an inode bitmap fuzz test.
>>
> No. I mean _ext4_log_config has test1~test10.
> 
> Best Regards
> Yang Xu
>>>>
>>>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>>
>>> Would you like to review this v2 patch again? I feel more confident if
>>> xfs maintainer could ack it :)
>>>
>>> Thanks,
>>> Eryu
>>>
>>>> ---
>>>>   common/log | 12 ++++++------
>>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/common/log b/common/log
>>>> index c7921f50..9b5a2f6d 100644
>>>> --- a/common/log
>>>> +++ b/common/log
>>>> @@ -546,15 +546,15 @@ _xfs_log_config()
>>>>   {
>>>>       echo "# mkfs-opt             mount-opt"
>>>>       echo "# ------------------------------"
>>>> -    echo "  version=2            logbsize=32k"
>>>> +    echo "  version=2,su=4096    logbsize=16k"
>>
>> The straight substitutions look fine to me, but then...
>>
>>>> +    echo "  version=2,su=16k     logbsize=16k"
>>
>> ...I can't tell why we're adding this extra case here, or why this
>> has to be here and not in a separate patch justifying the addition?
For 16k logbsize, I don't know much about it. it may make no sense? So
at the beginning, xfstests doesn't plan to test it. If so, I will remove 
this adding.

>>
>>>>       echo "  version=2,su=4096    logbsize=32k"
>>>> -    echo "  version=2,su=32768   logbsize=32k"
>>>> -    echo "  version=2,su=32768   logbsize=64k"
>>
>> ...I also don't think it's a good idea to reduce test coverage, and
>> definitely not buried in something that sounds like a fix patch.

OK. how about this change , as below(only specifying su=4096 for old 
options without su, logbusize=32K has su=4096, so add su=16k for it):
diff --git a/common/log b/common/log
index c7921f50..991c8e8f 100644
--- a/common/log
+++ b/common/log
@@ -546,15 +546,15 @@ _xfs_log_config()
  {
      echo "# mkfs-opt             mount-opt"
      echo "# ------------------------------"
-    echo "  version=2            logbsize=32k"
      echo "  version=2,su=4096    logbsize=32k"
+    echo "  version=2,su=16384   logbsize=32k"
      echo "  version=2,su=32768   logbsize=32k"
-    echo "  version=2,su=32768   logbsize=64k"
-    echo "  version=2            logbsize=64k"
+    echo "  version=2,su=4096    logbsize=64k"
+    echo "  version=2,su=32768   logbsize=64k"
      echo "  version=2,su=64k     logbsize=64k"
-    echo "  version=2            logbsize=128k"
+    echo "  version=2,su=4096    logbsize=128k"
      echo "  version=2,su=128k    logbsize=128k"
-    echo "  version=2            logbsize=256k"
+    echo "  version=2,su=4096    logbsize=256k"
      echo "  version=2,su=256k    logbsize=256k"

Best Regards
Yang Xu
>>
>> --D
>>
>>>> -    echo "  version=2            logbsize=64k"
>>>> +    echo "  version=2,su=32k     logbsize=32k"
>>>> +    echo "  version=2,su=4096    logbsize=64k"
>>>>       echo "  version=2,su=64k     logbsize=64k"
>>>> -    echo "  version=2            logbsize=128k"
>>>> +    echo "  version=2,su=4096    logbsize=128k"
>>>>       echo "  version=2,su=128k    logbsize=128k"
>>>> -    echo "  version=2            logbsize=256k"
>>>> +    echo "  version=2,su=4096    logbsize=256k"
>>>>       echo "  version=2,su=256k    logbsize=256k"
>>>>   }
>>>> -- 
>>>> 2.18.0
>>>>
>>>>
>>>>
>>
>>
> 
> 


