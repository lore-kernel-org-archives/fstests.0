Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3742222B2
	for <fstests@vger.kernel.org>; Mon,  9 Feb 2026 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770616534; cv=pass; b=ZTUhfDbxo3QLjpv/MD3sXXhEU657VQsyc2huGpoT6QZfOlhDwxD07DtP+o9rDOdvXDNu6Put52geabVHBTWrW31KXbY8oKOE/HSO/uePeOnNZiXWNNG1igr8sfyCYyVBI8+MasM1/KGrepmerQxZT6RCJsCPsAK8knuQxYy1vDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770616534; c=relaxed/simple;
	bh=T+QOvhsB6nnh3rBb/EQNR/3iQSifJMKBxkesTJz9bMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrJcuhBvfacC/wGziNI1UVqGSlQfK75uYmWcFiaFCtb27f4TXznDO0YO+zqYcpi0aWfxZCaYFr9dCUfK8l+V5sKzK3Ixu0iaHJWjz7VCjy8BNQ8jJp2Ii7bGzopnKa/OOy9ksSB84RIAlOxOyFWXKrwfQmYmbnV3m7jlqmysuTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRBuA2O7; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRBuA2O7"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6581551aa88so7804a12.0
        for <fstests@vger.kernel.org>; Sun, 08 Feb 2026 21:55:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770616532; cv=none;
        d=google.com; s=arc-20240605;
        b=IDWG9MvOM4kuqIKgPpgUauEk2sR0ycDt4Bv3sI/51VgRBOZqhEsHQnraAz14HLzonY
         YjOdEnZ2T6inhoEU1qCsxOJx1kuxHmR2wy/krt0s/uMwgJS6sogaroZ8wvC8lPDX8cNI
         vJQElbKoQK+OdyoSJy0pPIfTgOO3nLmg0jIVm2MGLQPYyaFpuGB9H+enKMF0WhxMyFUC
         p/CRGcQNBvtMYicGocOq04+HOTfMIeAwecmusW2lIIpOudFWreiKpVBTOqxE/YjI1fb8
         OooEqSfB80TK3q5WbGowZjDCTAX3QylaWYNOm+UyIojlK0r3tHu2LacLnURvXUo9IvGB
         UWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T+QOvhsB6nnh3rBb/EQNR/3iQSifJMKBxkesTJz9bMg=;
        fh=X47rxHd8z2NJafsQNVL6ZXp41OpRVRlZwAR+B9xVqNI=;
        b=F1Dzj8YkyO3ZmKtidv7J569iKiLOvDcubezQBR9K+3wC8m6tDFcpTBxtc9Hsdml1Ky
         FP63WxYbpQOTJtgr4Hcp4JuDLdHdt8ZvidBuirQMR4SH0Jgl88Z7EcCmUF66/78hKP/D
         QbZgjVpBbq2Rz5b9oDb3n0ZvYZy29TfZ7IWoe19mzz91WbPfqcMDLG8E7wmDTQGT2HxM
         Iy2bGsB7ZVwEGV4ZtqStXFZpYd5zi3kWyijfqMQC4+lVRLyvE4oYhHEPATmAr4LGLAmv
         AmcnY8SIHd1S9IqyHt874m4uhjnBgeg0T5Gb9OkwffPxN9Qyg/T/GDGhg0bqU0D6//49
         J+Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770616532; x=1771221332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+QOvhsB6nnh3rBb/EQNR/3iQSifJMKBxkesTJz9bMg=;
        b=JRBuA2O7eVEaWWVCtqloGVGieFSs1TvxFbHO8zB8N4HPxZ02pNEIQDR/p+KF2Z9EUw
         VsJ2DXajZ5Ob3iKgdYzO/O+63ewI1ygpFn+kvkmOd3SAIP7mzk1Qfxx9xcC9R26cJoQh
         z5fVYHQl7w4hJWMTNdRlxPGm2fPW3vxRI4I7dMKs0XkA8zArjGwLKotOr1BIn/o9pSMp
         2HGeOmt3vJsV9UJccPImQ9brWRqrk7eGmY8f/cxktJhXW7DNMCYvEO3VcS7kQ3xpJ48l
         xQXIicv8UZraflHSEcTzwCRU8dUYeB0ksHEVh107NlGjr4L25FAVQjr27JPhcoSqlpmX
         qFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770616532; x=1771221332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+QOvhsB6nnh3rBb/EQNR/3iQSifJMKBxkesTJz9bMg=;
        b=LGQk4aN/066V087CTArZYQkIjRtKTcKx1VRi+uQ8ffpknDXXOu6dg/xBlZAVitZWSv
         7HeQh3kPAfjWunAzDCd1/rIg+ESq7r6uoC7MuohU9eyFs1D3MwL9ldLbGZ0N/7z+t/J0
         5RajlhyLngKsBLCdApu93xpLv9D4kypj/gFDpBgAbw8ghM88a9NruCcMywUKC9I16X4T
         Lv5Jg3jo69hgjurttZw0WttIDKNcukAFpTUeWW+YwVtv5uya1RUjcTU+h3ykOncrRxV6
         FYYB78r5wBZbOCg2MeeS5ied6KZENyHtomz3i/PD2WSTfz5+DVyrbnNtzeNP0/TsUCRR
         t/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvw5snma4uLcpwVL2SeU/0p/Kyz/gwtDV7kjgLOiwGaI/rNFJ3RpbN8vTTrYJwts8hVzDI6RYl@vger.kernel.org
