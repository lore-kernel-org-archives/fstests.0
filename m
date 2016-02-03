From: Christoph Hellwig <hch@lst.de>
Subject: more reflink fixes
Date: Wed,  3 Feb 2016 17:02:04 +0100
Message-Id: <1454515328-1586-1-git-send-email-hch@lst.de>
To: darrick.wong@oracle.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

See http://www.infradead.org/rpr.html

A couple more fixes for the reflink tests.  With this I'm down to
zero failures an a single notrun on XFS, while some more work remains
to be done for NFS.
