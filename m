Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB07BEB64DD
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Jul 2023 09:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjGIJRT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Jul 2023 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJRR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jul 2023 05:17:17 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A83115
        for <fstests@vger.kernel.org>; Sun,  9 Jul 2023 02:17:15 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:34a8:0:640:678e:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id BD4BC5EB98;
        Sun,  9 Jul 2023 12:17:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BHTNLmHW0uQ0-YhEL6fNy;
        Sun, 09 Jul 2023 12:17:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688894232;
        bh=b95BdNRopZ+qkZuII8bP2vjSyKSj2k6yXfG+1dwOgE0=;
        h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
        b=XXRNefWDZb2oYQiIDn8j2TSJpwlMmIcQ3dA/AeUiPP1Fqp0VTGXEgfsjSXUZfWtBr
         h+nBglvkNX9kov9/qfoqcRdkGR3pdQs0pjBTySfhJhLrLr1yYmwcHlyYbVO93MADhL
         r4WfAnFmAZFIlv+xDg6rFvF3Ab2Gthgp1Fld1tHc=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2fd915b0-fd6f-ffb6-8d6b-900ca484c8d2@yandex.ru>
Date:   Sun, 9 Jul 2023 14:17:10 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] t_ofd_locks: fix initialization sequence
Content-Language: en-US
From:   stsp <stsp2@yandex.ru>
To:     Murphy Zhou <xzhou@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org
References: <20230630094051.3765376-1-stsp2@yandex.ru>
 <6ee5c9ee42388d2a2e25bf80b3d7db9c09384867.camel@kernel.org>
 <CALWRkkjb9hMmoHf3xa93mAEJBFM3hjB5K4dkWL+659dSGa0qsA@mail.gmail.com>
 <332cedf4-3580-86f8-3fd6-de32b67f155e@yandex.ru>
In-Reply-To: <332cedf4-3580-86f8-3fd6-de32b67f155e@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


06.07.2023 13:54, stsp пишет:
>
> 06.07.2023 13:41, Murphy Zhou пишет:
>> +                             semid = semget(semkey, 2, IPC_CREAT);
>>                                if (semctl(semid, 2, IPC_RMID, semu) 
>> == -1)
>> Good catch. This RMID is useless unless we have got the existing
>> semaphore. According to SEMGET(2), seems should be:
>>
>>      semid = semget(semkey, 2, 0);
>>
>> to obtain an existing semaphore?
>
> Yes, I just wanted to avoid the purely
> theoretical condition when someone
> else removed this sem right before we
> did second semget(). So I added IPC_CREAT
> just as a safety measure.
> Should I remove it?

Ping!

So how should I proceed with the patch?
Who can give reviewed-by?

