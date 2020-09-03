Return-Path: <SRS0=Tbzv=CM=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4502EC433E2
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Sep 2020 15:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1633F2072A
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Sep 2020 15:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="C3s14jKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgICPZm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgICPZl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Sep 2020 11:25:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B812C061245
        for <fstests@vger.kernel.org>; Thu,  3 Sep 2020 08:25:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f2so3437471qkh.3
        for <fstests@vger.kernel.org>; Thu, 03 Sep 2020 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=R/vwlE9cotrE5bF1HG/3J+pmzzBO2FvouGDghb20Twg=;
        b=C3s14jKIewUb/T2LNA4mIaFff+1F0i51goIY66znsk9DHLF1XD+GDrI8bMnNlq87KA
         0jpExC4qh955TFejIunNn1EtXwRsD7063bJFvFhUkDsppGvoGgnH7WUyHcnf9MJMoUyy
         SGz0DO8LVkUAZvCqa92LCGzQPame2BgzZkuEz7FbKnrNw+CHPV3ULq9zL+7Vpi8F4s0F
         LHGOzCIOecOANc8I3XspoSTYscgSm/IhTMgYpkkAy9sjW7qFDmIGT4xsOzuZXWXKU7+W
         QnZOOh5FJg4jLQYM1d2t1JqiOA3VJzoX7OB5XRSvWLKzPQz1rSbef4uuOa4ZIpW9BgW/
         FI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/vwlE9cotrE5bF1HG/3J+pmzzBO2FvouGDghb20Twg=;
        b=bNuRQGRP10Iaixig9gdwLL2RKF5Bi4nTpVPtvRTjtbGv52EzfihgvQwCmQEeMbPf4+
         hVNSqkcS33njA18vDX+jFCwmu63w69czQr9FY8zO1SeasLxSq12C9/P8WQgugHDJOjCQ
         wXn3t5FDtRGaXJ4kMG9Zk5+Mbqut2iChgCd74AadjamDv7/bXme/zRut8d/ezFsveBEk
         0k4siqfsiAeT9OQzyILvawtohfsitnD2yUs4B2pq262jltRUZYHNIyAyCh8IrNHid+Vm
         C+Q219q6V6hmjJfLHXzeVsn6QdsO9uLGpLMQge3Yw8m6ZIfJvFmq2EgMZD2Ub/kS2uCr
         PJlQ==
X-Gm-Message-State: AOAM532g4tSWaxDzBCmqsG8+hK47R3x9SCuZOzSZpAuGcwK1VUHNJN78
        eSyInYDRm1SszvBMZRtH4AUwZYlpZ8vvz+pG
X-Google-Smtp-Source: ABdhPJy/yqeBqsjf92CcgO9/A6oGH/gPfzk2dcKO80W15DN8x1IeCj13jUAI92znENUGX7F99NPFSQ==
X-Received: by 2002:a05:620a:211c:: with SMTP id l28mr3466200qkl.395.1599146737168;
        Thu, 03 Sep 2020 08:25:37 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o6sm2292347qki.16.2020.09.03.08.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:25:36 -0700 (PDT)
Subject: Re: [PATCH] btrfs/011: skip if on too small devices
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20200903121815.7797-1-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a1c29b06-7ae4-717a-9429-bf4c08ea91f4@toxicpanda.com>
Date:   Thu, 3 Sep 2020 11:25:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903121815.7797-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 9/3/20 8:18 AM, Johannes Thumshirn wrote:
> btrfs/011 does require a spare device of at least 10GB, skip if we don't
> have big enough devices, e.g. when testing on ramdisks.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
