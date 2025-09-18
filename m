Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB731C3314
	for <fstests@vger.kernel.org>; Thu, 18 Sep 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215794; cv=none; b=fXm02Mz85j+WoNZoH0ee8vNglpKyV8h6A99WkU112wPFQ3962QB8Cffquktr1gC7lGsTmGh6YUDmoUvux8IoK4lENtJNUCb42q+5tkt9Go4KK4K4Iw5JU/uAAC+ZJT7PSfOEIwDlNj06tpRpiuFZuRI2PisUg4oCpyKe82NnsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215794; c=relaxed/simple;
	bh=EkifGiWVCQfFYy2RLpR0UqqQlQXDCyIcoPQ6A1w0XKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMkdk1QcUABz75nRyq58G9VMHwCmZ/sKgUNBIO1/UnXQLbfjqs+T6ZEommQGTHQ+2jH0qppG2Mb96Agkr4k6wdS6zhXoBpmzsy2NLU9A+0xNPuG83V6IfLjV5nwmYfIF0xpyHvVGwdTrHhkBqm1aZ5GLzh1oN6BJ4FlJ0nAcqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fa8d732daso1580933a12.3
        for <fstests@vger.kernel.org>; Thu, 18 Sep 2025 10:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215790; x=1758820590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZrzq2UFCkB+iJ+VCPkh40NaV8VlgpHQDjMB5lp4n2s=;
        b=FavCB0aayD8RW1JZz79jw1pD344DArv1EhSp9YgqpY2SC/2mz3ybulrPFX/DHX8QkD
         hmvdKQBfx8IkGxrIHfHy8hBRHAEBQ70O9+iG/n13XAYurdxe08wS992s4Y+yzabh1xM4
         mLK1gN8h0JmReFuSQ7kh+47ZfzpRRFPYaxiBl/JKbj+b7Sd0EfGycF2aCuA7r7HPtY+E
         krgpwedR9ejASiSh/gnVaN/6LKvyhdKKMoww4blUfAIN3E+DlaRv+kNnnod54vlTQyXo
         aZzc81WtvkY7HeheSuW7LmJTX3Kb5s2UgCQVGNevh75HmrgW6oEV8wlBqOIeUlLyEWny
         Komg==
X-Gm-Message-State: AOJu0YxPBCk+lBDpRpOlE+ZJ7JRd/98UDlXr/EBrgyelfATm7p3mIxHk
	bjBMNeKasYh5Q9i8KXceih+X/yzPeUXmEviVtf62nQw9V52EJZbXVXtzCal1gen4
X-Gm-Gg: ASbGnctply2wgK2N2cIpKzREtG1SgcLXHS088pbt7ZKYdFpB1Pqf6wkpl6cd+aJ3/+E
	Mdz2R25UMcFkTzGjPFVS5PoUyVYki9zE8ak+W0jpdQ6H04ZzJ/kbAVA6J9VCtzxmGfTFTKIUCV+
	rtIUVlRYArLSyPprWdEY/wdtPidp4dNh8AGndFple1GS99UaGIGjGbEznVnucRfTQP98Pc+Qitq
	x4Bl718xoFEy9xSc/t26+uD2PXP6eXF1F7KeyGitL7DCSNTARA2NVaVLMJ9ah2v2joVDb7ZJqqN
	fnrAsvTMJXhhfe1GY63pShjSYxcrOZffFv7gahy22+2fyK5ED8nNNMyv5tmIw9/kjthX92I2WZg
	/KY/lLIXOPEMpuVi4m+1FXfQoOVdHeo5Vq5l91QYANalHtWrBt7d+jMfQvs0SPrDcSgaAgz8ir4
	TdTCMAfVAo5Bmu2bcvSF4ctyQl1vw=
X-Google-Smtp-Source: AGHT+IH6R7D4CV+7IMwQdT/20PoQRgg9nUixYrBdjvwBhfudRlfZQ15ofBu8gZQWFlbgDtZQE3VGjw==
X-Received: by 2002:a05:6402:5107:b0:62f:1e7a:f842 with SMTP id 4fb4d7f45d1cf-62fc0abc18amr38772a12.27.1758215790278;
        Thu, 18 Sep 2025 10:16:30 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f41594sm1749785a12.48.2025.09.18.10.16.29
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 10:16:30 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so32850166b.2
        for <fstests@vger.kernel.org>; Thu, 18 Sep 2025 10:16:29 -0700 (PDT)
X-Received: by 2002:a17:907:d8b:b0:b04:a1ec:d081 with SMTP id
 a640c23a62f3a-b1bb6802dc1mr790556766b.30.1758215789615; Thu, 18 Sep 2025
 10:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758148804.git.anand.jain@oracle.com>
In-Reply-To: <cover.1758148804.git.anand.jain@oracle.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 18 Sep 2025 13:15:52 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8iXwtdPfhPJSorxhPDe8v_stUURskgji0-Lq1_s+E6hQ@mail.gmail.com>
X-Gm-Features: AS18NWCRwa0LU36c6pi7i3hVz3lUvFq57s2bH2-WY1Rl1K6Q7jLi9gbC4VjJyJo
Message-ID: <CAEg-Je8iXwtdPfhPJSorxhPDe8v_stUURskgji0-Lq1_s+E6hQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fstests: test device reappearance with new maj:min
To: Anand Jain <anajain.sg@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:33=E2=80=AFPM Anand Jain <anajain.sg@gmail.com> w=
rote:
>
> From: Anand Jain <anand.jain@oracle.com>
>
> Tests filesystem behavior when a device reappears with a different
> MAJ:MIN after a block layer transport failure.
>
> Anand Jain (2):
>   common/rc: helper functions to handle block devices via sysfs
>   generic: test case for reappearing device
>
>  common/rc             | 26 ++++++++++++++++
>  tests/generic/809     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/809.out |  2 ++
>  3 files changed, 100 insertions(+)
>  create mode 100755 tests/generic/809
>  create mode 100644 tests/generic/809.out
>
> --
> 2.51.0
>

This series looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
