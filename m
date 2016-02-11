Received: from imap.thunk.org ([74.207.234.97]:35540 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbcBKD5t (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 22:57:49 -0500
Date: Wed, 10 Feb 2016 22:57:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Does _need_to_be_root deserve to live?
Message-ID: <20160211035746.GA16082@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

There appear to be a number of tests that need to mount and unmount
scratch or su to $qa_user that don't call the helper _need_to_be_root.

Also, sicne the check script calls _check_filesystems between every
single test, which requires unmounting and remounting the test and/or
scratch file systems, does the _need_to_be_root check make any sense
at all?

And if doesn't make any sense, is it worth it to submitting a patch
that just removes all mention of _need_to_be_root from the tests and
common/rc?

Cheers,

						- Ted
