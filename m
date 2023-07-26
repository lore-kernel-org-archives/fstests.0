Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC68C0015E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Jul 2023 04:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGZEmB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Jul 2023 00:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZEmA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Jul 2023 00:42:00 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E31989
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 21:41:58 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36Q4fWGf024591
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 00:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690346494; bh=y0Rr6xQeDPJL5fQifaEWIbWcz2t8/ElkVNXtZEu02xs=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=E2Bn7FwYQjbCFCJnPKDJ5kGpayi6p94Q5Mw4snuQSMsj4VPzqe/mC6T72OWGnQ+qL
         8wSrQfFTi1rW+1ERHcHirjP/XTOY8Fl7Uth/6uPr+w/SdgKmZOmhn5vSDz3pGibrn+
         Y70x3VkUX1M83ZUrcDmgRSSMta5dFecuLCScsXl53T6gyKLz0fGoTbM53M9ta28qAW
         piTNDBNBHSk0hisPhF1w4sK2ZTK2d+O4XYb++DCev9FQQeArkAcYi9rTSJQN0SvplN
         ns0XwJlcQB1xI3GwTuiZcF4zQf71tZegC7nAMGK87Hweh6M3i3PQa8YxOSh3tjIayi
         lAyeV+SkY8EEw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 240B215C04DF; Wed, 26 Jul 2023 00:41:32 -0400 (EDT)
Date:   Wed, 26 Jul 2023 00:41:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] fstests: add helper to canonicalize devices used to
 enable persistent disks
Message-ID: <20230726044132.GA30264@mit.edu>
References: <20230720061727.2363548-1-mcgrof@kernel.org>
 <20230725081307.xydlwjdl4lq3ts3m@zlang-mailbox>
 <20230725155439.GF11340@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725155439.GF11340@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 25, 2023 at 08:54:39AM -0700, Darrick J. Wong wrote:
> On Tue, Jul 25, 2023 at 04:13:07PM +0800, Zorro Lang wrote:
> > On Wed, Jul 19, 2023 at 11:17:27PM -0700, Luis Chamberlain wrote:
> > > The filesystem configuration file does not allow you to use symlinks to
> > > devices given the existing sanity checks verify that the target end
> > > device matches the source.

I'm a little confused.  Where are these "sanity checks" enforced?
I've been using

SCRATCH_DEV=/dev/mapper/xt-vdc

where /dev/mapper/xt-vdc is a symlink to /dev/dm-4 (or some such)
without any problems.  So I don't quite understand why we need to
canonicalize devices?

					- Ted
