Return-Path: <SRS0=RfwH=3C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15045C33CA9
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jan 2020 02:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31D62187F
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jan 2020 02:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbgAMCHF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Jan 2020 21:07:05 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19563 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727222AbgAMCHF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Jan 2020 21:07:05 -0500
X-IronPort-AV: E=Sophos;i="5.69,427,1571673600"; 
   d="scan'208";a="81708410"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Jan 2020 10:07:01 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id C8E774CE1CB3;
        Mon, 13 Jan 2020 09:57:55 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 13 Jan 2020 10:07:01 +0800
Message-ID: <5E1BD0C0.4040704@cn.fujitsu.com>
Date:   Mon, 13 Jan 2020 10:06:56 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Eryu Guan <eguan@linux.alibaba.com>
CC:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] fsx: Add '-a' option to skip unsupported keep
 size automatically
References: <20200106070654.13249-1-yangx.jy@cn.fujitsu.com> <20200106070654.13249-2-yangx.jy@cn.fujitsu.com> <CAOQ4uxh91oRB03UGuqhSgASeY7-OtQD3wMRdOQ-SL0UBgdMPHQ@mail.gmail.com> <5E13E895.8020005@cn.fujitsu.com> <CAOQ4uxijoQugy_qqpfmyFmF4GcCOenbL7eX8d2aEEGknfe_UQg@mail.gmail.com> <5E1436D1.9030601@cn.fujitsu.com> <CAOQ4uxjYmGXsRhGe76KSqfS3k-aMsad=bGdmm-wwMOXyDKFRyA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjYmGXsRhGe76KSqfS3k-aMsad=bGdmm-wwMOXyDKFRyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: C8E774CE1CB3.ADBB1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/1/7 16:49, Amir Goldstein wrote:
>> >  If keep_size is not supported, ops log can also includes the keyword
>> >  "skip ..." by Eryu's patch:
>> >  https://lore.kernel.org/fstests/20191022123115.12250-1-eguan@linux.alibaba.com/
>> >
>> >  Do you want to add require support for keep_size/punch/zero/collapse and
>> >  accept Eryu's patch as well?
>> >
> I am perfectly fine with Eryu's patch and I think it is correct to merge it,
> but it is completely independent to fixing the 4 tests.

Hi Eryu,

These 4 tests need the exact operations to reproduce some issues by 
--replay-ops so Amir perfer to skip tests rather than one operation
if a required operation/flag in tests is not supported.

I think it is reasonable to skip these tests in the case so I have sent 
v3 patch set[1][2]:
https://www.spinics.net/lists/fstests/msg13290.html
https://www.spinics.net/lists/fstests/msg13291.html

With my v3 patch set, it seems that these 4 tests have no chance to fall 
into the condition described by your patch:
https://lore.kernel.org/fstests/20191022123115.12250-1-eguan@linux.alibaba.com/

Best Regards,
Xiao Yang


