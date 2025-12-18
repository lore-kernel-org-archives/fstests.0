Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB432C95D
	for <fstests@vger.kernel.org>; Thu, 18 Dec 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059389; cv=pass; b=gNr1ndTdl14jPuMzrVme+e/46QVV3eCi5nBtTgpIz8eGY4VsOmPkmr1ZO0gVOmehhssQb7IKulhElsK4NNLSLpaduqVB9kc3/WjHNG56EL/qVoFWwhaefW4TzL1ZAN1nnyAuMDqlWq8z8pK4Z9++PO2eGoeGtY8F6g1lMhVeTMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059389; c=relaxed/simple;
	bh=mP8iu4svrEbrf1yL4ZQrNMH8UoxGEc2xHweJaF21/6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KASsiBnhaxebHUq7Dae36k/ioQvyNwHEbM7qQr3icNzo8KtFHtj+RD1W1Oh/+d5s1uu5bUXz92FDykK8ouRaYazu3ilIo8K/By1pIEglFnkUQN2NUza9HL9dt/an1N42jayvFKnG+J9bsldlmz83TTxjGZmhAXhCIdJcTshqbRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DYA3TK0; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DYA3TK0"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b5b56d72fso7830a12.0
        for <fstests@vger.kernel.org>; Thu, 18 Dec 2025 04:03:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766059385; cv=none;
        d=google.com; s=arc-20240605;
        b=QCBIvB5iWfbRIAgUns2/24V/8q9hdFDLu68/X8g1qf+mW6CUvQBF0CRZvWNnGGw8Hu
         lK3uXFtZaOINsTtLW3l7didhsqM4lcnZgxNPSuDvsKoqnWMe/0CJmaoPTdUPB7ZyRyJ5
         fPggIuU8Mz4acil5t/uaWgg0QTeYXAzjHtRFEs+0t8cBSkrg9W1YMsBxB05RnHbcCgfK
         B2ZVd8NpPUwcfpMUTUvWK01E9f3khSQapDSttFPypo3ijFS+sMEHdEHASiJNQi10o4Dm
         4DfcGr7aBn0dkMpbFbmfYk3wx2EXaVt+SCnDbA8A4zOlg6n1awDGtEB0o9/WrVQJ16bm
         pw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5f0Los8TIfwZ6I+bU9OjJEoJQfpjdMKPY9skiZET7E=;
        fh=ORVgTuZ5oFEY10IrqtwRVxTH2ujm3NeMkPxFdj3+c4I=;
        b=knHnrZUu5gEv9DyOEZuOgtxjvINSyrQrZm209+jv7Ke7n9tCL1HvEqd8xmrTyFDI/0
         l3ecrh46GDuUjqrvw38wxjy98H/TpaAZXbYT8niy6Ok2lzWK3/lbyRZvk6y6ILOS8LzW
         VPaxilMpcyX05P6ji4+NTWxggiIZ7bFMxPX9it1P/ZcxqOfE3p7Rt3tnZozSbPqQ/V05
         LO9ZBEYfXuONbenR8PE0PkS1C26iWi9UERKktXdvLqhiHMnn+b41G/8lKeWjIHWnEmHP
         5xr6Gnoog0fYDwPHiIZBriBKMgL4gB+iTxErirI0HFvuekTmbPvAuEvmlJsTp+kLgdmC
         GHpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766059385; x=1766664185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5f0Los8TIfwZ6I+bU9OjJEoJQfpjdMKPY9skiZET7E=;
        b=0DYA3TK05QU25rrV8nKPapedb8I71XgIy5SQeDwibQM9L1Yte7zWpffOFNUszSWHid
         1Vz9Fd2czqQ7NOnYFl0e6JHL4TdeAl/U6EiwjNQhLlbD5Of8U5sLYVLyTF6dT1RS4Qku
         dy7k0slrkmJHb0MWCIT0TTeCReLlK64eALDlOPWiaXTcxLOemZFoo4KRX1T8PaaAdbdA
         LIF8qtZbA/7xcR46ZeI+ZDDIfqGN8LuurO7hN+3gFoDhHzf8SJEbLIBt/mNik6Y/t7cb
         6g+XaQfWzdt2DqnGq79dEj/ejK14P+H1qXuHsQQSoK+IyvvCfgnsLUpt8WXNJTZwOZgv
         FS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766059385; x=1766664185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5f0Los8TIfwZ6I+bU9OjJEoJQfpjdMKPY9skiZET7E=;
        b=uhyo1iQUPfx149whUZLLR+NTDsJRXqq/mCZonWi4bzkTKXaELAflP2ed/lnePCtlmE
         IRGYbxZRVNKrv+qCYs20xzbG5oVKvPaQlIwPplSi4nwSN85f3WKcd8KtwxtC7S0GelPv
         W5PbcbJcAKR9csNURKlJ0lF9u8frvHEmohiZYSQIl4zUbcnGmwOfxrpYWqdWZLcpZQAU
         ZLKTO/Ime29+DnojjIxAD8p8ct3a3/DfX6ofZyRJ5muxrQPC9lijtltIe8QrOmKTvltK
         uRRSCrv7QXF3Ppwt5t9c6Q6Vw9gVC69U2aM8mE08CSuFjmHFuCu9xLxUtqcfM1lqZn/V
         Ig8w==
