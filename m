Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5171BC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 16:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DC86101D
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhJLQVT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:21:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51410 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhJLQVJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Oct 2021 12:21:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAD6C221BA;
        Tue, 12 Oct 2021 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634055546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO3HasV+qsjcT/AjlaQRCs4EFDoBSMVJ8p3pDWTSanc=;
        b=TKCoz1KZjKoeb7Qg/h8HT+v6/iW7/lmJGCG49UHZ7eVkS5e1wLdT5sMHFULUzvW3V+8MKl
        xVbpiHqMRt3NJSz3a2Zplct2tN+NyB+8BdgtZ4Rl0pfAns388iNmGOaCROMrLoXKGl8V0q
        2PjYCtGN7/qAv8Zxp1nvHmN4SC1u+Bw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C129813C00;
        Tue, 12 Oct 2021 16:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BwbnLXq1ZWHOPgAAMHmgww
        (envelope-from <ailiop@suse.com>); Tue, 12 Oct 2021 16:19:06 +0000
Date:   Tue, 12 Oct 2021 18:19:06 +0200
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] build: remove unused AC_PACKAGE_NEED_OPEN_BY_FSHANDLE
 macro
Message-ID: <YWW1esouYFRcbuHf@technoir>
References: <20211012135057.25689-1-ailiop@suse.com>
 <20211012153946.GH24282@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012153946.GH24282@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 12, 2021 at 08:39:46AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 12, 2021 at 03:50:57PM +0200, Anthony Iliopoulos wrote:
> > Commit 5868405dce1d ("Sync up different copies of the m4 macros, noop
> > change for this package.") introduced this macro, by the function was
> > never really used by any test, remove it.
> 
> If we're not going to keep this in sync (with what I have no idea) then
> why not remove the other unused macros?

This was standing out as I was looking specifically into fstests
dependencies to libhandle, but I didn't make a full pass through the
rest. Indeed at least AC_PACKAGE_NEED_LIBXFSINIT_LIBXFS seems also
unused.

From looking at earlier commits, I think sync was referring to bringing
the m4 macros up to date with the rest of the packages (xfsprogs,
xfsdump at least). Commit c1ef92a938a1 ("Updates to QA scrdiff script to
keep package configure macros in sync.") includes the following comment:

  "xfstests directory m4 directory is a repository of all of the custom
  m4 macros used in the packages we look after."

I just checked xfsdump and most of the macros in package_xfslibs.m4 are
indeed unused.

Regards,
Anthony
