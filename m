Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793097618;
	b=AKJ9n5ZdywQ7ByTBWP6sztSM1PcGLeZhu4VBWHjU6zso25iyQrcmE3NIcmD3eyZZImVG
	 2ypmY5QOC/gSSApGir1+Ynpppyp3VFap/gEc/Z2wi4SxOekRRPS3RV3JNUJFN/Ohv1GrY
	 k2Vf6u/XWjJ2AZhjmK8Jfh28T0xaGZ9w84acjhXUzq+ftZLzareKTXDgCQma+ssV1Xuxh
	 Ngj+t5F1hxBq0uO19QspUNBIgFGYsDPsrCR5sNhdupxZACmtusQopjPGCxbPTJMTcmkIO
	 xKmQUqJVpctUBcxZ2z6iZQcR4aTnKDfjNvMSyR1sH+NauujJyDxjw8+hX0gj745fblw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097618;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=7OYbDDzUmC/dcU5eCCTLOKEwzBV+TagsGcae08wBOPY=;
	b=WLKCWhbJ/G9hXMxOn/Vfa4pXQSyVCPOO0/ISkHSF6joktMRXYN5MSnL1NS1MVPeLgDTY
	 DpSHalrCJ/yPPWTpLdn+9yYxxapU0JEoqIfPpnyky/NnyaoqFboqbRAHC86dRqyQg4Giu
	 t1RCvS7hofdGLwbS4CCQoCrU15QNWCGJKCSEBNwv8OYMDrY/WUt0Kgw6Wtp5t9LUiSWPR
	 s4KK4YYFExuykCpBUC60Qn8uiUD3PsZewPAVrbc1uKaQ/yvuAnSp/UCGSW8KRfFdUCZOt
	 qqcq+pDUvuuQCwZODN15mX66lGiu86ff7D3BivuRyyhr6SoX+dUdFe//DtbC8SRyZuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="CLvo/MmI";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rdaIlOvb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD3606A320
	for <fstests@vger.kernel.org>; Tue, 27 Oct 2026 10:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93CD3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CLvo/MmI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rdaIlOvb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793097616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OYbDDzUmC/dcU5eCCTLOKEwzBV+TagsGcae08wBOPY=;
	b=CLvo/MmIWfWQ1PlmrFjF6IW88ynvgXNb8/rsUacPzCSicAGo5LXgwgq5hUUQ9DoSVKXbY8
	1+pO2VEIkuNLlyah0Pn8imXVF+ypkVkouXEkF2idni4jxhbVnbTJp12JTUyyvyTLLZWRrs
	v/Ccfs9OEAf6hnbA65O60BeGfMXPKKg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-GWLc3SlfOZebJX8CJcVENQ-1; Tue, 27 Oct 2026 06:40:13 -0400
