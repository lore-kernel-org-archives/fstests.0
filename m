Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30440855
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024833; cv=none; b=MUwrq94iWK+7zacNozVWNJoyaVPvGxkJ2UUeCu7c5/qaOFuHXEWUQYC40aFwGoP5/XIR+H4rbaXWJrMiOGsGWXCeuHBJN4D/qEf6fESChRJ4MYPfNm6kDWTpUGFMbkLF2HkQfNECTZb9auCKFWDeP0rbYChfYf++HLdY7NbpPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024833; c=relaxed/simple;
	bh=4NS4MdoqpEtR0zeXsPovV7vGbJsuvqAdhWKi40Y5DXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPnDhTfueiamKeDX0SAhShxFRotuxkotc9qpGpKUfIYiRXIjShLjyxTLMtiw0AELTFpw58k0kmVXYE6XN2TdYJKe+o2Px3Z39350ojbwHcnJJHiF2LVck3ts+eThHXZuHuN1p6WHIV5Wiiy/93PVRgkK6cZUFF+fpQ2R6n3b+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZaNgfMct; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZaNgfMct"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-424122baf43so143245ab.1
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758024831; x=1758629631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpTj7Nqy+YOGw0s/V38MS7a59oHs6vcqs/ZR8OoDv4Q=;
        b=ZaNgfMctznaODhp1Yiu/9xktkzRJYlJBGhWnSGNiTLpDDgAO2dkvTOzPijKHgbkIO4
         ezZSvBDbhtnhWXhW80cgWIoFygc+8SxoCTNc3g6FkWtgf72JDiiCRZ5+gLSuaffFEFW0
         8yjZzMFwR4QMhxN/okxSyUrIByxuwdSOlL8SmNphIWuCcfj1DjxQtW24NvsWQJnRCoQz
         UhgDVwBYaTrAlUMgi3m34uWSc2B9z5hcH06XloYU8bG5g6Cj58YFWHePaWVksDiYbfS5
         dz7Aza7z8c31RD0OuTy/d0uwqVHaHNzpznUaI9yvOBjuUTJUeGdG/uDZsg3pOTLAUw22
         USMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758024831; x=1758629631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpTj7Nqy+YOGw0s/V38MS7a59oHs6vcqs/ZR8OoDv4Q=;
        b=TOlUBGRiYEypA5CFkdxvBtik/NporRll4tR+6TP77/XN+ERDd3nqU8lNkxaci5K79L
         jA+xQVAizKGI3fp9QphtREJrqsaapRJ9G8Y3OBcFOv3YV7gtQOhXRz9z/ZCbU8KIeEnd
         d4pd8Ow0hUTLVZdff5T9CA65/IwbpgXfKseZw5Mi6jVumXP0f9lpja/Yox43nEmhYILP
         C6l9kpFdnoGrxjLXkGjDyObN74oP56Tk4JDYnFkOmw720AforyWjtxZjHP36GSpkR4M2
         D9oq6ScGlPIYMMu6DgOJoszNp8C49ed/K4oFbNXhADGk+t0FKG0pNvVaJ6hyKN31PRyH
         DJag==
X-Forwarded-Encrypted: i=1; AJvYcCV7JELWAxyyGiQvdkk77t1hW2pp3w+mNFKENwsxnBABLR2OtasDNHym5/vxWPVk8saAWHrFhfbR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz02nd9GPuxEvkhxGDWb43b4vlG+hJmvOGFiEBwGEYgRHmw84Cx
	lo+Gtdzqo3RZR6JJvm2E/Ptr2RMlVI7j42M0XrEWZjI231IDHCpLMl+4E+Ko2rg24pOCGVQY5WT
	ACWSU6mi5YTJW9HBOp27MAiOkmfK1e3hV5ClTJd6LrdupTY/s/0QFZbgAFDg=
