Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDABC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 15:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390230AbiDUPkO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390236AbiDUPkN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 11:40:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338ED47395
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 08:37:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5FF3E68B05; Thu, 21 Apr 2022 17:37:18 +0200 (CEST)
Date:   Thu, 21 Apr 2022 17:37:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
Message-ID: <20220421153717.GA27435@lst.de>
References: <20220419131423.2367795-1-brauner@kernel.org> <20220420175221.2502964-1-brauner@kernel.org> <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox> <20220421085942.GR1609613@dread.disaster.area> <20220421153513.frp7xdbejsoawews@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421153513.frp7xdbejsoawews@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 21, 2022 at 11:35:13PM +0800, Zorro Lang wrote:
> Sure, I won't do that wilfully, just try to ask how we can improve this
> huge and 'keep growing' idmapped-mounts.c, not tend to remove the whole
> idmapped-mount testing coverage :)

It might just be time to split that file up into a few ones if there
is a sensible split.  I'll let Christian think about that, though.
