Received: from mx2.suse.de ([195.135.220.15]:44678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751130AbdFBMry (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 2 Jun 2017 08:47:54 -0400
Date: Fri, 2 Jun 2017 14:46:52 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] generic: test Btrfs delalloc accounting overflow
Message-ID: <20170602124652.GJ12135@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <49a0c7551c337566be29b2c073ba0be57779d321.1496391726.git.osandov@fb.com>
 <9f328b7d-5d07-a72f-72b1-bf334fd80a02@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f328b7d-5d07-a72f-72b1-bf334fd80a02@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 02, 2017 at 12:07:37PM +0300, Nikolay Borisov wrote:
> > +# Make sure that we didn't leak any metadata space.
> > +if [[ $FSTYP = btrfs ]]; then
> > +	uuid="$(findmnt -n -o UUID "$TEST_DIR")"
> 
> if we are on btrfs and we don't have findmnt this test will likely fail.
> Perhaps include a _require_command findmnt

I think utilities like findmnt should be checked at the beginning of the
whole testuiste, not in each test that uses them. As findmnt is part of
util-linux, missing it would also mean that eg 'mount' is missing.
Highly unlikely.
