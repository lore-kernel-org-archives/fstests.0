Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D90C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 16:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiCQQdL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbiCQQdK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 12:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92DB5216A48
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647534712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CakZBq0bUnsQ2+1MdHu4Pwk4y6WgfLQKs7fgMBbunzM=;
        b=VofkvcBDP43Gc9M1TOb7E5O9mGVInM7r2yruxbzAntCxVgGiufJudjGJr8fnyHTO+hAUcs
        13JBrBzn6Z+qwfpoLVRFRQnEy2LaIRhFaGnb06QnmAPMSpN5pl7tShAMFyrcbas7EJPi0w
        0+eU0EvsBVJ5iPyNyEPDhxwwI9Wij+I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-03i2PuN6PSWsvm1EkN4glA-1; Thu, 17 Mar 2022 12:31:51 -0400
X-MC-Unique: 03i2PuN6PSWsvm1EkN4glA-1
Received: by mail-pj1-f71.google.com with SMTP id om8-20020a17090b3a8800b001c68e7ccd5fso1050065pjb.9
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 09:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CakZBq0bUnsQ2+1MdHu4Pwk4y6WgfLQKs7fgMBbunzM=;
        b=rITOHj6zi3B2aB1TTQHzvSWSUFUD+V/87xoJ5NO/1sUdbrRhVtTX5ErxIqz0wAbjlS
         kcUdnX9inCH1R3dUIM3CuP6DNyhxTDWM8XPE2qeKFMos/KrW+UHwVkyrnNDwAbE0U91Z
         h+zmHJDvbrpS9YS9yKvkwFWPgVUtdl4XJ4e/tXv7eYdW4ljEdayU7GN5AcgavHdQ3U/m
         ga4c/k6/56bqr3RMzFs2geCwmlucJdL94ObFZpwzwB80Upjyf/GnhkdTYZilQVFGuxB9
         23ljpOipSmVopfcNScxyxzcaKElJ9/d/ffk2FdFXsa66PcXSbF6aXfM2VKMl7llO80R2
         egwg==
X-Gm-Message-State: AOAM530pbc9tcBH/dzsVoMgvEVpUFiLxSE4CYystHR94bpAWseaO+SiF
        OI0naUs3AYGyIy5PGqJUKpojpceNnzHbv/fjnjchT+QAdNyqRThDCCFWjJoJKSkGSkjk6cCINRv
        bls2toncLGz6Xh8WQc0XhozX36GZ1WAbJxg==
X-Received: by 2002:a05:6a00:781:b0:4f4:2a:2d89 with SMTP id g1-20020a056a00078100b004f4002a2d89mr5292310pfu.13.1647534709437;
        Thu, 17 Mar 2022 09:31:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTKsafp0FtVN/dNsZm65ThTeuDWkvXitOciQzFXB4OakAbNTWCGvH+f/oPUvPeTmJqxclUTIj9zEKXGFhc/ck=
X-Received: by 2002:a05:6a00:781:b0:4f4:2a:2d89 with SMTP id
 g1-20020a056a00078100b004f4002a2d89mr5292284pfu.13.1647534709145; Thu, 17 Mar
 2022 09:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220317100842.1237893-1-bxue@redhat.com> <20220317100842.1237893-3-bxue@redhat.com>
 <20220317153038.GH8200@magnolia>
In-Reply-To: <20220317153038.GH8200@magnolia>
From:   Boyang Xue <bxue@redhat.com>
Date:   Fri, 18 Mar 2022 00:31:38 +0800
Message-ID: <CAHLe9YZQjukAP80yP_qHFF_6bDBVOd+CBbPAqUjYz9CTSsrDXg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] generic/513,675: check for security namespace support
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

(Resend due to previous email being rejected. Sorry)

Hi Darrick,

I find the problem when I run xfstests generic/513,675 on nfs

```
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 kvm103 5.14.0-71.el9.x86_64 #1 SMP
PREEMPT Tue Mar 8 17:49:53 EST 2022
MKFS_OPTIONS  -- localhost:/scratch_TMP
MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:root_t:s0
localhost:/scratch_TMP /scratch

generic/513     - output mismatch (see
/root/repo_xfstests/results//generic/513.out.bad)
    --- tests/generic/513.out   2022-03-09 05:26:45.450331405 -0500
    +++ /root/repo_xfstests/results//generic/513.out.bad
2022-03-17 09:34:17.190818281 -0400
    @@ -1,2 +1,18 @@
     QA output created by 513
    +Failed to set capabilities on file '/scratch/bar' (Operation not supported)
```

So nfs doesn't support capabilities, I think we should run a check and
not run the test on filesystems like nfs that don't support it.
I find the file capabilities are implemented by using "security
attribute namespace", and running "_require_attrs security" can do the
check.
After applying this patch, running generic/513, 675 on nfs will be like

```
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 kvm103 5.14.0-71.el9.x86_64 #1 SMP
PREEMPT Tue Mar 8 17:49:53 EST 2022
MKFS_OPTIONS  -- localhost:/scratch_TMP
MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:root_t:s0
localhost:/scratch_TMP /scratch

generic/513     [not run] attr namespace security not supported by
this filesystem type: nfs
generic/675     [not run] attr namespace security not supported by
this filesystem type: nfs
Ran: generic/513 generic/675
Not run: generic/513 generic/675
Passed all 2 tests
```

Thanks,
Boyang


On Thu, Mar 17, 2022 at 11:30 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Mar 17, 2022 at 06:08:42PM +0800, bxue@redhat.com wrote:
> > From: Boyang Xue <bxue@redhat.com>
> >
>
> Er... what does this patch do, and why?
>
> --D
>
> > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > ---
> >  tests/generic/513 | 2 ++
> >  tests/generic/675 | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/tests/generic/513 b/tests/generic/513
> > index dc082787..6e897fa0 100755
> > --- a/tests/generic/513
> > +++ b/tests/generic/513
> > @@ -12,10 +12,12 @@ _begin_fstest auto quick clone
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/reflink
> > +. ./common/attr
> >
> >  # real QA test starts here
> >  _supported_fs generic
> >  _require_scratch_reflink
> > +_require_attrs security
> >  _require_command "$GETCAP_PROG" getcap
> >  _require_command "$SETCAP_PROG" setcap
> >
> > diff --git a/tests/generic/675 b/tests/generic/675
> > index 23b7e545..311860dc 100755
> > --- a/tests/generic/675
> > +++ b/tests/generic/675
> > @@ -12,12 +12,14 @@ _begin_fstest auto clone quick
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/reflink
> > +. ./common/attr
> >
> >  # real QA test starts here
> >
> >  # Modify as appropriate.
> >  _supported_fs generic
> >  _require_user
> > +_require_attrs security
> >  _require_command "$GETCAP_PROG" getcap
> >  _require_command "$SETCAP_PROG" setcap
> >  _require_scratch_reflink
> > --
> > 2.27.0
> >
>

