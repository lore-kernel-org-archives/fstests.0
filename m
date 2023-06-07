Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CAEC77B7A
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jun 2023 12:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjFGMsf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jun 2023 08:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbjFGMsE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jun 2023 08:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1071FC7
        for <fstests@vger.kernel.org>; Wed,  7 Jun 2023 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686142030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIMo5Y/QP67ho0fhAFpw/9DK812qHznIVv186436Xwk=;
        b=SLuRhbSKJobkjTyh/uaAzFtusYXW3aFMZqNY0T9u4CDzyZYqZXQ3po3licnbouCZuK+8HZ
        oEcinsJkIKK3ErFbmcyEZdxpRtKoVpRBjQAY1U7DGXP2K1Ru5v3dwdzbRXZE9o8LQMBbs4
        AGTlgkbjKHffSMHAWhLfcSdrX6wAtew=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-NDKaM05-N6qOV5m8k615Ug-1; Wed, 07 Jun 2023 08:47:08 -0400
X-MC-Unique: NDKaM05-N6qOV5m8k615Ug-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b037e0247dso68530775ad.3
        for <fstests@vger.kernel.org>; Wed, 07 Jun 2023 05:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142027; x=1688734027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIMo5Y/QP67ho0fhAFpw/9DK812qHznIVv186436Xwk=;
        b=iTlxsMU97ZS1Bk6+M4LQCDOgw8QzYrhR8daC3vV+UAzbrHmXAd/SqMBlpLh40eMwWh
         EsVfjtr5Gm2mGXuRniyWVQzElTKXNjoY4L7P+AQ4I7HOSM1djjHt+AaPGQH3ZiZBAQDA
         MJvPFtxoLVc0t5TO/4ZRvk54qGCk9m3cDbgEJ6Ft/WoyEsP+EqvXzP5uFw1TDHcAVm9W
         pgAMkKELc0h1VrLAknjDnQAH0cGWx0FJMOlAKipmK/eoywlSCSW5id3y80s89gAdqPgn
         xl4BMU16t2g2Yoi6ZA6hZAvfsCUhIRMuOyTsLqMZzEh43rE3Fpv7zwI42AGkv1a97wf1
         Et/g==
X-Gm-Message-State: AC+VfDwKefOAy/PkelLU7GzC6muZ+JViO78VyytsPccaPF1mMb6peXjl
        j+03OzUKMV1aW8xLz8JW4QuCMVBwShR4dLvH5nik4/qnygQQxkrbVuCFV+bsGhMo+oNDTQ0WD0N
        f8De3IP3w9Sf7eZ1J3X5qfN2uLMoxTOihqkm4HoVBMPBe
X-Received: by 2002:a17:902:bcc6:b0:1ad:cba5:5505 with SMTP id o6-20020a170902bcc600b001adcba55505mr4925321pls.14.1686142026720;
        Wed, 07 Jun 2023 05:47:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qC1OumhuvAhonw4eWjtm8E7aE5odGKXCh3PsSbRbUVaCnX5Ettwrx23SYRJcc5Y+98gLsEyRJPF+SmN9YI5I=
X-Received: by 2002:a17:902:bcc6:b0:1ad:cba5:5505 with SMTP id
 o6-20020a170902bcc600b001adcba55505mr4925308pls.14.1686142026320; Wed, 07 Jun
 2023 05:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230606133545.1152607-1-agruenba@redhat.com> <20230606223754.GB72228@frogsfrogsfrogs>