X-Forwarded-Encrypted: i=1; AJvYcCWCZty8xVsICfvy/FsmoMSbF1/D8U5dZwpj/ZtTNYUnijHJ2xpGhdNTGBeRY25lzPOeYLCYPHeM@vger.kernel.org
X-Gm-Message-State: AOJu0YyhW+KPvscWReHTJh7OKagiyyj9KS4x2n7S4MThfWShXnsVJ/Oq
	4Xrr8O0xofwsLRJaKZ+VMD+eX6+lj1/KygAbK8pkvaO+XTnG/oBn3qwYPgabAuTzIUZhfgd5TuP
	lfDvGYbMVabtwX7m7LmMC8Hwt8grV2dux86y4fMNC93C2bZyOfQPHtChgnbk=
X-Gm-Gg: AY/fxX6PKBk3ZwgXshhISm3PtICQyooPVa3bUL6V79zT+WrMsKf745SmJAqrK880ATE
	X/W630YjdojQ1qSkzSFrfMfpUfhkoJ3u0CMSFUm45U41hDcJsi+wk4jsIi0s+GiSLyYlCKauh6Y
	UnVWWshtzN3JFSrm01uHa0hJCU+YjrbP6HYw3gMqpwptQ20dBXC4Fv8gBWukqDoeRTdMoSPcz1z
	xMi56cafN4Oek08yEj46PBvSQOjerlbFcN5Awx8bsQRQ2B1DxY20PAAL32GDZeflCMKFuPd
X-Google-Smtp-Source: AGHT+IFJ02n9HG7gHpb3OvXxNi0WUK9s0eJSibwmgJur1Tm6CGtMCTmGxYjY5HV1fc1U/usflmU/YZy0Ywy7MzklOWA=
X-Received: by 2002:aa7:c858:0:b0:645:21c1:97df with SMTP id
 4fb4d7f45d1cf-64b605c3f8amr36323a12.16.1766059384716; Thu, 18 Dec 2025
 04:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218071717.2573035-1-joannechien@google.com> <aUOuMmZnw3tij2nj@infradead.org>
In-Reply-To: <aUOuMmZnw3tij2nj@infradead.org>
From: Joanne Chang <joannechien@google.com>
Date: Thu, 18 Dec 2025 20:02:48 +0800
X-Gm-Features: AQt7F2qXO-63qBkLwjeS549hjhAyjI3um9kG3vW6Wlf8zSxWbXgepGaaDZ5QoYI
Message-ID: <CACQK4XDtWzoco7WgmF81dEYpF1rP3s+3AjemPL40ysojMztOtQ@mail.gmail.com>
Subject: Re: [PATCH v1] generic/735: disable for f2fs
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:33=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> On Thu, Dec 18, 2025 at 07:17:17AM +0000, Joanne Chang wrote:
> > generic/735 attempts to create a file with nearly 2^32 blocks. However,
> > the maximum block count per file in F2FS is limited by the capacity of
> > the inode. This limit is roughly 2^30 blocks, which is significantly
> > lower than the test's requirement.
> >
> > Signed-off-by: Joanne Chang <joannechien@google.com>
> > ---
> >  tests/generic/735 | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tests/generic/735 b/tests/generic/735
> > index 9bbdf3a1..d5ba5673 100755
> > --- a/tests/generic/735
> > +++ b/tests/generic/735
> > @@ -19,6 +19,9 @@ if [[ "$FSTYP" =3D~ ext[0-9]+ ]]; then
> >       _fixed_by_kernel_commit 2dcf5fde6dff "ext4: prevent the normalize=
d size from exceeding EXT_MAX_BLOCKS"
> >  fi
> >
> > +# Block number 0xffffffff is too big for a file in f2fs.
> > +_exclude_fs f2fs
>
> Please don't add random file system excludes.  This should be
> abstracted into a _require_max_file_size helper or similar.

Thank you for the feedback. I will implement a
_require_blocks_in_file helper in the next version. As far as I
know, there isn't a generic way to query the block number limit
across filesystems, so I plan to hardcode the known limit for
F2FS within the helper for now.

Please let me know if you have any further suggestions.

Best regards,
Joanne
