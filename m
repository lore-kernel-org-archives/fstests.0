Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CEAC433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Nov 2022 16:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiK1QCz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Nov 2022 11:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiK1QCx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Nov 2022 11:02:53 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBF10FE9
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2022 08:02:52 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w4so6988428qts.0
        for <fstests@vger.kernel.org>; Mon, 28 Nov 2022 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TCb2FWrNlQYd+Z4uzmL8P45oPWnl0JeHwwWpJYaobY=;
        b=ABm74U9SsYqTgL5b8PH0IvS/B1JUrpb2DvIF0MmIbZ9gEKqkAxZe4pHmHJeF6Iw9b4
         fMwjm856Xcnuq3WTTELwR3zvo01U3gkXIJm9QOQDKzE+wavofqV76u1uWIihrd1l0g4O
         goQF4bFVYE0NtK+CFXMy/zAyaLtGVJZoy/zLU1xp2T7nJRQ+HBaaDRbbZ2IJHSpQwS1a
         18832XJRA5ji4vCI+DgDcJ2DizyN2CHmSqEkldCrHe2u9f2cgQVDjTbr8g1LqUKx0eB6
         CvTp5Cf1MBpJuSM862Rg8KO+3LF23/YGgT6nrsdD4lKZfB+FeyYaD5oyc/O4dvvdwBeS
         SDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TCb2FWrNlQYd+Z4uzmL8P45oPWnl0JeHwwWpJYaobY=;
        b=THRxCX9AQe46trRBNTVggyP7pByodbrgXPuSYMqhqsQLonzj+0QvVb81Ecs6+i4Tbd
         vMJGCoqmlDIHgl82ZaVlvIeCBio4Qyq74IMb2RogFtxlmOy3V9ccYeQi9f7HlngHtMjP
         1VlQo2YUVIpV0HMjJ6X4lBdFp43b1NzqE7w/UVMl8Qnau7j62Zd0kEqw4GXN8qJapvJn
         YuYdITApLpd05h5bKhfB2hszT7qmaxejLtt9pEsvz/V9Gj4E8xH27lsBR2cU2L+OLu+W
         oVGXoWi+kexMfnzUzOA5pRH2HW+sle6yQqB4mYB2+0E0GajvWWvgEHf0cuwBiPVKZom9
         fRuA==
X-Gm-Message-State: ANoB5pma5hnW87qQAi2Hr+zshHJndxHVSW/1mCpiRFyTT1YVHpU/UuL8
        e6V/trEBQc77YvJHN87pH2JH2A==
X-Google-Smtp-Source: AA0mqf6XVOkcIpyKRULeoqoELu3EhmM9cvmxWOARjaQ/5E+PVX4xH3KWCHRxVUDc8/0C4+K6s3lRqQ==
X-Received: by 2002:ac8:72d7:0:b0:3a5:2bb7:55d5 with SMTP id o23-20020ac872d7000000b003a52bb755d5mr48068775qtp.439.1669651371824;
        Mon, 28 Nov 2022 08:02:51 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w23-20020ae9e517000000b006f9f3c0c63csm8452704qkf.32.2022.11.28.08.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:02:51 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:02:50 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: skip btrfs/253 for zoned devices
Message-ID: <Y4Tbqo7kALoStLco@localhost.localdomain>
References: <20221128122952.51680-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128122952.51680-1-johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 28, 2022 at 04:29:52AM -0800, Johannes Thumshirn wrote:
> The test-case btrfs/253 tests btrfs' chunk size setting, which is not
> available on zoned btrfs, so the test will always fail.
> 
> Skip the test in case of a zoned device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
