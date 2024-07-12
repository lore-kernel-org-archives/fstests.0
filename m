Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350616DC3B
	for <fstests@vger.kernel.org>; Fri, 12 Jul 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720776392; cv=none; b=WLHQ+gQAN9Uxy1U43mavr4Zjqv/Ar1qu5QGen+06wDdG10fYFxO7TjpQBteLZVBgCEI1USX//BMgD0PWwF0nbv6XrkNX9Ie7Adwk/Qhk5Rn70BYROC+rplqD+bsOT8tr2PZVaGUyhvOjMO1C0wWuV1JX1U337GZUFRpGqBJiJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720776392; c=relaxed/simple;
	bh=35WkcMjK2xOFy1uzNShcubhWcKG3F6XnMsljZYYCqig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUp3gVYbH4LdzV877Lw4Xebtqh8RFoE4e995ApzJ6uM7LRfw8GnHHvHUeO48WOwENZ1mdaRjuLb4wt0no4lZIQl2XIwSy0FlVGXspHRKDfFsClMDmo1wYFpdguoYsKwHvdMDIuPNtzCM8mJffDoyd2OP6rsoGxQ6yXIvwjdoQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhS3q1id; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhS3q1id"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720776389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvQCVOYv4dYVR0fdwwPxrnAbudsdeCOAappF4eD08RQ=;
	b=KhS3q1iduQOz5fpolCGAgj1u9JENepyRExHR4YA8PtF5E3pPF5OLBt5VqAXYOeBp9aY0yy
	PW8KQPhBEdj8QYmr0CIyhmwuIm5t/WMB/U1yY08dnY6XVDSsUYP/q+lWSMHZe25hbninAS
	QXx+nzpkursjyrWuSY0CTHlagvtZXtU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-5SGE89DMNNqyYflCyDXpdw-1; Fri, 12 Jul 2024 05:26:28 -0400
X-MC-Unique: 5SGE89DMNNqyYflCyDXpdw-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4f2faaa4dd3so621054e0c.3
        for <fstests@vger.kernel.org>; Fri, 12 Jul 2024 02:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720776388; x=1721381188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvQCVOYv4dYVR0fdwwPxrnAbudsdeCOAappF4eD08RQ=;
        b=bn5e/CW5Cs98lipg9XWe5IJ6kQcJmuKl421C4Zqkg4xnc5hZT09juPJBSr9C9cwQ1m
         BdZScfXIweMBjXflpUFPFNWXCt+mHBQQKQwPH186SqnEnLkI1RkwueKdh05Xdgnrb0SD
         8mMNTY0n2aRAdYcY4gUoX+MPmMSDVO4yw/EE6ipruKZnl/YIyIHGC4Z5ycTpzpGZLpQI
         gkw+1e8hk+Y9AYhNfz0jJ+e/0iSVn+UstGo6GVV8cvYrntLqv6d+vD+ygLXNtgJW/EhR
         Iwq+tJQTQ5ii9oXQl0DFDRo9ixUESjmLO9DlI7ltzZ9P1quY+dAfSlhHSxq0+CSv0iAo
         a1Cg==
X-Gm-Message-State: AOJu0Yw6wY9fzWlAwkr1lJoL0U8TQ+OheNFbf0FAUAYGcBDTS5suWSGF
	FlzEXIvix2/UvN1az5Ul/1jSawJsM3W4Oe7LuvQxfArS3Ws8bcTYEjpkBE/ISfgADgxK+WYch81
	sMU9OZqz6qCHp4ewz46iv1WAD3whjf1t4swf7RZ2EFWRrpLze2QvPLzVoLkZ6UgTogN59d54yYY
	/Ctk1hzBVBudtHOgLzJfJCzIusab8Rng==
X-Received: by 2002:a05:6102:94c:b0:48f:c031:3fa9 with SMTP id ada2fe7eead31-49032187c6emr12874155137.12.1720776387732;
        Fri, 12 Jul 2024 02:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4CmMWus0dk+UzsfljC4q/GAd8odD1dH/cD417ekW/1YTt0ws5nUKLVs63EQ9jiINUcAiLYHkAH27k7MYdsJ0=
X-Received: by 2002:a05:6102:94c:b0:48f:c031:3fa9 with SMTP id
 ada2fe7eead31-49032187c6emr12874144137.12.1720776387420; Fri, 12 Jul 2024
 02:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com> <20240630-common-fixes-v2-4-16d26fb1dee0@samsung.com>
In-Reply-To: <20240630-common-fixes-v2-4-16d26fb1dee0@samsung.com>
From: Zirong Lang <zlang@redhat.com>
Date: Fri, 12 Jul 2024 17:26:16 +0800
Message-ID: <CAN=2_HLOiaOmDud7SoFN3UtRXFvnbJVS-vaETEhKKaqF7=0xBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] common/rc: read config section mount options for
 scratch devs
To: da.gomez@samsung.com
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 10:52=E2=80=AFPM Daniel Gomez via B4 Relay
<devnull+da.gomez.samsung.com@kernel.org> wrote:
>
> From: Daniel Gomez <da.gomez@samsung.com>
>
> MOUNT_OPTIONS for scratch devices do not have specific fs mount options
> values (such as TMPFS_MOUNT_OPTIONS) from the config section. So, allow
> the scratch mount options to inherit section config values by reading
> them from _common_mount_opts().
>
> Move $* to the end so scratch device can be umount/mount. Otherwise, we
> end up with multiple mounts in the same scratch directory.
>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index 51827119c..627dbaaaa 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -231,8 +231,8 @@ _scratch_mount_options()
>  {
>         _scratch_options mount
>
> -       echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
> -                                       $SCRATCH_DEV $SCRATCH_MNT
> +       echo `_common_mount_opts` $SCRATCH_OPTIONS \
> +                                       $SCRATCH_DEV $SCRATCH_MNT $*

Why change the _common_dev_mount_options to _common_mount_opts? They're tot=
ally
different two functions. And this change will cause many test cases fail.

Thanks,
Zorro


>
>  }
>
>  _supports_filetype()
>
> --
> 2.43.0
>
>
>

