Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DACC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 07:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385667AbiDUHVZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385675AbiDUHVY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 03:21:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C5167F7
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 00:18:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A665A68B05; Thu, 21 Apr 2022 09:18:31 +0200 (CEST)
Date:   Thu, 21 Apr 2022 09:18:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
Message-ID: <20220421071831.GA24199@lst.de>
References: <20220419131423.2367795-1-brauner@kernel.org> <20220420175221.2502964-1-brauner@kernel.org> <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox> <20220421070513.wcqz7kzmcm3u5uok@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421070513.wcqz7kzmcm3u5uok@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 21, 2022 at 09:05:13AM +0200, Christian Brauner wrote:
> I'd like to avoid that. The testsuite tests a lot of core vfs
> functionality - completely indepenent of idmapped mounts which is why I
> should rename it - that isn't covered anwywhere else in xfstests.
> It also contains various regressions tests for core vfs work.
> Let's keep it in a single repo which will guarantee us that it will be
> run as part of xfstests.

Yeah, that unionmount testsuite is something no casual users will
run as it requires way too much effort to be usable.
