Received: from mx2.suse.de ([195.135.220.15]:51476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751513AbdF0Jz3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Jun 2017 05:55:29 -0400
Date: Tue, 27 Jun 2017 11:55:22 +0200
From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 2/2] common: remove tmp.mkfs[err/std] files by name
Message-ID: <20170627115522.0259323d@suse.de>
In-Reply-To: <20170627043304.GW23360@eguan.usersys.redhat.com>
References: <20170626134017.2741-1-ddiss@suse.de>
        <20170626134017.2741-2-ddiss@suse.de>
        <20170627043304.GW23360@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, 27 Jun 2017 12:33:04 +0800, Eryu Guan wrote:

> I posted a patch back in Jan. to cleanup tmp files and other leftover
> files after test, I switched from mktemp to a normal "tmp=/tmp/$$._mkfs"
> assignment so it could avoid this problem you want to fix too. But my
> patch got no review.
> 
> I'm going to send new version of my patch and will fix _scratch_do_mkfs
> too, I really appreciate if you could help review and provide
> Reviewed-by tag.

Thanks for the feedback, Eryu. My preference would be to continue to use
mktemp. I know it's test code, but I'd still like to avoid any potential
symlink races.

Cheers, David
