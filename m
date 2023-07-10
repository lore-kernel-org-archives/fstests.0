Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D26FEB64DA
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Jul 2023 06:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGJGSJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Jul 2023 02:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGJGSI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Jul 2023 02:18:08 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FCE103
        for <fstests@vger.kernel.org>; Sun,  9 Jul 2023 23:18:06 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3c81:0:640:d488:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 24FB05EBC3;
        Mon, 10 Jul 2023 09:18:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2IRDg3QWoGk0-A1pH26bD;
        Mon, 10 Jul 2023 09:18:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688969883;
        bh=D6W6c8q6aYVpDfOcl9x1v+yLnHdj9NiwY7x5nnLWye8=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=XekTs4P11uN615r0vTpMeR2lcqWWnDvN4AjpLhayQd7TsFzA9nLg292wRR7/BzJ99
         6EPZcwUmezOwWfZTM3jh2q+cMPEJJCUoeJBreZq7zHPY6x7/NpnSiCqGRUWaa9ZxsG
         KQxRefHaAg7LZtD8Pa31EaU8Fy0AKNVbxuGfUUxg=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <af5f52e2-a885-f0a0-c812-38fef87bb874@yandex.ru>
Date:   Mon, 10 Jul 2023 11:18:01 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
> Hi,
>
> Sorry for the late reply.
>
> On Thu, Jul 6, 2023 at 4:54 PM stsp <stsp2@yandex.ru> wrote:
>
>> What while loop do you mean and what
>> doesn't hurt? Does the rest of the patch
>> look ok?
> I mean the do-while loop ensures a new semaphore is created.

But it would really help if you quote
the relevant part of the patch, as I
have no idea what loop ensures a sem
is created. If I look through the patch
to find any loop that it removes, then
its this one:
-               do {
-                       memset(&sem_ds, 0, sizeof(sem_ds));
-                       semu.buf = &sem_ds;
-                       ret = semctl(semid, 0, IPC_STAT, semu);
-               } while (!(ret == 0 && sem_ds.sem_otime != 0));

Does it ensure if sem is created - no,
it only waits until otime is non-zero.
AFAIK the formal review process asks
you to comment with the relevant
quoting, so may I ask you to please
do the same. :)

> And in most of the test scenarios, this program runs only once and
> there is no semaphore left behind, unless debugging this program
> itself.

Indeed, so the problem was noticed by
me when debugging, rather than by
someone else who only runs it.

> So I don't  think there are any race conditions being opened up.
I don't think it is a good idea to have a
race conditions for those who can press
^c during tests, even if otherwise the
problem is unobservable.
With my patch the recovery after ^c
works reliably.

But much more importantly the
"Wait initialization complete."
loop didn't work, and now it does.
That is a primary reason of the patch.
The sem rm fix is just for debugging.
