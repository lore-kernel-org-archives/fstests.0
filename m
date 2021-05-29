Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1844CC4708C
	for <linux-fstests@archiver.kernel.org>; Sat, 29 May 2021 03:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DB961059
	for <linux-fstests@archiver.kernel.org>; Sat, 29 May 2021 03:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhE2DqD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 May 2021 23:46:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5138 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhE2DqA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 May 2021 23:46:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsS5x5THJzYnM8;
        Sat, 29 May 2021 11:41:41 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 11:44:22 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 dggema759-chm.china.huawei.com (10.1.198.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 29 May 2021 11:44:22 +0800
Subject: Re: [PATCH] xfs: fix check of whether the mkfs fail
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>, <guan@eryu.me>
References: <20210528094046.1920724-1-sunke32@huawei.com>
 <20210528163033.GO202144@locust>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <85e3b76b-810d-a726-59cd-63cd57230bac@huawei.com>
Date:   Sat, 29 May 2021 11:44:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210528163033.GO202144@locust>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



ÔÚ 2021/5/29 0:30, Darrick J. Wong Ð´µÀ:
> On Fri, May 28, 2021 at 05:40:46AM -0400, Sun Ke wrote:
>> The return value ("$?") is always the status of the last command in the pipe.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
> 
> Heh, whooops.  Thanks for fixing this!
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
Thanks for your review.

