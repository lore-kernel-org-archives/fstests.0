Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B31C61DA4
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Feb 2023 21:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjBIVrn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjBIVrm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Feb 2023 16:47:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D404C25298
        for <fstests@vger.kernel.org>; Thu,  9 Feb 2023 13:47:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so6678607pjy.1
        for <fstests@vger.kernel.org>; Thu, 09 Feb 2023 13:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUVFbFq7E9kWzYX4gWe2TCjlvPpnQTwh4pQBzO0P0kg=;
        b=RqhqlZBlPJMRwzxdwPmN6+QN9DXdJz2SJXxUPOLrIAp5v6D9MKS43et235mIdnQTmk
         2n86DFGhlBfIw4S3T33WA69vXlbr/XQwvJ0I3+Hoko+HUAZQDwsA0HAIxi1vGipsDuJ/
         M64g4U0R+mMnst2xDZRcf3MM0J44L6oEIH7n54OrX4WObzmpfxPcIHU5dccdZ45zMaZc
         nvRqy9a76r4LnDC4pPmgswlKerKyDb0baw/dQ5IP3peXA8JHmukZFRmCkUdzp5xN2p7k
         yydk/gqehsFwdMp9Nk+RCEjxNTf173oU2Iw08pZ8KmF6fB/8vsGFfdKDH/lqSbaDqWiJ
         zd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUVFbFq7E9kWzYX4gWe2TCjlvPpnQTwh4pQBzO0P0kg=;
        b=rj3icwlD1WoFvxhLxERSMSwwIm0tEgZr+mB28x1KigH5yiwky9vbpabByn4N7geZjq
         nUke+PZ+bv3Zmu081g8sJhbwe43RTaCSQMRG5Aq7O5BMc6shkr8TBMJxxUoMBGX7I/Ez
         oTCmQN1S1YHAZMDnNfpCLA6Q67xG9UdFF/iMz3kTyKHVQf4El02jE+1ThPsDbo3O4dM8
         Mv2qN0W3yYtPjqUopsG8DVlBiNCARieE/SDOVZ+qekQqgK3fHfX+7Y9cNojm+peibP9n
         eo2ZBDxADKDmXhYpf68K4LkuMDs9rksAkLfRhcoTm9QLAY5Zre5wC6rllmRj3hSnFWo3
         vFIw==
X-Gm-Message-State: AO0yUKVV3NUXu6bdl0d8iq9CGMQyDyzpNhAcsrIuwfHl0BdONUK7SbXo
        xiueeCkT7osQzjqh2o74L6g=
X-Google-Smtp-Source: AK7set/bkLelmKWs3Aifo+w6gXTYEwNgmEE6BNwf4BC6tfPBmrsJHy5ZNt6pqcMJ3knUruTNfkfCcg==
X-Received: by 2002:a17:902:d1d5:b0:199:540c:46a0 with SMTP id g21-20020a170902d1d500b00199540c46a0mr4473957plb.3.1675979261246;
        Thu, 09 Feb 2023 13:47:41 -0800 (PST)
Received: from google.com ([2620:15c:2c1:200:67b8:d62f:3d52:62f])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709027b9400b00192a04bc620sm1951361pll.295.2023.02.09.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:47:40 -0800 (PST)
Date:   Thu, 9 Feb 2023 13:47:38 -0800
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] debug: add tests for debugging testing setup
Message-ID: <Y+Vp+qSoi/CFcfZA@google.com>
References: <20230209013143.2586104-1-leah.rumancik@gmail.com>
 <Y+Rewk2CmqrWDyVu@magnolia>
 <20230209055302.osegwiqx77lav4p2@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209055302.osegwiqx77lav4p2@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Oops, should have put all my replies this message. Please see my
reply to Darrick's email as well.

On Thu, Feb 09, 2023 at 01:53:02PM +0800, Zorro Lang wrote:
> On Wed, Feb 08, 2023 at 06:47:30PM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 08, 2023 at 05:31:43PM -0800, Leah Rumancik wrote:
> > > Many people have developed infrastructure around xfstests. In order to
> > > test a setup, it would be helpful to have dummy tests that have
> > > consistent test outcomes. Add a new test folder with the following
> > > debugging tests:
> > 
> > Ooh, we've been needing selftests for a while, thanks!
> > 
> > > debug/001 pass
> > > debug/002 fail
> > > debug/003 skip
> > > debug/004 crash
> > > debug/005 hang
> > > 
> > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > ---
> > > 
> > > diff --git a/doc/group-names.txt b/doc/group-names.txt
> > > index 6cc9af78..212da7e7 100644
> > > --- a/doc/group-names.txt
> > > +++ b/doc/group-names.txt
> > > @@ -39,6 +39,7 @@ dangerous_scrub		fuzzers to evaluate xfs_scrub checking
> > >  data			data loss checkers
> > >  dax			direct access mode for persistent memory files
> > >  db			xfs_db functional tests
> > > +debug			tests with fixed results, used to validate testing setup
> > 
> > Bikeshed: Can we make the tag 'selftests' since debugging could refer to
> > just about anything in the kernel/userspace/otherstuff stacks?
> > 
> > Also a dangerous_selftests for tests that will crash or hang the test
> > appliances.  I'd really like to run this every time I start up fstests,
> > albeit without the dangerous ones. :)
> 
> I agree with this. When I saw *debug*, I thought it's about some kernel/fs
> debuging test, or it need kernel debug option. So *selftest* might be a better
> name, or if someone has better idea :)
> 
> With group name changing, I think better to change tests/debug/ directory to
> tests/selftests/.

Will do!

> > > diff --git a/tests/debug/Makefile b/tests/debug/Makefile
> > > new file mode 100644
> > > index 00000000..84556199
> > > --- /dev/null
> > > +++ b/tests/debug/Makefile
> > > @@ -0,0 +1,24 @@
> > > +#
> > > +# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
> 
> Do you need to change this ^^ ?
Ah yes, thanks!

- Leah

> 
> Thanks,
> Zorro
> 
> > > +#
> > > +
> > > +TOPDIR = ../..
> > > +include $(TOPDIR)/include/builddefs
> > > +include $(TOPDIR)/include/buildgrouplist
> > > +
> > > +DEBUG_DIR = debug
> > > +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(DEBUG_DIR)
> > > +DIRT = group.list
> > > +
> > > +default: $(DIRT)
> > > +
> > > +include $(BUILDRULES)
> > > +
> > > +install:
> > > +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> > > +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> > > +	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> > > +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> > > +
> > > +# Nothing.
> > > +install-dev install-lib:
> > > -- 
> > > 2.39.1.519.gcb327c4b5f-goog
> > > 
> > 
> 
