Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1D34AB00
	for <fstests@vger.kernel.org>; Fri,  8 May 2026 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271692; cv=pass; b=UCeCm2dbk/xydcJ6L7LB+TXnlruQYdEdecGJEiF4wYd8oY4yjc842BnbHzd9KLRUD9jy57BIoClCo1uJ6S1zWr6Fb6vVmAzhsKKaGIUFViuhXkm2M6Nz9TIXFJeJpXa/0kDPJet40fhj5REKDhOF5CTdepXXw2/FiaCYJNpN90g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271692; c=relaxed/simple;
	bh=mcOKP1P7xh/0iX/zeTZ0XMWGH+ftWHm6jFInDAsgaug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwwwY1YF3zW0ygVvW1rL/+5W3ZP09iRcZRJbs+YCXj+2sIsYbMNCNJfK5rCSGflUW87wqcpkmGL6B4VAPjgmlUT1efQWXicOZSAgnBfMWW2Cdv+qAPJSPKWPe86NyWOlmu6gfubl7LV6xjg9wsac4ZsTCbyyjeCruwNZ1zz1PP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/xLSfkg; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/xLSfkg"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso4500435a12.3
        for <fstests@vger.kernel.org>; Fri, 08 May 2026 13:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778271690; cv=none;
        d=google.com; s=arc-20240605;
        b=Eg8Gx1d9igPOjABHXuUuEpFe1+0penE5XufKOvGoatUCGgMfUKipnFL9gy9iSfRg+a
         GZ2t5qBibD649GQjRdCUm8t99yzTZ1zg1a/kKnhKHUP606qdLDeUF3UwTNFO9qAaTB6c
         P+TC3soKNTGKAeJV3izULoSexfr0KliWyR9Ii0hzEGKU1SmV2JgitX6aWvigjTmPJkwo
         Vyyv2ULFUte6LcP5YJLpOntZFCZVUPxfqpRyrLJWfD0RgoqcOvXCbxLQj5Pvd95wZTBy
         OvxLFDShNkJjHca9QRD1uK3qgUGhW4E3QGJGUvKcPKJsV4Q41IUyKa7LASePh33/JIHB
         o5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2hfEezhJrxyO5Y6C69MmAR5VxY70zy4iUa/wxq1qIl4=;
        fh=iKkLY4RdaqDThhWI1FGxebxF2LPoYY0/6mYnhK0p1Ss=;
        b=Xlhp8g19hCF0T8QWLn5CDSTHN+T77pXtAMUBYCIPw+98lqxqdL6N8VBmqQBqeUOqV9
         Al2IarfuowVubWKKenZmgnZtspkQUQM8hHb64JaxSegcHn6qJahBevFQk1OGBXfLOcHV
         GUlI6BTJWQuoZxdU8YIL1mjRauUhxPTNhEgWQ/vIF6tjsptnr+B2p4lS7YpeDG4CS39O
         dqj2hkQhh8GnvRSRpWugU4DedJEJJjLV9FrpalH+dmh1848KVOV2riFBxmP2P7DDol1l
         0Tc8v5zCGFrdQGJt/4U6/tc0eE9jlkV3Sbp1SRTdy7S6Uf99+5N6SyCCZc/XLDUP9J4B
         8pgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778271690; x=1778876490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hfEezhJrxyO5Y6C69MmAR5VxY70zy4iUa/wxq1qIl4=;
        b=V/xLSfkgoqbD/x6xX1af8nk7ItQ8GNlzEi6CmnKuSq262ZkVMP3FDiPg8Z0bsNKsMF
         S56Ke5Ft6euPNWD+aKVlJaCGpLr6IypZEB6Xp1+kFg+5EZ1ZexZfrFPWFfl9EuragFi5
         La/fBhvx0jSiK5LEcb99ywSHAZrd97sZJUkBs2tkaGwepPbdVMkiM/4tG2GkDQvfVJJI
         pdXsWCOT14Cs/k0BEl7QWV8f5yW/WUamGH9p6uVQdsRVKlH3VtRtTuwFIfJMVqlc/SyT
         YpiwlIGwgOtCyFYMbOc1vcDYwEQgCwn9jFjwhy5IL4Vv8f8JT7KjcHsIiPvmn+5/kTo8
         CjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271690; x=1778876490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hfEezhJrxyO5Y6C69MmAR5VxY70zy4iUa/wxq1qIl4=;
        b=AUd28W46oy++IN7pBuIlc+aGzg539S7Q68Z8/W1SIUODua7qwIl0p1yv4gIpvgPC3g
         IJceFneEVcbcQ5jyxaNr9vvLpW/sBHyoQ/abYnXCTEezwfVcrFkQ75ohpDqH+eEsOVV1
         5zbMoKqJVhJtMaGX5oFhZeFrM89Q22uF7XOXyQ70w5F0/SjW2zywtXhMtG0PIIpvDzLV
         F8fDO3I4cS1bmIxpENVAgrjU130c15vWCvuxJstW+pt0z5XrzoWxN7DereScxouciTlV
         n13c3xWrnDOloRJumknnOrUqGIz38SwnmwBnQWwxpUB3V0H6txh20yySatL3b5AMUlbb
         YUVw==
