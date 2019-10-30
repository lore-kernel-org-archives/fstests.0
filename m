Return-Path: <SRS0=KRl+=YX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5836CA9EAF
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Oct 2019 05:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843292087E
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Oct 2019 05:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJW8JEzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfJ3FeM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Oct 2019 01:34:12 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37146 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfJ3FeL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Oct 2019 01:34:11 -0400
Received: by mail-yw1-f65.google.com with SMTP id v84so463794ywc.4;
        Tue, 29 Oct 2019 22:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=awvmcllvoQxkws+t9hh1Rf782NhS4hoTdPuyYWHl1Qw=;
        b=YJW8JEzo/gUWhW+GX6FjSrlkJx48NldVHVf3eECe63wV3efUovH7oz/X1ewVMfPAv3
         rPy9BbZQFpaal7jfS72jf9l9KeGJBSeLstBGJfampKTlz9z4Y9/Sz9LGDIBadWHRoRvM
         ZtmPri8egMeI0GTiWuPuton/WcAleFRL23OuuZpqCoeyhH69wIRuyDRz6QsPiKZCdzXq
         7cOJnucaTDRfhowumzJN8aY64yYOP7zKpaerbn94KvscKW1thsJSKylBJCGrcng+oYwL
         kUsKndoh8yawzMwnHls0UuRDM/bYxkADJFfI9f4P1zC8W9WG3/MYbwJ4BKtg04rVTqyh
         7EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=awvmcllvoQxkws+t9hh1Rf782NhS4hoTdPuyYWHl1Qw=;
        b=AlQdb3XF0c6JFqCMBjMyth+6SXTrM/1gpX60DX+NnHDp+VqQ50Xogv4xjyv/aCfQPv
         K/rDAAH+Fc7jCuqoajPz0eLF4/rQazmKdgg/dAcoYbiQ9XLsKH07Qt6M3KU8JMO/aUMp
         5wiLivbb8nrRbhR1nXcl2TQRYo6W9oCx8iab8mCbBG/hmrDA7StsECdln7eSJfXRQf1M
         p+dXjZrQFKnjVVQp3O+5V2bgswq/xAxqsxDumOCCrRv36FHedffL6q8/MLD2eKcKtiz9
         gAs9ze7YKL1czv4MAvCVZikg/YbrxKlAUb+erzoj2raLNxZSwLt7WEXtRZT4N5oD8/Mx
         PKtA==
X-Gm-Message-State: APjAAAXLxsU6QTDT0SZQApZ7yGIlp7rwMJjJubLNl/ZwtbzLnQZZ3oGG
        ZC5Js4idmiegmtp/Z3+/Bi6YWiz3YcZ5bEXob3o=
X-Google-Smtp-Source: APXvYqzkhjwPX8DFKvX76CmDH5rDPGkFrl2rnqidDe/UX+00dduLxm9kM05f0UwNy2G0TUeUxHvbXk336DX1tSNb184=
X-Received: by 2002:a81:4a02:: with SMTP id x2mr20329875ywa.31.1572413650729;
 Tue, 29 Oct 2019 22:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191029055713.28191-1-cgxu519@mykernel.net> <CAOQ4uxgzZHXOv7K++BArYmaTEHbYr5oCkgXw8WVUsQgh0uyqhg@mail.gmail.com>
 <16e173c434a.11f8ced8d40796.3954073574203284331@mykernel.net>
 <CAOQ4uxjddbot29=cYqLMLyqT=w=pWmLOPqVzvi-5mcXQ3AB3EQ@mail.gmail.com>
 <CAOQ4uxiZgmA6Z8Lq=ac7O9f1+CMnSmyLoAA7TDu6Hyt=-pUctw@mail.gmail.com> <16e1afc4097.118c98c8b43000.1263688409904269456@mykernel.net>
