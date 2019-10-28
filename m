Return-Path: <SRS0=nTdV=YV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B128ACA9EC0
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Oct 2019 12:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7596C20717
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Oct 2019 12:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeQEkt/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389068AbfJ1M3R (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:29:17 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37117 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfJ1M3Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Oct 2019 08:29:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id v84so3693483ywc.4;
        Mon, 28 Oct 2019 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qy5X+tGUljkNKO5HzPxh3FDhuDWozHAuROxdEZ0SjMU=;
        b=ZeQEkt/zQDOLrHvyQIgHHeK4SWYOcIRjbeXAuMDSguJFK+nKaWl1zuSeHrsdlKPQOB
         MydOgn7XB14+hrd8+Y2vgraRMDYgbTlvTMMMWxSy/mmZ9Efg//Dtp6UStdkvpaPRhC4/
         bhko8b5oijC4J4LzczBlf9erC4Bejk5D09893Pqv9ry2TXDhVesFCV0+VnZWpMj2u0Mq
         KGYdMRIPe/sqSgwSHpJxGVVJJHBYi6556oj+TGIn9PjO+XHzwj9shpxkKlBrTykjlEA/
         S7Z87/jlkZXVl0UKQKelKyUOJk5sm7xq6FpR27y/9+A4d65g8OdsHudfnhDa8F6df+WN
         pS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qy5X+tGUljkNKO5HzPxh3FDhuDWozHAuROxdEZ0SjMU=;
        b=c0BWwGvabXus4oIUahvtednFcC9mvZvHy/46WHhS1prIV0bbs6/EfTAqpDBWXBXC1H
         Csp1EDn1yv5+zvCBVTy/9ZifUY6Jrfa0eBv11XaFIA3PE4cIYS3kbP8GhPVcZJ9HGw8j
         X8ociiSaV6eN/mwiLCyD3Z1BEXDWV1Sypyj6Zltci5E8mqaB1oQBI+PSvt+1RmyQ5V+8
         v66zxkSrG8xNurwZ92xccRTAt1O/7mA5hcO8e1690HJeel3XtpPcHZ2yopwRhNL0ex+l
         0QAY4Mi8oawEVNUbtw7hWFFUJ5IAuBUELEgY4W3ZcZBs3nPZ7WLbkeEUfBeJAwieN3PL
         tzIg==
X-Gm-Message-State: APjAAAUcl5Auys8J4uspninnlk897KN+bCHZr2pHO03rZz5FF6ID0Vsi
        kYhMmmFjqfcTcXMfPFyoPeunM1T2IY/qqXLliy4=
X-Google-Smtp-Source: APXvYqxqk6dRoRMGT15RnnUEzlvcqoBev5Nhnnq7VexNmSy5V6InAJxDhSz0DR6g5TEr9BsBY55ZZJB9r8fM2ArWq7A=
X-Received: by 2002:a0d:e347:: with SMTP id m68mr12594518ywe.183.1572265755186;
 Mon, 28 Oct 2019 05:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191024122923.24689-1-cgxu519@mykernel.net> <CAOQ4uxidZ=g29hGmKxinRA4Gp6CiWbOB9RqLWPPFXwtCB4DWog@mail.gmail.com>
 <16e007f78f9.12a9e815231850.7849365151361114799@mykernel.net>
 <CAOQ4uxgZDKnMGB3pbCJpyH_RxWzbEHLQMB2Mpc10PK=7=xYLOg@mail.gmail.com> <16e1244e1c9.ccaa038637864.8395134351025208019@mykernel.net>
In-Reply-To: <16e1244e1c9.ccaa038637864.8395134351025208019@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 28 Oct 2019 14:29:03 +0200
Message-ID: <CAOQ4uxjFvTTbKRW1BChnzfNSqg1yeyM3gjwjZ77i161D_XLFRg@mail.gmail.com>
Subject: Re: [PATCH v3] overlay/066: copy-up test for variant sparse files
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

On Mon, Oct 28, 2019 at 2:09 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2019-10-27 21:59:36 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > On Fri, Oct 25, 2019 at 4:19 AM Chengguang Xu <cgxu519@mykernel.net> w=
rote:
>  > >
>  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2019-10-25 05:02:07 Ami=
r Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > >  > On Thu, Oct 24, 2019 at 3:29 PM Chengguang Xu <cgxu519@mykernel.n=
et> wrote:
>  > >  > >
>  > >  > > This is intensive copy-up test for sparse files,
>  > >  > > these cases will be mainly used for regression test
>  > >  > > of copy-up improvement for sparse files.
>  > >  > >
>  > >  > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>  > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > >  > >
>  > >  > > ---
>  > >  > > v1->v2:
>  > >  > > - Call _get_block_size to get fs block size.
>  > >  > > - Add comment for test space requirement.
>  > >  > > - Print meaningful error message when copy-up fail.
>  > >  > > - Adjust random hole range to 1M~5M.
>  > >  > > - Fix typo.
>  > >  > >
>  > >  > > v2->v3:
>  > >  > > - Fix space requiremnt for test.
>  > >  > > - Add more descriptions for test files and hole patterns.
>  > >  > > - Define well named variables to replace unexplained numbers.
>  > >  > > - Fix random hole algorithm to what Amir suggested.
>  > >  > > - Adjust iosize to start from 1K.
>  >
>  > Chengguang,
>  >
>  > Sorry, I did't notice that you did that. Why?
>  > As you can see below, this change has a very bad impact on test run ti=
me.
>  > Any reason not to use _get_block_size?
>
> Use _get_block_size cannot mitigate the effect perfectly,
> in the worst case that we formatted fs with blocksize=3D1K,
> the test will  take long time and also test time is not fixed.
>
>  >
>  >
>  > >  > > - Remove from quick test group.
>  > >  >
>  > >  > Why? you said it takes 7s without the kernel patch.
>  > >  > The test overlay/001 is in quick group and it copies up 2*4GB
>  > >  > sparse files.
>  > >
>  > > I noticed that after changed to start from 1K iosize the test took a=
bout 23s.
>  > > I'm afraid maybe it will take more time on low performance VM env.
>  > >
>  > > The test overlay/001 took 8s/1s with/without kernel patch, so mainly=
 test time
>  > > wasted on creating test files on test overlay/066.
>  >
>  > You are correct about the time spent on creating the files, but...
>  >
>  > On my low perf VM, the test runs 95s with overlay over xfs+reflink
>  >
>  > But if I set start iosize=3D4 (which what my fs block size is) the tes=
t
>  > runs only 30s.
>  >
>  > IOW, most of the test time is spent on creating the files with small i=
osize
>  > below fs block size, which doesn't test copy up of holes at all.
>  >
>  > If I further change file size to be a multiply of iosize (x10),
>  > test run time drops to 6s!
>  > I don't think we loose too much test coverage if we do that?
>  > If anything we gain testing different file sizes.
>
> hmm, for small iosize the file size is even smaller than
> copy-up CHUNK SIZE(1M),  so that all contents(data+hole)
> will be passed at once, I'm not very sure is it helpful for
> hole copy-up logic in kernel patch. What do you think?
>

Not sure. I don't think we should target the test by what we know your
patch does, but by maximizing test coverage in a cost effective way.

Creating a 10M file with so many small holes doesn't add much to test
coverage IMO. If you feel those are needed, you should use a C helper
to create those files more efficiently.

BTW I think what is missing from test coverage is small holes
that are not aligned to 1M boundary.


>
>  >
>  > The disk space requirement formula for ${iosize}K_holefiles becomes:
>  > 10*(2^0 + 2^11)K*12/2 =3D~ 10 * 1024 * 12
>
> That's the mean of 12/2 ?

it's the formula to the sum of the series:
2^0+2^2+...2^11 =3D (2^0 + 2^11)*12/2

>
>  > same as before, just needs explaining.
>  > (the formula assumes the worst case of min_iosize=3D1)
>  >
>  > -------------
>  >  #
>  >  # |-- hole --|-- data --| ... |-- data --|-- hole --|
>  >
>  > -iosize=3D1
>  > +min_iosize=3D$(($(_get_block_size "${lowerdir}") / 1024 ))
>  > +iosize=3D$min_iosize
>  >  max_iosize=3D2048
>  > -file_size=3D10240
>  > -max_pos=3D`expr $file_size - $max_iosize`
>  >
>  >  while [ $iosize -le $max_iosize ]; do
>  > +       file_size=3D$((10*$iosize))
>  > +       max_pos=3D`expr $file_size - $iosize`
>  > +       date >>$seqres.full
>
> That's the purpose for putting data info here?

leftover from my debugging patch to figure out what takes so much time
You don't need it

Thanks,
Amir.
