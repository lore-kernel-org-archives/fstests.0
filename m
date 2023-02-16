Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF87C61DA4
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Feb 2023 05:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBPFmC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Feb 2023 00:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBPFmB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Feb 2023 00:42:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2CC8684
        for <fstests@vger.kernel.org>; Wed, 15 Feb 2023 21:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676526075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/DBe2aX58AifIlzI2nlCz/gYDRcDpo3SIpSSuocnmgw=;
        b=dOVNtrhStPPxM7S1e3CbIvIlGp1ZnxBp1qFt1JMenPH+MtxDIaKBaPb9IyPtolkYDEV0fi
        XxBXnywCt7tJ8Fa75VsX475WtX3IFbXjIi8/33912NjaykbmDVDaThgOzShyozcgDVu1s1
        20SmejdWD664jKDSPo37Yk3dt44094k=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-223-EhN3xPg-P0WJkJIeB2UJ-w-1; Thu, 16 Feb 2023 00:41:13 -0500
X-MC-Unique: EhN3xPg-P0WJkJIeB2UJ-w-1
Received: by mail-pf1-f198.google.com with SMTP id t13-20020a62d14d000000b005a89856900eso665071pfl.14
        for <fstests@vger.kernel.org>; Wed, 15 Feb 2023 21:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DBe2aX58AifIlzI2nlCz/gYDRcDpo3SIpSSuocnmgw=;
        b=fJ/nYfI41K9+yII6YiNYz/+CjiRuINqE1UKQbsHzKwGaZIG/lePWuCqGvJEUhbNnIx
         P85SH0G0Q5+7RPIzBlQGw3x1XyXq0gGkZNBawq/aFA9WhV131rbStPV4NkofATY41Ack
         lFNMe+uReLvdELldLgW3ue5nY7EqVEHJ31NuJPYvkidYeZ67ddqXgsF5mI9XLH1bSpLc
         c5nmQxoehCEqsHponi+BhimN0COJCnmE+ByIU+pLqU/yKcMorQMWsygonUdjPYdOh325
         u90uI+RVN6TMrUnX2qiajYGAjV3QbPf1vd7tQjrAjCRyMPbKl8CYiEIU34ZEUng5pCsM
         u2ww==
X-Gm-Message-State: AO0yUKV3WtvvQsJeB6utotMpoXpUE/aDLwZIkF08OLYUUFoNlBzQoN5v
        GH1r/n9wrI6JktP4YK90o1itFnQlA48OttexgdiaZtQxG3fi0wFCBTEQZMAcOZZImuzxDovlGTJ
        KdK01r+EMD/QaT38lq9neppLYmg==
X-Received: by 2002:a05:6a20:7d8b:b0:bf:58f4:beaf with SMTP id v11-20020a056a207d8b00b000bf58f4beafmr1327106pzj.7.1676526072215;
        Wed, 15 Feb 2023 21:41:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+hfp7jVySbB8aBHuLCq9S9fU5OwtUsF2LRw04TWfEUr1wTuKfAda/790ly2/h79haE1NQlmQ==
X-Received: by 2002:a05:6a20:7d8b:b0:bf:58f4:beaf with SMTP id v11-20020a056a207d8b00b000bf58f4beafmr1327088pzj.7.1676526071731;
        Wed, 15 Feb 2023 21:41:11 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p3-20020aa78603000000b0058dbd7a5e0esm324696pfn.89.2023.02.15.21.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 21:41:11 -0800 (PST)
Date:   Thu, 16 Feb 2023 13:41:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] selftest: add tests for debugging testing setup
Message-ID: <20230216054107.e2xed7ns4pcjqrc3@zlang-mailbox>
References: <20230214215431.1425107-1-leah.rumancik@gmail.com>
 <20230215044941.xgk3crhvv2jlahx6@zlang-mailbox>
 <CAOQ4uxguCkBjXydVLbDSGX7-aHd_G_tfD4u4fgvH9QCN=edA-g@mail.gmail.com>
 <Y+1/2GwjLpM5cRF+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+1/2GwjLpM5cRF+@google.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 15, 2023 at 04:59:04PM -0800, Leah Rumancik wrote:
