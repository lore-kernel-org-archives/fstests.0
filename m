Return-Path: <SRS0=31Kr=XW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AF4C4360C
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 01:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D739D207FF
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 01:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfI0Bks (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 Sep 2019 21:40:48 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1966 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725808AbfI0Bks (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 21:40:48 -0400
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; 
   d="scan'208";a="76088198"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Sep 2019 09:40:46 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id BEBC54CE14EA;
        Fri, 27 Sep 2019 09:40:49 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 27 Sep 2019 09:40:50 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] generic/442: add sync before dmsetup remove
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
References: <1569400158-5297-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190925130824.GU2622@desktop>
 <7f33fe1f-fe48-6a21-a92a-ca922265cdea@cn.fujitsu.com>
 <20190926055119.GV2622@desktop>
Message-ID: <19be84d6-25a4-bfa9-ed60-1b9105bca1ec@cn.fujitsu.com>
Date:   Fri, 27 Sep 2019 09:40:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190926055119.GV2622@desktop>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: BEBC54CE14EA.AFD3E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org
Message-ID: <20190927014043.-JPI8T7XglCrA1jK0ItYZrqRDYwP6yqC2YyCgz-89EI@z>


在 2019/9/26 13:51, Eryu Guan 写道:
> On Thu, Sep 26, 2019 at 11:05:13AM +0800, Su Yanjun wrote:
>> 在 2019/9/25 21:08, Eryu Guan 写道:
>>> On Wed, Sep 25, 2019 at 04:29:18PM +0800, Su Yanjun wrote:
>>>> This test case sometime fails. Because "dmsetup remove error-test" may
>>>> fail when some writeback is going on.
>>>>
>>>> This patch adds sync before dmsetup remove operation.
>>>>
>>>> Signed-off-by: Su Yanjun<suyj.fnst@cn.fujitsu.com>
>>>> ---
>>>>    tests/generic/442 | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tests/generic/442 b/tests/generic/442
>>>> index fe6d460..d48ca36 100755
>>>> --- a/tests/generic/442
>>>> +++ b/tests/generic/442
>>>> @@ -43,6 +43,7 @@ $here/src/fsync-err -d $here/src/dmerror $DMERROR_DEV
>>> fsync-err should have flipped $DMERROR_DEV to working mode and fsync
>>> each open fd before exit if fsync-err didn't report any failure. So
>>> there should be no on-going writeback.
>>>>    # success, all done
>>>>    _dmerror_load_working_table
>>>> +sync
>>>>    _dmerror_cleanup
>>> And _dmerror_cleanup umount $DMERROR_DEV first, then tear down the dm
>>> device. Could you check if fsync-err returns successfully and umount
>>> succeeds as well?
>> I cant find any mount info for $DMERROR_DEV in this test. fsync-err  just
>> does write or sync test with the raw logical dm device.
>>
>> Am i missing something?
> Ah, sorry, I missed that the test uses raw block device..
>
>> mkfs.xfs: cannot open /dev/sda11: Device or resource busy
>> device-mapper: remove ioctl on error-test  failed: Device or resource busy
>> Command failed.
>> _check_xfs_filesystem: filesystem on /dev/sda11 has dirty log
>> *** xfs_logprint -t output ***
>> xfs_logprint: logprint.c:230: main: Assertion `x.logBBsize <= 0x7fffffff'
>> failed.
>> *** end xfs_logprint output
>>
>>  From above log, dmsetup remove failed with "Device or resource busy".
> I can't reproduce above failure with v5.3 kernel, neither xfs nor ext4.
> Does ext4 pass in your setup? I suspect it's a kernel bug that still
> holds the block device.

Yes, ext4 can pass. Only in RHEL release it tests failed.

Maybe "sync" is only a workaround for the the case, the root cause is 
unknown.

It may need more time to analysis.

Thanks

> Thanks,
> Eryu
>
>


