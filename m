Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E30C64EC4
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Mar 2023 08:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCHItM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCHItE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2023 03:49:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E898F70D
        for <fstests@vger.kernel.org>; Wed,  8 Mar 2023 00:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678265302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxPjL0e7KLAZbUMplpHRZwa1y4nUzfMOWii1pHpi9W0=;
        b=Bpwljqwlbkr87KIS/sby+yS1v28S6MtGwhetFSOXVdYnFeiAoedmcat8znRVcwPlWi4t7R
        FSD/0ypCE46JfrXQzPuG7VMjmeSWNUdXkgdF7IIUprBaXBxgILpMZ6UnXHmBMb29dKqRnJ
        TD66r8f8BFgZ0EpnYJhNTFZhs/5yJZI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-Q87pwGC2PhWeME1kUIyVow-1; Wed, 08 Mar 2023 03:48:03 -0500
X-MC-Unique: Q87pwGC2PhWeME1kUIyVow-1
Received: by mail-pj1-f69.google.com with SMTP id q61-20020a17090a1b4300b00237d2fb8400so761920pjq.0
        for <fstests@vger.kernel.org>; Wed, 08 Mar 2023 00:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxPjL0e7KLAZbUMplpHRZwa1y4nUzfMOWii1pHpi9W0=;
        b=wJcjFBGPJAzjja0LIM8SunUHvc9+0uxgT/EeLqD72LIhjVbKnlp/KpEKCT7aUPo37r
         diAhpAx8eCMNZQVk3M9HtF7znS4bI7PLs70btS3SX/CPdEMm748XkoYaCKHDJSWXCqJz
         tFrWfRmWl3UC+O9Evw4to3B6LK4ycPRSR2p68nDRaK7C3bKJl5Pt6awg+xvTURVFwxIk
         dGlMTD/6Bg2fnj2E1bZIVTNXXmuHWuHpAkj+TkA99KOeBiieRjyXjUHj1OUi5bVCDtJM
         OB+GEQqdPVdd2ZZusARCRDPy21qPmhrhu1gb69u6ZMqHzYvHthK/Lk3lDrCQE3OzWdm+
         7qlw==
X-Gm-Message-State: AO0yUKX8dBpITIr6H8n377kwbe0Ri2Q48hVxHphSMkjtoQyzW05hULLc
        5RJUeJcs1rs81WYsceZXVJSmsA3VKrcTpi3yA1n4+T0oQtagbMyufx0f53l2DsljkwsyfX1l9n0
        8gtGEGOJVnakS4jujag==
X-Received: by 2002:a17:902:720b:b0:19e:674a:1fb9 with SMTP id ba11-20020a170902720b00b0019e674a1fb9mr15580528plb.69.1678265282118;
        Wed, 08 Mar 2023 00:48:02 -0800 (PST)
X-Google-Smtp-Source: AK7set9r8k57UVkP93htHVyG9lPVk5O7B936UfPTTRn6iKRWuZ3E2fRVRvzJWmw1ximaEOxcEr3dsQ==
X-Received: by 2002:a17:902:720b:b0:19e:674a:1fb9 with SMTP id ba11-20020a170902720b00b0019e674a1fb9mr15580513plb.69.1678265281703;
        Wed, 08 Mar 2023 00:48:01 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b0019c2cf1554csm9519663plc.13.2023.03.08.00.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:48:01 -0800 (PST)
Date:   Wed, 8 Mar 2023 16:47:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/284: list a couple btrfs-progs git commits
Message-ID: <20230308084756.sdeko4gm4x4teuvx@zlang-mailbox>
References: <7be1169e950b807f24e4b2ac33177e44fc13e434.1678189053.git.fdmanana@suse.com>
 <5a542a82-b47b-ced3-97d6-a38b6e926522@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a542a82-b47b-ced3-97d6-a38b6e926522@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 08, 2023 at 04:03:57PM +0800, Anand Jain wrote:
> On 07/03/2023 19:38, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > This test may often fail when running with btrfs-progs versions not very
> > recent. The corresponding git commits in btrfs-progs that fix issues
> > uncovered by this test are:
> > 
> > 1) 6f4a51886b37 ("btrfs-progs: receive: fix silent data loss after fall back from encoded write")
> >     Introduced in btrfs-progs v6.0.2;
> > 
> > 2) e3209f8792f4 ("btrfs-progs: receive: fix a corruption when decompressing zstd extents"")
> >     Introduced in btrfs-progs v6.2.
> > 
> > So add the corresponding _fixed_by_git_commit calls to the test.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/284 | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/tests/btrfs/284 b/tests/btrfs/284
> > index 0d31e5d9..c6692668 100755
> > --- a/tests/btrfs/284
> > +++ b/tests/btrfs/284
> > @@ -20,6 +20,11 @@ _require_test
> >   _require_scratch_size $(($LOAD_FACTOR * 1 * 1024 * 1024))
> >   _require_fssum
> > +_fixed_by_git_commit btrfs-progs e3209f8792f4 \
> > +	"btrfs-progs: receive: fix a corruption when decompressing zstd extents"
> > +_fixed_by_git_commit btrfs-progs 6f4a51886b37 \
> > +	"btrfs-progs: receive: fix silent data loss after fall back from encoded write"
> > +
> >   send_files_dir=$TEST_DIR/btrfs-test-$seq
> >   rm -fr $send_files_dir
> 
> 
> Along with this, why not check the btrfs-progs version using
> 'btrfs --version' and call _not_run()?

Does this case expose some known bugs, right? Or the failures due to some
features missing?

If this case uncovers some known issues, then the failure is expected on unfixed
version. We should let the failure exposing, not hide it by _notrun.

And the package version is not a good way to jundge if a issue is fixed or a
feature is merged. Due to many downstream packages might merge some upstream
patches independently.

Thanks,
Zorro

> 
> Thanks, Anand
> 

