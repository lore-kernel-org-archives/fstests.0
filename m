Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96656C77B7D
	for <linux-fstests@archiver.kernel.org>; Wed, 17 May 2023 06:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEQGg1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 May 2023 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEQGg0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2023 02:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118A23ABC
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684305338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jnNU98J7jhyyjeLK82jkgXNRtk0jnoROrIVR9ObpQMo=;
        b=h8lcGHC9K+nGjuXTpaxU89hV8s97lwsp3og/WfiNvjx4HLQb6cm4+7xUCJq6HW9tyM6Kvp
        Yvg0VYoK1hpO7NnCQAabsnxZXadit5SKMtluZoQX3od8AKWgpl6b5RzpFFOy0IqAG/ZC4a
        W1FPmfqx7OqAIRT+y+BPwv7OI2Wd0Js=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-2a34RXynPyaF0nJ-h4FLrg-1; Wed, 17 May 2023 02:35:36 -0400
X-MC-Unique: 2a34RXynPyaF0nJ-h4FLrg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-306286b3573so234444f8f.2
        for <fstests@vger.kernel.org>; Tue, 16 May 2023 23:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684305335; x=1686897335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnNU98J7jhyyjeLK82jkgXNRtk0jnoROrIVR9ObpQMo=;
        b=IL7Hvv+z8hluhRjoW3lkWWtg0GztOdfTFSer0NQi+vTGtaPuYH1/Q0zkkqWXWn1tqP
         5huYGkmlNRJxjMn/87k+UJySxFIujL6nJuR30gacqhBYDqIAwHxzpPfXAKup4/zBPzgF
         i6NOwgG3dPBz1uY5Q/ULxn3dXRWuagLBa/oawB/qRt7Mz/+N/ps59IdatUlGGkSkFsvG
         ugxmPrcDmc+upLyAVxttFdxucAu7zycNAoYA30eJiLKw8gSowMGbX38mSTZXdMhJd682
         D87K5Md/XCsuNdpH2EY2aKfaXNS4gSDY8B86X3bjUPRY31YutejpINJZpqDWfVy8mS7q
         ApLQ==
X-Gm-Message-State: AC+VfDzB4pZPPCgPBIS6irIutXIm2T+hNuLpT7X76KYLP67V0XSiGCk+
        nAImXMEE1WM7MFycBlWKSG6Evq0XTUJ71rsG7qNSKvf4kCA3L+V+xPgtM0yW39lTWHyVk43/M6F
        klSTdc3B3YXsiIPDsJA0uV8n93Cjn0WgbGLgRG4nQVfHz
X-Received: by 2002:adf:de8d:0:b0:306:2e04:5925 with SMTP id w13-20020adfde8d000000b003062e045925mr33358938wrl.17.1684305335531;
        Tue, 16 May 2023 23:35:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4y5ECQCEfeQ1tW9y5MjeWQiEAJlG3dUdorG1DYHf4eDWHP8NvDSOiIwz2rFiSKgNMVBAkV6zazSBUmD1i6mX4=
X-Received: by 2002:adf:de8d:0:b0:306:2e04:5925 with SMTP id
 w13-20020adfde8d000000b003062e045925mr33358924wrl.17.1684305335205; Tue, 16
 May 2023 23:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230516081935.2208793-1-jencce.kernel@gmail.com> <20230517012810.ygctwrbrms4cnyt4@zlang-mailbox>
In-Reply-To: <20230517012810.ygctwrbrms4cnyt4@zlang-mailbox>
From:   Murphy Zhou <xzhou@redhat.com>
Date:   Wed, 17 May 2023 14:35:23 +0800
Message-ID: <CALWRkkhCuL4sRHaBqkOtFmpdZmD8BqzHESoBSO=Xcw-=vaRa5g@mail.gmail.com>
Subject: Re: [PATCH] common/{filter,quota}, xfs/1{06,52}: fix grep pattern
To:     Zorro Lang <zlang@redhat.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 17, 2023 at 9:30=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Tue, May 16, 2023 at 04:19:35PM +0800, Murphy Zhou wrote:
> > Newer(3.9) grep is complaining about these unnecessary
> > backslashes before # and -, and breaking the golden output.
>
> Better to show what kind of warning output breaks the golden image
> at here.
>
> >
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  common/filter | 2 +-
> >  common/quota  | 2 +-
> >  tests/xfs/106 | 4 ++--
> >  tests/xfs/152 | 4 ++--
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/common/filter b/common/filter
> > index 3e3fea7e..f10ba78a 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -293,7 +293,7 @@ _filter_project_quota()
> >       # until the GETNEXTQUOTA ioctl came into use.  Filter it out.
> >       # But if you specify a name for ID 0, that means you want to
> >       # deal with it by yourself, this function won't filter it out.
> > -     _filter_quota | grep -v "^\#0 \|^(null) "
> > +     _filter_quota | grep -v "^#0 \|^(null) "
> >  }
> >
> >  # Account for different "ln" failure messages
> > diff --git a/common/quota b/common/quota
> > index 96b8d044..0a526e07 100644
> > --- a/common/quota
> > +++ b/common/quota
> > @@ -191,7 +191,7 @@ _scratch_enable_pquota()
> >  _require_setquota_project()
> >  {
> >       setquota --help 2>&1 | \
> > -             grep -q "\-P, \-\-project[[:space:]]*set limits for proje=
ct"
> > +             grep -q "\-P, \--project[[:space:]]*set limits for projec=
t"
>
> I think this change isn't enough, might still trigger the "grep: warning:
> stray \ before -" warning. Better to change this line as:

In my test, it works well. No more warnings.

Thanks,
>
>   grep -q -- "-P, --project[[:space:]]*set limits for project"
>
> Please confirm if it helps.
>
> Thanks,
> Zorro
>
> >       if [ "$?" -ne 0 ];then
> >               _notrun "setquota doesn't support project quota (-P)"
> >       fi
> > diff --git a/tests/xfs/106 b/tests/xfs/106
> > index fc2281af..388873bd 100755
> > --- a/tests/xfs/106
> > +++ b/tests/xfs/106
> > @@ -59,13 +59,13 @@ clean_files()
> >
> >  filter_quot()
> >  {
> > -     _filter_quota | grep -v "root \|\#0 " \
> > +     _filter_quota | grep -v "root \|#0 " \
> >               | sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
> >  }
> >
> >  filter_report()
> >  {
> > -     _filter_quota | grep -v "^root \|^\#0 " \
> > +     _filter_quota | grep -v "^root \|^#0 " \
> >               | sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
> >  }
> >
> > diff --git a/tests/xfs/152 b/tests/xfs/152
> > index dd33801d..325a05c1 100755
> > --- a/tests/xfs/152
> > +++ b/tests/xfs/152
> > @@ -98,13 +98,13 @@ clean_files()
> >
> >  filter_quot()
> >  {
> > -     _filter_quota | grep -v "root \|\#0 " \
> > +     _filter_quota | grep -v "root \|#0 " \
> >               | sed -e '/#[0-9]*/s/#[0-9]*/#ID/g'
> >  }
> >
> >  filter_report()
> >  {
> > -     _filter_quota | grep -v "^root \|^\#0 " \
> > +     _filter_quota | grep -v "^root \|^#0 " \
> >               | sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
> >  }
> >
> > --
> > 2.31.1
> >
>

