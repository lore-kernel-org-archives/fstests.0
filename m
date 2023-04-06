Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9ECC76196
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Apr 2023 05:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjDFFDX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Apr 2023 01:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjDFFDV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Apr 2023 01:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD5593F1
        for <fstests@vger.kernel.org>; Wed,  5 Apr 2023 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680757355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PqCIoTjskUFCsaWO0NwsbyWLuR/Gu7pPO1hvXt7JTC0=;
        b=jJVV8vo968GexvTYXj4fS3CD7czI5L4cpkwt17Fsg43jfVXv2q6MSv4HHaniHNvrIGpBQb
        8cfjAvIyozEnZNodyiAQFDZO4c3sZpGr7Tz4QHBoQ4B5irW59AgwypeGgc1Nyo0zEK1Uaa
        kniV1RuG/YOW4k9AG5EeFK3r5/J/y9o=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-KCO7102dPr-v7CyDtC7XXg-1; Thu, 06 Apr 2023 01:02:34 -0400
X-MC-Unique: KCO7102dPr-v7CyDtC7XXg-1
Received: by mail-pl1-f197.google.com with SMTP id s4-20020a170902ea0400b001a1f4137086so22181218plg.14
        for <fstests@vger.kernel.org>; Wed, 05 Apr 2023 22:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680757353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqCIoTjskUFCsaWO0NwsbyWLuR/Gu7pPO1hvXt7JTC0=;
        b=7ZWGBtPY1OvN8/yBelpDLyzZnC9vMFK0tWtf1DoE1XoikIzutMREzMT7ntKLMgDs5C
         mz3U67zvx1Q4MQtuZdOs5iQnJJBiLkoRiZ2STIHDesFwEBDR+7E2F7XilV4xycyuDV1r
         3OyxV7hRSmmVIKRLvOtfR+V2nnt1uXHca7CuUIutwkOwi2Dd2JmW54hK7PLNpr93SceN
         jZGRlg+ycSBxRpPKtRgAPkTSArfllEUHyCpBV/wBC9CBtFAd9XQhrG6s0kJ19fn/d7Ka
         1mwEY6I+QOZyhYMHaYHwa+AZ/UEnZSMnvNyD+efa8y9GqWGeJQjCYyObylpabRWWh9Of
         EXqw==
X-Gm-Message-State: AAQBX9cJa9J3B5mKp88PrkZE1AixCw4w1LEpfjmcvF3dW6PyNZQ7BRRQ
        k1CAK9/2SoC4MMYjGT30tiytLlnnUOgMB1sKwGDLT9CYSd57KIp0kEPowU3tlE8h2j4TB+a5rCV
        qzKB88K+DthszqPNmpspPh9l5iVmR
X-Received: by 2002:a17:90b:4c0a:b0:23f:1210:cea4 with SMTP id na10-20020a17090b4c0a00b0023f1210cea4mr9703899pjb.18.1680757353255;
        Wed, 05 Apr 2023 22:02:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zf19cjvyIcJ4uQD1BsrXEt+GMHe0xQGp8F3SkTT4F4OA14phVoFQMkrcnZoSqp3f92WI+dZQ==
X-Received: by 2002:a17:90b:4c0a:b0:23f:1210:cea4 with SMTP id na10-20020a17090b4c0a00b0023f1210cea4mr9703872pjb.18.1680757352886;
        Wed, 05 Apr 2023 22:02:32 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n32-20020a17090a2ca300b00227223c58ecsm258992pjd.42.2023.04.05.22.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 22:02:32 -0700 (PDT)
Date:   Thu, 6 Apr 2023 13:02:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] fstests/MAINTAINERS: add some specific reviewers
Message-ID: <20230406050228.5ujhuamrqqdjqu77@zlang-mailbox>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-5-zlang@kernel.org>
 <20230405-idolisieren-sperren-3c7042b9ed1f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-idolisieren-sperren-3c7042b9ed1f@brauner>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 05, 2023 at 09:47:55AM +0200, Christian Brauner wrote:
> On Wed, Apr 05, 2023 at 01:14:10AM +0800, Zorro Lang wrote:
> > Some people contribute to someone specific fs testing mostly, record
> > some of them as Reviewer.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > If someone doesn't want to be in cc list of related fstests patch, please
> > reply this email, I'll remove that reviewer line.
> > 
> > Or if someone else (who contribute to fstests very much) would like to a
> > specific reviewer, nominate yourself to get a review.
> > 
> > Thanks,
> > Zorro
> > 
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 620368cb..0ad12a38 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -108,6 +108,7 @@ Maintainers List
> >  	  or reviewer or co-maintainer can be in cc list.
> >  
> >  BTRFS
> > +R:	Filipe Manana <fdmanana@suse.com>
> >  L:	linux-btrfs@vger.kernel.org
> >  S:	Supported
> >  F:	tests/btrfs/
> > @@ -137,16 +138,19 @@ F:	tests/f2fs/
> >  F:	common/f2fs
> >  
> >  FSVERITY
> > +R:	Eric Biggers <ebiggers@google.com>
> >  L:	fsverity@lists.linux.dev
> >  S:	Supported
> >  F:	common/verity
> >  
> >  FSCRYPT
> > +R:	Eric Biggers <ebiggers@google.com>
> >  L:      linux-fscrypt@vger.kernel.org
> >  S:	Supported
> >  F:	common/encrypt
> >  
> >  FS-IDMAPPED
> 
> I'd just make this VFS since src/vfs/ covers generic vfs functionality.
> 
> But up to you,

Sure, it can be "VFS". I didn't use "VFS" directly due to vfs is larger, current
src/vfs only tests a small part of it, more tests are under tests/generic directory.
And we don't have many vfs tests, e.g. we don't test new mount API in fstests.

We need a way to sort out "VFS" only files/tests (e.g. group tag), and if we use
"VFS" at here, would you like to be a reviewer of all vfs tests?

Thanks,
Zorro

> 
> Acked-by: Christian Brauner <brauner@kernel.org>
> 
> > +R:	Christian Brauner <brauner@kernel.org>
> >  L:	linux-fsdevel@vger.kernel.org
> >  S:	Supported
> >  F:	src/vfs/
> > @@ -163,6 +167,7 @@ S:	Supported
> >  F:	tests/ocfs2/
> >  
> >  OVERLAYFS
> > +R:	Amir Goldstein <amir73il@gmail.com>
> >  L:	linux-unionfs@vger.kernel.org
> >  S:	Supported
> >  F:	tests/overlay
> > @@ -174,6 +179,7 @@ S:	Supported
> >  F:	tests/udf/
> >  
> >  XFS
> > +R:	Darrick J. Wong <djwong@kernel.org>
> >  L:	linux-xfs@vger.kernel.org
> >  S:	Supported
> >  F:	common/dump
> > -- 
> > 2.39.2
> > 
> 

