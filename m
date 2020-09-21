Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63473C43465
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 14:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F037D2220C
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 14:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="1SjJ9A2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIUOdh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUOdh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 10:33:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9839C061755
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 07:33:36 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e7so12421438qtj.11
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lZmS0sYnIpamTgh8yRO0ppjbopWuzXTeah1Q4hCrqYo=;
        b=1SjJ9A2ppKXtKOz7pJHIZRli9YXJT3NnWIbKq+xIAW77C9lMzWpRDYahbM4Tn4sS8R
         CCwCMvcntBTT0/OyUPD7cW7vgzucbRtScvQ8z67U0A9rkn3wEljJZp5OJrq2N9rWoty6
         rl1YsOinyYrqHjLf39NaAntXWSl6pXM1zf0L27nMPF09UQvozvCQwxJ+M5J/IWvGpaJi
         b5nWD00kTZmGfoYwa1o5uxPopV4x0bFDY+h7PZtLm89h8eWjY5xKq1wsfVtDc+N+LyzV
         wRn2+EfaQo1A28DEApapn0QC0nLH65lASd7u0kfxaiouPvB8h3hzXI47zmZYGEe+m45J
         jlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZmS0sYnIpamTgh8yRO0ppjbopWuzXTeah1Q4hCrqYo=;
        b=WrWKThwTMLgGnRAwnLB7q/bHXxBklF7xppzXkSpi+3LWKd388vgcKhZod0Zbw1EAgq
         cN4wxGBBZIvwIfyV5jtdKTPhIYMU/uPv5lY03rxx9evOKh3WjWjH5fvMJQyHOMyUH2e/
         zvWg6b2znJnrGHk+TjSVnaBX6JfaDD26iHLZ4EKd/HWNcqtufpcFiXZElcnQE/VwwPCA
         nwbABLA9hF2uy+2VfDov0pEAfitcpwYAZZjvuOxE6qv/DpN+bSjMwzdO/qF/fwWMjrhr
         kgmjNiPHXJY9GKIV2c49+MsXsp/vN+XBP7+yEqFPAaeayrFz+jQvLQBN65OrklKYzOR7
         pdGA==
X-Gm-Message-State: AOAM531PYKJPOTQDB7hWsCSW1HqsJAi1E2LAM6VMhivP5I9KOd58QCI1
        EtudjRMNmPOKthqUb5z5yhbLID6kUCTDMAv7
X-Google-Smtp-Source: ABdhPJzExD1Dmg3FMfUX+RyZujSDrDqu+a6oJRSy+NFAC/kOmjoi5kFTYBK/20T2+8RX9ZDBljO1FQ==
X-Received: by 2002:ac8:4e4e:: with SMTP id e14mr34517003qtw.49.1600698815759;
        Mon, 21 Sep 2020 07:33:35 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v131sm9575723qkb.15.2020.09.21.07.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:33:34 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: remove stale test for alien devices from auto
 group
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        fstests@vger.kernel.org
References: <20200921143035.26282-1-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6a74a0c3-038c-e079-8243-ce14bc0aec2d@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:33:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921143035.26282-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 9/21/20 10:30 AM, Johannes Thumshirn wrote:
> btrfs/198 is supposed to be a test for the patch
> "btrfs: remove identified alien device in open_fs_devices" but this patch
> was never merged in btrfs.
> 
> Remove the test from fstests' auto group, as it is constantly failing.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
