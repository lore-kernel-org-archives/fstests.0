Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1103EE14D7
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Sep 2023 04:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjIHEC6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Sep 2023 00:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjIHEC5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Sep 2023 00:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105A1BF0
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 21:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694145729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYvC4IUdgJ+gELBNmwoGvFIDDsROFybKkIWYtzQ1LQo=;
        b=iklB/VhAaJS2wCnnZ4vTu/1klXhUxx0FkTOG+fWrf6jgiiZY7C9xfIKeCgM0PozUSaa0pm
        07hDFJxkl5V2z4sxk+RYAPxlQ1hIoZOUPptVg0SkcjLO2E2GXxXuaUKERq9jBFPY/TcKvh
        pzrrHL3IDiJUZL+Akcn6PL9NljQvmRc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-lEywoqOMMJ6nIXomgtxfFg-1; Fri, 08 Sep 2023 00:02:07 -0400
X-MC-Unique: lEywoqOMMJ6nIXomgtxfFg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68bec4f6a64so2095017b3a.2
        for <fstests@vger.kernel.org>; Thu, 07 Sep 2023 21:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694145726; x=1694750526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYvC4IUdgJ+gELBNmwoGvFIDDsROFybKkIWYtzQ1LQo=;
        b=jl+Xvd6OhnUnIY+9M3LbG4UIvmYEfrVmF+FevvHsxQalu/rPBwUlnbTBUjGwUltWqW
         19hgPQxrUkGmf/Of86lviz/jbvObTeprsO9SRRC8zd27tZjy/Ta5Ykaky4CDK68GfEiF
         XICLfPo09tCkuXJiQlOLmSUZOniHG0FwMiCULOWvugABRMzKw8CQpy2tb2Tq7MS2N+Oh
         zXvSleD5jvNn9qlaaARnDxCw8B9M5P1lRt7kwc82bVFuXAKQmFw/Wx2HbgIeiPYvHOXy
         wiQxK6gITvzH47anw9jUJ0ALzB9tYVn6hiUZnVOQU9l0XfjskiWGHfMfyz2e9KPJKPby
         trlQ==
X-Gm-Message-State: AOJu0Yywn5ZwZlIXweNY1j0wLZZcWYjb4GxmkEoiK1mxbwTeOK2jmdDI
        rjqaRtwiUKRJoxrHheJE51YRG0eOFu8KGc2b85m9kITRfrN8X5rLfIaWaWcoRVltaeZTo/VuISz
        V/2zISlg44yiUfSIh1XhnK2UBVL627iHOpaq5TGpbhbQHTpZ1VSXygZfVGc7VzfPnbaunrEyuRW
        Gu
X-Received: by 2002:a05:6a00:b95:b0:68e:3a59:b9d5 with SMTP id g21-20020a056a000b9500b0068e3a59b9d5mr1504332pfj.16.1694145726184;
        Thu, 07 Sep 2023 21:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx5d/NGNsY9EEB4lAEv9eATsVL7kxZu+zcm1936KmtFMtgsdt0DmC12ISdpn5WzRWB5vdB1g==
X-Received: by 2002:a05:6a00:b95:b0:68e:3a59:b9d5 with SMTP id g21-20020a056a000b9500b0068e3a59b9d5mr1504305pfj.16.1694145725656;
        Thu, 07 Sep 2023 21:02:05 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b00686bef8e55csm430672pfo.39.2023.09.07.21.02.04
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 21:02:05 -0700 (PDT)
Date:   Fri, 8 Sep 2023 12:02:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] tools/mvtest: ensure testcase is executable (755)
Message-ID: <20230908040202.mmtvskdcdd54coxe@zlang-mailbox>
References: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
 <20230907135434.kj44w7mg6qvpzs4m@zlang-mailbox>
 <7365bd90-6aaf-46d7-b09e-61ea1ad9ddb5@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7365bd90-6aaf-46d7-b09e-61ea1ad9ddb5@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 08, 2023 at 10:13:01AM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2023/9/7 21:54, Zorro Lang 写道:
> > On Wed, Sep 06, 2023 at 03:13:49PM +0800, Shiyang Ruan wrote:
> > > Some test cases lack executable permission ('x'). Before running each
> > > test case, `./check` checks and grants them 'x' permission. However,
> > > this always leads to a dirty git repo. And the absence of 'x' permission
> > > in test cases is often overlooked during reviews.
> > > 
> > > Since maintainers use mvtest to assign new case, add this change for
> > > convenience of maintainers.
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >   tools/mvtest | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/mvtest b/tools/mvtest
> > > index 99b154142..e839f0256 100755
> > > --- a/tools/mvtest
> > > +++ b/tools/mvtest
> > > @@ -28,6 +28,8 @@ append() {
> > >   test "${src}" != "${dest}" || die "Test \"${src}\" is the same as dest."
> > >   test -e "tests/${src}" || die "Test \"${src}\" does not exist."
> > >   test ! -e "tests/${dest}" || die "Test \"${src}\" already exists."
> > > +# make sure testcase is executable
> > > +test `stat -c '%a' tests/${src}` == 755 || chmod 755 "tests/${src}"
> > 
> > (Weird, I thought I've replied this patch, but I can't find my reply anywhere.)
> > 
> > I said we can check and set the permission on the ${dest} file, after the
> > move operation is done. Due to we actually want to get a 755 ${dest} file
> > by running the mvtest.
> 
> It seems that maillist server was down at that time.  But I received your
> reply:

Recently I missed some emails/patches, I don't know if it was a problem of
fstests@ or redhat mail service. If I didn't reply a patch for long time,
please feel free to ping me or the ping fstests list.

Thanks,
Zorro

> 
> > I think we can check and set the file permission on the target file
> > after the move operation done, not the source file.
> >
> > And we recommend using $() to replace ``, if both of them work.
> 
> Then I have sent v2[1] which is using $() instead of `` and doing the
> check-then-set tests/${dest} after `git mv`, as you suggested.
> 
> [1] https://lore.kernel.org/fstests/20230907113501.4119112-1-ruansy.fnst@fujitsu.com/
> 
> 
> --
> Thanks,
> Ruan.
> 
> > 
> > Thanks,
> > Zorro
> > 
> > >   sid="$(basename "${src}")"
> > >   did="$(basename "${dest}")"
> > > -- 
> > > 2.42.0
> > > 
> > 
> 

