Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8351DC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 07:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386269AbiDUH6T (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386375AbiDUH6K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 03:58:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2180414006
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 00:55:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 798B668B05; Thu, 21 Apr 2022 09:55:17 +0200 (CEST)
Date:   Thu, 21 Apr 2022 09:55:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
Message-ID: <20220421075517.GA26832@lst.de>
References: <20220419131423.2367795-1-brauner@kernel.org> <20220420175221.2502964-1-brauner@kernel.org> <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox> <20220421070513.wcqz7kzmcm3u5uok@wittgenstein> <20220421071831.GA24199@lst.de> <CAOQ4uxhbBsrnPWPdT2MSUJu+vC8rT0Ykk+JAZRe+pBWcH=hLig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhbBsrnPWPdT2MSUJu+vC8rT0Ykk+JAZRe+pBWcH=hLig@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 21, 2022 at 10:52:35AM +0300, Amir Goldstein wrote:
> Please elaborate.
> 
> Quoting from README.overlay:
> 
> To enable running unionmount testsuite, clone the git repository from:
>   https://github.com/amir73il/unionmount-testsuite.git
> under the xfstests src directory, or set the environment variable
> UNIONMOUNT_TESTSUITE to the local path where the repository was cloned.
> 
> Is that what you are referring to by "way too much effort to be usable"?

I need to install another test suite and point to it.  That isn't
exactly an easy setup compared to having one self contained one.  If it
is just one testsuite for a specific file system that might be fine
(but then why even bother wiring up in xfstests?), but doing that
for lots of bits that test core code is just a nightmare.
