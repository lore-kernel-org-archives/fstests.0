Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6A306480
	for <fstests@vger.kernel.org>; Fri, 12 Sep 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682679; cv=none; b=kkCP8ip7Mu9FrTuoBV8jvk07wD33Pyc4MiYnacPaZBlMBam6zrQIUkiRo4srnTXopZrWlmQ06GFKGWZZ8yxi5y2KyDm02Kvr+/8Ery1AghlsIEuR7BD6UMZSiuFjmHv5xQuYIgv5AX2aiuCwNzuIusG3SsU3aSxytlx1GE2ix4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682679; c=relaxed/simple;
	bh=UMfXaqIVTrjKm7e4Q1IY3tQnRB0piZY9hACdX+C/sdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJ+cHxx7KO+XEz81vwQjFxlk5TCuWAkJtdWFEpHnl7HAA8MnyJ3cretNndLwn0sxHcSoMFZQz/ZllYbDmWS/lPgr97KGYYfeNZTLrn4G/4g/cnssd700623RnM5vuGlle8c2Qp+1J+84UHJ9MQa4bCha8mOsrysqiskLL86Kz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EiTizQCN; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EiTizQCN"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3f655b8ec86so198635ab.1
        for <fstests@vger.kernel.org>; Fri, 12 Sep 2025 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757682677; x=1758287477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0IJTgbxKAf0+RaiQSR2CuSpJwpcWD0Pbtbq7THtV8M=;
        b=EiTizQCNTZwa5MehrcYTsDTN8LdM9yMTDoLTTB5OFLjLZIx4mVWnWBa5eSK3JLrzEq
         MN+C+CA7vr+CFrqIcHfrneIsw5G4vvpk+63AmyHBc8/exWs4IeKXn26xQbQm0i6UHn1R
         +QEvUY96Ny0RST21FdgoEiJO92PDc+EliYqIkFHP+dSyn4aIySHkowzOsAjBBz1C1X1d
         u7VR/A+BeQDj+4prc3RuceWbK9U6R7NtI+95qvkN6yW85NM7xpoCuJhMl5UFnf/iDvIi
         BZbgDYOQfksgGfgSVAQ0/2SrvAESaSIucdqABlaasmGnacJc+XJFzKTYr/VxeYI8SSme
         eoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757682677; x=1758287477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0IJTgbxKAf0+RaiQSR2CuSpJwpcWD0Pbtbq7THtV8M=;
        b=ImSGGuLxyromWZqsWFpFHT74uGztAYW7KKseDw+nn2AILbCIwFy0imQ1FsxOiAo6x3
         aNRIVFcLMyEJd4knWBIDVKhKkCjGZIPvT10c6CSi4J0nLpz7iDpduQUBB6UmfR5w86Mf
         vtj5VIEfGHaEYPtrC82dN8/eXtgIK5pOgEcYDVwodqcUC1xkIDRWmnfZYAujU9zR1yVn
         Kla6wJrx9azXmdlBzmUXwmwKOePqF9ccRwpxNQ92S86/VwIjTV63bDnFqnQqySdZO3ci
         kr4gM0hiVmZ51dsUQGVU+BkidfVKxndYHXBgG7TiaQWurmXJlHtxrFd6uUN3VCKDycNV
         nRcg==
X-Forwarded-Encrypted: i=1; AJvYcCWjTbem6awI7zncnPrHb2x4/uYrJ9+jaDASNT81PTZlBu5PaxfX5XbMVj6QaaHSkpwMX/tRZ8Jb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxac8LE2lXeBlrFFZQqxZ6KF8ZHbfKC7KCPaFmXwt6cM/jhaWhy
	BS0FdrmeelSfYY6vONO7MNZ4/+rzEdmcUIbEa+0Tjs+6PYtkVyL8rhScLo5Tl0OH9unTCmzljbE
	zR87SNqU2Fg8v/KSgJUI5PaC95x1xArnhQl1pLjRruWOwpywH3kkZ5W78epg=
X-Gm-Gg: ASbGnctOS5hjxekwHpyx/IZyOyab9cgdZ3enpEG3/Qys9KdOWoPzGhd/JmWM6+I8ulc
	gdfAqB5oiUZ6urMPJ8lLVbZJkKqaC1w0OphvRm3JTU0iuUJvnSKpqogJCMftOgG5Afyus7Myw1N
	WYCOQB73bz4hVRCWPJO4LMVSNj7SX3/HdxkAbmhuqB6pxBPYs+DJVM1KrJtXnu3XiJJ8kI2/bj5
	n2NuUvjfQdVwd9pRlhCJtjvaG3ysD9Oa/fxfhBFyT+k
X-Google-Smtp-Source: AGHT+IGlE0WDMv18QJ1GxIJR6YpLQWS18GGDDF9+CS2pdyiRL1fHYN1lVxFBGUoHghSIWV5HRhnM7f0a73dNgJeqpiM=
X-Received: by 2002:a05:6e02:160c:b0:411:650e:654b with SMTP id
 e9e14a558f8ab-41655b596d9mr19408195ab.12.1757682676499; Fri, 12 Sep 2025
 06:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904085449.290354-1-jprusakowski@google.com> <20250904173917.GB854551@google.com>
In-Reply-To: <20250904173917.GB854551@google.com>
From: Jan Prusakowski <jprusakowski@google.com>
Date: Fri, 12 Sep 2025 15:11:04 +0200
X-Gm-Features: Ac12FXzhk3ZBJu_QrvFVGQM6mz-r4gD8CC07BuagrfHcLgV3UBDDAxsdFWUhp40
Message-ID: <CAHwWncg9NH4xKD3QZfe8jHtqHZ1==XbX-Rif+rrOObbFnEu3hA@mail.gmail.com>
Subject: Re: [PATCH v1] common/encrypt: Do not run _verify_ciphertext_for_encryption_policy
 on compressed FS
To: Eric Biggers <ebiggers@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 7:39=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
> Apparently this is for f2fs.  There isn't really any such thing as a
> "compressed filesystem" for f2fs.  Rather, f2fs supports compression on
> a per-file basis: the filesystem can contain a mix of compressed and
> uncompressed files.  Probably you used 'compression_extension=3D*', which
> caused f2fs to automatically enable compression on the files that
> xfstests created, which caused the test failure.  But that behavior is
> specific to 'compress_extension=3D*', not to compression support per se.
>

Yes, I used "compression_extension=3D*" in my tests.

> But also, we don't really need to skip these tests.  Instead, how about
> using 'chattr +m' to explicitly set the test file to uncompressed?

I tried that and "chattr +m" does not work as it tries to
simultaneously set 2 mutually exclusive compression flags (FS_COMPR_FL
and FS_NOCOMP_FL). However, "chattr -c" on an empty file works, so let
me post a v2 attempt shortly.

Thanks!
Jan
