Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5491957E4
	for <fstests@vger.kernel.org>; Mon, 23 Sep 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089321; cv=none; b=FToMgTz/wT3hKQSGKLL0BGNpN1/0ln9jXUG5HV0sqVIsnCaAwEbYXzKbcQwsWW/DWzZyDs303c4B+fw+fbhEOxgk7tH8CFJiQxgo6sZt+GQ5a4TQBuEc1jRYIHrPXOFtQQ9mfTtz18jpPNQD14+ZyKUd+f6zC7XapecsUIhMA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089321; c=relaxed/simple;
	bh=zNHD/3P4CeBolKttBIZ+//nSc14eC5QtWsURyrmdbSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trLDHTX2rpYXaMDGC10FzeFIiYJepQYNwcQNzoLL5aQjFEXA+yHblpisXXsTuGma9CK753HadpD6na34KUZa3l1mX6radMiHd5A2sbi/SP8exBz8K1tQgUzJqTFnM4ulXq9QbYwrnoWbIJPaR0/yPVKkD88btwWOATwAx+8kpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in/cQZhV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in/cQZhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA6CC4AF0B
	for <fstests@vger.kernel.org>; Mon, 23 Sep 2024 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727089321;
	bh=zNHD/3P4CeBolKttBIZ+//nSc14eC5QtWsURyrmdbSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=in/cQZhVeo6GJkljyFPmbVGXVT/CI4xBJoF5bAtre6+/vC9jBjVwwvSFZzptSaIf8
	 N768M2iu1148+VU9KKnqyhJ/zG1lXzeSLtfCezxNVjsrjO0YYHirYpDp8mGjUdjpUz
	 tF0Bij0D5zBZfKvO1nMCApHesvGnYMq5nwUxtjW4pIwUe2Mz6VGLe9gY2IGUavWmRY
	 c3L9d5NA0g+scNYzAEkAreoKYrXan/O8iHJ9dgMGF7yjjpQmKFtC+M6VjMRIHAkRim
	 NNPmtKq1e1IhASPTL35M/sGeFeZa8bMJjCLuDluEfIB8lsM9XAOwFW6nxjwafK/8QY
	 XkYolukGd1s5w==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-535be093a43so4982072e87.3
        for <fstests@vger.kernel.org>; Mon, 23 Sep 2024 04:02:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YyD7OmgVCEEtcwrPkiCzBvo1DvQzsr7RsaCiEB/9Vt/gcjkFZLB
	3Xyt4GyC89uOVFxV3OpKwsDS02d/fiakPYoJ/vIH3AJ9hKzlNVIOFrC87DPSdGWgT2Zg+ipZPGc
	tNIfHiAv/d+iSYxncCwksf2JXwjM=
X-Google-Smtp-Source: AGHT+IFY2uvr1CuNuHsx6letRe/y8v1ez1Yv4YI5H4hBk1Mdi1C7I+IwDyNLDrp5Y9rL7PqYPgzncTaJCJnE8+7rSDY=
X-Received: by 2002:a05:6512:1192:b0:535:6cf6:92f7 with SMTP id
 2adb3069b0e04-536ac338d1fmr5149343e87.59.1727089319714; Mon, 23 Sep 2024
 04:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923090607.953579-1-wubo.oduw@gmail.com>
In-Reply-To: <20240923090607.953579-1-wubo.oduw@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 23 Sep 2024 12:01:22 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4dthnioL3m9ejzp8sNOeaYLZpRxd2ciEi36uuZSxGoLg@mail.gmail.com>
Message-ID: <CAL3q7H4dthnioL3m9ejzp8sNOeaYLZpRxd2ciEi36uuZSxGoLg@mail.gmail.com>
Subject: Re: [PATCH] check stx_dio_offset_align to determine if DIO is supported
To: Wu Bo <wubo.oduw@gmail.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Wu Bo <bo.wu@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 10:06=E2=80=AFAM Wu Bo <wubo.oduw@gmail.com> wrote:
>
> According to the statx manual, if stx_dio_offset_align is 0, it
> indicates that Direct I/O (DIO) is not supported on this file.

There's already a patch for this:

https://lore.kernel.org/fstests/20240911035333.364961-1-chao@kernel.org/

(but not merged yet)

Thanks.

>
> Signed-off-by: Wu Bo <wubo.oduw@gmail.com>
> ---
>  src/min_dio_alignment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> index 131f6023..c50ae8c3 100644
> --- a/src/min_dio_alignment.c
> +++ b/src/min_dio_alignment.c
> @@ -28,7 +28,7 @@ static int min_dio_alignment(const char *mntpnt, const =
char *devname)
>         fd =3D open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
>         if (fd >=3D 0 &&
>             xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) =
=3D=3D 0 &&
> -           (stx.stx_mask & STATX_DIOALIGN))
> +           (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align)
>                 return stx.stx_dio_offset_align;
>
>         /*
> --
> 2.34.1
>
>
