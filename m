Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6861C43465
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5702220C
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 14:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="FmsFIJVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgIUObb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 10:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgIUObb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 10:31:31 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDB2C0613CF
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 07:31:31 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v54so12421186qtj.7
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xup/6l0/GUl/Q1GS1OD6QBEEYkQUDiMG4VGCKb3WaZ4=;
        b=FmsFIJViZvZbOhXuN7WcjJZgLOdjjtAt45r1K8gsDunmRnuL7o5IKpmfNY4rY/d1R6
         ywSUAYXfeOuVjF/GiZvaDhV6s8003W3ZCjqozUi2KJ7OQCaBMeNf6nWQ8VL0mm2XeZPA
         HcosbleoTU3fngKiPEoWC2ii/TBePj1+cOF4Tfg8vL2odygAzO0dlX0iD1pJqOWIKJuV
         H+x5Q8P3cwkF8bGFnDZe7KX6zxA/UiK7qfNFtRyiAnbmu45sYOP4nUQsSMjb3eeZytG7
         FZCiDyNxevjGY+QVHVUJ0yjqrsd9UX49ikVoaTdQXd9e4FOSgtalklvOIlColvL7yUpn
         gpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xup/6l0/GUl/Q1GS1OD6QBEEYkQUDiMG4VGCKb3WaZ4=;
        b=WXs42OTXgXl6LBGmaLhOOtsrd/9Kolg+CwkAkvfmHBhM7FoPF29s79kgr2UmSihU8a
         c0tArMt08coINz2E4iiO78/mZejgPbOu4g/OCLAw8+WKcCmcViqyqUT76X0Fzt/kCtv2
         +XYyo/E9JEDW7AmeILyydOJG0DZcxMEKNG8+JH8EPEcVxsTtu/ktPavPb7qYVSPWDJGr
         5/x4Gjxx3jl+vl82UxtB1a9eBqFfwGRV3eLM7FvzPD1cROH8tsR5+bSkbEr/RCO3mguf
         n+mQ6YlIAh9OvhjQrCkXZ1Luk++cC2zM1exe11jM6808OdUv5PLYCHowY7ZVIeW56Yac
         aKPw==
X-Gm-Message-State: AOAM5323qhTeufXyoP3ptirI0lT7MoLeVpAJvKqx7MzyxU5Gixzn/r4J
        rLxjmmlH9YGwef6OMoRhzoz83Q==
X-Google-Smtp-Source: ABdhPJwPrbg4Ym2iu6C3wPjA2uv+X0G28SeKTQvf82EsiBtY3Q30LKsaXtcWF9P06HDkn3mCxI0BZQ==
X-Received: by 2002:aed:23fc:: with SMTP id k57mr27040226qtc.216.1600698690610;
        Mon, 21 Sep 2020 07:31:30 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n136sm8847639qkn.14.2020.09.21.07.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:31:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: test incremental send after a succession of
 rename and link operations
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1600693732.git.fdmanana@suse.com>
 <83001e537cdf42258dd4b4e3212546dfd099a337.1600693732.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f2073f68-2491-54e0-a504-2b18fb00d86d@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:31:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <83001e537cdf42258dd4b4e3212546dfd099a337.1600693732.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 9/21/20 9:15 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send operation emits the correct path for link
> and rename operation after swapping the names and locations of several
> inodes in a way that creates a nasty dependency of rename and link
> operations. Notably one file has its name and location swapped with a
> directory for which it used to have a directory entry in it.
> 
> This test currently fails but a kernel patch for it exists and has the
> following subject:
> 
>    "btrfs: send, orphanize first all conflicting inodes when processing references"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
