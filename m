Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9E43E06C
	for <fstests@vger.kernel.org>; Wed, 16 Sep 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543816; cv=pass; b=Bar42F/nFImtZhmcBqKvqqLeea0PHF04WE1YMudXm2OtYeMEosm9esKJjqQMB8Gq5h0pcQceoE60sVT1SXjE4WZXVVI952NOVzQX44WPyR6nhRRY0ifp6EJnT3Fc22NKwRHrcc6zhZFT6vLzrIGMH4P7FhHYrKV4mymfom2vlgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543816; c=relaxed/simple;
	bh=9JdG5qSC0tk0ZBwuTZWIN9q74g97zJlNODpRuXQIuvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JU45ojig0jHHn2Os8FWAUncck8A5w2A+wdQmmkRNj/rZpd0yO57kQyJ6NBr0LN9LA5zXXzNNZLIJSdQoTZnTE/0TVy6NKfbWuk6KXf/wFvyuKGXU4DPUtqRhv9d2u9gfH+ln7hqUZnURGIeujf2tBXgHkoeEwElxZwPe721EnIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slyysVUc; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slyysVUc"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so83580766b.3
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2026 00:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789543796; cv=none;
        d=google.com; s=arc-20260327;
        b=sX1vcG8ARYzVhclxj3ofPmrRXQfeOYQhtfAowhZytYr6j9ms7bj4mxNzXmd5iOc94K
         o52FPhFW706pzwl0uZIV70B8yOLS6UmNBlRA2Iqr6wGpE2Dw3S7NqpTCz9Uctbk9xKIl
         oZZDIZI6JB+OOt2a4J2Bmwrwkvo/oEFoGlkbWlpT+tJUGu0qxWWoTWrzOsJuSmmOr6d/
         uy+xHHQAlzSc/ICDmjtdmwU5rTCYxQv8C3SDoJ8XM3IUpy0O8V7OW2BeSxyzpVqNHrhL
         33h/lrhEdxqK38XnpR8MXWUPi/H7dbskaZIWxICTid+cB5qQNm4F2mzZBc6lrCY1LNLq
         EodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g71NvPi7wydwxFtIeU+AubwwN2N/zTYMrRDoUqH+bKs=;
        fh=eW8f3VYcB8wgxVAJ8YhHCa1ZUrGHqjIiaoLmujEtgG0=;
        b=N5wpwr/8tDiCHPsuo6dxHiKjkuZxdTVyDWGx1CtswAwKzhvq6jhsa9jEV4OHXUQKS8
         9Dz/yGUp/bv0nhRlDpdEYIV6ODdDKSKir5Qj/MPtI6QaTRilndku7PUp4yBWzhMbN7Cs
         GIpxWlhHxrh87tUinwItOvu6GX4/zyAJotzSyXHlN23jHEjOMJiJo+4tuB+RDynf1iQu
         y5WgfuPGR1/CaVrXM1/UJpILp4gLMw7qyv7+qYs3hjvVUrsUVgRBfuPQ3cE5wywWmEZm
         Ub4CnmfE7oF86EovPR6Ffxzb1Jj6msLYEaRNdRlk3hJQE7SmFpDgP+nbGIqB/pkyyC4P
         NWhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789543796; x=1790148596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g71NvPi7wydwxFtIeU+AubwwN2N/zTYMrRDoUqH+bKs=;
        b=slyysVUcaut4zHyAgLBDk9vWOFpaqVvGpwwhTbbimyUhghlWyLAurG7X0RMTnLAOfo
         KgjsWhWVPaT1EtPnEx9Nm4+bUQ8FKN1JsU4HYrx8RDYn9C4Rp/pqsj6bn+0Su0Vwsi1d
         PtJDGiBpaUFX3nLJ+hFydEXZCDHzPZjPaEcQazBjvK5esqfA3a0LkMoi3NoIaGBqVBkD
         165bSNlneZ3hgUu5VUK2K7sr7PKQw5c+ilSvgjXRfIDcnLrkZKF5azpcgmKPDWyEj4xk
         EqT2lEeR0fIBoj38YiFaobyogDxWRQDytK+5ain1waGZl9TAePgK+jIYtnA5ZDlKEiFT
         bm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789543796; x=1790148596;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g71NvPi7wydwxFtIeU+AubwwN2N/zTYMrRDoUqH+bKs=;
        b=fcvOo324yXJmmx2mJrNhghpGfq+vlhsTGSsP42XYT4yMV5S5y5dI56kdoIN2hgND4d
         9U9TqnP3+QGho+Rqi+qxENLQ68AppMNsRjabWW7OdDuk1/1OJs6MsO2yOO0NHkmL9T0v
         nfe6tbUgw7t1FzWs7LNozN/1z6ZINUvuPZuNrwlShxzAk3qiTbBPmIzUH37RFl3n7yL8
         KrSVegPWoEyTAWPNmVYsGbzv+iQiuMovMSlbnxyDlzqiQqrbi8DeFMLyhiXpTzR1Vj/v
         m+yxheOJsLCgOs5PVSBBFDCJ/hwkb5MYv6c9woXRaQ1fJubTbrTI3+krxbYiJV8GA3X9
         ddYA==
