Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7579C77B7A
	for <linux-fstests@archiver.kernel.org>; Wed, 17 May 2023 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjEQIUn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 May 2023 04:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjEQIUm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2023 04:20:42 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3991FEB
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 01:20:38 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-561d5a16be0so2053277b3.2
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684311637; x=1686903637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiOjbLM9d07+ClKaS6A9wkQtqVbQxawd69rjjmZqzBc=;
        b=jJyPkHIBFtsLh8MR8g8GqnwoOamqWQv4pl4Kkt6JE2dGesRSQQxINlep0cTr86f3FI
         DgvaO6snnZd7vRvIxoL1LyZk346/MG+4fswcv5YyKPQRk6QhqQ653vFf9EXEI7l5inkM
         b5+zXrapXJRmVqV92GLtCRBWA1CPiq0oslqW3lMfeXEClVLQEQIOUzOEzkTJWSAgQJi9
         fcSecctZQe0rSUKRF3zyVZR8zAdE7eEY9Tz/vmSlzbtBItv/p0xpMLGSXkw9gjIChXwG
         4a7tVV7yRp6BuWUhEItFsnJfZqa36I+tNiszBpJU2kmUdpEaLqpOE3ay2Dqfoxio8c0U
         vaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684311637; x=1686903637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiOjbLM9d07+ClKaS6A9wkQtqVbQxawd69rjjmZqzBc=;
        b=WQ963Pwo8OIK+YVeaVxfEBOd+Y0UXIM71dP37hN28Lfv+aa/l4k7c5FjmAHcAXPLp+
         OULRWaKTaivMLVrWp3W6aItYV11WKWupZMbpZUCArOy9apMsVEHFj55f6qFZ2YRNHkWy
         bRQWUXDaciFzc9IMHIbn09AKR3ff3/7X0ww4BJrN/s9KYcscNPz4/QqfXiF7r7LYOLrm
         W2qEmIK3h5hadMD92eUOli0LCFfv1K5F8PX4h3fdirLiW30OqtO9q9y1/OiOgwaZBKgX
         QkzlhX3VXbbcl3dmfLca2u5qQlOrbwlXC2rBOIqPZKyfJSSz7CR95AzffCZcX6qo2m4X
         QIhw==
X-Gm-Message-State: AC+VfDzQNiIexR7jHyO676kAt4bGW36KNOFGxo7o97PdnQ/5nZ2bSngk
        HZg7bA7QTqD8olcxzXSPgRMYp352i1eC+oK/RRtXIO46Hqg=
X-Google-Smtp-Source: ACHHUZ6EIXeWsbDGxouAHbs0Min9mHJWHHbr18bYDSKJo+NWKM5i6D5OiPbYmbC3wWN24Axl9Y47mM2XcxvUT16CkMI=
X-Received: by 2002:a0d:f545:0:b0:55a:ab98:a2ef with SMTP id
 e66-20020a0df545000000b0055aab98a2efmr37053990ywf.40.1684311637628; Wed, 17
 May 2023 01:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230516081935.2208793-1-jencce.kernel@gmail.com>
 <20230517012810.ygctwrbrms4cnyt4@zlang-mailbox> <CALWRkkhCuL4sRHaBqkOtFmpdZmD8BqzHESoBSO=Xcw-=vaRa5g@mail.gmail.com>
In-Reply-To: <CALWRkkhCuL4sRHaBqkOtFmpdZmD8BqzHESoBSO=Xcw-=vaRa5g@mail.gmail.com>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Wed, 17 May 2023 16:20:26 +0800
Message-ID: <CADJHv_ugWT=a3UgVX1jW9xVTgRrHe3AjcPi2M+-u+OOcbJYOrg@mail.gmail.com>
Subject: Re: [PATCH] common/{filter,quota}, xfs/1{06,52}: fix grep pattern
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Oops, wrong email used. Sorry for the noise.

