Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79ACC11F64
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jul 2021 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809556141C
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jul 2021 14:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhGAOnW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhGAOnW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 1 Jul 2021 10:43:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8885B6140C;
        Thu,  1 Jul 2021 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625150451;
        bh=qRA6jix9tJ9GFuDWO6ZTcbnyF4vlIVI6z2/rj74g4BY=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=QNDj4qPVAmQzw7Kb5gvI5wgLPcwoNWfwmk+4LOIFlgi/Pp1YeV7GuM7suSnUqUTD4
         MaRQyN6hI9Rpfi0SllaxZ8hSbuzHQ4hvQ68QeEPIySmW0z/yK32S/9LElZCXiOYmZl
         XYADxpQ5xrkrsApJ9BkB4bS3naeyxIMru9QGgShGJvIYdlA7fAZdT+PZ27tUHrP0sm
         8dBAkqNNfe5EzDV2s97jqk6HBT+uaDY8r3zDGqha8sVnBth19BL/wbbTIhfqqTdM/2
         rcy8TqLSbI/D5nyk5JdMWFYwAIVlLsMlkwnUjiEqlChzQQtLu8HKDBFanVFpa0MQGN
         IJcob9zbEcz5Q==
Subject: Re: [PATCH v3 2/3] generic/103: special left calculation for f2fs
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org
References: <20210630113736.551843-1-sunke32@huawei.com>
 <20210630113736.551843-3-sunke32@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, guan@eryu.me
From:   Chao Yu <chao@kernel.org>
Message-ID: <e7122925-de26-65ae-6f13-91d6d66d4355@kernel.org>
Date:   Thu, 1 Jul 2021 22:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630113736.551843-3-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2021/6/30 19:37, Sun Ke wrote:
> It failed on f2fs:
>        QA output created by 103
>       +fallocate: No space left on device
>        Silence is golden.
>       ...
> 
> f2fs uses index(radix) tree as mapping metadata, its space overhead
> is about one thousandth of the data.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>
