Return-Path: <SRS0=HuhN=YU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCF8CA9EAF
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Oct 2019 13:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3499F21726
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Oct 2019 13:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec+8laEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfJ0N7u (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Oct 2019 09:59:50 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42394 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfJ0N7u (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Oct 2019 09:59:50 -0400
Received: by mail-yw1-f66.google.com with SMTP id d5so2889700ywk.9;
        Sun, 27 Oct 2019 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=poDWleOxwscAi1b6vGHml3VbL/qBFRh3NZaGbX0t3BU=;
        b=Ec+8laEeYmf/x6OI5mvnPVNY2TL9yLXNLWoGnvMrB6E5hbpnlHGLvnvd41qYTZQhfQ
         ypPg+E9fAtwZhMkkX4VPnOIeU6R5NxCvr2pbkr7X+du6QctthjNbLzUs/gBG++FAiFni
         PIgRffMAHAYfnEsoCqRAYb7crAxzjif/OporEWTHJiSWxh5wrwJNJoHEL7GtnAbJFi3O
         EAt+MUPlZXKO6loTZOCeCK4ajyDuulR/Hoib2jmmpB6PggfBrDG9TSdvWHagEjkiFvjX
         oVhimrJDz1Lug77JukA20xT7HbtJzbRlOWHVGC9pDwuMfnyr1WU39HgLmlrZ4p8zQu9o
         s3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=poDWleOxwscAi1b6vGHml3VbL/qBFRh3NZaGbX0t3BU=;
        b=Upn9Yprya3jaDnuHU38gvEjevz7Ue3c3l0JJVDHjCWe4dC386Yij6OF/u/L6Cj2HTO
         9dY1o6FLl7D1qBl10juRDwhEs9+Kp4KMBGzTDfpnzCJe/LeJAblPrTsaIydqSQsgWov4
         /iry5goas3lv2cLKfFNtvNPaVI/u3B2zfknSCF9QwEQd+tUjFa3ulVOKU25qcRcYcnCd
         ygeYNR/QaKJxX4P5YiMddefPIOb7L98Gt3KB0KUA3jxQ2YKm3xjCCU8aKzdtZpBEVbbj
         6PcRuJU6AnUUkxE18hYgXn5n8nsqarNyDgt9jzr8qWCxaJ713QjUdPwWtygFteDef1QZ
         MN7w==
X-Gm-Message-State: APjAAAXm5fXM0R97ce2W/Uslmhfyhi0DziGEiImVvrGzAqlasuuoJCbD
        aV0MNhh1EBAzf6LlWP8OP1yoWlwNWTgJaSUa8CM=
X-Google-Smtp-Source: APXvYqwULU4gXYRQRpmhVMr8NS0vNeSJGPNOU540Qf7LxS98LrRNTA+WPV9S2l+YL4wZX0EujbTQjXhht6L9/2isbkY=
X-Received: by 2002:a81:3187:: with SMTP id x129mr10054062ywx.294.1572184787702;
 Sun, 27 Oct 2019 06:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191024122923.24689-1-cgxu519@mykernel.net> <CAOQ4uxidZ=g29hGmKxinRA4Gp6CiWbOB9RqLWPPFXwtCB4DWog@mail.gmail.com>
 <16e007f78f9.12a9e815231850.7849365151361114799@mykernel.net>
In-Reply-To: <16e007f78f9.12a9e815231850.7849365151361114799@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 27 Oct 2019 15:59:36 +0200
Message-ID: <CAOQ4uxgZDKnMGB3pbCJpyH_RxWzbEHLQMB2Mpc10PK=7=xYLOg@mail.gmail.com>
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

On Fri, Oct 25, 2019 at 4:19 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2019-10-25 05:02:07 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > On Thu, Oct 24, 2019 at 3:29 PM Chengguang Xu <cgxu519@mykernel.net> w=
rote:
>  > >
>  > > This is intensive copy-up test for sparse files,
>  > > these cases will be mainly used for regression test
>  > > of copy-up improvement for sparse files.
>  > >
>  > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > >
>  > > ---
>  > > v1->v2:
>  > > - Call _get_block_size to get fs block size.
>  > > - Add comment for test space requirement.
>  > > - Print meaningful error message when copy-up fail.
>  > > - Adjust random hole range to 1M~5M.
>  > > - Fix typo.
>  > >
>  > > v2->v3:
>  > > - Fix space requiremnt for test.
>  > > - Add more descriptions for test files and hole patterns.
>  > > - Define well named variables to replace unexplained numbers.
>  > > - Fix random hole algorithm to what Amir suggested.
>  > > - Adjust iosize to start from 1K.

Chengguang,

Sorry, I did't notice that you did that. Why?
As you can see below, this change has a very bad impact on test run time.
Any reason not to use _get_block_size?


>  > > - Remove from quick test group.
>  >
>  > Why? you said it takes 7s without the kernel patch.
>  > The test overlay/001 is in quick group and it copies up 2*4GB
>  > sparse files.
>
> I noticed that after changed to start from 1K iosize the test took about =
23s.
> I'm afraid maybe it will take more time on low performance VM env.
>
> The test overlay/001 took 8s/1s with/without kernel patch, so mainly test=
 time
> wasted on creating test files on test overlay/066.

You are correct about the time spent on creating the files, but...

On my low perf VM, the test runs 95s with overlay over xfs+reflink

But if I set start iosize=3D4 (which what my fs block size is) the test
runs only 30s.

IOW, most of the test time is spent on creating the files with small iosize
below fs block size, which doesn't test copy up of holes at all.

If I further change file size to be a multiply of iosize (x10),
test run time drops to 6s!
I don't think we loose too much test coverage if we do that?
If anything we gain testing different file sizes.

The disk space requirement formula for ${iosize}K_holefiles becomes:
10*(2^0 + 2^11)K*12/2 =3D~ 10 * 1024 * 12
same as before, just needs explaining.
(the formula assumes the worst case of min_iosize=3D1)

-------------
 #
 # |-- hole --|-- data --| ... |-- data --|-- hole --|

-iosize=3D1
+min_iosize=3D$(($(_get_block_size "${lowerdir}") / 1024 ))
+iosize=3D$min_iosize
 max_iosize=3D2048
-file_size=3D10240
-max_pos=3D`expr $file_size - $max_iosize`

 while [ $iosize -le $max_iosize ]; do
+       file_size=3D$((10*$iosize))
+       max_pos=3D`expr $file_size - $iosize`
+       date >>$seqres.full
+       echo "Creating ${testfile}_iosize${iosize}K_holefile..." >>$seqres.=
full
        pos=3D$iosize
        $XFS_IO_PROG -fc "truncate ${file_size}K" \
                "${lowerdir}/${testfile}_iosize${iosize}K_holefile"
>>$seqres.full
-----------


>
>  >
>  > Tests that are not in quick group are far less likely to be run
>  > regularly by developers.
>
> hmm...well, lets add 'quick' group again and remove it  if anyone complai=
ns later.
>

I am now complaining ;-), but after fixes above, test is really quick

Please send a fix patch (to already merged test) to fir test runtime
and possibly use _get_block_size.

Thanks,
Amir.
