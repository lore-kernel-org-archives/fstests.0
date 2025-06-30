Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A81B87F0
	for <fstests@vger.kernel.org>; Mon, 30 Jun 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313527; cv=none; b=kQV6ku9hjbRAr/OPbZWJt9NYScc2nIKYq6wJfUHCQUBb+q8V25pLbO6H6a1flxXXlxwWDkTYzG4Q+pI2qlIb1dbWxnxyV81TWo2vyn7m1BPDqabe6r7sh6bpayOkL1gYwFkEMj3/7vGahAwYSuEr4kvXtFoHHhMe7QM9Ns55rhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313527; c=relaxed/simple;
	bh=2bRRRZ1lp9+0IPVpxNj7sf43IQvUm3WYy/Y3w0RGmak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoUJKLED63WlnFcm9iylpG8jsX4oDdKsGeDw8c7epRabkcN4UqyGdK9h5KFCjAqWqWcXW00ZDe7LZxpW8jbxbGFfxQ2/wXW0Dv8Sk1Iecqbi7FZJdEhJJI4pemAPQ+eGMplIKOKUlpcV2B7sGjXNTv1HjpCYez0SGNitOECuGLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+yuNd7v; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+yuNd7v"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso2555a12.0
        for <fstests@vger.kernel.org>; Mon, 30 Jun 2025 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751313522; x=1751918322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bRRRZ1lp9+0IPVpxNj7sf43IQvUm3WYy/Y3w0RGmak=;
        b=U+yuNd7vxP8rtI+3lV9TZCvZ375hJM5ANvAcyUubX84JXRcR4SqaFGL8e0z1/GzLP+
         bGJ5F/NhAvX2LWZaXePsBQl0ZaUS7WIJeBtk7emVr4OjTBVFa37EzFhEfZ68wIVEMQT8
         KLSm5SLM6VCaNKAPJx6ENLA/juegYm4sq23wahq5AxhE1jS3W3ypDq2h8WKeCtHhk/xd
         05M5oVC3fCDPLfoSpISrh03dcxb5lqkDnr8Bo6hNnm7VMl9apmpq8k6+Ux4BXQmaulaM
         TYo5wBc4sBlzutZugz1Yw/VpPTlmHuYeW7lXmDHxC2Ly0SDYtKdcdi9udrJQzNx4c4Dd
         Scew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751313522; x=1751918322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bRRRZ1lp9+0IPVpxNj7sf43IQvUm3WYy/Y3w0RGmak=;
        b=unoE4WzniTtVPV3wPYO1BiHeB6IkX9XoMDuK3xqW9gUapiA/Na3qWR12g42Gqh8dZ/
         AFnEkbAXZFPCnOy8oFeP2uT3d1hJhlMfxGj6RkBj26GmFnFykwVeRMkSJvkBezsjLo+d
         l5yVtHXYX6fL5XFJi6Qn3/98rCIolEd/D4dljcFjxs6A3s5bw2FyHh4tWZnwpiafyF3s
         KfNVLKjgK+wZiNA30lrp4zb4rOH6rEJkElsPJ8Sb9xqiRFlFXfYsK7wnWVOzjLm/GoF8
         zcosDnQW2jzLXK4RfyLQbNY6vDq5s2LtiPZTwyWlT7D5mKQWdsNJ2hiHEqWGhmzrNC35
         Sf5g==
X-Forwarded-Encrypted: i=1; AJvYcCWG1kktaemX4flRBXpk6TMm+2IJ9ISq+UT4mOyQqdbNMB+jJwHBYtKuKTqsKqw1fKy1pLNtrySz@vger.kernel.org
X-Gm-Message-State: AOJu0YzvrOpT8kkpa1PggQXu0eMKZbCBEGcmOC0M2sABXrbK5icaCNen
	TXNvCyqVbIiQomAKXmjcQ4so5NHUqXL7k569Mz0vPDxse5tz6QLsXSHqW52NtiAF4re82yxq+dQ
	9EXNRGBJE60Jo1AyH8DfUcCmYgPjL7jWpunjdVB4Ewx72PEcsm4/KOReXQOI=
X-Gm-Gg: ASbGncuySnTIsn/dNzz3PJuG2D9OumyUMDbIMPiJA+3DG9CfnisKXtrgWQHXxklJEav
	C73HC2d80zLq1QWASoe9JK1KYq67HjnLPgtOv7w8APrUKhc8PcPE7dcCuMEQkXYjGSxQM/ihOvL
	tweEOikWDrNRDy/3Fw+uMZ/Y8tiKRsoyiDgGnvKzhWFA==
X-Google-Smtp-Source: AGHT+IFZ5lHZOcOigJkjUG++4rwBcWPdV6xQNKDJ6iwEA2oDTgaw3v7Wu+bXd4VrjH5VXCxnJPZwDCghzRaR3ZIciU4=
X-Received: by 2002:a05:6402:17d5:b0:609:99a7:efdb with SMTP id
 4fb4d7f45d1cf-60e33326819mr14649a12.2.1751313521898; Mon, 30 Jun 2025
 12:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620082906.2122560-1-jprusakowski@google.com> <20250620142825.hczg4ldsk46delze@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250620142825.hczg4ldsk46delze@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Jan Prusakowski <jprusakowski@google.com>
Date: Mon, 30 Jun 2025 21:58:30 +0200
X-Gm-Features: Ac12FXx05NxpsjifcoA6eInw7PBfzkMDGedAW-Wuny4Tfpta1YfZQChx-KIS7ns
Message-ID: <CAHwWncjjZdcXDBmKH-Hm8vL2MW_9rHjr6_fPMxwhUAkmjiuNHw@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] generic/018: do not run the test if a compressed
 filesystem is used
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 4:28=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> I saw you used _require_no_compress in your patch, but this function only=
 supports
> btrfs checking currently. How do you avoid your test failure on F2FS?

Hi Zorro,

You're right - that patch won't work as I intended. Thanks for taking the t=
ime
to review it. We've done some more checks and it looks like our initial
suspicion was wrong and we'll need a kernel fix to address the problems wit=
h the
test.

Thanks again!
Jan
