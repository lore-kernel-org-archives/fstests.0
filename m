Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8361FEB64D9
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jul 2023 08:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjGFImE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jul 2023 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFImE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jul 2023 04:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7621BC3
        for <fstests@vger.kernel.org>; Thu,  6 Jul 2023 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688632876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4F0CwRPlKD3vOill8qtxLgGHI31zLv+Fx6FWL5hHOw=;
        b=i26Y1WwF7zgco4jq1J/LfmQwFYuyfTwkA5rgBZnT0xxjmZjf1SC03rQJc7UTVu5m2vYUMA
        UHibioq0FSzXxbERzqv3DyFoVxI9gVrPgmTGGgQu54C9OhyY0Rt9syapHTMqNJgBKlLrrg
        bD31lcg/i4CmPg48xKNTqOpZBRq54GY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-0XY8VYYfPtqqdnvbPEkuDQ-1; Thu, 06 Jul 2023 04:41:14 -0400
X-MC-Unique: 0XY8VYYfPtqqdnvbPEkuDQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbaade0c71so2592535e9.2
        for <fstests@vger.kernel.org>; Thu, 06 Jul 2023 01:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688632873; x=1691224873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4F0CwRPlKD3vOill8qtxLgGHI31zLv+Fx6FWL5hHOw=;
        b=YG3uIs25e5nizjDaEoelTeAaLCxkhkfyQpT0/nhyOQiYbyrXrd5N46b3MVmWOD4SdY
         D/0NA9+A2bUwj7YD4E3hYc9jULQFzWkhjfFFaZE/4Mdiz7THPIqztzwUZw2poOEKWpqT
         16rSrJrEfVwinab0HIaYOLEqyWst8OraG4PKX0XbeRiAdieg1FaQMY7jWwVJhcwEfZz7
         7M84slsrh/dS3fHzPLoL9mSDcLboJI2qFb0tp86v4e0i7LMLkiMtFQa1D+0jb5b3q2H9
         U6e7WyYIATXQtKfDIYFJ3AmM1oR6rxzawvAJ5a3+jpHykHgzDozH4mO+Ill1rNYDRaak
         wMLg==
X-Gm-Message-State: ABy/qLZQGw8N2jdj53JJEhi0H0MIiMtdbtCRT6bo9Aq68ih1rB2w80Ul
        voayjHkNwBg7X25wtlOVk6wYvsrT672aw/QWeni1VtgdRHKCMNtXJjSr0cOBaSUzmQijzqJjBfI
        kbPPGdaCESBIDFhc3KiLuNA+MzveSjfD1HQ==
X-Received: by 2002:a05:600c:2252:b0:3fb:c9f4:14f3 with SMTP id a18-20020a05600c225200b003fbc9f414f3mr833273wmm.2.1688632873393;
        Thu, 06 Jul 2023 01:41:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlESt4uKoNA4j4nsmk3bQF0I4wE91RXv3trdxrtYD+/i4WwPU/yZRxo+XSaCcoeEvExEIAsR5+p3W6GhsYxS3FM=
X-Received: by 2002:a05:600c:2252:b0:3fb:c9f4:14f3 with SMTP id
 a18-20020a05600c225200b003fbc9f414f3mr833262wmm.2.1688632873087; Thu, 06 Jul
 2023 01:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230630094051.3765376-1-stsp2@yandex.ru> <6ee5c9ee42388d2a2e25bf80b3d7db9c09384867.camel@kernel.org>
In-Reply-To: <6ee5c9ee42388d2a2e25bf80b3d7db9c09384867.camel@kernel.org>
From:   Murphy Zhou <xzhou@redhat.com>
Date:   Thu, 6 Jul 2023 16:41:01 +0800
Message-ID: <CALWRkkjb9hMmoHf3xa93mAEJBFM3hjB5K4dkWL+659dSGa0qsA@mail.gmail.com>
Subject: Re: [PATCH] t_ofd_locks: fix initialization sequence
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Stas Sergeev <stsp2@yandex.ru>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