On Wed, May 17, 2023 at 2:35=E2=80=AFPM Murphy Zhou <xzhou@redhat.com> wrot=
e:
>
> On Wed, May 17, 2023 at 9:30=E2=80=AFAM Zorro Lang <zlang@redhat.com> wro=
te:
> >
> > On Tue, May 16, 2023 at 04:19:35PM +0800, Murphy Zhou wrote:
> > > Newer(3.9) grep is complaining about these unnecessary
> > > backslashes before # and -, and breaking the golden output.
> >
> > Better to show what kind of warning output breaks the golden image
> > at here.
> >
> > >
> > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > ---
> > >  common/filter | 2 +-
> > >  common/quota  | 2 +-
> > >  tests/xfs/106 | 4 ++--
> > >  tests/xfs/152 | 4 ++--
> > >  4 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/common/filter b/common/filter
> > > index 3e3fea7e..f10ba78a 100644
> > > --- a/common/filter
> > > +++ b/common/filter
> > > @@ -293,7 +293,7 @@ _filter_project_quota()
> > >       # until the GETNEXTQUOTA ioctl came into use.  Filter it out.
> > >       # But if you specify a name for ID 0, that means you want to
> > >       # deal with it by yourself, this function won't filter it out.
> > > -     _filter_quota | grep -v "^\#0 \|^(null) "
> > > +     _filter_quota | grep -v "^#0 \|^(null) "
> > >  }
> > >
> > >  # Account for different "ln" failure messages
> > > diff --git a/common/quota b/common/quota
> > > index 96b8d044..0a526e07 100644
> > > --- a/common/quota
> > > +++ b/common/quota
> > > @@ -191,7 +191,7 @@ _scratch_enable_pquota()
> > >  _require_setquota_project()
> > >  {
> > >       setquota --help 2>&1 | \
> > > -             grep -q "\-P, \-\-project[[:space:]]*set limits for pro=
ject"
> > > +             grep -q "\-P, \--project[[:space:]]*set limits for proj=
ect"
> >
> > I think this change isn't enough, might still trigger the "grep: warnin=
g:
> > stray \ before -" warning. Better to change this line as:
>
> In my test, it works well. No more warnings.
>
> Thanks,
> >
> >   grep -q -- "-P, --project[[:space:]]*set limits for project"
> >
> > Please confirm if it helps.
> >
> > Thanks,
> > Zorro
> >
> > >       if [ "$?" -ne 0 ];then
> > >               _notrun "setquota doesn't support project quota (-P)"
> > >       fi
> > > diff --git a/tests/xfs/106 b/tests/xfs/106
> > > index fc2281af..388873bd 100755
> > > --- a/tests/xfs/106
> > > +++ b/tests/xfs/106
> > > @@ -59,13 +59,13 @@ clean_files()
> > >
> > >  filter_quot()
> > >  {
> > > -     _filter_quota | grep -v "root \|\#0 " \
> > > +     _filter_quota | grep -v "root \|#0 " \
> > >               | sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
> > >  }
> > >
> > >  filter_report()
> > >  {
> > > -     _filter_quota | grep -v "^root \|^\#0 " \
> > > +     _filter_quota | grep -v "^root \|^#0 " \
> > >               | sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
> > >  }
> > >
> > > diff --git a/tests/xfs/152 b/tests/xfs/152
> > > index dd33801d..325a05c1 100755
> > > --- a/tests/xfs/152
> > > +++ b/tests/xfs/152
> > > @@ -98,13 +98,13 @@ clean_files()
> > >
> > >  filter_quot()
> > >  {
> > > -     _filter_quota | grep -v "root \|\#0 " \
> > > +     _filter_quota | grep -v "root \|#0 " \
> > >               | sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
> > >  }
> > >
> > >  filter_report()
> > >  {
> > > -     _filter_quota | grep -v "^root \|^\#0 " \
> > > +     _filter_quota | grep -v "^root \|^#0 " \
> > >               | sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
> > >  }
> > >
> > > --
> > > 2.31.1
> > >
> >
>
