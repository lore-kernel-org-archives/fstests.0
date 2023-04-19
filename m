Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9681C77B73
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Apr 2023 09:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjDSJEe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Apr 2023 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjDSJE3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Apr 2023 05:04:29 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8F3C18
        for <fstests@vger.kernel.org>; Wed, 19 Apr 2023 02:04:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VgUOHqm_1681895062;
Received: from 30.97.48.183(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgUOHqm_1681895062)
          by smtp.aliyun-inc.com;
          Wed, 19 Apr 2023 17:04:23 +0800
Message-ID: <19262c0b-43ec-748c-8ac4-7e2ede2ce692@linux.alibaba.com>
Date:   Wed, 19 Apr 2023 17:04:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] src: fix detached_mounts_propagation compile errors
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
 <20230419-fahnden-sonderlich-b2968abdec77@brauner>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230419-fahnden-sonderlich-b2968abdec77@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2023/4/19 16:45, Christian Brauner wrote:
> On Wed, Apr 19, 2023 at 11:29:55AM +0800, Gao Xiang wrote:
>> Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
>> in addition to <linux/mount.h>.  It will report as below when
>> compiling with old linux kernel headers (without idmapped mounts,
>> such as kernel-headers 5.10.134) but with newer glibc (here checked
>> with glibc 2.36.6):
>>
>>      [CC]    detached_mounts_propagation
>> In file included from detached_mounts_propagation.c:29:
>> vfs/missing.h:115:8: error: redefinition of 'struct mount_attr'
>>    115 | struct mount_attr {
>>        |        ^~~~~~~~~~
>> In file included from detached_mounts_propagation.c:23:
>> /usr/include/sys/mount.h:210:8: note: originally defined here
>>    210 | struct mount_attr
>>        |        ^~~~~~~~~~
>> gmake[3]: *** [Makefile:102: detached_mounts_propagation] Error 1
>> gmake[2]: *** [include/buildrules:31: src] Error 2
>> make[1]: *** [Makefile:51: default] Error 2
>> make: *** [Makefile:49: default] Error 2
>>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
> 
> This header mount.h mess is a neverending nightmare...
> 
>>
>> Not quite look into that, but at a quick glance of tester reports
>> it seems the cases.
>>
>>   configure.ac                      | 5 ++++-
>>   src/detached_mounts_propagation.c | 1 -
>>   src/vfs/missing.h                 | 1 +
>>   3 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 4687d8a3..517b4c18 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -74,7 +74,10 @@ AC_HAVE_FIEXCHANGE
>>   
>>   AC_CHECK_FUNCS([renameat2])
>>   AC_CHECK_FUNCS([reallocarray])
>> -AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
>> +AC_CHECK_TYPES([struct mount_attr], [], [], [[
>> +#include <linux/mount.h>
>> +#include <sys/mount.h>
> 
> I think we should only rely on sys/mount.h. linux/mount.h and
> sys/mount.h are incompatible because linux/mount.h might have a #define
> where sys/mount.h has an enum.

Ok, got it.  Let me play with it later.

Thanks,
Gao Xiang


