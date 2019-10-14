Return-Path: <SRS0=eAkR=YH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70343C4360C
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Oct 2019 02:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493722082F
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Oct 2019 02:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfJNC0P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Oct 2019 22:26:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729474AbfJNC0P (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 13 Oct 2019 22:26:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 86E6ADD8FC537E62B03A;
        Mon, 14 Oct 2019 10:26:13 +0800 (CST)
Received: from [127.0.0.1] (10.177.224.82) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 10:26:05 +0800
Subject: Re: [PATCH xfstests] generic/192: Move 'cd /' to the place where the
 program exits
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <darrick.wong@oracle.com>, <ebiggers@google.com>,
        <yi.zhang@huawei.com>, <fstests@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1570609677-49586-1-git-send-email-chengzhihao1@huawei.com>
 <20191013124607.GH2622@desktop>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <25cb3854-4d90-872a-5932-4852f1b436b3@huawei.com>
Date:   Mon, 14 Oct 2019 10:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191013124607.GH2622@desktop>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.224.82]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I agree with your proposal. Indeed, '$here' is referenced in other places where executable files under src are used, including '$here/src/feature', '$here/src/seek_sanity_test', etc.
I have a question about why many test cases execute 'cd /' before the end. For example, generic/124, generic/122, generic/003. I wonder the intention of operation 'cd /'.

ÔÚ 2019/10/13 20:46, Eryu Guan Ð´µÀ:
> On Wed, Oct 09, 2019 at 04:27:57PM +0800, Zhihao Cheng wrote:
>> Running generic/192 with overlayfs(Let ubifs as base fs) yields the
>> following output:
>>
>>   generic/192 - output mismatch
>>      QA output created by 192
>>      sleep for 5 seconds
>>      test
>>     +./common/rc: line 316: src/t_dir_type: No such file or directory
>>      delta1 is in range
>>      delta2 is in range
>>     ...
>>
>> When the use case fails, the call stack in generic/192 is:
>>
>>   local unknowns=$(src/t_dir_type $dir u | wc -l)	common/rc:316
>>   _supports_filetype					common/rc:299
>>   _overlay_mount					common/overlay:52
>>   _overlay_test_mount					common/overlay:93
>>   _test_mount						common/rc:407
>>   _test_cycle_mount					generic/192:50
>>
>> Before _test_cycle_mount() being invoked, generic/192 executed 'cd /'
>> to change work dir from 'xfstests-dev' to '/', so src/t_dir_type was not
>> found.
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Thanks for the debug! But I think the right fix is to call t_dir_type
> via "$here", i.e.
> 
> 	local unknowns=$($here/src/t_dir_type $dir u | wc -l)
> 
> 'here', which points to the top level dir of xfstests source code, is
> defined in every test in test setup, and is guaranteed not to be empty.
> 
> Thanks,
> Eryu
> 
>> ---
>>  tests/generic/192 | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/generic/192 b/tests/generic/192
>> index 50b3d6fd..5550f39e 100755
>> --- a/tests/generic/192
>> +++ b/tests/generic/192
>> @@ -15,7 +15,12 @@ echo "QA output created by $seq"
>>  here=`pwd`
>>  tmp=/tmp/$$
>>  status=1	# failure is the default!
>> -trap "exit \$status" 0 1 2 3 15
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +}
>>  
>>  _access_time()
>>  {
>> @@ -46,7 +51,6 @@ sleep $delay # sleep to allow time to move on for access
>>  cat $testfile
>>  time2=`_access_time $testfile | tee -a $seqres.full`
>>  
>> -cd /
>>  _test_cycle_mount
>>  time3=`_access_time $testfile | tee -a $seqres.full`
>>  
>> -- 
>> 2.13.6
>>
> 
> .
> 

