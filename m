Return-Path: <SRS0=wEx+=77=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE7FC433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Jun 2020 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B8D2075E
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Jun 2020 15:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eqSTIsEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgFRPEh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:04:37 -0400
Received: from m12-17.163.com ([220.181.12.17]:41773 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730949AbgFRPEg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jun 2020 11:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=f7bIi
        YLGnhGD59z0jJnQEtBWc/ekl16e5LhDdROSH8c=; b=eqSTIsEWKlirlpEoaWpAk
        HLccbssp4wcw3EZGSy+yZ03qUP/QzDb0UtY1AHYRDATseECU8VmZJxY6/UwUi7Kx
        61ib2Iy0HEMQKb6RY0n3o7cIdalAzOUnmJ61xrIZlQdgnA0Z3RND+T/0zYTXAInb
        7UiqyPLkbRxeRRkLoMMPjc=
Received: from [192.168.0.10] (unknown [183.210.49.20])
        by smtp13 (Coremail) with SMTP id EcCowAAXzR5qgutepTCwIA--.61728S2;
        Thu, 18 Jun 2020 23:04:11 +0800 (CST)
Subject: Re: [PATCH v2 0/6] Make fstests support new behavior of DAX
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
 <20200618002128.GP4160762@iweiny-DESK2.sc.intel.com>
From:   Xiao Yang <ice_yangxiao@163.com>
Message-ID: <b0d5803e-81e4-bb14-f47b-44036284577e@163.com>
Date:   Thu, 18 Jun 2020 23:04:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200618002128.GP4160762@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: EcCowAAXzR5qgutepTCwIA--.61728S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1xXF13Jw1xKFWkKrWktFb_yoW8CrWxpa
        yF9ry5Kr1fJw1xZr43Xwn2qas0qan7GrWkCry7X34IqF18X3Wakrn2gr18JFyfWr4rWr4Y
        v3WkGFyrur4DArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdwIDUUUUU=
X-Originating-IP: [183.210.49.20]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqAxHXlc7QCqj-wAAsn
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 6/18/20 8:21 AM, Ira Weiny wrote:
> On Wed, Jun 17, 2020 at 05:31:58PM +0800, Xiao Yang wrote:
>> From: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Also this email for Ross is no longer valid.  I don't believe he is with Intel
> any longer.
>
> 	ross.zwisler@linux.intel.com

Hi Ira,

Thanks for your reminder.

IIRC, some code which is related to PMD fault testing comes from Ross, 
and the last two patches

update these code so that generic/413 and generic/602 can run PMD fault 
testing on different arches.

I wanted Ross to do some review before. :-)

Best Regards,

Xiao Yang

>
> Ira
>
>> The new behavior of DAX on xfs/ext4 has been merged into main kernel
>> tree/ext4-dax branch so it is time for fstests to support new behavior
>> of DAX.
>>
>> References:
>> https://lkml.org/lkml/2019/10/20/96
>> https://lkml.org/lkml/2020/5/28/949
>>
>> Xiao Yang (6):
>>    common/rc: Introduce new helpers for DAX mount options and
>>      FS_XFLAG_DAX
>>    fstests: Use _require_scratch_dax_mountopt() and
>>      _require_scratch_dax_iflag()
>>    common/rc: Remove unused _require_scratch_dax()
>>    generic/223: Don't clear all mkfs options for _scratch_mkfs_geom()
>>      roughly
>>    generic/413, xfs/260: Improve format operation for PMD fault testing
>>    xfs/260: Move xfs/260 to generic
>>
>>   common/rc                      | 57 +++++++++++++++++++++++++++++-----
>>   tests/ext4/030                 |  2 +-
>>   tests/ext4/031                 |  4 +--
>>   tests/generic/223              |  1 -
>>   tests/generic/413              | 12 ++-----
>>   tests/generic/462              |  2 +-
>>   tests/{xfs/260 => generic/602} | 12 +++----
>>   tests/generic/602.out          |  2 ++
>>   tests/generic/group            |  1 +
>>   tests/xfs/260.out              |  2 --
>>   tests/xfs/group                |  1 -
>>   11 files changed, 65 insertions(+), 31 deletions(-)
>>   rename tests/{xfs/260 => generic/602} (93%)
>>   create mode 100644 tests/generic/602.out
>>   delete mode 100644 tests/xfs/260.out
>>
>> -- 
>> 2.21.0
>>

