Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272D1354AC3
	for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819928; cv=none; b=S/lvIj9UdKd8VlGAFmL6qj0/Ssky2MNvPFn6hVWwFsBubEilBDfG07ddFbHDJnAXXPZHwJbmTagVr8WNisKnOUGi1Cu7VHVwgevSVOpAE5IoSyHZmLENbmShDgeAPvQENXHP5I6iHrxwhZtaOM3nuaEVJ7dfn43qKYSkvSQ4cVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819928; c=relaxed/simple;
	bh=JJIWNnCoiCiguK9/rbFMg0f0XCv3XZGq85zbgk4m07s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXv0lrM8zsAYJex8czoDiTaSit3BurWMo3d0gKMm0kYvOvW8EGBDZ2mSetu5YggJ7Otusw7B0o1Dg56PIG6QLxfhB+dEgMmWirTSMy2R/TLCLm1BWEpiUvngbhYu7UjFmGP+Afrfp4DQ1pxyDP8TW466I5al54WKWj9HKIpBHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcU6vQfR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcU6vQfR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b50206773adso398794466b.0
        for <fstests@vger.kernel.org>; Thu, 30 Oct 2025 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761819924; x=1762424724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgOlSBWsltR3bwKZ0KqRU5bm8t/l2+tDWDnMT0PQAXc=;
        b=fcU6vQfR7+9qSnWQRvnD86md6lNKG5Pd/wTWJoW7Wg98i8LL3C2U1stMOizmJkJYQe
         Y8IcMIRergrEgRzZ3G+S2yrPfVKz5luZwBDVz7g8zLKSC6xKDYN60LZ3fpArJEphAcQ0
         WIjTVi0PG9jm/VGXYPauvzWEIjWEBFkLIUA2cGMIm7t92l6o1AXq1oo1//TeWLieg+k5
         khVPV4O8q1x78F6VH3cpUhTkRNW23Spi0Iv4Ypkz8UVMDv0D1cTZGn513If4v2iBRpQ9
         1UgjvL3+hspth9nRl86Ci4ltWRrUkzxc/zBnVdcffSEtIO+tiuIgrl5f24aAHgGXqZr0
         rHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761819924; x=1762424724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgOlSBWsltR3bwKZ0KqRU5bm8t/l2+tDWDnMT0PQAXc=;
        b=RYb8Ze2B0uKfuOA2M0fwtQSwdZWHWZNvmw672kalXmnrDjo+pkqRKV1ci9TnyoljYm
         zfSU6S6QO/QOFDwEBVZA+CtbGM8r9zoUKhT2NovwxpLSgHo0bnI+yKkNIZJtWHq0HZdP
         dC9dpU8MbEg+WR6Ye0jT5cRWPwhGVFI83Q41vfEysXqALLZrvkvclWxguOfDmw4+AlKS
         sNK9/vCJtWC0Z+lpmKDGLkPCGrJ0r1NJIyrWchQoks3h77nsmK9e8OK98t3XFu70ExNy
         UrIO443f3hApmnfRIXKZ0A9GOJdlF3zuOkd0IhvBXDn7ETaG6ruMtcgX+JD+ie5DAZqC
         vnCw==
X-Forwarded-Encrypted: i=1; AJvYcCUSwEX4l1WhbvReRlgQ8zSDQW9TkcRmwcbH80VlkHQWVR8N2Jpks5OnCQ2NsVcg4eF5b5Mvqb3V@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1JCiWzWwOAML+dIuakaBMLspBcX2lv2ak20fUsPmtpuWvuaOn
	60JGymRYGb0IpZ7SNXr3vW0+RKNIDA8s2hIQ5Ih0uWCXLWxmi1tXT3Suelhf6g6breQUiLB/0Z3
	ZC6yN26WHCYfxC01LTY0z8SJ7oNgrs6g=
