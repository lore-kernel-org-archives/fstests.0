Received: from bombadil.infradead.org ([198.137.202.9]:35786 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126AbbG3RLD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 13:11:03 -0400
Date: Thu, 30 Jul 2015 10:11:02 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/6] xfsprogs: pull in libgen.h to get prototype for
 basename()
Message-ID: <20150730171102.GE25395@infradead.org>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
 <1437913255-7524-3-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437913255-7524-3-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: xfs@oss.sgi.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Looks fine, with the same caveat as the previous patch:

Reviewed-by: Christoph Hellwig <hch@lst.de>
