Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:25175 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445AbcBJFqO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2016 00:46:14 -0500
Date: Wed, 10 Feb 2016 16:45:31 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 01/12] check: avoid error messages of tests/$FS does not
 exist
Message-ID: <20160210054531.GR19486@dastard>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-2-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455069001-17846-2-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 09, 2016 at 08:49:50PM -0500, Theodore Ts'o wrote:
> There are no tmpfs specific tests, so tests/tmpfs does not exist.
> Avoid print an error message caused by trying to read the file
> tests/tmpfs/group (for example).
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Where does this error message get emitted? I would have expected
lots of people to notice this (e.g. NFS, CIFS, ext2, ext3, gfs2)
if this was causing some kind of problem long before this...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
