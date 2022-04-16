Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E173C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Apr 2022 17:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiDPRQr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 16 Apr 2022 13:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiDPRQo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 16 Apr 2022 13:16:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35F0DF496
        for <fstests@vger.kernel.org>; Sat, 16 Apr 2022 10:14:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c1so8600725qkf.13
        for <fstests@vger.kernel.org>; Sat, 16 Apr 2022 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5wZk7sMTs9B5pn33Cv/RCMjpFByujtRfiwHgse1M+jg=;
        b=Iky6aIUkK22nZskMJwBq2yLMTNzHjnNOj5rTnJLtoVGmWxoqyaHQJeFvjB2iTkcJVh
         qfxwlaJ+p/v/QwYZTax1EcDZ4UPDA7turo9AodbLycdkd7V/EgLvhX3t8l3KfU+DWQi2
         jqj4mekghG2r+R0OfmK2RCmxhmQXMsikYjNUXUC/uQNk6rnk3ZioAoBeOdNeW4IvVjlQ
         3mDyWd0mIMjNNnn1SX3m6FsM11CNSHdUtUPhOdCdCHBUCEXBff1musQo3qVd7bBD6x1N
         ICux5iZRsH8Tb1J61vcTv6ieVBVqziyVp/YBp5C3Vbxqz+Tc5Fv4D5S54nEQB4gCXR3A
         qW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5wZk7sMTs9B5pn33Cv/RCMjpFByujtRfiwHgse1M+jg=;
        b=fjltoa95ufCT4N1i32jV0EbICHBdiRciIk1XKe08UgUcvJ4mV0WP24QvKQea9UK3VE
         tREEGQgx6bHw4vExVIXqjBR1vCGAnjQWEY9yteM/WMnDZPHhQSrNon1icZj+8BzCW0/u
         Fi0IHTGSjfKUs3wybqket9VmQhqSlmyncQp1gmpVhICiFjr7GmPwSEh4zUCyegs+BJeg
         3gqrJzUTUXCdjlmnjkZ/oPlnP2PAz2X+NZMA/+4xVNaML+pobhsikrSFE34uIlj5Qn5N
         QGM8rK2AG958zWnekZtZifaqXiiBZLIhHw0NhVbRyMohzN7HqdEI9xOtjJEPbPt/fRc2
         qqSQ==
X-Gm-Message-State: AOAM533TsNpp8WZyTHvrqG12CZLnUNUb0EMVAewp4lpgUnHbDrjiMlXs
        1MDFCdL5tR8gCiBczrR4VYu0lQncMq+UDSE97rg=
X-Google-Smtp-Source: ABdhPJwL0DfIuJY23XtTER6nuMhnJGTOCsAjrgH2T+aGiQKsXCFMKjgkjs9kjckpXknaxJoVPd55jH4qZA4tflk5neo=
X-Received: by 2002:ae9:eb87:0:b0:69e:75b3:6527 with SMTP id
 b129-20020ae9eb87000000b0069e75b36527mr1732575qkg.386.1650129250983; Sat, 16
 Apr 2022 10:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220411054833.2157779-1-david@fromorbit.com> <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox> <20220413002656.GL1609613@dread.disaster.area>
 <20220414162544.kiesx5muc5ddtbzd@zlang-mailbox> <20220414191643.5udsx6kdarlumyfn@zlang-mailbox>
 <CAOQ4uxhA7pnfRE6sSQkKOAJRDP1WmNWZBj7T_THQEjYrD7SaxQ@mail.gmail.com> <20220416141126.wwzvkzyzbvjczfae@zlang-mailbox>
In-Reply-To: <20220416141126.wwzvkzyzbvjczfae@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 16 Apr 2022 20:13:59 +0300
Message-ID: <CAOQ4uxg8G1AkcyzpALy8Nc7duuENCYatLOqY9vF6PL5maM4NWg@mail.gmail.com>
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
To:     Amir Goldstein <amir73il@gmail.com>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Apr 16, 2022 at 5:11 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Sat, Apr 16, 2022 at 12:20:22PM +0300, Amir Goldstein wrote:
> > On Fri, Apr 15, 2022 at 12:56 PM Zorro Lang <zlang@redhat.com> wrote:
> > >
> > > On Fri, Apr 15, 2022 at 12:25:44AM +0800, Zorro Lang wrote:
> > > > On Wed, Apr 13, 2022 at 10:26:56AM +1000, Dave Chinner wrote:
> > > > > On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> > > > > > On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > > > > > > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > > > > > >
> > > > > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > > > >
> > > > > > > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > > > > > > Kill them in the cleanup function so that they don't have to be
> > > > > > > > manually killed after interrupting the test.
> > > > > > > >
> > > > > > > > While touching the _cleanup() function, make it do everything that
> > > > > > > > the generic _cleanup function it overrides does and fix the
> > > > > > > > indenting.
> > > > > > > >
> > > > > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > > > > ---
> > > > > > > >  tests/generic/019 | 6 ++++--
> > > > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/tests/generic/019 b/tests/generic/019
> > > > > > > > index db56dac1..cda107f4 100755
> > > > > > > > --- a/tests/generic/019
> > > > > > > > +++ b/tests/generic/019
> > > > > > > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > > > > > > >  # Override the default cleanup function.
> > > > > > > >  _cleanup()
> > > > > > > >  {
> > > > > > > > -    disallow_fail_make_request
> > > > > > > > -    rm -f $tmp.*
> > > > > > > > +     kill $fs_pid $fio_pid &> /dev/null
> > > > > > > > +     disallow_fail_make_request
> > > > > > > > +     cd /
> > > > > > > > +     rm -r -f $tmp.*
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > > > > > >
> > > > > > > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > > > > > > wait, but should be fine as-is:
> > > > > >
> > > > > > I agree. Better to avoid killing other system processes. Or how about this place
> > > > > > does (avoid killing system useful processes):
> > > > > > $KILLALL_PROG -q $FSSTRESS_PROG
> > > > > > $KILLALL_PROG -q $FIO_PROG
> > > > > >
> > > > > > Another picky question is, do we need to use a while loop checking, until the
> > > > > > processes really get killed? :)
> > > > >
> > > > > Do we really need to paint the bikeshed over how best to kill a
> > > > > process? I don't have time to do that, this is just a drive-by fix
> > > > > that works for me....
> > > >
> > > > Sure Dave:) The while loop checking is a little picky, I just ask what do you think, no
> > > > objection if you don't like that. Due to quick cleanup and exit is a good reason too.
> > > >
> > > > I think it might be worth doing "$KILLALL_PROG -q $FSSTRESS_PROG $FIO_PROG" at least, to
> > > > avoid killing other processes might be useful.
> >
> > That has much more likelihood to kill processes not spawn by the test
> > then pid wraparound.
>
> Yes, you're right. But generally we don't run xfstests with other testing, to avoid other
> testing break dmesg checking of xfstests. (Is there a way to help different process get
> independent dmesg out? If there's, I'm very glad to know how to do that, then I can run
> xfstests concurrently in one system:)
>
> Anyway, we can choose another way -- "unset'ing the "fs_pid" and "fio_pid" variables
> after the wait", both are fine to me.
>

Fine by me

Thanks,
Amir.
