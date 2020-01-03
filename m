Return-Path: <SRS0=PjwK=2Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDCC00523
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jan 2020 09:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B24222C4
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jan 2020 09:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgACJKW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:10:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4226 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725972AbgACJKW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Jan 2020 04:10:22 -0500
X-IronPort-AV: E=Sophos;i="5.69,390,1571673600"; 
   d="scan'208";a="81267596"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jan 2020 17:10:19 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 237AB406AB15;
        Fri,  3 Jan 2020 17:01:21 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 3 Jan 2020 17:10:14 +0800
Message-ID: <5E0F04F5.2060608@cn.fujitsu.com>
Date:   Fri, 3 Jan 2020 17:10:13 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Eryu Guan <eguan@linux.alibaba.com>
CC:     <fstests@vger.kernel.org>, <guaneryu@gmail.com>
Subject: Re: [PATCH] ltp/fsx.c: Ignore unsupported keep_size flag even if
 it's specified by --replay-ops
References: <20200103075451.12354-1-yangx.jy@cn.fujitsu.com> <20200103082642.GE41863@e18g06458.et15sqa>
In-Reply-To: <20200103082642.GE41863@e18g06458.et15sqa>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 237AB406AB15.A77F1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/1/3 16:26, Eryu Guan wrote:
> I proposed a similar fix back in 2017[1], but Amir didn't like it
> because my patch (and your patch) ignored keep_size silently (newly
> generated ops list was different than the one fed to --replay-ops).
>
> I proposed a new version in last Oct[2], which will record such ops as
> skipped in the generated ops list, and Brian suggested to add a switch
> to control the behavior if we want to fail fsx on unsupported ops. But I
> didn't have time to work on it since then..
>
> Would you like to help implement the switch Brian suggested based on my
> second patch? Then I can apply my v2 patch&  your switch patch.
>
> Thanks!
>
> Eryu
>
> [1]https://spinics.net/lists/fstests/msg07953.html
> [2]https://lore.kernel.org/fstests/20191023130934.GD59518@bfoster/
Hi Eryu,

Sure, I will try to implement the switch. :-)
Thanks for your detailed explanation.

Thanks,
Xiao Yang



