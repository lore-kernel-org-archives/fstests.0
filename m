Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587D2C001DE
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jul 2023 13:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGXNcl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jul 2023 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXNcl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2023 09:32:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31631FD
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2023 06:32:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DCB2A67373; Mon, 24 Jul 2023 15:32:36 +0200 (CEST)
Date:   Mon, 24 Jul 2023 15:32:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] generic: add a test for device removal with dirty data
Message-ID: <20230724133236.GB20744@lst.de>
References: <20230711100931.175680-2-hch@lst.de> <20230723045017.1706370-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723045017.1706370-1-zlang@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jul 23, 2023 at 12:50:17PM +0800, Zorro Lang wrote:
> I'd like to help this patchset to catch this or next fstests release. So I
> changed this patch a bit, if you feel good, I'll merge this patch as below.
> (Same to the 2nd patch).

I've actually got a few other changes locally nad plant to send it out.

> Change logs:
> 1) Replace SCRATCH_DEV with TEST_DEV, replace SCRATCH_MNT with SCSI_DEBUG_MNT
>    which is a directory in TEST_DIR, due to we don't call _require_scratch
>    in this case.

The SCSI_DEBUG_MNT change is fine.  The SCRATCH_DEV stuff I think we don't
need at all, after all the sector size doesn't really matter for this
test, so I've just dropped it.

> 2) Call _fail if _mkfs_dev or _mount fails

Shouldn't the mkfs side also use run_check ?

Btw, your cleanups should also go into generic/108 from where I took
the scsi_debug boilerplate.

I'll resend later today, also incorporating your changes.
