Return-Path: <SRS0=39K/=5Q=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A5DC43331
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 07:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D1C20A8B
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 07:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgCaH7w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:59:52 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7452 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726397AbgCaH7w (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Mar 2020 03:59:52 -0400
X-IronPort-AV: E=Sophos;i="5.72,327,1580745600"; 
   d="scan'208";a="88272453"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Mar 2020 15:59:49 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id CD4BF50A996E;
        Tue, 31 Mar 2020 15:49:29 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 31 Mar 2020 15:59:44 +0800
Subject: Re: [PATCH v4] xfs/191: update mkfs.xfs input results
To:     Christoph Hellwig <hch@lst.de>, <guaneryu@gmail.com>,
        <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>
References: <1585304270-8790-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200330043659.GR14282@dhcp-12-102.nay.redhat.com>
 <20200331074940.GB24372@lst.de>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <64ff8e6d-6b17-cc25-5597-31794ae5f151@cn.fujitsu.com>
Date:   Tue, 31 Mar 2020 15:59:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20200331074940.GB24372@lst.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: CD4BF50A996E.AF59F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2020/03/31 15:49, Christoph Hellwig wrote:
> On Mon, Mar 30, 2020 at 12:45:07PM +0800, Zorro Lang wrote:
>>> +loopimg=$TEST_DIR/$seq.loopimg
>>> +$XFS_IO_PROG -f -c "truncate $fssize" $loopimg
>>> +loopdev=$(_create_loop_device $loopimg)
>>> +SCRATCH_DEV=$loopdev
>>
>> Hi,
>>
>> I don't want to be picky, I think a "_require_test" would be better
>> if we use $TEST_DIR, although we always have a mounted TEST_DIR generally :)
>> If Eryu would like to add it, you can save one patch :)
>>
>> Others looks good to me, test passed.
>> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Same here, modulo a _require_test this looks good:
Thanks for your and zorro's review. I think Eryu can help me add 
_require_test when merge this patch into master.

Best Regards
Yang Xu
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> 


