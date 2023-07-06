Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7168EB64DC
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jul 2023 08:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGFIys (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jul 2023 04:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGFIyr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jul 2023 04:54:47 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F81BCC
        for <fstests@vger.kernel.org>; Thu,  6 Jul 2023 01:54:33 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3faf:0:640:537b:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 4943C5F53E;
        Thu,  6 Jul 2023 11:54:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PsPDJsBDYeA0-aBIuNbPo;
        Thu, 06 Jul 2023 11:54:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688633667;
        bh=bRJubmW6h7NXIb32gqJDxLlmO4Z2TX4UGOV9yNFDfvo=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=pA852bCWDvlXIFD+sFZKSnlKiBhwRNwXg4m5RsQFftBPQHBYCkVlSVkHFhDz6t05J
         YI8H3a+lG/5PMHidvWkLO+NbvCDwI/095PpnQTkLTXVq3LPHkZAmcN3BbH2hC6kidM
         TOsRyzcNwkdvwJPMG0WDRl06lNRfJremRNiZ0ZUU=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <332cedf4-3580-86f8-3fd6-de32b67f155e@yandex.ru>
Date:   Thu, 6 Jul 2023 13:54:24 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] t_ofd_locks: fix initialization sequence
Content-Language: en-US
To:     Murphy Zhou <xzhou@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org
References: <20230630094051.3765376-1-stsp2@yandex.ru>
 <6ee5c9ee42388d2a2e25bf80b3d7db9c09384867.camel@kernel.org>
 <CALWRkkjb9hMmoHf3xa93mAEJBFM3hjB5K4dkWL+659dSGa0qsA@mail.gmail.com>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <CALWRkkjb9hMmoHf3xa93mAEJBFM3hjB5K4dkWL+659dSGa0qsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


06.07.2023 13:41, Murphy Zhou пишет:
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> ---
>   src/t_ofd_locks.c | 73 ++++++++++++++++++++++++++++++-----------------
>   1 file changed, 47 insertions(+), 26 deletions(-)
>
> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> index e77f2659..daa6f96c 100644
> --- a/src/t_ofd_locks.c
> +++ b/src/t_ofd_locks.c
> @@ -297,6 +297,7 @@ int main(int argc, char **argv)
>                        semid = semget(semkey, 2, IPC_CREAT|IPC_EXCL);
>                        if (semid < 0 && errno == EEXIST) {
>                                /* remove sem set after one round of test */
> +                             semid = semget(semkey, 2, IPC_CREAT);
>                                if (semctl(semid, 2, IPC_RMID, semu) == -1)
> Good catch. This RMID is useless unless we have got the existing
> semaphore. According to SEMGET(2), seems should be:
>
>      semid = semget(semkey, 2, 0);
>
> to obtain an existing semaphore?

Yes, I just wanted to avoid the purely
theoretical condition when someone
else removed this sem right before we
did second semget(). So I added IPC_CREAT
just as a safety measure.
Should I remove it?

> The while loop makes sure we get the semaphore before continuing
> the test. It's been some time, I'm not sure but now I really can't see
> this really hurts.
What while loop do you mean and what
doesn't hurt? Does the rest of the patch
look ok?
