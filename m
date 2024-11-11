Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF671BC58
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338589; cv=none; b=HuFA6cDxHPQQ0d9l69SEK/I1Ny7amzLg7wRubSN5uwkjgR0qt14cxFiuyKgP/C2H6gGURBC3KYm6CVPRy9/RO3kgCkJoNV10GYVdBrj+5zIcVCULNXGMdILf7cR9kqaDd/oeH8oEA5x3v0PepaG1IWQLjKJQZLk9SztX2GYHkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338589; c=relaxed/simple;
	bh=VmivZvdWo5vK0AEQoKT7CGGAfs/DlxatoWf68eA/sHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRV2lbyDiOx6YXEa6GF79snpvQ5HViXJbZFkgUrNz+sYIi1b4ldQGIrlJ+77mGYV0Etb38dtqtv2EBXAtw5T6FRUn+ZLYNzHuapheWBSBiKzY+bPSQjIMPv3WcZYN8un4bLj3hSghepJXloL2WOJp0hS3F83Ckw88fMCKyIwIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=V2jzUvTz; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="V2jzUvTz"
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8D8483F185
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731338585;
	bh=Omjsq5eJGa5U/n+iV9tiE7ASNFekvkkDtDvd6eham/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=V2jzUvTzb3JMmCmleScUqSk6Aw+S5oq3IhgI0X0GS4KFoilt2XXu852POAeZyJE8a
	 YvBxDeUmeni2rP4z448DtSxOCKBVyMXsF4vmSDnMvdrMepArW9yTWofRpvlFXV9eeU
	 RaikweQItfpN4fZN1F3YdoXWJjGUlxgb2yVpEwkOMN7whJy8LXI0j0BjintHyZw5OP
	 Ocr35N6+olYOiub25B3KrrEVg8lacsWxoAtg1xVDgIVwH6DF2vmdGPO2Nm+Atx6QWR
	 RtxSps7h39rHiujOAha+3hy32Z+bUOLdeDpRl5QI1VOiUMLQQicGaeJlhYco4F52iu
	 2wtEUW3tFyL5A==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-294cacd9218so4490462fac.0
        for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 07:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338584; x=1731943384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Omjsq5eJGa5U/n+iV9tiE7ASNFekvkkDtDvd6eham/E=;
        b=nNlreY+app8hrMlj/nBCvoJW3uQsrSUA5Kg/rA9Y4wWbKAUAVVUTQSxabmSbv6UEI7
         Y7SxwmW3dJtlEYM0MoQZcjqDC48MoIheGmuR1Nhamm4N03uH2QDsGaMdxTl6B2QL/9hK
         5EAbHBVkuKa+5QwS788bH8Btr/KdXkPyazbB2mc7G4UK9wrDBEcKa1UQrCbPUJGXgC+d
         BbCTZdBEy/FwAMT3UwjgiQgwuRJx8JQSvhFoC7K6r24XjHMFXNLF6AZd4+aP3fGy0jo/
         8dg+avas9LEiuDowskHpWWyVXT04dA01Adl6jZGktMDJaQiHznxI4OYQEo6kz4U5Bn3e
         oigA==
X-Gm-Message-State: AOJu0YwdPOohsMbSLU8u48WL0ZIgFv0bBk3s8bv67987MNgyzdW+Q9I5
	beNRMJv9T0rPIQMKPUsTf+gr2t51Gca0Io4gSyseEvfPnfBI+EluuJl6P17K9Aeho3Hj7Dt0/EE
	YWWDO2n2ZsmHUctrIqqjuyvN4Ask5DfJf1t1hdygLUtOebrMxdJ59KsvNv4v0ZP6wsT0pJLpyi0
	Xr75EVcDbDGk6jlNVsvjnbOAs2eykzff3FDk7Wzx0WQnv2bQ==
X-Received: by 2002:a05:6218:280a:b0:1c3:89d4:e888 with SMTP id e5c5f4694b2df-1c641f40665mr502903855d.20.1731338584407;
        Mon, 11 Nov 2024 07:23:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMkRBV5laH6F6F0zmH4P6+rP5S9yHqymVKsBl9DIaOzkZ3owfdUraaM4bxTBR8r5n6WezVG9MP8/x4XKLdGss=
X-Received: by 2002:a05:6218:280a:b0:1c3:89d4:e888 with SMTP id
 e5c5f4694b2df-1c641f40665mr502901155d.20.1731338584114; Mon, 11 Nov 2024
 07:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com> <20241109120156.lipr33ykp73lzsxb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20241109120156.lipr33ykp73lzsxb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 11 Nov 2024 16:22:53 +0100
Message-ID: <CAEivzxe6f=g8SLNeMayjL8o_bhbmJb5spZPP7LVcbro4Em2VjA@mail.gmail.com>
Subject: Re: [PATCH] ext4/032: add a new testcase in online resize tests
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 1:02=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote:
>
> On Fri, Nov 08, 2024 at 02:48:17PM +0100, Alexander Mikhalitsyn wrote:
> > Add a new testcase for [1] commit in ext4 online resize testsuite.
> >
> > Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libao=
kun@huaweicloud.com [1]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  tests/ext4/032 | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tests/ext4/032 b/tests/ext4/032
> > index 6bc3b61b..77d592f4 100755
> > --- a/tests/ext4/032
> > +++ b/tests/ext4/032
> > @@ -97,6 +97,10 @@ mkdir -p $IMG_MNT || _fail "cannot create loopback m=
ount point"
> >  # Check if online resizing with bigalloc is supported by the kernel
> >  ext4_online_resize 4096 8192 1
> >
> > +_fixed_by_kernel_commit 6121258c2b33 \
> > +     "ext4: fix off by one issue in alloc_flex_gd()"
>
> We generally mark this at the beginning of the test, not in the middle of=
 test
> running. Refer to ext4/058.

Hi Zorro,

have fixed it. Thanks!

Kind regards,
Alex

>
> Thanks,
> Zorro
>
> > +ext4_online_resize $(c2b 6400) $(c2b 786432)
> > +
> >  ## We perform resizing to various multiples of block group sizes to
> >  ## ensure that we cover maximum edge cases in the kernel code.
> >  for CLUSTER_SIZ in 4096 16384 65536; do
> > --
> > 2.43.0
> >
> >
>