X-Gm-Gg: ASbGncvxKs0GNZUtAtLW9FquRRgrGFCMZrC4c5XKP/uYC5I5MC7899m0F/DdjMtm5O3
	vdgn5seMKE3l8Xbcz4LWJGNN2Vm5JPqwdC6qF+XNpmMvlFuiNxMRPWrCoqVDAUcv3jBCZTmKZ5W
	nruHBZ3qp/P+MQwSMkjOnAOumDKPYSXz9tdrkl9r/NaElcfi3GW1G2nV8iGNs1zR7UXeYtxcadu
	tbobHtQ50QbqmUxQq+/3MAiPHNLDvajJKMLSp3VoWB5OO8b2rol5RN2+sPrHBrUoN9FA9//nsO/
	SS1E4jAijHAs0RA2hVw=
X-Google-Smtp-Source: AGHT+IG1s+J1qsSzRLjzHYiT/VYRPZob+nrmIAe/cGI1XD/nmjBEEnz4k4/6pM5ItnXuo6ggIslcbL4yDUTbDqlUHYY=
X-Received: by 2002:a17:907:1b1b:b0:b50:94d1:8395 with SMTP id
 a640c23a62f3a-b7051f6307dmr291641966b.9.1761819924384; Thu, 30 Oct 2025
 03:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs> <176169820405.1433624.15490165287670348975.stgit@frogsfrogsfrogs>
In-Reply-To: <176169820405.1433624.15490165287670348975.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 11:25:12 +0100
X-Gm-Features: AWmQ_bnLwEnVDgdX6KD058UE1kZn67zBdXIwzjqwbOoKyDUWo9XWQMSAUULwjQQ
Message-ID: <CAOQ4uxgQe5thjp_Pfmbwf-P+o9n7a93a7dzS4S0_Rnw--ULBfA@mail.gmail.com>
Subject: Re: [PATCH 23/33] generic/{409,410,411,589}: check for stacking mount support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:29=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> _get_mount depends on the ability for commands such as "mount /dev/sda
> /a/second/mountpoint -o per_mount_opts" to succeed when /dev/sda is
> already mounted elsewhere.
>
> The kernel isn't going to notice that /dev/sda is already mounted, so
> the mount(8) call won't do the right thing even if per_mount_opts match
> the existing mount options.
>
> If per_mount_opts doesn't match, we'd have to convey the new per-mount
> options to the kernel.  In theory we could make the fuse2fs argument
> parsing even more complex to support this use case, but for now fuse2fs
> doesn't know how to do that.
>
> Until that happens, let's _notrun these tests.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/rc         |   24 ++++++++++++++++++++++++
>  tests/generic/409 |    1 +
>  tests/generic/410 |    1 +
>  tests/generic/411 |    1 +
>  tests/generic/589 |    1 +
>  5 files changed, 28 insertions(+)
>
>
> diff --git a/common/rc b/common/rc
> index f5b10a280adec9..b6e76c03a12445 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -364,6 +364,30 @@ _clear_mount_stack()
>         MOUNTED_POINT_STACK=3D""
>  }
>
> +# Check that this filesystem supports stack mounts
> +_require_mount_stack()
> +{
> +       case "$FSTYP" in
> +       fuse.ext[234])
> +               # _get_mount depends on the ability for commands such as
> +               # "mount /dev/sda /a/second/mountpoint -o per_mount_opts"=
 to
> +               # succeed when /dev/sda is already mounted elsewhere.
> +               #
> +               # The kernel isn't going to notice that /dev/sda is alrea=
dy
> +               # mounted, so the mount(8) call won't do the right thing =
even
> +               # if per_mount_opts match the existing mount options.
> +               #
> +               # If per_mount_opts doesn't match, we'd have to convey th=
e new
> +               # per-mount options to the kernel.  In theory we could ma=
ke the
> +               # fuse2fs argument parsing even more complex to support t=
his
> +               # use case, but for now fuse2fs doesn't know how to do th=
at.
> +               _notrun "fuse2fs servers do not support stacking mounts"
> +               ;;

I believe this is true for fuse* in general. no?

Thanks,
Amir.
