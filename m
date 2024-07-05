Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46C13ADA
	for <fstests@vger.kernel.org>; Fri,  5 Jul 2024 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216043; cv=none; b=rixl+B30wE60OZIfbgM/Z5sO37DfXioJyAjCmXFzD9P4ma17Pix+m9J+3hUMG7oWaS4GU6Ls2Z8D/3jibkHUT+wqWlErnJWuCWr+kfqnJNxFrYbD2Ei2qunxXsgDdQOSdhkbsxPW/5CtJQDCL+Wy0s5C9OhONKR23ZrGCtQOWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216043; c=relaxed/simple;
	bh=TyryhmLurPRWmsRX4IwybtRA5P/fAt0ieOkIxRJ12zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eqhko95uiOdtU2AWGQlLuJLLCdeaG5K1rbeYYC4xMtExWS8vVqHQr/iSfgqt2JSUv0fTVsojZox/CiIZS7blKpTSqkxZ3DhPbWvhympCdtQQL9Js8NKd6L9seYnlT+Nv6rMSY8VcuyJMkgwaCuZwLY19ya3LVS0dfxVd+DujBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=Hd9CvVip; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="Hd9CvVip"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a75131ce948so245267666b.2
        for <fstests@vger.kernel.org>; Fri, 05 Jul 2024 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1720216039; x=1720820839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vr0I7jInvOshQC4f2n66IOX0Avxqq48W4PEbS/xWVY=;
        b=Hd9CvVipflSBg3ylx6/PsKMjokr38QjapjhKw23t+AGBc1I1A8n+nvqTHQeALbCAYg
         yFR8kwIS/CxTVXrpOon8chOtp5psgMAfRh7KFKanQqLA3LZz4Tc+G6c4RAVgNddvICQr
         k6a60/h8bV1ehJd1ZXPRI8a0mppQ2rEDq8X4X791yoUCeMB7FujT/n4wWBkvJRT/6Lj7
         oaF19m7nxm8kWO57MHGy1SbfUIsTVkC+zOS0xNDoIDzKpNwPgGJwCKxfSqRJAEjqGjCA
         lPQvBaa4mSpcndMwnGiuYinLgBzIjIboabUaxWtOpJdLQ54wfG0YEzUtvMKAG5rEx5Ua
         IocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720216039; x=1720820839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vr0I7jInvOshQC4f2n66IOX0Avxqq48W4PEbS/xWVY=;
        b=BfCTXC3DAByN5ma23JGti9eMJ5Q6BpKmiPfBMBWiN00zgcJPe76ybp8o1kugLL61Wc
         JAX9IZvY6BBjhPGAirDKd9buaEFFiPO9Kfpjf7Thtlw2YTdD8syD9vqJdB77GBvYDA6J
         CTaEr04fnDQDh+smYV+GSkXnh60gxUWF1ufSYw9xkR3obdrE3ZsvFLavUNmgFx98hZ53
         8Kyfis5CTDtAkYkzgAGOvCUzhLEJcCu1JOMSKqFYbIV4B/iT5E60vxbdy4Ce5wDnPWaq
         SSd1E4SmQQW8uAuXly8bWOSxfNcdSJTGb25JLuiWGURcqRQg+cuYNDlQ7zg5A1zQ1jVf
         DMSg==
X-Forwarded-Encrypted: i=1; AJvYcCXW7FWx9Y4850pK025yAhbOELsZnA73ulf0KR3CQfdbu74fnrVh2/fB0LzmYig11ewy2hhyCQYD2wP9T15a9JvfTxuVM0zxJQ==
X-Gm-Message-State: AOJu0YzDI5rmnYiZ7RG3xRDSCVS2+ubH9flYMDbKpQ2xCSiLX/OYsQZo
	6NO7FT/FGDoji3Ml7HhOg2YCUTUUOlzf69sfqPToYlX1o8XZrbv+RRwpWzWcQh5DWsxDUVJxqvP
	tfcttCiLe6iI9uci4pwjFHuJHMoehg0vuxoB83g==
X-Google-Smtp-Source: AGHT+IEH79iielZwOo/Saub6Wsuy36bzwLwKn7SbUysTWq3qcA6vg2hM0mk9vYjpFYDrhuZnhfwXcU21TeQ/Shywx2M=
X-Received: by 2002:a17:906:c8c1:b0:a77:c5a5:f652 with SMTP id
 a640c23a62f3a-a77c5a5f764mr287763366b.26.1720216039278; Fri, 05 Jul 2024
 14:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
 <20240630-common-fixes-v2-2-16d26fb1dee0@samsung.com> <20240701223628.GJ103020@frogsfrogsfrogs>
In-Reply-To: <20240701223628.GJ103020@frogsfrogsfrogs>
From: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>
Date: Fri, 5 Jul 2024 23:46:53 +0200
Message-ID: <CABj0suCz-JDfPzUO7NUQXsxkE+9+TTiUAeXDb7oT_Y2eQRAdhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] common/rc: add recreation support for tmpfs
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: da.gomez@samsung.com, fstests@vger.kernel.org, 
	Zorro Lang <zlang@redhat.com>, mcgrof@kernel.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 12:36=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sun, Jun 30, 2024 at 11:52:41PM +0200, Daniel Gomez via B4 Relay wrote=
:
> > From: Daniel Gomez <da.gomez@samsung.com>
> >
> > Add support for test device recreation (RECREATE_TEST_DEV=3Dtrue) for
> > tmpfs.
> >
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  common/rc | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/common/rc b/common/rc
> > index 163041fea..51827119c 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -604,6 +604,9 @@ _test_mkfs()
> >      pvfs2)
> >       # do nothing for pvfs2
> >       ;;
> > +     tmpfs)
>
> Indentation problem here.

What's actually the format for indentation in bash scripts across
xfstests-dev project? I see a mix of tabs and spaces everywhere. For
this particular _test_mkfs(), I see:
<spaces>overlay)
<tabs># do nothing for overlay
<tabs>;;
<spaces>pvfs2)
<tabs># do nothing for pvfs2
<tabs>;;
<spaces>udf)
<spaces><spaces>$MKFS_UDF_PROG ...
<tabs>;;
<spaces>btrfs)
<spaces><spaces>$MKFS_BTRFS_PROG...



>
> > +     # do nothing for tmpfs
>
> If we're recreating the test filesystem, shouldn't that unmount and
> remount for tmpfs?  Or at least rm -rf everything underneath it?  That's
> generally the effect of _test_mkfs for disk filesystems.

I thought this was already supported. When I enable recreation, I get
the following error:

./check -s tmpfs_huge_always -R xunit generic/003
SECTION       -- tmpfs_huge_always
RECREATING    -- tmpfs on /media/test
our local _test_mkfs routine ...
mkfs: failed to execute mkfs.tmpfs: No such file or directory
check: failed to mkfs $TEST_DEV using specified options
Interrupted!
Interrupted!
Passed all 0 tests
Xunit report: /result.xml
SECTION       -- tmpfs_huge_always
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Passed all 0 tests

So, adding the tmpfs) case to _test_mkfs() just lets recreation go
through, and mount and umount when the test is finished. I'm not sure
if I'm missing something or maybe I should rename this patch as a fix?

>
> (That said, I'm much less familiar with non-disk filesystems...)

When umounting a tmpfs mount dir, data is lost. So in the recreation
case, _test_unmount() would take care of that.

>
> --D
>
> > +     ;;
> >      udf)
> >          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
> >       ;;
> >
> > --
> > 2.43.0
> >
> >
> >
