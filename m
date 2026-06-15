Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3240171CD
	for <fstests@vger.kernel.org>; Mon, 15 Jun 2026 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546598; cv=pass; b=daB3efiuqtVA/x0/zJ3YJzuif+GOWvmQCfrw74D0rrOFeG/Yt3M3PgtmDRi6B3zhx74u+52yvtA/HahR7HRkuSwYc5oCXMJAbxckGhSBfLiVM2NxKVWFfSbf3FKd8yw4tzFB94dsgvX4jVInYtwySqacPIV64zFoGtqgYqU9fFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546598; c=relaxed/simple;
	bh=hBOi3p0V03qyFPtScOsJhsmSy+M+ZuyXWOL5390UOjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neL0xPDoFq3z/5uY8JIygOQDYrrhpDaHfnswLlcSNvqWJyrJd9cRCrFU30hWDpfcHS1q4sWyIoj9KPYlpSMMrL+eN6qODHtubrsGe4dAxomqYv109ufZdIrFPaEmvCdvgIzO8EyGJ5yJ10KsRD1WhW80AM3yMTSoocbYraBWwLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myIZemFv; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myIZemFv"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so7147712a12.3
        for <fstests@vger.kernel.org>; Mon, 15 Jun 2026 11:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546595; cv=none;
        d=google.com; s=arc-20240605;
        b=YUrKnIUljj5pwxUhO5GxT8djFTFuSf5ZBN1g5pPvRx3DYHlb+9dqRhTxsIN2FSGutu
         SwD9hmZ0WVQYVEhW1MUsu2thR2Z/JTMtjZJhXhg0+nJtYNf0mP3SGHnBO0BhaQXD7uyq
         vJuPLV9gXsOIuMeBuiuh099/BHQGrrARxYA2MFdQQGurPSFnfUkh1EbySkkWpu3HMFMT
         ZiFBBterIKJJWMvx49R4KhE8YlDTn/I9vPqyVw5nKo75ZzrZcMNLTvernGFssaPHNiQs
         lTkbj8dh0M/zzY3I8ySeqH1u3szjHkSGB/aLiBrPWsEEDvnbvO4carh+3772EED7M6GD
         qhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBOi3p0V03qyFPtScOsJhsmSy+M+ZuyXWOL5390UOjQ=;
        fh=hCQiK1U1ukw+9q2FgbY8N9divoaQnhpYhL/oJjjG2PE=;
        b=Xs7SbLNMBFRvK8G6grLQyxR6cU6BFU/pgWnKT/NwzvKM6YmcN8Bwx7AnwPeecrVDsh
         3eyf2QnQF2l12mxSlQ5ecPe3kvrx8Pfr7e+tKjANnHRDCzqWGgVmDsG4t+sLRTjXYS6k
         YsSa3bBQ0dUPd5CeOjzC4/QFDilpUBGgB/bay1BLMgRdiaL2yftNe0ni8EQG4Oni8vGm
         gHMSYF99Z2kFZbOLcsal0NZedFVVnPr/wr0jqFVHCqAYh234G9AhQh0Y4CZv+j+HwhWT
         jSoMubprGChtxWGFuQNrJXuH15xzkm4vdLdDI8wR4PS8Up6qvPSO9aF/7tPupazUKPn3
         V2/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781546595; x=1782151395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBOi3p0V03qyFPtScOsJhsmSy+M+ZuyXWOL5390UOjQ=;
        b=myIZemFvoTlAinWuw3Orhm2XFDBji4wzeW6yNOCib9ozeADZEaYk/q0fhzr6IONarQ
         Yz7KWrYjYwGUX/rDDB49HDNe9DjyVi1MwS6mhgW4R/EG1ZJ2xzGSaa4g4sL1T6maKRpu
         y3LwvoyxIfcw/hh/Eqy1MxPb8NCPXYtPSi0f8dW+Zx2gb4kcwU3gmbGOZCkU1dRpLvVh
         /1XwvNSKM6AbxmIwiG3IPdDitc+bMYCAj2W4iXHkafHWS4UHNgTj946eY63jZLb+61lc
         LTowbs9p0s9ytXozYIKEGLGq2V0fSZ1BXt7MARCqcqyuJTHufK0DKyR/HC/RZVFGFx+G
         c6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546595; x=1782151395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBOi3p0V03qyFPtScOsJhsmSy+M+ZuyXWOL5390UOjQ=;
        b=UsOfYjhsj8Xo+SOx6CBzlRksc6BH+YWJtl233ZfuVsldp8+4zLjR7BvszShDNDW0/z
         78lPCvyHNcbw57ufRcxTkVtUcLrRq7KI7cP0QKmH0rhL4740LeK9H++/xonXHSuEYwF+
         mNgY3G5bNJoL6rmDA5aX0znUDC89Fxoyv8tGz46BXqPUapekl6KwU4R2Ub+yUZrl5B3X
         qjaPEIeBm2+vOB+nlELp/dyT+WnNgjWR00go2BO36NouIEFuePl60UIcsqAmow3m0o4T
         hjhoB021ygbWlAl7joX0x05X9/uhVT/yPVgclOuKU4T8SKZhxxaBFcrrg8tU+D33gYSm
         yAEA==
