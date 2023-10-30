Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821318E04
	for <fstests@vger.kernel.org>; Mon, 30 Oct 2023 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOW0z3nA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A0DC433C8;
	Mon, 30 Oct 2023 16:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698682657;
	bh=a2qfHa7pueDVA2/wA1n49F3aNS3apXsAhQ22oum/Chg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HOW0z3nAtbxpU4jcDmtO+KM9HXUU8NI5wdSjQzRkIn6vPw6AdUsYvofsER44vo7xv
	 uSoVk7wwOxFeiRmFLTOGnWWLJ96LlIITovuqvAqJppcqm0ZLMU778Ema4fCQ3qEH1h
	 HOBadnWs9yl4WVr58YaC5NZf0o+xPhU419IBXXsrDBDhc1raaOqM6u+u9h7GCt/F46
	 PsQuk9aM1ifiTLgz/JRlqIAecgWMTag8avJ+E7wJOW8RXJPshA9+TRSSjNhw4ZCHGw
	 o2FOdRXFgpfI265NbJCS3XOfgwfoh5TYeDSzIjbM5zNyZdnBFwwDqi09QAZLb5NWCm
	 EvEbBD6g9lr0g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso230741466b.0;
        Mon, 30 Oct 2023 09:17:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YwSvxQm7tzXI2fO2mgZVU0J53alZyo7N4wmxb5die9hk+XZQ1Pg
	utym2lkzmng24/LQA7qqQR0d1kDmdn06L6Ob5JU=
X-Google-Smtp-Source: AGHT+IHNympvAsRDhEC66Ah5hWqL/T7mRJRq9tVwkKSwH1HTRvOrQty0gnvFwqExws0m967d2W2axB+bwqtI1FlRN1Q=
X-Received: by 2002:a17:906:730d:b0:9bd:a75a:5644 with SMTP id
 di13-20020a170906730d00b009bda75a5644mr9362992ejc.16.1698682656030; Mon, 30
 Oct 2023 09:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698674332.git.anand.jain@oracle.com> <6ac586f4697e84c846a36cbc42b005c254b83de1.1698674332.git.anand.jain@oracle.com>
In-Reply-To: <6ac586f4697e84c846a36cbc42b005c254b83de1.1698674332.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 30 Oct 2023 16:16:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6ia6vg-MyXgR7zGvUOB-hVbFBJvQJmBxpdzojbcF_X7A@mail.gmail.com>
Message-ID: <CAL3q7H6ia6vg-MyXgR7zGvUOB-hVbFBJvQJmBxpdzojbcF_X7A@mail.gmail.com>
Subject: Re: [PATCH 1/6 v3] common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 2:15=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Currently _fs_sysfs_dname gets fsid from the findmnt command however
> this command provides the metadata_uuid in the context device is

in -> if

> mounted with temp-fsid. So instead, use btrfs filesystem show command to
> know the temp-fsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>
> v3: add local variable fsid
>
>  common/rc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/common/rc b/common/rc
> index 259a1ffb09b9..18d2ddcf8e35 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4721,6 +4721,7 @@ _require_statx()
>  _fs_sysfs_dname()
>  {
>         local dev=3D$1
> +       local fsid
>
>         if [ ! -b "$dev" ]; then
>                 _fail "Usage: _fs_sysfs_dname <mounted_device>"
> @@ -4728,7 +4729,9 @@ _fs_sysfs_dname()
>
>         case "$FSTYP" in
>         btrfs)
> -               findmnt -n -o UUID ${dev} ;;
> +               fsid=3D$($BTRFS_UTIL_PROG filesystem show ${dev} | grep u=
uid: | \
> +                                                       awk '{print $NF}'=
)

awk -> $AWK_PROG

Besides that, it looks fine, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +               echo $fsid ;;
>         *)
>                 _short_dev $dev ;;
>         esac
> --
> 2.39.3
>
