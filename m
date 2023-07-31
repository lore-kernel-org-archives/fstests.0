Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6A0C001DF
	for <linux-fstests@archiver.kernel.org>; Mon, 31 Jul 2023 11:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjGaLeR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGaLeQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Jul 2023 07:34:16 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB2C3
        for <fstests@vger.kernel.org>; Mon, 31 Jul 2023 04:34:15 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1d21:0:640:c9e4:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 578945EA58;
        Mon, 31 Jul 2023 14:34:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BYOQEfgDW4Y0-39sEotc5;
        Mon, 31 Jul 2023 14:34:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690803252;
        bh=KTjt/E+aCzO9E2dqRp7ekCnkH0i2GIt2ypy4YTQXmsI=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=WQDIn1j43nM3P9WXoXm2TM5Kzypfvu7inKgM0jiUeH+edk1rhjYXDj6ify/OyMMOr
         +6LZPDDu/fyZ+9uUvaKW48TYMbbKYwMH0OKCrwyRYukrLjPv8KhPMl2ara7MNut6dy
         +mYB0HC+bpPaeGZ+TJb0YQIyvCHOFScotiv859DE=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <10c83477-43aa-07cb-23f2-a321bab6fb28@yandex.ru>
Date:   Mon, 31 Jul 2023 16:34:10 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] t_ofd_locks: fix initialization sequence
Content-Language: en-US
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org
References: <20230630094051.3765376-1-stsp2@yandex.ru>
 <6ee5c9ee42388d2a2e25bf80b3d7db9c09384867.camel@kernel.org>
 <CALWRkkjb9hMmoHf3xa93mAEJBFM3hjB5K4dkWL+659dSGa0qsA@mail.gmail.com>
 <332cedf4-3580-86f8-3fd6-de32b67f155e@yandex.ru>
 <CALWRkkhmj7rJf8Xhe1Oo_5h4XByoD+U6SEoKHFC1S0ejYPu4cw@mail.gmail.com>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <CALWRkkhmj7rJf8Xhe1Oo_5h4XByoD+U6SEoKHFC1S0ejYPu4cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


10.07.2023 09:27, Murphy Zhou пишет:
>> What while loop do you mean and what
>> doesn't hurt? Does the rest of the patch
>> look ok?
> I mean the do-while loop ensures a new semaphore is created.
OK, given that the initial patch was problematic
for review, I posted the v2, which introduces
the simpler scheme, and is better structured:

https://lore.kernel.org/fstests/20230731112807.1463846-1-stsp2@yandex.ru/T/#t

Does this help?