> On Wed, Feb 15, 2023 at 07:57:55AM +0200, Amir Goldstein wrote:
> > On Wed, Feb 15, 2023 at 6:57 AM Zorro Lang <zlang@redhat.com> wrote:
> > >
> > > On Tue, Feb 14, 2023 at 01:54:31PM -0800, Leah Rumancik wrote:
> > > > Many people have developed infrastructure around xfstests. In order to
> > > > test a setup, it would be helpful to have dummy tests that have
> > > > consistent test outcomes. Add a new test folder with the following
> > > > tests:
> > > >
> > > > selftest/001 pass
> > > > selftest/002 fail from output mismatch
> > > > selftest/003 fail via _fail
> > > > selftest/004 skip
> > > > selftest/005 crash
> > > > selftest/006 hang
> > > >
> > > > Also, create two new groups: 'selftest' which includes tests 001-004 and
> > > > 'dangerous_selftest' which includes tests 005-006. The selftests will
> > > > run when running all tests but they are not part of the auto group.
> > > >
> > > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > > ---
> > > > v1 -> v2:
> > > >
> > > > - change name of folder from 'debug' to 'selftest'
> > > > - update tags to 'selftest' and 'dangerous_selftest'
> > > > - add selftest folder to SRC_GROUPS
> > > > - update copyright tag
> > > > - add test which _fails
> > >
> > > Thanks, this version looks good to me, just each case has a blank line at EOF.
> > > I'll help to remove those blank lines when I merge this patch.
> > >
> > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > >
> > > Thanks,
> > > Zorro
> > >
> > >
> > > >
> > > > v1: https://lore.kernel.org/fstests/20230209013143.2586104-1-leah.rumancik@gmail.com/
> > > >
> > > >  check                   |  2 +-
> > > >  doc/group-names.txt     |  2 ++
> > > >  tests/selftest/001      | 14 ++++++++++++++
> > > >  tests/selftest/001.out  |  2 ++
> > > >  tests/selftest/002      | 14 ++++++++++++++
> > > >  tests/selftest/002.out  |  2 ++
> > > >  tests/selftest/003      | 16 ++++++++++++++++
> > > >  tests/selftest/003.out  |  2 ++
> > > >  tests/selftest/004      | 16 ++++++++++++++++
> > > >  tests/selftest/004.out  |  2 ++
> > > >  tests/selftest/005      | 17 +++++++++++++++++
> > > >  tests/selftest/005.out  |  2 ++
> > > >  tests/selftest/006      | 20 ++++++++++++++++++++
> > > >  tests/selftest/006.out  |  2 ++
> > > >  tests/selftest/Makefile | 24 ++++++++++++++++++++++++
> > > >  15 files changed, 136 insertions(+), 1 deletion(-)
> > > >  create mode 100755 tests/selftest/001
> > > >  create mode 100644 tests/selftest/001.out
> > > >  create mode 100755 tests/selftest/002
> > > >  create mode 100644 tests/selftest/002.out
> > > >  create mode 100755 tests/selftest/003
> > > >  create mode 100644 tests/selftest/003.out
> > > >  create mode 100755 tests/selftest/004
> > > >  create mode 100644 tests/selftest/004.out
> > > >  create mode 100755 tests/selftest/005
> > > >  create mode 100644 tests/selftest/005.out
> > > >  create mode 100755 tests/selftest/006
> > > >  create mode 100644 tests/selftest/006.out
> > > >  create mode 100644 tests/selftest/Makefile
> > > >
> > > > diff --git a/check b/check
> > > > index 4827532e..c2065cdc 100755
> > > > --- a/check
> > > > +++ b/check
> > > > @@ -48,7 +48,7 @@ timestamp=${TIMESTAMP:=false}
> > > >
> > > >  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
> > > >
> > > > -SRC_GROUPS="generic shared"
> > > > +SRC_GROUPS="generic shared selftest"
> > 
> > I know this is a bit of bikeshedding,
> > but is it really needed to add selftest/* to SRC_GROUPS and then filter it out
> > by group?
> > 
> > Seems to me that it would be simpler to not add any new groups and use
> > ./check -g selftest/quick -g selftest/dangerous
> > to run the tests in the selftests subdir.
> > 
> > Just to be clear, the syntax above already works, nothing new to implement.
> > 
> > I do not object to adding the selftest groups if others like it better this way.
> 
> I think it behaves more as expected when it is a part of SRC_GROUPS, but
> I will probably run these by specifying specific tests - so I don't
> care much about which groups are used / if it is in SRC_GROUPS or not,
> and I am happy to change it if others agree.

I agree with the suggestion from Amir. The "selftest" should be an independent
test group only be run when a tester intend to run it.

Thanks,
Zorro

> 
> > 
> > It would also be nice to drop a line in README about running selftests.
> 
> Sure, I can do this.
> 
> > 
> > Thanks,
> > Amir.
> 

