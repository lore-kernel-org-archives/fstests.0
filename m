Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB684C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Apr 2022 10:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiDYKpc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Apr 2022 06:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDYKpb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Apr 2022 06:45:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C203BA79
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 03:42:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id e128so10415644qkd.7
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rBh59sS0fwKvwTRKx/eR+uDVVI5xzqQlxyhsLHc1opc=;
        b=eioHq/PN9w3omTaGTqtwLIcE2ofN064TVSO4XxK2ABht0ENQk3rFXKfL6iY/h19J+M
         AbgdVNwoNk0Rkm2+8iR36sgGIwHGE0F+eQXtggspKi+uC3ES9zS99gOTBUHm3lGGqJHV
         CarwKHIsdwfd//IEVs+vNJfaP4o+yaW5WNSxM3ObEmh5BXtZSvFbCAQzX/hk+puzWtNi
         WxI1HVD4zPE5xV7dHD+fdWQUAfimpY+oizXLkgSp8xIlbrHd7WYSDfgAn0LMRN3b8JSy
         kGfe+zdtVEJ2fWZDjjTHoltbXGtnCW284V9jG+Bl5mAtdJywvLAEmPdWN+9qW+7u/bkT
         bHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rBh59sS0fwKvwTRKx/eR+uDVVI5xzqQlxyhsLHc1opc=;
        b=8En9SyM6jfhM8kXkVHE45uw1IR+zSmfHOWaN3506d+nzbCZaU20Pre6jjKrvoHjJ/w
         RXCn8wTpcn65LFMFG5Yu1w2WcKIAcZkarc4xkbpqxrIBUNeg0dPGfv5D7oqgRxaQF1+u
         g2N3zim09ka4zHw/3PIMGMOminv2R7V4IV071RVCd1RsyCYa2e9UJQ5pDOjKohST2pUo
         E6tvU/4t7mD1B3AmV/qIwdYnNkwzepqGaPhwS6WyqHIqnG2S6hT0ssYQSK3uJBxCBpjY
         wCzY6DTRd6BBawRwu02DlZpM7FdbmQa5XyI1Teq3pExam3zzfeAkKzDIvjW8LNgRPCEz
         zSRA==
X-Gm-Message-State: AOAM53288CPgbaZNahTlgVVisL0LQoV6RfDYHztwAUh4pMf6DUIG7UPS
        MSoC7lVO+I+A1nc2BbkUdsh9j9Rjs5BO2GdW5A0=
X-Google-Smtp-Source: ABdhPJwyBkJv3wIv4hekWvMos2lJq6QTCm+Ub/xBOSyoK4cey6LVeAjgNwPF2bCzB1EI2ICxAyZlDc0Z18rc5mPYzFw=
X-Received: by 2002:a05:620a:1aa9:b0:69e:e20e:7961 with SMTP id
 bl41-20020a05620a1aa900b0069ee20e7961mr9545059qkb.19.1650883346628; Mon, 25
 Apr 2022 03:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220424063751.1067376-1-libaokun1@huawei.com>
 <CAOQ4uxgEXEgZ-uAYgiJi1sxX9Zzmg25NewBRiRQR6D8z+qOXHA@mail.gmail.com> <eccdacb7-ae04-23fe-4657-528d1c22f801@huawei.com>
In-Reply-To: <eccdacb7-ae04-23fe-4657-528d1c22f801@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Apr 2022 13:42:15 +0300
Message-ID: <CAOQ4uxhxE0aMyZfHiedqRQ9mvoOdmGXq9NywY_NdUb1MLuosFg@mail.gmail.com>
Subject: Re: [RFC] common: overlay support tmpfs
To:     "libaokun (A)" <libaokun1@huawei.com>
Cc:     Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>,
        fstests <fstests@vger.kernel.org>, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 25, 2022 at 12:31 PM libaokun (A) <libaokun1@huawei.com> wrote:
>
> =E5=9C=A8 2022/4/24 20:02, Amir Goldstein =E5=86=99=E9=81=93:
>
> On Sun, Apr 24, 2022 at 2:21 PM Baokun Li <libaokun1@huawei.com> wrote:
>
> xfstests support overlay+tmpfs
>
> Thanks for this improvement.
> Can you please share the results of ./check -overlay -g auto ?
>
> How many tests ran? notran? failed?
>
> Best if you have those numbers compared to
> overlay+(already supported base fs)
>
> All right, I'll share it after the adaptation is completed.
>
> ```local.config.example
> export FSTYP=3Dtmpfs
> export TEST_DEV=3Dtmpfs_test
> export TEST_DIR=3D/tmp/test
> export TEST_FS_MOUNT_OPTS=3D"-t tmpfs"
> export SCRATCH_DEV=3Dtmpfs_scratch
> export SCRATCH_MNT=3D/tmp/scratch
> export MOUNT_OPTIONS=3D"-t tmpfs"
>
> These mount options for tmpfs are very awkward.
> Please fix _overlay_base_mount to use -t $OVL_BASE_FSTYP
> like _test_mount() and _try_scratch_mount() do
>
> Could you be more specific?

--- a/common/overlay
+++ b/common/overlay
@@ -81,7 +81,7 @@ _overlay_base_mount()
                return 1
        fi

-       _mount $* $dev $mnt
+       _mount -t $OVL_BASE_FSTYP $* $dev $mnt
        _idmapped_mount $dev $mnt
 }


Untested.

Thanks,
Amir.
