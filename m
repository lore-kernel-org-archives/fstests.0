Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103CA1448C7
	for <fstests@vger.kernel.org>; Sat, 14 Sep 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726345102; cv=none; b=pkAKUL7CXvxUT3QEGn0OVGmiB9WflCiUDV2egpiXfyrW8OkllPqMcD4ro23siHJ0B8R+pc5439Wimk3DJ6G1WNpwne/6cKeQ2EiOg7vlU2t4FiHI0QWKvXDbyGkdnpMFGkt/9Sc+6hf/ebdXdGNGMy0qSzq0FoqWZQoU5N7+a20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726345102; c=relaxed/simple;
	bh=iWwWi4b5vPHcLbhHOex5gtk8nOCaGgUh9dPfqiDOvMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnFRxfOfMHBGa1Z4Pi0I2mYi1Zki37+wQbWuOmSYPoXJ9mxrnp+MddnGVFej58tQNYJKK/MGfZcCUl3KicENuJEp6xK48c0DrFbOhEHcGUkEXINoJIYusmdx9mmSkj2m5dUek9vo5E+k4HHFI+w7q6vLH3woUkeom6FlGNa+esA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F28EG1Nd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F28EG1Nd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2059204f448so29759275ad.0
        for <fstests@vger.kernel.org>; Sat, 14 Sep 2024 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726345100; x=1726949900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wsB9rVxrkFG32FKgt2OKoOWMXwoiqFMyM7bM0Oqyb4=;
        b=F28EG1Nd5dQ7YelpuoE9/8l+kqm+oDOmTzxi8MRJG+qZPKWhnsFBLiKf4B26rNw/pd
         E+5hEKbteVPpzlE1TTb97OB0vJa/FQTMsPVQpiGCXcBaEW1NizO0mvFZ/KHypfZKF3/j
         oQiIgyFn6u5Swn3Bx89aHcpMUje+9ZpFQijS6pIjdH7/CD2VsqJZJ61nLAvDHAmsKPs5
         KkshUWZnxQHfSk+e+BGXW55CtI8jUxBwvR2nfsVDmM5TgXuRg/IeP81bHW2SVSzCmVys
         Cn4j1qUuI0W1i06YaJKRduH9T+juepRE6WZGX64hhy7Jw+js33P6/juu55ovepp2WE/N
         Zs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726345100; x=1726949900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wsB9rVxrkFG32FKgt2OKoOWMXwoiqFMyM7bM0Oqyb4=;
        b=jv3Tl/QpoBDq/rdt1ytflm9KmFWExkPcxWlk50lxl75wJ/VKmaUfCrdovu1aKOO0aG
         nKz7fBhLRJV7R9XcPp+pDl5OtUiDEFxsJppcKOoE5yJUckqJq5Xv7UsozL7Ur93wS5Lz
         7/s+dzRMux646Cw1Ylu/fMICV8Vr/aFPPdRpi/KDPJ6SijupJt6K8vPxR5qOzeZhYx2Z
         Apos/nImfZ1fg0Kgmw/5EvED+TNfZvYuDMnpOlEIlDIHgX0YFTOjXcv7MKVGCmrsehpG
         F2GQRcpf+eel5cr4DTN1CewAjGPTrOaxAezHcM6+GkIACae8ZqVgwnTGCjvOUyAwXrJj
         V4kA==
X-Gm-Message-State: AOJu0Yz04yBunU39SzFRMDHdEW82/t5ATPsC2tieP8y1dQhkDv1FWDVc
	B5/1mCkuCDGqXmfJR7H4cS9aNKriKwbYjcbaIGlgqSnEI8JAG1UJozAc/tGrAQWHXiNdjqb2KHK
	gBruwk6EL53CaI4nxJvfE2rXHc3Z4sx/onIjo
X-Google-Smtp-Source: AGHT+IGev6ICJ3XQDQ/B0XSR4sAHfzxqNaFRZtJgrKhhnILCV9Xrjb9ReZNcby+qxqe03DeiS/RjXTQOJAOMWOKpBPA=
X-Received: by 2002:a17:903:2348:b0:205:810a:18ff with SMTP id
 d9443c01a7336-2076e45ce87mr163080015ad.54.1726345099873; Sat, 14 Sep 2024
 13:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801230417.323994-2-mattysweeps@google.com>
In-Reply-To: <20240801230417.323994-2-mattysweeps@google.com>
From: Matthew Broomfield <mattysweeps@google.com>
Date: Sat, 14 Sep 2024 13:18:03 -0700
Message-ID: <CALEiSPwGymqrBDiQ0sH1Vwmg9uzJ4KBe5tWx+BA_Vv4p0gvj_Q@mail.gmail.com>
Subject: Re: [PATCH] generic/375: clarify flipping the write bit
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:04=E2=80=AFPM Matthew Broomfield
<mattysweeps@google.com> wrote:
>
> When checking if SGID is cleared upon chmod / setfacl the write bit is
> flipped just to make sure permission changes are happening. This is
> orthogonal to testing SGID.
>
> Added this information to the test description.
>
> Signed-off-by: Matthew Broomfield <mattysweeps@google.com>
> ---
>  tests/generic/375 | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/generic/375 b/tests/generic/375
> index eb675144..44670350 100755
> --- a/tests/generic/375
> +++ b/tests/generic/375
> @@ -7,6 +7,9 @@
>  # Check if SGID is cleared upon chmod / setfacl when the owner is not in=
 the
>  # owning group.
>  #
> +# The test flips the write bit to easily observe that chmod / setfacl ar=
e
> +# successful. This is unrelated to testing SGID.
> +#
>  . ./common/preamble
>  _begin_fstest auto quick acl perms
>
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>

Hello, can someone review if the comment in this patch is accurate?
Thanks in advance for your time.
