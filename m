Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4EDCDB474
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Oct 2023 04:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjJQEZN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 Oct 2023 00:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjJQEZM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Oct 2023 00:25:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492F783
        for <fstests@vger.kernel.org>; Mon, 16 Oct 2023 21:25:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 353A268BFE; Tue, 17 Oct 2023 06:25:08 +0200 (CEST)
Date:   Tue, 17 Oct 2023 06:25:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: add missing _require_scratch calls
Message-ID: <20231017042507.GA6346@lst.de>
References: <20231016131103.966920-1-hch@lst.de> <20231016131103.966920-2-hch@lst.de> <20231016184124.GB11391@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016184124.GB11391@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 16, 2023 at 11:41:24AM -0700, Darrick J. Wong wrote:
> > +_require_scratch
> >  _require_scratch_delalloc
> >  _require_scratch_reflink
> 
> Oops.  That _require_scratch_delalloc could've gone beneath the
> _require_scratch_reflink to take advantage of the _require_scratch call
> in _require_scratch_reflink.
> 
> That said ... maybe _require_scratch_* calls should require the caller
> to have _require_scratch'd beforehand?  And perhaps all
> _require_scratch_* functions should complain if
> ${RESULT_DIR}/require_scratch doesn't already exist.

Either having a _require_scratch in all _require_scratch_* helpers or
none sounds sensible to me, having it in some and nother others is
rather confusing.  Any preferences?

