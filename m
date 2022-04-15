Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC56C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 15 Apr 2022 04:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbiDOEYo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 15 Apr 2022 00:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349402AbiDOEYn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Apr 2022 00:24:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF95B9BAC0
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 21:22:14 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23F4M63W010328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 00:22:07 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 338AB15C3EAF; Fri, 15 Apr 2022 00:22:06 -0400 (EDT)
Date:   Fri, 15 Apr 2022 00:22:06 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Kari Argillander <kari.argillander@fidelix.com>,
        fstests@vger.kernel.org
Subject: Re: [xfstests-bld PATCH 0/2] Make ntfs3 more usable
Message-ID: <Yljy7qjf6KDj64NN@mit.edu>
References: <20220414234220.627320-1-kari.argillander@fidelix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414234220.627320-1-kari.argillander@fidelix.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 15, 2022 at 02:42:18AM +0300, Kari Argillander wrote:
> Add ntfs3 kernel configs and disable tests which hangs at the moment.
> 
> Kari Argillander (2):
>   test-appliance: Add exclude file for ntfs3
>   kernel-configs: add ntfs3 to current 5.15 configs

Note that upstream fstests does *not* have support for ntfs3 at the
moment.  I have some admittedly very hacky patches in my personal fork
of xfstests on github, but they use a mix of userspace tools that are
specific for other ntfs file system drivers, since last I checked,
Paragon software has not made open source file system utilities for
ntfs3 available.

The support of ntfs3 in {kvm,gce}-xfstests was experimental in nature
when I was trying to make an assessment about whether ntfs3 was ready
for prime time.  So don't mind applying these patches, but I'm
currently no longer regularly running ntfs3 test runs, and I'm very
much aware that the current ntfs3 support that I had added a while
back into xfstests is definitely not polished or ready for the fstests
maintainer to consider accepting.

Cheers,

					- Ted
