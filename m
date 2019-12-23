Return-Path: <SRS0=A77W=2N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC9C2D0D2
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 05:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B6220709
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 05:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfLWFBZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Dec 2019 00:01:25 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31868 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbfLWFBZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Dec 2019 00:01:25 -0500
X-IronPort-AV: E=Sophos;i="5.69,346,1571673600"; 
   d="scan'208";a="80618054"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Dec 2019 13:01:20 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 34A254B3ED8D;
        Mon, 23 Dec 2019 12:52:33 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 23 Dec 2019 13:01:21 +0800
Subject: Re: [PATCH] generic/520: use fsync instead of sync during clean_dir
To:     <fdmanana@gmail.com>
CC:     fstests <fstests@vger.kernel.org>
References: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAL3q7H6ZNui6MbvBwXq1bAk5tLgxUjAv+QgRUju0veqwxMmPOA@mail.gmail.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <81436636-20e5-7286-532b-7a3faf61a193@cn.fujitsu.com>
Date:   Mon, 23 Dec 2019 13:01:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6ZNui6MbvBwXq1bAk5tLgxUjAv+QgRUju0veqwxMmPOA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 34A254B3ED8D.ADDBD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2019/12/20 20:32, Filipe Manana wrote:
> On Fri, Dec 13, 2019 at 5:45 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>>
>> When I test this case on xfs, it may fail as below:
>> --------------------------------------------
>>   === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
>> +umount: /mnt/xfstests/scratch: target is busy.
>> +        (In some cases useful info about processes that use
>> +         the device is found by lsof(8) or fuser(1))
>> ---------------------------------------------
>>
>> I think we don't need to sync all fs and fsync SCRATCH_MNT is enough.
> 
> It's indeed strange, and suggests something is still using the
> filesystem when trying to unmount it.
> 
> I've never hit that problem (I usually only test btrfs), and a loop of
> 100 iterations running this test has never reproduced that issue (or
> any other) for me.
> 
> Instead of fsync, I think you can simply do nothing (just remove the
> call to 'sync'), as the unmount is supposed to persist the
> file/directory removals.
> Does the problem reproduces this way?Yes. I remove sync and test it with a loop of 100 iterations on 
xfs/ext4. It doesn't reproduce busy error. Thanks for your advise.
I will remove sync in v2 patch.

Kind Regards
Yang Xu
> 
> thanks
> 
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   tests/generic/520 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/520 b/tests/generic/520
>> index 167d7077..a16467ca 100755
>> --- a/tests/generic/520
>> +++ b/tests/generic/520
>> @@ -58,7 +58,7 @@ clean_dir()
>>   {
>>          _mount_flakey
>>          rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
>> -       sync
>> +       $XFS_IO_PROG -c "fsync" $SCRATCH_MNT
>>          _unmount_flakey
>>   }
>>
>> --
>> 2.18.0
>>
>>
>>
> 
> 


