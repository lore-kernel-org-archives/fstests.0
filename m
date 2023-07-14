Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D39EB64DC
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Jul 2023 17:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjGNRNJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Jul 2023 13:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjGNRNI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Jul 2023 13:13:08 -0400
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [IPv6:2001:41d0:203:375::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BC63C2A
        for <fstests@vger.kernel.org>; Fri, 14 Jul 2023 10:12:26 -0700 (PDT)
Date:   Fri, 14 Jul 2023 13:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689354727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0r2xpos2ys7F9o74CXpmEJ8xVz6mIgUhl9VgGqNVDrY=;
        b=K76ou3lkR3D5u1PmKTR6gCDoZTqELDpYPY502UYFokePfxTt3yNyTxFEY5ivGtfSOPOJNb
        u9UD71rEAh/9C2qz7e+bMYlcBxAnsx4lUUBzZbVvMioVndjuEKFo5E+ugUy/vUkT6Qf0+R
        IkWk2nP97t2FYfgQvhnN7OTX6l47fRc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Zorro Lang <zlang@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] bcachefs: mark bch_inode_info and bkey_cached as
 reclaimable
Message-ID: <20230714171203.cwnid7jjs6oed5s6@moria.home.lan>
References: <ea7fe56-dbac-27b8-33cc-5c722f366e63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea7fe56-dbac-27b8-33cc-5c722f366e63@redhat.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 13, 2023 at 06:00:28PM +0200, Mikulas Patocka wrote:
> Mark these caches as reclaimable, so that available memory is correctly
> reported when there is a lot of cached inodes.
> 
> Note that more work is needed - you should add __GFP_RECLAIMABLE to some 
> of the kmalloc calls, so that they are allocated from the "kmalloc-rcl-*" 
> caches.

What's that actualy do? grepping for __GFP_RECLAIMABLE doesn't turn up
much. Is it just about segragating objects based on expected lifetime,
or is there more going on?
