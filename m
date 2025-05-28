Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F77043ABC
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429279; cv=none; b=Jkes61wGLuAD0py6nuKSS5yH+P1O5525LT37HJ+CPSBzH0wOt2Zn84Ec5U++vfypttP90992qWgPoml3sHl8cABa+Nw6PVvkVHHANBpLH2wRcC80LjRt57M+OiQ3nju0yEl/ArGB3hpx2fShmjssMiuZyEE9iW9PdkCGhmHpN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429279; c=relaxed/simple;
	bh=ExZGyat/8EUpSul+7XAZQcagzrYqYNqUIoQScNwQLaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP5gUAhG0EcH3IvAnDn4RO7gG5RkGmjoOyRVmKAnFmQZpzrcPHPRXEg7SHw7F/FiH90nwyS3vRdeOboCwNfw0VKGVPwfqzwsN4DhrSwHilthP7mW6O/AUrCFBevVLO+lARt9DY+njC5Gfva4s5916Bi0DGC9VNBxh2arYYfxZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTA2eau5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTA2eau5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-604e299b5b6so1493393a12.0
        for <fstests@vger.kernel.org>; Wed, 28 May 2025 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748429276; x=1749034076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwqMmoExpwqe4M0aY4CIlhTZrzteS2DqsdXdcMAJg2Q=;
        b=RTA2eau544qho3/EvaM5qjZEwpX5qjF5YzhrpyUMqlemGv+C3AmDG3TXuwAjAr/832
         M2Ajioq06sqrqE6yu27C/HIryso5ua08nAyox106lkHKJ3se7MBCcUBy7nw9WKgbl2HT
         xsPTjD8lwTrwcLWol/JsXpqSCjaA8Pvka5PKOT6DN8rKqYpBdUiyVGsOM3ZeWhllno+X
         ++CAASlgj7kfw+JJSmVVS7nmm9DA3Er8nENddQjJKjMz23pDApxHZk6CUB/NCj+bkmqR
         3FDSsCzvGhgo5Aweyb4tKkgqkp2dhkbubRsLhLouc58DoTvAEBMe85dNHZ3knYu93Bct
         Mm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748429276; x=1749034076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwqMmoExpwqe4M0aY4CIlhTZrzteS2DqsdXdcMAJg2Q=;
        b=B3Ao4m8X9XJffI/zC+UXzC9KKAfyy/HBSnUcECnpHLIsPb9EJQTze7dJe73pQziuTh
         uBi33tkwQd13kjCcvgDwLa0WOJETywWg8pOj3eGvMNR482sLopO6rMo0IX/97n0PMnFm
         xmdvJB2QQIIFNWSmJK2eXHRDJ2kkzBjvj8yjcDVx8mbQ7/YXju+VxBdS67u7oI5OpqKM
         iuFZLfZnuCbbgKdnKStF3apbF8WQEhLgA1ZV2JelApVecYUI2sVnesP4N/KFTIuBb+1v
         kHhILVoP2VGylETBfGEBQuEjPkSPnlIiDHzIUrf9PEKM7Rs1OQWtHY5Qh++GmnPfB7CM
         C9bw==
X-Forwarded-Encrypted: i=1; AJvYcCVtPVBCKBW+OLHjvff8tuLyxF90woZpdfE5GjgKCT5vesP7mTkm5GHkTzh80ScKOa8E4j6G3OoT@vger.kernel.org
X-Gm-Message-State: AOJu0YzLI5cWujxLT9yHUXicU9OZf1ODWfg5Y/YGyw3ym5jkfiIjLg2S
	g8joECq/+wbedkLEUj8c+phyGGHAwUItSJAnJ5Rd6fkMUqL7VYZYr3X93SYY+GBxsq2TCDGuCRp
	OpkYhfiehJDrAXD0xWHpsAckEjKr8+hinDf5+e68=
X-Gm-Gg: ASbGncsPnjQxeXCJNlGCbRiDxLDg3nG/qo5s0Lo8ovvenjzPwrnaS/lTfrrEEOgT1EF
	9INRWX+2OiX6QYwzjjAhtrZ7P04QHBTa9FcO1Sfu5cMSgFp4LzBY2AZ5BHez8ytlwUsAWy0dTaL
	7ueiS4vxkKy4WnyQi1YgsBwGNRuJLE/MfU6F61/YsBvSA=
X-Google-Smtp-Source: AGHT+IHZmZ2BJ04AqgMxIjhskv60/QIW0EnvTM7eHU/AgM/tUfoESnEo2INP9n29DxleTlwF+zGgEYujRFXYxwyiozg=
X-Received: by 2002:a17:906:c10e:b0:ad5:d6b3:5cd5 with SMTP id
 a640c23a62f3a-ad898865789mr413511566b.5.1748429275416; Wed, 28 May 2025
 03:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com> <20250528091530.1218188-6-Yuezhang.Mo@sony.com>
In-Reply-To: <20250528091530.1218188-6-Yuezhang.Mo@sony.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 May 2025 12:47:44 +0200
X-Gm-Features: AX0GCFt3YSkVf5mfb1yP4QLz7xjChyVgGUaB38y3nVZZNRGn25xAmRDGzpz6UMU
Message-ID: <CAOQ4uxiaO6kj5eVyPX5FpfZgc2Uw8GQqAJryPfRSv6pgiSHXUg@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] generic/730: add _require_scratch_shutdown
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:15=E2=80=AFAM Yuezhang Mo <Yuezhang.Mo@sony.com>=
 wrote:
>
> Before testing for shutdown, check whether the file system
> supports it with _require_scratch_shutdown.

Where exactly is this test performing shutdown?

>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>  tests/generic/730 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/generic/730 b/tests/generic/730
> index 6251980e..1dce547f 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730
> @@ -25,6 +25,7 @@ _cleanup()
>  _require_test
>  _require_block_device $TEST_DEV
>  _require_scsi_debug
> +_require_scratch_shutdown
>
>  size=3D$(_small_fs_size_mb 256)
>  SCSI_DEBUG_DEV=3D`_get_scsi_debug_dev 512 512 0 $size`
> --
> 2.25.1
>
>
