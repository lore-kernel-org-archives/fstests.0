Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505A27815F
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426222; cv=none; b=DWX4aJk7g4vECvXr9QIuhh4q9szCisRC8+jCzK0jy1zReV5IWy8LI01TKmm4JccERF+EmfSMFXF5RElKgkNzEX9wu24W0dfzYh5rUGtHoreiXXMWXCIq0TeTRxMDbcyTrL/q1F3v1JyGBCN75XBM3GQq1b7oM/ihslhJtLlU5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426222; c=relaxed/simple;
	bh=Fbjdhcm3r3q50qmv2JxWvZc9gCUBUbg+AG7nZK6Y3Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo2CuLOqbuYJMuDUkxlT6oFL/2efpbdo4HGh9hoR2LoZ1pThRUws/BL49wIWbF8x+SC1FTrwdtKp3z9rAUKKVPHHndEuB2qjG5Y9B2yyZncHsUk1bL1zEJDpsr8WTH/MQ4n1relSI2tpHm0hVX9cFDRzt0BSf67nQ/oUawRwPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=myDAX8hu; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="myDAX8hu"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4768f90bf36so36243861cf.0
        for <fstests@vger.kernel.org>; Wed, 28 May 2025 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1748426219; x=1749031019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/OTGAEmndSC5Obq0QUG5iTzbIynWduhdWMEBGhWnYLc=;
        b=myDAX8hus7JZZOEH+mlkBKlMDNV0KFctvXPYLB5hLri411pg58QIZOqJRg25N0Dgms
         YdFsQHSDp9zgQbHfnwlTrKX2YMN6d6ycUJHfUpluqO5L9Pi+dZF2aWvAEf/rPfe79qGz
         rUIPCG4LjvBkrpPFumneaeSMliL18ukpfd3/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748426219; x=1749031019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OTGAEmndSC5Obq0QUG5iTzbIynWduhdWMEBGhWnYLc=;
        b=o3Wlbf4oYyJSe0ZE7qJhESQTryoJRiVWi/4yq97GcA7j44WwXi+3btrnCAX6gksgom
         McfzRM+rEiMic0ud31uA+j6s2V2OZvWh6g2clYqL+D9/nP3m52InDku7EGyHtwZfCspq
         L0tKADZaE4ecKz/lEzQ7rjH5twg8J/+Go7d1WGWwuMZZQAXFQMpCUNR6qvoZ73KgEr5D
         J0wlUhY/9kOr3pvvw2sdTiK09jdf/7dsIgyE7v9Emf6ERAhBKw+vDl4vV9XvtKgLrM9B
         7pZqomV0vGWMEYvErrzVj9t3F692szeR15vYdABOSSDWhTJ9mOVNeR/aL/mtMdyvUKjw
         7v8w==
X-Forwarded-Encrypted: i=1; AJvYcCVyM8kvEHopwfsy6DEHfjCeAx3So6cN1xcNNgUIrndbfiL5HcK/oZg9mc7NF4aCWq+xN0IWbrCI@vger.kernel.org
X-Gm-Message-State: AOJu0YxA08/ruSvAGtk14o0D83M1SrOFO2vHFSAixoJA0GHOf7mHy3wH
	Ui3lCRPULCFXMlnnjmOcxOQMa6o+VYi1tT9i+3TBz+AgIelSFVjhpWAqeCXZEooKFpLGJ3D0Ccb
	wt4AUlYPl+3AP+SfjEBa7cgVqUy7uQgu8qwsUUCgQNQ==
X-Gm-Gg: ASbGnctGXCOKspTqLqBcAB7rrmlgR3edyBwm3WQe97HlvtJATSrJIIH9KjRwzMNEccm
	kCzi712yvA5VqLt+QMCl6SE2HTs85ZHeUi/QejoqgnSJSkE3mzKTH52MMFCqKjDRmxDEqFjF7ZP
	XHaW/8LUe/1LfHRB32TdK7P+3Z613HpqZrhSg=
X-Google-Smtp-Source: AGHT+IG2PxsM6SUYNrIaxsE7msw8VoQWZplwRrigyQqs0W6Eqtv7xRJPX7sphVk8r66KtkEeuRqdssVuipKHpsUIqvY=
X-Received: by 2002:a05:622a:5a92:b0:476:9e28:ce49 with SMTP id
 d75a77b69052e-49f47de6805mr280013801cf.43.1748426219251; Wed, 28 May 2025
 02:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526143500.1520660-1-amir73il@gmail.com> <20250526143500.1520660-2-amir73il@gmail.com>
 <CAJfpegtYTpJXYOiyckcfQA=YTVXcLQZRGV4=sjueLenJpTp7Lw@mail.gmail.com>
 <CAOQ4uxjh9u3DE_HKExa=kK08efzDsxVuCVuA0tUMjwSeLX=jnQ@mail.gmail.com> <rjqagpvze4mwnil6tck6jnyqfbcgqszy5bjgu4fqzdtq7e3idq@uizmifogsqyf>
In-Reply-To: <rjqagpvze4mwnil6tck6jnyqfbcgqszy5bjgu4fqzdtq7e3idq@uizmifogsqyf>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 May 2025 11:56:48 +0200
X-Gm-Features: AX0GCFvBaXP2RRkkeHKZOQBJmkpUzhyMaOwbDAHUQ74vl9F-mCyBnRGR97bDRsU
Message-ID: <CAJfpegtJ3SDKmC80B4AfWiC3JmtWdW2+78fRZVtsuhe-wSRPvg@mail.gmail.com>
Subject: Re: [PATCH 1/4] overlay: workaround libmount failure to remount,ro
To: Karel Zak <kzak@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Zorro Lang <zlang@redhat.com>, linux-unionfs@vger.kernel.org, 
	fstests@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 10:47, Karel Zak <kzak@redhat.com> wrote:

> Anyway, I agree that this semantics sucks, and from my point of view,
> the best approach would be to introduce a new mount(8) command line
> semantics to reflect the new kernel API, something like:
>
>    mount modify [--clear noexec] [--set nodev,ro] [--make-private] [--recursive] /mnt
>    mount reconfigure data=journal,errors=continue,foo,bar /mnt
>
> and do not include options from fstab in this by default.

But there's no fstab entry in the testcase.  The no-fstab case likely
gets way more use in real life then remounting something in fstab.
And this should not need to get the current options from the kernel,
since the kernel is the source of the current options.

With the KISS principle in mind the non-fstab "mount -oremount,ro
/mnt/foo" should just be translated into:

fd = fspick(AT_FDCWD, "/mnt/foo", 0);
fsconfig(fd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
fsconfig(fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);

and the kernel should take care of the rest.  I assume this doesn't
generally work, which is a pity, but I'd still think about salvaging
the concept.

> So, you do not need LIBMOUNT_FORCE_MOUNT2= workaround, use
> "--options-mode ignore" or source and target ;-)

Yeah, that's definitely a better workaround.

I wouldn't call it a fix, since "mount -oremount,ro /overlay" still
doesn't work the way it is supposed to, and the thought of adding code
to the kernel to work around the current libmount behavior makes me go
bleah.

Thanks,
Miklos
