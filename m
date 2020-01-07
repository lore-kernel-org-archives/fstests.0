Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC07C32771
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 02:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B821720715
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 02:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgAGCKe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:10:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18475 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727326AbgAGCKe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Jan 2020 21:10:34 -0500
X-IronPort-AV: E=Sophos;i="5.69,404,1571673600"; 
   d="scan'208";a="81410525"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2020 10:10:32 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 43F32406AB15
        for <fstests@vger.kernel.org>; Tue,  7 Jan 2020 10:01:33 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 7 Jan 2020 10:10:31 +0800
Message-ID: <5E13E895.8020005@cn.fujitsu.com>
Date:   Tue, 7 Jan 2020 10:10:29 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] fsx: Add '-a' option to skip unsupported keep
 size automatically
References: <20200106070654.13249-1-yangx.jy@cn.fujitsu.com> <20200106070654.13249-2-yangx.jy@cn.fujitsu.com> <CAOQ4uxh91oRB03UGuqhSgASeY7-OtQD3wMRdOQ-SL0UBgdMPHQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh91oRB03UGuqhSgASeY7-OtQD3wMRdOQ-SL0UBgdMPHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 43F32406AB15.AA37D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/1/6 19:24, Amir Goldstein wrote:
> A very strong NACK!
>
> Why are you making this change?
> Did you read the description of the tests and try to understand the sequence
> prescribed in the replay-ops file?
>
> Those are reproducers to specific issues that require a very specific sequence
> of operations and it seems to me that 'keep_size' is there for a reason in every
> one of those tests.
>
> For example, take the test generic/456, which I wrote, it has this link in the
> comment above fsxops to a very elaborate email from Ted explaining the
> problem:https://marc.info/?l=linux-ext4&m=151137380830381&w=2
>
> You cannot just remove 'keep_size' from the test because then the test
> doesn't do what it is intended to do.
>
> Did you read my reply to Eryu's patch which he referred you to?
> https://spinics.net/lists/fstests/msg08007.html
>
> Instead of allowing test generic/456 to run on fs which doesn't support
> FL_KEEP_SIZE, you should change the test to*require*  support for
> FL_KEEP_SIZE as well as require support for punch/zero/collapse:
>
> _require_xfs_io_command "falloc" "-k"
> _require_xfs_io_command "fpunch"
> _require_xfs_io_command "fzero"
> _require_xfs_io_command "fcollapse"
>
> Same for the other tests that you changed to ignore keep_size.


Hi Amir,

Thanks for your comment.

I had a doubt and asked Eryu after sending the second patch:
https://www.spinics.net/lists/fstests/msg13278.html

Current fsx skips all unsupported ops(e.g. punch_hole, zero_range, 
collapse_range) automatically even if they are specified by 
--replay-ops.  Is this existing logic wrong?

I read your suggestion before, but i just have a worry:
xfs_io commands cannot detect the supported flags of fallocate() 
correctly in one case(i.e. xfs_io commands are not supported but 
fallocate(2) supports flags).

fsx has many test_ functions to check these flags, so we can make fsx 
call only these test_ functions by adding a option and then report "not 
run" by analyzing the generated output.

Best Regards,
Xiao Yang