X-Gm-Message-State: AOJu0YzE+zj68XITYGLdNos6CbA7J6g4FbCBBi7QgfYmC3sUnGMj4ibN
	V1Sgy1jLpLGvIPmRiAR6RUu7W1LBqim3kxichIiMpnQclL4qFk1HUqlWtwGmzMR1vt8UHN+oip/
	J01TOkyPJSEkHaZfRmVIMh+u7+tLvNvY=
X-Gm-Gg: Acq92OG6N5gH7KEmJVPddbTlkbQcG1r9HqLtePGlmFjZrX9JcodTqxG4cuTN8PgvxpC
	nPLph95AAfWfzxEfPt8cXOESR3a5Mk4dIYSMXqXZEGwQJwJVDIBS2/44J3TdZD7js/53PjpuzEB
	r0QUnOdgnTlbfsC4rJjDuPJArsLRszQiIs/Y8HuSfs6ieIhXMA6F0drWdjah55azKoYBIW8xZeo
	Af04oSz9DBbTyLgG94DS3mRq4b7/7B+Q+ik/je+CvmUu3Se3lDNslQex7pQoy1MJ9CacB55bIO1
	hSKqd+CWTq2agKvexKk3zeEDAiG4XDqYLoPcxUitQg==
X-Received: by 2002:a05:6402:50cd:b0:672:a1df:9c6e with SMTP id
 4fb4d7f45d1cf-67d6489f992mr7840338a12.25.1778271689295; Fri, 08 May 2026
 13:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97140e8a-541c-4e0a-accd-cf58dd1feae6@app.fastmail.com>
In-Reply-To: <97140e8a-541c-4e0a-accd-cf58dd1feae6@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 May 2026 22:21:18 +0200
X-Gm-Features: AVHnY4IHG0KkRMTJIsoJKrIHSnuyNVArSWGlGVzc-pd0q6fKy4YRB6I_agEmCbE
Message-ID: <CAOQ4uxjHXdAyPN+hrMZV175OCgSdLT=-rbdD2+7ygqv8C9F-gQ@mail.gmail.com>
Subject: Re: [PATCH] overlay/080: cycle base fs in prepare_midlayer to
 exercise lazy verity load
To: Colin Walters <walters@verbum.org>
Cc: fstests@vger.kernel.org, overlayfs <linux-unionfs@vger.kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 10:08=E2=80=AFPM Colin Walters <walters@verbum.org> =
wrote:
>
> This reproduces the regression reported at:

Make the test closer to real composefs workloads, so it will reproduce
the regression reported at:
> https://github.com/bootc-dev/bootc/issues/2174
>
> Assisted-by: OpenCode (Claude Sonnet 4.6)
> Signed-off-by: Colin Walters <walters@verbum.org>
> ---
>  tests/overlay/080 | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/overlay/080 b/tests/overlay/080
> index ce5c2375..ede04dab 100755
> --- a/tests/overlay/080
> +++ b/tests/overlay/080
> @@ -21,6 +21,8 @@ _require_scratch_nocheck
>  _require_scratch_overlay_features redirect_dir metacopy
>  _require_scratch_overlay_lowerdata_layers
>  _require_scratch_overlay_verity
> +_fixed_by_kernel_commit 0c8c88b8eb82a2a41bec5f17c076d6312dc40316 \

I do not see this commit in the upstream kernel.
I do not think that Eric has already sent the PR.
Please wait until commit is merged upstream and then
use the abbreviated commit id.

When you do that and post v2 patch, you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> +    "ovl: fix verity lazy-load guard broken by fsverity_active() semanti=
c change"
>
>  # remove all files from previous tests
>  _scratch_mkfs
> @@ -222,6 +224,11 @@ prepare_midlayer()
>         echo -n "changed" > $lowerdir/$subdir$wrongverityname
>         _fsv_enable $lowerdir/$subdir$wrongverityname
>         echo "$lowerdata4" > $lowerdir/$subdir$missingverityname
> +
> +       # Cycle the base fs to evict cached inodes, so the overlay mount
> +       # that follows exercises the lazy verity load path from disk.
> +       _overlay_base_unmount "$OVL_BASE_SCRATCH_DEV" "$OVL_BASE_SCRATCH_=
MNT"
> +       _overlay_base_scratch_mount
>  }
>
>  test_common()
> --
> 2.52.0
>
