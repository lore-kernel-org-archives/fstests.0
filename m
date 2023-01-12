Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1337C54EBE
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 20:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjALUvf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Jan 2023 15:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbjALUu7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Jan 2023 15:50:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE5D13FB8
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 12:22:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 469B537794;
        Thu, 12 Jan 2023 20:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673554968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXftrabT5haZnJQM9SCungdRvqoZs2iFWCPvN1uvecg=;
        b=WSZF6YtBbBghzdoImGcKv+EfzEHJkhh5I/pliNw+b+UrWcw8UoUKrNDGCte0cu08XlOuqO
        NJvHG+2/PmN/QI/cyVb1XkYCJILpC12aO1+lvibpVMus36m8/xZ9fgZPkFsc8etESIpU6o
        5r1zQKx9yOClSWV3ZRvRW1kug3L3PRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673554968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXftrabT5haZnJQM9SCungdRvqoZs2iFWCPvN1uvecg=;
        b=L/yFSBNUVrvLtx9Ln+i4apgFby3xhJYRSxRorOd3UFy7ZyCWvMr4TCwd+RzTlvd0/xCVBC
        IS8AOSH3WzuGZ9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2308913585;
        Thu, 12 Jan 2023 20:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5/zVBhhswGNTLgAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 12 Jan 2023 20:22:48 +0000
Date:   Thu, 12 Jan 2023 21:23:52 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] more python dependence. was: populate: fix horrible
 performance due to excessive forking
Message-ID: <20230112212352.703007f4@echidna.fritz.box>
In-Reply-To: <Y8A+bGITjQo1p3rg@magnolia>
References: <20230110224906.1171483-1-david@fromorbit.com>
        <20230110224906.1171483-2-david@fromorbit.com>
        <Y75Q/dBXOIeIPonK@magnolia>
        <Y79pOYhJICghtLgj@magnolia>
        <20230112112458.4b024930@echidna.fritz.box>
        <Y8A+bGITjQo1p3rg@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, 12 Jan 2023 09:07:56 -0800, Darrick J. Wong wrote:

> On Thu, Jan 12, 2023 at 11:24:58AM +0100, David Disseldorp wrote:
> > Hi Darrick,
...
> > IIUC we currently only depend on python for the fio perf tests and
> > btrfs/154 . My preference would be to not see it spread further  
> 
> I don't appreciate your dismissal of the patch before I've even posted
> it!

Alright, fair enough. I apologise for that.

> The fstests README clearly lists python3 as a dependency.  Argument
> parsing and xattr calls are provided by the base python3 runtime.  No
> third party libraries are required for this new program, and if they
> were, they'd be added to the README.
> 
> > (especially if it's just to shave off a little runtime), mostly because
> > it's a pain for dependency tracking.
> > Perhaps you could use perl's syscall(SYS_fsetxattr(), ...)? Well, that or  
> 
> Raw system calls are a terrible idea for maintainability.  You'd
> *seriously* rather I open-code the glibc xattr wrappers and make the
> fstests community maintain that for the sake of your preference?

That's not what I said my preference was.

> > rewrite it again in awk ;-P  
> 
> WTAF?

<sigh>
