Received: from mga11.intel.com ([192.55.52.93]:41011 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbdHaEDA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 31 Aug 2017 00:03:00 -0400
Date: Wed, 30 Aug 2017 22:02:55 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [fstests PATCH] generic: add test for executables on read-only
 DAX mounts
Message-ID: <20170831040255.GB17095@linux.intel.com>
References: <20170829213721.GA27686@linux.intel.com>
 <20170829223715.26507-1-ross.zwisler@linux.intel.com>
 <20170830145103.GA10163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830145103.GA10163@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>, linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, Randy Dodgen <rdodgen@gmail.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 30, 2017 at 07:51:03AM -0700, Christoph Hellwig wrote:
> > The above patch fixes an issue with ext4 where executables cannot be run on
> > read-only filesystems mounted with the DAX option.
> > 
> > This issue does not appear to be present in ext2 or XFS, as they both pass
> > the test.  I've also confirmed outside of the test that they are both
> > indeed able to execute binaries on read-only DAX mounts.
> 
> It works for me on XFS.  But I don't really understand why, as the fault
> handler doesn't look very different.
> 
> Maybe the problem is that in ext4_journal_start_sb will fail on
> a read-only fs?
> 
> Even for xfs/ext2 it would seem odd that things like sb_start_pagefault
> just work. 
> 
> > +LS=$(which ls --skip-alias --skip-functions) 2>/dev/null
> > +if [ $? -ne 0 ]; then
> > +	status=$?
> > +	echo "Couldn't find 'ls'!?"
> > +	exit
> > +fi
> 
> These checks all fail for me..

Huh...really?  I'll send out v2 in a second, but if that fails for you as well
can you try and give me a hint as to what's going wrong with the test in your
setup?
