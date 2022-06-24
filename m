Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A314C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiFXPTG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiFXPTG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 11:19:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B2396B8
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 08:19:05 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25OFIwtZ017586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 11:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656083940; bh=sKrA1b93yDEk3tE4ymtqs0xXZkuLGbcUPkTnBWWgglo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AgFh++NXS2ljLcjQLcs0UveH9sC5EYKIMYsWfp/fhwaKA7B2jqfpb20WMzeGuyuB9
         QCiN0Brc2oqbMNRfZ0BxcKIGDg0MknuGKggD0yo41j9DkwVM11gXoN3pmVxCZUul/J
         /p4H/zbZmeyNgWMFfY37uprO3svpWkhLac56iGhgME+AQSuNOWe2aRL6l6at8eTAqY
         IS8BOP/VVU10/XuEEOWiCbrFZkyDppAqv0QZ9cuU/WdwL4Y7OuTlXv/HnGzdMxnDPI
         FXBoJPtkoUGMIXMdTEM845jUDVleWSRbKDyRul6DzxLfDuud9BPqM25xJfYiuli0SA
         Wn4nCPWnkYjpA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 64C5A8C3495; Fri, 24 Jun 2022 11:18:58 -0400 (EDT)
Date:   Fri, 24 Jun 2022 11:18:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] add option to rerun failed tests
Message-ID: <YrXV4lm4oqKDdl5F@mit.edu>
References: <20220621160153.29591-1-ddiss@suse.de>
 <YrVAm6dzTUh3ufb6@mit.edu>
 <20220624103243.10188970@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624103243.10188970@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 10:32:43AM +0200, David Disseldorp wrote:
> Yes, I forgot to mention that, sorry. As Zorro indicated, these were
> done atop the v2022.06.12 tag with the following series applied:
> https://lore.kernel.org/fstests/20220620192934.21694-1-ddiss@suse.de/

Got it, thanks.  Sorry, I had forgotten that we had the next branch now.

I'll try to do a full review once I'm able to give the patches a spin.

> > <testcase classname="xfstests.global" name="generic/476" time="354">
> > 		<failure message="Test  failed, reason unknown" type="TestFail" />
> > 		<system-out>
> > 		...
> > 	</testcase>
> > <testcase classname="xfstests.global" name="generic/476" time="343">
> > 	</testcase>
> > <testcase classname="xfstests.global" name="generic/476" time="353">
> > 	</testcase>
> > 	...
> 
> That seems sensible, I'll add this functionality.

I *think* that should happen automatically when _make_testcase_report
gets called after each iteration.  So that might be easier than having
to do any kind of special case handling.  (Which is why that was going
to be how I was planning on tackling it before you went ahead and
implemented --- thanks for that!!)

> > As far as haivng the .bad and .full files, I agree that some kind of
> > .rerun-NN suffix would make a lot of sense.
> 
> I had a bit of a play with this and it does get a bit ugly if we want to
> prefix things like .dmesg as well. The xunit rerun entries will already
> capture everything, but I suppose it's still needed for those not using
> xunit reports.

Well, actually, one of the things on my TODO list was to implement a
new report type which would removed the xunit <system-out> fields from
the xunit file.  The reason behind that is sometimes the the
NNN.out.bad files can get huge --- and the Python library for parsing
junit XML files has a safety mechanism which will error out if a field
is larger than 10MB, to prevent some denial of service attacks.  And
I've had some XFS NNN.out.bad files get to be 30MB or larger!

When that happens, it causes the Python script I use to parse the XML
file to fail.  In addition, since I already have a different mechanism
for saving the full set of test artifiacts ---- sometimes having the
NNN.full file is really useful for root causing the failure --- having
two copies of the out.bad files in both the Xunit file and in my test
artifacts tarball is a bit of a waste.

I had a POC which implemented this, but then Darrick had a feature
request, since for his workflow, it would be useful if saved only the
first N lines and last N lines in the xunit file, since that's
typically sufficient to figure out what's going on.  And I haven't had
a chance to get back to it.

						- Ted
