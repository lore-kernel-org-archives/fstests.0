Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4497C54EBD
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 10:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbjALK2J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbjALK04 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Jan 2023 05:26:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A835B50057
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 02:23:57 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E0ECC3FB3F;
        Thu, 12 Jan 2023 10:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673519035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zfkXi+37m12QamrffoSFDKb5JYZ12EFlwVGyYEp3zk=;
        b=NhmXvCYfw1xhLMr43FL/YfOwKHsjZ8F44RqQFfFyj0sV1E3NEpG7Yugofxf1S72Cs7KAkl
        PZwnD1e0thh1G0rTH4LzV7vRS6wBpZtJlVgTQB1U2ApD/C2JKZ+O2QyFPLPQ9cZZFy3nHw
        UL23THYQgRG/b2LIAyfSH6Dfc9ZKIJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673519035;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zfkXi+37m12QamrffoSFDKb5JYZ12EFlwVGyYEp3zk=;
        b=p5mP9DLlshGwcgzSzQ5ZYAFUp7s0yhMr+UTOsl69ESl/mywh8L61HERmMK9TSTyWx3RwlF
        9CJ/2HiCZCNzXvAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B7362136AE;
        Thu, 12 Jan 2023 10:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id VZWDKrvfv2MTMgAAGKfGzw
        (envelope-from <ddiss@suse.de>); Thu, 12 Jan 2023 10:23:55 +0000
Date:   Thu, 12 Jan 2023 11:24:58 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] more python dependence. was: populate: fix horrible
 performance due to excessive forking
Message-ID: <20230112112458.4b024930@echidna.fritz.box>
In-Reply-To: <Y79pOYhJICghtLgj@magnolia>
References: <20230110224906.1171483-1-david@fromorbit.com>
        <20230110224906.1171483-2-david@fromorbit.com>
        <Y75Q/dBXOIeIPonK@magnolia>
        <Y79pOYhJICghtLgj@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Darrick,

On Wed, 11 Jan 2023 17:58:17 -0800, Darrick J. Wong wrote:

> > (removexattr looks like a pain in perl though...)
> > 
> > Anyway it's late now, I'll look at the diff tomorrow.  
> 
> ...or thursday now, since I decided to reply to the online fsck design
> doc review comments, which took most of the workday.  I managed to bang
> out a python script (perl doesn't support setxattr!) that cut the xattr
> overhead down to nearly zero.

IIUC we currently only depend on python for the fio perf tests and
btrfs/154 . My preference would be to not see it spread further
(especially if it's just to shave off a little runtime), mostly because
it's a pain for dependency tracking.
Perhaps you could use perl's syscall(SYS_fsetxattr(), ...)? Well, that or
rewrite it again in awk ;-P

Cheers, David
