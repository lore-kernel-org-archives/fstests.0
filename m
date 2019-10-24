Return-Path: <SRS0=fGqU=YR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EEBCA9EB9
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 01:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714252086D
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 01:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407813AbfJXBs5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:48:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbfJXBs4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 23 Oct 2019 21:48:56 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CDC7A57799DCDC7611A7;
        Thu, 24 Oct 2019 09:48:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.224.82) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 24 Oct 2019
 09:48:47 +0800
Subject: Re: [PATCH xfstests v3] fstests: Add path $here before src/<file>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <darrick.wong@oracle.com>, <ebiggers@google.com>,
        <yi.zhang@huawei.com>, <fstests@vger.kernel.org>
References: <1571664946-105756-1-git-send-email-chengzhihao1@huawei.com>
 <20191023152024.GC2543@desktop>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <fe2e358e-3ea7-e1e3-f3e4-49a090e19ccc@huawei.com>
Date:   Thu, 24 Oct 2019 09:48:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023152024.GC2543@desktop>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.224.82]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

You're right.
I did a test. If xfstests-dev is installed in the root directory, there will be a problem in executing 'su regular_user -c CMD' (If the CMD contains an absolute path, /root does not provide read permission to other users).

I checked the place where 'su' and 'user_do' were called. After joining my patch, the following usecases did use absolute path in 'su regular_user -c CMD'.

generic/093 generic/125 generic/462

Thanks for your review.

ÔÚ 2019/10/23 23:20, Eryu Guan Ð´µÀ:
> On Mon, Oct 21, 2019 at 09:35:46PM +0800, Zhihao Cheng wrote:
>> Calling src/<file> without path '$here' may cause the problem that the
>> file cannot be found.
>> For example, Running generic/192 with overlayfs(Let ubifs as base fs)
>> yields the following output:
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
>>   local unknowns=$(src/t_dir_type $dir u | wc -l)	common/rc
>>   _supports_filetype					common/rc
>>   _overlay_mount					common/overlay
>>   _overlay_test_mount					common/overlay
>>   _test_mount						common/rc
>>   _test_cycle_mount					generic/192
>>
>> Before _test_cycle_mount() being invoked, generic/192 executed 'cd /'
>> to change work dir from 'xfstests-dev' to '/', so src/t_dir_type was not
>> found.
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Thanks a lot for the work!
>
> I found that some tests started to fail after applying this patch, they
> are
>
> generic/093 generic/125 generic/462
>
> as these tests run the test binary as a regular user (either via su or
> _user_do helper), and "$here" may contain path component that a regular
> user can't access, e.g. /root. So I skip adding $here prefix in above
> tests and add comments accordingly.
>
> Thanks,
> Eryu
>
> .

