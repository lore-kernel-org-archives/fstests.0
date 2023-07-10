Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC684C0015E
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Jul 2023 04:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGJE2O (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Jul 2023 00:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGJE2N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Jul 2023 00:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4888D100
        for <fstests@vger.kernel.org>; Sun,  9 Jul 2023 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688963245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lScVoSCu+0u+URyjq2zS3kS26M5L1GKkFDbZj92e0w=;
        b=ifmXk7NDjRNPToeILP2ioXwLvRrQ2+bHVSsnlCf4IQZ7+euuPOtw7QijzJjeDCCRkRVwwK
        93NF9vXT8gp6oYMzH90VuMC6isauoJ25KLMfq5d551oHGfD2VvkLy5d1zUgfuY/E+FxvJu
        iF7MEkOAWs3XiKb7P4g/V3uIbInBxlU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-7OZ9_NVDMC2xqd0le-Dezw-1; Mon, 10 Jul 2023 00:27:23 -0400
X-MC-Unique: 7OZ9_NVDMC2xqd0le-Dezw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3141325af78so2434645f8f.3
        for <fstests@vger.kernel.org>; Sun, 09 Jul 2023 21:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688963242; x=1691555242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lScVoSCu+0u+URyjq2zS3kS26M5L1GKkFDbZj92e0w=;
        b=JgWEfW6Nu0Q+LUmlo3CgqJDJGuN0rkVaNvSepScT5FnNgxSxonQW72OBEvtwQrffgf
         5GHxijB0wgSunhwrIhEyyfZOXV/TdDc/Y4TB8hWk+0niGBKe+rqGMnmZ8iMK2mbPZm1P
         YDauHPeNr6Qo3vWqyuV/C1LYeByz1Xwjx3G6gV7Q7otlee65aMRxYKzCnhkerzGEbEQC
         YJGujp4BbHY/tAO7CA7iVmZgW2tCTArT4Y+TQvOsMMWuKXgzSEojebYkKNxUDRuC0Gzn
         nPlFFUvqLly8ZibZ1iS0z7DUHrWZbd8k68FohuYKy9rHsLgDdaWFhDbe58OgUGETqXrw
         y5BQ==
X-Gm-Message-State: ABy/qLZUYWzWpz8Atgm1h34j8CQVBtqrZW0J2zoz4QDrZlODesYCPUwZ
        fe4CPPpegZpEEJy5LnSXVlxnogE7jCkGtBbrJ11n0poyz+BPKUVqJMHGaeIC+y3UryqybrAyj1E
        7MdjNc9xSmUYcM/2v+hFxgGxHqOsjZJFbWTQJWNmMyejt0Jc=
X-Received: by 2002:a05:6000:545:b0:314:3344:72f6 with SMTP id b5-20020a056000054500b00314334472f6mr10076210wrf.32.1688963242281;
        Sun, 09 Jul 2023 21:27:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHs+V0SoUzcVwJHTALSLL8KtZ9WLbpyHK/RSV8edzxTRlJQYaSI3QOv8LF1gWw3T0zfyOQv4pisWCsPeVPBl3A=
X-Received: by 2002:a05:6000:545:b0:314:3344:72f6 with SMTP id
 b5-20020a056000054500b00314334472f6mr10076193wrf.32.1688963241983; Sun, 09
 Jul 2023 21:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230630094051.3765376-1-stsp2@yandex.ru> <6ee5c9ee42388d2a2e25bf80b3d7db9c09384867.camel@kernel.org>
 <CALWRkkjb9hMmoHf3xa93mAEJBFM3hjB5K4dkWL+659dSGa0qsA@mail.gmail.com> <332cedf4-3580-86f8-3fd6-de32b67f155e@yandex.ru>
In-Reply-To: <332cedf4-3580-86f8-3fd6-de32b67f155e@yandex.ru>
From:   Murphy Zhou <xzhou@redhat.com>
Date:   Mon, 10 Jul 2023 12:27:10 +0800
Message-ID: <CALWRkkhmj7rJf8Xhe1Oo_5h4XByoD+U6SEoKHFC1S0ejYPu4cw@mail.gmail.com>
Subject: Re: [PATCH] t_ofd_locks: fix initialization sequence
To:     stsp <stsp2@yandex.ru>
Cc:     Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

Sorry for the late reply.

On Thu, Jul 6, 2023 at 4:54=E2=80=AFPM stsp <stsp2@yandex.ru> wrote:
>
>
> 06.07.2023 13:41, Murphy Zhou =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> > ---
> >   src/t_ofd_locks.c | 73 ++++++++++++++++++++++++++++++----------------=
-
> >   1 file changed, 47 insertions(+), 26 deletions(-)
> >
> > diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> > index e77f2659..daa6f96c 100644
> > --- a/src/t_ofd_locks.c
> > +++ b/src/t_ofd_locks.c
> > @@ -297,6 +297,7 @@ int main(int argc, char **argv)
> >                        semid =3D semget(semkey, 2, IPC_CREAT|IPC_EXCL);
> >                        if (semid < 0 && errno =3D=3D EEXIST) {
> >                                /* remove sem set after one round of tes=
t */
> > +                             semid =3D semget(semkey, 2, IPC_CREAT);
> >                                if (semctl(semid, 2, IPC_RMID, semu) =3D=
=3D -1)
> > Good catch. This RMID is useless unless we have got the existing
> > semaphore. According to SEMGET(2), seems should be:
> >
> >      semid =3D semget(semkey, 2, 0);
> >
> > to obtain an existing semaphore?
>
> Yes, I just wanted to avoid the purely
> theoretical condition when someone
> else removed this sem right before we
> did second semget(). So I added IPC_CREAT
> just as a safety measure.
> Should I remove it?
>
> > The while loop makes sure we get the semaphore before continuing
> > the test. It's been some time, I'm not sure but now I really can't see
> > this really hurts.
> What while loop do you mean and what
> doesn't hurt? Does the rest of the patch
> look ok?

I mean the do-while loop ensures a new semaphore is created.

And in most of the test scenarios, this program runs only once and
there is no semaphore left behind, unless debugging this program
itself.

So I don't  think there are any race conditions being opened up.

Much appreciated!

Thanks,
Murphy

