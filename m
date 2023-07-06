Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D3EB64D9
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jul 2023 10:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGFKZ0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jul 2023 06:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjGFKZZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jul 2023 06:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAA3DD
        for <fstests@vger.kernel.org>; Thu,  6 Jul 2023 03:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688639084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A63lyIBs1VR5pfZpltdeIG7F/0bdA3IWJCmKQZ/Z8lI=;
        b=gKjzWW46/TqO9/gWQgT9HlnaEjFGEAIW/isFoDmj3EnA7zTxGWcHNmWdIeZSBnWrU4U/cc
        yut+wUwbyjhdny+aCXRSduJTaMD+xhgW8ATZnh4VHAaXPmSs8d0oooCH2RWWrbNcJmFwUD
        GAiLxZsMDVQ3WgkeqsMZx0Ds+nc/EQc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-CyEedsQDOZChp8cHJIJxsw-1; Thu, 06 Jul 2023 06:24:42 -0400
X-MC-Unique: CyEedsQDOZChp8cHJIJxsw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-345e7434a79so2130775ab.1
        for <fstests@vger.kernel.org>; Thu, 06 Jul 2023 03:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688639082; x=1691231082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A63lyIBs1VR5pfZpltdeIG7F/0bdA3IWJCmKQZ/Z8lI=;
        b=b78do5IV4on1LFMpZwFqaQuHj5F2MkH5hl2IqPDWpjhP8L6EB5weksrpMCVpwi5opd
         h+dDELzJXh5bKwg1a5H0ugvhc52xWxMGzjYgI+RpnqJxR3utBJjy/5kptlE1K1ndUiRs
         11940qjuRC6abqgvDG+QHgM7txXHOSz7QoOxK157eSbp6wkPNiCA0gFY8Tkrfy5s0nfR
         VUEdjPSb4oZBGuJ/dZRJ3BGX1i00oe4DppRSq5+m3iPUHZ0o+QL0y049eFgbm8yE0xzV
         f+F4ank3f3H7skYpzEh5WvJeAp1Kw7JBfRmHiGm3JZBFubPv1vEoH5//OmIh8ekFEM5/
         YbOA==
X-Gm-Message-State: ABy/qLaHH0mXrFXg9+CnvzcpvYwk7mVTxwNumK8jRmGbLHin7H1Ves1F
        2gZao+OnLDsj6BOkcnH6PjwRp0DD8MeGL9EdKFyCD7uIq6eGcm1iuFTOQpXUod9WWGUfdF3eN0b
        fi/S36Z6CpBK0Osr8dfHDVTb+YD3wXx/EXrjeFN0TWvQT
X-Received: by 2002:a92:c803:0:b0:345:cc4d:bb7b with SMTP id v3-20020a92c803000000b00345cc4dbb7bmr1724846iln.6.1688639081897;
        Thu, 06 Jul 2023 03:24:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFsi/ILE5yudppFjjTFCadU7uj6+pDPYoTK0ET+XgI8Dy2atiaa5AFTgjzsH3vYzuBdp5gLXqI0spd/MT8FjF0=
X-Received: by 2002:a92:c803:0:b0:345:cc4d:bb7b with SMTP id
 v3-20020a92c803000000b00345cc4dbb7bmr1724831iln.6.1688639081670; Thu, 06 Jul
 2023 03:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688634271.git.alexl@redhat.com> <76c983397d13212ff3105ae05fe4240d830440a9.1688634271.git.alexl@redhat.com>
In-Reply-To: <76c983397d13212ff3105ae05fe4240d830440a9.1688634271.git.alexl@redhat.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Thu, 6 Jul 2023 12:24:30 +0200
Message-ID: <CAL7ro1GSF62xtzRuJDD9rQYT=cNGdhZHw+gatQwDPCNeWmn52g@mail.gmail.com>
Subject: Re: [PATCH 1/4] overlay: add helper for mounting rdonly overlay
To:     fstests@vger.kernel.org
Cc:     linux-unionfs@vger.kernel.org, amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 6, 2023 at 11:50=E2=80=AFAM <alexl@redhat.com> wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> Allow passing empty upperdir to _overlay_mount_dirs().
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Signed-off-by: Alexander Larsson <alexl@redhat.com>

> ---
>  common/overlay | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/common/overlay b/common/overlay
> index 20cafeb1..452b3b09 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -17,15 +17,19 @@ if [ -n "$OVL_BASE_FSTYP" ];then
>  fi
>
>  # helper function to do the actual overlayfs mount operation
> +# accepts "-" as upperdir for non-upper overlayfs
>  _overlay_mount_dirs()
>  {
>         local lowerdir=3D$1
>         local upperdir=3D$2
>         local workdir=3D$3
>         shift 3
> +       local diropts=3D"-olowerdir=3D$lowerdir"
>
> -       $MOUNT_PROG -t overlay -o lowerdir=3D$lowerdir -o upperdir=3D$upp=
erdir \
> -                   -o workdir=3D$workdir `_common_dev_mount_options $*`
> +       [ -n "$upperdir" ] && [ "$upperdir" !=3D "-" ] && \
> +               diropts+=3D",upperdir=3D$upperdir,workdir=3D$workdir"
> +
> +       $MOUNT_PROG -t overlay $diropts `_common_dev_mount_options $*`
>  }
>
>  # Mount with same options/mnt/dev of scratch mount, but optionally
> --
> 2.40.1
>


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

