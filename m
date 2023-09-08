Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615B7EC8747
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Sep 2023 02:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbjIHCNM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Sep 2023 22:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjIHCNM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2023 22:13:12 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E851BCD
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 19:13:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="131247908"
X-IronPort-AV: E=Sophos;i="6.02,236,1688396400"; 
   d="scan'208";a="131247908"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 11:13:05 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 49F59C68E5
        for <fstests@vger.kernel.org>; Fri,  8 Sep 2023 11:13:03 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 80DA7CF7EE
        for <fstests@vger.kernel.org>; Fri,  8 Sep 2023 11:13:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0A2CF401C3
        for <fstests@vger.kernel.org>; Fri,  8 Sep 2023 11:13:02 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.234.230])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id B13F41A02BA;
        Fri,  8 Sep 2023 10:13:01 +0800 (CST)
Message-ID: <7365bd90-6aaf-46d7-b09e-61ea1ad9ddb5@fujitsu.com>
Date:   Fri, 8 Sep 2023 10:13:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/mvtest: ensure testcase is executable (755)
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
 <20230907135434.kj44w7mg6qvpzs4m@zlang-mailbox>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230907135434.kj44w7mg6qvpzs4m@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27862.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27862.003
X-TMASE-Result: 10--15.024300-10.000000
X-TMASE-MatchedRID: 5U6uFEJz7+qPvrMjLFD6eHchRkqzj/bEC/ExpXrHizxBqLOmHiM3w5pj
        +XNqU6N7WX/b7eE68AgHlZ1juWgbYAMWCgdCzp+aag//jiWuh4NXbLRXY7rdnuZgZoDMqQBT+03
        a+MQ8RE0najXSbZssEnxvRiDyaBiBL/tBTZzO5Q0D2WXLXdz+ATFVRYZezcLzVxk27EKh25Ib8J
        PsJKmcvapudRsisNuFMgUz5yJGb06/zYKzQGIkR4h/ebSxR/Hnss3J45iL6l9xGu6rjxUqUDy7z
        xidHhYp75nWEVUWdwNZeYB1yXFZCmIebjj13eKWdo0n+JPFcJp9LQinZ4QefNQdB5NUNSsiDrBA
        jvbPhh50HSe131POnjsAVzN+Ov/sonrL/LM/rpw3Gr/VCsR+CekQ6Wwmk6ExxMI4dHNxiLSbvz9
        pzOACPw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2023/9/7 21:54, Zorro Lang 写道:
> On Wed, Sep 06, 2023 at 03:13:49PM +0800, Shiyang Ruan wrote:
>> Some test cases lack executable permission ('x'). Before running each
>> test case, `./check` checks and grants them 'x' permission. However,
>> this always leads to a dirty git repo. And the absence of 'x' permission
>> in test cases is often overlooked during reviews.
>>
>> Since maintainers use mvtest to assign new case, add this change for
>> convenience of maintainers.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   tools/mvtest | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/mvtest b/tools/mvtest
>> index 99b154142..e839f0256 100755
>> --- a/tools/mvtest
>> +++ b/tools/mvtest
>> @@ -28,6 +28,8 @@ append() {
>>   test "${src}" != "${dest}" || die "Test \"${src}\" is the same as dest."
>>   test -e "tests/${src}" || die "Test \"${src}\" does not exist."
>>   test ! -e "tests/${dest}" || die "Test \"${src}\" already exists."
>> +# make sure testcase is executable
>> +test `stat -c '%a' tests/${src}` == 755 || chmod 755 "tests/${src}"
> 
> (Weird, I thought I've replied this patch, but I can't find my reply anywhere.)
> 
> I said we can check and set the permission on the ${dest} file, after the
> move operation is done. Due to we actually want to get a 755 ${dest} file
> by running the mvtest.

It seems that maillist server was down at that time.  But I received 
your reply:

 > I think we can check and set the file permission on the target file
 > after the move operation done, not the source file.
 >
 > And we recommend using $() to replace ``, if both of them work.

Then I have sent v2[1] which is using $() instead of `` and doing the 
check-then-set tests/${dest} after `git mv`, as you suggested.

[1] 
https://lore.kernel.org/fstests/20230907113501.4119112-1-ruansy.fnst@fujitsu.com/


--
Thanks,
Ruan.

> 
> Thanks,
> Zorro
> 
>>   
>>   sid="$(basename "${src}")"
>>   did="$(basename "${dest}")"
>> -- 
>> 2.42.0
>>
> 
