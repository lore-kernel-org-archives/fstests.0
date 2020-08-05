Return-Path: <SRS0=/czi=BP=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B9BC433E0
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 04:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D082720842
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Aug 2020 04:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgHEEg2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Aug 2020 00:36:28 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39789 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725809AbgHEEg2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Aug 2020 00:36:28 -0400
X-IronPort-AV: E=Sophos;i="5.75,436,1589212800"; 
   d="scan'208";a="97631768"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Aug 2020 12:36:24 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C378D4CE34E2;
        Wed,  5 Aug 2020 12:36:19 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 5 Aug 2020 12:36:19 +0800
Message-ID: <5F2A3742.4090904@cn.fujitsu.com>
Date:   Wed, 5 Aug 2020 12:36:18 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>,
        <ira.weiny@intel.com>, <guaneryu@gmail.com>
Subject: Re: [PATCH v2] generic: Verify how to change the S_DAX flag on an
 existing file
References: <20200805024507.32702-1-yangx.jy@cn.fujitsu.com> <5F2A1FB1.9020403@cn.fujitsu.com>
In-Reply-To: <5F2A1FB1.9020403@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: C378D4CE34E2.ABC04
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/8/5 10:55, Xiao Yang wrote:
> Hi Darrick, Ira
>
> If you prove the v2 patch, I will add the combination(without dax option)
> into all related tests from my v8 patch set.

Sorry for a typo(s/prove/approve).

Thanks,
Xiao Yang


