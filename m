Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AE1CCA47F
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 22:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbiF0WE0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbiF0WD1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 18:03:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A851EC7F
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 15:02:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9FC6B21C6F;
        Mon, 27 Jun 2022 22:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656367328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnLMpOW8vEQrFEzIWK3VUR+F2G4BdCVN7cqYRvY5rQs=;
        b=sJEolcZljYHnuTmYk4D/s7m4BK5HI3lC6gDYBQWuMkO8PluQ82fzFBEzWkt6woNmMM/kut
        9UFdpyIIjsNTeu8YjHMqC9vPiwMOxQHBy7zNyYCidujgjqshPLI+2HuzJ+J4z/qcX6nzSU
        G41tfe00w828ImDLsayt9nAFkylPH0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656367328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnLMpOW8vEQrFEzIWK3VUR+F2G4BdCVN7cqYRvY5rQs=;
        b=m+/ecqzgL2BCdO7r1w6VH5L0zbu5dPaHb443JYsL729+UKeZhk7tbiBqfFt9+vznO01M+b
        5/RFULqa5p+yHXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 783EC13AB2;
        Mon, 27 Jun 2022 22:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L9TTG+AoumLWZgAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 27 Jun 2022 22:02:08 +0000
Date:   Tue, 28 Jun 2022 00:02:06 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] add option to rerun failed tests
Message-ID: <20220628000206.4d079c06@suse.de>
In-Reply-To: <YrXV4lm4oqKDdl5F@mit.edu>
References: <20220621160153.29591-1-ddiss@suse.de>
        <YrVAm6dzTUh3ufb6@mit.edu>
        <20220624103243.10188970@suse.de>
        <YrXV4lm4oqKDdl5F@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, 24 Jun 2022 11:18:58 -0400, Theodore Ts'o wrote:

> On Fri, Jun 24, 2022 at 10:32:43AM +0200, David Disseldorp wrote:
> > Yes, I forgot to mention that, sorry. As Zorro indicated, these were
> > done atop the v2022.06.12 tag with the following series applied:
> > https://lore.kernel.org/fstests/20220620192934.21694-1-ddiss@suse.de/  
> 
> Got it, thanks.  Sorry, I had forgotten that we had the next branch now.
> 
> I'll try to do a full review once I'm able to give the patches a spin.
> 
> > > <testcase classname="xfstests.global" name="generic/476" time="354">
> > > 		<failure message="Test  failed, reason unknown" type="TestFail" />
> > > 		<system-out>
> > > 		...
> > > 	</testcase>
> > > <testcase classname="xfstests.global" name="generic/476" time="343">
> > > 	</testcase>
> > > <testcase classname="xfstests.global" name="generic/476" time="353">
> > > 	</testcase>
> > > 	...  
> > 
> > That seems sensible, I'll add this functionality.  
> 
> I *think* that should happen automatically when _make_testcase_report
> gets called after each iteration.  So that might be easier than having
> to do any kind of special case handling.  (Which is why that was going
> to be how I was planning on tackling it before you went ahead and
> implemented --- thanks for that!!)

It does, but I've messed around with a few things in that code path, so
just need to make sure that this works as expected :). It should be
working this way in the v2 patchset that I'm about to send...

> > > As far as haivng the .bad and .full files, I agree that some kind of
> > > .rerun-NN suffix would make a lot of sense.  
> > 
> > I had a bit of a play with this and it does get a bit ugly if we want to
> > prefix things like .dmesg as well. The xunit rerun entries will already
> > capture everything, but I suppose it's still needed for those not using
> > xunit reports.  
> 
> Well, actually, one of the things on my TODO list was to implement a
> new report type which would removed the xunit <system-out> fields from
> the xunit file.  The reason behind that is sometimes the the
> NNN.out.bad files can get huge --- and the Python library for parsing
> junit XML files has a safety mechanism which will error out if a field
> is larger than 10MB, to prevent some denial of service attacks.  And
> I've had some XFS NNN.out.bad files get to be 30MB or larger!

Ouch, that does sound hard to parse. One thing I also noticed is that a
stray "]]>" CDATA terminator in the any of the captured content will
likely also cause some parsing headaches, so should be filtered.

> When that happens, it causes the Python script I use to parse the XML
> file to fail.  In addition, since I already have a different mechanism
> for saving the full set of test artifiacts ---- sometimes having the
> NNN.full file is really useful for root causing the failure --- having
> two copies of the out.bad files in both the Xunit file and in my test
> artifacts tarball is a bit of a waste.
> 
> I had a POC which implemented this, but then Darrick had a feature
> request, since for his workflow, it would be useful if saved only the
> first N lines and last N lines in the xunit file, since that's
> typically sufficient to figure out what's going on.  And I haven't had
> a chance to get back to it.

Given that the extra debugging details are already there in the current
xunit output, I think we may be stuck with them. That said, it should be
pretty straightforward to add a new "xunit-brief" or similar report type
under the (currently single-purpose) report API.

Cheers, David