In-Reply-To: <20230606223754.GB72228@frogsfrogsfrogs>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 7 Jun 2023 14:46:54 +0200
Message-ID: <CAHc6FU67DV_LOTnQvgFxn+cphHZTdZF7jYLNiPRqpDw9+Z_ekg@mail.gmail.com>
Subject: Re: [PATCH] generic/728: Add mmap + DIO write test
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 7, 2023 at 12:38=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
> On Tue, Jun 06, 2023 at 03:35:45PM +0200, Andreas Gruenbacher wrote:
> > This is the same as generic/647, but with an additional test that write=
s
> > a memory-mapped page onto itself using direct I/O.
> >
> > For direct I/O writes, the kernel will invalidate the page cache before
> > and after carrying out the write.  This puts filesystems that fault in
> > pages on demand and then carry out the write with page faults disabled
> > into a position in which they will not be able to make any progress.
> > ---
> >  src/mmap-rw-fault.c   | 33 ++++++++++++++++++++++++++++++---
> >  tests/generic/728     | 41 +++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/728.out |  2 ++
> >  3 files changed, 73 insertions(+), 3 deletions(-)
> >  create mode 100755 tests/generic/728
> >  create mode 100644 tests/generic/728.out
> >
> > diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
> > index 82f9d978..161d9f79 100644
> > --- a/src/mmap-rw-fault.c
> > +++ b/src/mmap-rw-fault.c
> > @@ -20,6 +20,7 @@
> >  #include <string.h>
> >  #include <errno.h>
> >  #include <err.h>
> > +#include <getopt.h>
> >
> >  char *filename;
> >  unsigned int page_size;
> > @@ -109,11 +110,29 @@ static ssize_t do_write(int fd, const void *buf, =
size_t count, off_t offset)
> >       return count2;
> >  }
> >
> > +static void usage(const char *argv0)
> > +{
> > +     fprintf(stderr, "Usage: %s [-2] {filename}\n", argv0);
> > +     exit(2);
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> > -     if (argc !=3D 2)
> > -             errx(1, "no test filename argument given");
> > -     filename =3D argv[1];
> > +     int opt, opt_2 =3D 0;
> > +
> > +     while ((opt =3D getopt(argc, argv, "2")) !=3D -1) {
> > +             switch(opt) {
> > +             case '2':
> > +                     opt_2 =3D 1;
> > +                     break;
> > +             default:
> > +                     usage(argv[0]);
> > +             }
> > +     }
> > +
> > +     if (optind + 1 !=3D argc)
> > +             usage(argv[0]);
> > +     filename =3D argv[optind];
> >
> >       page_size =3D ret =3D sysconf(_SC_PAGE_SIZE);
> >       if (ret =3D=3D -1)
> > @@ -179,6 +198,14 @@ int main(int argc, char *argv[])
> >               errx(1, "pread (D_DIRECT) from hole is broken");
> >       done();
> >
> > +     if (opt_2) {
> > +             init('f', O_RDWR | O_DIRECT);
> > +             ret =3D do_write(fd, addr + page_size, page_size, page_si=
ze);
> > +             if (ret !=3D page_size)
> > +                     err(1, "pwrite %s (O_DIRECT): %ld !=3D %u", filen=
ame, ret, page_size);
> > +             done();
> > +     }
> > +
> >       if (unlink(filename))
> >               err(1, "unlink %s", filename);
> >
> > diff --git a/tests/generic/728 b/tests/generic/728
> > new file mode 100755
> > index 00000000..13a88dc0
> > --- /dev/null
> > +++ b/tests/generic/728
> > @@ -0,0 +1,41 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 728
> > +#
> > +# Trigger page faults in the same file during read and write
> > +#
> > +# This is generic/647 with an additional test that writes a memory-map=
ped page
> > +# onto itself using direct I/O.
> > +#
> > +# The kernel will invalidate the page cache
> > +# before carrying out the write, so filesystems that fault in the targ=
et page before carrying out the direct I/O write will never make any progre=
ss.
>
> Oddly linewrapped...

Oops, I'll repost.

> How many filesystems stall when running this?  ext4/btrfs/xfs didn't
> when I tried.

gfs2 got this wrong. btrfs also has page faults disabled during direct
writes, but it already fell back to buffered writes when it didn't
make progress (as does gfs2 now).

Thanks,
Andreas

> --D
>
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -f $tmp.*
> > +     rm -f $TEST_DIR/mmap-rw-fault.tmp
> > +}
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs generic
> > +_require_test
> > +_require_odirect
> > +_require_test_program mmap-rw-fault
> > +
> > +echo "Silence is golden"
> > +
> > +$here/src/mmap-rw-fault -2 $TEST_DIR/mmap-rw-fault.tmp
> > +
> > +status=3D$?
> > +exit
> > diff --git a/tests/generic/728.out b/tests/generic/728.out
> > new file mode 100644
> > index 00000000..ab39f45f
> > --- /dev/null
> > +++ b/tests/generic/728.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 728
> > +Silence is golden
> > --
> > 2.40.0
> >
>