Thanks Jeff!

On Wed, Jul 5, 2023 at 8:34=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Fri, 2023-06-30 at 14:40 +0500, Stas Sergeev wrote:
> > Currently IPC_RMID was attempted on a semid returned after failed
> > semget() with flags=3DIPC_CREAT|IPC_EXCL. So nothing was actually remov=
ed.
> > To get a proper semid, this patch retries semget() without IPC_EXCL.
> >
>
> Nice catch.
>
> > This opens up a race: if the lock-tester grabbed the old sem before
> > lock-setter used that magic to remove it, then the lock-tester will
> > remain with removed sem.
> >
> > Additionally locker was waiting for sem_otime on sem0 to became
> > non-zero after incrementing sem0 himself. So sem_otime was never
> > 0 at the time of checking it.
> >
> > So basically the code was all wrong.
> > This patch:
> > - fixes RMID after IPC_EXCL to actually remove the sem
> > - moves the increment of sem1 to the lock-tester site, and the
> >   lock-setter waits for that event
> > - replaces the wait loop on sem_otime with GETVAL, adding a small sleep=
.
> > - lock-tester during the init sequence checks for removed sem, and
> >   if it is - retries the init from semget()
> >
> > Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> > ---
> >  src/t_ofd_locks.c | 73 ++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 47 insertions(+), 26 deletions(-)
> >
> > diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> > index e77f2659..daa6f96c 100644
> > --- a/src/t_ofd_locks.c
> > +++ b/src/t_ofd_locks.c
> > @@ -297,6 +297,7 @@ int main(int argc, char **argv)
> >                       semid =3D semget(semkey, 2, IPC_CREAT|IPC_EXCL);
> >                       if (semid < 0 && errno =3D=3D EEXIST) {
> >                               /* remove sem set after one round of test=
 */
> > +                             semid =3D semget(semkey, 2, IPC_CREAT);
> >                               if (semctl(semid, 2, IPC_RMID, semu) =3D=
=3D -1)

Good catch. This RMID is useless unless we have got the existing
semaphore. According to SEMGET(2), seems should be:

    semid =3D semget(semkey, 2, 0);

to obtain an existing semaphore?

The while loop makes sure we get the semaphore before continuing
the test. It's been some time, I'm not sure but now I really can't see
this really hurts.

Thanks,
Murphy



> >                                       err_exit("rmid 0", errno);
> >                               retry++;
> > @@ -315,32 +316,29 @@ int main(int argc, char **argv)
> >               semu.array =3D vals;
> >               if (semctl(semid, 2, SETALL, semu) =3D=3D -1)
> >                       err_exit("init sem", errno);
> > -             /* Inc both new sem to 2 */
> > -             sop.sem_num =3D 0;
> > -             sop.sem_op =3D 1;
> > -             sop.sem_flg =3D 0;
> > -             ts.tv_sec =3D 5;
> > -             ts.tv_nsec =3D 0;
> > -             if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> > -                     err_exit("inc sem0 2", errno);
> > -             sop.sem_num =3D 1;
> > -             sop.sem_op =3D 1;
> > -             sop.sem_flg =3D 0;
> > -             ts.tv_sec =3D 5;
> > -             ts.tv_nsec =3D 0;
> > -             if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> > -                     err_exit("inc sem1 2", errno);
> >
> >               /*
> > -              * Wait initialization complete. semctl(2) only update
> > -              * sem_ctime, semop(2) will update sem_otime.
> > +              * Wait initialization complete.
> >                */
> >               ret =3D -1;
> >               do {
> > +                     if (ret !=3D -1)
> > +                             usleep(100000);
> >                       memset(&sem_ds, 0, sizeof(sem_ds));
> >                       semu.buf =3D &sem_ds;
> > -                     ret =3D semctl(semid, 0, IPC_STAT, semu);
> > -             } while (!(ret =3D=3D 0 && sem_ds.sem_otime !=3D 0));
> > +                     ret =3D semctl(semid, 1, GETVAL, semu);
> > +                     if (ret =3D=3D -1)
> > +                             err_exit("wait sem1 2", errno);
> > +             } while (ret !=3D 2);
> > +
> > +             /* Inc sem0 to 2 */
> > +             sop.sem_num =3D 0;
> > +             sop.sem_op =3D 1;
> > +             sop.sem_flg =3D 0;
> > +             ts.tv_sec =3D 5;
> > +             ts.tv_nsec =3D 0;
> > +             if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> > +                     err_exit("inc sem0 2", errno);
> >
> >               /* place the lock */
> >               if (fcntl(fd, setlk_macro, &flk) < 0)
> > @@ -393,10 +391,26 @@ int main(int argc, char **argv)
> >       /* getlck */
> >       if (lock_cmd =3D=3D 0) {
> >               /* wait sem created and initialized */
> > +again:
> >               retry =3D 5;
> >               do {
> >                       semid =3D semget(semkey, 2, 0);
> > -                     if (semid !=3D -1)
> > +                     ret =3D -1;
> > +                     if (semid !=3D -1) do {
> > +                             if (ret !=3D -1)
> > +                                     usleep(100000);
> > +                             memset(&sem_ds, 0, sizeof(sem_ds));
> > +                             semu.buf =3D &sem_ds;
> > +                             ret =3D semctl(semid, 0, GETVAL, semu);
> > +                             if (ret =3D=3D -1 && (errno =3D=3D EINVAL
> > +                                            || errno =3D=3D EIDRM)) {
> > +                                     /* sem removed */
> > +                                     goto again;
> > +                             }
> > +                             if (ret =3D=3D -1)
> > +                                     break;
> > +                     } while (ret !=3D 1);
> > +                     if (ret =3D=3D 1)
> >                               break;
> >                       if (errno =3D=3D ENOENT && retry) {
> >                               sleep(1);
> > @@ -406,11 +420,15 @@ int main(int argc, char **argv)
> >                               err_exit("getlk_semget", errno);
> >                       }
> >               } while (1);
> > -             do {
> > -                     memset(&sem_ds, 0, sizeof(sem_ds));
> > -                     semu.buf =3D &sem_ds;
> > -                     ret =3D semctl(semid, 0, IPC_STAT, semu);
> > -             } while (!(ret =3D=3D 0 && sem_ds.sem_otime !=3D 0));
> > +
> > +             /* inc sem1 to 2 (initialization completed) */
> > +             sop.sem_num =3D 1;
> > +             sop.sem_op =3D 1;
> > +             sop.sem_flg =3D 0;
> > +             ts.tv_sec =3D 5;
> > +             ts.tv_nsec =3D 0;
> > +             if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> > +                     err_exit("inc sem1 2", errno);
> >
> >               /* wait sem0 =3D=3D 0 (setlk and close fd done) */
> >               sop.sem_num =3D 0;
> > @@ -418,8 +436,11 @@ int main(int argc, char **argv)
> >               sop.sem_flg =3D 0;
> >               ts.tv_sec =3D 5;
> >               ts.tv_nsec =3D 0;
> > -             if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
> > +             if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1) {
> > +                     if (errno =3D=3D EIDRM || errno =3D=3D EINVAL)
> > +                             goto again;
> >                       err_exit("wait sem0 0", errno);
> > +             }
> >
> >               if (fcntl(fd, getlk_macro, &flk) < 0)
> >                       err_exit("getlk", errno);
>
> (cc'ing Murphy)
>
> The patch looks reasonable to me at first glance, though I confess I'm
> no expert in semaphore handling.
>
> Acked-by: Jeff Layton <jlayton@kernel.org>
>

