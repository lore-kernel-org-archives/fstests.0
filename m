Return-Path: <SRS0=bqnA=EM=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567E0C2D0A3
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Nov 2020 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDDA22227
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Nov 2020 16:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="bov0KpVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgKFQz0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Nov 2020 11:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgKFQzZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Nov 2020 11:55:25 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCC6C0613D2
        for <fstests@vger.kernel.org>; Fri,  6 Nov 2020 08:55:25 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id k9so1658796qki.6
        for <fstests@vger.kernel.org>; Fri, 06 Nov 2020 08:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0vgzfQKA3GmsK2EHkYTj3FFm2v+OkGyAzmdVge3mu3c=;
        b=bov0KpVIDnpkWzcbHSo6yim2dgl2Jc5o0by25RvMIF7Szvbuy8pSxCgokUS5m5kdxv
         JASiX3IatXarFEPCJxm31MozROgnofWJlOMNZ7vU+HUWO4FJP9I7uyJYeEtUK3l1wwKA
         tcn7ls7E+dzmM0pdjFjTOC6kt3rRskHkmNVUZ/o//VZGG5NrJ7vAec8ClYC9obLNKVb5
         atH39DnRh860JFPpYCbp6NVHi+JJd9M2UbaWoC1Jlk9ZOQKXaJjskgzufgn5/x3x0ff8
         IoMEwiz1y/XKEWYLBke0NgG5U/3WOrBUpfP6objBs0OBNW5400ImEq6ytrMYjUphX+DD
         imng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0vgzfQKA3GmsK2EHkYTj3FFm2v+OkGyAzmdVge3mu3c=;
        b=ZEVGMS+994dT+U4GlxD1AVYKDMcry9JajTDLp4v0Cw/xi06iyhb+tTDlo5D2tUVocF
         v/f+uNadSSVAn6XhZOWa0QouYgu5aUTS2l3H8/Coq5mWHpxJ3iiezSk8rVjnUoG8aGNG
         flaQqqbeNO+swbMi4xuk7msb7x1duvvvIQAfQJKudhNPu8k4PRxItHIneNmICVP1uAyJ
         doAwDr0DZfAL17oiIclC55gtfK02QWSxvQuyewPJeFadkr1ZKSzi6gHQucHC/3071qhu
         q5tDvAFJZDtsVNjgKwK/B6fH1AfPeEXL/+xJxJiu+J2SHPkdZMUs4Gr6xbZtLydMy5mg
         YLZw==
X-Gm-Message-State: AOAM530DgVn8BnbkMqjcnsk0uKxmGhyNMlXE27cJRX+cbDqhEah9zRqA
        mWWoWXAVEaBMvBUFmDnz9CCgHZzWfdHqrzOU
X-Google-Smtp-Source: ABdhPJz6zoAS+w+Nx/nIgI5cHblOeDPEj3bZm0XroafbwcZ1wMdPBLRuOPB9REntwfM5SiRyow1XLg==
X-Received: by 2002:ae9:f404:: with SMTP id y4mr2489647qkl.372.1604681724794;
        Fri, 06 Nov 2020 08:55:24 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 185sm872761qke.16.2020.11.06.08.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:55:23 -0800 (PST)
Subject: Re: [PATCH 1/2] generic: test number of blocks used by a file after
 mwrite into a hole
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1604487838.git.fdmanana@suse.com>
 <289e1444dc95cb86945126b2677ca25879fdb8dd.1604487838.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eda0fe7a-5bb6-50e1-0664-d4e553a1b2c4@toxicpanda.com>
Date:   Fri, 6 Nov 2020 11:55:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <289e1444dc95cb86945126b2677ca25879fdb8dd.1604487838.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 11/4/20 6:13 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that after doing a memory mapped write to an empty file, a call to
> stat(2) reports a non-zero number of used blocks.
> 
> This is motivated by a bug in btrfs where the number of blocks used does
> not change. It currenly fails on btrfs and it is fixed by a patch that
> has the following subject:
> 
>    "btrfs: fix missing delalloc new bit for new delalloc ranges"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
