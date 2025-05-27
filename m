Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041012CCC0
	for <fstests@vger.kernel.org>; Tue, 27 May 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357352; cv=none; b=MTaxH4wZGn3qLM2wdm+S11epZ+P9YSUzocEp+lO0AqEoHC6ZyubyH9njPu3bV2/Bht9P06l5UtjrFRfvpR6kfOFC6UYXxRssVOKcsjBWB5NKi9Q91o24tMrgNI5xmhi8CjLYMBHc3lLtRGbMR1y2FtctHDflmPuUOEY19A2pkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357352; c=relaxed/simple;
	bh=sAiJI1O4JMXS3CTzVvXhahSMi3q9NSOWIzU1NDbfOSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDzzBQIDdqaBVcZaYyyWONIKhFgQi74JbdV43c1I5HU/eMQ3okpQvazk9DdP1jaUW46pBAjvhbri1mjhtVzwiy4dYHnDLTdqR6HxFTwy5wZB0yX4YvEGGGB6hT7Hhv8/X+5GI8+mvX+tuOWKrxsyVkrQukn0Tgq9al1H6TscsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iGEM0vPJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iGEM0vPJ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47698757053so38773281cf.0
        for <fstests@vger.kernel.org>; Tue, 27 May 2025 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1748357349; x=1748962149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sAiJI1O4JMXS3CTzVvXhahSMi3q9NSOWIzU1NDbfOSE=;
        b=iGEM0vPJmD4U7evlqR7S8a1CMzylkxnMdnBfO9XKzvO9UzGS9aMEYLT4YH/cbaxEq/
         ICkpRNHzoDxELEQAE7GbVQk8nisy1vbIjtIU1tISofHinamqt7iW8rX2fqBJA5tG6S8p
         3TuTzS984X0lru56Shial6sXOhsZk8/DyWwV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748357349; x=1748962149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAiJI1O4JMXS3CTzVvXhahSMi3q9NSOWIzU1NDbfOSE=;
        b=vjme1IV3zf0tt4CWqXJO52LDyY2bSNaNe9XmEhCDE75PWz7FPwm2O09LcwLmpbstnG
         TdLRcNitk0ObdJBN4OAG2HG9BGMGkxlUzZVlogpSPBWtzTwIa5S07+sFpt2Tt3AuMxhh
         okRDj2v2FfxYCOWaNBArhEMwgmWm6Rf1q6EN+tGd5qxeC0d5oes1ecWfsZVzE3DeG/NJ
         Ol9gQtcdqW1pvlDQKp+whZeFEBxvG1wZxKOELMchPFQ9gDIdTSb8t/TsMbiKxyuRtVwn
         Hbpdj79Nw4hFA82b1xLyOeN+NOW4sJg6PffFV6JDpuQFD6aVwSi870hcd6JXIpKr0Obh
         +GYA==
X-Forwarded-Encrypted: i=1; AJvYcCVC+Ns9eDkedK6N7yvaOghv6ZZwOvlF6gu6kTN1szGnYup7NKBt32zFNIsPrWjS2z74OdA9SKLJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHcCRwu/m1RsERWgxyMeou3bc7StmWiDwuxKgFiRfVipVs07eU
	cfHHRnF7qwhP+ww7PGM5X/d6qq8aim0CAQRrrKUVcetQ/sNfMqTQpjoBwCi67FGeV+xL9+Omr0V
	JZIM8BHmL1XFXMn+NwIsUXxPnoRhmmyCoIaRD+lmIBQ==
X-Gm-Gg: ASbGncsLWFNsyq+ACYTDLYblueNBqMGdigJTKQIVkcfiJqD7cLHDUPSxtJxX8UFc9nC
	c7L7//3vCc0b2yIsay2QnX+mKZtlALWjqJBzCbx5DclZcBA4tu3svyT+mCoyqNVZPluvbngA0qL
	sGvqBUZYFnMuBhjt1SQ+nVA+ivwwid+12zZrE=
X-Google-Smtp-Source: AGHT+IFKdB9PF1d1KvdjvhT+vpEtaK2jXUaSke16US5DJQ6ZKruJPm+x+ZTCVDhpG+EeSm2Ngd+vuQwEm1YhT98hRqo=
X-Received: by 2002:ac8:7dcc:0:b0:4a1:6656:16f6 with SMTP id
 d75a77b69052e-4a166561786mr115084911cf.1.1748357348899; Tue, 27 May 2025
 07:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526143500.1520660-1-amir73il@gmail.com> <20250526143500.1520660-2-amir73il@gmail.com>
In-Reply-To: <20250526143500.1520660-2-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 27 May 2025 16:48:57 +0200
X-Gm-Features: AX0GCFs3VA7UJtczZg8oDvYBTyu2JNhge9dyhvB1RX5a2h1bXGDJo5UYxG0WVm4
Message-ID: <CAJfpegtYTpJXYOiyckcfQA=YTVXcLQZRGV4=sjueLenJpTp7Lw@mail.gmail.com>
Subject: Re: [PATCH 1/4] overlay: workaround libmount failure to remount,ro
To: Amir Goldstein <amir73il@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, linux-unionfs@vger.kernel.org, 
	fstests@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 May 2025 at 16:35, Amir Goldstein <amir73il@gmail.com> wrote:
>
> libmount v1.41 calls several unneeded fsconfig() calls to reconfigure
> lowerdir/upperdir when user requests only -o remount,ro.

Isn't this a libmount bug then?

Working around it in xfstests just hides this, which seems counter productive.

Thanks,
Miklos
