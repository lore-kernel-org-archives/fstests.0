Return-Path: <SRS0=Klg3=23=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D2C32771
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 07:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7AE21734
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 07:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAFHKI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:10:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:17291 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726338AbgAFHKI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Jan 2020 02:10:08 -0500
X-IronPort-AV: E=Sophos;i="5.69,401,1571673600"; 
   d="scan'208";a="81356084"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Jan 2020 15:10:05 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id B48D249E9331;
        Mon,  6 Jan 2020 15:01:05 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 6 Jan 2020 15:10:03 +0800
Message-ID: <5E12DD49.50001@cn.fujitsu.com>
Date:   Mon, 6 Jan 2020 15:10:01 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     <eguan@linux.alibaba.com>, <fstests@vger.kernel.org>
Subject: Re: [PATCH 2/2] fsx: Add '-a' option to skip unsupported keep size
 automatically
References: <20200106065238.12884-1-yangx.jy@cn.fujitsu.com> <20200106065238.12884-2-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20200106065238.12884-2-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: B48D249E9331.A9B54
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

Sorry, forgot to add '-a' option to short help.
I will send v2 patch set soon.

Thanks,
Xiao Yang
On 2020/1/6 14:52, Xiao Yang wrote:
> 1) Use '-a' option to skip unsupported keep size automatically even if
>    it's defined by --replay-ops.
> 2) Add $FSX_AVOID to tests which defines keep size by --replay-ops.