X-Gm-Gg: ASbGncvgN8l1lGgt0VW5FOL9+pzcOKmK2AYUOMztJnhC9lXKD7WRn9uf7dwedNmQPOS
	uI5wZP4zjBsSLFdRx+13Zi7j1YLPU2dvdHJkKkGTTiZuiaD0AVXFW3rN7YCNxrYPM2+Xbvsctk0
	6RD73qF7lUlaC2R7RTUjbz/VQMNJ20j6Tm6lFpk2fQ5xpIGtm57p0amp5u8+QEa/Ns06ipi/gbi
	hXoCasNGNxJ8Tf1dB+POcfcPQS8olkZgw==
X-Google-Smtp-Source: AGHT+IG97+gDeo+x5k0gCWuMikrkn4VHk9ftt27Tqf/oLwJjb1o85aamc3nuM83i8Vq8mn2pDTiamRESwoTGzEndy6o=
X-Received: by 2002:a05:6e02:2781:b0:41f:1ff3:a01d with SMTP id
 e9e14a558f8ab-4240fef05afmr4212315ab.17.1758024830783; Tue, 16 Sep 2025
 05:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915100451.810719-1-jprusakowski@google.com>
 <20250915100451.810719-2-jprusakowski@google.com> <20250915143951.GB1993@quark>
In-Reply-To: <20250915143951.GB1993@quark>
From: Jan Prusakowski <jprusakowski@google.com>
Date: Tue, 16 Sep 2025 14:13:39 +0200
X-Gm-Features: AS18NWALWUsumuuOmET2CnM-Cg0K4VAqo5JNSd7sMREwfFAN1usprwK7xm0HEyQ
Message-ID: <CAHwWncjUFzByau+oWh--Q3t-w6FjQ8kWG_fiOyEzLB=HHfdAsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] common/encrypt: Do not run _verify_ciphertext_for_encryption_policy
 on compressed FS
To: Eric Biggers <ebiggers@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:40=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Mon, Sep 15, 2025 at 12:04:51PM +0200, Jan Prusakowski wrote:
> > common/encrypt: Do not run _verify_ciphertext_for_encryption_policy on =
compressed FS
>
> A better title would be something like
> "common/encrypt: Explicitly set the test file to uncompressed".

Agreed, will fix that in v3.

> > @@ -790,6 +790,13 @@ _do_verify_ciphertext_for_encryption_policy()
> >       _set_encpolicy $dir $keyspec $set_encpolicy_args -f $policy_flags
> >       for src in $tmp.testfile_*; do
> >               dst=3D$dir/${src##*.}
> > +             # To make sure the test file is not compressed we create =
an empty one
> > +             # and disable compression first (F2FS won't allow resetti=
ng the
> > +             # compression flag if the file has data already in it).
> > +             touch $dst
> > +             if lsattr $dst | grep -qE ".+c.+ $dst" ; then
> > +                     chattr -c $dst
> > +             fi
> >               cp $src $dst
> >               inode=3D$(stat -c %i $dst)
> >               blocklist=3D$(_get_ciphertext_block_list $dst)
>
> Is adding 'm' (FS_NOCOMP_FL) needed too?  If not, why does it exist?

In my setup files created have FS_COMPR_FL set from the start. Just clearin=
g
FS_COMPR_FL appears to help as now all the tests using
_verify_ciphertext_for_encryption_policy
pass when I run them on f2fs with "-o compress_extension=3D*".

Do you think we should add 'm' (FS_NOCOMP_FL) as well just in case some oth=
er FS
behaves differently? Do you have any ideas on what other FS I should check?

> Also, have you verified that the tests that use this function still pass
> on both ext4 and f2fs?

Yes, there are no regressions on ext4 and f2fs. I checked generic/369,
generic/548, generic/549, generic/550, generic/582, generic/583, generic/58=
4,
generic/592, generic/602, generic/693 and generic/739.

All now pass except generic/369 which is skipped due to no support for
hardware-wrapped inline encryption keys).

Kind regards,
Jan
