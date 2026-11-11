Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794407548;
	b=DUk/wjibh+NYqdnfCsg/pC3OKPG8Go/V+oib5ISz+Yv9rjbicyXTCIZD5nidtGBzmlc7
	 Rc2BZMdN03e64MOtzGArA5GNwyJLoN+r92YrzkuCzNd5XOrusERLrYAmkgZs+y+Xy2KnX
	 jmImatOLWHTNIYe2U1WlhX2lQ2nEZ/CadvZwVmgdAhVr0B9/c6VZcgnsD/AWXrUFaQ0qo
	 041ldPCzwglGTeRndku8C8LVB41ZRaLoQjjtOWls8RloZ8dc1N/uoSHor7y/5NdO3tXEj
	 oCSw0DQu8a8UuBQ82waDxoKP1LD1GKyIhI93vpJjHMyatikXuoxQishmzIh2akADEvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=H45KpFDCK+g+SsvdHkrZW+WnPt+fiQcRq1w1UXAbFIw=;
	b=oPU4N2nHIEFgnrX7gs5j8xVeR7cT+5u1EBrSUK+95cCV1WuNihHadzXY2C/DBQwVfsH1
	 g3WlwdkIZVZVMu/43rhTnjPnKgA31Cjv+xqdqphckacjvjYJP1EGTY66MqiNlmHU/nCuT
	 LUGRAv8gGAmolohfTT0QJNGAxntwYI7wY1c2K/nGpN4P9hh9VOl5fPH6avDFKCd+EsRXf
	 5NwIPq8dv/2wsUVRjddVnQpSlYfRgNdInK9zF8YSc07K9c8vu5c/tbo5jC4ExLiM+VtSZ
	 Y4f+Xz7zXOAmR/wsY7Vtlri0t3qZD29oPRviy83/lm20D0yIl16sCGjkhLtR5Nim9sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0PUxDQW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADB60A2623
	for <fstests@vger.kernel.org>; Wed, 11 Nov 2026 14:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FADB60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0PUxDQW
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so4251391a12.3
        for <fstests@vger.kernel.org>; Wed, 11 Nov 2026 06:32:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794407545; cv=none;
        d=google.com; s=arc-20260327;
        b=LbA1A69AZByZG3oql8/D7ldNZNPeY9VIsbrj71HIz+auM4PhDbk4Cu7l50KZWZv7fW
         KGd0rlraS2EIfsLu1I9CMds4jyQAd7lAGSAngc9mbKhY4TwNwrg+JgENqzFbT7wNG/zY
         fwDwJZ5WS96gwsO8jc8Fuv7X2iOL5mvM0Rgb5P62DVT6SIziY/iUouRtp/qyIrgAWNNf
         2pmyZNqRzDWDSnj9cd7e6NgYlcYsA02+rfF3asilJ9x15/zaMrVhURqh2LH4Zi3/5bZQ
         SH0TcFrVYwoAp8qu0Mwnr3/M6qMVwpIk7oncT2sEXDsKakYAC06OmhUR7DY25tw43VWW
         ajJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H45KpFDCK+g+SsvdHkrZW+WnPt+fiQcRq1w1UXAbFIw=;
        fh=KwMEtdkmyVjNwGs2Qh1Hxc3ZiVL7IU7E5hZcRIv0Vmg=;
        b=VfMasZ3L6G06QgtwlA3DJc7agovw9jcThCMazDhghDTt5n1041Kyh1EZp2XkkSuOEc
         MjigwGMzztIjwzGekO/q2PBEAdVGwZJE7zVlGMKxOg0l2GVdZcM8CRIO+zBuAN7xUGzB
         yWkZyE2rTxJzmWKOkroWe89NM+WjsRyE5MZbLXUQQOOVrPHKc7u3zOH6CVti84UyXdhw
         5yZk6/aX0vjBRk4z9im9aGYjRHVH86Su4D+ToDKgPwK3DgyCDhkoQ2Gzdj+kghflyLkS
         iTFt0XUqJNODsEb5oanCvFreZ2VShH92bmIxIGIhs3ZfuTW1M3STEkEygWxZvscwbylp
         Ww5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794407545; x=1795012345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H45KpFDCK+g+SsvdHkrZW+WnPt+fiQcRq1w1UXAbFIw=;
        b=n0PUxDQWY8lbniMMcg5XyOrakIOSWBddI2DuUo0W4g62MtmIX22RcOG5yCdak4GdWs
         x1+Y0jocLf+FhuyN52434g01fV2yYXQAP+TLfH2nvLH9VhrCEUMI/eNEyhJP2vAgrB3P
         W9rIzW9N8BJjZPH0mbAsFEaL9GTzHRsOHQ7GfECxvTJ85oTAgr558B8f3UwpUjOR/gtS
         heCatj6cIc5LtFFD58I8nCm6vD79ZrDH9W20xSWA2xgSLNlx2zpbH4p2Ww34y65mAWGG
         JTxxhnFNck3isnlERBqM0C864OYETyV7rvrQNiKK2cxdX2/EXRQh4NpYxeSRL1R0vJ2z
         MI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407545; x=1795012345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H45KpFDCK+g+SsvdHkrZW+WnPt+fiQcRq1w1UXAbFIw=;
        b=BXx4fF8R8R2if1YHcf8EJfEjtfP1EClW92zZsLGK3/S2FVXXA+Z5lbLTjHh2UME/Oz
         iXgqQXkFzul3A/PddnuFqpGoHIOqM2AvKXEfgw/84AygTg348fS71hrZPWUIkc/fJvk1
         v6NDIkwIVXWYp0ml5b/aWl9i6RS1eYGGsjEnzVhoS4yWBrTMZkWNvjLCe+Z4JuZ1GZs1
         +bFrVniL7aV9n9yoo08j2yNmzV+OJHs9zZgEuM1EoNb1/439S4bdYLei8UgedfshywtU
         ntRmhCvFqEzyQowl5PxBHHY9Z7ujXE4d7Gj9pAC0L/iU88V2XtjMFgcduhdvFla9MV3O
         4jRA==
