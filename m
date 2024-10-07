Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D81D223E
	for <fstests@vger.kernel.org>; Mon,  7 Oct 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303288; cv=none; b=MMzEh13lRbeG81hkM1tLSzw3Zsjn97YyOLq75LsWwI5wiBedafTM+uhmCXcHpCAoDz75c3sjViAEQY/XFD8pAmPXHubajSKP9Zil6LNHGmMY8ZdU8qk+kyA7yF9fFNQYE9bSCEmtCF6VBZRuze5+wbbWsQmoRdtF5iFMMSm6w0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303288; c=relaxed/simple;
	bh=WwESGIiIGtQuXOpmTVCXNS5pPNT1KSq8VLA6Ob6hRNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubMF4yPBDaPPBzCNwCQvC9vnHgpSN334tF11qE/cQ8gfmLWx4gTO11+o+cotQPn7mWuokT2VQ7sp37V2Em+OopnLTMqrRXXBYcz+SWc2MorC31ADAdentZGQPaiR6cMSoOvTfrgsL/UWvcmTe2Q7lINvt/2HbTdC+FV7M6/o8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPYZ8FEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPYZ8FEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58A5C4CEC6
	for <fstests@vger.kernel.org>; Mon,  7 Oct 2024 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728303287;
	bh=WwESGIiIGtQuXOpmTVCXNS5pPNT1KSq8VLA6Ob6hRNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JPYZ8FExl0oeD9iF8MrTmrOq5oY8yV9WiaJTEAlz0xD4GpTp6HwynyiqiKZBW69vX
	 VJmaLKWk/QB+prCTdIs9UWzjHqm507Cppb56Z9tn1YjNZfj9olK9PWW9+rXq9fcQzM
	 EtefBbO0AsIixSLpCmhUB8ekqB76X4/AS93l3OtQfeTAKxZTQQ5CQRxaMEAcG8r/Dm
	 gEcVQVkmCBwGccdJzuy7wGEn42FgWp3YsaoNnhH3fRq5dtVJjTRitjVXZUeXtnpZa/
	 40iPlnch6u+8vMnkeQJbnkL1hNOS72s0oXh+a4udyNdTKfeOLTe0fu1ntPqDraHt2A
	 Z0fMQyChYK09g==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso58267465e9.1
        for <fstests@vger.kernel.org>; Mon, 07 Oct 2024 05:14:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6D4fFRJqw49/6tLX0Yc3juCT5icgpc5FCN3GXduGSykc8T9CmLLOF3r1fg9xAVyEqZxmvagRj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7k1qlj3v1VriAn6G4R5PltD5mVgPqcp99Cn1g0wagT7zHB+Z
	lzFHYvyspUUc1W+nfo1YIzD0NKSNUudxQwYv2QVU5Hp0bHmbIWNbuGakm5yoV6n3Ua1SAWYFWJq
	44mT+32DR3tfNvKRVg7tlsN7ZLzE=
X-Google-Smtp-Source: AGHT+IHAQFf90fB8bV2rFCGhjIdwLssAJxndr6s651Xv6G5ETM+OsMMfBJZHE+PGrX/3idCAAHcFmoKwM6r1nHsL1R4=
X-Received: by 2002:a5d:69ca:0:b0:374:c3e4:d6b1 with SMTP id
 ffacd0b85a97d-37d0e8dafefmr10174720f8f.44.1728303286350; Mon, 07 Oct 2024
 05:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923090607.953579-1-wubo.oduw@gmail.com> <CAL3q7H4dthnioL3m9ejzp8sNOeaYLZpRxd2ciEi36uuZSxGoLg@mail.gmail.com>
 <20240923134603.cs5u4ea7bnaarnme@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240923134603.cs5u4ea7bnaarnme@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 7 Oct 2024 13:14:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4MVxFMU1LqESrnACc28sHhUaPvy4_FTP0qh4qiEsttSg@mail.gmail.com>
Message-ID: <CAL3q7H4MVxFMU1LqESrnACc28sHhUaPvy4_FTP0qh4qiEsttSg@mail.gmail.com>
Subject: Re: [PATCH] check stx_dio_offset_align to determine if DIO is supported
To: Zorro Lang <zlang@redhat.com>
Cc: Wu Bo <wubo.oduw@gmail.com>, fstests@vger.kernel.org, 
	Zorro Lang <zlang@kernel.org>, Christoph Hellwig <hch@lst.de>, Wu Bo <bo.wu@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 2:46=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Mon, Sep 23, 2024 at 12:01:22PM +0100, Filipe Manana wrote:
> > On Mon, Sep 23, 2024 at 10:06=E2=80=AFAM Wu Bo <wubo.oduw@gmail.com> wr=
ote:
> > >
> > > According to the statx manual, if stx_dio_offset_align is 0, it
> > > indicates that Direct I/O (DIO) is not supported on this file.
> >
> > There's already a patch for this:
> >
> > https://lore.kernel.org/fstests/20240911035333.364961-1-chao@kernel.org=
/
> >
> > (but not merged yet)
>
> Thanks Filipe. Yes, this's fixed by Chao Yu. You can check it in
> "patches-in-queue" branch, it'll be merged to for-next soon (this
> week I hope).

It missed the last update and it's still not in the "patches-in-queue" bran=
ch.

Thanks.

>
> Thanks,
> Zorro
>
> >
> > Thanks.
> >
> > >
> > > Signed-off-by: Wu Bo <wubo.oduw@gmail.com>
> > > ---
> > >  src/min_dio_alignment.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> > > index 131f6023..c50ae8c3 100644
> > > --- a/src/min_dio_alignment.c
> > > +++ b/src/min_dio_alignment.c
> > > @@ -28,7 +28,7 @@ static int min_dio_alignment(const char *mntpnt, co=
nst char *devname)
> > >         fd =3D open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
> > >         if (fd >=3D 0 &&
> > >             xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &st=
x) =3D=3D 0 &&
> > > -           (stx.stx_mask & STATX_DIOALIGN))
> > > +           (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_ali=
gn)
> > >                 return stx.stx_dio_offset_align;
> > >
> > >         /*
> > > --
> > > 2.34.1
> > >
> > >
> >
>