X-MC-Unique: GWLc3SlfOZebJX8CJcVENQ-1
X-Mimecast-MFC-AGG-ID: GWLc3SlfOZebJX8CJcVENQ_1793097612
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-7035f069837so4860757eaf.3
        for <fstests@vger.kernel.org>; Tue, 27 Oct 2026 03:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793097612; cv=none;
        d=google.com; s=arc-20260327;
        b=fjVetuAKD9ehAAbtCqWORqfqILFhxbi+TCb+Cp70nTnEVlMpV8lo6wnYnbfP13Dxvd
         617SgrfCs7O7hjSExiexVE3FCeryxICVZcO51uBG31cfOo91I5D8syxsenNFtTZlE2i6
         Ye6/fjTMxUTiP2X+bm8pj4s5HNbDCU6p2ZinWpDFl3MkSPZURkA5zJCb55xCmZ+y0DQf
         yc4u6isgEQF1hQCpzqpsCacYAlySaUMv5luw23GxjdEVquRqg7yVvF8cj+0BW/TKFu3P
         RPnbhh5903BmtSdwnc0SfJ9CVijjDvW7tHwdVrCEOLwHs5PO3tWQEayu+Da81HrXS6MX
         vqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7OYbDDzUmC/dcU5eCCTLOKEwzBV+TagsGcae08wBOPY=;
        fh=SmDF1XDy2Pz9YE/Jo/D7RKBd2SqHjjABgvTdYjSQ11U=;
        b=U7eCdYLkMWJ5DMyiUmQCCfEr7Dfae0rwCLTOyFZKBNiiR98Q2zqVOJc5Vo4e8zWh6u
         xjt0zYexPxaBfRSLhQHnfzGZy1E2H9bMvgu+DZFfuafumgKp2XCPATop9ZECoq/Oijaz
         8fHPQgrg25a2LGpeRF24zWq6RezoB9QSyAk/KWszI4+wNYqRCmwk7PvsR0RiZLWfmLiJ
         myUYltQeXbPyRhVVsV0PI2W3aVg/vZsAukN5IHP7BSZPtOwJw/2coH0hilGxExdVmjHd
         U+S+oCJU8behU8cAGNW2C7iPG3oKIQuMfK43JqhLkUIyMjIi/xE536zA8gWAUuKHzfDg
         PTEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793097612; x=1793702412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7OYbDDzUmC/dcU5eCCTLOKEwzBV+TagsGcae08wBOPY=;
        b=rdaIlOvb1bW+BBtDAaU2ztnVZrmM46iad4pdCwjIASfVstOHRCtQhe7CFW1BlHEE3O
         F7dXa5FOtp34k+QO1GbusbiYDr7Dw05SaLO56u5T0dWXbGgW3boEEkDCIg8OIpCFb9k0
         1C1QvT0NZsOU2FDNif7+msBkjbjsp3eU7CWZml0z5qS7orASs7sCsM+pC180uUE2uMnl
         XuRr7I/GwgHRKXOSSTZ3Xb+5emkgIfKHrMpDneEAg7GFo+rQCbDiokYff7jIA22Pmf4+
         pgyCGvKnHkb/sWoVF2H1wIcOtAMywRKG7GIwLrduUDtAkPtePCfZNh8H1oR2ugYF2p4/
         UVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793097612; x=1793702412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OYbDDzUmC/dcU5eCCTLOKEwzBV+TagsGcae08wBOPY=;
        b=jF5tzf6GLonk2chyHu0OSy/Q0WY+Kv1KeiKCJ/9iGO2Ayc426C3rn0brP/IVsGVgbB
         EcOHsmJyGar3hmG5O1bIPxmQAkzlUwooFHUE/RtKV7rMLksCoCkkvETsd+gkp0gRzWcT
         9BudWfD46i2QtT2X7ebKH+cRmXzkTBvBdvs/ApwjrUKgvziuNaZw7HSCb/LR9H+3I9yD
         2qAQXWD+koZPHEDPkp6ytdnjSsSguOF5hxXn/UDzZzUNgZU/6ssAmQFkgtViJ/Bqri8Q
         C/UnQ8EvY/ZTz26WcmSF+Glg4njmVyXhxHY7lUu5FppUJVzOdYy9ZOl5ENq+BQ2nf+MN
         KDWg==
X-Forwarded-Encrypted: i=1; AKwUvBxoOOtIcDehjMDV8aHmQSKR3NLjfX486jMICpdoiOF2nfLqWEuzcOhr8o3fOCqezrlLcnT+bPt+@vger.kernel.org
X-Gm-Message-State: AFq9FYKLDDqHKkwIoifJDPBK+oRjJBgko9nM16mElsyasuYfT//G9u1c
	u5i5vU3aIDBUdFqMWWqeQn+C6QjJLKhcfqpSMF6SRwgZQitA8uGUekdUJVzOQ1ghdeiOSkCbREi
	MrresLvXAHQUgk2TdQuhv+9Q7KtMtP+tleh59DALJk5WaEXWwfugyxnPL2Es/Z8Sku2Q6KJVXy8
	dGUP0hZL/pRCpZvkUJO125/0jR2KV1ehpxQg==
