Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79726C43331
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5258664E12
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbhCDAYP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:15 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51306 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1387962AbhCCUCv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Mar 2021 15:02:51 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 123K20IP011008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 Mar 2021 15:02:01 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7301015C3A88; Wed,  3 Mar 2021 15:02:00 -0500 (EST)
Date:   Wed, 3 Mar 2021 15:02:00 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Su Yue <damenly.su@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test which tries to exercise AIO/DIO into
 unwritten space
Message-ID: <YD/rONmSSOgDV644@mit.edu>
References: <20210210205818.1494305-1-tytso@mit.edu>
 <20210301171440.GD7269@magnolia>
 <YD0ssnT0BCnwPXXk@mit.edu>
 <CABnRu57hdKav3Mi8vQYeowZrQtFToMSzK23h4H2DuqGL0Dea2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABnRu57hdKav3Mi8vQYeowZrQtFToMSzK23h4H2DuqGL0Dea2A@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 02, 2021 at 11:20:06AM +0800, Su Yue wrote:
> But both xfs and ext4 100% fail in v5.12-rc1 with 4k block size and 4k page
> size on x86_64. The test itself should be okay because btrfs passes.
> xfstests-dev version is 8cbc48b460b6 applied this patch. logs are attached.

Hmm, interesting.  Thanks for the report.  I've been running most of
my tests on a GCE VVM (using gce-xfstests) with a 100GB PD-SSD as the
storage device.  I just tried, and it's passing now reliably on both
4k and 1k for me, both on v5.11 and v5.12-rc1.  (Previously it was
failing about 30% of the time on the ext4/1k test scenario, and was
passing 100% on ext4/4k.)

Given your report, I tried running it using KVM (with a NVME ssd as
the back-end storage device), and it's failing 80% of the time using
the 4k block size.

So previously I had assumed that it was passing consistently on with
ext4/4k, but it looks like that it's very much dependent on the
performance of the TEST_DEV.

					- Ted
