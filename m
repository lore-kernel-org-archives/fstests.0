Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2829C43334
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 11:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiGULnL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 07:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiGULnK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 07:43:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326FB77481
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 04:43:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26LBglUD020051
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 07:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658403769; bh=eCylLvAGqWGIDq7Y/mJGQFCW1VtbVocG9JY09cnuRjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DQJE6ShtTxOggx6QqzvcPnEq25l05moTVHsSt+PtMMWn2Iy8V+cy4+6REhqc2zB/U
         9D3oIyRSK3brsHfUwCsnR/ZHFYoE6dss3putmSoPqLGMdDfqd0B0OIDyA7OyfXQCq4
         0/+9FreRB+GJNwUq8U5LeeiQmYp02u+3/toxopipJRBu6l5OoUx1AA8128H8o/fWYq
         s1JQpC3IrFdK6e03WRYml/oAlQpYatJ/B/2h+T0Wozgzc6ui/vL0AqM+ZQhBS9d/Oa
         pHIB2QC5mKte+tbpfDpPG2N+tD5PY4XimNxsts4hyE4BQ74FN1NMbnwocSt+0HyZnT
         9bdNw59NcMMBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7B62415C3EBF; Thu, 21 Jul 2022 07:42:47 -0400 (EDT)
Date:   Thu, 21 Jul 2022 07:42:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Boyang Xue <bxue@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Message-ID: <Ytk7t0am8H4x2BbS@mit.edu>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <YtjYxyhVmSPzzFoH@magnolia>
 <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 03:26:05PM +0800, Boyang Xue wrote:
> > > I find generic/476 easily goes into an infinite run on top of NFS. When it
> >
> > Infinite?  It's only supposed to start 25000*nr_cpus*TIME_FACTOR
> > operations, so it /should/ conclude eventually.  That includes driving
> > the filesystem completel out of space, but there ought to be enough
> > unlink/rmdir/truncate calls to free up space every now and then...
> 
> Yes. I'm not sure the calculations inside, but when the size of the
> scratch device < 27GB (can be 26GB when the backing storage is ext4
> rather than xfs), the test runs infinitely. I'm aware that the test
> should be slow, especially on NFS, but I see the test never finishes
> after multi-days. This problem happens in both localhost exported NFS
> and remote exported NFS configurations.

I can partially confirm this.  I had noted a few weeks ago that I
needed to exclude generic/476 or the test VM would hang for over 24
hours, a which point I lost patience and terminated the VM.  I had
gotten as far as

	gce-xfstests -c nfs -g auto -X generic/476

(which is a loopback config) using 5.19-rc4 in order to get a test run
to complete.

Note: this was also triggering failures of generic/426 and
generic/551, which I also haven't had time to investigate, not being
an NFS developer.  :-)

I wasn't sure whether generic/476 never terminating was caused by a
loopback-triggered deadlock, or something else.  But it sounds like
you've isolated it to the scratch device *too* small, and since that
the failure occurred even on a configuration where the client and
server were on different machines/VM's, correct?

> > >  _require_scratch
> > > +_require_scratch_size $((27 * 1024 * 1024)) # 27GB
> >
> > ...so IDGI, this test works as intended.  Are you saying that NFS
> > command overhead is so high that this test takes too long?

I interpreted this as "if the drive is too small, we're hitting some
kind of problem".  This *could* be some kind of problem which triggers
on ENOSPC; perhaps it's just much more likely on a smaller device?  So
it's possible this is not a test bug, but an NFS problem.  Perhaps we
should forward this off to the NFS folks first?

	   		     	   	  - Ted