X-Gm-Gg: AYBFou0ZZz5VjuH9+FUUxT/vCDKd0gfsZSdcOdUqDBJpg1E5WL0H+Qjb1YzSogJW+jL
	MHBaKRiiqxwUqMSH96tUcaZ8YopAHsLmqQu9aUBiSRE4BbzhaFTZXhV9Wc+MmwXvPUSmtphe+Kr
	2GdMmpv7CwIVonv4qmMcx4Jg7f0Qzqc2RAchEKMz9VvwLZquzYUpSIZg==
X-Received: by 2002:a05:6820:828:b0:70b:a287:72b5 with SMTP id 006d021491bc7-70ba287795bmr4283942eaf.20.1793097612247;
        Tue, 27 Oct 2026 03:40:12 -0700 (PDT)
X-Received: by 2002:a05:6820:828:b0:70b:a287:72b5 with SMTP id
 006d021491bc7-70ba287795bmr4283925eaf.20.1793097611786; Tue, 27 Oct 2026
 03:40:11 -0700 (PDT)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016091628.295119-1-lherbolt@redhat.com> <atoO8FTTt97n5oXv@bfoster>
In-Reply-To: <atoO8FTTt97n5oXv@bfoster>
From: Lukas Herbolt <lherbolt@redhat.com>
Date: Tue, 27 Oct 2026 11:39:34 +0100
X-Gm-Features: AclHuK_m8lZbkotZuR9w7kW9eff4dLNdlzU6LcQDjKpyj2QbDPGB5jhyLJrf5vI
Message-ID: <CAM4Jq_7g1iTimXtGcy91ruEjHHv2t+X2voWiqTdPUY4WEzD+4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] xfs: add test for ENOSR/ENOSPC on DIO into delalloc extents
To: Brian Foster <bfoster@redhat.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, hch@lst.de, 
	linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:26=E2=80=AFPM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Fri, Oct 16, 2026 at 11:16:25AM +0200, Lukas Herbolt wrote:
