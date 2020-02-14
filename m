Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01324C352A3
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 01:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD4720873
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 01:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgBNBOk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:14:40 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18007 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727604AbgBNBOk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Feb 2020 20:14:40 -0500
X-IronPort-AV: E=Sophos;i="5.70,438,1574092800"; 
   d="scan'208";a="83276023"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Feb 2020 09:14:38 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 76673406AB15;
        Fri, 14 Feb 2020 09:05:00 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 14 Feb 2020 09:14:33 +0800
Subject: Re: generic/269 hangs on lastest upstream kernel
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Jan Kara <jack@suse.cz>, fstests <fstests@vger.kernel.org>
References: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
 <20200212105433.GH25573@quack2.suse.cz>
 <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
 <20200213170853.GA311476@mit.edu>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1c81c16b-6e31-74cb-0b88-46663fad500d@cn.fujitsu.com>
Date:   Fri, 14 Feb 2020 09:14:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20200213170853.GA311476@mit.edu>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 76673406AB15.A7913
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2020/02/14 1:08, Theodore Y. Ts'o wrote:
> On Thu, Feb 13, 2020 at 04:49:21PM +0800, Yang Xu wrote:
>>
>>
>> on 2020/02/12 18:54, Jan Kara wrote:
>>> Hello!
>>>
>>> On Tue 11-02-20 16:14:35, Yang Xu wrote:
>>>> Since xfstests support rename2, this case(generic/269) reports filesystem
>>>> inconsistent problem with ext4 on my system(4.18.0-32.el8.x86_64).
>>>
>>> I don't remember seeing this in my testing... It might be specific to that
>>> RHEL kernel.
>>
>> Agree.
> 
> So were you able to reproduce this on a 5.6.0-rc1 kernel or not?
No. I don't reproduce it on 5.6.0-rc1 kernel, but  5.6.0-rc1 kernel hang 
on my KVM machine when run generic/269.

Best Regards
Yang Xu
> 
> If you are, can you send the .config that you used, in case it's
> configuration specific?
> 
> 					- Ted
> 
> 


