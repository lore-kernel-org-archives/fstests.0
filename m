Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6F4C41513
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Oct 2023 05:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjJQFhx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 Oct 2023 01:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjJQFhx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Oct 2023 01:37:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2DE9E
        for <fstests@vger.kernel.org>; Mon, 16 Oct 2023 22:37:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDFAC433C7;
        Tue, 17 Oct 2023 05:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697521071;
        bh=nxpWkekwoPypKETo4S5SkrTKR3BTAxvyotwCGjViFfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8UxLaoDb3d16SnjeUnCiq86OBg6JUAE5/WKZ7c4k4NMuq1wchUXDL9SDtxYsbP6H
         Mug8LiqcMDyy7ZeLCvbLBkGycrwaQhCQtr3Z4+wSCyr7NFGhXo/L+VRtH1eTc9jJ0P
         6X62tbOTxJnC5qAHBU223PNeys19po+p2o6KWiRPI//AfpIg5GOMX5mkOrkNpXCKy4
         KEsqCm6Lzt4QLnvTJ2NlG51vJTp1sIkO/I381tW29Hyf0ExRytGLQEUDOe4ceJNkeh
         oPtrwCjA1JbqrSUmI3aKqRnEsgI/FwkXeCCINgzmAWz2XXgvjGS/3k+mDot5C8Zcfz
         2tSHoJOkGnKEQ==
Date:   Mon, 16 Oct 2023 22:37:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: add missing _require_scratch calls
Message-ID: <20231017053751.GD11424@frogsfrogsfrogs>
References: <20231016131103.966920-1-hch@lst.de>
 <20231016131103.966920-2-hch@lst.de>
 <20231016184124.GB11391@frogsfrogsfrogs>
 <20231017042507.GA6346@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017042507.GA6346@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 17, 2023 at 06:25:07AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 16, 2023 at 11:41:24AM -0700, Darrick J. Wong wrote:
> > > +_require_scratch
> > >  _require_scratch_delalloc
> > >  _require_scratch_reflink
> > 
> > Oops.  That _require_scratch_delalloc could've gone beneath the
> > _require_scratch_reflink to take advantage of the _require_scratch call
> > in _require_scratch_reflink.
> > 
> > That said ... maybe _require_scratch_* calls should require the caller
> > to have _require_scratch'd beforehand?  And perhaps all
> > _require_scratch_* functions should complain if
> > ${RESULT_DIR}/require_scratch doesn't already exist.
> 
> Either having a _require_scratch in all _require_scratch_* helpers or
> none sounds sensible to me, having it in some and nother others is
> rather confusing.  Any preferences?

IMIO, every test should be calling _require_scratch explicitly, and only
once.  The _require_scratch_XXX functions should complain if you haven't
called _require_scratch.

--D
