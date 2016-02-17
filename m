Received: from bombadil.infradead.org ([198.137.202.9]:44756 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933366AbcBQKDd (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Feb 2016 05:03:33 -0500
Date: Wed, 17 Feb 2016 02:03:33 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 05/16] generic: remove the generic/125 test
Message-ID: <20160217100333.GH21482@infradead.org>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
 <1455385269-26319-6-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455385269-26319-6-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

The pNFS block layout driver works the same way as CXFS here.  I
don't think I ever triggered this test during the development, though.

I'm indifferent on whether we should keep this test or not, but it
defintively makes sense to remove it from the auto group.
