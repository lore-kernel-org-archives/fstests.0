Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7F18C2F
	for <fstests@vger.kernel.org>; Mon, 30 Oct 2023 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTq9eaNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BC2C433C7;
	Mon, 30 Oct 2023 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698683034;
	bh=yDnmxU8WKBCuwujJb2yoPkjlD82UM0vuuXD653YI79o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bTq9eaNWUm2Kz/9rH345+b+6CXqryy6kJKoQUHRRxEG1nBQ07DnJqdqv2FAOcGGKG
	 Ux4sTzje6uhNuotxJYzcAn+1DL4bwJoC52Oit3huBvZL5O4llZqwQRRHK3ykLhyz/C
	 wZnRdkCMnAn880kexWqGiTIae3r1MmOudddOpbFu+EhxF2lurx//EVN5eYV05GnGC0
	 GCQRiFKieAgk6RZoMKDOwbJ67n0EURW6KL/7yqLTOpz50eBWdmyicoxyA8bBGay2rO
	 NkShXEncCxGz1TFvkm/rdMfNijqq9GrgCUbmhkJthv9aqiiYPrYb3x5NzYvqOMMdt4
	 nBON1vI7w2oqg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9d267605ceeso263749266b.2;
        Mon, 30 Oct 2023 09:23:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YzZyXDvTWV4UlRqQHXvKSp4q3UTduJRQToOiv7d6/e4HfFGwcQi
	M0ADpMF/RmstJ3YKW9fGMqv0ITqu675LJRzVfeU=
X-Google-Smtp-Source: AGHT+IFSeajrgWD6++621780V+d2wx9xU6A8tHUIJyEG/aRlltG4qwH1awWiwga11r1z2yLw2srxus3VKpRbkkViHpQ=
X-Received: by 2002:a17:907:930a:b0:9ba:3af4:333e with SMTP id
 bu10-20020a170907930a00b009ba3af4333emr8267476ejc.14.1698683032748; Mon, 30
 Oct 2023 09:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698674332.git.anand.jain@oracle.com> <077b252e8affc50ad3d7826d57ba42a2a8746d13.1698674332.git.anand.jain@oracle.com>
In-Reply-To: <077b252e8affc50ad3d7826d57ba42a2a8746d13.1698674332.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 30 Oct 2023 16:23:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7zgJ68UpK3+CiJBtFJC5JoUiXGV6rcpEMVg9ae=omByw@mail.gmail.com>
Message-ID: <CAL3q7H7zgJ68UpK3+CiJBtFJC5JoUiXGV6rcpEMVg9ae=omByw@mail.gmail.com>
Subject: Re: [PATCH 3/6 v3] common/btrfs: add helper _has_btrfs_sysfs_feature_attr
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 2:15=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> With this helper, btrfs test cases can now check if a particular feature
> is implemented in the kernel.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/btrfs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index c3bffd2ae3f7..fbc26181f7bc 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -753,3 +753,15 @@ _require_scratch_enable_simple_quota()
>                                         _notrun "simple quotas not availa=
ble"
>         _scratch_unmount
>  }
> +
> +_has_btrfs_sysfs_feature_attr()
> +{
> +       local feature_attr=3D$1
> +
> +       [ -z $feature_attr ] && \
> +               _fail "Missing feature name argument for _has_btrfs_sysfs=
_attr"
> +
> +       modprobe btrfs &> /dev/null
> +
> +       test -e /sys/fs/btrfs/features/$feature_attr
> +}

We already have _require_btrfs_fs_feature() to do exactly this.
Tried it in patch 5/6 and it works perfectly...

Thanks.

> --
> 2.39.3
>
