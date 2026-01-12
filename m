Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17725524C
	for <fstests@vger.kernel.org>; Mon, 12 Jan 2026 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188055; cv=pass; b=elllQNg3aJQDZ4lKkmClfwdqiz4E5JCh3cU1I0Qrl6+Qdkzc0cUQ0Yq+nGMJWiTnQEC5GbmMGV4voC/DrvHMiygujBvkpZ78MC0+1S6BnEB/Hup5x6O6Vv9QrDIkGm7Jitz/zE5ycaVc/iWl/tlAk+WiQ2gh0i6Ek0BQgsHSm78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188055; c=relaxed/simple;
	bh=ypit5LN0AhzIXxFTH9nmMYl4TUA3DkPDBkLLpdHYQwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmnxHVvw9HCwb4hG7hGgZLEvsIqEK8Cpzqn9w3K8ceg6laP78xJdeOWO35s/fzDLoQjWPYEKE6vS3S0jFZ/7DANxVVP6S/mR5HTZn2genaT6dMphL+XsBQ3wPRa0ETfXl76eZiIlp25iwhs6pt7PvftNocWd+zA3mLQG2D/Gg2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1bFT8Pxg; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1bFT8Pxg"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so7605a12.0
        for <fstests@vger.kernel.org>; Sun, 11 Jan 2026 19:20:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768188052; cv=none;
        d=google.com; s=arc-20240605;
        b=MRnT4Hbg4YGqhehK193zwcvZEoDQyIFo0E2//UUjnsMM1W+Xx77//bTbKL0ar/I2po
         0JS4FbrUziH9Rf/OcjGcibIuDrIz1aMJMdGekFhs8IdYpu/R4SI+quBVQHLl5WnCCmua
         y7tXMUUCrlggkOAh0woPvwQ+s8fi3BlHuvsCTNknsmZCTfgnfC54EqCqerBJnDeCKt5u
         J0l2Aqox1FSdjqAq2UW1becHVDFjR2HBsZGf05mvuxn/WnPN8aLSyvkRncZdudCnOss2
         Ql5ZxjPm+EYoFhONqjofCFy3bD6DhZu6esGffY7q6RsOw7cmg2hIiK5aNFHtPpg8zJBz
         Vqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EiOwJsS2Mb41IcQigwv6qcMuzuTrJ+f/o5v4xhTPl8s=;
        fh=t2Z+49nqvRkCyTdNBdlmMldCxsjDaDsfEezpd9Lvzrk=;
        b=X9+crSo4KNSUe7Rc76pidXhFq9ZHavDgRFNNJlvcx2aYksyaS1A5DmrokAwOckh6IN
         3TsqBvkfpa9S0DI8IHA+nlwHGD/SvVhAndstTwl9+VDKnlDh6ArfrLBA1vvy7lcCwqTZ
         FvPPVVkwfX3ttO9wUG2Vcg8VK8OEhrOAP6GLIuTp9W02BVVFOumOGD82CAFL9uL13Fal
         r60ogMLt89NCVf3aLI78dCeGn7wmtisknpSUv7zq6rbAqW3l4cm/SCxsiwIcPLG51hIT
         efRj/CqxkAue8HL2LHx2knIdETsMYal1x8xbA3cYHmGkjQjhY9UN+to1SKCBxkVI4uY3
         1f5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768188052; x=1768792852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiOwJsS2Mb41IcQigwv6qcMuzuTrJ+f/o5v4xhTPl8s=;
        b=1bFT8PxgeRrrxO/F/N2dGTY2IOJSfCffdXHkHvtlDnRWV1L9c/iFuaD9/x791CPeW/
         uL+gHgRJ18jrgo5pexPZn5pFBwPKFjxnr9qUotb3qn/plAQ5Pn93gyr353wHxKuttD2n
         cIjTKFwURkDRD2ZHeeiR4VndGr0rbnLLUDZgVz4Tv+9aPLRDQSo9zLV4t0aPdX9P6QA6
         vMsDwP64BC38onNB/NNP7lvLQvMl1E3QVAgVh7LEcc41qwRuWlVBOlgJ7pr/UnmpVs+v
         eiywOVwRtA9roRajY1SdlHpLBPbBmR2c+abMOmIzsx9RfRQvkb9k2m+9mWTJNNVO9Ios
         gHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768188052; x=1768792852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EiOwJsS2Mb41IcQigwv6qcMuzuTrJ+f/o5v4xhTPl8s=;
        b=lRuKsmLNTCnlguxq+I0ofJw3ltzvi+WOEfm5R5dWoxBwsBsa5wD2zn8WBPvbgg4Pzj
         fZ8XafLhQeYFUdXrSdW5KpLMHe+CoHNEhZn+3Ad9ns7LcufdH1FnOwVO9EIPfU0w5m6b
         kjDR5m+JBK+izC6zJQBMtOIzWt+8zLXxK6gJDkmSrUug7K5uQQ9Vi6Q1TW8DcIlUCNVV
         E6Q3L3aVENXftEK8WyOhGvTx9hZck835w5QtUK02xYROdkkEBrBdyyo0kVk8LTO+iqiP
         WVbmDJtN/xJyhamCZ1tunwfLDOh2TNIv88l2Bqhq/jMMOdeFyiwRsM87JPlorTfsy4o5
         OxvA==
