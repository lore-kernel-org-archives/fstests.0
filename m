Received: from bombadil.infradead.org ([65.50.211.133]:41791 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbdH3OvG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Aug 2017 10:51:06 -0400
Date: Wed, 30 Aug 2017 07:51:03 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [fstests PATCH] generic: add test for executables on read-only
 DAX mounts
Message-ID: <20170830145103.GA10163@infradead.org>
References: <20170829213721.GA27686@linux.intel.com>
 <20170829223715.26507-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829223715.26507-1-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>, linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, Randy Dodgen <rdodgen@gmail.com>, Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

> The above patch fixes an issue with ext4 where executables cannot be run on
> read-only filesystems mounted with the DAX option.
> 
> This issue does not appear to be present in ext2 or XFS, as they both pass
> the test.  I've also confirmed outside of the test that they are both
> indeed able to execute binaries on read-only DAX mounts.

It works for me on XFS.  But I don't really understand why, as the fault
handler doesn't look very different.

Maybe the problem is that in ext4_journal_start_sb will fail on
a read-only fs?

Even for xfs/ext2 it would seem odd that things like sb_start_pagefault
just work. 

> +LS=$(which ls --skip-alias --skip-functions) 2>/dev/null
> +if [ $? -ne 0 ]; then
> +	status=$?
> +	echo "Couldn't find 'ls'!?"
> +	exit
> +fi

These checks all fail for me..