> >   Test if a DIO extending write into a speculative delalloc region on a
> >   fragmented XFS filesystem does not trigger a dirty transaction cancel
> >   (-ENOSR) or return a spurious -ENOSPC.
> >
> >   With allocsize=3D128MB, a buffered write creates a large delalloc ext=
ent.
> >   A subsequent DIO write at i_size lands in the speculative prealloc
> >   region. On a fragmented filesystem, xfs_bmapi_write converts the
> >   delalloc starting from offset 0 but the allocation is too short to
> >   reach the DIO offset, causing either -ENOSR (dirty transaction cancel
> >   and filesystem shutdown) or -ENOSPC (wrong error from xfs_bmapi_write=
).
> >
> >   Assisted by LLM.
> >
> >   Fixed by kernel commits:
> >     2a9b99d45be0 xfs: pass the actual offset and len to xfs_bmapi_alloc=
ate
> >     21255afdd729 xfs: do not allocate the entire delalloc extent
> >     6773da870ab8 xfs: fix error returns from xfs_bmapi_write
> >
> > Co-developed-by: Eric Sandeen <sandeen@redhat.com>
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > Signed-off-by: Lukas Herbolt <lherbolt@redhat.com>
> > ---
> >  .gitignore                 |   2 +
> >  src/Makefile               |   3 +-
> >  src/buffer_direct_io.c     | 154 ++++++++++++++++++++++++++++++++
> >  src/fragment_fs.c          | 101 +++++++++++++++++++++
> >  src/mix_buffer_direct_io.c | 175 +++++++++++++++++++++++++++++++++++++
> >  tests/xfs/842              |  63 +++++++++++++
> >  tests/xfs/842.out          |   2 +
> >  7 files changed, 499 insertions(+), 1 deletion(-)
> >  create mode 100644 src/buffer_direct_io.c
> >  create mode 100644 src/fragment_fs.c
> >  create mode 100644 src/mix_buffer_direct_io.c
> >  create mode 100755 tests/xfs/842
> >  create mode 100644 tests/xfs/842.out
> >
> ...
>
> Just a few higher level comments..
>
> > diff --git a/src/buffer_direct_io.c b/src/buffer_direct_io.c
> > new file mode 100644
> > index 000000000000..01b19994a2e2
> > --- /dev/null
> > +++ b/src/buffer_direct_io.c
> ...
> > diff --git a/src/fragment_fs.c b/src/fragment_fs.c
> > new file mode 100644
> > index 000000000000..cee4edef73ff
> > --- /dev/null
> > +++ b/src/fragment_fs.c
> > @@ -0,0 +1,101 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2026 Eric Sandeen, Lukas Herbolt
> > + */
> > +
> > +/*
> > + * Fragment filesystem by creating fixed-size files and then deleting
> > + * every n-th one.
> > + *
> > + * Usage:
> > + *   fragment_fs <directory> <prefix> <file size> <delete every n-th f=
ile>
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <sys/statvfs.h>
> > +
> > +static int fragment_fs(const char *dir, const char *prefix,
> > +                    off_t size, int delete_nth)
> > +{
> > +     char path[4096];
> > +     int i, fd;
> > +     int created =3D 0;
> > +
> > +     fprintf(stderr, "Fragmenting filesystem (filling to ENOSPC)...\n"=
);
> > +
> > +     for (i =3D 0; ; i++) {
> > +             snprintf(path, sizeof(path), "%s/%s_%06d", dir, prefix, i=
);
> > +             fd =3D open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> > +             if (fd < 0) {
> > +                     if (errno =3D=3D ENOSPC)
> > +                             break;
> > +                     perror("open frag file");
> > +                     return -1;
> > +             }
> > +             if (fallocate(fd, 0, 0, size) < 0) {
> > +                     close(fd);
> > +                     unlink(path);
> > +                     if (errno =3D=3D ENOSPC)
> > +                             break;
> > +                     perror("fallocate frag file");
> > +                     return -1;
> > +             }
> > +             close(fd);
> > +             created++;
> > +     }
> > +     fprintf(stderr, "Created %d files\n", created);
> > +
> > +     fprintf(stderr, "Deleting every %d-th file...\n", delete_nth);
> > +     for (i =3D 0; i < created; i +=3D delete_nth) {
> > +             snprintf(path, sizeof(path), "%s/%s_%06d", dir, prefix, i=
);
> > +             unlink(path);
> > +     }
> > +     sync();
> > +
> > +     {
> > +             struct statvfs st;
> > +             if (statvfs(dir, &st) =3D=3D 0) {
> > +                     unsigned long free_mb =3D (st.f_bfree * st.f_bsiz=
e)
> > +                                             / (1024 * 1024);
> > +                     fprintf(stderr,
> > +                             "%d files remain, ~%lu MB free\n",
> > +                             created - created / delete_nth, free_mb);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
> Any chance we can reuse existing code in fstests for this sort of free
> space fragmentation? For example, see the punch-alternating tool and/or
> something like generic/186 (if useful, maybe that code can be lifted
> into a common helper).
>
I used to xfs_io to fragment the fs but it tool much more time. I will chec=
k
how it's done in the g/186 and see if we can use common helper
> ...
> > diff --git a/src/mix_buffer_direct_io.c b/src/mix_buffer_direct_io.c
> > new file mode 100644
> > index 000000000000..0af227a7c9f0
> > --- /dev/null
> > +++ b/src/mix_buffer_direct_io.c
> > diff --git a/tests/xfs/842 b/tests/xfs/842
> ...
>
> It looks like we have two mix I/O helper programs here, where this one
> appears unused..?
Ugh, I was doing some rename and I missed that.
>
> Also both appear to have some minor whitespace damage in the form of
> trailing spaces at the end of some lines, so it might be worth fixing
> that up as well.
>
> > new file mode 100755
> > index 000000000000..b2b2f7c493e7
> > --- /dev/null
> > +++ b/tests/xfs/842
> > @@ -0,0 +1,63 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2026 Lukas Herbolt.  All Rights Reserved.
> > +#
> > +# FS QA Test 842
> > +#
> > +# Regression test for XFS -ENOSR dirty transaction cancel during DIO
> > +# write into a speculative delalloc region on a fragmented filesystem.
> > +# With allocsize=3D128MB, a buffered write creates a large delalloc ex=
tent.
> > +# A subsequent DIO extending write at i_size triggers xfs_bmapi_write =
to
> > +# convert the delalloc from offset 0; on a fragmented FS the allocatio=
n
> > +# is too short to reach the DIO offset, returning -ENOSR and cancellin=
g
> > +# a dirty transaction, which shuts down the filesystem.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto enospc
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -r -f $tmp.*
> > +}
> > +
> > +_require_test
>
> Looks like we don't use the test dev in this test.
>
> > +_require_scratch
> > +_require_test_program "fragment_fs"
> > +_require_test_program "buffer_direct_io"
> > +
> > +_scratch_mkfs_sized $((1<<30)) > "$seqres.full" 2>&1
> > +_scratch_mount -o allocsize=3D131072k >> "$seqres.full" 2>&1
> > +
> > +src/fragment_fs $SCRATCH_MNT frag 4096 2 >> "$seqres.full" 2>&1
> > +src/buffer_direct_io $SCRATCH_MNT >> "$seqres.full" 2>&1
> > +RET=3D$?
> > +
> > +_dmesg_since_test_start | grep -q "detected at xfs_trans_cancel"
> > +DMESG_CHECK=3D$?
> > +
> > +if [ $RET -eq 5 -a $DMESG_CHECK -eq 0 ]; then
> > +     _fixed_by_kernel_commit 2a9b99d45be0 \
> > +             "xfs: pass the actual offset and len to xfs_bmapi_allocat=
e"
> > +     _fixed_by_kernel_commit 21255afdd729 \
> > +             "xfs: do not allocate the entire delalloc extent"
> > +     _fail "ENOSR dirty transaction cancel detected (ret=3D$RET)"
> > +
> > +elif [ $RET -eq 28 ]; then
> > +     _fixed_by_kernel_commit 2a9b99d45be0 \
> > +             "xfs: pass the actual offset and len to xfs_bmapi_allocat=
e"
> > +     _fixed_by_kernel_commit 21255afdd729 \
> > +             "xfs: do not allocate the entire delalloc extent"
> > +     _fixed_by_kernel_commit 6773da870ab8 \
> > +             "xfs: fix error returns from xfs_bmapi_write"
> > +     _fail "ENOSPC returned from xfs_bmapi_write (ret=3D$RET)"
> > +
> > +elif [ $RET -eq 0 ]; then
> > +     echo "Silence is golden"
> > +else
> > +     _fail "Unknown error: src/buffer_direct_io error code $RET"
> > +fi
>
> A brief comment above this might be helpful. I'm also curious if it can
> be simplified a little. For example, I'm not sure we need to explicitly
> _fail when we can rely on golden output and/or the dmesg checking that
> happens by default. Also it looks like the commit hints are duplicate
> except for the -ENOSPC specific one. So perhaps we could do something
> like the following?
>
> echo "Silence is golden"
>
> # words about the error codes, i.e. EIO vs ENOSPC?
> if [ $RET -neq 0 ]; then
>         _fixed_by_kernel_commit <X>
>         _fixed_by_kernel_commit <Y>
>         [ $RET -eq 28 ] && _fixed_by_kernel_commit <Z>
>         echo "... error code $RET"
> fi
>
> Brian
>
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/xfs/842.out b/tests/xfs/842.out
> > new file mode 100644
> > index 000000000000..643d05289a33
> > --- /dev/null
> > +++ b/tests/xfs/842.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 842
> > +Silence is golden
> > --
> > 2.56.0
> >
> >
>

Thanks

--
Lukas Herbolt
SSME
Red Hat

