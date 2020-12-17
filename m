Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D8EC2BBCA
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Dec 2020 16:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7CD239E4
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Dec 2020 16:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgLQQ2x (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgLQQ2x (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Dec 2020 11:28:53 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC4EC06138C
        for <fstests@vger.kernel.org>; Thu, 17 Dec 2020 08:28:12 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b64so22873488qkc.12
        for <fstests@vger.kernel.org>; Thu, 17 Dec 2020 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mbzpBCGhU9THHRTBeA0Ip/ckdVw6fJqozA0HkKle2iw=;
        b=mMXFZjZ4YlUV0B7m3xspeeIn34tloJCGPlaqVUZcFhAWk+J6rptSqFSpyGzNCnv3ZS
         8VizbX+mGaOki0fFn+rsH7RLCLHSpJSyxFxy+LWVS4z/R1vnEG/iJ5DqB6/AR41jFIyP
         pHnJAjZdP3UMR4MOXBuUK/j2HZwvCYiSEszp9tx+8lmcHncjtG29KdwBqnXZxysFXYW3
         uQz6SPo1WepHh4NFErLTjQC+A6QsF52wPvcbxVsuSPGnR1UE8vFaUSWRUA4rzJvcA0mE
         bFD9nv3ITtZnIux28Z7AArJXh4UCdjWYpCMYmopvEs8ze5WOpy6/NfvbIGFCS4H2ofoE
         71xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mbzpBCGhU9THHRTBeA0Ip/ckdVw6fJqozA0HkKle2iw=;
        b=JyvH2skYM6WFJ4yIcbZQNUkI0p2nBuTkhOXY6D1iCIXpAesmwfMrQEY9DEWIzSDr2j
         EwXfbQS5Y2C5nEAGyQAO1Z7bF2HU7JW2wy2TTQHuhxgFPBp7PBgBYBMeWaUtdsEPIB8J
         kkSBP2WsV9+aggh/0V0xqGPNYlk+gMmRCyAU53QxYYEO00IlUdLpgCKOFs6AuFY4kDti
         lxNyNtYJmNG3AJMiN5fEslCoIWG0L2FhtU8rfwGlOWp2e+CJMJ5AklhElz6qSB0Azg7y
         lNvxOzVwnKs1gOg08iAZvBBTYc4I572++OqjBvSCo74REYmcVv4YXaqCQBEo5m6GRkLe
         9ohQ==
X-Gm-Message-State: AOAM531Z+O7E8mDlqshsbm+5w1Y+55LU+vcK9xMJVpLv+xm4aKihpRzp
        BJGud8uJH5uQMdCbxKEwQCKMRA==
X-Google-Smtp-Source: ABdhPJy8FqS4glcub/9s1peMCvYhZFtSztHuBt5ioA8vAnElOXM7NyzQ6Os/FiOo0I4XGrBbpF6jyg==
X-Received: by 2002:a05:620a:12f8:: with SMTP id f24mr45201qkl.132.1608222491965;
        Thu, 17 Dec 2020 08:28:11 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c14sm3422571qtg.85.2020.12.17.08.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:28:11 -0800 (PST)
Subject: Re: [PATCH] btrfs: test incremental send after removing a directory
 and all its files
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <ea077f0f8a54ab3ea303494e45eb1b166de7e758.1607602049.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1a37ce73-ba32-ef51-3e0b-052eaa483d35@toxicpanda.com>
Date:   Thu, 17 Dec 2020 11:28:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ea077f0f8a54ab3ea303494e45eb1b166de7e758.1607602049.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 12/10/20 7:09 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send operation succeeds, and produces the
> correct results, after removing a directory and all its files, unmounting
> the filesystem, mounting the filesystem again and creating a new file (or
> directory).
> 
> This currently fails on btrfs, but is fixed by a patch that has the
> following subject:
> 
>    btrfs: send, fix wrong file path when there is an inode with a pending rmdir
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