X-Gm-Message-State: APuU4Z819y9UATueVqFIlF5qVESyyQK+br54SNtcGbpbK3dL32iw7G/x
	rd4UFt9PIYSfRE1dcZxWa+m72fLBJlPZZAi4cY2DKYjJeCubA0xZETo3QkjHLsXXZFzXHUBd9xz
	CmlzilhBoeinOHjK/IcepuCQ5dhkueO4=
X-Gm-Gg: AYBFou366mwd9auPQFdk6RIvqRLJNCohAbefjHsily1i6l7zM3mmIDeQfi11cIZIbRo
	oPZwjbmAMjcF3RXEbZZQ6CUkzLPtCPyn0BkFBn4bodNTU6fXPfFK8/Yk3mjb2XA7Vxk00ZeYD62
	Pt+zWTkXegC9IxwzjbDgUrxcYEi40QCY4awUbDOtJZqvqufOBFNpJYw0/TjBT2RhPTxoItZxvl5
	5Uo6Np+cjJHUU+KcM+gTQyR9W2p9Lq5hIYz/4K2B519yNdV+r/iqqUPrtjKxP83lKGX+BHS0EU/
	hxtkDMz10mDzyG4Lt64qd7C94KzFt/OIn+iDPDXB+Uv1b7B/Hf7u2lF7LDeP7h2umbYDU+Fodq4
	zj5lvthfHywzzFpR4HhRXLzN7IsBx4pZkwMWDVViop+7qHmdGEy7C8ZCg7HUWubzFVfMKGw==
X-Received: by 2002:a05:6402:a646:b0:6b1:8818:1090 with SMTP id
 4fb4d7f45d1cf-6b7773f30d0mr1395590a12.22.1794407545129; Wed, 11 Nov 2026
 06:32:25 -0800 (PST)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111132836.3495981-1-giuseppe@scrivano.org>