In-Reply-To: <16e1afc4097.118c98c8b43000.1263688409904269456@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Oct 2019 07:33:59 +0200
Message-ID: <CAOQ4uxjqMTFc-Fmpg3oGChy01X2JzQoG_jqxk5iEz+bR4yoQjg@mail.gmail.com>
Subject: Re: [PATCH] overlay/066: adjust test file size && add more test patterns
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     fstests <fstests@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 30, 2019 at 6:46 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-29 20:32:43 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > On Tue, Oct 29, 2019 at 1:58 PM Amir Goldstein <amir73il@gmail.com> wr=
ote:
>  > >
>  > > On Tue, Oct 29, 2019 at 1:17 PM Chengguang Xu <cgxu519@mykernel.net>=
 wrote:
>  > > >
>  > > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-29 16:32:32 A=
mir Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > > >  > On Tue, Oct 29, 2019 at 7:57 AM Chengguang Xu <cgxu519@mykernel=
.net> wrote:
>  > > >  > >
>  > > >  >
>  > > >  > Can you please send the patch as plain/text.
>  > > >  > Your mailer has sent it with quoted printable encoding and git =
am
>  > > >  > fails to apply the patch:
>  > > >  > https://lore.kernel.org/fstests/20191029055713.28191-1-cgxu519@=
mykernel.net/raw
>  > > >  >
>  > > >
>  > > > Sorry for that,  I'm not clear for the reason, so I send you the p=
atch in attachment first.
>  > > >
>  > >
>  >
>  > OK, I can verify that test runs quick (5s) on my VM.
>  >
>  > But there is one more issue that I think needs to be addressed, either
>  > in this fix patch or in a follow up patch.
>  >
>  > If the test ever fails on some run with a specific random holes sequen=
ce,
>  > it is going to be quite hard for reporter to report this sequence or f=
or
>  > developers to reproduce the same random sequence.
>
> IMO, it's not so hard as you thought,  I prefer to use filefrag to check =
it.
>
> I think below tidy info is very clear and easy to understand what had hap=
pened.
>
> [root@hades ovl-lower]# filefrag -k -e copyup_sparse_test_random_small_ho=
lefile
> Filesystem type is: 58465342
> File size of copyup_sparse_test_random_small_holefile is 10485760 (10240 =
blocks of 1024 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: fla=
gs:
>    0:        4..     411:    2625148..   2625555:    408:          4:
>    1:      816..    1259:    2626172..   2626615:    444:    2625960:
>    2:     1696..    1783:    2627196..   2627283:     88:    2627052:
>    3:     1872..    2207:    2627372..   2627707:    336:
>    4:     2544..    3019:    2629244..   2629719:    476:    2628044:
>    5:     3496..    3599:    2629720..   2629823:    104:
>    6:     3704..    3819:    2629928..   2630043:    116:
>    7:     3936..    3959:    2630044..   2630067:     24:
>    8:     3980..    4487:    2631292..   2631799:    508:    2630088:
>    9:     4992..    5235:    2631800..   2632043:    244:
>   10:     5472..    5715:    2632044..   2632287:    244:
>   11:     5956..    6355:    2633340..   2633739:    400:    2632528:
>   12:     6752..    6787:    2633740..   2633775:     36:
>   13:     6820..    6907:    2633808..   2633895:     88:
>   14:     6996..    7447:    2633896..   2634347:    452:
>   15:     7900..    8211:    2637436..   2637747:    312:    2634800:
>   16:     8516..    8867:    2638052..   2638403:    352:
>   17:     9216..    9703:    2638752..   2639239:    488:             las=
t
> copyup_sparse_test_random_small_holefile: 7 extents found
>

There is a difference between understanding what happened and
reproducing, but there is no reason to choose one method over
the other.

As a developer, when I get a bug report I would rather have both
an easy reproducer and all the postmortem  information available.
Therefore, please echo xfs_io commands, at least for creation of
random files to full log AND filefrag info, at least for the random
files to full log.

Thanks,
Amir.
