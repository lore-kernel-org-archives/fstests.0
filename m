Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4257CCCA488
	for <linux-fstests@archiver.kernel.org>; Fri, 22 Jul 2022 02:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiGVCTX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiGVCTU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 22:19:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86872E0D
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 19:19:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26M2Iwhw010680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 22:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658456340; bh=//JYZGGhiv+f0UEthS1WEd9eTA2gTyx5C7BDyUWlD+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HdPNHHMKW6/vjC7YWbfhpmPW2CUJM4T9E7TzHYt1QCEsxlHFEXsv7QEwF935R9/B7
         +2+i59jXvvSHjyQ63mPbN/rnzR2P40AkgE3ExaG5LfWpZR0En+S1K+Hb6w9Gsw3t8K
         MY9MiE2OnEk5fSssf49v+JMdoYlDSqFGsXtnwaeBG9av2ceAAR8HJV2LK62CDxHAg/
         9LJ8M8U/EFehiFPvECX6Ij13PSo/o93TEhsmmKnIyXqDjboyByN1RpBUJUxn1o7Tnl
         eAsBRLmA9gU4jasWnISBu2TGjiAe2rC6jLTFhVAs7nbZP5PFx72HnVIhPr6QpBV2X8
         Hw/1D9qg3L/Ag==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7DBF515C3EBF; Thu, 21 Jul 2022 22:18:58 -0400 (EDT)
Date:   Thu, 21 Jul 2022 22:18:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Boyang Xue <bxue@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Message-ID: <YtoJElcucHMtIYQT@mit.edu>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <YtjYxyhVmSPzzFoH@magnolia>
 <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
 <Ytk7t0am8H4x2BbS@mit.edu>
 <YtlcwZ/66pJhpdiS@mit.edu>
 <E5C39D1E-3DB4-467A-8C6D-6630A2ADE97E@oracle.com>
 <6C27EF62-B619-4451-9CBC-B21CEC72F66D@oracle.com>
 <YtmVH8HNHHxVUyoM@mit.edu>
 <75AAE413-4142-45F2-BE8A-7A7867CC0DA4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75AAE413-4142-45F2-BE8A-7A7867CC0DA4@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 06:13:48PM +0000, Chuck Lever III wrote:
> 
> I agree that Q/A and dev testing needs are distinct, so a dev might
> have a simpler series of tests to run and fewer resources to run them
> in.
> 
> That said, I've had it on my to-do list for some time to find an easy
> way to run automated multi-host tests, and I've been told it should be
> straight-forward, but I've been swamped lately.

Yeah, in a cloud or VM environment it shouldn't be *that* hard.
Especially for cloud setup, it's just a matter of launching another
cloud VM with a metadata flag that says, "please provide an NFS server
using the specified file system as the backing store", noting the IP
address, and then passing it to the client VM.  The only slightly
tricky part is that monitoring and saving the serial console of the
server as a test artifact in case of an oops or triggers a BUG or
WARN_ON.

Unfortunately, like you, I've been swamped lately.  :-/

> Many of us in the NFS community actually don't run the tests that
> require a scratch dev, because many of them don't seem relevant to
> NFS, or they take a long time to run. Someday we should sort through
> all that :-)

It doesn't take *that* long.  In loopback mode, as well as using the
GCE Filestore Basic product as the remote NFS server, it takes between
2.5 and 3 hours to run the auto group with the test and scratch device
sized to 5GB:

nfs/filestore: 785 tests, 3 failures, 323 skipped, 9922 seconds
  Failures: generic/258 generic/444 generic/551
nfs/loopback: 814 tests, 2 failures, 342 skipped, 9364 seconds
  Failures: generic/426 generic/551

That's the same order of magnitude for ext4 or xfs running -g auto,
and at least for me "gce-xfsetsts -c nfs/default -g auto" is fire and
forget kind of thing.  2-3 hours later, the results show up in my
inbox.  It's actually *analyzing* the test failures which takes time
and NFS expertise, both of which I don't have a lot of at the moment.

> For the particular issue with generic/476, I would like to see if
> there's a reason that test takes a long time and fails with a small
> scratch dev before agreeing that excluding it is the proper response.

At the moment, my test runner setup assumes that if a single test
takes more than hour, the system under test is hung and should be
killed.  So if generic/476 is taking ~400 seconds for pre-5.10 LTS
kernels, and over 24 hours if the watchdog safety timer isn't in use
for 5.10+ kernels, I need to exclude it in my test runner, at least
for now.

Once it's fixed, I can use a linux versioned #ifdef to only exclude
the test if the fix is not present.

(Also on my todo wishlist is to have some way to automatically exclude
a test if a specified fix commit isn't present on the tested kernel,
but to run it automatically once the fix commit is present.
Unfortunately, I don't have the time or the business case to put
someone on it as a work project...)

					- Ted