X-Forwarded-Encrypted: i=1; AFNElJ/TY7yNDeSsu1Bql4Rj+gEWLYVbyg5RIT8JFOPXmE5zS35g7hQuPYwgq9L7L8Cn6OYGSS9ewOEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8U+qfaypK2dWIlhp4ul+nM3KqaPPrEO3Dkcm9+xqFGSpaDSB
	n0w4a98wlxiQNUI7nLDx7wa5SJHSW9mNoWrKsw/MGLI2/eEB4/KXHHA37XGirN8cTQVhVy3IERk
	C07G8ZtHGeT+LEgwzyrWquVqgNOoKAso=
X-Gm-Gg: Acq92OGeBMyUNxMRIXSYmHqAy07ZRWGmfEmXfGnjGsfAi2S4+sXfSZAqUu5Wjw3YiC9
	BfSWJTVH0fmr6q8f37nGY7Ljk7QwcYQpls/wNhDshJ+VKSEqRXWKgvbwieP+UmjVB9cpM2moxhY
	KDv0260NOzWD2iziyqz49qQJnzxtH4cGDEqO0T1MT0WJz1UHGG8ins8jKV5hwCDMnnNqMnuwpxU
	grQVVTyJHqFuFzPoGley5nEQKu4yEYyPFZfOVo+01i96eh+fDZd8oZrisjlUZ5vTVCs0UM4pAHR
	3VFpKqCNnjM6eALonMjf2MgpSGLsknLi5uAlpdsgZw==
X-Received: by 2002:a05:6402:5d0:b0:691:706b:183a with SMTP id
 4fb4d7f45d1cf-693788fb0c2mr7319496a12.6.1781546595064; Mon, 15 Jun 2026
 11:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-overlay-idmapped-vfstest-v1-0-c6b3b2228092@kernel.org> <20260615-overlay-idmapped-vfstest-v1-2-c6b3b2228092@kernel.org>
In-Reply-To: <20260615-overlay-idmapped-vfstest-v1-2-c6b3b2228092@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Jun 2026 20:03:02 +0200
X-Gm-Features: AVVi8CdpMlwPdMYy_oKn-YBrEOug14SXeIqtiRTYC62U7wjb_HcLETp8cI_hDMM
Message-ID: <CAOQ4uxjtTd0H=DjyyxaOm56be0JOy2y4ZYV8AbVRnsdGnv4hxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] src/vfs: skip whiteout-device fixtures on overlayfs
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Zorro Lang <zlang@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:33=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> The idmapped mount tests create a whiteout device,
> mknod(S_IFCHR, makedev(0, 0)), as a fixture: a whiteout device is the
> only character device an unprivileged caller may create, since it is
> exempt from the CAP_MKNOD check. overlayfs reserves a 0:0 character
> device as its on-disk whiteout marker, so ovl_mknod() returns -EPERM
> and the fixture cannot be created, failing generic/633, generic/696 and
> generic/697 on overlayfs.
>
> Add an is_overlayfs() helper and skip the whiteout-device fixtures and
> the checks that depend on them on overlayfs. The makedev(5, 1)
> "creation must fail" probes are unaffected and keep running. No-op on
> every other filesystem.

I have no strong objection to this patch but there was actually a request t=
o
support makedev(0, 0) in overlayfs for creating overlayfs on an overlayfs r=
oot,
so perhaps it would be better to probe for makedev(0, 0) by fs owner instea=
d
of the is_overlayfs() check.

Thanks,
Amir.