X-Gm-Message-State: AFuF++nA5WqMzQorAW28K4oBTGnXpeihtG3MqOziCP5cyQZtkcpm9JDD
	zKo9uN9qhBF9TlVc3FoznyjH+2V5uxGT+wiyGn1C00xXQ62ir9MdD+sBRlPL+8weNQV5UfAa3Rk
	roy6qedydYzxzvu0f7FEaKQd4PfKbF7c=
X-Gm-Gg: AYBFou2gI5+1oUEgSCKP6PoNJrJ8aG8RQBaWi/mkHUXd0ZxH0gjspAFZz2GY0Lk120F
	GULSHBeV3PDoHbFZSlJo92aXo+VMzO1RVvedAjWknMeXaRZs5+4HFSJ4znEvJ0qBq5G/2D2EmKY
	+OyU0EZ0AeUU0+wS86piOcMtvux1wUGVd79yRLEtS6I1na+A3+hdo+4hsLW5bA6tXXATQfwNLHC
	qeXZ0NWeFMbgEOy5hFhDY+qumqn5BNOqXs3yHivMfpi7zcR4tO5iqsKy+d98vkbvFpNidwdsYY/
	+QOidyr1kdM2BYIFQbkgrs85Psu2ht1CE0sJ27BXkXywFHAtrp+pMxRN
X-Received: by 2002:a17:907:9621:b0:c29:4415:2ec6 with SMTP id
 a640c23a62f3a-c29e520778fmr98720666b.12.1789543795984; Wed, 16 Sep 2026
 00:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915153608.5197-1-prabhakar.pujeri@dell.com> <20260915153608.5197-2-prabhakar.pujeri@dell.com>
In-Reply-To: <20260915153608.5197-2-prabhakar.pujeri@dell.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Sep 2026 09:29:44 +0200
X-Gm-Features: AcwNN1UTUoHAQpOF4OttlFsJqQJKPO8Hys6tqOdmdDnflGDEHZzWukJCOGRyPYQ
Message-ID: <CAOQ4uxgCgHhLsxonj4vjcJombbOjEmxZqS4adx-+VVn+BB6b2Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] common/overlay: let _check_overlay_feature handle
 param-less options
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:36=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@dell.com> wrote:
>
> overlayfs mount options like uuid, xino, verity and fsync have no
> on/off module parameter of the same name, so _get_fs_module_param
> returns nothing for them and _require_scratch_overlay_features notruns
> before the probe mount is even tried.
>
> Per Amir's suggestion on the overlay/081 review thread, a missing
> parameter for such options means 'defaults off' rather than
> 'unsupported': generalize _check_overlay_feature to treat a missing or
> non-boolean parameter as default N, and drop the parameter existence
> pre-check from _require_scratch_overlay_features.  Support is then
> validated by the probe mount itself - a too-old kernel that does not
> know the option rejects it with EINVAL and the require notruns as
> before.
>
> This lets tests require param-less options uniformly, e.g.
> _require_scratch_overlay_features xino / uuid.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>

Hi Prabhakar,

Thanks for following up.
Feel free to add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

After fixing one small nits below...

> ---
>  common/overlay | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/common/overlay b/common/overlay
> index d32f3219..89413933 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -172,8 +172,15 @@ _check_overlay_feature()
>         # parameter (the system default) and per mount by mount
>         # option ${feature}=3D[on|off].
>         local default=3D`_get_fs_module_param ${feature}`
> -       [ "$default" =3D Y ] || [ "$default" =3D N ] || \
> -               _notrun "feature '${feature}' not supported by ${FSTYP}"
> +       if [ "$default" !=3D Y ] && [ "$default" !=3D N ]; then
> +               # Some mount options (e.g. uuid, xino, verity, fsync)

fsync does not have on/off so better take it off this list to avoid confusi=
on


> +               # have no on/off module parameter of the same name.
> +               # For those, a missing (or non-boolean) parameter means
> +               # that the feature defaults to off rather than that it
> +               # is unsupported.  Unsupported options are rejected by
> +               # the probe mount in _require_scratch_overlay_features.
> +               default=3DN
> +       fi
>
>         # Check options to be sure. For example, Overlayfs will fallback =
to
>         # index=3Doff if underlying fs does not support file handles.
> @@ -192,10 +199,10 @@ _require_scratch_overlay_features()
>         local opts=3D"rw"
>
>         for feature in ${features[*]}; do
> -               # If the module parameter does not exist then there is no
> -               # point in checking the mount option.
> -               _get_fs_module_param ${feature} > /dev/null 2>&1 || \
> -                       _notrun "feature '${feature}' not supported by ov=
erlay"
> +               # Some mount options (e.g. uuid, xino, verity, fsync)
> +               # have no on/off module parameter of the same name.
> +               # For those the probe mount below is what validates
> +               # support, so a missing parameter is fine.
>                 opts+=3D",${feature}=3Don"
>         done


Apart from repeating the fsync option mistake, this comment
feels out of context after removing the _get_fs_module_param
line. Does it document the past code?
I think that a simple "Validate that mount option can be enabled"
comment will be enough here.

Thanks,
Amir.
