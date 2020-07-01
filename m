Return-Path: <SRS0=3sLM=AM=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A7DC433E0
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F84C20771
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 01:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGABKv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:10:51 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49345 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbgGABKt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Jun 2020 21:10:49 -0400
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="95597011"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Jul 2020 09:10:20 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 7CC8A4CE4BD9;
        Wed,  1 Jul 2020 08:59:48 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 1 Jul 2020 09:10:18 +0800
Message-ID: <5EFBE277.7030603@cn.fujitsu.com>
Date:   Wed, 1 Jul 2020 09:10:15 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>
Subject: Re: [PATCH v3 0/6] Make fstests support new behavior of DAX
References: <20200630135951.21202-1-yangx.jy@cn.fujitsu.com> <20200630203422.GV2617015@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200630203422.GV2617015@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 7CC8A4CE4BD9.AE3E4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/7/1 4:34, Ira Weiny wrote:
> On Tue, Jun 30, 2020 at 09:59:45PM +0800, Xiao Yang wrote:
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
> Have the first 3 patches changed?  If not you could have added my Reviewed-by
> from v2?[1]
>
> Not sure if I need to look at them or not.
Hi Ira,

I didn't change the first 3 patches.
Sorry, I forget to add your Reviewed-by and will add it in v4 patch.

Best Regards,
Xiao Yang
> Ira
>
> [1]
> https://lore.kernel.org/fstests/b0d5803e-81e4-bb14-f47b-44036284577e@163.com/T/#mb0235e57045c4f7a3bc70c7745f2b7065bb3e3c1
> https://lore.kernel.org/fstests/b0d5803e-81e4-bb14-f47b-44036284577e@163.com/T/#ma472463b67a354484a054cf0c0c1bf3c8567937b
> https://lore.kernel.org/fstests/b0d5803e-81e4-bb14-f47b-44036284577e@163.com/T/#m5d44764e500370ceb4a350b4ae0df9bec8c08b56
>
>
>>    generic/223: Don't clear all mkfs options for _scratch_mkfs_geom()
>>      roughly
>>    generic/413, xfs/260: Improve format operation for PMD fault testing
>>    xfs/260: Move and update xfs/260
>>
>>   common/rc                      | 60 ++++++++++++++++++++++++----
>>   tests/ext4/030                 |  2 +-
>>   tests/ext4/031                 |  4 +-
>>   tests/generic/223              |  1 -
>>   tests/generic/413              | 12 ++----
>>   tests/generic/462              |  2 +-
>>   tests/{xfs/260 =>  generic/603} | 71 +++++++++++++++++-----------------
>>   tests/generic/603.out          |  2 +
>>   tests/generic/group            |  1 +
>>   tests/xfs/260.out              |  2 -
>>   tests/xfs/group                |  1 -
>>   11 files changed, 97 insertions(+), 61 deletions(-)
>>   rename tests/{xfs/260 =>  generic/603} (54%)
>>   create mode 100644 tests/generic/603.out
>>   delete mode 100644 tests/xfs/260.out
>>
>> -- 
>> 2.21.0
>>
>>
>>
>
> .
>