In-Reply-To: <20261111132836.3495981-1-giuseppe@scrivano.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Nov 2026 15:32:13 +0100
X-Gm-Features: AclHuK9UKcZuc11R1NXdk1mepeTSsngwkQRdBY94mhO_-NcU2qH9JLMsLDVbZSo
Message-ID: <CAOQ4uxj7+yrUMu_bFMpDR6g32x6RjwgcaqBR98h2PBFjn=YD7g@mail.gmail.com>
Subject: Re: [PATCH fstests] overlay: accept EIO for metacopy files with
 missing lazy data
To: Giuseppe Scrivano <giuseppe@scrivano.org>
Cc: fstests@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:28=E2=80=AFPM Giuseppe Scrivano <giuseppe@scrivan=
o.org> wrote:
>
> Since "ovl: return EIO if the lowerdata is missing", open() fails with
> EIO instead of ENOENT.  Accept both in check_no_file_contents(), so the
> tests pass on old and new kernels.
>
> Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks!
Amir.

> ---
>  tests/overlay/079 | 6 ++++--
>  tests/overlay/085 | 6 ++++--
>  tests/overlay/088 | 6 ++++--
>  3 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/tests/overlay/079 b/tests/overlay/079
> index cfcafcee..4ea4f609 100755
> --- a/tests/overlay/079
> +++ b/tests/overlay/079
> @@ -119,9 +119,11 @@ check_no_file_contents()
>
>         target_f=3D`echo $target | _filter_scratch`
>         out_f=3D`cat $target 2>&1 | _filter_scratch`
> -       msg=3D"cat: $target_f: No such file or directory"
>
> -       [ "$out_f" =3D=3D "$msg" ] && return
> +       # The data is missing: older kernels fail with ENOENT, newer ones
> +       # with EIO
> +       [ "$out_f" =3D=3D "cat: $target_f: Input/output error" ] && retur=
n
> +       [ "$out_f" =3D=3D "cat: $target_f: No such file or directory" ] &=
& return
>
>         echo "$target_f unexpectedly has content"
>  }
> diff --git a/tests/overlay/085 b/tests/overlay/085
> index 046d01d1..b644e7ef 100755
> --- a/tests/overlay/085
> +++ b/tests/overlay/085
> @@ -120,9 +120,11 @@ check_no_file_contents()
>
>         target_f=3D`echo $target | _filter_scratch`
>         out_f=3D`cat $target 2>&1 | _filter_scratch`
> -       msg=3D"cat: $target_f: No such file or directory"
>
> -       [ "$out_f" =3D=3D "$msg" ] && return
> +       # The data is missing: older kernels fail with ENOENT, newer ones
> +       # with EIO
> +       [ "$out_f" =3D=3D "cat: $target_f: Input/output error" ] && retur=
n
> +       [ "$out_f" =3D=3D "cat: $target_f: No such file or directory" ] &=
& return
>
>         echo "$target_f unexpectedly has content"
>  }
> diff --git a/tests/overlay/088 b/tests/overlay/088
> index 33215cbd..27011469 100755
> --- a/tests/overlay/088
> +++ b/tests/overlay/088
> @@ -95,9 +95,11 @@ check_no_file_contents()
>
>         target_f=3D`echo $target | _filter_scratch`
>         out_f=3D`cat $target 2>&1 | _filter_scratch`
> -       msg=3D"cat: $target_f: No such file or directory"
>
> -       [ "$out_f" =3D=3D "$msg" ] && return
> +       # The data is missing: older kernels fail with ENOENT, newer ones
> +       # with EIO
> +       [ "$out_f" =3D=3D "cat: $target_f: Input/output error" ] && retur=
n
> +       [ "$out_f" =3D=3D "cat: $target_f: No such file or directory" ] &=
& return
>
>         echo "$target_f unexpectedly has content"
>  }
> --
> 2.56.0
>
