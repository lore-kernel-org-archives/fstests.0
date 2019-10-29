Return-Path: <SRS0=gkCv=YW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B00CA9EAE
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Oct 2019 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159D32086A
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Oct 2019 12:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOrIR09x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJ2Mcz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:32:55 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34229 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfJ2Mcz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Oct 2019 08:32:55 -0400
Received: by mail-yb1-f196.google.com with SMTP id m1so5289483ybm.1;
        Tue, 29 Oct 2019 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=28ufGyAX1PNyse9+jZuy/kBDfiVuiZHqQyF4Qdd/geo=;
        b=fOrIR09xjODaRtdLjl8Q2wvtAw03dklCP6o85I20Bvr9cPajH06itEkOy4/VheGq+L
         kYZijNkVB5inhn8vkKvhEPYSjX0m9M+uXu17rKPVI7/rSYp4KVQYO8WtrpB8ThkakDfL
         tr3G6LsPCLaN5Dw669zytW8t5vUq7uiipjCzT/QOW35SPvykue9Htd9Wfj+pe+elF9w8
         C0wHIVLg4Blhx5WMVNmnrDWblqocSuHNmO/LGycJ6pyUWjr6faG6366qi5Jz9VWzW1xG
         8yPKDTybFymEW0Z/AD/VW+2IbUhtTjvZNwk6qGb03gP/J2cXa3L20jgLncP5SUxMgZYS
         OwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=28ufGyAX1PNyse9+jZuy/kBDfiVuiZHqQyF4Qdd/geo=;
        b=NtEhA0LHA3MSPHWfHrl4xXMwPuYaaG/HikOawwQosKJTYvF7kO94JLjuXRRH/njjp1
         9KuIP21zGLkDk8AxFPq/WEBU1mgnJ2Ac10iie1IgauctJUJ+rryC4NC771sLfsBmAt50
         qaHLtAQ8Bx5rYuTgd++1/rVk16ZJMRl5JjpQyqUgDkeqxyY9yMnaret4gOoZtqYAjArh
         S7v+4aV2IYkBhIgc0a+hr0xCsVZvU2LhWFycWbNAovgo64Hhyr7doc+IhZlIZvFoU72o
         PygbDgbkcVu4qprL5xifU47m/gVRxAyAs6uOPuXgIwdxkKaBqSIlTmWER0O3MSdKcWLD
         M1Ng==
X-Gm-Message-State: APjAAAXru8m0YQTCDFAUsB6kfkkEb3xkdAOdMEITK6Zt1vYlY41GS894
        cNhNMLkfqq/id7DvX5Nhil7DSWf1xD3ZJeCP38c=
X-Google-Smtp-Source: APXvYqytnaWvcYXPrHKCjxFcbKkUSgzA0SHYHc/HX9VMMvQqWL36o4xubhcPVYw+PRnqrtYC6gFrI7Gqt/vKs+TaomU=
X-Received: by 2002:a25:3344:: with SMTP id z65mr18488765ybz.439.1572352374378;
 Tue, 29 Oct 2019 05:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191029055713.28191-1-cgxu519@mykernel.net> <CAOQ4uxgzZHXOv7K++BArYmaTEHbYr5oCkgXw8WVUsQgh0uyqhg@mail.gmail.com>
 <16e173c434a.11f8ced8d40796.3954073574203284331@mykernel.net> <CAOQ4uxjddbot29=cYqLMLyqT=w=pWmLOPqVzvi-5mcXQ3AB3EQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjddbot29=cYqLMLyqT=w=pWmLOPqVzvi-5mcXQ3AB3EQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 29 Oct 2019 14:32:43 +0200
Message-ID: <CAOQ4uxiZgmA6Z8Lq=ac7O9f1+CMnSmyLoAA7TDu6Hyt=-pUctw@mail.gmail.com>
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

On Tue, Oct 29, 2019 at 1:58 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Oct 29, 2019 at 1:17 PM Chengguang Xu <cgxu519@mykernel.net> wrot=
e:
> >
> >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-29 16:32:32 Amir G=
oldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
> >  > On Tue, Oct 29, 2019 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net>=
 wrote:
> >  > >
> >  >
> >  > Can you please send the patch as plain/text.
> >  > Your mailer has sent it with quoted printable encoding and git am
> >  > fails to apply the patch:
> >  > https://lore.kernel.org/fstests/20191029055713.28191-1-cgxu519@myker=
nel.net/raw
> >  >
> >
> > Sorry for that,  I'm not clear for the reason, so I send you the patch =
in attachment first.
> >
>

OK, I can verify that test runs quick (5s) on my VM.

But there is one more issue that I think needs to be addressed, either
in this fix patch or in a follow up patch.

If the test ever fails on some run with a specific random holes sequence,
it is going to be quite hard for reporter to report this sequence or for
developers to reproduce the same random sequence.

One way to fix this is to output the sequence of commands that
generated the random files to full output, so it can be used as a recipe
for reproducer in case of a failure.

If you do that, please make sure that the recipe for creating
small random file is clearly separated from recipe for creating
big random file.

Thanks,
Amir.
