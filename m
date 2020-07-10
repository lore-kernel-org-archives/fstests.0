Return-Path: <SRS0=s9tj=AV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A2C433E5
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jul 2020 17:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF302075D
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jul 2020 17:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Ez/bv/5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGJRw2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGJRw2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Jul 2020 13:52:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F6C08C5DC
        for <fstests@vger.kernel.org>; Fri, 10 Jul 2020 10:52:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so6090688qkb.8
        for <fstests@vger.kernel.org>; Fri, 10 Jul 2020 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z/EptbW5l5MlTK8iv4lqndCFmdDwMl00L4o7dddZcU0=;
        b=Ez/bv/5D+7tFESuhn9k7WjcLZnnwQyMLqHBllKwyW1T/oJwT33VKLBet1y6PzkPqTX
         +pvCDOzktxICTq/ajVhFg5U9GAXmyIhwlPN8ypMWqzfwFdxu5J1M4UpA2vMplZbf9aXa
         Nbqv3QsDjr4vvaFR4kSuRr1zH2VDG8+t1BoszfZ/g7TPmAFx4jz25YRzRb3dSPh/O1as
         69zbh0K9XzvSFERi8oCeuriZhTg7kBSQLcJu7fq6nk5ZukHCgm5m4lxiKNBj9BuMrm++
         h3nyPBcChYWVugnARelnAulwgbyKpw4MsLMo5489dkFMpasBpH2OROJU5GCn/FwnsD1v
         8MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z/EptbW5l5MlTK8iv4lqndCFmdDwMl00L4o7dddZcU0=;
        b=S7PHZT/QEo/8FU7ogAE87/g25Bh8qEGKGdj55rm8rS/bfm3DrsLfIdbxBwOLTUUuPf
         D5WvkPaifjzprRa38YyxB18nQYj9i622S3ctI/ZdoZKGN1ej/8rbIpDx2lPvmC5yAKmb
         /fxYo4oSZ5qV08dPy60blSHdgV5iV20KsgHi4ZKPZJOUMTLtEx27RVoVCciRW7lltTu8
         E6AQ/dCCOZmbXyxkhZyQ0UpoWP/6mRVtCrdlChAUiKW18hz49atHUaiL/T3z2P4k1qb9
         vOSm6Tyf1VvKELEHikxfL8q5Ruo7PDwNGqv1QhVVwoPln+NBTLnvjiR3Z8eyZX5MmGqJ
         nr8g==
X-Gm-Message-State: AOAM532vPLDPHSsM42xKRbkgPzdxN/vDHzWU72I9fsyezGFbDYh9Pj5m
        b3gzjbEByYHZIKkQYCSLNTRTJQ==
X-Google-Smtp-Source: ABdhPJy+fakZnr5H9Yi75eg6ca9yYWo4GVWxwEGvLucV1Llpwri1a+7ByKvnC6Vfo3UmuYN6zLCusg==
X-Received: by 2002:a05:620a:1235:: with SMTP id v21mr52811688qkj.454.1594403547564;
        Fri, 10 Jul 2020 10:52:27 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o50sm8802506qtc.64.2020.07.10.10.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:52:26 -0700 (PDT)
Subject: Re: [PATCH v2] generic: add a test for umount racing mount
To:     Boris Burkov <boris@bur.io>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <c8bfc2c7-4c13-72e4-3665-c2e2dec99dd4@toxicpanda.com>
 <20200710171836.127889-1-boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <641e25ca-17bd-034a-9970-2396fe238c81@toxicpanda.com>
Date:   Fri, 10 Jul 2020 13:52:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710171836.127889-1-boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 7/10/20 1:18 PM, Boris Burkov wrote:
> Test if dirtying many inodes (which can delay umount) then
> unmounting and quickly mounting again causes the mount to fail.
> 
> A race, which breaks the test in btrfs, is fixed by the patch:
> "btrfs: fix mount failure caused by race with umount"
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
