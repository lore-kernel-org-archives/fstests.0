Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B2C33C99
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 07:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B392081E
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 07:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgAGHoX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:44:23 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37503 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbgAGHoX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 02:44:23 -0500
X-IronPort-AV: E=Sophos;i="5.69,404,1571673600"; 
   d="scan'208";a="81425629"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2020 15:44:20 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id F3E8749E9335;
        Tue,  7 Jan 2020 15:35:20 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 7 Jan 2020 15:44:19 +0800
Message-ID: <5E1436D1.9030601@cn.fujitsu.com>
Date:   Tue, 7 Jan 2020 15:44:17 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Amir Goldstein <amir73il@gmail.com>
CC:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] fsx: Add '-a' option to skip unsupported keep
 size automatically
References: <20200106070654.13249-1-yangx.jy@cn.fujitsu.com> <20200106070654.13249-2-yangx.jy@cn.fujitsu.com> <CAOQ4uxh91oRB03UGuqhSgASeY7-OtQD3wMRdOQ-SL0UBgdMPHQ@mail.gmail.com> <5E13E895.8020005@cn.fujitsu.com> <CAOQ4uxijoQugy_qqpfmyFmF4GcCOenbL7eX8d2aEEGknfe_UQg@mail.gmail.com>
In-Reply-To: <CAOQ4uxijoQugy_qqpfmyFmF4GcCOenbL7eX8d2aEEGknfe_UQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: F3E8749E9335.AA590
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/1/7 14:47, Amir Goldstein wrote:
> No it is not wrong, but this is different than skipping keep_size.
> My point is that when fsx is run with some parameters and
> produces a replay-ops log. If that replay-ops log is replayed with
> exact same parameters it should produce the exact same sequence.
>
> In the case of punch/zero/collapse, if those are skipped when recording
> the ops log, then ops log includes the keyword "skip ..." explicitly, but
> but for skipped keep_size, keep_size will simply not be in the log.
Hi Amir,

If keep_size is not supported, ops log can also includes the keyword 
"skip ..." by Eryu's patch:
https://lore.kernel.org/fstests/20191022123115.12250-1-eguan@linux.alibaba.com/

Do you want to add require support for keep_size/punch/zero/collapse and 
accept Eryu's patch as well?

Thanks,
Xiao Yang
>
> IOW, the fsxops logs that are hardcoded in the 4 tests that you changed
> have all been created*with*  keep_size support and*with*  punch/zero/collapse
> support, so should also be replayed the same way, because otherwise the test
> is simply not doing what it was intended to do.



