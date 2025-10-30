Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C82D595B
	for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 04:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798705; cv=none; b=pNFWULsvcc35XvQhTcAjBwyX+VuljIhZr+xgJ2yKyNVBTErMdQJyvAoKDaEnDf4SBGQBhwwlW2S7COGoGi9mQ/5E6fdVVNLeSBRslmxp/RQ1CS6jtLvIfWJ4kxAUwDRCxAcDTQp7X6+JYPODfA1ZqfrIPGaSgLmp0umvaE/sdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798705; c=relaxed/simple;
	bh=Q5Xixo/0rzWric77zsl9T6ewMorPoavjmEWf0OCnlhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1ahqZEGaI+Vv5VLK6bVSwk/HTmCSN373SxCHKQj+BBU53MuYo3seEobUKJ0DY88ltJTBZfI9f6AeBeSlRFufUpv6tQ98Yzc9fmE9dzTBX8FTRTz9Kvlxt42pv1gkqSt8xMN1XPn7D/ihz79bGGi5HvPbYztcVK6o+FSAXBZweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YghpcfCj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YghpcfCj"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c167b70f9so6894a12.0
        for <fstests@vger.kernel.org>; Wed, 29 Oct 2025 21:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761798702; x=1762403502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkKLavbAnXGp4iDh4iuLam0UMJbgW4T/KH3f7bMUYdA=;
        b=YghpcfCjVPFb/nO1gVSGNdEP5M1ImdOKHWhFgwlvVZFruTHgQ3VCqX1PJtPQa6Nc5K
         0h6UDkJgap0Uszv1nOpN5p4oWDfTgurNQdrRpyKVoLVSAg/x3MuFFqsEqSoNlQ5dJCcN
         GAm/wo0+fS/MBfxCgBcukXI4H3UtyzwGdV++Cwk5T+E2Ago4ZkMdl6o8jtaT2LgPxJKt
         mdCjHpdtMvVgJDV2hJBFGwJSJOU77PYMEUi6KOYL5tXQ009huTfYHMrC4L2pq0aiz7Rm
         eVnM3iFx9/aw0KIb4Ug6WbW58B0+7oZS7D/vUSmfYNfqTzkPPWT2i2h4YaAordkYvvtw
         2cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761798702; x=1762403502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkKLavbAnXGp4iDh4iuLam0UMJbgW4T/KH3f7bMUYdA=;
        b=KJDDbmTkoCXHBsigXdg6+ZCIz5d/pe6UqqXSOjHyOJlZ1QgG0SBUTuUaDeNa6jABIt
         zqUMUPSR5NfreS/Cpz+YosTkn0V4+hfq81iiQSTwyzNY91ssJ6DbBfh0x4QDwiUFoj97
         A9gaEGnsIoXaMyjCD4Wv6GNJktIH58gRv6sVUMGo0fs3tqSH0A3+Dp1mkdUKlvaA0Nu8
         8drUObKLAYx8abhYutd/p/aANfn5Uh9mzJ98a6+EX9zGLZKecrzlcCjm3nwlZ28bgmqs
         qIBgNHX9LqO1wLkQUDAO89n73qzzmwS08rP1WxSAJtwJie9H6k5B4odAnLovpzB+uTxv
         UmSw==
X-Forwarded-Encrypted: i=1; AJvYcCXyZYd4MoptY1xeGbR06HnNJpzCzEWCEYW8pa3pA8C5uK81p3N+upR8fnj2NMR/KOFN90mg7ohU@vger.kernel.org
X-Gm-Message-State: AOJu0YygyAsED8XzMDgeOyPKE8QvuiRohIG4TMt1AKPjoUr1Fqy/UyIy
	LqVtVmgivn82yKsDsPT3HjYDyZ+DqeC7u8ylggul950u9P0SQgTtZDqQNl48WTpdz4IR4BAchNK
	ZXCoYAV0m0h9U3ACDJheGL9dLJ3BiyOd/URpghsWypopPDJj/N3luiAbK
X-Gm-Gg: ASbGnctC9tiw2HtjGKH6db3wYhu9wRNXNXL/n6usHABGzKiRL79IzpilcvLzudgI4mO
	lMjkJ8IcieSEGbqQNJE81YkT3rhLf1wHSXe9vwuUD+czVVCpZ2QsxbzVYGExOlORuK7tQy27+En
	7leFAMgvJdDkgxCLYEXyQu+Ehy4S8iKeUBDebsnIOVmUWQGBc3oFblrrgV/0rhjoGfN/WFKrsND
	Bm9dV1YA6NPWEOCLsCDTe6XrMG6cD+dHQc/hAb+qbp72jk8qI3+RjOxolkeHKn+zDVWGNmZr/6Y
	e9iTmclvOspDO/FEXB52sDbKYg==
X-Google-Smtp-Source: AGHT+IGSu7+G4WtCEZXo5l3oENt7lnswe7xeyTRaJZa7R94EderqpzhMSFEq5yYmuNdnuUfgtwBO4ipUahHK1HUJgoQ=
X-Received: by 2002:a05:6402:3246:10b0:63c:11a5:3b24 with SMTP id
 4fb4d7f45d1cf-640647b7c7bmr33504a12.1.1761798701754; Wed, 29 Oct 2025
 21:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029093457.183578-1-joannechien@google.com> <1a26766d-311c-460b-b5c3-309750b3f0a1@kernel.org>
In-Reply-To: <1a26766d-311c-460b-b5c3-309750b3f0a1@kernel.org>
From: Joanne Chang <joannechien@google.com>
Date: Thu, 30 Oct 2025 12:31:24 +0800
X-Gm-Features: AWmQ_bl9Kk7zO-zoZQjVf-Uwev0bGo-dC9FUDBDMShCUIL01t-tNuKbM2V1yDkU
Message-ID: <CACQK4XAuJc2ineHw_PbHWb6ogwac_Z4YW+Cas4UPkWEP0+mqtQ@mail.gmail.com>
Subject: Re: [PATCH v1] f2fs/011: use random data to avoid file compression
To: Chao Yu <chao@kernel.org>, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:02=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
> On 10/29/25 17:34, Joanne Chang wrote:
> > ---
> >  tests/f2fs/011 | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/f2fs/011 b/tests/f2fs/011
> > index c21cb586..75679b36 100755
> > --- a/tests/f2fs/011
> > +++ b/tests/f2fs/011
> > @@ -35,8 +35,9 @@ _scratch_mount -o checkpoint=3Ddisable:10%
> >  pinfile=3D$SCRATCH_MNT/file
> >
> >  # simulate fragment status in f2fs
> > -for ((i=3D0;i<256;i++)) do
> > -     $XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/$i >>$seqres.full
> > +dd if=3D/dev/urandom of=3D$SCRATCH_MNT/0 bs=3D1M count=3D1 2> /dev/nul=
l
>
> IIRC, $XFS_IO_PROG is preferred in xfstests [1]
>
> [1] https://lore.kernel.org/fstests/20250326140938.6ll7yeez6iwabvgi@dell-=
per750-06-vm-08.rhts.eng.pek2.redhat.com
>
> So, what do you think of this?
>
> for ((i=3D0;i<256;i++)) do
>         $XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 1m" $SCRATCH_MNT/$i =
>>$seqres.full
> done

Thanks for the suggestion, Chao. I will send v2 with this change soon.

> > +for ((i=3D1;i<256;i++)) do
> > +     cp $SCRATCH_MNT/0 $SCRATCH_MNT/$i
> >  done
> >  sync
> >
>
