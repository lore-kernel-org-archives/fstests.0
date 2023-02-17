Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A39C636D6
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Feb 2023 18:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBQSl2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Feb 2023 13:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBQSl1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Feb 2023 13:41:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7209ECC
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 10:41:26 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p15-20020a17090a2d8f00b00233ceae8407so2077706pjd.3
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 10:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNuXtkDIQ1brfgsfwFw6u9PryTuxR+wLGCmTjSkUDZg=;
        b=F4epjvwkZjysNSnqXQcDKf0Zued6R+QR+HChQP11w6z5dei/XS6wtOh2Y5rqxFoFUe
         KXEQ27OJaPB3gbUWDey/XtflaeHy2Uj/cgbVqiuUZdoCLyM7C9Mqn8DEsGBVCQ/Hr+gT
         DXE83BtCqkm2A+btZREitbRqKkeh3je8I3ZOTF69Co3Pc2RuTmCb3PdU1VFfa08jVsfu
         43KtQahLl+6L4498XjWrCCtTbZYtMH9x57slTMPwO2NOCM4JflZclG4BkWHKTZi8M2QS
         GueYnB6iqc8jo0Mn39I2dhIT1t0BYfaxJ0logArmxue4qV2l7fSG88+qcJFfL6q+8Zo6
         g2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNuXtkDIQ1brfgsfwFw6u9PryTuxR+wLGCmTjSkUDZg=;
        b=vOoQ2l1WaFrIpkXyVU7e8wmanr1L78EraWj9JEtzVH3ijzJY4Ikwl/SYUMWccCDUCM
         WACmP8MBWph66khccCTXWOrLvNFt0vMQj+dDdkxIypfkWGVqUSL5BDe3jVdfAkjJPCag
         QgagHJGdwvr/sUuX+8fOR/lt1SGqkFWQpaTkSKRd4Huu8gBlYJCze/QO/E+WON7U2opt
         P2/SbKSjQCJnYyqOV4BD/GdB7pvv7tflR/YKXUMTEjKWjNQ+ywowZs8LdWjFCMgajTst
         IArgy7HPi2tV8RUDxzJfLHA0UUAezJhPTgDWHnROlidBjCvK3D5EILSI3h4V/wMcgjGT
         OWrw==
X-Gm-Message-State: AO0yUKVJ7gT/sIJNilGAJQ1hGhNXLmZXVmCeyx7js5iP8GWPT2uRVKyQ
        E2Szh2lsRLnYpMVFZxxmutbthsJNEqk=
X-Google-Smtp-Source: AK7set+ZzoPTOo5i+mByEmYsG055Qi3XLCLZ9ol95+zogDwPmHgTOLpLyvrPWffJmHxsHDwbBAFXpw==
X-Received: by 2002:a17:903:1ce:b0:199:41a5:1085 with SMTP id e14-20020a17090301ce00b0019941a51085mr1301190plh.33.1676659285503;
        Fri, 17 Feb 2023 10:41:25 -0800 (PST)
Received: from google.com ([2620:0:1001:7810:de02:eb82:7169:89c1])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001991942dde7sm3468247ple.125.2023.02.17.10.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:41:25 -0800 (PST)
Date:   Fri, 17 Feb 2023 10:41:23 -0800
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] selftest: add tests for debugging testing setup
Message-ID: <Y+/KU+4yrm47q5Ny@google.com>
References: <20230214215431.1425107-1-leah.rumancik@gmail.com>
 <20230215044941.xgk3crhvv2jlahx6@zlang-mailbox>
 <CAOQ4uxguCkBjXydVLbDSGX7-aHd_G_tfD4u4fgvH9QCN=edA-g@mail.gmail.com>
 <Y+1/2GwjLpM5cRF+@google.com>
 <20230216054107.e2xed7ns4pcjqrc3@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216054107.e2xed7ns4pcjqrc3@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 16, 2023 at 01:41:07PM +0800, Zorro Lang wrote:
