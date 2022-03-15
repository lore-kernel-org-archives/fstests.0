Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFCCC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Mar 2022 09:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbiCOJgB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Mar 2022 05:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346222AbiCOJgA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Mar 2022 05:36:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FA539B8A
        for <fstests@vger.kernel.org>; Tue, 15 Mar 2022 02:34:48 -0700 (PDT)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KHp995FHPzBrn5;
        Tue, 15 Mar 2022 17:32:45 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500022.china.huawei.com (7.221.188.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 15 Mar 2022 17:34:45 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 17:34:45 +0800
Subject: Re: [f2fs-dev] [PATCH v2] generic/066: attr1 is still there after log
 replay on f2fs
To:     Chao Yu <chao.yu@oppo.com>, <fstests@vger.kernel.org>,
        <guan@eryu.me>
CC:     <jaegeuk@kernel.org>, <david@fromorbit.com>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20220311094315.2476774-1-sunke32@huawei.com>
 <de79517f-4fa6-c409-42d4-6187eb968e0e@oppo.com>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <690fc25e-263e-5c7a-2bd0-55fa06c85e23@huawei.com>
Date:   Tue, 15 Mar 2022 17:34:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <de79517f-4fa6-c409-42d4-6187eb968e0e@oppo.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2022/3/15 12:01, Chao Yu 写道:
> On 2022/3/11 17:43, Sun Ke via Linux-f2fs-devel wrote:
>> The test fail on f2fs:
>>       xattr names and values after second fsync log replay:
>>       # file: SCRATCH_MNT/foobar
>>      +user.attr1="val1"
>>       user.attr3="val3"
>>
>> attr1 is still there after log replay. f2fs doesn't support fs-op level
>> transaction functionality. so it have no way to persist all metadata
>> updates in one transaction.  We can use "fastboot" mountoption for this
>> case, so during last fsync on qwerty, f2fs can trigger a checkpoint
>> which will persist all metadata updates before fsync().
>>
>> Suggested-by: Chao Yu <chao@kernel.org>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   tests/generic/066 | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tests/generic/066 b/tests/generic/066
>> index 105a7acd..b8465101 100755
>> --- a/tests/generic/066
>> +++ b/tests/generic/066
>> @@ -56,6 +56,14 @@ sync
>>   $SETFATTR_PROG -x user.attr2 $SCRATCH_MNT/foobar
>>   $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
>> +# f2fs doesn't support fs-op level transaction functionality. so it 
>> have no way
>> +# to persist all metadata updates in one transaction.  We can use 
>> "fastboot"
>> +# mountoption for this case, so during last fsync on qwerty, f2fs can 
>> trigger a
>> +# checkpoint which will persist all metadata updates before fsync().
>> +if [ $FSTYP = "f2fs" ]; then
>> +    export MOUNT_OPTIONS="-o fastboot"
> 
> Can we merge "fastboot" with original mount options? and after the test, 
> how about
> recovering to original mount options?
> 
> Thanks,

Like this:

  if [ $FSTYP = "f2fs" ]; then
-       export MOUNT_OPTIONS="-o fastboot"
+       export MOUNT_OPTIONS="-o fastboot $MOUNT_OPTIONS"
  fi

right?

And I have tested that there is no need to recover to original mount 
options after the test. It will be the original one in the next test.

Thanks,
Sun Ke

> 
>> +fi
>> +
>>   _flakey_drop_and_remount
>>   # After the fsync log is replayed, the file should have only 2 
>> xattrs, the ones
> .