X-Forwarded-Encrypted: i=1; AJvYcCXR3m1dvU8BP5gaQDvIr11MFr/FjTZbYGQTRiNUaeXJkeDbHC/M/8uUWaOnxKIhzfo8M2C8WXg+@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVlt9sw/RTWfiguLEyhc4ZZQ0gt0/sAkxwfLyD1u26RiqtcYa
	X3ACqnkgz/8w0aXh0AqaXw5r5Rxl1ZhLD05zG8JILaGkq1nyrVwXw/micy7f8o4fOphqrqYpHmn
	O/3FHH+UjZ3yrIEnV537xtS5JyVOHv4z7jwklCTq0
X-Gm-Gg: AY/fxX5FrU9QR3jEGPyP4YgLpDI1u5n9H6yCWIm5JhDhBEsc70k5yLZpIY+irAsuq/+
	2gj9UFQ/mTeras7cMCSJUyF9L6Tr+4ZXWdOPV9G80UXp/8Hso2BwkJLVWgXt/7vaCPHXaMHtU4n
	zzwmC6K3WdHySLkZTOHaw3DEovcjeFWCWUpDQKcldPuM9UPi4UqoEpUOnpDfSV0fwxQwtwcKSIT
	96X+MCzr1wCQZii4DUi5EQdO/9JOw8e35Z7D3Ta08vFxr8Lgb8ee5SOmAPpKYBCVTOdSbndTmTx
	pL8ErMgoUmspfOFHAXXDNhTb5Q==
X-Received: by 2002:a05:6402:3247:10b0:640:914c:ab91 with SMTP id
 4fb4d7f45d1cf-650e1c630b2mr25369a12.3.1768188052435; Sun, 11 Jan 2026
 19:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022501.754320-1-joannechien@google.com> <20260110013802.GB15541@frogsfrogsfrogs>
In-Reply-To: <20260110013802.GB15541@frogsfrogsfrogs>
From: Joanne Chang <joannechien@google.com>
Date: Mon, 12 Jan 2026 11:20:36 +0800
X-Gm-Features: AZwV_QgU0fitCf0PtTsBsdoG7CCI7PWtCAAHNpGVJaE4kCuClnPyVV2Wi5ljuKM
Message-ID: <CACQK4XDtrE5P-PjwSqvGtmEmMvEQS4r2KZkDh55LXY2YAoH6vw@mail.gmail.com>
Subject: Re: [PATCH v3] common/rc: add _require_blocks_in_file helper
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 9:38=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
> On Thu, Jan 08, 2026 at 02:25:01AM +0000, Joanne Chang wrote:
> > generic/735 attempts to create a file with nearly 2^32 blocks. However,
> > some filesystems have a maximum file block limit below this threshold.
> > For instance, F2FS is limited to approximately 2^30 blocks due to the
> > capacity of the inode. So add _require_blocks_in_file helper to skip th=
e
> > test in such cases.
> >
> > The helper uses a hardcoded constant instead of a programmatic method,
> > so that bugs which affect the maximum file size are not masked.
>
> Not to mention trying to create a file with 1,057,053,439 blocks
> allocated to it would probably take forever.
>
> Hang on, we're talking about iblocks (aka the number of blocks allocated
> to this inode), not the maximum file size in blocks, right?
>
> If so, then maybe this function and its comments should
> s/blocks/iblocks/?  Or am I confused? ;)
>
> --D

If I understand correctly, generic/735 creates a large logical file, but
the actual physical block allocation is much smaller. Also, the F2FS
limitation is about how many blocks the inode can address, no matter if
the blocks are actually allocated.

So I believe the requirement is about the maximum file size in blocks,
not the number of blocks actually allocated. Does it make sense to keep
the name, or do you think another term would be clearer? I appreciate
your thoughts on this.

Best regards,
Joanne