> On Wed, Feb 15, 2023 at 04:59:04PM -0800, Leah Rumancik wrote:
> > On Wed, Feb 15, 2023 at 07:57:55AM +0200, Amir Goldstein wrote:
> > > On Wed, Feb 15, 2023 at 6:57 AM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Tue, Feb 14, 2023 at 01:54:31PM -0800, Leah Rumancik wrote:
> > > > > Many people have developed infrastructure around xfstests. In order to
> > > > > test a setup, it would be helpful to have dummy tests that have
> > > > > consistent test outcomes. Add a new test folder with the following
> > > > > tests:
> > > > >
> > > > > selftest/001 pass
> > > > > selftest/002 fail from output mismatch
> > > > > selftest/003 fail via _fail
> > > > > selftest/004 skip
> > > > > selftest/005 crash
> > > > > selftest/006 hang
> > > > >
> > > > > Also, create two new groups: 'selftest' which includes tests 001-004 and
> > > > > 'dangerous_selftest' which includes tests 005-006. The selftests will
> > > > > run when running all tests but they are not part of the auto group.
> > > > >
> > > > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > > > ---
> > > > > v1 -> v2:
> > > > >
> > > > > - change name of folder from 'debug' to 'selftest'
> > > > > - update tags to 'selftest' and 'dangerous_selftest'
> > > > > - add selftest folder to SRC_GROUPS
> > > > > - update copyright tag
> > > > > - add test which _fails
> > > >
> > > > Thanks, this version looks good to me, just each case has a blank line at EOF.
> > > > I'll help to remove those blank lines when I merge this patch.
> > > >
> > > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > > >
> > > > Thanks,
> > > > Zorro
> > > >
> > > >
> > > > >
> > > > > v1: https://lore.kernel.org/fstests/20230209013143.2586104-1-leah.rumancik@gmail.com/
> > > > >
> > > > >  check                   |  2 +-
> > > > >  doc/group-names.txt     |  2 ++
> > > > >  tests/selftest/001      | 14 ++++++++++++++
> > > > >  tests/selftest/001.out  |  2 ++
> > > > >  tests/selftest/002      | 14 ++++++++++++++
> > > > >  tests/selftest/002.out  |  2 ++
> > > > >  tests/selftest/003      | 16 ++++++++++++++++
> > > > >  tests/selftest/003.out  |  2 ++
> > > > >  tests/selftest/004      | 16 ++++++++++++++++
> > > > >  tests/selftest/004.out  |  2 ++
> > > > >  tests/selftest/005      | 17 +++++++++++++++++
> > > > >  tests/selftest/005.out  |  2 ++
> > > > >  tests/selftest/006      | 20 ++++++++++++++++++++
> > > > >  tests/selftest/006.out  |  2 ++
> > > > >  tests/selftest/Makefile | 24 ++++++++++++++++++++++++
> > > > >  15 files changed, 136 insertions(+), 1 deletion(-)
> > > > >  create mode 100755 tests/selftest/001
> > > > >  create mode 100644 tests/selftest/001.out
> > > > >  create mode 100755 tests/selftest/002
> > > > >  create mode 100644 tests/selftest/002.out
> > > > >  create mode 100755 tests/selftest/003
> > > > >  create mode 100644 tests/selftest/003.out
> > > > >  create mode 100755 tests/selftest/004
> > > > >  create mode 100644 tests/selftest/004.out
> > > > >  create mode 100755 tests/selftest/005
> > > > >  create mode 100644 tests/selftest/005.out
> > > > >  create mode 100755 tests/selftest/006
> > > > >  create mode 100644 tests/selftest/006.out
> > > > >  create mode 100644 tests/selftest/Makefile
> > > > >
> > > > > diff --git a/check b/check
> > > > > index 4827532e..c2065cdc 100755
> > > > > --- a/check
> > > > > +++ b/check
> > > > > @@ -48,7 +48,7 @@ timestamp=${TIMESTAMP:=false}
> > > > >
> > > > >  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
> > > > >
> > > > > -SRC_GROUPS="generic shared"
> > > > > +SRC_GROUPS="generic shared selftest"
> > > 
> > > I know this is a bit of bikeshedding,
> > > but is it really needed to add selftest/* to SRC_GROUPS and then filter it out
> > > by group?
> > > 
> > > Seems to me that it would be simpler to not add any new groups and use
> > > ./check -g selftest/quick -g selftest/dangerous
> > > to run the tests in the selftests subdir.
> > > 
> > > Just to be clear, the syntax above already works, nothing new to implement.
> > > 
> > > I do not object to adding the selftest groups if others like it better this way.
> > 
> > I think it behaves more as expected when it is a part of SRC_GROUPS, but
> > I will probably run these by specifying specific tests - so I don't
> > care much about which groups are used / if it is in SRC_GROUPS or not,
> > and I am happy to change it if others agree.
> 
> I agree with the suggestion from Amir. The "selftest" should be an independent
> test group only be run when a tester intend to run it.


When you say "selftest" should be an independent test group, do you mean
we should keep the "selftest" and "dangerous_selftest" groups but just
remove the "selftest" folder from SRC_GROUPS? I think Amir was suggesting
to completely remove the test groups "selftest" and
"dangerous_selftest" as well as removing the folder from SRC_GROUPS.

- Leah

> 
> Thanks,
> Zorro
> 
> > 
> > > 
> > > It would also be nice to drop a line in README about running selftests.
> > 
> > Sure, I can do this.
> > 
> > > 
> > > Thanks,
> > > Amir.
> > 
> 
