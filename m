Received: from bombadil.infradead.org ([198.137.202.9]:45930 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbG3RO2 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 13:14:28 -0400
Date: Thu, 30 Jul 2015 10:14:28 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/4] xfstests: Support C libraries that define SIGCHLD
 instead of SIGCLD
Message-ID: <20150730171428.GB18185@infradead.org>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
 <1438006967-18815-3-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438006967-18815-3-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 27, 2015 at 10:22:45AM -0400, Theodore Ts'o wrote:
> SIGCLD is the name used by System V; SIGCHLD is the name defined by
> Posix.  Some C libraries will only define SIGCHLD and not SIGCLD, so
> accomodate them.

Please just use SIGCHLD unconditionally, there is no point in supporting
pre-Posix systems in xfstests.
