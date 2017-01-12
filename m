Received: from mx2.suse.de ([195.135.220.15]:34469 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750755AbdALM07 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Jan 2017 07:26:59 -0500
Date: Thu, 12 Jan 2017 13:26:56 +0100
From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] common: use xfs_io to obtain the xfsprogs version
Message-ID: <20170112132656.7caa64dd@suse.de>
In-Reply-To: <20170112035124.GU1859@eguan.usersys.redhat.com>
References: <20170111104820.7367-1-ddiss@suse.de>
        <20170112035124.GU1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, 12 Jan 2017 11:51:24 +0800, Eryu Guan wrote:
...
> I noticed that this $_version is only assigned to XFSPROGS_VERSION, and
> the only user of $XFSPROGS_VERSION is xfs/188.
> 
> if [ $XFSPROGS_VERSION -lt 21000 ]; then
>     _notrun "this test requires case-insensitive support"
> fi
> 
> That's a test added in 2008, now we avoid skipping tests by checking on
> some version number, we tend to add new _require rules to actually test
> for the requirements. e.g. for xfs/188, I think we can have:
> 
> in common/xfs:
> # this test requires mkfs.xfs have case-insensitive naming support
> _require_xfs_mkfs_ciname()
> {
> 	_scratch_mkfs_xfs_supported -n version=ci >/dev/null 2>&1 \
> 		|| _notrun "need case-insensitive naming support in mkfs.xfs"
> }
> 
> And remove all the version detection & checking code from common/config
> and xfs/188, and call the new _require rule in the test.

This seems much nicer, Eryu. I'm giving it a spin now, and will send a
patch once tested - thanks for the feedback.

Cheers, David
