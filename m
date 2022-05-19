Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FBAC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 19 May 2022 01:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiESBxi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 May 2022 21:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiESBxe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 May 2022 21:53:34 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 081BDC1ED7
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 18:53:32 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AFZjAIK3avxErg3sVY/bD5f1zkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJhj8nhDUGmGVJUG+GM6yDYTekfdAjb9m//EJTusDQydE2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfvQH+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfouOceiPh65T7I0ruNiGEL+9VJFMyNIsX0vx6DWF?=
 =?us-ascii?q?H6boTLzVlRh6Ym++t3KmTVOZhnIIgIdPtMYdZvWtvpQw1p95OrYvrGv2MvIEHm?=
 =?us-ascii?q?mxrwJ0mIBoXXOJBARIHUfgKS0Qn1o8rNa8D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZ9git6/nr7U5vPREQP9uk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124333620"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 May 2022 09:53:26 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 9A4E14D17192;
        Thu, 19 May 2022 09:53:23 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 19 May 2022 09:53:24 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 19 May 2022 09:53:23 +0800
Message-ID: <7ee2d82f-655c-c3ee-6bf9-9353abb8f64a@fujitsu.com>
Date:   Thu, 19 May 2022 09:53:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] xfs: add memory failure test for dax mode
To:     <zlang@redhat.com>
References: <20220513031411.2369314-1-ruansy.fnst@fujitsu.com>
 <20220513031411.2369314-2-ruansy.fnst@fujitsu.com>
 <20220518183846.k6est3gobhh5jxrm@zlang-mailbox>
CC:     <fstests@vger.kernel.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220518183846.k6est3gobhh5jxrm@zlang-mailbox>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 9A4E14D17192.AD4D8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2022/5/19 2:38, Zorro Lang 写道:
> On Fri, May 13, 2022 at 11:14:09AM +0800, Shiyang Ruan wrote:
>> Make sure memory failure mechanism works when filesystem is mounted with
>> dax option.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   .gitignore                      |   1 +
>>   src/Makefile                    |   3 +-
>>   src/t_mmap_cow_memory_failure.c | 157 ++++++++++++++++++++++++++++++++
>>   tests/xfs/900                   |  48 ++++++++++
>>   tests/xfs/900.out               |   9 ++
>>   5 files changed, 217 insertions(+), 1 deletion(-)
>>   create mode 100644 src/t_mmap_cow_memory_failure.c
>>   create mode 100755 tests/xfs/900
>>   create mode 100644 tests/xfs/900.out
>>
...
>> diff --git a/tests/xfs/900.out b/tests/xfs/900.out
>> new file mode 100644
>> index 00000000..d861bf1f
>> --- /dev/null
>> +++ b/tests/xfs/900.out
>> @@ -0,0 +1,9 @@
>> +QA output created by 900
>> +Format and mount
>> +Create the original files
>> +Inject memory failure (1 page)
>> +Inject posion...
> 
> As your program is: printf("Inject poison...\n");
> 
> So I think this place should be "poison".

My bad. I forgot to fix this typo in .out file.

> 
>> +Process is killed by signal: 7
>> +Inject memory failure (2 pages)
>> +Inject posion...
> 
> same as above. And other 2 patches might have same issue.

Thanks!  Will fix them.


--
Ruan.

> 
> Thanks,
> Zorro
> 
>> +Process is killed by signal: 7
>> -- 
>> 2.35.1
>>
>>
>>
> 


