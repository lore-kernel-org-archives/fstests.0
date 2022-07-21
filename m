Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3B5C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 07:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiGUHRw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiGUHRw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 03:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49D207B343
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658387870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VP1CmL79b4soHYwxXvqELhi4lhwEC5Fp2mINqOfpPLg=;
        b=JNF3z2d5H00R/M/ZvsI6OxNLjyT+Rk4WDXlFWWyN0MulAPSE3q5TS6md++VINsEh9pmCRo
        TQ/0k9VX7TiNagwVEZAMqWSQXsTYKp6ZE8T1FmOCAxogOWMS3I1bpHu4EJ0aYh1L15lwJU
        tA+ybyEZS1f+EkcRuq4mGYkAQkJJB6Q=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-pgpgZKX-PyGVWb-lgj3cKA-1; Thu, 21 Jul 2022 03:17:47 -0400
X-MC-Unique: pgpgZKX-PyGVWb-lgj3cKA-1
Received: by mail-pl1-f199.google.com with SMTP id o7-20020a170902d4c700b0016d2f7f9a6bso714042plg.13
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 00:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VP1CmL79b4soHYwxXvqELhi4lhwEC5Fp2mINqOfpPLg=;
        b=XvBIAUg711G/6LF8eTKNp61eSeqadTu6r7xN01mrbcAt6PAwf23xFT6gEJgxSGC4+7
         dgy9zhgpml8swFHx/Kc+m98YpTzSKnodtkFxz8wJBGiBAtt5TfryZM1b79GAv7ksHxEz
         wzCU7EGMKk6YdIeJAEGaV2bMqG8IWJpzL08v6tz7eyrOF5AfIgoY04ZAwP4u3/OG17Rs
         ZEv9FdctwROFjPajcuFExehaNDcLhCU4RIHJ4ZIAKmDJIVREXHCCu/xsDN6jdkKoNKaN
         9lPN2TYAw/AVuyyQzqXuob320aeyiteZwfApGcRwAiooxLViiBw9tBkzMvmAEB7KJeJP
         4KqQ==
X-Gm-Message-State: AJIora/noPAAvpb6kWbXhBjbRbRxFi7+BCf02p004jWgQzBaOoTlwB59
        KLDZK9ICD166XTIc+sz8f78HJS2BMWOLFuoUeL6kYLk6yIBWk9SW0nMXNYfpguPq1yON2kjo2fH
        wbPNM13ijVLf6zFAjkr+6lwK3FBX3NlSQtg==
X-Received: by 2002:a17:90a:d983:b0:1f2:2d63:be98 with SMTP id d3-20020a17090ad98300b001f22d63be98mr2493287pjv.219.1658387866050;
        Thu, 21 Jul 2022 00:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v8AzTBenfjyviRSnqHYfMvIdqMeVxDPAGgdh0tgi2Np0Zmc4s09EMjd1j78pT9zYyI4RCwpTU5ComN9VTf3BY=
X-Received: by 2002:a17:90a:d983:b0:1f2:2d63:be98 with SMTP id
 d3-20020a17090ad98300b001f22d63be98mr2493271pjv.219.1658387865781; Thu, 21
 Jul 2022 00:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220721022959.4189726-1-bxue@redhat.com> <bfa31081-2bd8-59df-6645-a5f707159f4e@fujitsu.com>
In-Reply-To: <bfa31081-2bd8-59df-6645-a5f707159f4e@fujitsu.com>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 21 Jul 2022 15:17:34 +0800
Message-ID: <CAHLe9YauKP2_EtnKrn8_WkM+JpwcqdxtAUcMP83-x1s1VZZ4JQ@mail.gmail.com>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 10:50 AM xuyang2018.jy@fujitsu.com
<xuyang2018.jy@fujitsu.com> wrote:
>
> on 2022/07/21 10:29, bxue@redhat.com wrote:
> > From: Boyang Xue <bxue@redhat.com>
> >
> > The test requires larger scratch dev size when running on top of NFS other
> > than ext4 and xfs. It requires at least 27GB in my test. Without this
> > requirement, the test run never finishes on NFS, leaving 100% scratch disk
> > space use.
> >
> > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > ---
> > Hi,
> >
> > I find generic/476 easily goes into an infinite run on top of NFS. When it
> > happens, the common pattern is 100% disk space use of SCRATCH_MNT, and
> > `nfsiostat` shows 50% write error on SCRATCH_MNT. When I run it with a large
> > enough SCRATCH_MNT, the problem disappears. So I post this patch to add the size
> > requirement.
> >
> > Please help review this patch. Thanks!
> >
> > -Boyang
> >
> >   tests/generic/476 | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/generic/476 b/tests/generic/476
> > index 212373d1..dcc7c3da 100755
> > --- a/tests/generic/476
> > +++ b/tests/generic/476
> > @@ -24,6 +24,7 @@ _cleanup()
> >   _supported_fs generic
> >
> >   _require_scratch
> > +_require_scratch_size $((27 * 1024 * 1024)) # 27GB
>
> If NFS needs this requirement, why do you require all filesystem meet this?

I can fix this by requiring the 27GB only when the target is NFS in
the next version of the patch.

>
> It will break test when using local filesystem ie xfs,ext4(as README
> says the minimum requiremount is 10G). I often use 20G as test device
> and scratch device.
>
> Also, I think you should figure out why NFS 100% use space. Use a large
> device size only hides a bug.

I think the test use 100% space just because the scratch device in
test is too small for the full operations of the test, and I guess the
test requires a so large device for NFS from day1 of the test.

Thanks,
Boyang

>
> Best Regards
> Yang Xu
> >   _require_command "$KILLALL_PROG" "killall"
> >
> >   echo "Silence is golden."

