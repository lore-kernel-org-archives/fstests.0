Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E105EB64D9
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jul 2023 19:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGGTNm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jul 2023 15:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGTNm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jul 2023 15:13:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD793128
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 12:13:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-26-156-224.bstnma.fios.verizon.net [108.26.156.224])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 367JDVV9010602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 15:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688757212; bh=FFL9JQmySM41TOa3asdCLJ0faKfB1Aoa/VinOeoOIro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Zcxx7g04RbfHECXRmYgiErd0R7hb/LjQfEu00utgy8W+Y6HPVXaXFcMDrzTuMZZC3
         EBYua76YjdF/HzHdIyRy1M//rbjOQpELM9PVGayvXA4fKyNNvXWY7ntat+SynWrICN
         31drqSvjLv7HyyWT4E7e9K9qXJ5WEkK88TzII1lV7hwWTOyc46S0kcl6rUw5YAYf5s
         sKNkocQew6m6yOP2cio/mCMa5gdWIa/evpemJzlb9NTYYAweg3xpH+goEosutv1b59
         WC8mS9pcTUYIYMyU07lmU+mxYfX6wWOc+WtQEQeGEpEGP0GWA8G//7LIYkPyxnLrEp
         XKqKZJnCnm7+w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1BA5415C0296; Fri,  7 Jul 2023 15:13:31 -0400 (EDT)
Date:   Fri, 7 Jul 2023 15:13:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] report: safely update the result.xml file
Message-ID: <20230707191331.GA2653610@mit.edu>
References: <20230706204232.1577765-1-tytso@mit.edu>
 <20230707150130.GA11442@frogsfrogsfrogs>
 <20230707161747.efz7azf6jta4e27w@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707161747.efz7azf6jta4e27w@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jul 08, 2023 at 12:17:47AM +0800, Zorro Lang wrote:
> > sync "$tmp_fn" && mv "$tmp_fn" "$out_fn"
> 
> I can help to add this when I merge it, if Ted doesn't want to change
> more than that.

I'll be sending out v2 shortly.

> Just curious, will renameat2 ignore data still in cached? I never did things
> likes "sync && mv" before, is there any known issue or it's as expected?

POSIX does not require rename() or renameat2() to do anything with any
cached data.  All it does is make changes to the directory entries
involved.   And that's what the VFS Layer does.

Some file systems implementation *may* do something special on a
rename(2), but it's not required by any specification.  For example,
in the wake of the O_PONIES controversy, ext4 will initiate (but not
wait for) the file writeback of file being renamed *if* it is being
renamed on top of another file, causing the destination inode to be
unlinked and deleted if it doesn't have any other hard links to keep
its reflink about 0.

This means that in the case of renaming result.xml.new on top of
result.xml, if result.xml exists, this will trigger an immediate
writeback of result.xml.new, instead of waiting for the 30 second
writeback timer --- if this is happening on ext4.  We added this to
ext4 because when people would exit the old Tuxracer game, this would
rewrite the top ten file in an unsafe manner, and then close the
OpenGL handle --- and on kernels with buggy proprietary graphics
drivers, it would cause a kernel crash, causing the top-ten score file
to be lost, and causing many users to complain to the file system
developers (but curiously enough, not to the application/game
developers).  So we added something which reduces the chances of this
being an issue, but it's not something anyone should count upon.

As far as sync && mv, that's the shell script equivalent of what
careful userspace programs should always do, which is to write the
file to foo.new, then fsync it, and then rename foo.new to foo,
optionally renaming foo to foo.old or foo~ beforehand.  Text editors
have always gotten this right, because programmers get salty when
their source files get trashed.  For whatever reason, desktop
application and games tend not be as careful....

Cheers,

						- Ted
