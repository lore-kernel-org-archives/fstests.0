Return-Path: <SRS0=y1X6=7S=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB7C433DF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 03:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2692053B
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 03:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmO4P4Xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgFEDF4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDFz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Jun 2020 23:05:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CDDC08C5C0
        for <fstests@vger.kernel.org>; Thu,  4 Jun 2020 20:05:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f7so8417363ejq.6
        for <fstests@vger.kernel.org>; Thu, 04 Jun 2020 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FAxBvbwdUnKBeS+PvZnQ40NmbbnExYWu59mhc7Dv/Ug=;
        b=LmO4P4XuZ9DEOFTnKjzKWQEsZvUjSC22syUx6JC02w61nrleH+RNTzDbG3FTEPLi7N
         ZmexKglQLMFU+h2IW4kSVOxycFVPbalmvupJyl+KeSXf4tunqg577/AysxPa/fynFPEs
         yKBusdh/ei6lGkq5gzGXu2gICBk6IykIctZMnnC+afozIrPCBa8JPv4bQCLUF1qgu7eQ
         nEYDgAMu1pw0F/LhpyJ/2MKWC2jhH/4JgNZ4LQMAu8n0RNRRTC7n72d+v3/00pLajGCR
         Noe+Wst/bR/ht2/39SDiuARhJK9rGVLmVuTKPqz1kqiB82JvkARkl1BzVckDmqG1MKG3
         m5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FAxBvbwdUnKBeS+PvZnQ40NmbbnExYWu59mhc7Dv/Ug=;
        b=sch2zuXzM+njs194L2q2UrrqoQJKRecIP9Z2kZiqwJM6m87fRL9TW/dl+RUO3SRWMv
         NJR7DH0vJdRTeDO4uwqZuY9Rocn49L1KhDcjmpzMP9W/J4aWQuqfiVoXya9Trqpqrq1C
         v+V2Py0ibA/OqhThlqKrLU+fSSfiPCtC/puDWXhN1+N4cqMc1TK9MlNWQeRZkOnUyeC6
         FNAQPXpGXiUmQ2QQ291W+FJzqj57qZWgP7YYa9CpxsUwRjRTWMBsUY+WBeDewcbH9LSw
         zFU4qx9Gra7s8Bs92qWbzsmsi/HWlU3neZ/hynbkPitK27C2a3RSeIJmtasHJqh5xgD3
         vUig==
X-Gm-Message-State: AOAM532ql+lDwGb76kAZ1eJXBaXKUorCS9I2ls1js8hzHQtiJzbfATrd
        dTKI6MGIVz5kzUMkqXZSAjaNDCByxcT9kIMyFYs=
X-Google-Smtp-Source: ABdhPJxrGoSXcibycEfR9KHiMkNKzjL87Tcoe0ZhsRjk2Jk6t0Drm1jmZ7ROVfNRQrXfirhNRmuqLO8MNfT//8JKB2U=
X-Received: by 2002:a17:906:594e:: with SMTP id g14mr6751344ejr.52.1591326353096;
 Thu, 04 Jun 2020 20:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200604095727.21720-1-yosun@suse.com> <b36809c8-d695-d764-6bf9-b01d84fb6f8d@sandeen.net>
In-Reply-To: <b36809c8-d695-d764-6bf9-b01d84fb6f8d@sandeen.net>
From:   Sun Yong <sunyong0511@gmail.com>
Date:   Fri, 5 Jun 2020 11:05:40 +0800
Message-ID: <CAAPJbvrgvChvYq+nhPJ3rVJ_JU7jMBK27Fwx1ezUkKPhC+3-yw@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: modify user name beginning with non-digit
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fstests@vger.kernel.org, Yong Sun <yosun@suse.com>,
        Petr Vorel <pvorel@suse.cz>, Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Eric Sandeen <sandeen@sandeen.net> =E4=BA=8E2020=E5=B9=B46=E6=9C=884=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On 6/4/20 4:57 AM, Yong Sun wrote:
> > openSUSE and SLE don't support username begin with digit, so it will
> > skip test generic/597 and generic/598 by lack of 123456-fsgqa user.
> > generic/597 and 598 are not test username begin with digit on purpose
> > (different with generic/381). It's will be helpful to use an username
> > begin with non-digit in this case.
> >
> > Signed-off-by: Sun Yong <yosun@suse.com>
> > ---
> >  README            | 1 +
> >  tests/generic/597 | 7 ++-----
> >  tests/generic/598 | 7 ++-----
> >  3 files changed, 5 insertions(+), 10 deletions(-)
> >
> > diff --git a/README b/README
> > index 094a7742..cffa0bc6 100644
> > --- a/README
> > +++ b/README
> > @@ -22,6 +22,7 @@ _______________________
> >  - create fsgqa test user ("sudo useradd -m fsgqa")
> >  - create fsgqa group ("sudo groupadd fsgqa")
> >  - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
> > +- create fsgqa-123456 test user ("sudo useradd fsgqa-123456")
> >
> >  ______________________
> >  USING THE FSQA SUITE
> > diff --git a/tests/generic/597 b/tests/generic/597
> > index 1d87a23a..11846b95 100755
> > --- a/tests/generic/597
> > +++ b/tests/generic/597
> > @@ -41,13 +41,10 @@ _supported_os Linux
> >  _require_test
> >  _require_sysctl_variable fs.protected_symlinks
> >  _require_sysctl_variable fs.protected_hardlinks
> > -# su in _require_user prints warnings about user name starts with a di=
git,
> > -# discard the warning
> > -_require_user 123456-fsgqa >/dev/null 2>&1
> > -# Do this SECOND so that qa_user is fsgqa, and _user_do uses that acco=
unt
>
> This comment is still relevant.  It's a quirk that _user_do uses the seco=
nd
> _require_user stated[1], and I wanted to highlight that in the comment.
>

I see, I'll left this comments in v3.

> Otherwise, TBH I guess I'd rather see the user simply be "fsgqa2" or some=
thing,
> so it's not easily confused with the 123456-fsgqa user.  Not a technical =
problem
> with this patch though, just a preference.
>
> Alternately, these two tests /might/ be able to run just as well with "ro=
ot"
> as one user or the other, but I didn't want to risk accidentally getting =
the
> permissions tests wrong by using a user with elevated privs.... so I'm no=
t
> sure about that option.
>

IMO fsgqa2 is better than root. root may misleading test motivation.
Also It's will be
more convenience to choose when people need a second user in other tests.

> -Eric
>
> [1]
> # check for a user on the machine, fsgqa as default
> #
> _require_user()
> {
>     qa_user=3Dfsgqa
>     if [ -n "$1" ];then
>         qa_user=3D$1
>     fi
>
> ...
>
> _user_do()
> {
>         echo $1 | su -s /bin/bash $qa_user 2>&1 | _filter_user_do
> }
>
> tho it might be better to enhance _user_do to take a username as an optio=
nal
> (or required) argument, to avoid this complexity/confusion.... that's a d=
ifferent
> patch tho.

+1, this may need a different patch.

Thanks,
Sero

>
> > +_require_user fsgqa-123456
> >  _require_user fsgqa
> >
> > -OWNER=3D123456-fsgqa
> > +OWNER=3Dfsgqa-123456
> >  OTHER=3Dfsgqa
