Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57BEC11F64
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jul 2021 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CC961403
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Jul 2021 14:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhGAOoE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232363AbhGAOoE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 1 Jul 2021 10:44:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0B8361414;
        Thu,  1 Jul 2021 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625150493;
        bh=N9LvBZmSN+Wmht/RZU9ESnqNi4gD3FpdAoKEyaqLOi0=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=JVAmUqApWYaNKcGwOsOlGbsNHOjHvNQHASi6mfeCdcYt4U81Jr5RUPu5JqHVC91DA
         RBqxbaO8QQ9sFeisGOOE0lH7pc7w3ilXTSuABLlxmkOOr+mHCW7EH+BTdsVAWPylhx
         lG8To1/ai11YS8q/l0Dtya5+WxhOIvUr/tfnx2vY1crNSRNXwCwzdcUZ7Y3a6yhfaz
         xG8hm7dueRkjgokgmMFRQXlx9JHDRGeIvpOffRL7yl1wbVoJiwCidNyMSu4/SKzKhe
         vAIc3PkhH/v0NvQMFkynNsq10Ks6uRUhNLb9Aox0ufehnaE4F3AmAZJVuNDGRQQ5kn
         kVtTP+95S7uaA==
Subject: Re: [PATCH v3 3/3] generic/260: f2fs is also special
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org
References: <20210630113736.551843-1-sunke32@huawei.com>
 <20210630113736.551843-4-sunke32@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, guan@eryu.me
From:   Chao Yu <chao@kernel.org>
Message-ID: <acb98dad-931a-12b3-37f7-6ef57f4ec38e@kernel.org>
Date:   Thu, 1 Jul 2021 22:41:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630113736.551843-4-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2021/6/30 19:37, Sun Ke wrote:
> It fail on f2fs:
> 
>   [+] Default length with start set (should succeed)
>   [+] Length beyond the end of fs (should succeed)
>   [+] Length beyond the end of fs with start set (should succeed)
> +After the full fs discard 0 bytes were discarded however the file system is 12882804736 bytes long.
> +It seems that fs logic handling len argument overflows
> 
> The root cause is f2fs can tag a special flag TRIMMED_FLAG to indicate
> the whole filesystem is trimmed, so after mkfs/fstrim(), following
> fstrim() won't trim any block.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---

Reviewed-by: Chao Yu <chao@kernel.org>
