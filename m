Received: from bombadil.infradead.org ([198.137.202.9]:53489 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192AbbLASKR (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 1 Dec 2015 13:10:17 -0500
Date: Tue, 1 Dec 2015 10:10:12 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: sys_copy_file_range tests
Message-ID: <20151201181011.GA6202@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Anna.Schumaker@netapp.com
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Anna,

I recently looked into allowing sys_copy_file_range to use the
clone_file_range operation so that file systems don't have to support
two methods if they only support clone-like features, and one thing
I noticed is that unlike for clone there are no tests for
clone_file_range in xfstests, and I couldn't find a testsuite anywhere
else either.  Do you have any good tests available to verify the
implementation?