X-Gm-Message-State: AOJu0YxmeGsXmaRyEIeFzKt9CQzVXyAWaveV+mPlmJ3bg82xv8Zj/5Ry
	Q3Sf1e/VSESjqj3+Oq+lBpQooz0WwcpcVI2mJZFZGy1DnX5uZglq05Bf1OVX8hEwpvOZBygtW/D
	XOJCZHP+96phohA30ezk8rbPdcVh0Dh7Fx2zmZjNp
X-Gm-Gg: AZuq6aIUhFTEXADVYklfKwtWIPbR6lNev/OotPPIdwv3ln16Vp/Tiu2gih9cJPgYu7W
	vsBE5+HFWVzWrnd6gmgjVorHVTPp/VmkvF+IUlJ0qqrJMWGf+DZ88EfKk4ywBrSmiNcN5vGCojy
	tBTYR3dShw64n8yAJzvMBHsw7D7JB1X4rmy7KmgrfjAv3BaLFjx7OcJ8FJZ6pv7eGUOSQMJg++L
	ZQOdW7mxWuiqjASIsNG0TPTPTBlGCS9Id/GvHXTz+Gi14TOGr1Ct6phEYS7yWu0xNWBvBoS7J9n
	+xYiNF0nlVihdLdDz3traStZ
X-Received: by 2002:aa7:cf19:0:b0:649:8aa1:e524 with SMTP id
 4fb4d7f45d1cf-659a9d1828emr30239a12.11.1770616532212; Sun, 08 Feb 2026
 21:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022501.754320-1-joannechien@google.com>
 <20260110013802.GB15541@frogsfrogsfrogs> <CACQK4XDtrE5P-PjwSqvGtmEmMvEQS4r2KZkDh55LXY2YAoH6vw@mail.gmail.com>
 <20260208195043.vhvkanq5pysbb74y@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20260209015326.GK1535390@frogsfrogsfrogs> <20260209035419.ivosuxils2gnn3lw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20260209035419.ivosuxils2gnn3lw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Joanne Chang <joannechien@google.com>
Date: Mon, 9 Feb 2026 13:55:15 +0800
X-Gm-Features: AZwV_Qjt0fAkperlVyp0uk5iJGAtZNUJexdbTOuM0fhw25LV9L2JU0rcyHAtMX0
Message-ID: <CACQK4XChXe7PoCdCbzSySpc4g_bKRXkyW6zoZtL8eYzV9NzmXg@mail.gmail.com>
Subject: Re: [PATCH v3] common/rc: add _require_blocks_in_file helper
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 11:54=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
> On Sun, Feb 08, 2026 at 05:53:26PM -0800, Darrick J. Wong wrote:
> > Ok, since this is a limit on the maximum logical file block number,
> > _require_max_file_range_blocks, perhaps?
>
> Thanks Darrick! I'm good with this, if Joanne agrees with this too, I can=
 help to
> make this change locally to avoid asking for a new patch.
>

I agree too. Thanks Darrick for the suggestion, and thanks Zorro
for your help.

Best regards,
Joanne

> Thanks,
> Zorro
>
> >
> > --D
