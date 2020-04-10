Return-Path: <SRS0=5a++=52=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC4BC2BB85
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Apr 2020 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1022084D
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Apr 2020 19:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="bImjK3L5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDJTWu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:22:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42020 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJTWu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Apr 2020 15:22:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id x66so3187762qkd.9
        for <fstests@vger.kernel.org>; Fri, 10 Apr 2020 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQTyhDUGNWY+2vY832LY8m2QdJZh5HwVSeRffKOPmc8=;
        b=bImjK3L51xIjlqbeYH+mT6Irt1470WDoVRoMZcoOkbAra5bbdqiVJI3OCJZVoHsRGt
         hvtwKcgOC0Qc9prFLIzYhI4/24qEL930DmEtFsIgtfbBbqzgM/NV2OnKBaWWRTs7SY88
         +9jT65MJJCCwnqN6bzQMGxlO865UtKp+chu8sMEUCunx6X+St91TiI+hMShygR5eXwP4
         ZrgbBKauRpge6/gofOCazZlR3v1QI0jxeEJJHJ4L0H9bRYmK52f97hsOLuXBp5pURnwk
         0h7zr2yK8wnSKyKubdwu/JFAqDNx7NGos6ja/mGk9oEOV9qOtPDXPX8uIhkHH+gQVhD4
         2RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQTyhDUGNWY+2vY832LY8m2QdJZh5HwVSeRffKOPmc8=;
        b=tAH6aulHfnW2W1imAvMlEReVfYI7NpRkoQbk3l7Jcnri/eHO33x9c+w3bvXds0qxxJ
         g7f2zjA7L86nrsIub3BhMThMVGUrgt5SxU+iDF4tmhcPdqSTRHgL2biwhwIcyBIND2B5
         rLVOZssRE2FE7meOxJs9J0n4k23B1u9UkmudbPjdoV92o4LRF2+C4HgNdciFeJlObJJi
         hfWqTQcQ+iPF7zVpfsf1b5p5ASBTua9WVcw+rB4YWbdinyz4I2Dgi31v7Vilngs2iMOd
         SmjdcjcBrD4lJPKwl1DVVhX1gb8hk3Uqz1b+2kUBxxrLPgx/XJQT/ZLngzGokW8XnzOc
         cHvA==
X-Gm-Message-State: AGi0PubuvpLf+FGaB9kDhPtepmvinqjvyZk5pzX0kjZGCldHimMyJikK
        WQgDTeuSDY7/zz7u3J/qg5PnLA==
X-Google-Smtp-Source: APiQypL9H8PFloon/jvIQxeYt7ZlVMvxdRczru6MXWOyVmZEFcn2fKQqcGFPfp7SAY9O1lvZVIHCZA==
X-Received: by 2002:a37:8603:: with SMTP id i3mr5220048qkd.303.1586546568851;
        Fri, 10 Apr 2020 12:22:48 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y21sm2203519qka.37.2020.04.10.12.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:22:48 -0700 (PDT)
Subject: Re: [PATCH] btrfs: check that cloning an inline extent does not lead
 to data loss
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200406105134.2233-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0287777d-39b1-c11d-82bb-d68cdef54df9@toxicpanda.com>
Date:   Fri, 10 Apr 2020 15:22:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406105134.2233-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 4/6/20 6:51 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a bug in the current kernel merge window (for 5.7) that results
> in data loss when cloning an inline extent into a new file (or an empty
> file. This change adds a test for such case into the existing test case
> btrfs/205, because it's the test case that tests all the supported
> scenarios for cloning inline extents in btrfs.
> 
> The btrfs patch for the linux kernel that fixes the regression has the
> following sibject:
> 
>    "Btrfs: fix lost i_size update after cloning inline extent"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
