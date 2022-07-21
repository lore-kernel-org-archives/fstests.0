Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E8C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 07:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiGUH0Y (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGUH0Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 03:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 120BC2A971
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 00:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658388382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=19hUXZ4uj5OgReO1j5ZEVKMXNfAo3zzzWrbQaR+Anx4=;
        b=HvbIARqlJB8XjQkPp2AuOZyRiJrxpH746P+zgq5PAP6X5AtIWF0U34v8B6mXV/Qyex3Dqk
        FnTI20VhTw7ma3NCDw1/rrsgpRLvISrP8g6w0FlR4qDEopFGDs0960bnAlPvnCu535FYLL
        GF58VKpmKbhQBLdr1AyEUU+I8OzPJzM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-XiS-6fo-Mf24SF2eam64IQ-1; Thu, 21 Jul 2022 03:26:18 -0400
X-MC-Unique: XiS-6fo-Mf24SF2eam64IQ-1
Received: by mail-pf1-f198.google.com with SMTP id c21-20020a624e15000000b0052abf43401fso494031pfb.14
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 00:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19hUXZ4uj5OgReO1j5ZEVKMXNfAo3zzzWrbQaR+Anx4=;
        b=or4lNdXYWo+rskCBUvD73DDeOUys2cHwIreUrkXahRWa31PHkZQufoEwog1uuNLTB3
         j8Ao3vJr5y7LqVAr+m3DuWj9NWH6TiS1BYPE5lMSiQHgrnssrPfEFSHEa5b8eRKqRkKx
         s3RT2reJUb5ajnYHaKnEeoXWteXzfd7KZTmQlZuk1U7aDW17Ww5dhAJx9GRo48WszcSi
         6MF40NDSNqkFnOCyruTKGrkESCuy9Vwm/zAIDFrEe0hS7QwQcMFZ2gnVLQfVBzOUBzvU
         Q3nHwRxfgX/drMwmGWfd3HWkpxBykh0OGUFIDbPgDgYrfCxeS3GoimCjBOjOyWcEiCJZ
         yNLA==
X-Gm-Message-State: AJIora+nhoDTccDTM700jsrhxHWCeCB7sGHgM/2itEM+9ybOrLIIO3xU
        B4jV5aRpSYly/gDUvFgKPERGPGEJLXHN8Z1wuRh0LGcDvttfL9/a+zsG/07hiYUKnXkTsRhjxvr
        S9SsF1XIHIPdI+ujwcH5cIXyUUPL0hQW4GQ==
X-Received: by 2002:a17:902:9b84:b0:16d:b40:7cdb with SMTP id y4-20020a1709029b8400b0016d0b407cdbmr12426698plp.59.1658388376930;
        Thu, 21 Jul 2022 00:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uX5DCxur2outXv2rjRYDJW47lvffUp7qKx2LTRWJXG5JQ6/7iSA78tK563TqS7nnUAJkILmB+crIiJIS5hveo=
X-Received: by 2002:a17:902:9b84:b0:16d:b40:7cdb with SMTP id
 y4-20020a1709029b8400b0016d0b407cdbmr12426683plp.59.1658388376630; Thu, 21
 Jul 2022 00:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220721022959.4189726-1-bxue@redhat.com> <YtjYxyhVmSPzzFoH@magnolia>
In-Reply-To: <YtjYxyhVmSPzzFoH@magnolia>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 21 Jul 2022 15:26:05 +0800
Message-ID: <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 12:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 10:29:59AM +0800, bxue@redhat.com wrote:
> > From: Boyang Xue <bxue@redhat.com>
> >
> > The test requires larger scratch dev size when running on top of NFS other
> > than ext4 and xfs. It requires at least 27GB in my test. Without this
> > requirement, the test run never finishes on NFS, leaving 100% scratch disk
> > space use.
>
> > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > ---
> > Hi,
> >
> > I find generic/476 easily goes into an infinite run on top of NFS. When it
>
> Infinite?  It's only supposed to start 25000*nr_cpus*TIME_FACTOR
> operations, so it /should/ conclude eventually.  That includes driving
> the filesystem completel out of space, but there ought to be enough
> unlink/rmdir/truncate calls to free up space every now and then...

Yes. I'm not sure the calculations inside, but when the size of the
scratch device < 27GB (can be 26GB when the backing storage is ext4
rather than xfs), the test runs infinitely. I'm aware that the test
should be slow, especially on NFS, but I see the test never finishes
after multi-days. This problem happens in both localhost exported NFS
and remote exported NFS configurations.

>
> > happens, the common pattern is 100% disk space use of SCRATCH_MNT, and
> > `nfsiostat` shows 50% write error on SCRATCH_MNT. When I run it with a large
> > enough SCRATCH_MNT, the problem disappears. So I post this patch to add the size
> > requirement.
> >
> > Please help review this patch. Thanks!
> >
> > -Boyang
> >
> >  tests/generic/476 | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/generic/476 b/tests/generic/476
> > index 212373d1..dcc7c3da 100755
> > --- a/tests/generic/476
> > +++ b/tests/generic/476
> > @@ -24,6 +24,7 @@ _cleanup()
> >  _supported_fs generic
> >
> >  _require_scratch
> > +_require_scratch_size $((27 * 1024 * 1024)) # 27GB
>
> ...so IDGI, this test works as intended.  Are you saying that NFS
> command overhead is so high that this test takes too long?
>
> --D
>
> >  _require_command "$KILLALL_PROG" "killall"
> >
> >  echo "Silence is golden."
> > --
> > 2.27.0
> >
>

